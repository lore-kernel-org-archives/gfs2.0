Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793102984;
	b=Lovmux4OHykIxcfMs3EIqp9szfC7bxj6dX3hlEFQioxYurDMEuiyptwsapfqK/Doe4vj
	 qOxBdAX0zX1nSgyiH09CgUF/rbfBO7MX8cliTHfomswq0XjzzSW1StUvcmdYL8QKP9hgg
	 BlxjQVTfey4MFrFun3XWqanMTviLxhZ8qW07cNjaXtUm5yRPOGv2bKbHod2HqX1hBnrg4
	 Vr3q5WOluv2QPj/ZgHB6/M+FlrchN83go03wOKgpQR0rXsKbIC+RzhPwwiqg9chIJ3vsa
	 MD2ho0xh/oeAKum5OFh/+rrl9SIMYM1LULPqD+2Cw7VGwHoIB/YcHxHCEVbdUFHKfSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793102984;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:MIME-Version:X-Received:Date:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:Message-ID:
	 Subject:From:To:Content-Type;
	bh=IptyB1qH+sm+JTCt8RytNfuKsrQJA6F1Il01uz2n03Y=;
	b=TsJOsVOGkDmJD76qmOS0Opu83BtYQKJ5pg4sMZmEzNOOyMTP2xGyb7kMFa/BQobfNkhO
	 7tNhiz0UUEsB4GRSoOVgCa2AYkHlnkms+2EdOUoazaURniPDyJ+9TWKmhaAAwcp7+Lvo7
	 ZCNjhRETqC9QSbxzSdCaEY8uuvzkQDbQIjSpbf/xjLc3E/xczEA3DLGKHRxfPxcjuUhMw
	 NJf2sL2eGLVdcQokLN1h77+cog2vMaeJUrQ7Ifxqpwm7Umv+jYs9q7EkJF5/UJ1W0KfGt
	 g1npGJXKhyemI8rJMkQiMWce5sbz9Z7p4Q+tYEbM2Ps4XLubksl0AGMAQU/Mi652NKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.167.197
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF440606A31A
	for <gfs2@lists.linux.dev>; Tue, 27 Oct 2026 12:09:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF440606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-55bf11583d9so1258383b6e.1
        for <gfs2@lists.linux.dev>; Tue, 27 Oct 2026 05:09:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793102983; x=1793707783;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IptyB1qH+sm+JTCt8RytNfuKsrQJA6F1Il01uz2n03Y=;
        b=qCDHtOuM1xGzCRtiENx8QeWaQanhQG0P0lHOhz9q0wyYZRNel+j9trn4lVYW1fyMsI
         DFv3ft0hgSY5cWVqduLrzbFa/f0sdBd9jzO3CtLRAC/Zpo70Kj/p57S5ck58vFDcStsI
         aWGZw0gRYuFIFKR/NNU8JxkOoE1AxCtoXK4Q+IoPDagDkZ5cygRAkp/0Hx9OHQYtLNp8
         8xe+b65lavYPo5BRMY34xd/N2F4TG4XXWH7NF69PQtrb7vTtcVKfez7/aQiLpxw+pBX3
         LsDuFcJdUu9O3W6RxoInGc8B7PhvpjegZAXw+ZleaFvx4pEFS0ZVCc4UnPN/M16y91Km
         FVXA==
X-Forwarded-Encrypted: i=1; AKwUvByds1jkID9EPGysxVoQ6ArgBfNUSmNUP1CyTTyow5iLUQsu4iPtgPU7As2OarAxbZNF7Htj@lists.linux.dev
X-Gm-Message-State: AFq9FYI7BB/duaQNruRUPcUFS60MoTpzmz00R0zZWQkPSpogCQWLaam6
	gwgOJOu1jkIed3fIzsrVA9emjhMjtGbdNa2YtdBH+kjkz5Ns5yJ6tHJ1zt/p3e62q/ZB6cmPxqD
	Kq86FL6q52Ukk3Xgx2FwLz080u6NW7uiFWNOCuJmJgmosWbL/NBNzS5UOCYc=
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Post: <mailto:gfs2@lists.linux.dev>
List-Help: <mailto:gfs2+help@lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
List-Owner: <mailto:gfs2+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:448a:b0:4d6:9133:cfee with SMTP id
 5614622812f47-55f813acd37mr1352531b6e.51.1793102982923; Tue, 27 Oct 2026
 05:09:42 -0700 (PDT)
Date: Tue, 27 Oct 2026 05:09:42 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ae09486.768774f5.3237ab.0017.GAE@google.com>
Subject: [syzbot] [gfs2?] WARNING in iomap_writepages
From: syzbot <syzbot+5e659793378ad9e06387@syzkaller.appspotmail.com>
To: agruenba@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d135ab453a74 Merge tag 'backlight-next-7.4' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13d4dee1580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ca6085a265c4d259
dashboard link: https://syzkaller.appspot.com/bug?extid=5e659793378ad9e06387
compiler:       Debian clang version 22.1.8 (1~deb13u4), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-d135ab45.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4dc024e5978e/vmlinux-d135ab45.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1f7c8ddcde45/bzImage-d135ab45.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5e659793378ad9e06387@syzkaller.appspotmail.com

------------[ cut here ]------------
(current->flags & PF_MEMALLOC)
WARNING: fs/iomap/buffered-io.c:2084 at iomap_writepages+0x29f/0x2d0 fs/iomap/buffered-io.c:2084, CPU#0: kswapd0/82
Modules linked in:
CPU: 0 UID: 0 PID: 82 Comm: kswapd0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:iomap_writepages+0x29f/0x2d0 fs/iomap/buffered-io.c:2084
Code: 00 65 48 8b 0d 8a be 45 12 48 3b 4c 24 60 75 42 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc cc e8 f2 ab 4e ff 90 <0f> 0b 90 b8 fb ff ff ff eb ac 44 89 f9 80 e1 07 80 c1 03 38 c1 0f
RSP: 0018:ffffc90000ebe5a0 EFLAGS: 00010293
RAX: ffffffff827a71be RBX: 0000000000000800 RCX: ffff888000300000
RDX: 0000000000000000 RSI: 0000000000000800 RDI: 0000000000000000
RBP: ffffc90000ebe650 R08: ffffc90000ebe70f R09: 0000000000000000
R10: ffffc90000ebe6a0 R11: fffff520001d7ce2 R12: 1ffff920001d7cb8
R13: dffffc0000000000 R14: ffff8880144b0218 R15: ffff88800030002c
FS:  0000000000000000(0000) GS:ffff88808ac1d000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffcb345acd0 CR3: 000000001f98a000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 gfs2_writepages+0x1bb/0x2a0 fs/gfs2/aops.c:175
 do_writepages+0x338/0x560 mm/page-writeback.c:2560
 filemap_writeback mm/filemap.c:387 [inline]
 filemap_fdatawrite_range mm/filemap.c:412 [inline]
 filemap_fdatawrite+0x1e9/0x2f0 mm/filemap.c:418
 gfs2_ordered_write fs/gfs2/log.c:730 [inline]
 __gfs2_log_flush+0x836/0x1d90 fs/gfs2/log.c:1135
 gfs2_log_flush+0x34/0x50 fs/gfs2/log.c:1217
 evict_linked_inode fs/gfs2/super.c:1439 [inline]
 gfs2_evict_inode+0x787/0x13f0 fs/gfs2/super.c:1506
 evict+0x624/0xb50 fs/inode.c:822
 dispose_list fs/inode.c:864 [inline]
 prune_icache_sb+0x223/0x2d0 fs/inode.c:1010
 super_cache_scan+0x390/0x4a0 fs/super.c:227
 do_shrink_slab+0x6d0/0x10d0 mm/shrinker.c:445
 shrink_slab_memcg mm/shrinker.c:562 [inline]
 shrink_slab+0x838/0x1210 mm/shrinker.c:640
 shrink_one+0x396/0x10f0 mm/vmscan.c:5315
 shrink_many mm/vmscan.c:5376 [inline]
 lru_gen_shrink_node mm/vmscan.c:5454 [inline]
 shrink_node+0x631e/0x6b20 mm/vmscan.c:6460
 kswapd_shrink_node mm/vmscan.c:7253 [inline]
 balance_pgdat mm/vmscan.c:7424 [inline]
 kswapd+0x1ff4/0x3a20 mm/vmscan.c:7700
 kthread+0x38b/0x480 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
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
