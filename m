Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A1C329E40
	for <gfs2@lists.linux.dev>; Fri, 28 Nov 2025 12:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764334793; cv=none; b=bkzJ3z0v6tjvMsIFPUdJ5bLyGh5Uhb1V1iH3ySFZtfDyECITS6QlYXndaLzfk1AkWSmJ8oSey8GHO4DondmhW7de6Ks3cDcEEL6omQg+LpJqKXPpW6ukMEx8xzryWDEU57GzUckMGPz16n1O5XzAuWayAoRBQcMhNtxKlz9NhsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764334793; c=relaxed/simple;
	bh=5QcOkFfFDyBXYDnDanyoo0Sx7zR4bMbvdaWPFSIL9Dk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZwhqWL7tytEeoa5/zV/+2Iku4CdO/xf0F4r3nt5jQ/z6GMbg5ZNJ3j3Jt/i9G5b26XqC+AT69xUcAxsduAKp63JCOICJqq2mEjLAU8tgi9eZ7VthiHV2DbN5gVmgblWp3As63UksSoda6RDL7fGSWCuQjt0DXlOp9rViDDL+l0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GiSx9KUj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GiSx9KUj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764334790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UbnViGm0SST3AIOO/NDK6ivARfPGgq8UL5FPgRGsaTs=;
	b=GiSx9KUjtxhoZsS5uDlwlsauxt6xbUtAaqMxXCp31fnyp+Y99ROSftxzDalwK1c31wqBwn
	5QyjyUtF74Vgg+bXV+L1fqrKSjr83qLFN6GBreP28RP+Nt43DISiK3OLOrpSnHz6YRmOsh
	iNno/MNxkGh6Z9JReMqiDfMeg1YAp54=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-55FY2S4FNhyPBDwmDhHorQ-1; Fri, 28 Nov 2025 07:59:47 -0500
X-MC-Unique: 55FY2S4FNhyPBDwmDhHorQ-1
X-Mimecast-MFC-AGG-ID: 55FY2S4FNhyPBDwmDhHorQ_1764334787
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-78aaf491ea9so21487237b3.2
        for <gfs2@lists.linux.dev>; Fri, 28 Nov 2025 04:59:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764334787; x=1764939587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UbnViGm0SST3AIOO/NDK6ivARfPGgq8UL5FPgRGsaTs=;
        b=VtVs0H4mW+cYVFEW4sK0u2sm6RfpDc3pdCyUB789maEXzwNfxFdig83m45h8h/D8pm
         NkoITr2V9sV6/cEV40/uT5jepapNdiRjPK2hOYFvU5K4mUm6zM6X4IqVya7qcccyvwGC
         vDd0H36HxeeX93+aj4qvorGY9B2oEB5+3St09wVXf/qnR6AMGzC8+VoPOpWWxSkoswTL
         sKGYgoWJ1YmaLjVCz8I6jvncu6ki05eHnZO0vq692ezTwweosLMru+B9wGTYWm1TKMK4
         Y+jNBcf5DNPhWrkKntE8G6GzJod+DbfXZoRvs7W8wnzAqvR9oKSgiPfoAEHP4x4rX0Tt
         x1aQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2El9q7DoQHAiS/VFKHCoY4f0sXGqEV1ZgU2HdouX5truXdcXYj2lCYV5vVNDsHnnBLNdx@lists.linux.dev
X-Gm-Message-State: AOJu0Yx32O0Vh5Y42XfgM1Jar2mczG3/EWEu6/cdlT6I/umyHEkbq7qu
	3BUyWzHssgDJAwFIjObrBW4osF+3B9casJb14qNjIWgjRCnbRvboZJot/LpfsZMkj2W10autgK/
	8AmUzqg3W5Cm0mah57hgEH2+sg7wEHcTtyIazPbiQzJq6rPEcFq7M8ikNAV3wKq2pgARcH9BaUn
	rHgOXY38dMU2pCFAcCruCsjnDHO/scgg==
X-Gm-Gg: ASbGncujp3fjJ8SaGmVqnfvKl+ztwmtHkLJPd4Y04FyE5fFu69YTvgwAi2tPCaMQAGm
	U4H/CkYhTKbWNsguvYvyS6fovhpnoHtT55rOxjFdkv5/zoZDiyDabCfwuDZSRIwwQ1bwvzl9a6H
	q99ea6DgK7Ozba/ibNPmMfthIElQVNOSop2Gv7WOXbpLA3HmU7iTCzew+TS9ynuooc
X-Received: by 2002:a05:690c:6f03:b0:786:78ab:72d0 with SMTP id 00721157ae682-78a8b47a179mr234771317b3.7.1764334786915;
        Fri, 28 Nov 2025 04:59:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGesqVOsUJELcTkEGN3hauFQ6kd2TkNnYcjHT4c1bgANcOfukNB8/4Sre15bHJPI3DpWDPFXhJhMME6PGLKN8M=
X-Received: by 2002:a05:690c:6f03:b0:786:78ab:72d0 with SMTP id
 00721157ae682-78a8b47a179mr234770957b3.7.1764334786528; Fri, 28 Nov 2025
 04:59:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251128083219.2332407-1-zhangshida@kylinos.cn> <20251128083219.2332407-3-zhangshida@kylinos.cn>
In-Reply-To: <20251128083219.2332407-3-zhangshida@kylinos.cn>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Fri, 28 Nov 2025 13:59:35 +0100
X-Gm-Features: AWmQ_bmJ3AOy1Ou64bzbzmfYJle8eXItasxBb4QbS7GrXBYKV503HxVqfGGmAks
Message-ID: <CAHc6FU6H22GEQTaOh4tm_=yL7CZ-Ck4EkXtmdsn_oyAW7OWB6g@mail.gmail.com>
Subject: Re: [PATCH v2 02/12] block: prevent race condition on bi_status in __bio_chain_endio
To: zhangshida <starzhangzsd@gmail.com>
Cc: Johannes.Thumshirn@wdc.com, hch@infradead.org, gruenba@redhat.com, 
	ming.lei@redhat.com, siangkao@linux.alibaba.com, linux-block@vger.kernel.org, 
	linux-bcache@vger.kernel.org, nvdimm@lists.linux.dev, 
	virtualization@lists.linux.dev, linux-nvme@lists.infradead.org, 
	gfs2@lists.linux.dev, ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhangshida@kylinos.cn
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HjO-D6-Sw6wgcd-tfkyrStbnZ347GOlGuzT-eSRtH7A_1764334787
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 28, 2025 at 9:32=E2=80=AFAM zhangshida <starzhangzsd@gmail.com>=
 wrote:>
> From: Shida Zhang <zhangshida@kylinos.cn>
>
> Andreas point out that multiple completions can race setting
> bi_status.
>
> The check (parent->bi_status) and the subsequent write are not an
> atomic operation. The value of parent->bi_status could have changed
> between the time you read it for the if check and the time you write
> to it. So we use cmpxchg to fix the race, as suggested by Christoph.
>
> Suggested-by: Andreas Gruenbacher <agruenba@redhat.com>
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
> ---
>  block/bio.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/block/bio.c b/block/bio.c
> index 55c2c1a0020..aa43435c15f 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -313,9 +313,12 @@ EXPORT_SYMBOL(bio_reset);
>  static struct bio *__bio_chain_endio(struct bio *bio)
>  {
>         struct bio *parent =3D bio->bi_private;
> +       blk_status_t *status =3D &parent->bi_status;
> +       blk_status_t new_status =3D bio->bi_status;
> +
> +       if (new_status !=3D BLK_STS_OK)
> +               cmpxchg(status, BLK_STS_OK, new_status);

This isn't wrong, but bi_status is explicitly set to 0 and compared
with 0 all over the place, so putting in BLK_STS_OK here doesn't
really help IMHO.

>
> -       if (bio->bi_status && !parent->bi_status)
> -               parent->bi_status =3D bio->bi_status;
>         bio_put(bio);
>         return parent;
>  }
> --
> 2.34.1
>

Thanks,
Andreas

