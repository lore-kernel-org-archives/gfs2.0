Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.139.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795554272;
	b=Ulm5lilzahJ994OxeIo02lEA5hhKKZ4L+KPIp4TFCIu93ic4SxzwxdNO+xm2544FHNN+
	 1cw+1YB3IXVg8TWi1md1sMUOVIH8zXgm/GlrPpCg92RXt3HatOs7Q6GwhbuPmwsmDsuOK
	 WM0wmJT1HFSs1DFqXzOUsAxlNnc8KPpINoS3OqTsfqKWNFlsbprHxpLcgmoIELCsoCx/x
	 F6Oi0vTf2/lJvj9el00Q/DVNYq4Oq8YuvUQgEZdlfmPai3h0vWi9rUXHaxZQim953hren
	 uzBudQ2sXXtWCQLrFWIFRLh86tlk9xut+ml0ijZHc1QifG5Xg/wHyIEbWJJYFZYa16g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795554272;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=YfPCZmxxb4rxdmgSeIDCjLwL3D9h2HXZSX4Vhy7qxFQ=;
	b=10ZkBruAualFPmQ0f22FfiMyVBlDNWePs79IzN1ovGmB4bExkRVI0DTD4Q2JfjCowgE1
	 o/1+c0OZSnuPuqNjmnEimVK6kUx1yCnwa1MtkUYB5CWn3M5BF2puoWZRn6JedHb6egZbl
	 +ge2NZQdums+KSjg78uqj24baP04CGBjJUqXVNJPhrEPy81HWKWyxBrG5wryfhUs6dSFD
	 XuY4wz6mc3bb193v+rc+5rpixHyFQzqYP+kIs69ziPBRbltkWFfk7lRmKgyiIbuAXOa9z
	 +ZPkYHix89SE4i30tq2xQ9D2gP5Mn48dtKQqmxnFw6iv2fgUBDAr+O0tI7cQQMBgqJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=g7uEj+N8;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=chjTM9TI;
	arc=none smtp.remote-ip=148.163.139.74
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E06606A31E
	for <gfs2@lists.linux.dev>; Tue, 24 Nov 2026 21:04:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13E06606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=g7uEj+N8;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=chjTM9TI
Received: from pps.filterd (m0167073.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AOKaOT63064431
	for <gfs2@lists.linux.dev>; Tue, 24 Nov 2026 16:04:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps01; bh=YfPCZmxxb4rxdmgSeIDCjLwL3D
	9h2HXZSX4Vhy7qxFQ=; b=g7uEj+N8wQIAeY5GUbVLPpSD8mOAEr3g0spIbuYY4Y
	+AdmEj/9kfKCnTtI22MOveGbSR9PZknITXTEkyOwF171VMk4+fItxdjwsTGGT2ZJ
	Sk1psHdn0uDV+67kLzFQtkFVi4Znom6cYLzFHb97MdmX5pSV8T1iGXoCEoL2z6fV
	wOJVWMoKE1vqRqa5HhWRHpllSIN4FDv4FT1QncVrlkkQUGNHAirHvnLz2yoNSg1N
	ZaZzra+9zZu1y7SHL/0PI0jtqX94lJcPirUzOyHfgNk3B6HsdHPtGIHeF7Zwzwhl
	ManYR212EZYzeIoatDOpt4fn2uew/A4rdwGbdGoj7yPg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4j5fa7hqm9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <gfs2@lists.linux.dev>; Tue, 24 Nov 2026 16:04:30 -0500 (EST)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-920f97bcad4so88119086d6.0
        for <gfs2@lists.linux.dev>; Tue, 24 Nov 2026 13:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1795554270; x=1796159070; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YfPCZmxxb4rxdmgSeIDCjLwL3D9h2HXZSX4Vhy7qxFQ=;
        b=chjTM9TIk01URewI/uvhcZ0Qj3yzlsDiqKA8pol0a50WVymSej90l7nYXyizWb/M1v
         cs/nmYRxc2ZGmLDMRfyzUM8o8MgqIIJJ3XssAkS3xjXwz2GFzbSJdTW6AYx5EAaqEfdd
         hj+EtjO9DNr5gMi5J3uGo4J+Gyjjfyv3tz0FeT2xFKd09SinsAUVvnaL4D+areLh+QfY
         0F4M0UZosP2Itdqg6KGAH01uE84ps6aztFxlgS7gVJ6i9fOTrn1X2iiFJLbfmnuGU6Nm
         cJy55pbIvRBA79WTFAy+izV7RZgtjElII8GrtZGSprsJIdpQu9QpO5v3oYPwJv+G5xMB
         qx3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795554270; x=1796159070;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YfPCZmxxb4rxdmgSeIDCjLwL3D9h2HXZSX4Vhy7qxFQ=;
        b=Av7lezKWN541D193Gf8bsM42FXtCnd/Dwf6U2ZTKsUMsnyIwYOSKKU7jWA+dvHQLrf
         nTUT5PBfUSMdOTuDtStrFCduHW+ek0uQVtUGKpsq+mUkHskF7sQu1Df26uBaKayiPpDB
         ilLLeGT+42CbN0o4g/mN/ttMO7qsjuhJdtsHJaglpz8BE6SePa/JzJLWd53SrWNZKToM
         pzFZeatdPuzMs0SbrfACt+vHuo497JPARmZFzB5l+8mB5y1wkfYGY/SkfnSxnr7mg2SU
         DfHBrZ+vY2SFVRgVtqnA2jyTfny+mSM0/KkgLftpdOf1C9ZsaOkmBRy9P70injzES/Fa
         P1sQ==
X-Gm-Message-State: APuU4Z9Ex5NA2yGz24bQxq5Xza1ByIlmtWvVqvI6UbHN1zkIuuG5yqJ3
	gYVSrgny1v803c4qeRGnfPv1FQZyG2MObY8XxwpYItL7/7jeSdRSEJ3rN4E4DSOrXJd6z/G/+RA
	Y/2PyvWyhjKQ6GCS9L80RicGPedCiAGwJYjVzTuDKK4mqxqK5ax0=
X-Gm-Gg: AZFdTZcRUHTc4cK6Ak6KvHYYmKBcW2fLEH6gySTuwHbTpxeBVXci5av3UQ0K9or2/wt
	5/zRyVea6xWbVmdfL2JegNUKtzG2TJ/rqbL7/mWBEFcs0qqmJ2tdH43Nd9TyOBc+hGuxrJbNTTE
	DEWgFeneTgdcVqmbhaX+F4dGumFlN/plW71Fs2yQk6y45DWFXMNQD7dduz1dZdm7bR01YMUS9l7
	Jn6TCpVDfk21+jplw5M+btPzJrG+2ehkDbXY+lQcNFrBJChvcxFIqjSwyq2ZtD1RdchJs8VoPyf
	SpAJ3Yr1xVNFCRzdSVYFIThyM4+tnR7ZLtD9BuntEBnmPb4evu3qrsDoXKIT554T3wL1Td3F+j0
	+AP9tpySd5xZEHvONuaKRv25wD/IMn7xaWMvAf4iu0CKkAhwfML0XJE04wmQ=
X-Received: by 2002:a05:6214:2586:b0:91f:2b45:798f with SMTP id 6a1803df08f44-921349d1a84mr303818426d6.1.1795554269978;
        Tue, 24 Nov 2026 13:04:29 -0800 (PST)
X-Received: by 2002:a05:6214:2586:b0:91f:2b45:798f with SMTP id 6a1803df08f44-921349d1a84mr303817776d6.1.1795554269260;
        Tue, 24 Nov 2026 13:04:29 -0800 (PST)
Received: from [127.0.1.1] ([129.236.231.128])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-92134a0a454sm142827326d6.35.2026.11.24.13.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 13:04:28 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Subject: [PATCH v2 0/4] gfs2: stop using struct page in the log code
Date: Tue, 24 Nov 2026 16:04:08 -0500
Message-Id: <20261124-gfs2-log-folio-v2-0-f229e90c8285@columbia.edu>
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
X-B4-Tracking: v=1; b=H4sIAMj7BWsC/12Nyw6CMBBFf4XM2jFtKWJc+R+GBW2nMAapaYFoC
 P8uj53Lk5x77gyJIlOCWzZDpIkTh34FdcrAtnXfELJbGZRQFymkxsYnhV1o0IeOA6pSm6v2hbW
 ihHX0juT5swcf1cFpNE+yw1bZjJbTEOJ3f5zk5h1xKcv/+CRRYF44kzujFeXF3YZufBmuz+RGq
 JZl+QHZNTxcwQAAAA==
X-Change-ID: 20261014-gfs2-log-folio-274b84f5cc07
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795554268; l=2556;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=7FO6/luyWyYiwy76McXgSi1siYuPq6HjMqibCHp9fZE=;
 b=sa/Hdt6+MzITp2xUSjYeaHYjKR4aGgDtGKHx7HykKnt4rguIRaPCsn+rx8T9+HrMR1ryUXA+8
 LfgELZNbNdwBGeBZYLz2OLTyiL2+SUYfRY7UPDszmA/7nDKWdB8SIG1
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-GUID: o56ns9Vgzvc2RcB55D7mGDMSnVWS9dWK
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA4MyBTYWx0ZWRfX9AMtCkKxZRQC
 8daFaNHElk0GEQuJWorCzcYXHOX4NmnSXhQ5HTnWzZbC8sXKHhlTNiTtA/UI8H4YNUuqvpqTuKd
 /5FtE8GblkpPwcbNoPeTUmFUG7lKiFo4MSce+OYFulq+dxAkeBUt
X-Proofpoint-ORIG-GUID: o56ns9Vgzvc2RcB55D7mGDMSnVWS9dWK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA4MyBTYWx0ZWRfX0ncwXsqCcXoV
 094Zsa+hZ7n08Wr22HGYztJ2Q51DwDtMeyKEb65KJ+8yjB75lXBa+82VVky+rCJcSYLhgyvcZ/w
 89wPx0H/FlSxmczIU8VF+69CPedp6HnP49omDOpP05dQxWwjmcYkgMtmyIPklcObIgN5hOlH2HG
 /UcZKuoGFmtZUmyTaaF8CWnaX3XCi9OAzH5TMCjXoBZoR9JlcuXxso2pNC0eTHUTUjraMMuILjR
 +4p06dys5ZWnL6scvbzo0cIRKuLa1g33G+/V3PAyW+T+XJYqOLOs+1JZpaHTcHf21wpUHADrzx/
 MPvBBnQIKOA5WVsiPp9+2gOOZSWznwgU9SDYMyGyl4pn6BjMi+jgUgL5hc5l9HglG1UWXKBAaB0
 OKz+gzhxWyQ6rDw928H4kOeJEDL1/UTtls62I5BveSkAVBT6dydxlOFm5Zs6Jn/NSTdIwW8eJPc
 56GEWy+vHTcdubpRCWQ==
X-Authority-Analysis: v=2.4 cv=NdZzRGD4 c=1 sm=1 tr=0 ts=6b05fbde cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=LNQXEAmb7IHcZyFqmLK0PA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=jHxIr1HyPKZ_Q5_91PL3:22
 a=bC-a23v3AAAA:8 a=RFVG-sN2wyKfNfnTff4A:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11976
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=10 adultscore=0 phishscore=0 clxscore=1015
 malwarescore=0 spamscore=0 priorityscore=1501 lowpriorityscore=10
 impostorscore=10 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611240083

This series gets rid of the remaining struct page usage in the gfs2 log
code.

The log headers, descriptors, revoke blocks, and escaped block copies
are allocated as pages from a mempool, and they end up in the same bios
as the page cache buffers being journaled. The completion handler then
calls page_folio() on every segment to figure out which kind it is
looking at. That won't work once memdescs land and those pool pages are
no longer folios.

Patch 1 gives each superblock its own mempool for these blocks in place
of the global one. Patch 2 moves the blocks over to block-sized kmalloc
buffers from that pool, with their own bios and completion handler. As a
result each descriptor block is now submitted as its own bio, so patch 3
adds a plug around the log flush to let the block layer merge them back
together. Patch 4 cleans up the leftover page references in the log
code.

Tested with fio 4K write+fsync on gfs2 over virtio-blk and null_blk.
Without an I/O scheduler, patch 2 adds one write request per log flush
(196.7k to 229.5k for 32k fsyncs) and ~10 us to the p99.9 fsync latency
on null_blk (41 us to 51 us); the plug in patch 3 merges them and
restores both performance numbers to the baseline. With mq-deadline
nothing changes.

With a 1k block size on 4k pages the result is the same. Patch 1 changes
nothing by itself, patch 2 takes the write requests for 32k fsyncs from
199.5k to 232.3k, and patch 3 brings them back to 199.5k.

---
Changes in v2:
- Patch 1 (new): Make the mempool per-superblock, per Andreas.
- Patch 2: Make the per-superblock mempool be block-sized, rather than
  page-sized, per Andreas.
- Link to v1: https://patch.msgid.link/20261117-gfs2-log-folio-v1-0-35db3db42e35@columbia.edu

---
Tal Zussman (4):
      gfs2: make the log page pool per superblock
      gfs2: stop using pages for log buffers
      gfs2: plug the log writes of a flush
      gfs2: remove the remaining page references in the log code

 fs/gfs2/bmap.h       |   1 -
 fs/gfs2/incore.h     |   2 +
 fs/gfs2/log.c        |  19 ++---
 fs/gfs2/lops.c       | 222 +++++++++++++++++++++++++++++++--------------------
 fs/gfs2/lops.h       |   6 +-
 fs/gfs2/main.c       |   8 --
 fs/gfs2/ops_fstype.c |   6 ++
 fs/gfs2/util.c       |   1 -
 fs/gfs2/util.h       |   3 -
 9 files changed, 157 insertions(+), 111 deletions(-)
---
base-commit: a009501c151f7d19519312ccfa2070d30d62b249
change-id: 20261014-gfs2-log-folio-274b84f5cc07

Best regards,
--  
Tal Zussman <tz2294@columbia.edu>

