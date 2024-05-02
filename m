Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C4A28FC
	for <gfs2@lists.linux.dev>; Thu,  2 May 2024 20:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714681048; cv=none; b=EK6accbsrjIvCVaCFPOoKCu3dZPCGOesswh9PynT0oYMl7XPp5kLD7L9LiOjok2K4/ZOacKIk7Cocm6tBqD0aZLONvfEbGs5cBbtPNrKJ65n/AQAtaxw+/LG9ETZf+Xfu9lJvgWtgQFvTdSR85f1rgko43eTjo/Z7liOrpJj6dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714681048; c=relaxed/simple;
	bh=4RHxfi53wIEd6JqUPxfrXAoUpSxbk4fwPAifJPNDrhM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YkTX94VKMDJPE+PTWZm/HqMW4dXRpF8ok2/kuXOkJ96kDfN7EQ4VFS2f3wKmO8QSdAk4Hcl/EcEwoQK3lL9iEQJ93J3FuID9HIq5h3dzX7a012X62PeptIOk+MLseJQwANjYlBz5Hqbl5f+Ek17TkBi0jmMcmqljnxZy+TOj1lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZSZPuzPu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZSZPuzPu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714681045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VbBqeOpD7Ka/zVtu/tJ94H3PCNLziAZYUNi8FEkKEko=;
	b=ZSZPuzPu7+9lpRfsfnQGHMhy81cGBOHak6CLQK6r4Xvb/oYyfsBqThvJIeyUIgxa4Ht+YF
	uEYqbCnmMf/cGOQRngFG0eLOLsN2VVasbDl1A9Uzocuz4YSVkAHJHoyEWmPooff/JQKodx
	7TtfBg7vLa3WvtHVZW3Jnl+y3yJ5PcY=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-389-ioz3hMwUOCaiWLDNQn9nrA-1; Thu, 02 May 2024 16:17:24 -0400
X-MC-Unique: ioz3hMwUOCaiWLDNQn9nrA-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1e2bbb6049eso76040525ad.0
        for <gfs2@lists.linux.dev>; Thu, 02 May 2024 13:17:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714681043; x=1715285843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VbBqeOpD7Ka/zVtu/tJ94H3PCNLziAZYUNi8FEkKEko=;
        b=a4JK53by2znoApnfmDXWiXhUGzbmVgUkAcK3/dnRh1xVOyT/Kqw2iEZ9ZfVj7s7JTU
         F18iivvKYtLIqZ1OeMHdglQv3bYa0ax58y+BTXi7o1PD/0c1CvwjuXDQqk7+sCdkNTQq
         q9Q8at0/3Ts7cecFJ7KPxtIwkAUHrUmRumnEGRKkHOeswkFTGg0rr6TdfSKruBbBCa1Q
         g5EX3DwTXO1aPvzT+XN4BV86NpVnxYX026fk/SmoXODcWm63GcOw06hc7z8gsF1R+HoZ
         TQadr+Ms9C7v3qXVka0p1R7Q3+bETQ6PjuB10BnSk/eWZcKmhzwSLQf318v8WRyQs5M6
         VAkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtnVrFgpxPt2szqZ0+OMM6NVW3WzJ1GZ/pCPAnDTBAZ9uMpeEUmFQ9Xnky2ZNjr1iGFfk/ic8vTOIuEkSF/MrgaGeA+A==
X-Gm-Message-State: AOJu0YynjO1vJKKM/dvLpAYFBE0V/r4uDdpmZQZQgrhM4euXBgccoFs6
	rBVdo4azlSEP98a5blWnuaYCT3eXqoO+IwBjHoMWBgvyT0vTQHc5O/+1vfLfNjzAgcTXH7hAwzc
	hfXIhy/fsYt++0jyzYB4rC9PJGm7zbNHIu9a2TvM2ajvNtoR/PTnDgfxfmLEtsSo9v/0djvtBF/
	VtfNyUyfahy1AHwVlK2mQ+QPU0Jg==
X-Received: by 2002:a17:903:2283:b0:1ea:26bf:5989 with SMTP id b3-20020a170903228300b001ea26bf5989mr979544plh.1.1714681043207;
        Thu, 02 May 2024 13:17:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IES8pb2h5WMXry13XBJ+sx5LzQj27HizreXZd3yLm/TbuqBwvZVFnMvkbisY810Hd1pBjgIyDgiLaHbLeMJ1i4=
X-Received: by 2002:a17:903:2283:b0:1ea:26bf:5989 with SMTP id
 b3-20020a170903228300b001ea26bf5989mr979519plh.1.1714681042829; Thu, 02 May
 2024 13:17:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240403172400.1449213-1-willy@infradead.org>
In-Reply-To: <20240403172400.1449213-1-willy@infradead.org>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Thu, 2 May 2024 22:17:11 +0200
Message-ID: <CAHc6FU5-1Qm170Qc_DV1zEidd+hQEEGDa6K=tnmKjfOm=Hnb4Q@mail.gmail.com>
Subject: Re: [PATCH 0/4] More GFS2 folio conversions
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Willy,

thanks a lot for yet another set of folio conversion patches.

On Wed, Apr 3, 2024 at 7:24=E2=80=AFPM Matthew Wilcox (Oracle)
<willy@infradead.org> wrote:
> Yet more gfs2 folio conversions.  As usual, compile tested only.
> The third patch is a bit more "interesting" than most.

The third patch looks fine to me, as does the first and fourth. Those
are the ones I've added so far.

The second one is problematic; I'll respond to that separately.

Thanks,
Andreas

> Matthew Wilcox (Oracle) (4):
>   gfs2: Convert gfs2_page_mkwrite() to use a folio
>   gfs2: Add a migrate_folio operation for journalled files
>   gfs2: Simplify gfs2_read_super
>   gfs2: Convert gfs2_aspace_writepage() to use a folio
>
>  fs/gfs2/aops.c       | 34 ++-----------------------
>  fs/gfs2/file.c       | 59 ++++++++++++++++++++++----------------------
>  fs/gfs2/meta_io.c    | 16 ++++++------
>  fs/gfs2/ops_fstype.c | 46 ++++++++++------------------------
>  4 files changed, 53 insertions(+), 102 deletions(-)
>
> --
> 2.43.0
>

