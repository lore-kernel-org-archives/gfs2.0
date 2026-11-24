Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.139.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795554274;
	b=J/JT3CD86ueSp1iMhiS0lTMFk9u4KKDIgAGl+HSniBnkBa/mpvXNbKhD8V2AhWw0RVa/
	 HROLBbdVS1FB7lVh6nAUWM9IPxOTjilSo7cXLikPtfUyGC+hI/jC8LaNLoM/LbzLzb29X
	 2Irhn/EvpTQXhYJ0T0SHtKMT30IMjKWUZDCUQCR232IegN+5+BSoP75xWzKAMTkrdelwy
	 +J7enPTd8jj8k+AK13Ax8wPQ45AD8ZeeMKqgu/HiJxuxzbMNuS+WhGhwgkuHB6FDJ5l9j
	 3AltBhQ8bEUwcxmLooN+dx+iWSLQTxAPhz/VGhOy3fz/9Tv/B2p7sVQdloXT+4xhsaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795554274;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=ehoHHwwhO+SOqHm1ETZN2i9roC6iAhoxJvRnhkD8HmA=;
	b=HQ6ZS6Q+Z6xYt9Sjh2PCSpN6VZd3YlJES6ef28mwqNZT27LXlipCDFSGeX3cxJC4cmAG
	 9n3bwfDQzbJNDqHjlNtonkxXOCPbc5x+wToJRC/wKZ7TMcPUGGpgZqob9hmKXmB818Iou
	 TBKRQHq+IpIroANsdmla9jHuaE3ePsJ3+avpU4TqfmD9UXGnzN6rptv8cMKw5VRyKuUuu
	 B36z02q2eqt9AJe0posigFjhFlmI4TFaTRFwa7YbZZs0Jj39rzdQunlz05MR5F+AAAdrj
	 hZJMJuSnhO1eMpmAOZV6O97aX//dydyf/vOlaNtBMdSPtiApjwkeYfAOP1ppIsQsWNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=G23IbbtZ;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=5CTyT3Mw;
	arc=none smtp.remote-ip=148.163.139.74
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F496606A332
	for <gfs2@lists.linux.dev>; Tue, 24 Nov 2026 21:04:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F496606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=G23IbbtZ;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=5CTyT3Mw
Received: from pps.filterd (m0167074.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AOKaQvh3256492
	for <gfs2@lists.linux.dev>; Tue, 24 Nov 2026 16:04:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=ehoH
	HwwhO+SOqHm1ETZN2i9roC6iAhoxJvRnhkD8HmA=; b=G23IbbtZreMQ79CHd6xU
	W9YRl5E3SSxzj4gpb0ob8J9G8tIXaibQ7MPHYqWahqmETs05RJKu1ob6UtJpumjN
	4VZTkM48jH2Z7tRksyMXOBWmBccc+Cz+bRw163iwhFNduy71cW113IoNIlYC48MK
	II/q/fQhlOfKuAwIq2Fv6KQnqJ7cGjwLOgjabGVBJyNX8ZS7zpHFthE7bS6jTAYr
	5FHFc3qOuzvqKMtGWzKMlzDJNuiYntkSmS2Sv/253w/KhQIEXoAXTlreLc4Q1cVz
	/nXvUuNHrkX6bs8YHYsoug54SK8ulutJDAQr9kLcMc9rwC1TJea8LLmd3u5h9HWt
	aA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4j5gd29231-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <gfs2@lists.linux.dev>; Tue, 24 Nov 2026 16:04:32 -0500 (EST)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-91c6c1e082bso96962686d6.0
        for <gfs2@lists.linux.dev>; Tue, 24 Nov 2026 13:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1795554272; x=1796159072; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ehoHHwwhO+SOqHm1ETZN2i9roC6iAhoxJvRnhkD8HmA=;
        b=5CTyT3MwiFxHuliI6RicHlJleJhPSX30i0hsylMGBtispZbzeXa5tz55Cj4MwZpB0W
         frf+Z69JkyT2AhSc5KPY2uCRbf/CCk+mQdHlREEe3e6E1yzjxemznhzJkeL1EdSqiaBS
         YoVlanRzFcgfCiBMxiy8uIHdjVPMbjWg09EPqQMxwpDBK3JulDFh3nKprTd/9ua87R3d
         wVDNhxGIEsvAc56nPx6SbQNi6s0bIS1pU24cs+QzcWm6a1nGneDzfCAi4gckdp9gwfoH
         jx7/4NVByXUL+Zj3C+Dg7NfhFAGHLKPAhGdkaUHPKgMfKj/khB8xwWbpUyJYZRyt+a0H
         EQzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795554272; x=1796159072;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ehoHHwwhO+SOqHm1ETZN2i9roC6iAhoxJvRnhkD8HmA=;
        b=HVu4psug1cMGlEYarCaxWeyo/TY7Vb5jYRKLYYx1UaLyRZNnPE9aJxBEo0AT+1lIw6
         fOjNYD+r88uhMslG7hL9YdmeVdnHUQ5fdnSwgPQtfyL18K2L4HBEefSxwuLHQ+q9LHV1
         2EjNmJb+ECBTCUyhpWRLR9FVEx6InHXfcspwWpVwkh7brXu+E+c0rL4qs2ntLT+iFROV
         6NXSeekI2tF5Juy21J8QviRAA3YXTEdZajD9CMOQhp6z2DVQ8ryTxZLTJvJMZYZVKgJL
         klqyQKJdbvm8fPppZoZm/E5OGPmcOPBwVKQJQTIe4RdNjb3U5iuhMFrBQpaH01yKiK4T
         5GMg==
X-Gm-Message-State: APuU4Z9S9ppA1WXNo4P87xcoFCJMJ41k1/cUr9Qr67edWwK+I7XNn8Y9
	yriVdAmqPdHDaNOwpErndCQ56qK2/zeD9GcGKD9GTDwH3sQbkr+MPGBnnLl1g5nrzee/7HMKQEa
	U5/+mnQblqrTOnpB6jnLJ/kgBle4QydwiWTXudjGZwlaqJPKHLMW5vagVyc8=
X-Gm-Gg: AZFdTZdp522eKcWSxJ+SxIxoaZl/a8J1DNvLfqZJX4CbLNybfED0NjdpLwGkzRO0thQ
	xdneUkNsexmFMQOsib47/4IRP53L7EhibFGOtd5QmCQABN1R7+Hl3+172zhIxhh9o9OfeKtlooQ
	jK4aqc+MTAiuPkxbwFr6GpdYZzHiPvOU6H5oVLpKG7fWZDWE9KxKJa7z9qPjclNOj+4fNhr+jiU
	MmqulhVzDhso9uVzvedn22Aumhg3hCGvPKhAiH278hwK08E4vAkNnmOSOX3l6on2ebUB04jbj5g
	ir9lvlPZG57PpBiIDoMLr5YHLC9FE9w1bK+KepQ8sA5UHikzyLTf7eOw7J7xfRYT7XljwsJGykp
	bQB0P+FEBR/835BpTQ+sd/lFRuHAqJsDfW4pDQCUQ6D6QBkjnfzmj8DZ6y4o=
X-Received: by 2002:a05:6214:8616:b0:921:23a6:8002 with SMTP id 6a1803df08f44-92134aef3d3mr270735806d6.14.1795554271524;
        Tue, 24 Nov 2026 13:04:31 -0800 (PST)
X-Received: by 2002:a05:6214:8616:b0:921:23a6:8002 with SMTP id 6a1803df08f44-92134aef3d3mr270735106d6.14.1795554270835;
        Tue, 24 Nov 2026 13:04:30 -0800 (PST)
Received: from [127.0.1.1] ([129.236.231.128])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-92134a0a454sm142827326d6.35.2026.11.24.13.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 13:04:30 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Date: Tue, 24 Nov 2026 16:04:10 -0500
Subject: [PATCH v2 2/4] gfs2: stop using pages for log buffers
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Post: <mailto:gfs2@lists.linux.dev>
List-Help: <mailto:gfs2+help@lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
List-Owner: <mailto:gfs2+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261124-gfs2-log-folio-v2-2-f229e90c8285@columbia.edu>
References: <20261124-gfs2-log-folio-v2-0-f229e90c8285@columbia.edu>
In-Reply-To: <20261124-gfs2-log-folio-v2-0-f229e90c8285@columbia.edu>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795554268; l=16673;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=JXJNR40Zoc7tA58fqBwNx+T8MYnCgn648eK4Iy0hpHU=;
 b=A7Y/7NoR3LmCq2vLOvrREOGA/Q5IcbQr+VFi/SJF6e3zOLE8V/tsSUkFGJxRMOWc+jUdIadH5
 MGRqgO31Bf5DHk401AD/O3sZjmNVQHEUTDdp2mloNqpoPWT2guN6IlH
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-ORIG-GUID: 1pIm1YUyfG-QcjUPcIyWopyZYxDYRrXw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA4MyBTYWx0ZWRfX0xbcdod5Dzbh
 hVoQZ9jKZHqxK0z2ps77dLx7oDQXNWSjvtl6cq5A/uJv9JI2DX7fVNXTGfmcvE8RAvqNDMcdl9R
 8kzNGZ0QOb6qEIrpRBZqnGlj54oIDF+RWlutamF1hmxzlqq1FM2NQw78oZtz70whYz4Xl6eb6FD
 YOGnIFXCO+OpVkVlzEQ1Xg/ZGa6M2fjul2Xr4NxE783A+U/0Ef+XEAcmg0d7KBYocE6xuYOOAH3
 yY5vwaF7AsX2dHQCIvGnVUnTpnpFDq4BE8qmQ4SNZzCpD2SDYDRfBvNTgwWB0H3ofssX/YQ1+6h
 5Yt1a2Uzrj0ZTD2+4dSsO4QChD2YqZOqXufgJc0ZKlBYSMl2ZIJsSjkzyJOeblaRMhttys0Fv/T
 PWmBGl4Fw3rWro12ZSCQ6Gb3m02FCae8nmJ+oGn9iaBhEG3e/hU6Vc1S//UqLkF2ybjo5xNCvJg
 Sg/cIccGRw2UnSiG35w==
X-Authority-Analysis: v=2.4 cv=OdgNnRTY c=1 sm=1 tr=0 ts=6b05fbe0 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=LNQXEAmb7IHcZyFqmLK0PA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=azVShVRs0zEubeQ0wG0L:22
 a=sYkUoKjhej99q4afhuMA:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA4MyBTYWx0ZWRfX/MVXD+bwUhRP
 0qiSEIykPZgU1zEFRAWk+u420uuyqr5wtmTYqfMm8SEljEqv31a3thx++UqBIS1Htw5TOWmtu/l
 wEF8g+IAtuVsqxcDswyM8WnTT/sLPUvXbw8V3zTi2LNnAwDBKPXE
X-Proofpoint-GUID: 1pIm1YUyfG-QcjUPcIyWopyZYxDYRrXw
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11976
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=10 phishscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 bulkscore=10 lowpriorityscore=10 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611240083

The log headers, descriptors, revoke blocks, and escaped block copies
come from a mempool of pages and share a bio with the buffer heads being
journaled. The completion handler tells the two apart by checking each
segment for buffers, which treats a pool page as a folio. That won't
work once memdescs give these pages a type of their own.

Make the per-superblock pool a kmalloc mempool of block-sized buffers
instead, and add them to the bio with bio_add_virt_nofail(). Give the
pool blocks their own completion handler, and start a new bio whenever
the handler changes so that a bio only holds one kind of segment.
gfs2_log_write() now takes a folio, so the log write path no longer uses
struct page.

Each descriptor and each escaped block copy is now a bio of its own.
They are contiguous and merge under an I/O scheduler, but the flush
path doesn't plug, so without a scheduler they reach the device as
separate writes.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/gfs2/log.c        |  10 +--
 fs/gfs2/lops.c       | 204 ++++++++++++++++++++++++++++++++-------------------
 fs/gfs2/lops.h       |   6 +-
 fs/gfs2/ops_fstype.c |   3 +-
 4 files changed, 136 insertions(+), 87 deletions(-)

diff --git a/fs/gfs2/log.c b/fs/gfs2/log.c
index e7076db3ba46..2f9f20b40adc 100644
--- a/fs/gfs2/log.c
+++ b/fs/gfs2/log.c
@@ -841,7 +841,6 @@ void gfs2_write_log_header(struct gfs2_sbd *sdp, struct gfs2_jdesc *jd,
 {
 	struct gfs2_log_header *lh;
 	u32 hash, crc;
-	struct page *page;
 	struct gfs2_statfs_change_host *l_sc = &sdp->sd_statfs_local;
 	struct timespec64 tv;
 	struct super_block *sb = sdp->sd_vfs;
@@ -850,9 +849,8 @@ void gfs2_write_log_header(struct gfs2_sbd *sdp, struct gfs2_jdesc *jd,
 	if (gfs2_withdrawn(sdp))
 		return;
 
-	page = mempool_alloc(&sdp->sd_log_buf_pool, GFP_NOIO);
-	lh = page_address(page);
-	clear_page(lh);
+	lh = mempool_alloc(&sdp->sd_log_buf_pool, GFP_NOIO);
+	memset(lh, 0, sb->s_blocksize);
 
 	lh->lh_header.mh_magic = cpu_to_be32(GFS2_MAGIC);
 	lh->lh_header.mh_type = cpu_to_be32(GFS2_METATYPE_LH);
@@ -905,8 +903,8 @@ void gfs2_write_log_header(struct gfs2_sbd *sdp, struct gfs2_jdesc *jd,
 		     sb->s_blocksize - LH_V1_SIZE - 4);
 	lh->lh_crc = cpu_to_be32(crc);
 
-	gfs2_log_write(sdp, jd, page, sb->s_blocksize, 0, dblock,
-		       REQ_OP_WRITE | op_flags);
+	gfs2_log_write_buf(sdp, jd, lh, sb->s_blocksize, dblock,
+			   REQ_OP_WRITE | op_flags);
 	gfs2_log_submit_write(&jd->jd_log_bio);
 }
 
diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
index 7a2c29652fec..156d7c6341ca 100644
--- a/fs/gfs2/lops.c
+++ b/fs/gfs2/lops.c
@@ -196,45 +196,70 @@ static void gfs2_end_log_write_bh(struct gfs2_sbd *sdp, struct folio *folio,
 	} while (bh && size);
 }
 
+static void gfs2_log_write_error(struct bio *bio)
+{
+	struct gfs2_sbd *sdp = bio->bi_private;
+	int err = blk_status_to_errno(bio->bi_status);
+
+	if (!cmpxchg(&sdp->sd_log_error, 0, err))
+		fs_err(sdp, "Error %d writing to journal, jid=%u\n",
+		       err, sdp->sd_jdesc->jd_jid);
+	gfs2_withdraw(sdp);
+}
+
+static void gfs2_log_write_done(struct bio *bio)
+{
+	struct gfs2_sbd *sdp = bio->bi_private;
+
+	bio_put(bio);
+	if (atomic_dec_and_test(&sdp->sd_log_in_flight))
+		wake_up(&sdp->sd_log_flush_wait);
+}
+
 /**
- * gfs2_end_log_write - end of i/o to the log
+ * gfs2_end_log_write - end of I/O to the log for buffers
  * @bio: The bio
  *
- * Each bio_vec contains either data from the pagecache or data
- * relating to the log itself. Here we iterate over the bio_vec
- * array, processing both kinds of data.
- *
+ * Every folio in the bio comes from the page cache. Unlock the buffers
+ * that were written.
  */
 
 static void gfs2_end_log_write(struct bio *bio)
 {
 	struct gfs2_sbd *sdp = bio->bi_private;
-	struct bio_vec *bvec;
-	struct bvec_iter_all iter_all;
+	struct folio_iter fi;
 
-	if (bio->bi_status) {
-		int err = blk_status_to_errno(bio->bi_status);
+	if (bio->bi_status)
+		gfs2_log_write_error(bio);
 
-		if (!cmpxchg(&sdp->sd_log_error, 0, err))
-			fs_err(sdp, "Error %d writing to journal, jid=%u\n",
-			       err, sdp->sd_jdesc->jd_jid);
-		gfs2_withdraw(sdp);
-	}
+	bio_for_each_folio_all(fi, bio)
+		gfs2_end_log_write_bh(sdp, fi.folio, fi.offset, fi.length,
+				      bio->bi_status);
 
-	bio_for_each_segment_all(bvec, bio, iter_all) {
-		struct page *page = bvec->bv_page;
-		struct folio *folio = page_folio(page);
+	gfs2_log_write_done(bio);
+}
 
-		if (folio && folio_buffers(folio))
-			gfs2_end_log_write_bh(sdp, folio, bvec->bv_offset,
-					bvec->bv_len, bio->bi_status);
-		else
-			mempool_free(page, &sdp->sd_log_buf_pool);
-	}
+/**
+ * gfs2_end_log_write_buf - end of I/O to the log for log blocks
+ * @bio: The bio
+ *
+ * Every segment in the bio is a block from the log buffer mempool.
+ * Return them to the pool.
+ */
 
-	bio_put(bio);
-	if (atomic_dec_and_test(&sdp->sd_log_in_flight))
-		wake_up(&sdp->sd_log_flush_wait);
+static void gfs2_end_log_write_buf(struct bio *bio)
+{
+	struct gfs2_sbd *sdp = bio->bi_private;
+	struct bio_vec *bvec;
+	struct bvec_iter_all iter_all;
+
+	if (bio->bi_status)
+		gfs2_log_write_error(bio);
+
+	bio_for_each_segment_all(bvec, bio, iter_all)
+		mempool_free(bvec_virt(bvec), &sdp->sd_log_buf_pool);
+
+	gfs2_log_write_done(bio);
 }
 
 /**
@@ -291,9 +316,9 @@ static struct bio *gfs2_log_alloc_bio(struct gfs2_sbd *sdp, u64 blkno,
  * @flush: Always flush the current bio and allocate a new one?
  *
  * If there is a cached bio, then if the next block number is sequential
- * with the previous one, return it, otherwise flush the bio to the
- * device. If there is no cached bio, or we just flushed it, then
- * allocate a new one.
+ * with the previous one and the bio has the same completion handler,
+ * return it, otherwise flush the bio to the device. If there is no
+ * cached bio, or we just flushed it, then allocate a new one.
  *
  * Returns: The bio to use for log writes
  */
@@ -309,7 +334,7 @@ static struct bio *gfs2_log_get_bio(struct gfs2_sbd *sdp, u64 blkno,
 
 		nblk = bio_end_sector(bio);
 		nblk >>= sdp->sd_fsb2bb_shift;
-		if (blkno == nblk && !flush)
+		if (blkno == nblk && bio->bi_end_io == end_io && !flush)
 			return bio;
 		gfs2_log_submit_write(biop);
 	}
@@ -319,38 +344,63 @@ static struct bio *gfs2_log_get_bio(struct gfs2_sbd *sdp, u64 blkno,
 }
 
 /**
- * gfs2_log_write - write to log
+ * gfs2_log_write - write a folio segment to the log
  * @sdp: the filesystem
  * @jd: The journal descriptor
- * @page: the page to write
+ * @folio: the folio to write
  * @size: the size of the data to write
- * @offset: the offset within the page 
+ * @offset: the offset within the folio
  * @blkno: block number of the log entry
  * @opf: REQ_OP | op_flags
  *
- * Try and add the page segment to the current bio. If that fails,
+ * Try and add the folio segment to the current bio. If that fails,
  * submit the current bio to the device and create a new one, and
- * then add the page segment to that.
+ * then add the folio segment to that.
  */
 
-void gfs2_log_write(struct gfs2_sbd *sdp, struct gfs2_jdesc *jd,
-		    struct page *page, unsigned size, unsigned offset,
-		    u64 blkno, blk_opf_t opf)
+static void gfs2_log_write(struct gfs2_sbd *sdp, struct gfs2_jdesc *jd,
+			   struct folio *folio, unsigned int size,
+			   unsigned int offset, u64 blkno, blk_opf_t opf)
 {
 	struct bio *bio;
-	int ret;
 
 	bio = gfs2_log_get_bio(sdp, blkno, &jd->jd_log_bio, opf,
 			       gfs2_end_log_write, false);
-	ret = bio_add_page(bio, page, size, offset);
-	if (ret == 0) {
+	if (!bio_add_folio(bio, folio, size, offset)) {
 		bio = gfs2_log_get_bio(sdp, blkno, &jd->jd_log_bio,
 				       opf, gfs2_end_log_write, true);
-		ret = bio_add_page(bio, page, size, offset);
-		WARN_ON(ret == 0);
+		WARN_ON(!bio_add_folio(bio, folio, size, offset));
 	}
 }
 
+/**
+ * gfs2_log_write_buf - write a log buffer to the log
+ * @sdp: the filesystem
+ * @jd: The journal descriptor
+ * @buf: the buffer to write, from the log buffer mempool
+ * @size: the size of the data to write
+ * @blkno: block number of the log entry
+ * @opf: REQ_OP | op_flags
+ *
+ * Like gfs2_log_write(), for a block allocated from sd_log_buf_pool.
+ * Ownership of the buffer passes to the bio, which returns it to the
+ * pool on completion.
+ */
+
+void gfs2_log_write_buf(struct gfs2_sbd *sdp, struct gfs2_jdesc *jd,
+			void *buf, unsigned int size, u64 blkno,
+			blk_opf_t opf)
+{
+	struct bio *bio;
+
+	bio = gfs2_log_get_bio(sdp, blkno, &jd->jd_log_bio, opf,
+			       gfs2_end_log_write_buf, false);
+	if (bio->bi_vcnt >= bio->bi_max_vecs)
+		bio = gfs2_log_get_bio(sdp, blkno, &jd->jd_log_bio,
+				       opf, gfs2_end_log_write_buf, true);
+	bio_add_virt_nofail(bio, buf, size);
+}
+
 /**
  * gfs2_log_write_bh - write a buffer's content to the log
  * @sdp: The super block
@@ -367,30 +417,30 @@ static void gfs2_log_write_bh(struct gfs2_sbd *sdp, struct buffer_head *bh)
 
 	dblock = gfs2_log_bmap(sdp->sd_jdesc, sdp->sd_log_flush_head);
 	gfs2_log_incr_head(sdp);
-	gfs2_log_write(sdp, sdp->sd_jdesc, folio_page(bh->b_folio, 0),
-			bh->b_size, bh_offset(bh), dblock, REQ_OP_WRITE);
+	gfs2_log_write(sdp, sdp->sd_jdesc, bh->b_folio, bh->b_size,
+		       bh_offset(bh), dblock, REQ_OP_WRITE);
 }
 
 /**
- * gfs2_log_write_page - write one block stored in a page, into the log
+ * gfs2_log_write_block - write one block stored in a log buffer, into the log
  * @sdp: The superblock
- * @page: The struct page
+ * @buf: The buffer
  *
- * This writes the first block-sized part of the page into the log. Note
- * that the page must have been allocated from the sd_log_buf_pool mempool
- * and that after this has been called, ownership has been transferred and
- * the page may be freed at any time.
+ * This writes the first block-sized part of the buffer into the log. Note
+ * that the buffer must have been allocated from the sd_log_buf_pool
+ * mempool and that after this has been called, ownership has been
+ * transferred and the buffer may be freed at any time.
  */
 
-static void gfs2_log_write_page(struct gfs2_sbd *sdp, struct page *page)
+static void gfs2_log_write_block(struct gfs2_sbd *sdp, void *buf)
 {
 	struct super_block *sb = sdp->sd_vfs;
 	u64 dblock;
 
 	dblock = gfs2_log_bmap(sdp->sd_jdesc, sdp->sd_log_flush_head);
 	gfs2_log_incr_head(sdp);
-	gfs2_log_write(sdp, sdp->sd_jdesc, page, sb->s_blocksize, 0, dblock,
-		       REQ_OP_WRITE);
+	gfs2_log_write_buf(sdp, sdp->sd_jdesc, buf, sb->s_blocksize, dblock,
+			   REQ_OP_WRITE);
 }
 
 /**
@@ -604,12 +654,14 @@ int gfs2_find_jhead(struct gfs2_jdesc *jd, struct gfs2_log_header_host *head)
 	return ret;
 }
 
-static struct page *gfs2_get_log_desc(struct gfs2_sbd *sdp, u32 ld_type,
-				      u32 ld_length, u32 ld_data1)
+static struct gfs2_log_descriptor *gfs2_get_log_desc(struct gfs2_sbd *sdp,
+						     u32 ld_type, u32 ld_length,
+						     u32 ld_data1)
 {
-	struct page *page = mempool_alloc(&sdp->sd_log_buf_pool, GFP_NOIO);
-	struct gfs2_log_descriptor *ld = page_address(page);
-	clear_page(ld);
+	struct gfs2_log_descriptor *ld;
+
+	ld = mempool_alloc(&sdp->sd_log_buf_pool, GFP_NOIO);
+	memset(ld, 0, sdp->sd_sb.sb_bsize);
 	ld->ld_header.mh_magic = cpu_to_be32(GFS2_MAGIC);
 	ld->ld_header.mh_type = cpu_to_be32(GFS2_METATYPE_LD);
 	ld->ld_header.mh_format = cpu_to_be32(GFS2_FORMAT_LD);
@@ -617,7 +669,7 @@ static struct page *gfs2_get_log_desc(struct gfs2_sbd *sdp, u32 ld_type,
 	ld->ld_length = cpu_to_be32(ld_length);
 	ld->ld_data1 = cpu_to_be32(ld_data1);
 	ld->ld_data2 = 0;
-	return page;
+	return ld;
 }
 
 static void gfs2_check_magic(struct buffer_head *bh)
@@ -652,7 +704,6 @@ static void gfs2_before_commit(struct gfs2_sbd *sdp, unsigned int limit,
 {
 	struct gfs2_log_descriptor *ld;
 	struct gfs2_bufdata *bd1 = NULL, *bd2;
-	struct page *page;
 	unsigned int num;
 	unsigned n;
 	__be64 *ptr;
@@ -665,10 +716,9 @@ static void gfs2_before_commit(struct gfs2_sbd *sdp, unsigned int limit,
 		if (total > limit)
 			num = limit;
 		spin_unlock(&sdp->sd_log_lock);
-		page = gfs2_get_log_desc(sdp,
-					 is_databuf ? GFS2_LOG_DESC_JDATA :
-					 GFS2_LOG_DESC_METADATA, num + 1, num);
-		ld = page_address(page);
+		ld = gfs2_get_log_desc(sdp,
+				       is_databuf ? GFS2_LOG_DESC_JDATA :
+				       GFS2_LOG_DESC_METADATA, num + 1, num);
 		spin_lock(&sdp->sd_log_lock);
 		ptr = (__be64 *)(ld + 1);
 
@@ -684,7 +734,7 @@ static void gfs2_before_commit(struct gfs2_sbd *sdp, unsigned int limit,
 		}
 
 		spin_unlock(&sdp->sd_log_lock);
-		gfs2_log_write_page(sdp, page);
+		gfs2_log_write_block(sdp, ld);
 		spin_lock(&sdp->sd_log_lock);
 
 		n = 0;
@@ -696,8 +746,7 @@ static void gfs2_before_commit(struct gfs2_sbd *sdp, unsigned int limit,
 			if (buffer_escaped(bd2->bd_bh)) {
 				void *p;
 
-				page = mempool_alloc(&sdp->sd_log_buf_pool, GFP_NOIO);
-				p = page_address(page);
+				p = mempool_alloc(&sdp->sd_log_buf_pool, GFP_NOIO);
 				memcpy_from_folio(p, bd2->bd_bh->b_folio,
 						  bh_offset(bd2->bd_bh),
 						  bd2->bd_bh->b_size);
@@ -705,7 +754,7 @@ static void gfs2_before_commit(struct gfs2_sbd *sdp, unsigned int limit,
 				clear_buffer_escaped(bd2->bd_bh);
 				unlock_buffer(bd2->bd_bh);
 				brelse(bd2->bd_bh);
-				gfs2_log_write_page(sdp, page);
+				gfs2_log_write_block(sdp, p);
 			} else {
 				gfs2_log_write_bh(sdp, bd2->bd_bh);
 			}
@@ -856,7 +905,7 @@ static void revoke_lo_before_commit(struct gfs2_sbd *sdp, struct gfs2_trans *tr)
 	struct gfs2_meta_header *mh;
 	unsigned int offset;
 	struct gfs2_bufdata *bd;
-	struct page *page;
+	void *buf;
 	unsigned int length;
 
 	gfs2_flush_revokes(sdp);
@@ -864,29 +913,30 @@ static void revoke_lo_before_commit(struct gfs2_sbd *sdp, struct gfs2_trans *tr)
 		return;
 
 	length = gfs2_struct2blk(sdp, sdp->sd_log_num_revoke);
-	page = gfs2_get_log_desc(sdp, GFS2_LOG_DESC_REVOKE, length, sdp->sd_log_num_revoke);
+	buf = gfs2_get_log_desc(sdp, GFS2_LOG_DESC_REVOKE, length,
+				sdp->sd_log_num_revoke);
 	offset = sizeof(struct gfs2_log_descriptor);
 
 	list_for_each_entry(bd, &sdp->sd_log_revokes, bd_list) {
 		sdp->sd_log_num_revoke--;
 
 		if (offset + sizeof(u64) > sdp->sd_sb.sb_bsize) {
-			gfs2_log_write_page(sdp, page);
-			page = mempool_alloc(&sdp->sd_log_buf_pool, GFP_NOIO);
-			mh = page_address(page);
-			clear_page(mh);
+			gfs2_log_write_block(sdp, buf);
+			buf = mempool_alloc(&sdp->sd_log_buf_pool, GFP_NOIO);
+			mh = buf;
+			memset(mh, 0, sdp->sd_sb.sb_bsize);
 			mh->mh_magic = cpu_to_be32(GFS2_MAGIC);
 			mh->mh_type = cpu_to_be32(GFS2_METATYPE_LB);
 			mh->mh_format = cpu_to_be32(GFS2_FORMAT_LB);
 			offset = sizeof(struct gfs2_meta_header);
 		}
 
-		*(__be64 *)(page_address(page) + offset) = cpu_to_be64(bd->bd_blkno);
+		*(__be64 *)(buf + offset) = cpu_to_be64(bd->bd_blkno);
 		offset += sizeof(u64);
 	}
 	gfs2_assert_withdraw(sdp, !sdp->sd_log_num_revoke);
 
-	gfs2_log_write_page(sdp, page);
+	gfs2_log_write_block(sdp, buf);
 }
 
 void gfs2_drain_revokes(struct gfs2_sbd *sdp)
diff --git a/fs/gfs2/lops.h b/fs/gfs2/lops.h
index 772557b63b48..c1d9e6fef7ac 100644
--- a/fs/gfs2/lops.h
+++ b/fs/gfs2/lops.h
@@ -14,9 +14,9 @@ extern const struct gfs2_log_operations *gfs2_log_ops[];
 
 void gfs2_log_incr_head(struct gfs2_sbd *sdp);
 u64 gfs2_log_bmap(struct gfs2_jdesc *jd, unsigned int lbn);
-void gfs2_log_write(struct gfs2_sbd *sdp, struct gfs2_jdesc *jd,
-		    struct page *page, unsigned size, unsigned offset,
-		    u64 blkno, blk_opf_t opf);
+void gfs2_log_write_buf(struct gfs2_sbd *sdp, struct gfs2_jdesc *jd,
+			void *buf, unsigned int size, u64 blkno,
+			blk_opf_t opf);
 void gfs2_log_submit_write(struct bio **biop);
 void gfs2_pin(struct gfs2_sbd *sdp, struct buffer_head *bh);
 int gfs2_find_jhead(struct gfs2_jdesc *jd,
diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index f62a893ce5a2..f71174273abf 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -1219,7 +1219,8 @@ static int gfs2_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (error)
 		goto fail_locking;
 
-	error = mempool_init_page_pool(&sdp->sd_log_buf_pool, 64, 0);
+	error = mempool_init_kmalloc_pool(&sdp->sd_log_buf_pool, 64,
+					  sdp->sd_sb.sb_bsize);
 	if (error)
 		goto fail_sb;
 

-- 
2.39.5

