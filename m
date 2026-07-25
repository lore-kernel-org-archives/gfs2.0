Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6190C3161A2
	for <gfs2@lists.linux.dev>; Sat, 25 Jul 2026 04:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784953955; cv=none; b=Ugsqo0RZdJ8kzDic3rddo4+99TPkjnqauAj5jxTFwyN2aWor5hP+xGfYG40NBmrFt4Hiwr40af+pPuF5U0uJaHERZLK8Vrj4LVfnAZCqkJLMrGP6Cvpvf5PPfjs/z4LDgnVNiJJOaY84IuFxI403qET6DiONypx9qCg5y2n5srQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784953955; c=relaxed/simple;
	bh=nAiq5DaK/mC2rcxPVx/KQSKaqafm15dANkazvi6C6Bw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ItrgzDst9Ou9crea/oPBRUvhUIdtJRalF7PHY9jMVwhfwfKNWwL4zb5yeGsAQHfV0W/UZXjepj160wN0B6NNhLFl41QhRNdg24krVBhSlP+/BNKkZEz1+1zQ/ptjLE0ATSoml54i7sl3jVEDHLedxBW6wiwTzbRioiNFWmEirmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-456bbfa4cb3so834679fac.1
        for <gfs2@lists.linux.dev>; Fri, 24 Jul 2026 21:32:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784953953; x=1785558753;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MQteYqC+HhJqci7msQYrWvz5EEODpw+0M1ujSXo1q8M=;
        b=sH9LEhyCj7nnROLDB5pZwGE1icxq1FBmCN3qZDAhXbfTFFg9+enqNAaD8S0JvQhWub
         4ti5bwyFeXMAI4MBuuiR8zkJ+Oh2J4DB+KJT0r5HirvZOa5ukaEvnN5hC0EL7T5lyJRd
         1L6Qt6DJCCUGoHBM2HwvoBRXceiP+M3Uq1BeR/qn/15Mx+jJzaXKzdetRCP2O8C6QB7k
         tkO2w9RuQJfJoAVikgApB6eDKnOqIEMJkpHWHRBdu9KbSjTlwV1zAhTMw0l7XHoUXN5H
         En+l7hSBXusMpMk2rCduXAnKH1+DJaJHfgjHe0QuOD6YWt5P9QTm3GWO1FhNFQaThxvV
         qxMw==
X-Gm-Message-State: AOJu0YxJQX7aDf10+Z+1vAoYgLq4/qFpEKgu32BHKfQ99I3EtTgH+qUq
	5ck2Q965Ik/3o8WeSlTu6qmaClk2apKZR0ueEbHwwkneojL6LPPccQzaxHkjdKtFqbUwJmo/cMf
	PvsMLmZpIOTur5mYBYg0o+SJE9+VRoDkUl89mxpPQAUrI9wGIZQnatjeUQW0=
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:2385:b0:4a4:c73:9f3 with SMTP id
 5614622812f47-4ab69f88242mr1128034b6e.3.1784953953146; Fri, 24 Jul 2026
 21:32:33 -0700 (PDT)
Date: Fri, 24 Jul 2026 21:32:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a643c61.a2ea2cc8.fbad6.000f.GAE@google.com>
Subject: [syzbot] Monthly gfs2 report (Jul 2026)
From: syzbot <syzbot+list2ec66fdfb7edb190b85f@syzkaller.appspotmail.com>
To: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello gfs2 maintainers/developers,

This is a 31-day syzbot report for the gfs2 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/gfs2

During the period, 1 new issues were detected and 0 were fixed.
In total, 26 issues are still open and 46 have already been fixed.
There are also 6 low-priority issues.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  415     Yes   KASAN: stack-out-of-bounds Read in gfs2_dump_glock
                   https://syzkaller.appspot.com/bug?extid=7efd59a5a532c57037e6
<2>  94      Yes   kernel BUG in do_qc
                   https://syzkaller.appspot.com/bug?extid=bad65435361712796381
<3>  53      Yes   WARNING in gfs2_ri_update (2)
                   https://syzkaller.appspot.com/bug?extid=7567dc5c8aa8f68bde74
<4>  44      Yes   general protection fault in gfs2_glock_dq (2)
                   https://syzkaller.appspot.com/bug?extid=5a5f492ccae698fd7434
<5>  31      No    kernel BUG in gfs2_trans_add_revoke
                   https://syzkaller.appspot.com/bug?extid=b17a83b050e9617376f0
<6>  10      No    KASAN: slab-use-after-free Read in gfs2_ail_drain
                   https://syzkaller.appspot.com/bug?extid=84a21b16aba9f279d96a
<7>  1466    Yes   kernel BUG in gfs2_glock_nq (2)
                   https://syzkaller.appspot.com/bug?extid=70f4e455dee59ab40c80
<8>  152     Yes   kernel BUG in gfs2_quota_cleanup (3)
                   https://syzkaller.appspot.com/bug?extid=af4d53576692f8956fd6
<9>  99      Yes   kernel BUG in qd_put (3)
                   https://syzkaller.appspot.com/bug?extid=0423714c06c369318794
<10> 12      No    kernel BUG in gfs2_unpin
                   https://syzkaller.appspot.com/bug?extid=0c5024a57ccf4017c187

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
