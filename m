Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E42231845
	for <gfs2@lists.linux.dev>; Thu, 18 Dec 2025 10:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766052388; cv=none; b=dbBj8WtbJAiVqifu60+MOHPUgwbmFTHwNREOlR8+Ug79fe/LZ8f5jh4/BwloN0KoNRdboXPDPOINCU+kEQlOrrkkxrLJiJpoGbZMwn8TTOaKKHkfCcYJfzKZcZvT+gU15dHBc8H+rRbNSUj6vAxMUqnyj1FGrXR49jGfvr34lCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766052388; c=relaxed/simple;
	bh=Mh0oP4HlUF4vJ5EWo4F9iJ0dfMo6kLfsjwYVtLVk1h0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=qc7NgvdV9ylhaq+MR/PiBbKA9a4puoUX8XL4d/pAANyTHq+DTapCNqu1Vy4RuGO3GJq8sJt0dM6pXbEzYTgaNOjVSqgkAHZ1Lo7EK901Inwh5qlXlBDpA5kpp3FzdSH4wJFFZtWoF7ku0PLk74tBZCldJeKmSM0BvOqse/Gsoko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-657a467228eso601812eaf.0
        for <gfs2@lists.linux.dev>; Thu, 18 Dec 2025 02:06:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766052386; x=1766657186;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jfWGGf32bjAsJumom/V+y1wxizbLYMBuz2jzZs6RHB4=;
        b=ZdepNGwcXGsypH0eDm5vbp6LXptoRw2Ig6fbnWPvzsrdey0ZAVLPSqsu+F3I/7Ik5t
         Snmkp2zkRKt0Mbe+770v4Jwa8tRBjujHbvT+urJb+oWwlN6r5tQdW1WripdfhMqx9DtQ
         GvmeyjLZPiaKkEzQ43fdQiBBy4e6nJsuw4eHArQx3JKpGz6mDdkImt75vAcksZzjaGOm
         hquzeu5GYiiIIV0iCAXtsYAqqwxjVMW8Hfk8coBvx4dURM/YIgQE29DqtNhWWVnrw+I8
         L3Xjhg9ju2156FtPrAaWwgvBcz1bKd39ovgHvaqNn5EDfbdMsuGAjQpDOG/ASm34HFB9
         fcHA==
X-Gm-Message-State: AOJu0YxB9NZMAJfnIivA/v1EcUWHfTFass44eGCSIBkXMgy3PUepJa39
	/nJtli9OvaSGkY2jUM5rywNG41/54IhbkeyT653W/AkkV9zDF3PJLsg1bDVgnBgF/xHyLT3Ef1m
	XYFQcy4vbEgGp98V6GszhxbFDzLTMY3mjQCUgR4VRYAwZgVdlFV79nbtNaro=
X-Google-Smtp-Source: AGHT+IG/NI6b7yAfl6SSk5rDZ37sYcQgE+kiWZ2Ni/Y5rVropDIQJLj8etXxuicWofwnIcPF+WJWToaR5t2oCWaDHGlZiIuea/rO
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2294:b0:65b:579c:8479 with SMTP id
 006d021491bc7-65b579c8cd6mr6433665eaf.75.1766052386042; Thu, 18 Dec 2025
 02:06:26 -0800 (PST)
Date: Thu, 18 Dec 2025 02:06:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6943d222.a70a0220.207337.00da.GAE@google.com>
Subject: [syzbot] Monthly gfs2 report (Dec 2025)
From: syzbot <syzbot+list6399ad7aede57fc4022c@syzkaller.appspotmail.com>
To: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello gfs2 maintainers/developers,

This is a 31-day syzbot report for the gfs2 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/gfs2

During the period, 3 new issues were detected and 0 were fixed.
In total, 39 issues are still open and 41 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  1434    Yes   kernel BUG in gfs2_glock_nq (2)
                   https://syzkaller.appspot.com/bug?extid=70f4e455dee59ab40c80
<2>  858     Yes   INFO: task hung in __gfs2_lookup
                   https://syzkaller.appspot.com/bug?extid=8a86bdd8c524e46ff97a
<3>  770     Yes   kernel BUG in gfs2_jindex_free (2)
                   https://syzkaller.appspot.com/bug?extid=150563285f78ac3e9bd4
<4>  545     Yes   WARNING in vfs_setxattr (3)
                   https://syzkaller.appspot.com/bug?extid=5ce48a14916462cec450
<5>  399     Yes   KASAN: stack-out-of-bounds Read in gfs2_dump_glock
                   https://syzkaller.appspot.com/bug?extid=7efd59a5a532c57037e6
<6>  215     Yes   WARNING in do_mknodat (3)
                   https://syzkaller.appspot.com/bug?extid=0cee785b798102696a4b
<7>  172     Yes   WARNING in chown_common
                   https://syzkaller.appspot.com/bug?extid=04c2672c56fbb9401640
<8>  137     Yes   KASAN: slab-use-after-free Read in gfs2_invalidate_folio
                   https://syzkaller.appspot.com/bug?extid=3a36aeabd31497d63f6e
<9>  68      Yes   INFO: task hung in block_invalidate_folio (2)
                   https://syzkaller.appspot.com/bug?extid=85194ada5aabdfff265b
<10> 66      No    WARNING in gfs2_put_super
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
