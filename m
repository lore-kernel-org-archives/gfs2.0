Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B63723A994
	for <gfs2@lists.linux.dev>; Wed, 10 Sep 2025 11:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757503533; cv=none; b=j2ko0Fjurk2jl1bFeyb2yujFnbON/BJWwCHVTK2LYyC4Y1XJNoKPun09Ce71pr9+Y4DRUDomM/8hbCWquKYh+UyYIwY1sJLU2E/7099H4pJnBWMtyXlZL374VGQoL40IHVF4nk+GOhSAm/pLtBni3fFYGe4R8tf3KzxM5aCJyKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757503533; c=relaxed/simple;
	bh=h9KEh2ojjm4QzM68ao2k0Bf1IqYGEbISWkQH5/yxjTE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kgEVbAgMhgCCvYEXrVhpPJrGdu8BAltAwygFgQJ/sbxU30KnzCch6KjbQDMRj6O8WZ/E1amhuUeYOlOTYCeHf+4/vgreq4vInxsu4CI9zQgHlL5Ehnfxj8PqzrKhXE+lajdRFqP6SsfS5AokYSx8PdhyxQ+a3xpQBifLGagVp2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BXgIANZ2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BXgIANZ2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757503531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XL4ruzM8AedzL+ahlUWIyyVR3AHZTuigDMBK5B/nuAs=;
	b=BXgIANZ2F6tBZXvW+GnHksSAnRo+Be4m5ABOAlEl/vw15WdUhr4UsTDrafYhJL6z58o4am
	oBQC7EUpYUb0PV4kRxbQSWiAm6rj8u/4aJJ4eVlK62YfeP+F3OxvSPVZjCPmovwb4HI7yR
	IsRggzD62NU/5Ze10XrQ0CQsgjCaY0Y=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-Pn8omlPFMHmswzEfYPEzQA-1; Wed, 10 Sep 2025 07:25:27 -0400
X-MC-Unique: Pn8omlPFMHmswzEfYPEzQA-1
X-Mimecast-MFC-AGG-ID: Pn8omlPFMHmswzEfYPEzQA_1757503527
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-24458345f5dso94248745ad.3
        for <gfs2@lists.linux.dev>; Wed, 10 Sep 2025 04:25:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757503527; x=1758108327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XL4ruzM8AedzL+ahlUWIyyVR3AHZTuigDMBK5B/nuAs=;
        b=b2PG45NqS85JKnGsow8Q5wIXjmIAbwn9LQUQzyG2x1lXqvZ01vh3baJqxQyg3FL3mx
         qtqt8jfbaoM2t5n5wu/HL261yQjqCBMq7CbFDmiDsrx3ZkKyzzTL89EPQFpTiPQnhH28
         o2W7ZiRzv03qwSwmEemnZw5E/54Voab+RkLJyoJNRErwF4WP7HKfVbWy8Txjw5Vqk55Y
         SKB90Eg92S3OAj4RsPvt3oUvs8T5WUrmNtkJpSTd42h/n7B53undSfNw1KoBH6vYP9Tj
         dRaKuWLFGdVkCqrfXmlZCXaBgWpbB7mI2VquS/xaXyhLu6qnDKbUUqU+ms9XqLcKOpjw
         /hag==
X-Forwarded-Encrypted: i=1; AJvYcCUO+aoXdS2XqhNwDVdPYoI5/+IPCHXUfmtkw5Wj9EjN136ImU/t7MQFqKoF4hWK/ZfU71Jh@lists.linux.dev
X-Gm-Message-State: AOJu0YwEXLUEi7T5eOIzVftMkMtcD6AbBjsRmRQjJ3iENt7QpPdMTS7S
	kiTAXKp2lkfTnjEAmWnIJ82gSUlpQp+5gpsTqMXQGBGosWi9YRjaJIlaAwVvA63ylLsQjevckBp
	uWJOqCU4d7AYDGFLMuKMiJH0h3Yu6hayTTphhQ17Jt7kyUtky5CL5ylP4aYOGjpG/G+CEZohpVu
	gWA2spHFHVu7pqpwYz9QtbvP8D1OmA9A==
X-Gm-Gg: ASbGncvC2LkssMqkISw1npZf5RB6bugmZcduvbBVh6ogVAYS7qBeqLgyM8T1v0RU4xS
	5pfCTH91dQtrL/v16keP8suJWpEPNaoYlZ+NvWHaPKjFep++NjIrXwmIntVgtxTiFExolcEbQy5
	wG5PrSLYKfqzMiW6HRt2Y=
X-Received: by 2002:a17:902:ec8e:b0:249:3049:9748 with SMTP id d9443c01a7336-25172292005mr202948285ad.35.1757503526547;
        Wed, 10 Sep 2025 04:25:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEaR+bhiVPNWt4QUvKQuVLEZvF3jJd3Ijjzb5yVlhxYaVgjP/2E3HUPYMEMrrYf689RheFHiy2DBowGyHRCSec=
X-Received: by 2002:a17:902:ec8e:b0:249:3049:9748 with SMTP id
 d9443c01a7336-25172292005mr202948025ad.35.1757503526115; Wed, 10 Sep 2025
 04:25:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250909014606.15043-1-bagasdotme@gmail.com> <874itbv23b.fsf@trenco.lwn.net>
 <aMC4LIltHWlpF9iY@archie.me>
In-Reply-To: <aMC4LIltHWlpF9iY@archie.me>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Wed, 10 Sep 2025 13:25:13 +0200
X-Gm-Features: AS18NWDq9XC6oKyEKwpzcoWeu3xT29_fWXpazweCsAqUf0bE5KqQor3qN_vB9ag
Message-ID: <CAHc6FU709iYrAVB+2DeL8+AkCMtgwtqC-7ikx+f=wqYPAZfjmg@mail.gmail.com>
Subject: Re: [PATCH v3] Documentation: gfs2: Consolidate GFS2 docs into its
 own subdirectory
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Documentation <linux-doc@vger.kernel.org>, Linux GFS2 <gfs2@lists.linux.dev>, 
	Randy Dunlap <rdunlap@infradead.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Christian Brauner <brauner@kernel.org>, Miklos Szeredi <mszeredi@redhat.com>, 
	"Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>, Bernd Schubert <bschubert@ddn.com>, 
	Jeff Layton <jlayton@kernel.org>, James Morse <james.morse@arm.com>, 
	Chen Linxuan <chenlinxuan@uniontech.com>, Matthew Wilcox <willy@infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Lz5DzYtmcv6Pl6Eu_DtE6_zOCW4yVRouqeETDaK3LdE_1757503527
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 1:28=E2=80=AFAM Bagas Sanjaya <bagasdotme@gmail.com=
> wrote:
> On Tue, Sep 09, 2025 at 01:48:56PM -0600, Jonathan Corbet wrote:
> > Bagas Sanjaya <bagasdotme@gmail.com> writes:
> >
> > > Documentation for GFS2 is scattered in three docs that are in
> > > Documentation/filesystems/ directory. As these docs are standing out =
as
> > > a group, move them into separate gfs2/ subdirectory.
> > >
> > > Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> > > Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> > > ---
> > > Changes since v2 [1]:
> > >
> > >   * Do not use wildcard on MAINTAINERS file entry and add review tag =
(Randy)
> > >
> > > [1]: https://lore.kernel.org/linux-doc/20250827022122.12132-1-bagasdo=
tme@gmail.com/
> > >
> > >  .../filesystems/{gfs2-glocks.rst =3D> gfs2/glocks.rst} |  0
> > >  Documentation/filesystems/gfs2/index.rst             | 12 ++++++++++=
++
> > >  .../filesystems/{gfs2.rst =3D> gfs2/overview.rst}      |  6 +++---
> > >  .../{gfs2-uevents.rst =3D> gfs2/uevents.rst}           |  0
> > >  Documentation/filesystems/index.rst                  |  4 +---
> > >  MAINTAINERS                                          |  2 +-
> > >  6 files changed, 17 insertions(+), 7 deletions(-)
> > >  rename Documentation/filesystems/{gfs2-glocks.rst =3D> gfs2/glocks.r=
st} (100%)
> > >  create mode 100644 Documentation/filesystems/gfs2/index.rst
> > >  rename Documentation/filesystems/{gfs2.rst =3D> gfs2/overview.rst} (=
96%)
> > >  rename Documentation/filesystems/{gfs2-uevents.rst =3D> gfs2/uevents=
.rst} (100%)
> >
> > I'm not sure which tree this is meant to go through ...
>
> There's linux-gfs2 tree (see MAINTAINERS)

Sure, I can take it. Can you please send your v4 patch to gfs2@lists.linux.=
dev?

Thanks,
Andreas

