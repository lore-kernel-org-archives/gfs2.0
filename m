Received: from mail-oa1-f80.google.com (mail-oa1-f80.google.com [209.85.160.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE732298CC4
	for <gfs2@lists.linux.dev>; Thu, 26 Mar 2026 16:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774544313; cv=none; b=C1U966zZMsn8exzoidJ2wHQlV5gmNV47LxMeUG42o1tHj5tXSO0vspehiiurLtANi5tTYSD0h1fQ5VKG0DOHjpZkNnSJFANyctdvEDjPrkeK7raQiLOwaRaOXLcQvb+gdA5l0ZAJ8IA7lIkKwTEXUCxsKqJf0GzjmkwdVz9pLX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774544313; c=relaxed/simple;
	bh=vg+Dsz7kKeFbvLWtAWrE8pPOOW/ro5rw+FfnaAbN+fM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=prcFhWv/HCg7y8HvMTBHOMRmee9z4p2Sza7Ag7Dq/sXq8Nh5W/sx3DJyh4Q6mnxSmhWQnQoz9rnNOFF7X/YBmDm0GA9BVqVjD5XD9HF5ZvhS7wjz+Zp5LNm0dE7ed+C1RoNbjZuMJl1Yu1OsPG0i3VbkFL1dGz/K9EedS9HKI0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f80.google.com with SMTP id 586e51a60fabf-41702ea8343so1777813fac.0
        for <gfs2@lists.linux.dev>; Thu, 26 Mar 2026 09:58:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774544310; x=1775149110;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y4cY7kRHLWfzYTA9mMntgGdoQF2os7HWGtEb9i5vcsM=;
        b=sap9JmZTv8cD7IT7Ht14hgiiGjoOiOl4G8X/ek0Jt0rw2bRPmqCI8EhZQd+LhTE3mi
         9frVySAQwbbiur25qDH77WkoPvlHfVHWFUq8DDKxiOKlIEbTF9hnYovPwGOvdF3gHAsH
         QlMVNfz0gPsLGgwLkcGwNyJn6JgEniC6lz4J57G44KS1KyGbPh8m656R0V3EBfebw9iz
         7AEDcEMRKyW4CNz3DR1xkk6gsuZfdyPxRWXtTVfixgCodh5gyf/VsZ5lGhrvEROCDDin
         OXwrT0aysaRTDcg07x9y5zBAhAXSLDpG+BBeaFI5oN0KFF1gQmkxMGFnx5g0R+pnaqn5
         VFVA==
X-Forwarded-Encrypted: i=1; AJvYcCWKfpy7hSNpgPCnkfuDOvDZN6V3xCsr5pHH5UqhC3Bw5RL60kJcKiVXNnMPPHHg5YWYuLCN@lists.linux.dev
X-Gm-Message-State: AOJu0Yx3nWjNYHQftuLQ8+4b/MBaqNoXos6xYFieuEXpsWyOL7nMNEFc
	GmJrPzFgxmmgUZe6GR8E2CC320dmB4qe/xM74+PsnTxSOvHF9x9bzFrYOExgFfsLpfLXcdrp5yH
	MH44vQrh309OVAj+TnxlsyB2LqLWBsKBGcjSq1ONHW15mUKeOYbae5xK2CUI=
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:81f:b0:67c:1fc7:daa6 with SMTP id
 006d021491bc7-67dff39eedfmr3990964eaf.10.1774544310544; Thu, 26 Mar 2026
 09:58:30 -0700 (PDT)
Date: Thu, 26 Mar 2026 09:58:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69c565b6.a70a0220.3d5e5.000a.GAE@google.com>
Subject: [syzbot] [gfs2?] kernel BUG in gfs2_trans_add_revoke
From: syzbot <syzbot+b17a83b050e9617376f0@syzkaller.appspotmail.com>
To: agruenba@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    785f0eb2f85d Add linux-next specific files for 20260320
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11c08b52580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c584910d0d74158d
dashboard link: https://syzkaller.appspot.com/bug?extid=b17a83b050e9617376f0
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a1f7fd9c1a63/disk-785f0eb2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6c138da87c25/vmlinux-785f0eb2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4d1be64e56db/bzImage-785f0eb2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b17a83b050e9617376f0@syzkaller.appspotmail.com

RBP: 00007ffd277b4f80 R08: 00007ffd277b5f80 R09: 00000000ffffffff
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffd277b6010
R13: 00007fd855832050 R14: 000000000008c299 R15: 00007ffd277b6050
 </TASK>
gfs2: fsid=syz:syz.0: about to withdraw this file system
------------[ cut here ]------------
kernel BUG at fs/gfs2/trans.c:321!
Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
CPU: 1 UID: 0 PID: 9715 Comm: syz-executor Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2026
RIP: 0010:gfs2_trans_add_revoke+0xd1/0xe0 fs/gfs2/trans.c:321
Code: 41 5c 41 5d 41 5e 41 5f c3 cc cc cc cc cc 89 d9 80 e1 07 80 c1 03 38 c1 7c e3 48 89 df e8 d7 80 0a fe eb d9 e8 a0 1a a1 fd 90 <0f> 0b 66 66 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90
RSP: 0018:ffffc90007607998 EFLAGS: 00010293
RAX: ffffffff842536e0 RBX: ffff88802a9439c0 RCX: ffff88802db05b80
RDX: 0000000000000000 RSI: ffff8880346d4070 RDI: ffff88807b910000
RBP: ffff88806a0ac650 R08: ffffffff90123cf7 R09: 1ffffffff202479e
R10: dffffc0000000000 R11: fffffbfff202479f R12: ffff8880346d4088
R13: dffffc0000000000 R14: ffff8880346d4070 R15: ffff88807b910000
FS:  0000555573c27500(0000) GS:ffff888125548000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f1ac2744a90 CR3: 0000000076a06000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 __gfs2_ail_flush+0x12c/0x220 fs/gfs2/glops.c:78
 gfs2_ail_flush+0xbd/0x100 fs/gfs2/glops.c:152
 evict_linked_inode fs/gfs2/super.c:1368 [inline]
 gfs2_evict_inode+0x743/0x1130 fs/gfs2/super.c:1434
 evict+0x61e/0xb10 fs/inode.c:846
 gfs2_evict_inodes fs/gfs2/ops_fstype.c:1760 [inline]
 gfs2_kill_sb+0x2bb/0x430 fs/gfs2/ops_fstype.c:1786
 deactivate_locked_super+0xbc/0x130 fs/super.c:476
 cleanup_mnt+0x437/0x4d0 fs/namespace.c:1312
 task_work_run+0x1d9/0x270 kernel/task_work.c:233
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 __exit_to_user_mode_loop kernel/entry/common.c:67 [inline]
 exit_to_user_mode_loop+0xed/0x480 kernel/entry/common.c:98
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:238 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:269 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:325 [inline]
 do_syscall_64+0x32d/0xf80 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd85579d9d7
Code: a2 c7 05 1c fd 24 00 00 00 00 00 eb 96 e8 e1 12 00 00 90 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 e8 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007ffd277b4ec8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 00007fd855832050 RCX: 00007fd85579d9d7
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007ffd277b4f80
RBP: 00007ffd277b4f80 R08: 00007ffd277b5f80 R09: 00000000ffffffff
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffd277b6010
R13: 00007fd855832050 R14: 000000000008c299 R15: 00007ffd277b6050
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:gfs2_trans_add_revoke+0xd1/0xe0 fs/gfs2/trans.c:321
Code: 41 5c 41 5d 41 5e 41 5f c3 cc cc cc cc cc 89 d9 80 e1 07 80 c1 03 38 c1 7c e3 48 89 df e8 d7 80 0a fe eb d9 e8 a0 1a a1 fd 90 <0f> 0b 66 66 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90
RSP: 0018:ffffc90007607998 EFLAGS: 00010293
RAX: ffffffff842536e0 RBX: ffff88802a9439c0 RCX: ffff88802db05b80
RDX: 0000000000000000 RSI: ffff8880346d4070 RDI: ffff88807b910000
RBP: ffff88806a0ac650 R08: ffffffff90123cf7 R09: 1ffffffff202479e
R10: dffffc0000000000 R11: fffffbfff202479f R12: ffff8880346d4088
R13: dffffc0000000000 R14: ffff8880346d4070 R15: ffff88807b910000
FS:  0000555573c27500(0000) GS:ffff888125548000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f1ac2744a90 CR3: 0000000076a06000 CR4: 00000000003526f0


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
