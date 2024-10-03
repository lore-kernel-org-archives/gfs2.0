Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC4012CD89
	for <gfs2@lists.linux.dev>; Thu,  3 Oct 2024 09:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727946208; cv=none; b=sxIFl1BYLxvs0yDbPcoKLEzOqgggDM5i6S5Tr28L7scR5w4e2aDVpw2m+Ws8ZAH7KSpLaS1dxpArr3hzG3isFBVkzxwCP0ZhorkutbgBz1uziaSFqWXiNdIQjyFvt0DEOCbD7WH+JiHfd2nvGWHkvJe/u/0Tmolo6bCXjcLl41Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727946208; c=relaxed/simple;
	bh=drR1l788D9mRPiNJFjzNSSN1fgY8nMeZhgMBUbGXkY4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=dHPQcDlkks3K61qCWS55UCtdOWOC9eb5efrmKJAJJlFxH4U2iOaE0CwfwrMPX6hx3GbnnSlaqWPmDNDSTfXSaj7N/N8HOmyP2mEPW3l6H2+zWUgWcA84YrppqhDfyA+Idy4DIpAn5HnJM96TWOq/Dsy/Rg4TJcyL9KZL2TRD3no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a1a8a4174dso7482415ab.1
        for <gfs2@lists.linux.dev>; Thu, 03 Oct 2024 02:03:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727946206; x=1728551006;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dU4a2t1oKs9S+lHM5kucxZWO5tZk9Ss5D5YXPR7ufkQ=;
        b=qMO628XzM3AQ8rXJR+U1+087FiY2huYg+Ax4GWcmSiK4ir3KmuwFpFO1pMS0BAYX4N
         QTSL4YsRF6n+qe0LGLbz5SVKplL8aA/PDUe67Gez2kkU7yNswLME5TeUatSaIou7iRf6
         GSTIcwV3S6Sfwp+qBkf36G99p8iA6UdD8jOACg9UU4ZmK5EdaBWRdKKF25AGng6oAcIh
         q3gm4b1J7GqJ7/33hOSP9r403XJWVtBibLC7CR/BI9dqQjq4Ht0jy0Rv6P1izHNsKpw/
         jkC51dEeFlegwHSYp87Sr3yrtGUeqylIKX1J3Qp7lx4+4o1wRg7wtsdpKb/+o9JfgxXf
         mc9w==
X-Gm-Message-State: AOJu0Yw3mh8WhoBLflPxAqVyLOi/tdV2i5GmG3lCMdFjUUJiHwcuKmJq
	PpMrU1+5pBAcqGaeUMYLh8J3l7Xtt/lxDioNmiByCEzA0mHLjkij7dONXpPWgkQ4sI4SlcHiviZ
	MEkAMUao7TxsmF9U+ourT6HqkylmKTDdZJMKuEJ5X/OdJvuFEPITf3N0=
X-Google-Smtp-Source: AGHT+IGWvTcNXXQvfvJJtLOAawQZqurErzp2lWk9ddQ+qYXfYmI0xMgOC25VglL86kXCErEuI6QnnwcUm0i8/B/ZRdiKdr1u8zMs
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a05:b0:3a0:9244:1916 with SMTP id
 e9e14a558f8ab-3a36592b8c9mr54055635ab.11.1727946206058; Thu, 03 Oct 2024
 02:03:26 -0700 (PDT)
Date: Thu, 03 Oct 2024 02:03:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66fe5dde.050a0220.9ec68.0035.GAE@google.com>
Subject: [syzbot] Monthly gfs2 report (Oct 2024)
From: syzbot <syzbot+list989caf6985e8118d71b1@syzkaller.appspotmail.com>
To: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello gfs2 maintainers/developers,

This is a 31-day syzbot report for the gfs2 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/gfs2

During the period, 4 new issues were detected and 0 were fixed.
In total, 16 issues are still open and 32 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  544794  Yes   WARNING in __folio_mark_dirty (2)
                   https://syzkaller.appspot.com/bug?extid=e14d6cd6ec241f507ba7
<2>  15162   Yes   WARNING: locking bug in gfs2_fill_super
                   https://syzkaller.appspot.com/bug?extid=ee157488ade46c021ef4
<3>  1320    Yes   kernel BUG in gfs2_glock_nq (2)
                   https://syzkaller.appspot.com/bug?extid=70f4e455dee59ab40c80
<4>  249     Yes   KASAN: stack-out-of-bounds Read in gfs2_dump_glock
                   https://syzkaller.appspot.com/bug?extid=7efd59a5a532c57037e6
<5>  104     Yes   kernel BUG in gfs2_withdraw
                   https://syzkaller.appspot.com/bug?extid=ed42f17ebcb58526788c
<6>  15      Yes   WARNING in gfs2_check_blk_type (2)
                   https://syzkaller.appspot.com/bug?extid=26e96d7e92eed8a21405
<7>  15      Yes   WARNING in gfs2_ri_update (2)
                   https://syzkaller.appspot.com/bug?extid=7567dc5c8aa8f68bde74
<8>  4       No    possible deadlock in gfs2_trans_begin
                   https://syzkaller.appspot.com/bug?extid=5baab0d4d584f7b68982
<9>  2       Yes   KASAN: slab-use-after-free Read in gfs2_invalidate_folio
                   https://syzkaller.appspot.com/bug?extid=3a36aeabd31497d63f6e
<10> 2       Yes   kernel BUG in gfs2_assert_warn_i
                   https://syzkaller.appspot.com/bug?extid=ffe01cefd437cbde362b

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
