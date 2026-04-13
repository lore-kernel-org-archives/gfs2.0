Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EEB73CCFB5
	for <gfs2@lists.linux.dev>; Mon, 13 Apr 2026 14:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776091961; cv=none; b=NymsPo9SptohEB3XB3hCGcuxp5DOhV2ZSRJqW8omIslGbD+xF+kU+GTH1m5ds5gGtdp3hyY6/Xwj5MLXtMeB6ZakILAfwpTT2zq6jog+9EO1859ZCgRCLcWy5c92gJzd2ClR1XVmYIxFS68vTrEKHcbN1/51IYdUY7fm5CvtsXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776091961; c=relaxed/simple;
	bh=Wba1hFI3PGwWy5I7+oXG3vV76q2wvDP05zIDzXVpQpI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=q2nzU6pINPA40wB1QHlfmXfNvgyN4UPo1Xv4aHiGp3Ycmc0P2JZCLdoTY2M6tVwn3GJtc3hHTKdpabUkvAv1bSb+bgJHe65oJp6m7U9I2/1RngE5HNpc6ZfBf6gZn8Uc2jkvYh5G67TE+03GB5mEuTRU+1lOeNauwz3vlaCFoak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TBhKS2Ny; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TBhKS2Ny"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776091959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PNMXYJ3T/RVZCsekQuTrpSMuoh7fnJllZdVHtZC46IA=;
	b=TBhKS2Ny08qpHQK7c3q+/rKhfjbzL4ZBQogxgOKRc0xcADwWV9rKJGnuAM4STX6BrlaHt2
	DonFlOwVvMLXmn6koJ3yXJUnlbF6L+66z88hmeLd6ykdJdvhXoJhJlnovQu97lKKU7lfg5
	9LHTNGXYJeuCFWz3nZk48sfvW3hrWjA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-351-VUsOuNPGPKyWxuIzoiTLOg-1; Mon,
 13 Apr 2026 10:52:37 -0400
X-MC-Unique: VUsOuNPGPKyWxuIzoiTLOg-1
X-Mimecast-MFC-AGG-ID: VUsOuNPGPKyWxuIzoiTLOg_1776091956
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 740341800BEB
	for <gfs2@lists.linux.dev>; Mon, 13 Apr 2026 14:52:36 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.44.32.156])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 807FB19560AB;
	Mon, 13 Apr 2026 14:52:35 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 15/18] gfs2: inode directory consistency checks
Date: Mon, 13 Apr 2026 16:52:08 +0200
Message-ID: <20260413145211.881752-16-agruenba@redhat.com>
In-Reply-To: <20260413145211.881752-1-agruenba@redhat.com>
References: <20260413145211.881752-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dH1dah8uV9DgV8Ogt44GRIlweMIgM1J9qvc926EglvM_1776091956
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

In gfs2_dinode_in(), only allow directories to have the GFS2_DIF_EXHASH
flag set.  This will prevent other parts of the code from treating
regular inodes as directories based on the presence of that flag.

In sweep_bh_for_rgrps() and __gfs2_free_blocks(), check if the
GFS2_DIF_EXHASH flag is set instead of checking if i_depth is non-zero.
This matches what the directory code does.  (The i_depth checks were
introduced in commit 6d3117b412951 ("GFS2: Wipe directory hash table
metadata when deallocating a directory").)

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/bmap.c  | 2 +-
 fs/gfs2/glops.c | 5 +++++
 fs/gfs2/rgrp.c  | 2 +-
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index fdcac8e3f2ba..89b043f70651 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -1539,7 +1539,7 @@ static int sweep_bh_for_rgrps(struct gfs2_inode *ip, struct gfs2_holder *rd_gh,
 			revokes = jblocks_rqsted;
 			if (meta)
 				revokes += end - start;
-			else if (ip->i_depth)
+			else if (ip->i_diskflags & GFS2_DIF_EXHASH)
 				revokes += sdp->sd_inptrs;
 			ret = gfs2_trans_begin(sdp, jblocks_rqsted, revokes);
 			if (ret)
diff --git a/fs/gfs2/glops.c b/fs/gfs2/glops.c
index aff7e890bf60..28f32424ee64 100644
--- a/fs/gfs2/glops.c
+++ b/fs/gfs2/glops.c
@@ -457,6 +457,11 @@ static int gfs2_dinode_in(struct gfs2_inode *ip, const void *buf)
 	ip->i_depth = (u8)depth;
 	ip->i_entries = be32_to_cpu(str->di_entries);
 
+	if (!S_ISDIR(inode->i_mode) && (ip->i_diskflags & GFS2_DIF_EXHASH)) {
+		gfs2_consist_inode(ip);
+		return -EIO;
+	}
+
 	if (gfs2_is_stuffed(ip) && inode->i_size > gfs2_max_stuffed_size(ip)) {
 		gfs2_consist_inode(ip);
 		return -EIO;
diff --git a/fs/gfs2/rgrp.c b/fs/gfs2/rgrp.c
index 8a97ca734afc..7ada7707e99a 100644
--- a/fs/gfs2/rgrp.c
+++ b/fs/gfs2/rgrp.c
@@ -2529,7 +2529,7 @@ void __gfs2_free_blocks(struct gfs2_inode *ip, struct gfs2_rgrpd *rgd,
 	rgrp_unlock_local(rgd);
 
 	/* Directories keep their data in the metadata address space */
-	if (meta || ip->i_depth || gfs2_is_jdata(ip))
+	if (meta || (ip->i_diskflags & GFS2_DIF_EXHASH) || gfs2_is_jdata(ip))
 		gfs2_journal_wipe(ip, bstart, blen);
 }
 
-- 
2.53.0

