Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8EB482EE
	for <gfs2@lists.linux.dev>; Tue, 18 Jun 2024 16:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718726736; cv=none; b=fViwwMit+sCie8TSWAmVxnx21yV3x+8AnrFwGR1SPhclQt6uNj9s3gHmfXUmw3VaLyHu3OI/i5BJueJPe92GGNS6AZzHLQG9wOabvBHND1T7PL64tj/Ztcx0ZJTevfUaRJJwZo/1moqwQVyinjFh6usYLueUyqbCrOlASu9BmpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718726736; c=relaxed/simple;
	bh=nrsWAEMOk45TVYCUAbPS8PeCMG53574d3r8uMWI/jLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZFyy8H5srBrMrD+sZR3VMbVmfTM/ajiC0fT5hMilvoFZk4W/zJpvMeI2aHiYYU+SaZ9eNrl8hxGbS1VmUs2NBkomGukA6RTeAYwqF94Pk6I3lgPUfEd0t7FLtOv44zEcGt36f8QibR7CaBjqkmw+YQY8DA4o+cAgNFK2PDUoh2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RjgF1wWg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RjgF1wWg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718726733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t6IXomBudozblbiSmtDCZf/EPEe0SpdN9vbb8ikeoH4=;
	b=RjgF1wWgB4CAmbI5bcixQ+sfBVdXyf2TTQVhscUXMNq+qGad6Suj5VzoZzHkNr6UG3BzAs
	U4eP4vcp4vLlPi8SivVRyIlJ7qW/jORbHH1Rkp+wKwFnBjrg+LkV2RdYaKujVXE5ls0tkv
	nyKI3MYhVKAz8XJ+ChGDHAdiDi1291E=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677-AwSU3GJ1NG2plNxriw3OJA-1; Tue,
 18 Jun 2024 12:05:28 -0400
X-MC-Unique: AwSU3GJ1NG2plNxriw3OJA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 72CDF1956095
	for <gfs2@lists.linux.dev>; Tue, 18 Jun 2024 16:05:26 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.40])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 75A9A19560B2;
	Tue, 18 Jun 2024 16:05:25 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 04/13] gfs2: qd_check_sync cleanups
Date: Tue, 18 Jun 2024 18:05:08 +0200
Message-ID: <20240618160517.901589-5-agruenba@redhat.com>
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

Rename qd_check_sync() to qd_grab_sync() and make it return a bool.
Turn the sync_gen pointer into a regular u64 and pass in U64_MAX instead
of a NULL pointer when sync generation checking isn't needed.

Introduce a new qd_ungrab_sync() helper for undoing the effects of
qd_grab_sync() if the subsequent bh_get() on the qd object fails.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/quota.c | 40 ++++++++++++++++++++++------------------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
index e0840b412d28..bbd66adaec3d 100644
--- a/fs/gfs2/quota.c
+++ b/fs/gfs2/quota.c
@@ -462,13 +462,13 @@ static void bh_put(struct gfs2_quota_data *qd)
 	mutex_unlock(&sdp->sd_quota_mutex);
 }
 
-static int qd_check_sync(struct gfs2_sbd *sdp, struct gfs2_quota_data *qd,
-			 u64 *sync_gen)
+static bool qd_grab_sync(struct gfs2_sbd *sdp, struct gfs2_quota_data *qd,
+			 u64 sync_gen)
 {
 	if (test_bit(QDF_LOCKED, &qd->qd_flags) ||
 	    !test_bit(QDF_CHANGE, &qd->qd_flags) ||
-	    (sync_gen && (qd->qd_sync_gen >= *sync_gen)))
-		return 0;
+	    qd->qd_sync_gen >= sync_gen)
+		return false;
 
 	/*
 	 * If qd_change is 0 it means a pending quota change was negated.
@@ -478,17 +478,24 @@ static int qd_check_sync(struct gfs2_sbd *sdp, struct gfs2_quota_data *qd,
 	if (!qd->qd_change && test_and_clear_bit(QDF_CHANGE, &qd->qd_flags)) {
 		slot_put(qd);
 		qd_put(qd);
-		return 0;
+		return false;
 	}
 
 	if (!lockref_get_not_dead(&qd->qd_lockref))
-		return 0;
+		return false;
 
 	list_move_tail(&qd->qd_list, &sdp->sd_quota_list);
 	set_bit(QDF_LOCKED, &qd->qd_flags);
 	qd->qd_change_sync = qd->qd_change;
 	slot_hold(qd);
-	return 1;
+	return true;
+}
+
+static void qd_ungrab_sync(struct gfs2_quota_data *qd)
+{
+	clear_bit(QDF_LOCKED, &qd->qd_flags);
+	slot_put(qd);
+	qd_put(qd);
 }
 
 static int qd_fish(struct gfs2_sbd *sdp, struct gfs2_quota_data **qdp)
@@ -504,7 +511,7 @@ static int qd_fish(struct gfs2_sbd *sdp, struct gfs2_quota_data **qdp)
 	spin_lock(&qd_lock);
 
 	list_for_each_entry(iter, &sdp->sd_quota_list, qd_list) {
-		if (qd_check_sync(sdp, iter, &sdp->sd_quota_sync_gen)) {
+		if (qd_grab_sync(sdp, iter, sdp->sd_quota_sync_gen)) {
 			qd = iter;
 			break;
 		}
@@ -515,9 +522,7 @@ static int qd_fish(struct gfs2_sbd *sdp, struct gfs2_quota_data **qdp)
 	if (qd) {
 		error = bh_get(qd);
 		if (error) {
-			clear_bit(QDF_LOCKED, &qd->qd_flags);
-			slot_put(qd);
-			qd_put(qd);
+			qd_ungrab_sync(qd);
 			return error;
 		}
 	}
@@ -1157,7 +1162,6 @@ void gfs2_quota_unlock(struct gfs2_inode *ip)
 	struct gfs2_quota_data *qda[2 * GFS2_MAXQUOTAS];
 	unsigned int count = 0;
 	u32 x;
-	int found;
 
 	if (!test_and_clear_bit(GIF_QD_LOCKED, &ip->i_flags))
 		return;
@@ -1165,6 +1169,7 @@ void gfs2_quota_unlock(struct gfs2_inode *ip)
 	for (x = 0; x < ip->i_qadata->qa_qd_num; x++) {
 		struct gfs2_quota_data *qd;
 		bool sync;
+		int error;
 
 		qd = ip->i_qadata->qa_qd[x];
 		sync = need_sync(qd);
@@ -1174,17 +1179,16 @@ void gfs2_quota_unlock(struct gfs2_inode *ip)
 			continue;
 
 		spin_lock(&qd_lock);
-		found = qd_check_sync(sdp, qd, NULL);
+		sync = qd_grab_sync(sdp, qd, U64_MAX);
 		spin_unlock(&qd_lock);
 
-		if (!found)
+		if (!sync)
 			continue;
 
 		gfs2_assert_warn(sdp, qd->qd_change_sync);
-		if (bh_get(qd)) {
-			clear_bit(QDF_LOCKED, &qd->qd_flags);
-			slot_put(qd);
-			qd_put(qd);
+		error = bh_get(qd);
+		if (error) {
+			qd_ungrab_sync(qd);
 			continue;
 		}
 
-- 
2.45.1

