Received: from mail-ot1-f80.google.com (mail-ot1-f80.google.com [209.85.210.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEABF3563FD
	for <gfs2@lists.linux.dev>; Tue, 27 Jan 2026 13:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769519971; cv=none; b=bXXSt8d4AVA/s6m6ZG9FSlTa102+lcVfBvu57M4Ca42KFRn8n6fVzRc0s8glL5eFKFK7aBmMgwPJ6vpQVpFbTE3M0+12URk8iSj9OA4vUVYLW+E17yfiwVjJOhqym4+GTGnC1mRX8Yr4SL+hcg7b6hW00FkTZyfUacPQzyBx7ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769519971; c=relaxed/simple;
	bh=KNLsNLV3Cro4K+q+f8dhzOUX4pkQtR+69Gzmh9INQP4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=gDN5xDP2Hz015nX1I2VT++kb/Nkuu3bi1gcK24VTItf1rhJMBORAjUXxI5bbDzPo5yK9q3RJRmDsLKZTUiOb1shP8h1Rsr+msuaOU/SxVqqIcjjrCoggXqM2+YoJaO8Ccd1TwYsYC3WAD1BWcLopg9xMapwWXjXZuJPzObfNyXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f80.google.com with SMTP id 46e09a7af769-7cfcc8890d2so16514996a34.0
        for <gfs2@lists.linux.dev>; Tue, 27 Jan 2026 05:19:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769519968; x=1770124768;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Y6jEW4jTKBlGOMOST6LwMdxKcZ3mIoPQNSnrjzF+mA=;
        b=svyFPTY1NRS3z/a3KcSmv2WUdloqB+QeBcWzZHGGVDyBUjQ99kWMP6kM/yvKE/jZAh
         1qpjj6RFcw9VIHoI9HBbC3jlp10YE2uqMnFzt6Xyh8a+3nVyFSw+nkfTgh2Zh1ye0w+i
         PUZWWQqH15mtQtB42UbSZH8Ka8MVb/jV2VPYPUGMdyRf3ozjiBK7FPQP9AAAQxFRZY4f
         L8xEZEk9WbYX8IdzLD4tiDG62fJSPGr6SxIMB7olpGoLGm/7IyTU98Cr2J9hNS5/DK+M
         DE125pWmaxlxCXrwEI4FvpY0StEHLb/FrMtS0s2XWF1hm+uBVV8oqdTH7JUQ0U0UTrbG
         6Ttg==
X-Forwarded-Encrypted: i=1; AJvYcCXsxSnmrVXi7U5S8JSO21oVUqWLkASdGrH1L0Cmh1klCKgXAVPVh/vFusWf60ss8Hy54NFk@lists.linux.dev
X-Gm-Message-State: AOJu0YyyKQmvuUZDqqyFiM35700QG1xlbLcZaXkdkPpIDufC0XKsHPsV
	h1pXPczRN/jE3BfLs/Bv3scmxs7ZcqecdKuEAbMBZZwTxLpITRFmfDJMNrANjlk3t9o9kpE5FYO
	4bSyu25/c8wMftZcDVFhA1HNEtpBsyX08Zbue1fN5GEqJw96RcrpWocQHauw=
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:602:b0:661:1c46:46b8 with SMTP id
 006d021491bc7-662f203a5famr1157973eaf.6.1769519968496; Tue, 27 Jan 2026
 05:19:28 -0800 (PST)
Date: Tue, 27 Jan 2026 05:19:28 -0800
In-Reply-To: <693b73ba.a70a0220.33cd7b.0044.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6978bb60.050a0220.c9109.001c.GAE@google.com>
Subject: Re: [syzbot] [gfs2?] general protection fault in gfs2_remove_from_journal
 (2)
From: syzbot <syzbot+cff8e1b82d7911dd051c@syzkaller.appspotmail.com>
To: agruenba@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    fcb70a56f4d8 Merge tag 'vfs-6.19-rc8.fixes' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11e3432a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4aae00ac5a9d2645
dashboard link: https://syzkaller.appspot.com/bug?extid=cff8e1b82d7911dd051c
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15a87d2a580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10050988580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-fcb70a56.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d1800162cc24/vmlinux-fcb70a56.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a90ccad4f274/bzImage-fcb70a56.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/039b62a3a6da/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=13cb8c52580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cff8e1b82d7911dd051c@syzkaller.appspotmail.com

RBP: 00007ffdcb694960 R08: 00007ffdcb695960 R09: 00000000ffffffff
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffdcb6959f0
R13: 00007f9bb640471f R14: 000000000001c700 R15: 00007ffdcb695a30
 </TASK>
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000005: 0000 [#1] SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000028-0x000000000000002f]
CPU: 0 UID: 0 PID: 5454 Comm: syz-executor Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:gfs2_remove_from_journal+0x3bb/0x6b0 fs/gfs2/meta_io.c:356
Code: 3a 4c 89 e7 e8 06 aa 1a fe eb 30 e8 2f d0 b0 fd 48 8b 6c 24 10 4c 8d 65 2c 4c 89 e0 48 c1 e8 03 49 be 00 00 00 00 00 fc ff df <42> 0f b6 04 30 84 c0 4c 8b 3c 24 0f 85 9d 01 00 00 41 ff 04 24 48
RSP: 0018:ffffc900029f7510 EFLAGS: 00010207
RAX: 0000000000000005 RBX: ffff8880476e93a0 RCX: ffff88800094a4c0
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000001
RBP: 0000000000000000 R08: ffff8880121fccff R09: 1ffff1100243f99f
R10: dffffc0000000000 R11: ffffed100243f9a0 R12: 000000000000002c
R13: 0000000000000001 R14: dffffc0000000000 R15: ffff888041d9a170
FS:  000055558f4ef500(0000) GS:ffff88808ccea000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f6bd52346c8 CR3: 00000000455fc000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 gfs2_discard fs/gfs2/aops.c:593 [inline]
 gfs2_invalidate_folio+0x579/0x750 fs/gfs2/aops.c:627
 folio_invalidate mm/truncate.c:140 [inline]
 truncate_cleanup_folio+0xcb/0x190 mm/truncate.c:160
 truncate_inode_pages_range+0x2ce/0xe30 mm/truncate.c:404
 gfs2_evict_inode+0x324/0x1050 fs/gfs2/super.c:1426
 evict+0x61e/0xb10 fs/inode.c:837
 gfs2_put_super+0x355/0x860 fs/gfs2/super.c:617
 generic_shutdown_super+0x135/0x2c0 fs/super.c:643
 kill_block_super+0x44/0x90 fs/super.c:1722
 deactivate_locked_super+0xbc/0x130 fs/super.c:474
 cleanup_mnt+0x437/0x4d0 fs/namespace.c:1318
 task_work_run+0x1d9/0x270 kernel/task_work.c:233
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 __exit_to_user_mode_loop kernel/entry/common.c:44 [inline]
 exit_to_user_mode_loop+0xed/0x480 kernel/entry/common.c:75
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:226 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:256 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:159 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:194 [inline]
 do_syscall_64+0x2b7/0xf80 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f9bb639c117
Code: a2 c7 05 7c 94 24 00 00 00 00 00 eb 96 e8 e1 12 00 00 90 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 e8 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007ffdcb6948a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 00007f9bb640471f RCX: 00007f9bb639c117
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007ffdcb694960
RBP: 00007ffdcb694960 R08: 00007ffdcb695960 R09: 00000000ffffffff
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffdcb6959f0
R13: 00007f9bb640471f R14: 000000000001c700 R15: 00007ffdcb695a30
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:gfs2_remove_from_journal+0x3bb/0x6b0 fs/gfs2/meta_io.c:356
Code: 3a 4c 89 e7 e8 06 aa 1a fe eb 30 e8 2f d0 b0 fd 48 8b 6c 24 10 4c 8d 65 2c 4c 89 e0 48 c1 e8 03 49 be 00 00 00 00 00 fc ff df <42> 0f b6 04 30 84 c0 4c 8b 3c 24 0f 85 9d 01 00 00 41 ff 04 24 48
RSP: 0018:ffffc900029f7510 EFLAGS: 00010207
RAX: 0000000000000005 RBX: ffff8880476e93a0 RCX: ffff88800094a4c0
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000001
RBP: 0000000000000000 R08: ffff8880121fccff R09: 1ffff1100243f99f
R10: dffffc0000000000 R11: ffffed100243f9a0 R12: 000000000000002c
R13: 0000000000000001 R14: dffffc0000000000 R15: ffff888041d9a170
FS:  000055558f4ef500(0000) GS:ffff88808ccea000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f6bd52346c8 CR3: 00000000455fc000 CR4: 0000000000352ef0
----------------
Code disassembly (best guess):
   0:	3a 4c 89 e7          	cmp    -0x19(%rcx,%rcx,4),%cl
   4:	e8 06 aa 1a fe       	call   0xfe1aaa0f
   9:	eb 30                	jmp    0x3b
   b:	e8 2f d0 b0 fd       	call   0xfdb0d03f
  10:	48 8b 6c 24 10       	mov    0x10(%rsp),%rbp
  15:	4c 8d 65 2c          	lea    0x2c(%rbp),%r12
  19:	4c 89 e0             	mov    %r12,%rax
  1c:	48 c1 e8 03          	shr    $0x3,%rax
  20:	49 be 00 00 00 00 00 	movabs $0xdffffc0000000000,%r14
  27:	fc ff df
* 2a:	42 0f b6 04 30       	movzbl (%rax,%r14,1),%eax <-- trapping instruction
  2f:	84 c0                	test   %al,%al
  31:	4c 8b 3c 24          	mov    (%rsp),%r15
  35:	0f 85 9d 01 00 00    	jne    0x1d8
  3b:	41 ff 04 24          	incl   (%r12)
  3f:	48                   	rex.W


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
