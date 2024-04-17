Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7981316FF41
	for <gfs2@lists.linux.dev>; Wed, 17 Apr 2024 16:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713372867; cv=none; b=UEACm5c4GBvo2tC/P6h6GmiKOn/74YjGm3Zxv+3DNTHKIWPxZPM5Pt8pIduEyXHzsp/mHYXOm1mGTESuVXCRsEFCs+N486cZZyVVbNjwCd4TvUdiQaLe3ayCMyQ5FXtKkfNuCSlqazNJYYDiG2usl00oJSH8uN+cncGG934gJZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713372867; c=relaxed/simple;
	bh=zlO3QyLU6T6kAPgF315577WoowuqF+crHU62sbLQ95M=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=BVeAdhCRT4diCpaOoOH4YcTpI5TDRihjsx9I3goQBubSZT6tJDOTCwz5FY/Z1+Tf3wuEFovRhY1gIRcv86U25Ax2mp1a0r1oIQiMiAYFHUhKVMcIYGyoyZJjRkPvMBjeCSTcR1XOKm1lAEvTP+lrWcobMFD2cmHkkjXLWTT+Twc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7d5f987a9f9so630477039f.2
        for <gfs2@lists.linux.dev>; Wed, 17 Apr 2024 09:54:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713372864; x=1713977664;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=94AERZMjJPIAPdPJbcKSLmYY89yKeD6SgqSo1jdF7OA=;
        b=WY22QcYpB36pIVTqnjZrUZz7K6kpbqmJB3evEXqvTL/pZSI1RYH/vABggZkY30NUqf
         54JpIJu7D7bhqXTZayew8GIBpWh0KWxZOjFzgeL9TmW7pxT6PArTP1uWp4tDlRmNxDRx
         tgEmwaoIP70AEh+xwB1qz7SdYCNjZLUq8hJeVvaX2LkaZyld2rNOBf5dUKSEDGAJDpm2
         fRxedVe+ovep8ufFxiYQuG0/zF3a8KGB38OBuI/X5cCAIJJEaF6VcR//1dvRIZWQb5Po
         myB5l3MkdFmejbK8spvbLqWo3em1AUg+2n/4CVnAEmu9vYk8PDk/blFjgAHtGpbpJnwr
         009Q==
X-Forwarded-Encrypted: i=1; AJvYcCWHA8nJsrz1NoQuPTOTybT0b5FG3xL8GxdooTZTf8shYya3QMEo+KV4eSo/AoyFKiko6dzY1FYcH+wTuXIgCT7MnWMdAg==
X-Gm-Message-State: AOJu0YwKKq2BVZH+GqMsziWfbFRL/rwLbHoFEmXp5PqZrrxDReX8r1Sx
	fSeov065weF2QW6gMXwkpGdTGNT16+sjO6Ryj5Zg5yYYbBH23HfwRJjFPUoj0Z4LM3TsZIFbzLp
	e5kQkpwDUuFMI7r+IqKYJeabVr0wa1FTkGzpzFST9dI3Wq0N1a9n+KWI=
X-Google-Smtp-Source: AGHT+IFNX1QrBClN+f+KBHQMg3tx/9A1nlzXeU4PiLf7pH9u6E//ldPrxBgPGlqAVdW7tvAnyXmEqGbtDVq6eeqyVtLfl9hRuoeu
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8917:b0:482:fa6f:78fd with SMTP id
 jc23-20020a056638891700b00482fa6f78fdmr839217jab.0.1713372864804; Wed, 17 Apr
 2024 09:54:24 -0700 (PDT)
Date: Wed, 17 Apr 2024 09:54:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f987ff06164db4f6@google.com>
Subject: [syzbot] [gfs2?] INFO: task hung in gfs2_glock_nq
From: syzbot <syzbot+dbb72d38131e90dc1f66@syzkaller.appspotmail.com>
To: agruenba@redhat.com, gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b5d2afe8745b Merge branches 'for-next/kbuild', 'for-next/m..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=139e600b180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=560f5db1d0b3f6d0
dashboard link: https://syzkaller.appspot.com/bug?extid=dbb72d38131e90dc1f66
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1745f177180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17509b6d180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/50bff35e1638/disk-b5d2afe8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4eeaa73e7ed1/vmlinux-b5d2afe8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8e796b089aa9/Image-b5d2afe8.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/3f56655953c4/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+dbb72d38131e90dc1f66@syzkaller.appspotmail.com

INFO: task syz-executor105:6284 blocked for more than 143 seconds.
      Not tainted 6.9.0-rc3-syzkaller-gb5d2afe8745b #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor105 state:D stack:0     pid:6284  tgid:6284  ppid:6282   flags:0x00000004
Call trace:
 __switch_to+0x314/0x560 arch/arm64/kernel/process.c:553
 context_switch kernel/sched/core.c:5409 [inline]
 __schedule+0x14bc/0x24ec kernel/sched/core.c:6746
 __schedule_loop kernel/sched/core.c:6823 [inline]
 schedule+0xbc/0x238 kernel/sched/core.c:6838
 bit_wait+0x1c/0xac kernel/sched/wait_bit.c:199
 __wait_on_bit kernel/sched/wait_bit.c:49 [inline]
 out_of_line_wait_on_bit+0x208/0x334 kernel/sched/wait_bit.c:64
 wait_on_bit include/linux/wait_bit.h:76 [inline]
 gfs2_glock_wait+0xb8/0x298 fs/gfs2/glock.c:1354
 gfs2_glock_nq+0xcc8/0x169c fs/gfs2/glock.c:1616
 gfs2_glock_nq_init fs/gfs2/glock.h:238 [inline]
 __gfs2_lookup+0x124/0x270 fs/gfs2/inode.c:905
 gfs2_lookup+0x2c/0x3c fs/gfs2/inode.c:930
 __lookup_slow+0x250/0x374 fs/namei.c:1692
 lookup_slow+0x60/0x84 fs/namei.c:1709
 walk_component+0x280/0x36c fs/namei.c:2004
 lookup_last fs/namei.c:2461 [inline]
 path_lookupat+0x13c/0x3d0 fs/namei.c:2485
 filename_lookup+0x1d4/0x4e0 fs/namei.c:2514
 user_path_at_empty+0x5c/0x84 fs/namei.c:2921
 user_path_at include/linux/namei.h:57 [inline]
 ksys_umount fs/namespace.c:1916 [inline]
 __do_sys_umount fs/namespace.c:1924 [inline]
 __se_sys_umount fs/namespace.c:1922 [inline]
 __arm64_sys_umount+0xf8/0x17c fs/namespace.c:1922
 __invoke_syscall arch/arm64/kernel/syscall.c:34 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:48
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:133
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:152
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598

Showing all locks held in the system:
1 lock held by khungtaskd/30:
 #0: ffff80008f057880 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire+0xc/0x44 include/linux/rcupdate.h:328
2 locks held by getty/6006:
 #0: ffff0000ccbde0a0 (&tty->ldisc_sem){++++}-{0:0}, at: ldsem_down_read+0x3c/0x4c drivers/tty/tty_ldsem.c:340
 #1: ffff800097b9b2f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x41c/0x1228 drivers/tty/n_tty.c:2201
1 lock held by syz-executor105/6284:
 #0: ffff0000df4da9a0 (&type->i_mutex_dir_key#6){.+.+}-{3:3}, at: inode_lock_shared include/linux/fs.h:805 [inline]
 #0: ffff0000df4da9a0 (&type->i_mutex_dir_key#6){.+.+}-{3:3}, at: lookup_slow+0x50/0x84 fs/namei.c:1708

=============================================



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
