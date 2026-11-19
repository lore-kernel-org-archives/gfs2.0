Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795132056;
	b=u1gPEihpo350o6YRHWzcy+eVXbyFm9Rx57WKFjL6IXgkFfja0TKOHWr4qQKvvky38JxU
	 iDNlwIEteUW9z1TovV0dbGfD+MEX/h/EGzOv4sxf32Inydxe+HuGT7r2Dk+wjYpIi1+eT
	 Prm1SVYDqJsCMmviVnuKlbCQpUN6R+FizwDkv4Q0i1ovnBpCcdlI8d/uiGicKGPx3T3Rr
	 6fJu+s0Z+Vh3xOXcbvL4prOoMn1JJTj2EkeFz8MsMO+C4KO0/GgjTgSTmqPFbxJSmWl87
	 afk+kAZfcldkqAmNL/L/abPBxwXy+ytadViIgfQIvPQcEtjBzrNJ6w+OgozDjFqqwtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795132056;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Type:Content-Transfer-Encoding;
	bh=1JyuEfN6bVNV6U+s54IqPQn0FYwCqy1D2V8r61yksZw=;
	b=JaQyP/aN3FfK3cAr2P0iRk8Z3rWmO5N4J/r4evgNgTvPTMFRPd1GAURuB7+l+D/5gIiX
	 nwMabqG0eyO+b39FPchEzaTJHbMNYtfSQDRHNmk9NhXkt8QCncXu3OE10eQvsqlBoZQOA
	 b3JhWQQ7DInVhG3Eb2ox1ZpIwTSeuvpOynLCoES6vxpPqRpv0mV5nPmHacPFDgg4oHHkE
	 pmq33cHA6YL58GZOFQEDHFU62R0Yw4Sj4JoE5/L7EdtwgvjLCsDx7H8LJYDLatX/o0RiZ
	 u71Xrq0mlDXHIi9gRN6L8qzTH6g087NTu8szf6EUUOZG1rxt24zMrgKjwIznRwA9QBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bo57aErG;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A63606A32A
	for <gfs2@lists.linux.dev>; Thu, 19 Nov 2026 23:47:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65A63606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bo57aErG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795132054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1JyuEfN6bVNV6U+s54IqPQn0FYwCqy1D2V8r61yksZw=;
	b=bo57aErGm2l1gLaGMZsZu8vRZLPDQHKQR2BD3hIMTgXt2iDm3ujevfWR6sYRE0mVTSOWWB
	xFsZXxxnqCCCLRyU9zPXuw4Bcp9sjHgKYa2LUorpzxYvBdr/QnbdiX1y5cJ0zmyqcMeFzq
	2gtDw0NYDAl40Tmtp3nvUl5jGeupGgk=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-1ZvUv6VPOIOf5pjfvg3s0w-1; Thu, 19 Nov 2026 23:47:32 +0000
X-MC-Unique: 1ZvUv6VPOIOf5pjfvg3s0w-1
X-Mimecast-MFC-AGG-ID: 1ZvUv6VPOIOf5pjfvg3s0w_1795132052
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-8b4bb8bf464so5427277b3.2
        for <gfs2@lists.linux.dev>; Thu, 19 Nov 2026 15:47:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795132052; x=1795736852;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1JyuEfN6bVNV6U+s54IqPQn0FYwCqy1D2V8r61yksZw=;
        b=YJUJt7p0HchktukNrJ//4U0VwK/HtrPBR222YN7yL9VGqVhUCLsEoNonaS7llyddID
         rV30rv/Oqw3WaJ1ocxR3Ie5bggr1m2lg7CdcZqSg+O98NP8/AZLNPGv13/XH8OwW2yjN
         AQSmssaus0Mddi+ahaezorkevmX9xY6Gk7Ni7ldTyeTfUXhTZDa6TOAMiSgql4u69/h6
         NIZowLd0/2KYAN2y1Az9FlQYKIJ5dZqh6Us649VRXpBpqVm29uwy4C9E5Y2fC0f6zzL9
         Pak+VbEtRiy3vIgjh14NDA15exfGxHuyMEabtNb3why8NvZcQj6P5u7JPFx1LWuPAQZJ
         tDvQ==
X-Gm-Message-State: APuU4Z86c8OH+KNRkVAz4aBDlrts4xj4mr8XOFXI3XC3eAYzeM7Q5kXd
	GSKkO7NItXk0hMJ/QYzXlXLU3FpsfOvtnJNbGhtOuiXl924WNhAZhmdX6x6tB4pDtbOEJmC5MyF
	D1QVvvG8a/DAV9fvd3XkI/P/yM6fRJXiBAeRayrD39CXLJ2Em6GxqDvXRvlSXzyYKabVdLz899S
	Fryrf7YjFYdI514KrGH3RwZv4ZuI9ZRQ==
X-Gm-Gg: AZFdTZfAGaM3mDu/APXH7uglx0Xc79ajQW9AYvWjd5Jhbuh3vHJP0qV4JPvTT1EscRP
	JQJQHpAt55di2F9tsRgg9VaqEdYzkUfkw7CHzvVJ+uk35bQoVU556nymOI1zNqkz4QhtLriMS1x
	ra2OG059p5cCxusi0jIvYEd39UhGdiZyD2dXf4rIn9q9YdjwFbR42WEiqljNC5sfrLf45pw3zcL
	gVPOIs6Vc1nnHVRS9unUuY/RlU4gdAsBIgmFdTY7PX4OQ==
X-Received: by 2002:a05:690e:4089:b0:679:a03c:3cef with SMTP id 956f58d0204a3-67df4462202mr401005d50.102.1795132051645;
        Thu, 19 Nov 2026 15:47:31 -0800 (PST)
X-Received: by 2002:a05:690e:4089:b0:679:a03c:3cef with SMTP id
 956f58d0204a3-67df4462202mr400981d50.102.1795132051061; Thu, 19 Nov 2026
 15:47:31 -0800 (PST)
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Post: <mailto:gfs2@lists.linux.dev>
List-Help: <mailto:gfs2+help@lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
List-Owner: <mailto:gfs2+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261117-gfs2-log-folio-v1-0-35db3db42e35@columbia.edu>
In-Reply-To: <20261117-gfs2-log-folio-v1-0-35db3db42e35@columbia.edu>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Fri, 20 Nov 2026 00:47:19 +0100
X-Gm-Features: AclHuK9gULsTk6PGMwqspw6Wk6A71f7dxi9qUV73alrF3gpANL5X2_CboyEiDG0
Message-ID: <CAHc6FU43KTAm-VvYXrR19BE1Q--2aHL6UALG9cj1pgdeqB_tBw@mail.gmail.com>
Subject: Re: [PATCH 0/3] gfs2: stop using struct page in the log code
To: Tal Zussman <tz2294@columbia.edu>
Cc: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Xd5oo-LuHerSaafFe2eguMmEqu2VnBN7h8da7ghzqrI_1795132052
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tal,

On Tue, Nov 17, 2026 at 8:46=E2=80=AFAM Tal Zussman <tz2294@columbia.edu> w=
rote:
> This series gets rid of the remaining struct page usage in the gfs2 log
> code.
>
> The log headers, descriptors, revoke blocks, and escaped block copies
> are allocated as pages from a mempool, and they end up in the same bios
> as the page cache buffers being journaled. The completion handler then
> calls page_folio() on every segment to figure out which kind it is
> looking at. That won't work once memdescs land and those pool pages are
> no longer folios.
>
> Patch 1 moves these blocks over to a kmalloc mempool, with their own
> bios and completion handler. As a result each descriptor block is now
> submitted as its own bio, so patch 2 adds a plug around the log flush to
> let the block layer merge them back together. Patch 3 cleans up the
> leftover page references in the log code.
>
> Tested with fio 4K write+fsync on gfs2 over virtio-blk and null_blk.
> Without an I/O scheduler, patch 1 adds one write request per log flush
> (196.7k to 229.5k for 32k fsyncs) and ~10 us to the p99.9 fsync latency
> on null_blk (41 us to 51 us); the plug in patch 2 merges them and
> restores both performance numbers to the baseline. With mq-deadline
> nothing changes.

thank you for these patches. Could you please rerun that test with a
block size smaller than the page size?

Thanks,
Andreas

> ---
> Tal Zussman (3):
>       gfs2: stop using pages for log buffers
>       gfs2: plug the log writes of a flush
>       gfs2: remove the remaining page references in the log code
>
>  fs/gfs2/bmap.h |   1 -
>  fs/gfs2/log.c  |  19 ++---
>  fs/gfs2/lops.c | 221 +++++++++++++++++++++++++++++++++++----------------=
------
>  fs/gfs2/lops.h |   6 +-
>  fs/gfs2/main.c |   8 +--
>  fs/gfs2/util.c |   2 +-
>  fs/gfs2/util.h |   2 +-
>  7 files changed, 154 insertions(+), 105 deletions(-)
> ---
> base-commit: e3280ea8b73964efb447f396fb09401a31373136
> change-id: 20261014-gfs2-log-folio-274b84f5cc07
>
> Best regards,
> --
> Tal Zussman <tz2294@columbia.edu>

