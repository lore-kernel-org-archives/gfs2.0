Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4C1233701
	for <gfs2@lists.linux.dev>; Mon, 14 Jul 2025 07:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752477816; cv=none; b=fHLAetDpN8WZl28LtPPoADt1Va1DP6jjexeEI6g4RHWpNUHzX6EzNuhj7ghefALtMKBHMUgX4QxflBDRQvLPFzCNU1NxLchDN4sZflA/L58f7JG3X+/wE5a1dZUYhkmOCl0Okzy72j86/50pitwburrM0BcPMomSXx6Wzhu576Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752477816; c=relaxed/simple;
	bh=ayW077Gk2pvt3Hw6dVG5Yg2VKry/Kayw1iHiNu51UC8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=YKTOJqd0/JRE7HOLhEQgVHJJbGixViyk9XRUWctSWzZm0I0LdCxm3cLDd7d1IFzmMD7N7i4Ui9IZm9KaLDzhExMBx2XUOwLC8B1wwm3qMX15ls0BIywKgIyjgonM5hRkMw/TETMhBVB0X9IgvTV8fcfUw2tp9iWTrkhQIXc8Yxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3ddbec809acso48221935ab.2
        for <gfs2@lists.linux.dev>; Mon, 14 Jul 2025 00:23:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752477814; x=1753082614;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BnrSjNkG3/uaXhOO/o2sQgdxidCRv7vVZ1X52wDBqS8=;
        b=PiirdzyR/aHq7H2UghT6yzp7adwb4eqafLKl8sul1H9LOYRpq911n6gJ6qdRRy9ds0
         8tDP2zWoA2gXaMXJjktV9qYTdK0ZGrL7pctcrwxN+QZ4drwK8iABNh7zrp2k3fpTa774
         15+lz4tDrLvghsVi8wl2cCCB3YC+v2dLxMOVdJVwNKvQDI5quHulzeZlFTx2eDOEM5x/
         X4/gxslrgFyLz1pl+3d202Ma8IdH492+ZEQH/V1/V3QTKTD5+AqPGBuAibokDiHjZDev
         M6AV0aHrzF/D39kXosiNw24Y82FCaRw41iQ1EGFJjXZoPuFgrJNAlEaAovGY2Ic7Hq3D
         C+ig==
X-Gm-Message-State: AOJu0Yz+diTbzM2flMBDtSR46geaReJBFIyqE8eQb0YaJtQof5HzM8ku
	K/CHIYMUfyPY5y1NXkUxG1wTxCEvxMixRWWCcQmqbW81YMIcUXtYvlZZLd0Eh8HPw7pBpX9NXOy
	wNDFK19+IqcemqFG7xyzwTD4odhAphcWvvqxJwZJn/CQn6VEus1PsS8rv7Lg=
X-Google-Smtp-Source: AGHT+IGdCHUa+pREzYVT/fJ+UZ5bQW6X7dVgoNVel3kmofbNf92QjDptPa5wKag7BTHjheHNeD9l03cafOladEMcDE89kl8gUKrW
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2166:b0:3de:12ba:7d6c with SMTP id
 e9e14a558f8ab-3e2532799e5mr145101745ab.8.1752477813853; Mon, 14 Jul 2025
 00:23:33 -0700 (PDT)
Date: Mon, 14 Jul 2025 00:23:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6874b075.a70a0220.3b380f.004d.GAE@google.com>
Subject: [syzbot] Monthly gfs2 report (Jul 2025)
From: syzbot <syzbot+list034a5bbd793492eeb988@syzkaller.appspotmail.com>
To: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello gfs2 maintainers/developers,

This is a 31-day syzbot report for the gfs2 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/gfs2

During the period, 2 new issues were detected and 0 were fixed.
In total, 21 issues are still open and 37 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  2518    Yes   kernel BUG in gfs2_withdraw
                   https://syzkaller.appspot.com/bug?extid=ed42f17ebcb58526788c
<2>  1392    Yes   kernel BUG in gfs2_glock_nq (2)
                   https://syzkaller.appspot.com/bug?extid=70f4e455dee59ab40c80
<3>  357     Yes   KASAN: stack-out-of-bounds Read in gfs2_dump_glock
                   https://syzkaller.appspot.com/bug?extid=7efd59a5a532c57037e6
<4>  288     Yes   INFO: task hung in __gfs2_lookup
                   https://syzkaller.appspot.com/bug?extid=8a86bdd8c524e46ff97a
<5>  98      No    kernel BUG in __gfs2_glock_put (2)
                   https://syzkaller.appspot.com/bug?extid=ef4ad020dc976d178975
<6>  44      Yes   KASAN: slab-use-after-free Read in folio_evictable (3)
                   https://syzkaller.appspot.com/bug?extid=4c7590f1cee06597e43a
<7>  41      No    WARNING in gfs2_put_super
                   https://syzkaller.appspot.com/bug?extid=56182be23469e01affbc
<8>  32      Yes   WARNING in gfs2_ri_update (2)
                   https://syzkaller.appspot.com/bug?extid=7567dc5c8aa8f68bde74
<9>  31      Yes   KASAN: slab-use-after-free Read in gfs2_invalidate_folio
                   https://syzkaller.appspot.com/bug?extid=3a36aeabd31497d63f6e
<10> 29      Yes   INFO: task hung in gfs2_glock_nq
                   https://syzkaller.appspot.com/bug?extid=dbb72d38131e90dc1f66

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
