Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503262C028A
	for <gfs2@lists.linux.dev>; Mon, 15 Sep 2025 06:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757919268; cv=none; b=RbeOCVn7SvwJldUDKTauAZsKHeNVKQpvGZHHhdXWm8BaGOcQUqgLVQLQWO62YqOCtq+s15g2LeuScm4TRvXL5BtZeZj6PzDQgswfYsqUvNtSFNQq/I1nnvwq7+bHRqlN9g3m458PoL89mjHpl4zJ2I7TyRSBSAxH1KWoz0ztGWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757919268; c=relaxed/simple;
	bh=XaQN2H2S1QXnTApPXoJ73KHsBZ1my6NmAZ6S5+6LBX4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=JocExMYUKDMhvnCcV+lytHuzQMMlH3w7DLaucesZiqesM7sAR7agmvpe7XQCRV+6XbX8py0YG/uiDAK0kKIy8nKU5rQJE3BMCucUb1jeNVpD2/cu67PBXTyCZ2XPQWVDTAC2RcMEVPhTsX/mteuy3nMo46yAd25OaJ0WOSj8jnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-423f9cbfa41so16569115ab.1
        for <gfs2@lists.linux.dev>; Sun, 14 Sep 2025 23:54:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757919266; x=1758524066;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=35LddoAycIkIJZ4G8fPfZLybSwKCAwTcTKRvI9msLyU=;
        b=TALZtFpuwyw42SRZa71R2Qa2inDgWkWdVX0zNBDB94uUPDMKG48IbNcllkYK74S3n/
         fx7itulqPFP6s+BFM27vBJrUjYt/xs9XaGb8aMu9vzZsJpuydSzo8t+SUPUpRybuxAPd
         gcCC6DKqP/E1H9InfkxrgrxdtjPuXbruwMSR1GeBK9WgSky2+EvLTdm3H2MYgz4j0o4j
         JmUHeZv+F7xsiu8yN++l6TbRlHL36f5Vhk6PUGnmPr1UCP07kM97RAhm3mXS1TpYaT1z
         nfZWc5pdxxJed8eF9zhnVMDNZHTigZnjp9KpiuDPE2lguSSTfJyWFk46AUUR6b8tmDXx
         tx6g==
X-Gm-Message-State: AOJu0Yz0wnpxpSKr2f43kmJ3eXauADgwO9GgjICPPPXnDE7QgqxXQ4pa
	p3JJn0rwLpZ0lnD6L7naK9Vzwayn6Oq/XGZXUPuvC0VbPFyBQra/vPBx5JcNmDjhzjan5y40r/Z
	1qYkY5IuRbKICGnZpVeXmzfZv8OEd2fawDdS0r9EcReRsE5VOi9lin5E/4Xg=
X-Google-Smtp-Source: AGHT+IFHakhglgBdRFJAguj1OsNcIE95IWTf4beEOqdjTQsvoyVjXcsmP8JT7HeWoVQKVtp0lKMC6DKkvZL2PgiPBgxP9s4ExS9R
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a92:ca4e:0:b0:423:fc5f:cad3 with SMTP id
 e9e14a558f8ab-423fc5fcdf6mr38125945ab.17.1757919266545; Sun, 14 Sep 2025
 23:54:26 -0700 (PDT)
Date: Sun, 14 Sep 2025 23:54:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c7b822.050a0220.2ff435.038c.GAE@google.com>
Subject: [syzbot] Monthly gfs2 report (Sep 2025)
From: syzbot <syzbot+listca0112af71376217520a@syzkaller.appspotmail.com>
To: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello gfs2 maintainers/developers,

This is a 31-day syzbot report for the gfs2 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/gfs2

During the period, 3 new issues were detected and 0 were fixed.
In total, 29 issues are still open and 39 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  546     Yes   INFO: task hung in __gfs2_lookup
                   https://syzkaller.appspot.com/bug?extid=8a86bdd8c524e46ff97a
<2>  445     Yes   WARNING in vfs_setxattr (3)
                   https://syzkaller.appspot.com/bug?extid=5ce48a14916462cec450
<3>  374     Yes   KASAN: stack-out-of-bounds Read in gfs2_dump_glock
                   https://syzkaller.appspot.com/bug?extid=7efd59a5a532c57037e6
<4>  339     No    kernel BUG in __gfs2_glock_put (2)
                   https://syzkaller.appspot.com/bug?extid=ef4ad020dc976d178975
<5>  188     Yes   WARNING in do_mknodat (3)
                   https://syzkaller.appspot.com/bug?extid=0cee785b798102696a4b
<6>  68      Yes   KASAN: slab-use-after-free Read in gfs2_invalidate_folio
                   https://syzkaller.appspot.com/bug?extid=3a36aeabd31497d63f6e
<7>  61      Yes   KASAN: slab-use-after-free Read in folio_evictable (3)
                   https://syzkaller.appspot.com/bug?extid=4c7590f1cee06597e43a
<8>  58      No    WARNING in gfs2_put_super
                   https://syzkaller.appspot.com/bug?extid=56182be23469e01affbc
<9>  39      Yes   kernel BUG in do_qc
                   https://syzkaller.appspot.com/bug?extid=bad65435361712796381
<10> 35      Yes   kernel BUG in qd_put (3)
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
