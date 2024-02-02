Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8BA1474CD
	for <gfs2@lists.linux.dev>; Fri,  2 Feb 2024 16:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706891564; cv=none; b=p++ySNweR/DuzcHQ0v9+jzIwejaKEib0+J4o/2f+KRNHgFNmYeOno4//v/rEynwRffZGctwwyiI3UahpSuFbmKYgGZwtX3W5vd4ehbb5+zM4GsmSgqn9m2ymMXcjLkbQeI/r8yHhot148/GZFRpWIKEQTryvHoVy5m3w5VcZtZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706891564; c=relaxed/simple;
	bh=8C+0n6TyDSH+n5YDVH3wLDcNX2sXA02pJcsN/p7Abxc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gGmvKq3c4xBnA82oVImhGEaprg/5ivinJJ1xuZnQ5WsKRcpxOUSyruBvrr4kBWkP866jAkhGcQYjv/i9+0UH0NdqD3FLZA//i9g/erdjzXjlKS7l//4ib1KSiKmA5MZgKoCFkmefoBtKmsQih+5R4MoSx1q5JOcdEwG7pH4x21o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CvvrQvSP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CvvrQvSP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706891557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pnva/E2axfPUjqausguqkoOkvXt+k+PBwt3jjgeYpR8=;
	b=CvvrQvSPtO0wlAvs1sSrsrupD3dG5iK9aQEkNIXAmYUAlzP6yRZ9e4l17117m6ZVBc4dpm
	CZzRnIET+vvSiqG+sYJid17DHvSjcbXHOlaXqviOLHT3Fc4TrNoJSU24Qu6BaB93mAp23n
	SoaFCrfXFgxXQ4cYdTnZfMsgmEawc3k=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-o78LPoPzNBmznOOQ0fq0Mw-1; Fri, 02 Feb 2024 11:32:36 -0500
X-MC-Unique: o78LPoPzNBmznOOQ0fq0Mw-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1d9657c2b71so15513885ad.3
        for <gfs2@lists.linux.dev>; Fri, 02 Feb 2024 08:32:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706891554; x=1707496354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pnva/E2axfPUjqausguqkoOkvXt+k+PBwt3jjgeYpR8=;
        b=GsIup4jAJNhhMaH6H7q9rL+8e4HkOdfPV/H/2gPFdb2JTfOIeEeRcAjaFnfuaKG3NA
         65ZQvkL5/kPmCFrG78QPoC/muS1q9lxppK3Ug8DAfp/JNxenaEYW/DYoacb4gonoOa63
         uN+DiwHeUae/Q45p1PtF44SsCfEP6V+u+zNL7ZLKJPcSj9LRiXIkoTbfGqF4SOg1xgTk
         LCzqZ/Z6heru2ZE9X8t8+QAyCDW/TWrBAUnjPHQlVIP/KHt2mex223f7Tesf6HSBhj4/
         fnPbNc8wzICn6CP2nbojHf2jxkMIG2+r+ejbZoBij6jhAzMEb1I+Yc25PbyWZINHyZx4
         EV4A==
X-Gm-Message-State: AOJu0Yxvq94pZuifXoa3aXm+tY8Ye2ctfvsey2AiWXJ41n51elwoaOmI
	eaRQlz21oWrAtopO+VMDYDIqq5v6ddkEDDqYx7Mjl+XsUqpFaymHspuNIgv41gpc0ZSXL0ldR3w
	2mjiUu39nfsMPGf08W5fAoMDMSjbQyaOh1SOaIDlgeeXHzVsdGXUeagzaSN5xcEnYc388qs0PLG
	9fA77ts8Ee0fD7c4M1RyP/ucxWljMUFBwwKVxZ
X-Received: by 2002:a17:903:1c2:b0:1d9:7e0f:c398 with SMTP id e2-20020a17090301c200b001d97e0fc398mr1224849plh.18.1706891554478;
        Fri, 02 Feb 2024 08:32:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG3FJ9lq1DdTedlwBPP/0+5YwjTeyADu9uv2M4ELbsCmWq3JmQ2cOhoeMCJy8MGxnulNNyYc8oqC7WHYm+Y2Mc=
X-Received: by 2002:a17:903:1c2:b0:1d9:7e0f:c398 with SMTP id
 e2-20020a17090301c200b001d97e0fc398mr1224829plh.18.1706891554214; Fri, 02 Feb
 2024 08:32:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240119212056.805617-1-agruenba@redhat.com> <20240202042312.GY2087318@ZenIV>
 <20240202043438.GA871762@ZenIV>
In-Reply-To: <20240202043438.GA871762@ZenIV>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Fri, 2 Feb 2024 17:32:22 +0100
Message-ID: <CAHc6FU7XP_ONzqYyYO--=f8+kGcdUxM5gmfMQAkD6gNTxpPghg@mail.gmail.com>
Subject: Re: [PATCH 0/9] gfs2: Bugs in "Use GL_NOBLOCK flag for non-blocking lookups"
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: gfs2@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Al,

On Fri, Feb 2, 2024 at 5:34=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> wr=
ote:
> On Fri, Feb 02, 2024 at 04:23:13AM +0000, Al Viro wrote:
> > On Fri, Jan 19, 2024 at 10:20:47PM +0100, Andreas Gruenbacher wrote:
> > > Hello,
> > >
> > > Al Viro has reported issues with commit dd00aaeb3432 ("gfs2: Use
> > > GL_NOBLOCK flag for non-blocking lookups"):
> > >
> > > * First, parent can now be NULL and dereferencing it in
> > >   gfs2_dir_check(d_inode(parent), &dentry->d_name, ip) isn't going to
> > >   work;
> > >
> > > * Second, gfs2_dir_check() can still sleep, which breaks LOOKUP_RCU
> > >   mode.
> >
> > Looks sane, but there's another piece of fun in gfs_permission():
> >         gl =3D rcu_dereference_check(ip->i_gl, !may_not_block);
> >         if (unlikely(!gl)) {
> >                 /* inode is getting torn down, must be RCU mode */
> >                 WARN_ON_ONCE(!may_not_block);
> >                 return -ECHILD;
> >         }
> >         if (gfs2_glock_is_locked_by_me(ip->i_gl) =3D=3D NULL) {
> >                 int noblock =3D may_not_block ? GL_NOBLOCK : 0;
> >                 error =3D gfs2_glock_nq_init(ip->i_gl, LM_ST_SHARED,
> >                                            LM_FLAG_ANY | noblock, &i_gh=
);
> >                 if (error)
> >                         return error;
> >         }
> >
> > See the problem?  In RCU mode we carefully fetch ->i_gl and verify
> > it's not NULL.  Then we proceed to dereference it again.
> >
> > IOW, these ip->i_gl below ought to be replaced with gl, or you are
> > risking a compiler fetching the sucker again and getting NULL this
> > time around.
>
> fix breakage in gfs2_permission()
>
> "gfs2: Use GL_NOBLOCK flag for non-blocking lookups" has
> reintroduced the bug fixed in "gfs2: fix an oops in
> gfs2_permission" a while ago.  We still fetch ->i_gl carefully,
> and check if it's NULL, but then we proceed to fetch it again.
> If it became NULL in the meanwhile, we get trouble...
>
> Trivial to fix, fortunately.

Indeed, and thanks for the review.

The other problem isn't quite as easy to address, unfortunately. I've
sent Linus a revert request.

Andreas

