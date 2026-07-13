Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A533537E8
	for <gfs2@lists.linux.dev>; Mon, 13 Jul 2026 18:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783968015; cv=none; b=UR3KHh46C6o+uqTrzGBC9tfGgaLOsfDsb1Y4KeSqUAHTrxw31OHpsRHsxD7Z/wOZNtPs2NLc7I6pZE5FPuCThpf03Cxyvr9fn7Rp7A7lQzPQjZB+lDMpBS/h954W0hrVf1lfTb86oQ0trhqK85TlP4h9IB20lBZlZlBJD1KDq90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783968015; c=relaxed/simple;
	bh=ssmhTTGSn6sUgTUzUK5DbF/vtmOaVoMkx2aHs/ASP4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A0dSGNFOoGeUmGtX/E30f/KCfavBINKF0uHHp37yRDNdx4gGOeZx+ht1ZclLZhY51nAsYRQAwVWk0rWL7c+DlD4pGwQx/D3G0RShGZvq1VjiHAB9IxkzYxEgIJbhx4dexuPyI3auw2Dn6CwSoLG3jSL3yuR4/tWyKuyEa+WXtq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZKt9DEVl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZKt9DEVl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783968012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KkgeR4qy1urHmGppXYgLTK5cuSjvtnicUYk6q0xDKVA=;
	b=ZKt9DEVlV1a6UTjGu8SEoqXw+5SakruoD3iIxzwpMe4yM1cuOrb5IxizhynuBlURs5Ob28
	ct3ju8Y4kyknU2xEFMaQFPFjEU3Uy0uQhixahQ956GGhNd1xHjhYk5PsCuI23VHD9xl10w
	X38TJwBjA0RjsmXuc6ZRL6Ra+6O8KZQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-ZA7VAkKiOIKi7Wu27vSCJA-1; Mon, 13 Jul 2026 14:40:11 -0400
X-MC-Unique: ZA7VAkKiOIKi7Wu27vSCJA-1
X-Mimecast-MFC-AGG-ID: ZA7VAkKiOIKi7Wu27vSCJA_1783968010
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-493ce08a6b4so30382165e9.1
        for <gfs2@lists.linux.dev>; Mon, 13 Jul 2026 11:40:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783968010; x=1784572810;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KkgeR4qy1urHmGppXYgLTK5cuSjvtnicUYk6q0xDKVA=;
        b=NZG4otK7fyU3dPhKhmlaC2XRMqweXOAmfWmya4O4osR6+RRMFn+SMDQhyKLTGzomJ5
         SpAyIbfj+CrC03uVjty0Ih6SJwoOvVRFbc5gWayDkGefVAskPgqmf6BSVDU0HAUHuLa1
         BVqUEqeAPQ3lPasIJPtj6xGk/FSoUsSszk7GjgYeYCytrBpC46NPqC/HGxE1UGjqzgIg
         QrhMHssL8wVudDSmjdRX251bZ79nc0Z2THg8noLnDHXSJyLR0reTll1wtS8WRwIXCt6A
         ixEaXWDl7Xjmr8JbhC4qIABC/aieF4w+dqQHft+40UyositvAb8e+XD0ckmc2A9t0y5E
         TEZw==
X-Gm-Message-State: AOJu0YwNRM6NZn6UUdFZ5NsYGuAmzW5k4E+CW72AkPy8yEqh4sVwalr2
	uo0BfeD4fkhsZtvkvVPbAxCICfKmYbT9I8ygO/R0aM2tc6gEYrO9PT5AnhKmXSvbOpGtUNjS4DC
	r16eMEphKqK5EUPFuuYNVZpBnL8Xc8SYzKfsoWJMJJ/m4BXkjQlQDQ5b1zb87ucM=
X-Gm-Gg: AfdE7ckYeaAuyG8V3pu9EMs96AN/vaRK1gcwk1S9yvnz3UROr/qzCmmrcMrdt8ZMMsQ
	TEXwcpU8f7uvapM975HKgeFcCJxK5UKSKc+3SqQAYdO/509iUdn10kj7fj2nK6EzN7ZxWfFIbtf
	onKYPIhdTqenAfF8gWR2AVTHNvoB3i9oy0DKs5P+Z8MxdImNNGWGhhkhVuq2V6g+ykS2SV9+HRM
	XQqJKTucgbX3NSp47svGf/pU/mq3ems7RlDoGlatp6x3SpcsT1WINLTTlxZs60N0Hjnyq90YmBq
	NvHIopTfu1uJleam896hy0ME7g5H4VBVi9LSlNtuBtKi4A9deMUacH015EX11+MwGR2z3xV4goI
	TKBjMvvKWv19YSm+HC2nqLMu1Lg8WEHennS2uNAHtYNLG/AnQ4xM0KdS8RzeNkOgb7tu7+Hk=
X-Received: by 2002:a05:600c:1992:b0:493:f261:d295 with SMTP id 5b1f17b1804b1-493f87d9886mr102184545e9.4.1783968010235;
        Mon, 13 Jul 2026 11:40:10 -0700 (PDT)
X-Received: by 2002:a05:600c:1992:b0:493:f261:d295 with SMTP id 5b1f17b1804b1-493f87d9886mr102184345e9.4.1783968009832;
        Mon, 13 Jul 2026 11:40:09 -0700 (PDT)
Received: from [192.168.1.167] (cpc76484-cwma10-2-0-cust967.7-3.cable.virginm.net. [82.31.203.200])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493f2a38b19sm215839955e9.0.2026.07.13.11.40.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 11:40:09 -0700 (PDT)
Message-ID: <a9bdedcd-cb49-4b6a-bf78-ba6f03b3d511@redhat.com>
Date: Mon, 13 Jul 2026 19:40:08 +0100
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gfs2: reject an over-long name in get_name_filldir
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Andreas Gruenbacher <agruenba@redhat.com>
References: <20260711150808.2919076-1-michael.bommarito@gmail.com>
From: Andrew Price <anprice@redhat.com>
In-Reply-To: <20260711150808.2919076-1-michael.bommarito@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: A_WKQNK0DAfgiJkUpKVkGLaZ-9WJtcspgBEW_znKAak_1783968010
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/07/2026 16:08, Michael Bommarito wrote:
> get_name_filldir() copies a directory entry name into the caller's fixed
> GFS2_FNAMESIZE-byte buffer with memcpy(gnfd->name, name, length) without

I don't see a GFS2_FNAMESIZE-byte buffer but it looks like gnfd->name is pointing to the `char nbuf[NAME_MAX+1]` in exportfs_decode_fh_raw(), but that's just a 1-byte difference so it doesn't change the conversation much.

> checking length against GFS2_FNAMESIZE. A gfs2 directory entry whose name
> length exceeds GFS2_FNAMESIZE, as produced by a corrupted or crafted
> on-disk directory, overflows the buffer.

I think the on-disk dirents should have been checked closer to the dirent read path before we get to the get_name() path.

> Impact: an out-of-bounds write past the GFS2_FNAMESIZE name buffer (KASAN)

Do you have a KASAN backtrace?

> in the NFS-export get_name path, reachable when a gfs2 filesystem carrying
> a crafted directory entry is re-exported over NFS.
> 
> Reject entries whose name length exceeds GFS2_FNAMESIZE before the copy.
> 

gfs2_check_dirent() is likely a better place to add the validation.

Andy

> Fixes: b3b94faa5fe5 ("[GFS2] The core of GFS2")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> ---
>  fs/gfs2/export.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/gfs2/export.c b/fs/gfs2/export.c
> index 3334c394ce9cb..7b28f1eb9ad0d 100644
> --- a/fs/gfs2/export.c
> +++ b/fs/gfs2/export.c
> @@ -76,6 +76,9 @@ static bool get_name_filldir(struct dir_context *ctx, const char *name,
>  	if (inum != gnfd->inum.no_addr)
>  		return true;
>  
> +	if (length > GFS2_FNAMESIZE)
> +		return false;
> +
>  	memcpy(gnfd->name, name, length);
>  	gnfd->name[length] = 0;
>  

