Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE41B1A8412
	for <gfs2@lists.linux.dev>; Thu, 14 Aug 2025 12:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755175347; cv=none; b=jq+IxlbzpVS3FiEG9K7qizFRJKEMTO7oV4bAsyV/Ex4TU053iEY578mWoTfPkoQaRpIF6Q4QtoUgQEq+2ZcqN8U7PvIU7ldhkZ9dyKKLzcy0v3biHA02f+iA+zdZEE+QZuaGen19CEwYjP1Npd+kZlC0jzyBaOhTzdaHA3jxW9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755175347; c=relaxed/simple;
	bh=k3yPg1aAQpEg1eCIUY+jC9DpHpSaMpafiVcA2bYOd64=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=t6Jvf68+VVFIa3EnZpQN7H4UGocuH0TPCHIaMT8+dxEr3mX+sWK2/f6BLbqHBF6ixcM9Va4H4mHGCPaUR4mx1Vh78ferL0Ml7Uo66JTnzTbZ4rfNy9zDYDMUiU1VueGm4cO0f/9CUq+QlXEqPMgpFuRALGfMFw6wWFBRdA81FDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-88432e81af0so220664039f.3
        for <gfs2@lists.linux.dev>; Thu, 14 Aug 2025 05:42:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755175345; x=1755780145;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rOEMLRawprqNsHkZ2jpgpNUe0GUGeALOt5V9z9tksoo=;
        b=dQFPd0xF0q7OV6DgOP1ggKCVZsEn+nr3xQDcobBXjPMtvtH2MihOx1mzPYG0idKNmH
         vebpL6mVFiTBGMmMcg5Rfae4XEVxCd5t/b0WM/d8YvgizIhr2XA6cT7CQRnK9MZw32+i
         9hAWcMYfBzXUZyXUgFXFM3E8RVZn1nd4j1bbHPRALa/KmFG2ldQHLAKxbd6kVIOW+ikB
         crwbNISCF2xBX0IuvYJmxRSojVnu6g5HhMK3ldvj/xHwAeXgN+h4ZCkwr5t0hxbOf4dm
         65Qf/gE9VYMBPsO13Bmc/KQNB/mx9x0PotMzkbWjhO9JwO2T5vnoP5Rv1zyJNfGPFOSK
         zNWg==
X-Gm-Message-State: AOJu0YyxEG4V28A3TrLP7j96VUT8Ieyx6aCSE9jjDn6+JaOLL3rnPi7s
	UOgdUILk+A50Kf4o6ViLtUjGQziV/Xl3hks9wsOmk3JdHB8p7jpoRbnTrMypDgqpCQp9Gb5mY2z
	exzx+tRs7DbPiJbqmPQOWfcNYtsjdxvBH2TUgUjdQxTkOaSIkjwSfqTft+EU=
X-Google-Smtp-Source: AGHT+IESUCWjgOWranWO/9Wcv5CQpm+Eh0DhLC/rNCD2k49jxG4ZzIVxpbTlLs9aS+9zhnD1VXoLthwVFYrgzh3wihHYTFlYwUsE
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6010:b0:881:8a58:3bc6 with SMTP id
 ca18e2360f4ac-8843382a70emr547983239f.8.1755175344833; Thu, 14 Aug 2025
 05:42:24 -0700 (PDT)
Date: Thu, 14 Aug 2025 05:42:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <689dd9b0.050a0220.17479b.0005.GAE@google.com>
Subject: [syzbot] Monthly gfs2 report (Aug 2025)
From: syzbot <syzbot+listf579ade1619e81d82873@syzkaller.appspotmail.com>
To: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello gfs2 maintainers/developers,

This is a 31-day syzbot report for the gfs2 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/gfs2

During the period, 2 new issues were detected and 2 were fixed.
In total, 23 issues are still open and 39 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  1397    Yes   kernel BUG in gfs2_glock_nq (2)
                   https://syzkaller.appspot.com/bug?extid=70f4e455dee59ab40c80
<2>  367     Yes   KASAN: stack-out-of-bounds Read in gfs2_dump_glock
                   https://syzkaller.appspot.com/bug?extid=7efd59a5a532c57037e6
<3>  303     Yes   INFO: task hung in __gfs2_lookup
                   https://syzkaller.appspot.com/bug?extid=8a86bdd8c524e46ff97a
<4>  237     No    kernel BUG in __gfs2_glock_put (2)
                   https://syzkaller.appspot.com/bug?extid=ef4ad020dc976d178975
<5>  56      No    WARNING in gfs2_put_super
                   https://syzkaller.appspot.com/bug?extid=56182be23469e01affbc
<6>  55      Yes   KASAN: slab-use-after-free Read in folio_evictable (3)
                   https://syzkaller.appspot.com/bug?extid=4c7590f1cee06597e43a
<7>  44      Yes   KASAN: slab-use-after-free Read in gfs2_invalidate_folio
                   https://syzkaller.appspot.com/bug?extid=3a36aeabd31497d63f6e
<8>  33      Yes   WARNING in gfs2_ri_update (2)
                   https://syzkaller.appspot.com/bug?extid=7567dc5c8aa8f68bde74
<9>  29      Yes   INFO: task hung in gfs2_glock_nq
                   https://syzkaller.appspot.com/bug?extid=dbb72d38131e90dc1f66
<10> 27      Yes   kernel BUG in qd_put (3)
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
