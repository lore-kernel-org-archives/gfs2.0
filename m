Received: from mail-oa1-f77.google.com (mail-oa1-f77.google.com [209.85.160.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13F13BA235
	for <gfs2@lists.linux.dev>; Mon, 17 Aug 2026 08:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786957065; cv=none; b=pgWfYIM7Fd/C19pZTGHt+SZJjMXLL8APOczp3po/cdWYqhaARkaAMTfTC1eTS6yMRNN2G7Wgnos7pBaPogo7RTTGWrn2URnJDqoEf9kYi4GS7gCOnml1tlUUtjcvpl6GiqMCsDErl/B6CIxXWEnmbSFB71y8KgzTl+52LJNpFKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786957065; c=relaxed/simple;
	bh=B+8H+QEoKKqVONf7VfgW7QAJj0LgSRPBkHbuRlsx9xE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=gKdXB5KAr/QY72dRt/uymASLq2aSrumEtvHccu9Kn1S3t4FtP3c6N64pCAzmW2+/e66psYUGIKiopbEF7T22blvWmRw6/kFjn6tHE05medl8RyELGnbPVSMPdRPF/4ohpOJYG+3rYi7qUBhDZrspFho9+zKf3saDXVGWvGH4B6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f77.google.com with SMTP id 586e51a60fabf-448d51840c4so2132825fac.1
        for <gfs2@lists.linux.dev>; Mon, 17 Aug 2026 01:57:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786957062; x=1787561862;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w/vjqFVaZlI7wXnWpyuSkyMmkLs28ImviCfLZaGGGNE=;
        b=p/EuzWs5BDYeFRUR6j7S/dKacD13cmnzE3Urts0YW34ASs+SxfZNEqhz6gayWoQq8i
         as8KGGFE69CP3KTTN6VWlb9k+B5Yg5Vcqc98jKgsxo4v9AwGDjm35iOmiWgzHEOx1a+1
         PIW4ex6IdNa8dnfdkbeQ67nlsYUywNDnvv/2TpMjC5fMBK+77SrMV1pfss13SZTIKyRS
         97tmxCFCEcX1SUPmA9ByieaKitQj9YH+AW7nYZhhBf9bbX9/b+GMisA7S18HrfA8LncU
         YJoGhOlTx+czcTIpAXK84AOeCjL2Yf6xTRTuxDO+ueR31a3zN7Ifz/AgXIcDfiTPDmhD
         6Nlg==
X-Forwarded-Encrypted: i=1; AHgh+RoJOoPX9qdc5rYNdvGhC40I4Lu68HIMezj6IfDY+7GQzpDRHg8RYh7XsD3mXJfKBr17VEOH@lists.linux.dev
X-Gm-Message-State: AOJu0YxUT6BIqCNiXz6aOHfZsu6Jja3KXturCUZYc4Yf1SPBvz5I7kw+
	+tiOuBWlMbbfokxuaAHoQYXKG0U9scaThrh8FOxTnEmOBah/J4JsgLGX/c7g7BQ4vOlrMI2uEmt
	j1BDDqKbdt3fjcScfjYdmC3AqaNgJAfgQ5FEAqVf721MRu+BowzG2XQvaPwM=
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:f016:b0:696:836e:ba2b with SMTP id
 006d021491bc7-6b0d6123262mr17868689eaf.11.1786957062700; Mon, 17 Aug 2026
 01:57:42 -0700 (PDT)
Date: Mon, 17 Aug 2026 01:57:42 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a82cd06.dbb3a75c.20434b.004b.GAE@google.com>
Subject: [syzbot] [gfs2?] WARNING: kobject bug in __dlm_new_lockspace
From: syzbot <syzbot+b2b8d04ec4914f618d23@syzkaller.appspotmail.com>
To: aahringo@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, teigland@redhat.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8d3ae59288f1 Linux 7.2
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=144ed6c6580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4c9eb8e593cf8c5c
dashboard link: https://syzkaller.appspot.com/bug?extid=b2b8d04ec4914f618d23
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e3213198af93/disk-8d3ae592.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ccb0eb1c86ad/vmlinux-8d3ae592.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8c009fbdf753/bzImage-8d3ae592.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b2b8d04ec4914f618d23@syzkaller.appspotmail.com

dlm: Using TCP for communications
workqueue: Failed to create a rescuer kthread for wq "dlm_callback": -EINTR
dlm: can't start dlm_callback workqueue
dlm: mydomain: can't start dlm_callback -12
------------[ cut here ]------------
kobject: '(null)' (ffff888060a7c0c8): is not initialized, yet kobject_put() is being called.
WARNING: lib/kobject.c:736 at kobject_put+0x66/0x550 lib/kobject.c:734, CPU#1: syz.2.3/5785
Modules linked in:
CPU: 1 UID: 0 PID: 5785 Comm: syz.2.3 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
RIP: 0010:kobject_put+0x8e/0x550 lib/kobject.c:734
Code: 85 04 48 89 d8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df 80 3c 08 00 74 08 48 89 df e8 2b 7e f3 f6 48 8b 33 4c 89 f7 48 89 da <67> 48 0f b9 3a eb 05 e8 f6 f9 89 f6 4c 8d 73 38 4c 89 f7 be 04 00
RSP: 0018:ffffc90004347810 EFLAGS: 00010246
RAX: 1ffff1100c14f819 RBX: ffff888060a7c0c8 RCX: dffffc0000000000
RDX: ffff888060a7c0c8 RSI: 0000000000000000 RDI: ffffffff8fc1a5a0
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: fffffbfff1f5f267 R12: 1ffff1100c14f820
R13: 00000000fffffff4 R14: ffffffff8fc1a5a0 R15: ffff888060a7c000
FS:  00007f3edfd866c0(0000) GS:ffff888125d3a000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ff044558000 CR3: 000000003c66c000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 new_lockspace fs/dlm/lockspace.c:617 [inline]
 __dlm_new_lockspace+0x19f0/0x2060 fs/dlm/lockspace.c:638
 user_cluster_connect+0x231/0xcc0 fs/ocfs2/stack_user.c:976
 ocfs2_cluster_connect+0x445/0x720 fs/ocfs2/stackglue.c:355
 ocfs2_cluster_connect_agnostic+0x6e/0x90 fs/ocfs2/stackglue.c:385
 user_dlm_register+0xd2/0x210 fs/ocfs2/dlmfs/userdlm.c:669
 dlmfs_mkdir+0x13c/0x340 fs/ocfs2/dlmfs/dlmfs.c:434
 vfs_mkdir+0x402/0x620 fs/namei.c:5276
 filename_mkdirat+0x289/0x520 fs/namei.c:5309
 __do_sys_mkdir fs/namei.c:5336 [inline]
 __se_sys_mkdir+0x34/0x150 fs/namei.c:5333
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f3ee1b2e0d9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f3edfd86028 EFLAGS: 00000246 ORIG_RAX: 0000000000000053
RAX: ffffffffffffffda RBX: 00007f3ee1db5fa0 RCX: 00007f3ee1b2e0d9
RDX: 0000000000000000 RSI: 00000000000001ff RDI: 00002000000006c0
RBP: 00007f3ee1bc5024 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f3ee1db6038 R14: 00007f3ee1db5fa0 R15: 00007ffc09922098
 </TASK>
----------------
Code disassembly (best guess):
   0:	85 04 48             	test   %eax,(%rax,%rcx,2)
   3:	89 d8                	mov    %ebx,%eax
   5:	48 c1 e8 03          	shr    $0x3,%rax
   9:	48 b9 00 00 00 00 00 	movabs $0xdffffc0000000000,%rcx
  10:	fc ff df
  13:	80 3c 08 00          	cmpb   $0x0,(%rax,%rcx,1)
  17:	74 08                	je     0x21
  19:	48 89 df             	mov    %rbx,%rdi
  1c:	e8 2b 7e f3 f6       	call   0xf6f37e4c
  21:	48 8b 33             	mov    (%rbx),%rsi
  24:	4c 89 f7             	mov    %r14,%rdi
  27:	48 89 da             	mov    %rbx,%rdx
* 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2f:	eb 05                	jmp    0x36
  31:	e8 f6 f9 89 f6       	call   0xf689fa2c
  36:	4c 8d 73 38          	lea    0x38(%rbx),%r14
  3a:	4c 89 f7             	mov    %r14,%rdi
  3d:	be                   	.byte 0xbe
  3e:	04 00                	add    $0x0,%al


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
