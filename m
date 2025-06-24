Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6DE182D2
	for <gfs2@lists.linux.dev>; Tue, 24 Jun 2025 05:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750744783; cv=none; b=ZcVW7wtWuxYfqg1otYOF8jLTsIjMTHmbIYpmxj8i6al/ribZJdc7SByCHw2Bpji05fAbn3tu1I64HWqRxMLTPjWfOV6Ut1DsYIcZ3RGam1eABRp/iGKAY71XXQB/dPHqct6NVwouWY42RvbtL6zuk6xKQY9aAcNuBx8DbitWzVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750744783; c=relaxed/simple;
	bh=p7JTv/Vl04sUhhRWS3lU9IHtibunvrxjNU3gZTKA1Uo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KcjZZPSl+trnbK0G8Y5wKBC9zuioYReiMDSS14cejss3YuGZ7x0QijRyy7BwRxWr8tzwhF5IYE+wJYgjlBqeWpwFeQL7Si3GrmGvH8SpQUOhEmMlRmzs0kLmWUDz+QnoJGU3b0M1mTAd1V0DBFbNbiQYIBW6BwOCFMDtQHbeE54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Am42XTsl; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Am42XTsl"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ad8a6c202ffso930254766b.3
        for <gfs2@lists.linux.dev>; Mon, 23 Jun 2025 22:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750744780; x=1751349580; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m6010/ZxGOxc/GtHfiUtuCWiZZWt6dGaK+o3fK6MDmU=;
        b=Am42XTsl6WOQelyYowwqjstlMtXajxBO8Nt/nmzpsmdHxaELHD/1QBGXtNMiH387yQ
         slgDfpkp/vQieWmkDQ7YZeMK7P4tVe0ZLBB7DPUXguWnT5tjFwihZRJ+FHNwq1NrwgJU
         Q0OuGPKyVKj5GSSxXm1mInO0pfgT+gdt8aTLjdGxbT4KnTyuBS/WqY7il8lwe4mydeYJ
         lYv67IH6HXOoox8NG6ZZEnv/3W0zc/qDH/tkI/71yuehRAdp8H0MApt+7rSJexJL1DZU
         Smv5Spl3ig3HEMHqoNrvLLyJz8QRWIZcQV535begTWh0D2g/eHLIb2wXx0Cekx4sIGKE
         yXEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750744780; x=1751349580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m6010/ZxGOxc/GtHfiUtuCWiZZWt6dGaK+o3fK6MDmU=;
        b=ufAJm0d1leMK/T8PCdBFV7S+x8Wevv3LjFLuUzaaCarKsr0fPV1CVpMbQv6lWgdP6U
         Ik5sEemcY3wvKQDIAHg3tbi/3QlrPHQ+9O5gxJJnuUGffdhwGPzjaVDRZ4GCBBPV1PHL
         lCJ/CZupMfTeNLZaEsuaEpJpNjvAdY3j0/oo82Lrw2+uXQ3jlTB9mwWFhwI0EtxcrU/h
         K8vOfBfLeecqcuAfUgKFVc7zK1YaWuVuLwJxPt8wlR2UMGf78UKySHe997wLxRRkaIN6
         iBjU9DKFcqYcVpuCQW5TaCxDz+eP3sXsUqmG0ZMQfNRnnWFVc15uRyzjyPFgzcAQlaU8
         cG4w==
X-Forwarded-Encrypted: i=1; AJvYcCVNlycZGV+t+991DsDv/hBTasOSYsE0YGE/ChFya1k9KplbO3ts/IB62GgjHYvDr470VHuO@lists.linux.dev
X-Gm-Message-State: AOJu0YzmVWZQw2I2nnzOWrrJljLGxKCUFTSsx9RkRwd3gRNEVoF0FHaQ
	p+9AMmyWAdO5wWfvYXOIdF4Jp1Sqc2qJ3ZegzUib6Kct0fYGsreJxTibmH6Jcx+qn+yj/x7pM7A
	XKAUUop6BNYN8MOLdMVt2XvBOEr8rMRY=
X-Gm-Gg: ASbGnctaTFAKkl2e5x8jL7gHFhOmD6Sm6ItqxNL4Ze3bilY1iK8HicV2CKx/qXUO7dX
	7fn51YZUjUhOBxAn9Fs5k8RiCHh36vdfEhIs8SWNbEtiXvmYHXNXdxs07zjRjn367duWi+qLmJV
	EKYITdATQwlEmOLkJx6C8edwc+Oypzbz60wbywhJQw6Fkv90720vfz8JA=
X-Google-Smtp-Source: AGHT+IE+xtk8mCeLX4OzNGlO9SwlPPmDyNCsobTZwfKxxEZdu+lYg/k7JddDFzyJ8a/vNVxMgcZ5qdSBpvnFKoOwczc=
X-Received: by 2002:a17:907:7e92:b0:adb:229a:f8bd with SMTP id
 a640c23a62f3a-ae057b6cc1dmr1547486566b.29.1750744779560; Mon, 23 Jun 2025
 22:59:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CGME20250529113215epcas5p2edd67e7b129621f386be005fdba53378@epcas5p2.samsung.com>
 <20250529111504.89912-1-kundan.kumar@samsung.com> <20250602141904.GA21996@lst.de>
 <c029d791-20ca-4f2e-926d-91856ba9d515@samsung.com> <20250603132434.GA10865@lst.de>
 <CACzX3AuBVsdEUy09W+L+xRAGLsUD0S9+J2AO8nSguA2nX5d8GQ@mail.gmail.com>
 <CALYkqXqVRYqq+5_5W4Sdeh07M8DyEYLvrsm3yqhhCQTY0pvU1g@mail.gmail.com> <20250611155144.GD6138@frogsfrogsfrogs>
In-Reply-To: <20250611155144.GD6138@frogsfrogsfrogs>
From: Kundan Kumar <kundanthebest@gmail.com>
Date: Tue, 24 Jun 2025 11:29:28 +0530
X-Gm-Features: Ac12FXzjJtXhWP5qaSTxOaM8kfMlrnXKIbZrGlp-NuqDUifHrwujHPqe26XNyh8
Message-ID: <CALYkqXpOBb1Ak2kEKWbO2Kc5NaGwb4XsX1q4eEaNWmO_4SQq9w@mail.gmail.com>
Subject: Re: [PATCH 00/13] Parallelizing filesystem writeback
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Anuj gupta <anuj1072538@gmail.com>, Christoph Hellwig <hch@lst.de>, 
	"Anuj Gupta/Anuj Gupta" <anuj20.g@samsung.com>, Kundan Kumar <kundan.kumar@samsung.com>, jaegeuk@kernel.org, 
	chao@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	miklos@szeredi.hu, agruenba@redhat.com, trondmy@kernel.org, anna@kernel.org, 
	akpm@linux-foundation.org, willy@infradead.org, mcgrof@kernel.org, 
	clm@meta.com, david@fromorbit.com, amir73il@gmail.com, axboe@kernel.dk, 
	ritesh.list@gmail.com, dave@stgolabs.net, p.raghav@samsung.com, 
	da.gomez@samsung.com, linux-f2fs-devel@lists.sourceforge.net, 
	linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-nfs@vger.kernel.org, linux-mm@kvack.org, gost.dev@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 9:21=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Wed, Jun 04, 2025 at 02:52:34PM +0530, Kundan Kumar wrote:
> > > > > For xfs used this command:
> > > > > xfs_io -c "stat" /mnt/testfile
> > > > > And for ext4 used this:
> > > > > filefrag /mnt/testfile
> > > >
> > > > filefrag merges contiguous extents, and only counts up for disconti=
guous
> > > > mappings, while fsxattr.nextents counts all extent even if they are
> > > > contiguous.  So you probably want to use filefrag for both cases.
> > >
> > > Got it =E2=80=94 thanks for the clarification. We'll switch to using =
filefrag
> > > and will share updated extent count numbers accordingly.
> >
> > Using filefrag, we recorded extent counts on xfs and ext4 at three
> > stages:
> > a. Just after a 1G random write,
> > b. After a 30-second wait,
> > c. After unmounting and remounting the filesystem,
> >
> > xfs
> > Base
> > a. 6251   b. 2526  c. 2526
> > Parallel writeback
> > a. 6183   b. 2326  c. 2326
>
> Interesting that the mapping record count goes down...
>
> I wonder, you said the xfs filesystem has 4 AGs and 12 cores, so I guess
> wb_ctx_arr[] is 12?  I wonder, do you see a knee point in writeback
> throughput when the # of wb contexts exceeds the AG count?
>
> Though I guess for the (hopefully common) case of pure overwrites, we
> don't have to do any metadata updates so we wouldn't really hit a
> scaling limit due to ag count or log contention or whatever.  Does that
> square with what you see?
>

Hi Darrick,

We analyzed AG count vs. number of writeback contexts to identify any
knee point. Earlier, wb_ctx_arr[] was fixed at 12; now we varied nr_wb_ctx
and measured the impact.

We implemented a configurable number of writeback contexts to measure
throughput more easily. This feature will be exposed in the next series.
To configure, used: echo <nr_wb_ctx> > /sys/class/bdi/259:2/nwritebacks.

In our test, writing 1G across 12 directories showed improved bandwidth up
to the number of allocation groups (AGs), mostly a knee point, but gains
tapered off beyond that. Also, we see a good increase in bandwidth of about
16 times from base to nr_wb_ctx =3D 6.

    Base (single threaded)                :  9799KiB/s
    Parallel Writeback (nr_wb_ctx =3D 1)    :  9727KiB/s
    Parallel Writeback (nr_wb_ctx =3D 2)    :  18.1MiB/s
    Parallel Writeback (nr_wb_ctx =3D 3)    :  46.4MiB/s
    Parallel Writeback (nr_wb_ctx =3D 4)    :  135MiB/s
    Parallel Writeback (nr_wb_ctx =3D 5)    :  160MiB/s
    Parallel Writeback (nr_wb_ctx =3D 6)    :  163MiB/s
    Parallel Writeback (nr_wb_ctx =3D 7)    :  162MiB/s
    Parallel Writeback (nr_wb_ctx =3D 8)    :  154MiB/s
    Parallel Writeback (nr_wb_ctx =3D 9)    :  152MiB/s
    Parallel Writeback (nr_wb_ctx =3D 10)   :  145MiB/s
    Parallel Writeback (nr_wb_ctx =3D 11)   :  145MiB/s
    Parallel Writeback (nr_wb_ctx =3D 12)   :  138MiB/s


System config
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Number of CPUs =3D 12
System RAM =3D 9G
For XFS number of AGs =3D 4
Used NVMe SSD of 3.84 TB (Enterprise SSD PM1733a)

Script
=3D=3D=3D=3D=3D
mkfs.xfs -f /dev/nvme0n1
mount /dev/nvme0n1 /mnt
echo <num_wb_ctx> > /sys/class/bdi/259:2/nwritebacks
sync
echo 3 > /proc/sys/vm/drop_caches

for i in {1..12}; do
  mkdir -p /mnt/dir$i
done

fio job_nvme.fio

umount /mnt
echo 3 > /proc/sys/vm/drop_caches
sync

fio job
=3D=3D=3D=3D=3D
[global]
bs=3D4k
iodepth=3D1
rw=3Drandwrite
ioengine=3Dio_uring
nrfiles=3D12
numjobs=3D1                # Each job writes to a different file
size=3D1g
direct=3D0                 # Buffered I/O to trigger writeback
group_reporting=3D1
create_on_open=3D1
name=3Dtest

[job1]
directory=3D/mnt/dir1

[job2]
directory=3D/mnt/dir2
...
...
[job12]
directory=3D/mnt/dir1

> > ext4
> > Base
> > a. 7080   b. 7080    c. 11
> > Parallel writeback
> > a. 5961   b. 5961    c. 11
>
> Hum, that's particularly ... interesting.  I wonder what the mapping
> count behaviors are when you turn off delayed allocation?
>
> --D
>

I attempted to disable delayed allocation by setting allocsize=3D4096
during mount (mount -o allocsize=3D4096 /dev/pmem0 /mnt), but still
observed a reduction in file fragments after a delay. Is there something
I'm overlooking?

-Kundan
