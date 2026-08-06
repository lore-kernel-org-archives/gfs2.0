Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D2547DD43
	for <gfs2@lists.linux.dev>; Thu,  6 Aug 2026 16:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786035592; cv=none; b=kwXbgo/cdovVoND0nXUWgoVZafHES1X2mCHmXa9dd+9Dvw44Ughp6ToOdVKMqw2MUhwOKI8M3CkuryBng3VO9Eyf6J9uEcllW0y6cJSvkdKVr6D5wQ9giS4xCGc7BQTxxMr7HlC1b21fc3+R3k6fa50ap3C/cOLXpDKaJahd0+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786035592; c=relaxed/simple;
	bh=oJD4nFEyaXWgVqYToy/GNwtnNE2Mg2QHu3WCWAeSWAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=txUQjKDmHp8/4Zg4nqVnsNKYKOsyiB7Blr1zCy9tbpYAt2uOOp9eKIL0EI8LUPz+veAGx9UtcGxqrTfYQpIgGNpHmG3QBQbHPlGej+eZiBmSHH6huVdtTrri25m3Uv7bSaXWDNr+qIH/7CNUcOO5FskiQL5nyUAuLtKODBV3aqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M9CZ0o1j; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M9CZ0o1j"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5bf94664327so1024614e0c.1
        for <gfs2@lists.linux.dev>; Thu, 06 Aug 2026 09:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786035587; x=1786640387; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i1O4+GTfBoV2V1bEoIh5L2jSUBNvl32w940uX7HvSIA=;
        b=M9CZ0o1jlY1mFhrDk/NDJ8jIL69zsdAj4gMnlKSuxjOVnLTiMksWVF8duFrA45doC7
         VKNpDwjtWErvvD7/7SRb7MTU/Dnq1XujdFbgbkqIfGayipqW7YaBucQxH/XCRqaJv9GN
         VMHxCG/7K7sGg7ElXYadKHvNHuf8CZtgZmUPniCJP1x82Dl3oL3kKXTm2ppWijYGqm/a
         XqpUoyVEP+0fCjkOYRVka5RMXyyVLSiQbBp12abPmDletpF+c/nkW+7gxPTB8/6A50uj
         gqaUQAIpgmO7bOuiqIID14in+GT8/Lu+OqXXxRZrgv8tPYN4mOlQqmNfI7FvUPP/7sLZ
         cCkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786035587; x=1786640387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=i1O4+GTfBoV2V1bEoIh5L2jSUBNvl32w940uX7HvSIA=;
        b=nHLHuNcGhMXWiOpT/TxFP8JMEl6QHZeXKmzkMH3KRq7mn99qzYqtsoXpi4HDMAVIFw
         6eUHei0fLkUp4PUkBAWxe/gK0Tb4Ti/r4ufwy0UxLZUjL+xZbHWvC5yZnZYmbEx/zCMW
         KrU+UdSTEzOi2NAMVoHYo3v9ThLQLrN5tYOyLN/KRIz5An/1+MPsXXLQTaTErfmick44
         HZUVEr96qUqmFEbd+gR1e5w369hjkwXVyVI2n1jE+Xe2/2cnws2DwN7EC2gQNPkIJO6V
         4Oa2ruOByz3dSv3puH3y9oxJGQQQG8Ez9ajKMg0MnZnT46mS561cK7/ORl1vy7O1hmro
         Uk5w==
X-Forwarded-Encrypted: i=1; AHgh+RoyfvtkZiSmsViqz64ty08jIcuMNBLHkSXNZyxche1VrWLaBibSSqrRcNVKOFJWVeGeAQ39@lists.linux.dev
X-Gm-Message-State: AOJu0Yw68ZBhkGJKuAMqxJJO+IgiGeQwHoo2qjVC063Gb2vemPanNPut
	SpISDMFnGrlrxKHp0VMj9ubam1VKDEOMVf2mO+IEr9ZwA0secSBFh/Kv
X-Gm-Gg: AR+sD11R+HuZ+WFX6K4QKjQU5YP/UHZdcn42rtS8+SiWYJ2DKOHpZKB4b7nY1phIwpb
	H5XUc13x6YdBVTuUKVzAVFKoBCXqZaR2QnriccWHsumwawzLzhi5wHZI+SQHUnRP9/cSkF8ZZCF
	QFclaopk5MR3ojJ3CT5Fgh8/Mns2mZ8MBv04kj1ETQVJYDc0DVUb655UmLK3WCb7dOAUmon9PLV
	5VI+V33YAtMJNKJcF/jAEtViA5l2Js9nUMoFKCRCHQ0gN0er93HIAfv5Ulw38+NzHyA0bNWWSiI
	0aXDD7DUXbvUDmQaxiOCHVpfWC9H98ZTtPt+mYt9s3SbBZ24Fb1dwnzkhZqzu3R/PBsxQXkBA2q
	5lIl4FDocA7fycWfcmD8c/OovmQEgo753AyXfu8bUQ6qp5TdIU2X7c7fyrncFwpG901NSWUXNoD
	hbbFUgxCqhmqEQ5N1vai9xaB6O4XfuEIfNWfkKVxuPYftUIWWxgEDGC4pko0YsbrLY035bmknm7
	7y/ZVE=
X-Received: by 2002:a05:6122:3a0c:b0:5c2:ac92:eb18 with SMTP id 71dfb90a1353d-5c3d919ab80mr2046889e0c.7.1786035586648;
        Thu, 06 Aug 2026 09:59:46 -0700 (PDT)
Received: from syssplab.cs.fiu.edu (nat1.cs.fiu.edu. [131.94.134.89])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c3d05c594fsm3706321e0c.8.2026.08.06.09.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 09:59:45 -0700 (PDT)
From: Chao Shi <coshi036@gmail.com>
To: Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Matthew Wilcox <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Baokun Li <libaokun@linux.alibaba.com>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Zhang Yi <yi.zhang@huawei.com>,
	Zhang Yi <yi.zhang@huaweicloud.com>,
	Bob Copeland <me@bobcopeland.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	linux-ext4@vger.kernel.org,
	ocfs2-devel@lists.linux.dev,
	gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Chao Shi <coshi036@gmail.com>,
	Weidong Zhu <weizhu@fiu.edu>
Subject: [PATCH v2 10/21] omfs: check for an inode write error with buffer_write_io_error()
Date: Thu,  6 Aug 2026 12:58:33 -0400
Message-ID: <b33ccb12c29ae743ccfa48cdf1e9140fbf2dabcc.1785951556.git.coshi036@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1785951556.git.coshi036@gmail.com>
References: <cover.1785951556.git.coshi036@gmail.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__omfs_write_inode() spots a failed synchronous write, on both the primary
block and each mirror, by testing BH_Req together with !BH_Uptodate.  That
relies on the write completion handler clearing BH_Uptodate on error, which
this series removes: a buffer whose write failed still holds the data the
filesystem asked to be written, so declaring it not up to date is wrong and
makes callers re-read it.

BH_Write_EIO says exactly what this code wants to know, and it implies
BH_Req, so each pair collapses into one test.

No behaviour change today - a failed write sets BH_Write_EIO and clears
BH_Uptodate together.  It stops being a no-op at the end of the series,
where the new test is the one that still works.

Acked-by: Weidong Zhu <weizhu@fiu.edu>
Signed-off-by: Chao Shi <coshi036@gmail.com>
---
 fs/omfs/inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/omfs/inode.c b/fs/omfs/inode.c
index 1d915ef72119..bc37029a4afb 100644
--- a/fs/omfs/inode.c
+++ b/fs/omfs/inode.c
@@ -145,7 +145,7 @@ static int __omfs_write_inode(struct inode *inode, int wait)
 	mark_buffer_dirty(bh);
 	if (wait) {
 		sync_dirty_buffer(bh);
-		if (buffer_req(bh) && !buffer_uptodate(bh))
+		if (buffer_write_io_error(bh))
 			sync_failed = 1;
 	}
 
@@ -159,7 +159,7 @@ static int __omfs_write_inode(struct inode *inode, int wait)
 		mark_buffer_dirty(bh2);
 		if (wait) {
 			sync_dirty_buffer(bh2);
-			if (buffer_req(bh2) && !buffer_uptodate(bh2))
+			if (buffer_write_io_error(bh2))
 				sync_failed = 1;
 		}
 		brelse(bh2);
-- 
2.43.0

