Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7DE3D82
	for <gfs2@lists.linux.dev>; Sat,  2 Dec 2023 21:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-587a58f3346so4203599eaf.1
        for <gfs2@lists.linux.dev>; Sat, 02 Dec 2023 13:33:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701552785; x=1702157585;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zKqRgYm0AgRjE4xdVrUEcvGqaGktrF3meejJYcgoL68=;
        b=A3jt+5m88yEdNhtHEk40sIlAR9ztLTv7sNrHzch0ymoRPuN88wCZg4MGvWicQrfoqx
         zeWJ22S4ALbytkR9AyKjg/wjb09KY3f8Fl6B5c6BpZAFYRSNZKMi+PHh2GexjZxAaHOl
         Ob8U8yQCUfOq9MWBVfBqBFzvsljSSRBCfgcXZXpZI9KMn3+Ni0qaeyRB+QObMPvUCyYe
         sb8XBNQqj/I85Sdhr3skw+blHxxPl8b8mvrUyeCtDuOAlulItknilJmK6pCwqwWbPZ2J
         FMyqeoHHGAJlvwt/p6uzMIAMHVLmVbn/kIOHhe4zWQVNwS19auyan1Kvz5WXulrhBX/x
         UakQ==
X-Gm-Message-State: AOJu0YywPL014o5tIDtPGsWoxN6f37NIZYCkJ+4nHOqi8RfQ3B/QDDPn
	57ZPfK+6t1oOpZGfB3jdPX3NR23mdY1xJxvD57IW9jTl7WTm
X-Google-Smtp-Source: AGHT+IFqucHa4qMk8RwcwCv8DbQzN4BAF0j4cNTlp1+iRF4gCgFVtyQXoYcZ5tycjVuxqOzZsBm5nFDyG77vYxFKL9qzpSe1l8Zl
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a4a:b243:0:b0:58d:6882:9000 with SMTP id
 i3-20020a4ab243000000b0058d68829000mr1032039ooo.0.1701552784595; Sat, 02 Dec
 2023 13:33:04 -0800 (PST)
Date: Sat, 02 Dec 2023 13:33:04 -0800
In-Reply-To: <000000000000f0bfe70605025941@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004ae32c060b8da1dc@google.com>
Subject: Re: [syzbot] [gfs2?] kernel BUG in gfs2_quota_cleanup
From: syzbot <syzbot+3b6e67ac2b646da57862@syzkaller.appspotmail.com>
To: agruenba@redhat.com, eadavis@qq.com, gfs2@lists.linux.dev, 
	juntong.deng@outlook.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rpeterso@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit bdcb8aa434c6d36b5c215d02a9ef07551be25a37
Author: Juntong Deng <juntong.deng@outlook.com>
Date:   Sun Oct 29 21:10:06 2023 +0000

    gfs2: Fix slab-use-after-free in gfs2_qd_dealloc

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=169c7b52e80000
start commit:   994d5c58e50e Merge tag 'hardening-v6.7-rc4' of git://git.k..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=159c7b52e80000
console output: https://syzkaller.appspot.com/x/log.txt?x=119c7b52e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c2c74446ab4f0028
dashboard link: https://syzkaller.appspot.com/bug?extid=3b6e67ac2b646da57862
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1268c086e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=164b3faae80000

Reported-by: syzbot+3b6e67ac2b646da57862@syzkaller.appspotmail.com
Fixes: bdcb8aa434c6 ("gfs2: Fix slab-use-after-free in gfs2_qd_dealloc")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
