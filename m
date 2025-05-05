Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D241426A0D0
	for <gfs2@lists.linux.dev>; Mon,  5 May 2025 20:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746477508; cv=none; b=pnCHjg/vy6mP622cE33PRgPFVHrKMaCU2+kvhhsCfiLDK7fAwu8V89x0S3TwLtCikuIuPoImw5hM31vbdrpYTfZxrRbVn88bE6mCLsTtYonv4aHV8SAU0oo5RK9e3YYIksX65N9vKLIglGkoXa2JXSrJYDefwPDRL5dHZj1o+gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746477508; c=relaxed/simple;
	bh=k++hYqj4x78kpJ78qOwKiMzxHdF9lArKJ7k5TUNKaW0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NobdmFK3DIV26hUkzixfRc8PNhDH6XqrTpqr+qn4Y1pQZjoRqXW6ON18LRdaCe9foQ0tvRrKVaS/c8DZLZnmVTVOtA9jG0fTp8UJ+4Am1lK+ht8TM4aziebBug/aWFMg4W3uEOeJtrQPCQkkVUDayFDYDRqfrFQeNgGds9p5oec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DKp1mD1E; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DKp1mD1E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746477504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cmQcj1XZtW7iDpIfl2kYGm5H6zAs8IhlCygqncc+VRE=;
	b=DKp1mD1EhfyyDJbaK0ELFAS7I1mXALayMMa1uBWbuokRA12KzJoiRPcwccg838JV3LlrSX
	P295a9Xvk+WAvQNwDi6zvpPyJ7mCBRkc4rjConwd7AZXp2SjZn+gnQOiPLfMuX8Hnr3Q/y
	jwbooYOxAlwjpWXmv8RFIxNBotBvIR4=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-Dg_vnVHHNuKA9lIS8N10dw-1; Mon, 05 May 2025 16:38:21 -0400
X-MC-Unique: Dg_vnVHHNuKA9lIS8N10dw-1
X-Mimecast-MFC-AGG-ID: Dg_vnVHHNuKA9lIS8N10dw_1746477500
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2242f3fd213so44856485ad.1
        for <gfs2@lists.linux.dev>; Mon, 05 May 2025 13:38:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746477499; x=1747082299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cmQcj1XZtW7iDpIfl2kYGm5H6zAs8IhlCygqncc+VRE=;
        b=j7gI4PjgAvazjUDkKY/49oR2CNLiNWdCULKwZdcAHuyeOquM2g7MeDTBiM0Dg7aVo1
         mWvc0W4jdbhDjYSvdw6xq9igEQQC9Nuv/7rcnsCTqP9qZFMLXFr2+MdvG+u2pTkMaS+l
         uBbIHteTair2gW29NCoWmU3sZixnFa3R7GxKahgr5StRjiLw+vvKozFdXkjMfWSwMWAp
         O2XrmwEH/+otZ1XRK8p1TShOre/Qxjjy/ACDXv+aWdhtPth7ZvLs1O09Un+WPzJ8oDEv
         mQVIUAHLQxsjtDnOQ7JXYJz/t1I0EuTcvWBU4eTC/aO1K5H+OuICAq6g6SRSqfj8a/Ik
         d0IQ==
X-Gm-Message-State: AOJu0YxBsYfhzWL/7u68eOxpJ5zIIvIhl2cMVvF3YUl+1r6ZNjIPJN8e
	9QV0Ad4egmr7F9+H9FEXFw7j9ewyHg1vBh9ukTQhVg+SOGrwp41KLBscILfEg5DA1zYR7nSVmoP
	PLNQbwDvt2o/CmmHkMyKpql3xKM7i68hLQ1rVhV+QU2f4eX5S1vPkCXbaj9uCR42k+l6bEfAHaZ
	PN/bbNUDwtTr0XRzM/s6scHrQKljFMPddy6Q==
X-Gm-Gg: ASbGncs84qc+vSu5QjngVAJxpkh90PzrQE8/oyW1PNZ6X5yXl5BS+UmVPmmKt/ZYWRX
	LUOkNjBoG+47tHGYRO09LOjeKJQd4WNLUJRRGzdkvkGVJDBratCCLHEb5tz40wODa1aQ=
X-Received: by 2002:a17:903:41c4:b0:224:584:6eef with SMTP id d9443c01a7336-22e32f0ba3amr11069975ad.41.1746477499316;
        Mon, 05 May 2025 13:38:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHdNEmzqYWTeJFhkGMcz8sxAKucZkRk1rIBmvsz2luCb8Vk6V/b54tOUy1XJ7Gm33Rcl6/4llrY03EEb1uPmY=
X-Received: by 2002:a17:903:41c4:b0:224:584:6eef with SMTP id
 d9443c01a7336-22e32f0ba3amr11069695ad.41.1746477498968; Mon, 05 May 2025
 13:38:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250505091828.3450317-1-hch@lst.de>
In-Reply-To: <20250505091828.3450317-1-hch@lst.de>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Mon, 5 May 2025 22:38:07 +0200
X-Gm-Features: ATxdqUFwkwkyc8MAtT28K_MOiUR-P1OX5t43A0QqiUDreMn6SGmzo21D4iG7mus
Message-ID: <CAHc6FU5u7+hwWUV82J7p4EVVHKnNi9hP6EmUHUg3tFhqsjCjRw@mail.gmail.com>
Subject: Re: [PATCH] gfs: don't check for AOP_WRITEPAGE_ACTIVATE in gfs2_write_jdata_batch
To: Christoph Hellwig <hch@lst.de>
Cc: gfs2@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JZoT_58tWaLYYaeejIT7QVnrncb9QkESnYjDiLxOOzw_1746477500
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 5, 2025 at 11:26=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
> __gfs2_jdata_write_folio can't return AOP_WRITEPAGE_ACTIVATE, so don't
> check for it in gfs2_write_jdata_batch.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/gfs2/aops.c | 28 ++++++++++------------------
>  1 file changed, 10 insertions(+), 18 deletions(-)
>
> diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
> index 68fc8af14700..5be99d87bcdc 100644
> --- a/fs/gfs2/aops.c
> +++ b/fs/gfs2/aops.c
> @@ -228,24 +228,16 @@ static int gfs2_write_jdata_batch(struct address_sp=
ace *mapping,
>
>                 ret =3D __gfs2_jdata_write_folio(folio, wbc);
>                 if (unlikely(ret)) {
> -                       if (ret =3D=3D AOP_WRITEPAGE_ACTIVATE) {
> -                               folio_unlock(folio);
> -                               ret =3D 0;
> -                       } else {
> -
> -                               /*
> -                                * done_index is set past this page,
> -                                * so media errors will not choke
> -                                * background writeout for the entire
> -                                * file. This has consequences for
> -                                * range_cyclic semantics (ie. it may
> -                                * not be suitable for data integrity
> -                                * writeout).
> -                                */
> -                               *done_index =3D folio_next_index(folio);
> -                               ret =3D 1;
> -                               break;
> -                       }
> +                       /*
> +                        * done_index is set past this page, so media err=
ors
> +                        * will not choke background writeout for the ent=
ire
> +                        * file. This has consequences for range_cyclic
> +                        * semantics (ie. it may not be suitable for data
> +                        * integrity writeout).
> +                        */
> +                       *done_index =3D folio_next_index(folio);
> +                       ret =3D 1;
> +                       break;
>                 }
>
>                 /*
> --
> 2.47.2

Applied to for-next, thanks.

Andreas

