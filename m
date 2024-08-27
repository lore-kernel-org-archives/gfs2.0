Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F71019E7DC
	for <gfs2@lists.linux.dev>; Tue, 27 Aug 2024 10:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724755959; cv=none; b=oUtchGXywbpiJT0mgOL5JcoM1r9UEgvY/EgWqrQwknBD0+tAjvLhkRvKWIn9BVWxra3lIDT3/kLOOJGQ9e2IQLDB0OoqYLxRUO6xdED1DS7ydPqnf7iXeCxM+yQ4Ywm9nctHA7qqSitKky6mbVo8YlJJ20t6+63bxamzdMtqqnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724755959; c=relaxed/simple;
	bh=YAHryf6iiMmo8Z5kIbH9aWPG4RIhK6tCmOKITSG3vyM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=CcnqKIjK0lEI1C+HuHYpm6+QntJr5hqPLGIHrw4RUFX9NgRKtbstFY6ZSVWc2rDYG3P8tEMc7kWofgDd0zmf3msa7lyDa2ZS1VWVKtHNBS2Jm28OXVZ1p7U+2JlSEiat3k0jtXZs28LtmWW6gt4eilbeuhUQBoOam3ihanIekM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=zVqhxma6; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="zVqhxma6"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7a1d7a544e7so350170285a.3
        for <gfs2@lists.linux.dev>; Tue, 27 Aug 2024 03:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1724755956; x=1725360756; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=L1/OASOdgW5eIZgb3nAGmTZU5/BzJCX72a/WaHOTVAA=;
        b=zVqhxma6YfukjA9rjeXLLhRWaFrGA5TSwWXB+HZnr7e7R1TqFwpkwYJOwSgzj1kbUr
         hP1zCSE/R0HNcy7DqTW7b8MC7XB0STxDUyK2XuweNsCxaEyS76vkz7evPmAT37nYpMsK
         3KZWSILBwhMnTIRAfTPHgF1+LnLhCkB54PPxXNPzy2ARCrzZLLoBhcBjtaNIM4ypR4i6
         K64xttLKxd07hIpxg85MO/t5+Q+5Q6nxriZuBGwFtezyD07/7SCsz5AxnG5Po0zqUzNh
         PylHsWvGrU1b1nU53oSXhmPc/37pw2T2ezkF9J6RbVA27CkCvS9q61WxPAApcxM9iEm4
         BbzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724755956; x=1725360756;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L1/OASOdgW5eIZgb3nAGmTZU5/BzJCX72a/WaHOTVAA=;
        b=OWP6weoNd9n8TYB1JyA7BmvTmWtKqbjzu8CEFd0mKx0fqLyXmshwzJhouTrwQ6g1/e
         Go8uTYfIvwDqiwAJGf29BwW4RYs6kXA+d8IkLrjY1cUPuYv5nYMD87Y3TKj25xR/4qVB
         SIJacKarHQYNMZtlN81SrfOVkjnEJUTIJrK7eWAQigT9poTnJcnX2BfPkxEbUw4sI1cr
         JIJ0C++sBAFAGwYMsKGVqVoNEmcuFaJkLjD+vUvXt/eXM59Pn9oJn/3jLsOvRPnCYc8e
         xMIN2GbI30yTIAjf+TWKQR0z+Uhq9YzCfyrYqBBebREySeZlembhoK9B8gY80hXHWvg8
         3jlA==
X-Forwarded-Encrypted: i=1; AJvYcCUXXUH66+qbdHnNHxUF6oCTacrp0aIxgG81Xi2G7TdZbHjWbQui+rq/BUwkVCz1Yqa0bXIq@lists.linux.dev
X-Gm-Message-State: AOJu0YwitldfsIDfqZlP6fMH1Rwerlv9fIpE0P99LcyL+LOTAFpFGhJ6
	JGZDzCxLwGHNGtS8pdjk4KFnfx1PvQ31aGpXD4Om3znxJzri+oi2HbYmfmznMTU=
X-Google-Smtp-Source: AGHT+IE/0KGfnI+BxdhiEauhnPCob4ywwYjoJfsqESQCbI3vPjdvAlSHONAnBe+aYMYMzbvGRJ/oLQ==
X-Received: by 2002:a05:620a:4590:b0:79f:181e:3c58 with SMTP id af79cd13be357-7a689728cd7mr1596802185a.42.1724755956035;
        Tue, 27 Aug 2024 03:52:36 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a67f31b81dsm539781885a.14.2024.08.27.03.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 03:52:35 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-block@vger.kernel.org,
	dlemoal@kernel.org,
	djwong@kernel.org,
	brauner@kernel.org
Subject: [PATCH][RFC] iomap: add a private argument for iomap_file_buffered_write
Date: Tue, 27 Aug 2024 06:51:36 -0400
Message-ID: <7f55c7c32275004ba00cddf862d970e6e633f750.1724755651.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to switch fuse over to using iomap for buffered writes we need
to be able to have the struct file for the original write, in case we
have to read in the page to make it uptodate.  Handle this by using the
existing private field in the iomap_iter, and add the argument to
iomap_file_buffered_write.  This will allow us to pass the file in
through the iomap buffered write path, and is flexible for any other
file systems needs.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
Alternatively we could just stuff the iocb in the iter, or the file, or any
other such changes to give us access to the file for the original operation.  I
don't have a strong opinion here, I just want to be able to take advantage of
iomap for FUSE, so whatever the prevailing opinion is here I'll happily do it
differently.

 block/fops.c           | 2 +-
 fs/gfs2/file.c         | 2 +-
 fs/iomap/buffered-io.c | 3 ++-
 fs/xfs/xfs_file.c      | 2 +-
 fs/zonefs/file.c       | 2 +-
 include/linux/iomap.h  | 2 +-
 6 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index 9825c1713a49..d16a6dddb12a 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -665,7 +665,7 @@ blkdev_direct_write(struct kiocb *iocb, struct iov_iter *from)
 
 static ssize_t blkdev_buffered_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	return iomap_file_buffered_write(iocb, from, &blkdev_iomap_ops);
+	return iomap_file_buffered_write(iocb, from, &blkdev_iomap_ops, NULL);
 }
 
 /*
diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index 08982937b5df..f7dd64856c9b 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -1057,7 +1057,7 @@ static ssize_t gfs2_file_buffered_write(struct kiocb *iocb,
 	}
 
 	pagefault_disable();
-	ret = iomap_file_buffered_write(iocb, from, &gfs2_iomap_ops);
+	ret = iomap_file_buffered_write(iocb, from, &gfs2_iomap_ops, NULL);
 	pagefault_enable();
 	if (ret > 0)
 		written += ret;
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index f420c53d86ac..a047a11541e6 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1022,13 +1022,14 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
 
 ssize_t
 iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *i,
-		const struct iomap_ops *ops)
+		const struct iomap_ops *ops, void *private)
 {
 	struct iomap_iter iter = {
 		.inode		= iocb->ki_filp->f_mapping->host,
 		.pos		= iocb->ki_pos,
 		.len		= iov_iter_count(i),
 		.flags		= IOMAP_WRITE,
+		.private	= private,
 	};
 	ssize_t ret;
 
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 4cdc54dc9686..e9c693bb20bc 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -760,7 +760,7 @@ xfs_file_buffered_write(
 
 	trace_xfs_file_buffered_write(iocb, from);
 	ret = iomap_file_buffered_write(iocb, from,
-			&xfs_buffered_write_iomap_ops);
+			&xfs_buffered_write_iomap_ops, NULL);
 
 	/*
 	 * If we hit a space limit, try to free up some lingering preallocated
diff --git a/fs/zonefs/file.c b/fs/zonefs/file.c
index 3b103715acc9..35166c92420c 100644
--- a/fs/zonefs/file.c
+++ b/fs/zonefs/file.c
@@ -563,7 +563,7 @@ static ssize_t zonefs_file_buffered_write(struct kiocb *iocb,
 	if (ret <= 0)
 		goto inode_unlock;
 
-	ret = iomap_file_buffered_write(iocb, from, &zonefs_write_iomap_ops);
+	ret = iomap_file_buffered_write(iocb, from, &zonefs_write_iomap_ops, NULL);
 	if (ret == -EIO)
 		zonefs_io_error(inode, true);
 
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 6fc1c858013d..f792b37f7627 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -257,7 +257,7 @@ static inline const struct iomap *iomap_iter_srcmap(const struct iomap_iter *i)
 }
 
 ssize_t iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *from,
-		const struct iomap_ops *ops);
+		const struct iomap_ops *ops, void *private);
 int iomap_file_buffered_write_punch_delalloc(struct inode *inode,
 		struct iomap *iomap, loff_t pos, loff_t length, ssize_t written,
 		int (*punch)(struct inode *inode, loff_t pos, loff_t length));
-- 
2.43.0

