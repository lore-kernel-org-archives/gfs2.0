Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794901593;
	b=lHonnKg13I1txfvEoIZpIxEHxiDHcjrBVw6s9rbX3ez6T0WuFnRAKNFJj9ZwaKpW3h6h
	 je0t9wjrcvr5qjWBCztuUBMYyqGxRfUxGYgZVAa1ad8b7g654FxwP6BLQSsWT9DKZFJPX
	 kRDxbsYhYEj5AUgzGTHuOn24LWiiMJWr+lCXUaRw1rLnMVX+tNCb1TL2nAmqdMlqIM7y4
	 Wm8GV2h5XHzfCAU4tXEWmxUlMxVdCMyffxLFA98K6/Tps8Ycf6EnvB2PO49+OKsTRpj94
	 0M/8AIHbdvJUO26eNL6bAhNDSC5EQyobmOijbw95iz3u4JPRmtKlZHFbp9RZJHGbdtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794901593;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=eux7kOFR0+YMJVkRb3ZXeOrx6EPrM/mga9ca7cOzUGk=;
	b=OB5DFF1a8z30Tj/SJXK29a4jGGlPvFdYjkJc0e/0lHvnXCdm9yNAapQEAVzWHPT8abkH
	 974zAvEDRAfXBATDVNLNTxFR15XM1fp+D1u3snk+WOI3xz48fIDM6hmNRB59aiSFUZP3v
	 i4Z6wMB6ebcB3I4CLY2reuVpN1LS9Q72eoIX3hZggt8inDnL2r8mPmc2KxUpYMjjGQDdZ
	 /kLJ6QNUPxF5x7m4sDvtg6hCxPT5vHgzSwdmy9PJtRkX5Z6sQJ3yNzCepaWZw416t5qrS
	 SIZ08a3f3yvGavVvhSHOmIec3x0O/mKvLcW0vjLeKQk3Y5PgmmjRHxSdMxotdIi5QBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=f0C2V8ft;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=n487HrEu;
	arc=none smtp.remote-ip=148.163.135.74
Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADF1606A335
	for <gfs2@lists.linux.dev>; Tue, 17 Nov 2026 07:46:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BADF1606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=f0C2V8ft;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=n487HrEu
Received: from pps.filterd (m0167070.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AH7aQAR336658
	for <gfs2@lists.linux.dev>; Tue, 17 Nov 2026 02:46:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=eux7
	kOFR0+YMJVkRb3ZXeOrx6EPrM/mga9ca7cOzUGk=; b=f0C2V8ftf4ZmZTjuPakq
	pxe8luiZDADEf+o0XawEuZ7h14pgLrzPf8z5DURfygp4yvnAEnytmVP3LqVnRlCG
	p1bhk0D6e3GuV/UdPPAo42ZaQdPIld7bC3exOIK3N7NgW9wWZXPoamRvLw+Jt+ot
	oCR23uzeoF4YUYA/K80hrf3YeFwYKG6xecua5cdsrQOz7iw7oIvRa3j3PN1598fs
	qiTevVSdraL5g7Ketm9Oe8UiJYv5vI9hR8iCuXAbb6SZrFJc7KYj8ZIdgLmt1z29
	8PtbU/A6NSprffu4pM1/4sq2gHyEBfZ8bFzVnDq/U7zM0uehQs+8+7868bhGVIYQ
	jQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4j0drw8x7b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <gfs2@lists.linux.dev>; Tue, 17 Nov 2026 02:46:31 -0500 (EST)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-91ec6cd898eso91462326d6.3
        for <gfs2@lists.linux.dev>; Mon, 16 Nov 2026 23:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1794901591; x=1795506391; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eux7kOFR0+YMJVkRb3ZXeOrx6EPrM/mga9ca7cOzUGk=;
        b=n487HrEupGo/fK2Fb5dCYYxBvUwUgez6GAXKMNs6eU6QghIafl2p58KEue4Ffzff31
         ch1VExicSqUiN3zT8Asim1UkJw969/0iFvL23fLU9rKYTYBbBg2jUATKZ6iAH94tEurm
         bSaBa5UoYqo03mVKG0xsv61zz2QNsMiUMVrwPj3qsM/zmn8xZnkiSBttnktjSJNPVecx
         z36qtLZ3BClq42kXOzwcV53n2adufZUDmgUlaxTUoIu1ERzsCw+YnlEYLzIw2soaD0jx
         6CpyPHjHtH85hlPmKY9iOC8Pikh75bxReVaYZ+wSUeuyxWAxkyOvyi5FTTWg1AtSvr/G
         grTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794901591; x=1795506391;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eux7kOFR0+YMJVkRb3ZXeOrx6EPrM/mga9ca7cOzUGk=;
        b=pREWM0PRGd6adbjv9F493WeejiV5tu/4DD/DORA+FIf2vKow34tdClCnPBLpGHO+eY
         ZwseDLCNSp/h6UuQHxcgBpdOrehqvyBxtbbDA5EsQizsQSC/WDq/e+SG/t9f+c4/EuOz
         M3f4stS7JnEpMGezU2cTpFMt2qKsfYFEwobVLriZVU1JEM19SRLZrVie5anGdWY8ECiP
         VuEI1FfU0h1meAEJrZNOoX1dEN8i0F7qXj4gVsCfQqf4ngo/9czZI4CdMh2BCJ4sqnmH
         rIVaenFm2msK7nq6GgFrj2/1CYuhCGngvkmUCSd4bNXijipIUfkdyzhrDXT5+HIVsdhG
         Zy7w==
X-Gm-Message-State: APuU4Z+QqpNzbNDKcirEF7c1E5vFPqFHran+zhWNygeQynnvKR68dXgF
	36Ipb8JXBn+R1vXaqlwzQQkj5L9RFlthebuOoSXJ1ShDA7ufysPtxho+LoI1qifzaxepIIrZHdu
	5cfrpW0fpA8IxM/ypfrovxAjQW2Aq+W6gkVzODnMfgfEDY24XULM=
X-Gm-Gg: AZFdTZf29Lcrp+hg8Xhz0xP2JYeB6D2q74jNETIf/HBrfttc+JYivwKwqTcQZfVqt/P
	iLo/zEfLYNnP+Z/YaOoCFJJwyLEBWvHIETzzCt1wP545Cdz12/qge+mzVi80hpyNZJztnoPoxU3
	Nshi4JEWROEDnh+LMy2TemIrYJ2vjnCg4pn6crUNwQrMJGBubTx6UVFXumFO9i4b9HKLP3izqUl
	U6D4hloATBEaMRd3OV1KZp/ChgAQ77xLVE7xO3KXcfs5XXwMhB5CMBUOcPSeKIOulynwVbnZJEa
	LywTiGgPxH923WA2m1BOX/iLlvNyFhbtYeeP83LofcFqAzOSdbNeeFn0H1sVbBUGRSFCYhTUbRm
	59q/xrFGcXRxIAN4LS1fL+aBYZyYW/S+tz1Szuh/XuDSqezASBEW+3S9pItJycn9OC0XLw4qhj+
	Qev0Ikgl12JdWLaxzT2A==
X-Received: by 2002:a05:6214:4506:b0:91c:6cd1:8058 with SMTP id 6a1803df08f44-91f2418bbffmr205429146d6.13.1794901590788;
        Mon, 16 Nov 2026 23:46:30 -0800 (PST)
X-Received: by 2002:a05:6214:4506:b0:91c:6cd1:8058 with SMTP id 6a1803df08f44-91f2418bbffmr205428896d6.13.1794901590408;
        Mon, 16 Nov 2026 23:46:30 -0800 (PST)
Received: from [127.0.1.1] (dyn-160-39-33-242.dyn.columbia.edu. [160.39.33.242])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23db0f58sm105632286d6.39.2026.11.16.23.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 23:46:30 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Date: Tue, 17 Nov 2026 02:46:27 -0500
Subject: [PATCH 2/3] gfs2: plug the log writes of a flush
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
Message-Id: <20261117-gfs2-log-folio-v1-2-35db3db42e35@columbia.edu>
References: <20261117-gfs2-log-folio-v1-0-35db3db42e35@columbia.edu>
In-Reply-To: <20261117-gfs2-log-folio-v1-0-35db3db42e35@columbia.edu>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794901587; l=1958;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=vcAK97ti8eOI21AjNZH7KTwZn8FBRACshzWgbyOzMQE=;
 b=B1JxC4mWrRP+qGn8YAdgYwaqpg/5hUgBfBXd2REKqjknNaDrNqsMYv9kgcImWCv3B5qV8Cx1M
 /VFzvVOH8M4C5TrfGMBNTQGlVlnShqANL+g36h+ZtZ9rhohfED/50AF
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDAyOSBTYWx0ZWRfXwws0UEV+6g9o
 qUnv/tpWvlvUz4CTxmPngObwpf5kEaT0acI/Wq00bbnwrLj3V6zXEnKeKH2MHS6UsovBay1kiFf
 S+CJc3u4j7vrosrclupMiYif4NThOXbuLJvi7ErlV+jWnYoOpCa585IhGR5JoAHIMFxQUVMli7a
 3jGL1bIsVttpASjhj7od9bVa3hJKFcARTVUPXEvgi9+rgnWQUKpAOkXKh2uwB7l5li7nClaK/3D
 FYgznEeeMN8IQg2R4ztd+cxlNsjyOZwjHlDn1JsgLnAY3aSfLhTpADcn+kgkKR1Hs5cIV4qDUa+
 37CnhrOOD0nPENugPTPVC4/VfAOewFRQjqblbIbjB6uDFbHRaG+jfRx/n9Ou8+sL1YYC5eYgu2o
 X9r2/1XpObDm4tegwKkLpzDv78hNBxa/XdRv6WAGTyc3yR16t3wCrjdbeKSjZIzAVpZHHQPm3bi
 eQakaz4EOJ+vlGyG5mQ==
X-Proofpoint-ORIG-GUID: lVDDO32pZ6D2yQZt4Hrq-f19GLrT7eCh
X-Authority-Analysis: v=2.4 cv=NrZE4MdJ c=1 sm=1 tr=0 ts=6afc0657 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=GaPK54s0Se3oFqK5NkZy0g==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=svvvyxlR1OQQkelhaPoB:22
 a=69gLQDoYLLJtuS-kOWQA:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: lVDDO32pZ6D2yQZt4Hrq-f19GLrT7eCh
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDAyOSBTYWx0ZWRfX3+/rBfL6+9Oa
 tsOUS3q4YtSBt/qVjbkiXR+eJ5jsuYK3lzoffkyjr5ictNSbggMOMTDlZaBbXzhvFOs/htWaJW0
 heSEaiBlS9VbNV4sPboqx9RpEk9ZtZmFrHjle2kE/zvlrANUctW3
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11968
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 malwarescore=0 phishscore=0 lowpriorityscore=10
 bulkscore=10 priorityscore=1501 adultscore=0 impostorscore=10 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170029

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
index 238f6655e15f..9b05db20921a 100644
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

