Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC4D208A0
	for <gfs2@lists.linux.dev>; Tue, 18 Jun 2024 16:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718726736; cv=none; b=gbgM0LBZ9FS0Ll8MOwr2Jb9gsJ4Wgx0MS5Nhe7A7mvfUMZSwyVFn7vz+0J26BSW7uM0tJ7y+KQxnm0Byg8H0Up0GCv8vXUgifvIfgilAHPac+n5ejzSCPsbkeYgO/eRQgo0R1sBIb2auZwOwejrNBvcL8zkkuiHltrt/rRDg8Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718726736; c=relaxed/simple;
	bh=nRuyjK2XHGuTWcXAYqTDs7Z2Lwl+Tgqwn6ACFH5ZaTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hSF80r4X9+MDgnf8/hjbZ1034vwrz5ra9A3Wa/hW4Eb5HR2QTd8dP+kz5lI2vZYAolIKBpZBvB460Koo+YDLhBjX3lolQ8RybeC4DyWlqHgIePEQY8WHZ7FjeUgjqd/k9VYFlEsHchTTlBSaDQyIX/yUqU18tjTaokIFIzzWkLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y999Vpfl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y999Vpfl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718726734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bZqElkOGWTyQkANabO0++9xTHDfW8MCGUAPMu/D5Xgg=;
	b=Y999Vpflmxk8yVYXnCdzYFn8z0oaMVZJFprPkxMkwFYlaXjez8YF6xASnnkNzokio/O10L
	Hu8cRxz5uklAGEqs5vm4jcGMr9dwpB6LLoymZJkI3hK4q7HzqVDyJfSBu/f+V1OjNu3+sl
	KMrJe5CeHxZQApuulAxSqp5V7Ks34fo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-452-xsJUn0pCNAqK_LmDmEG4OQ-1; Tue,
 18 Jun 2024 12:05:31 -0400
X-MC-Unique: xsJUn0pCNAqK_LmDmEG4OQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BF8931955F03
	for <gfs2@lists.linux.dev>; Tue, 18 Jun 2024 16:05:30 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.40])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C25D51955E74;
	Tue, 18 Jun 2024 16:05:29 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 07/13] gfs2: Fix and clean up function do_qc
Date: Tue, 18 Jun 2024 18:05:11 +0200
Message-ID: <20240618160517.901589-8-agruenba@redhat.com>
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

Function do_qc() is supposed to be conceptually simple: it alters the
current in-memory and on-disk quota change values for a given uid/gid by
a given delta.  If the on-disk record isn't defined yet, a new record is
created.  If the on-disk record exists and the resulting change value is
zero, there no longer is a need for that record and so the record is
deleted.  On top of that, some reference counting is involved when
creating and deleting records.

Currently, instead of doing the above, do_qc() alters the on-disk value
and then it sets the in-memory value to the on-disk value.  This is
incorrect when the on-disk value differs from the in-memory value.  The
two values are allowed to differ when quota changes are synced to the
global quota file.  Fix by changing both values by the same amount.

In addition, do_qc() currently gets confused when the delta value is 0.
It isn't supposed to be called that way, but that assumption isn't
mentioned and it makes the code harder to read.  Make the code more
explicit.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/quota.c | 34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
index 371fad7d64e7..29a69756cc32 100644
--- a/fs/gfs2/quota.c
+++ b/fs/gfs2/quota.c
@@ -702,32 +702,40 @@ static void do_qc(struct gfs2_quota_data *qd, s64 change)
 	mutex_lock(&sdp->sd_quota_mutex);
 	gfs2_trans_add_meta(ip->i_gl, qd->qd_bh);
 
-	if (!test_bit(QDF_CHANGE, &qd->qd_flags)) {
-		qc->qc_change = 0;
-		qc->qc_flags = 0;
-		if (qd->qd_id.type == USRQUOTA)
-			qc->qc_flags = cpu_to_be32(GFS2_QCF_USER);
-		qc->qc_id = cpu_to_be32(from_kqid(&init_user_ns, qd->qd_id));
-	}
+	/*
+	 * The QDF_CHANGE flag indicates that the slot in the quota change file
+	 * is used.  Here, we use the value of qc->qc_change when the slot is
+	 * used, and we assume a value of 0 otherwise.
+	 */
 
-	x = be64_to_cpu(qc->qc_change) + change;
-	qc->qc_change = cpu_to_be64(x);
+	x = 0;
+	if (test_bit(QDF_CHANGE, &qd->qd_flags))
+		x = be64_to_cpu(qc->qc_change);
+	x += change;
 
 	spin_lock(&qd_lock);
-	qd->qd_change = x;
+	qd->qd_change += change;
 	spin_unlock(&qd_lock);
 
-	if (!x) {
-		gfs2_assert_warn(sdp, test_bit(QDF_CHANGE, &qd->qd_flags));
+	if (!x && test_bit(QDF_CHANGE, &qd->qd_flags)) {
+		/* The slot in the quota change file becomes unused. */
 		clear_bit(QDF_CHANGE, &qd->qd_flags);
 		qc->qc_flags = 0;
 		qc->qc_id = 0;
 		slot_put(qd);
 		qd_put(qd);
-	} else if (!test_and_set_bit(QDF_CHANGE, &qd->qd_flags)) {
+	} else if (x && !test_bit(QDF_CHANGE, &qd->qd_flags)) {
+		/* The slot in the quota change file becomes used. */
+		set_bit(QDF_CHANGE, &qd->qd_flags);
 		qd_hold(qd);
 		slot_hold(qd);
+
+		qc->qc_flags = 0;
+		if (qd->qd_id.type == USRQUOTA)
+			qc->qc_flags = cpu_to_be32(GFS2_QCF_USER);
+		qc->qc_id = cpu_to_be32(from_kqid(&init_user_ns, qd->qd_id));
 	}
+	qc->qc_change = cpu_to_be64(x);
 
 	if (change < 0) /* Reset quiet flag if we freed some blocks */
 		clear_bit(QDF_QMSG_QUIET, &qd->qd_flags);
-- 
2.45.1

