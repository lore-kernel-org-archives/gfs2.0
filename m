Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA03481A96
	for <gfs2@lists.linux.dev>; Thu, 15 Oct 2026 19:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792091155; cv=none; b=FbWy9Ts964vPI3aq3NSLeNyAX/dAGuBv7b0lcd2XDowJLdUR4euBPLfn4RTzWyabYkiFod4m1Do803rPtR9l5lz16cwW+/uBwVu6kRazf3xY0Im2A0QbpT0ZjWL215UoxHYq1G0BuS+HWHXByQiYQ6NdVKNB2axkiPfN4ca4fSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792091155; c=relaxed/simple;
	bh=njrs69PTpabl/E/c3igW5pfsoq94perIYIoiSEXvZaU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VFSL6ufbBBWtGT4SpiXVXTA8m3Ofy9tIHa6XPcQCvhwVuKlm8Y0soYUZ8R2zqYWnCJ773R+UKwyNW0mCI48X1/C6W9/VMHFGMzC39DYW70G35jhAVgT2vpP9rFe8Bh9mgS7Z7m78QtxRPsdZz6ap5LSyD0NlEzg95TsZ9BJl+V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wv3WNItm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wv3WNItm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792091153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+t2QXv6kbjJkqJV/NGflwSk1ZKtAPXbD9EclLnTEDp4=;
	b=Wv3WNItm4uVAnbKHZ675WoLz38h/8kY7MU2NAg+5lT17THJIFrogFmbjkJnOW61gOu6hoO
	6XRfxqnAB3ZILdAd4iPJK1gyQFWfAndqs99an+eoXvUwvQ7189BoQvCkrHoHPudDEaGCJs
	+3cxdl6sh80/eMSYRJd6yzIAgExjVUw=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-8p-QEEmiNSezAWRm18f05g-1; Thu, 15 Oct 2026 19:05:51 +0000
X-MC-Unique: 8p-QEEmiNSezAWRm18f05g-1
X-Mimecast-MFC-AGG-ID: 8p-QEEmiNSezAWRm18f05g_1792091149
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-6790b1d3bc9so7658358d50.0
        for <gfs2@lists.linux.dev>; Thu, 15 Oct 2026 12:05:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792091149; x=1792695949;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+t2QXv6kbjJkqJV/NGflwSk1ZKtAPXbD9EclLnTEDp4=;
        b=zihh0nwXw68Ac5Lx8VyycfOlLLuj8OyqtETLmWUPFjU96rATnmtzvjtHaWfOadAgYV
         h19KLZOO0cCFlTeLbWaHLO1TDg8E0d1pWd9U7BMY0vQ0cgjrt6Rvync+zJFw+Z5FpyxY
         uslapLT0hUnc9CmLaeipCh9mo8v83l7HvWnKlCZxSeyr0CflGENKpFqlpyQqmKcLo70t
         NJbw4f5WTijkOlWthb4ci5bxml3mkADkIwdTM9MUDdGp+PWNeQbaA/thvFU8c/vd+I/g
         iqkomzl75Bqk3NXMfEvErDYWrZGjDJU4GiQwkWO2CTKX61ISPw9A7sm0EYcNSQ6RhF4Z
         h/DA==
X-Gm-Message-State: AFq9FYIHAXlfVcayHlnYrMpIQGc3c59jJw20Ec0dxOgPGnOtPOWHxnUb
	GylQ1/kv/SMIpABeorJxeJ9/4CpJHcYwpLhw7u28aEdORFHr6rIBG3hGEOGFSj8JLG3gpFiVkqS
	rBenoWe9oYvMn+vPAtaa9O8PVe/cKvPz4uYSRdQJRXvwSJMQ9Ucc5Buqx3w2QMV7Aw9dT3O5SKO
	/CBMgqF3CGYMARB9sLN8uZBiLhye8dMQ==
X-Gm-Gg: AYBFou1VZGflgS3kzAMV12QMdGjDVSRgCm0RvTMdY3Pr5cehmmIV8MAtNuWsPfUBP2+
	m9iIUNSul+bQKuZesoSla9pdxCvNMvvmyrht47WiGrpYx8pj9bo9+hT1Wst1WcbVI/CVRS/eJTb
	dsY4pfHOs3XPuXxoEO6FvObtVal9MnfzszyxBoCPN4fwJ6CcYXfBa3ztLI8InsTqY5ZVT2OfCh3
	jEAiJryTUAmdQYct2QeATcTwiFuQaLkU7JJr7IhLncF1Q==
X-Received: by 2002:a05:690e:c41:b0:679:8bba:31f9 with SMTP id 956f58d0204a3-6798bba38cemr2199244d50.91.1792091149397;
        Thu, 15 Oct 2026 12:05:49 -0700 (PDT)
X-Received: by 2002:a05:690e:c41:b0:679:8bba:31f9 with SMTP id
 956f58d0204a3-6798bba38cemr2199234d50.91.1792091148870; Thu, 15 Oct 2026
 12:05:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20261014-gfs2-escaped-copy-fix-v1-1-ff917ec48fcf@columbia.edu>
In-Reply-To: <20261014-gfs2-escaped-copy-fix-v1-1-ff917ec48fcf@columbia.edu>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Thu, 15 Oct 2026 21:05:37 +0200
X-Gm-Features: AclHuK94-O6U3jMmeZ5GvtKhtuJdhgNOo4OyQgWOMPl5vnte_lO1Kd2hA9skmQI
Message-ID: <CAHc6FU61aba=a4eTH8xLGm5RDpLxxwzstq5B3aMTA1R0CaNSug@mail.gmail.com>
Subject: Re: [PATCH] gfs2: fix the escaped block copy in gfs2_before_commit()
To: Tal Zussman <tz2294@columbia.edu>
Cc: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: aFyVcRmNXGzWEF0HWH6y1ubc29BsXwww8GCFj57T0aI_1792091149
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 2:37=E2=80=AFAM Tal Zussman <tz2294@columbia.edu> w=
rote:
> Commit d68d0c6c3fc7 ("gfs2: Use memcpy_{from,to}_page where
> appropriate") made the escaped buffer copy read from the mempool page
> it had just allocated instead of from the buffer, so the block written
> to the log is whatever the pool page last held. If the journal is
> replayed after a crash, the block is restored from that and the file's
> data is corrupted. Only escaped buffers are affected: jdata blocks
> whose first four bytes match GFS2_MAGIC. Copy from the buffer's folio
> instead.
>
> Fixes: d68d0c6c3fc7 ("gfs2: Use memcpy_{from,to}_page where appropriate")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>
> ---
>  fs/gfs2/lops.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
> index 77ef22eab368..16fba2108a4f 100644
> --- a/fs/gfs2/lops.c
> +++ b/fs/gfs2/lops.c
> @@ -689,7 +689,9 @@ static void gfs2_before_commit(struct gfs2_sbd *sdp, =
unsigned int limit,
>
>                                 page =3D mempool_alloc(gfs2_page_pool, GF=
P_NOIO);
>                                 p =3D page_address(page);
> -                               memcpy_from_page(p, page, bh_offset(bd2->=
bd_bh), bd2->bd_bh->b_size);
> +                               memcpy_from_folio(p, bd2->bd_bh->b_folio,
> +                                                 bh_offset(bd2->bd_bh),
> +                                                 bd2->bd_bh->b_size);
>                                 *(__be32 *)p =3D 0;
>                                 clear_buffer_escaped(bd2->bd_bh);
>                                 unlock_buffer(bd2->bd_bh);
>
> ---
> base-commit: d0c4bce31a579216780b990a09250f15e00f38ff
> change-id: 20261014-gfs2-escaped-copy-fix-1055ded37add
>
> Best regards,
> --
> Tal Zussman <tz2294@columbia.edu>

Thanks, I've applied this to for-next.

Andreas

