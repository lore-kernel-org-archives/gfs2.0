Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55E721D5AF
	for <gfs2@lists.linux.dev>; Mon, 19 Jan 2026 08:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768810707; cv=none; b=Y5WovsdmD6zvbKWGdUlMIPOq8pb26DaTGJDyKm0s0T/qt8iRZFCSoGbiYINLX9Gy+xpU8F6ukSgShnEil4LMk0bi2Y3cive3KesP7cj0NWWoe1R+duE95enGmDO0BUv1/+KnACo1T0uenF7woh3yd0MUet2ceJ0ZLctYjTKRK/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768810707; c=relaxed/simple;
	bh=8WqwcVIyAuNzFKiAv3P7uQClLYTUpWumN6zkpaa4phI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=n3L4k07MQaKh/XvZCvaE7TEmI0mLggrRETZhTZyGTo0Bj9nwL9d3q2oqBOamrgVmGvWkGhMDUPBHsPadOJruMoy7ZKpGMezkt5aCMtS72lZ+rzDG3iROyos+V8SAEuxviMGEwfjsqedQd//EbZ052lvH4/EfUWkUSPawPg6ypK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-66110333b04so6501389eaf.0
        for <gfs2@lists.linux.dev>; Mon, 19 Jan 2026 00:18:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768810705; x=1769415505;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GBOZJz6DuEs4qqOayzhjyXuSgbeFyRvGebOc0kNb5Ug=;
        b=rkvM+/XUt1a6qu1Vf6Rwb98ywBb/MioqyPlZaGKLx9Cj4XouQ2joSf1DPSiOlr9X0B
         SlwUzfDOSLu3dOKs2lEfjS8gAUoaN+23rVthBGWq7dl/tnNza2rjHFjTEqGTxV+XeyYj
         IWS0DoSlxYdG+lG+KY1XIA5DwMzjCXH1p4Bg3c6JFODeMrzDM5JyhMCgP8WReSLHQzqP
         Ft5S7fzHTZCuGC3NlBjQ3WIVM3YB2vdahN9jAgp9tvcrKEpKsyD5LR1JXxAjB0TV6Tld
         doCFZMOtsHN3kTunqFYo4ULGG0+OiVWS46/FFWHQOHHm8pZkdwfimakrgZZ09mkgMku+
         7Fcg==
X-Gm-Message-State: AOJu0YwdvFoSHzH4ox53rd/58UaJ+LQNR/B6Tx+eeVmWUJcs2FJGfm8w
	VTakQr3wxyX/+GPIYWoqEShOOE9gAqjStJfKZiusb1UbXBZUKkkdbvZuik76IQFt26yCSediQnG
	EYPNRYVEHED4BLGxkY8eCVjVQvNsosyWpvYSPT+phCrZeJpqQ8jFVmaqQ0o4=
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4a0c:b0:65c:f583:d3d6 with SMTP id
 006d021491bc7-661189b6bbdmr3607701eaf.70.1768810704980; Mon, 19 Jan 2026
 00:18:24 -0800 (PST)
Date: Mon, 19 Jan 2026 00:18:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <696de8d0.050a0220.3390f1.003d.GAE@google.com>
Subject: [syzbot] Monthly gfs2 report (Jan 2026)
From: syzbot <syzbot+listd7413ccb1a116ef396da@syzkaller.appspotmail.com>
To: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello gfs2 maintainers/developers,

This is a 31-day syzbot report for the gfs2 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/gfs2

During the period, 2 new issues were detected and 0 were fixed.
In total, 41 issues are still open and 41 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  1439    Yes   kernel BUG in gfs2_glock_nq (2)
                   https://syzkaller.appspot.com/bug?extid=70f4e455dee59ab40c80
<2>  1437    Yes   INFO: task hung in __gfs2_lookup
                   https://syzkaller.appspot.com/bug?extid=8a86bdd8c524e46ff97a
<3>  831     Yes   kernel BUG in gfs2_jindex_free (2)
                   https://syzkaller.appspot.com/bug?extid=150563285f78ac3e9bd4
<4>  603     Yes   WARNING in vfs_setxattr (3)
                   https://syzkaller.appspot.com/bug?extid=5ce48a14916462cec450
<5>  502     Yes   kernel BUG in __gfs2_glock_put (2)
                   https://syzkaller.appspot.com/bug?extid=ef4ad020dc976d178975
<6>  402     Yes   KASAN: stack-out-of-bounds Read in gfs2_dump_glock
                   https://syzkaller.appspot.com/bug?extid=7efd59a5a532c57037e6
<7>  233     Yes   WARNING in do_mknodat (3)
                   https://syzkaller.appspot.com/bug?extid=0cee785b798102696a4b
<8>  191     Yes   WARNING in chown_common
                   https://syzkaller.appspot.com/bug?extid=04c2672c56fbb9401640
<9>  156     Yes   KASAN: slab-use-after-free Read in gfs2_invalidate_folio
                   https://syzkaller.appspot.com/bug?extid=3a36aeabd31497d63f6e
<10> 110     Yes   KASAN: slab-use-after-free Write in gfs2_qd_dealloc (3)
                   https://syzkaller.appspot.com/bug?extid=42a37bf8045847d8f9d2

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
