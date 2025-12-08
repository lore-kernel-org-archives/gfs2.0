Received: from mail-ot1-f78.google.com (mail-ot1-f78.google.com [209.85.210.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9E0217F31
	for <gfs2@lists.linux.dev>; Mon,  8 Dec 2025 23:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765235787; cv=none; b=sEHNWxOp8heMKQsOBbqpeoZnBGBgoBt41xI8NpEEM9c5lvnzf10X8YdPkcgC4YekCD4ahSzrzfZN/OA9uazQ0wYEuipt2tM4XJTXmjkCyqONHbKEUhTMYMJqq7DXRr/qmAeLREv9bQZHWaCCZ2gV55TYPbczsbjyekTaanHzckE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765235787; c=relaxed/simple;
	bh=bgQUGJat4+yM8+3boIjC+3eYax4ZwuJ24OiiNY8E8kA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Kt+RwULWEiTutF0MeNDfHxlZzsAhTQZ+as3n/sHONY9pF8jyz8rv1TwEPl8+DAM1nROmzvRLSoGOZX1ZOmUMJEsKMUuCtFgMhR6A0Il9ptrRP0i3f744z3A8dt/Q/bbr0UXONA5oi4FMpHlLoy8RpEQHI/14DFnIF2ivp06TFT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f78.google.com with SMTP id 46e09a7af769-7c6db96dfcdso10636281a34.3
        for <gfs2@lists.linux.dev>; Mon, 08 Dec 2025 15:16:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765235784; x=1765840584;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5gYsrD7J869Vvtx5m079l0Dcp15+UlIRSfvjkn26PEw=;
        b=Q52H6vCPKwGTaG9kHPJJmKZfCMro6I7GPh+17gn5Tol6kR85UDz0TfJejZdikRoD5W
         mmaCWx5HzyKlx1g18XMUAGF1seZ0lDM5Vg9qgyp4dD/+hKqUZrdwRPWAWLnaLpr5xkYM
         cnZ7kWyYm2iQRGBHDEBamgtehsrl5zKJXrZ2AMeLdQdmf4u9J7xIvw4W+gBH5cOw/ML/
         vS3YWh4+nm7CnNz6UIyz2Q2QLGucjWkljEGPukd9tdgNHteUY95brJAWochP5mjcFR8i
         jyEH2XGlbkdFH3OXBgL9as0pfqZoPKhFkQedOnBgH2QoGsDONx77MnmBts2EQq4OiFpG
         ClWw==
X-Forwarded-Encrypted: i=1; AJvYcCU/s/QPrFgLQ1Yqe8817U4d4aCgcdBNJeKG/a9UpToh/8p+NTernHv0jlJs4wZT7WHH55OJ@lists.linux.dev
X-Gm-Message-State: AOJu0YzEYOAjnKfBbgpkXwJL/1AwZnIJwenj4HIFPcX+76Fnkh2hSRO1
	/jF0KRl4DTyBaOcsVnr42xbu4uw8agKqf3zi67QPyZTO1Mpp/awxyA0lDVQrukLWZW6TVGQPW7C
	nSQNbseRsEkjOvkC2tEp5DPaVpC4Lo4mcp/Mhv9dJnvHM+iItZOIXqX1vAzc=
X-Google-Smtp-Source: AGHT+IE4/8uyHqBb6ooUEgEL88LNYHIObYU/E7UG+buxa5uj5MCDTRnrXFqxyPBFQsi3CuThcgjoLpatKjE/yCEsov1DKZvK0bTv
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:818b:b0:659:9a49:9044 with SMTP id
 006d021491bc7-6599a8ba043mr3583314eaf.15.1765235784643; Mon, 08 Dec 2025
 15:16:24 -0800 (PST)
Date: Mon, 08 Dec 2025 15:16:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69375c48.a70a0220.38f243.00af.GAE@google.com>
Subject: [syzbot] [gfs2?] WARNING in gfs2_evict_inode
From: syzbot <syzbot+6a7837644249dbdc1fa0@syzkaller.appspotmail.com>
To: agruenba@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    6dfafbd0299a Merge tag 'drm-next-2025-12-03' of https://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=150d3cc2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7290a4d27e182f8b
dashboard link: https://syzkaller.appspot.com/bug?extid=6a7837644249dbdc1fa0
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-6dfafbd0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e7dec7519b1a/vmlinux-6dfafbd0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3ef2b7e3eee7/bzImage-6dfafbd0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6a7837644249dbdc1fa0@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: fs/gfs2/super.c:1247 at evict_should_delete fs/gfs2/super.c:1247 [inline], CPU#0: kswapd0/78
WARNING: fs/gfs2/super.c:1247 at gfs2_evict_inode+0xe8f/0x1000 fs/gfs2/super.c:1400, CPU#0: kswapd0/78
Modules linked in:
CPU: 0 UID: 0 PID: 78 Comm: kswapd0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:evict_should_delete fs/gfs2/super.c:1247 [inline]
RIP: 0010:gfs2_evict_inode+0xe8f/0x1000 fs/gfs2/super.c:1400
Code: 7c 24 20 e8 a3 84 22 fe 48 8b 44 24 20 48 8b 30 4c 89 f7 e8 53 75 f8 ff eb 1d e8 0c 02 bb fd e9 7f fe ff ff e8 02 02 bb fd 90 <0f> 0b 90 e9 f7 f4 ff ff e8 f4 01 bb fd 45 31 f6 49 bd 00 00 00 00
RSP: 0018:ffffc9000103f000 EFLAGS: 00010293
RAX: ffffffff840657fe RBX: ffff888019f45620 RCX: ffff88801c254980
RDX: 0000000000000000 RSI: 0000000000000800 RDI: 0000000000000000
RBP: ffffc9000103f130 R08: ffff888000d1c327 R09: 1ffff110001a3864
R10: dffffc0000000000 R11: ffffed10001a3865 R12: ffff888019f45668
R13: 1ffff110033e8acd R14: 1ffff110033e8b53 R15: 0000000000000800
FS:  0000000000000000(0000) GS:ffff88808d68a000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc185f879a0 CR3: 000000005106d000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 evict+0x5f4/0xae0 fs/inode.c:837
 dispose_list fs/inode.c:879 [inline]
 prune_icache_sb+0x21b/0x2c0 fs/inode.c:1027
 super_cache_scan+0x39b/0x4b0 fs/super.c:224
 do_shrink_slab+0x6df/0x10d0 mm/shrinker.c:437
 shrink_slab_memcg mm/shrinker.c:550 [inline]
 shrink_slab+0x7ef/0x10d0 mm/shrinker.c:628
 shrink_one+0x28a/0x7c0 mm/vmscan.c:4955
 shrink_many mm/vmscan.c:5016 [inline]
 lru_gen_shrink_node mm/vmscan.c:5094 [inline]
 shrink_node+0x315d/0x3780 mm/vmscan.c:6081
 kswapd_shrink_node mm/vmscan.c:6941 [inline]
 balance_pgdat mm/vmscan.c:7124 [inline]
 kswapd+0x13f5/0x2780 mm/vmscan.c:7389
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x599/0xb30 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
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
