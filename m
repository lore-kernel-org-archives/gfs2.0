Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D635380C
	for <gfs2@lists.linux.dev>; Tue,  5 Mar 2024 10:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709633241; cv=none; b=f3psPrYC1aK04+PajjzGjPnBsDSxwpzVi9pIoC0kiHPtx4YW9jWJXDd3nGUr93xd0SxDrtu4RuGQPCLKYzNJfd25RntiBMxJCfe+2aR7aB2jqBO9N8MMXiwOQ1yxAXaraMFCA7zHdhbpiuIDncHq0mI6SXbdbzGx1L8zOMG6UI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709633241; c=relaxed/simple;
	bh=tmWvhUXEZZ3pBn0rRhtM8Nj4vDkTWD01IJZIJla18XM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EDIR5W1ko2gqlilc2GuGFMueuTqCMK9FZwPrpMGOM/5xSzSQysd/jZOLcXUB6ZUBGSrJpn5RZ3yXB3CkuwM9vNUIkEXXZytK5Lw/sib3GKJ66x5xmmsZNEy6YDQ4lN6NkR4Xadc9th/ShWxaofCKpFjvvPrr6rDOsk3l3/PmyJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KfN54v7w; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KfN54v7w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709633239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5LvzkgpPOzZwlEgXOsRWtL0iyRGHSE/p12vv2dYEEWM=;
	b=KfN54v7wKpZnBko2P5nLaVhRMkBze0S2EDlpKoHSavaCxQa0aEJ1z1OhRGdtZbXR+X1MI9
	O8gZ7w5gD9lRojAcwsLzG0t/dBhf1Ut6572Ah6ZKUdzck3e5+wjcHoZQFRp34xofWwlqNJ
	KZq1JYKohfMe0RLdWqk+IoDAxYWszjA=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-fssXHbzoPsG3-zliP6JxAw-1; Tue, 05 Mar 2024 05:07:17 -0500
X-MC-Unique: fssXHbzoPsG3-zliP6JxAw-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1dc6f81c290so49860125ad.1
        for <gfs2@lists.linux.dev>; Tue, 05 Mar 2024 02:07:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709633237; x=1710238037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5LvzkgpPOzZwlEgXOsRWtL0iyRGHSE/p12vv2dYEEWM=;
        b=OoriiZWZOsv43LqMULHWdpCvdh2BGigr47A33rdR6saMy4dxfQGsX/9hVtyrW8q68l
         /GvPCOOnN1ohz98ZqiNN75KsoXs+9hPh6i9IE98v+WFNQDH3yk0PZud9El0VB7NUqNpL
         592Bq4BCu0oK1jWkgNeJziBEKBl357+6ry+n1nZuj/NOwJFOAXhoVMU6MqSm+JV3EuQE
         +lstI6dKOfcekq/CLnq+EikLZpUOHU4oddakhsYj/Jf5cKnVTbwbk6KZcUOGaNWIsoQb
         77Eq9+3nha/VsJvDQD+vHnnE76u5DNyz6XbAnG5hOx78ujhVVQC2kkaiSyvPhSCuaswp
         dBYA==
X-Forwarded-Encrypted: i=1; AJvYcCXgu0Lg9Jad+N5FMVx2Hi9mccSCChzS9efF4iQlq4v0GWYGmglVp3GidYOc+YX4QTHLsOx6wTgG/j3FoOgL0Yf6MicLvw==
X-Gm-Message-State: AOJu0YxRiVdhaLenAHoK3whfyomlyooBfVdeft2zb36kABGImWCG/8pd
	QdQr4k5y6ynwlLteNSMrQZf5yaupojo559mDOjJGvJeT3pSEpWvyn8HdHL3lQ9J9llQ8jFi6Sko
	L9qPb7Im11UBwv4p3Ovc16xqNJ6HicO55KKYxHMIlkBZsq2ItxzvM+cvqaHO9YGZStPli5XawBN
	bOdd/GwmBW5eFsUwiVPa1Z7v6SbQ==
X-Received: by 2002:a17:902:ce8d:b0:1dc:b320:60d2 with SMTP id f13-20020a170902ce8d00b001dcb32060d2mr1446803plg.33.1709633236855;
        Tue, 05 Mar 2024 02:07:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHMv6QAUQFA2PQMt09dU18T+73TTHk4Z3gqozQBVsQrgdPPOTCB2inQqNxcby7aXzwG2tWIwk4xFqDbjP3soXg=
X-Received: by 2002:a17:902:ce8d:b0:1dc:b320:60d2 with SMTP id
 f13-20020a170902ce8d00b001dcb32060d2mr1446786plg.33.1709633236559; Tue, 05
 Mar 2024 02:07:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <000000000000c925dc0604f9e2ef@google.com> <0000000000000c6e0a0612e6bd58@google.com>
In-Reply-To: <0000000000000c6e0a0612e6bd58@google.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Tue, 5 Mar 2024 11:07:05 +0100
Message-ID: <CAHc6FU5ynRASxSQDYPMZ7FHuOmjxPbqe0E+TTJEc19+ArJby0Q@mail.gmail.com>
Subject: Re: [syzbot] [gfs2?] BUG: sleeping function called from invalid
 context in gfs2_withdraw
To: syzbot <syzbot+577d06779fa95206ba66@syzkaller.appspotmail.com>
Cc: axboe@kernel.dk, brauner@kernel.org, gfs2@lists.linux.dev, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rpeterso@redhat.com, syzkaller-bugs@googlegroups.com, 
	yuran.pereira@hotmail.com
X-Mimecast-Spam-Score: 1
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024 at 10:48=E2=80=AFAM syzbot
<syzbot+577d06779fa95206ba66@syzkaller.appspotmail.com> wrote:
> syzbot suspects this issue was fixed by commit:
>
> commit 6f861765464f43a71462d52026fbddfc858239a5
> Author: Jan Kara <jack@suse.cz>
> Date:   Wed Nov 1 17:43:10 2023 +0000
>
>     fs: Block writes to mounted block devices
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D119f927a18=
0000
> start commit:   6465e260f487 Linux 6.6-rc3
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D8d7d7928f7893=
6aa
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D577d06779fa9520=
6ba66
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D10dbcdc1680=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D17a367b668000=
0
>
> If the result looks correct, please mark the issue as fixed by replying w=
ith:
>
> #syz fix: fs: Block writes to mounted block devices

Sounds reasonable:

#syz fix: fs: Block writes to mounted block devices

Andreas

