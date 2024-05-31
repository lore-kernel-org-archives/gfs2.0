Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E47E179AE
	for <gfs2@lists.linux.dev>; Fri, 31 May 2024 01:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717118610; cv=none; b=DWmw8nEo4m0uOwBVbbaRyO0n2StyTy4vUt6ofBwRCu5tFAqJSL7OoEvVt0GcekrgILropysEeX/RlwQqQxOlsspC8ylkZGHJphwTKxgG2EYZT2nNuevbOF9+XRp2FSFopSty/p4z0eIkTusxxIoM9Z0pVtTUPtIqbMJI3+2v/YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717118610; c=relaxed/simple;
	bh=riGEgFnPnIjsK9v3iNfGsGvzNUMBjZWS5Gn8umdhONQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=qvuleZ4hnpRQoJrxD1csLj5pOY5wQJ0VyGa2W2Zd8HDoFrc1GndHGv24TYnk2Cil20/M0AxhRC3wVknTOeXrHbHkCDq9r5cG5sv7wjRXUrFqGk3t7ivBPmwXvdv+wRJur/yiq5Sm/F369uno6Ox+xO9DvqvSOwvxhZ/WSzUcydM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-36da6da1d98so15517675ab.2
        for <gfs2@lists.linux.dev>; Thu, 30 May 2024 18:23:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717118608; x=1717723408;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XvsKf9GI4GJMckxNw9d7fVJn2/j/rCwGEaSbNej+rGY=;
        b=HjBRs/UHUTXW4tXCxwQlAbNnj+45m0/7guHNZgeo1ltUha38GZNPIVRlfozId2VF80
         KLLoJ6Smv9M+3RjWgKZ5rBnfFWhJv85mP+wh1iNd99WQNZa9dveCmGo6mXzWuN/xgA6m
         LnT5e+bCMSmAii+JP2owybBnyAy5ImVFwHG8KVid6FUadxgJQ3P+e55YPM9o6TRn5qaD
         7gONA+K0Q94kRZ/5Q03XDhQpeW9XHijErOl5A+4iehaW7qWSUZEwYvH0BR9X5CqiHIGO
         lbwBTCOCfcvTLcQc8JMZSJBSv+w0nt21tG++1UElEiAWNbuIVHnKweDje4RKbYjwNAG4
         g8XA==
X-Forwarded-Encrypted: i=1; AJvYcCWxnaKw72ENCS2HBwbEbOG9C0C1xY4G9K1bBxd4+5gKekdgvmKJUJCSsBQLfmHLIEs6Wc/sK7f/2mnWmTmaG7Lahk5P2g==
X-Gm-Message-State: AOJu0Yz2WMz4IlqxR5zqjRp+zCUlmLxN9TwD4RNowYhSLxo7M6JjsDv1
	CqfpdHsk8DiJ6sLR4LVcc/OEAUeAtoHLFvRfLGtNAUTUDadxLp5X9v7w0VRpwFZNZN4wxYYKkRp
	GKIfSisPz1robPM7JEupo1gDGe1JLjC3n1TA7xieJZP/zhBgrFS/aapk=
X-Google-Smtp-Source: AGHT+IFU84YHQl+crEhCGcVvr1GzXH2sZcC6TtDuiq45haG1lUaOqpHAZjsoZ+5WP/Swfe/RI2uH6Iyt++olPwUUNpbPyz9RBFyF
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18cb:b0:36c:c4cc:80e2 with SMTP id
 e9e14a558f8ab-3748b9f7d64mr425195ab.6.1717118607833; Thu, 30 May 2024
 18:23:27 -0700 (PDT)
Date: Thu, 30 May 2024 18:23:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a857ec0619b5d4a9@google.com>
Subject: [syzbot] [gfs2?] KMSAN: uninit-value in gfs2_quota_init
From: syzbot <syzbot+54a69997acb9eddf144e@syzkaller.appspotmail.com>
To: agruenba@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    614da38e2f7a Merge tag 'hid-for-linus-2024051401' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15bf6df0980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f5d2cbf33633f507
dashboard link: https://syzkaller.appspot.com/bug?extid=54a69997acb9eddf144e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/89eafb874b71/disk-614da38e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/356000512ad9/vmlinux-614da38e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/839c73939115/bzImage-614da38e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+54a69997acb9eddf144e@syzkaller.appspotmail.com

syz-executor.3: attempt to access beyond end of device
loop3: rw=12288, sector=402653184, nr_sectors = 8 limit=32768
=====================================================
BUG: KMSAN: uninit-value in gfs2_metatype_check_i fs/gfs2/util.h:125 [inline]
BUG: KMSAN: uninit-value in gfs2_quota_init+0x1c1d/0x2150 fs/gfs2/quota.c:1443
 gfs2_metatype_check_i fs/gfs2/util.h:125 [inline]
 gfs2_quota_init+0x1c1d/0x2150 fs/gfs2/quota.c:1443
 gfs2_make_fs_rw+0x4cf/0x6a0 fs/gfs2/super.c:155
 gfs2_fill_super+0x410e/0x42b0 fs/gfs2/ops_fstype.c:1288
 get_tree_bdev+0x681/0x890 fs/super.c:1614
 gfs2_get_tree+0x5c/0x340 fs/gfs2/ops_fstype.c:1341
 vfs_get_tree+0xa7/0x570 fs/super.c:1779
 do_new_mount+0x71f/0x15e0 fs/namespace.c:3352
 path_mount+0x742/0x1f20 fs/namespace.c:3679
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount+0x725/0x810 fs/namespace.c:3875
 __x64_sys_mount+0xe4/0x150 fs/namespace.c:3875
 x64_sys_call+0x2bf4/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:166
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 __alloc_pages+0x9d6/0xe70 mm/page_alloc.c:4598
 alloc_pages_mpol+0x299/0x990 mm/mempolicy.c:2264
 alloc_pages mm/mempolicy.c:2335 [inline]
 folio_alloc+0x1d0/0x230 mm/mempolicy.c:2342
 filemap_alloc_folio+0xa6/0x440 mm/filemap.c:984
 __filemap_get_folio+0xa10/0x14b0 mm/filemap.c:1926
 gfs2_getbuf+0x23f/0xcd0 fs/gfs2/meta_io.c:132
 gfs2_meta_ra+0x17f/0x7b0 fs/gfs2/meta_io.c:522
 gfs2_quota_init+0x784/0x2150 fs/gfs2/quota.c:1440
 gfs2_make_fs_rw+0x4cf/0x6a0 fs/gfs2/super.c:155
 gfs2_fill_super+0x410e/0x42b0 fs/gfs2/ops_fstype.c:1288
 get_tree_bdev+0x681/0x890 fs/super.c:1614
 gfs2_get_tree+0x5c/0x340 fs/gfs2/ops_fstype.c:1341
 vfs_get_tree+0xa7/0x570 fs/super.c:1779
 do_new_mount+0x71f/0x15e0 fs/namespace.c:3352
 path_mount+0x742/0x1f20 fs/namespace.c:3679
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount+0x725/0x810 fs/namespace.c:3875
 __x64_sys_mount+0xe4/0x150 fs/namespace.c:3875
 x64_sys_call+0x2bf4/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:166
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 1 PID: 5867 Comm: syz-executor.3 Not tainted 6.9.0-syzkaller-02707-g614da38e2f7a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
=====================================================


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
