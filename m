Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6CD15E8D
	for <gfs2@lists.linux.dev>; Wed,  1 Nov 2023 16:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rd1mALhb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698857186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1UGNSNpFNMr2zC14rYLIvIa7fQCx1cIgCpLav++p850=;
	b=Rd1mALhbF7LuBPgrThTwbPfSl1MSXHtxzX/4FWdic9ZnvTNYb2jfmii/+O39/aZFQFj/F3
	qYf0aynhomkrZ1+eyt42fIt/bwuPok5fzW+beyCWL10OJiwhJPmgYgrqo338+IMnGr5mJz
	LzZTgB1gfx3U9d0Y+NYAdJmNYu/wpvE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-DLPrtL7wPHuRdHEwGlKHfA-1; Wed, 01 Nov 2023 12:46:24 -0400
X-MC-Unique: DLPrtL7wPHuRdHEwGlKHfA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 875E28350FD
	for <gfs2@lists.linux.dev>; Wed,  1 Nov 2023 16:46:24 +0000 (UTC)
Received: from pasta.redhat.com (unknown [10.45.224.27])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DB36140C6EBC;
	Wed,  1 Nov 2023 16:46:23 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	Andrew Price <anprice@redhat.com>
Subject: [PATCH 09/25] gfs2: Stop using GFS2_BASIC_BLOCK and GFS2_BASIC_BLOCK_SHIFT
Date: Wed,  1 Nov 2023 17:45:59 +0100
Message-ID: <20231101164615.1138692-10-agruenba@redhat.com>
In-Reply-To: <20231101164615.1138692-1-agruenba@redhat.com>
References: <20231101164615.1138692-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Header gfs2_ondisk.h defines GFS2_BASIC_BLOCK and GFS2_BASIC_BLOCK_SHIFT
in a misguided attempt to abstract away the fact that sectors on block
devices are 512 or (1 << 9) bytes in size.  Stop using those definitions.

I would be inclinded to remove those definitions altogether, but the
gfs2 user-space tools are using them.

In addition, instead of GFS2_SB(inode)->sd_sb.sb_bsize_shift, simply use
inode->i_blkbits.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Andrew Price <anprice@redhat.com>
---
 fs/gfs2/inode.h      | 8 +++-----
 fs/gfs2/ops_fstype.c | 8 +++-----
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/fs/gfs2/inode.h b/fs/gfs2/inode.h
index c8c5814e7295..908c739220b8 100644
--- a/fs/gfs2/inode.h
+++ b/fs/gfs2/inode.h
@@ -44,19 +44,17 @@ static inline int gfs2_is_dir(const struct gfs2_inode *ip)
 
 static inline void gfs2_set_inode_blocks(struct inode *inode, u64 blocks)
 {
-	inode->i_blocks = blocks <<
-		(GFS2_SB(inode)->sd_sb.sb_bsize_shift - GFS2_BASIC_BLOCK_SHIFT);
+	inode->i_blocks = blocks << (inode->i_blkbits - 9);
 }
 
 static inline u64 gfs2_get_inode_blocks(const struct inode *inode)
 {
-	return inode->i_blocks >>
-		(GFS2_SB(inode)->sd_sb.sb_bsize_shift - GFS2_BASIC_BLOCK_SHIFT);
+	return inode->i_blocks >> (inode->i_blkbits - 9);
 }
 
 static inline void gfs2_add_inode_blocks(struct inode *inode, s64 change)
 {
-	change <<= inode->i_blkbits - GFS2_BASIC_BLOCK_SHIFT;
+	change <<= inode->i_blkbits - 9;
 	gfs2_assert(GFS2_SB(inode), (change >= 0 || inode->i_blocks >= -change));
 	inode->i_blocks += change;
 }
diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index 33ca04733e93..ecca978419e8 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -292,8 +292,7 @@ static int gfs2_read_sb(struct gfs2_sbd *sdp, int silent)
 		return error;
 	}
 
-	sdp->sd_fsb2bb_shift = sdp->sd_sb.sb_bsize_shift -
-			       GFS2_BASIC_BLOCK_SHIFT;
+	sdp->sd_fsb2bb_shift = sdp->sd_sb.sb_bsize_shift - 9;
 	sdp->sd_fsb2bb = BIT(sdp->sd_fsb2bb_shift);
 	sdp->sd_diptrs = (sdp->sd_sb.sb_bsize -
 			  sizeof(struct gfs2_dinode)) / sizeof(u64);
@@ -1190,10 +1189,9 @@ static int gfs2_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	/* Set up the buffer cache and fill in some fake block size values
 	   to allow us to read-in the on-disk superblock. */
-	sdp->sd_sb.sb_bsize = sb_min_blocksize(sb, GFS2_BASIC_BLOCK);
+	sdp->sd_sb.sb_bsize = sb_min_blocksize(sb, 512);
 	sdp->sd_sb.sb_bsize_shift = sb->s_blocksize_bits;
-	sdp->sd_fsb2bb_shift = sdp->sd_sb.sb_bsize_shift -
-                               GFS2_BASIC_BLOCK_SHIFT;
+	sdp->sd_fsb2bb_shift = sdp->sd_sb.sb_bsize_shift - 9;
 	sdp->sd_fsb2bb = BIT(sdp->sd_fsb2bb_shift);
 
 	sdp->sd_tune.gt_logd_secs = sdp->sd_args.ar_commit;
-- 
2.41.0

