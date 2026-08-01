Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12723CB55B
	for <gfs2@lists.linux.dev>; Sat,  1 Aug 2026 22:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785621694; cv=none; b=iNhA/QJWbtK1xwZtNkg+vF+dyYosaR6FAMQdbfQvXCEWuD4MR3fpABX97jQvXStaAgapNAzmifQ1xkaf+W4ovMOacBWEBYR/HsTqF98zjNZZI7x7opeG3Qe1LEJRUrMnuxTzEZBzJ/YICUS1PhKTET28iP8hpzTwtFy8MPs0Fso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785621694; c=relaxed/simple;
	bh=tojfuYvzfAMfs0bsJ/hEKkMgCSJ1prAxAJ+lK0XKzIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BRWhqwZda9KJkA0RUB7r2RK7sqtlIkWRVGWqIaNeUBxI6e3HzaqhP4NC4THqJXOu/SN7Va1M2ZOyEL4Nj+b1gorSqHpWUE2DWgBIOoVThV3nbLeZ+ZeITqind6nh9+KsNPeNKsabOg+Cj+qyExywwJHIQHz+OI8u+yXQ0tqDpls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YGg9EW84; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YGg9EW84"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-80cebd41372so32695997b3.3
        for <gfs2@lists.linux.dev>; Sat, 01 Aug 2026 15:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785621687; x=1786226487; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S5d9GJjjHaj8KTJ0WAU1dmfHtrReZ7Fn8M10/pEoUFY=;
        b=YGg9EW843m1YqGtG4+9tNUdJHGcvHLkuXx/4Y80MVjFfXYWe3oVuPusKzBQ1ZpxqMi
         HVK8ph1zis7/qH2vNnQBx/kQ23wwfZR0WoPU3kv21sejbES5keTB+cJz4phprWLlsMns
         TzsQYiTyrO5nX+M33jcy8NJNn2ZDfPCe/aTqBykHtWSqFLUm3ukAi0fVzmblyzO8532+
         im46FScC9LRq+XDLpJ3rq4Qgtp39s1dhn3Lxjm0e673Vh7WatDR1/jVGojiqGyd1bbcY
         MX67VIl9hccr+tANWWGbcwq3oefxQPkFD0LPfGKDlLk6NTbtHDyy4SkbIKJLJNbogOjS
         DwmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785621687; x=1786226487;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=S5d9GJjjHaj8KTJ0WAU1dmfHtrReZ7Fn8M10/pEoUFY=;
        b=HKFTc8Sz5jVzBkhTzLGEyOS5YOWjEwTSDnKBehO5gYyioQW0hRXlVO5GWQgUx1PCyD
         vBGli4Jyna2SUqSghm8wepTPZLJmgjvC16ynxmzJa+zXyWcYJumK2zFWJyWezOYPvTPk
         rsA+LNYENS9MgYou5NnN5t9jJlInJuyPTalRzMMI0V7ZSTHdStVdax7pUbiqyOw4y0iT
         ZNxJUJOHskmNcyU6nGgkHBMJ+MRbS4rNzRnWf4D7uBezmYX5VUul//5dm8XUL5gP+Nlp
         GukLYoHETOwG3HFpzi0M6NMx0mIrN9FYO8abz789ZCClesABh5KxXkn5mdBPZZESE8zf
         32ww==
X-Forwarded-Encrypted: i=1; AHgh+Rpma9wiD6biUPZ9pi1dcwxcF0qT6Pp5vbjjr1yhJajsTwcOw1jqxXHTEuqj+8ohGlPtnazo@lists.linux.dev
X-Gm-Message-State: AOJu0Yy4nqsEJA5YZ4n4SGwgW+hkfMO9NQZuJMVFf7s569eFw0v3yS8o
	1o9zkUjAVfuqmWQvB8T7/Np0zi4f2siMQqdUsNp0+OT2TF8A6mlw16g8
X-Gm-Gg: AR+sD11x4Q/8XG6zliKU1nYBa5AouE1NRhGVI58z0fdisMhmITGXJc7621m+OMiiKB3
	1vOvCAC3/1E7wUn4uSIA3f95vDWsamltFa5mRRyvR9H/Q1gf81J4oOg7OfQe/hqbfXrJEMnkqQE
	dGgYHVjHV53B8w2XXEqKLrVYUxjGkG3HI9/cfGXTJ063PikY7JnC8Fsi+Ztflh/KWjMU5QWIr7E
	Bk3pvNeHQOOhXRs9m+xQDnUaJ5ew8Vo3VEFP/O0tcyAHWdwLQNXIi5y0ymyHD90CGzbbFSlbbzy
	eKnDJwNndlS16W4eC0ivoX9y8D20jcl64eRSWzBFAMrimQ1T3mTaGXJ/Gy2KUrHZKfuhVXwq7er
	I54NmTvah0nU5n05Syz6z1kFkodCyhoA4V2bxd8XArhp/8nHvrmYBvM3NP5Qf/rOxoIkNSyxCs8
	Z8YSnaKsFLVzpH3P1qRzKX71mAMcgysHeI6bqVFliARYDDCWTd+OYqCn8JeS0PA7z3v6cRd/pCH
	aIidsw=
X-Received: by 2002:a05:690c:48c3:b0:81e:d792:a019 with SMTP id 00721157ae682-81fd4a64bcbmr74354127b3.6.1785621686736;
        Sat, 01 Aug 2026 15:01:26 -0700 (PDT)
Received: from syssplab.cs.fiu.edu (nat1.cs.fiu.edu. [131.94.134.89])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fcd0d6fbbsm29903767b3.25.2026.08.01.15.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 15:01:26 -0700 (PDT)
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
Subject: [PATCH 12/19] ext4: check for a metadata write error with buffer_write_io_error()
Date: Sat,  1 Aug 2026 18:00:56 -0400
Message-ID: <844d01d43111830a299346d0f3c6fddd62f22cc4.1785621505.git.coshi036@gmail.com>
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

Two places detect a failed metadata write by testing !buffer_uptodate()
after waiting for it.  That relies on the write completion handler clearing
BH_Uptodate on error, which this series removes: a buffer whose write
failed still holds the data the filesystem asked to be written, so
declaring it not up to date is wrong and makes callers re-read it.

ext4 already does this correctly for the superblock - see
ext4_commit_super(), which tests buffer_write_io_error() - so this brings
the other two into line.

In __ext4_handle_dirty_metadata() the old test also required BH_Req.
BH_Write_EIO implies it, so the pair collapses into one test.  The new test
is also strictly stronger than consuming sync_dirty_buffer()'s return
value, because it still fires when the buffer was written by background
writeback and that write hit an error, which sync_dirty_buffer() does not
report.

Note that BH_Write_EIO stays set until the buffer is written again,
forgotten or invalidated, so an unrepaired itable block now reports on
every subsequent sync of that inode rather than only on the write that
failed.  That is the intended behaviour and matches what ocfs2 has always
done with this flag.

No behaviour change today - a failed write sets BH_Write_EIO and clears
BH_Uptodate together.  It stops being a no-op at the end of the series,
where the new test is the one that still works.

Signed-off-by: Chao Shi <coshi036@gmail.com>
---
 fs/ext4/ext4_jbd2.c | 2 +-
 fs/ext4/mmp.c       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
index 02b066299164..f338d6e3c29f 100644
--- a/fs/ext4/ext4_jbd2.c
+++ b/fs/ext4/ext4_jbd2.c
@@ -413,7 +413,7 @@ int __ext4_handle_dirty_metadata(const char *where, unsigned int line,
 		}
 		if (inode && inode_needs_sync(inode)) {
 			sync_dirty_buffer(bh);
-			if (buffer_req(bh) && !buffer_uptodate(bh)) {
+			if (buffer_write_io_error(bh)) {
 				ext4_error_inode_err(inode, where, line,
 						     bh->b_blocknr, EIO,
 					"IO error syncing itable block");
diff --git a/fs/ext4/mmp.c b/fs/ext4/mmp.c
index 7ce361484b38..4b18ddef468d 100644
--- a/fs/ext4/mmp.c
+++ b/fs/ext4/mmp.c
@@ -49,7 +49,7 @@ static int write_mmp_block_thawed(struct super_block *sb,
 	bh_submit(bh, REQ_OP_WRITE | REQ_SYNC | REQ_META | REQ_PRIO,
 			bh_end_write);
 	wait_on_buffer(bh);
-	if (unlikely(!buffer_uptodate(bh)))
+	if (unlikely(buffer_write_io_error(bh)))
 		return -EIO;
 	return 0;
 }
-- 
2.43.0

