Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF3146B91
	for <gfs2@lists.linux.dev>; Tue, 18 Jun 2024 16:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718726731; cv=none; b=NkMSIsHMeGk9Q0695n6y/qyn89/sAOorueUjKrvtaBbpQ2hzyIHUqnIy7E5XiFfWdWLZbNCbm1h55Cdl8nt8b0TIrzU1irXB5ELKhQak9JAnm/xtN+PIwi2oqoQQfy7SgdsE+HS+Q0inOGfoWBOFZSzfZPTLcmMkcRUqcsZkQDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718726731; c=relaxed/simple;
	bh=ETMD4uLRZdXVyeyeAX3AR0Tp4VwKUXz220neDtMo5ms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uHSJ6KdRmZ978o2opB7OTw0r9VYcGOQorOJlhKTE0hAhOlqrAR2LN+jfJYr0U9X5cK7GecerZLTUJLt9gxg+F206bimMrrkVLbVuLBdCRaEPGBNfu0G681vt4Kga0P/X/YP+icCQi15GcktxDnpisDLCMa4JFSvpFRwUEIXY5fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hhrT7jLE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hhrT7jLE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718726728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OJuMaU4/l7cpP3cwu/2t5YBraYmGfhv6eouP04n0QZk=;
	b=hhrT7jLENl99GhJ3UE9In0Cf3a2/CIz5zkYcp9Bda7K7Y83ChT9wLPLsp96yg8z1O4QpEj
	NVwpBSkUBKs0fzw2uPHWrQKma2HpDy2P6KKa3thZdev28dv6vA57REN+LHybSgvp25z9rC
	WbU23F2OxFgEGk4l3y6lnPmAiSlj0ZY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-439-KYAyOWZsMQK0VDNHSu9lmw-1; Tue,
 18 Jun 2024 12:05:26 -0400
X-MC-Unique: KYAyOWZsMQK0VDNHSu9lmw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9F2491956051
	for <gfs2@lists.linux.dev>; Tue, 18 Jun 2024 16:05:24 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.40])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 823CB19560B2;
	Tue, 18 Jun 2024 16:05:23 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 03/13] gfs2: Revert "introduce qd_bh_get_or_undo"
Date: Tue, 18 Jun 2024 18:05:07 +0200
Message-ID: <20240618160517.901589-4-agruenba@redhat.com>
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

The qd_bh_get_or_undo() helper introduced by that commit doesn't improve
the code much, so revert it and clean things up in a more useful way in
the next commit.

This reverts commit 7dbc6ae60dd7089d8ed42892b6a66c138f0aa7a0.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/quota.c | 36 +++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
index 2984eaafdf6f..e0840b412d28 100644
--- a/fs/gfs2/quota.c
+++ b/fs/gfs2/quota.c
@@ -491,20 +491,6 @@ static int qd_check_sync(struct gfs2_sbd *sdp, struct gfs2_quota_data *qd,
 	return 1;
 }
 
-static int qd_bh_get_or_undo(struct gfs2_sbd *sdp, struct gfs2_quota_data *qd)
-{
-	int error;
-
-	error = bh_get(qd);
-	if (!error)
-		return 0;
-
-	clear_bit(QDF_LOCKED, &qd->qd_flags);
-	slot_put(qd);
-	qd_put(qd);
-	return error;
-}
-
 static int qd_fish(struct gfs2_sbd *sdp, struct gfs2_quota_data **qdp)
 {
 	struct gfs2_quota_data *qd = NULL, *iter;
@@ -527,12 +513,17 @@ static int qd_fish(struct gfs2_sbd *sdp, struct gfs2_quota_data **qdp)
 	spin_unlock(&qd_lock);
 
 	if (qd) {
-		error = qd_bh_get_or_undo(sdp, qd);
-		if (error)
+		error = bh_get(qd);
+		if (error) {
+			clear_bit(QDF_LOCKED, &qd->qd_flags);
+			slot_put(qd);
+			qd_put(qd);
 			return error;
-		*qdp = qd;
+		}
 	}
 
+	*qdp = qd;
+
 	return 0;
 }
 
@@ -1189,8 +1180,15 @@ void gfs2_quota_unlock(struct gfs2_inode *ip)
 		if (!found)
 			continue;
 
-		if (!qd_bh_get_or_undo(sdp, qd))
-			qda[count++] = qd;
+		gfs2_assert_warn(sdp, qd->qd_change_sync);
+		if (bh_get(qd)) {
+			clear_bit(QDF_LOCKED, &qd->qd_flags);
+			slot_put(qd);
+			qd_put(qd);
+			continue;
+		}
+
+		qda[count++] = qd;
 	}
 
 	if (count) {
-- 
2.45.1

