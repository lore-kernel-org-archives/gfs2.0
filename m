Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B459245D5FE
	for <gfs2@lists.linux.dev>; Sun, 20 Sep 2026 16:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789921940; cv=none; b=C4BsM1mxT7pLSneV/FZC+UgVEWN5N+uEK3No4wXQkPscCgHYhElP1SU/tm2I9aLbIatYMlXzByLfjmfv6NuTjs7T5A+WWhR8OEiJBsxAg6OXKM4FVTCbDg243GJTwCttYq7XTinKO3J77jBQqwWcyH0WLJGet8fmt0tZPo20iUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789921940; c=relaxed/simple;
	bh=+4YERuX/Tm4BEarMicY7oOWvS+xS/CmiXnLfQ+itnn8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DP8jBIFNnkCxlF56s25KUNfXxHPLXGfeFSbSHJ3AGqfq4f+yUXrIn91QSa1WosCGNmywRzZNsudXwKSKt2Y7yZeNjzs6oYUbGb126aaYeIk5S+pGlL/pPPPOWbdhLB+nQhi7MIWyYYcrD+4Tq8qYNMwKkdJlziNDQvStT+Rzddw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IPH/UlHc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IPH/UlHc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789921933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6ElUqtRQzGRczK+6qtQzmlt/OBYAjwvyq42r0CytLLM=;
	b=IPH/UlHcVsUic4V9o/HJERvOAnPve1FCYhoh8rfNL4qbSj5r5Tx4RuL15d+Yz/ddw14er8
	+pUlMbhNzLMIXrG7z+Xdu5fpTWW4JhVJaGfOjj4Rv5nmrynV45u5/9vS0avhLymF+UVc3y
	VWw62VoJao+vyFAUBEDjzqcz8KybpvM=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-21-8rNtfyM4MbqU7wklJ_3FIQ-1; Sun, 20 Sep 2026 12:32:12 -0400
X-MC-Unique: 8rNtfyM4MbqU7wklJ_3FIQ-1
X-Mimecast-MFC-AGG-ID: 8rNtfyM4MbqU7wklJ_3FIQ_1789921932
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-66c70bf18a1so2372847d50.0
        for <gfs2@lists.linux.dev>; Sun, 20 Sep 2026 09:32:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789921932; x=1790526732;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6ElUqtRQzGRczK+6qtQzmlt/OBYAjwvyq42r0CytLLM=;
        b=MjZIkwY8QH7wluCVk8IZ3CRfk77OyZ4e6I8MjYXLN+MwQPuCfxD7hoX8SaI3iE2GNH
         PJiwPdsL6zbgezMQDLY8bPCzSZAAUJfEm/EkvOLawdcE/OIflumW/DtVqJsgrE4cWbX9
         mlky6/tr4gWdkqp5cOJ7MfdFCSl08RCuUqXNh9WXx6X6lkVzEkOO1kml/2ToyRQA7BmM
         9+6ZL3F9kZPY/R0DcWEIWqZnsdJnevJqEWUT/wbHoypAgTB/RScxnHw08j8vILWQqD5Y
         GWUpkW6rCVozTBeqn1PjuersLf5YQtnq3zY8vvgQikUKZN/oamJutbW/R/wvCo8/G8x3
         0TMg==
X-Forwarded-Encrypted: i=1; AKwUvBx7QAxBrrk3OT2EnX88t8u20WZ0miAzUwccwKMkFRcMcVUlXrJHo71c/5Y6AxcCIOFPrvOD@lists.linux.dev
X-Gm-Message-State: AFuF++lYoe4X9m3tXDWMXD7SoVBMI1qdGzMGy7HtA7BOJVkmqmIP19BD
	Ka+hI0TpRR3ymE6VkAz5Z3zWlYVCXwXlr5/ygV43MzTo5vuIJhPnHdnlSYPt8HXtvLrZKJRxQpP
	pASjrEP/68m1a6liRUuQ/TNBfsYllSCdXrdRUHlaqILCvQFK2I4muJcDLLkWLD5Ve2rLGPnKvOq
	76M5oetg1u21N2+/BZG/wlpWzX+ddsWQ==
X-Gm-Gg: AYBFou2lSOAjwqeTzQTN+/3Dp7ubOUEBWNjPfJ0IDISyroApPWpMaxqSaws6WUFpKbz
	JAAFE0slery5Ju0JpzKhqIa2OhE4PcDkuamuB8H6/Cws4CZK7xBlNDeVHxAV9hxq2nTrf5N8PNl
	zxCa75gp8UxlB73pNSpAPvVP5BCRf7k4UGvdOf7IgAoOHIGrxavcAEVnBwFJo+Fi93R/0OI/aPp
	jmi8D+Dvb8i8ILxZM4aPpEAX1Vvd+Pah76w9kRp+gw24w==
X-Received: by 2002:a05:690e:1348:b0:671:50b8:aee4 with SMTP id 956f58d0204a3-6717fdf7f42mr2684428d50.77.1789921931917;
        Sun, 20 Sep 2026 09:32:11 -0700 (PDT)
X-Received: by 2002:a05:690e:1348:b0:671:50b8:aee4 with SMTP id
 956f58d0204a3-6717fdf7f42mr2684413d50.77.1789921931459; Sun, 20 Sep 2026
 09:32:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260919022441.3305170-1-neilb@ownmail.net> <20260919022441.3305170-4-neilb@ownmail.net>
 <CAHc6FU4M59nodfn+NCDsr81Wdmvd1Ubw712FF56ekVWfe1+Nuw@mail.gmail.com> <178985655280.37859.6894749467886035489@noble.neil.brown.name>
In-Reply-To: <178985655280.37859.6894749467886035489@noble.neil.brown.name>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Sun, 20 Sep 2026 18:31:59 +0200
X-Gm-Features: AcwNN1WDWK2kuJ9juQym02aIIB-Y-9YWAPGC_3VkH8hMthBmOzCWtJtaHEAolhI
Message-ID: <CAHc6FU4cD3fb13LE1-HOEnOoUNVdW1N3e892r7rFE9HJfztvhg@mail.gmail.com>
Subject: Re: [PATCH v2 03/14] gfs2: simplify atomic_open handling.
To: NeilBrown <neil@brown.name>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>, Jori Koolstra <jkoolstra@xs4all.nl>, 
	Mateusz Guzik <mjguzik@gmail.com>, Dorjoy Chowdhury <dorjoychy111@gmail.com>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, gfs2@lists.linux.dev, 
	Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org, 
	Paulo Alcantara <pc@manguebit.org>, Namjae Jeon <linkinjeon@kernel.org>, linux-cifs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: kSbI2YDCVlyrppTBwLHPnMyKypJlDLtMhsDmXywn5I8_1789921932
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 20, 2026 at 12:22=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrot=
e:
> On Sun, 20 Sep 2026, Andreas Gruenbacher wrote:
> > Neil,
> >
> > On Sat, Sep 19, 2026 at 4:31=E2=80=AFAM NeilBrown <neilb@ownmail.net> w=
rote:
> > > From: NeilBrown <neil@brown.name>
> > >
> > > gfs2 incorrectly returns -EFTYPE for any non-regular when __O_REGULAR=
 is
> > > in force.  A symlink might not be an error, and nfsd needs to know if=
 a
> > > directory was found.
> > >
> > > Neither this check, or the following check for a directory is needed.
> > > Both cases are handled correctly by instantiating the dentry and pass=
ing
> > > it to finish_no_open() - the caller will interpret the type.
> > >
> > > Signed-off-by: NeilBrown <neil@brown.name>
> > > ---
> > >  fs/gfs2/inode.c | 17 ++++-------------
> > >  1 file changed, 4 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
> > > index f361876c5583..7aa92bb31cf4 100644
> > > --- a/fs/gfs2/inode.c
> > > +++ b/fs/gfs2/inode.c
> > > @@ -738,19 +738,10 @@ static int gfs2_create_inode(struct inode *dir,=
 struct dentry *dentry,
> > >         inode =3D gfs2_dir_search(dir, &dentry->d_name, !S_ISREG(mode=
) || excl);
> > >         error =3D PTR_ERR(inode);
> > >         if (!IS_ERR(inode)) {
> > > -               if (file && (file->f_flags & __O_REGULAR) &&
> > > -                   !S_ISREG(inode->i_mode)) {
> > > -                       iput(inode);
> > > -                       inode =3D NULL;
> > > -                       error =3D -EFTYPE;
> > > -                       goto fail_gunlock;
> > > -               }
> > > -               if (S_ISDIR(inode->i_mode)) {
> > > -                       iput(inode);
> > > -                       inode =3D NULL;
> > > -                       error =3D -EISDIR;
> > > -                       goto fail_gunlock;
> > > -               }
> >
> > as you note below, when the inode exists but it isn't a regular file,
> > we won't even get here (gfs2_dir_search() will have returned
> > ERR_PTR(-EEXIST)). So the above two if statements are dead code, which
> > contradicts the patch description. Could you please fix that?
>
> There are two different modes here: the "mode" that was requested and
> the "inode->i_mode" that was found.
> This branch will only be taken if "mode" is "S_IFREG", but the inode
> that is found could be anything.

Ah right, we could be looking for a regular inode non-exclusively and
get back any inode type.

> >
> > > +               /*
> > > +                * This can only happen if "S_ISREG(mode) && !excl" s=
o "file"
> > > +                * cannot be NULL.
> > > +                */
> >
> > Is that comment useful without removing the below NULL check for file?
>
> Fair point.  I'll remove the NULL check.
>
> I'd feel more comfortable if gfs2_symlink(), gfs2_mkdir(), and
> gfs2_mknod() all passed "1" (or "true") for the "excl" arg.
> Then it would be even more obvious that we don't need to test
> for NULL, as all callers that pass a NULL file, pass a true excl.
> (you could remove the "!S_ISREG(mode) ||" which would make the code
> look cleaner).
>
> But that is beyond the scope of this patch.

Yes, makes sense. I'll happily clean that up.

In fact, could just remove the two if statements in this patch queue?
We can then clean up the rest on gfs2 for-next without causing a merge
conflict.

Feel free to send a cleanup, or let me know if I should write that.

> hmm... you could even pass "!file || excl" to gfs2_dir_search() to make
> it impossible to use file if it were NULL :-)

Right.

Thanks,
Andreas

