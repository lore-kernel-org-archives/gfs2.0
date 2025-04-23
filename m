Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE2F2D613
	for <gfs2@lists.linux.dev>; Wed, 23 Apr 2025 11:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745408535; cv=none; b=Bwae8D7VvXdb2Y616IrKG1+8Ai+uGwrZsnTcIuqj6gayXFSh5IxbgtrJHFCnI3Kym5RkCDq4b5cTWh8KNM3baj2YMN61SkK9YVxLdszJ5GwO0n+wtZNPpbaLfVbWtDN8pM5s/NSElxndp04V/oSsoRGNtNZq/CYg81ZHhjcfOEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745408535; c=relaxed/simple;
	bh=TyomZ5Q32VGWOIFL02bJIMo/tdbbHCfJQYikQ+RuoyE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=XLVMR+cu0wXY7+qMOYI7QX3ukNPCIa4s/3Tayh2G5f5YbzevsVvOu7JwtuUVo9+PjcrlzVPlMuNavoLZnCupLS5xBglcbrWQNCZbHPdEDqOl764Rj8OH7dJKQTeJlzHbS+QCir9n85C96QDPPZxBW00TjAJO+V9dcUeNrDl2LzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QckemWP4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QckemWP4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745408532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JrU4GRCwqoAeP3wuUTnQI+EANCJpdt7luf8MxbNTWv0=;
	b=QckemWP4phmmqm6iRm7lqjOfHrzN5JKM08yThPyQIZBjYqCuGySQSPdXJ0Emyvr/P27/3q
	Z3ysg7Jb+3S2uy07iGod0qjEtg6ZAnaluNwKc77aWdLNjiv3f49mffFNdVsA9QTyLz/c9e
	V6jpMH5yA+YtvcXQ6uQ6oFGrgiGakiI=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111-m6e4OLtQMha4GBMPdUAHYQ-1; Wed, 23 Apr 2025 07:42:11 -0400
X-MC-Unique: m6e4OLtQMha4GBMPdUAHYQ-1
X-Mimecast-MFC-AGG-ID: m6e4OLtQMha4GBMPdUAHYQ_1745408530
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c54a6b0c70so593606585a.0
        for <gfs2@lists.linux.dev>; Wed, 23 Apr 2025 04:42:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745408530; x=1746013330;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JrU4GRCwqoAeP3wuUTnQI+EANCJpdt7luf8MxbNTWv0=;
        b=H7z3eoP/oC6FCBvZkjRv6r6qPtOIXRb906LXGV2D8LaVuyyvF+wvyvkhIJGv2XSCbl
         yi6EeJmryouuZfV0lbLWxfoZVplsUMORxyTX6AYV8N+BLNs0ptmISEP8joZBf3eodL/1
         n0GJ+1lu+2qATB08Vg+JLeRaQvbAhKfkWSdPvsPkZaIi2qoAYw8OsaiYc9haL2JY7faW
         fpm25DARfeandtCuqqcEx1uvF4JM2FzyLOjLaHYza764c/p+jScpZ+rjHFiTJN0xnV4L
         h21zRq5f/gauTuY3fNmA1A6bx3EMGczpBQL5RV/AmejHCsMqOpPmEOhBsR0dlXbJr7kL
         dqtg==
X-Gm-Message-State: AOJu0YyQ3kkDdIB/U1S8xB3pFJK6ENmVyWCCZtVKNYEs0t0Hu7AimfwV
	eViggCYxrX2PaD+DaBEydEs3OXsbcBN9/5dmBj+yZVkSBcz5+CqHWrkhhliNrpl2no2uXKe7+/C
	muM36f/7BFh8z8fWQnVi/V7lGi5MsoaHM4VLuA6xNJfdZ0ldKGug=
X-Gm-Gg: ASbGncuzDP18O9ERFtvkmSY3+gFBn9BA7wdzKnRJd0mzz8UYMQ2vO0B8KRnXgL5ALy0
	qVu23l8Vuav1vOmWbc2eLfOCj46n9LJhQ72ZU4Adu2bO0VG4bv6YpmY5bfoQvZgZNeeGMv87mTd
	zbtlY6RujzEI903SAoATHnVudKPpjESFfD8eQ4XQDJfAc5yQn5ydYYedYiSUS/xqhLvGueUKmi7
	XXIEZAwBokkl8prAvLcqKZbaGYQEjKLBTiZg6ky17KuvEUAtGbTVjZGIGLAsdMB6eFTWCwqEFD5
	flEIRI41qwquMszGB0dgIGcbgP5aU5pMSEOWxLel8sXnxCFcQVNRG2lWzgfRYSx32iM+L4c=
X-Received: by 2002:a05:620a:2409:b0:7c5:b909:fde1 with SMTP id af79cd13be357-7c927f9dd6fmr3148252885a.25.1745408530570;
        Wed, 23 Apr 2025 04:42:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3TZMgTwfdZmxchfboy9NIm7wCRk37L8yf+/nLYk8rUmV5534T+o8H1ulp6HfbiJ22s3eTZA==
X-Received: by 2002:a05:620a:2409:b0:7c5:b909:fde1 with SMTP id af79cd13be357-7c927f9dd6fmr3148249785a.25.1745408530254;
        Wed, 23 Apr 2025 04:42:10 -0700 (PDT)
Received: from [192.168.1.167] (cpc76484-cwma10-2-0-cust967.7-3.cable.virginm.net. [82.31.203.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c925b4db99sm672519085a.81.2025.04.23.04.42.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Apr 2025 04:42:09 -0700 (PDT)
Message-ID: <f3b6e966-b0c0-43cf-92e5-3d3ef24f2049@redhat.com>
Date: Wed, 23 Apr 2025 12:42:07 +0100
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] gfs2: deallocate inodes in gfs2_create_inode
To: Andreas Gruenbacher <agruenba@redhat.com>
References: <20250422095407.1221362-1-agruenba@redhat.com>
 <20250422095407.1221362-3-agruenba@redhat.com>
Cc: gfs2@lists.linux.dev
From: Andrew Price <anprice@redhat.com>
In-Reply-To: <20250422095407.1221362-3-agruenba@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jN1gaEZY_l5oblOnDISeZkczac0cI7rIqBFiKAIZPrw_1745408530
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Something occurred to me...

On 22/04/2025 10:54, Andreas Gruenbacher wrote:
<snip>
> @@ -898,6 +901,14 @@ static int gfs2_create_inode(struct inode *dir, struct dentry *dentry,
>   	gfs2_glock_dq_uninit(&ip->i_iopen_gh);
>   fail_gunlock2:
>   	gfs2_glock_put(io_gl);
> +fail_dealloc_inode:
> +	set_bit(GIF_ALLOC_FAILED, &ip->i_flags);
> +	if (ip->i_eattr)
> +		gfs2_ea_dealloc(ip, xattr_initialized);

Is it safe to throw away the return value here? I guess it probably is 
if gfs2_ea_dealloc() failures always flag a withdraw, but it's difficult 
to check all the paths.

Andy

> +	clear_nlink(inode);
> +	mark_inode_dirty(inode);
> +	gfs2_dinode_dealloc(ip);
> +	ip->i_no_addr = 0;
>   fail_free_inode:
>   	if (ip->i_gl) {
>   		gfs2_glock_put(ip->i_gl);
<snip>

