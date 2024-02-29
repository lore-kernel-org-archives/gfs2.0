Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A218E38DE7
	for <gfs2@lists.linux.dev>; Thu, 29 Feb 2024 04:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709181966; cv=none; b=alp4TP6gvyUiqJ9pUBIQP4/prMKQFFdsK0qO53iNg46Y+D3UfU/7twbN0GAVDtJlqYv5/1jnc7vH4+aDh3ORLgjMwc1+t6l6FO7UdZGJNH7qtK9kyomKC+/c8n44iYxIxKVwzkMwhOX3YxHNkrtimACqENKWq9XjY7zirHfc9Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709181966; c=relaxed/simple;
	bh=uyjOIENxq69Mlcc4mc+sqUi2mtkubLj29ms1NoSVQk8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=mfPx8HGXJlOLF82lLlot/BPRNCTpP19OuW6k54/HWF1ZRoK08YpuNl5kBb6f0vynb28yoVDN0frvHjKnpPKEXX/rTlRU2GpMlX9OEJCme9hYcSBMq0PTdCwWcPiwfuubWllrjuHPcvsDJsODQtds3m8RFCB8m3AjEIq2HZ/3pBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3651a261194so5979685ab.1
        for <gfs2@lists.linux.dev>; Wed, 28 Feb 2024 20:46:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709181963; x=1709786763;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FEjUJh9OkG09y0YRlfLvgKOC1GUAUaQDR1N3zpLExVA=;
        b=wHjj4PBQiHGpbCm2Z6oydTv2uVYsTT8Mk8hPezX2e+xUYjOWTtrXrCMbXEfkMICn8d
         VMPDKaWLhVG9TDL+SfG+pqZJVYQTcErmmdaa7uDO2qZHhkjub5BhwblZt9Z9KLqVP6rX
         IVoZv0E+CQxrKdUPz6i7hS+07jf8DZJFpk5ETZwq4jRFbBkD/lIB/IJuCteRGgJ+fN1e
         TqVCunWNTQFa111enzMr/qFekF6RT39YgkwY8M8XQLc6Jr0lJQcDXEunsQ0JAplsxLQB
         yAKKxL6Ug8EyxUPgin6Tc9L2OJdYQFrNSxm2q0Y88Zecvz5wtvFT4/C7zj7cCFLhCFjn
         0ngw==
X-Forwarded-Encrypted: i=1; AJvYcCX3DJhXtgiStkv7a2tM7iBYWl5Qw6jOo9ZH9KL1BKjtKs1dY8ZRYGtXBj4pyspnu783BLScxYVQOKZyHfLD1AnqiyQZBw==
X-Gm-Message-State: AOJu0YxXLkLoK754QrekN0zLV9CDEsfRlbqUtVepXAAYHFALs42eNjU0
	QNIiYJw2ZgOJ4ZzyqDrDBCo9QeCnzgtlxvHfIP27/Ez2IpL1Uv2nefDoSVuDm194FIcbGAk91Je
	AWhNffIco3YrqYZOf1HKsb8/+4gKluSSd6z+LHHD9tF6vFI9KM2iwOL4=
X-Google-Smtp-Source: AGHT+IEdCtFwvSTo9IsVW4KKbhjExbFAmwCruc2QMMuLHxCBRQbrllGS6/9TC1/gdsUCxxkl5OaeSLKpXGOdphGqQzZ98gXSHGHl
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1cad:b0:365:1f8b:d103 with SMTP id
 x13-20020a056e021cad00b003651f8bd103mr66821ill.6.1709181963802; Wed, 28 Feb
 2024 20:46:03 -0800 (PST)
Date: Wed, 28 Feb 2024 20:46:03 -0800
In-Reply-To: <00000000000029b00c05ef9c1802@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cf2d2d06127def32@google.com>
Subject: Re: [syzbot] [gfs2?] WARNING in gfs2_check_blk_type
From: syzbot <syzbot+092b28923eb79e0f3c41@syzkaller.appspotmail.com>
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

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=108aa9ba180000
start commit:   861deac3b092 Linux 6.7-rc7
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=10c7857ed774dc3e
dashboard link: https://syzkaller.appspot.com/bug?extid=092b28923eb79e0f3c41
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1440171ae80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11b1205ee80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
