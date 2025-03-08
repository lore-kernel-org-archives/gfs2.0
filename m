Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871B614A8B
	for <gfs2@lists.linux.dev>; Sat,  8 Mar 2025 22:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741472187; cv=none; b=J7WWXrfeBftkjK4ja3ym+ZTXciYrMm7Ls/auz7dOuFg+oQESIwWSD+N28fEra9b+9VNSYeTScJzclEphDvo1XrToMBgHBGYLfxspABBiqVuTLDNlhzhPtoGYaqykZ7PVzjZA9hbnC29b5CeeR3jpmqSrfeLeVZyzg5nP0F8LAHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741472187; c=relaxed/simple;
	bh=OX56n8q23Q9G2LJ9j95QhOp2ZVlGHnFdzcq1w1E8Zfg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ZXn9KAJMlvymXvTLRQu1f+uI8yEL2gI8ktEEDQcfE6H5gJc31/1DDeIlwYSrqcNvKXJm7OaKxQ7PglNloDFk9v75cKJD9Lh5CtYJvOX8foaEUO9nDW/x7HNXo2Y5K8OpYM44nurHb47kvNW9YNzE8+deFGjRNtSy5yD2qsWjL0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3cfb20d74b5so27765625ab.3
        for <gfs2@lists.linux.dev>; Sat, 08 Mar 2025 14:16:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741472184; x=1742076984;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I06yOoTvrP7l2/KfUugZyZE655AtTX5fTsIzbRcl1io=;
        b=aSz6fgvCyy1bxeMKtxA4q12WyZeDBAVSEi5Ip4a5d/JCn0+JoKNPSq8J8y5lcAeeCL
         KW4UP8/o+DEFgNDZ4uWK7nu8IYj0IOQyK5KJNMeVU395ge+1UIcy6EIt1LoxDVabD/Rk
         vDXOnBn4DC1QQtC2YJG42UZou049JUzARlpdyTYusgpBaTa2SRSxv+Ys233f5yhSHNzn
         oarIusoCFtplTI7PS3CzdcmIwDH035xHr9aeR06X/ggbeFtTWbSGZrru6Wn0evjNRval
         LUZ/8ZE8lnRZdp0LbgCZyhHgaza7jyFQ8dtyx0DuOGc/UPBGLk8qpJanTqzlmJtNE0XP
         Ipgg==
X-Gm-Message-State: AOJu0Yz8fIq62GYCte4zwlpE2dzECfB1aqfPqo3h/chj25fTfZAS1eiW
	AJuUOsNMh+7fCNSCeLz/0tEei7aBqJg0cRRBwueJbC8wcGkXjyqXmNUI9/SRY8+qljxu2dPUEwW
	H6l5QbOUn/mMn0rhhUkzzhepbIt3uHlLh/6ykGEGSU9dyQxQvWRBh6mE=
X-Google-Smtp-Source: AGHT+IEhqRQrbFz34VlOThC4r7/U8s6uzHK9ZmOa7IV5tRfMCzVcI0/AjB4TJzXfPWltjvgJmT3PJ3qtRE97nrajbVvTRA0E4sTx
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aa5:b0:3d3:dcc4:a58e with SMTP id
 e9e14a558f8ab-3d44196903cmr101828515ab.8.1741472184726; Sat, 08 Mar 2025
 14:16:24 -0800 (PST)
Date: Sat, 08 Mar 2025 14:16:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67ccc1b8.050a0220.14db68.0057.GAE@google.com>
Subject: [syzbot] Monthly gfs2 report (Mar 2025)
From: syzbot <syzbot+list62f9bd376d8518ca2cbe@syzkaller.appspotmail.com>
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
<1> 700150  Yes   WARNING in __folio_mark_dirty (2)
                  https://syzkaller.appspot.com/bug?extid=e14d6cd6ec241f507ba7
<2> 1406    Yes   kernel BUG in gfs2_withdraw
                  https://syzkaller.appspot.com/bug?extid=ed42f17ebcb58526788c
<3> 1359    Yes   kernel BUG in gfs2_glock_nq (2)
                  https://syzkaller.appspot.com/bug?extid=70f4e455dee59ab40c80
<4> 345     Yes   KASAN: stack-out-of-bounds Read in gfs2_dump_glock
                  https://syzkaller.appspot.com/bug?extid=7efd59a5a532c57037e6
<5> 30      Yes   WARNING in gfs2_ri_update (2)
                  https://syzkaller.appspot.com/bug?extid=7567dc5c8aa8f68bde74
<6> 29      Yes   INFO: task hung in gfs2_glock_nq
                  https://syzkaller.appspot.com/bug?extid=dbb72d38131e90dc1f66
<7> 17      Yes   WARNING in gfs2_check_blk_type (2)
                  https://syzkaller.appspot.com/bug?extid=26e96d7e92eed8a21405
<8> 14      No    general protection fault in gfs2_glock_dq
                  https://syzkaller.appspot.com/bug?extid=48ae9388c13bf60ba2c9
<9> 10      Yes   KASAN: slab-use-after-free Read in gfs2_invalidate_folio
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
