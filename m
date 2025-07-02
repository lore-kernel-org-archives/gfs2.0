Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6591940A2
	for <gfs2@lists.linux.dev>; Wed,  2 Jul 2025 22:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751493656; cv=none; b=K+6zyzVhjIZ7FmgT5xhbw21F/Fe4jN8LqPBQ7ByxGJcMDCTWQI36WrnGUsxbVaG3pmKRN2FQdjS6CetKxhMvqMF1Bv3ldgvkRTGm1hLLBuJrxdoRLlV821dox8sq53CyQfzQ4iv6pZ5Q4xnRrwa2q6AhwhgIbINS7zZhChZ3qrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751493656; c=relaxed/simple;
	bh=I2HXhl9/BOzIBeeYz0x5dYvcHignO7fdSMD8M+8Zvhg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L8JBF70xzOoeNo8CGfxnkWHr4O6pz94ggo+7wCfFNWP3sYGNRAfYtlkOjWBy4XE/lxusJJMTCEsX3zXZt9qPlS1IGT+MR4wRTlIrmuwXw/nvG6pTX3hXMaYn5kpgcw+oj7PAhAJbh8gM92hOvNs9BBrdyUuZwC/qDUluCBK/xB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g+zhJBf7; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+zhJBf7"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4a752944794so83493551cf.3
        for <gfs2@lists.linux.dev>; Wed, 02 Jul 2025 15:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751493653; x=1752098453; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=THoCMbnlktwyHzz2kQcX/L8gGaM+8iyGu2w9om/iuLU=;
        b=g+zhJBf7teQjacmMHfLBJu9W0G458aDY+tK2Py9uOVq034zv0QwwPbv9TfrtnLYj6z
         tC5cOfZv2MqQ01oVzdEsn3/4PF25m/bb7TrMGNioelPcMRsooZpu6P0USXIZmTr/D2ho
         3mBnmahKDU8zMHoKEbNATKqD9TcVNEiBBwnyJccubn5XPnatnMzSvHSCyPwW3w/ndffS
         oxvhRSyqTm5BGHnZqyo47qqeTvWI0r/RTHUVsnkD+tewZs8mM7mC2wFSN/rL6y3ZkcDB
         MVOwNkSqrXGRuyAgCKRO5wroiBeAAGNPvR1iI/gUTaZhXws5kKb15i4XXfBVZDrRqidB
         iPaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751493653; x=1752098453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=THoCMbnlktwyHzz2kQcX/L8gGaM+8iyGu2w9om/iuLU=;
        b=UQBYXoaedsgLiVLXKVwNbAs1nSOOimwBvjBMnyGQxsv0ntdZExDlE2XJNmM/A1mdK/
         i5eMS/zY3p8+cT2585dd+cx3qb+myhl1j8sSQuJ9mKjuSTQmTJSahidqYu/9MEVwyNnW
         8WLA0lVelCTNM5azyKa4K3MODfHNiSZ0nLQl9fieKitQP76y//sfM1sb3CmxQ4Gfr9IQ
         kLTfg9DhX3NpZ+1yJdYGFK+MyVV194Gv8loDkbAyFdjoqeEk8lrM69X2dDcW7xG7n9AW
         weP5aaO2g0avEbS4SWSIqV3zUQ/qW6/BoM8U3hCOt/ZCEd3irfz3lXVRMXXjUtHx012d
         owGA==
X-Forwarded-Encrypted: i=1; AJvYcCW5cjaC39A63eE5n5eE87VUJtRjnYpjUD536mru5n4K4DahduD9D5KMBxtxdtFsjPcvGLn5@lists.linux.dev
X-Gm-Message-State: AOJu0YxiKjVqNn3rPt9IpkJRCICnk8AOuOG+hro/1t3ib6axlb93vUwv
	SaDKkk8Qkw7b8jBpCTwCPcGgl6wgcDsT4CxH0KBGhMjRY+fuNgKjKT8Wec0QcnSLfCIklQuE6kE
	hVZjHgPqTbRemSvxd9JDr36jbmbgczZw=
X-Gm-Gg: ASbGncsBLvfOSio6wjDes5tSHOmNopunhcT7JE2JS4xLzeprx5G1Zcb5/OuluBCSLDo
	A0IcSYFmnKZ0e9W7o69Q1e+dXWuPNcwucK0WrPcd1pXzJoE9VNGlGClXNlPE5G+oMoACQJ5GQqa
	//YG6RBXc+AjHbipKdlR5yf8/yyrB3bzxQyPpqmmREjAHA5R074M0ijXfrLZY+EDU6KjtcQw==
X-Google-Smtp-Source: AGHT+IGzkbGoHx67gm7//UOl9sXu9mntq0NbD7/FRK8AZGQcb3YRbyxMFYTrfA3GEzYiBVHJ4SFBTIK7amTWCmVYjGc=
X-Received: by 2002:a05:622a:4c14:b0:48e:5cda:d04e with SMTP id
 d75a77b69052e-4a976a53cb0mr67294621cf.36.1751493653206; Wed, 02 Jul 2025
 15:00:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250627070328.975394-1-hch@lst.de> <20250627070328.975394-2-hch@lst.de>
 <aF601H1HVkw-g_Gk@bfoster> <20250630054407.GC28532@lst.de>
 <aGKF6Tfg4M94U3iA@bfoster> <20250702181847.GL10009@frogsfrogsfrogs>
In-Reply-To: <20250702181847.GL10009@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 2 Jul 2025 15:00:42 -0700
X-Gm-Features: Ac12FXyiBAM5F056BsVQ_D-n0BsEnWC_2Lt1EQ3hTmWssFKMH3Kv25uDtBPegLc
Message-ID: <CAJnrk1YWjSO-FmnzHGRerBP6r6rPSAAm3MgUKfkr_AYjDJjUxA@mail.gmail.com>
Subject: Re: [PATCH 01/12] iomap: pass more arguments using the iomap
 writeback context
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Brian Foster <bfoster@redhat.com>, Christoph Hellwig <hch@lst.de>, 
	Christian Brauner <brauner@kernel.org>, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-block@vger.kernel.org, gfs2@lists.linux.dev, 
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 11:18=E2=80=AFAM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Mon, Jun 30, 2025 at 08:41:13AM -0400, Brian Foster wrote:
> > On Mon, Jun 30, 2025 at 07:44:07AM +0200, Christoph Hellwig wrote:
> > > On Fri, Jun 27, 2025 at 11:12:20AM -0400, Brian Foster wrote:
> > > > I find it slightly annoying that the struct name now implies 'wbc,'
> > > > which is obviously used by the writeback_control inside it. It woul=
d be
> > > > nice to eventually rename wpc to something more useful, but that's =
for
> > > > another patch:
> > >
> > > True, but wbc is already taken by the writeback_control structure.
> > > Maybe I should just drop the renaming for now?
> > >
> >
> > Yeah, that's what makes it confusing IMO. writeback_ctx looks like it
> > would be wbc, but it's actually wpc and wbc is something internal. But =
I
> > dunno.. it's not like the original struct name is great either.
> >
> > I was thinking maybe rename the wpc variable name to something like
> > wbctx (or maybe wbctx and wbctl? *shrug*). Not to say that is elegant b=
y
> > any stretch, but just to better differentiate from wbc/wpc and make the
> > code a little easier to read going forward. I don't really have a stron=
g
> > opinion wrt this series so I don't want to bikeshed too much. Whatever
> > you want to go with is fine by me.
>
> I'd have gone with iwc or iwbc, but I don't really care that much. :)
>
> Now I'm confused because I've now seen the same patch from joanne and
> hch and don't know which one is going forward.  Maybe I should just wait
> for a combined megaseries...

Christoph's is the main source of truth and mine is just pulling his
patches and putting the fuse changes on top of that :) For the v3 fuse
iomap patchset [1], the iomap patches in that were taken verbatim from
his "refactor the iomap writeback code v2" patchset [2].


[1] https://lore.kernel.org/linux-fsdevel/20250624022135.832899-1-joannelko=
ong@gmail.com/
[2] https://lore.kernel.org/linux-fsdevel/20250617105514.3393938-1-hch@lst.=
de/

>
> --D
>
> > Brian
> >
> >
