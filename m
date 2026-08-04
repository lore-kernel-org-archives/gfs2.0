Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F3536F434
	for <gfs2@lists.linux.dev>; Tue,  4 Aug 2026 02:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785810823; cv=none; b=dc0dQhY5ch2pBJGjLiO1cwF+2VSnxXOcty7HwVjJ3N87g7jIY3O4KbqTNCUT3RMwbxopuOhFwFgA2iEMZq+Mf0aGPCEZy2sdJY3ff5HxsIxzjFubfP+lLhvyjUWjO13ET/wfw3DRbc9ioornRTiBhfJTITvThy43TCf7RRMaBFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785810823; c=relaxed/simple;
	bh=kYWeOmRxvkWb9ogVcrQtclAZxrmN9SiblagBVPaoyyg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VWBN17t9jcWFKsW/sYCtjh1/icIdR3iZarf3ie5syDA/domxgStDoMiIOrm3cgwmKz4UA2nO7VhXHImLQABEWzY+t4bp8o4FsZsVQdCC0eaksML35QYX8HjkD0OLgTKkBCDw6cRtQ8HrzvGrOYpUlIClC570WEz4UiguqV2ozeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PfeR9p+b; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PfeR9p+b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785810822; x=1817346822;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kYWeOmRxvkWb9ogVcrQtclAZxrmN9SiblagBVPaoyyg=;
  b=PfeR9p+b4CmTEFQmYYHUtHzWg+E3XSXkWCvUkFl1y+eVLcaGFC0u8Ny4
   G4oQBkUYto9fVvyUIKYWb9a1Dn50XZPUKtX/PWA0qMIkj+kjsh9L1oi2x
   ewCyM1C3YZWOMm8Y4zS8Ekz0iHoueBE53+t8SfNWpIkwpul994goSQFja
   xDoI10wUWjMCowNgVaWh3O2ZowP3z0UZhKB8UD+z3h1wUbDTZnJlZEwI1
   tak+L8YnahmW21BfGvcWPlEITlxw8Bfbfkpw0bxyGFYbUnJk4+pnBQRgq
   yBf2notFUhZpjvWExMU2Tql8hHbrpPG0Y5zmnv1nfat/QUrfKfuiQ2AU/
   Q==;
X-CSE-ConnectionGUID: b0/AShmyQzq6btYIKoz1uA==
X-CSE-MsgGUID: CzBfAx+5TDS/KMOwRXiGFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="86387167"
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="86387167"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 19:33:41 -0700
X-CSE-ConnectionGUID: go7mbX4gQ366qs2kXWTHLg==
X-CSE-MsgGUID: uFKbM+nIQD+Q03XR1Ori9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="299605084"
Received: from tester.sh.intel.com ([10.112.106.126])
  by orviesa001.jf.intel.com with ESMTP; 03 Aug 2026 19:33:40 -0700
From: Tao Yu <tao1.yu@intel.com>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	syzbot+cb79de2cc8b76fbf474f@syzkaller.appspotmail.com,
	tao1.yu@intel.com
Subject: [PATCH] gfs2: mark the VFS superblock read-only before quota cleanup
Date: Tue,  4 Aug 2026 10:33:35 +0800
Message-Id: <20260804023335.2682101-1-tao1.yu@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During unmount, gfs2_put_super() calls gfs2_make_fs_ro(), which shuts
down quota/statfs activity and then frees the quota bitmap via
gfs2_quota_cleanup().

However, gfs2_make_fs_ro() did not mark the VFS superblock read-only
before that cleanup. As a result, later inode eviction could still
enter the deallocation path through gfs2_evict_inode() ->
gfs2_dinode_dealloc() -> gfs2_quota_hold() -> slot_get(), even though
sd_quota_bitmap had already been freed and cleared. That leads to a
NULL pointer dereference in find_first_zero_bit().

Set SB_RDONLY after the final quota/statfs sync and log shutdown, but
before gfs2_quota_cleanup(). This keeps subsequent inode eviction from
re-entering write-side quota/deallocation paths once quota state has
been torn down.

This fixes a crash reported by syzbot:

  Oops: general protection fault in _find_first_zero_bit
  KASAN: null-ptr-deref in slot_get()

Reported-by: syzbot+cb79de2cc8b76fbf474f@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=cb79de2cc8b76fbf474f
Signed-off-by: Tao Yu <tao1.yu@intel.com>
---
 fs/gfs2/super.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index 4d854556b5299..6b5457f965673 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -565,6 +565,14 @@ void gfs2_make_fs_ro(struct gfs2_sbd *sdp)
 				   HZ * 5);
 		gfs2_assert_warn(sdp, gfs2_log_is_empty(sdp));
 	}
+
+	/*
+	 * Once the final quota/statfs sync and log shutdown are complete, the VFS
+	 * must see the filesystem as read-only so later inode eviction cannot
+	 * re-enter deallocation paths that still expect live quota state.
+	 */
+	sdp->sd_vfs->s_flags |= SB_RDONLY;
+
 	gfs2_quota_cleanup(sdp);
 }
 
-- 
2.34.1

