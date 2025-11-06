Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3538264FBD
	for <gfs2@lists.linux.dev>; Thu,  6 Nov 2025 21:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762464200; cv=none; b=B4fW9HQ9ZBPUlvXMjnvwwa6UXN0xzT5lbyhAQrEKz3QT152HlJW3vyUE04DkZ7Pxv57jGJkPNguXY5bXsBJKLBfljnvX0D/7SKjXwkgdRr+rKnSb+1yJ45piM/Atw1QRS7uhHs/6f7TQxX5VI2BkvGyjCPLlZyM/HOfaK7H4WTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762464200; c=relaxed/simple;
	bh=vhnj2EGSVLP3FkxR0lZwUI0398IK7iqhmauafTm4wMw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d3vWjyl0/riBYpOHh6CeJNHsmjmBwhdl5rHBud8pLW2q1bV/49lJzQw3Rj6wjkq8Pa6y6bLW17TyJtzeLRxRDeiH6PGJ9aucKJdyo2eQMqEWC5nYfSZAmQvUB4X4+CQjBNRqEfaTMiukIUtE2U0K0Im5tS5h87P5/1D3IOS5/uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PlModDh8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PlModDh8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762464197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=usuQUhfQvr0g64KYfyoaUJEu3WWwfLZR2o6FU3CS9Hg=;
	b=PlModDh8M0L8ziwF6RwmfluZ02w7Ml0opbgNPHQrOf7vzwe9EMgrv9Wq+CMKF0cNg7Fta+
	4rIKKb+Nnnr2NsGSq2nHHUTNY3/nJVC8+5goBWOHgvNOdpBM8WVVrISVb0/OOXLi2X4Td/
	fWdyXFImWOXu+XM5H5xuGu16loAuzjE=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-274-YcFa8PV6NUiWJGyWxXGDmw-1; Thu, 06 Nov 2025 16:23:15 -0500
X-MC-Unique: YcFa8PV6NUiWJGyWxXGDmw-1
X-Mimecast-MFC-AGG-ID: YcFa8PV6NUiWJGyWxXGDmw_1762464195
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-7864f72835bso1300797b3.2
        for <gfs2@lists.linux.dev>; Thu, 06 Nov 2025 13:23:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762464195; x=1763068995;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=usuQUhfQvr0g64KYfyoaUJEu3WWwfLZR2o6FU3CS9Hg=;
        b=m1djxHAWN5S78G5zeoIUGdZUsxjh2GeKeF3P+EEwAS5/MMVWEVs9uItbPmm6Xx3TTs
         GcMqBzta0Txd0CX7/5TiSjYRvThzUtw16kbCqnO6JDmYepz64G8oYg/3Uy4k01hnOk8F
         ZWPh9nDmj5Z6rBDNLbadhEUFfK6IONjzB3Kn07UwPMtzkGbGm68x4tSyf9SOLouwxWlj
         R0pb1v/lFMLr2sdeUtTanBcp1AMVx+snWObs2n8yrZdldH409C5gDx2avNCSo2IvTudR
         UA8xiw79Uy6sPmby3pwKHu0hliiWIHqkhC0AFzhzrfoIVK7NWvon5DopMsVH5AZUzx7h
         1xVA==
X-Gm-Message-State: AOJu0Yw/+Tmh2R2ns0zBsMi3/zDI72aqfRxGwoxYb0atyRKzw7WkW6XO
	P018gGsAyRLb7v6XBsdsfw+3PyKkenTJulH9s/VxiCQwgDnR1LNtKpbxsGy7EcdSD98W9Gol4uG
	H6qOG3ftoS2AqJieY0PnqrdtGhw17DPWmmXsFuGBjqOvK8gf8iMvVRjKjJoM+qcoMXEMot9Ff5T
	BNVakYXHS4RnvWSA66DXKe4A7UAWk/JA==
X-Gm-Gg: ASbGncupLyYBcaoPElX5dXzXNFlhLrUFMoDjI95l9LuRl5LPNyW3UXzIiOQxOhr9LT5
	lT3cqJlag7bChNLqHkc8F+1D8GTuTJWKEDoU8vDcECM7Un+6ZxZH4eUPaJ2eGSMmoH0Ictv7rKe
	XStUD4xl5IMJmWn/qOIOa2Kq2R24Tcj50KSsxzgiAM3Mvu6KFQ/JoPMA==
X-Received: by 2002:a05:690c:a0a6:10b0:787:c613:821e with SMTP id 00721157ae682-787c6139ce5mr3327757b3.62.1762464194787;
        Thu, 06 Nov 2025 13:23:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGrALypo3RCpOWTZPjonBqYfAEjYD4JEptJgGL223XNnnR49gBZ7kEd9W7p+Bp7QuhUwdE2hhTUhiEaUyal/m4=
X-Received: by 2002:a05:690c:a0a6:10b0:787:c613:821e with SMTP id
 00721157ae682-787c6139ce5mr3327647b3.62.1762464194492; Thu, 06 Nov 2025
 13:23:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251106202944.2344526-1-willy@infradead.org>
In-Reply-To: <20251106202944.2344526-1-willy@infradead.org>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Thu, 6 Nov 2025 22:23:03 +0100
X-Gm-Features: AWmQ_blaeFJ0E8PLBUi96SroZHzppdF6ZcE1KCjNsv15hEQHnW7e8ZAIf1JXh28
Message-ID: <CAHc6FU40AYoMDTxRwWuT8XtfWozsfwEzOqPoVQD1giPVT2GMkQ@mail.gmail.com>
Subject: Re: [PATCH] gfs2: Use bio_add_folio_nofail()
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: G-ihzpgFWtKIUZl7SV-0qkRXJKuO8B_2awH5y4Yur8g_1762464195
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 9:29=E2=80=AFPM Matthew Wilcox (Oracle)
<willy@infradead.org> wrote:
> As the label says, we've just allocated a new BIO so we know
> we can add this folio to it.  We now have bio_add_folio_nofail()
> for this purpose.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/gfs2/lops.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
> index 9c8c305a75c4..233b3aa8edca 100644
> --- a/fs/gfs2/lops.c
> +++ b/fs/gfs2/lops.c
> @@ -562,8 +562,7 @@ int gfs2_find_jhead(struct gfs2_jdesc *jd, struct gfs=
2_log_header_host *head)
>                         bio =3D gfs2_log_alloc_bio(sdp, dblock, gfs2_end_=
log_read);
>                         bio->bi_opf =3D REQ_OP_READ;
>  add_block_to_new_bio:
> -                       if (!bio_add_folio(bio, folio, bsize, off))
> -                               BUG();
> +                       bio_add_folio_nofail(bio, folio, bsize, off);
>  block_added:
>                         off +=3D bsize;
>                         if (off =3D=3D folio_size(folio))
> --
> 2.47.2
>

Added, thanks.

Andreas

