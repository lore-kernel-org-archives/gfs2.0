Received: from mail-ot1-f80.google.com (mail-ot1-f80.google.com [209.85.210.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17308225A6
	for <gfs2@lists.linux.dev>; Tue, 10 Oct 2023 18:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by mail-ot1-f80.google.com with SMTP id 46e09a7af769-6c70e93400bso7902747a34.0
        for <gfs2@lists.linux.dev>; Tue, 10 Oct 2023 11:18:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696961930; x=1697566730;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YOOMP7bibDVlN4m76sArU8HLcCMvoN1FZfn53nyMP0g=;
        b=tnPfPqvpfp4WppMpkKGVHQp6TmHE6FYJ/1FNmMP4aZJxRWRrLVLrQWMKGeJ/AoA0K1
         3N3fXGgNeKlIiLnFOlPXrBTKPcr6icZqNSdOvKhdQ+EGoi6c3kj4Ox/0a5zDI/MK8WIY
         xqdgUFqTgjf38pozwLuKBtK6mLjtYgpGUsNSWXD9tBfCnaSPjIcwBzBEehx3+DvikCxS
         ZW3hsCg5V8L7XxtVnkoAa2rmRWP+eD3GWikbzJkU9Vqd+dHEbAL7inzw6QCstvDANkAd
         WuU8Xt7RUyvDM9LFunUvN5t/Rb7oZ3K15pa2yKGniR9cd7xGSauLTSffN6xbR3BN1LaN
         fGKQ==
X-Gm-Message-State: AOJu0Yw1PwKW8hJ0eAxrbDTaZhNmaHT+CVGhIBfAGzdLBQ2Sawt+y+K1
	dFjdNq2M52ES9QV7BF5ELeXr/SC0reQYn6J17Fs0XH7bH/KK
X-Google-Smtp-Source: AGHT+IGrf5ZcCFwuWMHVkXFkv2Fl5bm0Qb2/foKn8TTf3PhVjWptONsWN+pjSZKVQQHEdvGbHa8NvW73QTnaAemN5SSGOocaFk09
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6830:1142:b0:6c2:10e1:9d6f with SMTP id
 x2-20020a056830114200b006c210e19d6fmr5854168otq.6.1696961930214; Tue, 10 Oct
 2023 11:18:50 -0700 (PDT)
Date: Tue, 10 Oct 2023 11:18:50 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000c44b0060760bd00@google.com>
Subject: [syzbot] [gfs2?] WARNING: suspicious RCU usage in gfs2_permission
From: syzbot <syzbot+3e5130844b0c0e2b4948@syzkaller.appspotmail.com>
To: agruenba@redhat.com, gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rpeterso@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7d730f1bf6f3 Add linux-next specific files for 20231005
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11dd3679680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f532286be4fff4b5
dashboard link: https://syzkaller.appspot.com/bug?extid=3e5130844b0c0e2b4948
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1d7f28a4398f/disk-7d730f1b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d454d124268e/vmlinux-7d730f1b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/dbca966175cb/bzImage-7d730f1b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3e5130844b0c0e2b4948@syzkaller.appspotmail.com

gfs2: fsid=syz:syz: Now mounting FS (format 1801)...
gfs2: fsid=syz:syz.0: journal 0 mapped with 14 extents in 0ms
gfs2: fsid=syz:syz.0: first mount done, others may mount
=============================
WARNING: suspicious RCU usage
6.6.0-rc4-next-20231005-syzkaller #0 Not tainted
-----------------------------
fs/gfs2/inode.c:1876 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
no locks held by syz-executor.5/5216.

stack backtrace:
CPU: 1 PID: 5216 Comm: syz-executor.5 Not tainted 6.6.0-rc4-next-20231005-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x125/0x1b0 lib/dump_stack.c:106
 lockdep_rcu_suspicious+0x20c/0x3b0 kernel/locking/lockdep.c:6711
 gfs2_permission+0x3f9/0x4c0 fs/gfs2/inode.c:1876
 do_inode_permission fs/namei.c:461 [inline]
 inode_permission fs/namei.c:528 [inline]
 inode_permission+0x384/0x5e0 fs/namei.c:503
 may_open+0x11c/0x400 fs/namei.c:3248
 do_open fs/namei.c:3618 [inline]
 path_openat+0x17aa/0x2ce0 fs/namei.c:3777
 do_filp_open+0x1de/0x430 fs/namei.c:3807
 do_sys_openat2+0x176/0x1e0 fs/open.c:1422
 do_sys_open fs/open.c:1437 [inline]
 __do_sys_openat fs/open.c:1453 [inline]
 __se_sys_openat fs/open.c:1448 [inline]
 __x64_sys_openat+0x175/0x210 fs/open.c:1448
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:81
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f916187b6e0
Code: 48 89 44 24 20 75 93 44 89 54 24 0c e8 09 82 02 00 44 8b 54 24 0c 89 da 48 89 ee 41 89 c0 bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 77 38 44 89 c7 89 44 24 0c e8 5c 82 02 00 8b 44
RSP: 002b:00007f916262ce70 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000010000 RCX: 00007f916187b6e0
RDX: 0000000000010000 RSI: 0000000020000140 RDI: 00000000ffffff9c
RBP: 0000000020000140 R08: 0000000000000000 R09: 0000000000000c19
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000020000140
R13: 00007f916262cf40 R14: 00000000000126ad R15: 00000000200129c0
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
