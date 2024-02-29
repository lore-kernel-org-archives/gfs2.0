Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A031F43AA0
	for <gfs2@lists.linux.dev>; Thu, 29 Feb 2024 08:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709196191; cv=none; b=B6PAlAQ6RtAKdCJfnlmGgKu/NwH70eyaMu0dzEbh10lIXL+SA2cOrI/tIKLdG4LJ7dVsePQDfK/doivjW04iAN9N/lS1bgZnYRUqn0hBXzhSz2iLBPbGfCEq3na2p79exFIxDpQN7QOoGY1afCx8/xw5TagJ1GBtX2NXojRoQeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709196191; c=relaxed/simple;
	bh=hikBQBwK+HCibV9Ay+uw3hwq6fhlJ+kbZbSIdNLQbuc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jw1VU44tc9kOODpB804mA6AZWfo0CcndhABOAGl+H5UFiaQ327LlqdCfefgwO4pDBjeKNTEKytXi+blG07T8kl0zEoTyiZICMFJd2mjxOURsJYw2lmhCmgzsOv93j1c0PwwGhfDrZUMwUp2LMuzYWdKOwf1oSlKp1YcVV050JuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V5akrcBY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V5akrcBY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709196188;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DEuBlHD3kgoIX0ziveljn5872wJi8XDsY60eCgSwad4=;
	b=V5akrcBYhnejaido7NesbKrmOpOAMM4eAAMishpEl3Rl/4egY0utXVNBiI/cJL3AG59Y1M
	Yg3cIAhDf6gxE4jqVFUePNA6lY4GDTNNWLZ42rdNaFIsF9mrQeHt051ycOSnQflg7D0dNh
	WP4k+mfiDwS4dwbFOdvSDyehA97vxkg=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-w0nlEQo2OeybfHFSfKdwjA-1; Thu, 29 Feb 2024 03:43:06 -0500
X-MC-Unique: w0nlEQo2OeybfHFSfKdwjA-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1dc3fd65b7bso5781795ad.3
        for <gfs2@lists.linux.dev>; Thu, 29 Feb 2024 00:43:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709196186; x=1709800986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DEuBlHD3kgoIX0ziveljn5872wJi8XDsY60eCgSwad4=;
        b=IA2eBsVKTnmDb2+SHoDRRbWkrlB7za0Nd3RxTq79iSe3n8bbIKDSps+fCIJkyoml24
         kJbLqxwZ+l6ZvFzc6azsANT1gZe7OEgsfjs6M+gfjZsilmcGab46/wUer0LJ4pd/ep2y
         4WpP03E2Az0gowkeuODbCxDan7TBu30+me5TKtD04xLUL1KZFvkUdvPLrPdHJQZSzY0N
         JSpR/J+wAD+3SrVddNhehDlCRAidh8lv8jXFTpQ4EHU7/A7sfc+xPeY+DFb+A7YE7fit
         u/jjx5PX71saygFbdrwySjGFXhAopm5GZsd0PQdRWFcy2OTs1Bv6WWP+fFOVqFv6FfIz
         /h4w==
X-Forwarded-Encrypted: i=1; AJvYcCVwXuOymWMeW4D9ZQ4+WtSffhSvBwV3J/fPUZUp7WkmQK45n+Xo9pls5XQfHO63fj3PchOxbXGxFAOSkEXnjWxQohVf9Q==
X-Gm-Message-State: AOJu0YxGJ4rzgKYFUo3032iLaJPjZbpV00TejYnwQxYRy2IUOzGrKN47
	N+8IivoGxP9S6kkdtTsVrwgL1cG86hgJrMJJX++Vr1hsyQBTrOazr4cl0GRhrbP6TS0ia9Evt/i
	WmL2eAzasl2rELH9A8l7JhO21nsCxaInnawBztiJOmq6ml+yNXnGnHzRFfwq/MzGEAKAkaUsdwv
	OhgqD8dUat/bgU3DNO00Ri9/v8ZA==
X-Received: by 2002:a17:902:da8f:b0:1dc:ca09:6b7d with SMTP id j15-20020a170902da8f00b001dcca096b7dmr1826119plx.2.1709196185783;
        Thu, 29 Feb 2024 00:43:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHRJixUvjUtpkuPEzMa01pFKLhC0GOFKYvulFM09afef/K1eyl+EDf7oLoFQwQVwElle44GHMlouy/Ss7TyUcc=
X-Received: by 2002:a17:902:da8f:b0:1dc:ca09:6b7d with SMTP id
 j15-20020a170902da8f00b001dcca096b7dmr1826093plx.2.1709196185336; Thu, 29 Feb
 2024 00:43:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <00000000000029b00c05ef9c1802@google.com> <000000000000cf2d2d06127def32@google.com>
In-Reply-To: <000000000000cf2d2d06127def32@google.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Thu, 29 Feb 2024 09:42:53 +0100
Message-ID: <CAHc6FU7GqeMROfnoFLbTaNnoDhwr1+eFAsP_=rQD_JkfF__AqQ@mail.gmail.com>
Subject: Re: [syzbot] [gfs2?] WARNING in gfs2_check_blk_type
To: syzbot <syzbot+092b28923eb79e0f3c41@syzkaller.appspotmail.com>
Cc: axboe@kernel.dk, brauner@kernel.org, cluster-devel@redhat.com, 
	gfs2@lists.linux.dev, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rpeterso@redhat.com, 
	syzkaller-bugs@googlegroups.com
X-Mimecast-Spam-Score: 1
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 5:46=E2=80=AFAM syzbot
<syzbot+092b28923eb79e0f3c41@syzkaller.appspotmail.com> wrote:
> syzbot suspects this issue was fixed by commit:
>
> commit 6f861765464f43a71462d52026fbddfc858239a5
> Author: Jan Kara <jack@suse.cz>
> Date:   Wed Nov 1 17:43:10 2023 +0000
>
>     fs: Block writes to mounted block devices
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D108aa9ba18=
0000
> start commit:   861deac3b092 Linux 6.7-rc7
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D10c7857ed774d=
c3e
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D092b28923eb79e0=
f3c41
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1440171ae80=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D11b1205ee8000=
0
>
> If the result looks correct, please mark the issue as fixed by replying w=
ith:
>
> #syz fix: fs: Block writes to mounted block devices

Sounds reasonable:

#syz fix: fs: Block writes to mounted block devices

Andreas

