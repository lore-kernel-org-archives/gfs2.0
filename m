Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82E646B91
	for <gfs2@lists.linux.dev>; Tue, 18 Jun 2024 16:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718726735; cv=none; b=ck71ebDq/sM6F76FmueHswojCRA3n2xgKxfOcj+U5VEJuIe6MgluzjmDWWLxJMV8TBuceYCuiSuU+W9Uca66iHAas/A0oNvpsCi3fZAR4Bo2FMJN3voPfWaiQfdWD3ShbFQQJ3dkvf+lYoEFfdZa3oow/vckCJWZLr6gDdqCtIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718726735; c=relaxed/simple;
	bh=TjAqWM0Do4hVxwTR81ulWq3m4RYPcKtGdErI7/Dqa4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SR5L56t9sQatanFvtzoF6YVBJM1iPtXxE53QRpIitSz2FNWNbQIU91nH7d7XDRKBmdfFWs84edRc2fA9xF70oeENBILX4MpTDUsIx+ehnkA59eag753n2NRdbgZvWIztSEwyS4WqOV4HKuaf/AgBvyr4gx1P5Nt7dtZGMO/Cpmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IkZgva3Y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IkZgva3Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718726732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6H4wrGCao7RP6cV1ABqKFBGen5VDDOVTCYQ8odMKScM=;
	b=IkZgva3YoP9afYsTatcIUv7bb7jVwmlce+33S8A2ClHwOVrXuNImPEjf2PKsWY2VynE92+
	3WCfiYG0vfOwr5Azxx6zCbl0F5B5Tumdx9bPLTDiLHwvpsJbNdsToeDHAwAAXW6LxFXvc3
	Gaep11IVbfQcRPKDSYw85trBedFs2G4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-250-11IULA5yMx2VIn1Y_R-q-Q-1; Tue,
 18 Jun 2024 12:05:30 -0400
X-MC-Unique: 11IULA5yMx2VIn1Y_R-q-Q-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1C2581955F32
	for <gfs2@lists.linux.dev>; Tue, 18 Jun 2024 16:05:28 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.40])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D4B211955E72;
	Tue, 18 Jun 2024 16:05:26 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 05/13] gfs2: Revert "ignore negated quota changes"
Date: Tue, 18 Jun 2024 18:05:09 +0200
Message-ID: <20240618160517.901589-6-agruenba@redhat.com>
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

Commit 4c6a08125f22 ("gfs2: ignore negated quota changes") skips quota
changes with qd_change == 0 instead of writing them back, which leaves
behind non-zero qd_change values in the affected slots.  The kernel then
assumes that those slots are unused, while the qd_change values on disk
indicate that they are indeed still in use.  The next time the
filesystem is mounted, those invalid slots are read in from disk, which
will cause inconsistencies.

Revert that commit to avoid filesystem corruption.

This reverts commit 4c6a08125f2249531ec01783a5f4317d7342add5.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/quota.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
index bbd66adaec3d..f0aaae07a598 100644
--- a/fs/gfs2/quota.c
+++ b/fs/gfs2/quota.c
@@ -470,17 +470,6 @@ static bool qd_grab_sync(struct gfs2_sbd *sdp, struct gfs2_quota_data *qd,
 	    qd->qd_sync_gen >= sync_gen)
 		return false;
 
-	/*
-	 * If qd_change is 0 it means a pending quota change was negated.
-	 * We should not sync it, but we still have a qd reference and slot
-	 * reference taken by gfs2_quota_change -> do_qc that need to be put.
-	 */
-	if (!qd->qd_change && test_and_clear_bit(QDF_CHANGE, &qd->qd_flags)) {
-		slot_put(qd);
-		qd_put(qd);
-		return false;
-	}
-
 	if (!lockref_get_not_dead(&qd->qd_lockref))
 		return false;
 
-- 
2.45.1

