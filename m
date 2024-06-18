Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126C648788
	for <gfs2@lists.linux.dev>; Tue, 18 Jun 2024 16:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718726735; cv=none; b=QtUPrcvD5W2u95TnJbPmV9kuop7vTMQtzRLp0hhGip+TnfpVvLEPci6lpCBj1sInAjWpley4G3yX6qMt1RMsj+Fv2fp3SZVCzIoajTtpPXKCQI6YIDf5P6gv/qjMycNbvtaoXlCYvYUG/GLlTslGmUJTEtJVmG90arTV89bCUOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718726735; c=relaxed/simple;
	bh=CpbT+gkU+izMPhKNo7yBaOulfAawXjpXLhSAPSUgYT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z+auCcCJc7ZlcuqwdJJuIHP3mgVpH5XBDM+lFoH2fkOzx1Azqo8P54OMwRcW8em8W0AEHCFSfYvZdA4YVKkrnF+LWVZzPrZ0yaLd/Q4YJLM15Zx5dZGVmrkvprfD9u3TnqMw0XLgyal6Q+Q5G8WTDMFSwZaAG90PLvOtfY3kV8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XXFyFd17; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XXFyFd17"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718726733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4p0vQGXL5f/CH1mlh1URehTf6RJccablQDA+capnqS4=;
	b=XXFyFd17tSokqKhdOnDIjipByoTXVy44k6wS88xCr4DICe2pqRmsS0sKvPv00r25mcMGMa
	7YaxdzUZNLDJsYOvSt8Mr0/50s4+1atuNL2MQdrabqBgUPDJ0o8qcaeAEYtewOO+0VOQap
	ZHz3L6lM1hn8cV0oRZw+IHOlaSidOWE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-175-chGZFbxIPSGXuASnrQ5Z9Q-1; Tue,
 18 Jun 2024 12:05:31 -0400
X-MC-Unique: chGZFbxIPSGXuASnrQ5Z9Q-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6136C1955EF3
	for <gfs2@lists.linux.dev>; Tue, 18 Jun 2024 16:05:29 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.40])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 630D519560B2;
	Tue, 18 Jun 2024 16:05:28 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 06/13] gfs2: Revert "Add quota_change type"
Date: Tue, 18 Jun 2024 18:05:10 +0200
Message-ID: <20240618160517.901589-7-agruenba@redhat.com>
In-Reply-To: <20240618160517.901589-1-agruenba@redhat.com>
References: <20240618160517.901589-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Commit 432928c93779 ("gfs2: Add quota_change type") makes the incorrect
assertion that function do_qc() should behave differently in the two
contexts it is used in, but that isn't actually true.  In all cases,
do_qc() grabs a "reference" when it starts using a slot in the per-node
quota changes file, and it releases that "reference" when no more
residual changes remain.  Revert that broken commit.

There are some remaining issues with function do_qc() which are
addressed in the next commit.

This reverts commit 432928c9377959684c748a9bc6553ed2d3c2ea4f.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/quota.c | 19 +++++++------------
 fs/gfs2/util.c  |  6 +++---
 2 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
index f0aaae07a598..371fad7d64e7 100644
--- a/fs/gfs2/quota.c
+++ b/fs/gfs2/quota.c
@@ -75,9 +75,6 @@
 #define GFS2_QD_HASH_SIZE       BIT(GFS2_QD_HASH_SHIFT)
 #define GFS2_QD_HASH_MASK       (GFS2_QD_HASH_SIZE - 1)
 
-#define QC_CHANGE 0
-#define QC_SYNC 1
-
 /* Lock order: qd_lock -> bucket lock -> qd->lockref.lock -> lru lock */
 /*                     -> sd_bitmap_lock                              */
 static DEFINE_SPINLOCK(qd_lock);
@@ -695,7 +692,7 @@ static int sort_qd(const void *a, const void *b)
 	return 0;
 }
 
-static void do_qc(struct gfs2_quota_data *qd, s64 change, int qc_type)
+static void do_qc(struct gfs2_quota_data *qd, s64 change)
 {
 	struct gfs2_sbd *sdp = qd->qd_sbd;
 	struct gfs2_inode *ip = GFS2_I(sdp->sd_qc_inode);
@@ -720,18 +717,16 @@ static void do_qc(struct gfs2_quota_data *qd, s64 change, int qc_type)
 	qd->qd_change = x;
 	spin_unlock(&qd_lock);
 
-	if (qc_type == QC_CHANGE) {
-		if (!test_and_set_bit(QDF_CHANGE, &qd->qd_flags)) {
-			qd_hold(qd);
-			slot_hold(qd);
-		}
-	} else {
+	if (!x) {
 		gfs2_assert_warn(sdp, test_bit(QDF_CHANGE, &qd->qd_flags));
 		clear_bit(QDF_CHANGE, &qd->qd_flags);
 		qc->qc_flags = 0;
 		qc->qc_id = 0;
 		slot_put(qd);
 		qd_put(qd);
+	} else if (!test_and_set_bit(QDF_CHANGE, &qd->qd_flags)) {
+		qd_hold(qd);
+		slot_hold(qd);
 	}
 
 	if (change < 0) /* Reset quiet flag if we freed some blocks */
@@ -977,7 +972,7 @@ static int do_sync(unsigned int num_qd, struct gfs2_quota_data **qda)
 		if (error)
 			goto out_end_trans;
 
-		do_qc(qd, -qd->qd_change_sync, QC_SYNC);
+		do_qc(qd, -qd->qd_change_sync);
 		set_bit(QDF_REFRESH, &qd->qd_flags);
 	}
 
@@ -1303,7 +1298,7 @@ void gfs2_quota_change(struct gfs2_inode *ip, s64 change,
 
 		if (qid_eq(qd->qd_id, make_kqid_uid(uid)) ||
 		    qid_eq(qd->qd_id, make_kqid_gid(gid))) {
-			do_qc(qd, change, QC_CHANGE);
+			do_qc(qd, change);
 		}
 	}
 }
diff --git a/fs/gfs2/util.c b/fs/gfs2/util.c
index 7e79b1a9e35f..13be8d1d228b 100644
--- a/fs/gfs2/util.c
+++ b/fs/gfs2/util.c
@@ -99,12 +99,12 @@ int check_journal_clean(struct gfs2_sbd *sdp, struct gfs2_jdesc *jd,
  */
 int gfs2_freeze_lock_shared(struct gfs2_sbd *sdp)
 {
+	int flags = LM_FLAG_NOEXP | GL_EXACT;
 	int error;
 
-	error = gfs2_glock_nq_init(sdp->sd_freeze_gl, LM_ST_SHARED,
-				   LM_FLAG_NOEXP | GL_EXACT,
+	error = gfs2_glock_nq_init(sdp->sd_freeze_gl, LM_ST_SHARED, flags,
 				   &sdp->sd_freeze_gh);
-	if (error)
+	if (error && error != GLR_TRYFAILED)
 		fs_err(sdp, "can't lock the freeze glock: %d\n", error);
 	return error;
 }
-- 
2.45.1

