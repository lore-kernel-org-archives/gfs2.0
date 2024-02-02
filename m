Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A201872
	for <gfs2@lists.linux.dev>; Fri,  2 Feb 2024 12:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706877995; cv=none; b=egzwwtru6FoeQetraZNV1cZ89hTIzndRZrOxRzETeJ5IVx55KhFprFjWGNx/Q/GBHLG8K7zGWd7amI4Qwcc4tVg5ZeReEsZz/rFSA9PI+u3qBlUw3iReDZrA6e8wnqrVJYR3QqIewWb6jy0H/63s4XCTn5dO0P9+zaix5WFHxcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706877995; c=relaxed/simple;
	bh=9jfYcyv3fzRGvjh1EtP920b9Eq6608+VQorfwPNs8vc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=gD+9yhcsUwMajKYTWJMT61AT/XHaraxRFNsoqVA1ViEsKb5VJNNPdHsUvORqRIr55U/qDLP/Q7Mm3gksW2ESV3cNYl2Mgckenh0bfG2sBOYApnmjnQXJhtbkhKVy7NobDjTLxECMgakcUYG37LpJAiC8BpXTxZF8ECtCx3Nnol8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hwsn5Y7q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hwsn5Y7q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706877988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P3fy6o6Dm4CkqQkXm3itLrSdJ0nt+Z5idH0kXNZm9qQ=;
	b=hwsn5Y7q2EeIfzcZXzK6uCICu7lGkAQbAsACBvpUnD8nwM0SbN3pw0D41Yu/osmxcUPJpX
	eP89hKUx5X9MygwqGD9zA7dEL/KOyBhkpUz034MnMsYFPz6fNoxtsacqw0QN2QFVB+InvG
	X+vMCEMasOz6hroTq3WJ4WXiU7urFWY=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-EV8xo2BsNwi3Wc8GGkTOnQ-1; Fri, 02 Feb 2024 07:46:27 -0500
X-MC-Unique: EV8xo2BsNwi3Wc8GGkTOnQ-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-5d6fb108807so2159894a12.0
        for <gfs2@lists.linux.dev>; Fri, 02 Feb 2024 04:46:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706877985; x=1707482785;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P3fy6o6Dm4CkqQkXm3itLrSdJ0nt+Z5idH0kXNZm9qQ=;
        b=ZYQJFtvmFlx388cGE21J/+rp7BjJ0IPAZTz1ZuoY9iSe2MFEJwRooawc5mPG/vdlu9
         OD8MqYeGHKfVPGccHVP5knkjcLWDf0SucrJg01R2Rfq4wucOM2gR0WwcaxMbkXQr+5G8
         wXXR4x2h/bXwKhL2l8O4ID5S4r7V9moWoMb52ujtOrnBJnHtnvC1fH2Geqy6IyMFCyve
         n9vfqU8T+Wj9k1gIyIodzo1ZrBHDpjxNShN4VkijpUbjCfS3s1hDSrJOcI/EMNUjGb2+
         i3qV4s4o7puPclQECO4s1uXnCL2lwU+iouxnVKgz6mdZSqcfIvhRsvDM1MslleLgLWG2
         sXVw==
X-Gm-Message-State: AOJu0Yw7cewnbXYzySD/UgI33IJ8+iAtNA7R/LUv11ElkqOfYXH2iRrN
	veRImpNsOzz0a99t4hXqzK6E8UOQ981TFQBgu32ML3KImEkL6rY+shP9bDsgnHfbpvUfAYoIz1K
	BUJmZOclr0wc0ov3YdsBmpVlAky6XQxd/JGDVrIIU+e5ufpk9+WnW3bswwsn84A==
X-Received: by 2002:a17:903:264a:b0:1d9:44d4:706b with SMTP id je10-20020a170903264a00b001d944d4706bmr2026790plb.50.1706877985657;
        Fri, 02 Feb 2024 04:46:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH5agkW0IqbOjhD10wDOksDSGeSPhw7xC39uLq64mKZhLqArrqcB8fAgBpZP4JyECBJmstSow==
X-Received: by 2002:a17:903:264a:b0:1d9:44d4:706b with SMTP id je10-20020a170903264a00b001d944d4706bmr2026766plb.50.1706877985357;
        Fri, 02 Feb 2024 04:46:25 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVVmk/B9qcoC2jyE0C2JAg0u9z0jKPO4b/fq/ODwqvBSfXYRdCFlWxro9PQtiTMo/acFp5Kty7k34QjiNIoH+QJE4Tfbrg4mUAaDwqHMCc6vxNAG3afYiFT4vqkvSw=
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id j12-20020a170902c3cc00b001d90bacc8acsm1512096plj.124.2024.02.02.04.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 04:46:24 -0800 (PST)
Date: Fri, 2 Feb 2024 20:46:21 +0800
From: Zorro Lang <zlang@redhat.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Aring <aahringo@redhat.com>, fstests@vger.kernel.org,
	gfs2@lists.linux.dev
Subject: Re: [PATCHv2] generic: add fcntl corner cases tests
Message-ID: <20240202124621.gnrgc7gfhubwqjnq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20230925201827.1703857-1-aahringo@redhat.com>
 <d9981b21da65517589150792e8511bf192dd2374.camel@kernel.org>
 <20240202120441.xukbskkr26m6egoq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <CAK-6q+iiSgZBne_C-o3iGz=+dzjVupGX6t04JbzB9DZU__q-0w@mail.gmail.com>
 <20240202122744.ejfpfrfbt6gnrese@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <43df69aa93418c35dad23d3c115241ee9170a5fc.camel@kernel.org>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <43df69aa93418c35dad23d3c115241ee9170a5fc.camel@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Feb 02, 2024 at 07:36:11AM -0500, Jeff Layton wrote:
> On Fri, 2024-02-02 at 20:27 +0800, Zorro Lang wrote:
> > On Fri, Feb 02, 2024 at 07:19:53AM -0500, Alexander Aring wrote:
> > > Hi Zorro,
> > > 
> > > On Fri, Feb 2, 2024 at 7:04 AM Zorro Lang <zlang@redhat.com> wrote:
> > > > 
> > > > On Thu, Feb 01, 2024 at 12:10:44PM -0500, Jeff Layton wrote:
> > > > > On Mon, 2023-09-25 at 16:18 -0400, Alexander Aring wrote:
> > > > > > This patch adds fcntl corner cases that was being used to confirm issues
> > > > > > on a GFS2 filesystem. The GFS2 filesystem has it's own ->lock()
> > > > > > implementation and in those corner cases issues was being found and
> > > > > > fixed.
> > > > > > 
> > > > > > Signed-off-by: Alexander Aring <aahringo@redhat.com>
> > > > > > ---
> > > > > > changes since v2:
> > > > > > - move fcntl tests into one fcntl c file
> > > > > > - remove ofd and same owner tests, should be reflected by only one test
> > > > > > - simplify commit message (remove testname out of it)
> > > > > > - add error messages in fcntl.c to give more information if an error
> > > > > >   occur
> > > > > > 
> > > > > >  src/Makefile          |   3 +-
> > > > > >  src/fcntl.c           | 322 ++++++++++++++++++++++++++++++++++++++++++
> > > > > >  tests/generic/732     |  32 +++++
> > > > > >  tests/generic/732.out |   2 +
> > > > > >  4 files changed, 358 insertions(+), 1 deletion(-)
> > > > > >  create mode 100644 src/fcntl.c
> > > > > >  create mode 100755 tests/generic/732
> > > > > >  create mode 100644 tests/generic/732.out
> > > > > > 
> > > > > > diff --git a/src/Makefile b/src/Makefile
> > > > > > index 2815f919..67f936d3 100644
> > > > > > --- a/src/Makefile
> > > > > > +++ b/src/Makefile
> > > > > > @@ -19,7 +19,8 @@ TARGETS = dirstress fill fill2 getpagesize holes lstat64 \
> > > > > >     t_ofd_locks t_mmap_collision mmap-write-concurrent \
> > > > > >     t_get_file_time t_create_short_dirs t_create_long_dirs t_enospc \
> > > > > >     t_mmap_writev_overlap checkpoint_journal mmap-rw-fault allocstale \
> > > > > > -   t_mmap_cow_memory_failure fake-dump-rootino dio-buf-fault rewinddir-test
> > > > > > +   t_mmap_cow_memory_failure fake-dump-rootino dio-buf-fault rewinddir-test \
> > > > > > +   fcntl
> > > > > 
> > > > > I think this function needs a less-generic name than "fcntl". Other the
> > > > > lock tests themselves look like a nice addition though.
> > > > 
> > > > Yeah, the "fcntl" name is too "big", please rename it to show what it trys
> > > > to test. Hi Alexander, you can tell me the new name you'd like to change,
> > > > if you don't want to send a V2. That might help to catch the fstests release
> > > > of this weekend :)
> > > > 
> > > 
> > > I was thinking about "fcntl_corner_tests", if this is okay.
> > 
> > Good to me, I'm rename to that if no more objection :)
> > 
> > 
> 
> Can we make it "fcntl_lock_corner_tests"?
> 
> These tests are all about file locking, but fcntl() is a generic system
> call that does a lot of different things besides that.

Oh, you remind me, looks like we should add this case into "locks" group.
Any more suggestions?

> -- 
> Jeff Layton <jlayton@kernel.org>
> 

