Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F1A325496
	for <gfs2@lists.linux.dev>; Mon, 17 Nov 2025 09:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763370776; cv=none; b=Wi5KRoBJHQ5dsrlxAeTVBwFng3SLQr6vRvAT4uAC4aLUB9NY4Gj83wM5SNjav638ahP+eSWxRMyadMsKGVb2XX6mkasG29IYgGNoVF0rFkvXNbh7DIPTMUaSsv/P1TVWs87clLPoDi6AYg9TRW8R6QDpJKt2K38IadqTmArst8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763370776; c=relaxed/simple;
	bh=2VVFkfl4g1nx+AA/+GrQ825Z6764B184oZTxekTIHB0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XfqZvFiQF+7n9GkwrPCP950MB9odbTpiDmqk0OrPm7Z93WtIJyEBEv5d/tjlEOjvVYMnQFGzk+6Yx8zBPvbjDlUWCKvXMyXSX7rNHKaXSAMwBkLKYyMUl+fYbbFK8f8ZmBzu2o3UOF5tBEJ/AgLzA62hWSSW9DVWa0VUex3tJog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=NNacCmwD; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="NNacCmwD"
Received: from VelichayshiyPC.Dlink (unknown [178.69.159.220])
	by mail.ispras.ru (Postfix) with ESMTPSA id C812D408634C;
	Mon, 17 Nov 2025 09:06:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru C812D408634C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1763370405;
	bh=rIH7WAj84YL99BGcayq/d0ugGe6CjZl1r/LvuF1pGTs=;
	h=From:To:Cc:Subject:Date:From;
	b=NNacCmwDimTM441Om5N3GWOyl2PFRFQJ9F0Q2NkWAu88/+6wLN6aWL9+QAR8XMPxp
	 sZaeZuZwP0ToF6GAFtzoz1Ha4gA7G643gnZB7KNwuJl/27zlXdamRqeVrdnWyILwr9
	 Zsm4m0BCrcsaQSMnJeVnIuFPgEsRbPLZ5zmDRrc0=
From: Alexey Velichayshiy <a.velichayshiy@ispras.ru>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Alexey Velichayshiy <a.velichayshiy@ispras.ru>,
	gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH v2] gfs2: fix freeze error handling
Date: Mon, 17 Nov 2025 12:05:18 +0300
Message-ID: <20251117090603.13658-1-a.velichayshiy@ispras.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After commit b77b4a4815a9 ("gfs2: Rework freeze / thaw logic"),
the freeze error handling is broken because gfs2_do_thaw()
overwrites the 'error' variable, causing incorrect processing
of the original freeze error.

Fix this by calling gfs2_do_thaw() when gfs2_lock_fs_check_clean()
fails but ignoring its return value to preserve the original
freeze error for proper reporting.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Alexey Velichayshiy <a.velichayshiy@ispras.ru>
---
 fs/gfs2/super.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index 644b2d1e7276..54c6f2098f01 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -749,9 +749,7 @@ static int gfs2_freeze_super(struct super_block *sb, enum freeze_holder who,
 			break;
 		}
 
-		error = gfs2_do_thaw(sdp, who, freeze_owner);
-		if (error)
-			goto out;
+		(void)gfs2_do_thaw(sdp, who, freeze_owner);
 
 		if (error == -EBUSY)
 			fs_err(sdp, "waiting for recovery before freeze\n");
-- 
2.43.0

