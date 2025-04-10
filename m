Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1196E1F152E
	for <gfs2@lists.linux.dev>; Thu, 10 Apr 2025 17:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744307311; cv=none; b=ParvajoTqkAN22vGSsUij+y6Ehqc1DNAkekHbiJ+CEufhow1J15AppObXyOkJqdLueW8H0zFM4OP02kOYUWPZLiZFpdOfcNkeg2c9j3p3D7U3XMlRFfyh2LsUhyV3U/czgiYHnO6QmnsIye8CbmJJ31mGAS+MKwmboH1oIx2CjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744307311; c=relaxed/simple;
	bh=9kFVBt0xmNJ1O3N7xNDOXpsY2sp5HC0wOX9IKhNyfoM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ay+OcxK4uRH2paj6HDrYTIXi3cW6PEXMyGg0PzB7WJcQlJRmO/PMErTyhFrqiypPbTHO7tDvJPy/TMzD4x/4fwWbBJ2wbfpbX4+02EOD2q0n1kid3omvbVteY1BGFgxknkmk8JoF1Im1U3YupFRO0vG3O2Wv6FoyBnN9l9L2z94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Igoq8XiO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Igoq8XiO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744307309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OqvPNxA7jww3BXXOwYN/gaN85wuxZPgfj7tUlo1Pygo=;
	b=Igoq8XiOR2jq/FzPAumA9aWR2qErCcMAyz6s3JlB9EEI4xDcCXXp9FEdmEi/q0ByLxeCJ9
	ugiRj3jejH0O45K8chmG0RU1PgDuCS6jq0OUWLSShyW2GQVerQADXPh9B7ZVd094OxVD4N
	mMvEApChBM5BEhJlUHv+cNdLWwbPjvk=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-Pul3gvZYM2uAx1DrDXzXGA-1; Thu, 10 Apr 2025 13:48:27 -0400
X-MC-Unique: Pul3gvZYM2uAx1DrDXzXGA-1
X-Mimecast-MFC-AGG-ID: Pul3gvZYM2uAx1DrDXzXGA_1744307307
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2240a96112fso15554535ad.2
        for <gfs2@lists.linux.dev>; Thu, 10 Apr 2025 10:48:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744307307; x=1744912107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OqvPNxA7jww3BXXOwYN/gaN85wuxZPgfj7tUlo1Pygo=;
        b=pVAmrHIxmW1FuGvzVYFHg4wdzeMloMqNQpvnQVDGel5v10B9Juik7m+YTWeB0GajVO
         wjx8GMD9fBHDQvS8KQHCIS9FRTbiZ4SgGT3GAiczzyVIY0n1YAvcU5zMnXBV+Qmb8SlF
         UvfnkO/ujIz/BHzXKTHFW2re92veEkGfcqTEAoYXOXAJPVlbDY4B6f1gHvymbmvOSf1y
         Fr4XZ1CGk+7lY3ErsK2liu/U0FT/+DSRf5tE7PIUQW+OweEfh6WijAzJx/PUu43YG74V
         gh6F04tmGIhimpH4qv2PZjhtku2Qd7UFqIBs22EjDiJ8n32xTg3aL6X0kC+fV+ZQdVV9
         oVzg==
X-Forwarded-Encrypted: i=1; AJvYcCU6K0d6/crGlqNQuqVgn8FFaXVfznykDQLXimZc+yJpWrpfnb9LAJb4jxjXAgm2imw7IQqZ@lists.linux.dev
X-Gm-Message-State: AOJu0Yz6+EGNE/p2OKiD/7o8Okz+zGhdtjR+rB3QzdoF+deFBDVv3XJu
	79uhPu4AQ+ZOCHmNXzI2MTXyh7vcGLZ0Zkt/6iAbbO8PvMbm2QpeKIvfp3x9MxL8aYHG/MNSzi/
	WFTz0iI3zHg1VhWousAVCK0gOXKgRBUqyrsGZ5fKpM8SQ6jq5zw+FiwdAG+9fMqkLl/K5oOssGo
	fsHxFDrVIa+4o3zzdLYMBtiJzoXg==
X-Gm-Gg: ASbGncu4PzUz94ylTThKyQ55GHf+SW3pp8xesaoTL72odRZtNgWyDDbhf3klvZyQuWI
	snFCubBtBQZIQChHNog666ARoDqX1l34ECs/zi3PhT8MMoIVIQAhqegFTTGv5LTlMuws=
X-Received: by 2002:a17:902:dac9:b0:224:1579:5e91 with SMTP id d9443c01a7336-22b42c5ac2amr51880235ad.47.1744307306898;
        Thu, 10 Apr 2025 10:48:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUo1DbI1h9w9OLlDnjq5RZSX9CGytc55kczInpUMCnGZepk9T1FYX3YU4pw1A+DuQV82ASCx1d3eK2A6PEVwk=
X-Received: by 2002:a17:902:dac9:b0:224:1579:5e91 with SMTP id
 d9443c01a7336-22b42c5ac2amr51879845ad.47.1744307306483; Thu, 10 Apr 2025
 10:48:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250407182104.716631-1-agruenba@redhat.com> <20250407182104.716631-3-agruenba@redhat.com>
 <Z_eGvBHssVtGKpty@infradead.org>
In-Reply-To: <Z_eGvBHssVtGKpty@infradead.org>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Thu, 10 Apr 2025 19:48:14 +0200
X-Gm-Features: ATxdqUF2qSG62wdzI_CXx71qpQw7c7dGZziC1q7bbQkSEqifIFryfqrjJnWzITo
Message-ID: <CAHc6FU6NHxG-Tn+5tn2zy3QJFVruOM6tG7DsDi1sF+vDw4Xr_g@mail.gmail.com>
Subject: Re: [RFC 2/2] writeback: Fix false warning in inode_to_wb()
To: Christoph Hellwig <hch@infradead.org>
Cc: Jan Kara <jack@suse.cz>, cgroups@vger.kernel.org, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Rafael Aquini <aquini@redhat.com>, 
	gfs2@lists.linux.dev, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Pp7O1ymlMNOAQJMKOAGpLDLBXJ5CC6bsJsf_LuX_b98_1744307307
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 10, 2025 at 10:52=E2=80=AFAM Christoph Hellwig <hch@infradead.o=
rg> wrote:
> On Mon, Apr 07, 2025 at 08:21:02PM +0200, Andreas Gruenbacher wrote:
> > -static inline struct bdi_writeback *inode_to_wb(const struct inode *in=
ode)
> > +static inline struct bdi_writeback *inode_to_wb(struct inode *inode)
> >  {
> >  #ifdef CONFIG_LOCKDEP
> >       WARN_ON_ONCE(debug_locks &&
> > +                  inode_cgwb_enabled(inode) &&
> >                    (!lockdep_is_held(&inode->i_lock) &&
> >                     !lockdep_is_held(&inode->i_mapping->i_pages.xa_lock=
) &&
> >                     !lockdep_is_held(&inode->i_wb->list_lock)));
> > --
>
> This means that even on cgroup aware file systems we now only get
> the locking validation if cgroups are actually enabled for the file
> system instance and thus hugely reducing coverage, which is rather
> unfortunate.

Right. Is checking for (inode->i_sb->s_iflags & SB_I_CGROUPWB) instead okay=
?

Thanks,
Andreas

