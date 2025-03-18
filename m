Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EF8207650
	for <gfs2@lists.linux.dev>; Tue, 18 Mar 2025 15:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742311528; cv=none; b=EZ2FCK9fhWiX0qDEhur7wuqj0tjRR75m9wkOEv+p+psEXfXb8+JLQaXuA1NiSjnl28fjmxsckezoBlqF91MboAcsS6IXOkhS4fZqEoH4lVGbB8+LYDR6w0lBdse9YQ8+H/LVtqMyA0wkbol5bV+vsyHtwwRUIMgGQZbKL4zQPlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742311528; c=relaxed/simple;
	bh=n7VgW5IdpWHpR4QRlwLyqADMhcQRXhHFMtOMOX33dhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H1p1X8nu8eUj6KNu8DrLpaBSMXz6xLY2gLpbQLVQsoa6cP8qeV1Ncr1SfTNAk4cM6Wyu4/J/aCl4Sq/xRWa601YaYwEhACKpbcAGEtqoG6Vyp6OOAQTkNp9bZPyhszIeR+XKH908xNFUkGq+Kv7WOMRhcbEXudaUVYWi8IiFhSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GG8g7ufd; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GG8g7ufd"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6e8f6970326so49790716d6.0
        for <gfs2@lists.linux.dev>; Tue, 18 Mar 2025 08:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742311526; x=1742916326; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Iyn8RJjlleD7uhnXI6huIEcPWo+6WvTYSC8J/PV1Ppw=;
        b=GG8g7ufdA56tdz7hzX6XUHQPwUghN6phfFujRkYL89nMx7wf+3NGVjJOqGuc5YLmJp
         jNNVCRCrw1TsDjNtUCiDUzco90esicGYyxtMY/QRXCHE19dFwUiDwhjs0FLYLZsRVlRa
         U8V2LBTPOCugbW7sE16ciFjXw3h2rUOnaBWSkl7Zr7aQF38k/ZRulaPWEPh/Sw6qEmDu
         f8h6Pz2rfW6aMHINfhJaPf445BaivVQ8jfsO4Dr5+LXrGnbnDAEHJ0a0I7NsjBEgWN7M
         crgwF8W8v+WOXqpSWedYdAEzkXEg/dQ++pf2/Korzeb3/HrvmYJWZJbqOjvEn3CMSOA7
         HLcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742311526; x=1742916326;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iyn8RJjlleD7uhnXI6huIEcPWo+6WvTYSC8J/PV1Ppw=;
        b=P1nq/Z1DSl6003LmOXo7okWeUd4/CkFK+HhVXXv90wFOqeKsNXsGLXEF+h+fiO1k2d
         FUOLqG2t0m2tXF+Ivi7mTWNEg+cc4VeZSNjBqG/rilh17HjPjW+CsDVKhGg5HZ12p3iz
         2WbcvmqXeZJF+yxQu+pIwm2F9z62wZCzewTJVuRHgLVrIeZ8HYgxMiUnF9UhX3TX0Sgw
         /wEi4npoWmhAF4M3uWde+qysI8SdOF4U4D2Yuci6PNgpGuRrh+qnH09yQTR4ti6ELjBp
         7gfLWZBgNyUiwgFeYr1J9AQzxn4Iw4x5ejwV47Q7S+ZYrpZ7LrpeY0aX4TVmrT/gd4er
         rTlg==
X-Forwarded-Encrypted: i=1; AJvYcCXa5QqNKR1dvzYyNFV4sc4bx+6Y0zcaPE7XUGxURsh9yUh4+959ke2FBFN0Xr8jWNtUgRdU@lists.linux.dev
X-Gm-Message-State: AOJu0YxIYqdSZ2TX3eEzoHB/AQkpbNR4QAvGn1EbvfObePaXan4L9LxE
	zoSeMdZvwDiEcpIMpb7ZHBe8ha+Hf/9hZeLJOsBYVMo5lGz/Y32+654rYRyQ
X-Gm-Gg: ASbGnctn4eQjw8vCIamZm4WEjQAT5JWpStqQ4IoQLaWgDK/hwmA2TLZ93D6J695GZ+B
	cxtVAGBbNrECIAe0sc50L2oPf5Q7y03fcTT2DZA8lm8XwoKQjOZi/9syWMF20q8A+GgEbnUzOp9
	UYdadVPD2WeLpkQ6i+NMjqSefaBL4VdLWzZlEyBfxGTXZE0TmAqdq4xA+4SGpqkd9I8Jqocv4WF
	jyloS8qi9NHoHj+IFtuW/ZQdN4nRL6H5VfTPunRmNo1mpHzfsx956Zs7Of01KNskm1kBZ+PonJM
	nuwKs0jqy6V6n7VwAkva5OQWgk+5ZrVtKtgGtRXDy7PwNXBA+yJdYy5aIGTh
X-Google-Smtp-Source: AGHT+IFMrxghikRrokajWNq7Qgw70xbXKxuDnySNPyGwfwT2Ss7893xwolfUMGoDpYSi2hTG/afasQ==
X-Received: by 2002:a05:6214:c88:b0:6e8:fa33:2969 with SMTP id 6a1803df08f44-6eb1b8391fdmr53856596d6.10.1742311525741;
        Tue, 18 Mar 2025 08:25:25 -0700 (PDT)
Received: from f (cst-prg-67-174.cust.vodafone.cz. [46.135.67.174])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eade209bcdsm69412376d6.24.2025.03.18.08.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 08:25:24 -0700 (PDT)
Date: Tue, 18 Mar 2025 16:25:15 +0100
From: Mateusz Guzik <mjguzik@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, 
	Andreas Gruenbacher <agruenba@redhat.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, gfs2@lists.linux.dev
Subject: Re: [PATCH 3/8] lockref: use bool for false/true returns
Message-ID: <ptwb6urnzbov545jsndxa4d324ezvor5vutbcev64dwauibwaj@kammuj4pbi45>
References: <20250115094702.504610-1-hch@lst.de>
 <20250115094702.504610-4-hch@lst.de>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250115094702.504610-4-hch@lst.de>

On Wed, Jan 15, 2025 at 10:46:39AM +0100, Christoph Hellwig wrote:
> Replace int used as bool with the actual bool type for return values that
> can only be true or false.
> 
[snip]

> -int lockref_get_not_zero(struct lockref *lockref)
> +bool lockref_get_not_zero(struct lockref *lockref)
>  {
> -	int retval;
> +	bool retval = false;
>  
>  	CMPXCHG_LOOP(
>  		new.count++;
>  		if (old.count <= 0)
> -			return 0;
> +			return false;
>  	,
> -		return 1;
> +		return true;
>  	);
>  
>  	spin_lock(&lockref->lock);
> -	retval = 0;
>  	if (lockref->count > 0) {
>  		lockref->count++;
> -		retval = 1;
> +		retval = true;
>  	}
>  	spin_unlock(&lockref->lock);
>  	return retval;

While this looks perfectly sane, it worsens codegen around the atomic
on x86-64 at least with gcc 13.3.0. It bisected to this commit and
confirmed top of next-20250318 with this reverted undoes it.

The expected state looks like this:
       f0 48 0f b1 13          lock cmpxchg %rdx,(%rbx)
       75 0e                   jne    ffffffff81b33626 <lockref_get_not_dead+0x46>

However, with the above patch I see:
       f0 48 0f b1 13          lock cmpxchg %rdx,(%rbx)
       40 0f 94 c5             sete   %bpl
       40 84 ed                test   %bpl,%bpl
       74 09                   je     ffffffff81b33636 <lockref_get_not_dead+0x46>

This is not the end of the world, but also really does not need to be
there.

Given that the patch is merely a cosmetic change, I would suggest I gets
dropped.
