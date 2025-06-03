Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF5B22FDF2
	for <gfs2@lists.linux.dev>; Tue,  3 Jun 2025 13:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748958781; cv=none; b=li8DHp9Bb7g7LwNXUNBwtehKKMwLX4Tppjh+iouEakPiU2UlFIaywCdhwGHDbhmBZAVHvqAdESjNiVAEdbX8v9B/LmicSZHBKrUqG55rBW56LsEVfmH4W7xY84WgzaVoq3rOcNoIpPmDnr3zlhYtzqml4Ht5cPHz3E3W/QW8xFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748958781; c=relaxed/simple;
	bh=56xm7d/i4w3yNuEd8L05kuAjEab3Mgm2fv1xTPSDORc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ejo4ugjXbvSuRk5lxAixBbqq+cruKbsoj/DJea9PyJ6npxVE7pTcB92lODHtco7M0spjBH0UJrt2ltRK3ScXKKAR7Y1Ovzjppdz2UDvjR3IxNoqHFVsliYOaZqVyDh1P+t0QWPsH7Q0+ZbfQMO6AUe7j2u1d26rWfGmdCDLDK7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CjlQmmi6; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CjlQmmi6"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-adb5fd85996so459740666b.2
        for <gfs2@lists.linux.dev>; Tue, 03 Jun 2025 06:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748958777; x=1749563577; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y3dgRxegT5qf67xryaScOvVUZaIAW5sj2uHc8EGQ1+g=;
        b=CjlQmmi6bv4ii147BvXs9M+I7pU3RSYVw2UrMt77MEGq9OoVzvBSE7HZPaMNnl4UbV
         LKe1SNZpkZ5ZJeMbgleMpalTxfl7TL1cT8jbn8rzAo6Us3w2PDHwZQOMgU/rE2bpJkaO
         W2Ca9E/2sKIKpaCLsAha789z33e+ozDCdajbobp8rUUVFKicX4sCtQ9234qFaB+48LXe
         ANLTnfn4c3kLpYWuQ+PWPrt5jvqMyoqV9LbU4Hixa9W5HSs190f/ageOH/nwrSOgxfkj
         H71yx+zvABvG1Mzia940mj1xZoRhsflOoXyifpmlGALVzknDNi37Y5okVGD1bSsVzLtb
         Dmjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748958777; x=1749563577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y3dgRxegT5qf67xryaScOvVUZaIAW5sj2uHc8EGQ1+g=;
        b=jHihLOLTEjmpJ02sMFT4xDYhZd+Ifim6r89xmsL4CSZULv5K1SoOog1F85TR62sQ92
         +/xIgV3X+YxerFLLsXVCETG/wBviJrKnYfx972rvDjvpgE2ev4IoA/FthZb5SvxTbNod
         OSwRumPs2PHcp2/he1PctjdNOwLN+G6+Dqaz2j2PbFWgYWRts/UfqrPdjmSON28uKb59
         rVd3jAYxgFeZWpWoSWoF6dVBcD90TUp6TuMS8yF52QR7IAv0GWLglH2al/47Z4IBwUAm
         MqHaAky1NgN7WR7v9V85hvSno1aHk2RYTUILb7X7YdJBuMSzNPTMgE4saQoFMvFxF8EZ
         j89A==
X-Forwarded-Encrypted: i=1; AJvYcCVBtJ9zfyZVMBR6+asBrt49UXZYqyIHORqL42O118BYu6PGYOs3l7DQBjrtxeNuhgLqgcBL@lists.linux.dev
X-Gm-Message-State: AOJu0YxDW+Q805/4O3zqprFBdqrWR8FokWHItCACYxvrBL5KZFOXY7yp
	U4LsJUEWV/CvNoHc7ZpYzjgYlPQWmxwvXuKZ3XbMgDIYLs/NHTtr/F/BSIFydFWX20wvw9l9NgV
	j5pJmjeUD1C1AHvfZ1OgPjN9Mwxo1LQ==
X-Gm-Gg: ASbGncuGYXDTPsC3d1R/u6wIYNIVTY4x3EqRxUi94OzoIExraZDEIW4SQ2Yoel6HwDa
	Tpt/XMU+zamzGrbQ9G/fXDsXA8MLPdqtvoDALWYWb713uSCdfd0W4ZDxHzJTu8MflEmfDdN27kU
	ldGaeRHVZJ3AEFb+mD1N7khGvRPO36eHyvSxXCa8oxuqoWlBVjmoo5obOwAUeUHUkMzqq9Q/A2B
	Q==
X-Google-Smtp-Source: AGHT+IFus+lYy/Vn8DX7AejSTWq5DWSZv2otFfVWZOt+Ot1Cw3NBGg/aiRMWu1o2ZMIdoZsQp1gzV5igzu9cyaTxn5s=
X-Received: by 2002:a17:907:3f0f:b0:ad8:9909:20b5 with SMTP id
 a640c23a62f3a-adb496037b7mr1318776566b.56.1748958777045; Tue, 03 Jun 2025
 06:52:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CGME20250529113215epcas5p2edd67e7b129621f386be005fdba53378@epcas5p2.samsung.com>
 <20250529111504.89912-1-kundan.kumar@samsung.com> <20250602141904.GA21996@lst.de>
 <c029d791-20ca-4f2e-926d-91856ba9d515@samsung.com> <20250603132434.GA10865@lst.de>
In-Reply-To: <20250603132434.GA10865@lst.de>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Tue, 3 Jun 2025 19:22:18 +0530
X-Gm-Features: AX0GCFs142Om3-wJu99daJuShs3COk0AlQwDiy7BvMajL8e3IU6AzAyzk8BCwWQ
Message-ID: <CACzX3AuBVsdEUy09W+L+xRAGLsUD0S9+J2AO8nSguA2nX5d8GQ@mail.gmail.com>
Subject: Re: [PATCH 00/13] Parallelizing filesystem writeback
To: Christoph Hellwig <hch@lst.de>
Cc: "Anuj Gupta/Anuj Gupta" <anuj20.g@samsung.com>, Kundan Kumar <kundan.kumar@samsung.com>, jaegeuk@kernel.org, 
	chao@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	miklos@szeredi.hu, agruenba@redhat.com, trondmy@kernel.org, anna@kernel.org, 
	akpm@linux-foundation.org, willy@infradead.org, mcgrof@kernel.org, 
	clm@meta.com, david@fromorbit.com, amir73il@gmail.com, axboe@kernel.dk, 
	ritesh.list@gmail.com, djwong@kernel.org, dave@stgolabs.net, 
	p.raghav@samsung.com, da.gomez@samsung.com, 
	linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	gfs2@lists.linux.dev, linux-nfs@vger.kernel.org, linux-mm@kvack.org, 
	gost.dev@samsung.com, kundanthebest@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 3, 2025 at 6:54=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrote=
:
>
> On Tue, Jun 03, 2025 at 02:46:20PM +0530, Anuj Gupta/Anuj Gupta wrote:
> > On 6/2/2025 7:49 PM, Christoph Hellwig wrote:
> > > On Thu, May 29, 2025 at 04:44:51PM +0530, Kundan Kumar wrote:
> > > Well, the proper thing would be to figure out a good default and not
> > > just keep things as-is, no?
> >
> > We observed that some filesystems, such as Btrfs, don't benefit from
> > this infra due to their distinct writeback architecture. To preserve
> > current behavior and avoid unintended changes for such filesystems,
> > we have kept nr_wb_ctx=3D1 as the default. Filesystems that can take
> > advantage of parallel writeback (xfs, ext4) can opt-in via a mount
> > option. Also we wanted to reduce risk during initial integration and
> > hence kept it as opt-in.
>
> A mount option is about the worst possible interface for behavior
> that depends on file system implementation and possibly hardware
> chacteristics.  This needs to be set by the file systems, possibly
> using generic helpers using hardware information.

Right, that makes sense. Instead of using a mount option, we can
introduce generic helpers to initialize multiple writeback contexts
based on underlying hardware characteristics =E2=80=94 e.g., number of CPUs=
 or
NUMA topology. Filesystems like XFS and EXT4 can then call these helpers
during mount to opt into parallel writeback in a controlled way.

>
> > Used PMEM of 6G
>
> battery/capacitor backed DRAM, or optane?

We emulated PMEM using DRAM by following the steps here:
https://www.intel.com/content/www/us/en/developer/articles/training/how-to-=
emulate-persistent-memory-on-an-intel-architecture-server.html

>
> >
> > and NVMe SSD of 3.84 TB
>
> Consumer drive, enterprise drive?

It's an enterprise-grade drive =E2=80=94 Samsung PM1733

>
> > For xfs used this command:
> > xfs_io -c "stat" /mnt/testfile
> > And for ext4 used this:
> > filefrag /mnt/testfile
>
> filefrag merges contiguous extents, and only counts up for discontiguous
> mappings, while fsxattr.nextents counts all extent even if they are
> contiguous.  So you probably want to use filefrag for both cases.

Got it =E2=80=94 thanks for the clarification. We'll switch to using filefr=
ag
and will share updated extent count numbers accordingly.
