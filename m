Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E30D37DE80
	for <gfs2@lists.linux.dev>; Mon, 23 Mar 2026 08:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774256304; cv=none; b=Z5C/Vpkt52XAQQs/c07bkjNfN8zroG2SIZBeOi6iiOnYctlRaeTlqqsef9b3W+dCylVsmyU94/fRHeQURU1MIhQ6DLKqADhI/+4F04Uaekjku7UP1NKKToY9x0nDamcnsz89Bul56Ebenv4M7DkacmuSnCPMZd4ULRYyredgUvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774256304; c=relaxed/simple;
	bh=Lf6YltsHu9uHN3qA9R7UIrkZBLRlR8pyoDJRwvq3QGI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=O3pVZKqm0p4Rg7aYJi4qmrz8S3rSePlA05mQ95fyZ8E9NAIn5Kcvt7Gk4hKoHWANhhLmIpRpaUEzQX1aWB1c9C7zzcMkgeeVUJtvpaDj1S4L6xMSsv0bgxwx31zAVQQooT2cEn6/8UQN5+PYfCRyQ7Pht/twtUe8byY9cYLDzvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-67c30448569so19016605eaf.3
        for <gfs2@lists.linux.dev>; Mon, 23 Mar 2026 01:58:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774256302; x=1774861102;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m2avvS9FCLIW1/kZd9uKTz07yCExdTYJfBTPSvD7Wu4=;
        b=Z+u4CGduM+nehkmf3OCtoeZQDj/a/+wQ0okhpu6n9G23Se4hJsqo+Gopyi2HS0qM+n
         ZMbS/1pW+kpyFvSUHnb1ux75UPiAP3kIu8TChrXmijWHKA2HtWMZkTPu0uS1tl9B3hPs
         cqwerGJBWyBM+aT+YUrd/k/q6zNIXDbtOWvNcz4H1RMcdewTXmQl5ua83/dMl9Vbndol
         3VaJBEpECFedTofAGKCxzesIaKYqWOppBFNw26Bjsi6We/Nl5QsV+D/zJG3jSeM+mx0V
         T2dk4uOE4buxnpppahVwvknRIpVqY1tRQ4agLz5uqZURTz+yHU77n7EFCddyfH4xRSOv
         7WKg==
X-Gm-Message-State: AOJu0Yz9StijbG2A9CTTFzS7MksGrDtfPu3EU/KE+cyEwUOkKqpsA8HB
	gCdS5AQv4Bn1p7PaOuUncOZyzXhpJvw8RFOpPgw/OIHG0AvxiwRU3LuZe2ENv8ArKc2eTMVJG8f
	fbNOK6qbn2igu04y8sZS7sEbSAKg6SMArG3d3IodzQCuyANwQioCPoY0nr9M=
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:150a:b0:67c:1fc7:daa6 with SMTP id
 006d021491bc7-67c22bd05bcmr8768934eaf.10.1774256301941; Mon, 23 Mar 2026
 01:58:21 -0700 (PDT)
Date: Mon, 23 Mar 2026 01:58:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69c100ad.050a0220.3bf4de.0094.GAE@google.com>
Subject: [syzbot] Monthly gfs2 report (Mar 2026)
From: syzbot <syzbot+list8048c142182f0c44572a@syzkaller.appspotmail.com>
To: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello gfs2 maintainers/developers,

This is a 31-day syzbot report for the gfs2 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/gfs2

During the period, 0 new issues were detected and 0 were fixed.
In total, 37 issues are still open and 43 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  1939    Yes   INFO: task hung in __gfs2_lookup
                   https://syzkaller.appspot.com/bug?extid=8a86bdd8c524e46ff97a
<2>  1448    Yes   kernel BUG in gfs2_glock_nq (2)
                   https://syzkaller.appspot.com/bug?extid=70f4e455dee59ab40c80
<3>  1371    Yes   kernel BUG in gfs2_jindex_free (2)
                   https://syzkaller.appspot.com/bug?extid=150563285f78ac3e9bd4
<4>  659     Yes   WARNING in vfs_setxattr (3)
                   https://syzkaller.appspot.com/bug?extid=5ce48a14916462cec450
<5>  407     Yes   KASAN: stack-out-of-bounds Read in gfs2_dump_glock
                   https://syzkaller.appspot.com/bug?extid=7efd59a5a532c57037e6
<6>  222     Yes   WARNING in chown_common
                   https://syzkaller.appspot.com/bug?extid=04c2672c56fbb9401640
<7>  171     Yes   KASAN: slab-use-after-free Read in gfs2_invalidate_folio
                   https://syzkaller.appspot.com/bug?extid=3a36aeabd31497d63f6e
<8>  146     Yes   INFO: task hung in block_invalidate_folio (2)
                   https://syzkaller.appspot.com/bug?extid=85194ada5aabdfff265b
<9>  103     Yes   general protection fault in __gfs2_trans_begin
                   https://syzkaller.appspot.com/bug?extid=a3a4e5eee651210c6887
<10> 84      Yes   kernel BUG in qd_put (3)
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
