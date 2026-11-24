Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.139.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795554274;
	b=jN9ewNz1WKorQnTBdUCvBnmS2Es4lC6S2bMGg6mEUG2JCYCXtzdRWddmIpSvCG6G/aQy
	 t8yrHJtoSnu+kfUiqR1jqdWedLxyMpHXs+DItPUyT0dCjgy2Sb2lI0IXEFvRF6Cp1sGDR
	 o2twKHSgmo2nJYDk9tYm4oxCzUVMb5pBUqwODM+yOltB8KgWY90XQySG1v4MJB1bKYM0k
	 ZAxCvGBA/v+xQJu6trRzrwBrGLOijgC0zw2MclgV/9Pqxa4OuNNsPSDeOkqx6hJvKxXhd
	 S3HSmZrGqpRJbRRLV9hs8ZCQX9VO1qXA1sTFDWL2Kpz8fsit/xS/5fP06j0BABkScOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795554274;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=5yCOWfdW+sH0T9BYwqdnPRj1Lb92cHfiSwhCHRCjMaA=;
	b=wjuIdN+iJoY+4jWei97wr2konzGPvKSk9o4WOD3mLEm83TuyyzsC+Ip0KVrizUYRgljb
	 d1GXl3RWhwTBkVgU7VGrmZjD+YJFW03YBUGMxsfu9yvPMkarW+DEElOfgRnn+TzJvGDpR
	 f3QNWyIUqeYfh5rb2O6XSSk0c+bOYXsK+OWxwtDh/RZ0YvSnkO8sNW+7zz/R0IPfC+9lB
	 0iYBgIxfNGgoWECE6bkLhwvh7eu6plf4Atl0dywbXFSSTZ1+EDvqwJ71EtrYGI6hs+7q5
	 fNcUF8pNqQuzx8UKAqtyRBKKQ1hYlPwXa3vfrQBT3cyywHO+DSb5xUWSS2DhnvNocUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=kR4zlwH+;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=GHf5IW8r;
	arc=none smtp.remote-ip=148.163.139.74
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9ACA606A335
	for <gfs2@lists.linux.dev>; Tue, 24 Nov 2026 21:04:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9ACA606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=kR4zlwH+;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=GHf5IW8r
Received: from pps.filterd (m0167076.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AOKabq1066178
	for <gfs2@lists.linux.dev>; Tue, 24 Nov 2026 16:04:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=5yCO
	WfdW+sH0T9BYwqdnPRj1Lb92cHfiSwhCHRCjMaA=; b=kR4zlwH+KS2IQ7SR+/Gr
	Z0AKidm2HBNBikjS/6jxfVyXGmmH4yW2IR4EF0eUKUDfdzUQ4LPW9tGd1aAhMDr3
	NhOIMd8tdNTPIBThvIUJpR4zBNbxzCMuablpsK5v8Vf1fY6YWJoMu/uIbWTxGJ4e
	vIVYKhgGGzyNIH2mFH1p9yNbduw11ETNhszBmewdb2BOdGoV3r2SDpO9fEIP+t0J
	Efn+W+ETNI6OVMX2Vxub+ayViubrgKLCFfr1GIiMd1v4CPqwIp/FgabTIUXPmZFx
	cEDDtxw6YPpS4S5lmx3HJeKJHWLOSNP1ga4v2HUXq3Wx3XcbtE2Un9ZPv2J52FlI
	Yg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4j5dsc2u99-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <gfs2@lists.linux.dev>; Tue, 24 Nov 2026 16:04:32 -0500 (EST)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-9210bbc04abso96998896d6.2
        for <gfs2@lists.linux.dev>; Tue, 24 Nov 2026 13:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1795554272; x=1796159072; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5yCOWfdW+sH0T9BYwqdnPRj1Lb92cHfiSwhCHRCjMaA=;
        b=GHf5IW8r8dQLUUIzgh7dD9NMcDftrqfJBlmDHvn6q5WkLw/V/ikeD+Xd+DGbXqjG4V
         /nIK5QePXtOM3k5BtQoaHxsL32yzqqALdNL3RfrkejW64TSvCr/10CdFnUVdwNOpB4Du
         az8ia9vsbWVps7ZkVaqE4Ie9uTk2YDa8VTPvvkce5IeSfT17HkHl2Ie+X7hQRmhPW5r3
         XVkrskojzCCY3jj4rDbTtZP1uffjAQh6bzQTXA/5P6mVp7uhAuCqxvwYtjnXfhyodsK7
         dA7pcuOzZi5h7QsAAWyOAA6kpF5s1iF7ADNuCWFJumZyDWpUqw6Z0pajpTX2HZ5ZJLN5
         x1tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795554272; x=1796159072;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5yCOWfdW+sH0T9BYwqdnPRj1Lb92cHfiSwhCHRCjMaA=;
        b=ajAhRJmdXD4dpg+JrswDeWaGtQp4R7PiZbk9W1/OSJwru7L3v72RfpjS90La2tnGTN
         b90TjCAmiwhG2fqZW1bOyav8UwPe+XNKMtUeMg/7BYXorYwBF+ic4KrGM91RukCDfp7M
         3zm7J/CInb17dZYs3+u9aIBCN/NDV4TjhPTrhgFcLvE2kYT0MQmJHrUru0yV+70AN1aA
         vAbKRc2E9FtH+mgZJCXsC97FSmjLnbmIvpQc14GUYrrOm6E03HdM+sNQZl0icUuIKAtS
         7CDkJEIIHhXVHdEluUofQFC4vtln1/UJ0ydcfLqaAQdD8ThYTqWLqSK3rhovtwS4yUxI
         3ryw==
X-Gm-Message-State: APuU4Z+QjztgAc1lWotxFjOrJm26cfM0vPnsJDqIgw6Gso5Jynmfe6md
	Yc/qdWW9kmO1jPFJUL26odoKReVRzmvSTeQkQYamhVZRaI61FWzTdSHqKrz0V8nrp5vAGqmFAQW
	fpYq0PUUaqGb1iL9WJFaBT2iwnvUjBZjMvMEwy7LjAt1q0dTx8nq0JwRpOwE=
X-Gm-Gg: AZFdTZc3W1uBvsrJjXaVgAUKWW1JPrTHVfWCYBr7Yra4ob9c9OLZou2pY8bKK5WSgIr
	RjoU6wsAwkGwwUj+C6SmADc/vnLsWwXf7uL2YztEF8pp1lGpzP/c+P2bEpSf4h7JYvk0Fxbq9+J
	04CncRy9MV4dRzfCz6Ccz5HwPNA+m08jagiThSICgfkx4OJGY+fwwzFbprngASxrFePbIiSX3gy
	Rlc8EwoiuvudpPP9fFCvL9MpT6FKEg6TVNrMMiqL3foyrHhAt83y7yYmfMA0uvXjKfbwSjH4GeX
	5AHA83WwhTak/+p12C+m5KJNSJqiSs6FkD6CzgnnSl9jMRIxaHGf9xs6C9A+06ZW2FRQhw76+Tc
	MdagdxsZ4uv3Yy/Na5YuobyJCD6QVbxMTJ7LRHg1tvnL9SFE7SYSIX+lmS0A=
X-Received: by 2002:a05:6214:808d:b0:921:19a:e11e with SMTP id 6a1803df08f44-92134b1cdafmr241718056d6.25.1795554272027;
        Tue, 24 Nov 2026 13:04:32 -0800 (PST)
X-Received: by 2002:a05:6214:808d:b0:921:19a:e11e with SMTP id 6a1803df08f44-92134b1cdafmr241717756d6.25.1795554271604;
        Tue, 24 Nov 2026 13:04:31 -0800 (PST)
Received: from [127.0.1.1] ([129.236.231.128])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-92134a0a454sm142827326d6.35.2026.11.24.13.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 13:04:31 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Date: Tue, 24 Nov 2026 16:04:11 -0500
Subject: [PATCH v2 3/4] gfs2: plug the log writes of a flush
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
Message-Id: <20261124-gfs2-log-folio-v2-3-f229e90c8285@columbia.edu>
References: <20261124-gfs2-log-folio-v2-0-f229e90c8285@columbia.edu>
In-Reply-To: <20261124-gfs2-log-folio-v2-0-f229e90c8285@columbia.edu>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795554268; l=1958;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=bqNWp6VHwFxSol3mEB7RPaULyNIreDqDGAAxEyCt9po=;
 b=AvTLNjefB7jlAaNoWFzca2dDj/cCGWsPgcMlGuY1CBjfFvlRFAVWqp/L+5hbgiksGkL+R5Gm/
 BawQBB6i7C9BSqOJipcyGZCSONXNVCwxX1VG7HeCKajOwLZJaKjlv8r
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA4MyBTYWx0ZWRfX1CISn7/1oUyr
 6RC5/x6ZPj4Fh75VerwP/osf0JtMzUwt54qIoyJwEtnfyuOXZgC16pVEH68164VEtScHxxIKbe1
 p65iaZtj7ySp0Ko+2JZQteGKAQtZHlvYu6wp343LAm6QUqXQK5axFLS92Y8zeOaaUgFKnXN8dt3
 W4D1U+fCS2wECZ8DS8tbl5xtN2KS3gAlOmkMjDqzOZnivxqehIVc3UD28X8GTFlCYKRrar0tGDm
 mNV/69kc5/RX9xxHqfF8eKLWBixBqEaNwlRxSB0dbT2Svy3I8EeqS9W1F8mVkzCFpHjfIgSfrdQ
 evLHuvkG609NrI9cGLQo49Gg3mKHAQRF1sYeNqB9GznOomoUevX8fzClH+HUHi0w7aYJoN29xAW
 O8yftDSH9E8BIycnMqs35sfR/EC4L3X46rsLSNw10/jIEhicvDL0n4bVo6/fuTs8A6mL1+MguCG
 AIzgKYh8nwRI/WUoO1w==
X-Authority-Analysis: v=2.4 cv=de4VTnXe c=1 sm=1 tr=0 ts=6b05fbe0 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=LNQXEAmb7IHcZyFqmLK0PA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=Qm0qsxP7aFY2tkT6R2MF:22
 a=69gLQDoYLLJtuS-kOWQA:9 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA4MyBTYWx0ZWRfXyS/93eLGvlbr
 /EN7pFimzXvkuZ5of4M/mdQJdZcRST++iGVwf6bn59KcS6ufyaZzM/vbiEpVViXueT68FiFaL3A
 R29I6Prcfduv9mU6+cD0nA7Oa8Nzsk+7wwLZDSYmxVX1y0HTEHuW
X-Proofpoint-ORIG-GUID: 0ukVrrm1Hy4J2xOoPOFDAzrcuSthzhss
X-Proofpoint-GUID: 0ukVrrm1Hy4J2xOoPOFDAzrcuSthzhss
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11976
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=10
 adultscore=0 suspectscore=0 impostorscore=10 clxscore=1015 bulkscore=10
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611240083

__gfs2_log_flush() submits the log blocks of a transaction as several
bios. lops_before_commit() starts a new bio whenever the next block is
not contiguous with the last one or has a different completion handler,
so each descriptor block is a bio of its own. Most of these bios are
contiguous on disk, but the flush does not plug, so without an I/O
scheduler each of them reaches the device as a separate write.

Plug around lops_before_commit() and the submission of the last bio, so
that the block layer can merge the contiguous bios into fewer requests.
The log header is still written after the plug is finished.

With fio 4K write+fsync and no I/O scheduler, this takes the write
requests for 32k fsyncs from 229.5k back to 196.7k, and the p99.9 fsync
latency on null_blk from 51 us back to 41 us.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/gfs2/log.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/gfs2/log.c b/fs/gfs2/log.c
index 2f9f20b40adc..f7bcbb51ebe3 100644
--- a/fs/gfs2/log.c
+++ b/fs/gfs2/log.c
@@ -1088,6 +1088,7 @@ static void __gfs2_log_flush(struct gfs2_sbd *sdp, struct gfs2_glock *gl,
 	bool frozen = test_bit(SDF_FROZEN, &sdp->sd_flags);
 	unsigned int first_log_head;
 	unsigned int reserved_revokes = 0;
+	struct blk_plug plug;
 
 	trace_gfs2_log_flush(sdp, 1, flags);
 
@@ -1148,11 +1149,13 @@ static void __gfs2_log_flush(struct gfs2_sbd *sdp, struct gfs2_glock *gl,
 	gfs2_ordered_write(sdp);
 	if (gfs2_withdrawn(sdp))
 		goto out_withdraw;
+
+	/* Plug so that the contiguous log bios merge into fewer requests. */
+	blk_start_plug(&plug);
 	lops_before_commit(sdp, tr);
-	if (gfs2_withdrawn(sdp))
-		goto out_withdraw;
-	if (sdp->sd_jdesc)
+	if (!gfs2_withdrawn(sdp) && sdp->sd_jdesc)
 		gfs2_log_submit_write(&sdp->sd_jdesc->jd_log_bio);
+	blk_finish_plug(&plug);
 	if (gfs2_withdrawn(sdp))
 		goto out_withdraw;
 

-- 
2.39.5

