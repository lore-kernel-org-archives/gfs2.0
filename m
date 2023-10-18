Received: from mail-oi1-f207.google.com (mail-oi1-f207.google.com [209.85.167.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620E6358BD
	for <gfs2@lists.linux.dev>; Wed, 18 Oct 2023 14:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by mail-oi1-f207.google.com with SMTP id 5614622812f47-3b2b1b0d930so8407048b6e.1
        for <gfs2@lists.linux.dev>; Wed, 18 Oct 2023 07:28:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697639280; x=1698244080;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CdMBNL3S2x6JknCQNvPePRN6XZ2zBEfRh1DVc58bPSA=;
        b=uWXRNrE3stjvHaQuNKoK5IiHJJDN9PMLqMTZjpuS7r48/iQTfQ65F73lbmM98eand2
         nFgSQo4D4I7TyFcJZ+Xms/FttplblGPqSRs6ApN2KGs/q0fXaTWeqochS2yyFKGUyjTj
         gBX62CJM/CDZR3yuMFhzry9LxeqcNzDqsY/+72vEARCpop/JU9G15u4wafRzJy26erew
         /UIQcPNaGjSBaWFwNKAA8RBbeBYQvNSem2ofnSmjA1f3vJMrAPbRUQWkGGQ3i66YqT7A
         lCFj7MLLcAn+C0FvQIPwEg03JJ+2JCW7USUHCLk6O+G0PzbzMC6j5CP/OomKieV/alce
         nWtQ==
X-Gm-Message-State: AOJu0YyyxC9M21OgKk1dEPwB9q30BWeksEoUg2bHfzEOSsyRYVqJoy7G
	CEigV5VfTf78XUuOOMR0LrUpfX66aXzg2/jei2ysw9e9Agzn
X-Google-Smtp-Source: AGHT+IH5x77WTQFzLiRumx9QRmlIW1x9csdWG+C9yZ4XNpdGNpfb61NuTSsTMsCGzbBMsDzUBEgm2yxf0y4jfQacuqmDkoK4xRm/
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:219b:b0:3b2:f40e:9493 with SMTP id
 be27-20020a056808219b00b003b2f40e9493mr13347oib.6.1697639280434; Wed, 18 Oct
 2023 07:28:00 -0700 (PDT)
Date: Wed, 18 Oct 2023 07:28:00 -0700
In-Reply-To: <0000000000000c44b0060760bd00@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004467c80607fe72f1@google.com>
Subject: Re: [syzbot] [gfs2?] WARNING: suspicious RCU usage in gfs2_permission
From: syzbot <syzbot+3e5130844b0c0e2b4948@syzkaller.appspotmail.com>
To: agruenba@redhat.com, gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, postmaster@duagon.onmicrosoft.com, 
	rpeterso@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    2dac75696c6d Add linux-next specific files for 20231018
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=13af5fe5680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6f8545e1ef7a2b66
dashboard link: https://syzkaller.appspot.com/bug?extid=3e5130844b0c0e2b4948
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=101c8d09680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11a07475680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2375f16ed327/disk-2dac7569.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c80aee6e2e6c/vmlinux-2dac7569.xz
kernel image: https://storage.googleapis.com/syzbot-assets/664dc23b738d/bzImage-2dac7569.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/5ce278ef6f36/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3e5130844b0c0e2b4948@syzkaller.appspotmail.com

gfs2: fsid=syz:syz.0: first mount done, others may mount
=============================
WARNING: suspicious RCU usage
6.6.0-rc6-next-20231018-syzkaller #0 Not tainted
-----------------------------
fs/gfs2/inode.c:1877 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
no locks held by syz-executor120/5052.

stack backtrace:
CPU: 1 PID: 5052 Comm: syz-executor120 Not tainted 6.6.0-rc6-next-20231018-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x125/0x1b0 lib/dump_stack.c:106
 lockdep_rcu_suspicious+0x20c/0x3b0 kernel/locking/lockdep.c:6711
 gfs2_permission+0x3f9/0x4c0 fs/gfs2/inode.c:1877
 do_inode_permission fs/namei.c:462 [inline]
 inode_permission fs/namei.c:529 [inline]
 inode_permission+0x384/0x5e0 fs/namei.c:504
 may_open+0x11c/0x400 fs/namei.c:3249
 do_open fs/namei.c:3619 [inline]
 path_openat+0x17aa/0x2ce0 fs/namei.c:3778
 do_filp_open+0x1de/0x430 fs/namei.c:3808
 do_sys_openat2+0x176/0x1e0 fs/open.c:1440
 do_sys_open fs/open.c:1455 [inline]
 __do_sys_openat fs/open.c:1471 [inline]
 __se_sys_openat fs/open.c:1466 [inline]
 __x64_sys_openat+0x175/0x210 fs/open.c:1466
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f5b23a31a11
Code: 75 57 89 f0 25 00 00 41 00 3d 00 00 41 00 74 49 80 3d 7a 06 0b 00 00 74 6d 89 da 48 89 ee bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 93 00 00 00 48 8b 54 24 28 64 48 2b 14 25
RSP: 002b:00007ffe9ecd33a0 EFLAGS: 00000202 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000010000 RCX: 00007f5b23a31a11
RDX: 0000000000010000 RSI: 0000000020037f80 RDI: 00000000ffffff9c
RBP: 0000000020037f80 R08: 00007ffe9ecd3470 R09: 0000000000037f13
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000000
R13: 00007ffe9ecd3470 R14: 0000000000000003 R15: 0000000001000000
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
