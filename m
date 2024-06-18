Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A7C46521
	for <gfs2@lists.linux.dev>; Tue, 18 Jun 2024 16:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718726729; cv=none; b=FlU02uVdsXdmqX/Mj6IdtpsRjjr+ukiDP3+IXyetz/v3fSIuI/feNpRiVM2z5VzHukTYEEw5/V4wt68G+A3sZFIkgb1jWF90lA8zJ9urBLwLzc3Gk3MO5/JnJvu9vsV+oCfdy57E8XKEHs3rMdDAjW66APjtfhYdGRqfvS0ovu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718726729; c=relaxed/simple;
	bh=DXfB3mr1dKoaEmppHgLN4MWSkr69BZunG0AKjIJ6tPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CquSUvShh+EOWZJFUSq9y0LZqaysWzFyTUTsPrWPzoEN9TSgFefdxt08zNW07NaJ6pJVGx/eptbPG6X2zlPXbbeE2phQp8aAyn4cz2NLvqWGDj+Jk+3fmGjn8Akc+vzJDeFofE6X2w4ySWieKW0Yh+DqXzyMJsHq+6+wQsCQmkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ajyE6mHI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ajyE6mHI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718726726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s1iweP3t6ruBMZT0F77V/UuHn46vMmsPvZOnEn8PcaQ=;
	b=ajyE6mHIPVdJfZmXfjwa4FxN+i0tYdYSgt4xqof5e9qjI65tQ+pyP4fbYe/VAus3OgGsDl
	y4T9zs2mfLnJ//LEzwt3cov136hQiNBFMzI7irmMRi5ezjt+mvJYPAsaocpYZV4oM7Rjia
	Cncz/NolslcGMOig217simoPhkTbKF4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-611-N-2p2W29MPK_thATPLitAA-1; Tue,
 18 Jun 2024 12:05:24 -0400
X-MC-Unique: N-2p2W29MPK_thATPLitAA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2146319560B9
	for <gfs2@lists.linux.dev>; Tue, 18 Jun 2024 16:05:23 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.40])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1666E19560B2;
	Tue, 18 Jun 2024 16:05:21 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 02/13] gfs2: Check quota consistency on mount
Date: Tue, 18 Jun 2024 18:05:06 +0200
Message-ID: <20240618160517.901589-3-agruenba@redhat.com>
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

In gfs2_quota_init(), make sure that the per-node "quota_change%u" file
doesn't contain duplicate uids/gids.  Those duplicates would cause us to
acquire the glock corresponding to those ids repeatedly, which the glock
code doesn't allow.

When finding inconsistencies, we wipe them out and ignore them.  The
resulting quotas will likely be inconsistent, and running quotacheck(1)
is advised.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/quota.c | 37 +++++++++++++++++++++++++++++++------
 1 file changed, 31 insertions(+), 6 deletions(-)

diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
index d75eeb327060..2984eaafdf6f 100644
--- a/fs/gfs2/quota.c
+++ b/fs/gfs2/quota.c
@@ -1427,7 +1427,7 @@ int gfs2_quota_init(struct gfs2_sbd *sdp)
 		return error;
 
 	for (x = 0; x < blocks; x++) {
-		const struct gfs2_quota_change *qc;
+		struct gfs2_quota_change *qc;
 		unsigned int y;
 
 		if (!extlen) {
@@ -1443,10 +1443,10 @@ int gfs2_quota_init(struct gfs2_sbd *sdp)
 		if (gfs2_metatype_check(sdp, bh, GFS2_METATYPE_QC))
 			goto fail_brelse;
 
-		qc = (const struct gfs2_quota_change *)(bh->b_data + sizeof(struct gfs2_meta_header));
+		qc = (struct gfs2_quota_change *)(bh->b_data + sizeof(struct gfs2_meta_header));
 		for (y = 0; y < sdp->sd_qc_per_block && slot < sdp->sd_quota_slots;
 		     y++, slot++) {
-			struct gfs2_quota_data *qd;
+			struct gfs2_quota_data *old_qd, *qd;
 			s64 qc_change = be64_to_cpu(qc->qc_change);
 			u32 qc_flags = be32_to_cpu(qc->qc_flags);
 			enum quota_type qtype = (qc_flags & GFS2_QCF_USER) ?
@@ -1468,18 +1468,41 @@ int gfs2_quota_init(struct gfs2_sbd *sdp)
 			qd->qd_slot_ref = 1;
 
 			spin_lock(&qd_lock);
+			spin_lock_bucket(hash);
+			old_qd = gfs2_qd_search_bucket(hash, sdp, qc_id);
+			if (old_qd) {
+				fs_err(sdp, "Corruption found in quota_change%u"
+					    "file: duplicate identifier in "
+					    "slot %u\n",
+					    sdp->sd_jdesc->jd_jid, slot);
+
+				spin_unlock_bucket(hash);
+				spin_unlock(&qd_lock);
+				qd_put(old_qd);
+
+				gfs2_glock_put(qd->qd_gl);
+				kmem_cache_free(gfs2_quotad_cachep, qd);
+
+				/* zero out the duplicate slot */
+				lock_buffer(bh);
+				memset(qc, 0, sizeof(*qc));
+				mark_buffer_dirty(bh);
+				unlock_buffer(bh);
+
+				continue;
+			}
 			BUG_ON(test_and_set_bit(slot, sdp->sd_quota_bitmap));
 			list_add(&qd->qd_list, &sdp->sd_quota_list);
 			atomic_inc(&sdp->sd_quota_count);
-			spin_unlock(&qd_lock);
-
-			spin_lock_bucket(hash);
 			hlist_bl_add_head_rcu(&qd->qd_hlist, &qd_hash_table[hash]);
 			spin_unlock_bucket(hash);
+			spin_unlock(&qd_lock);
 
 			found++;
 		}
 
+		if (buffer_dirty(bh))
+			sync_dirty_buffer(bh);
 		brelse(bh);
 		dblock++;
 		extlen--;
@@ -1491,6 +1514,8 @@ int gfs2_quota_init(struct gfs2_sbd *sdp)
 	return 0;
 
 fail_brelse:
+	if (buffer_dirty(bh))
+		sync_dirty_buffer(bh);
 	brelse(bh);
 fail:
 	gfs2_quota_cleanup(sdp);
-- 
2.45.1

