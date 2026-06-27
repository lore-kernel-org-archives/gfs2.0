Received: from send55.i.mail.ru (send55.i.mail.ru [89.221.237.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77827285CB4;
	Sat, 27 Jun 2026 16:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.221.237.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782578011; cv=none; b=Fx+QZWILblCxRwLRip2rzA4sDFR03TocX/rKEBvM/4/dS6/wfeigHpnTlf9kgkaKoLidKLmjTjjX/bbspTF5QqGPd6slwJae7Q6Bz1gLDjj/DSJikJeY3Ey0+ZVoJp0hxCBQQ9H1L80UAQhyoTMT1jfYErqsttgLdE9G3V3RuAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782578011; c=relaxed/simple;
	bh=rFLPxK+aSbD91u+nhgu8BCP1Xmqdp7rRXxLF08GbkeA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LXOyku2wW2be4E6hmIzyOhf38mXE2rvF9fflytNbEJZ/XVbsBkiXs2MfIfPWNIj8F4Qnw7wm/ekpA2dtOL3cQX86O7vgBYCI0svwUzIi6FYvLwr0sroMmu9RJO2Qd/9fQhmJRmCe2BpLa7YvSWzQU/hkHeJaSnekBCnp4Ik/G3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru; spf=pass smtp.mailfrom=mail.ru; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=hE5IKdhq; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=OPpxpX30; arc=none smtp.client-ip=89.221.237.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="hE5IKdhq";
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="OPpxpX30"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:
	To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive:X-Cloud-Ids;
	bh=Qtc8rjOjKZRVmLEc/Fn2CPKY8YqfGK+Pwu1MABFvyR4=; t=1782578007; x=1782668007; 
	b=hE5IKdhq21z7QMhAsH3ubvB0tuh+hX+yZ8KEtlM3lzwrJerQBB29kNnR0oZIkLbwtumKyB82bnP
	n0l2LX68pDd0aPamT8l+38cVed7GzqzEI6b3CI1nuz8oQzN/q7IczVZMJXDyJulHnOZck6nY/ibWT
	280/Zn36ijTzyl7rvQncOHe5L8LDlYTkd7yJIo7/9LY//mV1gK24q2adiET3tskvs6mqX7BiC16Mm
	ccMYHAue4l3AqnMkDXlSElrc9YWFNfZcUqXX/5Ij2dEu4AvNh6rJ4VuiioVggApefDv0c1LJPz+nt
	8ji6TpXHTiZr6GYXXcffQfmnDmvS/IYjD8WQ==;
Received: from [10.113.252.53] (port=40278 helo=send276.i.mail.ru)
	by exim-fallback-7db886947c-vgflq with esmtp (envelope-from <listdansp@mail.ru>)
	id 1wdVjP-00000000I4y-17vU; Sat, 27 Jun 2026 19:18:13 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:
	To:From:From:Sender:Reply-To:To:Cc:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=Qtc8rjOjKZRVmLEc/Fn2CPKY8YqfGK+Pwu1MABFvyR4=; t=1782577091; x=1782667091; 
	b=OPpxpX30u1MR1S1QPWczCWcPjj4BGgfgj31ed1cZbOBHilgqeeyf/4ktBgecnYV7olP52nT5SpV
	XCg12jY5oFdi8JhQCfbDmPpUQfxfvoATCela0Au5fDvuwwDWz8b7JpG/VkMyfK93kL1F28p4os3zE
	dXI/ddcZH6Tt1cAkaIU7VZIFE4Pj/4FEGo77hi1pdjf9L/QQEpFG3ZCHj/kbtsdif7FCyL3B9E7NR
	crSPEFqCDPLnV2m9JT6dG8ZWJcciPNoh28T2/JWd/AyENxYhUne2OS7e2ro90M9Qk8yU3aEKphcQl
	YHDO5qLyCfS1ii1OpSliAjBPa1g7LB3Kwj6w==;
Received: by exim-smtp-78b8b8c574-4j46x with esmtpa (envelope-from <listdansp@mail.ru>)
	id 1wdVjF-00000000Pf2-2TVc; Sat, 27 Jun 2026 19:18:02 +0300
From: Danila Chernetsov <listdansp@mail.ru>
To: Alexander Aring <aahringo@redhat.com>
Cc: Danila Chernetsov <listdansp@mail.ru>,
	David Teigland <teigland@redhat.com>,
	gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH] dlm: The core of the DLM for GFS2/CLVM
Date: Sat, 27 Jun 2026 16:17:21 +0000
Message-Id: <20260627161721.129861-1-listdansp@mail.ru>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD918D6BB028DF8CB6160F722F80D1938568A4823BFAE13B784182A05F5380850405CB2D9A2314B05693DE06ABAFEAF6705309ACB8885212EFEF56BBBE89A28EED1AF0056C46A67EA41
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7AF18881564A951B9EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637AC83A81C8FD4AD23D82A6BABE6F325AC2E85FA5F3EDFCBAA7353EFBB553375667A8D271431AA2D757B6841F7CA3C8A803C6A6001FC0995FA63414217D8A300EB8EEF46B7454FC60B9742502CCDD46D0D1E44367C8E80A7B4F6B57BC7E64490618DEB871D839B73339E8FC8737B5C2249CDE59DDCCE53AF2BCC7F00164DA146DAFE8445B8C89999729449624AB7ADAF37F6B57BC7E64490611E7FA7ABCAF51C92176DF2183F8FC7C060F9ADC06DA375D58941B15DA834481F9449624AB7ADAF37BA3038C0950A5D3613377AFFFEAFD269176DF2183F8FC7C0044B9F2C9FBC7C0D7B076A6E789B0E97A8DF7F3B2552694AD5FFEEA1DED7F25D49FD398EE364050FB28585415E75ADA9B341D7040ADD27A2B3661434B16C20ACC84D3B47A649675FE827F84554CEF5019E625A9149C048EE9ECD01F8117BC8BEE2021AF6380DFAD18AA50765F790063735872C767BF85DA227C277FBC8AE2E8B2299DC0B1123EF2375ECD9A6C639B01B4E70A05D1297E1BBCB5012B2E24CD356
X-C1DE0DAB: 0D63561A33F958A563CAA048494EA9515002B1117B3ED69675D2E50056341CDCC89B063BDC7FAC35823CB91A9FED034534781492E4B8EEAD2739D626790C8313C79554A2A72441328621D336A7BC284946AD531847A6065A17B107DEF921CE79BDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0AD73CAD6646DEDE191716CD42B3DD1D34C77DD89D51EBB774225B6776AC983F447FC0B9F89525902EE6F57B2FD27647F25E66C117BDB76D65965A50EF2D561DE48312A6EF1EF7F2DF6886533E0E34984E7784A1C14FDE05A4759DD727AAE8B343AB8341EE9D5BE9A0ACBF427442584B153C27C236185F89F10C7AE3191487874FE721D270AA2B885D14C41F94D744909CE04437D853D7CD20871FE3B1D98EC473624A389F0E278DBF4
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+ObcCpyrx6l7KImUglyhkEat/+ysWwi0gdhEs0JGjl6ggRWTy1haxBpVdbIX1nthFXMZebaIdHP2ghjoIc/363UZI6Kf1ptIMVRSZSJkMhZtMmcRJw1LArIg=
X-Mailru-Sender: 4CE1109FD677D277A25EA9D9B320DF53A289993E0C5B2135B951B70A5BD4BD8E2D57F4CF5D569E423C72AD0B1D2E52B0C53BD13D3F6EEB2F3DDE9B364B0DF289C95E31D8FCF52BE1594FB4C9F0DBF4120D4ABDE8C577C2ED
X-Mras: Ok
X-Mailru-Src: fallback
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B4FA133F958ACA88638E64B5B6F18F8E39D9B32733C1737D5B049FFFDB7839CE9EC8994B5FF94C9042D2EC4F926DA38DFF7E2CE769E06B4F0A85DDCD195D599963DBF7E0B554C3EE3A
X-7FA49CB5: 0D63561A33F958A5B3772422863172B45002B1117B3ED69650DBF98BAAF2EBE6C01B4B6FA7B343C102ED4CEA229C1FA827C277FBC8AE2E8B54F520D093A0DF28
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+OYcBso8Zm+oliTz8oZwnDrFsY77LZRcHyw5ht0smWrfSeTW5FiI8avd9v29gUBslpEZ9wIMwqVP4jLQVQ+dVm7x9BpDHadBV9RMjI809PraZJgo3RGM/qrp4Pw3vuP8Q3Q==
X-Mailru-MI: 20000000020000000000000800
X-Mras: Ok

The DLM recovery path restores lock state from rcom_lock messages
received from remote nodes. The lock modes in these messages are
copied directly into the local lkb state without validating that they
are within the valid DLM lock mode range.

The rest of the DLM code assumes that lkb_rqmode and lkb_grmode
contain valid lock modes. In particular, LVB callback handling in
dlm_may_skip_callback() uses lock modes as indexes into the
dlm_lvb_operations array:

    dlm_lvb_operations[prev_mode + 1][mode + 1]

An invalid lock mode received during recovery could therefore result in
an out-of-bounds read during subsequent LVB callback processing.

Validate rl_rqmode and rl_grmode before storing them into the local LKB
state. This preserves the lock mode invariant required by the rest of
the DLM code.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: e7fd41792fc0 ("[DLM] The core of the DLM for GFS2/CLVM")
Signed-off-by: Danila Chernetsov <listdansp@mail.ru>
---
 fs/dlm/lock.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index c381e1028446..3be1d6007e35 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -5529,6 +5529,10 @@ static int receive_rcom_lock_args(struct dlm_ls *ls, struct dlm_lkb *lkb,
 {
 	struct rcom_lock *rl = (struct rcom_lock *) rc->rc_buf;
 
+	if (rl->rl_rqmode < DLM_LOCK_IV || rl->rl_rqmode > DLM_LOCK_EX ||
+	    rl->rl_grmode < DLM_LOCK_IV || rl->rl_grmode > DLM_LOCK_EX)
+		return -EINVAL;
+
 	lkb->lkb_nodeid = le32_to_cpu(rc->rc_header.h_nodeid);
 	lkb->lkb_ownpid = le32_to_cpu(rl->rl_ownpid);
 	lkb->lkb_remid = le32_to_cpu(rl->rl_lkid);
-- 
2.25.1

