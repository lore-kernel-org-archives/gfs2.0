Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293A81401B
	for <gfs2@lists.linux.dev>; Thu,  5 Dec 2024 09:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733389468; cv=none; b=K/ry+wY+PNPOau0xls8gz8E9uhnbMiKCTvfYW3gCsNToB+Fk9tqIkNL7iUDVwjhuutSQ5Iv2d5w8EIXOldnjr2rBq7BMOid2G43Lhf55109SpOKibldQRSN3X3KwwFO4mMhbDPR0v44s/DqEBaBQpAutSRma9rTl9FDNabRQAJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733389468; c=relaxed/simple;
	bh=UI6cxBtpoXhC6l8/5MMqqAEglAQv4gFY7nrgv5fIlp0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=qyNhv4mVkaPrS2P4XnBTq0w0wLqSzxgVKS5GkFHDc7tj8NRJ7UgOLhUrAEuWEvL7nPcUaVAOxgWZ9zP6GKmRQLvMWe13aaJVlWyJXDNPI82FLvctMdz4G4eHoGubTIowh2wXelTexhe4FjpdFKIlZiyCoSjiEYfAl3CPXay3KXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a7e0d7b804so6665665ab.0
        for <gfs2@lists.linux.dev>; Thu, 05 Dec 2024 01:04:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733389466; x=1733994266;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ynnpAB+dKETSQS8JOngGO5ca8blmUDJ3fT2BlUIICa0=;
        b=xKNYFDy5tMl+95zh1+piu0Zq5Af0kcW9M/MFKwhCf8s6q9OQz7sVewnixLFIZLxJSd
         jWFy+EChaMCftHH2CyquMSVDdknStvwE//XHbT3fvEaUpGYqlPkwFVuUyf5y+EGue2uL
         kqu09Pwe5cB3C5jzkmQKWxJK8YBR0trTkppXU2aS4USWyiXW/CMaJVzhpEYWUhQEBuNL
         UMBevBCwJXuEn8SXtqEd/JySschD9aSnVmRLDA3OrHWJ4fHAvC5BiYdZju0JCOCzV4gx
         CDmFnDKiLmjki9EOwvSWX4wsuDl5fGNTL0RivFHgzxhFbZQHKNwxrxoOJyPsfqycX5PH
         tgUA==
X-Gm-Message-State: AOJu0YwHkguGjhk95NlIlaKB6U86PxNMK9NzgDW72uNBBUtXB/9RHuuZ
	a+yyKeLzYUaZlLKnizhVb2LDtKEHlANmW717quCNRhNbyZXygfvqx8fPgJuEke2vrQVi9aw+BmR
	Syu7C5TaLqqO12mfat+A2+IZkXJsYzU6NK6RkTn7zdxBhPfy3hYKCBF4=
X-Google-Smtp-Source: AGHT+IHTYALk19iTOYHvqLh69WaOXb8pJWPllGpUZ6TjP2weAiDByWBcsFqdj725Qpy4gAjYehGJHygM2snfPiRnOWkRYKIzrlsG
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a81:b0:3a7:e67f:3c58 with SMTP id
 e9e14a558f8ab-3a7f9a2fb3emr132399265ab.3.1733389466353; Thu, 05 Dec 2024
 01:04:26 -0800 (PST)
Date: Thu, 05 Dec 2024 01:04:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67516c9a.050a0220.17bd51.008d.GAE@google.com>
Subject: [syzbot] Monthly gfs2 report (Dec 2024)
From: syzbot <syzbot+list00589e0ae5eac5469961@syzkaller.appspotmail.com>
To: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello gfs2 maintainers/developers,

This is a 31-day syzbot report for the gfs2 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/gfs2

During the period, 1 new issues were detected and 0 were fixed.
In total, 16 issues are still open and 34 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 599473  Yes   WARNING in __folio_mark_dirty (2)
                  https://syzkaller.appspot.com/bug?extid=e14d6cd6ec241f507ba7
<2> 1328    Yes   kernel BUG in gfs2_glock_nq (2)
                  https://syzkaller.appspot.com/bug?extid=70f4e455dee59ab40c80
<3> 604     Yes   kernel BUG in gfs2_withdraw
                  https://syzkaller.appspot.com/bug?extid=ed42f17ebcb58526788c
<4> 301     Yes   KASAN: stack-out-of-bounds Read in gfs2_dump_glock
                  https://syzkaller.appspot.com/bug?extid=7efd59a5a532c57037e6
<5> 124     Yes   INFO: task hung in __gfs2_lookup
                  https://syzkaller.appspot.com/bug?extid=8a86bdd8c524e46ff97a
<6> 27      Yes   WARNING in gfs2_ri_update (2)
                  https://syzkaller.appspot.com/bug?extid=7567dc5c8aa8f68bde74
<7> 17      Yes   WARNING in gfs2_check_blk_type (2)
                  https://syzkaller.appspot.com/bug?extid=26e96d7e92eed8a21405
<8> 5       Yes   kernel BUG in gfs2_assert_warn_i
                  https://syzkaller.appspot.com/bug?extid=ffe01cefd437cbde362b
<9> 3       Yes   KASAN: slab-use-after-free Read in gfs2_invalidate_folio
                  https://syzkaller.appspot.com/bug?extid=3a36aeabd31497d63f6e

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
