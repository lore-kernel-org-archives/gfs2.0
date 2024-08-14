Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CE61C37B2
	for <gfs2@lists.linux.dev>; Wed, 14 Aug 2024 20:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723668469; cv=none; b=UYu7S12pDOLZElgWCZWealKm6+r1v7yo5WBDNQ/Q8Nu9eReKYwFdbIUz/xLRp2ATBNPPRZgl05N84ennPg8U1C2M0HI/saKio3T/N/laC74HkLjmnkKhhZsCCkLAUgxRwt46S3HnHHyibADBpQmZNSrZLumZ0v2EVIjFYQqNl/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723668469; c=relaxed/simple;
	bh=xAuqg4LG4M0fbnSo/GQcVfg4wjhYXdK6fQ96rx9RI40=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IwFaXTyerkvO1t/waDtVCAeb1ZuwSWd6ZYJ86bCw24xXHc2ZYGDCESrLXIcDLJgO2kzbQTOOTlNVOJBW8vOUT19RWkpxlbYNDaeAh57WGyt7HwVcXvu+nWxSxDlsujhszlblkL3iyT+48b0ZzWG/8u8G8TV41ry4DdjdiBw9q7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OA7UOBV2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OA7UOBV2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723668464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L+6lTZVqxZijRPSjfEzQi+vwTAY7CwJ2b1e+TxM4Mrk=;
	b=OA7UOBV25OigDon4mYpG0PaGojzrCq8mEdXd7EhmqAdIGNWqQ0WOjVSJ5WKYa2xd+4DkOj
	yh3/4+NVQ0cwBHF7IVZ7T3K1UWkNIqYonSldUUw1oHl6+OAhB1F78XyzzSRAz9Cz+lrBQe
	nb4OX+LP9lh7bJQwf0ribAeigiLUuas=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-s_BJkkrbOx6hzGMGNONBvQ-1; Wed, 14 Aug 2024 16:47:42 -0400
X-MC-Unique: s_BJkkrbOx6hzGMGNONBvQ-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2ef22e62457so2294731fa.2
        for <gfs2@lists.linux.dev>; Wed, 14 Aug 2024 13:47:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723668461; x=1724273261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L+6lTZVqxZijRPSjfEzQi+vwTAY7CwJ2b1e+TxM4Mrk=;
        b=qJ/PE6hO3T9t3J1m6EoXj+lvXCjooA8Qb8x7BYI4PKVimdNeo0A5A4sbY9Oj6yRWl+
         6ly/SpoYFFRIWc58Wi98rhhICrUl9XAgCY49GCg8BBoSqUJ47jfCznmBUqaKdDCvsVSQ
         O+iqqi3mjOaCIJas6eXSoUkHkkmB0NBpqBgBAXqSqJX3lNf/RNcfZwExQgQ7WTO0Kb9Q
         q84C44cyAKgOCav95v421Zaqs/cFkw3EvVbfBP/1KGsdJ+0P2+DoLtHWj/8nSIGbHjFE
         VCQZ3J7lLRYn+LRT+my0rlBgRE709smTUjE4uQ+bjSYDuX/petz/Rx2TI4+VzCJxHMfN
         rzSw==
X-Forwarded-Encrypted: i=1; AJvYcCWpq20UzNu0fCEWtO7TEtU2qeBeMRm5wk+kIytfLAAmicdTRYlXA9vE4EYaH/zz0V3Znzum0P4QRlsxewOeZN3kH2SWyw==
X-Gm-Message-State: AOJu0YyRsGmSepUk/un50QxGqFFrr30QxaY+SknVmCKlR1+OcerGKGwA
	ZscjdY6xNHtAqMmVIUN6CTJPCDPDhAYGmFJZBcnSLlK6YNkrPw6L1Mh47egMZkqgVOpvc/tzLtT
	Yo8vHBrOOch5XcT74ZChG+g0zhUFHq4GCJMpPPVtrLyhUqPlceV2W1f0wil7ZbEBR+U7MytL8gg
	tmfpQioP96R7bD6fmAbelXa8ynig==
X-Received: by 2002:a2e:9683:0:b0:2ef:2ce0:6ac with SMTP id 38308e7fff4ca-2f3aa1f1dd1mr24000331fa.22.1723668460826;
        Wed, 14 Aug 2024 13:47:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOJF6QT6rKh2U8kgEkPVDV5badXvR0hhWLGciNfUm778LjMDYtscMG23tmLAtY9tHBPsjoWq2/pM4uncBTUwk=
X-Received: by 2002:a2e:9683:0:b0:2ef:2ce0:6ac with SMTP id
 38308e7fff4ca-2f3aa1f1dd1mr24000091fa.22.1723668460232; Wed, 14 Aug 2024
 13:47:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240814143414.1877505-1-aahringo@redhat.com> <20240814143414.1877505-10-aahringo@redhat.com>
 <2024081445-coffee-antiques-e9cc@gregkh>
In-Reply-To: <2024081445-coffee-antiques-e9cc@gregkh>
From: Alexander Aring <aahringo@redhat.com>
Date: Wed, 14 Aug 2024 16:47:28 -0400
Message-ID: <CAK-6q+hN8ZRAHc7aS7C_RO4pEGN1t3eA_vDChsSgsQOcJEU4vg@mail.gmail.com>
Subject: Re: [RFC dlm/next 09/12] kobject: export generic helper ops
To: Greg KH <gregkh@linuxfoundation.org>
Cc: teigland@redhat.com, gfs2@lists.linux.dev, song@kernel.org, 
	yukuai3@huawei.com, agruenba@redhat.com, mark@fasheh.com, jlbec@evilplan.org, 
	joseph.qi@linux.alibaba.com, rafael@kernel.org, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, 
	ocfs2-devel@lists.linux.dev, lucien.xin@gmail.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Aug 14, 2024 at 11:06=E2=80=AFAM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
>
> On Wed, Aug 14, 2024 at 10:34:11AM -0400, Alexander Aring wrote:
> > This patch exports generic helpers like kset_release() and
> > kset_get_ownership() so users can use them in their own struct kobj_typ=
e
> > implementation instead of implementing their own functions that do the
> > same.
>
> Why is anyone needing these?  What raw kobjects require this type of
> stuff?
>

In this patch series I introduced kset_type_create_and_add() to have
the possibility to do the exact same what kset_create_and_add() is
doing, just setting a different "struct kobj_type", for the kset that
is created internally by kset_create_and_add(). I can't use
kset_create_and_add() as it always uses "kset_ktype", see [0].

I am doing that to have only a callback for ".child_ns_type" assigned
as it returns the "&net_ns_type_operations;" structure to tell
underneath everything is separated by net namespaces.
I don't want to change anything else so the "struct kobj_type" should
look like what kset_create_and_add() is doing. Therefore I am creating
the same structure as kset_create_and_add() is using, see [0]. The
"kobj_sysfs_ops" structure seems to be already accessible from
outside, just the two functions I am exporting in this patch are
missing. Or I implement it in the same way in the dlm/gfs2 codebase
(that is what nfs is currently doing, see [1]).

And then we are at the two users of those kobjects that are using
those functions, it's DLM and GFS2 as they used kset_create_and_add()
before and I just want to add the ".child_ns_type" callback. Other
users could be nfs [1] (for the release, get_ownership - I have no
idea).

thanks.

- Alex

[0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/lib/kobject.c?h=3Dv6.11-rc3#n937
[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/fs/nfs/sysfs.c?h=3Dv6.11-rc3#n23

