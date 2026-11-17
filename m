Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.139.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794901594;
	b=wuFAYyfUceA/ViGY35XEaDKfZNylKwFWNE+HjgjWkXXwjXqImVd/cLN0vx0iMbkUDMpc
	 /s02OZBc9jh8tLtAt9YWT2nOIlCsVuMyfXoQMWfj0eLauyH45leGAqoiNvqxfNwUBb4sk
	 fM8XW1CUxsNVfaynJMtt+AlIDenq3wHKMHYi+9x+vuyvFcJANlIrXvdyAuaWfQIsaa3ii
	 YngMBMeduOosODfYdApqgnHzsqbTQHB9K8h3UgnRx1BR9187CLIk41wc7AVi+F7XCjtI/
	 G9Sb6kIUCsS9sCGK7XCp0vGB7RHcML+3y3rhWbsk9P0cMX/d7etxpXgBpEm+8Bk3MKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794901594;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=13gBg7QBW6VxUO230NS+TxRvi6Fhbsy36rbkemPFH78=;
	b=10GOVKWDE3hpJa3CxQwfVLnoKZjSPgjYJpier/ZaBypULMfD5cSi9kLR3+uNeFlRHiXu
	 vqWW0TaCz6/SWbR4Iq3ki2pJ2WQuxZhG8tc4lb004kPPqedurxnwpXuvTY5AZTLWoy/t1
	 AOEcR6h7WhOreuAawYLcHP+tbTiE38XT29pmT10HSLClx9efLGjXojk/upG65jMa4KXGa
	 /+v14tOVl0iuEWkyI/odS4MBxLqxgr8odePab3QLsw+Oy22KfKLHdWgFTAXB/cCHoKCEZ
	 ETJerT5cUsVsTnkK4MPSfHqEXn3JUvjH+3dmboLaObEcQ0WRmoqgAeRA4Q0OCW3CwSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=XjsgZo0D;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=1TptSAx4;
	arc=none smtp.remote-ip=148.163.139.74
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B42D606A882
	for <gfs2@lists.linux.dev>; Tue, 17 Nov 2026 07:46:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B42D606A882
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=XjsgZo0D;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=1TptSAx4
Received: from pps.filterd (m0167074.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AH7YfOj1193952
	for <gfs2@lists.linux.dev>; Tue, 17 Nov 2026 02:46:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=13gB
	g7QBW6VxUO230NS+TxRvi6Fhbsy36rbkemPFH78=; b=XjsgZo0Dq0PXXVgHHx58
	gK/2O+GJBHHJlhWZ/JcKiC7IqCvQWHjLsH+II5P5VSWF8XJyBxGCkvqh0ahbHwM5
	LyMfsVILj2Foi2+LCWxnbyZ9erCdRJER+6NpuRZ9AFyCbB5tAHj3K8tgWVnSLN1W
	t3Yqi++4waxuJbZ5v4cLXRrBaVRRPGbGhmZMbU5Jt/3lwRbbXKDanpaZs728HAzc
	3alMVeRgXJ2iR9FGM736hItlyhfSS3xiHrbgruULfqzHNFsZyD5gkk7kV3iNSbyu
	YjQ5EriXu9D2IbhBtF8wycjmdNtwn9lLe0FzGOg0JvLa1YLzuB6r1fif6jgtK17u
	iw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4j0ew0rn5q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <gfs2@lists.linux.dev>; Tue, 17 Nov 2026 02:46:32 -0500 (EST)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-55ca34548f5so791711cf.1
        for <gfs2@lists.linux.dev>; Mon, 16 Nov 2026 23:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1794901592; x=1795506392; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=13gBg7QBW6VxUO230NS+TxRvi6Fhbsy36rbkemPFH78=;
        b=1TptSAx4kbt1hY8ifhJlFrVq0TrV3vT+DwEoeMdytGMMoN67MnfBln+9xvEpK1Ztb9
         gfixI20oUijL9a0sT2UAdW/axSOdMLjPrP7cY6LQj+LATQR+NLvNr3IYXuPlCeiUlmMd
         Q4f3J6dCAx9KpCkgnlGO8zD23xpIHvz+bGh4MbuKKokhUUzZosl9CgLbwgpFn5d3LdaO
         mlbKcL9Fulhn6HlncDsFdJ86FyxdtlzX0IAC43ovhCxiY/qrFjIjZd8Hk5ZSboYc0z1y
         HvuVPghUGzynBLpaS0NgYb/mJzzjg1eBABjg2GpKHavhdK2Ex1s8PVMtIwfKukkhmbGa
         h75w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794901592; x=1795506392;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=13gBg7QBW6VxUO230NS+TxRvi6Fhbsy36rbkemPFH78=;
        b=DFwb+gZ1Pw2ZtlPzbi4wKW0SEGCftclD6EhychENqLXb4Lq6c8jKigqtxHNPtIr0Wu
         C0YsncWq1gT5nTLiJBlZsM0eWtptDxKAXVzOnNCFWPn5VAUTFY3eQkAPa5OwOxoHQifT
         S1bTz4TLluys8l3MePZhtWf2zwOrt5Iqj3yYOX1p0yJdKZeI004sNRm/fs7QcHQlZoGI
         zru1xZEBdLm01tYnox202wEQiNcyMmiCqkkGkaRZDvoZgBpREX9ICEa4Kv8KKpeoAwm4
         oQnJCTV9smlwHlGyrM6a2MX+Gu2ibJ6QuRTQLCwuFQO2/OSDJnrYDK/Fetmz0/6ImrW6
         FlCg==
X-Gm-Message-State: APuU4Z/5GlaPB12tIn5II20wfarIFv3xyr3fA0U1UCbk31VNzo5PPiuZ
	1J2H09081tFo/dMeyM+g6Q0NGa/LDZYe0skgUMspqDKbO3Plb3mmD6qA8h0K48YrLmM5bvViccq
	KbFQedE0/beK8+mtZ7Od4Fp/q1AVI8O+cQbl+Fk6TSnK7IWHJKOc=
X-Gm-Gg: AYBFou0FOLAxHk0rKKHgX0AhuxoiV+MtdHtuHmwC68tuwVnWFH73AZitEKciJ7oYyTY
	z67NvakwzROehb90/cC6hdA9iPkT2CC1t6x6qmb0C1zhTuCHt2qQpmLgwJeFSiAysR9hpGSP+Cv
	tzqSu+MTjYSKcUQS+rOSd4aLCeFo0F3s5b+vM5+xB2s1+NpscwFUdaox2GUqFzIulEz8fEzoP2F
	y2aZuzjcxS0yRrb5AVMzspOYbbeqIcpQsee0wD577Ab3pLhpxLNxUcclJEIEX+sYa6ZdqQEeUhV
	vlxn/M71QUI6xsakIKna08gift/orZ3E98wssTKVgicFc8PrCj0bUIyBj/0bACwnDhfcpn9MNJ9
	/CFRY8541Igy0Nt9riUDM/gQUAUzxeajNy+hpQgFcwx0l/D4bOZVfriCDFd0pQ32tfmA23kVMrg
	HdapZ3/zeAI/BXtmoiXA==
X-Received: by 2002:a05:622a:1a85:b0:55c:fa5a:b230 with SMTP id d75a77b69052e-55cfa5ab36emr143284631cf.32.1794901591756;
        Mon, 16 Nov 2026 23:46:31 -0800 (PST)
X-Received: by 2002:a05:622a:1a85:b0:55c:fa5a:b230 with SMTP id d75a77b69052e-55cfa5ab36emr143284341cf.32.1794901591140;
        Mon, 16 Nov 2026 23:46:31 -0800 (PST)
Received: from [127.0.1.1] (dyn-160-39-33-242.dyn.columbia.edu. [160.39.33.242])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23db0f58sm105632286d6.39.2026.11.16.23.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 23:46:30 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Date: Tue, 17 Nov 2026 02:46:28 -0500
Subject: [PATCH 3/3] gfs2: remove the remaining page references in the log
 code
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
Message-Id: <20261117-gfs2-log-folio-v1-3-35db3db42e35@columbia.edu>
References: <20261117-gfs2-log-folio-v1-0-35db3db42e35@columbia.edu>
In-Reply-To: <20261117-gfs2-log-folio-v1-0-35db3db42e35@columbia.edu>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794901587; l=3235;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=I1OoGwa46W8CbYKC4H5ofZJ0hfXIdWRBljG1BL3y/x4=;
 b=6diQgVHk6GU2bnyJ7q/nrEUp76qx4EOf+glkpY27FpjD4ExEKSGR3OZbav8MHGycP1ctbesaP
 eQdSkHne4R9C70wmLaAuPo5kz3hd/Jpxey8KxyXFzjCrTEGnphorrrO
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Authority-Analysis: v=2.4 cv=dcIVTnXe c=1 sm=1 tr=0 ts=6afc0658 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=GaPK54s0Se3oFqK5NkZy0g==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=azVShVRs0zEubeQ0wG0L:22
 a=RLOwVVqb4wJnjAl-1mUA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: XXXrwLzzYYvjz_new_JvZ31OSmqaGUL5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDAyOSBTYWx0ZWRfX4RCRgG10sQ6L
 87XT5AJyIRVoP92856s6jT5hhw9lIdtC5XdVHYXysNIj0Z7eI1n33WQrpDbIBfgKmHdbMuCFUGW
 K7mmk4oxe2Vyexqv9OEvRPTSDZMX7QxEIlDRNNOij5oX3J+HisXTjGwTockAvyKx+bv29xHKCdO
 vKi4rbGMZLJAAxuGLlJrH8yhrLf3SH7ME+30vbm4gocYeNLMBHBzwBtCKsJ0xgsXgKMhJiQFSZW
 /TVx88rKmtEBIabXlnCkjgb/OeQSaonNxfQa4xzLnJGmy72Ak7gHwSesv4tCMxyymJHVy1KnE5P
 XVQI+4AkbIQxUSXlb851px4rclFAtzcm4G7Tzj5a9Pydt8RkgczYks78T3JUWiPjU2fSdfdmymE
 ol+8b4JNPBrg/BaEdQBhPhyLr66bGOqkq/91uk97tY2QbGkhtBggr7vMZ8o9VZLWnikfsAMkETK
 EWBQ+f2ynLzydP/vraQ==
X-Proofpoint-ORIG-GUID: XXXrwLzzYYvjz_new_JvZ31OSmqaGUL5
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDAyOSBTYWx0ZWRfX+2cx5PwX9x7o
 KGFNSgPg6kA7mBrPOJ07LQr1WxcnRHJGMpF1bH9WFMTZqHOVTKkDWCe/Q4LVpi1TfolBStoJdu8
 +GqrdxAN5tnhqh0UHh1BSi2a9+/srwbxqaZ+Z3PhMRhUoAq3Xc3f
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11968
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 phishscore=0 lowpriorityscore=10
 adultscore=0 impostorscore=10 bulkscore=10 suspectscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611170029

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
index c86f92f2e508..805466667e8a 100644
--- a/fs/gfs2/lops.c
+++ b/fs/gfs2/lops.c
@@ -446,7 +446,7 @@ static void gfs2_log_write_block(struct gfs2_sbd *sdp, void *buf)
  * gfs2_end_log_read - end I/O callback for reads from the log
  * @bio: The bio
  *
- * Simply unlock the pages in the bio. The main thread will wait on them and
+ * Simply unlock the folios in the bio. The main thread will wait on them and
  * process them in order as necessary.
  */
 static void gfs2_end_log_read(struct bio *bio)
@@ -464,7 +464,7 @@ static void gfs2_end_log_read(struct bio *bio)
 }
 
 /**
- * gfs2_jhead_folio_search - Look for the journal head in a given page.
+ * gfs2_jhead_folio_search - Look for the journal head in a given folio.
  * @jd: The journal descriptor
  * @head: The journal head to start from
  * @folio: The folio to look in
@@ -498,9 +498,9 @@ static bool gfs2_jhead_folio_search(struct gfs2_jdesc *jd,
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
@@ -517,9 +517,9 @@ static bool gfs2_jhead_folio_search(struct gfs2_jdesc *jd,
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
 
@@ -630,7 +630,7 @@ int gfs2_find_jhead(struct gfs2_jdesc *jd, struct gfs2_log_header_host *head)
 				continue;
 			}
 
-			gfs2_jhead_process_page(jd, blocks_read >> shift, head, &done);
+			gfs2_jhead_process_folio(jd, blocks_read >> shift, head, &done);
 			blocks_read += PAGE_SIZE >> bsize_shift;
 			if (done)
 				goto out;  /* found */
@@ -641,7 +641,7 @@ int gfs2_find_jhead(struct gfs2_jdesc *jd, struct gfs2_log_header_host *head)
 	if (bio)
 		submit_bio(bio);
 	while (blocks_read < block) {
-		gfs2_jhead_process_page(jd, blocks_read >> shift, head, &done);
+		gfs2_jhead_process_folio(jd, blocks_read >> shift, head, &done);
 		blocks_read += PAGE_SIZE >> bsize_shift;
 	}
 

-- 
2.39.5

