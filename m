Received: from mail-oa1-f80.google.com (mail-oa1-f80.google.com [209.85.160.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD171386C9
	for <gfs2@lists.linux.dev>; Fri, 12 Dec 2025 01:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765503933; cv=none; b=H7Dlk87o+JlAp2C6u6La2LrOi0h3dY0ZjLhA2/LZntP+Ff15Mc/gAn8vj2g56smLoJ61lSkQtGRZbTwHNPEgg6k1nnji2NYTCIezlsMEJTfzxiekxgGsEldSGUDCzsSuCGidbkSDB/cOQmLq91NxM4jlI8RBr7fJlCCP7gMw/6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765503933; c=relaxed/simple;
	bh=jlvWHl7y4RgxyEhG5TolpT+5BZxcoIx+tXWlh2WaPG4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=RedreS6mKKe3JheYG91fh+p8X5aztpQkQDkFIjV62ht/ZoN40clxI/fOm0ADfaBZ+foFpn0awV6pemdZrhFfAdEQPEits98YZzdKtF23YwHqE5OYyVKmcF9a2XWLKTmdkju4lYz6u0x3/4RRkjb4EGiCVtHC48cnnWnkL95GkrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f80.google.com with SMTP id 586e51a60fabf-3f0d1a7a9c2so490538fac.3
        for <gfs2@lists.linux.dev>; Thu, 11 Dec 2025 17:45:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765503930; x=1766108730;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rJeHpWGHUmObWowYq3P1dvj/KOiXFn7HVoWTaajokZE=;
        b=FYfMhs0on9fWpyJ0LvmLBYZ4k3o55EJbUWjVvdkOp83RANGeRfDy0+Ns3ilaegAFbc
         gkG/PY7FAgpbKc9WUKa2bmuXRHtYtgADJnCP+emLBhUU62Aqb27xDH12UyYNerVSCfoN
         KcPY4+cq62o5yh319VmUNjIswVzkGCSBnlVWB+3n3h49xOT5ARWfVmxE0gdXX64eAA6O
         /cLp5xivPVSJdXRXVI2pouz9DX/h82jPTWmBMFasaIRbbb5xUYdnLr6PS+pGJPqxjVSM
         SopApKEqjdtZRmgFctX9plkNaJRwjz09iiK4pG3mAmS2E8SSekbNt680E8uJe86Vm2II
         jvWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYzOSSS2IxnzE7kaRU2S3hA6FHrsoTexknIdzMh54nPSqC4QBc2pghoxTmcTUhwsZ4bpUP@lists.linux.dev
X-Gm-Message-State: AOJu0YzDdzMbHoV3VfRsg7/JJxE2wePwADVzPXFyVVhyq3rETImplej7
	UK3d0NUsydX7zXwBAbywVRRzsQjWjtXCam4HgZ9ZpzueNWnE2hMvd3rIO0IvmwlUbcPBE0APd4i
	tYwnxFvfuDL6O0GUhqmlV+EM/VZOFrQvajJ3k+xt4sEKJYeY939i6j6icfns=
X-Google-Smtp-Source: AGHT+IHqHBZ6aCsR+5fmkp/OjvTHUAEmtZtXy0YzVVPakHjg+RqPoqT1AQxQPhTql0VkqO7UMO6+4nYZ2bBw1Ev5VOsS147jZCEp
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1c9c:b0:659:9a49:8e07 with SMTP id
 006d021491bc7-65b45273592mr228187eaf.73.1765503930568; Thu, 11 Dec 2025
 17:45:30 -0800 (PST)
Date: Thu, 11 Dec 2025 17:45:30 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <693b73ba.a70a0220.33cd7b.0044.GAE@google.com>
Subject: [syzbot] [gfs2?] general protection fault in gfs2_remove_from_journal (2)
From: syzbot <syzbot+cff8e1b82d7911dd051c@syzkaller.appspotmail.com>
To: agruenba@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e811c33b1f13 Merge tag 'drm-fixes-2025-11-08' of https://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1609aa92580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=929790bc044e87d7
dashboard link: https://syzkaller.appspot.com/bug?extid=cff8e1b82d7911dd051c
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-e811c33b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9a1852775b7f/vmlinux-e811c33b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d2f7ca742771/bzImage-e811c33b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cff8e1b82d7911dd051c@syzkaller.appspotmail.com

Zero length message leads to an empty skb
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000005: 0000 [#1] SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000028-0x000000000000002f]
CPU: 0 UID: 0 PID: 5331 Comm: syz.0.0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:gfs2_remove_from_journal+0x3cc/0x6d0 fs/gfs2/meta_io.c:359
Code: 3a 4c 89 e7 e8 05 ab 27 fe eb 30 e8 9e 6b c0 fd 48 8b 6c 24 10 4c 8d 65 2c 4c 89 e0 48 c1 e8 03 49 be 00 00 00 00 00 fc ff df <42> 0f b6 04 30 84 c0 4c 8b 3c 24 0f 85 aa 01 00 00 41 ff 04 24 48
RSP: 0018:ffffc9000d4973f8 EFLAGS: 00010207
RAX: 0000000000000005 RBX: ffff88801c0d0000 RCX: 0000000000100000
RDX: ffffc9000e683000 RSI: 0000000000000e73 RDI: 0000000000000e74
RBP: 0000000000000000 R08: ffff8880434e0caf R09: 1ffff1100869c195
R10: dffffc0000000000 R11: ffffed100869c196 R12: 000000000000002c
R13: 0000000000000001 R14: dffffc0000000000 R15: ffff8880511d41e0
FS:  00007fa4cc38a6c0(0000) GS:ffff88808d730000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000000140 CR3: 000000004233d000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 gfs2_discard fs/gfs2/aops.c:597 [inline]
 gfs2_invalidate_folio+0x579/0x750 fs/gfs2/aops.c:631
 folio_invalidate mm/truncate.c:140 [inline]
 truncate_cleanup_folio+0x2d8/0x430 mm/truncate.c:160
 truncate_inode_pages_range+0x233/0xda0 mm/truncate.c:379
 do_gfs2_set_flags fs/gfs2/file.c:254 [inline]
 gfs2_fileattr_set+0x80a/0x9b0 fs/gfs2/file.c:311
 vfs_fileattr_set+0x932/0xb90 fs/file_attr.c:298
 ioctl_setflags+0x180/0x1e0 fs/file_attr.c:334
 do_vfs_ioctl+0x8ed/0x1430 fs/ioctl.c:560
 __do_sys_ioctl fs/ioctl.c:595 [inline]
 __se_sys_ioctl+0x82/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa4cb58f6c9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fa4cc38a038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fa4cb7e6090 RCX: 00007fa4cb58f6c9
RDX: 0000200000000140 RSI: 0000000040086602 RDI: 0000000000000005
RBP: 00007fa4cb611f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fa4cb7e6128 R14: 00007fa4cb7e6090 R15: 00007ffcd258e628
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:gfs2_remove_from_journal+0x3cc/0x6d0 fs/gfs2/meta_io.c:359
Code: 3a 4c 89 e7 e8 05 ab 27 fe eb 30 e8 9e 6b c0 fd 48 8b 6c 24 10 4c 8d 65 2c 4c 89 e0 48 c1 e8 03 49 be 00 00 00 00 00 fc ff df <42> 0f b6 04 30 84 c0 4c 8b 3c 24 0f 85 aa 01 00 00 41 ff 04 24 48
RSP: 0018:ffffc9000d4973f8 EFLAGS: 00010207
RAX: 0000000000000005 RBX: ffff88801c0d0000 RCX: 0000000000100000
RDX: ffffc9000e683000 RSI: 0000000000000e73 RDI: 0000000000000e74
RBP: 0000000000000000 R08: ffff8880434e0caf R09: 1ffff1100869c195
R10: dffffc0000000000 R11: ffffed100869c196 R12: 000000000000002c
R13: 0000000000000001 R14: dffffc0000000000 R15: ffff8880511d41e0
FS:  00007fa4cc38a6c0(0000) GS:ffff88808d730000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000000140 CR3: 000000004233d000 CR4: 0000000000352ef0
----------------
Code disassembly (best guess):
   0:	3a 4c 89 e7          	cmp    -0x19(%rcx,%rcx,4),%cl
   4:	e8 05 ab 27 fe       	call   0xfe27ab0e
   9:	eb 30                	jmp    0x3b
   b:	e8 9e 6b c0 fd       	call   0xfdc06bae
  10:	48 8b 6c 24 10       	mov    0x10(%rsp),%rbp
  15:	4c 8d 65 2c          	lea    0x2c(%rbp),%r12
  19:	4c 89 e0             	mov    %r12,%rax
  1c:	48 c1 e8 03          	shr    $0x3,%rax
  20:	49 be 00 00 00 00 00 	movabs $0xdffffc0000000000,%r14
  27:	fc ff df
* 2a:	42 0f b6 04 30       	movzbl (%rax,%r14,1),%eax <-- trapping instruction
  2f:	84 c0                	test   %al,%al
  31:	4c 8b 3c 24          	mov    (%rsp),%r15
  35:	0f 85 aa 01 00 00    	jne    0x1e5
  3b:	41 ff 04 24          	incl   (%r12)
  3f:	48                   	rex.W


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
