Received: from mail-oo1-f79.google.com (mail-oo1-f79.google.com [209.85.161.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537D235DA50
	for <gfs2@lists.linux.dev>; Fri, 27 Mar 2026 23:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774654471; cv=none; b=Ud4qb1gLeL+d4M83oaGl01F3J4R2JQnewv0Kws/1U+rgOlC653DND92D8PdI+MgLBVO5s3ll5Gx3CJ2+S67sWYpvyN17KJRcv/iECtoXwKSagUEPn4yot2IQWWMngKDicop9bR+belD7MQq1S0B8ZcjKisIIMPBF+UWWBLnlugs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774654471; c=relaxed/simple;
	bh=rxOyZBMkA/sKo3vf4M5jTJw2ObgA6L4wwxeOiDXRYZg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=GYgtK7pIoRQpAL5hdlqsacWGTjj+90LPL07Q/2PePKkZwqE/4MR7M7qYYwKHOzo+2hz7OgD2rFmECDNLDUc1dqyn/Z6WaqR9T/yg8wb+zXqkmtqryq3EQVyfEEm4jAm2gNYAi0xxng6punwNeLVsK+l/vesYqKlEEHVN+DlNGIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f79.google.com with SMTP id 006d021491bc7-67e07123bb5so5284313eaf.0
        for <gfs2@lists.linux.dev>; Fri, 27 Mar 2026 16:34:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774654469; x=1775259269;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wzHOenVg2egQCerYa+qYHv/FatVLL4IjQVJn2JqlhoU=;
        b=nZV4L87hbdAiVhNeHx/EKTQq9kS4CK4rZxYMINzFx8f/sYEjIS+v9T9xno0NP4xP/m
         Wk6Jet+2mnykZLenuv22UdWXyruWo1Iy4zAwycaMBF8xiiSJ6m4vHXY5/uMhfktGzRju
         KLTgMuKCeswiJ+ohU6YXv1DrG8ovQ8IyXy59IyerhAZ30keX0lmF0FTMCX4EAzuvWHHo
         VoSxc7D6y7/oeZggrBSmqttI28dpc9l0C88GmpUtXBumFq6OJHUR6KkMD263WK5K0MOM
         k9Z2GqPiYxSkorNEFs8SYgMKQnk+GLnfWAaJUOWHIdZCUfWEnh4cKy+j6UIIpXtfiBvx
         rntg==
X-Forwarded-Encrypted: i=1; AJvYcCXCSlu6rCMJojPgGbBqdJG7jKTa5ix2ElU13t9TX2a4I/WLimyQ5tVvBOLixTqDJ3wW7k49@lists.linux.dev
X-Gm-Message-State: AOJu0YyZq14nwtK9zfz7xwumeD5nUbGMqKS6w/LeWynPGpcEb5UiHves
	63jNewLTQGqaEcf0EzvqvLoBnx+8jd6xVtMcLdTOwgOPojZFzTBYUou/W+WD0gpUg95KaGJHUwZ
	17/HJx16k8F4P71I40x7Bi2B/AERAB+xCbint0OaqjiyWgtL8py2v09HJuvc=
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:3087:b0:67e:2c8:c0c0 with SMTP id
 006d021491bc7-67e187531demr2311313eaf.58.1774654469292; Fri, 27 Mar 2026
 16:34:29 -0700 (PDT)
Date: Fri, 27 Mar 2026 16:34:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69c71405.a70a0220.128fd0.000c.GAE@google.com>
Subject: [syzbot] [gfs2?] WARNING in gfs2_put_super (2)
From: syzbot <syzbot+c5e536ca62b3854e739b@syzkaller.appspotmail.com>
To: agruenba@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    66ba480978ce Add linux-next specific files for 20260325
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1056d752580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5782739fc9debc4
dashboard link: https://syzkaller.appspot.com/bug?extid=c5e536ca62b3854e739b
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/771dba450de5/disk-66ba4809.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d25fd753a911/vmlinux-66ba4809.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a61db95be18c/bzImage-66ba4809.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c5e536ca62b3854e739b@syzkaller.appspotmail.com

BUG gfs2-bufdata/syz:syz (Not tainted): Objects remaining on __kmem_cache_shutdown()
-----------------------------------------------------------------------------
Object 0xffff8880246d8460 @offset=1120
Slab 0xffffea000091b600 objects=36 used=1 fp=0xffff8880246d8000 flags=0xfff00000000200(workingset|node=0|zone=1|lastcpupid=0x7ff)
Disabling lock debugging due to kernel taint
------------[ cut here ]------------
1
WARNING: mm/slub.c:1231 at __slab_err+0x15/0x20 mm/slub.c:1231, CPU#1: syz-executor/5843
Modules linked in:
CPU: 1 UID: 0 PID: 5843 Comm: syz-executor Tainted: G    B               syzkaller #0 PREEMPT(full) 
Tainted: [B]=BAD_PAGE
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2026
RIP: 0010:__slab_err+0x15/0x20 mm/slub.c:1231
Code: 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 e8 5b 01 00 00 bf 05 00 00 00 be 01 00 00 00 e8 cc 99 5e 00 90 <0f> 0b 90 e9 53 75 8b 0a cc 66 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc90003f17bf8 EFLAGS: 00010093
RAX: ffffffff8186d52a RBX: ffffc90003f17c20 RCX: ffff888076570000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff9323f0a7 R09: 1ffffffff2647e14
R10: dffffc0000000000 R11: fffffbfff2647e15 R12: ffff88802b0c81c8
R13: ffffea000091b600 R14: ffffea0000a42850 R15: ffff88802b0c8180
FS:  0000555577af5500(0000) GS:ffff88812554a000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000a49030 CR3: 00000000678d8000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 free_partial mm/slub.c:7940 [inline]
 __kmem_cache_shutdown+0x13b/0x2a0 mm/slub.c:7983
 kmem_cache_destroy+0x8e/0x170 mm/slab_common.c:569
 gfs2_put_super+0x83f/0x890 fs/gfs2/super.c:642
 generic_shutdown_super+0x13d/0x2d0 fs/super.c:646
 kill_block_super+0x44/0x90 fs/super.c:1725
 deactivate_locked_super+0xbc/0x130 fs/super.c:476
 cleanup_mnt+0x437/0x4d0 fs/namespace.c:1312
 task_work_run+0x1d9/0x270 kernel/task_work.c:233
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 __exit_to_user_mode_loop kernel/entry/common.c:67 [inline]
 exit_to_user_mode_loop+0xed/0x480 kernel/entry/common.c:98
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:238 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:269 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:328 [inline]
 do_syscall_64+0x33e/0xf80 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd5f7b9d9d7
Code: a2 c7 05 1c fd 24 00 00 00 00 00 eb 96 e8 e1 12 00 00 90 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 e8 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007ffde2411ff8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 00007fd5f7c32050 RCX: 00007fd5f7b9d9d7
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007ffde24120b0
RBP: 00007ffde24120b0 R08: 00007ffde24130b0 R09: 00000000ffffffff
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffde2413140
R13: 00007fd5f7c32050 R14: 0000000000049ffd R15: 00007ffde2413180
 </TASK>


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
