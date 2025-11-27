Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E6F27874F
	for <gfs2@lists.linux.dev>; Thu, 27 Nov 2025 17:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764265232; cv=none; b=Fm81ZzYpDjUkhufwYSEFgZLLBCKHNTdyLS3D6xmB0KanqRlLO/9P7Sv3s6pO1aMxhvGWJKdFQmJu/CRdV4Tptu0ImD4WqAdUUSpp7f2/jvm32y5C68d5QknVOwqJNZTTWupDRkX2jIsHtCooZP6c6bFTywIowJRJTkEp9xRp8FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764265232; c=relaxed/simple;
	bh=ZqtJnpsRUXUfJfK82U0YxO1B2Eg77OAmsoFUnzjOIRU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=DGwGqeUyb3+XEvr1WEpKzFOJGbRgCw6mbSuiYj4iO7FVi/3ohnQvdkCz9f+fJI8sum+2BXSstQ5XUX67wp7H7Dx+I2qhOxi2polgsDQYQ8DqgoLL0UiuNpVNe6Ao7pTAMiGh331BPERniC191/kVIOJdY8Y/5nKZuMq9t4fQcTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-43373c85296so7358005ab.2
        for <gfs2@lists.linux.dev>; Thu, 27 Nov 2025 09:40:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764265230; x=1764870030;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Psq9rzD7koIid/gpPFrdtRJyjvj0jQlokI3aS8kzQuQ=;
        b=tWF7iIy2ZsiMC70fmaUXb4MrofHSgNq0b/VkZ9UYpfxncgPc6rddVBzoTdsaQfKmVO
         xyO0LtWbN2V3K9VW9NtC6+N6B6ieL7YCkk2gt7yMcmgTu8iO2Zc9c/K/c02VDUYXvsmC
         cC+7yQ3Fhg6zyfsFraLZEEungt3UPewq9Mef+/rKQWvKRim47q8VFec2l7dTwfe9yAfF
         Nqbw8+b8OoyX7gAgR+1Hj4/CJOAkCVotwfvceErgDLqWP1WEPFl+IU+B3BzQUyuaHH22
         iBBbsLeA38Q9cViHV1HRDACPKfHGq0pLDWG1dj3LBH4IDATodK+6ECNhQTSktG5gYPzb
         Qtaw==
X-Forwarded-Encrypted: i=1; AJvYcCXmHOMfPg2ECl7CNz9WtyxHgf4lZ22snokJsaIUZj8cp1/9SZu1HqNRQWeat3i9ZZsqLm+7@lists.linux.dev
X-Gm-Message-State: AOJu0YyD0KoG2NR4Ft14wthU1TXgrXkTZZpAhwX0SFcj/Znqni108BWs
	LXye3R/t/v5LSWJSZKz2kAimcge0QkapOtvvB7dt7P8P8J7QsSPpMQ662a/qXQ/qBWKTp2gkdDy
	kCd+SINiFLARwt//kBqo1G4LBHYSOBIIqgXADunUMOtlZY6HSSDe9YwmMraw=
X-Google-Smtp-Source: AGHT+IHR/XuGrIym3+iyXRhGGqkvMcaJuWz7ww1dNnqVn38OVS9Iatze8S4XZWdTuj18aQpC2SBq+yRpnLtKGzu0hrwIsH5bQ90Q
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a84:b0:433:7b4f:f8bb with SMTP id
 e9e14a558f8ab-435dd0de6e2mr82529275ab.20.1764265230195; Thu, 27 Nov 2025
 09:40:30 -0800 (PST)
Date: Thu, 27 Nov 2025 09:40:30 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69288d0e.a70a0220.d98e3.010c.GAE@google.com>
Subject: [syzbot] [gfs2?] kernel BUG in gfs2_quota_cleanup (3)
From: syzbot <syzbot+af4d53576692f8956fd6@syzkaller.appspotmail.com>
To: agruenba@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d724c6f85e80 Add linux-next specific files for 20251121
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=109dce92580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=68d11c703cf8e4a0
dashboard link: https://syzkaller.appspot.com/bug?extid=af4d53576692f8956fd6
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=178c797c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11b03612580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0ccfc806f65a/disk-d724c6f8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c2ec31ffb05e/vmlinux-d724c6f8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c25d9c0c1917/bzImage-d724c6f8.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/a4debf5b02b8/mount_1.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=10814612580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+af4d53576692f8956fd6@syzkaller.appspotmail.com

RBP: 00002000000003c0 R08: 00007fff7a4b9a50 R09: 000000000126a4b5
R10: 000000000126a4b5 R11: 0000000000000246 R12: 0000200000000340
R13: 00007fff7a4b9a10 R14: 0000000000000000 R15: 0000200000004140
 </TASK>
gfs2: fsid=syz:syz.0: about to withdraw this file system
------------[ cut here ]------------
kernel BUG at fs/gfs2/quota.c:1520!
Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
CPU: 1 UID: 0 PID: 6305 Comm: syz.2.77 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
RIP: 0010:gfs2_quota_cleanup+0x6ee/0x6f0 fs/gfs2/quota.c:1519
Code: ff 44 89 f1 80 e1 07 80 c1 03 38 c1 0f 8c c2 fd ff ff 4c 89 f7 e8 82 79 21 fe e9 b5 fd ff ff e8 58 d4 54 07 e8 a3 dd ba fd 90 <0f> 0b 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 40 d6
RSP: 0018:ffffc9000493fa40 EFLAGS: 00010293
RAX: ffffffff8406fbcd RBX: 0000000000000002 RCX: ffff88801e703d00
RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000000
RBP: ffffc9000493fb50 R08: ffff88807aa440af R09: 1ffff1100f548815
R10: dffffc0000000000 R11: ffffed100f548816 R12: 1ffff92000927f4c
R13: ffff88802fe9d000 R14: dffffc0000000000 R15: 0000000000000000
FS:  000055557fefd500(0000) GS:ffff888125fba000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555573bca808 CR3: 0000000075f56000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 gfs2_make_fs_ro+0x27a/0x300 fs/gfs2/super.c:566
 gfs2_reconfigure+0x6a3/0xb20 fs/gfs2/ops_fstype.c:1594
 reconfigure_super+0x227/0x890 fs/super.c:1077
 do_remount fs/namespace.c:3286 [inline]
 path_mount+0xd29/0xff0 fs/namespace.c:4036
 do_mount fs/namespace.c:4057 [inline]
 __do_sys_mount fs/namespace.c:4246 [inline]
 __se_sys_mount+0x313/0x410 fs/namespace.c:4223
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f9ca3d90eea
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff7a4b99c8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fff7a4b9a50 RCX: 00007f9ca3d90eea
RDX: 00002000000003c0 RSI: 0000200000000340 RDI: 0000000000000000
RBP: 00002000000003c0 R08: 00007fff7a4b9a50 R09: 000000000126a4b5
R10: 000000000126a4b5 R11: 0000000000000246 R12: 0000200000000340
R13: 00007fff7a4b9a10 R14: 0000000000000000 R15: 0000200000004140
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:gfs2_quota_cleanup+0x6ee/0x6f0 fs/gfs2/quota.c:1519
Code: ff 44 89 f1 80 e1 07 80 c1 03 38 c1 0f 8c c2 fd ff ff 4c 89 f7 e8 82 79 21 fe e9 b5 fd ff ff e8 58 d4 54 07 e8 a3 dd ba fd 90 <0f> 0b 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 40 d6
RSP: 0018:ffffc9000493fa40 EFLAGS: 00010293
RAX: ffffffff8406fbcd RBX: 0000000000000002 RCX: ffff88801e703d00
RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000000
RBP: ffffc9000493fb50 R08: ffff88807aa440af R09: 1ffff1100f548815
R10: dffffc0000000000 R11: ffffed100f548816 R12: 1ffff92000927f4c
R13: ffff88802fe9d000 R14: dffffc0000000000 R15: 0000000000000000
FS:  000055557fefd500(0000) GS:ffff888125eba000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f8a64ae2000 CR3: 0000000075f56000 CR4: 00000000003526f0


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
