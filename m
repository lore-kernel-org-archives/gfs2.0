Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2191A3BD7
	for <gfs2@lists.linux.dev>; Sun,  9 Mar 2025 19:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741549415; cv=none; b=qgBdzG710cIZTYj96n4fL8YkH0QkSVlzd21Ft1xiJCR3FYzE3LfK657+LKE7AJ+y40CtGiPqHZNEtoRaW1XZrJUoiSSJLK8ao5SYokqWrHR9SD70Bl2I7MTC4hAHtwO03AYUXKz5BdIaPllLS5F6Y9166rnNFUmEb3cBjiKteLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741549415; c=relaxed/simple;
	bh=PcXEvTmP0Nmq5iRQTwGA/fVuglGMEBJWCiim3Cel88Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HnGjlkAfwNm0DBtWUhxEnaAN6i+RJhv8DEXej6miga01I7sBO3Tq5vK7a3tQkbyvvtrRDlPHSXNqgRvdxrPfFBerZ/RPx/PxWYl0Ib/2bI02RVeYZy+1/rd1q6t2Gc2gxrzB5xHcpCEBBW/hfixQ7bLZmIdJCF069ILUOf7hm+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ws7Dd5Xh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ws7Dd5Xh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741549412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rmlFQWhZKZbPGn7ZfFNpeUgMQE0KdEQP748zRbes2mM=;
	b=Ws7Dd5XhJeQjZ0zpOel+hVEUXXf0M7x1QcQ361gbo1QpPPVJNB2tQhGZTlMJuBB5URa6Vs
	J/nA+mF+M69MzhXFpcFxKZqg3vMQaRTgoKHlfE0qg/GgxbTCDc+oU26LX+4M7aclGNqPvF
	12DUD48R2whl3hJdFOnWLSPWm1336Bk=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-BapjcnYKM0KfD27EwjyGsQ-1; Sun, 09 Mar 2025 15:43:31 -0400
X-MC-Unique: BapjcnYKM0KfD27EwjyGsQ-1
X-Mimecast-MFC-AGG-ID: BapjcnYKM0KfD27EwjyGsQ_1741549410
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2240a7aceeaso62194465ad.0
        for <gfs2@lists.linux.dev>; Sun, 09 Mar 2025 12:43:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741549410; x=1742154210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rmlFQWhZKZbPGn7ZfFNpeUgMQE0KdEQP748zRbes2mM=;
        b=ITHmCkJamCr7g6rOVbM2ESALF+E8nhhybnAIedp2vwlfyyT24bWxjTs2pM1B0W6btz
         YS59NOz4VAipZM1ZbOr62Jbg7smBqNWZQaG7FSZUf6IP3jR+T8SgswslnI0/EYR42xcF
         /H5DDlf07LPE7qX8rHx8UpadtUT03z0ICssEz6GWQnpdAfWHLiC7fjUdDyxU91fQZJ6a
         qEgVbIEke0cri47DYlaZ25ng1OFEDj6QwktvNuaCRQ5o3SkFle4K9xBcOeC6X0JVKi3h
         C+lagwKd9HEACBWPy0w7La+20LkzokuCyg0y7K00QayLJCubFbsylHzqgpxiKtJQoZk8
         aa9w==
X-Gm-Message-State: AOJu0YyZT+4KkMPl1Ug8OUzBtIYIJNDkZxEfi3G/jB5a5Le1rJ/UC6FF
	DsIazjrt2koJw6GCHYx1EHqrSORY0D2qXYPKQW8/o/+/+6eQwVr4TjvSH7/Wb3M0LBSgdYI2SNA
	p+512hFyf+KooU7NuvxaDVZjULoPFzNBGw9L+7ldTlRuxqnlbQERXLI4doidVzo5o+HGvriZKw4
	cHM/OHyb1m+OCd0xZM4ZlHPB/Yzg==
X-Gm-Gg: ASbGncszh2Tb3quXMcXTad83W/AHoCLd2k6EKbSBq6ajHt8vmwOMrR+ANfauDcKkaNs
	EzzAsRnE2Ocd+p5duXMF+ffgdHx93lIpedyuGzzEYg9wgL10SNsYmSxopEZPIbUZJaa3h+pI=
X-Received: by 2002:a17:903:234f:b0:224:18bb:44c2 with SMTP id d9443c01a7336-22428881fcfmr148875015ad.6.1741549410184;
        Sun, 09 Mar 2025 12:43:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSAbOntYSkhj1Cxv/OKzLZ+MTf5PVqVJzDQBxypFycd8UKOYukszbnBM7t3IP41dFYeJF0GgjcCRZgdLMMPds=
X-Received: by 2002:a17:903:234f:b0:224:18bb:44c2 with SMTP id
 d9443c01a7336-22428881fcfmr148874895ad.6.1741549409900; Sun, 09 Mar 2025
 12:43:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250210133448.3796209-1-willy@infradead.org> <20250210133448.3796209-7-willy@infradead.org>
In-Reply-To: <20250210133448.3796209-7-willy@infradead.org>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Sun, 9 Mar 2025 20:43:18 +0100
X-Gm-Features: AQ5f1JrJmS3XoJdt7uF7y2sdMDjqqEnMKkCOFpiHJUUXqMVVe6GJ1yX0jC0X5_k
Message-ID: <CAHc6FU4oR4bkDgfqEweHAmoMDUVtGDzDFDU0QAMxx_SrjcQ61w@mail.gmail.com>
Subject: Re: [PATCH 6/8] gfs2: Convert gfs2_find_jhead() to use a folio
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8_hwTQkGx3RhsNzGSbwvudR8zDHeGRlEwF8Twx3Oho4_1741549410
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 2:35=E2=80=AFPM Matthew Wilcox (Oracle)
<willy@infradead.org> wrote:
> Remove a call to grab_cache_page() by using a folio throughout
> this function.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/gfs2/lops.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
> index 09e4c5915243..30597b0f7cc3 100644
> --- a/fs/gfs2/lops.c
> +++ b/fs/gfs2/lops.c
> @@ -514,7 +514,7 @@ int gfs2_find_jhead(struct gfs2_jdesc *jd, struct gfs=
2_log_header_host *head,
>         struct gfs2_journal_extent *je;
>         int sz, ret =3D 0;
>         struct bio *bio =3D NULL;
> -       struct page *page =3D NULL;
> +       struct folio *folio =3D NULL;
>         bool done =3D false;
>         errseq_t since;
>
> @@ -527,9 +527,10 @@ int gfs2_find_jhead(struct gfs2_jdesc *jd, struct gf=
s2_log_header_host *head,
>                 u64 dblock =3D je->dblock;
>
>                 for (; block < je->lblock + je->blocks; block++, dblock++=
) {
> -                       if (!page) {
> -                               page =3D grab_cache_page(mapping, block >=
> shift);
> -                               if (!page) {
> +                       if (!folio) {
> +                               folio =3D filemap_grab_folio(mapping,
> +                                               block >> shift);
> +                               if (!folio) {
>                                         ret =3D -ENOMEM;
>                                         done =3D true;
>                                         goto out;
> @@ -541,7 +542,7 @@ int gfs2_find_jhead(struct gfs2_jdesc *jd, struct gfs=
2_log_header_host *head,
>                                 sector_t sector =3D dblock << sdp->sd_fsb=
2bb_shift;
>
>                                 if (bio_end_sector(bio) =3D=3D sector) {
> -                                       sz =3D bio_add_page(bio, page, bs=
ize, off);
> +                                       sz =3D bio_add_folio(bio, folio, =
bsize, off);

The check below needs adjusting: bio_add_folio() returns whether the
addition was successful, not how many bytes were added.

I'll fix that.

>                                         if (sz =3D=3D bsize)
>                                                 goto block_added;
>                                 }
> @@ -562,12 +563,12 @@ int gfs2_find_jhead(struct gfs2_jdesc *jd, struct g=
fs2_log_header_host *head,
>                         bio =3D gfs2_log_alloc_bio(sdp, dblock, gfs2_end_=
log_read);
>                         bio->bi_opf =3D REQ_OP_READ;
>  add_block_to_new_bio:
> -                       sz =3D bio_add_page(bio, page, bsize, off);
> +                       sz =3D bio_add_folio(bio, folio, bsize, off);

Likewise here.

>                         BUG_ON(sz !=3D bsize);
>  block_added:
>                         off +=3D bsize;
> -                       if (off =3D=3D PAGE_SIZE)
> -                               page =3D NULL;
> +                       if (off =3D=3D folio_size(folio))
> +                               folio =3D NULL;
>                         if (blocks_submitted <=3D blocks_read + max_block=
s) {
>                                 /* Keep at least one bio in flight */
>                                 continue;
> --
> 2.47.2
>

Thanks,
Andreas

