Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540613E2742
	for <gfs2@lists.linux.dev>; Wed,  5 Aug 2026 19:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785956551; cv=pass; b=ryPlqKa4zuGaKDyx4n5O6AIIvApt52EJr0s72ADJqmdRRRBAJn1octIUkBdWaU+ulbGJuvlW4FjNxrFneHCGpBHw1GWEq2qzSn323O09hxFvbYcrdIKV2IhDbSDVznz/e6PW1TWutibLrfJFtdnJtAtiXmzfR51L6IhMVhhAErw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785956551; c=relaxed/simple;
	bh=ALS4z1Gntn76BUGW7fczi1PamcwbMhAJ+HBZQNl5qW0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JDGE19Dqthsd1beqtYEo2nB3ede2nZ5KOZbABJBXOR1HJhyQHFVx/jXO1JLSwHDfpkmlYnReSkEFAOW3vMfTi/EjTzFnK7fO2VdcTXM0w/VcaEdTx7BqQO+7nLwj0kaVs4+9+atSwTJN/APBTY4GleK4r0/oxfWNdalCTQx8YhQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UwBH84UI; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UwBH84UI"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6a17c04563fso1216037a12.3
        for <gfs2@lists.linux.dev>; Wed, 05 Aug 2026 12:02:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785956537; cv=none;
        d=google.com; s=arc-20260327;
        b=DMLWWtphcVHQu5VPTyWR/I00IgKwR1+5djXaAML5PcQ1Z/VzNWM9Z6nhKRp/S1w9Lj
         GSEWaKq6S4oCCM63MxV96SX8ave/27Gurv5xAmvn/k0fh60h+qISuHb7rZ1Lz0u0HMHW
         6k/acBsgasoALZDdLWExMAZ1iPpVK0Rv7RItlhGitro/bL/EBopV94iP94NkWUpskkgq
         YT7u2J7QRSqRgcNb/2j6DZB/5T/rqDkETNVXCHK5MFuOHLdGMmsXXdq5JNOu10TqFxIu
         V6gePi4CN0JL9QVfzSkcbAw6ndalxUvq1Wqhvan/jJbu4yjeh7BteJBQqPgX3cKYtpiC
         f36A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bXL8fOwPfzW8cmIw726T8X174t2PQj7sWrk7UD/8Cqs=;
        fh=TkweFhh3cQYatygWSC7bYQfmSch/kaUCUu2VeaNV0vc=;
        b=SBiviJSY+Z3ZKULcANNvUHaQxo0VLq29067rFc4fRPQFSvML4jaGu//L4CyyPe1b8n
         TZ0oz1jhSCBkwzzimcOazjsaBb8aJ/BCRiLrLgI62Tmk0d0CVL6CS7YgwkcMj6ShJISp
         cmGq8ZGhLuLS2YlOXk4jWkjNq3fL/ygNR3jqiMJZxIDE1dNDLHHbrPkFpxcDLEJU1zMB
         zRFq/Bc+XHp/QtmSlwI+SVuHa9ZCu19esL3arODdD5T1Cp0lUK5Y8pf2wY93l/qBB2Os
         EZE6hP7PQFjQ4oXdwylp9Fxp3Nla27x6vua8YjXXKa5STqPZGp0r06b4vAzPY3TTw/ye
         knkA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785956537; x=1786561337; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bXL8fOwPfzW8cmIw726T8X174t2PQj7sWrk7UD/8Cqs=;
        b=UwBH84UIh9cENcgk5qBeqoo5wOMVoVZUSMMOkkTHyPPeNX+7G80ZpYoI8397iDEY8C
         BFpZ8tcSrpDNPQlQjvNmfyHWa5R9MzJh6btRSQNB68hrRdiYiyP+mYvPkifvkugls/wk
         sIT+ab4mxw3rHXPc66KJd+iKi0kmQTouW+FBayubpJU68nYHFfh0rZmlvR2CchyJoqCb
         43omGUlA9hf+rSxpuKK7VpOwkKz4v2IAWDlKBvMbKtvFcF7ghABPN2pd4SEQfBUczAd4
         ySgjBQdI8DWxAYLWobUpVJopdFbCJkS1uNedddaNeNe/dmZ03zaHTu6MQSK9n5IHa9iV
         wjmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785956537; x=1786561337;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bXL8fOwPfzW8cmIw726T8X174t2PQj7sWrk7UD/8Cqs=;
        b=lw+elYKJv1ik5cbjsvDbWjFBufTNLfVvnIad9p+knuqZsaPu8StEQwNejGs4fOjbB6
         YxCXqNK6gPW3tVqPi+hb8wLRLPbJo7dOkrfdobfrv0rg8AuCKSQ314JrxL5hJH+/7SFy
         4zTiks0XqQAtRlqUZhwzFV98Qgztq132T3g2/Sz9gL/sedUTtSETtvZ47DlEFkT/t7KX
         /vxwz5Ah8hEHBqR5H/JOjH2UWc7KR+Bso/6Y/Em4UR47GYsgukDGW0qDHYrFcrV6kTkk
         EeyrBe2BKiOGoqFh75hRTkPf8Ngz8yb1NqYnM6tW+Sr1lypzCFTucq24+2Bepl15IcEn
         4Qxw==
X-Forwarded-Encrypted: i=1; AHgh+RoCuGqe3DtervpAHI8E8zA2jKBwyTcUNWtJmgxpF4kLF3JARosRimypzTnxVICjnhzbUcRX@lists.linux.dev
X-Gm-Message-State: AOJu0Yykzfrn02G66QPa33keQ7LEEoAq91BDv4TmEq4NuFPwG7PXwdvj
	wEu1KtRMCBGOjRExBQQM05AKkrdMOGTRiDkDUnO/P/TzXv5zTtJuJZcn3hrLybuHV2a9mtY72KD
	CsN4LC4r8zFmMFKOJmREBCMWLvuKnuKA=
X-Gm-Gg: AR+sD13omkkmPWb5ifwqvR0363uPZaZFdi0zgtBOY9jMhM4fxPlswEHJ8cKFgwU7VaI
	MPcQZ1cwcjIAMhvZnmTQARqzY5DURw2ETJyIqVLcc65Hj7uET/ToofTMX5VkXQOfEY1savRFePS
	7quaPziQ9EwiI9qlVCEpAiKiCLcDyC6ZHjJs7yC3VtYPJZsw2SQMvnXg2TX1oa1bUOg+HtMAFTg
	WVzINXGTFD0SqGs5QHApworVA4xzhBgMdgYKIoLTdjO9i70MrS2F0qJuziTy1+4xpBLlrt0EIea
	MkzwDWbS/0JOda+jsW0YcxbSsyEY+dvTUj3mxRhZcfVG
X-Received: by 2002:a05:6402:e87:b0:6a1:28d8:2306 with SMTP id
 4fb4d7f45d1cf-6a14f07bc72mr5050205a12.1.1785956536576; Wed, 05 Aug 2026
 12:02:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1785621505.git.coshi036@gmail.com> <2824f30bbc43e6a0b318564fa641228e9a096e37.1785621505.git.coshi036@gmail.com>
 <anDZ5YG-Ljflv7Vm@casper.infradead.org> <anFYf1iKrNLAjJMw@casper.infradead.org>
In-Reply-To: <anFYf1iKrNLAjJMw@casper.infradead.org>
From: Chris S <coshi036@gmail.com>
Date: Wed, 5 Aug 2026 15:02:05 -0400
X-Gm-Features: AUfX_myV5AVdy2Vk3b4_r8TJRgGAg0iuSL9FFYfHvWZSH4sclQZJlO_bQY1K40Y
Message-ID: <CACd_6n2GY2RRQPeKtJEuVkHcSBN-Ne2gJdHRfwxg2i=OT06MFg@mail.gmail.com>
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

Thank you so much.
Taken, with a change: the helper needs a matching unmap, and must not map
the folio-less case at all.

static inline void *kmap_local_bh(const struct buffer_head *bh)
{
if (!bh->b_folio)
return bh->b_data;
return kmap_local_folio(bh->b_folio, bh_offset(bh));
}

static inline void kunmap_local_bh(const struct buffer_head *bh, void *addr=
)
{
if (bh->b_folio)
kunmap_local(addr);
}

Two reasons.  kmap_local_page(virt_to_page(bh->b_data)) loses the offset
within the page, and b_frozen_data is kmalloc(b_size), which is only
guaranteed page aligned when the block size is at least PAGE_SIZE.

The second one is your other point.  With CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP=
,
__kmap_local_page_prot() maps even a lowmem page, one page at a time.  So
mapping memory that is already permanently mapped would walk this path
straight into the bs>PS problem you just described, which it is otherwise
immune to - b_data covers the whole block whatever its size.  Returning
b_data and calling kunmap_local() on it anyway is not an option either:
kunmap_local_indexed() WARNs on an address outside the fixmap range under
that config.  Hence the pair.

On the bs>PS folio path itself: agreed it is real and predates this series.
I would rather not fold a fix into this one, but I will take it - I'll look
at it separately once this has settled.

Chao

On Mon, Aug 3, 2026 at 11:12=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Mon, Aug 03, 2026 at 07:11:49PM +0100, Matthew Wilcox wrote:
> > On Sat, Aug 01, 2026 at 06:00:47PM -0400, Chao Shi wrote:
> > > @@ -330,6 +330,8 @@ static __u32 jbd2_checksum_data(__u32 crc32_sum, =
struct buffer_head *bh)
> > >     char *addr;
> > >     __u32 checksum;
> > >
> > > +   if (!bh->b_folio)
> > > +           return crc32_be(crc32_sum, bh->b_data, bh->b_size);
> > >     addr =3D kmap_local_folio(bh->b_folio, bh_offset(bh));
> > >     checksum =3D crc32_be(crc32_sum, addr, bh->b_size);
> > >     kunmap_local(addr);
> >
> > This is awkward.  How about ...
>
> ... Oh.  It's not just awkward.  The current code is actually wrong.
> If one uses ext4 on a bs>PS device and one has
> CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP enabled, it'll only map one
> page of the buffer and we should get a crash when trying to checksum
> the entire block.
>
> Supporting mapping multiple pages from a folio simultaneously is
> something we haven't figured out how to support.  Since HIGHMEM is
> dying (see Arnd's recent work), I'm not inclined to spend effort
> on it.
>
> We probably just need to make ext4 depend on !DEBUG_KMAP_LOCAL_FORCE_MAP
> or something?
>
> > static inline void *kmap_local_bh(const struct buffer_head *bh)
> > {
> >       if (bh->b_folio)
> >               return kmap_local_folio(bh->b_folio, bh_offset(bh));
> >       return kmap_local_page(virt_to_page(bh->b_data);
> > }
> >
> > (this is also somewhat awkward because it feels like we could just
> > return bh->b_data, but kunmap_local_indexed() does some ... stuff)
> >
> > Anyway, it all gets optimised away on non-HIGHMEM.  Or if it doesn't,
> > you can force it to ;-)
> >
> >
