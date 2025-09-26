Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7201E7C27
	for <gfs2@lists.linux.dev>; Fri, 26 Sep 2025 00:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758846589; cv=none; b=H84C3HTriJQlQUMMANqJ7jyHtMpty+BdMhr1lLo22hMRZjGAqW2ItMf/IsNndx9ZAx1GvVykPKbrHZ2oojc7D+CeB4jnfjs8vjIEe0RxJ8Jv0GP9JWNOs+JTJu3JdNcDyg5bZrOzTOKRIkc8MeW6/s3lrmW7GhAX6CBvNDPzZ9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758846589; c=relaxed/simple;
	bh=douu/OH3JOBJbcNCPjglBlefsScRwWQQRJejY8Y8034=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=svIe8T7in1sjWd9DFOYBICKKTR1Wq8DyyD1WsD8PFG7piZ4VNrxy7711PPqyBnFg/V4SB5MiuFC++NlghsIHKViLJqVwAbZIjZqe/81/FuckSR2baufxHxKXlgs2bUxeqE/W3uPzugefDczhZBFBYHbY0as35s89+K3C9jqjfcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UNRGZQ1W; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UNRGZQ1W"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-27c369f898fso18531255ad.3
        for <gfs2@lists.linux.dev>; Thu, 25 Sep 2025 17:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758846587; x=1759451387; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4mZBfvjKH+a+qnWQMQA8rEgrcPJHuMhz3ff1QpWHtCw=;
        b=UNRGZQ1WIZWLuGwF9tgCkQ3+d4HE9PDEbrxd/X9WQdUKxV8hM6+HmMx5iXGE0/BGpd
         t1U2y7MUazjdMzb9pC+cHaMPCBFbtO5jz4Ft/mT60WNf+/pdMQmgRMpxRN/LKwccCnoN
         uIUX9KzZCxOFr85nu5ZmRrLXOjD2PPDHW31HUBv6Y+yXceKfNG+3mwTD8LTrJeWzeHRf
         /EtlnKpULDRT9t+yXkXXTxBjY7NMMqWXWn8fmQxW/Jh3vhbsQ/TJ0F8MCbM4Kyj+diS+
         C7AqQSaPy4H1MahCcMf9rCPXZFARSby0QDPtoXB+CXSIqbsN7Yc0WC351SamJUZ1zvem
         kw0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758846587; x=1759451387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4mZBfvjKH+a+qnWQMQA8rEgrcPJHuMhz3ff1QpWHtCw=;
        b=Mr29PDbU8tWAf2EipZd4gz3U7tDIkajNXEK4A8I1dsASYYccNmaX5ZbFLIupBKJwkY
         3V2uuKHXEZh4tPi8NhIC10+Xws3D2eItEveZcY00Aqs8xQMn1WyLyRRD8k2/0i9RrueC
         4B3HV+lDfBkbbMLkjsy93utiWBLhcvgyBqYKDEVmMMU8sXdzkM/Xcg2V9zfViN65uhZk
         B/e1KvFFy8ADkuaArfyvDeRsD3TjKeBJR0yWSHTSHtrsug+3jNhxEUFGqr2r0kAAWmwl
         owq1D7CCVkq9f0AIrmA59bzfSZGWp1EEEo0ZTH4kNlSY4YRAttWYO0qxNWsJB6jrF/xl
         igtA==
X-Forwarded-Encrypted: i=1; AJvYcCVh5/F4onYygSJAzV6xYolbS2+FakeP5WFxFl0HKCzwXxJMA+DpDJO1GhEQ22XONqyqgWtk@lists.linux.dev
X-Gm-Message-State: AOJu0Yz7embl0UalD4+tgJXcehe/Kf31LCBEr3pmrFtkAzyR6qAeMlEK
	FJ3h0PlLUISCW6Gjhauz9MsPj/6UW+mfsMDX9ZZaJ4bwOkEiIplyw8QvppURew==
X-Gm-Gg: ASbGnctiax9Rv0M0DHrGJ1lcj9c4zoJtDY9qW0mo12/WrvaZA5QCjZB91jfA851QFki
	5MlRXOnhFrbMY99pn2StRcW4lDm9OJfOOszyDd2cXxnXSQmyYqL0Y3FW8yyc3781z2nt5Pt831n
	4Z9G6USBPL6C4S6AJAhkSBH8pcRpRCwBTciW8Ty53FthifjOQbnjv0BPRtWscLS7JMlatTYg90P
	rf8NkGZvGtZqmFjfaF4kHKmXop9pj23X8BuNpwo830rSduoKbx9dBRVLqRR49/nR3TDK/t4j32m
	PHJjVreQBFRVIPMMl0iTiopUlbpRHvKALVOuqfFpjgkkZWafyOz0yMGpPYW4fcfFLAZk8k4UyNP
	8NVjdTQy3KNCjP6KbmQPSPjHnmvAEbHbItzQ1flLWIEBRlNV46YOX3CaGWcY=
X-Google-Smtp-Source: AGHT+IEMH5lJf7DHsnuKCyqZaYo7vRM2tcWdcLIid+23yMPPfujKM5L9NhzST+ddt/eFTEXbRRQDiA==
X-Received: by 2002:a17:903:32c2:b0:24c:c8e7:60b5 with SMTP id d9443c01a7336-27ed49dd7d2mr60037595ad.16.1758846586702;
        Thu, 25 Sep 2025 17:29:46 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:3::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6716081sm36552055ad.53.2025.09.25.17.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 17:29:46 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org,
	miklos@szeredi.hu
Cc: djwong@kernel.org,
	hch@infradead.org,
	hsiangkao@linux.alibaba.com,
	linux-block@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com,
	linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v5 14/14] fuse: remove fc->blkbits workaround for partial writes
Date: Thu, 25 Sep 2025 17:26:09 -0700
Message-ID: <20250926002609.1302233-15-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250926002609.1302233-1-joannelkoong@gmail.com>
References: <20250926002609.1302233-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that fuse is integrated with iomap for read/readahead, we can remove
the workaround that was added in commit bd24d2108e9c ("fuse: fix fuseblk
i_blkbits for iomap partial writes"), which was previously needed to
avoid a race condition where an iomap partial write may be overwritten
by a read if blocksize < PAGE_SIZE. Now that fuse does iomap
read/readahead, this is protected against since there is granular
uptodate tracking of blocks, which means this workaround can be removed.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/dir.c    |  2 +-
 fs/fuse/fuse_i.h |  8 --------
 fs/fuse/inode.c  | 13 +------------
 3 files changed, 2 insertions(+), 21 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 5c569c3cb53f..ebee7e0b1cd3 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1199,7 +1199,7 @@ static void fuse_fillattr(struct mnt_idmap *idmap, struct inode *inode,
 	if (attr->blksize != 0)
 		blkbits = ilog2(attr->blksize);
 	else
-		blkbits = fc->blkbits;
+		blkbits = inode->i_sb->s_blocksize_bits;
 
 	stat->blksize = 1 << blkbits;
 }
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index cc428d04be3e..1647eb7ca6fa 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -975,14 +975,6 @@ struct fuse_conn {
 		/* Request timeout (in jiffies). 0 = no timeout */
 		unsigned int req_timeout;
 	} timeout;
-
-	/*
-	 * This is a workaround until fuse uses iomap for reads.
-	 * For fuseblk servers, this represents the blocksize passed in at
-	 * mount time and for regular fuse servers, this is equivalent to
-	 * inode->i_blkbits.
-	 */
-	u8 blkbits;
 };
 
 /*
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 7485a41af892..a1b9e8587155 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -292,7 +292,7 @@ void fuse_change_attributes_common(struct inode *inode, struct fuse_attr *attr,
 	if (attr->blksize)
 		fi->cached_i_blkbits = ilog2(attr->blksize);
 	else
-		fi->cached_i_blkbits = fc->blkbits;
+		fi->cached_i_blkbits = inode->i_sb->s_blocksize_bits;
 
 	/*
 	 * Don't set the sticky bit in i_mode, unless we want the VFS
@@ -1810,21 +1810,10 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
 		err = -EINVAL;
 		if (!sb_set_blocksize(sb, ctx->blksize))
 			goto err;
-		/*
-		 * This is a workaround until fuse hooks into iomap for reads.
-		 * Use PAGE_SIZE for the blocksize else if the writeback cache
-		 * is enabled, buffered writes go through iomap and a read may
-		 * overwrite partially written data if blocksize < PAGE_SIZE
-		 */
-		fc->blkbits = sb->s_blocksize_bits;
-		if (ctx->blksize != PAGE_SIZE &&
-		    !sb_set_blocksize(sb, PAGE_SIZE))
-			goto err;
 #endif
 	} else {
 		sb->s_blocksize = PAGE_SIZE;
 		sb->s_blocksize_bits = PAGE_SHIFT;
-		fc->blkbits = sb->s_blocksize_bits;
 	}
 
 	sb->s_subtype = ctx->subtype;
-- 
2.47.3

