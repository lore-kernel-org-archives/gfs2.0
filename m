Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FB91C861C
	for <gfs2@lists.linux.dev>; Mon, 14 Apr 2025 23:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744672736; cv=none; b=UvqxYxIuip8Issok6UL6BBFYZuCe4FCi62O0xvXysGsuVm98YE0FJFEhGpVHqebZvLZcym4DgLmvf17qNd+t680CsT8guev0KTziPrtcbXk6bWIkEn5jN+7bd6T7uQm+E78R7J/SmiPNc5/ICUCJK3+WGMcDFV7GBN4QaZ/64Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744672736; c=relaxed/simple;
	bh=Vpzaudbp8Y7zrbb390HW78JJPo4FnSlXlz76ZxNyXGY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=av8xih4URt/+D6tsqH/DoVablatbfSdS3EN+LES3/rtYvLEWJS1xRdTsPYZp1KyHW3TSi8zWJ1P08xwUrYkGQb+Iavs4qo7u9MSoQ49gIZgvB6qviImcGfTrbEonigiXrh6Ns4LY6mDmaDcAxBqSC1B2tceqS7OmZjZ2i/22TAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aWCYOHIP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aWCYOHIP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744672732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qaoK7poL4lFt0zzKd827Q2KBVOP06dQDJUh2ihDBMGA=;
	b=aWCYOHIP9idtg8DWBhWhbzaCK/LD/4jQxJoMSdhUtm7dMsy7KfPiqWcrvnC6UHT60eH94D
	CpBqMSaYG1Xj2kx518kQ4Pf7La4hJ6xM+1ekFgvAEwXsJbv5j0EKWfSwXAJfKkuCYKmVqy
	Q+ZEc5NwhhBhzzTxb1SQhC9ueT5f1UA=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-knpbwLBdPVy6T65B62mu8w-1; Mon, 14 Apr 2025 19:18:51 -0400
X-MC-Unique: knpbwLBdPVy6T65B62mu8w-1
X-Mimecast-MFC-AGG-ID: knpbwLBdPVy6T65B62mu8w_1744672730
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-224191d9228so59143395ad.3
        for <gfs2@lists.linux.dev>; Mon, 14 Apr 2025 16:18:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744672730; x=1745277530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qaoK7poL4lFt0zzKd827Q2KBVOP06dQDJUh2ihDBMGA=;
        b=R8RtKuiVSFzC3bKemMJzQqiAmfM5UigSkg1HROZobN/pgoc69nlBVqeQegQnad4ABL
         jdDa/m3Zt10t5ph1iEsidEBMggmDBBLFUCpYy0hU1QY26WRsZagbGu/JlJn5U5F4hS0p
         VYXnRy3qxyaRYdkRST4DN9pZtMvFzBGUBalxFrWTh1A1cXsD8RoHktINKURmK+zomRgi
         d07j27JmfmavV5+HDfpSxqTpjYVVR6pfYzoB+nzW0nGQyELxNCIOlr9sgC8m8Kz3if40
         R3kc0+xMsmILqegUisSRd+qcOfktQDaB+bQY5KmHL9YXb470ADnM2N9j1pMzcGQnRIks
         /RmA==
X-Forwarded-Encrypted: i=1; AJvYcCUEFIAzZHiAI12Bj69RfV0JhhvrJMS7PTy28HD27ihm3IfRcZPHDqn7ux1w+t6fTe2wsfTf@lists.linux.dev
X-Gm-Message-State: AOJu0Yyb9+PQzFTxQ1yMlZTHHnSCl3At8rnJdypK3chTvHbQIFNr24iY
	ViZ7vWSXi9achLdwAEaK0vb75+XZfxBJF9UL1343DN/IJDNF+G3shrnxBfa0XxoSWDqZADLEi1V
	Wwm2KbmIISHJL9YMAU1St8ncU3ywXcj4eenS+XAHftVNHsAT1MdWGyHJ9DRgfFyV4l8h7tPuMaw
	/ZzG9fyEHPX6qQPNGV5xlVNrJZDg==
X-Gm-Gg: ASbGncuDiHXcqsnXMqIxugXM0jRhEOTnGEc/mDbqgQwtIXaKCOVw3uEnGFGcWNQ2pvw
	1x2CsxZiuGRsIG7vooVQQCoy0NTqM/49LEZr0ja6X7mKifLf0iEZPEO07vJuEbkvYjls=
X-Received: by 2002:a17:902:d481:b0:220:f59b:6e6 with SMTP id d9443c01a7336-22bea495687mr151860695ad.8.1744672730472;
        Mon, 14 Apr 2025 16:18:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTkx4rzJcGUvdjR+8IkBuWXjpb03TgR9MDlGC2OL5q8ZwLfz7AdIcQ7zVCufAPTrl8j8sJhif/5Ghk7BA8IQ8=
X-Received: by 2002:a17:902:d481:b0:220:f59b:6e6 with SMTP id
 d9443c01a7336-22bea495687mr151860555ad.8.1744672730227; Mon, 14 Apr 2025
 16:18:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250412163914.3773459-1-agruenba@redhat.com> <20250412163914.3773459-3-agruenba@redhat.com>
 <20250414144741.56f7e4162c5faa9f3fb5c2a6@linux-foundation.org>
In-Reply-To: <20250414144741.56f7e4162c5faa9f3fb5c2a6@linux-foundation.org>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Tue, 15 Apr 2025 01:18:38 +0200
X-Gm-Features: ATxdqUHmoD9wBQhxdgcyUd4MlED8R-VRCkPirnQXdbKIxEeeDfOLknsoCdUpMs4
Message-ID: <CAHc6FU5EMw_S4FHyBLRinTdDc-jh9WPOnabSdvHuVF_MPWQkMw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] writeback: Fix false warning in inode_to_wb()
To: Andrew Morton <akpm@linux-foundation.org>
Cc: cgroups@vger.kernel.org, Jan Kara <jack@suse.cz>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Rafael Aquini <aquini@redhat.com>, 
	gfs2 <gfs2@lists.linux.dev>, Linux-MM <linux-mm@kvack.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lq54JQrM_8BZ30j2lxye0FdfGDwy9oTFbCJLttyBlA0_1744672730
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 14, 2025 at 11:47=E2=80=AFPM Andrew Morton
<akpm@linux-foundation.org> wrote:
> On Sat, 12 Apr 2025 18:39:12 +0200 Andreas Gruenbacher <agruenba@redhat.c=
om> wrote:
> > From: Jan Kara <jack@suse.cz>
> >
> > inode_to_wb() is used also for filesystems that don't support cgroup
> > writeback. For these filesystems inode->i_wb is stable during the
> > lifetime of the inode (it points to bdi->wb) and there's no need to hol=
d
> > locks protecting the inode->i_wb dereference. Improve the warning in
> > inode_to_wb() to not trigger for these filesystems.
> >
> > ...
> >
> > --- a/include/linux/backing-dev.h
> > +++ b/include/linux/backing-dev.h
> > @@ -249,6 +249,7 @@ static inline struct bdi_writeback *inode_to_wb(con=
st struct inode *inode)
> >  {
> >  #ifdef CONFIG_LOCKDEP
> >       WARN_ON_ONCE(debug_locks &&
> > +                  (inode->i_sb->s_iflags & SB_I_CGROUPWB) &&
> >                    (!lockdep_is_held(&inode->i_lock) &&
> >                     !lockdep_is_held(&inode->i_mapping->i_pages.xa_lock=
) &&
> >                     !lockdep_is_held(&inode->i_wb->list_lock)));
>
> Is this a does-nothing now GFS2 has been altered?
>
> Otherwise, a bogus WARN is something we'll want to eliminate from
> -stable kernels also.  Are we able to identify a Fixes: for this?

The excess warnings started with commit:

  Fixes: aaa2cacf8184 ("writeback: add lockdep annotation to inode_to_wb()"=
)

Getting rid of them requires this change, together with "gfs2: replace
sd_aspace with sd_inode" from gfs2 for-next:

  https://web.git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git/c=
ommit/?h=3D
    a5fb828aba730d08aa6dec6bce3839f25e1f7a9d

Thanks,
Andreas

