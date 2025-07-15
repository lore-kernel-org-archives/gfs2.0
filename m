Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22C724293F
	for <gfs2@lists.linux.dev>; Tue, 15 Jul 2025 12:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752583505; cv=none; b=kCIwLKnCK8NnZvNO/RBk+2xuMzeGhtdzFuEwz/2p3Mk9+CJiyfnVgrDQDk7kFVgXWcxeWOkYpAXZSLFmgb4AewyWLIJX7Bv/S+nDxeHj2WSnFuyB5Ikfjg4NXbqEgrnamYSYhGQ0kInZbAydVUcixVF13hjwkU1zR4rc6P6RQXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752583505; c=relaxed/simple;
	bh=qd9byiqdLs5dhX68Mvy0lY6EMTedt2FDJFFyGsFXEM4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=MZHqCa58EuMiN3dXIg3CwIiLJE0IwXgr7bvrUOR4b/3+aeNiKXXvXNXFIYt+JDhKkLhkZEuYWGtSvo4Zj9LWiYgE5ViK5sDav7y5lFXlbUiPRRfhu075/p+9cyDUFQOJtEKf9wMDqaekaESb/3nCkwaY47TJY16PROkfL0vtYqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-876a8bb06b0so988031939f.1
        for <gfs2@lists.linux.dev>; Tue, 15 Jul 2025 05:45:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752583503; x=1753188303;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f/0NmGbHnwvLah827HF2TRWoOhL/bFX+Kt45R03Zcdc=;
        b=LsKHfrsuOmiVnkLHswVGsuwW4MwnoQGI0mCpcuYfRMTd//JpULh4o0l8m5kWpFJ1na
         WbVr0hM2wwfif0JNs4nKvyrfm/7OoL8X1eehJpcWUixbQTkfYa3Qu+qYLxP+SExJDa+T
         eq2oM2aBAvPRJj1V3OajDRU+Rh2UvV453Wul/NVZS8LxSZkxBHn3CiyIHaCtKpsSxN/G
         AqScDOqezGUjUVIG5gwoK1DuXuFh0UzSd6XUQdkZp54kLd9Fjcs40p97yH0FAXbJM0e8
         CqweZCvvTMntrYMN7XykSHscit2PBooKBy8k3PsJGby7YebqZXFsSX2ZnJTebih8z/++
         XdsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtMaKiS8XawxRa3FskarZ5sFXLL6S3gWAka2mcZmw3g+Md4YWzdyiiQu4StYM515EMPrL1@lists.linux.dev
X-Gm-Message-State: AOJu0YwP7eal0AGFuOBcGhUqvsSo/trdcKyav06gbf+N9nyZQFJrurOI
	D9G4EVCBNNZu25Rzjjzen6wTMMS8/cv8a4yfDCySZNUU6g7Xm3t8N81Av1w7sq2OdYWsyQUVO2C
	6cBJpus7Ipg/cwhAMttN/O8YD/GQH9UDOeeUU5Z3ppDWG+5P2o+m1AUdR9h4=
X-Google-Smtp-Source: AGHT+IHG73OdBF8cmM6aXt94Cd4FWPR95gSFPx77XZ8alCdtiFen2vBUAmbwXvHXI9npZrrfSgJe+M5+0XZewM5kAnBnrI4TMyU2
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1555:b0:879:4aee:a88a with SMTP id
 ca18e2360f4ac-87977e9a6f7mr1821780439f.0.1752583503113; Tue, 15 Jul 2025
 05:45:03 -0700 (PDT)
Date: Tue, 15 Jul 2025 05:45:03 -0700
In-Reply-To: <76704579-e2a1-4000-8d0c-b3ccd429870d@redhat.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68764d4f.a70a0220.693ce.000a.GAE@google.com>
Subject: Re: [syzbot] [gfs2?] UBSAN: shift-out-of-bounds in gfs2_dir_read (2)
From: syzbot <syzbot+4708579bb230a0582a57@syzkaller.appspotmail.com>
To: agruenba@redhat.com, anprice@redhat.com, gfs2@lists.linux.dev, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in move_to_new_folio

------------[ cut here ]------------
gfs2_meta_aops does not implement migrate_folio
WARNING: CPU: 0 PID: 30 at mm/migrate.c:944 fallback_migrate_folio mm/migrate.c:942 [inline]
WARNING: CPU: 0 PID: 30 at mm/migrate.c:944 move_to_new_folio+0x696/0x7a0 mm/migrate.c:996
Modules linked in:
CPU: 0 UID: 0 PID: 30 Comm: kcompactd1 Not tainted 6.16.0-rc6-syzkaller-g155a3c003e55-dirty #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:fallback_migrate_folio mm/migrate.c:942 [inline]
RIP: 0010:move_to_new_folio+0x696/0x7a0 mm/migrate.c:996
Code: 0d 01 90 42 80 7c 3d 00 00 74 0a 48 8b 7c 24 20 e8 2f 53 fe ff 48 8b 44 24 20 48 8b 30 48 c7 c7 20 bb 97 8b e8 cb b5 5e ff 90 <0f> 0b 90 90 49 bf 00 00 00 00 00 fc ff df e9 7e fd ff ff e8 e2 d2
RSP: 0018:ffffc90000516fd0 EFLAGS: 00010246
RAX: 0ac1efce833f5700 RBX: ffffea0000d5d100 RCX: ffff888030f20000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000002
RBP: 1ffff1100aaeabc5 R08: ffff88801fc24293 R09: 1ffff11003f84852
R10: dffffc0000000000 R11: ffffed1003f84853 R12: ffffea00015c8e00
R13: ffff888055755d08 R14: ffffea0000d5d108 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff88808d21b000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fffb6eacfe8 CR3: 0000000054de7000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 migrate_folio_move mm/migrate.c:1301 [inline]
 migrate_folios_move mm/migrate.c:1653 [inline]
 migrate_pages_batch+0x1c34/0x2830 mm/migrate.c:1900
 migrate_pages_sync mm/migrate.c:1930 [inline]
 migrate_pages+0x1bcc/0x2930 mm/migrate.c:2039
 compact_zone+0x23f4/0x4ad0 mm/compaction.c:2683
 compact_node+0x1d2/0x280 mm/compaction.c:2952
 kcompactd+0xbc8/0x1290 mm/compaction.c:3250
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


Tested on:

commit:         155a3c00 Merge tag 'for-6.16/dm-fixes-2' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11eb8382580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f62a2ef17395702a
dashboard link: https://syzkaller.appspot.com/bug?extid=4708579bb230a0582a57
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=150808f0580000

