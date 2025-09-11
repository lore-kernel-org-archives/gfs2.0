Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F7033CE98
	for <gfs2@lists.linux.dev>; Thu, 11 Sep 2025 15:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757604343; cv=none; b=IoHbvNrZI+1W8pwcq3kMjEQiTX5m7dmCFw0yibfVHWhnRHxn3hQfj/z/w/VXyrNfgePlNFrP0MWeEBZBh/wTz5gZp2QWVoiNkV/LiTpfQWzexUOKcowqM9ymYpNp76ylpTzgebxEskOJxHzaqTT7T+WwV6qEc/Xw8YvC8UMjGKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757604343; c=relaxed/simple;
	bh=Qc9twpB6zxk1AUG32TYfKJq458SiGeSBFj3nxyvwLb4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nkA0htqE2uD2RIPL6M675vIkWB4IPQ0KK8LYUvIJaJtTVcwbuiQvnsrwbOLSLxRow8h1MHS6elai31Vwv5bcbHKvfGhmBb/1aCEBRqrFrEmNNZeZHzBs8BjU0H2Yv3ysLBnOlBAl6d0xaOagjsY18AgcFPS77yZcTZI8/DwZWVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MtwwhoqU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MtwwhoqU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757604341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IX5f48qPrHgSAo8Qfjy0z5/MP47tnq9vZF9LkyfaTxE=;
	b=MtwwhoqUlS/ZhO1nYMBh8RKPXl5DDWQrycDHNWtKtznywQyEatD5fsod9nJPlduKEtTHoS
	ZQ+BsmAw4zhMv+XawyGmAfYffMGN6uGeG6VnOqkubKEgenn4qDoWsIz7qD+pyEmPeZu46E
	/o7K6Ixb955wkX+6vtaRPLC4h1w0lmk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-2ByyCGcxM1WqgsRdkaolqg-1; Thu, 11 Sep 2025 11:25:39 -0400
X-MC-Unique: 2ByyCGcxM1WqgsRdkaolqg-1
X-Mimecast-MFC-AGG-ID: 2ByyCGcxM1WqgsRdkaolqg_1757604338
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45b920e0c25so5872045e9.3
        for <gfs2@lists.linux.dev>; Thu, 11 Sep 2025 08:25:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757604338; x=1758209138;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IX5f48qPrHgSAo8Qfjy0z5/MP47tnq9vZF9LkyfaTxE=;
        b=WuSvV5YA90r5aiRJ29nM7pxKt0JRx4zN+WodmcqExxVNnDw47g/9tjO+TNAXO/s4IU
         2gXZXMM6x5sq3+gAd8gULkN28tAIq5B8g/3WYykKvZCgZNOTw/iIZCYviBNB2WzRg0HM
         OoeCTp9w/s8rGx8p5MfX2IGxY4gTq7q4lpCgtq//BfgIEO4kKDGDRgmUYiY3/zCK+TsO
         8Db2tMXexVaB8z1raLJ2LUx82YcvkdkjiAhwxBHNHSY+srHt3ERuf+1Bc4wcjqEqaQ0X
         CWh25ku08kvGFLX9dqPFrwQ/xvor4kDz9C02Vm7Lc6sLDmO/2J0PFY8lF5j5BqmNv8N1
         JKWA==
X-Forwarded-Encrypted: i=1; AJvYcCWN3oF+JS8AZ6DObz+xIoCOLy1r4IToq+0m1rQkeemQBO46L+vb1z2q7Jw2I+hBnxk+829C@lists.linux.dev
X-Gm-Message-State: AOJu0YwNksFOdsE75LcP1RWqNH0mC0lQGAq7g9oQrdllj8VE5pVAUAo3
	q4whO65ElXMNHOOC5lg5oWC+1SwW/T10SwF4iSslzOhqsxP4Z0yvJcTO/5WJKZTRI19mkUFp8VZ
	fyS0WxsjN/gvvFTKH+aExXMdacz9Q2veKrJfYK4IlMyu5Kqfvt4eC5GJXXiVSb0c=
X-Gm-Gg: ASbGnctMEwNKyd7sbIx5V3wJeH68/DxVarYDGGJLciB7/4FhTzA8oC/lN6uazBntFQ7
	vI6ISoCiZxH88gJ7tgbcNHX2YPq9mBkIKDzMKJ9pWK+2G76ce5boVEW73FnsrH5dNASulvkNejd
	vYIppX9LhZvw1o8ovz/xYXktCg9DZB7p71DHVpGuMZKG/yfVwrQJh0yfRRU2sZCTGMzMP5ha6+8
	3tA87363Y3EyfSAFzf8tLWY2fDfcNuE0sa6GaslUeJUkHC6BoN1QVecyJinpqCc5UNO/E+0c4T6
	CCYeLAS0jd3QLrBCDHQgOXKTl3aUphinKE+uakBn7Uty210CNz5O2KB50a8pxq+umoDrMEtpSl+
	YQP6kJMyrZHQUKnrsUa14PxfA
X-Received: by 2002:a05:600c:350a:b0:45d:dbf4:8880 with SMTP id 5b1f17b1804b1-45dddef7b71mr172481385e9.27.1757604338253;
        Thu, 11 Sep 2025 08:25:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcjMs+IQ75XmXbz6/DdNsrG1j5ZTXPQuGohyTr3Yi1HVq5MvjTbT70wzY32KarFgCClexN7g==
X-Received: by 2002:a05:600c:350a:b0:45d:dbf4:8880 with SMTP id 5b1f17b1804b1-45dddef7b71mr172481155e9.27.1757604337798;
        Thu, 11 Sep 2025 08:25:37 -0700 (PDT)
Received: from [192.168.1.167] (cpc76484-cwma10-2-0-cust967.7-3.cable.virginm.net. [82.31.203.200])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607870c4sm2880255f8f.22.2025.09.11.08.25.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 08:25:37 -0700 (PDT)
Message-ID: <78124aef-b064-4aa9-928c-16fbab76767d@redhat.com>
Date: Thu, 11 Sep 2025 16:25:36 +0100
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/20] gfs2: Remove duplicate check in do_xmote
To: Andreas Gruenbacher <agruenba@redhat.com>, gfs2@lists.linux.dev
References: <20250911135726.657575-1-agruenba@redhat.com>
 <20250911135726.657575-14-agruenba@redhat.com>
From: Andrew Price <anprice@redhat.com>
In-Reply-To: <20250911135726.657575-14-agruenba@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: M2txG96AbXPdFsmhm_NMoIZ1bD_RKBtxoZE1UYciZZ0_1757604338
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/09/2025 14:57, Andreas Gruenbacher wrote:
> In do_xmote(), remove the duplicate check for the ->go_sync and
> ->go_inval glock operations.  They are either both defined, or none of
> them are.
> 
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> ---
>  fs/gfs2/glock.c | 27 +++++++++++++--------------
>  1 file changed, 13 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
> index e754214fdb1c..15a90ab8a979 100644
> --- a/fs/gfs2/glock.c
> +++ b/fs/gfs2/glock.c
> @@ -714,25 +714,24 @@ __acquires(&gl->gl_lockref.lock)
>  				     &gl->gl_flags))
>  			return;
>  	}
> -	if (!glops->go_inval && !glops->go_sync)
> +	if (!glops->go_inval || !glops->go_sync)
>  		goto skip_inval;
>  
>  	spin_unlock(&gl->gl_lockref.lock);
> -	if (glops->go_sync) {
> -		ret = glops->go_sync(gl);
> -		/* If we had a problem syncing (due to io errors or whatever,
> -		 * we should not invalidate the metadata or tell dlm to
> -		 * release the glock to other nodes.
> -		 */
> -		if (ret) {
> -			if (cmpxchg(&sdp->sd_log_error, 0, ret)) {
> -				fs_err(sdp, "Error %d syncing glock\n", ret);
> -				gfs2_dump_glock(NULL, gl, true);
> -			}
> -			spin_lock(&gl->gl_lockref.lock);
> -			goto skip_inval;
> +	ret = glops->go_sync(gl);
> +	/* If we had a problem syncing (due to io errors or whatever,

Minor nit: Comment is missing a closing ')' but this patch is innocent too :)

Andy

> +	 * we should not invalidate the metadata or tell dlm to
> +	 * release the glock to other nodes.
> +	 */
> +	if (ret) {
> +		if (cmpxchg(&sdp->sd_log_error, 0, ret)) {
> +			fs_err(sdp, "Error %d syncing glock\n", ret);
> +			gfs2_dump_glock(NULL, gl, true);
>  		}
> +		spin_lock(&gl->gl_lockref.lock);
> +		goto skip_inval;
>  	}
> +
>  	if (test_bit(GLF_INVALIDATE_IN_PROGRESS, &gl->gl_flags)) {
>  		/*
>  		 * The call to go_sync should have cleared out the ail list.

