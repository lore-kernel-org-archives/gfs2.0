Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000E0145348
	for <gfs2@lists.linux.dev>; Thu, 16 Oct 2025 08:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760603787; cv=none; b=Feub4QUDsnkVSXiWWZ6wscFAZUHH5+mRzGsQMPEEu0JrwzD6oi7Kbkmnz9F9NGx0n/c2f7VPKHoutptDSMPk4Mxfae70StGEaQNuz5vGIZ7FYB8kZSPFm4c/C6vcmVDtpgsvwyGF+TbWRVnahTTfxE/yUCEHYgzFlML6U3JJgcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760603787; c=relaxed/simple;
	bh=SdcHay0WXkFqLNNCg32vsm4Xob0lPiDeLJwuqqs+4EA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=nUOIN5zSz3Cliubpg68RGSeTnBqohU9fDPNZ9BLJ8vQOaZCL80JtH0WLMuf0lR60t4P4aF+Ejc2H91MLDJqELzuwww+RB96pxl1vut6e9IuMs4fXNJzNdaCdEy/43/a8sLEQFhu3k5K0BnLNnh0Q0ZOw4XI8uNcGJMLLmJQBD/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-42f71a09b2cso4860125ab.1
        for <gfs2@lists.linux.dev>; Thu, 16 Oct 2025 01:36:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760603785; x=1761208585;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3ODVMCUuglEM66AgpA48vPPpWwPga7eh5csdCvtlp0w=;
        b=sNJc3tXHew7HoxWD7oi9ZWTRcVrJb3f6L6MwlfCcLdNeX2tPhV+6JdZuLGNjA6K0GG
         KkoE3nvNBnDgM8cs9jCPF9+QIuBrNDoGTZMQqrtoTCTGRibs+FJw7ef5x14POKnRaYrP
         RARfCPNlPwe8Togt86AKQIIyrZmI9uXs0z0yzeXF2JbWkV9gWkX7YrfVKblVOFlUJzg2
         Yrq+jfgX/dIeWEb2suc01eV9r2ntLu1+6h7l65JrLxKfOVRrUU5c31X7fCsvj4612/KB
         E3xGz0/tPAt7ESYPpBM/9aPuqnxLTZTX972C+wwQv5RwuARSYdmnlKlMGO2V+1bf3/P5
         gFFg==
X-Gm-Message-State: AOJu0YyQOtKKjq2Ybxbz/9v9mZHcsORF9VRfV0XXsGs/3CwGbXocNcwl
	M8dpi2S2EeO8/6Nc0Ex/rrYH3DmktyrjFQGIIOijcaCxnwaA2qSXnWj7rP+JsGb3nZY3bEsq/DE
	SUVxz9rE1P5xW3upfzjITI+bwIj92B9fCp9csr/nnPOl9HKDU61g2j7E+J64=
X-Google-Smtp-Source: AGHT+IEX9O7K4PDPS1zDzFSGCyp3SKlA5AHnJSa9vWaniPBHBnSu4kMAi8FP5SHL31UgC6/3gErOuM9yQRG3zmWv4YMSYD+mX9cJ
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1523:b0:430:bf84:e941 with SMTP id
 e9e14a558f8ab-430bf84ea22mr7550725ab.3.1760603785165; Thu, 16 Oct 2025
 01:36:25 -0700 (PDT)
Date: Thu, 16 Oct 2025 01:36:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f0ae89.050a0220.91a22.03e0.GAE@google.com>
Subject: [syzbot] Monthly gfs2 report (Oct 2025)
From: syzbot <syzbot+list0466b925309ecf3d9218@syzkaller.appspotmail.com>
To: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello gfs2 maintainers/developers,

This is a 31-day syzbot report for the gfs2 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/gfs2

During the period, 3 new issues were detected and 0 were fixed.
In total, 34 issues are still open and 39 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  1415    Yes   kernel BUG in gfs2_glock_nq (2)
                   https://syzkaller.appspot.com/bug?extid=70f4e455dee59ab40c80
<2>  641     Yes   INFO: task hung in __gfs2_lookup
                   https://syzkaller.appspot.com/bug?extid=8a86bdd8c524e46ff97a
<3>  477     Yes   WARNING in vfs_setxattr (3)
                   https://syzkaller.appspot.com/bug?extid=5ce48a14916462cec450
<4>  409     No    kernel BUG in __gfs2_glock_put (2)
                   https://syzkaller.appspot.com/bug?extid=ef4ad020dc976d178975
<5>  381     Yes   KASAN: stack-out-of-bounds Read in gfs2_dump_glock
                   https://syzkaller.appspot.com/bug?extid=7efd59a5a532c57037e6
<6>  292     Yes   kernel BUG in gfs2_jindex_free (2)
                   https://syzkaller.appspot.com/bug?extid=150563285f78ac3e9bd4
<7>  195     Yes   WARNING in do_mknodat (3)
                   https://syzkaller.appspot.com/bug?extid=0cee785b798102696a4b
<8>  137     Yes   WARNING in chown_common
                   https://syzkaller.appspot.com/bug?extid=04c2672c56fbb9401640
<9>  98      Yes   KASAN: slab-use-after-free Read in gfs2_invalidate_folio
                   https://syzkaller.appspot.com/bug?extid=3a36aeabd31497d63f6e
<10> 66      Yes   KASAN: slab-use-after-free Read in folio_evictable (3)
                   https://syzkaller.appspot.com/bug?extid=4c7590f1cee06597e43a

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
