Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F9D20D505
	for <gfs2@lists.linux.dev>; Tue, 18 Mar 2025 13:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742305514; cv=none; b=OKsxPPjWiPE2O4YZxnC1mmFVEFqI/2ZMEvPQeqkNzEX0GHR+FladhXAat9xoG50GFpFUISji9IkI83b/kAVWiuWYLWgik8d3yu6O4kZOKEe2OB6xbk2sk6LfgEuSLeg+al26m4lonHm4REZX7KDij8DtDQRQ3fgAPMk43Y7awR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742305514; c=relaxed/simple;
	bh=F0enmnWDSBZDU7hVEfx25HAOemvA57Z4DSWg6u9UcmI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EQCenkggXUtXM2xDNgBLNfBiZazdTLOBKFckQo6D5Z+twGHsfwHRsZN6auMMQKMz9Rf65VgOl0It47GOvVl9ZXt9HWnVdH+bux+PAo6p+lOYTSLOcVdNpDOcooEXKqpN6cg0JtE8mpFq5gfIDOP0kVXWx/3S8tssAwAIy2p05H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V5ADFMNa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V5ADFMNa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742305508;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F0enmnWDSBZDU7hVEfx25HAOemvA57Z4DSWg6u9UcmI=;
	b=V5ADFMNamy5UtWFv3JHUnnwk2JWUU23p/zze6nT3JDEIPv5bcAW5vRbnUPIFCYL59t2Gkj
	RKMVkOuZQS4oo0tQJP94qhvhJc7xkO7aCN0YZitzXY5TFyjHEIvtLL3eNUoN5s0WXZbUoR
	+wPCsbvLVDawpIXXCqEplYaBWEKVrqs=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-WPZTue2fN3G3WgKWQR9JGA-1; Tue, 18 Mar 2025 09:45:07 -0400
X-MC-Unique: WPZTue2fN3G3WgKWQR9JGA-1
X-Mimecast-MFC-AGG-ID: WPZTue2fN3G3WgKWQR9JGA_1742305506
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-30bf7dee799so63607951fa.3
        for <gfs2@lists.linux.dev>; Tue, 18 Mar 2025 06:45:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742305506; x=1742910306;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F0enmnWDSBZDU7hVEfx25HAOemvA57Z4DSWg6u9UcmI=;
        b=RiLKJsn8UgWlChfmKoCr09OMDC79QIlJroAYbM3SpvSFOaYAhxHIom4IG8Fk1ddkSm
         mMjA4RCAXhQVZ1CQOPNf7IXq7tgR1kcUy+dQMG8WnRkm/N7EhYo6IjHgD4qNu49oayXF
         pJNDiMZnO4XgXMWt+hbdNp0AZlKpABcYVm6nZd6mVzUzcCpG2k4Ez9gqJJAbhtW0O3cF
         U/5TsQbwp91UEK50fCxW6+k4JGceUYHETWtkPZu5/nM9UusbB+4e3e+HjiupqwjnHuIK
         1W0hFijYjv/f+tSSYv64g/Eu/O/fx9GpIVvw+CLTZV1qd+W6DrL1hRaeRwlI5OCV0bOZ
         45KA==
X-Forwarded-Encrypted: i=1; AJvYcCWxdkFDjKM2JoHzl9C97p5/Mkm3NJZjOTq5hPQsIjsq/kXVotGgvYwwqVynr6382g76ULbP@lists.linux.dev
X-Gm-Message-State: AOJu0YwwKw6MFo+ZhbeZu97CVQPg248i0/4inKoTH8KnQDHjpAcnfe6l
	x86LF8WMS/5t/UBBN1L68U0B86UIkc/lJyymJ06aEUMMoxKoNfD4hRt1ZgP02mwGBLtTL5c4P6T
	QHdkkfBMlUvYA6Jjv4fYUNNaM6GrVR21SUiO6v8zF5AhxgoNKfbnmUlxN7Cb5ZScDpasJpdVr5d
	oac+Rq6X97UzBPhy8YW0iEY+Ne/g==
X-Gm-Gg: ASbGncs96FCYHzl6Pgu0Quffll2ldWoqwUofiJMVSEyWjwaGJ1QZ3cSqzNcAueSOYAp
	XnrqV1zsD3CCjWdlhQVJcl8hDspKykKxVkYkzKaOGl7FiUSeN1kKRR5VNUDas/i2k1HugVt6BYa
	gQfBjdHFgVQaw1dA7RBmTvyCr8MVjIyA==
X-Received: by 2002:a2e:b8d3:0:b0:30b:d4a9:947c with SMTP id 38308e7fff4ca-30c9a9282e4mr32223911fa.24.1742305505813;
        Tue, 18 Mar 2025 06:45:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4kVD24sQ+mUjOqf7yZNsRXCusLL5P99XhICfTtx47kHbtFNh0LDWlQyBX5+5qmzVaXgaGWFu/kKZNtKP59is=
X-Received: by 2002:a2e:b8d3:0:b0:30b:d4a9:947c with SMTP id
 38308e7fff4ca-30c9a9282e4mr32223791fa.24.1742305505471; Tue, 18 Mar 2025
 06:45:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250310073623.18607-1-heming.zhao@suse.com> <20250310073623.18607-2-heming.zhao@suse.com>
In-Reply-To: <20250310073623.18607-2-heming.zhao@suse.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Tue, 18 Mar 2025 09:44:53 -0400
X-Gm-Features: AQ5f1Jo9Ykkn-RHNx3LvSs7N1lj5E3nooNBQu8VwlTmk2LazftCXaNpJB_iWUHg
Message-ID: <CAK-6q+i3+Q=VEd3cf9Br73uHODYtU_zUuegsa=Fx9=2Ws8vrFg@mail.gmail.com>
Subject: Re: [PATCH] dlm: make tcp still work in multi-link env
To: Heming Zhao <heming.zhao@suse.com>
Cc: teigland@redhat.com, gfs2@lists.linux.dev, glass.su@suse.com, 
	zzhou@suse.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ue8JTJTedoip5w1uCtwd1hfee64IiLl0dBvHCUsbkJs_1742305506
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 10, 2025 at 3:36=E2=80=AFAM Heming Zhao <heming.zhao@suse.com> =
wrote:
>
> This patch bypasses multi-link errors in TCP mode, allowing dlm
> to operate on the first tcp link.
>
> Signed-off-by: Heming Zhao <heming.zhao@suse.com>

Acked-by: Alexander Aring <aahringo@redhat.com>

- Alex

