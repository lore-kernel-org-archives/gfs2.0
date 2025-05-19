Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE642749C8
	for <gfs2@lists.linux.dev>; Mon, 19 May 2025 11:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747653557; cv=none; b=IxpbU6Vb5Fe0JyEuMLS+nYzF5x2fu9BiN9AUSCOF4f7xgNYvZ3FjmPziSucgy2WqMwADnS/n5CFpJyn+g1Yb+a6vtahNlndJvqc2vw+OsG+YsP39Wf2PorcnnazbibUfhYVI6PS/fNjaXdLncshKhk8oZh5BL5dbYkDmOWMHzso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747653557; c=relaxed/simple;
	bh=N8RuEkO2IoiL8DgveTH3ZkQKihxgVutAx27REWuwLa0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=BydVCu3CcPJYkFl5oN6ysMlzQ6PoJkpNHuqazwBItZnD5maDPjfH5EuHYuJTg4dU4LeYUkOve4SlSjEX8vyi8YW3VwoiZfI+xpZSgG5ig5m5Bhyv3lqLGLTWqQm4xoBe/swClOz8EyR//j6hug/gibd/Qlboft2RZ0FXn797Apo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JmzAffrO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JmzAffrO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747653554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ewS3bDhA9nzN6Q+elARbuhd/+H3x56UkCJbR9YJBMcw=;
	b=JmzAffrOjV5wZF292cKtXxwGxXsK45xRERiE1k8sy8uWIvOV2B7boGaemm1xP04SyS+brP
	iHk9jcYT3A3Rp+QgmhDQeoJKcpTqSEclqOt1/73upzZKj+lQt3BlVW+9taUci93szDgq3U
	pYSaMk2qcRglC1POZPMYuZeIaiI+OKg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-249-jNFfYdYuOySCFrsCKjJCGA-1; Mon,
 19 May 2025 07:19:13 -0400
X-MC-Unique: jNFfYdYuOySCFrsCKjJCGA-1
X-Mimecast-MFC-AGG-ID: jNFfYdYuOySCFrsCKjJCGA_1747653552
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 74248180036D
	for <gfs2@lists.linux.dev>; Mon, 19 May 2025 11:19:12 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.234])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6DCA31800368;
	Mon, 19 May 2025 11:19:10 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 2/6] gfs2: Move gfs2_log_pointers_init
Date: Mon, 19 May 2025 13:19:01 +0200
Message-ID: <20250519111906.1503215-3-agruenba@redhat.com>
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
X-Mimecast-MFC-PROC-ID: 2g347ZIjMNNrGYOIjls5yyuLZoCRJjB06MtR8GpAiRA_1747653552
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Move gfs2_log_pointers_init to recovery.c: there is no need for inlining
this function.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/log.h      | 11 -----------
 fs/gfs2/recovery.c |  9 +++++++++
 fs/gfs2/recovery.h |  1 +
 3 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/fs/gfs2/log.h b/fs/gfs2/log.h
index c27b05099c1e..fc30ebdad83a 100644
--- a/fs/gfs2/log.h
+++ b/fs/gfs2/log.h
@@ -44,17 +44,6 @@ __releases(&sdp->sd_log_lock)
 	spin_unlock(&sdp->sd_log_lock);
 }
 
-static inline void gfs2_log_pointers_init(struct gfs2_sbd *sdp,
-					  unsigned int value)
-{
-	if (++value == sdp->sd_jdesc->jd_blocks) {
-		value = 0;
-	}
-	sdp->sd_log_tail = value;
-	sdp->sd_log_flush_tail = value;
-	sdp->sd_log_head = value;
-}
-
 static inline void gfs2_ordered_add_inode(struct gfs2_inode *ip)
 {
 	struct gfs2_sbd *sdp = GFS2_SB(&ip->i_inode);
diff --git a/fs/gfs2/recovery.c b/fs/gfs2/recovery.c
index 9080f1b5f434..7776d2092b9b 100644
--- a/fs/gfs2/recovery.c
+++ b/fs/gfs2/recovery.c
@@ -581,3 +581,12 @@ int gfs2_recover_journal(struct gfs2_jdesc *jd, bool wait)
 	return wait ? jd->jd_recover_error : 0;
 }
 
+void gfs2_log_pointers_init(struct gfs2_sbd *sdp, unsigned int value)
+{
+	if (++value == sdp->sd_jdesc->jd_blocks) {
+		value = 0;
+	}
+	sdp->sd_log_tail = value;
+	sdp->sd_log_flush_tail = value;
+	sdp->sd_log_head = value;
+}
diff --git a/fs/gfs2/recovery.h b/fs/gfs2/recovery.h
index 6a0fd42e1120..630ac490948d 100644
--- a/fs/gfs2/recovery.h
+++ b/fs/gfs2/recovery.h
@@ -29,6 +29,7 @@ void gfs2_recover_func(struct work_struct *work);
 int __get_log_header(struct gfs2_sbd *sdp,
 		     const struct gfs2_log_header *lh, unsigned int blkno,
 		     struct gfs2_log_header_host *head);
+void gfs2_log_pointers_init(struct gfs2_sbd *sdp, unsigned int value);
 
 #endif /* __RECOVERY_DOT_H__ */
 
-- 
2.49.0

