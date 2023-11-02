Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E9E2135D
	for <gfs2@lists.linux.dev>; Thu,  2 Nov 2023 19:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KTNDUww5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698955087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7taLW3F+D0vnaaLV96D0NG1JKRdHcM2rSP9NtaFn0kc=;
	b=KTNDUww5YDpqinRLH9xLDO5Ov/WaOrg22lfQXBYepdOhdLW3bUXVtaAYpCMVkQ860XzMqS
	M3mSRUm7+8+GSN9fbiVc1IHwd8LIclgWCTHsENiQk9YU8WCL/xSIkWM8ESWWCXeW19OPow
	az17qzQUnEYk7ZPGv9eEbqj3aYt/jJ8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-Uf7auSaRN7Cx69BBr81adw-1; Thu, 02 Nov 2023 15:58:05 -0400
X-MC-Unique: Uf7auSaRN7Cx69BBr81adw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D709380C348
	for <gfs2@lists.linux.dev>; Thu,  2 Nov 2023 19:58:04 +0000 (UTC)
Received: from pasta.redhat.com (unknown [10.45.224.27])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3D9B92166B27;
	Thu,  2 Nov 2023 19:58:04 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	Alexander Aring <aahringo@redhat.com>
Subject: [PATCH] gfs2: don't withdraw if init_threads() got interrupted
Date: Thu,  2 Nov 2023 20:58:03 +0100
Message-ID: <20231102195803.1212539-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

In gfs2_fill_super(), when mounting a gfs2 filesystem is interrupted,
kthread_create() can return -EINTR.  When that happens, we roll back
what has already been done and abort the mount.

Since commit a28dc123fa66, we also call gfs2_withdraw_delayed() in
gfs2_fill_super(), but that only marks the filesystem as withdrawing and
relies on a caller further up the stack to do the actual withdraw --
which doesn't exist in the gfs2_fill_super() case.  Because the
filesystem is marked as withdrawing / withdrawn, function
gfs2_lm_unmount() doesn't release the dlm lockspace, so when we try to
mount that filesystem again, we get:

    gfs2: fsid=gohan:gohan0: Trying to join cluster "lock_dlm", "gohan:gohan0"
    gfs2: fsid=gohan:gohan0: dlm_new_lockspace error -17

Fix this by getting rid of the ill-conceived gfs2_withdraw_delayed() in
gfs2_fill_super().

Reported-by: Alexander Aring <aahringo@redhat.com>
Fixes: a28dc123fa66 ("gfs2: init system threads before freeze lock")
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/ops_fstype.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index 2fa9baf61c3f..73ae5fcea0de 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -1279,10 +1279,8 @@ static int gfs2_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	if (!sb_rdonly(sb)) {
 		error = init_threads(sdp);
-		if (error) {
-			gfs2_withdraw_delayed(sdp);
+		if (error)
 			goto fail_per_node;
-		}
 	}
 
 	error = gfs2_freeze_lock_shared(sdp);
-- 
2.41.0

