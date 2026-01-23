Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD0B21CA13
	for <gfs2@lists.linux.dev>; Fri, 23 Jan 2026 15:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769182283; cv=none; b=rok/bXts8lDrUYxIOWjfUFLQktIn3omukc5G5U1uvU+fjLjoXzOsPQejlhpSqmI5x0+e1Fb7189sMYuOaKMAUFAqQvKIpCB5UPaM24AddFpnzh/fgd7zVBzWYKSziunx1Pxzr9r2gOblmypAh+dkbKNvmkUtaA9RPHfsZnR65eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769182283; c=relaxed/simple;
	bh=mBnwkN84fer3wlf+vfkPrcUS7HaoutrF45z0UxwgjI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=XVS2r6CrAhvA5ESxb7HZNRhx3YCBChbz2hCStR1U+mQxl3iOwH9gZVyKswWBO0GdqDWVJ/CQKOc+O/Ou7X3DFUjp+GLUqkNBlV57uDM/QxVRYv/6lG//vT8hCgpMwJrjKjQxUYc+LdFr4D6afQOsxEbnOSFxOdhTYt6qFtrDTrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Oj+Z0N97; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oj+Z0N97"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769182281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k0VvxG9s+nE9bAXP1fYyNXwt9ts9KqVAeS9i1OsccBk=;
	b=Oj+Z0N97PIj0wlwM19Grvupfe9Bnx90/HlEj1hJZaue9iskTzne5QcfOVhJrF3pUCvrkxG
	uooh5cHtCzDn/AwkzJephf3dJ1Ks/19Zw3NqX22Kp4wz8SK1tMw+p/pB1jddlwMallinTo
	OWJDvBb4Uudk1pC2HFUdYBCjMfSaUtw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-554-UKiC9TrMNLCCuvmlG5od8Q-1; Fri,
 23 Jan 2026 10:31:20 -0500
X-MC-Unique: UKiC9TrMNLCCuvmlG5od8Q-1
X-Mimecast-MFC-AGG-ID: UKiC9TrMNLCCuvmlG5od8Q_1769182279
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C6DF1193E8D6
	for <gfs2@lists.linux.dev>; Fri, 23 Jan 2026 15:31:19 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.52])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C914330002DF;
	Fri, 23 Jan 2026 15:31:18 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 08/13] gfs2: gfs2_chain_bio start sector fix
Date: Fri, 23 Jan 2026 16:30:58 +0100
Message-ID: <20260123153105.797382-9-agruenba@redhat.com>
In-Reply-To: <20260123153105.797382-1-agruenba@redhat.com>
References: <20260123153105.797382-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: v5Macsfn-fGMwg_Dq_m_07NLjz-k_z-X9VRJ9LcH5sI_1769182279
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Pass the start sector into gfs2_chain_bio(): the new bio isn't
necessarily contiguous with the previous one.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/lops.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
index c3317432a25b..879635ebddae 100644
--- a/fs/gfs2/lops.c
+++ b/fs/gfs2/lops.c
@@ -479,13 +479,13 @@ static void gfs2_jhead_process_page(struct gfs2_jdesc *jd, unsigned long index,
 }
 
 static struct bio *gfs2_chain_bio(struct bio *prev, unsigned int nr_iovecs,
-				  blk_opf_t opf)
+				  sector_t sector, blk_opf_t opf)
 {
 	struct bio *new;
 
 	new = bio_alloc(prev->bi_bdev, nr_iovecs, opf, GFP_NOIO);
 	bio_clone_blkg_association(new, prev);
-	new->bi_iter.bi_sector = bio_end_sector(prev);
+	new->bi_iter.bi_sector = sector;
 	bio_chain(new, prev);
 	submit_bio(prev);
 	return new;
@@ -548,7 +548,7 @@ int gfs2_find_jhead(struct gfs2_jdesc *jd, struct gfs2_log_header_host *head)
 					unsigned int blocks =
 						(PAGE_SIZE - off) >> bsize_shift;
 
-					bio = gfs2_chain_bio(bio, blocks,
+					bio = gfs2_chain_bio(bio, blocks, sector,
 							     REQ_OP_READ);
 					goto add_block_to_new_bio;
 				}
-- 
2.52.0

