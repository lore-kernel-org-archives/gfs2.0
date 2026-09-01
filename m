Received: from mail-oo2-f8.google.com (mail-oo2-f8.google.com [74.125.231.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3BA32C8B
	for <gfs2@lists.linux.dev>; Tue,  1 Sep 2026 23:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788303988; cv=none; b=b8CEc2jWpK/m5HJxUhDUENG1O/UGXYrtTtXAeJmk8jIFG/m1EpsSFSBrsBee5tG7+diVy7x+QEHMy/aIuIS0mmv/yXFOwKjqbyfKmBb+CK0iJ4N0UyF5edp5FLi3mKJtmDYdpawPjsDca4E+D6zI2dnGQ48gQR7dUMEHJBpzfwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788303988; c=relaxed/simple;
	bh=fTTzUUef/giTP36AMBrK8vZ5Mt4Z0GkfdMC6ws30VT8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=MLiRdjmH/Vl0L3XUEFaOSWWr9VLHSuZB1lhfEQyAoGIToqmJKxrAqwDn7J89ynI1wD6DWD94oFEF4INMAQfAhOL7f584vR4ZwfBT03EkaxEuUmN5LI4IE6P/nPCoCGXJcsEKSnBl3SY7SNHwIB159YWzSHca7z1r9mrDvNT24JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo2-f8.google.com with SMTP id 006d021491bc7-6b1ca037684so7365eaf.0
        for <gfs2@lists.linux.dev>; Tue, 01 Sep 2026 16:06:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788303986; x=1788908786;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ToRfVoUbS7J82fWQO+yda+u6CrS6/cWnXChbMIIKU1Y=;
        b=qRQAmBHOWdYsuiszYlC7PvVFx/IQHmvJDO5NIEm2ABka+bju7WAiMWhm6qDKa8KHP+
         dFhUPKkljdt4g0lF7xMyIOLMPKQM1MSm3L3QosLYLBloPBV5qp23wQNqSQLEkiSk6CRD
         weDvMaQtMD7laFiTOX4jGUP44AlkSJqIcPYbBwPeWwNaWbi446aYD+JRfYLKnFpyM2OR
         yxI0mhPFeTv12snd7Rch/bzv3yDSnpBGc+EDBTBa/bipxiBPTm7hjim1/fx1guOl6H9J
         8GM24Un3xIt1RrjfxE6w9jIQTG4YXdsVu03kDkdnm9lN53XGRfWB8/p4Oeic2YkoaWcS
         HvuQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq//MzfgiH8Pvm14ycNmR7bcDgOzTiCc2Z5WfzdaMHzxNwNeFaa4Iv04no6kWQowAgQhfaT@lists.linux.dev
X-Gm-Message-State: AFuF++nmt31rbqXgfj9Yy13XtimABdxf4MF4VM7fV8EldNlZSzgMEPfW
	NQijbswinSHPmkFv3Hw7uYJ9DsaKNJgXSYYHySJgtdBrcdMhwOkrk8x7W45m5oSei2CHrNI4Kph
	TQPJ2K3TbhpV+6i3LUWG2CHHZOxbRUjDCAebXEl1Mhf9MtAGEztlyna5GzhM=
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:3108:b0:6b1:afca:5c78 with SMTP id
 006d021491bc7-6b48043ec63mr234212eaf.32.1788303985978; Tue, 01 Sep 2026
 16:06:25 -0700 (PDT)
Date: Tue, 01 Sep 2026 16:06:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a975a71.9266084e.bf0d7.0002.GAE@google.com>
Subject: [syzbot] [gfs2?] general protection fault in gfs2_quota_lock
From: syzbot <syzbot+d84e35a320d14f8c270a@syzkaller.appspotmail.com>
To: agruenba@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    89c07d98716a Add linux-next specific files for 20260831
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=13eafe25580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3084bde934a7eb4b
dashboard link: https://syzkaller.appspot.com/bug?extid=d84e35a320d14f8c270a
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=167d3b79580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14c51379580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/efda3e96af9f/disk-89c07d98.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7cba3e147607/vmlinux-89c07d98.xz
kernel image: https://storage.googleapis.com/syzbot-assets/bf4b2e49d1cb/bzImage-89c07d98.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/85a2c905fb7a/mount_2.gz
  fsck result: OK (log: https://syzkaller.appspot.com/x/fsck.log?x=10c51379580000)

The issue was bisected to:

commit e65756f09826a87322479abc946ca11e6816a6ce
Author: Andreas Gruenbacher <agruenba@redhat.com>
Date:   Wed Aug 26 10:41:28 2026 +0000

    gfs2: No quotas for meta inodes

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=112f5c15580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=132f5c15580000
console output: https://syzkaller.appspot.com/x/log.txt?x=152f5c15580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d84e35a320d14f8c270a@syzkaller.appspotmail.com
Fixes: e65756f09826 ("gfs2: No quotas for meta inodes")

capability: warning: `syz-executor311' uses deprecated v2 capabilities in a way that may be insecure
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000020: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000100-0x0000000000000107]
CPU: 1 UID: 0 PID: 5636 Comm: syz-executor311 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
RIP: 0010:gfs2_quota_lock+0x103/0x7b0 fs/gfs2/quota.c:1105
Code: 00 00 4d 89 fd 49 c1 ed 03 41 80 7c 1d 00 00 74 08 4c 89 ff e8 1e fd e7 fd 49 8b 3f 48 8d 87 00 01 00 00 48 89 c1 48 c1 e9 03 <0f> b6 0c 19 84 c9 0f 85 c9 05 00 00 8b b7 00 01 00 00 ba 08 00 00
RSP: 0018:ffffc90003bcf8d0 EFLAGS: 00010202
RAX: 0000000000000100 RBX: dffffc0000000000 RCX: 0000000000000020
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff907a487f R09: 1ffffffff20f490f
R10: dffffc0000000000 R11: fffffbfff20f4910 R12: ffff888012189320
R13: 1ffff110024312f9 R14: 00000000ffffffff R15: ffff8880121897c8
FS:  000055558edf6400(0000) GS:ffff888124dcd000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000006a9ee0 CR3: 0000000073f60000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 gfs2_quota_lock_check fs/gfs2/quota.h:50 [inline]
 do_grow fs/gfs2/bmap.c:2117 [inline]
 gfs2_setattr_size+0x9df/0x1270 fs/gfs2/bmap.c:2198
 gfs2_setattr+0x269/0x430 fs/gfs2/inode.c:2138
 notify_change+0xbba/0xea0 fs/attr.c:556
 do_truncate+0x1c2/0x250 fs/open.c:68
 vfs_truncate+0x4b4/0x540 fs/open.c:118
 ksys_truncate+0xf3/0x1c0 fs/open.c:142
 __do_sys_truncate fs/open.c:154 [inline]
 __se_sys_truncate fs/open.c:152 [inline]
 __x64_sys_truncate+0x5b/0x70 fs/open.c:152
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f49688f2409
Code: c0 79 93 eb d5 48 8d 7c 1d 00 eb 99 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 d8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd4cc3da68 EFLAGS: 00000246 ORIG_RAX: 000000000000004c
RAX: ffffffffffffffda RBX: 0030656c69662f2e RCX: 00007f49688f2409
RDX: 00007f49688f2409 RSI: 000000000008fff5 RDI: 0000200000000180
RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffd4cc3db98
R13: 0000000000000002 R14: 00007f49689b3c80 R15: 0000000000000002
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:gfs2_quota_lock+0x103/0x7b0 fs/gfs2/quota.c:1105
Code: 00 00 4d 89 fd 49 c1 ed 03 41 80 7c 1d 00 00 74 08 4c 89 ff e8 1e fd e7 fd 49 8b 3f 48 8d 87 00 01 00 00 48 89 c1 48 c1 e9 03 <0f> b6 0c 19 84 c9 0f 85 c9 05 00 00 8b b7 00 01 00 00 ba 08 00 00
RSP: 0018:ffffc90003bcf8d0 EFLAGS: 00010202
RAX: 0000000000000100 RBX: dffffc0000000000 RCX: 0000000000000020
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff907a487f R09: 1ffffffff20f490f
R10: dffffc0000000000 R11: fffffbfff20f4910 R12: ffff888012189320
R13: 1ffff110024312f9 R14: 00000000ffffffff R15: ffff8880121897c8
FS:  000055558edf6400(0000) GS:ffff888124dcd000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000006a9ee0 CR3: 0000000073f60000 CR4: 00000000003526f0
----------------
Code disassembly (best guess):
   0:	00 00                	add    %al,(%rax)
   2:	4d 89 fd             	mov    %r15,%r13
   5:	49 c1 ed 03          	shr    $0x3,%r13
   9:	41 80 7c 1d 00 00    	cmpb   $0x0,0x0(%r13,%rbx,1)
   f:	74 08                	je     0x19
  11:	4c 89 ff             	mov    %r15,%rdi
  14:	e8 1e fd e7 fd       	call   0xfde7fd37
  19:	49 8b 3f             	mov    (%r15),%rdi
  1c:	48 8d 87 00 01 00 00 	lea    0x100(%rdi),%rax
  23:	48 89 c1             	mov    %rax,%rcx
  26:	48 c1 e9 03          	shr    $0x3,%rcx
* 2a:	0f b6 0c 19          	movzbl (%rcx,%rbx,1),%ecx <-- trapping instruction
  2e:	84 c9                	test   %cl,%cl
  30:	0f 85 c9 05 00 00    	jne    0x5ff
  36:	8b b7 00 01 00 00    	mov    0x100(%rdi),%esi
  3c:	ba                   	.byte 0xba
  3d:	08 00                	or     %al,(%rax)


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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
