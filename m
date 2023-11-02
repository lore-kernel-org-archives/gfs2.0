Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861F122303
	for <gfs2@lists.linux.dev>; Thu,  2 Nov 2023 22:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I4263HfH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698963089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pwQQL/PKP43Gvvb08OW0KEGorvc7QsnJMcAGv+KBQwU=;
	b=I4263HfHRs50w5uMIcZyoelOXL5vfaiJAIUinmzgOGj/X1HYcOL0/Wyc6sVkS3COIe3quZ
	xAhnOEyHD+Lvgz88Af8lED8jLhg1vr6IsMF22AObsGBAVjYeds7ochqOUmyFk19B384M8k
	Sbk98VGvskfK57HfMnJy3d0qErFQMLM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-55yAzG21NsKyGTDq-GTbCA-1; Thu, 02 Nov 2023 18:11:28 -0400
X-MC-Unique: 55yAzG21NsKyGTDq-GTbCA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9b2cf504e3aso112617466b.2
        for <gfs2@lists.linux.dev>; Thu, 02 Nov 2023 15:11:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698963086; x=1699567886;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pwQQL/PKP43Gvvb08OW0KEGorvc7QsnJMcAGv+KBQwU=;
        b=XG81J7l80ZPVrqsxzUO6Mxr/z1yoXJqOKQ++/+2a//h5JNF6gKKSC1UrHPiJYKjJ0w
         6S8LqVOxNFZ8YiOuNrIXp8XCKYgEL4X/CAQ5/xvCkXFmpkoDFFEm5MeTI23AxFNluStk
         ZRuVZNLNb9OQqGLbZEhSysvPqAFPRQkLKcy2toPDZ/BeWCzErarfrwRcMQGzyNx1zYFQ
         HByBTvFmcIZlFj98JOMcqADkoxFzAaE7uqD4sf+r1uVbojgfDStZiKMLk75MrQ4YGOQM
         c9ZNTtRFhMVwZ7q2DDpXGPyzJtx0sUWENZkPIq0Z4+24WpcbTSceWdGYx/yQu+L2ikjU
         G4pQ==
X-Gm-Message-State: AOJu0YyAcXdMBtA1xL5XiVLZg8VN0Boq4AC1vCHP+bPTn4OxiYltE4+v
	dyc5ox+e8c1HptMF+fZR97MeRjTA3SMN0xC1Jiwwvoq8pwYj95L43cgiqJIlXs4/Kof142eO/KD
	pCwQlMJLGXZIcNzx4wpKCBL7a2aViu//RzNQt3A==
X-Received: by 2002:a17:907:a4d:b0:9d4:2042:7751 with SMTP id be13-20020a1709070a4d00b009d420427751mr5987039ejc.35.1698963086207;
        Thu, 02 Nov 2023 15:11:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+c8YeDwCBgAWwQG36cA61ZM7maAoP3ks/4hh8hVmST3D3ktQ4xzTAlCcOSNGHwpPRyxzmKEHAYlcZxDmQoKw=
X-Received: by 2002:a17:907:a4d:b0:9d4:2042:7751 with SMTP id
 be13-20020a1709070a4d00b009d420427751mr5987026ejc.35.1698963085928; Thu, 02
 Nov 2023 15:11:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231102195803.1212539-1-agruenba@redhat.com> <CAK-6q+h7zaCy7DZjYsmc0Z+w6iVhrWvLL2icrhXpWH5Z=aYEog@mail.gmail.com>
 <CAHc6FU4Ym_nzTvvS6=1AjZm=de3X_kjd0Dn1x329L==WiDeqig@mail.gmail.com>
In-Reply-To: <CAHc6FU4Ym_nzTvvS6=1AjZm=de3X_kjd0Dn1x329L==WiDeqig@mail.gmail.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Thu, 2 Nov 2023 18:11:14 -0400
Message-ID: <CAK-6q+iTBiN+RYgMYpPn1-0PxTYe+-kei1-t8-B_a1zm2J5MVg@mail.gmail.com>
Subject: Re: [PATCH] gfs2: don't withdraw if init_threads() got interrupted
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: gfs2@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Nov 2, 2023 at 6:09=E2=80=AFPM Andreas Gruenbacher <agruenba@redhat=
.com> wrote:
>
> On Thu, Nov 2, 2023 at 9:50=E2=80=AFPM Alexander Aring <aahringo@redhat.c=
om> wrote:
> >
> > Hi,
> >
> > On Thu, Nov 2, 2023 at 3:58=E2=80=AFPM Andreas Gruenbacher <agruenba@re=
dhat.com> wrote:
> > >
> > > In gfs2_fill_super(), when mounting a gfs2 filesystem is interrupted,
> > > kthread_create() can return -EINTR.  When that happens, we roll back
> > > what has already been done and abort the mount.
> > >
> > > Since commit a28dc123fa66, we also call gfs2_withdraw_delayed() in
> > > gfs2_fill_super(), but that only marks the filesystem as withdrawing =
and
> > > relies on a caller further up the stack to do the actual withdraw --
> > > which doesn't exist in the gfs2_fill_super() case.  Because the
> > > filesystem is marked as withdrawing / withdrawn, function
> > > gfs2_lm_unmount() doesn't release the dlm lockspace, so when we try t=
o
> > > mount that filesystem again, we get:
> > >
> > >     gfs2: fsid=3Dgohan:gohan0: Trying to join cluster "lock_dlm", "go=
han:gohan0"
> > >     gfs2: fsid=3Dgohan:gohan0: dlm_new_lockspace error -17
> > >
> > > Fix this by getting rid of the ill-conceived gfs2_withdraw_delayed() =
in
> > > gfs2_fill_super().
> > >
> > > Reported-by: Alexander Aring <aahringo@redhat.com>
> > > Fixes: a28dc123fa66 ("gfs2: init system threads before freeze lock")
> >
> > nitpik, this is not the right commit, calling gfs2_withdraw_delayed()
> > was already been there before if init_threads() fails just in super.c
>
> Ah, so this problem was already introduced in commit 62dd0f98a0e5
> ("gfs2: Flag a withdraw if init_threads() fails"). Thanks for pointing
> this out; I've looked up what that was supposed to fix and I've
> updated the description.

I looked into that commit, but this also fixes some ctrl-c issues
pointed out by me... I am not sure if we are going back and forward
here with ctrl-c issues.

- Alex

