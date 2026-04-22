Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3B43C1401
	for <gfs2@lists.linux.dev>; Wed, 22 Apr 2026 09:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776848917; cv=none; b=vGHJAjBkw8v/7llkQYuccD2wWUjx7MWcFfcn/ZWFmK8GZIZq6p0oKArIZpY4D6qWgP7Su5GQj0dtvL7cyuNSIUrKFnzVQGG41SKt2xGZUJousRotsWD/Kux5pSbOMqYVh1CCJ92/ueVZ5LM1w+9QoFrh1WgnQw5Q+JNTLUy8Rqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776848917; c=relaxed/simple;
	bh=KgCEYFMeeeLBYx7yuidyDkhXDGEZTDJmYXGLzTpvFYs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=RNQ8KoZmtOBdQrdjiXV/80yRP6YYu1akalcEWDkC3kfJRnxvTB918fUQ9r81ZDeuVGSdUQVRsKB2KO1hZ0B9ujN/jeKRXD0sml9a6gpHV3or7yHw+XV1LL1PDJh2gveoVTze5Ty2SyQd0sSHtfzKkxyG8ayu4hWfeW5vieNkFH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-679c5ed0942so8021670eaf.1
        for <gfs2@lists.linux.dev>; Wed, 22 Apr 2026 02:08:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776848915; x=1777453715;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nIlz/RWVOell8Nbw7bIUpoJRej1CE2CihHUUD/mx0kw=;
        b=UQ61adegGmPdyzGd3jPcS7AEN+k1JV0gBBPV46yXBkNHiDfsBUHLe7iBBHahJu+aE9
         cx70RT7bnsl4DUScuw/OGVu2ZaX68NCvbQJfLId1LEXmaesLEXw/0/HFmqKO/X/6UiGx
         yKyxerZsbmqqaqHTVuNZHfde5gXa64VtMssZWX7bT6BztwPP2345XdvLmhggbSYUam+z
         499MOzWVvKyRVBZryitwLJPZQFAq3wlDXQGrn94F/+woLNkkZpbEULPPYV16PH+D/AkR
         Ltle/b2QAZBEDHejg0Y/ZLX2FSEt1rmPSWJYfC+s0Q7GLQ7cud0tKbVwiUk/uV5QTLFT
         fL1w==
X-Gm-Message-State: AOJu0YzMz4ZwOnRB1yWuUD3Hh5ZkCxtd8JSmOs1Ddi8nz9IkAIWnV/7a
	Q+ekkUXVRPHExdxbPPNi/F3uMgxoQ7mFlgYbSO5uCmjEQCBL3JCCJ1aIa+EFfVRsr0d3QmXz/SZ
	8noFlv3pf+P0oThOJ1uZnHxscSpD+ubqEH3hpZ5kVRM53oPwlQ3nnvKO7FKI=
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1a06:b0:686:d107:2865 with SMTP id
 006d021491bc7-69462f372c1mr12111270eaf.59.1776848914905; Wed, 22 Apr 2026
 02:08:34 -0700 (PDT)
Date: Wed, 22 Apr 2026 02:08:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69e89012.a00a0220.17a17.0028.GAE@google.com>
Subject: [syzbot] Monthly gfs2 report (Apr 2026)
From: syzbot <syzbot+list2e7521569c2378f26147@syzkaller.appspotmail.com>
To: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello gfs2 maintainers/developers,

This is a 31-day syzbot report for the gfs2 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/gfs2

During the period, 4 new issues were detected and 0 were fixed.
In total, 43 issues are still open and 44 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  2097    Yes   INFO: task hung in __gfs2_lookup
                   https://syzkaller.appspot.com/bug?extid=8a86bdd8c524e46ff97a
<2>  1453    Yes   kernel BUG in gfs2_glock_nq (2)
                   https://syzkaller.appspot.com/bug?extid=70f4e455dee59ab40c80
<3>  1398    Yes   kernel BUG in gfs2_jindex_free (2)
                   https://syzkaller.appspot.com/bug?extid=150563285f78ac3e9bd4
<4>  682     Yes   WARNING in vfs_setxattr (3)
                   https://syzkaller.appspot.com/bug?extid=5ce48a14916462cec450
<5>  412     Yes   KASAN: stack-out-of-bounds Read in gfs2_dump_glock
                   https://syzkaller.appspot.com/bug?extid=7efd59a5a532c57037e6
<6>  229     Yes   WARNING in chown_common
                   https://syzkaller.appspot.com/bug?extid=04c2672c56fbb9401640
<7>  155     Yes   INFO: task hung in block_invalidate_folio (2)
                   https://syzkaller.appspot.com/bug?extid=85194ada5aabdfff265b
<8>  139     Yes   general protection fault in __gfs2_trans_begin
                   https://syzkaller.appspot.com/bug?extid=a3a4e5eee651210c6887
<9>  89      Yes   kernel BUG in qd_put (3)
                   https://syzkaller.appspot.com/bug?extid=0423714c06c369318794
<10> 78      Yes   kernel BUG in gfs2_quota_cleanup (3)
                   https://syzkaller.appspot.com/bug?extid=af4d53576692f8956fd6

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
