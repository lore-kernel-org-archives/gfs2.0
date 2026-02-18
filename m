Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC1E2BD030
	for <gfs2@lists.linux.dev>; Wed, 18 Feb 2026 13:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771420830; cv=none; b=q6V5DFbLh6kpMR6Y2ni3VVH+7ROcjaUtFaJaLWNDJMXmODs3MvEmUgAtYss3gLcynSm6Lr7vnr5jMc1lCpCFMN6GOp3KRm3ysW6UvXBTO04Vxtfmh6NHvRHILY1rZyZsaFKxjc8XhrRCzE4EnOIN6fXJs+yIFbGqqqg+GT/m3Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771420830; c=relaxed/simple;
	bh=CEAGDoFoVMhjoXBVlBcYRZzvdefsgxvfjmpYRLBAWFo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=OfHgq79omVfdTy2KViQ0CiQ6Veq9nBUiZS0gzwQikLHRZ/mJ9WUjbhJgZosQi9czDaS1aMJAuOrF0RbRjYnAbZuq5UrJsgLlLo87mpfokbQ3yv3VXTF0h0BaqTPICT1uExj54ey2fE2IJiz+aY2yr8dciVm0zN8ydq8p2bgLKu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-40efa542b8aso44609035fac.2
        for <gfs2@lists.linux.dev>; Wed, 18 Feb 2026 05:20:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771420828; x=1772025628;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cnbsdVL0Z6XBcVjkAppqJTHMjSnIX3jPUvVn18hraFU=;
        b=OmjPZnyqXlHoTDm2gmjvJhck9dV42Qz+MmGPLFTfYTxGVYaTNW+9jst2hB3wz/D4Uv
         /oHMRk8voqX5+AKnqBoJNExNGvj7jYlIg0e8KBAQJWW6b6i4EeJJvgbbv5xWrTKvDUdn
         MrSuH+pNrS4sJcxNtVjix51sUOO5o1SqVqOKp/ZqyeJ13wrDQgN4n+Dq/JaPT6I3rwHX
         7p6hlIi9Uo11s0dgaSI//XLCLh52i6MpDLkEig9bjL26RO1ATKkZOUGjMFsHNQ/HnV9C
         djcCPmiUPFq6BGyScfUCO86VosfREh4vpqFB90QRfjdwWjpfbXKIclSRC0wIFHxPvbjk
         BDKg==
X-Gm-Message-State: AOJu0YyCDB4ECfVllXUdXVw2q7hv9W+01bvBg6gTdOEUqvnyiGHfaW74
	K0U2gR0YlykTHzhR2sn444ZvLYECSA7hS9Cr/mPUkjX25WBsdhMd5FlOQwLQ69rrVq1X/SxzC8E
	CsWc8t+3oCAbfPMINmrUB742k9/UnAXNl3qod1I2fIffALuCjb4/f9iZwv5o=
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:151b:b0:65f:1012:69c5 with SMTP id
 006d021491bc7-679a748c16bmr876795eaf.76.1771420827892; Wed, 18 Feb 2026
 05:20:27 -0800 (PST)
Date: Wed, 18 Feb 2026 05:20:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6995bc9b.050a0220.b01bb.0029.GAE@google.com>
Subject: [syzbot] Monthly gfs2 report (Feb 2026)
From: syzbot <syzbot+list6cba931c478e5ba16b4e@syzkaller.appspotmail.com>
To: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello gfs2 maintainers/developers,

This is a 31-day syzbot report for the gfs2 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/gfs2

During the period, 2 new issues were detected and 1 were fixed.
In total, 41 issues are still open and 43 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  1902    Yes   INFO: task hung in __gfs2_lookup
                   https://syzkaller.appspot.com/bug?extid=8a86bdd8c524e46ff97a
<2>  1444    Yes   kernel BUG in gfs2_glock_nq (2)
                   https://syzkaller.appspot.com/bug?extid=70f4e455dee59ab40c80
<3>  1148    Yes   kernel BUG in gfs2_jindex_free (2)
                   https://syzkaller.appspot.com/bug?extid=150563285f78ac3e9bd4
<4>  626     Yes   WARNING in vfs_setxattr (3)
                   https://syzkaller.appspot.com/bug?extid=5ce48a14916462cec450
<5>  401     Yes   BUG: corrupted list in list_lru_add
                   https://syzkaller.appspot.com/bug?extid=092ef2e75c24d23f33c4
<6>  240     Yes   WARNING in do_mknodat (3)
                   https://syzkaller.appspot.com/bug?extid=0cee785b798102696a4b
<7>  211     Yes   WARNING in chown_common
                   https://syzkaller.appspot.com/bug?extid=04c2672c56fbb9401640
<8>  157     Yes   KASAN: slab-use-after-free Read in gfs2_invalidate_folio
                   https://syzkaller.appspot.com/bug?extid=3a36aeabd31497d63f6e
<9>  146     Yes   KASAN: slab-use-after-free Write in gfs2_qd_dealloc (3)
                   https://syzkaller.appspot.com/bug?extid=42a37bf8045847d8f9d2
<10> 126     Yes   INFO: task hung in block_invalidate_folio (2)
                   https://syzkaller.appspot.com/bug?extid=85194ada5aabdfff265b

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
