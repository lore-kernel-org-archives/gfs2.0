Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.254.49.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794321156;
	b=fCmHbn101nrwv1zXd4+oe9c+TwwtRGNMC/mH0Z4aEznrD1kAcCDrxCj1nqDAR1g+e4PP
	 5/OuEUhb2f15wFD0+l+zS5mCEcd+m3k1xCV1xf1rRFVO4Qq+cZ7u3KWUvlA/Yu7IdId3H
	 TLdpn9btT2xqEx/ZWfeOiElke51rvQK99Zk7ChDtrIa5jwj8RRVTPB5ZJfzZra9Ps1WhU
	 F5ZOB+8eDb20XDPEMODuGOTwxsJRUkHYTTCzcPG6cr8s+B83vtISE/mrMb6U3IY247V38
	 OFfKc8DtQRLLBHDkStCTdgzWMH/NgJs8GdCTgcCLnyrABQu9U24qZR4h87t5zjDI0Fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794321156;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-HM-Tid:
	 X-HM-MType:X-HM-Spam-Status:DKIM-Signature;
	bh=5WJo43basd2Nuy7XNUK8J6/4Xh64CirRclBNsFrvwDQ=;
	b=bNBCmqxoAwbxZ8aGWtPgIDFL2BbEKw6HrOiU/5Ibq0mxktdEsJQzmXGjlkjPB6uexg91
	 9mNXwObbH2MzPeNbdlWQzB9046RW7rD0ufzwbb3KeoxQ5f7XmJKZt5hVseTt05iqFV/8j
	 HWsX3OXtlr5/xTvBJSzoqmQakDBnNl37KM+24tUgxN0xvEXa0oAoAm8bvWzNErnMhoopx
	 WEkJ95exgH7E1MtPeSIkghXwNaJYnxPfDouWDpMjlpcpxbVQwY4Xne1fmYmnW4ny3oTCs
	 m8RhuSkE4e9//D+HkIRg5TICXptg+cXD5AgqVi3v/Txxhx2TA7ACQgbd7g/wsUHw3vQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.sdu.edu.cn;
	spf=pass smtp.mailfrom=mail.sdu.edu.cn;
	dkim=pass header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b="BJmL/Wx0";
	arc=none smtp.remote-ip=45.254.49.198
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086BE606A325
	for <gfs2@lists.linux.dev>; Tue, 10 Nov 2026 14:32:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 086BE606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=BJmL/Wx0
Received: from lgs.. (unknown [101.76.249.61])
	by smtp.qiye.163.com (Hmail) with ESMTP id 542cd9c43;
	Tue, 10 Nov 2026 22:32:22 +0800 (GMT+08:00)
From: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] gfs2: Fix potential recovery bitmap leak on mount failure
Date: Tue, 10 Nov 2026 22:32:21 +0800
Message-ID: <20261110-9f141e6bc8-gfs2@mail.sdu.edu.cn>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Post: <mailto:gfs2@lists.linux.dev>
List-Help: <mailto:gfs2+help@lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
List-Owner: <mailto:gfs2+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa1c5dfd44c03a1kunmfc3dce5c16cdc4
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCTUsdVhgZSkNDQktOHklJT1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKS0pVTE1VSU9CVU1KWVdZFhoPEhUdFFlBWUtVS1VLVUtZBg
	++
DKIM-Signature: a=rsa-sha256;
	b=BJmL/Wx0yG3dhqDQqjWZ6g1o1h7UqH5uLZmoyBna/5Rm73RjtU0WCWRQRsdKhb0ikHvDMZpp3TyqSz0NLXWaDYfAfGEXrQb+x/klpdXf7hEN9iF6FtZWnFwh6SbqIv64+7dqhYww8uui6Adg+ispDSif3R3HD4dz/mlvuhHw7wk=; s=default; c=relaxed/relaxed; d=mail.sdu.edu.cn; v=1;
	bh=5WJo43basd2Nuy7XNUK8J6/4Xh64CirRclBNsFrvwDQ=;
	h=date:mime-version:subject:message-id:from;

set_recover_size() can allocate the LVB bitmap before failing to allocate
the recovery arrays. Use the recovery cleanup path on this failure so
the bitmap is released before the superblock is freed.

This issue was found by our static analysis tool under development.

Fixes: 57c7310b8eb9 ("GFS2: use kmalloc for lvb bitmap")
Signed-off-by: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
---
 fs/gfs2/lock_dlm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/gfs2/lock_dlm.c b/fs/gfs2/lock_dlm.c
index 47eec0c13025..f3d2c6ad614f 100644
--- a/fs/gfs2/lock_dlm.c
+++ b/fs/gfs2/lock_dlm.c
@@ -1315,7 +1315,7 @@ static int gdlm_mount(struct gfs2_sbd *sdp, const char *table)
 
 	error = set_recover_size(sdp, NULL, 0);
 	if (error)
-		goto fail;
+		goto fail_free;
 
 	/*
 	 * prepare dlm_new_lockspace args
@@ -1384,7 +1384,6 @@ static int gdlm_mount(struct gfs2_sbd *sdp, const char *table)
 	dlm_release_lockspace(ls->ls_dlm, DLM_RELEASE_NORMAL);
 fail_free:
 	free_recover_size(ls);
-fail:
 	return error;
 }
 

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
