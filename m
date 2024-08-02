Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCFE1BF301
	for <gfs2@lists.linux.dev>; Fri,  2 Aug 2024 07:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722583589; cv=none; b=GM6Z5loug5QUFFGSkNvckEOcsP8zxJog31yPIBCrH6I/FyWfDZUlJs0jDCajgYswgV+4j9emKWlOEz2g6dEbZHHhWbdRMfPiHBDpXjMA4t33OhvLthq8rXeLOkMsQEKjNYmtjOTbEAC/S+QLh6Fay3jj7zazUHVmLsrIDhy4wDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722583589; c=relaxed/simple;
	bh=Q7isDA4cLD+NJOp6yTaUe+JZ4Vy9np6f6rMW0uX2Zyo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ejyk3gRbp8PgKkBcSCBGOG38TDUluOYLyYN0AQTkkqtxMbcqo5xkA7jqjBxVw7QwRgFhsgcUq/zAjl91qp5Ft+SYsy+Er4AT+OUC/EjRC1MdEAZjIJMHdeLYx9ymGMyM4QrCgmGE03Vrk4NMtvAXyLUDx5R2ubl7TS3oqCyPyLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39862b50109so113471945ab.3
        for <gfs2@lists.linux.dev>; Fri, 02 Aug 2024 00:26:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722583587; x=1723188387;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qU4YHEI5FOJW3hx872vK4nm0dqI+dc1npOneKYtbxQA=;
        b=RkbLkT3RgbVtVomTMiQyY9nGRXTWDxAGCeENXkKWruWx2Jv3nExyekiLF2DB4xyIvb
         PN7vpSgGOHXtgaD9b9fEGo+Sl0ffr2cE2Bn30VhSVZBXD0Y/HuG7+EpfomtAhM7+/NlZ
         W9wJJUv0wIZHsykXBrMVfXBb5Z1J2D3mrjhOHqXur34gTguzhPOqiIjnQChvtWL0xAY4
         Pp0D/3NR17ki3h0xUKKaG8+iKHjuddOzpT3X2kSbA3UelxNh2rxWTiXYsTLPmQCpfc+z
         vBomva4oEcYa4T97Bqx4GBC/yRxwPp0BhuyPUB9SPmoSP9aNrVvP/AaZf2rPOZHNd1UF
         RXxA==
X-Gm-Message-State: AOJu0YxasAU4as8mMn4tSE7gJrLiohQXTc78laN3JfKrVP3ZG+xugL51
	mdNi8Q9kgwU5AnXZ/l7XrcO9HpEKBEwi29/UduiS99Hs2hv+MoskQO+5HOd4y/5pJVWT0bvcZCg
	PVSV0up4kdp7dWrc/4/yG0SHdlDD0xuhRqo9ycXHBiatjN8BFAvDDZ8M=
X-Google-Smtp-Source: AGHT+IFgoLsJ3Olpb4xM+WKgxtJtmrUqo6TemLUxZj1WQUH10l9PFtOsHjCb8QuKZfPmmc/KlMZx2Jb/kJnwPReKukIOTmKYVRgf
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d0e:b0:39a:e800:eec9 with SMTP id
 e9e14a558f8ab-39b1fc58ef4mr1859095ab.4.1722583587180; Fri, 02 Aug 2024
 00:26:27 -0700 (PDT)
Date: Fri, 02 Aug 2024 00:26:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cf67e9061eae3e91@google.com>
Subject: [syzbot] Monthly gfs2 report (Aug 2024)
From: syzbot <syzbot+listb61a1d58ae517f6982e4@syzkaller.appspotmail.com>
To: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello gfs2 maintainers/developers,

This is a 31-day syzbot report for the gfs2 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/gfs2

During the period, 1 new issues were detected and 0 were fixed.
In total, 14 issues are still open and 31 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 378206  Yes   WARNING in __folio_mark_dirty (2)
                  https://syzkaller.appspot.com/bug?extid=e14d6cd6ec241f507ba7
<2> 6347    Yes   WARNING: locking bug in gfs2_fill_super
                  https://syzkaller.appspot.com/bug?extid=ee157488ade46c021ef4
<3> 1305    Yes   kernel BUG in gfs2_glock_nq (2)
                  https://syzkaller.appspot.com/bug?extid=70f4e455dee59ab40c80
<4> 729     No    possible deadlock in do_qc
                  https://syzkaller.appspot.com/bug?extid=8ef337b733667f9a7ec8
<5> 115     Yes   INFO: task hung in __gfs2_lookup
                  https://syzkaller.appspot.com/bug?extid=8a86bdd8c524e46ff97a
<6> 102     Yes   KASAN: stack-out-of-bounds Read in gfs2_dump_glock
                  https://syzkaller.appspot.com/bug?extid=7efd59a5a532c57037e6
<7> 24      Yes   INFO: task hung in gfs2_glock_nq
                  https://syzkaller.appspot.com/bug?extid=dbb72d38131e90dc1f66
<8> 14      Yes   WARNING in gfs2_check_blk_type (2)
                  https://syzkaller.appspot.com/bug?extid=26e96d7e92eed8a21405

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
