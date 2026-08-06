Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD20349480D
	for <gfs2@lists.linux.dev>; Thu,  6 Aug 2026 19:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786045592; cv=pass; b=BprPnURPV8WfwOSyvDwxmtDIJZAxtQdrxaXPeHxiuNlBM5lFuOLBFVErobxP9TAwOUW1By9e5DOCttqe7XIg2nFsb/kGn76qiM7P2YJV9OaWzgip3nDsCHHDur4Offn752km2bPKhZef2EDBn4FLtyo2FLOgWSNV4hXM6Py/Y2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786045592; c=relaxed/simple;
	bh=/grpQlkFIsjOtZJ9kjTYgO1M00ZnDq0iZMthC0cITsY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZS2YOHB1WdZ9rxXA58a/Z1rzulF0D/FQuoZVX522vZA60TIstLGAPL+z5XYObSnRAP8l7yWYONX/U066LXuydod53n9RElwxHjRsmqft0Vnu5W/CiYiPlbpJW9na03zjUHCkBQLaW6ONHj9leK8Fv8Erb7CBZOSMG0SA7VVmoNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uom3yPLo; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uom3yPLo"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6a063d211ebso3425164a12.3
        for <gfs2@lists.linux.dev>; Thu, 06 Aug 2026 12:46:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786045589; cv=none;
        d=google.com; s=arc-20260327;
        b=UG/hrs/uSjYiMWGQ5auOh/n1deE48BkfCRbPQtRxkXlm25E5nPHNsZPEM5xGVZjp8L
         o/PJgTfZezjk++BBYfmakOzSymKjZj5vxvpAj+mbP2+GXRyC2edC12Hc3vwVXY0rgxk0
         ASqjTrbVtALKKsNbXHKC6+bSFFt5GuuLhN4KvKVt0z0ngI9RKNqyh76Z1hxxY1lcw7Am
         rLqNzNyHm8um4eP9trbTg7U1wMwQEd9ciG66Akrcxh7qL3XLHElawX4D6s5rxrSqC3r7
         2a4i+MdNDVVCgnkvMtxhZPAu3WdYRxpvxsBXegVnjn4wHdFsySD9TMiK8wQ347VGm6ri
         WH5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nLbIcjJWlLYm7ckgJdCevI6JSBS4OVTbw09CC4o45Ao=;
        fh=7eP95rTwIgWp36awHkKSf9fx1g7nu+USNeamtj/gRGA=;
        b=cJgnrR57jGy9PhT6gw6lKju6gw715+gkCuRrXDqED0n3Ih5Tjf8sBsYtyr6Wh+pgh4
         fndg0K6+ElYUltCtmkMi5vitX5WwJmlryACtFz+p42WFulRKNBQqVezyUBj45MZvAM8W
         lRNiv0hSCJ2GJgWNWNQEjT24kHtkBGtQedwKydun/KmUpgEjJNuK0ePIIZYKWReaEkM8
         /R4VqdI5mx4aZ8rptEP/x+QUDUIyscjK0FCAMVxPbxdw7iqsFlsmLx5olcslzgl1lpwl
         mGflspjgC2ZdHPuj74HZfcppKxsVPAxG1livNHjwTs+XTYCdE0fnOod6oMa/RqloDnj+
         M2Zw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786045589; x=1786650389; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nLbIcjJWlLYm7ckgJdCevI6JSBS4OVTbw09CC4o45Ao=;
        b=Uom3yPLomjQUm3dlw+y8epgpPjcds4dFu6+z19dRsW+L+EKZRfCPqqAk2QzbyT9x97
         7+9a0Q+Iqn59DngeEHkgIz67rLrbt5MuSS6YylHK8qQEaYSb/0b2kz7qmsQkv5H68+lk
         XlzVY3DoEBE0rfgihKotaxQhYer/bs+i/SIwjGCaMd1pN+CK8qDy7AU025rBF/lgS4P5
         DdVGNc/A2zgyAgC71TzWbtXEb5ucW6NqwPts+beBB5rVy2g0cFnQZaAmIf94jABtmBgs
         UAAlGDeC9tsWwbP+KTn0a8dElsmm8sbRDboEwxmcWh8YOVgJS0Q3AhQ4Etnom5IdrYpr
         LCng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786045589; x=1786650389;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nLbIcjJWlLYm7ckgJdCevI6JSBS4OVTbw09CC4o45Ao=;
        b=MbHN8f5emM7dNPGxRr76wRsqskoWBYSuZTHOooizPkPOFOXANk4iQf4FOLUGm9fvRd
         EXWVYtPqiCja5vuQSuQiW7cwqdXI+LNM0nYt2fJjBFt/j8T/0diFoi2kZefazlJ8rQ20
         sYjvltLNrbR4hbulvGm4CGgkmoNUDrqXi2li4zAa+KVuqhXBMc1mpgxvLDy+YuAr2c6b
         GY8Hu8U4ZJDdd/phgp9Sylb/S9b7aeMstlLw22+eOr81fqKDeCDKRCdh5MidFZzzoVk7
         UZ8LcXoopu20Y8LrpqUAin32nKJB/nSxOrxDwR7+lKhdTR/TZb4jKWo+xd3A816uFDg2
         yXLg==
X-Forwarded-Encrypted: i=1; AHgh+Ro24ifaXmpYbA4HYuai3Jz/c/w24AEyfvLZj+sgLRqCHzdRbZJfkH0PwPSRudKnoeX0KRJf@lists.linux.dev
X-Gm-Message-State: AOJu0YxGz6cMmn6zckHc7HkxgK81t89CXX7RlElX/tlonyYF2zLfuNai
	9BZuCrOhpSrP5iOBvPApidvY/mlgS11axgL3fJfej6gHpHT9EsCWTLYddzPVjKsTgJrT9V4C50N
	kXT/Gu96Ot6CKW+SDRaZvb1GX2ZyQ7qE=
X-Gm-Gg: AR+sD10CXS8hHxhF8s37Tr1Q5yTUiTTagwh8Q3xUU7zSAeihT4NvuGut5NGSRkhqpWp
	hK7KlTNk6l5K/oD5EAER0077jS7D9DHWXmc97bsm0x+18ZQQb2zX0QcfReNA3LFNNaa337+JrEv
	y33seM+wRjlbNIKeR/TIQEvfYu8n6QKdkVTpYcAzfLgwE1/OwtoNHIk29A+e1rfUQ9OPKxHdUkV
	LM7sUdMhQEb14YL43oMhb4YL8yWO5tFxbaDU6/5LG/dVLyvsLj5ikNBmxDX/QrqB5c3yAgqWmM3
	RqQNjcMaXT5O4ojGlAPmH9ZMrg9f+szTYvJteXSMYRmy
X-Received: by 2002:a05:6402:a5ca:20b0:6a1:8ec3:764b with SMTP id
 4fb4d7f45d1cf-6a18ec37760mr3594879a12.17.1786045589025; Thu, 06 Aug 2026
 12:46:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1785621505.git.coshi036@gmail.com> <2824f30bbc43e6a0b318564fa641228e9a096e37.1785621505.git.coshi036@gmail.com>
 <anDZ5YG-Ljflv7Vm@casper.infradead.org> <anFYf1iKrNLAjJMw@casper.infradead.org>
 <CACd_6n2GY2RRQPeKtJEuVkHcSBN-Ne2gJdHRfwxg2i=OT06MFg@mail.gmail.com> <anOf4vNU_XPvyhb0@casper.infradead.org>
In-Reply-To: <anOf4vNU_XPvyhb0@casper.infradead.org>
From: Chris S <coshi036@gmail.com>
Date: Thu, 6 Aug 2026 15:46:17 -0400
X-Gm-Features: AUfX_my3MOnB94S3irinQYPvJ_IWdDZWDeP-gGrdJ_Rtf7S3jrdVnkhoJS9GiKE
Message-ID: <CACd_6n2pHtu3aKWc0TbQ04BEwa7Loqcug_=5i5KGo9w_-tZBGw@mail.gmail.com>
Subject: Re: [PATCH 03/19] jbd2: point the shadow buffer at the frozen data directly
To: Matthew Wilcox <willy@infradead.org>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	"Theodore Ts'o" <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, 
	Baokun Li <libaokun@linux.alibaba.com>, Ojaswin Mujoo <ojaswin@linux.ibm.com>, 
	Ritesh Harjani <ritesh.list@gmail.com>, Zhang Yi <yi.zhang@huawei.com>, 
	Bob Copeland <me@bobcopeland.com>, Namjae Jeon <linkinjeon@kernel.org>, 
	Sungjong Seo <sj1557.seo@samsung.com>, Yuezhang Mo <yuezhang.mo@sony.com>, 
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, Mark Fasheh <mark@fasheh.com>, 
	Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, 
	Andreas Gruenbacher <agruenba@redhat.com>, linux-ext4@vger.kernel.org, 
	ocfs2-devel@lists.linux.dev, gfs2@lists.linux.dev, 
	linux-karma-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

folio_vmap() sounds like the right shape, and nothing in this series is
waiting on it, so there is no hurry from my side.

One thing worth settling before anyone writes it, because it decides what
the callers have to look like: kmap_local_folio() documents "Context: Can
be invoked from any context" and has no failure return, while vmap() does
might_sleep() and returns NULL on failure.  So folio_vmap() would inherit
the weaker contract from the one case that needs it, and every caller would
have to be written for may-sleep and may-fail even though on !HIGHMEM
neither can ever happen.  That costs the jbd2 commit path nothing - both
checksum callers run under jbd2_journal_commit_transaction() in kjournald2,
which sleeps freely - but it is not free everywhere, so this may want to be
two entry points rather than one.

Glad to talk it through, and happy to write it if that would help.  I
already owe you a look at the bs>PAGE_SIZE callers once this series
settles, and this is the same errand, so it would be no extra work for me
to start there.  Entirely your call.

Best,
Chao

On Wed, Aug 5, 2026 at 4:41=E2=80=AFPM Matthew Wilcox <willy@infradead.org>=
 wrote:
>
> On Wed, Aug 05, 2026 at 03:02:05PM -0400, Chris S wrote:
> > Thank you so much.
> > Taken, with a change: the helper needs a matching unmap, and must not m=
ap
> > the folio-less case at all.
> >
> > static inline void *kmap_local_bh(const struct buffer_head *bh)
> > {
> > if (!bh->b_folio)
> > return bh->b_data;
> > return kmap_local_folio(bh->b_folio, bh_offset(bh));
> > }
> >
> > static inline void kunmap_local_bh(const struct buffer_head *bh, void *=
addr)
> > {
> > if (bh->b_folio)
> > kunmap_local(addr);
> > }
>
> Ah, I hadn't considered that option.  Yes, I think this is the right
> approach.  Thanks!
>
> > Two reasons.  kmap_local_page(virt_to_page(bh->b_data)) loses the offse=
t
> > within the page, and b_frozen_data is kmalloc(b_size), which is only
> > guaranteed page aligned when the block size is at least PAGE_SIZE.
>
> Yeah; my bad.  I should have added in PAGE_MASK(bh->b_data) to that,
> but what you have is better.
>
> > The second one is your other point.  With CONFIG_DEBUG_KMAP_LOCAL_FORCE=
_MAP,
> > __kmap_local_page_prot() maps even a lowmem page, one page at a time.  =
So
> > mapping memory that is already permanently mapped would walk this path
> > straight into the bs>PS problem you just described, which it is otherwi=
se
> > immune to - b_data covers the whole block whatever its size.  Returning
> > b_data and calling kunmap_local() on it anyway is not an option either:
> > kunmap_local_indexed() WARNs on an address outside the fixmap range und=
er
> > that config.  Hence the pair.
> >
> > On the bs>PS folio path itself: agreed it is real and predates this ser=
ies.
> > I would rather not fold a fix into this one, but I will take it - I'll =
look
> > at it separately once this has settled.
>
> I've been considering adding a folio_vmap() which would be a nop for
> !highmem, kmap_local() for order-0 highmem folios and vmap() for
> large highmem folios.  It's not reached the top of my todo list yet.
