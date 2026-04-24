Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6A141C6A
	for <gfs2@lists.linux.dev>; Fri, 24 Apr 2026 04:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777003650; cv=none; b=tJocyfQ1IxDnF1YRfzcRvtcv4IDYLGQrYiDj7U6JUGl7dkBldcclKGQJ9akN/3zXwin9qViKgBJDUqzHlEJyNdgoRfVjWwRzdQACsypUkeQTYzoJAcF4snke+/hSJsSuZ5IzelrYczGX8uihjGcABPFq1usCT+JFjrhxRPNLSug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777003650; c=relaxed/simple;
	bh=OSrfRAoSSYSXcrxQaAwYIGgyrwjGtp7UD1HVOTmMqTM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EZN2jyOAug2aBtmnlfzr4adjVd4h6TfcVNBW7JhQbdp+eTVf5dbs5BsbunbQucn4y+CZfNcci+EW7bBeiOso5Y+wvWrpsLeMd008TXS0RtNeYHcr3Ekb+koxsfvQYaHH2NxkuGKZx0zzgE9WIfBQ/FVo52DkxUYSpaqkUe67hoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.pku.edu.cn; spf=pass smtp.mailfrom=stu.pku.edu.cn; dkim=pass (1024-bit key) header.d=stu.pku.edu.cn header.i=@stu.pku.edu.cn header.b=X7GUBKdd; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.pku.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.pku.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=stu.pku.edu.cn header.i=@stu.pku.edu.cn header.b="X7GUBKdd"
Received: from localhost.localdomain (unknown [IPV6:240c:c001:1:2e07:80f7:50e8:7109:ab97])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3bf9301b1;
	Fri, 24 Apr 2026 12:07:15 +0800 (GMT+08:00)
From: Wxm-233 <2200013188@stu.pku.edu.cn>
To: agruenba@redhat.com,
	gfs2@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	Wxm-233 <2200013188@stu.pku.edu.cn>
Subject: [PATCH] gfs2: keep per-bio end_io when splitting journal head reads
Date: Fri, 24 Apr 2026 12:06:56 +0800
Message-ID: <20260424040656.1366-1-2200013188@stu.pku.edu.cn>
X-Mailer: git-send-email 2.45.2.windows.1
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9dbdaba30803a1kunm726cce9b2e45b
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaH0wfVhgYQ0MfGkpCHUkdTlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJT0sYQRhLS0pBSkFJHktMQUNLHUxBTkseQ0FMSktCQRoZQk
	xZV1kWGg8SFR0UWUFZT0tIVUpLSUhOQ0NVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
	b=X7GUBKddAgvlfqG1/cH/iwJlfGkfoROkafvoE3bcJmtIzschlOwV/ZKl0I/gfe1Np41A2DVZ+8wpwIgOvBOpOGkejALJZX0YkO0fXRlfdTU/C1PqZQGTSswYQiAVH+vxqAfD7/QVG1u7wA/qJGu2XnCvN/6A+Kx5JE85ukqnEI4=; c=relaxed/relaxed; s=default; d=stu.pku.edu.cn; v=1;
	bh=9KJPtjao3PZB+rhi1RvsN6oGksFrGlxqTnMxud0d6P8=;
	h=date:mime-version:subject:message-id:from;

gfs2_find_jhead() can split a folio across two bios when part of the
folio is already queued in the current bio and the remaining blocks
need a new bio.

That split path currently calls bio_chain(new, prev).  But journal read
bios need to retain gfs2_end_log_read() and bi_private so that each bio
completes its own folios with folio_end_read().  Replacing the new
bio's completion handler with the block layer chaining callback breaks
that expectation, and fuzzing workloads can hit a BUG in bio_chain()
on this path.

Keep the per-bio completion state for the new bio and only submit the
previous bio.

Signed-off-by: Wxm-233 <2200013188@stu.pku.edu.cn>
---
 fs/gfs2/lops.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
index 6586963..3d0fad3 100644
--- a/fs/gfs2/lops.c
+++ b/fs/gfs2/lops.c
@@ -481,12 +481,16 @@ static void gfs2_jhead_process_page(struct gfs2_jdesc *jd, unsigned long index,
 static struct bio *gfs2_chain_bio(struct bio *prev, unsigned int nr_iovecs,
 				  sector_t sector, blk_opf_t opf)
 {
+	bio_end_io_t *end_io = prev->bi_end_io;
+	void *private = prev->bi_private;
 	struct bio *new;
 
 	new = bio_alloc(prev->bi_bdev, nr_iovecs, opf, GFP_NOIO);
 	bio_clone_blkg_association(new, prev);
 	new->bi_iter.bi_sector = sector;
-	bio_chain(new, prev);
+	/* Each journal read bio must complete its own folios. */
+	new->bi_end_io = end_io;
+	new->bi_private = private;
 	submit_bio(prev);
 	return new;
 }
-- 
2.45.2.windows.1

