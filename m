Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B2023BB
	for <gfs2@lists.linux.dev>; Wed, 17 Jan 2024 00:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705452486; cv=none; b=SX6ZipnFPJGLet4Ss6enddw4ASIU0NtTJjUp3vLpViwHOe2YBkmFtzeIoo+b14j1FTQpzrPmUowJGFf7ywZFDY2EjS1SZ8NqFVSHxAEFd3qZknC0zwMGU/97xMGIQ1H5wwJDHiAhnNE6c7Fq01s0v3Ca/C7ANyN5D7pFT1WcoKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705452486; c=relaxed/simple;
	bh=AAf/I4I42rLMBWEVS3mffH9UrtbgCWfulkA5r6p8F0g=;
	h=Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Google-Smtp-Source:MIME-Version:X-Received:Date:In-Reply-To:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:
	 Message-ID:Subject:From:To:Content-Type; b=IysnpJuHufekhQBQ6yXH9SDkhiYafkqLyABgOtTqcJUKupy3zLKHd6JWUWPAKPmCz9CUYl1rg4ytshoVJ0GSG+ryF58DYqBf4Y4v4Xs+4fBKvIw0KpptXw0HU2pqTij84DcQrYEUlO/Wj1yNOnJ833G6ltSPEpKfTOrKRo57T+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7bedddd00d5so589139639f.3
        for <gfs2@lists.linux.dev>; Tue, 16 Jan 2024 16:48:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705452484; x=1706057284;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TzIe28wbwr/i91YfIe1SnCMYHz0m9HJdrPMgOmh1W7s=;
        b=R/gc2T16A8za3b2k6ES58wBXKGB/ym77Fulje2ofMviRvOpN+X/zDVFygIOildGufQ
         S+g+F1/dctbJOW5Krruky9if5WhqCDFdQrDc2/lLN4AwEEvtvQHUMdBk5/8u2IGI1USw
         VYaO+oj8y0FX9slsWxMHcnI7jXKpTAIRyNllC5DkhixEHO6buinWhPHkrSf9XUYCAt8m
         tfMYIIYhI+6qdXtowam1BOfMzoOIWp0YMqXEYMBf6Ditb3vbS4jDqDp+6E6yWlESL9Sp
         W/1TxE6YwWFYCklZMNJecVjTTMxVysarp9KwOffCL96pBDA16wlU3ZCbc/9hb+kQGwPp
         Bf6w==
X-Gm-Message-State: AOJu0YzSC9Ve1BQb4ugemZHZ3+khxjKNW2Ul+6XQPbSQ8ZubsHYd+9CF
	egWDPHJsWPJAneQtplXx3X77KA27xzBBFHJCGfV+rUSvhGoj
X-Google-Smtp-Source: AGHT+IHZVgMumbYxDDuWNDkufYNSG2RSuuRZw5AZC5yXzVcZyTrEb3BR3h9XXdNCm2Cw3PsN4qPkDImjOvsVezYDvFpng64qP0vK
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a07:b0:35f:db4b:69dd with SMTP id
 s7-20020a056e021a0700b0035fdb4b69ddmr837348ild.0.1705452484751; Tue, 16 Jan
 2024 16:48:04 -0800 (PST)
Date: Tue, 16 Jan 2024 16:48:04 -0800
In-Reply-To: <0000000000007caa3f06014cad2e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000088f73f060f1999fa@google.com>
Subject: Re: [syzbot] [gfs2?] BUG: sleeping function called from invalid
 context in gfs2_make_fs_ro
From: syzbot <syzbot+60369f4775c014dd1804@syzkaller.appspotmail.com>
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

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=126262dbe80000
start commit:   46670259519f Merge tag 'for-6.5-rc2-tag' of git://git.kern..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=a4507c291b5ab5d4
dashboard link: https://syzkaller.appspot.com/bug?extid=60369f4775c014dd1804
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1602904ea80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12d67e9ea80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
