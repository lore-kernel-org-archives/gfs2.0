Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E33E146588
	for <gfs2@lists.linux.dev>; Thu,  8 Aug 2024 22:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723154627; cv=none; b=tn6sSG5dRf0E+IEQzNu4to5gExQFhB1lrw9eyl1aZfkxsoj9Ntw/IB7G9Firqoa9xh7i0G/SOArqCCmwoFIv5Qj60B0TpwqAmVxxoPsutN8b03DL2dmkJAPoiaKW67nsrycmvDYl4HJj4iZQRDvYRtrFqURzoffKIU6uXquMnEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723154627; c=relaxed/simple;
	bh=uNcUY8yHRyYsZM3h0TFO6DExo7cRKiSaWW9bFFCHjf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lI7GlZFxqARJBByv1zQeaQ7xGGiDvOSovGjJFEnu43zyvxllPTwyrUjIjkTep4bDj1Xnhtk1P0pZSN9YW/7iNOgw7cxY0ZmHhT7IuES5QKq6nOox1Wt8OLFQKaHozR8zh/D86Ickg5nsCXKEIHh8hmTixMintoypy9qIrAGBZgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=KtIDcO1z; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="KtIDcO1z"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7a1be7b7bb5so1124230a12.0
        for <gfs2@lists.linux.dev>; Thu, 08 Aug 2024 15:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1723154625; x=1723759425; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VovAhXzqSeyRFjRdkVXxIjBd1uS33PY0oNHckm00eHs=;
        b=KtIDcO1z8RT2a/AY/F2fJpJjOhia7citvNIRRIgxm7FSHUg86GpVoguYDoUd1ljpWv
         Bw9lg9+wUc8K6Rs6BlbGHYrsTp8xJnNrmGZFAhLtt3q6O0jNmACyP2B95jckGQDcHPq2
         uG43TKaIaZdTUoeXpfibUA+DSWMVEkkJ+VQwhByNXsb+PRsmKVF9DzKE36gmWiv/QUjD
         KAZdEWErRNtsC1PVGxNVcZyQLnYDwuBntr4x5/TugqRtpGpbG07ahxEPyCbRtp8zXgxS
         wdEx1u9s5JKm3zL3WY2icMUPlHDcSompXd12pN/vUa16YmDfTgB9tWhzwVFuNdt3ccTt
         ibdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723154625; x=1723759425;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VovAhXzqSeyRFjRdkVXxIjBd1uS33PY0oNHckm00eHs=;
        b=Eax852Mf9NnZiCC2z+j12oJaMXPOKGqllsVGUhC1rPXHEVkH6kbgz7a9sUorP9FAi8
         4NPmHAHYyiVkPgQDth2l2PnAiFr5FeLj9Kp04oXVsTZUYgDDkfrFZawWwc76NBJBf8b0
         CguRXt3xSbjOySQUlVR+3LeK8Fc4Yc+0AmdnWVowWw0x9l7lfNOHG8EPpVhXrcGaha66
         pG4zu0Euayw9X5EMshu6uzzacclprdjv6t+ExzxTc1aeelWZZekzWw+ldEUKVS1eLnlg
         MQN2ZXMGg4wiIfNgly/dqpEn5EzM4uUUOF5WmrLz40D2g5YkB3KLepTsWvrKGGC0IDeJ
         n7uw==
X-Forwarded-Encrypted: i=1; AJvYcCWqv9PVOXbVto+1McI+xLX5xUWmhUMYdsNO1M4R/lC7W2JSpHyN1+33VUvrpvIDwAqBn6s4eR+HgT21Amyz7UnGNcVV5A==
X-Gm-Message-State: AOJu0YyvLCMEc2M2zhFev5dW9+TYj2kLhetULA0rbIhcHy5W/+oCwi08
	ISCrkgyVlbyVPi/ic0Rq8xKa8555iCNgfRpur8Yrbf9Rl9wDK65DGFEyr3jdes0=
X-Google-Smtp-Source: AGHT+IE5dO8WHZC6Pz9g72R0dboQ8rfRXb+Uzl5pZcpIdVcM7rWuMMHNr1EwN1H2Ba6s/xKz5Hjnbw==
X-Received: by 2002:a05:6a21:271e:b0:1c4:c160:2859 with SMTP id adf61e73a8af0-1c6fcf32732mr3245526637.31.1723154624900;
        Thu, 08 Aug 2024 15:03:44 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-47-239.pa.nsw.optusnet.com.au. [49.181.47.239])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d1c9c9f03csm1642587a91.26.2024.08.08.15.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 15:03:44 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1scBET-00ACDg-2F;
	Fri, 09 Aug 2024 08:03:41 +1000
Date: Fri, 9 Aug 2024 08:03:41 +1000
From: Dave Chinner <david@fromorbit.com>
To: Josef Bacik <josef@toxicpanda.com>
Cc: kernel-team@fb.com, linux-fsdevel@vger.kernel.org, jack@suse.cz,
	amir73il@gmail.com, brauner@kernel.org, linux-xfs@vger.kernel.org,
	gfs2@lists.linux.dev, linux-bcachefs@vger.kernel.org
Subject: Re: [PATCH v2 16/16] xfs: add pre-content fsnotify hook for write
 faults
Message-ID: <ZrVAvQLfP8fNSJwx@dread.disaster.area>
References: <cover.1723144881.git.josef@toxicpanda.com>
 <aa122a96b7fde9bb49176a1b6c26fcb1e0291a37.1723144881.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa122a96b7fde9bb49176a1b6c26fcb1e0291a37.1723144881.git.josef@toxicpanda.com>

On Thu, Aug 08, 2024 at 03:27:18PM -0400, Josef Bacik wrote:
> xfs has it's own handling for write faults, so we need to add the
> pre-content fsnotify hook for this case.  Reads go through filemap_fault
> so they're handled properly there.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/xfs/xfs_file.c | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index 4cdc54dc9686..585a8c2eea0f 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -1325,14 +1325,28 @@ __xfs_filemap_fault(
>  	bool			write_fault)
>  {
>  	struct inode		*inode = file_inode(vmf->vma->vm_file);
> +	struct file		*fpin = NULL;
> +	vm_fault_t		ret;
>  
>  	trace_xfs_filemap_fault(XFS_I(inode), order, write_fault);
>  
> -	if (write_fault)
> -		return xfs_write_fault(vmf, order);
>  	if (IS_DAX(inode))
>  		return xfs_dax_read_fault(vmf, order);
> -	return filemap_fault(vmf);
> +
> +	if (!write_fault)
> +		return filemap_fault(vmf);

Doesn't this break DAX read faults? i.e. they have to go through
xfs_dax_read_fault(), not filemap_fault().

-Dave.
-- 
Dave Chinner
david@fromorbit.com
