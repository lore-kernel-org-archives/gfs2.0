Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7C5346A11
	for <gfs2@lists.linux.dev>; Thu, 11 Sep 2025 15:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757604098; cv=none; b=MqVxotvL1Tv9SPxl8AjHnPsDdXd5aloc9b7stmZlkN5Imy6u2/UMjNtVbldUAqZjZMFhB2bmHn45EXBLI+o2pqNSw3aGjcn49g0/MItB0hIgA7+WbEu8YpT0VSAcDXixz0YO9DKAVU9ArNxIcogTOKh/6jwbcTV0v2PP/J3Ttmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757604098; c=relaxed/simple;
	bh=tMJhGEo1n1XR+uWTdcU5HzwQxZT0+i2G1VaY3vpbevU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UvzntBu47BNRp7wPj7uJ0s4GsTbnR8MIZGfs3TY/IfOJDxFZMTdwfP1p/e7e/GRl7VVvgTaUkMAkn+QVvRjBP6bu2pN21YqdLQJSkyP3/SiW42CuV/RBMkuIOri0nMGi+veVdtKbkk4FrAuSalW6tZy7sFhLVCAZYPGheLUFN44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O3olD664; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O3olD664"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757604094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+4mxLDAkRer9HfS1E1qKKiVAWcljcp7Bz450T/TpiUY=;
	b=O3olD664dlEjnn1dpj9ztUuROaYBJL3xVBACw94fxhDLbMoao8RgTlqz8EQ05/v0ESunB0
	oM663/oOqZ1y6WN5wB6YfdYdbetLqP9KKM13AnZEPmLwxXrKmtnD62Og3wrInnFVHuL1ej
	GQ5WXX+9PY8QMEXOGVZuJC3L8E6/d7Q=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-6dZdp_u-Ppuizs6iKWao2Q-1; Thu, 11 Sep 2025 11:21:33 -0400
X-MC-Unique: 6dZdp_u-Ppuizs6iKWao2Q-1
X-Mimecast-MFC-AGG-ID: 6dZdp_u-Ppuizs6iKWao2Q_1757604092
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3e7634eb959so341548f8f.2
        for <gfs2@lists.linux.dev>; Thu, 11 Sep 2025 08:21:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757604092; x=1758208892;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+4mxLDAkRer9HfS1E1qKKiVAWcljcp7Bz450T/TpiUY=;
        b=s07/n21+76d2immPprr3PPuUYWY+aNeHpJD5nvNcXKOop/ZATge5rtwavUazkzfH4b
         BGc76RMhhYKnil4y4/wqeQ/QC/qzACEXahQDWeC30D2gB9sQHgCl6v7l1Nnkf4YJQmnR
         n0+pH+D5E7qHa728haBzqUZF5vnYZzkwjKuRCbNva8p3XfolYnh4nx4qkP066zJEprCa
         5JfQ6fWf4kHNCoOqSranWNtVZgMzd02JD02BPwtBX0ujUwbF3nvM+Mm8128Cr9GCWXxh
         +TQTs3V7tim5X3Md280yo/W/Vj8/MmFCfHm+Sz844jHXvgs5Zf1C3f/qwyr0JEWGuodS
         azUg==
X-Forwarded-Encrypted: i=1; AJvYcCVeuFcxmE5h9UM4OMlvdhPrZ8AL8U+NfKIXHVQAlZ7RaBOtGcDFD20ezc8FkmuvNahVNlIU@lists.linux.dev
X-Gm-Message-State: AOJu0YydhoHvIfgrIINDPDyYUo2e0FVnshYeiTCb7Z86nLWCpHKFzSFJ
	RKBIqyPDfHMJa2PyTMvKxk7cEqMjG+23Wf3ac8zQdOk6N6O0cB+tv8m+pvE9nuzR9ZYz5CMCU5w
	8+lpFDGCFM/JASGhRtOKdi2km8CSICk6FDgwNSyVoaQHvD/c83/z+hVw=
X-Gm-Gg: ASbGnctxUSogAx7AtqLwMOGABFzZwXJxLMSIUFplIIb9CC8UxML1Ew5ioZ38AS/ypLt
	Byo4yKdDiXp8Vt0DgjoF9fNklY+87xjF5Ep23QG+BzxkGf2dhmrg3kAxgoNJwBsE36q7auntfIw
	0ua5YMhNjP6rQyP6hMdRLj/m7qJd46DuMzT/thVZVHlCDj0GKkcr6/n40de8cdmrdG8IULR9ZTJ
	vW0movcTX5kMOwiZOBW/LoUPiNZwbq35VQjC8pxnGDoFaOyCS9+wWP+9E+UM0idSlys9nrOYta4
	oDAn2LboQ9CIzn+wpUphE6TjYKTZgzkLDgZ5JnGuFTNAPTsKmJx5WxSfpe2St2DaoCzhI4Lqm+5
	fFp9LUwyd0kg4skOSQ4yi+ipV
X-Received: by 2002:a05:6000:1789:b0:3e4:3e20:dafe with SMTP id ffacd0b85a97d-3e6440ef3a2mr16904670f8f.33.1757604092005;
        Thu, 11 Sep 2025 08:21:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLDJn/4SXm3bf/0WHd8oWG2WfiTwwUaDSdq7WfYvfcdIckJxQ3bi9vdu9/SLNjgQx7vg0RlQ==
X-Received: by 2002:a05:6000:1789:b0:3e4:3e20:dafe with SMTP id ffacd0b85a97d-3e6440ef3a2mr16904641f8f.33.1757604091597;
        Thu, 11 Sep 2025 08:21:31 -0700 (PDT)
Received: from [192.168.1.167] (cpc76484-cwma10-2-0-cust967.7-3.cable.virginm.net. [82.31.203.200])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e0156c64bsm30328835e9.2.2025.09.11.08.21.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 08:21:30 -0700 (PDT)
Message-ID: <29f05cb4-c5c1-47e6-bc83-c0913bf7f0fa@redhat.com>
Date: Thu, 11 Sep 2025 16:21:30 +0100
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/20] gfs2: Sanitize gfs2_meta_check,
 gfs2_metatype_check, gfs2_io_error
To: Andreas Gruenbacher <agruenba@redhat.com>, gfs2@lists.linux.dev
References: <20250911135726.657575-1-agruenba@redhat.com>
 <20250911135726.657575-9-agruenba@redhat.com>
From: Andrew Price <anprice@redhat.com>
In-Reply-To: <20250911135726.657575-9-agruenba@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: KZPaZjcUNpVxDxQzkbLF4xfxi9ROAaEnWSo4xWGVRL4_1757604092
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/09/2025 14:57, Andreas Gruenbacher wrote:
> Change those functions to either return a useful value, or nothing at
> all.
> 
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> ---
>  fs/gfs2/util.c | 23 ++++++++---------------
>  fs/gfs2/util.h | 34 +++++++++++++++++++---------------
>  2 files changed, 27 insertions(+), 30 deletions(-)
> 
> diff --git a/fs/gfs2/util.c b/fs/gfs2/util.c
> index 020dd21ad51e..56412f63f3bb 100644
> --- a/fs/gfs2/util.c
> +++ b/fs/gfs2/util.c
> @@ -471,13 +471,11 @@ void gfs2_consist_rgrpd_i(struct gfs2_rgrpd *rgd,
>  
>  /*
>   * gfs2_meta_check_ii - Flag a magic number consistency error and withdraw
> - * Returns: -1 if this call withdrew the machine,
> - *          -2 if it was already withdrawn
>   */
>  
> -int gfs2_meta_check_ii(struct gfs2_sbd *sdp, struct buffer_head *bh,
> -		       const char *function, char *file,
> -		       unsigned int line)
> +void gfs2_meta_check_ii(struct gfs2_sbd *sdp, struct buffer_head *bh,
> +			const char *function, char *file,
> +			unsigned int line)
>  {
>  	gfs2_lm(sdp,
>  		"fatal: invalid metadata block - "
> @@ -486,18 +484,15 @@ int gfs2_meta_check_ii(struct gfs2_sbd *sdp, struct buffer_head *bh,
>  		(unsigned long long)bh->b_blocknr,
>  		function, file, line);
>  	gfs2_withdraw(sdp);
> -	return -1;
>  }
>  
>  /*
>   * gfs2_metatype_check_ii - Flag a metadata type consistency error and withdraw
> - * Returns: -1 if this call withdrew the machine,
> - *          -2 if it was already withdrawn
>   */
>  
> -int gfs2_metatype_check_ii(struct gfs2_sbd *sdp, struct buffer_head *bh,
> -			   u16 type, u16 t, const char *function,
> -			   char *file, unsigned int line)
> +void gfs2_metatype_check_ii(struct gfs2_sbd *sdp, struct buffer_head *bh,
> +			    u16 type, u16 t, const char *function,
> +			    char *file, unsigned int line)
>  {
>  	gfs2_lm(sdp,
>  		"fatal: invalid metadata block - "
> @@ -506,7 +501,6 @@ int gfs2_metatype_check_ii(struct gfs2_sbd *sdp, struct buffer_head *bh,
>  		(unsigned long long)bh->b_blocknr, type, t,
>  		function, file, line);
>  	gfs2_withdraw(sdp);
> -	return -1;
>  }
>  
>  /*
> @@ -515,15 +509,14 @@ int gfs2_metatype_check_ii(struct gfs2_sbd *sdp, struct buffer_head *bh,
>   *          0 if it was already withdrawn
>   */
>  
> -int gfs2_io_error_i(struct gfs2_sbd *sdp, const char *function, char *file,
> -		    unsigned int line)
> +void gfs2_io_error_i(struct gfs2_sbd *sdp, const char *function, char *file,
> +		     unsigned int line)
>  {
>  	gfs2_lm(sdp,
>  		"fatal: I/O error - "
>  		"function = %s, file = %s, line = %u\n",
>  		function, file, line);
>  	gfs2_withdraw(sdp);
> -	return -1;
>  }
>  
>  /*
> diff --git a/fs/gfs2/util.h b/fs/gfs2/util.h
> index 2a8a1fac611a..da0373b1e82b 100644
> --- a/fs/gfs2/util.h
> +++ b/fs/gfs2/util.h
> @@ -91,9 +91,9 @@ void gfs2_consist_rgrpd_i(struct gfs2_rgrpd *rgd,
>  gfs2_consist_rgrpd_i((rgd), __func__, __FILE__, __LINE__)
>  
>  
> -int gfs2_meta_check_ii(struct gfs2_sbd *sdp, struct buffer_head *bh,
> -		       const char *function,
> -		       char *file, unsigned int line);
> +void gfs2_meta_check_ii(struct gfs2_sbd *sdp, struct buffer_head *bh,
> +			const char *function,
> +			char *file, unsigned int line);
>  
>  static inline int gfs2_meta_check(struct gfs2_sbd *sdp,
>  				    struct buffer_head *bh)
> @@ -108,10 +108,10 @@ static inline int gfs2_meta_check(struct gfs2_sbd *sdp,
>  	return 0;
>  }
>  
> -int gfs2_metatype_check_ii(struct gfs2_sbd *sdp, struct buffer_head *bh,
> -			   u16 type, u16 t,
> -			   const char *function,
> -			   char *file, unsigned int line);
> +void gfs2_metatype_check_ii(struct gfs2_sbd *sdp, struct buffer_head *bh,
> +			    u16 type, u16 t,
> +			    const char *function,
> +			    char *file, unsigned int line);
>  
>  static inline int gfs2_metatype_check_i(struct gfs2_sbd *sdp,
>  					struct buffer_head *bh,
> @@ -122,12 +122,16 @@ static inline int gfs2_metatype_check_i(struct gfs2_sbd *sdp,
>  	struct gfs2_meta_header *mh = (struct gfs2_meta_header *)bh->b_data;
>  	u32 magic = be32_to_cpu(mh->mh_magic);
>  	u16 t = be32_to_cpu(mh->mh_type);
> -	if (unlikely(magic != GFS2_MAGIC))
> -		return gfs2_meta_check_ii(sdp, bh, function,
> -					  file, line);
> -        if (unlikely(t != type))
> -		return gfs2_metatype_check_ii(sdp, bh, type, t, function,
> -					      file, line);
> +	if (unlikely(magic != GFS2_MAGIC)) {
> +		gfs2_meta_check_ii(sdp, bh, function,
> +				   file, line);
> +		return -EIO;
> +	}
> +        if (unlikely(t != type)) {

Minor nit: Looks like a whitespace issue here but it wasn't added by this patch.

Andy

> +		gfs2_metatype_check_ii(sdp, bh, type, t, function,
> +				       file, line);
> +		return -EIO;
> +	}
>  	return 0;
>  }
>  
> @@ -144,8 +148,8 @@ static inline void gfs2_metatype_set(struct buffer_head *bh, u16 type,
>  }
>  
>  
> -int gfs2_io_error_i(struct gfs2_sbd *sdp, const char *function,
> -		    char *file, unsigned int line);
> +void gfs2_io_error_i(struct gfs2_sbd *sdp, const char *function,
> +		     char *file, unsigned int line);
>  
>  int check_journal_clean(struct gfs2_sbd *sdp, struct gfs2_jdesc *jd,
>  		        bool verbose);

