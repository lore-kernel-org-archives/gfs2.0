Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4701432ABFA
	for <gfs2@lists.linux.dev>; Fri, 28 Nov 2025 12:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764334695; cv=none; b=i7z2eLzhETDcc5xzTEH9vjhyqvl527+mGgnL1BDZK8/gTr3rQs+nRI7g5r+/jWjiLLcjvgREowNfOuXyJIQ6f9E64nizq2IvxQlw4lhXzzLWGoaGDqbq0NhgoGAye1GiezHmRe2WO9V1aGQSXmmiqMgpFBow+Fp/jnf3z4+C320=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764334695; c=relaxed/simple;
	bh=MuFoqSXPuLC7mZdpb7+pS1mI6Pzog4fHqbrI6/r2Fik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F9LZwtNWik87LvB2kRW+EKK8yasB4naytRQgL7JdCbCd5Suj6yPJmXKK4/YbUWvkqcKYCAMRPaeEVFIgsEOloXv4oKCfaCeLqf+gSxCxU8Z27ezRuwkz/uy3ywKkVtH8rdt4k6/v47sl8eVXwTZZ9HUf7xBGKw6hX9yH3QqQ6KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XJWYU+6u; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XJWYU+6u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764334693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nNammxq+ggHJRHkPcyBw0qZgJjTAIfnPB/5V2CCXd5w=;
	b=XJWYU+6uD2TNlbVBS1FWSfq/vP8XVoyGeNQVA2MIuhO/W4T8uQBNHQgULFu1ufsrLZrJlY
	lFTx9xa+7BzUc6E0ZglUBSgSsLJ1mcbujDT0vhlLqJzytcH4lFSPmNaTFKhsd58bsoLE/y
	/U0BTvNl50SHvZA1e3jAbGdy75xr+Ms=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-Mf5t3hjNNcGTfK7l1noFqA-1; Fri, 28 Nov 2025 07:58:12 -0500
X-MC-Unique: Mf5t3hjNNcGTfK7l1noFqA-1
X-Mimecast-MFC-AGG-ID: Mf5t3hjNNcGTfK7l1noFqA_1764334691
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-78954aac3e7so25488237b3.0
        for <gfs2@lists.linux.dev>; Fri, 28 Nov 2025 04:58:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764334691; x=1764939491;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nNammxq+ggHJRHkPcyBw0qZgJjTAIfnPB/5V2CCXd5w=;
        b=HFnwT3H8+o2baAMbxUXiQC8EeNcv4uC0EwNtiCNAxd5SaqxmQD4eqt1WWf+xAyGxNb
         MPBraWdrWzyH1mHPtzLhjQuSX3DOp/EwttWdN6CucNbfRuW9+RHE5DYQUXjKxLnEMcbD
         FSTPDD8c7XQh7JpQrK7hTsIjmJdYEJde2FGtznEozubPnon9nwafGwRlxLhWFVRIsIaR
         wOPf9mli2zpwuxy5WO3zy4pWscOd8R/5O9VjfTuFraJdMSMqEy5RKGsRSPwaMKlvMmCL
         ZdsfY1OVbAcV0BNIFGJV4+Sd6uoqj6zg8J3m5/AsqbFYYVpdsV5pmsqUOxLCuPKn7bjb
         I8Zg==
X-Forwarded-Encrypted: i=1; AJvYcCVX9Faibvr8EzJa+RDuYLxXYAwytLxwL+1QPyOVFP76ysQU6iCDQfEnHsJ8F7YprNNQ/WMl@lists.linux.dev
X-Gm-Message-State: AOJu0YwcE+0RPbkNwf77dZjM9ruBrL/tTxRfTzAfIWxYknSFEmxyesbt
	2jsS7skRU8j+v32hWkWhf4GdOGuDUwIUbF6oCC8mSQao0Fur/cqcwj2HshklqVKKfzzIZJ1p4TG
	7Rqk7r+qavF5UI3jFPbzeGpqQ7fh4IMO0oGVmF+ytpE+Jk0Qq25iDJyZkExIjJ+Si9z9FEhfhZt
	Ah+wpAh+0V72fUnigLp7vbh1aaqoLYdg==
X-Gm-Gg: ASbGncvR4efx83ohiQnKIyTbCJ495uHqo7o3KkwzU3UyW5zXVhFASQJnzluqa5Wuf4H
	xfrI7MIfA1NIn1rIgeUplqoqg6OlZtyLLtX0KwSVeMFzI8PfKyuyLnAwPoAn3ZVWrhSD0Sh3FnI
	zZfgX6gnqGT0KYeMzWmYJRPzYg5x2B6g7M8OpwJfxtKiOBHajcqcU91+PdtaNVxd6L
X-Received: by 2002:a05:690c:4c12:b0:786:68da:26d6 with SMTP id 00721157ae682-78a8b47f539mr225392567b3.2.1764334691008;
        Fri, 28 Nov 2025 04:58:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE6o2vx3XDXGg+LlkIovRC1qPDpHivJwIyySPFZW+LOu2PT9QpULnJt3ZozP3PJjgQPuJtToIp2pCOkRf4ONwA=
X-Received: by 2002:a05:690c:4c12:b0:786:68da:26d6 with SMTP id
 00721157ae682-78a8b47f539mr225392307b3.2.1764334690627; Fri, 28 Nov 2025
 04:58:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251128083219.2332407-1-zhangshida@kylinos.cn> <20251128083219.2332407-5-zhangshida@kylinos.cn>
In-Reply-To: <20251128083219.2332407-5-zhangshida@kylinos.cn>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Fri, 28 Nov 2025 13:57:59 +0100
X-Gm-Features: AWmQ_bkpqINzOqnBww77x7L-xnpoIyN1fhsiEmRMn1madN6s7Ak0j6O_sI0bIl0
Message-ID: <CAHc6FU6dmK1udCgj9vMj1ew-4+bZOK7BA47kyEgONEwGg42veg@mail.gmail.com>
Subject: Re: [PATCH v2 04/12] block: prohibit calls to bio_chain_endio
To: zhangshida <starzhangzsd@gmail.com>
Cc: Johannes.Thumshirn@wdc.com, hch@infradead.org, gruenba@redhat.com, 
	ming.lei@redhat.com, siangkao@linux.alibaba.com, linux-block@vger.kernel.org, 
	linux-bcache@vger.kernel.org, nvdimm@lists.linux.dev, 
	virtualization@lists.linux.dev, linux-nvme@lists.infradead.org, 
	gfs2@lists.linux.dev, ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhangshida@kylinos.cn
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1jyRXrqeFGZepBFrtY1uz-VsIkXYmgcDi8huji9uaKU_1764334691
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 28, 2025 at 9:33=E2=80=AFAM zhangshida <starzhangzsd@gmail.com>=
 wrote:
> From: Shida Zhang <zhangshida@kylinos.cn>
>
> Now that all potential callers of bio_chain_endio have been
> eliminated, completely prohibit any future calls to this function.
>
> Suggested-by: Ming Lei <ming.lei@redhat.com>
> Suggested-by: Andreas Gruenbacher <agruenba@redhat.com>
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
> ---
>  block/bio.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/block/bio.c b/block/bio.c
> index aa43435c15f..2473a2c0d2f 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -323,8 +323,13 @@ static struct bio *__bio_chain_endio(struct bio *bio=
)
>         return parent;
>  }
>
> +/**
> + * This function should only be used as a flag and must never be called.
> + * If execution reaches here, it indicates a serious programming error.
> + */
>  static void bio_chain_endio(struct bio *bio)
>  {
> +       BUG_ON(1);

The below call is dead code and should be removed. With that, nothing
remains of the first patch in this queue ("block: fix incorrect logic
in bio_chain_endio") and that patch can be dropped.

>         bio_endio(bio);
>  }
>
> --
> 2.34.1
>

Thanks,
Andreas

