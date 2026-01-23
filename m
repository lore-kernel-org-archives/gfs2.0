Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D6E22F75E
	for <gfs2@lists.linux.dev>; Fri, 23 Jan 2026 15:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769182281; cv=none; b=ftrLxl443+2rm0n1dYwZD4ikGCACLuf09lyx65koln+/t5++xxpFtmzJ35upWiwsImpZOOmMy/VDPvOrgX955tSKXBnGNMwU0hnSIxfW/ii2JXT2436behnL66UDeEOh0c8qkmyl6wjC+G45/+71D1TwunnC5A52iKzwHKYQ+Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769182281; c=relaxed/simple;
	bh=w2JiCUhmvRT8ZQZxwuaTFt0UtjH6jhCGJVP322DS2Fo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WtgtGCGLu14vpaoCvpV4Vfwa8Q8a/K0CG4Vultf2hX6We50Mz95nxSpeGlba1lQiT4Moz4v2HNeyqTAxIxkkBxOVYZsVxIFsNK8JqrUlmrhNz0sgu4HWim4VYmUJxlz4xJSjTYP7bZFcjobQyY9skeE/rqZWXce/C4BsuTxwwlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V5ws3wEQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V5ws3wEQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769182279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MymNL/nYeDWvomO79oTb7U4puYKN2dbfH+nTeBxlP5Q=;
	b=V5ws3wEQGCLLvCHxjtQY3p+PXIySd3FboJY1LgHzGkWFz8Bz3iHP+qtzJ4kczoAqs2I28B
	YVLcHxZ8KsKOXUsIkdXBCwYifbuh2ROkEFnjGJ3QXo6uSluYIQNcpLVJRAIIHdgzWY+0o5
	pzmNUl3rfuTsm6zVshOC1h8qFsQ6jGk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-8LOpjD06NHmEqrGi9fP1uA-1; Fri,
 23 Jan 2026 10:31:16 -0500
X-MC-Unique: 8LOpjD06NHmEqrGi9fP1uA-1
X-Mimecast-MFC-AGG-ID: 8LOpjD06NHmEqrGi9fP1uA_1769182275
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 512861955D9F;
	Fri, 23 Jan 2026 15:31:15 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.52])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1A5C830002D1;
	Fri, 23 Jan 2026 15:31:13 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH 05/13] Revert "gfs2: Fix use of bio_chain"
Date: Fri, 23 Jan 2026 16:30:55 +0100
Message-ID: <20260123153105.797382-6-agruenba@redhat.com>
In-Reply-To: <20260123153105.797382-1-agruenba@redhat.com>
References: <20260123153105.797382-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

This reverts commit 8a157e0a0aa5143b5d94201508c0ca1bb8cfb941.

That commit incorrectly assumed that the bio_chain() arguments were
swapped in gfs2.  However, gfs2 intentionally constructs bio chains so
that the first bio's bi_end_io callback is invoked when all bios in the
chain have completed, unlike bio chains where the last bio's callback is
invoked.

Fixes: 8a157e0a0aa5 ("gfs2: Fix use of bio_chain")
Cc: stable@vger.kernel.org
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/lops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
index 97ebe457c00a..d27a0b1080a9 100644
--- a/fs/gfs2/lops.c
+++ b/fs/gfs2/lops.c
@@ -484,7 +484,7 @@ static struct bio *gfs2_chain_bio(struct bio *prev, unsigned int nr_iovecs)
 	new = bio_alloc(prev->bi_bdev, nr_iovecs, prev->bi_opf, GFP_NOIO);
 	bio_clone_blkg_association(new, prev);
 	new->bi_iter.bi_sector = bio_end_sector(prev);
-	bio_chain(prev, new);
+	bio_chain(new, prev);
 	submit_bio(prev);
 	return new;
 }
-- 
2.52.0

