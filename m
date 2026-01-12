Received: from mail-oa1-f78.google.com (mail-oa1-f78.google.com [209.85.160.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE43322B8B
	for <gfs2@lists.linux.dev>; Mon, 12 Jan 2026 15:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768232970; cv=none; b=nOK6GwliCZTgRg0/BJcIsjggeddmKdr9dEJAPpevl4+ARwz6o5Ms41OaGx35YgTkdVvieQPeFW3OOFD5lNtws/8Gguz0Z9v0nhhqW2RrYNm2yf5oaIsVwaMYgXPjuMePWU8AMN3eRI3JTJCILFwK+ykX12/Y6SII5VME6/0vArg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768232970; c=relaxed/simple;
	bh=GdnoJe5LXqiAB0UkbWsnh+niHS7njJFVB1OaAKi271k=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=nuPTDWgAeZRFAtTlEDwvATzT2/40Mj7AuoqrR59olTumyQhMZ4ViowfN5rihvyztmIhGrKlTw6hVp/kx1u+cz0E61r37vO3ljeZRrANvta9vClm/qUSG9pLjhL/MvIKQZmq0vm5P9jslJkvYW9PlUvhtniKyEsV3kkqFZJ+sMdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f78.google.com with SMTP id 586e51a60fabf-3fda5f60035so11961869fac.0
        for <gfs2@lists.linux.dev>; Mon, 12 Jan 2026 07:49:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768232968; x=1768837768;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QsLaALc9MteT9gyHUpO9MJnDbv4so+PXtA5FesndbBs=;
        b=IBs9MeYS4LM/dDDm8lz0WnTn8La98zPj/ir+9l5gQZqAVsjSzkGgDqH9yU+15937+l
         CKpuUT3ADxp07FfWpcX/mRfRAPhO5oQJqxaC9LQ9yYuRX1+uxZ3G/dhQhpkeYtOikz2L
         29bk0ld3At7Bk21ZNy2BsTUE01ogLcinx34Q9knKKVN/cmIfEdgJySDR4qxdDUQBNQf/
         AQTlbNAz9WTNn8O59YYKn/dwdNouVWXdWSGqdBadciMkfy48MMVJd3hK05DkKkogNd7z
         fhHmb81ku2QTR+ncGiv24It8D0TPr001nH1AQcXNz3tS9meFg64D7YJpOysiTOo1GqMh
         99Jg==
X-Forwarded-Encrypted: i=1; AJvYcCWBoZlvZt2Rke1CR7Ut5Mnkrp3jY9PXkhAdDhwUqRZ0iAeYrjD4lYfHw6eMBTHC91FykaeT@lists.linux.dev
X-Gm-Message-State: AOJu0YwNsMNqxrDhL4P1eD8gSVZ8J23XVzvFzPAM9DLlwnHfZloHAVfZ
	zuvTqjD34Lu8t5+AN23ymmUxipOpNffLjK2MTZL6JAJqxFwKVVdQOu09K8vrDgDlu606ugxvNkl
	c8SXs7lrlYBpQu+fDFYWXJ9i7B0kEAWjKSlDbX0ZMIQNMYDSXCNw0esxpAok=
X-Google-Smtp-Source: AGHT+IHaHEzOHcVoSRf/0Lc/a6qkBzjQQrUQBxYmBZmCXuuQ4EiQjU0rhkUaJddBXr4wmFxeLknsLDGeRKwKjlFVPGDcvLJxgv6T
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1501:b0:659:9a49:8e76 with SMTP id
 006d021491bc7-65f5507e732mr8757216eaf.70.1768232967920; Mon, 12 Jan 2026
 07:49:27 -0800 (PST)
Date: Mon, 12 Jan 2026 07:49:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69651807.050a0220.eaf7.00b2.GAE@google.com>
Subject: [syzbot] [gfs2?] WARNING in rgblk_free (2)
From: syzbot <syzbot+3e2c95229d1ab81a0bfd@syzkaller.appspotmail.com>
To: agruenba@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    54e82e93ca93 Merge tag 'core_urgent_for_v6.19_rc4' of git:..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1216e5fa580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=513255d80ab78f2b
dashboard link: https://syzkaller.appspot.com/bug?extid=3e2c95229d1ab81a0bfd
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11b4bc3a580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1015b922580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-54e82e93.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f3befb5f53a4/vmlinux-54e82e93.xz
kernel image: https://storage.googleapis.com/syzbot-assets/92820ca1dbd8/bzImage-54e82e93.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/074df7c33445/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=10da39fc580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3e2c95229d1ab81a0bfd@syzkaller.appspotmail.com

gfs2: fsid=syz:syz.0: first mount done, others may mount
gfs2: fsid=syz:syz.0: found 1 quota changes
------------[ cut here ]------------
WARNING: fs/gfs2/rgrp.c:2267 at rgblk_free+0x136/0x750 fs/gfs2/rgrp.c:2267, CPU#0: syz.0.17/5483
Modules linked in:
CPU: 0 UID: 0 PID: 5483 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:rgblk_free+0x136/0x750 fs/gfs2/rgrp.c:2267
Code: c0 0f 85 fe 05 00 00 45 8b 36 44 89 f7 44 89 e6 e8 cf 42 b9 fd 45 39 e6 76 2e e8 05 41 b9 fd e9 89 00 00 00 e8 fb 40 b9 fd 90 <0f> 0b 65 48 8b 05 b0 f9 78 0e 48 3b 84 24 80 00 00 00 0f 85 a0 05
RSP: 0018:ffffc90002797a80 EFLAGS: 00010293
RAX: ffffffff8407c5a6 RBX: ffff88801fce7000 RCX: ffff888000634980
RDX: 0000000000000000 RSI: 0000000000000927 RDI: 0000000025540013
RBP: ffff88801fce7000 R08: ffffffff8f824677 R09: 1ffffffff1f048ce
R10: dffffc0000000000 R11: fffffbfff1f048cf R12: 0000000000000927
R13: 0000000000000001 R14: 0000000025540013 R15: dffffc0000000000
FS:  000055556242d500(0000) GS:ffff88808d414000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000011b5f000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 gfs2_unlink_di+0x296/0x420 fs/gfs2/rgrp.c:2566
 gfs2_unlink_inode+0x11d/0x180 fs/gfs2/inode.c:1226
 gfs2_unlink+0x448/0x550 fs/gfs2/inode.c:1298
 vfs_rmdir+0x512/0x660 fs/namei.c:5236
 do_rmdir+0x27f/0x4a0 fs/namei.c:5291
 __do_sys_rmdir fs/namei.c:5315 [inline]
 __se_sys_rmdir fs/namei.c:5313 [inline]
 __x64_sys_rmdir+0x47/0x50 fs/namei.c:5313
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xec/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fbfb358f7c9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc4142d868 EFLAGS: 00000246 ORIG_RAX: 0000000000000054
RAX: ffffffffffffffda RBX: 00007fbfb37e5fa0 RCX: 00007fbfb358f7c9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000200000000100
RBP: 00007fbfb3613f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fbfb37e5fa0 R14: 00007fbfb37e5fa0 R15: 0000000000000001
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
