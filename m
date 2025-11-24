Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBD42EB5D4
	for <gfs2@lists.linux.dev>; Mon, 24 Nov 2025 08:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763971689; cv=none; b=JhXlqYQsdyMW9WTf5kf1a9oQNbVcvHxU6iQnXqH7WmsLfZ67/V09oPOG7kbI76INPIlJz1iBfP851Fzjk674G5piSlikMP4ZjY58V5Apan1WWwcugCs4Hs3tgVRJZlTrmzHn4etJHNRqC2cgssEtuNHkclrKEA7FrgRoWhtBy3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763971689; c=relaxed/simple;
	bh=lv+AEbEO5IfBluOI6lN3XPIKGE9a0yctf/Cn6smugBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kzqz3J5RLX4sE2wFt4+ojbB+jMa6qXwE2i3h9xlahOlNzuXqDcXQzfGcHyXURhpmPfycKF6NJs6KsQETmbgNsQegLpgcsyk9UibtzwY9dbGLm4lJ2f6p6MrUj5vIEIDNlYKajXMteSvYQbCUfQVsdzTyGNgUtZ7NLXbcbUfaWoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a9DXStPR; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a9DXStPR"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b736d883ac4so739751366b.2
        for <gfs2@lists.linux.dev>; Mon, 24 Nov 2025 00:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763971686; x=1764576486; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YLf2E3nOZAEZ9lLAngAWJ9piteS0oS4r7Jb/uJKZm84=;
        b=a9DXStPReU5p0aHKxUl5ZBvxThPTS6fvP6fHrPEwKVYPUSmhcs7appcHWUoa1LSIWl
         z7mNQkAnglKbeZwOReKv/HZ9TH5cJDjjHvuKR1nCswJHC6n+KlBp7wp87B87DqVqKO1K
         otHhz2TyNuc8+NZF314g/nlzkwCu0JIo0DLLrCLI/coEMuMMhPASZ3kTjhK58kd/ZMlY
         TIg9qpWKFqE0k94HbzTZhrhqUhdb4+GfUOW2hOY93fE6LQZKBIyIDcG+qA4Ug4RtSWu3
         +tYdsXy0Pz22GZCFceelWsH9B75qj5nTzFK56sOJaPZckUyV5Yz7Okg6DitzUfKxwjrj
         Jm8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763971686; x=1764576486;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YLf2E3nOZAEZ9lLAngAWJ9piteS0oS4r7Jb/uJKZm84=;
        b=MVvmmNXuOVUr13VrojPQP/VeIyq5gyefgq57lS8FNEiuYSzTq5OhEfWdaB8TIlgvpL
         kKh2eTa2VSBFpdOSWVILyn+J/61aBLokIUEeKqDvZYnt2bUAf2ajeZWQ2ziBiiI3clvN
         LZg1M4bHLxFU9SNcwLLG3ox06ve6ePJUYMJYHA6+PNdPu9G3t5bs5B+niuByD7RstI5C
         N5SCTnmj3J+BX6CwPgPP62G4ZMf1kgY0DdYP/JUXNeCb2nVlcI8Y24wJSBaQHUrmRVFq
         NcbLmJZP/1U+Rq3Nd718Bu2I5I67DTxs0ZUeroXfQCEq7jXD9GSQhXi2J+7lY4bl6Tv2
         E6rg==
X-Forwarded-Encrypted: i=1; AJvYcCVU8GKjQN2TnyEHepjLr4+25WnLCDMIdVgyOnXjKpMGACwGX4ZZG52/5ZyJqAxhjk5esd72@lists.linux.dev
X-Gm-Message-State: AOJu0Yy0IQHQCXTfN67/vVOHZXj4zu1kaRcv7wprxm4zFJBRl5zCaX4f
	MItvhnHxhSTR+3vNDTei3lXUAe1UO+KM1OzyRwJlfpkSClvk4RcJDV1B
X-Gm-Gg: ASbGnctRoQ2bL6ee3czfKgoUJnFPrWne8qdS2iZxmL8ba1IjfBs7pwz0KpgI4cud90F
	ctGG9JNTB4hRchq7xIST8k9Tvq04tyYWuXL7guYEIzCLO9z/keMM5h3cuvSLOXw5vfoFG8UkW30
	NWEgovA4DyOJsLWXrj0e8plQePWqXlxnc/p282iQIXonfd5cRTqtVNdW6RmrnZErGBl6/yl9A4+
	V8eg4HMZT4WtkCArcCk16UDwLdiBSzwjyKPtzRxW9RXH9SDELh9eO06gJHgjNdfPJDAA5JTibY1
	QPWo1x2cpzJ7B27JM74s07DVEHDXtSFRqt6pFGovT/SPg7Dmi2DBRtLuVTM6tQ/Hx21QSX0CASH
	BBBbUkgleK6IRFqOpSV9oZcdThSggQFqs514cqEc6ASNXkD2I0K2+9MK/BSYFYHM9H8yB15608g
	s90fMD9LJwOLaduqqWIiWw9y3T6JMRO9WVIFlE9cQ3uowQR0ILqhKrCPzx
X-Google-Smtp-Source: AGHT+IFtSDCdQoEJDSme9cNU9H3jXN99Pr9VF8AAs0+V0hbQXcsw7JNTw9He4Bb9bU9ZG0GgB3qehw==
X-Received: by 2002:a17:906:d550:b0:b76:630d:fd27 with SMTP id a640c23a62f3a-b767153a62bmr1142202666b.5.1763971685814;
        Mon, 24 Nov 2025 00:08:05 -0800 (PST)
Received: from f (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654d502cfsm1215050966b.19.2025.11.24.00.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 00:08:05 -0800 (PST)
Date: Mon, 24 Nov 2025 09:08:00 +0100
From: Mateusz Guzik <mjguzik@gmail.com>
To: syzbot <syzbot+2fefb910d2c20c0698d8@syzkaller.appspotmail.com>
Cc: agruenba@redhat.com, almaz.alexandrovich@paragon-software.com, 
	brauner@kernel.org, dhowells@redhat.com, gfs2@lists.linux.dev, jack@suse.cz, 
	linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	marc.dionne@auristor.com, ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [ntfs3?] INFO: task hung in __start_renaming
Message-ID: <v6f6kfeeur7hhpj74za4larguj2jdhz652cwvmxu5o32ivkuso@cdpkqhx5gt7j>
References: <69238e4d.a70a0220.d98e3.006e.GAE@google.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <69238e4d.a70a0220.d98e3.006e.GAE@google.com>

On Sun, Nov 23, 2025 at 02:44:29PM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    fe4d0dea039f Add linux-next specific files for 20251119
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=142c0514580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f20a6db7594dcad7
> dashboard link: https://syzkaller.appspot.com/bug?extid=2fefb910d2c20c0698d8
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11cd7692580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17615658580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/ce4f26d91a01/disk-fe4d0dea.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/6c9b53acf521/vmlinux-fe4d0dea.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/64d37d01cd64/bzImage-fe4d0dea.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/a91529a880b1/mount_0.gz
> 
> The issue was bisected to:
> 
> commit 1e3c3784221ac86401aea72e2bae36057062fc9c
> Author: Mateusz Guzik <mjguzik@gmail.com>
> Date:   Fri Oct 10 22:17:36 2025 +0000
> 
>     fs: rework I_NEW handling to operate without fences
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17739742580000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=14f39742580000
> console output: https://syzkaller.appspot.com/x/log.txt?x=10f39742580000
> 

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs-6.19.directory.locking
