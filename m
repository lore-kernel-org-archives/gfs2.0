Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6540716C683
	for <gfs2@lists.linux.dev>; Fri,  9 Aug 2024 23:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723244746; cv=none; b=Kmkd7vDXJFJ/AXOUQmYxov3qF3FUJGUPbv0qR5JXnljzmfCHMImrcq7KIMESG/zB5YQq3UWjFA25ytkPb3vtw+YFOiTQclewf/lOLTbxHo5NAKwmc6JBV9VnV+PtZYrNvFl9LDkLnM1N7BkfbtDuQr9FOl/wFIEQQxwOeUVHqJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723244746; c=relaxed/simple;
	bh=kip/j2N4MU6D8qAnWjrKI+qx/Op9j8h8o+o5qlLzWHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qfReOI/qk6CSiGqzC4lXav7LSOMUgSkuicOP84eEBxpoU4iyw9m6MpwKO4/K2KhSSaRj7bCyNOLVjcHuxz30XvM/ZbXwVuGzLNwR8SzKPZzDq9E1lsr83rFOvsvNxKsTfxfZdCVSvLqMVXUZa2Yve8si32NoMRUA5MELUWgKn7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=bf7oOV7C; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="bf7oOV7C"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7107b16be12so2159686b3a.3
        for <gfs2@lists.linux.dev>; Fri, 09 Aug 2024 16:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1723244744; x=1723849544; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nTDcrQgyeVMDCz81y0q/ZpfGE+ROsNi+zfVoOYVwgYs=;
        b=bf7oOV7CX7uSiLksn83nG+TReNhTZnbatJ91IVW8TbzE+bpHM29XoUAcmGH0njXtzY
         j1cLlY+54f9soxccAQB/zsLXl3fhQw+GZG+trXYxqPFyn/Q3lqIRQfHgNy9q221q/tfo
         BakSgkhjvkCW+QAl7j7Q5LYQnPRw07C4LylQSLZhMN7K+DrbO0CIGpMKj9ADkC9qREzx
         gUB1KbL20flkGJwWfNb5l4/Ikbeo4I6kRrcbAwC4W30/d9F/0zKTiJ8PngwIGYVf7X3I
         Q106oo0WTpfqx3HLIs452diUjampcK48+1wsY1ybgJ9jVHCrbu/SGlRMjz8BSKKx+Hwb
         l6uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723244744; x=1723849544;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nTDcrQgyeVMDCz81y0q/ZpfGE+ROsNi+zfVoOYVwgYs=;
        b=JVfw/mKAy6UfQKkOWGCBKr179V8WRGOh7vXB9FrMjtnkGZFmRA8dkKDtdlN2hNbNiD
         ho+gRPPIayWc41i493JjBdLYd4nNdkB6RucwGQOq77EB8C/AyFAz3DCeWGEJKTTBVfS+
         QIWEfGUY8i8IERkRld6cplg4T8bSC4ipNpZGjO7G7tNvMMH19NpkqgOKB+qJMMR/yxHW
         b6DJ/TaqjW4oaWkCtFLKlz2Pk8rJp3q1erovEW3HN2vnwEN/a8kbqzlC5GfvZNri8Zls
         n502QKXkLPdOd/jpoR4Uni707fc6+SWvBupGiAW7MUaBepOJNj9HPrf7FLSpzwyBqRgq
         IdOg==
X-Forwarded-Encrypted: i=1; AJvYcCU0WCw73HL3ofJrlkdVbM6co5d5BNxzRTnq59HK59dGTcElGMqBpy6VIY7GYX18ogP7QzR5ZznqHrMFy7d92NBvSCzM0w==
X-Gm-Message-State: AOJu0YzHFBxYn4xHwcwtck2vRTobxbinNTSFKwHF/gima3/wxKM4vbNM
	3wf9a9fHE7XIApkqayaoRh/Qv4FMrmAMFwCrxHUFZb/eovAvnRJjlyX602UuKPQ=
X-Google-Smtp-Source: AGHT+IFCLSKyX0YVdtgGjZlbE/P8XJNJvz1WTxeb29RoLQ3QQ2JHQrcHUzNiNqGJfplvUdPb5Eejhw==
X-Received: by 2002:a05:6a00:cd0:b0:70d:ca45:a004 with SMTP id d2e1a72fcca58-710dc760083mr3294863b3a.13.1723244743590;
        Fri, 09 Aug 2024 16:05:43 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-47-239.pa.nsw.optusnet.com.au. [49.181.47.239])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710e58735f9sm267932b3a.2.2024.08.09.16.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 16:05:43 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1scYg0-00BQM9-1s;
	Sat, 10 Aug 2024 09:05:40 +1000
Date: Sat, 10 Aug 2024 09:05:40 +1000
From: Dave Chinner <david@fromorbit.com>
To: Josef Bacik <josef@toxicpanda.com>
Cc: kernel-team@fb.com, linux-fsdevel@vger.kernel.org, jack@suse.cz,
	amir73il@gmail.com, brauner@kernel.org, linux-xfs@vger.kernel.org,
	gfs2@lists.linux.dev, linux-bcachefs@vger.kernel.org
Subject: Re: [PATCH v3 13/16] fsnotify: generate pre-content permission event
 on page fault
Message-ID: <ZragxG7wkTsD1sdy@dread.disaster.area>
References: <cover.1723228772.git.josef@toxicpanda.com>
 <192b90df727e968ca3a17b6b128c10f3575bf6a3.1723228772.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <192b90df727e968ca3a17b6b128c10f3575bf6a3.1723228772.git.josef@toxicpanda.com>

On Fri, Aug 09, 2024 at 02:44:21PM -0400, Josef Bacik wrote:
> FS_PRE_ACCESS or FS_PRE_MODIFY will be generated on page fault depending
> on the faulting method.
> 
> This pre-content event is meant to be used by hierarchical storage
> managers that want to fill in the file content on first read access.
> 
> Export a simple helper that file systems that have their own ->fault()
> will use, and have a more complicated helper to be do fancy things with
> in filemap_fault.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

....
> +/**
> + * filemap_maybe_emit_fsnotify_event - maybe emit a pre-content event.
> + * @vmf:	struct vm_fault containing details of the fault.
> + *
> + * If we have a pre-content watch on this file we will emit an event for this
> + * range.  If we return anything the fault caller should return immediately, we
> + * will return VM_FAULT_RETRY if we had to emit an event, which will trigger the
> + * fault again and then the fault handler will run the second time through.
> + *
> + * Return: a bitwise-OR of %VM_FAULT_ codes, 0 if nothing happened.
> + */
> +vm_fault_t filemap_maybe_emit_fsnotify_event(struct vm_fault *vmf)
> +{
> +	struct file *fpin = NULL;
> +	vm_fault_t ret;
> +
> +	ret = __filemap_maybe_emit_fsnotify_event(vmf, &fpin);
> +	if (ret) {
> +		if (fpin)
> +			fput(fpin);
> +		return ret;
> +	} else if (fpin) {
> +		fput(fpin);
> +		return VM_FAULT_RETRY;
> +	}

Logic is back to front.  Both paths have to check for fpin,
only one fpin path needs to modify ret:

	ret = __filemap_maybe_emit_fsnotify_event(vmf, &fpin);
	if (fpin) {
		fput(fpin);
		if (!ret)
			ret = VM_FAULT_RETRY;
	}
	return ret;

> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(filemap_maybe_emit_fsnotify_event);
> +
>  /**
>   * filemap_fault - read in file data for page fault handling
>   * @vmf:	struct vm_fault containing details of the fault
> @@ -3299,6 +3391,19 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
>  	if (unlikely(index >= max_idx))
>  		return VM_FAULT_SIGBUS;
>  
> +	/*
> +	 * If we have pre-content watchers then we need to generate events on
> +	 * page fault so that we can populate any data before the fault.
> +	 */
> +	ret = __filemap_maybe_emit_fsnotify_event(vmf, &fpin);
> +	if (unlikely(ret)) {
> +		if (fpin) {
> +			fput(fpin);
> +			ret |= VM_FAULT_RETRY;
> +		}
> +		return ret;
> +	}

Why do we or in VM_FAULT_RETRY here where as the previous case we
simply return VM_FAULT_RETRY? Which one of these is wrong? If both
are correct, then a comment explaining this is in order...

-Dave.
-- 
Dave Chinner
david@fromorbit.com
