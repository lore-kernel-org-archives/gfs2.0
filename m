Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA8B317715
	for <gfs2@lists.linux.dev>; Mon, 17 Nov 2025 07:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763365831; cv=none; b=R8rQ4V6Ot1Vjvs/nV92y4VoM/uzv3kn7cenCF7fg9DJNvSFObVJAZLxuPKgYlGj7sEXHJ5YizAPHY0euvq6ZihImVeGjjPrGOXk9kI8SJ46qxTFeePx1ipxoWCQCpDNZNLsUQUdFFFL1ccA89gXmL5J8W2jkTrjoNFUTm9GHRe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763365831; c=relaxed/simple;
	bh=1VzZnyN4unBFn7va4cxKXstzCrbOOHlFnFEn4pUJY0s=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=WMy381Vltj5M87mqhrlqdk2TJe9A1M6CgZQX0UtmmPVkxAtQemCljzePEsQRsFhebb5FEsWyInVAfp7307QpitKV7JFJ3oAVHlOR6wGyjL+hCKlsOc17a5FGOCF46b2Ha8/tHMG6G+W2q60G3SjSJ8SUn42XqNswkiui0ugmPxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-43331ea8ed8so38494655ab.3
        for <gfs2@lists.linux.dev>; Sun, 16 Nov 2025 23:50:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763365829; x=1763970629;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D2oiemNQNQuI77grN5TokXXDmUv6qOGDR4tltUPIYZQ=;
        b=VJ6rlgzAxJyvdcyx36BevhKvu9Ee9ae5TxXRUs1aRasPYDKs4crNgkbKge+/0IwJdV
         kxETI/413K2qR8bkHsyB+efS7utPBxMMi0MbWiWyc4f2FMucJsoRcs+BFLTUbZk3Fz5e
         xxMs9trNXe7WZdNIdE8u1jckfms+cL6GHsKXLWfrtwKON0GUIfuE7NAG33weurFki9zA
         MptCc0B/Lvc2636/PDQAzwDOUIrtvBxTu5U84dnlJMk0gwHR1AGjxst1rQJC3P7V3Gzv
         ZElYqVs2IXr6+AIvgyGL7mzetOUfLGDyeoQH58Pmq3Nam/w2Xr1uDJLbq+rUzXxvH29n
         3nIw==
X-Gm-Message-State: AOJu0YwLfveioiICx8XmMJ+jVxzeOB+FporO8Xz7qZo5nzeIss1RGGjG
	6wXxxI74mWevawA2u25OlgqoxO6Zs2jMkfqF/UEULJeYbUDJGEnu6oaQ04uRu+0E12Xbfipx8Dt
	vHO43hm73hPx777VXPV4wu8r9+mPRRlxiMl2wQiw6H59PSflaZ29OJO1btKQ=
X-Google-Smtp-Source: AGHT+IEUsP49nQ7L6gKN2oJKbN3zf3UBmh2kgIJdshEKVIDecInvpyg5L1CugZM6e2rPWInPIrFTpTR12ayDzUf0DVr3/WUtyXkv
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:17cd:b0:433:2711:c5cc with SMTP id
 e9e14a558f8ab-4348c9491b2mr170943525ab.32.1763365828824; Sun, 16 Nov 2025
 23:50:28 -0800 (PST)
Date: Sun, 16 Nov 2025 23:50:28 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <691ad3c4.a70a0220.f6df1.0007.GAE@google.com>
Subject: [syzbot] Monthly gfs2 report (Nov 2025)
From: syzbot <syzbot+list3a6c8221befe7277e550@syzkaller.appspotmail.com>
To: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello gfs2 maintainers/developers,

This is a 31-day syzbot report for the gfs2 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/gfs2

During the period, 3 new issues were detected and 0 were fixed.
In total, 35 issues are still open and 39 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  1426    Yes   kernel BUG in gfs2_glock_nq (2)
                   https://syzkaller.appspot.com/bug?extid=70f4e455dee59ab40c80
<2>  732     Yes   INFO: task hung in __gfs2_lookup
                   https://syzkaller.appspot.com/bug?extid=8a86bdd8c524e46ff97a
<3>  514     Yes   kernel BUG in gfs2_jindex_free (2)
                   https://syzkaller.appspot.com/bug?extid=150563285f78ac3e9bd4
<4>  509     Yes   WARNING in vfs_setxattr (3)
                   https://syzkaller.appspot.com/bug?extid=5ce48a14916462cec450
<5>  411     Yes   kernel BUG in __gfs2_glock_put (2)
                   https://syzkaller.appspot.com/bug?extid=ef4ad020dc976d178975
<6>  393     Yes   KASAN: stack-out-of-bounds Read in gfs2_dump_glock
                   https://syzkaller.appspot.com/bug?extid=7efd59a5a532c57037e6
<7>  203     Yes   WARNING in do_mknodat (3)
                   https://syzkaller.appspot.com/bug?extid=0cee785b798102696a4b
<8>  113     Yes   KASAN: slab-use-after-free Read in gfs2_invalidate_folio
                   https://syzkaller.appspot.com/bug?extid=3a36aeabd31497d63f6e
<9>  66      Yes   KASAN: slab-use-after-free Read in folio_evictable (3)
                   https://syzkaller.appspot.com/bug?extid=4c7590f1cee06597e43a
<10> 62      No    WARNING in gfs2_put_super
                   https://syzkaller.appspot.com/bug?extid=56182be23469e01affbc

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
