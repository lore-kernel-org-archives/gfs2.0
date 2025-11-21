Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDE62EB86D
	for <gfs2@lists.linux.dev>; Fri, 21 Nov 2025 17:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763745166; cv=none; b=AME4XnliZSESXJlWRc8/dZFzMGQYGBngZAHxr0qIlPiKiBCBruAIEtvR1FjzqlmPMeD1xf8MJODpMYRMlqtoq2UL31Aajca1auKyRALn16Re5f+/vIULcBTgPZKcthDz2CjgmDi+h81W/mGQcy5vnjGI8dm7al+i65sg5DeOUvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763745166; c=relaxed/simple;
	bh=4knX7UdpV5PqcFPGudPF/uxcuJbYSUmyGMDEJIBJ6aQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RqH7snMgsOqAlyX6W7s1Q/Go/wYG+G6UZw2/jVpTgwrs6tHp9L01OXa6UVZOTKnBxmEblXVWx77y6VKqw5j3ipP7c4tRAl/3Z0m4Khnp28vx+YF9zhdS5ue5ndzGAioqah91x1lsyx1yOb0pOFgHRTeSo6gm3ECI8eTc0GBrRIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cqy9qcpb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cqy9qcpb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763745163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FRU2qLfbf/wNhvSHqqWH92nPqYewb6NVEbhZtNPwvUI=;
	b=cqy9qcpbcGQAei1a6vkW78PX0oB6wuJqlQEgGG/dao+gR0Hw76kCrUiGwcXxBDw7rvB3Ta
	pqfXo0fERWSL5qLfrH9oCvNO4KbZnn4a4ZcVI6f9nK4GQbRupmd4dmoqZIHcVHmotJday8
	LXI27scflyz7ODSMqOAl9Iud3U37d8M=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-jXLq2hTTMEescWXY-jtUfg-1; Fri, 21 Nov 2025 12:12:40 -0500
X-MC-Unique: jXLq2hTTMEescWXY-jtUfg-1
X-Mimecast-MFC-AGG-ID: jXLq2hTTMEescWXY-jtUfg_1763745160
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-787e3b03cc2so33528267b3.1
        for <gfs2@lists.linux.dev>; Fri, 21 Nov 2025 09:12:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763745160; x=1764349960;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FRU2qLfbf/wNhvSHqqWH92nPqYewb6NVEbhZtNPwvUI=;
        b=R/HfJsnH3THVlzqzngy7qyxs0ow3cc51/KQkoXFJ0JplhXhuVjVT0ZAXOCh5tgUQwU
         B7lcl4gTSdoT/K7Ml8W/X9Gu6e/QgofqKBnnvbtzw833lINhzABST8xpFfNpV2TGw9U8
         jVzuOP8BwyrgclMuaAqrXgVXPhWkyv4cMNp7TT4/HL7FyVi8zbINcANWT2aztzUECrBu
         0guXGHV4CN3bQDPx39NFIR0u4LLLxhQKd9CJmnSagr318q8R1IZNnoBLsO3XYvYYghbm
         U4uoJoEsqQjLSSyEVilnmhJBORsWmi+RR8affc2tKSmeaMm9zwz0RQbCtvSVQSGs1FTp
         vYzw==
X-Forwarded-Encrypted: i=1; AJvYcCXuhlGa6AQRBE5ZysEHKC9ieYzBJlCH8PuZSXz6KZamI8pTNeXZjV9jRV48Y2x3XoSydi8x@lists.linux.dev
X-Gm-Message-State: AOJu0Yzzm5jfPrkZ/yhyW848Tc0mgZbJci2tvNbzEo3GRikIN/hlkPVU
	OK1kg9lzm/QY/ZHSMDO+Nq7v7gVtVEcCgJqVKP7GK3q/Yp7H07LdNDZToBMI0W1lsAbByW2ASJR
	pcz2d0zlTiUZYpdqflpNp4455haGQ5iLL7SFPheBHCkPjsm1yHJmyCXrldRDIctlUV212vC3TF8
	eaoi2kc4xF1zEPeBQhDvYTpHgHM/Bv2A==
X-Gm-Gg: ASbGncurIDGwYVj6ld3QpTgGdMUv/YSljT4vtl5g176fuPkNTm/0GlSj+wXCp7GdNkG
	uiraviPxSUMCxDT6EylY49CJFwNP6tpFh4vraePbEnGYvrpJb3QKwxnXIVcx4IvO3TSIpgxCtIM
	642S5i6xlUKy5kqJ+n4xa2WZb4f1tRv6F9Pyipk9pfA3hMqW0r19ZgtyVADvhoA5/n
X-Received: by 2002:a05:690c:4c09:b0:787:bf16:d489 with SMTP id 00721157ae682-78a8b5681a0mr24167077b3.62.1763745160079;
        Fri, 21 Nov 2025 09:12:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJMtLvkeHiv5tBcVk8Zunn6fcLBfbMFj2OlEQ7sDWssH1e01yWoO2IMY4KicgI4AI0qMGjQLfshccde2mHq/o=
X-Received: by 2002:a05:690c:4c09:b0:787:bf16:d489 with SMTP id
 00721157ae682-78a8b5681a0mr24166847b3.62.1763745159764; Fri, 21 Nov 2025
 09:12:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251121081748.1443507-1-zhangshida@kylinos.cn> <20251121081748.1443507-3-zhangshida@kylinos.cn>
In-Reply-To: <20251121081748.1443507-3-zhangshida@kylinos.cn>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Fri, 21 Nov 2025 18:12:28 +0100
X-Gm-Features: AWmQ_bnhlFe4bz2evbPrSI0Jb0EHnrWDpAVAemzJqi8jgCPnPPGI5CuseKDcbLY
Message-ID: <CAHc6FU7eL6Xuoc5dYjm9pYLr=akDH6ETow_yNPR0JpLGcz8QWw@mail.gmail.com>
Subject: Re: [PATCH 2/9] block: export bio_chain_and_submit
To: zhangshida <starzhangzsd@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	nvdimm@lists.linux.dev, virtualization@lists.linux.dev, 
	linux-nvme@lists.infradead.org, gfs2@lists.linux.dev, ntfs3@lists.linux.dev, 
	linux-xfs@vger.kernel.org, zhangshida@kylinos.cn
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bFW0LANJKf4-Jjsnq6bag68sO6lmNmSJrWiCn9OreKY_1763745160
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 21, 2025 at 9:27=E2=80=AFAM zhangshida <starzhangzsd@gmail.com>=
 wrote:
> From: Shida Zhang <zhangshida@kylinos.cn>
>
> Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
> ---
>  block/bio.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/block/bio.c b/block/bio.c
> index 55c2c1a0020..a6912aa8d69 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -363,6 +363,7 @@ struct bio *bio_chain_and_submit(struct bio *prev, st=
ruct bio *new)
>         }
>         return new;
>  }
> +EXPORT_SYMBOL_GPL(bio_chain_and_submit);
>
>  struct bio *blk_next_bio(struct bio *bio, struct block_device *bdev,
>                 unsigned int nr_pages, blk_opf_t opf, gfp_t gfp)
> --
> 2.34.1

Can this and the following patches please go in a separate patch
queue? It's got nothing to do with the bug.

Thanks,
Andreas

