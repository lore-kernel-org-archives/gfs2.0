Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920A1242D88
	for <gfs2@lists.linux.dev>; Thu, 15 Oct 2026 00:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792024619; cv=none; b=sb0C8iUg8tWL2DsX6Fk/8ekvbeMlEiDOSbqcQXPjTXjs4eGeVsdaMOvDW/mWMOzxLKybVE4hunL/aZdtRWl3MUavWohmkiIEBURbWaHRyYiVjuORYFsM+Rn0/z3TEP4XejuOv8p4k+/QDjOiLkCmmHwY017bI8/X1sNv9BHjZfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792024619; c=relaxed/simple;
	bh=E0+VeT9tm+vZYltOxt+1BIvDMbhjzaTt6pQ1L2g5Hac=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ELmdHUzmfOvKMAogn+oW17jW8o+l5TdgFTQsOkUXLuuSFlOTYV6hP/zjHKkHn2Ti5fLmAcUbmsn8gAXGq6rueX11Iek6nbqg6t9WlK7Qa224ajqBxeVpkMeVQn3G/imriyn9A2b0cz15h/vu6buCO2B9dmTtDnYdsrkXQmmOtNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=aod3LhyS; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=lcn5eicK; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="aod3LhyS";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="lcn5eicK"
Received: from pps.filterd (m0167068.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69F0XLjN217666
	for <gfs2@lists.linux.dev>; Wed, 14 Oct 2026 20:36:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps01; bh=MBFZjRkNZaLoShz4icw9A3S4SC
	eyo+a2ZXrJLss9QNk=; b=aod3LhySZ+NXWVh2m0H2+yut1FEa1vAOQroJDPUint
	FEj6ttWUf5Lu+8EZmo7pedsBrNjplnHEt9zmNz0GPV9r9oryUjV5PoiJZM2TyQR4
	04p5vX6Xb7eGMkwHSACIQ99xhlAkfb3Dyp2kHE0TYw9gJGu9i61yArUvYd6bwpIH
	i5GKozMp0A8UThOEp1RCtoE3DlTbB2lT8PQEWQD5YU6+bNsZep4zzDTmB5EizRev
	0kI5O/luy9jNowfCc6PvlJppgR43ShHX8Dd3MtQFDvFFCMg64kR8Gh/hlsnRquOs
	SQ83EM1ecsQoEY3vj/SNoCOi5A+KhmD71lOvmT8BlPtA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4hafnsj6fh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <gfs2@lists.linux.dev>; Wed, 14 Oct 2026 20:36:55 -0400 (EDT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93cb98809caso812217885a.1
        for <gfs2@lists.linux.dev>; Wed, 14 Oct 2026 17:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1792024615; x=1792629415; darn=lists.linux.dev;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=MBFZjRkNZaLoShz4icw9A3S4SCeyo+a2ZXrJLss9QNk=;
        b=lcn5eicK+OLfC2eAEN4JyLKjBh0mu1cpgznf7RAoUFn+DRlKkYFmnKd8Tc9W0kaoJR
         /pQRbcH5uNEWoqa4m/zIQKiFbFWy5CWfIIC+ARFyBBzBE1ho4LKAj4qN0lRWiMLeQ+kS
         1j9dg6HcDKzdXvEE3b8K3+VxKLOjpXy8qygvDJuoL79HR7JdhlWGttRIcsJ8wBgzxqMa
         Jq6R8KzkFI5HrS7GYcvRoRmVR7Nk4ZHNCJjxiSMkkJ2bkrRep4pCDjSixnJBoFfjlUW/
         RJhMz/jCoNqdwB6kYB7vv8gsC9BoGSOsLqupfYoyF75okALstVeQYUy7URCJ+iIB0edW
         /XnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792024615; x=1792629415;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=MBFZjRkNZaLoShz4icw9A3S4SCeyo+a2ZXrJLss9QNk=;
        b=xvIv0UrUaNjAzFj33/+8MndGMlnHfxjYFCjxZSRbdqb7hKHDZCapXGcETo/BxUwsdc
         Y300Vf8PdhSnBTJyqPiADDUjevUTyY51BOTEBOOKzaLbtWYULvC8Vn4kfaZnq/mYnNVX
         WphNjce32ImEp9zUY9La6YQorEBxCTIAJuCvIZver2pueHZO0ZdMgkPdNikrApOv/ufO
         QhGRCxXSITgxpGVw8o2vhiIrMBbVcZVUwROtEa7qTlAsFcLnza1gr8Q6frd+aGgEWrru
         3c+N5LMMRwGA6cNw9b/z9550NCgv5/2Vakz6UWsGPLmLpRCrvp3ccmGh9W8uOonMpZuM
         GRyg==
X-Gm-Message-State: AFq9FYJEpGfDo+ym1tiSZdTmXryQRKshfjGyr2Kv4jyDGK+9OT63uVFJ
	/faOH0KDfH0mdXiw2a9v2qR28PRoNp7zkT22BQ1/mXqV3PdMfotdVoNCYVHSA10qSGrPpMQNegc
	utzMz41Hme5nFp5ml+/AsYbYVQZkEBp/P5fTjJoufXHwS/dKK4AU=
X-Gm-Gg: AYBFou328Ex2vwsBPdBGwHibSCJR3HHPWHMLMEJ46F2Gvq0tPzG4jn666iQDyPyds2D
	qlOjsSp99ewTbPC2VRVZAViosK6m15laZiB0+pQOIkvO1wlQ+ZL/Y5a0BTAR045k/OEA+5hchFC
	P9coJa1k5aOrB04of8gxxRjqo6cjdzwxj6ICVl5Q2A55LI4PDC27a84GCNhXUsobOVwKfcAROM1
	w0/8/PsyUw53aokplI61Fp+pFTYNWgIeTgyTdRO2wcz0UH0PaqNgbYgM2CXbwcpRquLJMZokYC7
	fFO7LErnefbUVTQwAwZ1TN12LAuhnnYJGAKMSFmfwGq/bSr7ViZTdVhw9ftQ5dv4LixgnpmVloH
	I3xAjq2QaDAHDQAmolOqCTpM+U2QoW6uHxIMJYWZOgN+o
X-Received: by 2002:a05:620a:3713:b0:93e:6ee0:c074 with SMTP id af79cd13be357-93ebd260beamr2867280785a.38.1792024614759;
        Wed, 14 Oct 2026 17:36:54 -0700 (PDT)
X-Received: by 2002:a05:620a:3713:b0:93e:6ee0:c074 with SMTP id af79cd13be357-93ebd260beamr2867278785a.38.1792024614259;
        Wed, 14 Oct 2026 17:36:54 -0700 (PDT)
Received: from [127.0.1.1] (dyn-160-39-33-242.dyn.columbia.edu. [160.39.33.242])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93ef50095a5sm630842885a.12.2026.10.14.17.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 17:36:53 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Wed, 14 Oct 2026 20:36:43 -0400
Subject: [PATCH] gfs2: fix the escaped block copy in gfs2_before_commit()
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-gfs2-escaped-copy-fix-v1-1-ff917ec48fcf@columbia.edu>
X-B4-Tracking: v=1; b=H4sIABog0GoC/yXMwQ6CMBCE4Vche3aTtgomvgrxULsDrAdoumg0h
 He36vGbZP6NDEVhdGk2Kniq6TJX+ENDaYrzCFappuBC550/8ThYYFiKGcJpyW8e9MXeta1Ajuc
 oQvWbC+r86/bXv+1xuyOt3xjt+wc6WjoQeQAAAA==
X-Change-ID: 20261014-gfs2-escaped-copy-fix-1055ded37add
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792024613; l=1502;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=E0+VeT9tm+vZYltOxt+1BIvDMbhjzaTt6pQ1L2g5Hac=;
 b=cptjR8Wi5QYajBKi+2dNzereqKLFdldPrIPDRcekAy3LT29s8G+h9DpIpWr8+FkL8erFn7Qus
 8HR7V17pv46DIQK7gtNc52U7+DONYjsDgZQ5QkgdzlGHmHSnwIYVIKH
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAwMSBTYWx0ZWRfXyGomgyLnvzuT
 HdHRj6CX7PZm8bfI/A4aitpSFiqLEz2tvlfkl8f7prZURTtziJ2IoD4MgdU7KqwaUoFWfZ4Xah4
 09IhO4u5WDJSmN1dxHlHQyCvxMCYyccIF64P+ZrlxYGvfnhmoJKlkXcPQYcxn21Yl+dLSD/t/4j
 pQwFFhH+AVbDXQnNOUeJWVJvqffs1HoTqmjM9e28rs5vLGOID0BigJhX7NG2kojKkS5A8CINGeq
 tYzSoSVAaU8yT82VVsQKCRO/gE/VNTq/bdmKoDonymPg53lXY5P3UjtVjCtBmr8eSpA71908Ur6
 hfnuCTBaNnGTakpT58lfrJX2j0QYj55ElGV5vc2C+Vr6H+5wzmCnQvFe3xdCunhIyWeTgWm2VR1
 kIeNZIah9pv+5YM0gG1J8oxq3uBDmQMfgtF639thJhzGrXzCF/PC+oCeSAMjbXSGCXA8QMqjlyO
 qaZCmdNjooOIoUOxHqw==
X-Authority-Analysis: v=2.4 cv=Mr3HeGae c=1 sm=1 tr=0 ts=6ad02027 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=GaPK54s0Se3oFqK5NkZy0g==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=usPcmh10W0ubT8QP8_c3:22
 a=VwQbUJbxAAAA:8 a=bvDx6QY01viD3ml5MkMA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAwMSBTYWx0ZWRfX0EcxO2uhcsPU
 ey0SCNAN0HyPY9UL6lPTO2EHno/08YlBjUilifgYh7Kt7TNzYuwal15tZd2tdAnGynyNAlJB/pr
 IKDnwX0Ma5JGfudarfSSthuhrdecxOTpr7IFvfy7MTZ5cqJCj7Eo
X-Proofpoint-ORIG-GUID: fxhTTZajvREDqZscPjo8YNB0mlMADntg
X-Proofpoint-GUID: fxhTTZajvREDqZscPjo8YNB0mlMADntg
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11935
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 phishscore=0 suspectscore=0
 impostorscore=10 lowpriorityscore=10 spamscore=0 bulkscore=10 clxscore=1011
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610150001

Commit d68d0c6c3fc7 ("gfs2: Use memcpy_{from,to}_page where
appropriate") made the escaped buffer copy read from the mempool page
it had just allocated instead of from the buffer, so the block written
to the log is whatever the pool page last held. If the journal is
replayed after a crash, the block is restored from that and the file's
data is corrupted. Only escaped buffers are affected: jdata blocks
whose first four bytes match GFS2_MAGIC. Copy from the buffer's folio
instead.

Fixes: d68d0c6c3fc7 ("gfs2: Use memcpy_{from,to}_page where appropriate")
Cc: stable@vger.kernel.org
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/gfs2/lops.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
index 77ef22eab368..16fba2108a4f 100644
--- a/fs/gfs2/lops.c
+++ b/fs/gfs2/lops.c
@@ -689,7 +689,9 @@ static void gfs2_before_commit(struct gfs2_sbd *sdp, unsigned int limit,
 
 				page = mempool_alloc(gfs2_page_pool, GFP_NOIO);
 				p = page_address(page);
-				memcpy_from_page(p, page, bh_offset(bd2->bd_bh), bd2->bd_bh->b_size);
+				memcpy_from_folio(p, bd2->bd_bh->b_folio,
+						  bh_offset(bd2->bd_bh),
+						  bd2->bd_bh->b_size);
 				*(__be32 *)p = 0;
 				clear_buffer_escaped(bd2->bd_bh);
 				unlock_buffer(bd2->bd_bh);

---
base-commit: d0c4bce31a579216780b990a09250f15e00f38ff
change-id: 20261014-gfs2-escaped-copy-fix-1055ded37add

Best regards,
--  
Tal Zussman <tz2294@columbia.edu>

