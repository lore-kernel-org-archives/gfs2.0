Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC782264C7
	for <gfs2@lists.linux.dev>; Tue, 23 Sep 2025 00:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758587655; cv=none; b=po0LyMhV1qMpZvVh4Y84Nk0d0phO80Cp0k0DMdy3Q2N1KVBSI6KW9Ky9uuSJLiNkrr9BQGLayCZCQc+uEVdiHSZJYERwP9WpE6J7DSV6Oq7f2Eoto1MCkgra5dbGlZsgugyyPZmETKZPidRmf0f1D60JTJ1b7Xcaqse0m5mj6kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758587655; c=relaxed/simple;
	bh=douu/OH3JOBJbcNCPjglBlefsScRwWQQRJejY8Y8034=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hs59mm0+lfRUtbYEaBVZT6wuJCjzccfswIQHYku99xyJ1i+SXnTGSx2E/Ob/pcGxek9Ma7j/Wc0R3KrM6XfLog+UNBoI9jiiSMyiTKFrAFJT/BPcXV1XmdEwx1/rkxeA3onp4PZMWEpu7wji/8HhWcYS8EHBHtW3aMrphje5Fyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CtOoLS10; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CtOoLS10"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-27d3540a43fso432665ad.3
        for <gfs2@lists.linux.dev>; Mon, 22 Sep 2025 17:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758587653; x=1759192453; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4mZBfvjKH+a+qnWQMQA8rEgrcPJHuMhz3ff1QpWHtCw=;
        b=CtOoLS10Cd0NXxaL6jodd3/hYsHQDlT+7LT15G2nacQr5AY8zQRN5YxFU1YQlrrP0h
         DBornl6zTh7kaHl095YO2qiV/HCEFrzCumzFxi+7vAQTwKLeNGEEVRSt1sFaTwaNMdX8
         lxK8zTeIFzYaQT+QWCMblfILHEQXsUoH4H7Jo/DpMO/PXXuUs8to5isM5vTTkkxMqfuO
         1nRBA+dbcGhjFCX5gGmfnSlN6TcnKUD91F4PLt5FL3J/+G3xRtENTqxrfSOS/y+mq7T8
         FVKz3SJEeSimSveOQZlD/VepKtkruW83X3JUvVXjNgCU+kTT8TE+YXXiPLtOsGjKvlv2
         srYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758587653; x=1759192453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4mZBfvjKH+a+qnWQMQA8rEgrcPJHuMhz3ff1QpWHtCw=;
        b=MeEN7baMWtJOQXW9BphDOzktEZt6mpLM65KeVM+h8ECSo6L3uhHW5kwcylEepFuLtj
         EBLFi1ZwQj497rrvuF/qImP7TkE3hStL0lu/7Ir1zbWgkUGninvRk/vjddnWmDIaw3Kb
         K6z2PgEguvpsnCia0dIDiGjNZhgR4DVn60u/iIeoFvJPqiQG0gwkRgOhJctTE2f/Nfqc
         Wu7MmEorXTNLkCLkJlW9BI1fKn01b3ai5QZRUYniUf4vO3d/Fo8zkXYM3spVQJ1ey0k7
         uy+3lZNgDoOBSwbFUbX6xP2foP/ZlDjyQbvmp+MM3cEW+9MiTrbvIPeAxamgmlCmwFrS
         sv1w==
X-Forwarded-Encrypted: i=1; AJvYcCWizBlCISjZzDZS1qv44bospaL7wOfei41Y/yfF7B7rh1YXExBlRjP8jvapGmo+vXo7tgsh@lists.linux.dev
X-Gm-Message-State: AOJu0YzrsKEAY6L2pTktx44BXV8N3t4Kxm6Zencqg5/yttlC4leskNiV
	qRA8SzU8y9/eLNRfrhI8rczzzygZemZZ3pWTyNcGxxmc1BQlOARNR5jK
X-Gm-Gg: ASbGnct1CKeeF/6ltU0O+an0DgNUDdQi3LeLalC9QMuEyk6w8fJxm+lu08UQmAzoOtt
	sdr+K35mg80YbeWQ4r+TSyccG8Hc1JRj4iKHWr6XNuXbqkoI4tBdl810CzJneUSfK79BBrmqOBd
	YhNsSJWh527AQ67EK6ROsUl70/eGzarHV610zJQ/HPcmLdpjvp9eQai53lD57BwMHmMSvV7KVW2
	7V4UVDzySR5uvef6bfHCRANve5oalshW0pFMMhOyv6WuVYH8S/FTZqxzP745wQOSEJrMB6r1Hh6
	DBAHWjHx90DB4RWAXoVpX2AvcYnPeeiIOojxRiarOMYwetQdYWZUfjKw0BDFf1q85nmHFXZ1qy0
	cgYfM+YBNoTXevBnQu0Ysy2nJqPgLp60nJYHH97bPAa4khsjzzw==
X-Google-Smtp-Source: AGHT+IEWMO1uEK4B7K/pZLGH+dB9Etd+KJEgWU9E0E30eLXih5la102pjColw3CwPrUCACkIv7xPGw==
X-Received: by 2002:a17:902:ea11:b0:260:3c5d:9c2 with SMTP id d9443c01a7336-27cc61b8b3emr7635835ad.48.1758587653500;
        Mon, 22 Sep 2025 17:34:13 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:40::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980339e89sm141416405ad.130.2025.09.22.17.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 17:34:13 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org,
	miklos@szeredi.hu
Cc: djwong@kernel.org,
	hch@infradead.org,
	linux-block@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org,
	hsiangkao@linux.alibaba.com,
	kernel-team@meta.com
Subject: [PATCH v4 15/15] fuse: remove fc->blkbits workaround for partial writes
Date: Mon, 22 Sep 2025 17:23:53 -0700
Message-ID: <20250923002353.2961514-16-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250923002353.2961514-1-joannelkoong@gmail.com>
References: <20250923002353.2961514-1-joannelkoong@gmail.com>
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

