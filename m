Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7BF1419A2
	for <gfs2@lists.linux.dev>; Fri,  2 Feb 2024 12:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706876411; cv=none; b=ky9MHE5thpb1ebgWFYQ9VGUujFAS2CBJmolt9K/zdTXM699Qs3yaheu+evBHFAe/iodj9FDFEX5E9ojg11XgYzSmFF/YdJJUERyKZpkShQKPYqpXBpNewwabJJtwW5TaRyFKGatHFFyHEZf5pC6nXcKTvZosVSqDFp3I5+s2o/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706876411; c=relaxed/simple;
	bh=tbufM01LMGev4Pg+LbNrac1oVsvR6Ipue9czRk3ZHGg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pCUJBwyLo+cFDkdNl9slzK+6xqKzuvMVOwZPvVwk6bmmjh7jwnkG/rt5BUPPhtIPlk0wzV4ESGv+dVF/lOFjNVnknHkOd0wM8Rg6VjdkDBBOvFBqcQlcGQZJ4MiqT/c3xnrdH86lqVYLIIMpqOU0IQo19IzMHDkY8bcurl4zZrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RYILJbJ9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RYILJbJ9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706876408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zWPDTjGrjhjMNJrQTp58AfSW6I+1SdSuSRFkFXF1+8I=;
	b=RYILJbJ9UjkxhrKcSam9s6kdECkjLEz0jeeEv4L8Re+ra+Q4Y4y5oHrO4+FXbt03K0/Ig/
	UWLls3F881/UHLIrR8gzG069G2T+zE64JolLZVjpVbhBnUEoHv7o8rlsiyyiUk28CgIUzM
	ANrbFXfSaWJvsP8ZvmPF34NeTRDH42c=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-3CUC0zHbNsKLRU2porvwsQ-1; Fri, 02 Feb 2024 07:20:07 -0500
X-MC-Unique: 3CUC0zHbNsKLRU2porvwsQ-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-55f63fd55ffso1194575a12.3
        for <gfs2@lists.linux.dev>; Fri, 02 Feb 2024 04:20:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706876406; x=1707481206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zWPDTjGrjhjMNJrQTp58AfSW6I+1SdSuSRFkFXF1+8I=;
        b=DSbd2mgbAChXkH5NGSp5ZF/hzCQql5nv8C0mgtCD2+WRJEt6CuUmIISv6bHV8M7hqf
         IlV+aJKpcqLV9T+vjpPhaBzVbW40TTQCtz3bp9AQ+jhJpXiEHt67LCmy363AWRPQHXeD
         +alB8y1OqHlEhMU0Pk3yDzl9Hn3i81Jm1CJndHSkBcYsVDEwouMg62BVqvOxOJNBfbRu
         N0G8HnACGWkI8QnIA74g7tpvbtrgWFP+croa0ihzbu7nCZhgbh06uRgLV+zkC1PMgCmT
         PGM16atrsmz3SBdLk6EMGR9ji4A4Ddi0Y9eP1k5GLo6qsEP+3YHArjZcRgmqTAeWtP//
         0ISQ==
X-Gm-Message-State: AOJu0Yy9MmgdXlTDb6Es9ydRAvZR1Q/H+7JoFjCHyLVbJPQJWVHkfVBp
	Sq7OWB2n5xxyHucZmCqpxa1tK5X8Xi+r3BOH9Ol/ESz78QlGh1P0vxKfpJ/L/TQRCIyLDrutm8H
	q6Knr828yiu+dAj5Uh2FiPBGB7Jgx1B/OoMg4ng4bAvIv9aZsxnG0MJFAstPxa5yJhBmT3Dwtvt
	juYzoQBLPCycEcDiX8SLJ3ThsGKQ==
X-Received: by 2002:aa7:d658:0:b0:55f:fe5f:318d with SMTP id v24-20020aa7d658000000b0055ffe5f318dmr723319edr.34.1706876405569;
        Fri, 02 Feb 2024 04:20:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGR4U7ivvBycWNkO9vjimzq3Qe8mpE2HwujRdVJU5dpg0VqWAIR99pGP56VZelEw+1aGxYD6xcwsZ7wOl2LnIE=
X-Received: by 2002:aa7:d658:0:b0:55f:fe5f:318d with SMTP id
 v24-20020aa7d658000000b0055ffe5f318dmr723287edr.34.1706876404908; Fri, 02 Feb
 2024 04:20:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230925201827.1703857-1-aahringo@redhat.com> <d9981b21da65517589150792e8511bf192dd2374.camel@kernel.org>
 <20240202120441.xukbskkr26m6egoq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
In-Reply-To: <20240202120441.xukbskkr26m6egoq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Fri, 2 Feb 2024 07:19:53 -0500
Message-ID: <CAK-6q+iiSgZBne_C-o3iGz=+dzjVupGX6t04JbzB9DZU__q-0w@mail.gmail.com>
Subject: Re: [PATCHv2] generic: add fcntl corner cases tests
To: Zorro Lang <zlang@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>, fstests@vger.kernel.org, gfs2@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Zorro,

On Fri, Feb 2, 2024 at 7:04=E2=80=AFAM Zorro Lang <zlang@redhat.com> wrote:
>
> On Thu, Feb 01, 2024 at 12:10:44PM -0500, Jeff Layton wrote:
> > On Mon, 2023-09-25 at 16:18 -0400, Alexander Aring wrote:
> > > This patch adds fcntl corner cases that was being used to confirm iss=
ues
> > > on a GFS2 filesystem. The GFS2 filesystem has it's own ->lock()
> > > implementation and in those corner cases issues was being found and
> > > fixed.
> > >
> > > Signed-off-by: Alexander Aring <aahringo@redhat.com>
> > > ---
> > > changes since v2:
> > > - move fcntl tests into one fcntl c file
> > > - remove ofd and same owner tests, should be reflected by only one te=
st
> > > - simplify commit message (remove testname out of it)
> > > - add error messages in fcntl.c to give more information if an error
> > >   occur
> > >
> > >  src/Makefile          |   3 +-
> > >  src/fcntl.c           | 322 ++++++++++++++++++++++++++++++++++++++++=
++
> > >  tests/generic/732     |  32 +++++
> > >  tests/generic/732.out |   2 +
> > >  4 files changed, 358 insertions(+), 1 deletion(-)
> > >  create mode 100644 src/fcntl.c
> > >  create mode 100755 tests/generic/732
> > >  create mode 100644 tests/generic/732.out
> > >
> > > diff --git a/src/Makefile b/src/Makefile
> > > index 2815f919..67f936d3 100644
> > > --- a/src/Makefile
> > > +++ b/src/Makefile
> > > @@ -19,7 +19,8 @@ TARGETS =3D dirstress fill fill2 getpagesize holes =
lstat64 \
> > >     t_ofd_locks t_mmap_collision mmap-write-concurrent \
> > >     t_get_file_time t_create_short_dirs t_create_long_dirs t_enospc \
> > >     t_mmap_writev_overlap checkpoint_journal mmap-rw-fault allocstale=
 \
> > > -   t_mmap_cow_memory_failure fake-dump-rootino dio-buf-fault rewindd=
ir-test
> > > +   t_mmap_cow_memory_failure fake-dump-rootino dio-buf-fault rewindd=
ir-test \
> > > +   fcntl
> >
> > I think this function needs a less-generic name than "fcntl". Other the
> > lock tests themselves look like a nice addition though.
>
> Yeah, the "fcntl" name is too "big", please rename it to show what it try=
s
> to test. Hi Alexander, you can tell me the new name you'd like to change,
> if you don't want to send a V2. That might help to catch the fstests rele=
ase
> of this weekend :)
>

I was thinking about "fcntl_corner_tests", if this is okay.

Thanks.

- Alex

