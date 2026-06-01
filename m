Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2E7126C03
	for <gfs2@lists.linux.dev>; Mon,  1 Jun 2026 02:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780280305; cv=none; b=RzsZhJNC80B9ud3/nelvVBMVoVWBBq3M10p1h/zJuQ8tYLhQHTaLwieCYBSrp1n5NE7gtWGsegpCaFZkQtJUnq+0gYWFxQ0r0z82o57OuknFN/lu7jnHYgjczPD6ICmA6NWXvHNfT9LSAETbYaAmMfwytVx0/pifL+wPjoJqH4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780280305; c=relaxed/simple;
	bh=9/OoYbJrCL//kiSb4MsyIPFutjEKgOPFPTI2qY/4THs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ekelQURauhlI04xBEoMHSh+OMedcB5+1s4WgD38sWQPX44PB0fYcB+m6uiemYAWphByBdin0zHn9SR+k0okSpfiDOMDHFndZah+xPrT3SbRovm5UwGFI3OYUpgR9Fkit/d/9Dl9CZIaOL2vaSaS2VIFRQAQc/XuLwcmo8umMmUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 27bd8c1a5d6011f1aa26b74ffac11d73-20260601
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:c5a2195f-e3aa-4e67-ba15-095144402682,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:e8432f2e79e2d9283b8a5227bf4c10d3,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
	DM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 27bd8c1a5d6011f1aa26b74ffac11d73-20260601
X-User: zenghongling@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zenghongling@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1406518520; Mon, 01 Jun 2026 10:18:19 +0800
From: Hongling Zeng <zenghongling@kylinos.cn>
To: agruenba@redhat.com,
	swhiteho@redhat.com,
	gregkh@linuxfoundation.org,
	rpeterso@redhat.com
Cc: gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	zhongling0719@126.com,
	Hongling Zeng <zenghongling@kylinos.cn>
Subject: [PATCH] gfs2: Fix use-after-free in gfs2_remove_from_journal()
Date: Mon,  1 Jun 2026 10:18:12 +0800
Message-Id: <20260601021813.15468-1-zenghongling@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function calls brelse(bh) but then continues to access
the buffer head through bh->b_private, clear_buffer_dirty(),
and clear_buffer_uptodate().

After brelse() decreases the reference count, the buffer head
may be freed, making the subsequent accesses use-after-free.

Fix by moving the brelse(bh) call to the end of the function,
after all accesses to bh have been completed.

Fixes: e93b100931a4 ("GFS2: Fix slab memory leak in gfs2_bufdata")
Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
---
 fs/gfs2/log.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/gfs2/log.c b/fs/gfs2/log.c
index 78bba8cc10b8..a92c84146de9 100644
--- a/fs/gfs2/log.c
+++ b/fs/gfs2/log.c
@@ -1038,7 +1038,6 @@ void gfs2_remove_from_journal(struct buffer_head *bh, int meta)
 			set_bit(TR_TOUCHED, &tr->tr_flags);
 		}
 		was_pinned = 1;
-		brelse(bh);
 	}
 	if (bd) {
 		if (bd->bd_tr) {
@@ -1056,6 +1055,8 @@ void gfs2_remove_from_journal(struct buffer_head *bh, int meta)
 	}
 	clear_buffer_dirty(bh);
 	clear_buffer_uptodate(bh);
+	if (was_pinned)
+		brelse(bh);
 }
 
 /**
-- 
2.25.1

