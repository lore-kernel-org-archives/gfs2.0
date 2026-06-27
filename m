Received: from send100.i.mail.ru (send100.i.mail.ru [89.221.237.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2529D285CAD;
	Sat, 27 Jun 2026 16:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.221.237.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782579510; cv=none; b=ojfIUCYCiE5+xPe0dXObFzqdMGdoSGken3k0yXaIqBnn9Tk8ns4C1hTVuYufFxD1JwYswpm4fIt9/hDC3LBpremdt2LrXal8Y79OeBnv37Iwooa/rG5TtZSV+As1xNjKJo8Kvqf1ROekKDNMkvJGYt6gz1u1hMgEkmDX8EzkshA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782579510; c=relaxed/simple;
	bh=u9S4B6a8VjHL4FDi1UBPwXINLyUpmPIVH3qUbW64Zig=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QlLJppXZvvAn6Ss38DzZeqq/OlD60iI2qFO1m7w0bapYQr0+Vf5t4jb0YGtUkK5hpmUUBbTrWe6dacjPUSaBMPB6cmDsbIP/TAIEmPiILmwMBtNDvdjCg281Sfde2T1naKIsu+PxWD22Md5ZNK2On+gtOM5amjc6/hpMr8u1IsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru; spf=pass smtp.mailfrom=mail.ru; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=tWBgbpfX; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=EHAT5CVM; arc=none smtp.client-ip=89.221.237.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="tWBgbpfX";
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="EHAT5CVM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive:X-Cloud-Ids;
	bh=12VCEfEpSTnv3MtNJOLbdyS4O1xD0+2mBF05DrnlJgQ=; t=1782579506; x=1782669506; 
	b=tWBgbpfXq1TTulIUEezBkypaBUh7qmShtTXpvsYHO2vLWfBoIMMXV0KzH+f8I8OeQsbG9NJu/0o
	/lA3klyztajIxgtN8jx0LTVCt9De49mevamxM4ZIkmN2qMhO68NH725rnB3SZRbZMqgcJG/pQ43U3
	JRgnSED3ycyzOBaEbRBPnBGBMfCuF4r5SbMLX9lGrARNSY6dkg0KW7JtX0Ezm7z4HqniLqhqPwE4K
	KlfTj2dMs1U+iMREU2At/zjxdnTF4HKquualI5xQIE4/1g+oopI+I8cJNhhrLOpPqA1ggVWr5OJn7
	3mAjrwuk2CyAwwdz3BGebNmNv0ocNCyDI10A==;
Received: from [10.113.2.44] (port=34082 helo=send151.i.mail.ru)
	by exim-fallback-7db886947c-jfr2j with esmtp (envelope-from <listdansp@mail.ru>)
	id 1wdW7e-00000000EbU-1ECx; Sat, 27 Jun 2026 19:43:14 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=12VCEfEpSTnv3MtNJOLbdyS4O1xD0+2mBF05DrnlJgQ=; t=1782578594; x=1782668594; 
	b=EHAT5CVMmJWfKQ6yB9nplGlAFyjTkDc2u9LONxFHO1bQTWv2lj51TUylJwqZQGOijJNQxxKuLNz
	Y48w1qlAJOhNYadXzsJP8Zp4oMIawX8UFRGIa7mlhtXuO/DvX3GnWUt+WBdRnmPx8K6IN/HpHMGH/
	ITx/QraqPvi7CESaX5ADEvEj/GFfmZqtvgXk4kuq6JOgsMZ2juvxpvihdUlie3K0ip+FcXrpGg5ZF
	GdecRI4pHPk/kdbBxVf1XiowSrv/G2ZU41ZfwroshOE2acE9LhLCwrcgI3iJhe4l6YwkTo4WCXhbl
	25draukHNvr0uiHYw/sITQ5FYf5CS8fJ/ClA==;
Received: by exim-smtp-78b8b8c574-mttf2 with esmtpa (envelope-from <listdansp@mail.ru>)
	id 1wdW7T-00000000WnP-0tHT; Sat, 27 Jun 2026 19:43:03 +0300
From: Danila Chernetsov <listdansp@mail.ru>
To: Alexander Aring <aahringo@redhat.com>
Cc: Danila Chernetsov <listdansp@mail.ru>,
	David Teigland <teigland@redhat.com>,
	gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH v2] dlm: validate lock modes in recovery messages
Date: Sat, 27 Jun 2026 16:42:11 +0000
Message-Id: <20260627164211.134982-1-listdansp@mail.ru>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260627161721.129861-1-listdansp@mail.ru>
References: <20260627161721.129861-1-listdansp@mail.ru>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD918D6BB028DF8CB61525AEE36BB2062474470531DE4816542182A05F5380850400B49814DA136993A3DE06ABAFEAF6705A81937E9D93765388516D4EB2A802F64DE2E4F11C3090EAD
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7D3E352D4AD7EBF54EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637AC83A81C8FD4AD23D82A6BABE6F325AC2E85FA5F3EDFCBAA7353EFBB553375667A8D271431AA2D755F040100554B2BE00AECC46AA362946B1045FF463A6A754A8EEF46B7454FC60B9742502CCDD46D0D0839144E5BB460BAF6B57BC7E64490618DEB871D839B73339E8FC8737B5C224915519F706774CB6ACC7F00164DA146DAFE8445B8C89999729449624AB7ADAF37F6B57BC7E64490611E7FA7ABCAF51C92176DF2183F8FC7C0F9892FFADCC82CE38941B15DA834481F9449624AB7ADAF37BA3038C0950A5D3613377AFFFEAFD2691661749BA6B97735E0359D86951506AA7B076A6E789B0E97A8DF7F3B2552694AD5FFEEA1DED7F25D49FD398EE364050F437C869540D2AB0F436E4CC186B5AB2DB3661434B16C20ACC84D3B47A649675FE827F84554CEF5019E625A9149C048EE9ECD01F8117BC8BEE2021AF6380DFAD18AA50765F790063735872C767BF85DA227C277FBC8AE2E8B6D5978F13CF55F0A75ECD9A6C639B01B4E70A05D1297E1BBCB5012B2E24CD356
X-B7AD71C0: 6FEFE4C63DFE2D851629A3278334FCEC2AD323669803AD9FE6E38E9349F0B9667F35BAA83BD2469459E970AB7D0E9FF0
X-C1DE0DAB: 0D63561A33F958A53B31342874CC5B155002B1117B3ED696841053EFFE880216484B8D70797403F6823CB91A9FED034534781492E4B8EEAD37F46C620FF2CAEEC79554A2A72441328621D336A7BC284946AD531847A6065A17B107DEF921CE79BDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0AD73CAD6646DEDE191716CD42B3DD1D34CB8C0E004AB9358F525B6776AC983F447FC0B9F89525902EE6F57B2FD27647F25E66C117BDB76D659714797C67397DA9B89F0C74F1DE277446DD1BE6A5EB7B27897B11BB2ADCDC8FCEC867B1762F49EEFB8341EE9D5BE9A0A07629BF80C8413A2964ACCCFA6D8B3470568C83604E6C60A721D270AA2B885D14C41F94D744909CE04437D853D7CD20871FE3B1D98EC473624A389F0E278DBF4
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+ObcCpyrx6l7KImUglyhkEat/+ysWwi0gdhEs0JGjl6ggRWTy1haxBpVdbIX1nthFXMZebaIdHP2ghjoIc/363UZI6Kf1ptIMVRSZSJkMhZtMUts3V6BVurk=
X-Mailru-Sender: 4CE1109FD677D277A25EA9D9B320DF5360C5F37B160A0A87B951B70A5BD4BD8E43BB109172E94817C655969879B08F79C53BD13D3F6EEB2F3DDE9B364B0DF289C95E31D8FCF52BE1594FB4C9F0DBF4120D4ABDE8C577C2ED
X-Mras: Ok
X-Mailru-Src: fallback
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B4FA133F958ACA88638E64B5B6F18F8E395F4284038122D8BB049FFFDB7839CE9EC8994B5FF94C90420243087173F5EC76CB422B20AD978E4235466F4EF61FEA02331D1819EA0C466F
X-7FA49CB5: 0D63561A33F958A5198CFA790F7BDDA35002B1117B3ED6969A20CA0F2D272E0B3D1B8CC3424EAECF02ED4CEA229C1FA827C277FBC8AE2E8B54F520D093A0DF28
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+OYcBso8Zm+oliTz8oZwnDrFsY77LZRcHyw5ht0smWrfSeTW5FiI8avd9v29gUBslpEZ9wIMwqVP4jLQVQ+dVm7x9BpDHadBV9RMjI809PraZjmI79EXTy1Ma6V3oQYPYnw==
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
Changes in v2:
- Fixed an incorrect patch subject from the previous submission.

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

