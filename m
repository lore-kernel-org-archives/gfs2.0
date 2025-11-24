Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A522EB85E
	for <gfs2@lists.linux.dev>; Mon, 24 Nov 2025 08:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763971636; cv=none; b=TwkOC6WmHNNoj2yavpQZ5k1mIhn35Q5loiBujbYMuIrvPwKYXCtVz/GsAcJFWkeh2JHulM5kZobqk7/1LeAy/LixwfcNegWaGTdi10Wf7hdueD6wfetnRvw2t8DsA/Txo0aL6CZbm0Zp++H4soaule5NFLPg8U+398oMiiRMe30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763971636; c=relaxed/simple;
	bh=uLF4ymbc1debRYSZV84IG2bq9LlsCFvbjGNsZ7FjQMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pv+LHkYnd2oKq0xHlbSOYW9eMm9GHzn2RKa+efvJPX4IulzmrIOK/hXPo/xXLklPkGKgoWxioORYUmwwzCl3WExXVd0PJ3/1cqMNLnTsCL9xIUhMaLbedWUorFXRpakjCFGlp9qdnM0fK4iKU2XPSk/6G/VibzvXmUaXpa5KIGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HQyUpJd3; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HQyUpJd3"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b72b495aa81so482072966b.2
        for <gfs2@lists.linux.dev>; Mon, 24 Nov 2025 00:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763971633; x=1764576433; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ffJm8uD7vCOgF9zgZEJ5I2oPynD5JwzH3iIO07ZQVps=;
        b=HQyUpJd31NXxusrrTYDQVARFVaWES2+Bq4AifvFaTTlVjU4IPNO38YiCOux5k8BLwr
         7YdQQZ8l8avaau8s6VBVlNbNXeky36PDYqHI9HPTHahTGjIoHS1HHdYGj4HcdqGaE+6Z
         QJJEOFWKQFQ0Wl5UiBYwFmUW2fWLpObOL48L4/SJUDTu7rkW0dqxoHev0dccQZknA4wN
         nzqeQdw4iV5CLyfleq/nuamVuQwwzSsESOchQKvWVLOJTkNv1aeWMWWTta+GlCrbax0Z
         9SFmkq3KFLH+5NcF1Bexve5bh0cH8+V0X5/EeCvXY5vAsF0vYMFgVFp19vxq7tknzTAE
         jHwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763971633; x=1764576433;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ffJm8uD7vCOgF9zgZEJ5I2oPynD5JwzH3iIO07ZQVps=;
        b=r88EPdCIXX3fMOC9d3sSnQVfwjyFVtendunjz6BEZ1i/M8rBAv/1y2JIc1v3evQR9X
         aFUGx83PXVJhLCV/O8EGavZdlkscHBeguRqAEXLKGJQIhQDrXaREpWkkqmTDZyqz25ZT
         GjaXfQGHLKFTnOhE1ymxy3ZCq2i4wiTNq1F9YzrX7BfON+KAeMDbjiZdjnQQUKiMyTAN
         IQpwhNk6brVIhojAipCrn7MCIVJm/R5kmNBYszfLJ/5H0Egjr+StpUANWEWKuTqhvEUl
         Xmgag+qMSSSqss4Dfqjn4uWFBwpVC9f8g1GczNVuRS7cr+p9TLOB5fb93OPaEuUkSLKU
         MgBg==
X-Forwarded-Encrypted: i=1; AJvYcCUpDqnQvj05+h+9Rx3lp1FXiNl+aeC7yiTnBrcsQO0i8NmE8QP17U6WU2aBQRzmKwUCsA/s@lists.linux.dev
X-Gm-Message-State: AOJu0YwnbwtHKxPB325qk199zN7djJTT22456bpzBvVGt9D1YD8s+hMN
	T6r2bF0Gx/9P7l3hMu4nu/pMCFW//Mlv0KIi3ed/WzNx+KQfX4I+aI7VKn5Y4/P8
X-Gm-Gg: ASbGncudzQxH2dTVy7Qf858Q8FaE/9OeRuC8aMw2w42Jd0QRsje7wlBVQCxEJy439bc
	YRgu9K5WJzLkUHMwcWlKH0RNV8DWzLg8e0fV0x0Sop6vJOpWxsbjjdd0Roy3YORiSY+648bwuFn
	RAnnGgZlAKa1iaPy/rZ9Bf7cn0nNzE7PBXb8bx9BxO1NIgKRj12a0kJKhvZQXCnEJTpO6no2q/f
	t/6Bn7jrLBj5S5mE9RaqO4hSF/kWt6c/dUzu7aKV/qxWDXa2f/WrJEkQT+TNKKswbDwACegXdir
	YTZ8Vh+/5JrTmd4RPVPKKXhPzuaVl5lsSXdrkZgtzdUSsWhUcfKav1/4S9mFy+WQZTxV0QN2kCq
	J/UOZNuWpznKEyF5mWUWqAaHZaIoeMTiOMpu82DDiVObG17YPbdH/Cb46R2q6FYD5pqCETmP5qI
	tFY9DC5q3ShVVbBWF7QkXjMHRMHQ3RPf+O1empIUWMSp2GwMgK/X7I+lvs
X-Google-Smtp-Source: AGHT+IFtvbyzbyYPyyUbUpNZQBqo9VaVT/zaQpsMNf29OGJ5PF9TvCJCEVLb2lxKlFTH4n4qLf5tjg==
X-Received: by 2002:a17:906:fe46:b0:b4e:d6e3:1670 with SMTP id a640c23a62f3a-b7671517ad4mr1179647766b.11.1763971632882;
        Mon, 24 Nov 2025 00:07:12 -0800 (PST)
Received: from f (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654cdd5e0sm1283838066b.1.2025.11.24.00.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 00:07:12 -0800 (PST)
Date: Mon, 24 Nov 2025 09:07:00 +0100
From: Mateusz Guzik <mjguzik@gmail.com>
To: syzbot <syzbot+2fefb910d2c20c0698d8@syzkaller.appspotmail.com>
Cc: agruenba@redhat.com, almaz.alexandrovich@paragon-software.com, 
	brauner@kernel.org, dhowells@redhat.com, gfs2@lists.linux.dev, jack@suse.cz, 
	linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	marc.dionne@auristor.com, ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [ntfs3?] INFO: task hung in __start_renaming
Message-ID: <wij7hnuisn4cukkqmcflda3eurejl2dqjgwlphwesbu5jbljvc@xtqmwpwdj4pr>
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

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs-6.19.inode 
