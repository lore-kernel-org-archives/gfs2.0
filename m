Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A45F390C89
	for <gfs2@lists.linux.dev>; Wed, 26 Aug 2026 06:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787724862; cv=none; b=nVJQuRXI0ElDUqIRVF+eYdJ7JG8I2AZoPNPkEdgMoTtxBTQXCGpLjh2jJHw/SZaTbj8aA70YvVwxZh5Lzp92AnEXW02Cs9wbHASJhqp+Q/XUHz6reLFdCASXx0sP+Krso9+XiuPOmKwhNXKKT3dor1ej0rUjGcXbl0Bak1qyrYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787724862; c=relaxed/simple;
	bh=rYv65aHzJx7zpsHNKefen4yv3ZXwkoOdogAEAqvc2YA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XZaSFOKOzmVB2y9IyqvSogjI7pemVEQ/59xpGgnX/hw/EWsBrtcW7YoIS6Krn+RZuwfC1HV3WSQEYwzx2JFmDDos2aXn6lDHfmfX1NrZt/WAjHU89lxRjdWiupIcC+Ecdu4fpUYTJVRSWjfrEqSnnfmZ2iP9wi7uYCLFvVcBgmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 5cd8ed06a11511f19a56ed5b684f684d-20260826
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:84a169bb-9a61-42ac-b7ff-b03e29d6821c,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:4d4de799795018303924e1e098e3d0e4,BulkI
	D:nil,BulkQuantity:0,SF:102|850|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:n
	il,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LE
	S:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 5cd8ed06a11511f19a56ed5b684f684d-20260826
X-User: zenghongling@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zenghongling@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 2030714239; Wed, 26 Aug 2026 14:14:14 +0800
From: Hongling Zeng <zenghongling@kylinos.cn>
To: agruenba@redhat.com
Cc: gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	zhongling0719@126.com,
	Hongling Zeng <zenghongling@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH] gfs2: validate file type in glockfd iterator
Date: Wed, 26 Aug 2026 14:14:10 +0800
Message-Id: <20260826061410.1378510-1-zenghongling@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The gfs2_glockfd_seq_show_flock() function assumes all file descriptors
with inodes on the GFS2 superblock have file->private_data pointing to
struct gfs2_file. This is incorrect for:

- O_PATH files: private_data is NULL
- Special files (FIFO, socket, device): private_data points to
  different structures

The glockfd iterator only checks that the inode's superblock matches,
which allows these files to pass through. This can lead to NULL pointer
dereference or invalid private_data access when accessing private_data.

Add an f_op check so we only process files using gfs2_file_fops before
accessing private_data.

Fixes: 56535dc695f8 ("gfs2: Add flocks to glockfd debugfs file")
Cc: stable@vger.kernel.org
Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
---
 fs/gfs2/glock.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index d59ea71a84db..b210c97cde45 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -2562,10 +2562,16 @@ static void gfs2_glockfd_seq_stop(struct seq_file *seq, void *iter_ptr)
 static void gfs2_glockfd_seq_show_flock(struct seq_file *seq,
 					struct gfs2_glockfd_iter *i)
 {
-	struct gfs2_file *fp = i->file->private_data;
-	struct gfs2_holder *fl_gh = &fp->f_fl_gh;
+	struct gfs2_file *fp;
+	struct gfs2_holder *fl_gh;
 	struct lm_lockname gl_name = { .ln_type = LM_TYPE_RESERVED };
 
+	if (i->file->f_op != &gfs2_file_fops)
+		return;
+
+	fp = i->file->private_data;
+	fl_gh = &fp->f_fl_gh;
+
 	if (!READ_ONCE(fl_gh->gh_gl))
 		return;
 
-- 
2.25.1

