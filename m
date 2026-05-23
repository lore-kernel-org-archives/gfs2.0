Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F74384235
	for <gfs2@lists.linux.dev>; Sat, 23 May 2026 12:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779539565; cv=none; b=WsuRU0Hqhfq5USjdDWc2OS92hBZ4XpEAKZJ5Un+iHoZns0eTQ0pAwxjVkl7b99g5aJySYpA0s3AoiJl1tczeNBQMEAV/5SZiZ7HZh1l4KDF6BYwVq/UW4I+4wIjpivVsfiwVWn/al5KoWnAEUcFixCvB7gkF41xGiupxAB4ph4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779539565; c=relaxed/simple;
	bh=UbeZ36PYH+yKCAMwMkxyEgOJ/RrC5sRT9nWc1MBTgK0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=AUtuhRXAMCuE/9tb4+AHooz9urOF725Y/DZxvJY/q46P2QPtUA8iQ4nT9DyTLHNyYXxbe7N91VxzRlOxmRe6QLmj4zzolnw0rdQ/aUrpnTQTSkAS2HGqHOWorsn2vZYK6vKUSuNON+kdg6TUuueUwtT5fxGj3SjJlXf9afZGf0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7e620d2c5e5so702546a34.0
        for <gfs2@lists.linux.dev>; Sat, 23 May 2026 05:32:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779539563; x=1780144363;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LcsIhy8pIdG9Lvfku1Vxlvjwtqaa6H3Omds977zl9gw=;
        b=b8ekbaNJW8+4Y5AM7qHqLplCWr9ZCO8NRQ/HFVX4yVuwO+9LoSUMCG6kbxmWemMc5X
         asoxRIJaA+Ige/REI73gcxSphRvPuh8g7r91Ph0/LXGAM/IrphoX/skA0L/PoB89ApzA
         QfQHeEozatVpKIfBZGWUqNe7BLj3aVDJx+9IFt7PUO7fHToVnxw6o2tm3wudcIvwjlFa
         rXJnca2grLFnEA34YFgIf6iJAaCBeQU315c/Sm52iuFfrWQT1dk7LVuK6AxRd0qoyMLd
         cwJkchl/g3odFehkYa8XbzKDzMEKOMZylufeFgtReseLYNC3hc+9P5gKJ8kXPx6FC0bW
         jY9g==
X-Gm-Message-State: AOJu0YzpE5nZ4a44Co0SDsQ8TA/MMv9Z6rCCqB3ZQ9HnuDahUuK0t9R7
	rttH7keDBuUk4ZLlfK1SRoBSBVSqg8bMXkjri8oKbL9l/2z74YY4h3rT59LzJlOS+D5NPWS4uf6
	5aN52LLYgfYXTlSdGZZ7RMV1DnEpbfH0f5bGkih4vWzkvO8QexKNfm6+a+Oc=
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:201:b0:696:89d9:e215 with SMTP id
 006d021491bc7-69d7eb6b378mr3951035eaf.20.1779539563302; Sat, 23 May 2026
 05:32:43 -0700 (PDT)
Date: Sat, 23 May 2026 05:32:43 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a119e6b.170a0220.35b2b7.000a.GAE@google.com>
Subject: [syzbot] Monthly gfs2 report (May 2026)
From: syzbot <syzbot+list792ff7e60f79eeaa9303@syzkaller.appspotmail.com>
To: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello gfs2 maintainers/developers,

This is a 31-day syzbot report for the gfs2 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/gfs2

During the period, 0 new issues were detected and 0 were fixed.
In total, 33 issues are still open and 44 have already been fixed.
There are also 3 low-priority issues.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  413     Yes   KASAN: stack-out-of-bounds Read in gfs2_dump_glock
                   https://syzkaller.appspot.com/bug?extid=7efd59a5a532c57037e6
<2>  72      Yes   INFO: task hung in gfs2_recover_journal (4)
                   https://syzkaller.appspot.com/bug?extid=9013411dc43f3582823a
<3>  49      Yes   WARNING in gfs2_ri_update (2)
                   https://syzkaller.appspot.com/bug?extid=7567dc5c8aa8f68bde74
<4>  2174    Yes   INFO: task hung in __gfs2_lookup
                   https://syzkaller.appspot.com/bug?extid=8a86bdd8c524e46ff97a
<5>  1455    Yes   kernel BUG in gfs2_glock_nq (2)
                   https://syzkaller.appspot.com/bug?extid=70f4e455dee59ab40c80
<6>  92      Yes   kernel BUG in qd_put (3)
                   https://syzkaller.appspot.com/bug?extid=0423714c06c369318794
<7>  91      Yes   kernel BUG in gfs2_quota_cleanup (3)
                   https://syzkaller.appspot.com/bug?extid=af4d53576692f8956fd6
<8>  28      No    general protection fault in gfs2_glock_dq (2)
                   https://syzkaller.appspot.com/bug?extid=5a5f492ccae698fd7434
<9>  14      No    kernel BUG in gfs2_trans_add_revoke
                   https://syzkaller.appspot.com/bug?extid=b17a83b050e9617376f0
<10> 12      Yes   KASAN: slab-use-after-free Read in lru_add (2)
                   https://syzkaller.appspot.com/bug?extid=8921d5debffa05b33b27

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
