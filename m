Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20E71D9A40
	for <gfs2@lists.linux.dev>; Mon,  6 Jan 2025 10:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736157688; cv=none; b=N2xgcDWTxFo8XhvQeDXOhU3Vg1VYp4S7dGiPCMCKx0X1rw3kaN3hQonRKfitZqH4WY5Sn7dmY/XVGxcoMWjR2eycjw2zztNRahoZU3NEWzerNjkhPoQ+b9RvwDOtkxZwafvgFh/0kqx6rgDNICUIWaQWbcoOrqoK/QnXsKseEHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736157688; c=relaxed/simple;
	bh=VVrFoK7KDqPYn2rKoK4noL3weMpKPRpBI0e3aUczvEc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=WrefJ6Pjlh3veZrsgk/3bY10mjxcOet1pBgDMWvvzHG3kxn+hiXpwl7711mVbf9xUaBHdfAQDD3ZxAsf4ROakBNiTfDIltMPZ/e6Ie0I/Cgu1iDY+eAsdrzYaASIy8ozev6gsG0dYtAjCQdYCtBfnvy45PL6RtT1V7zf4oMhedo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a814c7d58eso150427385ab.1
        for <gfs2@lists.linux.dev>; Mon, 06 Jan 2025 02:01:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736157686; x=1736762486;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cnthWUzc8DwvrN9itiR8Xhbtj3h1UYI0nnaS2yhMSlM=;
        b=rKurYbuH0MZpV0WbnyLG4BPazNaaXE6+mE+vkyH50ddra3ynIqpCUxq6iCsPg9+y/d
         kmC6T9KNohJb4+Ir9DzYfeY95CjNQA6DbR3N5jsxSbdJhCvDc97DZo/dNM1CH00fmStW
         GGqGV1L8t/br6MyBEq6JgQqqlZMwdBte9vI+UNMPKXo1qrfuDc8lBBnlK3dcpigQ94oI
         zsNM+qb4HO3w2Wi6Hc3zMUwy+gf+RMQT+FRpEsqycXa3pzNrR52dZhwSrtpH7HB3qdYc
         ziiXrdD9Vhrf0ohP+ZHmeJVglsSMMjMDYJllJQb6P+qDMypElAG38RbvOUMFMPO9SaXc
         39dQ==
X-Gm-Message-State: AOJu0YwathzHQOfCrb70slULVtrAF/dLrSYkktjuwgsWiwBLJ6PtOoIu
	RAZhP40gwCbx/3mnQnfNdrfTj7LJ22JTReLviL92Rzu5Ax8+zDZlzjT0iofRxbZ44gUPfEbGBqN
	7XRmdQy9e5PB6Gr3534YXe5tpJx1x4dUsc8p7glecYS2uL0T6KxB59tA=
X-Google-Smtp-Source: AGHT+IEniCMxokF00tKZ3ZXIyWJOZs48yp0sUm8JAz7wHc7+GAV0JqmBDpZZwurgY5hp0O8OOZmpLfGHN5UPG8K1BUEW2Th8iCZ/
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1ca5:b0:3a7:a29b:c181 with SMTP id
 e9e14a558f8ab-3c2d2d4f1e4mr435583225ab.13.1736157686061; Mon, 06 Jan 2025
 02:01:26 -0800 (PST)
Date: Mon, 06 Jan 2025 02:01:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <677ba9f6.050a0220.a40f5.0004.GAE@google.com>
Subject: [syzbot] Monthly gfs2 report (Jan 2025)
From: syzbot <syzbot+listb58444abba4ac0e01683@syzkaller.appspotmail.com>
To: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello gfs2 maintainers/developers,

This is a 31-day syzbot report for the gfs2 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/gfs2

During the period, 1 new issues were detected and 0 were fixed.
In total, 15 issues are still open and 34 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  635844  Yes   WARNING in __folio_mark_dirty (2)
                   https://syzkaller.appspot.com/bug?extid=e14d6cd6ec241f507ba7
<2>  1342    Yes   kernel BUG in gfs2_glock_nq (2)
                   https://syzkaller.appspot.com/bug?extid=70f4e455dee59ab40c80
<3>  928     Yes   kernel BUG in gfs2_withdraw
                   https://syzkaller.appspot.com/bug?extid=ed42f17ebcb58526788c
<4>  337     Yes   KASAN: stack-out-of-bounds Read in gfs2_dump_glock
                   https://syzkaller.appspot.com/bug?extid=7efd59a5a532c57037e6
<5>  133     Yes   INFO: task hung in __gfs2_lookup
                   https://syzkaller.appspot.com/bug?extid=8a86bdd8c524e46ff97a
<6>  30      Yes   WARNING in gfs2_ri_update (2)
                   https://syzkaller.appspot.com/bug?extid=7567dc5c8aa8f68bde74
<7>  29      Yes   INFO: task hung in gfs2_glock_nq
                   https://syzkaller.appspot.com/bug?extid=dbb72d38131e90dc1f66
<8>  17      Yes   WARNING in gfs2_check_blk_type (2)
                   https://syzkaller.appspot.com/bug?extid=26e96d7e92eed8a21405
<9>  7       Yes   kernel BUG in gfs2_assert_warn_i
                   https://syzkaller.appspot.com/bug?extid=ffe01cefd437cbde362b
<10> 7       Yes   KASAN: slab-use-after-free Read in gfs2_invalidate_folio
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
