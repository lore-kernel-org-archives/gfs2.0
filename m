Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2A4482EE
	for <gfs2@lists.linux.dev>; Tue, 18 Jun 2024 16:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718726727; cv=none; b=RYgUbuE9P9z8ix9z37qS9d3RMcK01U//uWvlo0WQHb0ApqNrHAD4cC+aTtlaelR90+xdMm+v9RZMe76o5eADO9rsGvNWQ518hQIB0vBUCawjF+JDi7pGVqx6zPAbNZ/09xLC0JLYh3qESIRktuArPM83QqdwUGVq0D2kIhqG3bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718726727; c=relaxed/simple;
	bh=uuG2+PNALefd+dyz+Gcx53bbsvr+qqx01duFrm7fnn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KEVirGel7xYWiGtEiDg7PyeJC0Z5zUs5UfMvRchOWMNOhsNoXoWZLLU62th5XKoGfkkwLt+/WcxIAAJmnW7qZFB29WF+1b0oEaVlRSoeTduQMq51GSA0KF9SWHBWZ4ZCwzWbyNejPVVCw5tjkJl5iIBcMJl9yCqaupz9e4SyPdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QItyeLTM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QItyeLTM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718726724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6X3b50idwlTcDgJ0HZ9Ip8UdK/R2Ff/hMZcALjhiEfc=;
	b=QItyeLTMQftoIzeTV5I8n0apLi/jOl/mbDZwDyDTokaMcXHPIRGX0NmrbkwAwQjf+fQI12
	yWu5RUQzxByAZ3dCccmElU5koHRVePl2yGGoFsfm+hOhiPuwO2e4imzsmNe/j0h1U5eb96
	1+PCrGKJcwn5k6gwEzdDDUqBZ0Cc6G0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-621-3jbMZ7pzOaG5mJksZHwB4Q-1; Tue,
 18 Jun 2024 12:05:22 -0400
X-MC-Unique: 3jbMZ7pzOaG5mJksZHwB4Q-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 944B61955F2B
	for <gfs2@lists.linux.dev>; Tue, 18 Jun 2024 16:05:21 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.40])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9495E19560B2;
	Tue, 18 Jun 2024 16:05:20 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 01/13] gfs2: Minor gfs2_quota_init error path cleanup
Date: Tue, 18 Jun 2024 18:05:05 +0200
Message-ID: <20240618160517.901589-2-agruenba@redhat.com>
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

Add a fail_brelse label and use it where useful.  Move variable bh out
of the loop to extend its visibility to the new label.  No functional
change.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/quota.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
index aa9cf0102848..d75eeb327060 100644
--- a/fs/gfs2/quota.c
+++ b/fs/gfs2/quota.c
@@ -1407,6 +1407,7 @@ int gfs2_quota_init(struct gfs2_sbd *sdp)
 	unsigned int found = 0;
 	unsigned int hash;
 	unsigned int bm_size;
+	struct buffer_head *bh;
 	u64 dblock;
 	u32 extlen = 0;
 	int error;
@@ -1426,7 +1427,6 @@ int gfs2_quota_init(struct gfs2_sbd *sdp)
 		return error;
 
 	for (x = 0; x < blocks; x++) {
-		struct buffer_head *bh;
 		const struct gfs2_quota_change *qc;
 		unsigned int y;
 
@@ -1440,10 +1440,8 @@ int gfs2_quota_init(struct gfs2_sbd *sdp)
 		bh = gfs2_meta_ra(ip->i_gl, dblock, extlen);
 		if (!bh)
 			goto fail;
-		if (gfs2_metatype_check(sdp, bh, GFS2_METATYPE_QC)) {
-			brelse(bh);
-			goto fail;
-		}
+		if (gfs2_metatype_check(sdp, bh, GFS2_METATYPE_QC))
+			goto fail_brelse;
 
 		qc = (const struct gfs2_quota_change *)(bh->b_data + sizeof(struct gfs2_meta_header));
 		for (y = 0; y < sdp->sd_qc_per_block && slot < sdp->sd_quota_slots;
@@ -1461,10 +1459,8 @@ int gfs2_quota_init(struct gfs2_sbd *sdp)
 
 			hash = gfs2_qd_hash(sdp, qc_id);
 			qd = qd_alloc(hash, sdp, qc_id);
-			if (qd == NULL) {
-				brelse(bh);
-				goto fail;
-			}
+			if (qd == NULL)
+				goto fail_brelse;
 
 			set_bit(QDF_CHANGE, &qd->qd_flags);
 			qd->qd_change = qc_change;
@@ -1494,6 +1490,8 @@ int gfs2_quota_init(struct gfs2_sbd *sdp)
 
 	return 0;
 
+fail_brelse:
+	brelse(bh);
 fail:
 	gfs2_quota_cleanup(sdp);
 	return error;
-- 
2.45.1

