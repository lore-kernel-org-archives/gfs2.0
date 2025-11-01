Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A2A17B418
	for <gfs2@lists.linux.dev>; Sat,  1 Nov 2025 15:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762011339; cv=none; b=jP5KlSADiIgGhGlFd0YIZBj/KKSN2YFs5Xefx1gcbiIXRwflxpNKwd7ph3/S74PoQutoGBNTeHYaA+GXTeSigkzka+iFDSZ2eMVQwtFnBKi6nxOUSh/LyTM5zEP5bkHicaJIqpxKqTbXHV/M1qbN7cRQV1vZ48+lW3gixfRrKts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762011339; c=relaxed/simple;
	bh=d/Vi6umW296mUYSX4hNzCMgSwp/SLgfcmcKnoswc5Ic=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=s81wOInguMx5JeinzS16oyUgtt7jBnO4GReeMhYRZWTELVBC1n4Uch3JQPhtMieorimYAQPiw+0cGyq4+jQhNc9pJ/zLIBubGBcPCJCbHXI67uOxxvD9TTWoBmlhxEoGvTVRpt8Qn0L450JpZvcgOqVZgoE5cEA9XxlzGk8/7Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=XXuyroy4; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="XXuyroy4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=0c
	Ur8pYzuWRmcI+WIvUB5HLHJAPKHIi3okUSE03VhJw=; b=XXuyroy4GKTVq7M5nd
	uc8+R4KVpDuMSntHoOdff99bGuCR98dOXdN6zNmbQXgWA4LvTGc6YUv/hO3hisAw
	rzh2zIUynSxM0W8UtJsCsczenyW9Dkttyj5HSae6TVF2zieT9vKeUp6SP89bUl/i
	u8pgpQgQLv0QdAxNydRKd3GlY=
Received: from MacBookPro.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgDHd5+rKAZpxWMyCQ--.37795S2;
	Sat, 01 Nov 2025 23:35:23 +0800 (CST)
From: cestbonchen <cestbonchen@163.com>
To: agruenba@redhat.com
Cc: gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	syzkaller@googlegroups.com,
	cestbonchen <cestbonchen@163.com>,
	syzbot+353de08f32ce69361b89@syzkaller.appspotmail.com
Subject: [PATCH] gfs2: Fix invalid glock target state during withdraw
Date: Sat,  1 Nov 2025 23:35:03 +0800
Message-Id: <20251101153503.6019-1-cestbonchen@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgDHd5+rKAZpxWMyCQ--.37795S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WFy3uw4ktw4xuFyfZw1xGrg_yoW8XF48pr
	y5Wr47Ar4DKaykXw4UKanYkw1kWa95Gw47CrWkX3W0yan0kFyxXr42g3y7ZFWDJFZ3uF45
	WF1a9F1ayFWUWrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UTBTrUUUUU=
X-CM-SenderInfo: hfhv3uxrqfxvrq6rljoofrz/1tbiJgT4wGkGGzHSMwABs-

During filesystem withdraw, do_xmote() may set the glock target state
to LM_OUT_ERROR when the intended target is not LM_ST_UNLOCKED.
However, LM_OUT_ERROR is an operation result code, not a valid DLM lock
state. Passing it to finish_xmote() triggers a kernel BUG at
fs/gfs2/glock.c:674 due to an invalid state transition.

The correct behavior during withdraw is to force the target state to
LM_ST_UNLOCKED, which safely invalidates cached data via ->go_inval()
and avoids further DLM operations.

Fix both the general withdraw path and the -ENODEV error handling path.

Fixes: 669d4eb0b918 ("gfs2: Clean up properly during a withdraw")
Reported-by: syzbot+353de08f32ce69361b89@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?id=f9cc39ae87e4716a6309e8f5d558432cd90035ac
Signed-off-by: cestbonchen <cestbonchen@163.com>
---
 fs/gfs2/glock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index e19aa2e820c8..fb08660567ed 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -696,7 +696,7 @@ __acquires(&gl->gl_lockref.lock)
 skip_inval:
 	if (gfs2_withdrawn(sdp)) {
 		if (target != LM_ST_UNLOCKED)
-			target = LM_OUT_ERROR;
+			target = LM_ST_UNLOCKED;
 		goto out;
 	}
 
@@ -719,7 +719,7 @@ __acquires(&gl->gl_lockref.lock)
 			 * been unlocked implicitly.
 			 */
 			if (target != LM_ST_UNLOCKED) {
-				target = LM_OUT_ERROR;
+				target = LM_ST_UNLOCKED;
 				goto out;
 			}
 		} else {
-- 
2.43.0


