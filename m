Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F182F4A00
	for <gfs2@lists.linux.dev>; Tue, 16 Sep 2025 23:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758066652; cv=none; b=kJqD0JmKosRJj18GE6HFeJa1Pk3sibYIBnmnIZYJYV3XI/GNTXCFsDq/nNToZSBigQnqtvVlE0D165p9XHvCvAoswL/qQ9bZ/icCVf0wOQsn0x8FR2WPo7VVQXyFkuY6OtzzdtnoRk27JFtYsSbceJjmLlXG5Iz7UKodWaoYUCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758066652; c=relaxed/simple;
	bh=X5VeKxCOzUEl3wsEDYiMdyGsEejRLZ63bJIX2+ITwds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ON+Am+r1hh/LAxCSxnpic7y78Ks8TtQ4TRXWE9kDjonag9Ure6yexPYEMewWhkFMiWUMeqvav12bt0DapLxGt49EA8J0VD/6vv4nTaqeb4ViuRW9t/ZuInR/GW0gHJwXzg/p5DqHsgf39idVPyB1Rn9+CRlgyhh6JZAx6uyLn3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HrvzSGcU; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HrvzSGcU"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-32e1288eb0cso2618629a91.3
        for <gfs2@lists.linux.dev>; Tue, 16 Sep 2025 16:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758066650; x=1758671450; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4zQULdjLrk3RHQ78+SXdGM3zZbqfDbjmRNccIhvDiRQ=;
        b=HrvzSGcU2YvtwVwtrxxyIEDzJmlxIQRdkXAGwSHnIYaMr9meFd5Oo83lFBAn+xZrwW
         xSF7zUfkja2UZ6eK94bH2/jqC6DWcDa+lE3VwYp1Tk790mtEewuow/KYlG+SCRnJgw6I
         DopMkso42sgtyZLwGTTHfhClsgPhBeOsDEUBoqSDqi4zoS0bWZNzrCebgJc9T4TXwoDv
         IU6/BOX6p9bgU76HVUipQpbVk/So2T4c+oV/7WdRdtyBpCzPfVs/gih3fBz/7xbrNaBJ
         nVsnnbvqOogGFTkU0v7yvD7hEeaYuNAekUtOQe4Zs94S5TPwpL/P6SikYTbgU6++3I2Y
         6tKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758066650; x=1758671450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4zQULdjLrk3RHQ78+SXdGM3zZbqfDbjmRNccIhvDiRQ=;
        b=YwJYFxeCmHoh3G5wB24qD8/yzSjlmaJjYV2gUWqqDeBrNqUVIkzbQS9E6g/jLxiSij
         T54ec7ifNxETxkFCTVGUkjERw4ttNiDV6lAMbiNlN2CWHOMpae3ShAWsZXnuGKNOOtYh
         5AuFckKOz84N0/GCCwOLKUsixaZyTPCtlJJF4QIktz+wtRWmyxV2Y/zsZmSK0iRtqRcw
         Mo4dNiqbtvtsBZuKK4wiu/eKBd8eq7/tnZC8te3PkkOjd7WrAqNi2lXSszKwQRYnAyAj
         LDxv/wDKlxWP1VfAit2uh32+9ZlMjmsVgp8CYoEL7xpzbQypihROiBVdTw6p0VZa4XDV
         UcsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOYA+JxzCYDijaenLvwLxXbAQ7PJuUEbzjz5lbnWVJvpMVj+kuaApRe+GpeP8+mmAREFiF@lists.linux.dev
X-Gm-Message-State: AOJu0YwfE+ImKQNMrOQhPQizfciMVO4WXP8AdgPnXEp1KbmkTwgY+fC7
	WfPYuB7AfE/PAtO/mEcBPZ6JW6GczNt7au00dRvgLAJxlApcMPcgS8p+
X-Gm-Gg: ASbGncsSDUSjpI3eluGjXC50wAEKdlgXOzdVJILme0bkqyvnxUF6qqqZGMFLoTjeo0a
	zPNxHnVPqlYX+lOybTYVxtciVHUkwHCwCXu1SEnyHNCLnU7wYbA7lshOROu8HlUCaabgBs0YjDW
	pNi30dddy3923Yy9PxVBjcEavzvUT+UwelFvtF5o5rNxLktRojb7Z4TpFFfLcH6digKJbKhHi7A
	PQxK/HtOzJ27xaFZYKPP8hpMiDPMYC5rdcqasmUuMObD//cVqpWfW+gp+RvkculbtWUeSwcJaWm
	thv9v1o3aP7UD0GUOFMaRrny+n7MRmAiYCHBE/pGJuB2Q6+c93qJMkBoztdc7yiCLIkZK5D/6+i
	cg3XS3JQQUJySkYLV2MDV9ln6i67NPyS5HNkgdluCEhc05fdw0u4hat3w4A5vycwS3N/Qj0RB12
	EKbA==
X-Google-Smtp-Source: AGHT+IF3/Qq+e6C8ki6sfdZo/ufgl6Uw/vgFAFRQyV5O6PlrdhNwHnRCfnw8PwqYcBwvdrnS//+vpA==
X-Received: by 2002:a17:90b:4c4c:b0:32e:7270:94b5 with SMTP id 98e67ed59e1d1-32ee3f141e1mr189294a91.23.1758066649702;
        Tue, 16 Sep 2025 16:50:49 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:2::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32ea3c6fefdsm1695880a91.3.2025.09.16.16.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 16:50:49 -0700 (PDT)
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
Subject: [PATCH v3 15/15] fuse: remove fc->blkbits workaround for partial writes
Date: Tue, 16 Sep 2025 16:44:25 -0700
Message-ID: <20250916234425.1274735-16-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250916234425.1274735-1-joannelkoong@gmail.com>
References: <20250916234425.1274735-1-joannelkoong@gmail.com>
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
index fdecd5a90dee..5899a47faaef 100644
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

