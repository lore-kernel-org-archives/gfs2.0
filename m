Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319BC2951C9
	for <gfs2@lists.linux.dev>; Mon, 12 May 2025 13:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747056880; cv=none; b=HhEGH6dEIoFNuxhzUL/J6bc+5ieh1C39826mxYQL0Sb6++Ljid6hNQ1iJMODj6Fjr3bKB2697IHNaplHMCvkCCAkT8O7hGNjYHvjw9SIqgdPHUNvwpg6vluXcmZc8dYGsCslQvN+A/kNoW3ZcWbKiyrHO+ZG7m/pCoOsbEneqAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747056880; c=relaxed/simple;
	bh=R5GMYtFj0h4A7mc3vAohAShmVyD3Xpx77U7uj36wtYU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=qRwIke/BMuFVYFIByHqpPkCqMPWYZAtgMe4hd0hcHL1UXC6fSewfAlGHoaF11iEpVUbJ5YY5JWFt8l0ORhO9wPqqCxaIYmaQp88Ua1t58dcCOO5zXVw3L5ouN92iHPKVb6Jz+jibEZdGFTtd38AhpYJ0bFj2HGEW7QbznqDq6og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.219.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6f6e59df2f3so60060296d6.3
        for <gfs2@lists.linux.dev>; Mon, 12 May 2025 06:34:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747056878; x=1747661678;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wpzm94ef45sTLmkJ+/qIsa0Ro4johfQXs/vt1jnkyuE=;
        b=bmLw5JzGUjlonR7pfeXxhC1F5RFjvmwtp02x034XUj6V0i7jwTx83G2XisL/kRj5B4
         zPN/Ynq4jJT623cU8NbWJbZvRP4TqwSXbEOWgQ+nQWjT89czltRMtGbmZ29UJYdiBP1E
         5cU0yLWl4VsbVlc+e4E3iGNi3MmxYlQqQNvzt2leIG298aOJUI8m4qSyQ9sP1mtMp9oZ
         58PysERZGWpwa154IzwmkcHof6ZsgMAshOjuZHwF+23xcOHfcOz23BmcI6Ox+PatZO/K
         d/uSEFgRf7djZIJ3bcr8opFMHZp/g8VGsec1vT9xFXMowxFY/oixXui5mxRd8DmAb0Ej
         yJkg==
X-Gm-Message-State: AOJu0YzeUaKMsf5TsGHgO3cW9CMfifJpScCAFI1Fl66PSfSycYEVJCwj
	CeKOu5sDWlqyCV2KrIE9X9zppJhHYP5Y7m3o3CLr9SyCqSzpylk5ebdHVOJpy0/n97U8GamcJ5k
	rxxSmnVHw8gqAwO7T/Vdmh1mltU1mPyNwjQmVSUrhilg4qC4SDKebgKU=
X-Google-Smtp-Source: AGHT+IFXdt4ENEPXB7sK2eyZrcIwteG/hOKBe3Z9UfACWApKzBiXqyWOkChvtmQx9kcBvhPizqRB+9JrJs9FVGH6Q6FAaK0s8nAg
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1945:b0:3d4:70ab:f96f with SMTP id
 e9e14a558f8ab-3da7e1e73f3mr147928045ab.8.1747056867646; Mon, 12 May 2025
 06:34:27 -0700 (PDT)
Date: Mon, 12 May 2025 06:34:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6821f8e3.050a0220.f2294.0060.GAE@google.com>
Subject: [syzbot] Monthly gfs2 report (May 2025)
From: syzbot <syzbot+list6c60f00c820c2d824539@syzkaller.appspotmail.com>
To: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello gfs2 maintainers/developers,

This is a 31-day syzbot report for the gfs2 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/gfs2

During the period, 1 new issues were detected and 0 were fixed.
In total, 13 issues are still open and 34 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 1992    Yes   kernel BUG in gfs2_withdraw
                  https://syzkaller.appspot.com/bug?extid=ed42f17ebcb58526788c
<2> 1376    Yes   kernel BUG in gfs2_glock_nq (2)
                  https://syzkaller.appspot.com/bug?extid=70f4e455dee59ab40c80
<3> 30      Yes   WARNING in gfs2_ri_update (2)
                  https://syzkaller.appspot.com/bug?extid=7567dc5c8aa8f68bde74
<4> 29      Yes   INFO: task hung in gfs2_glock_nq
                  https://syzkaller.appspot.com/bug?extid=dbb72d38131e90dc1f66
<5> 18      Yes   WARNING in gfs2_check_blk_type (2)
                  https://syzkaller.appspot.com/bug?extid=26e96d7e92eed8a21405
<6> 10      Yes   kernel BUG in gfs2_assert_warn_i
                  https://syzkaller.appspot.com/bug?extid=ffe01cefd437cbde362b
<7> 5       Yes   KMSAN: uninit-value in gfs2_quota_init (2)
                  https://syzkaller.appspot.com/bug?extid=9fb37b567267511a9e11
<8> 3       Yes   stack segment fault in gfs2_glock_dq
                  https://syzkaller.appspot.com/bug?extid=e0dbe53de58ffe4a5f31

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
