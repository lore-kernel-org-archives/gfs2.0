Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=101.204.27.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795144409;
	b=YqIiUM5pJeBFnNazsn2Cc7bFfG+2slxQzbjDEWBqmwPV56EkNZKrs7mT/dX5d1MgJQBw
	 PhU7Nj2Lf+hrrkr4+ppVkCxpMOkWEV51L/BUhgJapgZ/ri8nh+p5sEkoAQjncwgriGng0
	 vUZ4QwHBLStHKTHO2p4VnjLkNxs8M0V6L+nPvXQL+3RAB0VZOuFock46JRUeM8QvWcABA
	 vaVFLyW6aXyBEvTGV61PM0eT9cmD8246fbMlwweB822Du8Jdmrh5sA5ykSaI7rlhPHavb
	 pvigoAzkS62d2wqL2cCwTuPHB7QNiDCgvK66HDE2YLFGZthNnc9gP+c3HYknRh+ZHHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795144409;
	h=DMARC-Filter:Received:Received:Received:Received:From:To:CC:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy;
	bh=zUqNb6wemhiBoBp+X8ai6wiBdY/EqbcgcEcqzhCJ9kw=;
	b=NZRyTbR2/ivyRuKtV30bKdLDY0qTiXnU/+LwHrBV+aE8qTyjwvbWAnaxBtrXiYRlKBnn
	 3ljhiF0VpsXDyXeuzYKlc0lkAhbyU35ehu+GYLoh63Im+Z4dmKDDmLrgn4slaLrM5sFf1
	 DFVTBCAeoh8UPNq38spfRxLAZVdnogEe4cdWgd20OO1WYUKnfSTv4dV5H5J00Rd4yAfwO
	 HHYA0bGNrMyFROxRnfugKA6tKcEQmGXAywwxRWVTKaLynmc9o5VYeEFMlPBecILnDpWxT
	 7yiI3ifKP6nYeIQZKoS7ldCrrkkEqnlOQShQqVYLyZs8NsdSchq27WK8IbTY8knx37Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hygon.cn;
	spf=pass smtp.mailfrom=hygon.cn;
	arc=none smtp.remote-ip=101.204.27.37
Received: from spam01.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCAB1606A325
	for <gfs2@lists.linux.dev>; Fri, 20 Nov 2026 03:13:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BCAB1606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp2.hygon.cn (unknown [127.0.0.1])
	by spam01.hygon.cn (Postfix) with ESMTP id 4jW0lc3DKBzVhfS;
	Fri, 20 Nov 2026 11:13:16 +0800 (CST)
Received: from maildlp2.hygon.cn (unknown [172.23.18.61])
	by spam01.hygon.cn (Postfix) with ESMTP id 4jW0lZ0R15zVhfS;
	Fri, 20 Nov 2026 11:13:14 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp2.hygon.cn (Postfix) with ESMTPS id A68AA30CB6D7;
	Fri, 20 Nov 2026 11:12:10 +0800 (CST)
Received: from hsj-2U-Workstation.hygon.cn (172.19.24.226) by
 cncheex04.Hygon.cn (172.23.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 20 Nov 2026 11:13:11 +0800
From: Huang Shijie <huangsj@hygon.cn>
To: <viro@zeniv.linux.org.uk>, <brauner@kernel.org>, <jack@suse.cz>,
	<hch@infradead.org>, <agruenba@redhat.com>, <mic@digikod.net>,
	<axboe@kernel.dk>
CC: <gnoack@google.com>, <paul@paul-moore.com>, <jmorris@namei.org>,
	<serge@hallyn.com>, <legion@kernel.org>, <aleksa@amutable.com>,
	<libaokun@linux.alibaba.com>, <ebiggers@kernel.org>, <djwong@kernel.org>,
	<sandeen@redhat.com>, <zhongyuan@hygon.cn>, <fangbaoshun@hygon.cn>,
	<yingzhiwei@hygon.cn>, <wujianyong@hygon.cn>, <shijie8@gmail.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-block@vger.kernel.org>, <gfs2@lists.linux.dev>,
	<linux-security-module@vger.kernel.org>, Huang Shijie <huangsj@hygon.cn>
Subject: [PATCH v3 0/11] vfs: add inode iteration methods
Date: Fri, 20 Nov 2026 11:12:54 +0800
Message-ID: <20261120031305.3561045-1-huangsj@hygon.cn>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Post: <mailto:gfs2@lists.linux.dev>
List-Help: <mailto:gfs2+help@lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
List-Owner: <mailto:gfs2+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cncheex05.Hygon.cn (172.23.18.115) To cncheex04.Hygon.cn
 (172.23.18.114)

This series adds two superblock inode iteration helpers,
super_iter_inodes() and super_iter_inodes_locked(), and converts the
open-coded sb->s_inodes walks in the VFS to them.  The design is based on
Dave Chinner's patch set:
  "vfs: improving inode cache iteration scalability"
  https://lore.kernel.org/all/20241002014017.3801899-1-david@fromorbit.com/

About the two helpers:

  int super_iter_inodes(struct super_block *sb, ino_iter_fn iter_fn,
                        ino_iter_eligible_fn eligible, void *priv,
                        int flags);

  static inline int super_iter_inodes_locked(struct super_block *sb,
                                             ino_iter_fn iter_fn,
                                             void *priv);

  - super_iter_inodes() runs @iter_fn with a referenced inode and with
    sb->s_inode_list_lock __dropped__, so the callback is free to block and
    to do whatever it wants with the inode except drop the reference the
    iterator holds.  The iterator releases that one reference per inode
    itself, so the callback cannot leave a dangling inode behind.
    It is exported because GFS2 can be built as a module.

  - super_iter_inodes_locked() keeps sb->s_inode_list_lock held for the
    whole walk and takes no inode references at all.  Its callback
    therefore only has an existence guarantee: it must not block and
    must do its own inode state checks and its own reference handling.
    It is internal to the VFS, being declared in fs/internal.h.

  - The callback is separate from the caller's data, so a caller keeps
    its state in its own structure instead of filling in a shared
    context:

      typedef int (*ino_iter_fn)(struct inode *inode, void *priv);

  - %INO_ITER_F_REFERENCED restricts the safe iterator to inodes that
    still have a reference.  It preserves the "only handle referenced
    inodes" rule of landlock's sb-delete walk.

  - %INO_ITER_F_NOREF does the opposite: only inodes whose reference
    count has already reached zero are handed out.  %INO_ITER_F_NOIGET
    suppresses the reference.  Neither keeps the inode alive, so the
    caller must make it unclaimable itself.

   Patch 1 adds super_iter_inodes().
   Patch 2 adds super_iter_inodes_locked().
   Patch 3-5 convert the callers which cannot use referenced inodes
           (dquot removal, nr_blockdev_pages() and the
           generic_shutdown_super() poisoning loop).
   Patch 6-11 convert the remaining callers (inode eviction, sync_bdevs,
           drop_pagecache_sb, add_dquot_ref, landlock's hook_sb_delete
           and gfs2_evict_inodes()).


BTW:
  This patch set depends a small patch:
  "fs/drop_caches: skip filesystems without fs writeback"
  https://lkml.org/lkml/2026/9/23/675

v2-->v3:
   -the callers' state no longer goes through a shared struct, the
    callback now takes the caller's own @priv.

   -super_iter_inodes() takes @eligible directly, so a caller can reject
    an inode before the reference is paid for.

   -rename super_iter_inodes_unsafe() to super_iter_inodes_locked() and
    drop the rcu_read_lock(), which the list lock already covers.

   -drop @ctx->prev; the resume point is gone with the unsafe iterator.

   -evict_inodes() no longer goes through the locked iterator. 
    it now uses the unlocked iterator with INO_ITER_F_NOREF | INO_ITER_F_NOIGET.

   -each caller gets its own patch.

   v2: https://lore.kernel.org/all/20261113115702.586594-1-huangsj@hygon.cn/
   v1: https://lore.kernel.org/all/20261015093854.2082600-1-huangsj@hygon.cn/

Huang Shijie (11):
  vfs: add super_iter_inodes()
  vfs: add super_iter_inodes_locked()
  fs/quota: convert remove_dquot_ref() to super_iter_inodes_locked()
  block: convert nr_blockdev_pages() to super_iter_inodes_locked()
  fs: convert generic_shutdown_super() poison loop
  fs/inode: convert evict_inodes() to super_iter_inodes()
  block: convert sync_bdevs() to super_iter_inodes()
  fs/drop_caches: convert drop_pagecache_sb() to super_iter_inodes()
  fs/quota: convert add_dquot_ref() to super_iter_inodes()
  landlock: convert hook_sb_delete() to super_iter_inodes()
  gfs2: convert gfs2_evict_inodes() to super_iter_inodes()

 block/bdev.c                   | 101 ++++++++++--------------
 fs/drop_caches.c               |  45 ++++-------
 fs/gfs2/ops_fstype.c           |  29 ++-----
 fs/inode.c                     |  61 ++++++---------
 fs/internal.h                  |  31 ++++++++
 fs/quota/dquot.c               | 139 ++++++++++++++++-----------------
 fs/super.c                     | 106 ++++++++++++++++++++++---
 include/linux/fs/super_types.h |  29 +++++++
 security/landlock/fs.c         | 138 ++++++++++++--------------------
 9 files changed, 370 insertions(+), 309 deletions(-)

-- 
2.53.0


