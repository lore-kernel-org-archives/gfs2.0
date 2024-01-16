Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701A21C6B7
	for <gfs2@lists.linux.dev>; Tue, 16 Jan 2024 15:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c99AJCvc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705420697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j3+81Y370yZULKu921Q3F9OVI+1X1VMWHK6XvqAJu5s=;
	b=c99AJCvcx2CZyfD11uoPlAgHM1UVZlZEM73NgIq4FlAC3DQslA4ktPs8zHCuJqEZOQLb0G
	UY47kzz4Le6mDdr/CgNBehjxkfCwF78SJbapkRqTTn70JWgSM6JwrW35zzFzSuGSUeY61e
	wqakyTVXzEDv6J2zcszjBBgScfThW5I=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-115-Kyh8nWuXPom6r0RaPSk2kQ-1; Tue, 16 Jan 2024 10:58:11 -0500
X-MC-Unique: Kyh8nWuXPom6r0RaPSk2kQ-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-5cf2714e392so4882530a12.0
        for <gfs2@lists.linux.dev>; Tue, 16 Jan 2024 07:58:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705420690; x=1706025490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j3+81Y370yZULKu921Q3F9OVI+1X1VMWHK6XvqAJu5s=;
        b=hhMp708Rv99I1kJZwsK9vI2kW4Jn1MoWtAoH00pjzwQ/WGSwNeQ3Pc9+98UNtIqh/E
         zSyS6Fka9Vs5iOulSug6zC0LFpufDHx9Uhdi9aOMGjsdMqhzvZ7k/FhNp1Krm2UTW1CO
         dLbigXNBROaJfX2IdhaayFhk/bk2Tk87qC8azZDi8wq4vVKlnqjXtm72O9ZD3i/tN85b
         1TOBMlwDpgkkpMqc4p3n94wNXWsaWq5Fiii1CTModIRfXU0M2p9eakjFHZOfifksdhJH
         EHPNJ+V5xF19sl6BGqNjnUVpCeSXiGZx4hcORvx191Yy6p5q2KjTVCnqR4vDckpkCxIx
         ht5Q==
X-Gm-Message-State: AOJu0YzXhMQEjHiqoDOHbUeN7mf28Gg9ws288ndfPmyFA5far6tamYEq
	qgsqOwjJXZyjSZOLMATYAC9OCJs34FdO4mAhkPOPP/DbuVqse1kUH6YqOnMR8qT6Oa7Cz9R18vc
	NBgyMC9gK/lmh6uRxOFF8uN534caIN96RUrIUEg==
X-Received: by 2002:a17:902:860a:b0:1d5:6648:a7c2 with SMTP id f10-20020a170902860a00b001d56648a7c2mr8407127plo.65.1705420689959;
        Tue, 16 Jan 2024 07:58:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE/5NEy07nCVG6NnmBEYEpT6FFnmHrRdkz28cHmFwSkUBCszqq6bHwK4J8ZyqQ2XTkNvDPrrn/xVsSj8tGGBic=
X-Received: by 2002:a17:902:860a:b0:1d5:6648:a7c2 with SMTP id
 f10-20020a170902860a00b001d56648a7c2mr8407109plo.65.1705420689693; Tue, 16
 Jan 2024 07:58:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <0000000000008d00ec05f06bcb35@google.com> <000000000000ac2378060f12234c@google.com>
In-Reply-To: <000000000000ac2378060f12234c@google.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Tue, 16 Jan 2024 16:57:58 +0100
Message-ID: <CAHc6FU5iG_tAOSaxzRdri3gugmxgu=Hx3VEYcNRbg2h34k3EuA@mail.gmail.com>
Subject: Re: [syzbot] [gfs2?] BUG: unable to handle kernel NULL pointer
 dereference in gfs2_rindex_update
To: syzbot <syzbot+2b32df23ff6b5b307565@syzkaller.appspotmail.com>
Cc: axboe@kernel.dk, brauner@kernel.org, cluster-devel@redhat.com, 
	gfs2@lists.linux.dev, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rpeterso@redhat.com, 
	syzkaller-bugs@googlegroups.com
X-Mimecast-Spam-Score: 1
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 4:54=E2=80=AFPM syzbot
<syzbot+2b32df23ff6b5b307565@syzkaller.appspotmail.com> wrote:
> syzbot suspects this issue was fixed by commit:
>
> commit 6f861765464f43a71462d52026fbddfc858239a5
> Author: Jan Kara <jack@suse.cz>
> Date:   Wed Nov 1 17:43:10 2023 +0000
>
>     fs: Block writes to mounted block devices
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D12452f7be8=
0000
> start commit:   0a924817d2ed Merge tag '6.2-rc-smb3-client-fixes-part2' o=
f..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D4e2d7bfa2d6d5=
a76
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D2b32df23ff6b5b3=
07565
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D14860f08480=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D174d24b048000=
0
>
> If the result looks correct, please mark the issue as fixed by replying w=
ith:
>

Another one to go away.

#syz fix: fs: Block writes to mounted block devices

