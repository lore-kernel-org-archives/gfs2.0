Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84C625A322
	for <gfs2@lists.linux.dev>; Sat, 29 Nov 2025 10:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764411097; cv=none; b=g/GFChL/jvccCOcEZnGYgSODR2ogh9ZmKH0BHwBxGTQAf4urD3zoo4nVESkalddlyVjWUkGHA4qn3OZtd7j4y9nJ/ryKW15u922yz04efFnkFR64mxqi6SrrHkw8MA63dwKcim9hk+0pKYCZ1ZwNVAuJSvIFpqqv7s8VTj80Vg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764411097; c=relaxed/simple;
	bh=W7DxpMXpJYxVKIOxasG4CJNAGfG2+Dl4Gh3tjPhL9EQ=;
	h=Content-Type:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To; b=NQdfmh4bLMK3waG/TlHB93G1I1+wYMi2JSYmVcfmH5hXaE4RtBb4mPJjaSYJv78xLWEO0BqdnPPT1+i1+qfUMDrvNYRzRI/+S4hJnfSbxwLrT4FIM6YG4ExcqEbuh43zuHZCKKeiDbpam6w5aWqTBH9m89o7GUXxxiqY7PWUTSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fN7/J5Z3; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fN7/J5Z3"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7b8e49d8b35so2986986b3a.3
        for <gfs2@lists.linux.dev>; Sat, 29 Nov 2025 02:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764411095; x=1765015895; darn=lists.linux.dev;
        h=in-reply-to:from:content-language:subject:references:cc:to
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W7DxpMXpJYxVKIOxasG4CJNAGfG2+Dl4Gh3tjPhL9EQ=;
        b=fN7/J5Z3nVI8/zldGd4oWDzJEDh46ECpxQ73C9yvEUR/WCl9nhQWgY/6rBnPc3xXon
         rJXpOIZGp+ZNLwW1jeJcdTfvJuw8JGRYUD6exK8yUfEmmQLaV2O4N2Q+i3xSnfShGgPU
         AdZEpOvdcneS6w2ATyAIsibTzMqGEBtQzUicDjhmKCRjdLa3Es0WH6SjfFEI2WNcFHt/
         0e9Kj3stBKpYNZ1xxxs0+Ej2y5xsnoyeN9kPwFJvRUHWLn5P2xRD+6zK8ylvnFic/p0Y
         /UW7jKK2aNO/wPbfhHmTLCTI9147Zp4SEBe/ri6zUnXRjMdWsdkOG4wEMoRLLZbnl2t8
         Q02A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764411095; x=1765015895;
        h=in-reply-to:from:content-language:subject:references:cc:to
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W7DxpMXpJYxVKIOxasG4CJNAGfG2+Dl4Gh3tjPhL9EQ=;
        b=GBLm/GOcsMVzyBRqM1berZOYo7JP1MrUn21KSqYkZ9HfDSAoHAkJPV3FepTzcMPH9Q
         coNYr68jKKCIG/MFc15r35TR1G/Wt0ojOfcZZO/KtLXllV+srzT9sqy0+vyAmyucGRZA
         m6cFgvIEjRjp4g9hkg446Y6zBaft2z+ULMLHZc3L+4ENe5RoNvKPoZ2tHjhtP1XdA/5x
         XuJsH2b42dGgbnk1oL0yftc2Z4k9ZaF0r1KhqjA5srtaKkNGDmt+mRZrzWf6QxdN9/Nt
         2e8Hke6AMQA6pE/Si+QeOK2SjhSbzDyi+/Ih6LRwPd9hxd5PJhFATU0P5L5y4sskoM6B
         IhXg==
X-Forwarded-Encrypted: i=1; AJvYcCUgc8jjtVwpe0nunUWDuIvcTbw96D2FiCI+tskwzeWP67qxNYA7fMiFanMfUn6eqzj9CUsR@lists.linux.dev
X-Gm-Message-State: AOJu0Yx/rjId605zHCiFG9AgZjqTkbmceX/o5Zsr9JA6VgrmAQJTT6dw
	Detm+elPG+1pi/WLE0WrzLLWep0wxXRNbPZcW/x8L7PLGjrHu+kIAvM6GsgvxGzg
X-Gm-Gg: ASbGncu/gWVt6Wschczg27tZOeJW9od2cMSMSLGq9ZNOzPdlv4frCuUhymGPCxe1gh7
	um1eKYCPmkgSs1y4rqJexPmWirh1MQjp6Mo+2GJwUAqKFqdA5L/b5JTx3IdpKyPQmm6g8U3/W26
	cnLpMaE3nCPrXfPC+sGeW39YuYUCXSNori09UYKjZDjykB+Za+mS3Esdf7DxXIPxsTTdEVj04Xs
	fxqPpAOxMeYFDQB2VrYmEY/MW9ByG1LPSss/Crq4eGp8XwJOx+SyFJyNtX5tLnw8QDhwTJUDhiR
	xJ+5Ir2DPduGkJvmemfkPUlGn5c4Pu22r5D5q/pC9/XjT9px87ZN2JCcXf1FpGLHzE7rK31sVsy
	ZlbvGfXAGWANNl206mkOR1wVllaU6anjd8FG9tDlvC3/G3Cp9IG+0FGCPxuHwzxiQthpFcN5/eP
	ho9GrIf9wrNa+C/bshnxhNC0DWx4CcBezYHNKHaj72UqXtThjn6g==
X-Google-Smtp-Source: AGHT+IE2Az4r8zhZUJ1jI0hI/1lPDIz2rrNcKSwaxbxoDqRq+OVzOICbZGB7+ktIKXBAJ+tLmX6c0g==
X-Received: by 2002:a05:6a00:13a4:b0:7ab:8583:9cc7 with SMTP id d2e1a72fcca58-7c58db2cb6cmr32349089b3a.16.1764411095007;
        Sat, 29 Nov 2025 02:11:35 -0800 (PST)
Received: from ?IPV6:2405:201:31:d869:ca83:6d4:140:3932? ([2405:201:31:d869:ca83:6d4:140:3932])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d1518e5dacsm7597003b3a.23.2025.11.29.02.11.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Nov 2025 02:11:34 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------nU5QybEYh0TBzow4tEGI2Oci"
Message-ID: <b19fde40-0e5f-4bef-8ee8-ecdabbfc9562@gmail.com>
Date: Sat, 29 Nov 2025 15:41:31 +0530
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: syzbot+af4d53576692f8956fd6@syzkaller.appspotmail.com
Cc: agruenba@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <69288d0e.a70a0220.d98e3.010c.GAE@google.com>
Subject: Re: [syzbot] [gfs2?] kernel BUG in gfs2_quota_cleanup (3)
Content-Language: en-US
From: shaurya <ssranevjti@gmail.com>
In-Reply-To: <69288d0e.a70a0220.d98e3.010c.GAE@google.com>

This is a multi-part message in MIME format.
--------------nU5QybEYh0TBzow4tEGI2Oci
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

#syz test:
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

--------------nU5QybEYh0TBzow4tEGI2Oci
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-gfs2-allow-quota-cleanup-when-filesystem-is-withdraw.patch"
Content-Disposition: attachment;
 filename*0="0001-gfs2-allow-quota-cleanup-when-filesystem-is-withdraw.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSBjYjE2NThlNTViMTcyN2RjYjY2MmY3Y2I5ZjI4N2FkZjQ2YmZlOTE3IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBTaGF1cnlhIFJhbmUgPHNzcmFuZV9iMjNAZWUudmp0
aS5hYy5pbj4KRGF0ZTogU2F0LCAyOSBOb3YgMjAyNSAxNTozODoxOCArMDUzMApTdWJqZWN0
OiBbUEFUQ0hdIGdmczI6IGFsbG93IHF1b3RhIGNsZWFudXAgd2hlbiBmaWxlc3lzdGVtIGlz
IHdpdGhkcmF3aW5nCgpnZnMyX3F1b3RhX2NsZWFudXAoKSB0cmlnZ2VycyBhIGtlcm5lbCBC
VUcgd2hlbiBjYWxsZWQgd2hpbGUgdGhlCmpvdXJuYWwgaXMgc3RpbGwgbWFya2VkIGxpdmUs
IFNERl9OT1JFQ09WRVJZIGlzIG5vdCBzZXQsIGFuZCB0aGUKZmlsZXN5c3RlbSBpcyBpbiB0
aGUgcHJvY2VzcyBvZiB3aXRoZHJhd2luZy4gVGhpcyBjYW4gb2NjdXIgZHVyaW5nCmZpbGVz
eXN0ZW0gcmVjb25maWd1cmUgb3BlcmF0aW9ucyB3aGVuIGEgd2l0aGRyYXcgaXMgdHJpZ2dl
cmVkCmR1cmluZyBnZnMyX21ha2VfZnNfcm8oKS4KClRoZSB3aXRoZHJhdyBwcm9jZXNzIGNs
ZWFycyBTREZfSk9VUk5BTF9MSVZFIGluIHNpZ25hbF9vdXJfd2l0aGRyYXcoKSwKYnV0IHRo
ZXJlJ3MgYSByYWNlIHdpbmRvdyB3aGVyZSBnZnMyX3F1b3RhX2NsZWFudXAoKSBjYW4gYmUg
cmVhY2hlZApiZWZvcmUgdGhpcyBoYXBwZW5zIGR1cmluZyB0aGUgZ2ZzMl9tYWtlX2ZzX3Jv
KCkgLT4gZ2ZzMl9xdW90YV9jbGVhbnVwKCkKY2FsbCBwYXRoLgoKQWRkIGEgY2hlY2sgZm9y
IGdmczJfd2l0aGRyYXdpbmdfb3Jfd2l0aGRyYXduKCkgdG8gdGhlIEJVR19PTiBjb25kaXRp
b24KdG8gYWxsb3cgcXVvdGEgY2xlYW51cCB0byBwcm9jZWVkIHNhZmVseSBkdXJpbmcgYSB3
aXRoZHJhdy4gVGhpcyBpcwpzYWZlIGJlY2F1c2U6CjEuIFRoZSB3aXRoZHJhdyBwcm9jZXNz
IGhhbmRsZXMgY2xlYW51cCBncmFjZWZ1bGx5CjIuIGdmczJfcXVvdGFfY2xlYW51cCgpIGFs
cmVhZHkgc2tpcHMgZW50cmllcyB3aXRoIGFjdGl2ZSByZWZlcmVuY2VzCjMuIFRoZSBmdW5j
dGlvbiB3YWl0cyBmb3IgcmVmZXJlbmNlcyB0byBkcmFpbiB2aWEgd2FpdF9ldmVudF90aW1l
b3V0KCkKClJlcG9ydGVkLWJ5OiBzeXpib3QrYWY0ZDUzNTc2NjkyZjg5NTZmZDZAc3l6a2Fs
bGVyLmFwcHNwb3RtYWlsLmNvbQpDbG9zZXM6IGh0dHBzOi8vc3l6a2FsbGVyLmFwcHNwb3Qu
Y29tL2J1Zz9leHRpZD1hZjRkNTM1NzY2OTJmODk1NmZkNgpGaXhlczogNzE3MzNiNDkyMjAw
ICgiZ2ZzMjogZml4IGtlcm5lbCBCVUcgaW4gZ2ZzMl9xdW90YV9jbGVhbnVwIikKClNpZ25l
ZC1vZmYtYnk6IFNoYXVyeWEgUmFuZSA8c3NyYW5lX2IyM0BlZS52anRpLmFjLmluPgotLS0K
IGZzL2dmczIvcXVvdGEuYyB8IDMgKystCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25z
KCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZnMvZ2ZzMi9xdW90YS5jIGIvZnMv
Z2ZzMi9xdW90YS5jCmluZGV4IDIyOThlMDY3OTdhYy4uNGFlMDdjNmNlZTk4IDEwMDY0NAot
LS0gYS9mcy9nZnMyL3F1b3RhLmMKKysrIGIvZnMvZ2ZzMi9xdW90YS5jCkBAIC0xNTE3LDcg
KzE1MTcsOCBAQCB2b2lkIGdmczJfcXVvdGFfY2xlYW51cChzdHJ1Y3QgZ2ZzMl9zYmQgKnNk
cCkKIAlpbnQgY291bnQ7CiAKIAlCVUdfT04oIXRlc3RfYml0KFNERl9OT1JFQ09WRVJZLCAm
c2RwLT5zZF9mbGFncykgJiYKLQkJdGVzdF9iaXQoU0RGX0pPVVJOQUxfTElWRSwgJnNkcC0+
c2RfZmxhZ3MpKTsKKwkgICAgICAgIWdmczJfd2l0aGRyYXdpbmdfb3Jfd2l0aGRyYXduKHNk
cCkgJiYKKwkgICAgICAgdGVzdF9iaXQoU0RGX0pPVVJOQUxfTElWRSwgJnNkcC0+c2RfZmxh
Z3MpKTsKIAogCXNwaW5fbG9jaygmcWRfbG9jayk7CiAJbGlzdF9mb3JfZWFjaF9lbnRyeShx
ZCwgJnNkcC0+c2RfcXVvdGFfbGlzdCwgcWRfbGlzdCkgewotLSAKMi4zNC4xCgo=

--------------nU5QybEYh0TBzow4tEGI2Oci--
