Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AC328640E
	for <gfs2@lists.linux.dev>; Tue,  9 Sep 2025 23:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757460212; cv=none; b=rOpo4Km/UbKLVpOsl3Adea9epzAXN5+HE1SJUg3qS3fVhHue6sjxup6aw7je2/8cdN6Ve85NmG6hUYVMP7avFKCgTYRn2R7u2vVvbndeMsPYj/PkX7lG6/ckbwAh2EJRDdLExMWf6ccHL2CkPVgaKaD6J9ljX6JOyTgpgba6wNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757460212; c=relaxed/simple;
	bh=M5GUi+UFBwWm+EXf6sxOo83N1GRYMBNV4Yu3+UGUlJU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=h7Y/kShY3Jn0XqXpgUo6RfYsIZkUQ3ws1YtAEZSIg+Foog1zaOqKKb+wkC0nU6LT6aubnEj4H/nQxOtZLxWZjb4HOTbhnWP3bnvsyD57Z1Sl6FRY9QoguN3+uIDkX4y6X2PUugYv4CONhTQAqcxFnEcKkJb0fvFzZvxJXrBlUZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-4020e59b735so101312145ab.1
        for <gfs2@lists.linux.dev>; Tue, 09 Sep 2025 16:23:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757460210; x=1758065010;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eXRzNXovbvKhfHPl7AbaXleDD01AmnIrCau7uI7AOJI=;
        b=AdBHmnXD77y7FkRcG7z2jNO78JJSz/3zu5Gum5nw/Y2x7yBauKy9aSR3aTJzr224UM
         NNpcFWSSoD5dgOEOIzePlKfK2Z0FPJBfGBbjtgOOfhqKeXt6zC13pLjkfNcgW2ZT7O3k
         OFIj+/cXARAlcQrC47OpJQCC21OxO8/U6nYgIC2qJ2Z03oYXPdgAopHEs4nmYW7WSTh+
         4wwDgFvcOQ/qq7cK5oRQSACwar0Iw75lYodW9NIkzqoH6GgLwU+M+zl4k2VxKz/ZOFYG
         jk3JCHV60IfQPCcC7KNNX9IGMfhCj3va6DEgiG/wgt8XYzhHNkYkBF33HfbGLhgjEcRe
         w1xQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKLhgLiR5E8ULkTA+ejflImZIrjWhLTP9YC5wbePO0opzH/un5oFfgOJtA8vf17KYY6DEP@lists.linux.dev
X-Gm-Message-State: AOJu0YxndXOAqyDfI5ixOmZFVMf+0jtilACW6BdVxQyIcHSGZpUpMfrD
	SI/0jS7olOfr7oluWaXsQ4UZ4xAHZ7LB34VcFo1ayUx0sqlAjHUlkKV19M9nvDg2SU+xIIcOYkV
	C/6mae6jRoepjt4c7W2VAoiardHBe7lSqYUFHJJosqpnUMfClg6EyW254rNY=
X-Google-Smtp-Source: AGHT+IFvCVHOScOi1V4fP34N4FyO6fyiAJKqjUpEEcDIuwwx8hBXeKenax2RAZr0ypfGlZNKySYb4PvwnUH7a4//b70QmsG4/c34
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:4417:10b0:402:b8e3:c9f6 with SMTP id
 e9e14a558f8ab-402b8e3cfbcmr156221175ab.25.1757460209872; Tue, 09 Sep 2025
 16:23:29 -0700 (PDT)
Date: Tue, 09 Sep 2025 16:23:29 -0700
In-Reply-To: <684c0d76.050a0220.be214.029f.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c0b6f1.050a0220.3c6139.0014.GAE@google.com>
Subject: Re: [syzbot] [gfs2?] kernel BUG in gfs2_jindex_free (2)
From: syzbot <syzbot+150563285f78ac3e9bd4@syzkaller.appspotmail.com>
To: agruenba@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    9dd1835ecda5 Merge tag 'dma-mapping-6.17-2025-09-09' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1580c934580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c7f605fd273c8220
dashboard link: https://syzkaller.appspot.com/bug?extid=150563285f78ac3e9bd4
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10472642580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10b94b12580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-9dd1835e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4657190ff75d/vmlinux-9dd1835e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2c21590a37de/bzImage-9dd1835e.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/4e71338bb0fc/mount_0.gz
  fsck result: OK (log: https://syzkaller.appspot.com/x/fsck.log?x=138ab562580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+150563285f78ac3e9bd4@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at fs/gfs2/super.c:76!
Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5487 Comm: syz-executor Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:gfs2_jindex_free+0x43e/0x440 fs/gfs2/super.c:76
Code: c8 85 80 07 cc 89 f9 80 e1 07 80 c1 03 38 c1 0f 8c ea fd ff ff e8 42 39 26 fe e9 e0 fd ff ff e8 b8 a0 7d 07 e8 53 48 c1 fd 90 <0f> 0b 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 0f 1f 00
RSP: 0018:ffffc90002a8fa40 EFLAGS: 00010293
RAX: ffffffff83fe763d RBX: dead000000000122 RCX: ffff888034610000
RDX: 0000000000000000 RSI: 0000000000000008 RDI: 00000000ffffffff
RBP: ffffc90002a8fb00 R08: ffff888050e74d4f R09: 1ffff1100a1ce9a9
R10: dffffc0000000000 R11: ffffed100a1ce9aa R12: ffff888050e74818
R13: dffffc0000000000 R14: ffff888040184200 R15: ffff888040184278
FS:  0000000000000000(0000) GS:ffff88808d20c000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c0021090f0 CR3: 0000000043def000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 gfs2_put_super+0x8af/0x950 fs/gfs2/super.c:636
 generic_shutdown_super+0x135/0x2c0 fs/super.c:643
 kill_block_super+0x44/0x90 fs/super.c:1766
 deactivate_locked_super+0xb9/0x130 fs/super.c:474
 cleanup_mnt+0x425/0x4c0 fs/namespace.c:1375
 task_work_run+0x1d1/0x260 kernel/task_work.c:227
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0x6b5/0x2300 kernel/exit.c:961
 do_group_exit+0x21c/0x2d0 kernel/exit.c:1102
 __do_sys_exit_group kernel/exit.c:1113 [inline]
 __se_sys_exit_group kernel/exit.c:1111 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1111
 x64_sys_call+0x21f7/0x2200 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f235d18eba9
Code: Unable to access opcode bytes at 0x7f235d18eb7f.
RSP: 002b:00007fff8ebd2df8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f235d211c2a RCX: 00007f235d18eba9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000001
RBP: 0000000000000005 R08: 00007fff8ebd0b97 R09: 00007fff8ebd4050
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fff8ebd4050
R13: 00007f235d211c05 R14: 0000000000018b8b R15: 00007fff8ebd4090
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:gfs2_jindex_free+0x43e/0x440 fs/gfs2/super.c:76
Code: c8 85 80 07 cc 89 f9 80 e1 07 80 c1 03 38 c1 0f 8c ea fd ff ff e8 42 39 26 fe e9 e0 fd ff ff e8 b8 a0 7d 07 e8 53 48 c1 fd 90 <0f> 0b 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 0f 1f 00
RSP: 0018:ffffc90002a8fa40 EFLAGS: 00010293
RAX: ffffffff83fe763d RBX: dead000000000122 RCX: ffff888034610000
RDX: 0000000000000000 RSI: 0000000000000008 RDI: 00000000ffffffff
RBP: ffffc90002a8fb00 R08: ffff888050e74d4f R09: 1ffff1100a1ce9a9
R10: dffffc0000000000 R11: ffffed100a1ce9aa R12: ffff888050e74818
R13: dffffc0000000000 R14: ffff888040184200 R15: ffff888040184278
FS:  0000000000000000(0000) GS:ffff88808d20c000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c0021090f0 CR3: 000000003380a000 CR4: 0000000000352ef0


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
