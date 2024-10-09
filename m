Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975AB1A2651
	for <gfs2@lists.linux.dev>; Wed,  9 Oct 2024 14:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728485793; cv=none; b=PHSdZ+VpSQu2d/ytPx8yjVJcr3W6ZE0V3hIcIqDm3d5fwi+LMhHMqj8XHJbPblgnT/gBR5lAlpY/9eIb7Kug4LM+XOK+Rb9qv8xlKd5ftjCamjw32W4UaX5DjBEJ02Y6K9t+tklNKX3GEjf5MRnPkjT8oF0swD9+p68zJy7Ce5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728485793; c=relaxed/simple;
	bh=/tgJyGOWgs44BJBgryDmR2dJiQ41bYyC9nITu+aA4RU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B7JZe6TG2N3Wd57N69ab82C2F41lDKl2HiNquEGBjC/078dCtUVE/uCp2Qg+5asqWr3tiBU5zbpPgJt99nbFaVEnNpZrVeGvivLhQPTjhH3l0Og3oWk/4woakr7pUlnjYBK9J3GNplaAMe8TkOhL/y+PViCGv63DfR9HJ4JS8T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cHZbORjr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cHZbORjr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728485790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0PLE7VP4A55O5HT6SFbDpqUQK1BXhXp/AsPnei2699E=;
	b=cHZbORjrpJ3flqYhRUUu2I8gVE7iRQ68PevKK/c+AFy9Av21HUZh8ASCTWccy0pm+Rjs/e
	/fiJKm+k5w2O8oxK0IIbf6FNdVr0cRezlGdPGcsX69CJGW93mU0G9fFadQvdat1hUNcJ5m
	y4OMITPS0jPGxm6JL109WSC0tN7L4RM=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-OFHRIabrMoWRVCVbdJiVdg-1; Wed, 09 Oct 2024 10:56:29 -0400
X-MC-Unique: OFHRIabrMoWRVCVbdJiVdg-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2f75cf9472dso59660231fa.3
        for <gfs2@lists.linux.dev>; Wed, 09 Oct 2024 07:56:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728485787; x=1729090587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0PLE7VP4A55O5HT6SFbDpqUQK1BXhXp/AsPnei2699E=;
        b=uwcb/kgjsGhKASp6qBMJCbMHET3UwIZoannZbZaLDTRp8QLwMq6n1EfTu9FZ+nmdLj
         ZqdbGMDd3xy6rEeSI/BNrlth9Imzthcx1s9YYmhcTZScWcoIgsPv7RYkeHVs95PfOapI
         1igohzTvejLZA/AhzCYNKNInIUyaeGoAeMYLBvVTjEX0ewuHqlDCLGvWftiBfuljXUzy
         IJDbz7+dL3ZZeZaCDWCcnlF16LRaB/P06KlqvnCnB6RXbqgOxxYtc10U4RMwvg+jhqoM
         EB5IsTOUNQEnw9zTN/2oBX7HrlAevr4qu5lBzOwj7cB/PRp9nWP4WgRG5RTRD+pA3S/A
         rN1g==
X-Forwarded-Encrypted: i=1; AJvYcCX/78DulHpIJZB9Qs4Dv1WkJGkDpdIc/WYiOWhIqQIg9QX7zpaNqei3z+nE+o4baz1tLLp1@lists.linux.dev
X-Gm-Message-State: AOJu0Yz575eUm2y4dUlgsmUjT6b6BA/0l0QSrMshiHe1BL1Ypqdl9Nx1
	o9ZzkiIao024uh1hNeeQO9x38DQSQ/bCHqEYmabaOV+/uNw7Nw9n3bkpi4Td/Dgjxy0g5zbzPy2
	Zi5xPALmiE0ZF9tcZyIri5u1dXuSsDXryniK0VAR7kwz4TbReN211ViOTGvHrZE1w/jMLmROM5x
	YprGEkKniSIgITImplFuJlL9Aw0A==
X-Received: by 2002:a2e:bea3:0:b0:2fa:e658:27b4 with SMTP id 38308e7fff4ca-2fb18720a67mr19368991fa.4.1728485787101;
        Wed, 09 Oct 2024 07:56:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzmz6GlJFxJZGY+qLLAzphRbOgwssQ5wLeuGH+fl8u7i2WGipZw80Xr8tyG5lV1AvCAzvO6tH6a9X0aOIQE5o=
X-Received: by 2002:a2e:bea3:0:b0:2fa:e658:27b4 with SMTP id
 38308e7fff4ca-2fb18720a67mr19368761fa.4.1728485786705; Wed, 09 Oct 2024
 07:56:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241003151435.3753959-1-aahringo@redhat.com> <20241003151435.3753959-5-aahringo@redhat.com>
 <ECD4A28B-9987-42BC-91DC-8DED8CAEED21@redhat.com>
In-Reply-To: <ECD4A28B-9987-42BC-91DC-8DED8CAEED21@redhat.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Wed, 9 Oct 2024 10:56:15 -0400
Message-ID: <CAK-6q+h4rsitB5C-dh=gpF5wG_1P2M=qT0wSVhTjLjkHLEsXsg@mail.gmail.com>
Subject: Re: [PATCH 4/4] nfs: sysfs: use default get_ownership() callback
To: Benjamin Coddington <bcodding@redhat.com>
Cc: trondmy@kernel.org, anna@kernel.org, gregkh@linuxfoundation.org, 
	rafael@kernel.org, akpm@linux-foundation.org, linux-nfs@vger.kernel.org, 
	gfs2@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 8, 2024 at 4:09=E2=80=AFPM Benjamin Coddington <bcodding@redhat=
.com> wrote:
>
> On 3 Oct 2024, at 11:14, Alexander Aring wrote:
>
> > Since commit 5f81880d5204 ("sysfs, kobject: allow creating kobject
> > belonging to arbitrary users") it seems that there could be cases for
> > kobjects belonging to arbitrary users. This callback is set by default
> > when using kset_create_and_add() to allow creating kobjects with
> > different ownerships according to its parent.
> >
> > This patch will assign the default callback now for nfs kobjects for
> > cases when the parent has different ownership than the default one.
> >
> > Signed-off-by: Alexander Aring <aahringo@redhat.com>
> > ---
> >  fs/nfs/sysfs.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/fs/nfs/sysfs.c b/fs/nfs/sysfs.c
> > index a6584203b7ff..b5737464b892 100644
> > --- a/fs/nfs/sysfs.c
> > +++ b/fs/nfs/sysfs.c
> > @@ -27,6 +27,7 @@ static const struct kobj_ns_type_operations *nfs_netn=
s_object_child_ns_type(
> >  }
> >
> >  static struct kobj_type nfs_kset_type =3D {
> > +     .get_ownership =3D kset_get_ownership,
> >       .release =3D kset_release,
> >       .sysfs_ops =3D &kobj_sysfs_ops,
> >       .child_ns_type =3D nfs_netns_object_child_ns_type,
> > --
> > 2.43.0
>
> Hi Alex, if I understand this correctly, this patch just punts the owners=
hip
> callback up to fs_kobj, which, because it has no .get_ownership is just
> going to be the same result: root.
>

Yes, from my understanding this has to do with user namespaces and
being able to write to the related sysfs/kobject files?

> Does this patch add value?
>

For me no, but it is there now as default and I think somebody
probably forgot to update all the other users that created their kset
in a more low-level kind of way.
I think the whole "transitioning process" to make the same things with
namespaces created under root vs user is still kind of still in
process.

I am not sure if any of the nfs userspace namespace aware tools are
also limited by other things that require additional changes to do
something else as a "normal" user.

For me it's fine to drop this patch series and if somebody wants to
make a user namespace working with nfs tooling can come back again and
find out such patch might be necessary?

Thanks.

- Alex

