Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B43241FB
	for <gfs2@lists.linux.dev>; Thu, 18 Jan 2024 11:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705578654; cv=none; b=UH60Dgf0RekIWfko977AipsmzjSBmETP7m1qI6PvXAexQHMXT5B3JFDzCekIrWcnKMibKnF+XCWyceLB+J5CoUtCd6FoTdCRfWMk1HdGle1ktEHQ0c22HVk3JNPdKSLzWusV3aUX0As/T+IFYxtkEFm9jf24+l9UmAdXKCyVGY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705578654; c=relaxed/simple;
	bh=gt35hwddnpNUWAan27VYVSM0nHY7vcCvCwkZZknrkR0=;
	h=DKIM-Signature:Received:X-MC-Unique:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Received:
	 X-Google-Smtp-Source:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 X-Mimecast-Spam-Score:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding; b=In4UmfYzKl1XtNesa08AzoJYP48aW1mjIkze8/qRkbQjgfg7LW5CfOXBhNhiiH4z4gRHDcC2+gN1jiMaab3Eet0Sf8ebYIyJACEcG69SWtgktmyyB/2jkPepAwu+wCEDixzYntIAdXmgBinItjZf/fBy5uWqyXAlWqI6fuxgtqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SXjje/vT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SXjje/vT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705578651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QT9qXfX+i5084J8ucGBrAuMK3QTq9k9pLJjBMMFh3rE=;
	b=SXjje/vT9+vqiAGnAdtgnhGz12f4LEbUe02RAeji67okrlX0I3Z3/L0dP+cI6p84/aqNl9
	LW7wvzgOsSmevT3K9vWUnfnPoavxQHB30rdIk2JzQu/KkHXFkyvaaL8x+KO+GQFuXjmbAK
	i3gDJihQ37fN+PST0LnhUGnpjjrvwLs=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-ab3obiylNam2W9bWhCxmNQ-1; Thu, 18 Jan 2024 06:50:50 -0500
X-MC-Unique: ab3obiylNam2W9bWhCxmNQ-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-28bbe965867so8328345a91.1
        for <gfs2@lists.linux.dev>; Thu, 18 Jan 2024 03:50:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705578649; x=1706183449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QT9qXfX+i5084J8ucGBrAuMK3QTq9k9pLJjBMMFh3rE=;
        b=CdRwRu7c1JaXrQjGpRLkHQJT/K/ZDNstIRsOY+9HmFgv1+4CeSVIhpkzWVbvw2C72s
         hsOi8FcUej1T1LMyE2R2wLjJ5gmOZeZE+9EYnW01ThgTeTtR6vSV7G10H4i6+sZjmugQ
         gz09uStLNU3Z9WmAt8lO+hToCHSXfuaiz6BijjnspLItOTPIYlUAAkeNrDxLsQ31SN0J
         m/1WEJlcM8PBxTdHVw/TP471y/NUVsx4E2AkMXHJy14RuPNH9xUtr3kL0UqfnCX76d4f
         sTzbAQ2OE0Uwr0NHDF8LfJSlnHwYsejRomNRRODFYcLRw5U4XiNyy+IjgNlQK0gTJe6C
         PBnw==
X-Gm-Message-State: AOJu0Yyw42k3EsHRSC8ZroZlBXFZpe8UkOIhZAwzkCm81WnXba/Ox7Yw
	nVCrVsBkJJsch2e2QQ0FwifRaFCsx6cudD9dRu3/QqhalsjIIDM8+ImiDpzk1jpTKwcy7lKF6pt
	jx3Tj00ulfEJ8GqooD5qCc9xHhsvUnnhtJtXdiyNuERHsH1TMOcXUjyhOQUYz4kgbuuaBh4A4xH
	QWHRMH0Kot+dJGllhu2BVa9/6LMg==
X-Received: by 2002:a17:90a:fa08:b0:28f:423f:1cfe with SMTP id cm8-20020a17090afa0800b0028f423f1cfemr537980pjb.18.1705578648794;
        Thu, 18 Jan 2024 03:50:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHVs+zCTtfvuguPsuMp6IoFUt9geCNapxlrZ6013/fZtiox4ORl6FknrWsaFGhDHw+mmfqpBre4bZ+1zAqDKZk=
X-Received: by 2002:a17:90a:fa08:b0:28f:423f:1cfe with SMTP id
 cm8-20020a17090afa0800b0028f423f1cfemr537973pjb.18.1705578648531; Thu, 18 Jan
 2024 03:50:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240116002817.216837-1-sashal@kernel.org> <20240116002817.216837-11-sashal@kernel.org>
 <ZabrPnsVr6WHz2lM@duo.ucw.cz>
In-Reply-To: <ZabrPnsVr6WHz2lM@duo.ucw.cz>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Thu, 18 Jan 2024 12:50:37 +0100
Message-ID: <CAHc6FU70RD8fktBp=Srv6xeq3qXoLCdT8pi6y=1Y7bMHFK-mtQ@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 4.19 11/12] gfs2: Refcounting fix in gfs2_thaw_super
To: Sasha Levin <sashal@kernel.org>, Pavel Machek <pavel@denx.de>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, gfs2@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 9:53=E2=80=AFPM Pavel Machek <pavel@denx.de> wrote:
> Hi!
>
> > From: Andreas Gruenbacher <agruenba@redhat.com>
> >
> > [ Upstream commit 4e58543e7da4859c4ba61d15493e3522b6ad71fd ]
> >
> > It turns out that the .freeze_super and .thaw_super operations require
> > the filesystem to manage the superblock refcount itself.  We are using
> > the freeze_super() and thaw_super() helpers to mostly take care of that
> > for us, but this means that the superblock may no longer be around by
> > when thaw_super() returns, and gfs2_thaw_super() will then access freed
> > memory.  Take an extra superblock reference in gfs2_thaw_super() to fix
> > that.
>
> Patch was broken during backport.
>
> > +++ b/fs/gfs2/super.c
> > @@ -1013,6 +1013,7 @@ static int gfs2_freeze(struct super_block *sb)
> >               goto out;
> >       }
> >
> > +     atomic_inc(&sb->s_active);
> >       for (;;) {
> >               error =3D gfs2_lock_fs_check_clean(sdp, &sdp->sd_freeze_g=
h);
> >               if (!error)
> > @@ -1034,6 +1035,7 @@ static int gfs2_freeze(struct super_block *sb)
> >       error =3D 0;
> >  out:
> >       mutex_unlock(&sdp->sd_freeze_mutex);
> > +     deactivate_super(sb);
> >       return error;
> >  }
>
> Notice the goto out? That now jumps around the atomic_inc, but we
> still do decrease. This will break 4.19, please fix or drop.

Thanks, Pavel.

Sasha, you don't want that fix without "gfs2: Rework freeze / thaw
logic" and the follow-up fixes, and backporting that probably isn't
going to be worth it.

Thanks,
Andreas

