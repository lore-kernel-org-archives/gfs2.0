Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.139.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794901592;
	b=CyAgaupz8KK4JQvAQKRdu/kIEVPHJ1AYy+VI6gUXxyXGCT3PVrS6RW2bT+3m5RiNcC8P
	 Ys9oeqCkWGEHOOAgXFNyYfTRvxC7YLUa7ny5XNV5UJyYz5fN4kAfTEEw/ZhKw2/KY0q01
	 Vf5jiCOH+j6pmw8xDtUv8FKvSFUfnlgFKCIUanDxDMDo+6uBoQaUteizeBwZ6Ve/HexlC
	 W/xhb4sSRCaCiPN95RGoD71y5XzIILkmBYsjIc8AIcM3bUPimP3Sxs6aKLVwdovkH3pt0
	 IjcR1m4NeYHMJSPDVpf1yribl3gCQUwaIYXNEQXDR+mtozPOO68Ve78x3xTmjuZiBTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794901592;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=WZc+/VLh+KD9epaQzIGRgWflK50EfOGmCzfwggbHQ5o=;
	b=ZsodEdBHKg6uQh6elAKGTOmFnEDe+QBgdQP7wxW3yodyDjisDSjVDURdCGuO+a3LSS8q
	 DGPTc4PFdGguCR9yUk2QO04cZcKcGMnn/9Dhrp7dp3Ru/wRBWuXxogA8EpZXc/sm2fs8X
	 oXFwe6FhDSq1n8pmPkDREJfS6MG+Y6zix0Fw2r9Rs84DjDxuPQx9PjJsrnKa7SlXvj90h
	 EFDFT2P0B5+BBwUr9WmOnJzsEvv/U32+KImXV2sDRlxDTFt7fmWZ0KSPVoOHKMSr1NXUK
	 yVaJjGgkiXDmSd0iHKe2A/obT4mhWTkcVFfEsR67qzaew4mc/MX4hZheVeeT9PxQXoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b="q/4x+X2A";
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=hsiIhlpf;
	arc=none smtp.remote-ip=148.163.139.74
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBD6606A323
	for <gfs2@lists.linux.dev>; Tue, 17 Nov 2026 07:46:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5BBD6606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=q/4x+X2A;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=hsiIhlpf
Received: from pps.filterd (m0167073.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AH7YQeo1002678
	for <gfs2@lists.linux.dev>; Tue, 17 Nov 2026 02:46:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps01; bh=WZc+/VLh+KD9epaQzIGRgWflK5
	0EfOGmCzfwggbHQ5o=; b=q/4x+X2A9jCg+jJR+cGD12JIosil2bPp9Ov2IqOofy
	CBrVDEK1HmOiTHlyqDIhqwTvc+jnAPr4hHHIfvgkwCM716BHCamG7Caz6N6kcjoT
	5asIJWFfWaf9drQ3r9phmANHLMfPYSYriBLgNbxbrOpKPxmHEZ/hUBMYDVLBG01O
	ZDNKXuwm9rXn82UIrzaBVODxiy50o4RRwe5/BAEpqHEUr3VmcFgZTBR8/YRRSmQ6
	vHO/JRJ7teOfuFeee7tpZSz6mnBiQs+Bq0Tqygvy3aSx17JWTbUZYqO5GXFoGODP
	d051E2h9BrZ3xu7f9VwvwUBooaj4hzQx5hHPrtByi0ig==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4j0fk7ggmk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <gfs2@lists.linux.dev>; Tue, 17 Nov 2026 02:46:30 -0500 (EST)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-55d2f5f1e1dso39177491cf.3
        for <gfs2@lists.linux.dev>; Mon, 16 Nov 2026 23:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1794901589; x=1795506389; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WZc+/VLh+KD9epaQzIGRgWflK50EfOGmCzfwggbHQ5o=;
        b=hsiIhlpfZV9fHh3V5UNVxsj9cFH4Mao92YoWEmoBaxDBWwaIiAC0LkD/UBySgfgCI+
         cLEvs8PsM53zevjLXrP5PdH2iTmICYQyox5fjoLZpeetwwxT8OYhW5P3adrSM/BZ3dLr
         57mwAhsXqCwkXABZTm755NMPC3RS1RVMzRmFbwIOmkxs4Hq/2Zi5bzs4lJLfVhbETp8J
         5wprnmsmSmY/RXcbL1uJmQ3YTw8eLWWrSiS6SHY3hEWlTq83V5BtTBcrD3qJZ4EG9OdT
         +p3Mr2b+fMZnUtPTgScpSattcVeNDSz5uj3ZqB4VTBj9PdPIko3Hcj56IeKXLNoSqcr1
         wlAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794901589; x=1795506389;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WZc+/VLh+KD9epaQzIGRgWflK50EfOGmCzfwggbHQ5o=;
        b=TJ7/4YyZBHQvtS7ZeYiDKXjT6ml7NwsNS4XeLSFoIwhHu8GJ49sVelcKLcFPHc2Mkp
         sqhsqIf9pBWZhIh4sNSG3pmXOPD0SRLimHFE5FuMRfNasLU361pLrKXhs57+90DnbOwx
         GXT8SA0XyAgxmvID4lkMRfMV2K7lyKZoikGIodikt9HrqNPmsANWm2ySVhcfUMEJ7s/g
         QKCpDsumpvww7fLpAW//ozusdRxwk2sXa2rsFSvF9yLY7bs3jfMfDGX1xiQsre9e5ikR
         EWkhAfO0gX4ZqpEFUGpeRhaSvEtCag36+r6ZF4jKabCcFsDaP2WTX2EsVZgnJVwEgcx3
         z2kw==
X-Gm-Message-State: APuU4Z9UXG/TBChCbfQPPAbcz3HwBpjpy7fwZTiU10pbKmoyjSNlO1ti
	ndWRipfnm1ofdW8uhoY4Wu//nF6lyYeIYFYHpwwl0MwNMtNez0V+zpFufkyo9wMv10ofcfKT14x
	lNRHzJ0pQNXt6Q9BDrT7y8I3G+RitdWtiPqH9ICjwchnTCjBFx44=
X-Gm-Gg: AYBFou0JF1vrweN2aw0nyiNnAF7qIrG64mwkC6AMi8kIrkZuZ/+NCSQCItax2lasiCi
	DoCSMBsD33daSRBe4kDTFUjkssajJHqOzmxkmlZ91Jdil2xcTsQ9lWeYpBARJIgv/S46CdDOaoy
	VBfk8tzWa11Ku4g0XKyz5uwTdlCrKSbp9t1DvxTIfP08AENU1d5gxxg2+69w0Vhi/CR4ZpNuQfu
	GEQ8XvjdRUD3Em3z5VXahvfWl31VuGI6hcN6e3L0NLeQheQFbnT1HMI1psolhDhMhxXV/ukcZzt
	OM1kniKCYtX4e72qyeM8YRjWVVn/C7kcbjHh59QxszRTe8PDcHuEvVwlkky5atP65mn36Vk2brG
	L//J1MCZt1Bb6seamreJhMeVco7PLNzDoUO5jAMgt7df9QeG2InavB//8BvU0V5Ii3/mKeaOlVy
	ddJyDCPLYP6LEY3QjbRg==
X-Received: by 2002:ac8:6f13:0:b0:55d:3789:8c8e with SMTP id d75a77b69052e-55d37898ed8mr93778601cf.15.1794901589473;
        Mon, 16 Nov 2026 23:46:29 -0800 (PST)
X-Received: by 2002:ac8:6f13:0:b0:55d:3789:8c8e with SMTP id d75a77b69052e-55d37898ed8mr93778451cf.15.1794901589048;
        Mon, 16 Nov 2026 23:46:29 -0800 (PST)
Received: from [127.0.1.1] (dyn-160-39-33-242.dyn.columbia.edu. [160.39.33.242])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23db0f58sm105632286d6.39.2026.11.16.23.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 23:46:28 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Subject: [PATCH 0/3] gfs2: stop using struct page in the log code
Date: Tue, 17 Nov 2026 02:46:25 -0500
Message-Id: <20261117-gfs2-log-folio-v1-0-35db3db42e35@columbia.edu>
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
X-B4-Tracking: v=1; b=H4sIAFEG/GoC/yXMTQqDMBBA4avIrB1IQvyhVykuTJzEETEl04og3
 t20XX6L904QykwCj+qETDsLp61A1xX4edwiIU/FYJRptdIWYxCDa4oY0soJTWddb0PjveqgRK9
 MgY/f8Dn8LR+3kH9/L3BdNydZAQZyAAAA
X-Change-ID: 20261014-gfs2-log-folio-274b84f5cc07
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794901587; l=1803;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=tlhF4A7EMIMf6AAglL8ZpZxXbchaA9cld4o5Pjri+58=;
 b=DjO+3wYuNu0XJp9/o9HcDi4gqxeDxmHt7BUTgW7DFr/6WqSaIs9rIcj+qGMzuvR7vkJHBcyub
 JfTil81C+AlCVIVYbbaH8SVDSk7fAR4XcQd+uUqmdXgixHW98xS0d4s
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDAyOSBTYWx0ZWRfX0e4FZOfB/psy
 ONAt5QmXLFoJZz+GFXCPq/AzV8o1bCFE4jdiLrrcLSAWqhjkC77wXdnM4iniGPCpGbWZ8W7WMLw
 siwr06mEsGXaHQrXrz3af3rtlRb9p67pLNUmk94+Fsr0A5HHRCLqgsHYgYXHXhfmlV5jmwkCizo
 WHljoQuUwsCxhf4rblo4kIE/aePSX2LvWmuD54nwVjBK07T2KD6QxwkXEGnbvaB4Ad3xQsTtMMA
 z279WRfTF70W4l2wWqdS7W+5Qn/yE+GZeTfDpiH4wa1rS9h4JoaLWz8rAXdPRisNmOEvnwNfnCN
 snolUdz6eyRy6wCG3wihWAtrq9AYT8XPQYkoLnXguQFtc+5g57S1dJAeye6OCq5evRKWtFPDQSG
 uH4b7V/D0KZe+Q2ePmwiUBugj9e52zf7PqEbp2papEEdL87zxduRZvoyWcwEjXMKAL8ZE0nF0Ok
 GLcPJrai8sLp3RD3eGA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDAyOSBTYWx0ZWRfX57IDp60aIrsr
 N3qNEbfEpidoHK0WhDkEIjxzQIvEiBjuBbaecz3dT4fFXGHK2Z291+OEJq86O7gkRdKQfjfR9Xm
 s0SIoX6EQkjCmFbgavC51wQhvEPsimFLlxBlaCmX+fDHqL4xk90T
X-Proofpoint-ORIG-GUID: ZiQm6sFWtZTl_1ap3r2Mh5-xZPzcd0cj
X-Authority-Analysis: v=2.4 cv=YqOa1IYX c=1 sm=1 tr=0 ts=6afc0656 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=GaPK54s0Se3oFqK5NkZy0g==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=jHxIr1HyPKZ_Q5_91PL3:22
 a=zUfmlPF-26W2JwXOGS0A:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: ZiQm6sFWtZTl_1ap3r2Mh5-xZPzcd0cj
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11968
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0 bulkscore=10
 priorityscore=1501 phishscore=0 clxscore=1015 lowpriorityscore=10
 impostorscore=10 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611170029

This series gets rid of the remaining struct page usage in the gfs2 log
code.

The log headers, descriptors, revoke blocks, and escaped block copies
are allocated as pages from a mempool, and they end up in the same bios
as the page cache buffers being journaled. The completion handler then
calls page_folio() on every segment to figure out which kind it is
looking at. That won't work once memdescs land and those pool pages are
no longer folios.

Patch 1 moves these blocks over to a kmalloc mempool, with their own
bios and completion handler. As a result each descriptor block is now
submitted as its own bio, so patch 2 adds a plug around the log flush to
let the block layer merge them back together. Patch 3 cleans up the
leftover page references in the log code.

Tested with fio 4K write+fsync on gfs2 over virtio-blk and null_blk.
Without an I/O scheduler, patch 1 adds one write request per log flush
(196.7k to 229.5k for 32k fsyncs) and ~10 us to the p99.9 fsync latency
on null_blk (41 us to 51 us); the plug in patch 2 merges them and
restores both performance numbers to the baseline. With mq-deadline
nothing changes.

---
Tal Zussman (3):
      gfs2: stop using pages for log buffers
      gfs2: plug the log writes of a flush
      gfs2: remove the remaining page references in the log code

 fs/gfs2/bmap.h |   1 -
 fs/gfs2/log.c  |  19 ++---
 fs/gfs2/lops.c | 221 +++++++++++++++++++++++++++++++++++----------------------
 fs/gfs2/lops.h |   6 +-
 fs/gfs2/main.c |   8 +--
 fs/gfs2/util.c |   2 +-
 fs/gfs2/util.h |   2 +-
 7 files changed, 154 insertions(+), 105 deletions(-)
---
base-commit: e3280ea8b73964efb447f396fb09401a31373136
change-id: 20261014-gfs2-log-folio-274b84f5cc07

Best regards,
--  
Tal Zussman <tz2294@columbia.edu>

