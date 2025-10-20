Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A0B314B8E
	for <gfs2@lists.linux.dev>; Mon, 20 Oct 2025 22:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761000396; cv=none; b=S2kKygefbxFIdIjhh4LBwvzymfYoQ17R9lM5hPQN3DJjM+qxOR01FiQBc4NosEpIRsMU5/RxAozakAcYt9NoWirzcHyAoemg1e62/dQwChg3DyDaW9iDLSiRAYesr0bhSMMK27UoPLAhrOD8ricn7+IHDYpBI4AYTD45AlSuhS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761000396; c=relaxed/simple;
	bh=tg/WtCVAyCNywj42umEUEmZjcANyQLTq/nfy6UTS1k4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oCVKLRXOzY9bUGf6v7Gsn4blx+uO2tCuSta+X9NMUZMkzTdyTZD09oHU0XY+izGRJAOKtR5lQMUSV5Cg/cZX8mK3PmfM5gUy+jrhsqkaTo8s1P1AjYeZUWx+DJZM39niSk095O7fP3EtdU24BSqFGLzj+JrNHZmT3G25oMfTTkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=g2kHwO7c; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="g2kHwO7c"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-26e68904f0eso48423595ad.0
        for <gfs2@lists.linux.dev>; Mon, 20 Oct 2025 15:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1761000394; x=1761605194; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bUtWq6BwnjWVaI8PPEZSZXu56vepaxMGdapsduu3y9o=;
        b=g2kHwO7cUY1PTlt26tJwOkBgQ7zErH/Rwxl10pwvx/3mFfVlM21Ne50MOPQk9MKKUN
         6cgyPi6bl0Zui70BxxhUwnlzPmzcUqgqw39FnYnsbYPs2czaX5K7kh9l8uB5WuWGoOsR
         hkDqVwhxZJbvYjzGkUBr/4L1KjktjYBGWid2HzBQJUOxQWhmunxrryACWaULSI22o2u6
         3zyvxiUltbITeu0Tj+occWaHOyZ6nTLPtAghiNYrpbY68mKT4OnnpsXKnUNeRf/QYsvw
         3GE5UOeHVKmA1pftpoCwKiYp0qhcA73+wnDT8fdbIDa4Whsnn0hIezplTLNjK40VY4kK
         SGBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761000394; x=1761605194;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bUtWq6BwnjWVaI8PPEZSZXu56vepaxMGdapsduu3y9o=;
        b=gOmxpQSiGnjRNgv3X6ZHLGseky32cpmqU8K4vzcct8YqfLnPc7asrBTDGdnDdBwZei
         4HKHoFzylDNuDdrZLBOsX09SDx8bLBxYQUxYqRmmWErvjtGDdUGvtftjn/aNUAQAFs26
         6hsNhq87ZCM0a/Jn8u9Yk/XBMqwMZMAOX3zW0PZC3hrbq2ZioN/k8tbyU8IaNeHYIUbA
         gcpTgpU3Yxv8vRW5rZFKOrNBQUxYWbdK6wp18GcDzxuZ28nScm2V3v3Mm/0LxxsJrXey
         1vA792SHimPM15KcVR2+7CjXxK/U6elNbcoiS2ejt1wLahdPwUpCGeC9UQ7LiQeaGsfv
         j+Iw==
X-Forwarded-Encrypted: i=1; AJvYcCXTDS/XJuOkz1hrLbXysFcQ19bKHX4vW+p07/2n79UVgU4uNDt0hDQxuuu+GuRimdOeugnN@lists.linux.dev
X-Gm-Message-State: AOJu0Yw/5u1LIpgZ/s+kFtB2Sbe7ByLOcvwfUQbBPkpNvC2y0UZqgDn5
	YBN7IQmxsslSrCrteBFPgnPBfat/u41AKa0gGKrwuPlGZnGRHRxcP1mIj09ckS2LBJc=
X-Gm-Gg: ASbGncsYt5jDXRKEK2/CBpaZ2aTDTOTov0EVuoVm0gkRQHD5/0mysVbu5yYnMzwshTA
	RFHbKECgWvkh7TKZbKrgSUTzQH07qGu4vc2e+LgRJkHbkFj56n495BcMpsowvwOJFH+dnBSDZxe
	5Yn99qFLWgzJ4UBoqv+a+7f2Lp01Jh7GAMBtoYCtaRht9m3aD9DOLRxtWvbWZpNWuZcykiG8jkV
	N9l1kM1XjAXEoPgZFSMQISFRnwkdzsiNdhDbOBy6UniSZxDxSb2/O7cTRBTXXrGyefyaNaFHbSr
	aqIQD7dQPU/JAP7pM5F/H1uokNJgDbjy0AAf6fskhkzuRICKBtJM53hQLJCbATFE1B1aA3gKRBM
	+1H9hN+zFgA3jEpX/+whK/mKYNQrZpWfk63AD3pKnQiZp2V5++1IrungRU2cnekMz4DWGH2xW/W
	Lb0pUkPFWc+WveCqdvNlc1m4SrrGy6jQ6noN6VQxzL5Xj8o2tmLL8=
X-Google-Smtp-Source: AGHT+IFUIIz9u3gROHoyBrX9GrfKv6A6QBpIppZbYxVF4pPYqH4Q7yX35XtiJX79fRgqZ/TJvN1KGA==
X-Received: by 2002:a17:902:d4c4:b0:25b:f1f3:815f with SMTP id d9443c01a7336-290cb65f80emr187540085ad.58.1761000394302;
        Mon, 20 Oct 2025 15:46:34 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-91-142.pa.nsw.optusnet.com.au. [49.180.91.142])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471d594esm90846765ad.72.2025.10.20.15.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 15:46:33 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1vAye6-0000000HVzd-2eTg;
	Tue, 21 Oct 2025 09:46:30 +1100
Date: Tue, 21 Oct 2025 09:46:30 +1100
From: Dave Chinner <david@fromorbit.com>
To: Kundan Kumar <kundan.kumar@samsung.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, miklos@szeredi.hu,
	agruenba@redhat.com, trondmy@kernel.org, anna@kernel.org,
	akpm@linux-foundation.org, willy@infradead.org, mcgrof@kernel.org,
	clm@meta.com, amir73il@gmail.com, axboe@kernel.dk, hch@lst.de,
	ritesh.list@gmail.com, djwong@kernel.org, dave@stgolabs.net,
	wangyufei@vivo.com, linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev,
	linux-nfs@vger.kernel.org, linux-mm@kvack.org, gost.dev@samsung.com,
	anuj20.g@samsung.com, vishak.g@samsung.com, joshi.k@samsung.com
Subject: Re: [PATCH v2 00/16] Parallelizing filesystem writeback
Message-ID: <aPa7xozr7YbZX0W4@dread.disaster.area>
References: <CGME20251014120958epcas5p267c3c9f9dbe6ffc53c25755327de89f9@epcas5p2.samsung.com>
 <20251014120845.2361-1-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014120845.2361-1-kundan.kumar@samsung.com>

On Tue, Oct 14, 2025 at 05:38:29PM +0530, Kundan Kumar wrote:
> Number of writeback contexts
> ============================
> We've implemented two interfaces to manage the number of writeback
> contexts:
> 1) Sysfs Interface: As suggested by Christoph, we've added a sysfs
>    interface to allow users to adjust the number of writeback contexts
>    dynamically.
> 2) Filesystem Superblock Interface: We've also introduced a filesystem
>    superblock interface to retrieve the filesystem-specific number of
>    writeback contexts. For XFS, this count is set equal to the
>    allocation group count. When mounting a filesystem, we automatically
>    increase the number of writeback threads to match this count.

This is dangerous. What happens when we mount a filesystem with
millions of AGs?


> Resolving the Issue with Multiple Writebacks
> ============================================
> For XFS, affining inodes to writeback threads resulted in a decline
> in IOPS for certain devices. The issue was caused by AG lock contention
> in xfs_end_io, where multiple writeback threads competed for the same
> AG lock.
> To address this, we now affine writeback threads to the allocation
> group, resolving the contention issue. In best case allocation happens
> from the same AG where inode metadata resides, avoiding lock contention.

Not necessarily. The allocator can (and will) select different AGs
for an inode as the file grows and the AGs run low on space. Once
they select a different AG for an inode, they don't tend to return
to the original AG because allocation targets are based on
contiguous allocation w.r.t. existing adjacent extents, not the AG
the inode is located in.

Indeed, if a user selects the inode32 mount option, there is
absolutely no relationship between the AG the inode is located in
and the AG it's data extents are allocated in. In these cases,
using the inode resident AG is guaranteed to end up with a random
mix of target AGs for the inodes queued in that AG.  Worse yet,
there may only be one AG that can have inodes allocated in it, so
all the writeback contexts for the other hundreds of AGs in the
filesystem go completely unused...

> Similar IOPS decline was observed with other filesystems under different
> workloads. To avoid similar issues, we have decided to limit
> parallelism to XFS only. Other filesystems can introduce parallelism
> and distribute inodes as per their geometry.

I suspect that the issues with XFS lock contention are related to
the fragmentation behaviour observed (see below) massively
increasing the frequency of allocation work for a given amount of
data being written rather than increasing writeback concurrency...

> 
> IOPS and throughput
> ===================
> With the affinity to allocation group we see significant improvement in
> XFS when we write to multiple files in different directories(AGs).
> 
> Performance gains:
>   A) Workload 12 files each of 1G in 12 directories(AGs) - numjobs = 12
>     - NVMe device BM1743 SSD

So, 80-100k random 4kB write IOPS, ~2GB/s write bandwidth.

>         Base XFS                : 243 MiB/s
>         Parallel Writeback XFS  : 759 MiB/s  (+212%)

As such, the baseline result doesn't feel right - it doesn't match
my experience with concurrent sequential buffered write workloads on
SSDs. My expectation is that they'd get close to device bandwidth or
run out of copy-in CPU at somewhere over 3GB/s.

So what are you actually doing to get these numbers? What is the
benchmark (CLI and conf files details, please!), what is the
mkfs.xfs output, and how many CPUs/RAM do you have on the machines
you are testing?  i.e. please document them sufficiently so that
other people can verify your results.

Also, what is the raw device performance and how close to that are
we getting through the filesystem?

>     - NVMe device PM9A3 SSD

130-180k random 4kB write IOPS, ~4GB/s write bandwidth. So roughly
double the physical throughput of the BM1743, and ....

>         Base XFS                : 368 MiB/s
>         Parallel Writeback XFS  : 1634 MiB/s  (+344%)

.... it gets roughly double the physical throughput of the BM1743.

This doesn't feel like a writeback concurrency limited workload -
this feels more like a device IOPS and IO depth limited workload.

>   B) Workload 6 files each of 20G in 6 directories(AGs)  - numjobs = 6
>     - NVMe device BM1743 SSD
>         Base XFS                : 305 MiB/s
>         Parallel Writeback XFS  : 706 MiB/s  (+131%)
> 
>     - NVMe device PM9A3 SSD
>         Base XFS                : 315 MiB/s
>         Parallel Writeback XFS  : 990 MiB/s  (+214%)
> 
> Filesystem fragmentation
> ========================
> We also see that there is no increase in filesystem fragmentation
> Number of extents per file:

Are these from running the workload on a freshly made (i.e. just run
mkfs.xfs, mount and run benchmark) filesystem, or do you reuse the
same fs for all tests?

>   A) Workload 6 files each 1G in single directory(AG)   - numjobs = 1
>         Base XFS                : 17
>         Parallel Writeback XFS  : 17

Yup, this implies a sequential write workload....

>   B) Workload 12 files each of 1G to 12 directories(AGs)- numjobs = 12
>         Base XFS                : 166593
>         Parallel Writeback XFS  : 161554

which implies 144 files, and so over 1000 extents per file. Which
means about 1MB per extent and is way, way worse than it should be
for sequential write workloads.

> 
>   C) Workload 6 files each of 20G to 6 directories(AGs) - numjobs = 6
>         Base XFS                : 3173716
>         Parallel Writeback XFS  : 3364984

36 files, 720GB and 3.3m extents, which is about 100k extents per
file for an average extent size of 200kB. That would explain why it
performed roughly the same on both devices - they both have similar
random 128kB write IO performance...

But that fragmentation pattern is bad and shouldn't be occurring fro
sequential writes. Speculative EOF preallocation should be almost
entirely preventing this sort of fragmentation for concurrent
sequential write IO and so we should be seeing extent sizes of at
least hundreds of MBs for these file sizes.

i.e. this feels to me like you test is triggering some underlying
delayed allocation defeat mechanism that is causing physical
writeback IO sizes to collapse. This turns what should be a
bandwitdh limited workload running at full device bandwidth into an
IOPS and IO depth limited workload.

In adding writeback concurrency to this situation, it enables
writeback to drive deeper IO queues and so extract more small IO
performance from the device, thereby showing better performance for
the wrokload. The issue is that baseline writeback performance is
way below where I think it should be for the given IO workload (IIUC
the workload being run, hence questions about benchmarks, filesystem
configs and test hardware).

Hence while I certainly agree that writeback concurrency is
definitely needed, I think that the results you are getting here are
a result of some other issue that writeback concurrency is
mitigating. The underlying fragmentation issue needs to be
understood (and probably solved) before we can draw any conclusions
about the performance gains that concurrent writeback actually
provides on these workloads and devices...

-Dave.
-- 
Dave Chinner
david@fromorbit.com
