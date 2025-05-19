Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4601D5CE8
	for <gfs2@lists.linux.dev>; Mon, 19 May 2025 11:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747653559; cv=none; b=QMO9a50bc/ix2MmQIFZGGC4I9gJ9z1l2Ykq8qqAnf7fYnTNWZy2y1k7kGvsRQLlluCNdXQAKuXgfP4GbWTnt8dPl00vX7HLfVKYBaviwlnaEoQuTzFwdNGluyE/9rcZLbftHgq1ufXANCsQJbAdktG1/KREPUQVcAnV41q7WuZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747653559; c=relaxed/simple;
	bh=KStuVi3mDVZkaq6MJqXYm8+fd4yiRw1Mbxi22RQ4y6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=W6Ut2EKHPa/dF/3Ke/WScOs26v2If/q4U9yz1UigorQuszUje4D0UaN6NPtlKCkxnIgD+YG5MFF41L2ksTTvdAzR5kJi80KDfP0Gcmasl04W7MXneRRU0gFyLy8KnV0opr5mJmETMYT0JmBqNEWEaxqmxFPZIp9Z1Tt1p4RCuEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AkP4ikf/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AkP4ikf/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747653556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q+tosVw4YYaP2giDvHBz8IORytkUN2pNrnssLsCFx9c=;
	b=AkP4ikf/xu+O6/uQDha1y+votIBRM7JTVAIffnImOEGxqsWBV6MDd6LXoKHm3Uu02mraZ/
	DdP4RJVOcDhwkbBZUabgMTTsUG9Y4YlhqEXA+d8+pvAf2y02P1jyIo2gd2KsVP8V1+sie1
	Om8Y3jTgB87BP8KisWSvgBulO4LgA3E=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-664-yVIjPBt8NIOfbNynYHI3nw-1; Mon,
 19 May 2025 07:19:14 -0400
X-MC-Unique: yVIjPBt8NIOfbNynYHI3nw-1
X-Mimecast-MFC-AGG-ID: yVIjPBt8NIOfbNynYHI3nw_1747653554
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 004631956094
	for <gfs2@lists.linux.dev>; Mon, 19 May 2025 11:19:14 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.234])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EC1C218004A7;
	Mon, 19 May 2025 11:19:12 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 3/6] gfs2: Simplify gfs2_log_pointers_init
Date: Mon, 19 May 2025 13:19:02 +0200
Message-ID: <20250519111906.1503215-4-agruenba@redhat.com>
In-Reply-To: <20250519111906.1503215-1-agruenba@redhat.com>
References: <20250519111906.1503215-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3DgWKC5upXLIFXljmLi_TPLdzlVqXm4FtxYUGV5cFkw_1747653554
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Move the initialization of sdp->sd_log_sequence and
sdp->sd_log_flush_head inside gfs2_log_pointers_init().  Use
gfs2_replay_incr_blk().

Before this change, the log head lookup code in freeze_go_xmote_bh()
didn't update sdp->sd_log_flush_head.  This is now fixed, but the code
in freeze_go_xmote_bh() appears to be pretty useless in the first place:
on a frozen filesystem, the log head will not change.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/glops.c    |  3 +--
 fs/gfs2/recovery.c | 19 ++++++++-----------
 fs/gfs2/recovery.h |  3 ++-
 fs/gfs2/super.c    |  3 +--
 4 files changed, 12 insertions(+), 16 deletions(-)

diff --git a/fs/gfs2/glops.c b/fs/gfs2/glops.c
index 116efe335c32..e153db45bbd9 100644
--- a/fs/gfs2/glops.c
+++ b/fs/gfs2/glops.c
@@ -607,8 +607,7 @@ static int freeze_go_xmote_bh(struct gfs2_glock *gl)
 		if (gfs2_assert_withdraw_delayed(sdp, head.lh_flags &
 						 GFS2_LOG_HEAD_UNMOUNT))
 			return -EIO;
-		sdp->sd_log_sequence = head.lh_sequence + 1;
-		gfs2_log_pointers_init(sdp, head.lh_blkno);
+		gfs2_log_pointers_init(sdp, &head);
 	}
 	return 0;
 }
diff --git a/fs/gfs2/recovery.c b/fs/gfs2/recovery.c
index 7776d2092b9b..db1238480e91 100644
--- a/fs/gfs2/recovery.c
+++ b/fs/gfs2/recovery.c
@@ -270,10 +270,6 @@ static void clean_journal(struct gfs2_jdesc *jd,
 	gfs2_write_log_header(sdp, jd, head->lh_sequence + 1, 0, lblock,
 			      GFS2_LOG_HEAD_UNMOUNT | GFS2_LOG_HEAD_RECOVERY,
 			      REQ_PREFLUSH | REQ_FUA | REQ_META | REQ_SYNC);
-	if (jd->jd_jid == sdp->sd_lockstruct.ls_jid) {
-		sdp->sd_log_flush_head = lblock;
-		gfs2_log_incr_head(sdp);
-	}
 }
 
 
@@ -581,12 +577,13 @@ int gfs2_recover_journal(struct gfs2_jdesc *jd, bool wait)
 	return wait ? jd->jd_recover_error : 0;
 }
 
-void gfs2_log_pointers_init(struct gfs2_sbd *sdp, unsigned int value)
+void gfs2_log_pointers_init(struct gfs2_sbd *sdp,
+			    struct gfs2_log_header_host *head)
 {
-	if (++value == sdp->sd_jdesc->jd_blocks) {
-		value = 0;
-	}
-	sdp->sd_log_tail = value;
-	sdp->sd_log_flush_tail = value;
-	sdp->sd_log_head = value;
+	sdp->sd_log_sequence = head->lh_sequence + 1;
+	gfs2_replay_incr_blk(sdp->sd_jdesc, &head->lh_blkno);
+	sdp->sd_log_tail = head->lh_blkno;
+	sdp->sd_log_flush_head = head->lh_blkno;
+	sdp->sd_log_flush_tail = head->lh_blkno;
+	sdp->sd_log_head = head->lh_blkno;
 }
diff --git a/fs/gfs2/recovery.h b/fs/gfs2/recovery.h
index 630ac490948d..5a5ba72ecd75 100644
--- a/fs/gfs2/recovery.h
+++ b/fs/gfs2/recovery.h
@@ -29,7 +29,8 @@ void gfs2_recover_func(struct work_struct *work);
 int __get_log_header(struct gfs2_sbd *sdp,
 		     const struct gfs2_log_header *lh, unsigned int blkno,
 		     struct gfs2_log_header_host *head);
-void gfs2_log_pointers_init(struct gfs2_sbd *sdp, unsigned int value);
+void gfs2_log_pointers_init(struct gfs2_sbd *sdp,
+			    struct gfs2_log_header_host *head);
 
 #endif /* __RECOVERY_DOT_H__ */
 
diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index 54f1efd47a3e..b55aa38a485a 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -153,8 +153,7 @@ int gfs2_make_fs_rw(struct gfs2_sbd *sdp)
 	}
 
 	/*  Initialize some head of the log stuff  */
-	sdp->sd_log_sequence = head.lh_sequence + 1;
-	gfs2_log_pointers_init(sdp, head.lh_blkno);
+	gfs2_log_pointers_init(sdp, &head);
 
 	error = gfs2_quota_init(sdp);
 	if (!error && gfs2_withdrawing_or_withdrawn(sdp))
-- 
2.49.0

