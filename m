Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7279247295
	for <gfs2@lists.linux.dev>; Thu, 29 May 2025 09:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748512789; cv=none; b=BHxDHN4pwLpV5kJpnGzDU0z1tPFebTc7hfjlwu2G3BoMaF7xagiaqrzGXuin+hhNz20aFXZjwzasTGp1PIzTiulFEPZJha3xpAQArqpacM5Z66Ksoy+uNoFJnPIp2uAwaZJsQTcsa+dyw5OM7EhGydS7lqEiCnaIaGkd9L0ZGEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748512789; c=relaxed/simple;
	bh=YW/KEl+pedxhjjK/AqA6LiVTpIGpSSif3YDPbz6HDqE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J1WDmAoYT5M8A88wJj99JcSqT5MEEYGfDMm4l4+/AaxWdxNtT8yVw75XLX01dDgQFj/eDH2YPX46HJ6AW2stigXL26noGlMsPii5b42nU+zoRouwkcZ77w5Gli7zjvXuMkq77XD8txqVjvIJ++y90kNxfLaUhi3Y0qcfHbVaqY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h/d59svy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h/d59svy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748512785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BXk4rpcvWCtNktUyjSSVTfny1b3bNkwpaGwF0foHQGg=;
	b=h/d59svyQloGZ79UIau1FLVJhUytYqJYKE/2VjyJM9oAdFEsnLFPaMX262sefi/z4Vgzai
	8Ro2aBbBdxjc3hGFQcRzZSlnNYyjkecBEonJhRkguxm/J82dr1Ys2wfshca5G84Qu615ek
	hjSbpF/Yj7QsQ8qoVJjllrck9GM2D8w=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-VLemAohYN3Oa-MpvJjNVlw-1; Thu, 29 May 2025 05:59:42 -0400
X-MC-Unique: VLemAohYN3Oa-MpvJjNVlw-1
X-Mimecast-MFC-AGG-ID: VLemAohYN3Oa-MpvJjNVlw_1748512781
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c92425a8b1so114225085a.1
        for <gfs2@lists.linux.dev>; Thu, 29 May 2025 02:59:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748512781; x=1749117581;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BXk4rpcvWCtNktUyjSSVTfny1b3bNkwpaGwF0foHQGg=;
        b=R4Gn4yPNPtWhrWo1SGYJGQRxpnJWpETjlqmWYL7JzNKnSH5OI1uqm+TqFc0yJl0VYa
         NfPBlYHGWAa0vBpKiZSxYc5eAiPSqhPA2tAGZ8H2Qdl1chG5Z+jEMTLWVTAVMwChQpXC
         nt+PTAfNzg6tOAUIF8ZjN88lCkAi9uYhBP9xFCPyZ4+tqUHBMKhjeNxj7RbJQQGpmdBh
         0J8wbEpyXXLwS4l5vOMr/7juofL1Vw94/FVJgUiMmg6s890piAKa+8sBUIvpXgtQ50Rk
         n50HpBZ1US1NSk6/ieWdsGIKHEVSLhKICeG+1UVxgi+r5cBkOCqVft/aRzs4er6T+sw1
         3tfg==
X-Gm-Message-State: AOJu0YxtW4KiIhkPD+dHWOd98QpR2hhHjDjrDtXDc7aM0Pzm1cUCs0gS
	u3PYarx2AZginuxKRFpYpqc1qS/JEwEByJxIWNaxjv1xBL3TlJxQwz0j4McNn36mfXaR8Kf8bPF
	UoUBsjUpsUrad82L4TpP/2jf5xIWNdiKCvWYKEFLcTI7i9BBD+xGUfak=
X-Gm-Gg: ASbGnctgOrH6sP0T3eGPDaQobifbi94JKYrb2YJUNTXqXVl/zfUNvCLDImODlVijmIi
	ecEWgs3fLA26B+x22dGnstlvvt5ibZnY9p6Ao4X8vzQywiNnSTNi3MXHS2wqoBpQOAhTc80cXIj
	SKNYSjC/BFISvPWvnp+aZDKw3rVhS3WnQ4KBBys2HexaE7ujdQrctIzLrXk8HwkPPkmCctTDsxu
	jn7lMH5Qp1CYqkM8Dnv6oPaGLAl+aPBThnX6w18gzNAmyIQGMz6Rjp5UtWrGJ5boRLbYY6UO6ZJ
	TUr+qSi8pB8a1iKLfJLOFnbbVSSAK7eSXSbTGEiwhHCcq3/R/AhEARQvcg6ghDvdUBCBE6E=
X-Received: by 2002:a05:620a:2956:b0:7ce:c3e5:6ec0 with SMTP id af79cd13be357-7d0987ba15amr405876485a.20.1748512781617;
        Thu, 29 May 2025 02:59:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdDrXf+adwJ4W+kiG5NSludBSVorewr+9GslpUloBqIIsRtNpo0Jq7q8o8sN75jnO9kHs8YA==
X-Received: by 2002:a05:620a:2956:b0:7ce:c3e5:6ec0 with SMTP id af79cd13be357-7d0987ba15amr405874285a.20.1748512781212;
        Thu, 29 May 2025 02:59:41 -0700 (PDT)
Received: from [192.168.1.167] (cpc76484-cwma10-2-0-cust967.7-3.cable.virginm.net. [82.31.203.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d09a195c73sm75430685a.69.2025.05.29.02.59.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 May 2025 02:59:40 -0700 (PDT)
Message-ID: <5cdf4f04-d8dc-43ab-9690-3e5701bdbb2e@redhat.com>
Date: Thu, 29 May 2025 10:59:37 +0100
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gfs2: Don't clear sb->s_fs_info in gfs2_sys_fs_add()
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: gfs2@lists.linux.dev,
 syzbot+b12826218502df019f9d@syzkaller.appspotmail.com
References: <20250528150237.171254-1-anprice@redhat.com>
 <20250529093306.2049425-1-agruenba@redhat.com>
From: Andrew Price <anprice@redhat.com>
In-Reply-To: <20250529093306.2049425-1-agruenba@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _r9EzvdXdWtZVDueoKHicjy7gxyKBBVuNyHcmKWDMUM_1748512781
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 29/05/2025 10:33, Andreas Gruenbacher wrote:
> Hi Andy,
> 
> On Wed, May 28, 2025 at 5:02â€¯PM Andrew Price <anprice@redhat.com> wrote:
>> When gfs2_sys_fs_add() fails it sets sb->s_fs_info to NULL which results
>> in a NULL pointer deref in gfs2_drop_inode() when iput(sdp->sd_inode) is
>> called in the gfs2_fill_super() error path. Remove the NULL assignment
>> from gfs2_sys_fs_add() and let gfs2_fill_super() deal with it instead,
>> after the iput().
>>
>> Fixes: ae9f3bd8259a ("gfs2: replace sd_aspace with sd_inode")
>> Reported-by: syzbot+b12826218502df019f9d@syzkaller.appspotmail.com
>> Signed-off-by: Andrew Price <anprice@redhat.com>
>> ---
>>   fs/gfs2/sys.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/fs/gfs2/sys.c b/fs/gfs2/sys.c
>> index 748125653d6c..c3c8842920d2 100644
>> --- a/fs/gfs2/sys.c
>> +++ b/fs/gfs2/sys.c
>> @@ -764,7 +764,6 @@ int gfs2_sys_fs_add(struct gfs2_sbd *sdp)
>>          fs_err(sdp, "error %d adding sysfs files\n", error);
>>          kobject_put(&sdp->sd_kobj);
>>          wait_for_completion(&sdp->sd_kobj_unregister);
>> -       sb->s_fs_info = NULL;
>>          return error;
>>   }
>>
>> --
>> 2.49.0
>>
> 
> This is interesting, thank you. I've been puzzling over the same bug
> report, but didn't get as far.
> 
> Looking through history, this assignment was added in commit
> 0d515210b696 ("GFS2: Add kobject release method"), and it should
> probably have been paired with the kfree() but not the kobject_put()
> right then: the idea seems to be to clear sb->s_fs_info before freeing
> the object sb->s_fs_info points to. The freeing is meanwhile done in
> free_sbd(), so I'm wondering if we shouldn't clean things further, as
> below.
> 
> diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
> index 8a4cdd961e5f..a19d7e431c8e 100644
> --- a/fs/gfs2/ops_fstype.c
> +++ b/fs/gfs2/ops_fstype.c
> @@ -64,7 +64,10 @@ static void gfs2_tune_init(struct gfs2_tune *gt)
>   
>   void free_sbd(struct gfs2_sbd *sdp)
>   {
> +	struct super_block *sb = sdp->sd_vfs;
> +
>   	free_percpu(sdp->sd_lkstats);
> +	sb->s_fs_info = NULL;
>   	kfree(sdp);
>   }
>   
> @@ -1314,7 +1317,6 @@ static int gfs2_fill_super(struct super_block *sb, struct fs_context *fc)
>   	iput(sdp->sd_inode);
>   fail_free:
>   	free_sbd(sdp);
> -	sb->s_fs_info = NULL;
>   	return error;
>   }
>   
> diff --git a/fs/gfs2/sys.c b/fs/gfs2/sys.c
> index 748125653d6c..c3c8842920d2 100644
> --- a/fs/gfs2/sys.c
> +++ b/fs/gfs2/sys.c
> @@ -764,7 +764,6 @@ int gfs2_sys_fs_add(struct gfs2_sbd *sdp)
>   	fs_err(sdp, "error %d adding sysfs files\n", error);
>   	kobject_put(&sdp->sd_kobj);
>   	wait_for_completion(&sdp->sd_kobj_unregister);
> -	sb->s_fs_info = NULL;
>   	return error;
>   }
>   
> 

Yes, that's a good improvement.

Thanks,
Andy

