Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE373A451F
	for <gfs2@lists.linux.dev>; Tue, 23 Jun 2026 20:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782246750; cv=none; b=bdR3pzFdMyCZRN5noiKxQilpus6A5xoXVzsPewMMeJrqkCmlYlL/9/C8c0aZtqsP1/OkW4cGuUyn5HxXdzDRaYOwJpAT7ReGjsfKMIG3LKr9svELobd6a7I3xIV6WYHSxs7Y42s8OGHh0OE0MIWIX3Q+b1qhN1C0PBJI4id3Ci0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782246750; c=relaxed/simple;
	bh=mnzHS0GCmXVYmBGZridCOB+oZo6g9Nz6PEbvJD7h8Ys=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Btjb4KQjhj79G9WpkLI7E5lEWA2biaz87IphddV3+pBzNtOiDv8HHmkChIO24D7uLTBxEOwG5RAZeuoyJBXU3O4+iguVO5z148IIoFo5i6jX0kCFF/vjPGP2V0wCeR0ZPJ9EbjGs8M5OTSGXG5SMRTPHXJOaEQHI4eLrDk2g+es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-4862fcd9a3cso348710b6e.2
        for <gfs2@lists.linux.dev>; Tue, 23 Jun 2026 13:32:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782246748; x=1782851548;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FVwZLNKrxLaOEaJmtOUd3myfwyVDer1HLneCqBWOqR0=;
        b=E/Xvl5YD3BetJxyfWzq/95SmtN69/Ju+jOadmVNRqKrVNaQjwyon83iinG32MYsl48
         usWTwSZW2WrE7nEuNGQmVYbFog14RHyGFvCtEPGFzi5n3rB6zk1swjiVHPKpOL5lLdx8
         KP+e9Pd0KHsZINtk6Nrx9m0J2MeAfBcq2hI8YqDyfut7CTiC261y5vfek7Khu/76NVRH
         YWBmWHP6BMB6B9SW7ZSh3kqd7Bp6quSKB4/GVH6XjoLS83TS0jwIEAq6t6s3Z7wxxjU9
         5oTtEoXF83XxnK9gFPXMlW8dj/HlS3ehRXcFOYnS2I+PmlyiSsoSlFhLnM8xLa4mRmh9
         dkpQ==
X-Gm-Message-State: AOJu0Yy54rLnAGTfz6fcFOP3gjmh8fBSablmfl2adQqw7aOsTPRvdtxx
	wzQEUt0rG5pNuJrR7A+BKR0KHJcIfWJU9BhXKNyEIzamLCxbRzgcsSGHYb1WayWT4QW+GalwVrP
	pNVrOsM2q4hgyulmWPN3iLnA6Kd2E8G+bUUq+zii9qsPfjaco6CcxUPI3Lp0=
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:c3cb:b0:490:6550:1e2f with SMTP id
 5614622812f47-49065502833mr641533b6e.41.1782246748216; Tue, 23 Jun 2026
 13:32:28 -0700 (PDT)
Date: Tue, 23 Jun 2026 13:32:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a3aed5c.b0c80a11.da7f.0003.GAE@google.com>
Subject: [syzbot] Monthly gfs2 report (Jun 2026)
From: syzbot <syzbot+listbdd7bcec77794732beb4@syzkaller.appspotmail.com>
To: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello gfs2 maintainers/developers,

This is a 31-day syzbot report for the gfs2 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/gfs2

During the period, 0 new issues were detected and 0 were fixed.
In total, 28 issues are still open and 44 have already been fixed.
There are also 5 low-priority issues.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 77      Yes   kernel BUG in do_qc
                  https://syzkaller.appspot.com/bug?extid=bad65435361712796381
<2> 76      Yes   KASAN: slab-use-after-free Read in folio_evictable (3)
                  https://syzkaller.appspot.com/bug?extid=4c7590f1cee06597e43a
<3> 75      Yes   INFO: task hung in gfs2_recover_journal (4)
                  https://syzkaller.appspot.com/bug?extid=9013411dc43f3582823a
<4> 50      Yes   WARNING in gfs2_ri_update (2)
                  https://syzkaller.appspot.com/bug?extid=7567dc5c8aa8f68bde74
<5> 35      Yes   general protection fault in gfs2_glock_dq (2)
                  https://syzkaller.appspot.com/bug?extid=5a5f492ccae698fd7434
<6> 22      No    kernel BUG in gfs2_trans_add_revoke
                  https://syzkaller.appspot.com/bug?extid=b17a83b050e9617376f0
<7> 2361    Yes   INFO: task hung in __gfs2_lookup
                  https://syzkaller.appspot.com/bug?extid=8a86bdd8c524e46ff97a
<8> 110     Yes   kernel BUG in gfs2_quota_cleanup (3)
                  https://syzkaller.appspot.com/bug?extid=af4d53576692f8956fd6
<9> 96      Yes   kernel BUG in qd_put (3)
                  https://syzkaller.appspot.com/bug?extid=0423714c06c369318794

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
