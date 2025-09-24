Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D502417DE
	for <gfs2@lists.linux.dev>; Wed, 24 Sep 2025 18:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758738196; cv=none; b=dC5Mmge1F61YSzlAruz7YReJ7wamyjPD1mK/iTwuWOnHZ68XKdNfaIRZJTrJmraVJZBXoveG/UJvRoDDbcHvSfdg82nNj8uUQLv30M9BZ8ABn2bdQTl8eGtfIwlrNZvtGJs1UMhfrAX3A+BzUFcDyU4Vvu37kZIOlwLgnrVYyNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758738196; c=relaxed/simple;
	bh=r/pO+CZyHHxpu+YW1zwr7CM/wT81oD3rByhrRLtBYgk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YB9CtNKhb6+NoMAydqljTVsP+a0zi6K1/mdJjXQMMzNJAllefecyFD1XJmKXWHH4/hZixgnEaYxzn6nCiqRGMPlAVDxqyGd9fnv6/p4tg3z4Wxh74jbnmtLRA+sJlPz3ahoso0hb36X5asnXRsR1jWWtPY8Mk0fGCIohr4fcml4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RBCD6W6f; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RBCD6W6f"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4c88e79866aso1149271cf.1
        for <gfs2@lists.linux.dev>; Wed, 24 Sep 2025 11:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758738193; x=1759342993; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r/pO+CZyHHxpu+YW1zwr7CM/wT81oD3rByhrRLtBYgk=;
        b=RBCD6W6fKx06UnaKssL3HLFo4KT9GgqMSf4rTKlnfSSdN+2HeyqswMF0ZOCnUJ77if
         ZdQvPO/eBj0vf1g/IIGL3RLC0eP7TQGRr3qlS6ME3A2WpM31R/HR83C6dzoqEazGHsWK
         XLyaR5fc1y9rTiWrQgzvcCzj5oK+2W+c183CuHNiOmd1D7hcOJRhrptkLhHTrvh2jrEf
         67gT8z0UzoLJa6e16PIEbK/R0S9BalC13mqTh5mlvWHpGcganKpUvKqRaaCepGGOARE1
         n6MawGra+CmfOQ0VPlzWdz5arV5zbsNLHeOrp0rDGq6trTbQtN+BpkMuWtJiC0TRgw0o
         crkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758738193; x=1759342993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r/pO+CZyHHxpu+YW1zwr7CM/wT81oD3rByhrRLtBYgk=;
        b=mdz9xxXkuRCbssLrO4MIBQURWq3x81CPWx7s3Y0G7ALRu0g0KX9Qa28+2rtgaY8hpp
         Zz0Jg1xTtbSokEjeAtqtnXrcbsL8upglo8LSEx8DyHX6zjTqJAbzd0oZYmMRClanXWJO
         tjKqbxV7g3ifaHhz+8xloyWkTBkgLPpx+plqbeoO2b5BpzvYsMfogMhlgkw34gTeNR7T
         NuXWoX4HcgPn8rKw5EAUV2uFD+XGEFW8eF1i8XiFU2tE3SDznEjPxTVTFJpnP6jIGBku
         fw0VsWmxrft5QQpTDcaAOPsRUpO1St9tuWgmdMnXckQhLj/z3w5MFVyoa1cQAZ5YzD1j
         ZvtA==
X-Forwarded-Encrypted: i=1; AJvYcCXTLa23PbWKSFF9x8wlqwJjflMFswZZE4WYvK3xIue/raFCE9fYVFckXtVjTxUlhm/O6t7q@lists.linux.dev
X-Gm-Message-State: AOJu0YxvyK46Fp9u4whfxiespnw/oQpE501GZmecgLfmMCp3kD0XNvwe
	I/IznMmZWFu+5qhE0ik3YRmoMlmhaB0Rkn2ORhoa/6SKBTT2NOZfe8moDluD9GDOUgA7nz+WjlV
	Ff+qFHjYqbJerKgywSxfxY0R5jypAZdk=
X-Gm-Gg: ASbGncvRt3z6ypp+oBM6oWjhx6Q5dDR34GHJzLswQ0Ay7L4zr0StcV45HzeFKSgCwnR
	nYBp1erz7H7R6QRZeH1YyuhUMSue06LWzaHYVyCKIXxozu8k4GNBqzDd9puMDDt7weekkRcyryz
	F9L+pjGxO40xrUc5+/at+63l3vxOLqoKfG6HOXwFSg9J3bTUMgwFzkaFqX7SlNEMRgZAyriPjOI
	Nphd3lIdKavJw/BShR0CNiD/S9+rVPPR2I8s2Nt
X-Google-Smtp-Source: AGHT+IFb2hnIa33/rJNkCrkGQy65hGr9PbmGe9myzP3aURdvVIcxUKeZQP66X+68mdhz4LTVXyo8AURYpcXobTiuOWo=
X-Received: by 2002:a05:622a:1188:b0:4d8:afdb:1277 with SMTP id
 d75a77b69052e-4da4b428a11mr10874201cf.38.1758738192675; Wed, 24 Sep 2025
 11:23:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250923002353.2961514-1-joannelkoong@gmail.com>
 <20250923002353.2961514-11-joannelkoong@gmail.com> <20250924002832.GN1587915@frogsfrogsfrogs>
In-Reply-To: <20250924002832.GN1587915@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 24 Sep 2025 11:23:02 -0700
X-Gm-Features: AS18NWCrgkvYY30dc-QDZpxRITAd1Rc6cqAqGzLtb2nb9C8hv8zV40q9qN2yU1Y
Message-ID: <CAJnrk1aLtP6fVCqfNTM+boFFnHQ4amB=614efyGS2vW2iauZ7Q@mail.gmail.com>
Subject: Re: [PATCH v4 10/15] iomap: add bias for async read requests
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: brauner@kernel.org, miklos@szeredi.hu, hch@infradead.org, 
	linux-block@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-doc@vger.kernel.org, hsiangkao@linux.alibaba.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 5:28=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Mon, Sep 22, 2025 at 05:23:48PM -0700, Joanne Koong wrote:
> > Non-block-based filesystems will be using iomap read/readahead. If they
> > handle reading in ranges asynchronously and fulfill those read requests
> > on an ongoing basis (instead of all together at the end), then there is
> > the possibility that the read on the folio may be prematurely ended if
> > earlier async requests complete before the later ones have been issued.
> >
> > For example if there is a large folio and a readahead request for 16
> > pages in that folio, if doing readahead on those 16 pages is split into
> > 4 async requests and the first request is sent off and then completed
> > before we have sent off the second request, then when the first request
> > calls iomap_finish_folio_read(), ifs->read_bytes_pending would be 0,
> > which would end the read and unlock the folio prematurely.
> >
> > To mitigate this, a "bias" is added to ifs->read_bytes_pending before
> > the first range is forwarded to the caller and removed after the last
> > range has been forwarded.
> >
> > iomap writeback does this with their async requests as well to prevent
> > prematurely ending writeback.
>
> I'm still waiting for responses to the old draft of this patch in the v3
> thread.

Ahh, thanks for clarifying that. I'll go back to that thread and get
some more alignment.

Thanks,
Joanne
>
> --D
