Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACEF240225
	for <gfs2@lists.linux.dev>; Mon, 13 Jan 2025 15:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736783748; cv=none; b=W4QooGs2ezerFoNv3FQEuInLJZlMqh9xoe+DNmtktBsdrzH4G+8cy0AlwUpO43QvehZb3g1i4Os52bLHrF492OjUfs98Xytv1ZKhRO7rLRcbC4VISJlMgyCprWXDuCh2mbAha3h8y4znQG8/vNpCU429l8RTkmbsc9RPVHl9rtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736783748; c=relaxed/simple;
	bh=i5VYpuaqX2V5Xa7D3QwfPhvFzx7wjWPCeu5qgceCnI0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ZHPkpbYLts5v/QIrEp0MxROLU/wsZCko27v2XcaRyZlkjVo7/FrApkFRTRDRii72x9diJcua+Rs4YhCjVaJQDv48M4pN5xdUc6P3XxV8dYxxFfRx3HP0ouhrYyweRR/qIpDyT7bkPn0JPtmQ824QzpbC8++2ODuz/GyHPDrqiug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn; spf=pass smtp.mailfrom=m.fudan.edu.cn; dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b=jJYRbNFB; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.fudan.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b="jJYRbNFB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=m.fudan.edu.cn;
	s=sorc2401; t=1736783712;
	bh=NrRPZq/ZMyh19GlByE7xB6nLXqdnqOWrJl+/lnw3bAQ=;
	h=Mime-Version:Subject:From:Date:Message-Id:To;
	b=jJYRbNFBkAV3zDoPEYBx6hRnCDFDDStYUvGjtglKim5l3dqtBpn4j3UacfhoD+h3f
	 mmdh/ap1SFGFVinMRCQSqKMwchkJaq0UF/X4Wrl06Kc+bdP2gkSqmS/o2aBOpFjzKa
	 1WpDDYnAfNXfTSoVBvPDnaJz6Jxww8mZeyL606k8=
X-QQ-mid: bizesmtpip2t1736783710tqcbhrv
X-QQ-Originating-IP: L13RZripdlpPXuVZg+558qgW595Y+68cLTRi/I7N3Tw=
Received: from smtpclient.apple ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 13 Jan 2025 23:55:08 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17641171886708638794
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Re: Bug: slab-out-of-bounds Write in __bh_read
From: Kun Hu <huk23@m.fudan.edu.cn>
In-Reply-To: <CAHc6FU5YgChLiiUtEmS8pJGHUUhHAK3eYrrGd+FaNMDLti786g@mail.gmail.com>
Date: Mon, 13 Jan 2025 23:54:58 +0800
Cc: Jan Kara <jack@suse.cz>,
 viro@zeniv.linux.org.uk,
 brauner@kernel.org,
 linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 "jjtan24@m.fudan.edu.cn" <jjtan24@m.fudan.edu.cn>,
 gfs2@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <27DB604A-8C3B-4703-BB8A-CBC16B9C4969@m.fudan.edu.cn>
References: <F0E0E5DD-572E-4F05-8016-46D36682C8BB@m.fudan.edu.cn>
 <brheoinx2gsmonf6uxobqicuxnqpxnsum26c3hcuroztmccl3m@lnmielvfe4v7>
 <5757218E-52F8-49C7-95F1-9051EB51A2F3@m.fudan.edu.cn>
 <6yd5s7fxnr7wtmluqa667lok54sphgtg4eppubntulelwidvca@ffyohkeovnyn>
 <31A10938-C36E-40A2-8A1D-180BD95528DD@m.fudan.edu.cn>
 <xqx6qkwti3ouotgkq5teay3adsja37ypjinrhur4m3wzagf5ia@ippcgcsvem5b>
 <86F5589E-BC3A-49E5-824F-0E840F75F46D@m.fudan.edu.cn>
 <CAHc6FU5YgChLiiUtEmS8pJGHUUhHAK3eYrrGd+FaNMDLti786g@mail.gmail.com>
To: Andreas Gruenbacher <agruenba@redhat.com>
X-Mailer: Apple Mail (2.3818.100.11.1.3)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:m.fudan.edu.cn:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MrxXcFOI3p+kKy+wAuuqHfZdiPGFMCRXYH88acGR4CkIuIa7DnMs8ZnB
	uHC4ld8b3VR5yv/SDwtYnQ0DURaDq0OfrTUYz/UZacwPNSzzb/wa3woFzTH8OSJswrNF1ql
	E2txgxWP8d2wiKbpBFkiBXRckzJU7+19xTxz44Lb+eKhrASbsyc6324Gr4Z0MwmWCJiImtO
	IJsF/g2N4EcNzKnd3vaQS+9AU3//2yusbGmE/nYwvNBEdN6wq4A4qCeXWsKDDijMbA/snVS
	bUogYyo8V3FKMLWOVt/dbpUC3usMeX4sOu4OtIC4PUqRkfFkVK7LM8iaNaosH7VwOmPA8Bu
	axQWQMuTrXfoZPX9zAmJ2XCaKOiLL4P8StlbsEObfyJ4I71RdIOgxViAS/QV1nVhhK3Nna3
	ouRm65PB1StVHvd0Dl7+ouz8zxdd0TSt0UbQpMglzAA/YKrkuqyKIM0vLrBzwqmOjoRJaUw
	pL3Nxl7neFiYNFLFfigQq/+xNu94stLr4aeRMdQqpmWyoKl3+Xjlp9MkBil6gj4ijSaYyE+
	kTVKs89CQmnS0I/5EYFSBrheMkdEdt6Ca9FQ053dRqZpJ86/ED+TlPHsqRoO2babMp5Ls8u
	q2/pkZy14hIp0XZkyAbbC6WYg0FskWBeVmvxmHG1neKho5lzX2VtnzHSo40KOo+AnvSU7/Q
	D+0pkwIlxI62858hzjRtjt6V3KyrXwRPfpzD8PGTvN68nzQh8oZj1Z8UpScoEW3i8vcvGM3
	cGCpANjUTqyAQWtRE0MFcCZGklswHyInaWK0JKJpaQdB44fDVd4Jbtg7GPdbXbbCjlGah+K
	IZI5TB/h/89zNlDZPyp8zurqFi1gzjbw+GdRrusWGId2gHGhpQaqURsShQ4hceImV+xqO7d
	m0fXnZLQx4h2a0kd9qS4ZxrLxBJJyaHLCXmPovRVn+F5TkRAeSTbB9tVhMFlgeiFKKmU+rD
	ZTC8CcgIw/dtbnW16O5oLAiiqx4EMJ761dcE=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0


>=20
> 32generated_program.c memory maps the filesystem image, mounts it, and
> then modifies it through the memory map. It's those modifications that
> cause gfs2 to crash, so the test case is invalid.
>=20
> Is disabling CONFIG_BLK_DEV_WRITE_MOUNTED supposed to prevent that? If
> so, then it doesn't seem to be working.
>=20
> Thanks,
> Andreas


>  We have reproduced the crash with CONFIG_BLK_DEV_WRITE_MOUNTED =
disabled to obtain the same crash log. The new crash log, along with C =
and Syzlang reproducers are provided below:

> Crash log: =
https://drive.google.com/file/d/1FiCgo05oPheAt4sDQzRYTQwl0-CY6rvi/view?usp=
=3Dsharing
> C reproducer: =
https://drive.google.com/file/d/1TTR9cquaJcMYER6vtYUGh3gOn_mROME4/view?usp=
=3Dsharing
> Syzlang reproducer: =
https://drive.google.com/file/d/1R9QDUP2r7MI4kYMiT_yn-tzm6NqmcEW-/view?usp=
=3Dsharing

Hi Andreas,

As per Jan's suggestion, we=E2=80=99ve successfully reproduced the crash =
with CONFIG_BLK_DEV_WRITE_MOUNTED disabled. Should you require us to =
test this issue again, we are happy to do so.

=E2=80=94=E2=80=94
Thanks,
Kun Hu=
