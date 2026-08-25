Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD5743CED8
	for <gfs2@lists.linux.dev>; Tue, 25 Aug 2026 12:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787661166; cv=none; b=O6ASuhJQaRWuQYeHi8+DsDEsGAe2DRaZ/fwKLiPZ5dY7cH0IBc5SB9u/s91fDPMYi87wt25Ijyd2mcEER5tzB2EvQx6nFxGBmZq0D/H0eftyNIeimDyWV8xgt+hsFAgvjk2BP/yCOK7Om6Jxm7XGDtHbgwR9y/Ly1icAFzr+dk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787661166; c=relaxed/simple;
	bh=o3anankbo7fFs/ujEO7jUKJUUIIx3U807nAC0s4ZG98=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Nhjv+NSIia66SVuPqkZelmV7n7kQX6QZv6Upo6xz/G+xoJ/xEqRPgPJl3INGPPW/1cvWGUKL94j7GxNvndI+Q+/FOykNd/76kN32yhMtnFWoy1eT1sdzW7xh1ikMF27KHZcF7bk+7yMDGJvWZHnwFmKaJU5A9leoQL4qlL+OYsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-4a49f09233fso889438b6e.0
        for <gfs2@lists.linux.dev>; Tue, 25 Aug 2026 05:32:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787661163; x=1788265963;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MmFpIrXQaDPQSOcxIkYv2/4Zf9P6UAxmpzlTyr5OikM=;
        b=hKTeN/gAjYcXV9EadyxZ4s3xRREK9OJniTnF2KmY+0nhA7OXhQmjUy18SZ+GBBPYVd
         mhyCoGx/ZdKdWDvMHPZ5Id3ysYvXqaPdA2igwOGidJoOQ52/IplfWH2Mn619gi52nlIp
         llo4kWthlFXL0MQHTxIWbwLOeX5CFc+3GdxsOkZdy31jOG58PsZHM2/X9IOBiZyyoh8J
         fL2vqJjFqjF1zGFxXsX0v+jkWlN0J5dwlhSNfEN1hgEuei+l5YILrDdiffGutv3uv0Zf
         2OCcbejCkrm9VuIR14gi682br4UWfrzu0KuYWuQvpbTClE+gq2Xdcn/iEl+Ad0Baphky
         Um1Q==
X-Gm-Message-State: AFuF++n+nYbcPx6enThQqMBGK+/AhA3BEWiO045SYcpBpzCdAyhL3Weg
	75hP/mWy7LoZ0E1Rxq6hLHaTaQOBWDBeRZO0kPhoc/4I7Jtm2AVW0L/PrjM0ivtAEY739IMT47M
	wRrBlqHtTGum3TScbZFQ3Yjb1XjBB43el8+JpqdSpe9qR1EZKYf7LoNNnfyc=
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:2f0d:b0:4ab:224d:6dd6 with SMTP id
 5614622812f47-4b35059f7a2mr4745797b6e.15.1787661163230; Tue, 25 Aug 2026
 05:32:43 -0700 (PDT)
Date: Tue, 25 Aug 2026 05:32:43 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a8d8b6b.a5a502ce.31d34.0064.GAE@google.com>
Subject: [syzbot] Monthly gfs2 report (Aug 2026)
From: syzbot <syzbot+listfa0a756e488ba124ea13@syzkaller.appspotmail.com>
To: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello gfs2 maintainers/developers,

This is a 31-day syzbot report for the gfs2 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/gfs2

During the period, 2 new issues were detected and 0 were fixed.
In total, 26 issues are still open and 47 have already been fixed.
There are also 10 low-priority issues.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  115     Yes   INFO: task hung in do_uevent
                   https://syzkaller.appspot.com/bug?extid=b114bbe890d76037877c
<2>  100     Yes   kernel BUG in do_qc
                   https://syzkaller.appspot.com/bug?extid=bad65435361712796381
<3>  79      Yes   KASAN: slab-use-after-free Read in folio_evictable (3)
                   https://syzkaller.appspot.com/bug?extid=4c7590f1cee06597e43a
<4>  77      Yes   INFO: task hung in gfs2_recover_journal (4)
                   https://syzkaller.appspot.com/bug?extid=9013411dc43f3582823a
<5>  54      Yes   WARNING in gfs2_ri_update (2)
                   https://syzkaller.appspot.com/bug?extid=7567dc5c8aa8f68bde74
<6>  52      Yes   general protection fault in gfs2_glock_dq (2)
                   https://syzkaller.appspot.com/bug?extid=5a5f492ccae698fd7434
<7>  20      No    KASAN: slab-use-after-free Read in gfs2_ail_drain
                   https://syzkaller.appspot.com/bug?extid=84a21b16aba9f279d96a
<8>  14      Yes   WARNING in filename_symlinkat
                   https://syzkaller.appspot.com/bug?extid=2ed46b6b748df855347f
<9>  156     Yes   kernel BUG in gfs2_quota_cleanup (3)
                   https://syzkaller.appspot.com/bug?extid=af4d53576692f8956fd6
<10> 102     Yes   kernel BUG in qd_put (3)
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
