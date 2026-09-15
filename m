Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44383D891C
	for <gfs2@lists.linux.dev>; Tue, 15 Sep 2026 06:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789454721; cv=none; b=LVQK1FyU0+jE1h8LZCBsx0fTWHLNPJMxuuRBlUsnsGqA1UNEyEh4GxhDDB23fqDWxUep5pjN+reFReyAcNEk9quBUqzINY9Pv4/9c/EVOTWKThzX6l5B2rMdy999d4u/diX2BnFsywK+fkMYabmrZcNHDvAhTtX/Ks/5nnkBzss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789454721; c=relaxed/simple;
	bh=eUIYE7KHg/2xLsrIfLuIvcbSWZaZX9ECh9f5yd/Z0DI=;
	h=Date:From:To:Cc:Subject:Content-Type:MIME-Version:Message-ID; b=AIqUxwp4TQ3tAiAnHhWc3NqR0eSftpEM/JKsh54G4GTuZxrfiALDmXqFHgDx7PZwCMHGXMYg4NuDsy8SLsT8625hdwCyBg9QXQeq0UEMHVsffoCJFztSFgpmf8+a53Fy2CSbAQqf5R+Z5XGTsBdo5mHJIdmx2iccrJhCUY6kmCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=a2H57DIT; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="a2H57DIT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=eUIYE7KHg/2xLsrIfLuIvcbSWZaZX9ECh9f5yd/Z0DI=; b=a
	2H57DITiG6dQCs9pvIXvukJcXRRSq14weGeBjw9FJHe7M7+yOijKIPRa0mVgti93
	ams0DqRmyLBW3pj0s94g38/IQmnoAehNhbAmCxZQj8vLvcKZLCxyQQdJLaMiJRyM
	r+NF5unw9STMPkMouHQrs6X+5fSc+6+a8j/4PO0f5Y=
Date: Tue, 15 Sep 2026 14:45:11 +0800 (CST)
From: CJ <firefly0158@163.com>
To: agruenba@redhat.com
Cc: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [BUG] gfs2: WARNING in gfs2_check_blk_type
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
X-NTES-SC: AL_Qu2TC/ieu08q5ymbYOkdmEsTju82UcS4ufQl245Xc98Figbk+QAgeFpPNFDG1NiRKyuJkh+TdQFs6cJxc45/DKvBeWR4ZcWol+fWUqMH3g==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-ID: <5fc618f2.587e.1a0a3cffc8a.Coremail.firefly0158@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:hygvCgD3P7Z46ahqaPAPAA--.21217W
X-CM-SenderInfo: piluvw1o1qikqy6rljoofrz/xtbC+RdcDmqo6Xd4HAAA3E
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkhpLAoKCkkgYW0gcmVwb3J0aW5nIGEgV0FSTklORyBpbiB0aGUgZ2ZzMiBibG9jay10eXBlIGNo
ZWNrLCB0cmlnZ2VyZWQgYnkgYSBzeXprYWxsZXIKcmVwcm9kdWNlciB0aGF0IG1vdW50cyBhIGNy
YWZ0ZWQgZ2ZzMiBpbWFnZS4gIFRoZSBpc3N1ZSBpcyByZXByb2R1Y2libGUgd2l0aCBIRUFECmNv
bW1pdCBjZWU5Mzk1YWNkODA0M2JlMDY0NGIyNWMzNGJmYTg2NjIzZjJiOTM1ICh2Ny4zLXJjMSwg
TGludXggNy4zLjAtcmMxKS4KCgpUaGUgcmVwcm9kdWNlciBtb3VudHMgYSBjcmFmdGVkIGdmczIg
ZmlsZXN5c3RlbSBpbWFnZSBvbiBhIGxvb3AgZGV2aWNlIGFuZCB0aGVuCnJlc29sdmVzIGFuIGlu
b2RlIHRocm91Z2ggaXRzIGZpbGUgaGFuZGxlLCB3aGljaCBtYWtlcyBnZnMyIGxvb2sgdXAgdGhl
IHJlc291cmNlCmdyb3VwIGNvdmVyaW5nIHRoZSBibG9jayBudW1iZXIgZW5jb2RlZCBpbiB0aGUg
aGFuZGxlLgoKClRoZSBjb25zb2xlIHNob3dzIGEgV0FSTklORyBhdCBmcy9nZnMyL3JncnAuYzoy
NjI4IHdpdGggUklQIGluCmdmczJfY2hlY2tfYmxrX3R5cGUsIHJlYWNoZWQgZnJvbSBnZnMyX2lu
b2RlX2xvb2t1cCBhbmQgZ2ZzMl9maF90b19kZW50cnkuICBJbiB0aGUKb3JpZ2luYWwgcmVwb3J0
IHRoZSBzYW1lIHdhcm5pbmcgd2FzIGF0dHJpYnV0ZWQgdG8gdGhlIGlubGluZWQKZ2ZzMl9yYm1f
ZnJvbV9ibG9jayBhdCByZ3JwLmM6Mjc5LCB3aGljaCBpcyB0aGUgcmFuZ2UgY29tcHV0YXRpb24g
aW5zaWRlIHRoaXMKZnVuY3Rpb24uCgoKT25lIHBvc3NpYmxlIGNhdXNlIGlzIHRoYXQgdGhlIGJs
b2NrIG51bWJlciBkZXJpdmVkIGZyb20gdGhlIGZpbGUgaGFuZGxlIGFuZCB0aGUKcmVzb3VyY2Ug
Z3JvdXAgYml0bWFwIGlzIG5vdCB2YWxpZGF0ZWQgYWdhaW5zdCB0aGUgcmVzb3VyY2UgZ3JvdXAn
cyByZWFsIGV4dGVudApiZWZvcmUgdGhlIGJsb2NrIHR5cGUgaXMgbG9va2VkIHVwLCBzbyBhIGNy
YWZ0ZWQgaGFuZGxlIG9yIGltYWdlIG1ha2VzIHRoZSBjaGVjawpmYWlsIGFuZCB3YXJuLiAgVGhp
cyBsb29rcyBsaWtlIGEgbWlzc2luZyB2YWxpZGl0eSBjaGVjayBvbiBhIGNvbXB1dGVkIGJsb2Nr
Cm51bWJlci4gIEkgYW0gcmVwb3J0aW5nIHRoZSB3YXJuaW5nIGFuZCB0aGUgcGF0aCBhcyBvYnNl
cnZlZC4KCgpUaGlzIGFwcGVhcnMgdG8gYmUgYSByZWN1cnJlbmNlIG9mIHRoZSBzeXpib3QgaXNz
dWUgd2hvc2UgZXh0ZXJuYWwgaWQgaXMKYWJjYzA4NzNkNTg1N2JjMzZmNzYuICBJdCByZW1haW5z
IHJlcHJvZHVjaWJsZSBvbiB2Ny4zLXJjMS4KCgpSZXByb2R1Y2VyOgoKCnN5eiByZXByb2R1Y2Vy
OiBodHRwczovL3Bhc3RlYmluLmNvbS9yYXcvSnc4YlpYblUKCmNvbnNvbGUgb3V0cHV0OiBodHRw
czovL3Bhc3RlYmluLmNvbS9yYXcvY0M3djZFNmIKCmtlcm5lbCBjb25maWc6IGh0dHBzOi8vcGFz
dGViaW4uY29tL3Jhdy9aOUp6YlhiTQoKCktlcm5lbDoKCgpIRUFEIGNvbW1pdDogY2VlOTM5NWFj
ZDgwNDNiZTA2NDRiMjVjMzRiZmE4NjYyM2YyYjkzNQpnaXQgdHJlZTogdXBzdHJlYW0gKGxpbnV4
LmdpdCksIHRlc3RlZCB0aHJvdWdoIHRoZSB2Ny4zLXJjMSBhbm5vdGF0ZWQgdGFnIG9iamVjdArC
oCDCoCDCoCDCoCDCoCDCoGU1ZTA0NzI2Y2RkMDQzZTMwOTY3NzA3MWFiMWI2NWE0YjE4ZjQyMmIK
a2VybmVsIHZlcnNpb246IDcuMy4wLXJjMSAjMSBQUkVFTVBUKGZ1bGwpCnRlc3RlZCB0YWc6IHY3
LjMtcmMxIChMaW51eCA3LjMtcmMxLCAyMDI2LTA4LTMwKQoKCkxldCBtZSBrbm93IGlmIHlvdSBu
ZWVkIG1vcmUgZGV0YWlscyBvciB0ZXN0aW5nLgoKCkJlc3QgcmVnYXJkcywKQ2hhbmdqaWFuCgo=

