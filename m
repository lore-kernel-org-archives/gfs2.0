Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.139.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795554275;
	b=s4CT9Zzj3djIx65qtAd59XC7steQEMXqhnlJNHhou8ONPogQf9DbYAvDFmGjJJWbLQG6
	 4+EPQZ0IhYU5f4UqzhxRgfQnS0viF+2Ev4Da3D17HHa7jc9+9v34MU0kp6RRe70TMkgOJ
	 OrGLID8ibbHx4pk843egUQH+Cg02zDCYRW2sK1Yi89ZIyNXnTKpkDwgSQ5GX0l0l4s7JC
	 8odcXyqAQ0q/rDpi2yrMpysFPshYxfhje6hz38vsOjk6MTAgv3o6Cw/y4mWgZAbjSv66k
	 QfcnhmrPd40UxD3Pxz85VQD/fg0QKOf1NmOofc55n4lHj92IGtkk8grYdBHc1P9dmRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795554275;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=HEE4z1qXFnBWTDdjAETCwV2Mt7o77ms8dAQPaznXq1g=;
	b=AKxmIfrs+7HBh4x7TS0k5JZvB6ET1iY/LDJev37+fyUVYMnVsy1ekZ/r6aqOiswflufp
	 QycxZN6FQkc58MNtpu1vj2E9N0Sa6qLWUL8RgzhFZLIbdI9FnW0SEE6XG9KMjdCszA4r3
	 //AfQYtf/qIXMWE6iYtvljo+FonQMAk0+m+FcaP1lYSnCntqI/Gpi5f6y6qu0j9bFjpvE
	 KU5xnOT22O9V9RFG4bPxSf935dfNn3buhqncJIQk/9wsHy6T265YTMzn/r0GgrAsuzJJk
	 ADybrJ7SzqXo0ndYVNZApKZiNWnLnGjXVLZJoNrhEa337piZBtwa6AGxHYk0yhYn+cQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=YRjpw25i;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=pE6TRkZN;
	arc=none smtp.remote-ip=148.163.139.74
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06D5606A686
	for <gfs2@lists.linux.dev>; Tue, 24 Nov 2026 21:04:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E06D5606A686
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=YRjpw25i;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=pE6TRkZN
Received: from pps.filterd (m0167077.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AOKaO5q2580512
	for <gfs2@lists.linux.dev>; Tue, 24 Nov 2026 16:04:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=HEE4
	z1qXFnBWTDdjAETCwV2Mt7o77ms8dAQPaznXq1g=; b=YRjpw25ioZigVnw31awX
	iP8yzfcTyQZEOlPqDOQ0SsuOKu2MBboMFWr//cTpSWpGTHY9iuev0Up0yMu43G1b
	YsF9Ps8bfoMs+2AEu6TB4m7NqCGFEZYtIYz2/UHcVA4RDpdL5Yq0WbzyZsQ6jw/B
	KJ9ZNHivTC5hm3libb2AebYCeGxbK5N0q3GDgGtpyrcnKB2W2ctJEDQW4MoWVANO
	bV+e1LVqsXzFyOVEJ+Ri5uEf81IP7Ja2tdpyFVHMpSdZeyIBnIS51WeX6wKRTf2z
	NHo7gJgs4e+nnEEm4k4HMmJgOzR6PhJsTzDfLBt4Um0baT4MtGNl148B/LJEE6+V
	GA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4j5g7bh5fb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <gfs2@lists.linux.dev>; Tue, 24 Nov 2026 16:04:33 -0500 (EST)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-92134f1eb00so72509866d6.0
        for <gfs2@lists.linux.dev>; Tue, 24 Nov 2026 13:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1795554273; x=1796159073; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HEE4z1qXFnBWTDdjAETCwV2Mt7o77ms8dAQPaznXq1g=;
        b=pE6TRkZNXi4GF1LRpFNNzwd1fyPRq7kIxJR/32k+mHiDBVWL+iE0inV73VzASFf466
         TFEC1/iJ3ldZZCaaXPRohLbHErMuIAKWlklMB6FT5fzvgwEZRss+ps5grpyi46/pXzPS
         Pvj59kcfIPSNhXdMFkVJTzHjDAS+as/vbdmcOax7QTJc3y8Dg3h6IjHOIxnSAwtb4Io4
         9HtbcVj9zOIVF7bRdievBHlwsI/xsRfBMFnkll70Y0VcSpyggWt+gWdafRszI3hlYDts
         1jwXfz5MNgmut1MmPXRmJr2Qq4DD+MzeQKst/UowVpsBe9stxFQQHuv35+gUIgRh9tZi
         /F2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795554273; x=1796159073;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HEE4z1qXFnBWTDdjAETCwV2Mt7o77ms8dAQPaznXq1g=;
        b=AO6hLJmzZrW7mZDvl8qXOR4DJdhJt8zezo6lNm7P7FiuW1Dwmf+idcGyYdwNsX8N3A
         JtSnhO66Qy1RsAvPqkNqnRKCO7TZzNJwj68KC8HxUC/ti+iVKNooDdCYh94hRk0pnRbV
         RMubRuowppVVKiDTyeUfrnGnAY6MsUxfcMbnVrZVtvhMqhIj26iRrabm+SMzzUjWxiqF
         Ae18rtrM+W0BXo4broqsGDZ5BJmgcUVTVIMWvYEHRhgsTS+m7nlJcoz35rpXV+84/QkN
         SjeW99ULn1XlWatPWsCCu7gbj/0kCDa1ZJ4mpMiEHjQVkaDXUlAkThkAGji6f1CRv8Y+
         gGVQ==
X-Gm-Message-State: APuU4Z+CPZ6EbdRDLqHOpKoxvleL96v3nH/eQv8MlOvWPFI3NpJY7CD2
	LDv53yQVO4jVZr6GGlr/o8TPlQwTAO8tYaCrAScD0C6flc7NdHyj3Wgm8PF57LEi4dUFW3TmsfL
	HDk5nw22Xgs/o/CZRPvKMxIBsrdmXI0TywTtR5tZs1QQc4XBF5Ok=
X-Gm-Gg: AZFdTZeW8jJTyfudKsBkFj/Bn3mUr4YfIZbB2c2ZTqW8tys64etaCVCOQseymAdD+DP
	7CDoSuuW9miDpkVNpNsBfKjUHBfvpl0H3EbFj6XmzZrbnZhaFx0ubSNLSP2YhjphB2bOFco9I7V
	XdpgxvIFHNX7gE76nZMAmMkUZCqiTT1IwYeldPYr+9oFg6p54yqXa4jl+jG4xKUFXio3l6lPHXe
	6gHZ31Ldvd0n5FwT81xA32NRFobdv4wp4iOyXD42eidkwIaYUsWPDDwQ9eiqckpUXRI0JylyumU
	CVz9Okv1sesG0sU8rZ6123gRU21vu+bT3TJNXIpPL4ABDtgoGFXjjP6X1i0dc3SLawMzlbav7ml
	G1CuwcWqQwuY0nszamxsZcyV9aLS+xePPjRFzU9XSvBodLsmLmsUvX5boUAw=
X-Received: by 2002:a05:6214:458b:b0:921:1e1b:1e11 with SMTP id 6a1803df08f44-92134aae5b1mr274723876d6.11.1795554272942;
        Tue, 24 Nov 2026 13:04:32 -0800 (PST)
X-Received: by 2002:a05:6214:458b:b0:921:1e1b:1e11 with SMTP id 6a1803df08f44-92134aae5b1mr274723526d6.11.1795554272517;
        Tue, 24 Nov 2026 13:04:32 -0800 (PST)
Received: from [127.0.1.1] ([129.236.231.128])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-92134a0a454sm142827326d6.35.2026.11.24.13.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 13:04:31 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Date: Tue, 24 Nov 2026 16:04:12 -0500
Subject: [PATCH v2 4/4] gfs2: remove the remaining page references in the
 log code
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
Message-Id: <20261124-gfs2-log-folio-v2-4-f229e90c8285@columbia.edu>
References: <20261124-gfs2-log-folio-v2-0-f229e90c8285@columbia.edu>
In-Reply-To: <20261124-gfs2-log-folio-v2-0-f229e90c8285@columbia.edu>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795554268; l=3235;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=OgZ2zeJfQt6UnNuu1TeQVqZhmgjPlO+0iv55uACTpZ8=;
 b=iHK2QTNfzT4MBkSVKE27B+IG3oZy06kk89SJhnWSw5WSqD7RgNhyfXEWm3QkJcdvEysp9udmA
 APClu+NXWayBPHZEA7dHJSQ7AX2RE18hryeS3ipkEr2qODvbcM3U7Pj
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA4MyBTYWx0ZWRfX4QCEd4qkDavq
 ZSkGigirf+flBNtfV2XXBivxuClbxEdlvFs2zyhvHms1SJsscIPyIv6ytWpkFHhmfkd6Y0DYl/9
 REluf5M+KRGojKJZ6A7WdF1LYVhhilRq57Z0fn72N00qi93BrDqA3KE47Vd1fuM0b3TLWjB5cC3
 hP3R2Gu93SXkrL2ZHZBE/mAvUd1pIUGQ2Nh60QPLjHTDti9l+uOrh1iv3hU0sZ4E3yUnlHVLFc6
 PvKzBLy0/LDHbduLTGX55sQWu/lVD/ZQGCKSuELBbtHqWiAouyQTzGsQrgcRHoHtpa2dthe6Rn+
 P4W/c4fp00rDmMwrogpzU1izjzHIGp9d0dgO2Tr+ERQ1pYEpaSuZggp479poJbB2pxaje7NuBho
 9sdnLanZMZOHu6vhnpMiNDN8AC8qwZuI0pHlFRw3p8YYFfvdGCiYhFI5gMdruLvgnCErt7NaNP/
 TsYoKxcglNERg2jA4Xw==
X-Proofpoint-ORIG-GUID: IX1VRJi7CNOjsG519u2SWPVT0ii2sT03
X-Proofpoint-GUID: IX1VRJi7CNOjsG519u2SWPVT0ii2sT03
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA4MyBTYWx0ZWRfXy+1Ri6G1xZKS
 gRpww0bwg1amOP3jeMhd+rF+KQ6qtjkC0k79D/nsjaT/S/giJAMHBUb0yTUI65Ae99hBQ7w+eGV
 cDkmcXeeRGI6B1ViZfUH/Ju+X5n4iO+sgt3YdQo3gKluEkJG2c5J
X-Authority-Analysis: v=2.4 cv=RIcmjIi+ c=1 sm=1 tr=0 ts=6b05fbe1 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=LNQXEAmb7IHcZyFqmLK0PA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=QOCMdifcju39GKoXhKua:22
 a=RLOwVVqb4wJnjAl-1mUA:9 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11976
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 impostorscore=10 lowpriorityscore=10 priorityscore=1501 bulkscore=10
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611240083

gfs2_jhead_process_page() takes a folio, and the comments around it and
gfs2_end_log_read() still describe folios as pages. Rename it to
gfs2_jhead_process_folio() and update the comments.

Drop the struct page forward declaration from bmap.h as well, which has
had no user since the unstuff path was converted.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/gfs2/bmap.h |  1 -
 fs/gfs2/lops.c | 18 +++++++++---------
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/fs/gfs2/bmap.h b/fs/gfs2/bmap.h
index e3d6efdfd890..7b44cc9c742c 100644
--- a/fs/gfs2/bmap.h
+++ b/fs/gfs2/bmap.h
@@ -13,7 +13,6 @@
 
 struct inode;
 struct gfs2_inode;
-struct page;
 
 
 /**
diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
index 156d7c6341ca..000be5ec54a3 100644
--- a/fs/gfs2/lops.c
+++ b/fs/gfs2/lops.c
@@ -447,7 +447,7 @@ static void gfs2_log_write_block(struct gfs2_sbd *sdp, void *buf)
  * gfs2_end_log_read - end I/O callback for reads from the log
  * @bio: The bio
  *
- * Simply unlock the pages in the bio. The main thread will wait on them and
+ * Simply unlock the folios in the bio. The main thread will wait on them and
  * process them in order as necessary.
  */
 static void gfs2_end_log_read(struct bio *bio)
@@ -465,7 +465,7 @@ static void gfs2_end_log_read(struct bio *bio)
 }
 
 /**
- * gfs2_jhead_folio_search - Look for the journal head in a given page.
+ * gfs2_jhead_folio_search - Look for the journal head in a given folio.
  * @jd: The journal descriptor
  * @head: The journal head to start from
  * @folio: The folio to look in
@@ -499,9 +499,9 @@ static bool gfs2_jhead_folio_search(struct gfs2_jdesc *jd,
 }
 
 /**
- * gfs2_jhead_process_page - Search/cleanup a page
+ * gfs2_jhead_process_folio - Search/cleanup a folio
  * @jd: The journal descriptor
- * @index: Index of the page to look into
+ * @index: Index of the folio to look into
  * @head: The journal head to start from
  * @done: If set, perform only cleanup, else search and set if found.
  *
@@ -518,9 +518,9 @@ static bool gfs2_jhead_folio_search(struct gfs2_jdesc *jd,
  * our references to the folio.
  */
 
-static void gfs2_jhead_process_page(struct gfs2_jdesc *jd, unsigned long index,
-				    struct gfs2_log_header_host *head,
-				    bool *done)
+static void gfs2_jhead_process_folio(struct gfs2_jdesc *jd, unsigned long index,
+				     struct gfs2_log_header_host *head,
+				     bool *done)
 {
 	struct folio *folio;
 
@@ -631,7 +631,7 @@ int gfs2_find_jhead(struct gfs2_jdesc *jd, struct gfs2_log_header_host *head)
 				continue;
 			}
 
-			gfs2_jhead_process_page(jd, blocks_read >> shift, head, &done);
+			gfs2_jhead_process_folio(jd, blocks_read >> shift, head, &done);
 			blocks_read += PAGE_SIZE >> bsize_shift;
 			if (done)
 				goto out;  /* found */
@@ -642,7 +642,7 @@ int gfs2_find_jhead(struct gfs2_jdesc *jd, struct gfs2_log_header_host *head)
 	if (bio)
 		submit_bio(bio);
 	while (blocks_read < block) {
-		gfs2_jhead_process_page(jd, blocks_read >> shift, head, &done);
+		gfs2_jhead_process_folio(jd, blocks_read >> shift, head, &done);
 		blocks_read += PAGE_SIZE >> bsize_shift;
 	}
 

-- 
2.39.5

