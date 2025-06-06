Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579FB191F7E
	for <gfs2@lists.linux.dev>; Fri,  6 Jun 2025 09:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749203305; cv=none; b=ZsYHVjeALSN2zUHXrKwBIDMK0zIK5I5OYQxSJ2Cvskadt/Q15+MvZg5IN4+vTYUlg6ljZDGYacZXY+pABtwbyu5HVkyCcuq/dWLn/Q4pYRjKqn2NFWKMam7/DmIWXDVGeKJntx1ejERnaNoqZbfItDNcu8jW3q93iEZxInsOBXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749203305; c=relaxed/simple;
	bh=AWs6o6teUVAdxwrYxvidlWGCoVaYDXyS5NHOk+ItuC0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jSPvYLP6GvbKAnxix/vG7TXtFGeqbWHv8fXhk0g286dJw9+ubWxWSGORqLOW/D4N93iFHKsJMOabHqd5y2+AvQ/SFpb74QA4qqUm1ORcKMP/E5+HqXvZQ0Q+ugOynR1MVESXj3GDKNd5PpFmT4FI3SK4t372Pj9Uv1OdoyQ3cu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=R7AySU8z; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="R7AySU8z"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a365a6804eso1281199f8f.3
        for <gfs2@lists.linux.dev>; Fri, 06 Jun 2025 02:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1749203301; x=1749808101; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZNeTOPNHHaNk/W0Z9D8B6lb+kfoyEb4k9ztzQ0EwTOM=;
        b=R7AySU8zxDrdmkNkXp2P7DCEk8a00QFWijg11U1642qTCan23E8pXtDqsixsAR5cb4
         HIQ8bqG5TI7tHHpdwj4KBdN7qJjIELktdZBa24ziefBp6/3SEf7uSXWqMCeExVZGO4vG
         036srXprdamzGJScEzXoUWmUo7T+Ivrq80v1MIfyYXJeKzNNmTmlsznS8K0tr/Q0P5+V
         quVu4y9f7AqEzCIkkoR7lkTeit4YkmHkY4WpUvxlz9I+tz/fo6LI41PBvDzVkTT5NB3N
         pyYkMvhpJIhKNtzTFT/x96j/tNtl4BF+MJToMP6CreftjJRadpP2T1QX9XpPcJG573Ny
         JNHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749203301; x=1749808101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZNeTOPNHHaNk/W0Z9D8B6lb+kfoyEb4k9ztzQ0EwTOM=;
        b=KFPzFXlxT3IqbCSv9tVbHbXgpEDzzT24+5Dc8DhTbJnruZss1adFL++MerjU6K0nfG
         j2J5FVd+EM3x8jHebK/XtLyxOUUHmvsL0cqAckZ3EJKyP7XDRODpk3T9sB+Ieg1dPqMt
         3DYs1oHDp/Diw+O+6xNBWVnn1+8rOrRkqi85bSpjqgXEhONaT+yJBN22eW9siVIiwDLk
         sgA73q87SkCfuoIduOede3dEEr2b6OJkIS14pAWt4EM9MnGB5PNldCqvZCGXBbByzWMC
         WxhLXe5vDRBW+yvoipELT4I0AmpwNPkPYqJg6bm8rHTft9NlscYi6bsKHpI8/xkyjPLW
         Vizw==
X-Gm-Message-State: AOJu0YylU7qhi/gnw1/hBDrfxpch3T9xmuVfBT+uUJQxTWT4iNv353i9
	dX8ClMyR+pvplzNzRBn8VzjTwRrzWxGkS15XoaRGjNROCgvhY+Nss6uL67ntah4LxeSvk4hp/IO
	WLLrJY2DaQ93n
X-Gm-Gg: ASbGncuZ1EA0b7i2eqPf8NZPdTLCoJBC130lA9G3lU4CjDHzGiK/S7O9tRm2zw/66jp
	V0dMM03luh3f4uwXzhuQ5lh/qi6Fy1PryKrqqUK4/O4XZN0/rDvdwFjdEj0/PQnusRYqZR+aU3n
	rIj2Q0Lio4BEttbblAxo9Ro0ovnCxVTd4VOX17fiKGpXes3Kh80Ja2Ydfssg9rH97yZaeWGrFg/
	vBBIKwUQE46CSWdUBrjxIJZjf27Hg2lTIuT45AoKlkvD6uizisX7q+h6mUiT7xEJ+rYs7ddXkBh
	E6GPyX2+c6B+elF091pCiFLXlIPSASaIJ0P5U2fjnk4APG4QtP0=
X-Google-Smtp-Source: AGHT+IGwfViYJXEo2GLuylww7Mlr7Abjdem3kmoC51kL2njx7OZBfq0gQoKp1LIAXNcpcEg2YKF3Fg==
X-Received: by 2002:a5d:64ca:0:b0:3a3:63d3:369a with SMTP id ffacd0b85a97d-3a531cb0b45mr2615144f8f.25.1749203301289;
        Fri, 06 Jun 2025 02:48:21 -0700 (PDT)
Received: from MacBookPro.lan ([5.255.111.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7482af3859csm936348b3a.36.2025.06.06.02.48.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 06 Jun 2025 02:48:20 -0700 (PDT)
From: Su Yue <glass.su@suse.com>
To: gfs2@lists.linux.dev
Cc: l@damenly.org,
	agruenba@redhat.com,
	willy@infradead.org,
	Su Yue <glass.su@suse.com>
Subject: [PATCH 2/2] gfs2: do not call gfs2_jdata_writepages for jdata
Date: Fri,  6 Jun 2025 17:47:56 +0800
Message-Id: <20250606094756.95958-3-glass.su@suse.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250606094756.95958-1-glass.su@suse.com>
References: <20250606094756.95958-1-glass.su@suse.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The script can triger hang of umount:

==========================================================================
  dev="/dev/vdb2"
  mnt="/mnt"
  user=root

  yes | mkfs.gfs2 $dev -p lock_nolock
  mount -o quota=account $dev $mnt
  echo 1 > /sys/kernel/debug/tracing/tracing_on
  quotacheck -ug $mnt
  quotaon -ug $mnt
  quotaon --project $mnt
  chmod ugo+rwx $mnt
  setquota -u $user $((250 * 4096 / 1024)) $((500 * 4096 / 1024)) 3 5 $mnt
  umount $mnt # hangs
==========================================================================

  [  247.018171 ] INFO: task umount:1004 blocked for more than 122 seconds.
  [  247.018398 ]       Not tainted 6.11.0-09378-gfbb86b0d5f38 #235
  [  247.018598 ] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
  [  247.018866 ] task:umount          state:D stack:0     pid:1004  tgid:1004  ppid:988    flags:0x00004006
  [  247.019191 ] Call Trace:
  [  247.019282 ]  <TASK>
  [  247.019358 ]  __schedule+0x404/0x1410
  [  247.019485 ]  schedule+0x27/0xf0
  [  247.019600 ]  schedule_preempt_disabled+0x15/0x30
  [  247.019761 ]  rwsem_down_read_slowpath+0x26f/0x4e0
  [  247.019925 ]  ? sched_balance_find_src_group+0x51/0x580
  [  247.020106 ]  down_read+0x48/0xa0
  [  247.020232 ]  __gfs2_trans_begin+0x119/0x290   [gfs2 0d63e36c3a51bc921f68927c362d00048655daca]
  [  247.020535 ]  gfs2_trans_begin+0x4b/0x90   [gfs2 0d63e36c3a51bc921f68927c362d00048655daca]
  [  247.020816 ]  gfs2_write_cache_jdata+0x163/0x680   [gfs2 0d63e36c3a51bc921f68927c362d00048655daca]
  [  247.021138 ]  gfs2_jdata_writepages+0x29/0x70   [gfs2 0d63e36c3a51bc921f68927c362d00048655daca]
  [  247.021449 ]  gfs2_ail1_flush+0x1c9/0x4c0   [gfs2 0d63e36c3a51bc921f68927c362d00048655daca]
  [  247.021731 ]  ? psi_group_change+0x12a/0x300
  [  247.021882 ]  gfs2_ail1_start+0x4b/0x70   [gfs2 0d63e36c3a51bc921f68927c362d00048655daca]
  [  247.022175 ]  gfs2_log_flush+0x9fd/0xb70   [gfs2 0d63e36c3a51bc921f68927c362d00048655daca]
  [  247.022458 ]  gfs2_kill_sb+0x39/0x170   [gfs2 0d63e36c3a51bc921f68927c362d00048655daca]
  [  247.022731 ]  deactivate_locked_super+0x33/0xb0
  [  247.022890 ]  cleanup_mnt+0xba/0x150
  [  247.023018 ]  task_work_run+0x5c/0x90
  [  247.023148 ]  syscall_exit_to_user_mode+0x1b2/0x1c0
  [  247.023316 ]  do_syscall_64+0x8e/0x190
  [  247.023449 ]  ? syscall_exit_to_user_mode+0x37/0x1c0
  [  247.023618 ]  ? do_syscall_64+0x8e/0x190
  [  247.023751 ]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
  [  247.023931 ] RIP: 0033:0x7f1730c2756b
  [  247.024068 ] RSP: 002b:00007fff3db03018 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
  [  247.024334 ] RAX: 0000000000000000 RBX: 0000562517583560 RCX: 00007f1730c2756b
  [  247.024582 ] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000562517583970
  [  247.024828 ] RBP: 00007fff3db030f0 R08: 0000000000000000 R09: 0000000000000000
  [  247.025073 ] R10: 0000000000000800 R11: 0000000000000246 R12: 0000562517583668
  [  247.025320 ] R13: 0000000000000000 R14: 0000562517583970 R15: 0000000000000000
  [  247.025568 ]  </TASK>
==========================================================================

While in gfs2_ail1_flush(),  gfs2_log_flush() has already down_write sdp->sd_log_flush_lock
but gfs2_jdata_writepages() stil calls gfs2_trans_begin() to down_read the semaphore.

The commit 8d391972ae2d ("gfs2: Remove __gfs2_writepage()") overlooked differences between
gfs2_jdata_writepage() and gfs2_jdata_writepages(). The later calls gfs2_write_cache_jdata()
which 'start transactions before we grab page locks'.

The commit partly revert commit 8d391972ae2d ("gfs2: Remove __gfs2_writepage()").
__gfs2_writepage() is back as gfs2_write_jdata_folio() which is called by
exported gfs2_write_jdata_folios().
In gfs2_log_shutdown(), if the inode is jdata then call gfs2_write_jdata_folios()
to write all folios without new transaction started just like old behavior
before 8d391972ae2d.

Fixes: 8d391972ae2d ("gfs2: Remove __gfs2_writepage()")
Signed-off-by: Su Yue <glass.su@suse.com>
---
 fs/gfs2/aops.c | 40 ++++++++++++++++++++++++++++++++++++++++
 fs/gfs2/aops.h |  1 +
 fs/gfs2/log.c  |  6 +++++-
 3 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index 1a9e4ed33911..26ed68e9529a 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -138,6 +138,46 @@ static int __gfs2_jdata_write_folio(struct folio *folio,
 	return gfs2_write_jdata_full_folio(folio, wbc);
 }
 
+/**
+ * gfs2_write_jdata_folio - Write folio
+ * @folio: folio to write
+ * @wbc: The writeback control
+ *
+ * Returns: errno
+ *
+ */
+
+static int gfs2_write_jdata_folio(struct folio *folio, struct writeback_control *wbc)
+{
+	struct inode *inode = folio->mapping->host;
+	struct gfs2_inode *ip = GFS2_I(inode);
+	struct gfs2_sbd *sdp = GFS2_SB(inode);
+
+	if (gfs2_assert_withdraw(sdp, ip->i_gl->gl_state == LM_ST_EXCLUSIVE))
+		goto out;
+	if (folio_test_checked(folio) || current->journal_info)
+		goto out_ignore;
+	return __gfs2_jdata_write_folio(folio, wbc);
+
+out_ignore:
+	folio_redirty_for_writepage(wbc, folio);
+out:
+	folio_unlock(folio);
+	return 0;
+}
+
+int gfs2_write_jdata_folios(struct address_space *mapping, struct writeback_control *wbc)
+{
+	struct folio *folio = NULL;
+	int error;
+
+	while ((folio = writeback_iter(mapping, wbc, folio, &error)))
+		error = gfs2_write_jdata_folio(folio, wbc);
+
+	return error;
+}
+
+
 /**
  * gfs2_writepages - Write a bunch of dirty pages back to disk
  * @mapping: The mapping to write
diff --git a/fs/gfs2/aops.h b/fs/gfs2/aops.h
index a10c4334d248..4364693486ab 100644
--- a/fs/gfs2/aops.h
+++ b/fs/gfs2/aops.h
@@ -11,5 +11,6 @@
 void adjust_fs_space(struct inode *inode);
 void gfs2_trans_add_databufs(struct gfs2_inode *ip, struct folio *folio,
 			     size_t from, size_t len);
+int gfs2_write_jdata_folios(struct address_space *mapping, struct writeback_control *wbc);
 
 #endif /* __AOPS_DOT_H__ */
diff --git a/fs/gfs2/log.c b/fs/gfs2/log.c
index f9c5089783d2..586f103f01c2 100644
--- a/fs/gfs2/log.c
+++ b/fs/gfs2/log.c
@@ -31,6 +31,7 @@
 #include "dir.h"
 #include "trace_gfs2.h"
 #include "trans.h"
+#include "aops.h"
 
 static void gfs2_log_shutdown(struct gfs2_sbd *sdp);
 
@@ -131,7 +132,10 @@ __acquires(&sdp->sd_ail_lock)
 		if (!mapping)
 			continue;
 		spin_unlock(&sdp->sd_ail_lock);
-		ret = mapping->a_ops->writepages(mapping, wbc);
+		if (gfs2_is_jdata(GFS2_I(mapping->host)))
+			ret = gfs2_write_jdata_folios(mapping, wbc);
+		else
+			ret = mapping->a_ops->writepages(mapping, wbc);
 		if (need_resched()) {
 			blk_finish_plug(plug);
 			cond_resched();
-- 
2.48.1

