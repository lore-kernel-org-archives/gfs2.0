Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1076FD1
	for <gfs2@lists.linux.dev>; Tue, 16 Jan 2024 03:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3607ad143c2so79784375ab.1
        for <gfs2@lists.linux.dev>; Mon, 15 Jan 2024 19:35:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705376105; x=1705980905;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QDZPKLWcldx4Qh4G0TWmxOUwgI57VtugrnMHdb+OGCE=;
        b=EzuvnDEqZMwMJMNLxVHaIhqQj7vYqmXECmY+Tnw5IoajJqopubEqs4hDwmjjFfwccN
         g6pT7MZgPzW4szqFnONiK4WUlJUbXsDMdZ+YZ8U+glPA7aEu+5zrGvOw+bTejwhlAgBc
         Ca4u1R2ZQOV9pPyy7x2TMDrO4KEsnmg4cIGalyGWQY2r+pZgwSO3v8KawkgEZ1/eq78m
         B9ANH4uPvfmEN5MBxluTIEYQjZ/PvQF3Bgy6NNo4v9CJE0Cz2rQEqagkaTv227/iv0rd
         sw5x6ewr+D9lvXoTwLMdsQdcalYOEmN1DkzE7+FqrBvH6jVZQ0YXYjnBEk2hE9k8xr2a
         WbVg==
X-Gm-Message-State: AOJu0Yzk5GEWrfqYVAJtuIFcZbtNm7n2xcxVZwlGMe5t5Aji+oU02PkE
	hkjdINvCE8k5A9TfsKRq4R3JJTN0Lbvrtm8H3H5iuKWArJSz
X-Google-Smtp-Source: AGHT+IEmZtzkNJYz5yodsOTO/J/hRFV4GXetYqHl0g4+sQzW/5cRi3XB6vwH0HMFagaNmW5Hf5yS7qVF2+p4VnVeERztj0SwH9gi
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c49:b0:360:6649:29da with SMTP id
 d9-20020a056e021c4900b00360664929damr962185ilg.3.1705376105526; Mon, 15 Jan
 2024 19:35:05 -0800 (PST)
Date: Mon, 15 Jan 2024 19:35:05 -0800
In-Reply-To: <00000000000057049306049e0525@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fa7c3b060f07d0ab@google.com>
Subject: Re: [syzbot] [gfs2?] BUG: sleeping function called from invalid
 context in glock_hash_walk
From: syzbot <syzbot+10c6178a65acf04efe47@syzkaller.appspotmail.com>
To: agruenba@redhat.com, axboe@kernel.dk, brauner@kernel.org, 
	cluster-devel@redhat.com, gfs2@lists.linux.dev, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rpeterso@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=165bebf5e80000
start commit:   3f86ed6ec0b3 Merge tag 'arc-6.6-rc1' of git://git.kernel.o..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=ff0db7a15ba54ead
dashboard link: https://syzkaller.appspot.com/bug?extid=10c6178a65acf04efe47
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13e4ea14680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13f76f10680000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
