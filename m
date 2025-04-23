Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C31786344
	for <gfs2@lists.linux.dev>; Wed, 23 Apr 2025 19:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745435738; cv=none; b=uP8kXyMoYy5I+FVkUfIUpCl+dpM0FR6+3PUSHnJWJ//rAOYwbZLhERV9nYErwY/QKFpmqVR+EVDlCx/xJN1BmvZwBRWE6R22qZ2qRRx7SeeWHT/3wTGfp226bEX7pkRweg7I63HRitLEFJ2cLGRmym5FS9XJp/l7sWzZFcDUbDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745435738; c=relaxed/simple;
	bh=eickxpp+U+TX/hCGMIUysoHKRlJLm+0sC+wt+DIQuu4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R1rRh51vNNfkDkCIZd3Eh/aO4v2eznJYXRjO2UCT0/U+gY3PBScVszN2eONRHMufRWemfdzJ1CXN0Y9R4YPbhg3fuQrw0n4mV28OXwhi5Vgy5bneUKhBiuwlmuLnkzNjDL3di7gH00l+5jTotuu8is/7DoxNCrWCW/Ib+2u/qd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GFClGIJx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GFClGIJx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745435735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NsN5lkmU2hxjcVy5rQEw514KL16xc+u7bIhBtUpApIU=;
	b=GFClGIJx58nYbHVf65viYewtypnWe4MZ3MUjhC2EE6zi8F1AqGz8m+rdrEGhLA/z6YpvtZ
	bLP13XTJzK+mOLrG2V0kWVFEjdnvzoyaMnaJzSluJew1peucjwiYU/PPhfXg/ZR1btT6rX
	b1JRx+Ul0NniEneWeJyhlUGU6Cm7wV8=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-ZXZBkB46N6mICD-hb_4Q3A-1; Wed, 23 Apr 2025 15:15:34 -0400
X-MC-Unique: ZXZBkB46N6mICD-hb_4Q3A-1
X-Mimecast-MFC-AGG-ID: ZXZBkB46N6mICD-hb_4Q3A_1745435733
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-22651aca434so1424635ad.1
        for <gfs2@lists.linux.dev>; Wed, 23 Apr 2025 12:15:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745435733; x=1746040533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NsN5lkmU2hxjcVy5rQEw514KL16xc+u7bIhBtUpApIU=;
        b=pUyVM5dPm2VggFCZJdgrjb1+jpzAqar3BEVqOQdUD8KkE5KQ63PPbgpTO23xUOtYLA
         W9QBq3eCgjpbVBT4gEgsN/q2cS8WC/gBw9J9RPK1Pm0RF0HoiHrwS2L8nNsNN1rSmxt5
         QWSVsOt8zMYFK5T4EYYHWkLtk5A/VCKiW0ICuNCg/SjfBZzTMRVcmNOKoYqS5uh5MHel
         Xum8Xc2Hh9jR4cwVuc3rFcsEzhE0Hx8KFvZk66+q1imnG7LOJM5ycLKpuMMPKxlsQ5Fu
         rAuUAX/etDBdYXWoFMfkYuPLnwtaxJuIkQOYvN3raJY3U8W51Z8OfU8PtbZzvqA/KjHy
         Ulxw==
X-Gm-Message-State: AOJu0Yxd/ciEJ1mkHCT4L2ypkEVCkAvYxQacUO00F0AaLkKxKxF9ECAU
	CaOHCaSG4XCAoXzUV+p0Hs7Ccs0HxnaolNudfU8C3uM+hhN9F0Lit0rH3thr39QcjvqzK/hPHcB
	UYkAUk1U3qdlf6MhGue4ENUOvdlUx+/ECjAqyhC+4vUSmkZDL6VBZ+n3pcwKrEMpKET+ErmxFuK
	zE1Mf5ogHH8ueIpilbnBV9KM626g==
X-Gm-Gg: ASbGncsTkfkVRfVMsET6UWOHf8ugJXe5x1JkW/7MnXWXMT/X/k2U6iuW1dCdkU5MO+p
	GZkPvBk+WSYdwFrCcpe/HjMsbLLKHaEgJkdjA28ZUOfmhdEsLX1hAD/pa2TOJrrhyaNM=
X-Received: by 2002:a17:903:110c:b0:223:66bb:8993 with SMTP id d9443c01a7336-22c5362e04bmr319319245ad.43.1745435732992;
        Wed, 23 Apr 2025 12:15:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAAFS26DKOMBitZyuK9X8fdqxlPh6t17mhHt6DJ7fRrV7XBYhBe+lT/z79OwJ1uTc+ljXTjpnq4zuPKthqMjw=
X-Received: by 2002:a17:903:110c:b0:223:66bb:8993 with SMTP id
 d9443c01a7336-22c5362e04bmr319318965ad.43.1745435732663; Wed, 23 Apr 2025
 12:15:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250423153528.251736-1-anprice@redhat.com>
In-Reply-To: <20250423153528.251736-1-anprice@redhat.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Wed, 23 Apr 2025 21:15:21 +0200
X-Gm-Features: ATxdqUFWbgngWDBSUSToBnlSaizPwfUOkhr07JJzAo_cPGKCeSdQgE4W63vkCSo
Message-ID: <CAHc6FU43no8JWgcw_TjCrkbdfBHVS0R7AkuX5kQQ5-A4O+kXUg@mail.gmail.com>
Subject: Re: [PATCH] gfs2: Fix usage of bio->bi_status in gfs2_end_log_write
To: Andrew Price <anprice@redhat.com>
Cc: gfs2@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 22O7lq5FfRYUf8CMo2YUz_j5XHXB4WYwURCKopCwHJw_1745435733
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 23, 2025 at 5:35=E2=80=AFPM Andrew Price <anprice@redhat.com> w=
rote:
> bio->bi_status is an index into the blk_errors array, not an errno. Its
> __bitwise tag is cast away here, resulting in a sparse warning:
>
>   fs/gfs2/lops.c:207:22: warning: cast from restricted blk_status_t
>
> We could either add __force to the cast and continue logging bi_status
> in the error message, or we could look up the errno in the array and log
> that. As sdp->sd_log_error is used as an errno in all other cases, look
> up the errno here for consistency.
>
> Signed-off-by: Andrew Price <anprice@redhat.com>
> ---
>  fs/gfs2/lops.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
> index 0fd3b5ec7d8cc..a1022635abc98 100644
> --- a/fs/gfs2/lops.c
> +++ b/fs/gfs2/lops.c
> @@ -204,9 +204,11 @@ static void gfs2_end_log_write(struct bio *bio)
>         struct bvec_iter_all iter_all;
>
>         if (bio->bi_status) {
> -               if (!cmpxchg(&sdp->sd_log_error, 0, (int)bio->bi_status))
> +               int err =3D blk_status_to_errno(bio->bi_status);
> +
> +               if (!cmpxchg(&sdp->sd_log_error, 0, err))
>                         fs_err(sdp, "Error %d writing to journal, jid=3D%=
u\n",
> -                              bio->bi_status, sdp->sd_jdesc->jd_jid);
> +                              err, sdp->sd_jdesc->jd_jid);
>                 gfs2_withdraw_delayed(sdp);
>                 /* prevent more writes to the journal */
>                 clear_bit(SDF_JOURNAL_LIVE, &sdp->sd_flags);
> --
> 2.49.0

Applied, thanks.

Andreas

