Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D947211C89
	for <gfs2@lists.linux.dev>; Mon,  5 Feb 2024 08:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707123604; cv=none; b=WIPkfA6RSZa51OYUlinb41/aqiPBwh3ywn14nSa41QD3BWzWrF0QGdV6TBZjpf6px64fKCQO/4tBOO0A8s3MfnxRaLVJR+/NC8ycHpRDxh9OE93SweZvHzghr+Rd+aiXV8tQGrdWM8rwqBsjtIG0cC6ursEJMXHHqiXsILeFCZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707123604; c=relaxed/simple;
	bh=iUexCMalKBWpEfcbdAvmle3x/PtwaKT1i+ys8RT6WyA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YFzLRNMSTxn/I+512KxbG5NkX8c2FzA+sDSfP+Si8w7u0/WcVnm2UlwXjv1SH2iU3CQcl2fvvRYurlmkz6OyhkcaAWHHj66Q+oMxdVKOEMQwGigm3ABwD6nZrmtZsBUL/z7vp0p+BPsJ6tWu1jOmQblp3CbK1ARiGONIDt2/tL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 945148aa29f24604a0175eae1108e9c7-20240205
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:a2d60129-7c4b-490e-9c8a-a98836b1eafe,IP:20,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:30
X-CID-INFO: VERSION:1.1.35,REQID:a2d60129-7c4b-490e-9c8a-a98836b1eafe,IP:20,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:30
X-CID-META: VersionHash:5d391d7,CLOUDID:38212280-4f93-4875-95e7-8c66ea833d57,B
	ulkID:2402051659566CSA1LK0,BulkQuantity:0,Recheck:0,SF:66|24|17|19|44|102,
	TC:nil,Content:0,EDM:5,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,
	OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS
X-UUID: 945148aa29f24604a0175eae1108e9c7-20240205
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1952537164; Mon, 05 Feb 2024 16:59:53 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 26A27E0005A3;
	Mon,  5 Feb 2024 16:59:52 +0800 (CST)
X-ns-mid: postfix-65C0A387-960952945
Received: from kernel.. (unknown [172.20.15.254])
	by mail.kylinos.cn (NSMail) with ESMTPA id 65085E000EBC;
	Mon,  5 Feb 2024 16:59:51 +0800 (CST)
From: Kunwu Chan <chentao@kylinos.cn>
To: aahringo@redhat.com,
	teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH] fs: dlm: Simplify the allocation of slab caches in dlm_midcomms_cache_create
Date: Mon,  5 Feb 2024 16:59:49 +0800
Message-Id: <20240205085949.439628-1-chentao@kylinos.cn>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
to simplify the creation of SLAB caches.

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 fs/dlm/midcomms.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/dlm/midcomms.c b/fs/dlm/midcomms.c
index 2247ebb61be1..8e9920f1b48b 100644
--- a/fs/dlm/midcomms.c
+++ b/fs/dlm/midcomms.c
@@ -226,8 +226,7 @@ static DEFINE_MUTEX(close_lock);
=20
 struct kmem_cache *dlm_midcomms_cache_create(void)
 {
-	return kmem_cache_create("dlm_mhandle", sizeof(struct dlm_mhandle),
-				 0, 0, NULL);
+	return KMEM_CACHE(dlm_mhandle, 0);
 }
=20
 static inline const char *dlm_state_str(int state)
--=20
2.39.2

