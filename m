Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEA41DFD5
	for <gfs2@lists.linux.dev>; Tue, 31 Oct 2023 14:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vw+aFAK6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698762834;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UmmvPt2JDYzVIPSiQSgfxPdm/menzvk+MCgpyLHR0mg=;
	b=Vw+aFAK6lvIT9Od+kKhikdGyHa9jsm0PZjhdQWzm87FS3RLa5mjmhyehh/28KDOfGpeUQK
	WArOs24emxG3lNDODqtuDaJVf2UePfAbXmRgslfMwvajRwx1D5N1IsfsSIJBhcHmiF4W59
	hCszNQUr3W7b6sJhPO9jZ2FuegQli24=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-466-p3VfxgsnPcK7NZSFI6G0yQ-1; Tue,
 31 Oct 2023 10:33:48 -0400
X-MC-Unique: p3VfxgsnPcK7NZSFI6G0yQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 541F43811709
	for <gfs2@lists.linux.dev>; Tue, 31 Oct 2023 14:33:33 +0000 (UTC)
Received: from fs-i40c-03.fs.lab.eng.bos.redhat.com (fs-i40c-03.fast.rdu2.eng.redhat.com [10.6.23.54])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4A966C1290F;
	Tue, 31 Oct 2023 14:33:33 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: rpeterso@redhat.com
Cc: agruenba@redhat.com,
	gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCH] gfs2: don't withdraw if init_threads() got interrupted
Date: Tue, 31 Oct 2023 10:33:28 -0400
Message-Id: <20231031143328.1364741-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

When interrupting a gfs2 mount process by e.g. SIGKILL it could be that
kthread_create() returns -EINTR. If this happens we see on the kernel log:

[55942.843273] gfs2: fsid=gohan:gohan0.2: can't create logd thread: -4
[56186.441647] gfs2: fsid=gohan:gohan0: Trying to join cluster
"lock_dlm", "gohan:gohan0"

The issue is that we can never mount it again because gfs2 does not
cleanup the lockspace and it returns -EEXIST without mounting anything:

[56186.443041] gfs2: fsid=gohan:gohan0: dlm_new_lockspace error -17

The issue is (so far I see on the code) that init_threads() can returns
-4 (-EINTR) what we see above and then calls gfs2_withdraw_delayed().
This will set the SDF_WITHDRAWING and gfs2_lm_unmount() will then not
call unmount and will never release the lockspace.

This patch just don't call gfs2_withdraw_delayed() if init_threads()
returns -EINTR.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/gfs2/ops_fstype.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index 33ca04733e93..227e8b3c2abf 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -1281,7 +1281,13 @@ static int gfs2_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	if (!sb_rdonly(sb)) {
 		error = init_threads(sdp);
-		if (error) {
+		if (error == -EINTR) {
+			/* no setting of SDF_WITHDRAWING when
+			 * kthread_create() returns -EINTR to
+			 * allow lockspace getting released.
+			 */
+			goto fail_per_node;
+		} else if (error) {
 			gfs2_withdraw_delayed(sdp);
 			goto fail_per_node;
 		}
-- 
2.39.3

