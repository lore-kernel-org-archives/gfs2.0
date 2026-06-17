Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D63D39F162
	for <gfs2@lists.linux.dev>; Wed, 17 Jun 2026 10:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781693523; cv=none; b=kpKGZagEa62qq788dLgZmdjUvNnQ7dhrBXG/AoRABwoec1O6jFUG3ujL8lVgp0HzspCyVKlwowbdzxIl6F+M36RgDePCIoLwA6dXz+vkzOfwNwaSseShoNbnkX1ar7keCRHsRK4af4BPYRuzgubg5zQ4u1E6GpoB1XY9uhUNW3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781693523; c=relaxed/simple;
	bh=P61yXoFT55LCqdtv8dojNfoxbvuQPGVSIrZJbPV4rVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=scjA62qpd8YE00XXnc0HGgAc6eDoz1gjg5cudxM+JlI+p7N1JUSL+PLPKiquGXCKUcrDxC+5/1OTYVgXlfCYtlypm8yUQuQq5ggz0vYynpxcGGMqOOQCBi/ckSkrKlw3KNeXHXFBnPqBmhhUg2qunFzhuqq2FeV69PbrM2XW/qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HmyGDbQ4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HmyGDbQ4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781693521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bkr4SAhPMDT9px8dL8O1ncJ6XM9d7F5rRlhMTmcXksE=;
	b=HmyGDbQ4YMInXlje5Vcmf7a7TAlFZmkenqMEt+Szl0652IXlCPKzI1dIWQ3dSwo2MKmYhB
	G1SaC2/JZyhaq+uXsSgw1YgJXGHUthoo2ZyvuXwMBpukTPxeHZGSWQFnx1+w7IX5i0rSon
	EUz8oHqgnLKpwVY8i55YlyDAEopBZ34=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-ydlx8TnAOQiFEf4qiCrtmA-1; Wed, 17 Jun 2026 06:51:57 -0400
X-MC-Unique: ydlx8TnAOQiFEf4qiCrtmA-1
X-Mimecast-MFC-AGG-ID: ydlx8TnAOQiFEf4qiCrtmA_1781693517
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4629f312a67so470772f8f.2
        for <gfs2@lists.linux.dev>; Wed, 17 Jun 2026 03:51:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781693516; x=1782298316;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bkr4SAhPMDT9px8dL8O1ncJ6XM9d7F5rRlhMTmcXksE=;
        b=lMvj8zVBEhYbGZ5uYfTS9e+B0I8vgTBEspnlbs8wiUcooWVg+hbB4Q3ux4pTAKM4Z9
         5eR+8dkTp/PRcGJqacfUdEgJUyRfKIvrns2WKIJcGwkxHFdxFoLE1NTIogHz9dnzO3Ig
         L1aQhnfo34Os4k9KmVE4tpCBCQuhCRiN8Y9zBXJCmFHNRHAJ3S/BkOZAtl016I72CdO+
         BeE2zYfDrcAKpeHPE1T8NzSbikxuvAQHHf7ye5RrjkImT6Gl9Om+J5Xyxei8ZB4caIKU
         8C4bSINZj/o5vNC+mPlzgEv/XL8+m0JDxR3KUlOwd7a2fJhdmuUDr/8Ez837ucJztgUZ
         LgBA==
X-Gm-Message-State: AOJu0Yx0qyQbAqcD3RM85fZcdX9U09CPs9+fJBG60HeINd2SK4XlJXsp
	qXOVVuKlNitPrEUg9nItz3ADnVRMlib1fwRrF4qVYAL3YBVz/ZFbd4Et/xMcrhvGQZMI5Se/3uS
	vN7Jui1B1O+eHZ3mNMD6VxgqVNvRRDowC7lTnGNTbcHNjDQFoQyDhbxQ=
X-Gm-Gg: AfdE7cktUEA/fMYWITF94VHFjVt/1we+4mzf8HsAaDHr9mLdXmzJVqU1yWSpek8Rp99
	z12S8dbK/Bt4LLFJiSlR7fEX5A9TJrAOTD3SHaEJIrJgGFTh8kXkz3FXck7WrHswt6K4qfmiAxi
	tKxeV6gCBftnmlf9YCGbZ4NluZkXn1RFilO9U0JaxKs548yHzx3u2LX8Gon5jQkl0IRj/mZ9dyg
	zhhI0rtwPefCevjunUSFqu06dReq2OehJn1BIGUIjMdooWC+Cnw70TjMZdPDrkk0laPncfROa+t
	l3Aluii1uSZABY1/UeXpmIntV4MprWmjnkJxTprqnaKxl+HCMlENRplJfffS0Dj0p2Ia+RhxWf9
	UnoJrtSLepGm1e1PNZCUycd+j3yTsYnwzw8317dYWF/ArCslYBEM2d9koPFHBJo5xTJ2rFm0=
X-Received: by 2002:a05:6000:288b:b0:45e:6518:21ad with SMTP id ffacd0b85a97d-4623521ab30mr5946608f8f.3.1781693516640;
        Wed, 17 Jun 2026 03:51:56 -0700 (PDT)
X-Received: by 2002:a05:6000:288b:b0:45e:6518:21ad with SMTP id ffacd0b85a97d-4623521ab30mr5946527f8f.3.1781693516034;
        Wed, 17 Jun 2026 03:51:56 -0700 (PDT)
Received: from [192.168.1.167] (cpc76484-cwma10-2-0-cust967.7-3.cable.virginm.net. [82.31.203.200])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4620b1083e3sm8660654f8f.20.2026.06.17.03.51.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 03:51:55 -0700 (PDT)
Message-ID: <d8d1d7fc-4028-4913-8025-cb4c39ab437c@redhat.com>
Date: Wed, 17 Jun 2026 11:51:54 +0100
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gfs2: Fix use-after-free in gfs2_remove_from_journal()
To: Hongling Zeng <zenghongling@kylinos.cn>, agruenba@redhat.com,
 swhiteho@redhat.com, gregkh@linuxfoundation.org
Cc: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, zhongling0719@126.com
References: <20260617090143.735219-1-zenghongling@kylinos.cn>
From: Andrew Price <anprice@redhat.com>
In-Reply-To: <20260617090143.735219-1-zenghongling@kylinos.cn>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Zv9ubPrtDkfSZcFk45T4v0Tjtc9o_6KrP7qHZ7K7KtM_1781693517
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/06/2026 10:01, Hongling Zeng wrote:
> The function calls brelse(bh) but then continues to access
> the buffer head through bh->b_private, clear_buffer_dirty(),
> and clear_buffer_uptodate().
> 
> After brelse() decreases the reference count, the buffer head
> may be freed, making the subsequent accesses use-after-free.

When buffers are pinned their refcount is incremented and the brelse() here is only called for pinned buffers so I'm not convinced that there's a bug.

Callers of gfs2_remove_from_journal() also use the bh afterwards so if there was a use-after-free this patch wouldn't fix it.

Did you see a use-after-free in testing?

Andy


> Fix by moving the brelse(bh) call to the end of the function,
> after all accesses to bh have been completed.
> 
> Fixes: e93b100931a4 ("GFS2: Fix slab memory leak in gfs2_bufdata")
> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
> ---
>  fs/gfs2/log.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/gfs2/log.c b/fs/gfs2/log.c
> index 78bba8cc10b8..a92c84146de9 100644
> --- a/fs/gfs2/log.c
> +++ b/fs/gfs2/log.c
> @@ -1038,7 +1038,6 @@ void gfs2_remove_from_journal(struct buffer_head *bh, int meta)
>  			set_bit(TR_TOUCHED, &tr->tr_flags);
>  		}
>  		was_pinned = 1;
> -		brelse(bh);
>  	}
>  	if (bd) {
>  		if (bd->bd_tr) {
> @@ -1056,6 +1055,8 @@ void gfs2_remove_from_journal(struct buffer_head *bh, int meta)
>  	}
>  	clear_buffer_dirty(bh);
>  	clear_buffer_uptodate(bh);
> +	if (was_pinned)
> +		brelse(bh);
>  }
>  
>  /**

