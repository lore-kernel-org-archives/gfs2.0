Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A283BCD00
	for <gfs2@lists.linux.dev>; Sat,  1 Aug 2026 22:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785621694; cv=none; b=TxRLPu/sfKPfYzaA0/4DOoMlhvjtBGI7uBhTOzK1RTQIGJtbc1JHpnuW5kUOoaUEQW9F6rpuMb+8cP9j3cCJ2dGB1Q2yCoS+o/Te48/0I9YPq6Rm9LatXPepOW5wjTpFkh0etT9kmuMzA/Hx3USSHNBWVHs1PYYlXPKGMe6YS2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785621694; c=relaxed/simple;
	bh=njsuMFgQW9XgoUDzJC8DUF4aImr/QOgd49oen3uWUEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uEc4kGix1G7bcUhYcNPh6bqSOZGB4Xxh3T7EKDEvIBL7iNNeazFrzn0wiMvHGvDvs9OrYCdtdDQRS/myEx0ox69j6sYWPEYv7qF0+YtiCZe0u4ssOiXvyXUdDE0ExG7IlZi7/J1BnXzVs3B27hjg9ZFphNwAojaBm3I/aDTgIys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tbsj4BzC; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tbsj4BzC"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-81062fdeaf5so45790507b3.0
        for <gfs2@lists.linux.dev>; Sat, 01 Aug 2026 15:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785621689; x=1786226489; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nQgNx97XjQWdnRUlGoDKYUMjSoMBL5tDz0tOo1NQ/rc=;
        b=Tbsj4BzCD3ZVZOdPOqjhKfMLxDhgzgUsDD39qdLG7HPLpq7WE3DVfjPBKFuroOWvgb
         cu6IWYJfK7L435C6dXn93S1ehEvdY9XzLRadITn1Lm5FF8ErCVTdQEJ34awt52wkVVLJ
         ywH26VehghGl3ynapOxjMDsjr0Q7fOsQ20SajkRbq+xC6QF5FZUIp+swgcrXH4aOkpiO
         yGGqpPyqFZUSFFoVZO4tj9qe9RnDF7LnjBh1LokTNi1qm7BIsJ1Em9rr1WpjYQiSLs+T
         b0vKfD7yxTlUGgB/XL5FckkfrkEqxHAeV5cwqvraX2CA5B0jigPzn0EqDkT8HqVgbkbT
         fXnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785621689; x=1786226489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nQgNx97XjQWdnRUlGoDKYUMjSoMBL5tDz0tOo1NQ/rc=;
        b=JfFIXQYRLiXpRNTM+9rPOpXveuyffIyDtsJHrjHn6vY/wvNmAS+Ph3IRLeEJNU805S
         4fO9pDX5zs9yb18bs5BzuUU9jAQ9PEHO5MdGfVoAJNktZfeJUvfaul0Ajv8eQgJpuARn
         undT8YcCThdGg4m3dW/Lfag9E7uxBYJBqCJ0Zm+u8BKk01VihF/b5h6ZMSF3/l47dXaR
         yFhdN+UbmBiPfEiFR54yGm1XPtpMoASKmZRo+EqLmbDc/RCyHxuC3MwkoYfey5/+u0q7
         yDhO9Zyytt2kd0/RW3hb+XNuWxFP5ufIPIkeSe9ymviypuJEG5qL0R2wFqy2rd5/jKY4
         Tlsw==
X-Forwarded-Encrypted: i=1; AHgh+RrUn1ra/Lg7Bqu/i2Ofz+i9mgi/SdwekdewAy8tYXCxi1pdjS5wi4OS7rx/zxSDYj/Qoyo/@lists.linux.dev
X-Gm-Message-State: AOJu0YzJlyoxNdrE3imP85Ik2UhSdTBNk111dbrzrA6IUzy/uCdijlkb
	owXjZRgf4acfq0L/MxytbqnrIL1VbvRm5BGJKtecgsZX+1QmAPNgF01p
X-Gm-Gg: AR+sD12Pd8LxJ/1Qrm27ghnKeY1NQLr20ESXvsUc/MSlK5T2UHuG9EpK4QYQAM2iLoI
	YDoGyj884ww8U5Xcm7TT+2Si1wDxzEKvkXQOoKmlxssOeVphO/BbIczrhm4ZvrE26bXwieq79Ab
	PwOzvAK7QcWtHDNtrWrycmwVhqMMNf/kOlpCnmMVTA1ApuoqzXeYkr1j+Rysk1YIrTC4GQz5LFn
	aj5SjV7TMnpvLnZ64XQB7NpuVSzBGp07+Xrb5MvTu2PAItgJnueXHAAMj5dTeLIC7StyqbJRFN9
	I/fHkl8KuxO9jZf3QvZt4AcQtV+t2DyqNpAw7WFsGykA5u6gMGHAzBjo219CMw/mdi5OVqtDIiK
	X9qic8wdoc9E2yWUIzaavM14C2Bw/Xa0xb+fn5puRuS7wd340+UGTAaA/3NOIALmi76qY6asuaP
	GJf8A/0IVhrFIl6t8hm/TnOsU/i6JgP8DunH9U9/Rso6cOG3G4JgDAZOpOr+ruRHaNnnGMc/a9F
	2UxwceSS2DwNnx+xg==
X-Received: by 2002:a05:690c:e3c6:b0:81f:69a:3739 with SMTP id 00721157ae682-81fcbd4e504mr95002497b3.18.1785621689541;
        Sat, 01 Aug 2026 15:01:29 -0700 (PDT)
Received: from syssplab.cs.fiu.edu (nat1.cs.fiu.edu. [131.94.134.89])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fcd0d6fbbsm29903767b3.25.2026.08.01.15.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 15:01:29 -0700 (PDT)
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
	linux-karma-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Shi <coshi036@gmail.com>
Subject: [PATCH 14/19] ocfs2: check for a stale write error before reusing a metadata buffer
Date: Sat,  1 Aug 2026 18:00:58 -0400
Message-ID: <e63c15e7001fea3f83e0a0aed1512224832b8b1e.1785621505.git.coshi036@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1785621505.git.coshi036@gmail.com>
References: <cover.1785621505.git.coshi036@gmail.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__ocfs2_journal_access() refuses to journal a buffer whose previous write
failed, and turns the filesystem read-only rather than risk metadata
inconsistency.  That check sits inside an if (!buffer_uptodate(bh)) block,
because until now a failed write also cleared BH_Uptodate.

This series stops clearing BH_Uptodate on write error, so that outer test
would never fire again and ocfs2 would silently start reusing buffers whose
last write failed.  Hoist the check out of the debug block, where it does
not depend on BH_Uptodate any more, and drop the now dead second half of
its condition.

The mlog() pair keeps its own !buffer_uptodate() guard: it is a separate
"we can safely remove this assertion after testing" debug aid about being
handed a buffer with no valid contents, which is a different question from
whether the last write of that buffer failed.

The unlocked test followed by a locked retest is deliberate.  BH_Write_EIO
is cleared under the buffer lock when the buffer is submitted for write
again, so taking the lock and looking a second time avoids turning the
filesystem read-only over an error that a concurrent rewrite has already
cleared, while keeping the common case lock-free.

The code in this patch is Jan's, from the review discussion linked in the
cover letter.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Chao Shi <coshi036@gmail.com>
---
 fs/ocfs2/journal.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/fs/ocfs2/journal.c b/fs/ocfs2/journal.c
index d8afbc1a76bb..ea6802d894c2 100644
--- a/fs/ocfs2/journal.c
+++ b/fs/ocfs2/journal.c
@@ -676,19 +676,20 @@ static int __ocfs2_journal_access(handle_t *handle,
 		mlog(ML_ERROR, "giving me a buffer that's not uptodate!\n");
 		mlog(ML_ERROR, "b_blocknr=%llu, b_state=0x%lx\n",
 		     (unsigned long long)bh->b_blocknr, bh->b_state);
-
+	}
+	/*
+	 * A previous transaction with a couple of buffer heads fail
+	 * to checkpoint, so all the bhs are marked as BH_Write_EIO.
+	 * For current transaction, the bh is just among those error
+	 * bhs which previous transaction handle. We can't just clear
+	 * its BH_Write_EIO and reuse directly, since other bhs are
+	 * not written to disk yet and that will cause metadata
+	 * inconsistency. So we should set fs read-only to avoid
+	 * further damage.
+	 */
+	if (buffer_write_io_error(bh)) {
 		lock_buffer(bh);
-		/*
-		 * A previous transaction with a couple of buffer heads fail
-		 * to checkpoint, so all the bhs are marked as BH_Write_EIO.
-		 * For current transaction, the bh is just among those error
-		 * bhs which previous transaction handle. We can't just clear
-		 * its BH_Write_EIO and reuse directly, since other bhs are
-		 * not written to disk yet and that will cause metadata
-		 * inconsistency. So we should set fs read-only to avoid
-		 * further damage.
-		 */
-		if (buffer_write_io_error(bh) && !buffer_uptodate(bh)) {
+		if (buffer_write_io_error(bh)) {
 			unlock_buffer(bh);
 			return ocfs2_error(osb->sb, "A previous attempt to "
 					"write this buffer head failed\n");
-- 
2.43.0

