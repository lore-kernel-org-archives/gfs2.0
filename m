Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F002AC17
	for <gfs2@lists.linux.dev>; Wed, 15 Oct 2025 13:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760536026; cv=none; b=HaQ2S7+6aRGQwa3KTiSlcA5QsS/QkiYrrRLSSyL2EPGxE9mqoZS+1Ebdy+ESvE7B3m4ILwM3AC9GHg+ivLnBYy9Dn0moo/yOg/aLjzUWYDfiSaEOx3BpmC1KVESNn/3F1SnDTN17cZ52dZbz4ZpRckXtDiPCcs1N7iJgtGQFSF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760536026; c=relaxed/simple;
	bh=SzkGglACk2ecMvMJD1k84GoJTdSAjj2YDmu8jCQyZOo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=dVrY8jbv9u7Ia6vb4skNT+F5MEAzRDsKrihpAbj4TC9Fg7uw0v7q0xxrRtoXFUB70aKeyu9hw5BOWgbCuOOhmlBTNJGnx8paN0BWX5DMJTX0YK96lQTZDg2MINSWfPpNxboI8fh+OAjyLdhP1NhB36LZu9Btn5UstQpwwubth6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-42486f6da6fso170512255ab.2
        for <gfs2@lists.linux.dev>; Wed, 15 Oct 2025 06:47:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760536024; x=1761140824;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ljo9OuErlLM00XsMZf/51X/x1BYGThyE9CnwvE2p/rE=;
        b=ndjVBwqJ34MtI4t7JMxMI0O7uTOhGkxS2cxmfnSF1rbsgWOCnCd1hIucB8AO4Dc3bX
         0xBSRvQZx5rUIN6l9BJhtOoNQil4d87hLYeQoSme0x9RjcJNvfb8atb2xOLLWpfriVbF
         hTJ/Fxoi9eR31p/m7GmsmqZyznAanZN0F6DPNWXLIScvDWOMoihsUO+nc4PCBNjw8481
         0gpAc0q8aU4lSmeGMBQhF8kSsOI+n63btV9ZE102mDyMU3KBpUeI7jt8wdmSApGl0HGw
         eS+hfo1JSZs6ZPAa8gAXgLFCJNe5rm/FE38nGiksSphNys4Tkws88ihDDoL4BfA2Jw/h
         NnyQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2ByIhEI44rx/ewTXv17gp+zq2asYQYqW5MMlrr3cdDsmI61TeVtzYzkyM9+UHOqOisLP5@lists.linux.dev
X-Gm-Message-State: AOJu0YwyyA7krlFjUouzqd9dyHHWxoolZ0kvfpzebS0ZQm/zLi5aDGw/
	jmTbo/qjqUxpDhCd3qL+bqzaCOhqZeZDgOxThIBQWGVOyEEfwyitOTU+I/uOdYrJ04cT0no72MZ
	OafFHKtz6VN6TPIJ96FR9n+8zDzWryMx6Kz/piO0C1rofTZFFeERmJo8VOaE=
X-Google-Smtp-Source: AGHT+IFv0XfRI1sNhOVh1lWVY/8eYketaW7CTv2ixqDDMHd1FEX1C8Zunr75lmJtxs40lenVaQwDcM2mnunernofDpyQyZTlr/JS
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3790:b0:430:ab48:cccb with SMTP id
 e9e14a558f8ab-430ab48cd17mr43775895ab.31.1760536024119; Wed, 15 Oct 2025
 06:47:04 -0700 (PDT)
Date: Wed, 15 Oct 2025 06:47:04 -0700
In-Reply-To: <68ef030a.050a0220.91a22.022a.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68efa5d8.050a0220.91a22.0263.GAE@google.com>
Subject: Re: [syzbot] [gfs2?] general protection fault in gfs2_log_is_empty
From: syzbot <syzbot+6b156e132970e550194c@syzkaller.appspotmail.com>
To: agruenba@redhat.com, eadavis@qq.com, gfs2@lists.linux.dev, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 578194d38a129a7b60ddd90d226ea517605db30d
Author: Andreas Gruenbacher <agruenba@redhat.com>
Date:   Thu Jul 31 21:49:37 2025 +0000

    Revert "gfs2: Force withdraw to replay journals and wait for it to finish" (6/6)

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10df95e2580000
start commit:   52ba76324a9d Add linux-next specific files for 20251013
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12df95e2580000
console output: https://syzkaller.appspot.com/x/log.txt?x=14df95e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=99cb6b007a8889ef
dashboard link: https://syzkaller.appspot.com/bug?extid=6b156e132970e550194c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=132af304580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12cd7892580000

Reported-by: syzbot+6b156e132970e550194c@syzkaller.appspotmail.com
Fixes: 578194d38a12 ("Revert "gfs2: Force withdraw to replay journals and wait for it to finish" (6/6)")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
