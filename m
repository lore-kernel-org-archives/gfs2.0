Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7353FD4
	for <gfs2@lists.linux.dev>; Wed, 19 Feb 2025 19:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739993215; cv=none; b=niFakMbmbk+fyHACsJgoQHmxIWJLs4deTaPd4gFh/bPd9sFk8IkGOrmq7COOm0tpctgrcAN2S5miU20wLpPiPL98NeHSlBhcfuPC1acKweiaOCCVCc9VS6p8OohgHKE91JsJM72zpIuPAm4ytx/al0my+vCFQyBNYZ893cldg14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739993215; c=relaxed/simple;
	bh=E4wp2g1JVJwQUig8w3PJtOhOGjrh4V3kXt2sNxV8qwA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=ic6UCxNVaAH/id9eaFiaQx3EzkuYnkVwynEIUtPpMues6O27zOo6AXacS/u/kqbU1n2qTMeCh7y51aQVKz3xDeyaSw6a2NSekF9wxGmt9dYfXKRE7pdFst8accSWFKHCCEfn4DjLAWzTuvXtkfuoS8RFz6qZxFPHoS1VnyeBxJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dj5X1/lc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dj5X1/lc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739993212;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CbW9OPwWeon27bEX+5aszi0YISYRRhZ0398uatwbEJ8=;
	b=Dj5X1/lcgVzVhw/p2otv2Mr9rPaMGy28Q8bejKFDZTKa3Z2dyBxzJKcMA9Ou5oDPyewiyJ
	k0YteRMYVuWHGhxZoZaiqoHEBhLRHvu6GmLcmgAYyAp7NUMF8dbW0vwwWFtbJ0HGyEFYSR
	eoleFP5t918SpihxAqplMhvtxt34iuI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-382-fifqbNr4OT2998tY1H0o9A-1; Wed, 19 Feb 2025 14:26:48 -0500
X-MC-Unique: fifqbNr4OT2998tY1H0o9A-1
X-Mimecast-MFC-AGG-ID: fifqbNr4OT2998tY1H0o9A_1739993207
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-38f4c0c1738so142636f8f.1
        for <gfs2@lists.linux.dev>; Wed, 19 Feb 2025 11:26:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739993207; x=1740598007;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CbW9OPwWeon27bEX+5aszi0YISYRRhZ0398uatwbEJ8=;
        b=v3afWhwv3aq/7As7ZRz+lX1hWGRhvz/STQ0gBd3YXEEJBbP8kP9AGvtFY/WqWB/mqJ
         U9TXVk/idk4wInyBKIFOLCut7EbQnxtNJHNex2Sno7bi3mih1dBmmyTnyRt1hp1NUA+7
         C21HQNA8AY+U0ldPsZAshGMhMqRq1afqGYt0rHttD1FFq+qT36ColgB5bTFiopd+YFt3
         3YZsWazZq1KPsI16TdEQtgsRiHjfjjN9KRNv6TwemcN94jPurUYH3O1yuntHlq/dU/l1
         EBinvMBX0hsSFPNZuC3zMyGLfbMCJ1UhBubneObLajORy+JlIvOuPZbVppnFjyTNKJBS
         l+pg==
X-Gm-Message-State: AOJu0YzCn5Go+KT8vYb+tKsD9hWP96UW+fPEo9uhtR3f6hopXB8riI1U
	rM9toyLlpJlieu6BuKjW/ia+PL26u5bDG7B8+Z+qsKspJ7t2O1xE0SPBv9sQXG2iJBZ87JXN7LO
	ATEEBlac/q+4vM/DO9765lSk1RsW45jABRSZCNtjkEWYT2VzgCpo=
X-Gm-Gg: ASbGncuqMFDlh2cR1ya6WhJ22gMd+jFWoqD7UC0zXDiwuyrgmKUz+OzzKlYfwOFGWJv
	bXmpEtWe/5+NhlXXJc2TWVpohPWE1hKXaeKsI0TqEE1RWbpFTGHl81+ovn7SE9NSAqClUPj3k2k
	Ss0fhVYKlJU8F3RlnvLhkqTdd80xQ0+mzIAkRlUMtIECySL2ZJWEsDwne6tSfL3pFgFX/5aM/Zi
	0kctWF+I/TFSfXCm+QU8p/0f4ogWl4eMCOxQ2pTmLoxaafWaX9h7ZuePHwgNtxCzXn2aw0ionr7
	gSh7f6qg3GzeUuxVLLgnNtjFeob/v+3bp94osblADOdc1mufw2U6fLSkxR5T3iTU
X-Received: by 2002:a05:6000:188d:b0:38d:bccf:f342 with SMTP id ffacd0b85a97d-38f587e16dbmr5144744f8f.43.1739993206719;
        Wed, 19 Feb 2025 11:26:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHWusebGOt0iGIWgkMdFEtzuHiUZ8JS5hdIJkVYHWvWcNzzFT9PxsVv57+BawJtOMXd1J4GWQ==
X-Received: by 2002:a05:6000:188d:b0:38d:bccf:f342 with SMTP id ffacd0b85a97d-38f587e16dbmr5144724f8f.43.1739993206336;
        Wed, 19 Feb 2025 11:26:46 -0800 (PST)
Received: from [192.168.1.167] (cpc76484-cwma10-2-0-cust967.7-3.cable.virginm.net. [82.31.203.200])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d8f1csm18847876f8f.69.2025.02.19.11.26.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 11:26:45 -0800 (PST)
Message-ID: <9ed4afc3-c3ad-4411-8196-404a6063aeaf@redhat.com>
Date: Wed, 19 Feb 2025 19:26:44 +0000
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] gfs2_grow: Optionally allow not issuing discard
 requests
To: Mark Syms <mark.syms@cloud.com>
References: <20250219162315.377253-1-mark.syms@cloud.com>
Cc: gfs2@lists.linux.dev
From: Andrew Price <anprice@redhat.com>
In-Reply-To: <20250219162315.377253-1-mark.syms@cloud.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: cW6jYleJJyyY3u3BYZo9Bqe8NRm1WvJC9V_cb5sjvak_1739993207
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/02/2025 16:23, Mark Syms wrote:
> mkfs.gfs2 supports a -K option which disables issuing discard requests
> for unused blocks on the LUN. gfs2_grow does not have an equivalent
> option so even if the filesystem was originally created with the -K
> option a subsequent grow operation will incur the, potentially high,
> cost of performing the discard.
> 
> Signed-off-by: Mark Syms <mark.syms@cloud.com>
> 
> ---
> v2:
>   * Fix indentation of break statement
> v3:
>   * Update man page with the new option

Applied, thanks.

Andy

> ---
>   gfs2/man/gfs2_grow.8  |  6 ++++++
>   gfs2/mkfs/main_grow.c | 11 +++++++++--
>   2 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/gfs2/man/gfs2_grow.8 b/gfs2/man/gfs2_grow.8
> index f1ba5e4e..ed962dca 100644
> --- a/gfs2/man/gfs2_grow.8
> +++ b/gfs2/man/gfs2_grow.8
> @@ -38,6 +38,12 @@ Prints out a short usage message and exits.
>   \fB-q\fP
>   Be quiet.  Don't print anything.
>   .TP
> +\fB-K\fP
> +Do not attempt to discard the block device contents. Issuing discards to the
> +device allows some solid state devices and sparse or thin-provisioned storage
> +devices to optimise free space. Other devices may emulate this behaviour by
> +zeroing the device contents, which can be a slow process.
> +.TP
>   \fB-T\fP
>   Test. Do all calculations, but do not write any data to the disk and do not
>   expand the filesystem. This is used to discover what the tool would have done
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

