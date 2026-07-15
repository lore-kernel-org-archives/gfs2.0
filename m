Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAA644685F
	for <gfs2@lists.linux.dev>; Wed, 15 Jul 2026 12:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784117188; cv=none; b=EL38VbgGN5eGc9RaMbG0nd6Fla15ebRPfGlbi65klTu4PJcUiC5r/6NfLLSdrvnqKW5K+wtf7fO6yZ5oh4fheEZJE1FK/fmvwZde/PvBT3j46lUu1hXy0xXWNpeqfZtS6IznUAwZnbjWZ8Hoh49q1e/nHek+o7UW21I9Naeorkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784117188; c=relaxed/simple;
	bh=5chy9DLs53u/9RawX16/HaFqd0e3eUNquSrQlw9FA7Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=E5qn4GFlLSRJ1kErdYzGc1gOZM5w/xDA9ZGHgOrxTpf4TV6sgxRI4fXOYY7iRifzxrupOdsJxX2weVUcorFTH/weziaePf9tUnNhCezMsIm8FUSFdrYWnn2B1Jky2gNAME6wEVgqjuJmgjrEJ4tWgYlKegvtMdofjDE2g9fPo1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=anDyE5+X; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="anDyE5+X"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cc73e322dbso64345435ad.1
        for <gfs2@lists.linux.dev>; Wed, 15 Jul 2026 05:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784117184; x=1784721984; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QBCR6V8aARkLeXQtpzy2HKAP8PmYdJT3CmWSOmYdG+o=;
        b=anDyE5+X8YYG6KEWls9+cRF3B1inajBGl4lmg+pPjli/zyj9ZxyBumevk6QqYnAab+
         CMV1GzCBk7mlQhT1u7hq/U+0KMAN/peKX4kamp0vGUNzc+L7oa9L1aECif9RzY5DtIbD
         CGzX5ufYHs/tbcnRc7GZowSUseUQGIrgoiF4kVf7BcuVRNTOyVDgcb0W08FoBt60Kx8Q
         b0zg3APt809MhBtGXvgFdTYR5ENWTDCtWQdzbHnKRgphoFW1XDkyk3Mkyp/XSb/MH2ev
         EnpXq1WEhlpaQCObA7gGQEzSd/z1DvxqY/EW34i8y8Ax/Y1CGE7X25OVndPbJe/zGzyy
         SruQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784117184; x=1784721984;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QBCR6V8aARkLeXQtpzy2HKAP8PmYdJT3CmWSOmYdG+o=;
        b=dL+JxOGENNjBfjbdi3hCZBl/1DzYlQtTyi1o+o3w3fP1bZp9TkRqMlAi5bofqA1XQa
         YiGDiQ2Jvb9NvQBMCfMO9/XmDny8dBTTnyXh/KM2SifkaIhmRRzRWKtvk7i0FkQrhCHC
         DlFBhspPv4bMLdS7rYVbkqPEcoG2x/QlNLugfGIvNTeM5eAPagUhlVNgNUr8CrCkHTbF
         NmMbLnH1CtT4jNuDJZyY/rLw4YovzeYk1dpJAUPrpHhiJZ3keaWQBQpls7doXyuV5bWi
         B5tThonnwserNbQAtpqKLy0TCDYHmDkUzOJaOmqpT7os++BPByZaGprbVmpIXNCsfirV
         Y0rg==
X-Gm-Message-State: AOJu0YxLx3qjNicWcJIzkxvIkavkefqDCZePl2D8VaZ0BR5CbSs7UaD6
	8Bm6oNrRuo6ZQoYiR+/TPQf6sbDJ9+0PygvK8I8/8tGaL8QxVfNgK9Sy
X-Gm-Gg: AfdE7clu6q7DrNFUD5at2JjPtytEebj8pDlttdF363daqKD9NDasGQIsupvPBxBv4lr
	H9LV68Hf2SodQZLbSqmqwM7oyee8yYz5bOoRSqv5XVLoVdt07/wmR2cblJaiEXArlwa5EnozKA1
	IA1eCqbjKu6KH02HKWi1clX/Uwwv9/QX3nK5Iop28VD64nEjshinZvm519NZV/0wpXVZDKTeSIr
	T5VS6kmsKm9YQzxE0yEFLUlylf6J8X7R41y0c1GDBfOs5vCNkx8N+t5WnFv5G0nzTcB2oQAucA2
	SiMUfkJwyTi+SZUCCg2Fflrj5pZ+fxHGzzSQSZNUNcLndxgGIZvI4TnrYrIDy/GzOobofNLrBQJ
	VUzSRnpA6z3aTn8s2Hkw6p3iHjNo/n5jf4zN+GCDRwjIap+lCkC0Mz8iHa7CPEdeMJQ4J7i7feQ
	JbtxPa6YHaTLf3dU6phKY2w4PZJyEA/PFlX+EjEMwyB0W8vCxDT8+d
X-Received: by 2002:a17:903:11ce:b0:2c9:da58:17dd with SMTP id d9443c01a7336-2cf03d93685mr22145255ad.34.1784117183596;
        Wed, 15 Jul 2026 05:06:23 -0700 (PDT)
Received: from lipengfei28-ThinkStation-P368.mioffice.cn ([2408:8607:1b00:8:d1d2:d044:5a81:884])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf106e6fe6sm1147105ad.73.2026.07.15.05.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 05:06:23 -0700 (PDT)
From: Li Pengfei <ljdlns1987@gmail.com>
X-Google-Original-From: Li Pengfei <lipengfei28@xiaomi.com>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	lipengfei28@xiaomi.com,
	syzbot+8921d5debffa05b33b27@syzkaller.appspotmail.com
Subject: [PATCH] gfs2: validate metadata block numbers before reading them
Date: Wed, 15 Jul 2026 20:06:12 +0800
Message-Id: <20260715120612.3084326-1-lipengfei28@xiaomi.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pengfei Li <lipengfei28@xiaomi.com>

When mounting a crafted/corrupted gfs2 image, an inode's indirect block
may contain a block pointer that lies outside the filesystem.  Both the
metadata tree walk (__fillup_metapath -> gfs2_meta_buffer) and the
metadata read-ahead (gfs2_metapath_ra) take such a pointer straight from
disk and pass it to gfs2_getbuf() without any bounds check.

gfs2_getbuf() turns the block number into a page index via
"index = blkno >> shift".  A pointer of 0xffffffffffffffff therefore
inserts a metadata folio at index ULONG_MAX in the glock's metadata
mapping.  When the glock is put, __gfs2_glock_put() calls
truncate_inode_pages_final(), but that only scans the range
[0, ULONG_MAX-1] (truncate_inode_pages_range() passes end - 1 as the
inclusive last index), so the folio at ULONG_MAX is never removed.  The
withdraw path in __gfs2_glock_put() then skips the
GLOCK_BUG_ON(!mapping_empty()) assertion, and the glock -- with its
embedded address_space still holding the stray folio -- is freed via
RCU.  Later, when a per-cpu LRU batch is drained, folio_evictable()
dereferences the now-freed mapping, producing a slab-use-after-free that
surfaces far from gfs2 (e.g. in lru_add during an unrelated task's
shmem/fault path).

Reject block pointers that fall outside the block device before using
them.  In the tree-walk path flag the inode as inconsistent (which
withdraws the filesystem); in the read-ahead path, which is advisory,
just skip the bogus pointer.

Reported-by: syzbot+8921d5debffa05b33b27@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=8921d5debffa05b33b27
Signed-off-by: Pengfei Li <lipengfei28@xiaomi.com>
---
 fs/gfs2/bmap.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index 51ac1fd44..032acb964 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -291,8 +291,25 @@ static void clone_metapath(struct metapath *clone, struct metapath *mp)
 		get_bh(clone->mp_bh[hgt]);
 }
 
+/*
+ * On a corrupted filesystem, an indirect block may contain a pointer that
+ * lies outside the filesystem.  Feeding such a block number to gfs2_getbuf()
+ * creates a page far beyond the end of the metadata mapping (at an index up
+ * to ULONG_MAX), which truncate_inode_pages_final() never reaches; the page
+ * is then left dangling when the glock is freed.  Reject pointers that are
+ * outside the block device.
+ */
+static bool gfs2_meta_blk_out_of_range(const struct gfs2_sbd *sdp, u64 blk)
+{
+	u64 blocks = bdev_nr_bytes(sdp->sd_vfs->s_bdev) >>
+		     sdp->sd_sb.sb_bsize_shift;
+
+	return blk >= blocks;
+}
+
 static void gfs2_metapath_ra(struct gfs2_glock *gl, __be64 *start, __be64 *end)
 {
+	struct gfs2_sbd *sdp = glock_sbd(gl);
 	const __be64 *t;
 
 	for (t = start; t < end; t++) {
@@ -300,6 +317,8 @@ static void gfs2_metapath_ra(struct gfs2_glock *gl, __be64 *start, __be64 *end)
 
 		if (!*t)
 			continue;
+		if (gfs2_meta_blk_out_of_range(sdp, be64_to_cpu(*t)))
+			continue;
 
 		rabh = gfs2_getbuf(gl, be64_to_cpu(*t), CREATE);
 		if (trylock_buffer(rabh)) {
@@ -325,6 +344,8 @@ metapath_dibh(struct metapath *mp)
 static int __fillup_metapath(struct gfs2_inode *ip, struct metapath *mp,
 			     unsigned int x, unsigned int h)
 {
+	struct gfs2_sbd *sdp = GFS2_SB(&ip->i_inode);
+
 	for (; x < h; x++) {
 		__be64 *ptr = metapointer(x, mp);
 		u64 dblock = be64_to_cpu(*ptr);
@@ -332,6 +353,10 @@ static int __fillup_metapath(struct gfs2_inode *ip, struct metapath *mp,
 
 		if (!dblock)
 			break;
+		if (gfs2_meta_blk_out_of_range(sdp, dblock)) {
+			gfs2_consist_inode(ip);
+			return -EIO;
+		}
 		ret = gfs2_meta_buffer(ip, GFS2_METATYPE_IN, dblock, &mp->mp_bh[x + 1]);
 		if (ret)
 			return ret;
-- 
2.34.1

