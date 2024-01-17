Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1367B14265
	for <gfs2@lists.linux.dev>; Wed, 17 Jan 2024 09:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705484964; cv=none; b=ptCV5uyUUGgoRxwCYFc+RjqE5Xo8fbB+nbOcuJMig04QXm+D8Ry96ojmGoLCv1SSBMrJpOi1LbKdfWMoQK4GMy7APzMsweAo849TdfUt+5sn9B3tr4srJ5Rd/M2KDh/NUCP+RuwnIfdoF4WFzeyeUUmyM1jTxB/kGCN8BwSzrx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705484964; c=relaxed/simple;
	bh=7GWS1V6NjJSHOFU7bkOXSHE/D7l3qrvU5HZcUfH1Vnk=;
	h=X-UUID:X-CID-P-RULE:X-CID-O-INFO:X-CID-INFO:X-CID-META:X-CID-BVR:
	 X-CID-BAS:X-CID-FACTOR:X-UUID:Received:Received:X-ns-mid:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding; b=AYHSX/GKvJ4bTCuDL3/X+wxlhErzCFYc7mAXBfERfRWiM4Axtlx2oxdFhFrqlK8AxHMZHg3V4JqxHiBF3PV/xgYc3HIjHVngaOriZjQ9c0hUHY1Xs+uALJZmsnor4WTtQJ50DlNbwyS7VkxS1REeznhukg8yzbtcqTN7/sfAFS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 6a3c479c79494d19a82d0990871f5611-20240117
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:99b7ab5f-8fc9-4f37-af81-8e90cc9060ab,IP:10,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:20
X-CID-INFO: VERSION:1.1.35,REQID:99b7ab5f-8fc9-4f37-af81-8e90cc9060ab,IP:10,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:5d391d7,CLOUDID:f0ac432f-1ab8-4133-9780-81938111c800,B
	ulkID:240117174916YVG0YATC,BulkQuantity:0,Recheck:0,SF:66|24|17|19|44|102,
	TC:nil,Content:0,EDM:5,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,
	OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 6a3c479c79494d19a82d0990871f5611-20240117
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 757765849; Wed, 17 Jan 2024 17:49:15 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 0B315E000EB9;
	Wed, 17 Jan 2024 17:49:15 +0800 (CST)
X-ns-mid: postfix-65A7A29A-856248760
Received: from kernel.. (unknown [172.20.15.234])
	by mail.kylinos.cn (NSMail) with ESMTPA id 911CEE000EB9;
	Wed, 17 Jan 2024 17:49:14 +0800 (CST)
From: Kunwu Chan <chentao@kylinos.cn>
To: aahringo@redhat.com,
	teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH] fs: dlm: Simplify the allocation of slab caches in dlm_lowcomms_msg_cache_create
Date: Wed, 17 Jan 2024 17:49:12 +0800
Message-Id: <20240117094912.155729-1-chentao@kylinos.cn>
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
 fs/dlm/lowcomms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
index 6296c62c10fa..712165a1e567 100644
--- a/fs/dlm/lowcomms.c
+++ b/fs/dlm/lowcomms.c
@@ -248,7 +248,7 @@ struct kmem_cache *dlm_lowcomms_writequeue_cache_crea=
te(void)
=20
 struct kmem_cache *dlm_lowcomms_msg_cache_create(void)
 {
-	return kmem_cache_create("dlm_msg", sizeof(struct dlm_msg), 0, 0, NULL)=
;
+	return KMEM_CACHE(dlm_msg, 0);
 }
=20
 /* need to held writequeue_lock */
--=20
2.39.2

