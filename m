Received: from mail-oi1-f208.google.com (mail-oi1-f208.google.com [209.85.167.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6AC449B29
	for <gfs2@lists.linux.dev>; Fri, 31 Jul 2026 17:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785518074; cv=none; b=RTevQGQ+VEybXeYqbE9xktRWYII3irgeHybkx2iGuIcu6LzfVUHm6dUDpljryMq7a6GMHC98xuR6Uyz+Z7v4jOAo/RCfmuW8xUDjblQlaB+gSW35RY+Bta21sAC3hvq06eoJn9lEwJmjCMUv43bYm8sr9rP9tUOxlou3wuXUKME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785518074; c=relaxed/simple;
	bh=hnlKnsrIMGRxavFKBceHDuGhYvRRGhbLnXMNEd0OrBM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=IMXRHoDyAY1MRiEtGK0W3utDeKL2rSutkJb7UBYeVWubni7sa+xGCYuLO9u8ZaOXhZ3GNfIDO+T9A/PLfBkqXKJ70s4QK9YaEGHhcqrMlmbH5XRgVtKbYDGFHgyFX/gGv4WTqwFFTJ4WehlLpmhQNmGGzWdsravXAbHJSjr13QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f208.google.com with SMTP id 5614622812f47-4ab4f78b9f4so1517878b6e.2
        for <gfs2@lists.linux.dev>; Fri, 31 Jul 2026 10:14:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785518071; x=1786122871;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y/64JuiEqi94j506cuIciDVsPEU8nZBUvLfJTByWCl4=;
        b=NMVK3GVpjc+rNNbajb+2UN2isuMON1zuugEiYkgDUrnRTmhJN0Di8IAdowGaXlSBwD
         6yWe3qe04RYLwPfjISCprIdL0CPOnwSJi7vma7qJB7ZLcPyK8qdjfFmVJ/QrpH6tPaS4
         KNyj5f2ZFl8vzQDm+oOCvzjZvmUo6YA23xVOIcN8HAwpVhzkOjr2bMlFblcDadvT95wj
         97fZEKdhOTnImDY4Rw22RUgW+a1k7teMqidKe0SK1UXjSmXEWVyGHwvA4SB79w1lY4ug
         PIJb9cTR/pOYFbO9Y+tKDvAsfwpCFxtQu+AVNmx+cjQEDkTpcbppV3OGCavRs+a8Alwu
         UYgg==
X-Forwarded-Encrypted: i=1; AHgh+Rr/zhVvINULJZvRS7PTLhvNh1HJyAQRGAEgD5rKH3JWbSnQVzws3ClqFGBgjFOfUxYNbR6v@lists.linux.dev
X-Gm-Message-State: AOJu0YyzHS4xxXC7rAQ9jl+VzmeoIzvOkMLH8u3ay2wK7OMREtyXLd3q
	7ytGkundotDqLjhQRWj1B5cOaoBpcwtpoVV6kdzqQTrYz2ur/1CbarUtQGJwAlapAYeqBy4iEKN
	QAQdEatPFV9CqoG2NVS6lQpqyeYb3D/xgQCPtBNXxaRA3Id7xtWIvkNLTJ7o=
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1247:b0:496:9b3:486 with SMTP id
 5614622812f47-4af5e2fc1b2mr1287674b6e.14.1785518071042; Fri, 31 Jul 2026
 10:14:31 -0700 (PDT)
Date: Fri, 31 Jul 2026 10:14:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a6cd7f7.2d659fcc.1d46f5.019a.GAE@google.com>
Subject: [syzbot] [gfs2?] WARNING in dlm_lowcomms_close
From: syzbot <syzbot+04dfbd15d442517e713a@syzkaller.appspotmail.com>
To: aahringo@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, teigland@redhat.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3708dd948844 Merge tag 'pm-7.2-rc6' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12b1caea580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=145fa60d73086782
dashboard link: https://syzkaller.appspot.com/bug?extid=04dfbd15d442517e713a
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1020a5b9580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13057a49580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-3708dd94.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/57f69e2a6e3b/vmlinux-3708dd94.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3511d4246fb6/bzImage-3708dd94.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+04dfbd15d442517e713a@syzkaller.appspotmail.com

dlm: closing connection to node 1
------------[ cut here ]------------
!con
WARNING: fs/dlm/lowcomms.c:1455 at dlm_lowcomms_close+0x3d/0x21b fs/dlm/lowcomms.c:1455, CPU#1: syz.0.18/5929
Modules linked in:
CPU: 1 UID: 0 PID: 5929 Comm: syz.0.18 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:dlm_lowcomms_close+0x3d/0x21b fs/dlm/lowcomms.c:1455
Code: 89 ee 48 c7 c7 00 eb eb 8b e8 8f 61 fc ff e8 da f8 ff ff 31 f6 89 ef 41 89 c4 e8 9e 0f a1 01 48 85 c0 75 1b e8 d4 77 e4 00 90 <0f> 0b 90 44 89 e7 bb fe ff ff ff e8 43 f8 ff ff e9 b5 01 00 00 48
RSP: 0018:ffffc9000383fbd8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff82c6f9c4
RDX: ffff888033a52540 RSI: ffffffff8125e92c RDI: ffff888033a52540
RBP: 0000000000000001 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
R13: 0000000000000001 R14: ffffed1005244e10 R15: 0000000000000001
FS:  0000555565d9e500(0000) GS:ffff8880d5eda000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b33163fff CR3: 000000002cf16000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 dlm_midcomms_close+0x312/0x590 fs/dlm/midcomms.c:1443
 drop_comm+0x62/0x1a0 fs/dlm/config.c:556
 client_drop_item+0xa6/0x100 fs/configfs/dir.c:970
 configfs_rmdir+0x5d3/0x950 fs/configfs/dir.c:1567
 vfs_rmdir fs/namei.c:5381 [inline]
 vfs_rmdir+0x328/0x8a0 fs/namei.c:5354
 filename_rmdir+0x31a/0x5c0 fs/namei.c:5438
 __do_sys_rmdir fs/namei.c:5461 [inline]
 __se_sys_rmdir fs/namei.c:5458 [inline]
 __x64_sys_rmdir+0x46/0x70 fs/namei.c:5458
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa842f9e019
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc8c738bb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000054
RAX: ffffffffffffffda RBX: 00007fa843225fa0 RCX: 00007fa842f9e019
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000200000000040
RBP: 00007fa84303500c R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fa843225fac R14: 00007fa843225fa0 R15: 00007fa843225fa0
 </TASK>


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
