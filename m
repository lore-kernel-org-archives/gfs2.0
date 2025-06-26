Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA202EE289
	for <gfs2@lists.linux.dev>; Thu, 26 Jun 2025 15:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750950002; cv=none; b=QCIAIME4RXtO19y3MHxosEF/Zv5uvP0wSfw1r8W4epMge9QobNSp7KLWwJmeLBtVEOmBsMMrzpvQ9Jox0bk3ekBj8LspnmEF2iiCOfP86rFmvNVbO3SZARysLTS3iCyH/HzaLEPqK3UScRheN6McBiOEtZIsn2YurC56HGtwiqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750950002; c=relaxed/simple;
	bh=Rd9MfG2wYsIuZWNKGti3XIqY5TapE2MeUv/fqmZbSYY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dsk0yfwqHnERoajT+YUKaeLYJa3MwvqkuXXsha2awdeZU9eCSSffcY4YB/7QJMAA2s63V9U6ADfH57TKAPWqEZcGTxHrO3N2HKs9M8kEh7ueulmzmF0ctC+tMCDIg4NbCBw+4/3W1WuRmBSPFDSJH2xXHS1ze91tcN2Pq2RD528=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dMb1yLMn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dMb1yLMn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750949999;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=66pjXQOOoZM9w58+iyhucNXBgUjwx6ikLbfG097QrC4=;
	b=dMb1yLMncHwG5X1rxETKMdqR9IqZcwxwctxC7PH8FyR90q/O1hbZANo0E+SkaK3rYHpzHj
	nWfSu79V661MN6F14LmaKQG4FLUD7WKR8b4d0OKGRXoLQ/q5tw8NaNMUw2XRu87Cr1LEjS
	EY2F9ufBG3MqXfNyAwnGKaGrxcmxnJw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-5h5oSd9bNpe50Kz8v0dQMQ-1; Thu, 26 Jun 2025 10:59:58 -0400
X-MC-Unique: 5h5oSd9bNpe50Kz8v0dQMQ-1
X-Mimecast-MFC-AGG-ID: 5h5oSd9bNpe50Kz8v0dQMQ_1750949997
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4532514dee8so8214065e9.0
        for <gfs2@lists.linux.dev>; Thu, 26 Jun 2025 07:59:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750949996; x=1751554796;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=66pjXQOOoZM9w58+iyhucNXBgUjwx6ikLbfG097QrC4=;
        b=HRa19k1soO+iobOyzItfZnFvl8xylJ4D8XAI6amiAO9/JtAgwx8PWJhOeoXsHcADzA
         iJbSnQigaH3jyBQ2lw/VWBMVp5C6QvsBL8b1fMWbs2lSw4EJGblAJs6B6gAZlak3/bg5
         P41YmIcCS5+a/UJYcwuPvzbQEf5Fu6N/pK8ePEl9EFmIqetAYdM8SaRjIyK2vYmfEveY
         CKKsvZaFx0v3/D9HFZzSsQloZPtGF+oJ0UdhfZ9Jzkedi9yvfLDSJ2yfXtuJeiVo8PVs
         uivDogTyJafQ2n84Hj2A7ET3WvEpJI1Ap/Qhre1H/KZeHTIz/KsGAGVlnbHfjFfmOh4w
         JIgg==
X-Forwarded-Encrypted: i=1; AJvYcCUcH7KrS/3GfVl1fYSWtyNhxIlMvA9pgyFQffvns+7thyaybGSARnWXM3JqY9IGlj1hqG6f@lists.linux.dev
X-Gm-Message-State: AOJu0YyiLwI5/mLipUBTyO7Dgz1TN9vpb2SV0/AulYtrcY34mcJ7TKLp
	AAuwiLWdHZDp4AimJQ3Qp4rt5vXcnTickSXTxy29VCJu/+oEQIsWkShWNGVVOWe06zBDcgRxjpj
	eRtyUGl33Y/OojyYKcEBr1swsw+kS0R1i5ZmnHIv5jkxUYBzV5iPBhIE=
X-Gm-Gg: ASbGncujiKXaFnhr7JvG7WfI5xHR4ekYv4H6p7NSwseXBNjWV1xKa9PuilP5hNctYHZ
	yorvKw9mYxanGyDP78gSMdj9ke1xulofLHosrDBL4zxi7DgLKjljMX6jQRLQCHP+vgzWD4ufBCJ
	CfhIUPL/ryMFC8DCUcXl11JeSXxE2tVzf5hdgXqeuHa2pg4jbx4046b1S08//GP/qaOjsCe7PMa
	NJ3g6CD98R6MhDADBC1FlaQ+/wG5yj1itrByMgZUSi7e/7dHB6tirM6b1juEvGl4wHuPkCfIA8S
	G+nR15FKKAcHRT0WRvgHHaYjWS6LRgapyrZJzMUhtykcqYapQL5lcpYAypDZT2vNCmKEQ04UgM2
	Yf59cFQ==
X-Received: by 2002:a05:600c:3e86:b0:43c:ed61:2c26 with SMTP id 5b1f17b1804b1-4538ea96e0dmr203695e9.17.1750949996525;
        Thu, 26 Jun 2025 07:59:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZrdudCYO4vZ84TfNYGyCpPy5SlZtMrr64Qy5kZRI78irHoQkU46UWTcPsRtqX+quq7nWPLg==
X-Received: by 2002:a05:600c:3e86:b0:43c:ed61:2c26 with SMTP id 5b1f17b1804b1-4538ea96e0dmr203335e9.17.1750949996055;
        Thu, 26 Jun 2025 07:59:56 -0700 (PDT)
Received: from [192.168.1.167] (cpc76484-cwma10-2-0-cust967.7-3.cable.virginm.net. [82.31.203.200])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a88c7fab6esm137284f8f.31.2025.06.26.07.59.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jun 2025 07:59:55 -0700 (PDT)
Message-ID: <07ef2fd5-d4cb-4fc3-8917-4bd6f06501d0@redhat.com>
Date: Thu, 26 Jun 2025 15:59:54 +0100
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: refactor the iomap writeback code v2
To: Christoph Hellwig <hch@lst.de>
Cc: linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev,
 Andreas Gruenbacher <agruenba@redhat.com>
References: <20250617105514.3393938-1-hch@lst.de>
From: Andrew Price <anprice@redhat.com>
In-Reply-To: <20250617105514.3393938-1-hch@lst.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 73gMc6DBOAOY96Nqg59cSRfos72QJUP-dpg5tvp8qKU_1750949997
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/06/2025 11:54, Christoph Hellwig wrote:
> Hi all,
> 
> this is an alternative approach to the writeback part of the
> "fuse: use iomap for buffered writes + writeback" series from Joanne.
> It doesn't try to make the code build without CONFIG_BLOCK yet.
> 
> The big difference compared to Joanne's version is that I hope the
> split between the generic and ioend/bio based writeback code is a bit
> cleaner here.  We have two methods that define the split between the
> generic writeback code, and the implemementation of it, and all knowledge
> of ioends and bios now sits below that layer.
> 
> This version passes basic testing on xfs, and gets as far as mainline
> for gfs2 (crashes in generic/361).

I can't get generic/361 to crash per se, but it does fail as it detects the new warning about the missing ->migrate_folio for the gfs2_{rgrp,meta}_aops, which I'm looking at now.

If you have different results to this, please let me know more about the crash and your test environment.

Thanks,
Andy

> 
> Changes since v1:
>   - fix iomap reuse in block/zonefs/gfs2
>   - catch too large return value from ->writeback_range
>   - mention the correct file name in a commit log
>   - add patches for folio laundering
>   - add patches for read/modify write in the generic write helpers
> 
> Diffstat:
>   Documentation/filesystems/iomap/design.rst     |    3
>   Documentation/filesystems/iomap/operations.rst |   51 --
>   block/fops.c                                   |   37 +-
>   fs/gfs2/aops.c                                 |    8
>   fs/gfs2/bmap.c                                 |   48 +-
>   fs/gfs2/bmap.h                                 |    1
>   fs/gfs2/file.c                                 |    3
>   fs/iomap/buffered-io.c                         |  438 ++++++-------------------
>   fs/iomap/internal.h                            |    1
>   fs/iomap/ioend.c                               |  220 ++++++++++++
>   fs/iomap/trace.h                               |    2
>   fs/xfs/xfs_aops.c                              |  238 +++++++------
>   fs/xfs/xfs_file.c                              |    6
>   fs/xfs/xfs_iomap.c                             |   12
>   fs/xfs/xfs_iomap.h                             |    1
>   fs/xfs/xfs_reflink.c                           |    3
>   fs/zonefs/file.c                               |   40 +-
>   include/linux/iomap.h                          |   81 ++--
>   18 files changed, 630 insertions(+), 563 deletions(-)
> 

