Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4A37464
	for <gfs2@lists.linux.dev>; Tue, 18 Mar 2025 15:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742313104; cv=none; b=R2bkWquSe1YUT5jffzlsBqxvUpJNknyjpG4mHwjfn9PhXcWAgRfkxzlCvsqK56l2hGalDG/DfcgS0l1fH8MdZKjCg/ssYuqDD+1zT3VEy6auSJ4VUyO72NDOWn7yg7m6jxdL/LJ2niVXW7a36jhdcl0VAj1a85oQM2jXKp1FUZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742313104; c=relaxed/simple;
	bh=3IUzgW0tqmvBtDPQEnXyodqPaV1/XSemXMh7OodnVNw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O3zl8RBm3XXk377w4Che1cjw6WrMI2aDaJrB8kcy6wJKdBFzIJEuYeqe5gGLNAzEDb1L2rpLCRZeST+ABqEV5/noa3eDIiEXPXKJ2LrhX3rLw5BRFRp1SjUCpWKcdyZoXZ68k8BPgoI3UAWQ7yStLXHRs0fqkhJMvYI9+qASODM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZQ9DXbQk; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZQ9DXbQk"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ac34257295dso223273966b.2
        for <gfs2@lists.linux.dev>; Tue, 18 Mar 2025 08:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742313100; x=1742917900; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OQsfpXrf/4c4YQpb8eNn6gMWmckTaNQ66mxt9z5Ef4E=;
        b=ZQ9DXbQkFowi11GbOOTE82O8XXZxhE3RkgEF+C59V+JYvBFRis9ThKTRA25L87Q6ID
         spwVp5f9XEnNkEFFOMTfMwsMi4BygI4aKknwOK0zXjWNsieSuhdoAG8GqkdjnYjLlRIJ
         2LubZtKVMrrysFNszMRwHzAVwagybgKeRsraqPm7RR3IC4ZlAafQgqfK+JkG0x1VozIM
         O3nICe5fzrUXf9LZ726FbI8ubsn/VLROdvQuuGG6Jr/inAUTjwpGt7r3qfmo1pBLQ13M
         zyCvHQSy5VqjHNEOEuHe1ZBUqGTc0BMErU+ukLmuASPx/TVIbDetEY0Oxm88l+szVyal
         /OVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742313100; x=1742917900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OQsfpXrf/4c4YQpb8eNn6gMWmckTaNQ66mxt9z5Ef4E=;
        b=u5m9e3CxouQ0T1A+PI0OWwfoSU/GVTIJFBlXS7U3POPn/FA2Sw2/z2D1FYqo7G4biY
         ZwEU+aZWGQdUuTdf/q0HmmffB79eVpMYwWN6IZcfpSq0zZCkB3tTa2wxMvXEm+jD7TpX
         ZgozdgQRfSLQyWy71YAGgt5JbOvXzlTuD5tMdhYhXII84bsHIoHuCL0YmJXwErmfY9bY
         an19UCBb6slD3ErACTEt2gO2ZRSypVBbEG5r3Sj5804DzJq+3hEdvFy0Vc+FrH1aNo39
         3NhXF/3EHiUJsoh+iX2MGDg82NhCBqaMp7rJFQV9i6n1YVZG2sbc0nXfSnwMXUEKqAjc
         3Pdw==
X-Forwarded-Encrypted: i=1; AJvYcCWlbs74KZype7p/iJ3c7eUBBP6QxUjnivXlRIGbPNZaNOqBnzUEH02Pv2blyvGfKABLDaE8@lists.linux.dev
X-Gm-Message-State: AOJu0Yx59I23BoiQAXL0QNXr597OWR+QetyHJP+GU3qg51Yfl48NzKLY
	cO3nlMMQvbFMAn6UTWYkoRBBvW43Hhq3IZQseCIuWX5jqILBU5jytkGFap4PVGBmFmPJBJ7wWPY
	0QVbkYhgrV6NlDuTn2psjdGbKT2M=
X-Gm-Gg: ASbGncusg1t4BiQUXgg4ptUy42teMfK9bjzz9cuV41RCNAFKK16/Yum/k6O35mmerms
	oPrWJTbrcmMXtYQXHEZ+2H1/5Mr2OlYB3fYeIeVYNQf4tCV7UTMkI3snwDstr3tyOf9450HzxMz
	5RrT+c2z5+UOWaD0+nDl8an8WSCQ==
X-Google-Smtp-Source: AGHT+IFjG8edwwuf2mEVeTcyHLZb3BYe7dhVljkptYUqPN1fOMiWWxKawFj8Wyt+UhG++lSQFRDFKNY1P6+HUcVXn7o=
X-Received: by 2002:a17:907:d92:b0:ac1:da09:5d32 with SMTP id
 a640c23a62f3a-ac3301d979bmr1912910866b.6.1742313099481; Tue, 18 Mar 2025
 08:51:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250115094702.504610-1-hch@lst.de> <20250115094702.504610-4-hch@lst.de>
 <ptwb6urnzbov545jsndxa4d324ezvor5vutbcev64dwauibwaj@kammuj4pbi45>
In-Reply-To: <ptwb6urnzbov545jsndxa4d324ezvor5vutbcev64dwauibwaj@kammuj4pbi45>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 18 Mar 2025 16:51:27 +0100
X-Gm-Features: AQ5f1JoIV3Ekgoa3AyaPQZviu6xh4y3D7_TilsaK7QfN_pG3EjUXa6A87nuBb0M
Message-ID: <CAGudoHEW=MmNLQSnvZ3MJy0KAnGuKKNGevOccd2LdiuUWcb0Yg@mail.gmail.com>
Subject: Re: [PATCH 3/8] lockref: use bool for false/true returns
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, 
	Andreas Gruenbacher <agruenba@redhat.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
	gfs2@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 4:25=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> w=
rote:
>
> On Wed, Jan 15, 2025 at 10:46:39AM +0100, Christoph Hellwig wrote:
> > Replace int used as bool with the actual bool type for return values th=
at
> > can only be true or false.
> >
> [snip]
>
> > -int lockref_get_not_zero(struct lockref *lockref)
> > +bool lockref_get_not_zero(struct lockref *lockref)
> >  {
> > -     int retval;
> > +     bool retval =3D false;
> >
> >       CMPXCHG_LOOP(
> >               new.count++;
> >               if (old.count <=3D 0)
> > -                     return 0;
> > +                     return false;
> >       ,
> > -             return 1;
> > +             return true;
> >       );
> >
> >       spin_lock(&lockref->lock);
> > -     retval =3D 0;
> >       if (lockref->count > 0) {
> >               lockref->count++;
> > -             retval =3D 1;
> > +             retval =3D true;
> >       }
> >       spin_unlock(&lockref->lock);
> >       return retval;
>
> While this looks perfectly sane, it worsens codegen around the atomic
> on x86-64 at least with gcc 13.3.0. It bisected to this commit and
> confirmed top of next-20250318 with this reverted undoes it.
>
> The expected state looks like this:
>        f0 48 0f b1 13          lock cmpxchg %rdx,(%rbx)
>        75 0e                   jne    ffffffff81b33626 <lockref_get_not_d=
ead+0x46>
>
> However, with the above patch I see:
>        f0 48 0f b1 13          lock cmpxchg %rdx,(%rbx)
>        40 0f 94 c5             sete   %bpl
>        40 84 ed                test   %bpl,%bpl
>        74 09                   je     ffffffff81b33636 <lockref_get_not_d=
ead+0x46>
>
> This is not the end of the world, but also really does not need to be
> there.
>
> Given that the patch is merely a cosmetic change, I would suggest I gets
> dropped.

fwiw I confirmed clang does *not* have the problem, I don't know about gcc =
14.

Maybe I'll get around to testing it, but first I'm gonna need to carve
out the custom asm into a standalone testcase.

Regardless, 13 suffering the problem is imo a good enough reason to
whack the change.

--=20
Mateusz Guzik <mjguzik gmail.com>
