Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7872F1FDB
	for <gfs2@lists.linux.dev>; Sat, 22 Nov 2025 12:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763812893; cv=none; b=LYGfEzd0mRlk7UdZSuV0QAfkqilL73VEbq4+I0Tukjo+tjyVGD7jBT4/txpOPavEtu9PFgsr39oW1pGRWhx2HF0xKSr8tr8nB0MllGuIMXa6ok9YVZ3OKxbvH/rq9TcBf360oeDiaVe2vVCl57WThGiutXkmwa+yprkQaLBKYCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763812893; c=relaxed/simple;
	bh=4nWgX9ww33bsVkN80fxqeJv7BBG+H91O9D+0SVq5PiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hFFOp6HKnKXTtWt68PtbpVEHp6DujRQF+l6rAOw/8UUvjQXI4wKyuP9GiFxPhCF5J5CuPM2Ft7GdyA2FK2Pi/ECwtzL2VqJhm1AAQUFA2ud7ahodYQIbRQvqJXhC7uz/iZQ1i038EKpPumQY1fibP3RGU1kRPbrje3FJEGzlgV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XLrXaMGM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XLrXaMGM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763812890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JuZK2beRgEq+MC2I+vh3JTOKDyroWbZXDvE+0QrmUyk=;
	b=XLrXaMGMLocznje0Ka+pM6j+AA7vyyLQU5N5wlhUH5A9ERf6tKmUrQ5+PVpeWlaUttM+pf
	KJkYKtLdJb0Wus9vxLl1QFkJ2evYyb/mbYMLXisRAGqFgXafP4aqfi7NnDF4mh7TJpZ509
	5ypGveMfFYVrN9wpj8F91g/NopUPVr0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-653-VC8oek4GOGiDUqoXurM1bg-1; Sat,
 22 Nov 2025 07:01:26 -0500
X-MC-Unique: VC8oek4GOGiDUqoXurM1bg-1
X-Mimecast-MFC-AGG-ID: VC8oek4GOGiDUqoXurM1bg_1763812885
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 28B171956080;
	Sat, 22 Nov 2025 12:01:24 +0000 (UTC)
Received: from fedora (unknown [10.72.116.33])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 873C01940E82;
	Sat, 22 Nov 2025 12:01:14 +0000 (UTC)
Date: Sat, 22 Nov 2025 20:01:08 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Stephen Zhang <starzhangzsd@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	nvdimm@lists.linux.dev, virtualization@lists.linux.dev,
	linux-nvme@lists.infradead.org, gfs2@lists.linux.dev,
	ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org,
	zhangshida@kylinos.cn
Subject: Re: Fix potential data loss and corruption due to Incorrect BIO
 Chain Handling
Message-ID: <aSGmBAP0BA_2D3Po@fedora>
References: <20251121081748.1443507-1-zhangshida@kylinos.cn>
 <aSEvg8z9qxSwJmZn@fedora>
 <CANubcdULTQo5jF7hGSWFqXw6v5DhEg=316iFNipMbsyz64aneg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANubcdULTQo5jF7hGSWFqXw6v5DhEg=316iFNipMbsyz64aneg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Sat, Nov 22, 2025 at 02:42:43PM +0800, Stephen Zhang wrote:
> Ming Lei <ming.lei@redhat.com> 于2025年11月22日周六 11:35写道：
> >
> > On Fri, Nov 21, 2025 at 04:17:39PM +0800, zhangshida wrote:
> > > From: Shida Zhang <zhangshida@kylinos.cn>
> > >
> > > Hello everyone,
> > >
> > > We have recently encountered a severe data loss issue on kernel version 4.19,
> > > and we suspect the same underlying problem may exist in the latest kernel versions.
> > >
> > > Environment:
> > > *   **Architecture:** arm64
> > > *   **Page Size:** 64KB
> > > *   **Filesystem:** XFS with a 4KB block size
> > >
> > > Scenario:
> > > The issue occurs while running a MySQL instance where one thread appends data
> > > to a log file, and a separate thread concurrently reads that file to perform
> > > CRC checks on its contents.
> > >
> > > Problem Description:
> > > Occasionally, the reading thread detects data corruption. Specifically, it finds
> > > that stale data has been exposed in the middle of the file.
> > >
> > > We have captured four instances of this corruption in our production environment.
> > > In each case, we observed a distinct pattern:
> > >     The corruption starts at an offset that aligns with the beginning of an XFS extent.
> > >     The corruption ends at an offset that is aligned to the system's `PAGE_SIZE` (64KB in our case).
> > >
> > > Corruption Instances:
> > > 1.  Start:`0x73be000`, **End:** `0x73c0000` (Length: 8KB)
> > > 2.  Start:`0x10791a000`, **End:** `0x107920000` (Length: 24KB)
> > > 3.  Start:`0x14535a000`, **End:** `0x145b70000` (Length: 8280KB)
> > > 4.  Start:`0x370d000`, **End:** `0x3710000` (Length: 12KB)
> > >
> > > After analysis, we believe the root cause is in the handling of chained bios, specifically
> > > related to out-of-order io completion.
> > >
> > > Consider a bio chain where `bi_remaining` is decremented as each bio in the chain completes.
> > > For example,
> > > if a chain consists of three bios (bio1 -> bio2 -> bio3) with
> > > bi_remaining count:
> > > 1->2->2
> >
> > Right.
> >
> > > if the bio completes in the reverse order, there will be a problem.
> > > if bio 3 completes first, it will become:
> > > 1->2->1
> >
> > Yes.
> >
> > > then bio 2 completes:
> > > 1->1->0
> >
> > No, it is supposed to be 1->1->1.
> >
> > When bio 1 completes, it will become 0->0->0
> >
> > bio3's `__bi_remaining` won't drop to zero until bio2's reaches
> > zero, and bio2 won't be done until bio1 is ended.
> >
> > Please look at bio_endio():
> >
> > void bio_endio(struct bio *bio)
> > {
> > again:
> >         if (!bio_remaining_done(bio))
> >                 return;
> >         ...
> >         if (bio->bi_end_io == bio_chain_endio) {
> >                 bio = __bio_chain_endio(bio);
> >         goto again;
> >         }
> >         ...
> > }
> >
> 
> Exactly, bio_endio handle the process perfectly, but it seems to forget
> to check if the very first  `__bi_remaining` drops to zero and proceeds to
> the next bio:
> -----
> static struct bio *__bio_chain_endio(struct bio *bio)
> {
>         struct bio *parent = bio->bi_private;
> 
>         if (bio->bi_status && !parent->bi_status)
>                 parent->bi_status = bio->bi_status;
>         bio_put(bio);
>         return parent;
> }
> 
> static void bio_chain_endio(struct bio *bio)
> {
>         bio_endio(__bio_chain_endio(bio));
> }

bio_chain_endio() never gets called really, which can be thought as `flag`,
and it should have been defined as `WARN_ON_ONCE(1);` for not confusing people.

So I don't think upstream kernel has the issue you described.


Thanks,
Ming

