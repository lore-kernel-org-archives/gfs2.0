Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3DD8626E
	for <gfs2@lists.linux.dev>; Tue,  2 Apr 2024 14:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712069810; cv=none; b=B8Y7YBJH5NPfIIKG0fzRBEwMLBV2WBe1Qg12De2jHQO1ci8iLsd8lTr+McGhrvhJ3sJ3F5YJvQ1CbNXuKO85EOMRhN3hArjoCv+WWIXlTUUwVTekofS6HRI8Jg8P6+ZT0ZTlZe0B/kw1RzRHb+WSMnseZHu9OCxWUa4JR8iFuPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712069810; c=relaxed/simple;
	bh=HpuQ5eF7YCIbnWpTR/xnTijyyZTAnePPG+eVonC58dU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u5ekg90Q426UXkF3AqbT6x1CzfnNN7W7Yt5vkWCkXUVa7zUgvoZ696dPFZ2x8m6jG1IWXQSAM1EqrqCnObWDvxYdS2Tkx8YfzTzLfZdPHcy1xkNrWgudqTzJDUcUothyn9Z/VYLkARhlqloPSWrDbxZRqRGDoM+h/UxbMhTGtEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MdSc2u7A; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MdSc2u7A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712069807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=coSlOwk5kpLH2uC/uJWOwN8i8ItnZLeDftarxZf/2Ps=;
	b=MdSc2u7AhJPCAYlhOQeRYvHv6qD1uvehWLvFel4TNgf/uYMWnBEjQxJ+RnaH+BMf65lDwp
	hyUI0fsAKK1gjURBrNgmc6MH787qeHFkgYOAhCMzS6CUYGZ2USVPUx6fqsi5Y84+Lmm0EF
	ZdAklthWVVuDjyF59aRopQdj3YOkQoM=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-VrQJDt_hNUS6HaqueJkshA-1; Tue, 02 Apr 2024 10:56:46 -0400
X-MC-Unique: VrQJDt_hNUS6HaqueJkshA-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2d717230d3eso32717661fa.1
        for <gfs2@lists.linux.dev>; Tue, 02 Apr 2024 07:56:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712069804; x=1712674604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=coSlOwk5kpLH2uC/uJWOwN8i8ItnZLeDftarxZf/2Ps=;
        b=j2II0MGLcC2tHrGb/5rkYgu4evI0prkLmjuM1BjP1fM6386iilIZESq/bUZVn1EKmp
         mFyOz1HfkwbT4L6X6sEarHnROTNkzKW+oAlGq3UEn4guydlx+iu1l9uS7Y7xqPm6JN4d
         /uGt74MyaZs6KEyt/yeVRAcblIO/VMWlJVaP9/FA37sviwtAohGyWHuCWB9YLyNNuPNY
         H4pWxjDhE8+2ZAHz7cX2950EKpCv+zWUYEuk7HgCYrlZ7HRhuvm6tZVQ8m9aHKLW8lTD
         BEXLG1DPstsDWpLDFoJfuErtIyjr/LVXswflb86kexCOO4tdwbFOJ/CY5sJ2Fn0Axnm4
         DoGw==
X-Forwarded-Encrypted: i=1; AJvYcCX0LbvG+yPBWlcP9APBSLirbzwZu8G70X0PydTKr7TtWo9U87TD/coucn47EfVRl4ykEaLOvMkEPCFmuEGSgC4/1G0Wiw==
X-Gm-Message-State: AOJu0Yx+cxDK9IRILGf6RFdbwYeMoQCTs0geXWd06nGNnlLC6qtRmsHr
	92LpGfYIPoNYBpusvWifeopdAd90PTgqpRQKMYjyZtiUtf4F7Lwe4f7wp/7VFI4vJm/mL/bzGzC
	DuTsrdpVOxDSBmX3/8sKQNoU455HUZ00C6LDiryldkyyZaf/FJhYKvg26sRAsidt2PIKhRuU8/Z
	CyavIjwQ61w08HFdcx+shnLGNhgG0CTiz6Fg==
X-Received: by 2002:a05:651c:2d1:b0:2d4:6786:e8 with SMTP id f17-20020a05651c02d100b002d4678600e8mr6956617ljo.12.1712069804464;
        Tue, 02 Apr 2024 07:56:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjNsKKbgMJVMEfgEd8p3p4dPgkT0ABeq3D5wcXXCczSNd5fv1qDmNVsl2OW910bUhNrcis85N3DPdxWCch048=
X-Received: by 2002:a05:651c:2d1:b0:2d4:6786:e8 with SMTP id
 f17-20020a05651c02d100b002d4678600e8mr6956603ljo.12.1712069804131; Tue, 02
 Apr 2024 07:56:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230925201827.1703857-1-aahringo@redhat.com> <20240330072500.qs73uzweykk3npsq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
In-Reply-To: <20240330072500.qs73uzweykk3npsq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Tue, 2 Apr 2024 10:56:32 -0400
Message-ID: <CAK-6q+h9Oy1A3ZSR=d52ckijVZbAi4zufnE0KkLhMfMi+kY-Dg@mail.gmail.com>
Subject: Re: [PATCHv2] generic: add fcntl corner cases tests
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, gfs2@lists.linux.dev, jlayton@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Mar 30, 2024 at 3:25=E2=80=AFAM Zorro Lang <zlang@redhat.com> wrote=
:
>
> On Mon, Sep 25, 2023 at 04:18:27PM -0400, Alexander Aring wrote:
> > This patch adds fcntl corner cases that was being used to confirm issue=
s
> > on a GFS2 filesystem. The GFS2 filesystem has it's own ->lock()
> > implementation and in those corner cases issues was being found and
> > fixed.
> >
> > Signed-off-by: Alexander Aring <aahringo@redhat.com>
> > ---
> > changes since v2:
> > - move fcntl tests into one fcntl c file
> > - remove ofd and same owner tests, should be reflected by only one test
> > - simplify commit message (remove testname out of it)
> > - add error messages in fcntl.c to give more information if an error
> >   occur
>
> Any update? :) It's still in "patches-in-queue" branch.

I still have it on my list to work on this.

Thanks for all the recommendations for another version. I hope I can
provide an update soon. What is about the CIFS issue, we will ignore
it for now? From my understanding it is an issue in CIFS but probably
rare to hit and not easy to fix for now.

(report after hang) I can look if we can add an alarm() type
interruption, but this only work if the filesystem really implements
that fcntl(..., F_SETLKW, ...) is interruptible which should be the
case, otherwise it would be another exception why the test is know to
be failing.

Thanks.

- Alex

