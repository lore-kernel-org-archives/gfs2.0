Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749F414A85
	for <gfs2@lists.linux.dev>; Wed,  1 Nov 2023 16:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JwRWFaK3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698857201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/Y+9NPUkPMNdyvLo1rkgMj0mLCg6D8BvATd0opVs9ZA=;
	b=JwRWFaK3eG5EqumWze3dwLUUAKd49i7Ztg8E8hWs5gpCahQRayWp6b09wFoaz8B1DQiUBY
	umwuyOLF4/iVnB5Pb0DDwmiZnwc/sbH3uV8kS7sD+jHSEaHfMyARwojEe27DKbxMrdNC9s
	ctNNK+8KY6rbwJaUAE+YqD2qTxIGmOA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-163-WCj4jDHLPvest8C22J5rUw-1; Wed, 01 Nov 2023 12:46:38 -0400
X-MC-Unique: WCj4jDHLPvest8C22J5rUw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A1EA2811E88;
	Wed,  1 Nov 2023 16:46:37 +0000 (UTC)
Received: from pasta.redhat.com (unknown [10.45.224.27])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D7FF140C6EC0;
	Wed,  1 Nov 2023 16:46:36 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Juntong Deng <juntong.deng@outlook.com>,
	syzbot+29c47e9e51895928698c@syzkaller.appspotmail.com,
	Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 25/25] fs/gfs2: Fix slab-use-after-free in gfs2_qd_dealloc
Date: Wed,  1 Nov 2023 17:46:15 +0100
Message-ID: <20231101164615.1138692-26-agruenba@redhat.com>
In-Reply-To: <20231101164615.1138692-1-agruenba@redhat.com>
References: <20231101164615.1138692-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

From: Juntong Deng <juntong.deng@outlook.com>

In gfs2_put_super(), whether withdrawn or not, the quota should
be cleaned up by gfs2_quota_cleanup().

Otherwise, struct gfs2_sbd will be freed before gfs2_qd_dealloc (rcu
callback) has run for all gfs2_quota_data objects, resulting in
use-after-free.

Also, gfs2_destroy_threads() and gfs2_quota_cleanup() is already called
by gfs2_make_fs_ro(), so in gfs2_put_super(), after calling
gfs2_make_fs_ro(), there is no need to call them again.

Reported-by: syzbot+29c47e9e51895928698c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=29c47e9e51895928698c
Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/super.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index 726f062bc490..84e88b50ed92 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -602,13 +602,15 @@ static void gfs2_put_super(struct super_block *sb)
 	}
 	spin_unlock(&sdp->sd_jindex_spin);
 
-	if (!sb_rdonly(sb)) {
+	if (!sb_rdonly(sb))
 		gfs2_make_fs_ro(sdp);
-	}
-	if (gfs2_withdrawn(sdp)) {
-		gfs2_destroy_threads(sdp);
+	else {
+		if (gfs2_withdrawn(sdp))
+			gfs2_destroy_threads(sdp);
+
 		gfs2_quota_cleanup(sdp);
 	}
+
 	WARN_ON(gfs2_withdrawing(sdp));
 
 	/*  At this point, we're through modifying the disk  */
-- 
2.41.0

