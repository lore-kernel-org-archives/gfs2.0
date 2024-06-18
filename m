Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A51846521
	for <gfs2@lists.linux.dev>; Tue, 18 Jun 2024 16:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718726740; cv=none; b=fkd+9WxQhnsODKJ/CMBsiFdI8+hWvs9vKvo8rIsA7M9CeFEqx2Gj2+0BI0hwYrMpL/XA1bfqokK2wqq6QHd7+s1FYJFiivIc4z96Ajcc/TvFWJ2y+a4oy5L+UbOrLEa4TJAASBpK6zLHHsLGpEpFWIHq5YNIHCWSI88xersM4c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718726740; c=relaxed/simple;
	bh=wW0ge5iD54z8kqm+zCcPVvD3qBFiqWNrJqFqa85YL8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=blkOJ3QsgBTCjM0sGaxNW1YYpMq/MJrZb0XbWHdI8PDgl1qLgSzb2dWcxCBf8zxqQuA6qR9OAoGkolFvYK07QYUzwWD6xbmg6oHA5we6YAVwb48xmQuZ8gT6JGI1jHK4X7v5WU0lXLvtvoaefpBXt9FbP5rJsxmlQdoQhaO4wbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bpypeYjf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bpypeYjf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718726737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZYcaZ77UMeUihVycBC4MmeqJrGGTiynqEY2QbJDfYCo=;
	b=bpypeYjfhVyxirQWjcj+DmFn2nU4cWy8oqHB9Ji6QAKu+qa69p8SXcdoAxwX5dxmR+1v6D
	s4cJ1dkcI+rYj3cEmWhBKzoIhEh4I3OqIyt9xpFvmYQhtMT6o1FDy20y7kVUT4DW38vVN4
	tBnNKFCcZVnogynogjprUk+TxSFDxfw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-313-pNFTN6PQOX2cRDBMcg9kZQ-1; Tue,
 18 Jun 2024 12:05:35 -0400
X-MC-Unique: pNFTN6PQOX2cRDBMcg9kZQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F046019560BD
	for <gfs2@lists.linux.dev>; Tue, 18 Jun 2024 16:05:34 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.40])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EB68F19560AE;
	Tue, 18 Jun 2024 16:05:33 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 10/13] gfs2: Add some missing quota locking
Date: Tue, 18 Jun 2024 18:05:14 +0200
Message-ID: <20240618160517.901589-11-agruenba@redhat.com>
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

The quota code is missing some locking between local quota changes and
syncing those quota changes to the global quota file (gfs2_quota_sync);
in particular, qd->qd_change needs to be kept in sync with the
QDF_CHANGE change flag and the number of references held.  Use the
qd->qd_lockref.lock spinlock for that.

With the qd->qd_lockref.lock spinlock held, we can no longer call
lockref_get(), so turn qd_hold() into a variant that assumes that the
lock is held.  This function is really supposed to take an additional
reference when one or more references are already held, so check for
that instead of checking if the lockref is dead.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/quota.c | 82 ++++++++++++++++++++++++++++++++-----------------
 1 file changed, 53 insertions(+), 29 deletions(-)

diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
index ae02403407aa..283c6ff21911 100644
--- a/fs/gfs2/quota.c
+++ b/fs/gfs2/quota.c
@@ -316,11 +316,11 @@ static int qd_get(struct gfs2_sbd *sdp, struct kqid qid,
 }
 
 
-static void qd_hold(struct gfs2_quota_data *qd)
+static void __qd_hold(struct gfs2_quota_data *qd)
 {
 	struct gfs2_sbd *sdp = qd->qd_sbd;
-	gfs2_assert(sdp, !__lockref_is_dead(&qd->qd_lockref));
-	lockref_get(&qd->qd_lockref);
+	gfs2_assert(sdp, qd->qd_lockref.count > 0);
+	qd->qd_lockref.count++;
 }
 
 static void qd_put(struct gfs2_quota_data *qd)
@@ -462,19 +462,27 @@ static void bh_put(struct gfs2_quota_data *qd)
 static bool qd_grab_sync(struct gfs2_sbd *sdp, struct gfs2_quota_data *qd,
 			 u64 sync_gen)
 {
+	bool ret = false;
+
+	spin_lock(&qd->qd_lockref.lock);
 	if (test_bit(QDF_LOCKED, &qd->qd_flags) ||
 	    !test_bit(QDF_CHANGE, &qd->qd_flags) ||
 	    qd->qd_sync_gen >= sync_gen)
-		return false;
+		goto out;
 
-	if (!lockref_get_not_dead(&qd->qd_lockref))
-		return false;
+	if (__lockref_is_dead(&qd->qd_lockref))
+		goto out;
+	qd->qd_lockref.count++;
 
 	list_move_tail(&qd->qd_list, &sdp->sd_quota_list);
 	set_bit(QDF_LOCKED, &qd->qd_flags);
 	qd->qd_change_sync = qd->qd_change;
 	slot_hold(qd);
-	return true;
+	ret = true;
+
+out:
+	spin_unlock(&qd->qd_lockref.lock);
+	return ret;
 }
 
 static void qd_ungrab_sync(struct gfs2_quota_data *qd)
@@ -493,8 +501,10 @@ static void qdsb_put(struct gfs2_quota_data *qd)
 
 static void qd_unlock(struct gfs2_quota_data *qd)
 {
+	spin_lock(&qd->qd_lockref.lock);
 	gfs2_assert_warn(qd->qd_sbd, test_bit(QDF_LOCKED, &qd->qd_flags));
 	clear_bit(QDF_LOCKED, &qd->qd_flags);
+	spin_unlock(&qd->qd_lockref.lock);
 	qdsb_put(qd);
 }
 
@@ -663,6 +673,7 @@ static void do_qc(struct gfs2_quota_data *qd, s64 change)
 	struct gfs2_sbd *sdp = qd->qd_sbd;
 	struct gfs2_inode *ip = GFS2_I(sdp->sd_qc_inode);
 	struct gfs2_quota_change *qc = qd->qd_bh_qc;
+	bool needs_put = false;
 	s64 x;
 
 	mutex_lock(&sdp->sd_quota_mutex);
@@ -674,26 +685,24 @@ static void do_qc(struct gfs2_quota_data *qd, s64 change)
 	 * used, and we assume a value of 0 otherwise.
 	 */
 
+	spin_lock(&qd->qd_lockref.lock);
+
 	x = 0;
 	if (test_bit(QDF_CHANGE, &qd->qd_flags))
 		x = be64_to_cpu(qc->qc_change);
 	x += change;
-
-	spin_lock(&qd_lock);
 	qd->qd_change += change;
-	spin_unlock(&qd_lock);
 
 	if (!x && test_bit(QDF_CHANGE, &qd->qd_flags)) {
 		/* The slot in the quota change file becomes unused. */
 		clear_bit(QDF_CHANGE, &qd->qd_flags);
 		qc->qc_flags = 0;
 		qc->qc_id = 0;
-		slot_put(qd);
-		qd_put(qd);
+		needs_put = true;
 	} else if (x && !test_bit(QDF_CHANGE, &qd->qd_flags)) {
 		/* The slot in the quota change file becomes used. */
 		set_bit(QDF_CHANGE, &qd->qd_flags);
-		qd_hold(qd);
+		__qd_hold(qd);
 		slot_hold(qd);
 
 		qc->qc_flags = 0;
@@ -703,6 +712,12 @@ static void do_qc(struct gfs2_quota_data *qd, s64 change)
 	}
 	qc->qc_change = cpu_to_be64(x);
 
+	spin_unlock(&qd->qd_lockref.lock);
+
+	if (needs_put) {
+		slot_put(qd);
+		qd_put(qd);
+	}
 	if (change < 0) /* Reset quiet flag if we freed some blocks */
 		clear_bit(QDF_QMSG_QUIET, &qd->qd_flags);
 	mutex_unlock(&sdp->sd_quota_mutex);
@@ -844,6 +859,7 @@ static int gfs2_adjust_quota(struct gfs2_sbd *sdp, loff_t loc,
 	be64_add_cpu(&q.qu_value, change);
 	if (((s64)be64_to_cpu(q.qu_value)) < 0)
 		q.qu_value = 0; /* Never go negative on quota usage */
+	spin_lock(&qd->qd_lockref.lock);
 	qd->qd_qb.qb_value = q.qu_value;
 	if (fdq) {
 		if (fdq->d_fieldmask & QC_SPC_SOFT) {
@@ -859,6 +875,7 @@ static int gfs2_adjust_quota(struct gfs2_sbd *sdp, loff_t loc,
 			qd->qd_qb.qb_value = q.qu_value;
 		}
 	}
+	spin_unlock(&qd->qd_lockref.lock);
 
 	err = gfs2_write_disk_quota(sdp, &q, loc);
 	if (!err) {
@@ -990,7 +1007,9 @@ static int update_qd(struct gfs2_sbd *sdp, struct gfs2_quota_data *qd)
 	qlvb->qb_limit = q.qu_limit;
 	qlvb->qb_warn = q.qu_warn;
 	qlvb->qb_value = q.qu_value;
+	spin_lock(&qd->qd_lockref.lock);
 	qd->qd_qb = *qlvb;
+	spin_unlock(&qd->qd_lockref.lock);
 
 	return 0;
 }
@@ -1012,7 +1031,9 @@ static int do_glock(struct gfs2_quota_data *qd, int force_refresh,
 	if (test_and_clear_bit(QDF_REFRESH, &qd->qd_flags))
 		force_refresh = FORCE;
 
+	spin_lock(&qd->qd_lockref.lock);
 	qd->qd_qb = *(struct gfs2_quota_lvb *)qd->qd_gl->gl_lksb.sb_lvbptr;
+	spin_unlock(&qd->qd_lockref.lock);
 
 	if (force_refresh || qd->qd_qb.qb_magic != cpu_to_be32(GFS2_MAGIC)) {
 		gfs2_glock_dq_uninit(q_gh);
@@ -1085,20 +1106,19 @@ static bool need_sync(struct gfs2_quota_data *qd)
 	struct gfs2_tune *gt = &sdp->sd_tune;
 	s64 value, change, limit;
 	unsigned int num, den;
+	int ret = false;
 
+	spin_lock(&qd->qd_lockref.lock);
 	if (!qd->qd_qb.qb_limit)
-		return false;
+		goto out;
 
-	spin_lock(&qd_lock);
 	change = qd->qd_change;
-	spin_unlock(&qd_lock);
-
 	if (change <= 0)
-		return false;
+		goto out;
 	value = (s64)be64_to_cpu(qd->qd_qb.qb_value);
 	limit = (s64)be64_to_cpu(qd->qd_qb.qb_limit);
 	if (value >= limit)
-		return false;
+		goto out;
 
 	spin_lock(&gt->gt_spin);
 	num = gt->gt_quota_scale_num;
@@ -1108,8 +1128,12 @@ static bool need_sync(struct gfs2_quota_data *qd)
 	change *= gfs2_jindex_size(sdp) * num;
 	change = div_s64(change, den);
 	if (value + change < limit)
-		return false;
-	return true;
+		goto out;
+
+	ret = true;
+out:
+	spin_unlock(&qd->qd_lockref.lock);
+	return ret;
 }
 
 void gfs2_quota_unlock(struct gfs2_inode *ip)
@@ -1211,12 +1235,12 @@ int gfs2_quota_check(struct gfs2_inode *ip, kuid_t uid, kgid_t gid,
 		      qid_eq(qd->qd_id, make_kqid_gid(gid))))
 			continue;
 
+		spin_lock(&qd->qd_lockref.lock);
 		warn = (s64)be64_to_cpu(qd->qd_qb.qb_warn);
 		limit = (s64)be64_to_cpu(qd->qd_qb.qb_limit);
 		value = (s64)be64_to_cpu(qd->qd_qb.qb_value);
-		spin_lock(&qd_lock);
 		value += qd->qd_change;
-		spin_unlock(&qd_lock);
+		spin_unlock(&qd->qd_lockref.lock);
 
 		if (limit > 0 && (limit - value) < ap->allowed)
 			ap->allowed = limit - value;
@@ -1282,12 +1306,12 @@ static bool qd_changed(struct gfs2_sbd *sdp)
 
 	spin_lock(&qd_lock);
 	list_for_each_entry(qd, &sdp->sd_quota_list, qd_list) {
-		if (test_bit(QDF_LOCKED, &qd->qd_flags) ||
-		    !test_bit(QDF_CHANGE, &qd->qd_flags))
-			continue;
-
-		changed = true;
-		break;
+		spin_lock(&qd->qd_lockref.lock);
+		changed = !test_bit(QDF_LOCKED, &qd->qd_flags) &&
+			  test_bit(QDF_CHANGE, &qd->qd_flags);
+		spin_unlock(&qd->qd_lockref.lock);
+		if (changed)
+			break;
 	}
 	spin_unlock(&qd_lock);
 	return changed;
-- 
2.45.1

