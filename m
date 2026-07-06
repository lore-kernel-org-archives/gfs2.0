Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197C940A933
	for <gfs2@lists.linux.dev>; Mon,  6 Jul 2026 13:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783343765; cv=none; b=OqntgcvwjoNHMuNAANSF2WAOks9FC19MbMGO0da9jrW7xakK/ErNnD/C8t8ooKvl1dVKz41bRlaSRO1mNGD9MDSfYybPcXdt7Oqa+ypRj4Ljghq4NgQKF2qoWHgIYTQrVGLQX2gY670pVQSl4L45YJ5A1Exp7MioVNH8kW7Q2pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783343765; c=relaxed/simple;
	bh=ZG4slmePuA8hAwfYnmF/1n5HJkJeLXV2KFDHoBeiAmc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kaZK+NXw8hPUZf3nMlFABD/XvZP5GQJ+7atuO+6eHoviLyLUmeNqsKtXeuoP7hUFgeCOmCLPGsw+B1PCtPmfcujaJ5YyT2mZn54uqq/PMrnZxVUlOfd4/5Z4Ymh4kBlLMmVx3RZ7YZb1TrLq2Lls7ydXl1PnTVItwd/+3JboKoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CxSA+Lc1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CxSA+Lc1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783343763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AxMOA32PrhBgJC1rEErLDcIUQtikuP/rNGrPj73qrKE=;
	b=CxSA+Lc1ttmV6E3ihZHLeSTzE87AL/TAUAhffhYqZBQrOqVfR4kV5aaMb2jC2ihvtEIlRs
	UfKxj9MsrHi9qR+PKUpq7EJNUhuccd4stO+bP792h/ywbYjxEy/AaJO4FJDCoHSovACndl
	+vqldmk868fRcC/z/pctQbtaGJcEXQk=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-hP5bHmo8PkWTMFYZkBR0_g-1; Mon, 06 Jul 2026 09:16:02 -0400
X-MC-Unique: hP5bHmo8PkWTMFYZkBR0_g-1
X-Mimecast-MFC-AGG-ID: hP5bHmo8PkWTMFYZkBR0_g_1783343761
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-80d9b6fd492so96444457b3.0
        for <gfs2@lists.linux.dev>; Mon, 06 Jul 2026 06:16:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783343761; x=1783948561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AxMOA32PrhBgJC1rEErLDcIUQtikuP/rNGrPj73qrKE=;
        b=QjcwWS3X0pIKcxjJ44JarHjFufnBOWXDqyKyUEFhyV2G3Doo4ODkaxtHd8aU3TROMO
         KthzaFUTqH0Ec8C6C/7I1VnFGVx/car9CgUjhkbMJFdWlqyub7osYTZXeSFfnHIq7JDo
         my6+qpOJQFGffViXbnWejXM2uBOMFwsgP0sDNoziQ1vZSmZdluvst0OeFogDvBhzcbS6
         OIbk1FF5pHNRmc6pCakhVgTEHLRGPe74AoTjdmPb14HEBrUx0L6/s15eOaUOlGGbTBEX
         rLFPMs2bl7bK0LKqSLSzMefSu2+9GSnEFzmfUoTsB+Gc0ph6WjTVJymyzhdshnqO3n2X
         FwEg==
X-Forwarded-Encrypted: i=1; AHgh+RpZExGMB+XAYli0XeoCqXpwxZuE5v4OGMJPf7DB1XwDw7vL2co1+BYXgcpcs++dJYm2SQox@lists.linux.dev
X-Gm-Message-State: AOJu0Yw4OUUJa6aVs9PotJjetoG9J0aLdVT39/TonKpa/175SWdjxx6U
	3j7EprGy+X77kHkk4Q1/DthB7JgkrhMogZOa39tA0rwi4QY3Dqhkhh8qPhu6c6+7zav638jV+BU
	HIYwDR29sDsKXjzndON48VaqLzSVhc13YEFAa7jhQDhdhCjLW99oowY+HA6o22F8FehPwB1VmzI
	sDnFKU2lCOgRxd/9wLdrwXrh6ACTvgWQ==
X-Gm-Gg: AfdE7cm5Etj0OphZTcB3/Z4S1Q6G9SRwtdHHMo//guFHSy+RBAqFdQdwASIvfvJnvMV
	P28p9KHhVJDJMtWbDBPqTs10mo0Xl3KSSIpFKYo97S6Dsqc9VFAGBJzTRKrU8IJ8FQ+GQ5Emo1C
	o9Y5thW7cxRZP9oHsPzlyLMo7imgEW8eOWudOHJPYs/j3PfixSP3LKdzRR7lj44Oaef/GzqNwEn
	PT+snC6/cSs/k2h9whd7AscglFYK8hFdKNrDIa151SYq/EGHgFz9iQ=
X-Received: by 2002:a05:690e:2027:b0:666:53bb:bc1f with SMTP id 956f58d0204a3-6677fa5a3efmr346441d50.1.1783343761122;
        Mon, 06 Jul 2026 06:16:01 -0700 (PDT)
X-Received: by 2002:a05:690e:2027:b0:666:53bb:bc1f with SMTP id
 956f58d0204a3-6677fa5a3efmr346388d50.1.1783343760532; Mon, 06 Jul 2026
 06:16:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAHc6FU4tz8-HmEf2_XKT0NT8N=rv5OMcY79PxTACkXAVLOAUpg@mail.gmail.com>
 <akZEjH2Hf8-RR8yQ@infradead.org> <akhaWrUHXcubQQab@casper.infradead.org>
In-Reply-To: <akhaWrUHXcubQQab@casper.infradead.org>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Mon, 6 Jul 2026 15:15:49 +0200
X-Gm-Features: AVVi8CeZ90TZOgMX_QaiF2EyLUwZK6uqeXE5eQFowT0YnNBZfC21D0pOzkVqfoY
Message-ID: <CAHc6FU4-GsE1jtw8kXe0h_-T6VK2bB5QuVm2w16Ek6FiUV77tg@mail.gmail.com>
Subject: Re: iomap_writepages WARN_ON_ONCE(PF_MEMALLOC)
To: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>, Christian Brauner <brauner@kernel.org>, 
	"Darrick J. Wong" <djwong@kernel.org>, gfs2 <gfs2@lists.linux.dev>, linux-xfs@vger.kernel.org, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	cgroups@vger.kernel.org, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _NZC4DfVmJ7C2H7E8sgNW6Ah6DXPiRTHsjktkJEZLEE_1783343761
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 4, 2026 at 2:57=E2=80=AFAM Matthew Wilcox <willy@infradead.org>=
 wrote:
> On Thu, Jul 02, 2026 at 03:59:24AM -0700, Christoph Hellwig wrote:
> > On Wed, Jul 01, 2026 at 10:51:06PM +0200, Andreas Gruenbacher wrote:
> > > Do you have any suggestions?
> > >
> > > The above is on RHEL-8, but a similar code path exists in cgroups v2,
> > > triggered via:
> > >
> > >   echo reclaim_amount > /sys/fs/cgroup/.../memory.reclaim
> > >
> > > That code path starts with:
> > >
> > > memory_reclaim -> user_proactive_reclaim -> try_to_free_mem_cgroup_pa=
ges ->
> >
> > PF_MEMALLOC is a sign of direct reclaim.  cgroup code is doing really
> > weird things when it is set and it is doing writeback.
>
> If we're going to blame the cgroup people for doing weird things, let's
> cc them so they stand a chance of seeing this ... original at:
>
> https://lore.kernel.org/linux-fsdevel/CAHc6FU4tz8-HmEf2_XKT0NT8N=3Drv5OMc=
Y79PxTACkXAVLOAUpg@mail.gmail.com/

This is all pretty ugly: inode_lru_isolate() selects inodes that have
a clear i_state to evict. Among the inodes selected is at least one
gfs2 inode that has the GLF_LFLUSH glock flag is set in
GFS2_I(inode)->i_gl->gl_flags. That flag means that evicting the inode
requires flushing out revokes. Before that log flush can happen,
ordered inodes need to be flushed (ordered journalling mode). And this
is where iomap_writepages() got called.

Unfortunately, filesystems cannot refuse to evict inodes once they are
chosen by inode_lru_isolate().

An acceptable way out may be to set an i_state flag whenever the
GLF_LFLUSH glock flag is set so that inode_lru_isolate() will skip
those problematic inodes.

Thanks,
Andreas

