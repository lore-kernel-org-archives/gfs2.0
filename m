Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E772A1BA
	for <gfs2@lists.linux.dev>; Tue, 31 Dec 2024 22:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735683263; cv=none; b=kqpmmrAcXbVgUcPK6zb91OQA29VPs+R9vRWW8Zrhje483+HXHfLiVmgRlr4iVI8eHygJzlj+L0FLr7wdXsS5JNUDrDfkpVnDevBAFPlj4XYF/PUTKJ6octlrK2ooGEsmnQY2XSh5htDtF8UK9S2hI7zSlRnzJUwO5BJB1aDW39A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735683263; c=relaxed/simple;
	bh=f59vzNqGTjBNSfzbgqzHMUl+wJQ/COcx/rfMo1ZnmsY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=U50IgPCSQc8tQPAMw7X3p0RBvYEaD0TolXeVUCh0G9QinvaXcywxNqjSjoM2rGIIvwhInF/kucPXtliWR4dhZk8OggAhk9j+63phgx/bxY+c5H8BINesTxhBWEDRjBbQmQKdPVKM64a6s5Y2OGB1NyHfikhc2TvbDw7GiNIcujE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3ac98b49e4dso95669735ab.1
        for <gfs2@lists.linux.dev>; Tue, 31 Dec 2024 14:14:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735683261; x=1736288061;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lqvz4l34FIkSyHVMSSfKXW8ufbeHEIvLxRZ4h6bbjJE=;
        b=VxQbTvOW2WQGECK4mm0Z03gWn2fLxZVStfHvcnoTYV1FuF3Ui+VazQeRUH+bK7BWkZ
         PM1a/goPqmxCGt2iaCahAgTCHkMbdfRKFoa86t7YIIsgxV+y7WZqTzzzPx2YF5yVF72b
         FJ2oLi0/bXfI/1k7uiI2R1CibU2ndnP0qoPCV/Off/xYIx1MzQ7JQ24jbf4O/b0VVZVy
         Sl3Bc3Nb6rfgdRPTpmc/14wxmma6iKD6m8vh323fZsNGYVd86IjWGfDyXDPM8mWX/6uO
         npcnX2WfSJuYhOEZ4O4o7Z/eD/0GWUhfmO+h+xpAIiJFhX9S4e1xz2p54NOVglALxvWm
         Aqlg==
X-Forwarded-Encrypted: i=1; AJvYcCXkNWl8EdYTP8Sw2zRoC1yVfevF86Vwdr+ldkeFUlvZUazMHh90NYYvAvuozdQlM4vif8jD@lists.linux.dev
X-Gm-Message-State: AOJu0Yzc1dzUqMIJLbtDZ7vm8CJKp8XMKXJ36gKK7ie99imP4Ag4eGVR
	gWONbJ0IOdBs6UAvC7F4DravgNeM3PL/TlcAONpV+FvNxMQlXdw9g3MCSJZyXuU8alZ/FZSFonu
	KPdqKdTUyJWl2cpk+8QcrAvaxVukhzDRbzJ8uL4SwdEhkxIsR3Oh//aU=
X-Google-Smtp-Source: AGHT+IF4k2Bpd5oOM1qvWU9hAQNrUPO9u6HqTSBVDBkwb5XLP+ts6e+ey0Ctn5AH/jKTqhwnTVofriFS2zMb76nC9dTTOkDItTKt
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a44:b0:3a7:6c5c:9aa4 with SMTP id
 e9e14a558f8ab-3c2d2783632mr298228355ab.12.1735683260902; Tue, 31 Dec 2024
 14:14:20 -0800 (PST)
Date: Tue, 31 Dec 2024 14:14:20 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67746cbc.050a0220.25abdd.0951.GAE@google.com>
Subject: [syzbot] [gfs2?] UBSAN: shift-out-of-bounds in gfs2_dir_read
From: syzbot <syzbot+8f27157166450172d406@syzkaller.appspotmail.com>
To: agruenba@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8379578b11d5 Merge tag 'for-v6.13-rc' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10917adf980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d269ef41b9262400
dashboard link: https://syzkaller.appspot.com/bug?extid=8f27157166450172d406
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-8379578b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/46152cb37ce6/vmlinux-8379578b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b14facfd62b8/bzImage-8379578b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8f27157166450172d406@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 32768
gfs2: fsid=syz:syz: Trying to join cluster "lock_nolock", "syz:syz"
gfs2: fsid=syz:syz: Now mounting FS (format 1801)...
gfs2: fsid=syz:syz.0: journal 0 mapped with 1 extents in 0ms
gfs2: fsid=syz:syz.0: first mount done, others may mount
------------[ cut here ]------------
UBSAN: shift-out-of-bounds in fs/gfs2/dir.c:1544:15
shift exponent 32 is too large for 32-bit type 'u32' (aka 'unsigned int')
CPU: 0 UID: 0 PID: 5323 Comm: syz.0.0 Not tainted 6.13.0-rc4-syzkaller-00069-g8379578b11d5 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 ubsan_epilogue lib/ubsan.c:231 [inline]
 __ubsan_handle_shift_out_of_bounds+0x3c8/0x420 lib/ubsan.c:468
 dir_e_read fs/gfs2/dir.c:1544 [inline]
 gfs2_dir_read+0x1a50/0x1af0 fs/gfs2/dir.c:1585
 gfs2_readdir+0x14b/0x1b0 fs/gfs2/file.c:116
 iterate_dir+0x571/0x800 fs/readdir.c:108
 __do_sys_getdents64 fs/readdir.c:403 [inline]
 __se_sys_getdents64+0x1e2/0x4b0 fs/readdir.c:389
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f60b3185d29
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f60b3f65038 EFLAGS: 00000246 ORIG_RAX: 00000000000000d9
RAX: ffffffffffffffda RBX: 00007f60b3375fa0 RCX: 00007f60b3185d29
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000005
RBP: 00007f60b3201b08 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f60b3375fa0 R15: 00007fffa2e8df68
 </TASK>
---[ end trace ]---


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
