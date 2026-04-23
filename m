Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F203E4C84
	for <gfs2@lists.linux.dev>; Thu, 23 Apr 2026 09:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776936058; cv=none; b=SI8I8aZfbBz4sc49NZIA7AqTwnT/dMC5McIjsxKqfMpviTtoAe78gtXktqqdQ74LYr/EraxqAZp31eXZMBZq9ZFzhTGhkLbCq9im97KW0q6SiEtieliSsUHV5ITY8d38pZJ2yh0VQ3l2gBgkExyHa1KzoU5K5+ztSBmoUDZwsjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776936058; c=relaxed/simple;
	bh=K7o56FXoqRFyY/mX8M8npp10YmZ3rqb233igp8tPuFk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VyHpYg80eiKOYmK5v0n1f4HBAo9tTqoRjZ0ywo7bpCyi/UDEZklTp+d63pkBsF8LSdsvVg3DYQnxiDwkRi90GKhxpEiPZT31V1LKBlMCYUM13/1AvCLatgUSrJIWjzJIehD4ZDWhPlpRhvTgAO1IwiW36AeNUnM5xv258yaUeqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q+KfmDqC; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+KfmDqC"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-82fcd0aa2dbso1431074b3a.0
        for <gfs2@lists.linux.dev>; Thu, 23 Apr 2026 02:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776936056; x=1777540856; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fdhDKETwuj9Ml6qRV2b2vUEXK+zO6bSmJ/i18ItJCMs=;
        b=Q+KfmDqC0bN8qVPSDNyl5+tv4+YanqRYb4zu3rwehQdQm+ETsR2GsKSkbFMlTz2Cm0
         a7I+KHYAs1ad2/9ny+zhPRWLJ9BiGP0xlbM7HhK2Ux14e2edAEeDEHsqEWH6QkeMPLmp
         w0Ah6U3ZpnvIjvOjp0Yr3z136Pgo1MJ2IFNSdfi/DKvF9Qsbrbc0PZeXzlkNp5U1gRIm
         yIN2Cq++i+3eAgbFEP5AnEIlcC76K15F/vAIJvUnvbls1YOdQ86FOMsLa39XlB2JLETn
         zbZ0N9hD0SOJRWlM+8GCE3LeyKkdliYsId8rpqhF6PVDRu8uShV56w9u53iIZ1oGRuAv
         u1TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776936056; x=1777540856;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fdhDKETwuj9Ml6qRV2b2vUEXK+zO6bSmJ/i18ItJCMs=;
        b=N3XUBf/1Ha6VCxOmfBhH12UngEd4TZkdHNmozN6N8V/D8u/UKAGp2yUdEuRJjBeKlx
         ZT0qKhrLxqkZ5RQh0VtuJuhv2r4YjGvUyvAqC3gHV8VcNRJL4aQeVJWzs1bI1ZqGTdSe
         m+lrvQzOLx02STDPAkdM/04Vfljvo4mNG7uNqGoTa3FJf20T9zdi+jpp0dlB/rqSM9zx
         hmUAnZSFZAm75tq4vlOQb4MLJ+jmhYibUj3OdGtsiGlQLWRoeDYaZAEKTYYKT13HdZ+K
         CutP/dVuwN+j07eP0yEBQMMAberx3NGUPUh19Skad9a6KJm5LsXx2zuCKbkKgDVfunr9
         sSpA==
X-Gm-Message-State: AOJu0YzbrYNOn7cFwoTBbCPsesqbtik+OaHRtseZZgHNKD2lLxnKFjUo
	eB1Vtz/A2Z0SscPhuLrYv30eXO2OG3Yp+vvTdhH1ROY0sLlH3vkJMmom
X-Gm-Gg: AeBDietMFRzP454IQLPMpvRmWSTZV7p/gXztvU9pdMw1grX4Dy70Lq26yUxgOhpfAm5
	2rFra+t1C4+U9yugdJh094qbKmGNL09y03FrdkF3+BzA9If0ZAd3rL7FNRUY2YR6s45dI1tw1N/
	ESX30m4f5bSY0wyG3rr5aZ98IpDU4lpULIlmlxBj1qhJMW6nJqEHQSw/5x8b6QYVG1IQijJ3JCG
	djJGai5rhl3HLGePgmyiCU1Ngx0400YBa2J+Q9bc7DRFHN4cosCARGmVoLxAoi2S72vob194a7e
	5ic3ekwxfvWKRBf/8pt+0U72/9tb+7uZugAE7rsadXXJqFPKwZxYKWcO8lTd3H3d+crkrFCNxUN
	0vex1BgAxdwyhyn1bz5hYLY4cQ/7GFjBw5pvIn3XFK3/55/7FNbgWfzodYV6NoZ8IQG01pKkTAm
	+EGKuLfla5K+YfIg1xVZ++WPbqT07ZEoYFxHSK0SLxHWolZOxMI6JRKrFCV8Kv8tZOwgoyT18r6
	pU9k0AzFQ==
X-Received: by 2002:a05:6a00:14c2:b0:82f:3774:4fdc with SMTP id d2e1a72fcca58-82f8b32d6c7mr22315357b3a.1.1776936055789;
        Thu, 23 Apr 2026 02:20:55 -0700 (PDT)
Received: from kernel-fuzz.. ([103.172.182.26])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e9d35acsm20300218b3a.15.2026.04.23.02.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 02:20:55 -0700 (PDT)
From: ZhengYuan Huang <gality369@gmail.com>
To: agruenba@redhat.com
Cc: gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	r33s3n6@gmail.com,
	zzzccc427@gmail.com,
	ZhengYuan Huang <gality369@gmail.com>
Subject: [PATCH] gfs2: wait for recovery log bios in sync recovery
Date: Thu, 23 Apr 2026 17:20:44 +0800
Message-ID: <20260423092044.3769207-1-gality369@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[BUG]
Mounting a fuzzed image can recover journal 0 and queue
clean_journal()'s log-header bio, then fail recovering journal 1 on
corrupted metadata. The mount unwind frees struct gfs2_sbd, and the
delayed bio completion later reports:

BUG: KASAN: slab-use-after-free in instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
BUG: KASAN: slab-use-after-free in atomic_dec_and_test include/linux/atomic/atomic-instrumented.h:1383 [inline]
BUG: KASAN: slab-use-after-free in gfs2_end_log_write+0xe3/0x7c0 fs/gfs2/lops.c:230
Write of size 4 at addr ffff888012810e78 by task ublk.fsfuzz/334

 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0xbe/0x130 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xd1/0x650 mm/kasan/report.c:482
 kasan_report+0xfb/0x140 mm/kasan/report.c:595
 check_region_inline mm/kasan/generic.c:186 [inline]
 kasan_check_range+0x11c/0x200 mm/kasan/generic.c:200
 __kasan_check_write+0x14/0x30 mm/kasan/shadow.c:37
 instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
 atomic_dec_and_test include/linux/atomic/atomic-instrumented.h:1383 [inline]
 gfs2_end_log_write+0xe3/0x7c0 fs/gfs2/lops.c:230
 bio_endio+0x5e0/0x700 block/bio.c:1678
 blk_update_request+0x7e5/0x14e0 block/blk-mq.c:998
 blk_mq_end_request+0x61/0x3e0 block/blk-mq.c:1160
 blk_flush_complete_seq+0x8f6/0xea0 block/blk-flush.c:191
 mq_flush_data_end_io+0x2b1/0x550 block/blk-flush.c:362
 __blk_mq_end_request+0x123/0x380 block/blk-mq.c:1150
 __ublk_complete_rq drivers/block/ublk_drv.c:1202 [inline]
 ublk_ch_uring_cmd_local+0x1a5f/0x2180 drivers/block/ublk_drv.c:2478
 ublk_ch_uring_cmd+0x42/0x640 drivers/block/ublk_drv.c:2562
 io_uring_cmd+0x26f/0x570 io_uring/uring_cmd.c:263
 __io_issue_sqe+0xc2/0x760 io_uring/io_uring.c:1826
 io_issue_sqe+0xdd/0x11e0 io_uring/io_uring.c:1849
 io_queue_sqe io_uring/io_uring.c:2076 [inline]
 io_submit_sqe io_uring/io_uring.c:2336 [inline]
 io_submit_sqes+0x806/0x2390 io_uring/io_uring.c:2449
 __do_sys_io_uring_enter+0x5c0/0x13a0 io_uring/io_uring.c:3516
 __se_sys_io_uring_enter io_uring/io_uring.c:3455 [inline]
 __x64_sys_io_uring_enter+0xe5/0x1c0 io_uring/io_uring.c:3455
 x64_sys_call+0x2419/0x26a0 arch/x86/include/generated/asm/syscalls_64.h:427
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x93/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
 ...

Allocated by task 314:
 kasan_save_stack+0x39/0x70 mm/kasan/common.c:56
 kasan_save_track+0x14/0x40 mm/kasan/common.c:77
 kasan_save_alloc_info+0x37/0x60 mm/kasan/generic.c:573
 poison_kmalloc_redzone mm/kasan/common.c:400 [inline]
 __kasan_kmalloc+0xc3/0xd0 mm/kasan/common.c:417
 kasan_kmalloc include/linux/kasan.h:262 [inline]
 __kmalloc_cache_noprof+0x25f/0x800 mm/slub.c:5771
 kmalloc_noprof include/linux/slab.h:957 [inline]
 kzalloc_noprof include/linux/slab.h:1094 [inline]
 init_sbd fs/gfs2/ops_fstype.c:78 [inline]
 gfs2_fill_super+0x19e/0x2a80 fs/gfs2/ops_fstype.c:1128
 get_tree_bdev_flags+0x38b/0x640 fs/super.c:1698
 get_tree_bdev+0x24/0x40 fs/super.c:1721
 gfs2_get_tree+0x56/0x280 fs/gfs2/ops_fstype.c:1337
 vfs_get_tree+0x9a/0x370 fs/super.c:1758
 fc_mount fs/namespace.c:1199 [inline]
 do_new_mount_fc fs/namespace.c:3642 [inline]
 do_new_mount fs/namespace.c:3718 [inline]
 path_mount+0x5b8/0x1ea0 fs/namespace.c:4028
 do_mount fs/namespace.c:4041 [inline]
 __do_sys_mount fs/namespace.c:4229 [inline]
 __se_sys_mount fs/namespace.c:4206 [inline]
 __x64_sys_mount+0x282/0x320 fs/namespace.c:4206
 x64_sys_call+0x1a7d/0x26a0 arch/x86/include/generated/asm/syscalls_64.h:166
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x93/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

Freed by task 314:
 kasan_save_stack+0x39/0x70 mm/kasan/common.c:56
 kasan_save_track+0x14/0x40 mm/kasan/common.c:77
 __kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:587
 kasan_save_free_info mm/kasan/kasan.h:406 [inline]
 poison_slab_object mm/kasan/common.c:252 [inline]
 __kasan_slab_free+0x6f/0xa0 mm/kasan/common.c:284
 kasan_slab_free include/linux/kasan.h:234 [inline]
 slab_free_hook mm/slub.c:2543 [inline]
 slab_free mm/slub.c:6642 [inline]
 kfree+0x2bf/0x6b0 mm/slub.c:6849
 free_sbd fs/gfs2/ops_fstype.c:71 [inline]
 gfs2_fill_super+0x14cd/0x2a80 fs/gfs2/ops_fstype.c:1321
 get_tree_bdev_flags+0x38b/0x640 fs/super.c:1698
 get_tree_bdev+0x24/0x40 fs/super.c:1721
 gfs2_get_tree+0x56/0x280 fs/gfs2/ops_fstype.c:1337
 vfs_get_tree+0x9a/0x370 fs/super.c:1758
 fc_mount fs/namespace.c:1199 [inline]
 do_new_mount_fc fs/namespace.c:3642 [inline]
 do_new_mount fs/namespace.c:3718 [inline]
 path_mount+0x5b8/0x1ea0 fs/namespace.c:4028
 do_mount fs/namespace.c:4041 [inline]
 __do_sys_mount fs/namespace.c:4229 [inline]
 __se_sys_mount fs/namespace.c:4206 [inline]
 __x64_sys_mount+0x282/0x320 fs/namespace.c:4206
 x64_sys_call+0x1a7d/0x26a0 arch/x86/include/generated/asm/syscalls_64.h:166
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x93/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x76/0x7e


[CAUSE]
gfs2_recover_journal(jd, true) only waits for the recovery worker to
clear JDF_RECOVERY. After the clean_journal() wait was removed,
clean_journal() can still have an in-flight bio holding bi_private =
sdp when the synchronous caller returns. If a later recovery step
fails, mount teardown can free sdp before gfs2_end_log_write()
decrements sd_log_in_flight.

[FIX]
When wait=true, also wait for sd_log_in_flight to drain before
returning from gfs2_recover_journal(). This restores the synchronous
recovery completion contract on the cold mount path without changing
the wait=false recovery callers.

Fixes: 4a3d049db42b ("gfs2: Don't wait for journal flush in clean_journal")
Signed-off-by: ZhengYuan Huang <gality369@gmail.com>
---
 fs/gfs2/recovery.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/gfs2/recovery.c b/fs/gfs2/recovery.c
index 616c46aa3434..954b0367e8e2 100644
--- a/fs/gfs2/recovery.c
+++ b/fs/gfs2/recovery.c
@@ -566,6 +566,7 @@ void gfs2_recover_func(struct work_struct *work)
 
 int gfs2_recover_journal(struct gfs2_jdesc *jd, bool wait)
 {
+	struct gfs2_sbd *sdp = GFS2_SB(jd->jd_inode);
 	int rv;
 
 	if (test_and_set_bit(JDF_RECOVERY, &jd->jd_flags))
@@ -575,9 +576,12 @@ int gfs2_recover_journal(struct gfs2_jdesc *jd, bool wait)
 	rv = queue_work(gfs2_recovery_wq, &jd->jd_work);
 	BUG_ON(!rv);
 
-	if (wait)
+	if (wait) {
 		wait_on_bit(&jd->jd_flags, JDF_RECOVERY,
 			    TASK_UNINTERRUPTIBLE);
+		/* Synchronous recovery must not return while its log bio is live. */
+		log_flush_wait(sdp);
+	}
 
 	return wait ? jd->jd_recover_error : 0;
 }
-- 
2.49.0
