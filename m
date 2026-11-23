Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795435022;
	b=Mlai84megQIFQiBCz2mu+t1md+ShoFgeyJuy+SF37SOHOQMQR7jSBiq5TUxdJKNejVWu
	 ZBv6zzINa7RTiJpXE/PLri/425hbXBoGkfX8eSIihsbIfvDzwcmj2OJlGUUTQ4v6fMM+X
	 f4yE9zotyCilVYpanyX5wSSzjBtfSz0yj/sHWQ1yfz/RnaFnaHz7KnB4F8L5GOq0hyQp7
	 +GuuRX2Ji700YXgYivfPnfVM2DUuP0ww1g3goL+4aL5i1FUB8X5URiy6HErD+5maE730e
	 Kd7QWF+U012wdOrNSIL5XjVCiSAb/NoDWRbAKFMWa4M6UNFqof3MRSdXWqkJXG2s/CA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795435022;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=oqxTqGc37dwDnLjYZnqU54myhb23sMonqleeRzhUP+A=;
	b=ntGjtKFVxmKDX2AYZ89UTZ30QrP1Ety2Aa24NG8auVWeKpuzI1pAXZ6zIR3tKKzDgDwh
	 AKAo+G243wRfZHvIwYT2Bn7POBLgVcFqsLRQGdR2meUiWknP3/Fp/tbLT/aaxkfHKd1jv
	 RvHGaWoCnOP76cPinTRIHve5BHeLIGdGEDuwIBZBII7t0YZEUA3BAhTzK5ELQIkkf4cn6
	 hNCbg1QKMNLhb2bLhxfbwGcrtVO/0rXQikA4WYcedy/QFuFXuyeefOFL3KAyzODjzsJ2W
	 uRal6cwKye49GO25Y4m+/ouCPO+9OvLUmVFpbUPt5g1T1PL9RpYPg5zCJIhEgCkDr6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=E+gRbUMk;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387B4606A31A
	for <gfs2@lists.linux.dev>; Mon, 23 Nov 2026 11:57:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 387B4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=E+gRbUMk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795435021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oqxTqGc37dwDnLjYZnqU54myhb23sMonqleeRzhUP+A=;
	b=E+gRbUMkXzr0ftgnphVyzjzHx4e5SigwzrZsgeRJCNybCOx25/aMeDa/5uK8JDEq0XaT8T
	/GotI0hz8XNeEaCJySIHX7w0tJVAPDeoB3onXSvfuP5VncwyfmwP7YIzUrYUIH/3A0FxwR
	7vcuuTbyVgva45tbdLQt4k2HsLFCp7w=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-5QQyLO7JPa-AMtFEm7hSqw-1; Mon, 23 Nov 2026 11:56:59 +0000
X-MC-Unique: 5QQyLO7JPa-AMtFEm7hSqw-1
X-Mimecast-MFC-AGG-ID: 5QQyLO7JPa-AMtFEm7hSqw_1795435019
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-677c2db10b1so4706388d50.1
        for <gfs2@lists.linux.dev>; Mon, 23 Nov 2026 03:56:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795435019; x=1796039819;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oqxTqGc37dwDnLjYZnqU54myhb23sMonqleeRzhUP+A=;
        b=Lziqg1rU/VEf3PhLlRLbADFL9TUMWsDRdZgn+8HcAWWZHVrcZ5HI/JQS1fYJao3bwo
         ssrAkhq+4nuYKSdlJ9LciiLoClFEX17ETk30CCt+1Z++HaQYRE1zndWQKpBOsgl9fOi0
         LLf8HX6dpPMQgvEEDWZU0D4jUKuT2/ZBCAY5Ztx6EXuxKLkwvm2pRUL7E/ot502Gkq3i
         isiw+UdQ/D/jovBV9fcc2sH171Hj710g3zOgX6SftK4c/s5NioREtqEnJ3Dv3Fw2Pt3Z
         q02+DsvC22fZihRsTlvoPtlJ6WNFO5tCncrkz3VuCEjHncApTQslGytpW8kTipZQz+Rg
         efdQ==
X-Forwarded-Encrypted: i=1; AL+hErEwmCqWR/c/V1hr3HP+/jYwCbv2HEca1IyGs25uzSGgUZlSdpT1VoQsv8BuUMgImrq3h6EP@lists.linux.dev
X-Gm-Message-State: APuU4Z+RvovpJL1qzR1kyQfvEeWzeAQqSRA1H0525HIOEC1nkNUkkOh0
	byrqjY9zth61N7242X69ey0sM6h1sDra+zFJU8pOwTe8Xl1nWWLtafBw1Hl9u+fJfnu1a2Hp2Wn
	XAOjebGFrf7mLya4qat7pzW0+OeK2XQCrit64H+aOg2VeXHaPe5JRSFfi0rK8peMQNmgXJlYNM4
	HP+XpCT5k5YHcs5g8UoXmaS5m4TWf4pA==
X-Gm-Gg: AZFdTZdoQSKBxjGaqtCF0wszhKI4x2zBw/7872MowRLUeHV2m4GvFbqPBTjRdtH1UO1
	nl5ykxhcTHNQTKhT+5myWCLbegdo/0KNUgQvX3E66VkB8rggAmDqYIdFrhzKOo0lADCTrMWbwKm
	RIXXU0oU206ENAeMurP/QeIVqgD8/OLqFpooA/VRtSZvPzBf2Tm3wqihPwkNRP5GkVrV0hWnISx
	buTHB+bZasErMoPSTtQWltTa3oW2yBeqEuwuuouG6A6MQ==
X-Received: by 2002:a05:690c:6b05:b0:8b3:ba8d:2f55 with SMTP id 00721157ae682-8b52043567emr39667297b3.33.1795435018868;
        Mon, 23 Nov 2026 03:56:58 -0800 (PST)
X-Received: by 2002:a05:690c:6b05:b0:8b3:ba8d:2f55 with SMTP id
 00721157ae682-8b52043567emr39667047b3.33.1795435018370; Mon, 23 Nov 2026
 03:56:58 -0800 (PST)
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Post: <mailto:gfs2@lists.linux.dev>
List-Help: <mailto:gfs2+help@lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
List-Owner: <mailto:gfs2+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261120031305.3561045-1-huangsj@hygon.cn> <20261120031305.3561045-2-huangsj@hygon.cn>
 <CAHc6FU7VUBLg=gX-xspFfp4jPffdH7Pc4oVx5nRDo7A3aiVWug@mail.gmail.com> <awP5q_CmS3uIqfCw@hsj-2U-Workstation>
In-Reply-To: <awP5q_CmS3uIqfCw@hsj-2U-Workstation>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Mon, 23 Nov 2026 12:56:47 +0100
X-Gm-Features: Aa3M54pdTCvZmmXjws9eztEBY-s6WsNxLh4ieFxp9T0N0Za24a02lla1XE5V3KA
Message-ID: <CAHc6FU7rAr4Mbf3KssQdsxhdk7D+2SzxSydkyw7cgykGGJOi=A@mail.gmail.com>
Subject: Re: [PATCH v3 01/11] vfs: add super_iter_inodes()
To: Huang Shijie <huangsj@hygon.cn>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	hch@infradead.org, mic@digikod.net, axboe@kernel.dk, gnoack@google.com, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, legion@kernel.org, 
	aleksa@amutable.com, libaokun@linux.alibaba.com, ebiggers@kernel.org, 
	djwong@kernel.org, sandeen@redhat.com, zhongyuan@hygon.cn, 
	fangbaoshun@hygon.cn, yingzhiwei@hygon.cn, wujianyong@hygon.cn, 
	shijie8@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	gfs2@lists.linux.dev, linux-security-module@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _EeMa3D5g7doL-MG2iOrpIRM4wGM8B2bfjhIKS3WEd8_1795435019
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2026 at 9:31=E2=80=AFAM Huang Shijie <huangsj@hygon.cn> wro=
te:
> =E5=9C=A8 Fri, Nov 20, 2026 at 03:56:23PM +0100=EF=BC=8CAndreas Gruenbach=
er =E5=86=99=E9=81=93=EF=BC=9A
> > > +
> > > +int super_iter_inodes(struct super_block *sb, ino_iter_fn iter_fn,
> > > +                     ino_iter_eligible_fn eligible, void *priv, int =
flags);
> > > +
> > >  struct super_operations {
> > >         struct inode *(*alloc_inode)(struct super_block *sb);
> > >         void (*destroy_inode)(struct inode *inode);
> > > --
> > > 2.53.0
> >
> > Sorry to say, but this has gone quite a bit off course. Can you try a
> > construct like iomap_iter() instead?
>
> Christian had suggested to use the following methed:
>   https://lore.kernel.org/all/20261120-mitverantwortlich-drehbaren-kantho=
lz-241300d20168@brauner/

Yes, that's what I meant.

Thanks,
Andreas
