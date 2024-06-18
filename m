Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495EB482EE
	for <gfs2@lists.linux.dev>; Tue, 18 Jun 2024 16:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718726737; cv=none; b=PhhdJj8W7fPlJMljgKuZbppn4OF9XpwZTh5U6DEoKgfacoC08hVK3pnOmtN3V2JjzppZJe0wcC4TSrpuaZtB2z5ftB+F90Qz1sJR2CDRNKfl/PewW+tj+JTkerTZySY9bDTL8diMR6n13I6MuZ+q3bZvWStR97+A4PAL+YA/pWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718726737; c=relaxed/simple;
	bh=08KZziaDj4FYIfySckOjeDQA2I2UtszHhSbvglVkPn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jr9DX6o877ZCBOB2YEVVr6By7zAIALLvgDK++JPeY9dIO0esRYYP3ALROn0mwb4GM3c9PiOqeJOqAQbJcgCtvC1PrAvj40gfN0pd4pUFGmdVYNcZfWQJSjcQ8dEDRrx40CPWxcBz2OUf2XNAt/rA4/nePtdbHuXfx1UxmZoP17Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JZhHoqw+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JZhHoqw+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718726735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mnz+IV9CyUcYV8qMqeYxuwDrwLQyXMf1dmKymoNx47U=;
	b=JZhHoqw+tVQPlYW6y1TPbrbmBeaztKrS8d4NhanLfDCMLJA4WLFufWpZ4RIMbZb4/VeRXS
	L9MzqRhOz9I10HRucXPARxyun+WHqMGSyllfBlasynN35/QHST7koyI8KX957Y3tBiacO1
	X21Um05TYO/GPMyBQyOphnVBgPKRtoQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-472-DrjH2lGjPRiOADbtERNloA-1; Tue,
 18 Jun 2024 12:05:33 -0400
X-MC-Unique: DrjH2lGjPRiOADbtERNloA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2E3381956088
	for <gfs2@lists.linux.dev>; Tue, 18 Jun 2024 16:05:32 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.40])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2E11019560B2;
	Tue, 18 Jun 2024 16:05:30 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 08/13] gfs2: quota need_sync cleanup
Date: Tue, 18 Jun 2024 18:05:12 +0200
Message-ID: <20240618160517.901589-9-agruenba@redhat.com>
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

Rename variable 'value' to 'change' as it stores a change in value.

Add new 'value' and 'limit' variables for the current value and limit.

Only fetch the tuning parameters when we need them.

Get rid of unnecessary nesting.

No change in functionality.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/quota.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
index 29a69756cc32..11bd16d8f81c 100644
--- a/fs/gfs2/quota.c
+++ b/fs/gfs2/quota.c
@@ -1117,34 +1117,32 @@ static bool need_sync(struct gfs2_quota_data *qd)
 {
 	struct gfs2_sbd *sdp = qd->qd_sbd;
 	struct gfs2_tune *gt = &sdp->sd_tune;
-	s64 value;
+	s64 value, change, limit;
 	unsigned int num, den;
 
 	if (!qd->qd_qb.qb_limit)
 		return false;
 
 	spin_lock(&qd_lock);
-	value = qd->qd_change;
+	change = qd->qd_change;
 	spin_unlock(&qd_lock);
 
+	if (change <= 0)
+		return false;
+	value = (s64)be64_to_cpu(qd->qd_qb.qb_value);
+	limit = (s64)be64_to_cpu(qd->qd_qb.qb_limit);
+	if (value >= limit)
+		return false;
+
 	spin_lock(&gt->gt_spin);
 	num = gt->gt_quota_scale_num;
 	den = gt->gt_quota_scale_den;
 	spin_unlock(&gt->gt_spin);
 
-	if (value <= 0)
-		return false;
-	else if ((s64)be64_to_cpu(qd->qd_qb.qb_value) >=
-		 (s64)be64_to_cpu(qd->qd_qb.qb_limit))
+	change *= gfs2_jindex_size(sdp) * num;
+	change = div_s64(change, den);
+	if (value + change < limit)
 		return false;
-	else {
-		value *= gfs2_jindex_size(sdp) * num;
-		value = div_s64(value, den);
-		value += (s64)be64_to_cpu(qd->qd_qb.qb_value);
-		if (value < (s64)be64_to_cpu(qd->qd_qb.qb_limit))
-			return false;
-	}
-
 	return true;
 }
 
-- 
2.45.1

