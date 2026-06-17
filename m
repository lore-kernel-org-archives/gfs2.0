Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0FF395AF0
	for <gfs2@lists.linux.dev>; Wed, 17 Jun 2026 09:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781686919; cv=none; b=UB98Fw8LRoW3LcV4vAjvu0XYPwl/Ryr8aGlsnzDlEXi61LNaKGamPDEQG2bqSFQ67gHcrVQy8SP77A8yUbaQOkA45XsGn7l/6YWeD0u1fyVbAvN9i9JfL2lgdFFtozmU54fcrTBF+moDdM7PguK8TYYWvpu6nzTvzA4LEgKignI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781686919; c=relaxed/simple;
	bh=9/OoYbJrCL//kiSb4MsyIPFutjEKgOPFPTI2qY/4THs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GRq/h7dza0C6zNJ18ib2UL8g+w/UhrGhWOamDqulbd7z5AK6FIQ/3qO2JSReUUr/Bul/7oeRlfNqTUR5PYOzBEzFAQdvIRuDIHzyTVn/PlAbqK3LQus0yNa8pcn+qNNTDYt7FPHP4i8QOtVAu7QaIBwNUn8/2rp9XRvPAwrm1i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 2d1c3ea46a2b11f1aa26b74ffac11d73-20260617
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:4042869d-f967-4c02-a626-2bac9b899792,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:0f34688fb48a7ecf7247636f46d3e22c,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
	DM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 2d1c3ea46a2b11f1aa26b74ffac11d73-20260617
X-User: zenghongling@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zenghongling@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1609382198; Wed, 17 Jun 2026 17:01:49 +0800
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
Date: Wed, 17 Jun 2026 17:01:43 +0800
Message-Id: <20260617090143.735219-1-zenghongling@kylinos.cn>
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

