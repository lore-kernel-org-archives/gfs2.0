Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90270349B19
	for <gfs2@lists.linux.dev>; Tue, 25 Aug 2026 01:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787622923; cv=none; b=CurgAvJN5JOZcXejscvCSTqbQ7va0K6JEHK26GnOldAkyySLiepwBG9x5xwDcv/Yd3Bqgh9CM+0pg9poGcbkTkspUfeHAyUiBuOB5ahMMO/adeN3JTW9yayqtF21QvtMzis8hs1fuY56ilRm7+asAGAKPGZn4luz+B4CbKHOJrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787622923; c=relaxed/simple;
	bh=yBTfXNcxdlrQIVtwnlU/pFCYCvgy2a9QKjszkzYIPDg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=P5ZFYpGpPngQYqR+w78lyC+GeiCuuwvzx18RWVja/IfJs4RLc7JMVa3rGmOrEpnjE907mknRY8kV3pGwqU8wk1OjXCsX92oeZZB72Bv+wiB4tO+3BuJVM/pbOdQLjrQtdwdyYW+vlZT3Oa8nBdQ0Rj3or2/Sbx1UXHNswQAvDiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: fe14eb78a02711f19a56ed5b684f684d-20260825
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:c1b9de98-43fb-4b34-9278-1c94c85cbcef,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:4883dc32d67551e314fd2c9c6bbd2cbd,BulkI
	D:nil,BulkQuantity:0,SF:102|850|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:n
	il,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LE
	S:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: fe14eb78a02711f19a56ed5b684f684d-20260825
X-User: zenghongling@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zenghongling@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 920026769; Tue, 25 Aug 2026 09:55:05 +0800
From: Hongling Zeng <zenghongling@kylinos.cn>
To: agruenba@redhat.com,
	anprice@redhat.com,
	swhiteho@redhat.com,
	gregkh@linuxfoundation.org,
	rpeterso@redhat.com
Cc: gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	zhongling0719@126.com,
	Hongling Zeng <zenghongling@kylinos.cn>
Subject: [PATCH v2] gfs2: move brelse() after buffer head accesses
Date: Tue, 25 Aug 2026 09:55:01 +0800
Message-Id: <20260825015501.633078-1-zenghongling@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The brelse() call happens before all buffer head accesses are complete.
While the reference counting prevents a real use-after-free in practice,
this pattern is error-prone for future maintenance.

Move the brelse() call to the end of the function to make the intent
clearer and eliminate potential static analysis warnings.

Suggested-by: Andreas Gruenbacher <agruenba@redhat.com>
Suggested-by: Andrew Price <anprice@redhat.com>
Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
---
 Change in v2:
 -Correct the commit.
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

