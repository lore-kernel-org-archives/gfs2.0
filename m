Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494341C286
	for <gfs2@lists.linux.dev>; Mon, 30 Oct 2023 21:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bEW+nkfR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698699915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1JmURPcvLtSqLUUbFA7SrmnbERd26AC5lme3Qx7nOkM=;
	b=bEW+nkfRZw1fTRzn6LzOi+Dq+Y0lvS7dvJ78R5MV8IRVQGo5QiY5IoE4wZ3V7wdbcMogEp
	iU8e+Q8GuD67t7tqpqXRS5doZRP+4NDg1u0td4IdT1u49omv6pbLzI7SV1QDW5F3tn2Njw
	10hCaqFea/MJ+SbkvYPD7p4LukN+3DA=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-u8EyToqjMfq5_-rHHMTcJw-1; Mon, 30 Oct 2023 17:05:13 -0400
X-MC-Unique: u8EyToqjMfq5_-rHHMTcJw-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5b9aa9dabedso750892a12.3
        for <gfs2@lists.linux.dev>; Mon, 30 Oct 2023 14:05:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698699912; x=1699304712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1JmURPcvLtSqLUUbFA7SrmnbERd26AC5lme3Qx7nOkM=;
        b=rpogdVCgGtwIkw4lUyyDeDYFmiiovqkgfvV5/EDh6kc3b32zY9sTETHb7e4yShJw1d
         Acwp5oI9/eFCPe5N+kVMIOZd9VGNsiKcE3Uz4UkgEwE1rdhy7auu8DztG30LfjCIJ8Cz
         f17fDS0jhI9vkYbp0tMqq1pDdbfO/eKgmwjCVbfHzUOcdSNtLaNTqEo0MxTP2i5N2TGc
         fD4JI5TBrARhZaJ9IXZegSviC9nwi48tDOPtuuHJomZr9tx6D1DD0FWg2qde2tR2lm/q
         FMpFaeZ55U1fpPDBYhfnfKusCU+kqt5tKYdoVzfHYGLsGeWeoF1Ltq5WqcQjkEZKR5Mt
         8mRw==
X-Gm-Message-State: AOJu0YyMFl0cSys2+nNa/dy9LpLDZLYLgPOgVQ600yFrAdwXtd+wAL74
	yFYzROJEiqFczlR2l30iDsxXKasSj07RYi8suEDtZiiYPUM+DntdXq3a63myGaQpc1KCW4lGpJi
	j/I6Ln1P+sugy45Rrg7O9hx5xZluTEw==
X-Received: by 2002:a17:902:bf44:b0:1ca:c490:8537 with SMTP id u4-20020a170902bf4400b001cac4908537mr8378143pls.14.1698699912579;
        Mon, 30 Oct 2023 14:05:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzbZk3QaOS4ZLoC9Xi0ie7QckJKqDxiUMckdm8KX4ydz1J+XDcKYN3ZT+xrDzl974H1L6JMnNQ06VhK1wjIKY=
X-Received: by 2002:a17:902:bf44:b0:1ca:c490:8537 with SMTP id
 u4-20020a170902bf4400b001cac4908537mr8378130pls.14.1698699912248; Mon, 30 Oct
 2023 14:05:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <0000000000000c44b0060760bd00@google.com> <000000000000c92c0d06082091ee@google.com>
 <20231025032133.GA1247614@ZenIV>
In-Reply-To: <20231025032133.GA1247614@ZenIV>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Mon, 30 Oct 2023 22:05:00 +0100
Message-ID: <CAHc6FU4Zd0szGBzZBx212K4MgjFJAEMwD1jbTraw0ihMG14Z2w@mail.gmail.com>
Subject: Re: [syzbot] [gfs2?] WARNING: suspicious RCU usage in gfs2_permission
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: syzbot <syzbot+3e5130844b0c0e2b4948@syzkaller.appspotmail.com>, 
	cluster-devel@redhat.com, gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, postmaster@duagon.onmicrosoft.com, 
	rpeterso@redhat.com, syzkaller-bugs@googlegroups.com
X-Mimecast-Spam-Score: 1
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Al,

On Wed, Oct 25, 2023 at 5:29=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
> On Fri, Oct 20, 2023 at 12:10:38AM -0700, syzbot wrote:
> > syzbot has bisected this issue to:
> >
> > commit 0abd1557e21c617bd13fc18f7725fc6363c05913
> > Author: Al Viro <viro@zeniv.linux.org.uk>
> > Date:   Mon Oct 2 02:33:44 2023 +0000
> >
> >     gfs2: fix an oops in gfs2_permission
> >
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D10b21c33=
680000
> > start commit:   2dac75696c6d Add linux-next specific files for 20231018
> > git tree:       linux-next
> > final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D12b21c33=
680000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D14b21c33680=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D6f8545e1ef7=
a2b66
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D3e5130844b0c0=
e2b4948
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D101c8d096=
80000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D11a07475680=
000
> >
> > Reported-by: syzbot+3e5130844b0c0e2b4948@syzkaller.appspotmail.com
> > Fixes: 0abd1557e21c ("gfs2: fix an oops in gfs2_permission")
> >
> > For information about bisection process see: https://goo.gl/tpsmEJ#bise=
ction
>
> Complaints about rcu_dereference() outside of rcu_read_lock().
>
> We could replace that line with
>         if (mask & MAY_NOT_BLOCK)
>                 gl =3D rcu_dereference(ip->i_gl);
>         else
>                 gl =3D ip->i_gl;
> or by any equivalent way to tell lockdep it ought to STFU.

the following should do then, right?

    gl =3D rcu_dereference_check(ip->i_gl, !(mask & MAY_NOT_BLOCK));

> BTW, the amount of rcu_dereference_protected(..., true) is somewhat depre=
ssing...
>
> Probably need to turn
>                 ip->i_gl =3D NULL;
> in the end of gfs2_evict_inode() into rcu_assign_pointer(ip->i_gl, NULL);

That's what commit 0abd1557e21c6 does already so there's nothing to fix, ri=
ght?

> and transpose it with the previous line -
>                 gfs2_glock_put_eventually(ip->i_gl);
>
> I don't think it really matters in this case, though - destruction of the=
 object
> it used to point to is delayed in all cases.  Matter of taste (and lockde=
p
> false positives)...

I don't understand. What would lockdep complain about here?

Thanks,
Andreas

