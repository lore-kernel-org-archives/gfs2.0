Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607001CD3F
	for <gfs2@lists.linux.dev>; Mon, 15 Jul 2024 16:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721062667; cv=none; b=tP801Hi/hZFfhoYPpYmhIsolfU046iV4tK5X+o4+R7fR69GebeTIG14ZM9GjLfvZMhQ7txizm+tyvYqXCfz3t/KteInKTD07HQv8LoPZH435TO2Co4NHvINa/4q/5R5zrLSHtyF1mgzR/WcRpBZG0OAqNHi6JxhkRFB31ZPykl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721062667; c=relaxed/simple;
	bh=xXNjCq2WW30UGIiUjaMaHuggEsEUhHxf0nXvby77kEQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W7vwer/OR6yXqSOH3kOiKaMfaMd1YUM0hlSu+wWaTaKANQLYubGCobXus3MMkylNz6aGafGAEZjLiCoMF1ZTlVB61eQPn3nkxvNPPVbzrLUpmJzR8u4EL00VhL7vOa5Rchh8drSOSQRpg46qhdMuLx/1WTAwd1xnl1K/7aK15Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=acsWy820; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="acsWy820"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721062665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y1FG23mSTcxbd1EYxLFTCH/TbFomvqVGQxfRti39P7g=;
	b=acsWy820HLHLpspX6GPJ9H/7iwQnphMGh51jM4s2SSvqczmRyrYR0+HzbQz4hh6wFuReA9
	9+SMdJlZNtuJuO2K+38+iMVNamg9dFfAt3vFuTMebbaPKxvNTyGF0mZFema0SaU60b0y04
	ra6/CJDCWg9qIAhr8HTM/hcjuGkxJYY=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-445-b-sk9B6LNCKlAMYR7tKOyA-1; Mon, 15 Jul 2024 12:57:43 -0400
X-MC-Unique: b-sk9B6LNCKlAMYR7tKOyA-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2ee8eaccb7aso44420541fa.2
        for <gfs2@lists.linux.dev>; Mon, 15 Jul 2024 09:57:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721062662; x=1721667462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y1FG23mSTcxbd1EYxLFTCH/TbFomvqVGQxfRti39P7g=;
        b=ViqFW7tDEFmDjluMgrE9PP6EvKVUHZefsio5qFB1nbSL5Anz75uMvDKCPyBG5mndPm
         GGKe2FyKbyMjclcLz5buf3lLa/OKcim48VupkxoAra6yv0mqVwVdWo5RYDx1y5cunY2g
         eXj8dGkgxIEz76vr/XtIxsnL3wviYqROq+W1g0hz3WX4JAKSzLHKDa7Uc1ejndsKWJf+
         kn7fKjLMs69ZVj/jIRl2FdKnBKguXx4hCuaXsHjJxo07grlRQ+cDaGZ7jezuNcjkTHrG
         acS5PgizR42ByWhoMCnij5a6QBifq0fJuQlhErbQrpDPSBX39zFIfyaGeRsp1CEGjdgH
         90bQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4cSCDlN/wf3aSYUw2F2LLir35bJrckkNBUu4U2zPu3NioF+yX4rZTTcv1288YTSJItbcJIecZKwVJHWV2ccR+hxH+cg==
X-Gm-Message-State: AOJu0YyT2jPCJbEQDXBAL1ZQWoO6e332Ue15EhGkRSPbEEYUdukxUyFE
	69YbSjpQI3HboqyLpdMykqcyXtMMhJpkYmjaGa6StANwmx4aqvsDhNhXCmi/WGs9xmi8PFzFqVK
	DbaaUAVd73HLUWDdEGGYwUttdmjBoWnSQt2BdX5BU7ntZj7yuVwrNj5IrHtLvTpzKIE9WOKm+J/
	FBc3BUTBoMPZ5fiEEQJsCzlklEcw==
X-Received: by 2002:a2e:3604:0:b0:2ee:7b7c:7f6e with SMTP id 38308e7fff4ca-2eef2d98034mr3360411fa.39.1721062662117;
        Mon, 15 Jul 2024 09:57:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFe7JCLjfYbgdoILJ7WlOzC+ld1mr6rcbwXDmy9MlNEt6x0VMIBaXrkXPcXYBOG049FLSAoWIHxLpZgv7OWMAU=
X-Received: by 2002:a2e:3604:0:b0:2ee:7b7c:7f6e with SMTP id
 38308e7fff4ca-2eef2d98034mr3360301fa.39.1721062661732; Mon, 15 Jul 2024
 09:57:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAK-6q+jSBjuFaFqGLQcfVLMUwRcJJMHk2oUnSgMObwz+OAih6g@mail.gmail.com>
 <2024071509-closable-drop-down-3a7f@gregkh>
In-Reply-To: <2024071509-closable-drop-down-3a7f@gregkh>
From: Alexander Aring <aahringo@redhat.com>
Date: Mon, 15 Jul 2024 12:57:30 -0400
Message-ID: <CAK-6q+hCTSgODtBOXJ1NvafmMszdxk0V3aj6t3LWQ9B0BDbtRw@mail.gmail.com>
Subject: Re: udev kset_create_and_add() with own struct kobj_type?
To: Greg KH <gregkh@linuxfoundation.org>
Cc: rafael@kernel.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, gfs2 <gfs2@lists.linux.dev>, 
	David Teigland <teigland@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 15, 2024 at 11:33=E2=80=AFAM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
>
> On Mon, Jul 15, 2024 at 11:27:00AM -0400, Alexander Aring wrote:
> > Hi,
> >
> > I am currently implementing namespace support into the fs/dlm
> > subsystem. The DLM subsystem uses kset_create_and_add("dlm",
> > &dlm_uevent_ops, kernel_kobj); to create the "dlm" sysfs directory.
> > Underneath it creates for each lockspace a subdirectory using
> > kobject_init_and_add() with a non-static name and being known during
> > runtime.
> >
> > Now I want to add namespace support and need to change the "default"
> > kset->kobj.ktype =3D &kset_ktype; that is set by
> > kset_create_and_add()->kset_create() to my own kobj_type because I
> > need to implement a different ".child_ns_type" callback before
> > kset_register() is called.
> >
> > So kset_create_and_add() does not allow me to add my own
> > ".child_ns_type" callback for the kset that is required for me to have
> > my sysfs "kernel/dlm" directory separated by each net-namespace
> > without breaking any backwards compatibility.
>
> I don't understand, what "backwards compatibility" is happening here?
>

The DLM sysfs udev directory for kobjects begins in
"/sys/kernel/dlm/", that is the created kset by kset_create_and_add().
Then a lot of per lockspace kobject directories are created by
kobject_init_and_add() with a name known during runtime only.
I cannot simply do a "/sys/kernel/dlm/lockspaces/" and have
"lockspaces" separated by namespaces, it needs to be "dlm" as user
space assume a specific directory structure in "/sys/kernel/dlm" and
interprets it and we want to have lockspaces separated per namespace.

> > My current solution is that I mostly copy&pasted the code of
> > kset_create_and_add()/kset_create() to have a way to tell my own
> > struct kobj_type that contains the implemented my own ".child_ns_type"
> > callback.
>
> Ick.
>
> > I am writing this mail to get some advice on what I can do here
> > without doing the copy&pasted code?
> > Add a parameter to kset_create_and_add() that allows me to set an
> > "struct kobj_type"?
> > Introducing a new function that does allow me to set the new parameter
> > (I probably like that because then I don't need to update all other
> > users)?
>
> A new function would be ok, but I hate it how filesystems have to use

I will try this out. Thank you.

> "raw" kobjects and the like all the time.  It's rough, sorry.
>

DLM "Distributed Lock Manager" is a networking subsystem but as there
are mostly in-kernel filesystem users (gfs2, ocfs2) it is currently
part of "fs/".
The plan is to separate DLM lockspaces per net-namespace as each
separation acts like a "network entity" (node) that is required anyway
for each DLM socket handling.

> Also, I didn't think sysfs namespaces worked for anything except
> networking stuff.  Are you sure you really need this?  Where is your
> "namespace" defined at?
>

It is networking but I will not lie that at the end users of DLM e.g.
the cluster file system gfs2 is required to separate their sysfs
directly the same way as DLM is doing here as each mount is on a per
"network entity" (cluster node) basis.

It will be an experimental support in the first place to use it for
testing/developing (not required to synchronize traces over the
network) and scale testing (testing on a limited resource machine a
lockspace with 1000 of nodes instead of having 1000 VMs). The scale
part is important for us to make DLM ready to handle a lot of node
members to handle future use-cases.

I hope that this "justify" here the use of net namespaces in udev.

- Alex

