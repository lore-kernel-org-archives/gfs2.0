Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E461922A1E4
	for <gfs2@lists.linux.dev>; Wed, 16 Apr 2025 11:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744801754; cv=none; b=OEUq/mkzzklHHQiKK5MyOqRohrENZ2kmo987Qj8Z9jEbAwKXLpCxTYZn5dhjnO9W8iugGycR9Kcnk+y7KlLvTTyBUNhpvy6FiivKm5hlZ2iBJTuYTAD3Ors2zab0fNJjqEx/Mho4v7m4Tyaz6m0p2q/rdakjV6LEl5hRrZ4Gr3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744801754; c=relaxed/simple;
	bh=2NNfZxaYCVPH8OmJDA4wDdKw1qepejTj7MXbaNFtNCY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sQUlYu7VNExZ1S9grXQAahwSTJMMOewtw/qRvnn2VhO8lfkRz6cLneqTjTqGhxYfzATPtrHM3HjN3cA5GbDPDVqibhCdtJKILUV7OW0ro/CWC0TTvOIkP2SOUOAsjZ0y92w6tfvripDHsEzTlkTVzHx8N+v8LPGgTOlPzCwSrCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WrN2gjbx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WrN2gjbx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744801751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FvoG0rJ4ZaNqTcODQQWB3PzESs7m7P+r71ByG8VqdYM=;
	b=WrN2gjbxGPLbbtqglKqRMuYsyNK3zWWeI0R6YMCfSXku4gTsUTmbXRB6TuuNGGQZDxIW1a
	dWaSXbS+vt6KD0mZbWV3M7l2pt8Rxt+UvqbPOh3PQLj1vW/8MgzFZCeVn4U0Y4q8IMLS0F
	rJmhg7QrIdhzaZbHqHzi2/98qg9TIL8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-Jp2uolokMkOCJROfqvf24w-1; Wed, 16 Apr 2025 07:09:10 -0400
X-MC-Unique: Jp2uolokMkOCJROfqvf24w-1
X-Mimecast-MFC-AGG-ID: Jp2uolokMkOCJROfqvf24w_1744801749
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43d007b2c79so47181435e9.2
        for <gfs2@lists.linux.dev>; Wed, 16 Apr 2025 04:09:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744801749; x=1745406549;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FvoG0rJ4ZaNqTcODQQWB3PzESs7m7P+r71ByG8VqdYM=;
        b=ap9BG+PR9IFGdt73Xsr/Sos0v2vd++b2BlcS0/eemgolvhXX8AWgwKCotp+JoHZNBa
         jHdlcrMWUKMzwIXvP0+UQ+Fsj10RUR4psbRhpnk3rIcaveGFyulYmUQqcHdagL+Ea6NM
         pArx+LlONM4MeZBWqVX7Je772w6/Tbrxj9BNEo12zaSoLVxTCz3+PlnJyJd4mIC5LRJr
         zatTUdQGck28SJsgm+xo6DaHJumiJkkzeK1CuCnSnZ/AV0wS9zF8GLfY39xLpayX70Wk
         tmTZvsO8567jo0NE7PhmYSN5P5ZtvJBIItP9TVLsbi/AGiTF1reLvqbKad5P7+rmXCiU
         nSqQ==
X-Gm-Message-State: AOJu0YyXW64P3vrLZqm9h43p7yH6I3i0nt31krnr2hpZ2kL8bS3PKAKh
	1CdZRP4OjBswME8MlKbt1f9m0KOjRoczSxp+maIonDr/CZ/XwYoSToLQ8YgPOGgp73/wT9IzLgO
	pnAlw5/BE2VS2Jtu8HDeNWaJ+UY/SXHyoJuNIBix9EVenDFNOYUI=
X-Gm-Gg: ASbGncs+d5KL0Vj/ii6uj30m8POxq3lFTeL3cE2QNdc1c/Aa46X6EbNOKmsBCkGa0Ni
	0IEfR2wtO0kJ33r3GzUqYzw2xsCo/nFyXDY4zyFt2M5hfaifp9Bg1NIL2/cWEc11eShUI3bXZlu
	wGngDRiEK9HRmqqALK5kN4w+W4aaSwx1utl8RzA/HWTKiKNhEeyZx6J5/6Ti6KAls2OYGa3c4gj
	Jw0SaVhP0GtDrfUYR20a/7pTDu3IgLs1KAiD8PZ5262xFd08TAS/4Q2nSpy/Mc3EK6c9nDk16fv
	MzLgkovjp5+iSE0wXBCCiKICfLGpZ99PeJz2j7w3DIeqfhW3GAVTktE6TUh2uFq8FG8a65M=
X-Received: by 2002:a05:600c:a418:b0:43d:1824:aadc with SMTP id 5b1f17b1804b1-440601e2fcamr3708735e9.29.1744801749211;
        Wed, 16 Apr 2025 04:09:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGUs3LKsn6pJNsp4U16bAqW+oZK3vljPoxPIhRLorBTR/duEiLDtH5TLFiIZXUSCALv6pv0A==
X-Received: by 2002:a05:600c:a418:b0:43d:1824:aadc with SMTP id 5b1f17b1804b1-440601e2fcamr3708385e9.29.1744801748675;
        Wed, 16 Apr 2025 04:09:08 -0700 (PDT)
Received: from [192.168.1.167] (cpc76484-cwma10-2-0-cust967.7-3.cable.virginm.net. [82.31.203.200])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4405b53eec3sm17657025e9.34.2025.04.16.04.09.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Apr 2025 04:09:08 -0700 (PDT)
Message-ID: <78895df2-fb5a-4dd9-849e-91930419fac1@redhat.com>
Date: Wed, 16 Apr 2025 12:09:07 +0100
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: gfs: Delete duplicate function generic_update_time
 calls
To: Chaohai Chen <wdhh6@aliyun.com>, agruenba@redhat.com
Cc: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250416094240.206847-1-wdhh6@aliyun.com>
From: Andrew Price <anprice@redhat.com>
In-Reply-To: <20250416094240.206847-1-wdhh6@aliyun.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bZkUmI_uZ26aNF-OBFBcVBIRV9Ghaz44uPmv1q6ecXc_1744801749
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/04/2025 10:42, Chaohai Chen wrote:
> generic_update_time is called by inode_update_time after
> processing gfs2_update_time function,

This is incorrect. inode_update_time() returns after calling 
gfs2_update_time():

          if (inode->i_op->update_time)
                  return inode->i_op->update_time(inode, flags);
          generic_update_time(inode, flags);

Andy

> gfs2_update_time do not
> need call the generic_update_time again.
> 
> Signed-off-by: Chaohai Chen <wdhh6@aliyun.com>
> ---
>   fs/gfs2/inode.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
> index 6fbbaaad1cd0..05fc363bd6e7 100644
> --- a/fs/gfs2/inode.c
> +++ b/fs/gfs2/inode.c
> @@ -2171,7 +2171,6 @@ static int gfs2_update_time(struct inode *inode, int flags)
>   		if (error)
>   			return error;
>   	}
> -	generic_update_time(inode, flags);
>   	return 0;
>   }
>   

