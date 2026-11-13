Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794540369;
	b=xy5QMMa6oZwNGhfDTSmvNnPcoIvtuqctnJBtDmepfdg87fbiXixdSsyLtBmmExWVJho+
	 TXw1gtoX4MObReg4NI/w92Lr0YTM1hCFCpyv9zy8xP8u9RHLgnHfIb2r+jpHQAPj/5yw/
	 20U5pYbMbpj3FYZRL0IErL8mY0rBWg+waHk8jAUTtBCX8u4jdxDnfuzvQnJoaO9T6GFYC
	 /fODcE7oH8fZ0S4TZqm3l4yXyPISK5xUD0ifz8sbciRbh3+ZE96EKiQLpxRn4Qc+IKiBK
	 TGriSf58f0/tCFXXFQ05GDW/Cpoav7ly/miHgnBFu3r3rRfJFN4UZuuZH9wlTTwro1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794540369;
	h=DMARC-Filter:DKIM-Signature:Date:From:To:Cc:Subject:X-Priority:
	 X-Mailer:X-NTES-SC:Content-Transfer-Encoding:Content-Type:
	 MIME-Version:Message-ID:X-Coremail-Locale:X-CM-TRANSID:
	 X-CM-SenderInfo:X-Coremail-Antispam;
	bh=BZbhWSVYwvqc81XMzZhg6WVKBpMD+fjDJv5nXh/22Ao=;
	b=EsmMJNJ10WcQy9o+D2Sxq+01qVqQwOwquCjI/1ER0itWDhkfTRKCm9zB4c2SySftxL0q
	 Gg/aO52XeLt2o6Fr3ZxK1FNi3rxJNrt2XYeHZSUdRCD5CXUTDZxatFsVDGyzegCHdZOU7
	 2Y9uQZ7hYVRmoMDA2ro5J8eQYiLNvdPj8rrjtVpADd1+EqOVQJj2X+9OrpifTo5BsQe5E
	 IL/BhVGUPgrEn8l1VHEHtCEa3jEjlvJMDIi0IefydVZ4zmbwtR/wwQOjsV+LXjDkq4iuA
	 W12rxBOo4zsmTX7Xx8ZaaFu+aEkyIyZ++PJ+fFwKdViKTjbusFHJCp6QGudI3axP4eA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=lZxQR8GH;
	arc=none smtp.remote-ip=220.197.31.2
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8A6606A321
	for <gfs2@lists.linux.dev>; Fri, 13 Nov 2026 03:26:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA8A6606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=lZxQR8GH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=BZbhWSVYwvqc81XMzZhg6WVKBpMD+fjDJv5nXh/22Ao=; b=l
	ZxQR8GHVSwvMd8ogI0RPV33NbdGqc8S1i0vAa17kQ7OncLg4+GEoBCG69wcbssBR
	kG7OoM2CZYywtuoOciBh0tQBkIkmHGMdt6IKUC4itrRusK4a8fy3X6YO4HPsYDLB
	GEiqg6EnMRbDfKldyX9n+X8XjRcdkwHWPRLMORmkcM=
Date: Fri, 13 Nov 2026 11:26:01 +0800 (CST)
From: CJ <firefly0158@163.com>
To: agruenba@redhat.com
Cc: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: INFO: task hung in gfs2_glock_nq on v7.3-rc2
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
X-NTES-SC: AL_Qu2SBvmfv0st5yieY+kdmEsTju82UcS4ufQl245Xc98Fnj/m0QAgUkVjHWLvy8SkMRGyrhS9cglw1fpzYbByNLzbvb2TVHdLyK981b7X0g==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Post: <mailto:gfs2@lists.linux.dev>
List-Help: <mailto:gfs2+help@lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
List-Owner: <mailto:gfs2+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Message-ID: <2b1d6f3b.2f1d.1a1d2f0d896.Coremail.firefly0158@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:hygvCgD3l6FKg_ZqjlY2AA--.1613W
X-CM-SenderInfo: piluvw1o1qikqy6rljoofrz/xtbC+QpL-Gr2g0rngQAA33
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkhpLAoKCnN5emJvdCByZXBvcnRlZCAiSU5GTzogdGFzayBodW5nIGluIGdmczJfZ2xvY2tfbnEi
IG9uIExpbnV4IDYuMS4gVGhlIHNhbWUgZmFpbHVyZSBpcyBzdGlsbApyZXByb2R1Y2libGUgb24g
djcuMy1yYzIgd2l0aCB0aGUgYWRhcHRlZCByZXByb2R1Y2VyIGRlc2NyaWJlZCBiZWxvdy4KCgpU
aGUgcmVwcm9kdWNlciBtb3VudHMgYSBjcmFmdGVkIEdGUzIgbWV0YSBpbWFnZSwga2VlcHMgYSBk
aXJlY3RvcnkgZGVzY3JpcHRvciBhbGl2ZSwgYW5kIHBlcmZvcm1zIHBhdGggbG9va3VwcyBpbiB0
aGUgbW91bnRlZCBmaWxlc3lzdGVtLiBUaGUgYWRhcHRlZCBzeXogcHJvZ3JhbSBrZWVwcyB0aGUg
aW1hZ2UgYW5kIG1vdW50IGNhbGwgdW5jaGFuZ2VkIGFuZCBhZGRzIGV4cGxpY2l0IG9wZW5hdCBs
b29rdXBzIGZvciBHRlMyIG1ldGEgZW50cmllcywgbWFraW5nIHRoZSByZWNvcmRlZCBsb29rdXAg
cGF0aCBkZXRlcm1pbmlzdGljLgoKClRoZSB0YXJnZXQgY29uc29sZSByZXBvcnRzIGEgaHVuZyB0
YXNrIGJsb2NrZWQgaW4gZ2ZzMl9nbG9ja193YWl0IGFuZCBnZnMyX2dsb2NrX25xLCByZWFjaGVk
IGZyb20gX19nZnMyX2xvb2t1cCB0aHJvdWdoIGxvb2t1cF9zbG93LgoKClRoZSBsb29rdXAgcmVt
YWlucyBibG9ja2VkIHdoaWxlIGFjcXVpcmluZyB0aGUgZGlyZWN0b3J5IGdsb2NrLiBUaGUgcmVw
b3J0IHNob3dzIGEgcmVwcm9kdWNpYmxlIHdhaXQgY29uZGl0aW9uLCBub3QgYSBiaXNlY3RlZCBy
b290IGNhdXNlLgoKClRoaXMgaXMgYSBmb2xsb3ctdXAgZm9yIHRoZSBleGlzdGluZyBzeXpib3Qg
cmVwb3J0IGh0dHBzOi8vc3l6a2FsbGVyLmFwcHNwb3QuY29tL2J1Zz9leHRpZD05MGY5YzUzYThl
MTE4MWFhM2Y0Yiwgbm90IGEKYmlzZWN0ZWQgcm9vdCBjYXVzZS4gVGhlIHRhcmdldCByZXBvcnQg
c2hhcmVzCjExIGtleSBmcmFtZXMgd2l0aCB0aGUgc291cmNlIGNyYXNoIHJlcG9ydC4KCgpSZXBy
b2R1Y2VyOgrCoHN5eiByZXByb2R1Y2VyOsKgaHR0cHM6Ly9wYXN0ZWJpbi5jb20vcmF3LzExWWVK
S21ZCgoKY29uc29sZSBvdXRwdXQ6IGh0dHBzOi8vcGFzdGViaW4uY29tL3Jhdy93emU2TDRjYQpr
ZXJuZWwgY29uZmlnOiBodHRwczovL3N5emthbGxlci5hcHBzcG90LmNvbS90ZXh0P3RhZz1LZXJu
ZWxDb25maWcmeD04NzJjMDQ0NjYxNzk4MzNmCgoKS2VybmVsOgrCoCBIRUFEIGNvbW1pdDogZGYy
OTA4MDkwY2RhMzY4YjAxZmY0MzcwOWY1MTg5MDA3NmM1NjE1NwrCoCBnaXQgdHJlZTogbGludXgt
c3RhYmxlCsKgIGtlcm5lbCB2ZXJzaW9uOiA3LjMuMC1yYzIKwqAgdGVzdGVkIHRhZzogdjcuMy1y
YzIKCgpMZXQgbWUga25vdyBpZiB5b3UgbmVlZCBtb3JlIGRldGFpbHMgb3IgdGVzdGluZy4KCgpU
aGFua3MuCgo=
