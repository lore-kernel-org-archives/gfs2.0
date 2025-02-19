Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0931F2BAD
	for <gfs2@lists.linux.dev>; Wed, 19 Feb 2025 16:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739981728; cv=none; b=DA/WPww3L5/L9MyiZ+9rsCumx/mcX3awP7d3EHio0m8fY/PuWfUOxmb+LZjrTFJXfVrRpsLh4/+KZ7Geba+2fq4RvJyVyOGxF45icfkj3nDzeFDrV92SASsoQjs0tyy5qTlfbeJngmrQw3T1db6vMezkhAUcXmfby4lnD9wHqcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739981728; c=relaxed/simple;
	bh=TKriWIzFRYjTVypLjq0Grj5BbxlDZ8sK36y8GTRd3NM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=lfdIkdp7YUFqEbgoLxJJv2FyZtITgcyHMO00gnBz7KstJ7cdxN6Erum6FTEoavJ9UWtz9K25wKehuZ4A5rLoCpoNJ0Jd1m2f6QOHCLqikmcKOaZvZ8ki3x9vtQyA5/Exdi+LG4fvIpVWTK3l+99ZW0dWsAFGMrvLFJ2xhsJj1i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GY7X9+N9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GY7X9+N9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739981725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jGkJdDvpuOniFmqRp0qlz1PjP9Ki4fEMF6d1RNsvkJU=;
	b=GY7X9+N9lUvjI6W4gE9IMEfkt2boOxdkQUnY1GXMacirmhl5nnZ4WpqJJb/GomQFK7zQBA
	fLUd0bsB4fnSPiHFzlpHNU+eZYzn2HUiKaduV5R8wZ7AzaYrcp/NYwOwwymlos9WVj8wl6
	hpap5dWZcDSXwV7+3Vfk/B2Zd1E+bL4=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-Yod61CmxPY6Jxoiq02gtuQ-1; Wed, 19 Feb 2025 11:15:24 -0500
X-MC-Unique: Yod61CmxPY6Jxoiq02gtuQ-1
X-Mimecast-MFC-AGG-ID: Yod61CmxPY6Jxoiq02gtuQ_1739981723
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-47198c965e1so121270611cf.3
        for <gfs2@lists.linux.dev>; Wed, 19 Feb 2025 08:15:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739981723; x=1740586523;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jGkJdDvpuOniFmqRp0qlz1PjP9Ki4fEMF6d1RNsvkJU=;
        b=wf2JsekuP0zIi8chbtJmFZScQ4+fYsezWR/8TrujpycTJcLWmF163VStIHi5BztiiZ
         kxZ7TTJI/f340jSDRN3xWkuFMSFT1ioULsbKheSTm3Kkn65XLUWfNYMk3431csNFK9wR
         fpdj9SPGTaIc4PCw97KsTYgjfRD6rmShd7Nmi+vPydp056+p+fw7KFOBrpb/Lg6Uplzh
         iKcYG0wqPiM3CS8cyNrIalo3YDvIgJWqdOeFGphDEkJ3DmYR4+DVymzXLYaDNd5qF0js
         v/cdtewgDhi9c5IdcAksJTObQBgZNSakjZy8UQrz/S9rHePR0y8TCtcM4EcPzoaG/s81
         auTg==
X-Gm-Message-State: AOJu0Yxk5QEafnP1SqpOXahmOGpzKEq2g3BagPoo9H6iNTAr63kVsnb9
	MtnF1yYGwYQrdTuNuQGRg3IcK05H7RMv9CeSVwvk9DIZ97hI2ARpPCqxoJ24R5/eA/GrJ6WxF7G
	vg+SAmd2/gtvXWRtJTJUdOe0Ss0c3Ztqwd60JOtLBc1oeSLkpzAxPs1meNCk=
X-Gm-Gg: ASbGncscCLcJIh2SrtGzcZoM3ERcPJTFRUhZ/5QOQn6i37jywUxkIq/VYny0gKaGEPh
	eSsNb0nyUbfHUkvRuso7NpMbbsy+/+T84tEwCnFLynw2rTHxHG4znMjyyFAEaJzSYFVwlZih+u8
	RbI2BOmYD6rtr3ntw+xfKfNbG4MSDc6MLZ36/hwBByJjjvBk+A2vXw5yuiSgycMZnDKHQBkczB2
	wvxQJlHhdoCOPzrj+Nn7VwT8/q6Bw4UuOGOaomAjeUL6+EsxidNhfiNxJEvuzFkOQbFym6niDQ2
	BWy+wwo6a2MGq9eIDOBxIOoGq8wzhFfhVeDPSQhZi4TWyNSqlJrSSGLCSKfvAgaU
X-Received: by 2002:a05:622a:1807:b0:472:7ce:2340 with SMTP id d75a77b69052e-4720824e081mr69495051cf.14.1739981723684;
        Wed, 19 Feb 2025 08:15:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEpyDhEB4rlyAc2AleyuTibBx/RVq6rss+HBXxisU66jCp++MMWkNo3NDKY5J+gi0Q6mFCcng==
X-Received: by 2002:a05:622a:1807:b0:472:7ce:2340 with SMTP id d75a77b69052e-4720824e081mr69494731cf.14.1739981723363;
        Wed, 19 Feb 2025 08:15:23 -0800 (PST)
Received: from [192.168.1.167] (cpc76484-cwma10-2-0-cust967.7-3.cable.virginm.net. [82.31.203.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471fe6c81e4sm23589321cf.44.2025.02.19.08.15.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 08:15:21 -0800 (PST)
Message-ID: <242c810d-9f69-45a4-9787-a053c0a4501b@redhat.com>
Date: Wed, 19 Feb 2025 16:15:18 +0000
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] gfs2_grow: Optionally allow not issuing discard
 requests
To: Mark Syms <mark.syms@cloud.com>
References: <20250219153654.351944-1-mark.syms@cloud.com>
Cc: gfs2@lists.linux.dev
From: Andrew Price <anprice@redhat.com>
In-Reply-To: <20250219153654.351944-1-mark.syms@cloud.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CeapNZKoTrQaxXA61wdMbP3hvKnWp2AX6jHmrz0iKe0_1739981723
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/02/2025 15:36, Mark Syms wrote:
> mkfs.gfs2 supports a -K option which disables issuing discard requests
> for unused blocks on the LUN. gfs2_grow does not have an equivalent
> option so even if the filesystem was originally created with the -K
> option a subsequent grow operation will incur the, potentially high,
> cost of performing the discard.

Looks good to me. Could you add an entry for the new -K option to the 
man page (gfs2/man/gfs2_grow.8)? A follow-up patch would be fine.

Thanks,
Andy

> 
> Signed-off-by: Mark Syms <mark.syms@cloud.com>
> 
> ---
> v2:
>   * Fix indentation of break statement
> ---
>   gfs2/mkfs/main_grow.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/gfs2/mkfs/main_grow.c b/gfs2/mkfs/main_grow.c
> index e378a668..2d74c3fa 100644
> --- a/gfs2/mkfs/main_grow.c
> +++ b/gfs2/mkfs/main_grow.c
> @@ -31,6 +31,7 @@
>   static uint64_t override_device_size = 0;
>   static int test = 0;
>   static uint64_t fssize = 0, fsgrowth;
> +static int skip_discard = 0;
>   int print_level = MSG_NOTICE;
>   
>   extern int create_new_inode(struct lgfs2_sbd *sdp);
> @@ -72,6 +73,7 @@ static void usage(void)
>   		"-T", NULL, _("Do everything except update file system"),
>   		"-V", NULL, _("Display version information"),
>   		"-v", NULL, _("Increase verbosity"),
> +		"-K", NULL, _("Don't try to discard unused blocks"),
>   		NULL, NULL, NULL /* Must be kept at the end */
>   	};
>   
> @@ -92,7 +94,7 @@ static void decode_arguments(int argc, char *argv[], struct lgfs2_sbd *sdp)
>   {
>   	int opt;
>   
> -	while ((opt = getopt(argc, argv, "VD:hqTv?")) != EOF) {
> +	while ((opt = getopt(argc, argv, "VD:hqTv?K")) != EOF) {
>   		switch (opt) {
>   		case 'D':	/* This option is for testing only */
>   			override_device_size = atoi(optarg);
> @@ -116,6 +118,9 @@ static void decode_arguments(int argc, char *argv[], struct lgfs2_sbd *sdp)
>   		case 'v':
>   			increase_verbosity();
>   			break;
> +		case 'K':
> +			skip_discard = 1;
> +			break;
>   		case ':':
>   		case '?':
>   			/* Unknown flag */
> @@ -207,7 +212,9 @@ static unsigned initialize_new_portion(struct lgfs2_sbd *sdp, lgfs2_rgrps_t rgs)
>   	unsigned rgcount = 0;
>   	uint64_t rgaddr = fssize;
>   
> -	discard_blocks(sdp->device_fd, rgaddr * sdp->sd_bsize, fsgrowth * sdp->sd_bsize);
> +	if (skip_discard == 0)
> +		discard_blocks(sdp->device_fd, rgaddr * sdp->sd_bsize, fsgrowth * sdp->sd_bsize);
> +
>   	/* Build the remaining resource groups */
>   	while (1) {
>   		int err = 0;

