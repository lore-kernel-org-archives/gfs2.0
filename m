Received: from mail-oi1-f205.google.com (mail-oi1-f205.google.com [209.85.167.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA743002DD
	for <gfs2@lists.linux.dev>; Fri, 21 Aug 2026 08:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787302075; cv=none; b=g5fH0lOB3D/kr8ELr32y3pnt/e+/0kgWPNTxPa7LGOMRBgP4S7ls/p1bXM5uInbLi+xIGdqvdF5Vm6UFScoHp6CuwTX+OuEz7+qGqeKQvfrGhZfvlJvoTvJQcsn4m2tJFsiyVx2sIiAlNPynOfcaSDRoux/ZaNu0b671WlpJgt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787302075; c=relaxed/simple;
	bh=O1ZTLIoo6Vjt6O0krePAej0tYjPgqkSyWHb2JYo6ReY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=FJ8xRdNhFBCUD8g0sj+yhGVyAik6WIat2F8MrChxM0zWTYs60kRpxDyptRW7CG+iGvUNXhQRDcQf3X9+fCBmK+33+5lcav6+pmCNKRnEYzqUx9dARvpUjQf65p4Vx4IA9AlQHaOJ6OwrQ0OsmLYvB/Zan90GcUtLkVmP9qRJfL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f205.google.com with SMTP id 5614622812f47-4a49f09233dso691558b6e.2
        for <gfs2@lists.linux.dev>; Fri, 21 Aug 2026 01:47:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787302072; x=1787906872;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=17i1DjAlI1eKRN4kR7G73skA2928LySzI999roIf94g=;
        b=nQTOvKZXJxfgdfxzf6uEISimmP1F7hwrlDqewT9qc+HCqv3QcGZ02NwfLlXykOeDab
         fDq5o/ZUAuF1fXGpovAzC6NwIHxxrjYme+T2B2LM/2HL7RNps7GE90tZLljklYGTm4v/
         K8F0LfgLs+PtOxG3pwobbaTLrsTsQBN2hmvokPLcURBJHBThcejh//R6cY2xgFiGnP12
         oHit/5ZoOZnKHXMmERwbzd9JVsagK/ZfgDx5X4CjD00WYWmn2Xo2Jj8wHJD79B0+oa1o
         OQ2i0j0TC7+ejQ5PLvSPkcecXmBeaK0rwHylTHNbl4zSEFlkIO0FyTv04C138o44jC8l
         DlJg==
X-Forwarded-Encrypted: i=1; AHgh+Rr3Um6rRFjAMxMYHf/piIbH2v72jPaaUz806qQGj24qd2DLREkdlzE7/8bQTZ/8MOf+i3ek@lists.linux.dev
X-Gm-Message-State: AOJu0Yyq+4tMFpZI05pKhUOPNDO9zETkwhbaZjUZZkYiYhMujd11GYW1
	LuxeHMqMVugw+4AiAsQueoEI4uR875KmyT+s+OO/2Dgtd8Uv6CKUf8xDYNNgVJLqnROR62pQSFI
	IWg/Se8fsD7tl2b0DkdceSAHIUjkBgVxthmW2hW6aTGfwaNo+EhQY8VS+rYM=
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:5242:b0:4ab:2764:1911 with SMTP id
 5614622812f47-4b2ef4570d0mr5290035b6e.19.1787302072388; Fri, 21 Aug 2026
 01:47:52 -0700 (PDT)
Date: Fri, 21 Aug 2026 01:47:52 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a8810b8.ae6ddae5.3da009.002f.GAE@google.com>
Subject: [syzbot] [gfs2?] WARNING in dlm_lowcomms_connect_node
From: syzbot <syzbot+d451adc04b34fbabccf2@syzkaller.appspotmail.com>
To: aahringo@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, teigland@redhat.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    21d6ac051080 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=14bbea25580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d1128bc53f2ef7f3
dashboard link: https://syzkaller.appspot.com/bug?extid=d451adc04b34fbabccf2
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/88380e2ddcb9/disk-21d6ac05.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5dba5c2896b7/vmlinux-21d6ac05.xz
kernel image: https://storage.googleapis.com/syzbot-assets/52ac739e37e0/Image-21d6ac05.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d451adc04b34fbabccf2@syzkaller.appspotmail.com

dlm: ls1: dlm_recover 15333067685668308026
------------[ cut here ]------------
WARNING: fs/dlm/lowcomms.c:557 at dlm_lowcomms_connect_node+0x14c/0x1f8 fs/dlm/lowcomms.c:558, CPU#0: dlm_recoverd/4971
Modules linked in:
CPU: 0 UID: 0 PID: 4971 Comm: dlm_recoverd Not tainted syzkaller #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/07/2026
pstate: 83400005 (Nzcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : dlm_lowcomms_connect_node+0x14c/0x1f8 fs/dlm/lowcomms.c:558
lr : __find_con fs/dlm/lowcomms.c:274 [inline]
lr : nodeid2con fs/dlm/lowcomms.c:305 [inline]
lr : dlm_lowcomms_connect_node+0x114/0x1f8 fs/dlm/lowcomms.c:556
sp : ffff8000933b7b20
x29: ffff8000933b7b20 x28: 0000000000000002 x27: 0000000000000001
x26: ffff0000ee849000 x25: ffff0000ef82f480 x24: dfff800000000000
x23: 0000000000000000 x22: ffff80008e8f5c50 x21: 0000000000000002
x20: ffff800088ed2bc0 x19: 0000000000000000 x18: 00000000ffffffff
x17: ffff80008a7d6000 x16: 0000000000000003 x15: ffff80008a35fda0
x14: ffff80008a5d5e28 x13: ffff0000cf590000 x12: ffff0000cf590000
x11: 00000000000000c8 x10: 0000000000000003 x9 : 0000000000000000
x8 : 0000000000000000 x7 : 0000000000000000 x6 : 0000000000000000
x5 : ffff80008aa48520 x4 : 0000000000000004 x3 : 0000000000000001
x2 : ffff80008a468b28 x1 : ffff0000cf590000 x0 : 0000000000000000
Call trace:
 dlm_lowcomms_connect_node+0x14c/0x1f8 fs/dlm/lowcomms.c:558 (P)
 add_remote_member fs/dlm/member.c:313 [inline]
 dlm_add_member fs/dlm/member.c:334 [inline]
 dlm_recover_members+0xe98/0x1c48 fs/dlm/member.c:607
 ls_recover fs/dlm/recoverd.c:151 [inline]
 do_ls_recovery fs/dlm/recoverd.c:360 [inline]
 dlm_recoverd+0x594/0x1d20 fs/dlm/recoverd.c:430
 kthread+0x304/0x3d4 kernel/kthread.c:436
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:838
irq event stamp: 46
hardirqs last  enabled at (45): [<ffff800086930818>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:178 [inline]
hardirqs last  enabled at (45): [<ffff800086930818>] _raw_spin_unlock_irqrestore+0x38/0x98 kernel/locking/spinlock.c:198
hardirqs last disabled at (46): [<ffff80008690b3d0>] el1_brk64+0x20/0x54 arch/arm64/kernel/entry-common.c:445
softirqs last  enabled at (42): [<ffff800080f722fc>] dlm_create_root_list fs/dlm/recoverd.c:72 [inline]
softirqs last  enabled at (42): [<ffff800080f722fc>] ls_recover fs/dlm/recoverd.c:141 [inline]
softirqs last  enabled at (42): [<ffff800080f722fc>] do_ls_recovery fs/dlm/recoverd.c:360 [inline]
softirqs last  enabled at (42): [<ffff800080f722fc>] dlm_recoverd+0x584/0x1d20 fs/dlm/recoverd.c:430
softirqs last disabled at (40): [<ffff800080f721ec>] dlm_create_root_list fs/dlm/recoverd.c:65 [inline]
softirqs last disabled at (40): [<ffff800080f721ec>] ls_recover fs/dlm/recoverd.c:141 [inline]
softirqs last disabled at (40): [<ffff800080f721ec>] do_ls_recovery fs/dlm/recoverd.c:360 [inline]
softirqs last disabled at (40): [<ffff800080f721ec>] dlm_recoverd+0x474/0x1d20 fs/dlm/recoverd.c:430
---[ end trace 0000000000000000 ]---
dlm: ls1: dlm_recover_members error -2
dlm: ls1: do_ls_recovery 15333067685668308026 error -2
dlm: ls1: dlm_recover 15333067685668308027
dlm: ls1: add member 1
dlm: ls1: dlm_recover_members 1 nodes
dlm: ls1: generation 1 slots 1 1:1
dlm: ls1: dlm_recover_directory
dlm: ls1: dlm_recover_directory 0 in 0 new
dlm: ls1: dlm_recover 15333067685668308027 generation 1 done: 10 ms


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
