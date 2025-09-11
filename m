Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9D23469E4
	for <gfs2@lists.linux.dev>; Thu, 11 Sep 2025 15:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757603406; cv=none; b=l3CUOMFY1UMl1O1+VfiFy8lrCUHD67N6gWM3bj9/jF6lHT3KgKW6v3OIwo8SRUzJoy0MnkSwNo7yGQ0G/CPW1+xfJbCjqh4hpJPwOBbxip4At//hfCpkRq2sgzzqipIEUQ/9JwU764SdQShpUUS5NCAEazFyZr7eK/E1iiSnSGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757603406; c=relaxed/simple;
	bh=N4W+8pquFoP92G+o8lJbiWfNxJJ0800TLeK2Y3vt3LQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YgZFlTMDsS180W9rCoo+iWI/KYPadMhzcIQtM5faLf1/JH2JUNUseyZn1RCcco9BOXYTZbffIyPW3qumOy+TJSlJzK03TMftsr2rqTgQ3wLPy2GRzimcKhICmxs+UHFFsITS8pnXiNG7Xbl1jGCZL2suXXw25h1/6g0rNkPhivk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZaLUKen1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZaLUKen1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757603398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zFzVYLmGxzy94wwH+ayr9v5omMBRq3s2fenGntFifFo=;
	b=ZaLUKen1PdwMv0KDxddjjShRwd13m3zRshFwUVrcXUY6Yhz4QaDq4IejMwARsNS3I5QmeG
	a3CoHX+npVBQ7XSQUm4VB6YHKj6pSo1drPoZx5XdMN3gvgqBM7LEWuHaBjGgsqd0adenyr
	rUtrSXxzkvAXpVTpEl92gDWZeOhR+94=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-lU3tlSK8N821C6Em9GISXQ-1; Thu, 11 Sep 2025 11:09:51 -0400
X-MC-Unique: lU3tlSK8N821C6Em9GISXQ-1
X-Mimecast-MFC-AGG-ID: lU3tlSK8N821C6Em9GISXQ_1757603383
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3e424a186fcso511035f8f.0
        for <gfs2@lists.linux.dev>; Thu, 11 Sep 2025 08:09:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757603383; x=1758208183;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zFzVYLmGxzy94wwH+ayr9v5omMBRq3s2fenGntFifFo=;
        b=T0SXC6V9uDBxDglO+S7ylseA5Jk5l6xFP7VAI+SuqvmId6MT27IBp6oqNXIWNfvEt9
         yvnzjkpJXdnbaO5Z/QzXKOjwDmaLHdcMWttfR6xNqAHXtTbnE6S6gCQumHNVJ2a1yKrq
         MO95zPfnrnpW0X9svri8VNB5WJQx1A+h4Clj3AVr6C5zuIQQyoAbod6M+g60JcuuYVj/
         mqULaXuHzJCxVF+dh5if4y/3kJTMF6aTUqLtlR3zsLogaJkTHApaRX3ouvyGPOvF0/kl
         AMNxHYQGO35XKj5g1y+cTr6W0U+cLITSIBN0DRZpEV7KHD0zYNVbeIdN94JKjkkTfWcN
         MaNg==
X-Forwarded-Encrypted: i=1; AJvYcCUczkWvsQdZiPQ+6tLi7R9DEOWzJHZvB9E5ogeZZjKNU8CeMqYiZsIRHkFIbTirw2GXBn5r@lists.linux.dev
X-Gm-Message-State: AOJu0YwXD4Or4dB2G/pJ8fAb9Oe/A6LEdiIz4qpDNA3tyS375i+ETBNi
	G1SvcOnBi2wUd5C6BajzjpOjj6HqCSFlpUNA5ACk1FtYbddQoDyiT6gXxoSfj5lfiAAJXXPOyVF
	x5DCLiJeV/KvjLvbi5PxJeO5rQ7/2zhs+5pyosLpqKI9NpgKZWU9TZSgI8H1ltEA=
X-Gm-Gg: ASbGnctaORSSUCh1p8HH3634v4+oigwu54uFDwSkGV8hFA1tvSGyp+Fa4cV6GvhLke5
	X9iiLiNnde0l/rLwiJ8+d5RO49oNtZzpjATckUbOrBCurgDosbNu80KRuxWOgYyrlTlZU72edn0
	CnFw599SxAyKKMCI7bWsLcwczysuhUoC/KZJIirx6FJgFn7IEw7/IncH4q2qjjq2VyomW0Jn+ny
	8QvUlBtH3HOxc9X5CoVtFe8ltuIDd2Pm9LvqMp3eeSx2ruZPtuRxfdbwpq7DfIzE5a1wuZpYHUc
	pu5ut3RX1oXTEZVDbrqJYmEl7foNJIrys0przo4hw6xjaQyjS8uzEHww9fQtR8sPnKtCCOz9vlo
	+W/qlnYQ31+JntrskmzNQb8Hn
X-Received: by 2002:a05:6000:3113:b0:3de:c4dd:9e58 with SMTP id ffacd0b85a97d-3e643ff86f2mr13999343f8f.50.1757603383072;
        Thu, 11 Sep 2025 08:09:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESs8cItJdShISssk8/C8MKCstSe3Dj3sBddZJnEmweN0BSgor2szU/wYKkf+NBghlacDjfaA==
X-Received: by 2002:a05:6000:3113:b0:3de:c4dd:9e58 with SMTP id ffacd0b85a97d-3e643ff86f2mr13999322f8f.50.1757603382602;
        Thu, 11 Sep 2025 08:09:42 -0700 (PDT)
Received: from [192.168.1.167] (cpc76484-cwma10-2-0-cust967.7-3.cable.virginm.net. [82.31.203.200])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e037c4490sm26733825e9.19.2025.09.11.08.09.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 08:09:42 -0700 (PDT)
Message-ID: <0b03f419-eb0a-4be3-b8b0-b95d0f2ebcab@redhat.com>
Date: Thu, 11 Sep 2025 16:09:41 +0100
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/20] gfs2 patches on for-next
To: Andreas Gruenbacher <agruenba@redhat.com>, gfs2@lists.linux.dev
References: <20250911135726.657575-1-agruenba@redhat.com>
From: Andrew Price <anprice@redhat.com>
In-Reply-To: <20250911135726.657575-1-agruenba@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VuEpMyTFnNNtgGn1tGv2yePUYJ372OCUimEQXID1dSM_1757603383
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/09/2025 14:57, Andreas Gruenbacher wrote:
> Hello,
> 
> the following patches have accumulated on for-next and will be part of
> the next pull request.  (Colin Ian King's patch has gone through the
> list already.)  Please review.

Looks good to me.

For the series (optional):

Reviewed-by: Andrew Price <anprice@redhat.com>

Andy

> Andreas Gruenbacher (19):
>   gfs2: Remove unused GIF_FREE_VFS_INODE flag
>   gfs2: Remove unused sd_withdraw_wait field
>   gfs2: do_xmote cleanup
>   gfs2: Simplify refcounting in do_xmote
>   gfs2: Partially revert "gfs2: do_xmote fixes"
>   gfs2: Turn gfs2_withdraw into a void function
>   gfs2: Sanitize gfs2_meta_check, gfs2_metatype_check, gfs2_io_error
>   gfs2: Do not use atomic operations unnecessarily
>   gfs2: Further sanitize lock_dlm.c
>   gfs2: Remove DLM_LKF_ALTCW / DLM_LKF_ALTPR code
>   gfs2: Fix LM_FLAG_TRY* logic in add_to_queue
>   gfs2: Remove duplicate check in do_xmote
>   gfs2: Fix GLF_INVALIDATE_IN_PROGRESS flag clearing in do_xmote
>   gfs2: Get rid of GLF_INVALIDATE_IN_PROGRESS
>   gfs2: Simplify do_promote
>   gfs2: run_queue cleanup
>   gfs2: Minor run_queue fixes
>   gfs2: Add proper lockspace locking
>   gfs2: Fix unlikely race in gdlm_put_lock
> 
> Colin Ian King (1):
>   gfs2: Remove space before newline
> 
>  fs/gfs2/file.c       |  23 ++++--
>  fs/gfs2/glock.c      | 185 ++++++++++++++++++++-----------------------
>  fs/gfs2/glock.h      |   4 +
>  fs/gfs2/incore.h     |   5 +-
>  fs/gfs2/lock_dlm.c   | 100 +++++++++++++----------
>  fs/gfs2/trace_gfs2.h |   1 -
>  fs/gfs2/util.c       |  38 +++------
>  fs/gfs2/util.h       |  36 +++++----
>  8 files changed, 199 insertions(+), 193 deletions(-)
> 

