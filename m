Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AA133D6E8
	for <gfs2@lists.linux.dev>; Mon, 26 Jan 2026 14:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769437573; cv=none; b=CQeXnI4BfLP6oeow7xGL83Z28/M7KstEfITQm9VZKIetT9acHwy4+QrTe/LSpfNa+nRQuVOu+D8+Nln3vVK17nPuKWpkqh1BPfgiUYJ1gYYLHetX9D+A+thuZqHHslspYoDGsZV1Zo4PLVjVH3nMlgpCRZAmpNI6BE2mgU7DEZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769437573; c=relaxed/simple;
	bh=R39yI3zrUVBRoImFLGoBqsOKE4XKwQsDK7ICxl0PndA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kmwdxOxDM0JFJRR5rPAeiUN23v0Le8weZ2aqyA9FIwE+pkFz0YSjaXir+wKnX1m/PkOn5DKqWrx2DvoFtncn+osRvsXkSKB7eotoUKRJDSFUPULo0WX7YCbi1TPzk/lcvHbwIL2/Kbi7eLyq0ZSQGo+ZrYAmEL1I+DDXHpSpbFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F1r0HcEp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F1r0HcEp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769437571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0LQyvuQCM9ruI9QQbyiNGANsOOzKEFGJPablDXgQe7E=;
	b=F1r0HcEpzuf/FiTeWq1LRSHMXtq09bEROmGTmZTr9hHUUJeCgJqpf+tc2+XOMe//8ze5N8
	Ghb2qBrtp4GBAGSrEv9rgoR4HyqG80lQGR9tgVBsf0GcT6aC91fXDtRtudB7TrlBBP2B/C
	iEHEQw7tpg/JbG85g5jwEB8hwPTiOsM=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480--5L1re5tMmGII8v3ZeRhKQ-1; Mon, 26 Jan 2026 09:26:09 -0500
X-MC-Unique: -5L1re5tMmGII8v3ZeRhKQ-1
X-Mimecast-MFC-AGG-ID: -5L1re5tMmGII8v3ZeRhKQ_1769437569
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-64680de9f05so7204263d50.3
        for <gfs2@lists.linux.dev>; Mon, 26 Jan 2026 06:26:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769437569; x=1770042369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0LQyvuQCM9ruI9QQbyiNGANsOOzKEFGJPablDXgQe7E=;
        b=P1wV0lsPrLnb5HBix+hToh/Rvxa4ih1lE9xv1FuruleXE82k1V/KMuf6OjocLrHtdf
         J7fD3lLEWw81YlL9YcLqKZe9xwdU+7LcgjefwKFDiDkHAhsZd5GfwFQsYLAYQV9t/7IP
         zPEmseAGBYIcAv1U//0pTImRDrgmaBKiRKy0rMNU0aP+XygDlZ8CYgG44ijyzZyZS0G1
         Bmolm4OFoFCYgYSxtaH+3l+K2MPB/ElfLBsPbBoNjars3mYv40FipLMRm7I6QJ7PTwha
         VFXiRWkmt8d86mFnnGPzpHhmtAvbJgEeHf69rvE7TYP8F9iAG4Am7CrgfeqELpfClJFQ
         0TUw==
X-Gm-Message-State: AOJu0YwSl7m5wNLqoGE0seohEcr0MTjHZRQ0LQOQGiWYYk37CMzn9Lpb
	dgUoPcWn1OiASSREfqXK8HbJY2WW4CjMiqLvm0J0s841N41FrCPJPo0tgWaq5T1cUDyTnKPMKTM
	Vs+dtxq4dh806ShNOtpVMwcQIN8xwg5RbWRVjoE0BODR79ikY75MxycRItzzKKNikUxy6CaHBlq
	Ns1RbjwIUUO+v+QsOP7EMjjAkCFowWOpUd2T8kUg==
X-Gm-Gg: AZuq6aJL3XSLsPLyNvHhXCwXgKc87lf7LbXkuPq3+sVyPpNaSBJwIzyYZEVtXes0StH
	jRov4F1g75QwxstMKO873lPuitEgBJVqn2KoUb/k0Q4TFox95c4+mGDTTPxEuao+utFKATGJhhD
	9rsET3GxBwodjBrh+1uczcyf6K5amyx8/lgzXuXidJdQuY/IJ69s8m1uSYCu+88OtYLA9kxEDq4
	ZJZxv7dHNlDZbuLZknsLLhVxLVsW/d+DBPdeZLEMrohTp9tZkFLSQ==
X-Received: by 2002:a05:690e:d03:b0:649:2e3c:7d6b with SMTP id 956f58d0204a3-64970bcc1b3mr3695907d50.26.1769437569280;
        Mon, 26 Jan 2026 06:26:09 -0800 (PST)
X-Received: by 2002:a05:690e:d03:b0:649:2e3c:7d6b with SMTP id
 956f58d0204a3-64970bcc1b3mr3695891d50.26.1769437568931; Mon, 26 Jan 2026
 06:26:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260123153105.797382-1-agruenba@redhat.com> <20260123153105.797382-6-agruenba@redhat.com>
In-Reply-To: <20260123153105.797382-6-agruenba@redhat.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Mon, 26 Jan 2026 15:25:57 +0100
X-Gm-Features: AZwV_QjE4MMgKxvc4KIUhZ3qTyu6516o9EPDLlxbX-_2X3jlvKviLbQ2yRVzs7c
Message-ID: <CAHc6FU67iqcqCAAg49ygDQ+joRg7pUds++mMMS47gZHKkcQRiQ@mail.gmail.com>
Subject: Re: [PATCH 05/13] Revert "gfs2: Fix use of bio_chain"
To: gfs2@lists.linux.dev
Cc: stable@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: l0btx7oNdevMqPVYyWWixE68Cn6kZl1a7Z4vT42OHfo_1769437569
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

(This patch is upstream already.)

On Fri, Jan 23, 2026 at 4:31=E2=80=AFPM Andreas Gruenbacher <agruenba@redha=
t.com> wrote:
>
> This reverts commit 8a157e0a0aa5143b5d94201508c0ca1bb8cfb941.
>
> That commit incorrectly assumed that the bio_chain() arguments were
> swapped in gfs2.  However, gfs2 intentionally constructs bio chains so
> that the first bio's bi_end_io callback is invoked when all bios in the
> chain have completed, unlike bio chains where the last bio's callback is
> invoked.
>
> Fixes: 8a157e0a0aa5 ("gfs2: Fix use of bio_chain")
> Cc: stable@vger.kernel.org
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> ---
>  fs/gfs2/lops.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
> index 97ebe457c00a..d27a0b1080a9 100644
> --- a/fs/gfs2/lops.c
> +++ b/fs/gfs2/lops.c
> @@ -484,7 +484,7 @@ static struct bio *gfs2_chain_bio(struct bio *prev, u=
nsigned int nr_iovecs)
>         new =3D bio_alloc(prev->bi_bdev, nr_iovecs, prev->bi_opf, GFP_NOI=
O);
>         bio_clone_blkg_association(new, prev);
>         new->bi_iter.bi_sector =3D bio_end_sector(prev);
> -       bio_chain(prev, new);
> +       bio_chain(new, prev);
>         submit_bio(prev);
>         return new;
>  }
> --
> 2.52.0
>

