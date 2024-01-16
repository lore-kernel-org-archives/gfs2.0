Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9479B1BF54
	for <gfs2@lists.linux.dev>; Tue, 16 Jan 2024 15:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UUuys75n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705420558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EkaObLRiZU2WVUtOEp3KCOMnmv+FaFDDWJ1dwMpQFZ4=;
	b=UUuys75nzd0ticNVRFUOAow5I4Y6pue7CxfVAR134eZlmYIREULnggiDUNNgFDdFTf0m3e
	/Bg8SSQDcjhNbbcUb8TeVseFu7mCrVb6GdrA/QpqhzQ/yJrT6VzhlT8Krfn01/R0MNwyjr
	7x0Smcuy2YinVUww945BjTLxGjc+t1A=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-ya4hKE0vMG6Se49eqLUflQ-1; Tue, 16 Jan 2024 10:55:56 -0500
X-MC-Unique: ya4hKE0vMG6Se49eqLUflQ-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1d4c36e9507so57123705ad.0
        for <gfs2@lists.linux.dev>; Tue, 16 Jan 2024 07:55:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705420555; x=1706025355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EkaObLRiZU2WVUtOEp3KCOMnmv+FaFDDWJ1dwMpQFZ4=;
        b=Zr8U3P38V1fuA+O5rWzOCW8B0XkNz/nPXMTcd3zM1Kdcxhas+6f2REylhdjrCaLvHp
         bsRD0hlqPsutbEvFshu4tV990HlGl4cCVWSpZQDqpjAA8QCp3lVQKiKzWuY3bsQgvt2j
         lpZS30ZRJkDWGj/5gPoxYut365riu7oADaAYRA/EKTl9kndSSybVzm9mUI409/f9csR/
         yuqZHEi4dSWgShj03C3UE9eZPkwSRfThF/BHJCyvQqkUp6wCneXSlhYPnnaUb2dROPyL
         AF0g1t4aBaajOEL27Sc1QvUs3t6y9cyZuILg3DsgG/aOu7npAirlptsWYZeXkhyDNOok
         gubg==
X-Gm-Message-State: AOJu0Yw41p+2X7LaVg8Hf1k4O2OYa8HRe4n+0EFl1oGLbKQ1k3W9truP
	h0PYOby9wZbPmV+z2tas9IGyIJKRtf0ZH0ZFiMZp7mJbIy/XdaiUJzmd7CRgLX3Dl8NREGKrBl7
	B1w4yRGEW2+aPij0UuZVTvHTacOZilQ1Iin/Esg==
X-Received: by 2002:a17:902:a98b:b0:1d4:672f:4809 with SMTP id bh11-20020a170902a98b00b001d4672f4809mr3966898plb.129.1705420555684;
        Tue, 16 Jan 2024 07:55:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHZQrzkzOTwvJXIqY16Mk/9F/L79khIzMK3iukN9JqmT78QTW3UdlrX8fmF1HTGkx/EuRv2R27m2byQtY34e3Y=
X-Received: by 2002:a17:902:a98b:b0:1d4:672f:4809 with SMTP id
 bh11-20020a170902a98b00b001d4672f4809mr3966881plb.129.1705420555426; Tue, 16
 Jan 2024 07:55:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <00000000000057049306049e0525@google.com> <000000000000fa7c3b060f07d0ab@google.com>
 <20240116103300.bpv233hnhvfk3uvf@quack3>
In-Reply-To: <20240116103300.bpv233hnhvfk3uvf@quack3>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Tue, 16 Jan 2024 16:55:43 +0100
Message-ID: <CAHc6FU6wzkniuMormDzthUpj3fCap-iFFRfa_skEAvp6fwBOJA@mail.gmail.com>
Subject: Re: [syzbot] [gfs2?] BUG: sleeping function called from invalid
 context in glock_hash_walk
To: Jan Kara <jack@suse.cz>
Cc: syzbot <syzbot+10c6178a65acf04efe47@syzkaller.appspotmail.com>, axboe@kernel.dk, 
	brauner@kernel.org, cluster-devel@redhat.com, gfs2@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rpeterso@redhat.com, syzkaller-bugs@googlegroups.com
X-Mimecast-Spam-Score: 1
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 11:33=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
> On Mon 15-01-24 19:35:05, syzbot wrote:
> > syzbot suspects this issue was fixed by commit:
> >
> > commit 6f861765464f43a71462d52026fbddfc858239a5
> > Author: Jan Kara <jack@suse.cz>
> > Date:   Wed Nov 1 17:43:10 2023 +0000
> >
> >     fs: Block writes to mounted block devices
> >
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D165bebf5=
e80000
> > start commit:   3f86ed6ec0b3 Merge tag 'arc-6.6-rc1' of git://git.kerne=
l.o..
> > git tree:       upstream
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dff0db7a15ba=
54ead
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D10c6178a65acf=
04efe47
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D13e4ea146=
80000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D13f76f10680=
000
> >
> > If the result looks correct, please mark the issue as fixed by replying=
 with:
> >
>
> Makes sense.
>
> #syz fix: fs: Block writes to mounted block devices

Thank you, Jan.

Andreas

