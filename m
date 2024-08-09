Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51B91607AF
	for <gfs2@lists.linux.dev>; Fri,  9 Aug 2024 23:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723244792; cv=none; b=repi9EO90kzcr95uoPi172L2qgiW0ozt31Rd6/Rds79BTl27GkcsMmGqHgGuGsEbDphU38Zp9b4Idr0eAe670xkmWBYANSkIfcMRh88UdKtGuZYCpbnI83oQtV9Bso48kR0NCMWjxoRU4fdX0RalDTxA0+hs/hD0NobBntQk+oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723244792; c=relaxed/simple;
	bh=bZwx8Awwb4wvIVQy1/czHFUPIfNr4eP4NZCskia242k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nALN+4CT0KXB4ZY2g+8EFy8PmScSe4Vgscc7nThi8/D4mqVCxb4kILpEc33PAM6IJYig2RzCO/JXDfpeTBPMRl5gCS31ljlsgnhdvmLq0WIO5oGzowXZjJtFiY6Mus7x6jjMXgp/m4m5MEcv1ojhzyT0dBDT62I1GubpowMOjKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=GLxSgqHz; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="GLxSgqHz"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-710d1de6e79so1504906b3a.0
        for <gfs2@lists.linux.dev>; Fri, 09 Aug 2024 16:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1723244790; x=1723849590; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qLXIcRQfqVWPyILBS4NCRfPx9XX6KjuIPWCqoJLoWeA=;
        b=GLxSgqHzL6JifxoEgTaEUFYFv94ywIrYU3x4b5yBpJVbqionUY0MPUMTgZo9ePXYjc
         Zu9EYF2Rx0S8IJ0+jL9R93trt7Sm3l03l8ZWMwLkRSc5Cb9hTBKtiYWyaRRqcamaen6j
         OGmynn16yQQXlbc2EDd3JHgbDeO31zkE3TWdrWU5sLyD95mB1TWfN8h4pI58eS87hIbm
         b95T0kz6q8psXh1UnUNX8iSwygCR+KXxhV8DKCCbgl3t+4lB+80mkzrTwsniLUtguKbu
         D51rJVKQ7lV4AYMBgQwhNYtF2K0nDIzhWhTtsCA0t6Tfauss7hrFGkDrPD3mV1T+5KJY
         vp2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723244790; x=1723849590;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qLXIcRQfqVWPyILBS4NCRfPx9XX6KjuIPWCqoJLoWeA=;
        b=IIaQwsz70mCvVpzBiupdaXtMfJ4m8ojJB79QWOoQEeRenmhuAvynTQPUE6WnpIcYT2
         4Y2aUELvrkv94Ljhc+eBmeEv6LV2TBnN86Al0a9ze9E/nhvUuOVFQyp/3Q2hjkONKLL2
         bgEc6xyPjGucOgbPdiJIxEJd3b3NibqLVmRZ1wUx34B4yjchp7o9FgXtUtC2pmH0SkQf
         0PjbDxQ9u9mQOwuVbNcre7RD61+bTY4RQpHOhFAx0TRh8Zf+lOhkMQzADFbZmyN8hvL6
         gfSdF1vaxDgZH/WsCc3LhVNnKbtK16PY4RDklHGDpt3ObjxPfA5l9ucMmAjN8u3EGooO
         VJHg==
X-Forwarded-Encrypted: i=1; AJvYcCWflhGEIdTXZMIttpe6x11R55+X4eRaauyH//iDBnIWpueLGZ4fLwVcyxGAl9G1lTvba3rGzCZCr5a48ycPbJ1anJlz7g==
X-Gm-Message-State: AOJu0YzxBwyv0bq4DdFhEbYxNEF16tV8DYFZ/mGxNygecPbE7xojZvgO
	yF6RZvN+YExayHPRwNlSANJT9oGR1igoo3AoQq/za33pA951y0R7w1TALcEfYnw=
X-Google-Smtp-Source: AGHT+IEUU8G/DVGE6NlsSYImmjk9rN+qyR0QXuoHxE6GCaGPWCZFRMYYJIt81OTDQfegBeHuVGXukw==
X-Received: by 2002:a05:6a00:2d97:b0:705:a450:a993 with SMTP id d2e1a72fcca58-710dc762037mr3670855b3a.17.1723244789985;
        Fri, 09 Aug 2024 16:06:29 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-47-239.pa.nsw.optusnet.com.au. [49.181.47.239])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710e5ab79casm258567b3a.199.2024.08.09.16.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 16:06:29 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1scYgk-00BQOS-1c;
	Sat, 10 Aug 2024 09:06:26 +1000
Date: Sat, 10 Aug 2024 09:06:26 +1000
From: Dave Chinner <david@fromorbit.com>
To: Josef Bacik <josef@toxicpanda.com>
Cc: kernel-team@fb.com, linux-fsdevel@vger.kernel.org, jack@suse.cz,
	amir73il@gmail.com, brauner@kernel.org, linux-xfs@vger.kernel.org,
	gfs2@lists.linux.dev, linux-bcachefs@vger.kernel.org
Subject: Re: [PATCH v3 16/16] xfs: add pre-content fsnotify hook for write
 faults
Message-ID: <Zrag8qezssak5rVY@dread.disaster.area>
References: <cover.1723228772.git.josef@toxicpanda.com>
 <89eb3a19d19c9b4bc19b6edbc708a8a33a911516.1723228772.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89eb3a19d19c9b4bc19b6edbc708a8a33a911516.1723228772.git.josef@toxicpanda.com>

On Fri, Aug 09, 2024 at 02:44:24PM -0400, Josef Bacik wrote:
> xfs has it's own handling for write faults, so we need to add the
> pre-content fsnotify hook for this case.  Reads go through filemap_fault
> so they're handled properly there.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/xfs/xfs_file.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index 4cdc54dc9686..a00436dd29d1 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -1328,8 +1328,13 @@ __xfs_filemap_fault(
>  
>  	trace_xfs_filemap_fault(XFS_I(inode), order, write_fault);
>  
> -	if (write_fault)
> -		return xfs_write_fault(vmf, order);
> +	if (write_fault) {
> +		vm_fault_t ret = filemap_maybe_emit_fsnotify_event(vmf);
> +		if (unlikely(ret))
> +			return ret;
> +		xfs_write_fault(vmf, order);
> +	}
> +
>  	if (IS_DAX(inode))
>  		return xfs_dax_read_fault(vmf, order);
>  	return filemap_fault(vmf);

Looks good now.

Acked-by: Dave Chinner <dchinner@redhat.com>

-- 
Dave Chinner
david@fromorbit.com
