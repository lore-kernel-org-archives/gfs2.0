Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107BC43C7A3
	for <gfs2@lists.linux.dev>; Wed,  8 Jul 2026 12:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783513638; cv=pass; b=cm8RHC+4qJPrrFum58/c99n51HUEAb9lybGQYpfoVwzxnUWMzKgQSZQKNgQPX7bVnM8zPGTvOo853pLNS9R3VJD4+oN0mH1fH5S0ZdIxIioOmZujWeEMWLrsDk+88bCnO1FLlW7NT0IIozmWRa0IXUs8/vdPfHXJHtQhUGCJnrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783513638; c=relaxed/simple;
	bh=zPFkyhopdFT0JPsIfgb2iXZl8chYkBZJNeonmSHRRGA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=YoFB77J4IrY3IXymnlcaUWDRICVwoccxoCgLl7S+K2wqBrNy+pEmu8n4zQrjADYhp0AR4k6yRVuBgENKZOyCp+qVkULdORfzNh0DMv1tmiO0ZlsMqfXmTkxJcFgOMtSWeKBp4jbPnrwEQZq0n2IPezBzoRn4z6pp24XQl1TeSJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RucI1+Wv; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RucI1+Wv"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-698562f10e7so913113a12.0
        for <gfs2@lists.linux.dev>; Wed, 08 Jul 2026 05:27:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783513632; cv=none;
        d=google.com; s=arc-20260327;
        b=Hkorokp/QOHxDBJTqR+u+TFjb7ruqDQnAi52aJkcd/dfkZYDppTU/6+uVa00lKmRWd
         qGTSs971bFUQ6Myr1S1vz6CvGJXv6si0pYvIjOGREc+ylzfaLDgwsCkqQ5UM8k0M0+zS
         RFC1nuOalNhOSlUdj6zgdvy99+FiA/cJcukWoAxTlWwaVShmYqkeepGtl36tzs68D3pX
         Id0nCtSQ8ivjWBXvzSl0UgXxAYpbdj7so/aTKxQx7l1vpEdr4CKXvnK3oLNN5C7AbvI9
         wwIbJclacQz43ENfWm92Ym8gU1Q1VC7UGgLZS/77CoQU/wjIDyxidk78P2YE7dqZSNyh
         USiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=tLQLcpScQrE7wzrhdFXjxcM3MEyMt2LTWYco/p/bFBw=;
        fh=9BfCWamNaSJJ1q7D9Mwz6L+IhgepDam3u6kaUFabzv4=;
        b=RUzng+sqQaQVIImyrORDAXlKtoJ+X1Jab3KJ5FwG2kOwWsKZqinyotIKmovvKOorI1
         EB6QZphAGgET87KPQwUh9hImEGHHKVBCYvUx5OAzUWLv9jBYHLqAj0kFSA+RVAdHN9EW
         o1HrZOslFUY/8/CiscDJM1gaTt2WqZVmwK54eLcjmF/+gVHmP3DBUJoJ1S8TRR2XuIB4
         dfz6lRQR3DJ1nRCIikhcmICK49z4jomtRQn7bdgVq3iADd0Kd0crOUrn/p/0snLL+C7n
         jKDZLIpWxRsEg4dCO+d70eWGKrvsqZ+a6BWVa5CKjzaq6h3+X8pzgXyyPzaFjvS4vRgQ
         fxvg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783513632; x=1784118432; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tLQLcpScQrE7wzrhdFXjxcM3MEyMt2LTWYco/p/bFBw=;
        b=RucI1+Wv+JwdJdOc4l1s0bcVrhTj0ZN2WeLQAhgZgzo/VC1mk37DmSWWdCBehCsyN6
         vqq6obl1y9bbeEELeAeXYMTubTdoRP+BiQ+047VgDrNq5gSC1CBuH9kCIW93i5d6HJ1g
         h71Yt2fPlxISBDwDFi2/4/hHuoyK+zlVPy71wo69EgVzi1KejVUZgRPE5J2WNsbcYg/n
         /ky1OgCZl4b0kk4djF5TxDHRqn5q2VxmlyHoM+JC1pOJSCyN83in+n5nJygs8+H71nEB
         aEIxLFbbksOEebYFCVxfgU0jSrMuSbqZB9ZqKQf+x6cpYIiLrqCs1vnieAT/2rDEOzCl
         JvxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783513632; x=1784118432;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tLQLcpScQrE7wzrhdFXjxcM3MEyMt2LTWYco/p/bFBw=;
        b=guidprqt3hDk1kqGGxSh42end7yM/A/diYjRoeG1afpsaKNDpNmZ7kaOliAEkTTmip
         6KwHDVaqMBpGiLetUZ6vWaYO4u/1srMX1P/K8+3svhSXjLWfV5oHdBGUJFRAQvev2Adv
         GWrD1KLTr9pTlicMihS2IcH3s2D55wlsEN6WPY66Yt2qlYsb6MFXclNHEluBAMF5Ign1
         uJy6S7qX4bZ0KahYpz55SaSh2ER4TvoZauABFrJ4e6EfO7xMKZ4cqvggnbUPCW7Os7Hn
         w5DmiBJlgcRO9g6Ab6BxAB9+8OL2QhdSqGjwm846UgXPwJtVC4kjSkvLmdOODxllvRSn
         RuPg==
X-Forwarded-Encrypted: i=1; AHgh+Rpa6TjZo6oAD04aaeCdMlTr6XlR61hguNqBRnBMU9UR60eilOE2K4hZLS0a/UB2VQkcE81u@lists.linux.dev
X-Gm-Message-State: AOJu0YzAqucjPBHBjz/IUZiCrdq3R7l01mQd96OWcMyxrVDTxr2aKYPa
	/ZvGwyqUnwxBc4l3jdzugJf3JwgHYP7orIWaAEcA5Q3RhFh0EtZfda7EiSwadP6/5RbVkHSe1eC
	yT1pB9LHUEoyo/YB85oCJeugZbtCxp5o=
X-Gm-Gg: AfdE7cniu3DpxFxcJ0C4dMYIG0TNgHaZ8caxzuS3lKAFhygTza8DimSU5l1cQObdN/3
	KbmphhsuFS/syUw9HNgI9qcA1knXrg6phVRTCuBCu/uOxGGLWrfxMaTJT81jHpaRZdi2N2eXjlf
	7prk5O1jAbbSCEnD6E+dLraW3qXsAb34bwvKKUeWjcHLL1oLpzVylvFkEKko5OIFLFgmznUiNxB
	23itrrA+xnIQGp4TSlAJJGAGa7VuAV8hpwNdT7Z6yI9s+Wl6rQR0kVQDj1q/SR+HXEjonzRBg==
X-Received: by 2002:a17:907:1c2a:b0:c15:da6a:c27c with SMTP id
 a640c23a62f3a-c15da6ac90emr36104866b.25.1783513631840; Wed, 08 Jul 2026
 05:27:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Jiaming Zhang <r772577952@gmail.com>
Date: Wed, 8 Jul 2026 20:26:33 +0800
X-Gm-Features: AVVi8CcTSxSWQp0p80NXDPDi3QdM336AmO4_nL_nipqop-pDGgp1enlvRLIVHzQ
Message-ID: <CANypQFasb8voDrg=O9xJikYHdRFeupb5VP2VeJaZ_wFNMoGr2Q@mail.gmail.com>
Subject: [Linux Kernel Bug] INFO: task hung in gfs2_logd
To: agruenba@redhat.com, gfs2@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, syzkaller@googlegroups.com, 
	r772577952@gmail.com
Content-Type: text/plain; charset="UTF-8"

Dear Linux kernel developers and maintainers,

We are writing to report a task hung issue discovered in the GFS2
subsystem. The issue is reproducible on the latest version of linux
(v7.2-rc2, commit 8cdeaa50eae8dad34885515f62559ee83e7e8dda). Below is
the kernel report:

---
INFO: task gfs2_logd/syz:s:9474 blocked for more than 143 seconds.
      Not tainted 7.2.0-rc2-00001-g946f2468cbdc #3
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:gfs2_logd/syz:s state:D stack:29288 pid:9474  tgid:9474  ppid:2
   task_flags:0x200040 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5510 [inline]
 __schedule+0x1743/0x55b0 kernel/sched/core.c:7234
 __schedule_loop kernel/sched/core.c:7311 [inline]
 schedule+0x165/0x2b0 kernel/sched/core.c:7326
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7383
 rwsem_down_write_slowpath+0x874/0x1010 kernel/locking/rwsem.c:1215
 __down_write_common kernel/locking/rwsem.c:1347 [inline]
 __down_write kernel/locking/rwsem.c:1356 [inline]
 down_write+0x1ab/0x1f0 kernel/locking/rwsem.c:1632
 gfs2_logd+0x27a/0x10b0 fs/gfs2/log.c:1351
 kthread+0x389/0x480 kernel/kthread.c:436
 ret_from_fork+0x509/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Showing all locks held in the system:
5 locks held by kworker/u10:1/32:
1 lock held by khungtaskd/35:
 #0: ffffffff8e55a1c0 (rcu_read_lock){....}-{1:3}, at:
rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #0: ffffffff8e55a1c0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock
include/linux/rcupdate.h:840 [inline]
 #0: ffffffff8e55a1c0 (rcu_read_lock){....}-{1:3}, at:
debug_show_all_locks+0x2e/0x180 kernel/locking/lockdep.c:6775
3 locks held by syz-executor108/9460:
1 lock held by gfs2_logd/syz:s/9474:
 #0: ffff8880278dce80 (&sdp->sd_log_flush_lock){++++}-{4:4}, at:
gfs2_logd+0x27a/0x10b0 fs/gfs2/log.c:1351
2 locks held by gfs2_quotad/syz/9475:
 #0: ffff888023d04640 (sb_internal#2){.+.+}-{0:0}, at:
gfs2_trans_begin+0x6f/0xe0 fs/gfs2/trans.c:123
 #1: ffff8880278dce80 (&sdp->sd_log_flush_lock){++++}-{4:4}, at:
__gfs2_trans_begin+0x519/0x900 fs/gfs2/trans.c:87

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 35 Comm: khungtaskd Not tainted
7.2.0-rc2-00001-g946f2468cbdc #3 PREEMPT(full)
Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix,
1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x10e/0x190 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x274/0x2d0 lib/nmi_backtrace.c:122
 nmi_trigger_cpumask_backtrace+0x17a/0x380 lib/nmi_backtrace.c:65
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 __sys_info lib/sys_info.c:157 [inline]
 sys_info+0x135/0x170 lib/sys_info.c:165
 check_hung_uninterruptible_tasks kernel/hung_task.c:353 [inline]
 watchdog+0xfdf/0x1040 kernel/hung_task.c:561
 kthread+0x389/0x480 kernel/kthread.c:436
 ret_from_fork+0x509/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 9460 Comm: syz-executor108 Not tainted
7.2.0-rc2-00001-g946f2468cbdc #3 PREEMPT(full)
Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix,
1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:do_raw_spin_lock+0xa/0x260 kernel/locking/spinlock_debug.c:114
Code: c1 7c 90 48 89 df e8 f5 02 91 00 eb 86 0f 1f 00 90 90 90 90 90
90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 55 48 89 e5 41 57 <41> 56
41 55 41 54 53 48 83 e4 e0 48 81 ec 80 00 00 00 48 89 fb 65
RSP: 0018:ffffc90003777748 EFLAGS: 00000296
RAX: abc1b017099cbe00 RBX: ffff888044d2c7b8 RCX: 0000000080000001
RDX: 0000000000000000 RSI: ffffffff8dd65db5 RDI: ffff8880278dcf18
RBP: ffffc90003777750 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: ffffffff841989b2 R12: 1ffff110089a58f7
R13: ffff888045c47218 R14: 0000000000000000 R15: ffff8880278dcf60
FS:  000055555e67e380(0000) GS:ffff8880ebe25000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000556a433c4638 CR3: 0000000043a37000 CR4: 0000000000752ef0
PKRU: 55555554
Call Trace:
 <TASK>
 spin_lock include/linux/spinlock.h:342 [inline]
 gfs2_ail1_start_one fs/gfs2/log.c:143 [inline]
 gfs2_ail1_flush+0xce2/0xfb0 fs/gfs2/log.c:218
 gfs2_ail1_start fs/gfs2/log.c:249 [inline]
 empty_ail1_list+0x13d/0x260 fs/gfs2/log.c:978
 __gfs2_log_flush+0x176a/0x1d70 fs/gfs2/log.c:1167
 gfs2_log_flush+0x34/0x50 fs/gfs2/log.c:1216
 gfs2_kill_sb+0x5c/0x430 fs/gfs2/ops_fstype.c:1779
 deactivate_locked_super+0xbc/0x130 fs/super.c:477
 cleanup_mnt+0x425/0x4c0 fs/namespace.c:1317
 task_work_run+0x1d4/0x260 kernel/task_work.c:233
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 __exit_to_user_mode_loop kernel/entry/common.c:70 [inline]
 exit_to_user_mode_loop+0x207/0x7c0 kernel/entry/common.c:101
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:230 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:318 [inline]
 do_syscall_64+0x353/0x5c0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f608523e48b
Code: ea 75 a4 c7 05 4e 85 0a 00 00 00 00 00 eb 98 e8 bb 07 00 00 66
2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 a6 00 00 00 0f 05 <48> 3d
00 f0 ff ff 77 05 c3 0f 1f 40 00 48 c7 c2 c0 ff ff ff f7 d8
RSP: 002b:00007ffeb55b0b78 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f608523e48b
RDX: 00007f6085220ea8 RSI: 0000000000000009 RDI: 00007ffeb55b0c40
RBP: 00007ffeb55b0c40 R08: 0000000000000073 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffeb55b1ce0
R13: 000055555e67f6e0 R14: 0000000000000001 R15: 431bde82d7b634db
 </TASK>
---

Following is the root cause analysis for this issue, note that
analysis is performed with the assistance of LLM, it maybe inaccurate.

The root cause for this issue is that, during unmount, gfs2_kill_sb()
performs a synchronous log flush before the GFS2 background log and
quota threads are stopped. Given a corrupted GFS2 image, the
synchronous flush can spend a long time in empty_ail1_list() /
gfs2_ail1_flush() while holding sdp->sd_log_flush_lock.

While the unmount path is holding sd_log_flush_lock, gfs2_logd can
wake up and try to acquire the same lock for write in gfs2_logd(). At
the same time, gfs2_quotad can try to start a transaction through
gfs2_statfs_sync() and block on sd_log_flush_lock for read in
__gfs2_trans_begin(). Both background threads can remain in D state
long enough to trigger the hung task issue.

To fix this issue, we can stop the GFS2 background threads by calling
gfs2_destroy_threads(sdp) before gfs2_kill_sb() starts the synchronous
log flush. gfs2_destroy_threads() calls kthread_stop_put() for
sd_logd_process and sd_quotad_process, so it waits until gfs2_logd and
gfs2_quotad have actually exited. After that, the following
gfs2_log_flush() may still take time to drain the AIL, but no live
background log or quota thread can enter gfs2_logd() or
gfs2_statfs_sync() and block behind sd_log_flush_lock. This avoids the
reported D-state wait in gfs2_logd/gfs2_quotad without changing the
log flush itself.

```
diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index 9b9e70f14d25..d087845a75d6 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -1776,6 +1776,8 @@ static void gfs2_kill_sb(struct super_block *sb)
        return;
    }

+   gfs2_destroy_threads(sdp);
+
    gfs2_log_flush(sdp, NULL, GFS2_LOG_HEAD_FLUSH_SYNC | GFS2_LFC_KILL_SB);
    dput(sdp->sd_root_dir);
    dput(sdp->sd_master_dir);
```

After applying the above patch, the reproducer no longer triggers the
issue on my machine.

If this solution is acceptable, we are happy to submit a formal patch.

The kernel console output, kernel config, syzkaller reproducer, and C
reproducer are available at google drive:
https://drive.google.com/drive/folders/1_RQO1w7qM5RU5ibdiq09Mpr96E6IITH0?usp=sharing

Please let me know if any further information is required.

Best Regards,
Jiaming Zhang
