Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51609277CB8
	for <gfs2@lists.linux.dev>; Sat,  1 Nov 2025 08:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761984580; cv=none; b=VYDoradooZOzqaI78WhJLwXJUOWW1tcIH8VmjCm95AUsdLuDe9P7vn1F3HZpkj0vAbRLnGRDeW9nUeJyvfWvTp1MOLZaDD5s3SNEvWJs/aO4lx42yXNmZMS7Exuy63Qjy4VVpHVxRFO1vfMwwTIjptnkZxfxrkjE2ib2+US3tZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761984580; c=relaxed/simple;
	bh=NTubLnvrfYxlsp2gxaNPv6OO2rMv2OpGp9sUstBF/bM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ct0c03ZD7uhSY+XRp/+C+y0MIZpL57CstmNYMgiJmpehDHYu12BJfIs2H0axesce/GGonZj1n7SMFq2nXBOw4PqC933+u6lTm3Z4g8lKMntbma+FJBTu74PJs0NY+N6VgiqS1WvI51fWztpxTNiGN1e1KeI/0pI2wIAdXrGQwEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iakLeiHb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iakLeiHb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761984578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mkskNvYUh9HdYNFvmlsAmpRbct+L4i8noxGDKwwLkkw=;
	b=iakLeiHbTLal8nGM6AsISnN8d0cfys/TyG5hZtYGwmbIi5lKkHH0P6god8USJkDVvhvFI4
	s6cpDhDuGzf2PrNbaqXQMUXidSMZEOHknU5A6Gh5wROYJwwkoYKzd/hBcUuSzSrrHB6ShI
	x6WJzxst0bMKNcAMjsiyZX/Gx+bCcXw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-610-t5QzrkyAOCWKT32J37GkQQ-1; Sat,
 01 Nov 2025 04:09:33 -0400
X-MC-Unique: t5QzrkyAOCWKT32J37GkQQ-1
X-Mimecast-MFC-AGG-ID: t5QzrkyAOCWKT32J37GkQQ_1761984572
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 185BF19560B5;
	Sat,  1 Nov 2025 08:09:32 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.12])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 82C6719560A2;
	Sat,  1 Nov 2025 08:09:29 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev,
	Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 4/5] gfs2: Enable non-blocking lookup in gfs2_permission
Date: Sat,  1 Nov 2025 08:09:18 +0000
Message-ID: <20251101080919.1290117-5-agruenba@redhat.com>
In-Reply-To: <20251101080919.1290117-1-agruenba@redhat.com>
References: <20251101080919.1290117-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Under MAY_NOT_BLOCK, we consider the cached permissions "good enough" if
the glock still appears to be held.

Reviewed-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/inode.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index 3d87ecd277a1..af38676a408f 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -1955,14 +1955,14 @@ int gfs2_permission(struct mnt_idmap *idmap, struct inode *inode,
 	gfs2_holder_mark_uninitialized(&i_gh);
 	ip = GFS2_I(inode);
 	gl = rcu_dereference_check(ip->i_gl, !may_not_block);
-	if (unlikely(!gl)) {
-		/* inode is getting torn down, must be RCU mode */
-		WARN_ON_ONCE(!may_not_block);
-		return -ECHILD;
-        }
-	if (gfs2_glock_is_locked_by_me(gl) == NULL) {
-		if (may_not_block)
+	if (may_not_block) {
+		/* Is the inode getting torn down? */
+		if (unlikely(!gl))
 			return -ECHILD;
+		if (gl->gl_state == LM_ST_UNLOCKED ||
+		    test_bit(GLF_INSTANTIATE_NEEDED, &gl->gl_flags))
+			return -ECHILD;
+	} else if (gfs2_glock_is_locked_by_me(gl) == NULL) {
 		error = gfs2_glock_nq_init(gl, LM_ST_SHARED, LM_FLAG_ANY, &i_gh);
 		if (error)
 			return error;
-- 
2.51.0

