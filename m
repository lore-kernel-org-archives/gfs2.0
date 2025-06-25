Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B572229B20E
	for <gfs2@lists.linux.dev>; Wed, 25 Jun 2025 15:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750866305; cv=none; b=MEgQvpVsgDS9kwqXykLPXF70iesG+9kboPTUazbObNiJ6Hc+x/AbPFYHECfGE1SlIIOXXY9EnW+PQD8uo30vIBkEzItEt+B1YsewzMwSK/LrK6siCqxuqyJSL4qzk6vAXa8EfIbcDtwrt/Qbpz+Sn9AOnmaz13cPqgZsETQt7lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750866305; c=relaxed/simple;
	bh=hW/6m1/IVovvjQyrM0zoK+5rKyQCDSNy64NWdJi1Z+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lNcU5RByRR5XpT4StYkJSv+FQ+5pwNDjrc6WuLyM0VPh65EkD/LynJdxmrxxeMdYpvxld0XllNOim9z2lpkF9lr34OpIfmBB9XueHNOf73rZgCGj1GkxqNKp499y/tKDPlx5KsEpfwv4oEjawQppMrdc+0RKFJCOj/gTqc80SRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hywM/p2o; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hywM/p2o"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ae0bc7aa21bso5594666b.2
        for <gfs2@lists.linux.dev>; Wed, 25 Jun 2025 08:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750866302; x=1751471102; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iocf3xZEV33qVQt+76WbLL52e+K++YTQHmhfnQovIf0=;
        b=hywM/p2oDIrQ2Yivfft2xq9DCaflPsRDFRE3adF2SQt4kEDOh0SFr/6L/Clc43dKkU
         Y9DuIWJeeKr6llTRvRqVGNFyCcmga643U2COnI7WEo+A0mxXWeQg8oPaGC1/IM3r/88F
         n5MN9u5RHiHU1lOJ1leDSvdsINXsy+ts/s4Jo4mF1bh4dKiVaZLC/UsxRw5iAvyXdnx0
         FuIwb1hMBIDetwU1PBFgfc5GUXwtWl4862nYmFFelp+M+r7JgrbSFFa/IAzg7/Ej4TYi
         gNxNq+WkGD2g0WnkKQPbO3y2kcq8wTZiD5k1oqI8KzrhBsaSwqzTmnm3T69LlDgRDEOT
         fi2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750866302; x=1751471102;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iocf3xZEV33qVQt+76WbLL52e+K++YTQHmhfnQovIf0=;
        b=b43yT9vwgVr68DWVqOs9jHYhQr+Dx9c3GEDSJ4bYDStOBDu5sqNmRckvwkYsrd7Co8
         rUuSKA8dWi7GEO7Ii/iZqjN5UkGR8yjsoyaTW02gpor3eDSMioxNakFQ5gXsi58rskV/
         FIJ45ytVmAPx7+fOtvx5QC1l+moKJI4mJnzpyUEhOXKoVhuiFk9VjglDpJAqJpkYkVMo
         H80HK+nBTDRhjBUukMp6T5vmxTEiPuSJum6eRuz/iMyASoEc6Ore4VAgXzGR7ocaZUrA
         41lTC61THvOmwZLetLawHSe+wr0b1N4yKLlgeI9Ea5n7mT0tzjephWX58a8oDTfBv3tf
         UkmA==
X-Forwarded-Encrypted: i=1; AJvYcCVNZfa9/XLWfcEU/pr04HVw5NLqe1MAppu4bDyCwPb8k4w5uBEKeI6tXP67t+ACmlVFPz56@lists.linux.dev
X-Gm-Message-State: AOJu0Yw1oS3mj7fD5aWXg8AONs/cXG75pCW/8YpGXO2KAlldGi1bze4m
	07EwfksuuVBln8ZqdmQkrHnLT2/kQCVuF/KF19LVXExSRXJ42Ktqm/F9A7iHcsmheVaaXQPuXOi
	STzVkki5PLsZFn/5A3C56/YrHiF/cSBY=
X-Gm-Gg: ASbGncum2VlYv5MdP9RZgLy/Pp78WXxxBScauGEqFuosY3V4gRBersrUDkes8+JL238
	98nme2ji4p8RqlcLwMmJQsIjt5JSWOUoDHbf/woIpTTmYMqEOeE0CFR27T4+Zt2Tk6lk6MaM/J4
	l/M2yILJedbV/s/KS+cHP43UNLVnfwqcDqiGmQU6mJGA0/
X-Google-Smtp-Source: AGHT+IFs+V/EDFHaGKcJwU9/xkWCRRHAYQqa7LBSGKtKl48ykcDE4Nb840e4+FWhpIDCiq8jKWE842faRWDZOh7ThxM=
X-Received: by 2002:a17:907:97cd:b0:ad8:8529:4f9b with SMTP id
 a640c23a62f3a-ae0bed82d81mr354973966b.38.1750866301696; Wed, 25 Jun 2025
 08:45:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CGME20250529113215epcas5p2edd67e7b129621f386be005fdba53378@epcas5p2.samsung.com>
 <20250529111504.89912-1-kundan.kumar@samsung.com> <20250529203708.9afe27783b218ad2d2babb0c@linux-foundation.org>
In-Reply-To: <20250529203708.9afe27783b218ad2d2babb0c@linux-foundation.org>
From: Kundan Kumar <kundanthebest@gmail.com>
Date: Wed, 25 Jun 2025 21:14:51 +0530
X-Gm-Features: Ac12FXz-WfD7KDK7gS4t-j71iOt-puRRwIJfu8WaOkNNWXA_hJ1q0mugrvCoDS0
Message-ID: <CALYkqXqs+mw3sqJg5X2K4wn8uo8dnr4uU0jcnnSTbKK9F4AiBA@mail.gmail.com>
Subject: Re: [PATCH 00/13] Parallelizing filesystem writeback
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kundan Kumar <kundan.kumar@samsung.com>, jaegeuk@kernel.org, chao@kernel.org, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, miklos@szeredi.hu, 
	agruenba@redhat.com, trondmy@kernel.org, anna@kernel.org, willy@infradead.org, 
	mcgrof@kernel.org, clm@meta.com, david@fromorbit.com, amir73il@gmail.com, 
	axboe@kernel.dk, hch@lst.de, ritesh.list@gmail.com, djwong@kernel.org, 
	dave@stgolabs.net, p.raghav@samsung.com, da.gomez@samsung.com, 
	linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	gfs2@lists.linux.dev, linux-nfs@vger.kernel.org, linux-mm@kvack.org, 
	gost.dev@samsung.com
Content-Type: text/plain; charset="UTF-8"

>
> Makes sense.  It would be good to test this on a non-SMP machine, if
> you can find one ;)
>

Tested with kernel cmdline with maxcpus=1. The parallel writeback falls
back to 1 thread behavior, showing nochange in BW.

  - On PMEM:
    Base XFS        : 70.7 MiB/s
    Parallel Writeback XFS    : 70.5 MiB/s
    Base EXT4        : 137 MiB/s
    Parallel Writeback EXT4    : 138 MiB/s

  - On NVMe:
    Base XFS        : 45.2 MiB/s
    Parallel Writeback XFS    : 44.5 MiB/s
    Base EXT4        : 81.2 MiB/s
    Parallel Writeback EXT4    : 80.1 MiB/s

>
> Please test the performance on spinning disks, and with more filesystems?
>

On a spinning disk, random IO bandwidth remains unchanged, while sequential
IO performance declines. However, setting nr_wb_ctx = 1 via configurable
writeback(planned in next version) eliminates the decline.

echo 1 > /sys/class/bdi/8:16/nwritebacks

We can fetch the device queue's rotational property and allocate BDI with
nr_wb_ctx = 1 for rotational disks. Hope this is a viable solution for
spinning disks?

  - Random IO
    Base XFS        : 22.6 MiB/s
    Parallel Writeback XFS    : 22.9 MiB/s
    Base EXT4        : 22.5 MiB/s
    Parallel Writeback EXT4    : 20.9 MiB/s

  - Sequential IO
    Base XFS        : 156 MiB/s
    Parallel Writeback XFS    : 133 MiB/s (-14.7%)
    Base EXT4        : 147 MiB/s
    Parallel Writeback EXT4    : 124 MiB/s (-15.6%)

-Kundan
