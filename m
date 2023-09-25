Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE4C134AA
	for <gfs2@lists.linux.dev>; Mon, 25 Sep 2023 09:03:34 +0000 (UTC)
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2c007d6159aso93756151fa.3
        for <gfs2@lists.linux.dev>; Mon, 25 Sep 2023 02:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695632613; x=1696237413; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0876FHIeBuRkE3mg4RyV7ixbXu6UGcmmLWFxGz1E/rg=;
        b=j/Z9abRnDC8JrZtkY663VEq3TbcmDMyMWbaxQkFPJ7BoQ4rbFU4nU1HkS7EjT27CI1
         GmDVApD1fhrwCqlo5Aij8ruaHr0zu4BW6ZzwXoIqRwf+NC+UZRWEEjzxGAQ2AEeEabQW
         3Sq4j7HzwhCTOTY7Hr2TRk9r6vCufmAIF2/BcGYIrdMTvf461jWb1JgSg9AWylhdYPkG
         HET/mZ5g/A1+iecwADUC1BIR8rQaWKZPrDK21B3sNKyXGLxPlZd9Wij4dRrJMkKfTB8X
         emIsh8v3U9t5QA1EM+y2UwBE9fUpqTDHLZBXmFgd07uAvHlbCIqUqlYwEf4taHR67KHD
         Ov2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695632613; x=1696237413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0876FHIeBuRkE3mg4RyV7ixbXu6UGcmmLWFxGz1E/rg=;
        b=qJqoJ2JEwLABVbLDOOAqpB3Yg410C1RU8gB5/vZ4suuIVQxOGxWb9wnHAvW5Fo4z38
         rYwJshmHOsVlBqnuZzfin5KjYciyfEjy0JF5Ry5QhrKbl/L2FKassjJjzNQCowrlrw+Z
         6ChzAaSngfcEzv/nyIfCEv34gezonHwV6VuhXJ9ZmBiB5FTL5EQbvElE4aO6B2X+Wbbi
         ywd/NF6ffhadSz0PA8qzjiYbzXve1a8BmjAGP9+alIpqViNs0y3hIGb1V15aY6wyxubS
         omVnCGfD+GGKRq6kfFj00ZVmONzbTjMuOIlO3pJHJeJVI5T1UYiBFR2bKKgzcuxMzT/A
         a+Sg==
X-Gm-Message-State: AOJu0Yyum85ohd1g/RZdVvwl8ix/groVQE0MYnovxBA/pBkuXQv4PzZE
	aSqU7b1PCw9xJt5wHtw60aYEusoa/+F0O9bmT9Pm7+lgLI9fZsjh
X-Google-Smtp-Source: AGHT+IGk5SpxfBxOzHbxygfDtJQHQN+3ZxQndLePmt1VW54583PS38ZnUiMfC6HM123eDNulPMXJ3Z0e4lb9ILp5zNE=
X-Received: by 2002:a2e:9802:0:b0:2bf:fb49:6619 with SMTP id
 a2-20020a2e9802000000b002bffb496619mr5297683ljj.23.1695632612359; Mon, 25 Sep
 2023 02:03:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Yikebaer Aizezi <yikebaer61@gmail.com>
Date: Mon, 25 Sep 2023 17:03:20 +0800
Message-ID: <CALcu4rbxMHse4Z3R_zMP3ksLZV4ggpHwdjmwy9jTWOQVO4kdJg@mail.gmail.com>
Subject: kernel BUG in gfs2_glock_nq
To: rpeterso@redhat.com, agruenba@redhat.com
Cc: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

When using Healer to fuzz the Latest Linux-6.6-rc3,  the following crash
was triggered.

HEAD commit: 6465e260f48790807eef06b583b38ca9789b6072 ( Linux 6.6-rc3=EF=BC=
=89
git tree: upstream

console output:
https://drive.google.com/file/d/1q_XmbjLsz22Y32vqe0FAv5qbxbcDC_9r/view?usp=
=3Ddrive_link
kernel config:https://drive.google.com/file/d/13ZZEh_dhL4SiUoKcDF0bv4YP1IEg=
AAE8/view?usp=3Ddrive_link
C reproducer:https://drive.google.com/file/d/18efm0TG5Sk3deVXG7ZDDpknAcIEHB=
eru/view?usp=3Ddrive_link
Syzlang reproducer:
https://drive.google.com/file/d/189JUztMVaBcO8rmli6Rk2yRAp02TcAtP/view?usp=
=3Ddrive_link


If you fix this issue, please add the following tag to the commit:
Reported-by: Yikebaer Aizezi <yikebaer61@gmail.com>

------------[ cut here ]------------
kernel BUG at fs/gfs2/glock.c:1544!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 8029 Comm: syz-executor374 Not tainted 6.6.0-rc3-g6465e260f487 =
#2
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
RIP: 0010:add_to_queue fs/gfs2/glock.c:1544 [inline]
RIP: 0010:gfs2_glock_nq+0xbf3/0x1420 fs/gfs2/glock.c:1569
Code: 3c 03 0f 8e f5 05 00 00 8b 53 18 4c 89 e6 48 c7 c7 e0 0c 3c 8a
e8 7d e2 d0 fd 48 8b 34 24 ba 01 00 00 00 31 ff e8 4d 57 ff ff <0f> 0b
e8 46 38 ed fd 48 89 ef e8 fe 94 ff ff 41 89 c4 e9 c0 f9 ff
RSP: 0018:ffffc90002dc7920 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff88802e790000 RCX: 0000000000000000
RDX: ffff888019f19e00 RSI: ffffffff83941059 RDI: ffffffff8a3c43d0
RBP: ffff88801723d438 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 7366203a32736667 R12: ffff88810303d270
R13: 0000000000001f5d R14: ffff88801723d400 R15: ffff88801723d422
FS:  0000000000000000(0000) GS:ffff888063c00000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fecce4a2000 CR3: 000000002857d000 CR4: 0000000000750ef0
PKRU: 55555554
Call Trace:
 <TASK>
 gfs2_glock_nq_init fs/gfs2/glock.h:252 [inline]
 do_sync+0x45a/0xdf0 fs/gfs2/quota.c:921
 gfs2_quota_sync+0x37b/0x5c0 fs/gfs2/quota.c:1347
 gfs2_sync_fs+0x40/0xb0 fs/gfs2/super.c:667
 sync_filesystem fs/sync.c:56 [inline]
 sync_filesystem+0x105/0x280 fs/sync.c:30
 generic_shutdown_super+0x7a/0x3c0 fs/super.c:666
 kill_block_super+0x38/0x70 fs/super.c:1646
 gfs2_kill_sb+0x374/0x420 fs/gfs2/ops_fstype.c:1811
 deactivate_locked_super+0x94/0x170 fs/super.c:481
 deactivate_super+0xad/0xd0 fs/super.c:514
 cleanup_mnt+0x2ae/0x3d0 fs/namespace.c:1254
 task_work_run+0x164/0x250 kernel/task_work.c:180
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xa86/0x2990 kernel/exit.c:874
 do_group_exit+0xd0/0x2a0 kernel/exit.c:1024
 __do_sys_exit_group kernel/exit.c:1035 [inline]
 __se_sys_exit_group kernel/exit.c:1033 [inline]
 __x64_sys_exit_group+0x3a/0x50 kernel/exit.c:1033
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fa392914c51
Code: Unable to access opcode bytes at 0x7fa392914c27.
RSP: 002b:00007ffd30a95fb8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007fa3929bc1b0 RCX: 00007fa392914c51
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000001
RBP: 0000000000000001 R08: ffffffffffffffb8 R09: 00327366673d656c
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fa3929bc1b0
R13: 0000000000000000 R14: 00007fa3929bcf40 R15: 00007fa3928ca060
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:add_to_queue fs/gfs2/glock.c:1544 [inline]
RIP: 0010:gfs2_glock_nq+0xbf3/0x1420 fs/gfs2/glock.c:1569
Code: 3c 03 0f 8e f5 05 00 00 8b 53 18 4c 89 e6 48 c7 c7 e0 0c 3c 8a
e8 7d e2 d0 fd 48 8b 34 24 ba 01 00 00 00 31 ff e8 4d 57 ff ff <0f> 0b
e8 46 38 ed fd 48 89 ef e8 fe 94 ff ff 41 89 c4 e9 c0 f9 ff
RSP: 0018:ffffc90002dc7920 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff88802e790000 RCX: 0000000000000000
RDX: ffff888019f19e00 RSI: ffffffff83941059 RDI: ffffffff8a3c43d0
RBP: ffff88801723d438 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 7366203a32736667 R12: ffff88810303d270
R13: 0000000000001f5d R14: ffff88801723d400 R15: ffff88801723d422
FS:  0000000000000000(0000) GS:ffff888063c00000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fecce4a2000 CR3: 000000002857d000 CR4: 0000000000750ef0
PKRU: 55555554
