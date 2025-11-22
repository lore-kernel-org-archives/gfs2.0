Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB4451022
	for <gfs2@lists.linux.dev>; Sat, 22 Nov 2025 07:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763797606; cv=none; b=EG8LY0aGytlfbzr8+T5S3Fvo0wZ/8CYC7OrHlxQ7gdPyVmYtvHFiVujTavIr6iClEQ/BXio451DPvXzuvhe0hiLnimOqjc5QEFUEVcyO4/6FrXapP4hlsMloMRlvAfK5INfdSOAsN3osXFdRCy+fe8CoeI6IkUk8li7T2kKPcB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763797606; c=relaxed/simple;
	bh=Q2I4fYvh4oepaGQS7zTzvtbJbgRyZjD4TiTFO6vRTII=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=krDoMRv//OVkldZW5UUSF0agq3IHzcWa8BKdb/H1F+rd/Z9/ac90lij5dR+441KgJPUxG/plro6Alrh5P1iiylBJOYFEVklIowlYr4A3rGEUrImQb15cHuVzKWC1IqBOfM5r7Et0vxDOHFaJ83MIWL4qV1b3QERLlXCvWxchlwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LPJ6FitH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LPJ6FitH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763797603;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NzKDrDr19qM8qzMg2r6gHYZungvxwnQDvei/yhzW154=;
	b=LPJ6FitHNxbrsrP14dgo14ZtmOAxYTEE8fVndXCt2fF294RJeU0PohXSGwCghIO48Vva5Z
	PcI8NuIJEQuEyao3IAMRMtTkfbLOnO1hYcuCLsFycrzMt+kLsSG8SPR5YJsp8gA/J1j3JK
	4PVQA4mNRZsfWEBr0xGsnxRHDV9a0q8=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-84QlomtuNIim4aH8YDSiZA-1; Sat, 22 Nov 2025 02:46:41 -0500
X-MC-Unique: 84QlomtuNIim4aH8YDSiZA-1
X-Mimecast-MFC-AGG-ID: 84QlomtuNIim4aH8YDSiZA_1763797601
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-63e2d3351abso3424398d50.3
        for <gfs2@lists.linux.dev>; Fri, 21 Nov 2025 23:46:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763797601; x=1764402401;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NzKDrDr19qM8qzMg2r6gHYZungvxwnQDvei/yhzW154=;
        b=ZrmGXvSWkN+tmPsmgi/1rhXEw7ZRdFzQKbKij8BMRmJy9ykTQWk1auX2YywADS7dCc
         GPKpWIpCV3/C7nBr+TzuodZsZJOdkVNlAJsYN4mcfpVnaH1Sy2AnQ1wk8qPSzH7ZN3qN
         53bl0+eIVw54G5L7dllBQduhud+R8m/NBWMcvYBXrbswqGQHR90ribZzProfmSAv4r0n
         p4osEwkCuRKHbbp6C0Kq7r3HZVGsC9mk7aw5twLquBifWTwslzgFt5EugXMme6SAdtAI
         dL1VFKvfOfCqJaGjVEeJD1tUv8nNzVy3pI+UOjsHFNtNXsrvtRFJajXzdE+TdzzXHSsN
         tAhw==
X-Forwarded-Encrypted: i=1; AJvYcCW78oVWuK7/p6mkql7ekRpwNwm9h4c0Qoke1mEyFShaUvYFuCdJ9Gogu5sNY3OlMAchqr/r@lists.linux.dev
X-Gm-Message-State: AOJu0YwwQL1bWix2CeSnxCghKg7hhIe8pdk+CkG/OzV1XssA3UvMiMpd
	3XSFrVJQ8K6HnO/+9VUrudBqIa1kXGAnN7OPUMi20xd4KtdALS4KUkSeUcXxOwb7AyCKvy8ZcDA
	ik4gbLzGjPhSrQ07N8Y0MYbd6/hJQdkkHhS6yzPgb/FZGPEbh61lGuJ/+kICfVCPC5sfWAboYeF
	cyo055bKromMNVmyv2GA3pTedg/NvBsw==
X-Gm-Gg: ASbGncvOD4MM+UQCA38ZPrcVCuiTuADkby7nVPTmhocwDA7dRqLRxFs42GVpuwQBEtD
	nPFGc+gGmgC8xtBB06JpDuqLnAYJttOVaNyn1hjT+VQY0+k2hXJykhkcrVCfS22P+Vic87gEhSB
	fTh0HmwRJmxlgBoD2vdbf49jospx/CzGKXaYbf2U5UQYH+MzT4AYjWqecL1fOlZkWo
X-Received: by 2002:a05:690c:b98:b0:781:64f:2b1a with SMTP id 00721157ae682-78a8b56828cmr79989367b3.60.1763797600945;
        Fri, 21 Nov 2025 23:46:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHT6ReihqZuKDslp4v6LlKyjNYk5cYZ5oqfMTnv4XvlKobsBj9Saq/UGtRReN9JAQWVmvP6mmp+/fX9V/OmqWs=
X-Received: by 2002:a05:690c:b98:b0:781:64f:2b1a with SMTP id
 00721157ae682-78a8b56828cmr79989177b3.60.1763797600562; Fri, 21 Nov 2025
 23:46:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251121081748.1443507-1-zhangshida@kylinos.cn>
 <aSEvg8z9qxSwJmZn@fedora> <CANubcdULTQo5jF7hGSWFqXw6v5DhEg=316iFNipMbsyz64aneg@mail.gmail.com>
In-Reply-To: <CANubcdULTQo5jF7hGSWFqXw6v5DhEg=316iFNipMbsyz64aneg@mail.gmail.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Sat, 22 Nov 2025 08:46:29 +0100
X-Gm-Features: AWmQ_bkNPMPKGc9hcr0WMHGjLmVXZ8Lp-bk_Jm40n6CY0-WAnMeo9R7n5uUvirQ
Message-ID: <CAHc6FU5ofV7s3Q4KBGFJ3gExwsMpbaZ9Vj0FEHqrOreqvQMswQ@mail.gmail.com>
Subject: Re: Fix potential data loss and corruption due to Incorrect BIO Chain Handling
To: Stephen Zhang <starzhangzsd@gmail.com>
Cc: Ming Lei <ming.lei@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, nvdimm@lists.linux.dev, 
	virtualization@lists.linux.dev, linux-nvme@lists.infradead.org, 
	gfs2@lists.linux.dev, ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org, 
	zhangshida@kylinos.cn
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FOsq_AHgCmrw-ZURmBQE0FNHP77idy7b_E0_6vPjUe8_1763797601
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 22, 2025 at 7:52=E2=80=AFAM Stephen Zhang <starzhangzsd@gmail.c=
om> wrote:
> Ming Lei <ming.lei@redhat.com> =E4=BA=8E2025=E5=B9=B411=E6=9C=8822=E6=97=
=A5=E5=91=A8=E5=85=AD 11:35=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Fri, Nov 21, 2025 at 04:17:39PM +0800, zhangshida wrote:
> > > From: Shida Zhang <zhangshida@kylinos.cn>
> > >
> > > Hello everyone,
> > >
> > > We have recently encountered a severe data loss issue on kernel versi=
on 4.19,
> > > and we suspect the same underlying problem may exist in the latest ke=
rnel versions.
> > >
> > > Environment:
> > > *   **Architecture:** arm64
> > > *   **Page Size:** 64KB
> > > *   **Filesystem:** XFS with a 4KB block size
> > >
> > > Scenario:
> > > The issue occurs while running a MySQL instance where one thread appe=
nds data
> > > to a log file, and a separate thread concurrently reads that file to =
perform
> > > CRC checks on its contents.
> > >
> > > Problem Description:
> > > Occasionally, the reading thread detects data corruption. Specificall=
y, it finds
> > > that stale data has been exposed in the middle of the file.
> > >
> > > We have captured four instances of this corruption in our production =
environment.
> > > In each case, we observed a distinct pattern:
> > >     The corruption starts at an offset that aligns with the beginning=
 of an XFS extent.
> > >     The corruption ends at an offset that is aligned to the system's =
`PAGE_SIZE` (64KB in our case).
> > >
> > > Corruption Instances:
> > > 1.  Start:`0x73be000`, **End:** `0x73c0000` (Length: 8KB)
> > > 2.  Start:`0x10791a000`, **End:** `0x107920000` (Length: 24KB)
> > > 3.  Start:`0x14535a000`, **End:** `0x145b70000` (Length: 8280KB)
> > > 4.  Start:`0x370d000`, **End:** `0x3710000` (Length: 12KB)
> > >
> > > After analysis, we believe the root cause is in the handling of chain=
ed bios, specifically
> > > related to out-of-order io completion.
> > >
> > > Consider a bio chain where `bi_remaining` is decremented as each bio =
in the chain completes.
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

Currently, bio_chain_endio() will actually not decrement
__bi_remaining but it will call bio_put(bio 2) and bio_endio(parent),
which will lead to 1->2->0. And when bio 1 completes, bio 2 won't
exist anymore.

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
> >         if (bio->bi_end_io =3D=3D bio_chain_endio) {
> >                 bio =3D __bio_chain_endio(bio);
> >         goto again;
> >         }
> >         ...
> > }
> >
>
> Exactly, bio_endio handle the process perfectly, but it seems to forget
> to check if the very first  `__bi_remaining` drops to zero and proceeds t=
o
> the next bio:
> -----
> static struct bio *__bio_chain_endio(struct bio *bio)
> {
>         struct bio *parent =3D bio->bi_private;
>
>         if (bio->bi_status && !parent->bi_status)
>                 parent->bi_status =3D bio->bi_status;
>         bio_put(bio);
>         return parent;
> }
>
> static void bio_chain_endio(struct bio *bio)
> {
>         bio_endio(__bio_chain_endio(bio));
> }
> ----

This bug could be fixed as follows:

 static void bio_chain_endio(struct bio *bio)
 {
+        if (!bio_remaining_done(bio))
+                return;
         bio_endio(__bio_chain_endio(bio));
 }

but bio_endio() already does all that, so bio_chain_endio() might just
as well just call bio_endio(bio) instead.

Thanks,
Andreas

