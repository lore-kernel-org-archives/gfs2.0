Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938EC6EB79
	for <gfs2@lists.linux.dev>; Fri,  1 Mar 2024 14:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709302136; cv=none; b=BeAMUW+F2uTTG1LAdgu0E6kJP1U2iq2uWcGPaSoa5la6jerTdJs61w9uifP0PnZ2s3Sdj97XUFh3RLIRASvuJkXK/uGhIGIfJHbh6qDYqBE9YXBpjoBqTFFSOk7N4w/P46z6KEIrFCdEZidSnf8rz+DcS7Q8zaRlDCf42TZuHmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709302136; c=relaxed/simple;
	bh=iT6JJmiRbb+kh1+RgPYgYNnUnOvZ0AoJcZwUvgBzKnY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RtIM4qus8slEv6rHsnV1YHdm0NfGy1c5X0EoUmkPMYnBrKTqJW7RhWAZdls/ueh4ZOBWA/zM+2FTHwXvTJQUJnxC7IGOkwi9DtxsTy1M1n9RTIpi+Jm8FKNLjPyODMKO+2GVUB8K35RRQBJ1PpgHo64wUwIJyTm6GeAPml/QL/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EZaRsLJh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EZaRsLJh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709302133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eZNB7Cp4kFaNUO1dt4k9gvrovl60pZyh1b4xj20qO2c=;
	b=EZaRsLJhYNGkGK42KP6HJwKrLeeQLQyyckxa278quaauXCG4REhv86PrbDju+chiIceiaJ
	akLHTyE+IWqR8M6IaGkTLjuJdi0NnAsF6FLDIj1heXrQhtmORH4ao85CFqjFXiSMV32TQf
	zu2dNGRVrBKNe4QlW5NdB+aUV0CMimA=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-161-picvka0POZKK7UhdJqKT4w-1; Fri, 01 Mar 2024 09:08:52 -0500
X-MC-Unique: picvka0POZKK7UhdJqKT4w-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2d2c98de907so13695721fa.1
        for <gfs2@lists.linux.dev>; Fri, 01 Mar 2024 06:08:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709302130; x=1709906930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eZNB7Cp4kFaNUO1dt4k9gvrovl60pZyh1b4xj20qO2c=;
        b=UZ3x9HILB27R4K0tJvN2I//ppr9F+YbSNgld1IyO8ZOXrdo/r8ZREjEU0K2eqgiZ39
         +8XP64e+k7j7Tc1TBVrCbPRoA0XxEnLeniOF8t5ky03dW/se0sOUowybsRE5KAmqHCVG
         aeEkzd4DtC7RkxHCruFgpq7n6WVQqT7xI6ndpA8t8CNs9j5W2UW/poWB6+pWUCDpp/3P
         hCwP0LJ+5YWyBwESSDoZbn3Y33RLlzwO0/1MGpFFYK4ZiEw8zFdkHH14+Vqz5/tzbLhC
         em9rkXz/vuAevw4WZrd8XRGwUF1R1n/K+9ygm8ZxOsKU4poljQHOW+3KzXKE9fDGF47x
         3WQA==
X-Forwarded-Encrypted: i=1; AJvYcCUnU9x78APDXhZFMTMSD/kTA7X16WebuSxGf4qyLE/eo3yZFgNKRso4CnrP+Z9EJfZDyS2G6xBPZcuaT/5BWX8he/ve7Q==
X-Gm-Message-State: AOJu0YzZEEw+5B+9MX8h6KVcuJelfDtcbsaFcGipWtXcBhppzlbO6rF8
	WNt1/dKPKHKMvqwKYy3fgbGRv0jlN8voj4PbS+taAgRBSjtYueW69go6FpNsnmsXUNiHDlcSKtt
	q1blufGpPw0vIsToFFUaGXWb1e7C5FEnVAUp+qkDIkE7sSBLz2HOI6e5KM8pelqrs0L1hUyWugu
	wz/pUfpvHmXhTLCq/2qrI7+JJ9WQ==
X-Received: by 2002:a2e:a545:0:b0:2d2:c83c:ffd7 with SMTP id e5-20020a2ea545000000b002d2c83cffd7mr1484967ljn.42.1709302130748;
        Fri, 01 Mar 2024 06:08:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFSDJeJpN277d+Vv9za9OxHPDSkM2MaL7PivkBpn5DLbwMNlURIgc/uCGOC+jzzIJ/SUczkiXhxW0KtMRkM6us=
X-Received: by 2002:a2e:a545:0:b0:2d2:c83c:ffd7 with SMTP id
 e5-20020a2ea545000000b002d2c83cffd7mr1484941ljn.42.1709302130433; Fri, 01 Mar
 2024 06:08:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230925201827.1703857-1-aahringo@redhat.com> <20240209052631.wfbjveicfosubwns@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <CAH2r5msWwX7QdXrzmR3tapU85WMga9Y-waNOHm+hMWmWPUF=tQ@mail.gmail.com>
 <20240209114310.c4ny2dptikr24wx5@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20240301103835.gylf2lzud2azgvx7@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
In-Reply-To: <20240301103835.gylf2lzud2azgvx7@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Fri, 1 Mar 2024 09:08:39 -0500
Message-ID: <CAK-6q+jZVfK2=Z6RCCU+K+TLYuHgC4ynqOBz3K-nhcypCoN3ww@mail.gmail.com>
Subject: Re: [PATCHv2] generic: add fcntl corner cases tests
To: Zorro Lang <zlang@kernel.org>, pc@manguebit.com
Cc: Zorro Lang <zlang@redhat.com>, Steve French <smfrench@gmail.com>, fstests@vger.kernel.org, 
	gfs2@lists.linux.dev, jlayton@kernel.org, linux-cifs@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Mar 1, 2024 at 5:38=E2=80=AFAM Zorro Lang <zlang@kernel.org> wrote:
>
> On Fri, Feb 09, 2024 at 07:43:10PM +0800, Zorro Lang wrote:
> > On Thu, Feb 08, 2024 at 11:35:06PM -0600, Steve French wrote:
> > > Could you forward the changeset for this so we could try it?
> >
> > Hi Steve,
> >
> > Thanks for your reply. Sure, there's a temporary branch "patches-in-que=
ue",
> > you can get it by:
> >   # git clone -b patches-in-queue git://git.kernel.org/pub/scm/fs/xfs/x=
fstests-dev.git
> >
> > Then you can see a generic/740 test case in it, run it on cifs. I teste=
d
> > with cifs 3.11, and wrote the /etc/samba/smb.conf as:
> >   [TEST_dev]
> >   path =3D $dir
> >   writable =3D yes
> >   ea support =3D yes
> >   strict allocate =3D yes
> > And set:
> >   MOUNT_OPTIONS=3D"-o vers=3D3.11,mfsymlinks,username=3Droot,password=
=3Dxxxxxxxxxx"
> >   TEST_FS_MOUNT_OPTS=3D"-o vers=3D3.11,mfsymlinks,username=3Droot,passw=
ord=3Dxxxxxxxx"
> >
> > I'm not sure if it's a cifs issue, Alexander writes this case for gfs2,=
 it
> > works for other fs, but blocked (until kill it manually) on cifs. So ho=
pe
> > to get some suggestions from cifs list.
>
> Hi Steve,
>
> Any feedback about this? Just to make sure if it's a cifs bug or a case i=
ssue.
>

I talked yesterday with Paulo Alcantara (cifs developer), he is
currently looking into it.

Paulo, is there any feedback yet? Thanks.

Thanks for the ping Zorro.

- Alex

