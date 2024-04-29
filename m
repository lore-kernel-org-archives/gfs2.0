Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2907BA39
	for <gfs2@lists.linux.dev>; Mon, 29 Apr 2024 12:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714394066; cv=none; b=SoGyVVLX6FU9SmuXtxN0ULua1GX5sLdSiXPgdmcd4s5FIRZhVUZXT77FVtENHzNmd3sK235Xj3RzUtulctsmFfFJNK9c/Mkf6HVeKnF6i47cXHGrxtc1w6lNaOo9253ysqcaKTd9b2CyDNCu5jq1JlhlFUw46J/fG7ntitejWDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714394066; c=relaxed/simple;
	bh=zNX4dvMj8sMaSc/H5ov7uAslSWACWgUB2DwD63KMJfc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=MmBptOHjVM9FA8nODiII5loMs9bfkNuxBcwJzqU0wxKhSAtYu2imUjz9dt7KoCfg0O82tXfSKjP5ObJKOWkjKp1YyPvII1QOfyLv//AOLRwPj3IXUduIW5uVpMyAuT4PiCZ8cUYM+Z02LS2B227OhQoA+MQkLU/wG4edP30Ej+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7dec58efbfaso173403639f.3
        for <gfs2@lists.linux.dev>; Mon, 29 Apr 2024 05:34:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714394064; x=1714998864;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lIcH+uqjp3vumX9YpVxoQmZo6VBkUG5FwDdMSz/9KgE=;
        b=vl1Q6NUpbxOKiEotikIyyXvE8MzQN1db1REMsKUw0yvXy6mIxdEtWYkOLPesNnpB+U
         qkqVn80tRlAohYOfTVd6B2f4wjrw4WDax53D/gKinOB4Vvlu86ET+WjkyjuWpRyLPiQA
         8uN0P71+i1RzIyFt/+Kcmn+DxH5gLzL9Sr4fK3SPot2YI2Ph6Z/+NoWVpGKWn1n2URHj
         OhThn6vXFvqdetnCO6Ro1c7BEtKA+ZfiPvzreGPG5hHkFUFXVPxjainxUUsjh7ELZHrs
         AlOxa59TS5cF8aXF4Epw5kClRfShxEKhy98/otYGysTV5eJ4xYfciZCaQk7QNFUY+OPi
         7wAw==
X-Gm-Message-State: AOJu0YyNG5/d0n/P78alyTgA22+yfsMj+AAutRRw7l9h7unqQ2Ybepwp
	4T1CbQck1j0XIC1VLGG3hAnnByohPFSSW2ERqsk/Izpvez5xEvwvRFptsz2nggQKlAJnapVold4
	+tIRcz8rf0+vkSVyN6tgMbaw31YLMpiPx0xlPHiSGR7meOqFjZb8xdKY=
X-Google-Smtp-Source: AGHT+IFmGFq5GWv4TOIvJdOwBbT+UeOKGABz5MfdMy4OwFM1jJZ30xEQ78iGkI8pgziDJHL8eka2027lOFMUoQQis9xo9C0fNNFr
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3d89:b0:487:c6e:1bf2 with SMTP id
 ci9-20020a0566383d8900b004870c6e1bf2mr816814jab.1.1714394064267; Mon, 29 Apr
 2024 05:34:24 -0700 (PDT)
Date: Mon, 29 Apr 2024 05:34:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000034bbf206173b7991@google.com>
Subject: [syzbot] Monthly gfs2 report (Apr 2024)
From: syzbot <syzbot+list8ffe20412d57261746c6@syzkaller.appspotmail.com>
To: gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello gfs2 maintainers/developers,

This is a 31-day syzbot report for the gfs2 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/gfs2

During the period, 6 new issues were detected and 0 were fixed.
In total, 11 issues are still open and 31 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 61493   Yes   WARNING in __folio_mark_dirty (2)
                  https://syzkaller.appspot.com/bug?extid=e14d6cd6ec241f507ba7
<2> 746     Yes   kernel BUG in gfs2_glock_nq (2)
                  https://syzkaller.appspot.com/bug?extid=70f4e455dee59ab40c80
<3> 108     Yes   INFO: task hung in __gfs2_lookup
                  https://syzkaller.appspot.com/bug?extid=8a86bdd8c524e46ff97a
<4> 90      No    possible deadlock in do_qc
                  https://syzkaller.appspot.com/bug?extid=8ef337b733667f9a7ec8
<5> 22      Yes   INFO: task hung in gfs2_glock_nq
                  https://syzkaller.appspot.com/bug?extid=dbb72d38131e90dc1f66
<6> 12      Yes   WARNING in gfs2_check_blk_type (2)
                  https://syzkaller.appspot.com/bug?extid=26e96d7e92eed8a21405
<7> 1       Yes   KASAN: slab-use-after-free Read in gfs2_invalidate_folio
                  https://syzkaller.appspot.com/bug?extid=3a36aeabd31497d63f6e
<8> 1       No    KMSAN: uninit-value in inode_go_dump (4)
                  https://syzkaller.appspot.com/bug?extid=bec528924d6c98923e5d

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
