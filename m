Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40EF244668
	for <gfs2@lists.linux.dev>; Wed,  2 Jul 2025 22:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751497045; cv=none; b=koDAwVTBkM05cb+6BZHxczLf3JuLvg3JrB3aGpEFyB0wzZnv0fFn9M+U687KzTNAbC27javxREoOgH7UINCW7IJg9x2gbU1bCUNw47qSSiLR+yv03mr226MIb1KWdR+qLAz/IF3QPa9dmcxns3DdbMdym+f0tEjt24tVkuglWIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751497045; c=relaxed/simple;
	bh=8EW0hGGxBNPaepJB/kat+o+7PivqzOmIdnFN/RapTEk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JfP4E/p12yiZmKk2+exAAsF8bHjID6xv/NDe9qcxesZWmqaJ72sFnmmVi9F8GS6iApVLuXavt2rabACqVEVGoplPdepk3hRe1SK48WFsx+FvXp3+5FnKxLtaUjKl/fHYbYNPN/d9oYH7QfrcZjAWEdoXYj9/DpnFfuWKS8ItytY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AtX4tSBs; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AtX4tSBs"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4a44e94f0b0so100394571cf.1
        for <gfs2@lists.linux.dev>; Wed, 02 Jul 2025 15:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751497043; x=1752101843; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L+sj4DzOPih53SQUVn5/WouvC+G14JrQj6it97lI9Kg=;
        b=AtX4tSBssvb6j8DLlY4DVRbd194/3h/iqAfeiK8Mrp3aeKK7hMhIauwnDsr+e1AJsF
         jERaD+kEzO/0dw0Ff3kAOofJNYGKp4jEEyGUh6/L2kTqOw+GS6Hg8gJMDIoEUqSJGLGB
         ausqY9dRiYQOgv4A8X5JsWzOhOwQvtBwBE2aZTjwg3ozKtftuUwojGfrfK97Vyxojlih
         44pVe3iNa6IOw0MrdFZoCQItGqGaz99qAHKj5Lob5iAimy/UGcmIxoZfNtyRPXFnKJvd
         aCXKMu3mxzOzm1MXi+dCTDjmXSCyBVcqfsEUs+0vmTpjzHMcrlHu82TwMVhx2YG1fkwe
         5Vpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751497043; x=1752101843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L+sj4DzOPih53SQUVn5/WouvC+G14JrQj6it97lI9Kg=;
        b=eHA8gP0m35eEFt0rDS6Y2wbwme+oYrMsJJsgpBES8yha4DLerrytLyUduaO/0I9BW4
         3v1tvM0IPgHJigMHmEr/P8UXROjddU+oNRF0XFOftMmAqns/tFkBt0urehWzdx2G7qC/
         jzDJp2LaZCV/vCHkOGRJqXSrav5tezI6OlveuVl2NQx4nrD5Xw0jN/90xPKIC67Ljokc
         OG/OWoT4P8hrh6RSnlJYp48lAC7JQJml02mj/nf3jdMCdkas5cMW1p54wzBcMnDP08+Y
         A6+byN/8GVje69lcLoumkDErmGvJbFeKVl9Rvf7JeZwJGkbLGXiTMPZEP5OCEVE9NOJq
         rK+g==
X-Forwarded-Encrypted: i=1; AJvYcCU2UUqRlckC+IeAuwiP+AUh8aObqW+3VUrOSIkwesmhJl77SqrpqvyjoMnzyD3GDeVPTvH9@lists.linux.dev
X-Gm-Message-State: AOJu0Yy30JGTsINKvK29hw2cagLJZqzGCsmf9kG9r0d2D5BUD5w4ARLq
	Amuu58Uv89w6e3+GyNUzNI54WH47dnpm8oapLwVpr1egk1u17C2ULu/n5CJUYTLn6B7KlrP5Vin
	Au6+NBjG5ywvsn9U5H4OVnFJ3Ri6Ihmg=
X-Gm-Gg: ASbGncsCmMrb6R4KJwPICd2me86rR+L+wWXqvEenm4dNGQjUA669qtk/jD70IcPOh5N
	6CsCObgozOPL05kxDS+foxf5jbG9ZIn0uNpnTPpn4dM3jZVOpEueSdC+s5eFUcqfdHKmbwr6uId
	FDIXEiJIXfVUb3vhDT4Yr/2RLu6nB/Hx2W/9Cgf41YIfCXagUeUvJVvwwthcA=
X-Google-Smtp-Source: AGHT+IGh+uw6/WknPh/VOBOhELlnb2ckIXgQMw+Dl8Agj8uw+6O+8N23tvom7rsshXm0+/bXl2b6LhX8aRmfe9JENnM=
X-Received: by 2002:a05:622a:1343:b0:494:9455:5731 with SMTP id
 d75a77b69052e-4a9768dc925mr69623251cf.7.1751497042623; Wed, 02 Jul 2025
 15:57:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250624022135.832899-1-joannelkoong@gmail.com>
 <20250624022135.832899-13-joannelkoong@gmail.com> <20250702175509.GF10009@frogsfrogsfrogs>
 <20250702175743.GG10009@frogsfrogsfrogs>
In-Reply-To: <20250702175743.GG10009@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 2 Jul 2025 15:57:10 -0700
X-Gm-Features: Ac12FXz7lG-Jak0UpEVy1wDinr93eTqUtI8IoSMS4xFeGJDW7InC6JSRScIU8tA
Message-ID: <CAJnrk1ZhFropUE-qoXcfa4VB740quF7nkQ3cs+NNbwPTFgpLsw@mail.gmail.com>
Subject: Re: [PATCH v3 12/16] fuse: use iomap for buffered writes
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, hch@lst.de, miklos@szeredi.hu, 
	brauner@kernel.org, anuj20.g@samsung.com, linux-xfs@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-block@vger.kernel.org, gfs2@lists.linux.dev, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 10:57=E2=80=AFAM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Wed, Jul 02, 2025 at 10:55:09AM -0700, Darrick J. Wong wrote:
> > On Mon, Jun 23, 2025 at 07:21:31PM -0700, Joanne Koong wrote:
> > > Have buffered writes go through iomap. This has two advantages:
> > > * granular large folio synchronous reads
> > > * granular large folio dirty tracking
> > >
> > > If for example there is a 1 MB large folio and a write issued at pos =
1
> > > to pos 1 MB - 2, only the head and tail pages will need to be read in
> > > and marked uptodate instead of the entire folio needing to be read in=
.
> > > Non-relevant trailing pages are also skipped (eg if for a 1 MB large
> > > folio a write is issued at pos 1 to 4099, only the first two pages ar=
e
> > > read in and the ones after that are skipped).
> > >
> > > iomap also has granular dirty tracking. This is useful in that when i=
t
> > > comes to writeback time, only the dirty portions of the large folio w=
ill
> > > be written instead of having to write out the entire folio. For examp=
le
> > > if there is a 1 MB large folio and only 2 bytes in it are dirty, only
> > > the page for those dirty bytes get written out. Please note that
> > > granular writeback is only done once fuse also uses iomap in writebac=
k
> > > (separate commit).
> > >
> > > .release_folio needs to be set to iomap_release_folio so that any
> > > allocated iomap ifs structs get freed.
> >
> > What happens in the !iomap case, which can still happen for
> > !writeback_cache filesystems?  I don't think you can call
> > iomap_release_folio, because iomap doesn't own folio->private in that
> > case.

AFAICS, there's otherwise no private data attached to the folio for
fuse for the non-writeback paths, so I don't think this is an issue.
ifs_free() would be a no-op.

>
> ...and I think the answer to that is that the !writeback_cache case
> passes all file IO directly to the fuse server and never touches the
> page cache at all?

There's two !writeback_cache cases, direct io and writethrough.
For writethrough, the file IO gets passed to the fuse server and it
also gets written to the page cache.

>
> --D
>
