Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2786C31C576
	for <gfs2@lists.linux.dev>; Mon,  8 Sep 2025 18:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757357563; cv=none; b=CHD2n3HB/fA1Xac7+VHJ29CZJRwTBsTUwWQCiA1zFZg7yQtnisTQTyOxjHKlJY5X4UxTDT3Nd5H3zrJ0sNyaeY6nkweiHlzjtNtXW/tJcPNGWJlzig4ErRpfJJMROOaL4rVQnhbsBrr53ZEn6sqG7gRk0G6c8TJn2mqmlTL/sjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757357563; c=relaxed/simple;
	bh=+CTN5B7SeqTNFS9JipDKq8pNDlO61mP9PFkpU1qk1bU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sIGDjZ+WOBU8GNHnQxG3WKjniY99NAyOeeI+Wa6RortyhjsJbPFoF+Lx9I9NfeyfDlQahC5gWxjdG9nI02Vt7ZY7VqOFNohCMY8SqdjAfav63e08VZ4aZhLbFp0ndcN+LDCXxKLWYGTlSaVlie05HnvVqMYo4XNUXptEP4FOwb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jMsDn00b; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jMsDn00b"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b4c6fee41c9so3739838a12.1
        for <gfs2@lists.linux.dev>; Mon, 08 Sep 2025 11:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757357561; x=1757962361; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J114gh6ByMwTjUeA+rsO/Z2owIHbEpPQYJvbk/lVNzo=;
        b=jMsDn00bt1CKhHYYTu18DeYiUBqW//ZWNIeE++wrUp7nYwAuxp7gFiwXshXz2XLkob
         LMXhX/RzTwbG/wTd6xuE45kM/IVKvYeK28ECs6qzv8Xt9slxk2ISYbomaqTuMNbZLE8h
         yQbcNnn36TcLELKUFSDSQ71DmMsrd8rQjMkrLn0yAGQS2ZueMzLOqNz+zmmiDAodEKBn
         qScoBckeGaKwJCtSQqe7otNcyjn7mBjc7rd+VEhEGUNkUBHA4tEPyjwdA/0pZ7tTVx09
         G9+toWP4GBcGwRInZWH3XaFaNeUe1FzlNSZXl2/5Bs7qYGZdvy6T2CZ4XK9QiT6OF9DY
         lFPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757357561; x=1757962361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J114gh6ByMwTjUeA+rsO/Z2owIHbEpPQYJvbk/lVNzo=;
        b=a5Y8aoEMIj3YmGcbe69F4qkVSI662DfQ/6Ir/qFbe95q5x9Ya1V3XFSX2P8SaWjjQn
         EfX+UkiahoXqlua07AjQ2sjC4iVOr4CJ+jXUs7Ip9+UX5ikpLZRYCTFNFL6VXt746oC9
         iRq2MkhsDOybgXC3DFsWkjn/1E4klSnhm01NSDq7eEmKb/AsXgEBkS8tryREH6wC08NG
         +aou088yL19yhGdEazdUi/+/PHII/tuPP759jebIYVcFn5lmPGJs0vpnAY9kLitX0zpd
         X1a88n95ItJYUbKX7WAKIlr41smrxwLmBCWU3XzOrnSRAYz1i82GUYgptLnK4X6vlQaQ
         ZyWw==
X-Forwarded-Encrypted: i=1; AJvYcCXmrTzr8wbnLOA5dxsSOKQ8fTbHhh5pZDh+O+evft+IFkPar/75u0GFiXshZAC3aGRJmlMW@lists.linux.dev
X-Gm-Message-State: AOJu0YxIQCqDq+EeKYzQnZAUfoFKhs9PyeLg939S/1ClgBjarQ8HTBIL
	3ZQNxN4nCy2+RhibRuKYXhaT45HZN4pfBZjkj/EB5baeTuQRYKkJDTZP
X-Gm-Gg: ASbGncuUAhf3IfkTAfLeql5P7HitUAE9Y43OpE32qG1c5ihtpQs8imIWoDMFkH+l/oL
	7Ms3Rc2CNl0gzY8plcF8t909XUa0ZdfIkM2oKVdR3Q5NiEDEbQ6Y4MxpIQwQ4FVI3qGzuJ+q+db
	xPZIPgB72Ql4182vObOZnbfAnV/72uKrOQmlZOCIuDOyhEFT2Lw9dpx6Z7JhxEfnoRYYa3ViaUJ
	dOoD8WclI0TGEl+LMzRNpbfxsKEMKNTyYN3ZDqcwv/w3xFWg81PhQ72YdfwYIc3lyK1OgTMTuwy
	WDTwG38fUrPlsWUDCa/ccUmvvLTCczrnU+F0LiaJNYoN7oL/lF/r/4361JZ2eGDRgtANmGTOSUH
	0k5AERANKtKz413xx3Q==
X-Google-Smtp-Source: AGHT+IGaGjLS6C/cbQh6aP5wsaX1LuBLHs6U4eYzV2mo/KlHw7FqzzxriJd7OMiRK7ZMZmkSYnVxwg==
X-Received: by 2002:a17:902:db07:b0:24c:e372:9de4 with SMTP id d9443c01a7336-2516dfcb6acmr132026735ad.18.1757357561355;
        Mon, 08 Sep 2025 11:52:41 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:56::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24c9a46bcf1sm148251415ad.3.2025.09.08.11.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 11:52:41 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org,
	miklos@szeredi.hu
Cc: hch@infradead.org,
	djwong@kernel.org,
	hsiangkao@linux.alibaba.com,
	linux-block@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com,
	linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v2 16/16] fuse: remove fc->blkbits workaround for partial writes
Date: Mon,  8 Sep 2025 11:51:22 -0700
Message-ID: <20250908185122.3199171-17-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250908185122.3199171-1-joannelkoong@gmail.com>
References: <20250908185122.3199171-1-joannelkoong@gmail.com>
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
index 7ddfd2b3cc9c..3bfd83469d9f 100644
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

