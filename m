Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6B438CFF8
	for <gfs2@lists.linux.dev>; Wed,  2 Sep 2026 22:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788386608; cv=none; b=jriZZ3SXqZI6krjwQ6Wd3Hle7eWIL03oaTs1BuTOhM5sTOLUXM+H9LeNhDeZpptO+vwyfzXrTLKP9P5VO7j9Z2Kkp1PsfJJzHaUCgbGiUJ6wfP9j/8AiBx2QEGrDkZF8/KAYGGWRnJTAsvCACdVqYEKdUhgcg15FZgjNCXOJkuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788386608; c=relaxed/simple;
	bh=Ji96awhBSDtE9T9eDzIF/2tyM2hKMLoai8rzH+V1s0g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rhDXgADS5ftU8tCKvB4U9auoAyRK5dtGkuv8vybNS521Vgdpba+iFH7j/AdlpUXBOwdTK77bFKHq2dfuDouqzPYjKmedHcCUQxz738x21WqbuMnubI4nrDKd0fozfvaLeQLiZ7g/Z7OBwU04c/4HAL93K7uCDHFHQc4JmW8vP0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hvvS1MGV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hvvS1MGV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788386602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FSyGVw4A9GnmeP8/IbMD6oCendLxzXyxCDzDxdtJ6gA=;
	b=hvvS1MGVtrEpHUCQx5f5ymcOghFlHuAsCxT5HpK+blb4BCv4C/De77dIE+ubHwm2JQfBhb
	ILkgQ/AkIHzAuQPtmaibHpi9GvbkggBDr14nk1s9EObMOl/PjuQ6juxGTaLhKpqtOdN96H
	X3yDWHwPCcQDXUIrIcC5uRgTV4zsBg0=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-Y9YlZD3LMzKkWDt3IcGkRQ-1; Wed, 02 Sep 2026 18:03:21 -0400
X-MC-Unique: Y9YlZD3LMzKkWDt3IcGkRQ-1
X-Mimecast-MFC-AGG-ID: Y9YlZD3LMzKkWDt3IcGkRQ_1788386600
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-66cad42590cso1708468d50.1
        for <gfs2@lists.linux.dev>; Wed, 02 Sep 2026 15:03:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788386600; x=1788991400;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FSyGVw4A9GnmeP8/IbMD6oCendLxzXyxCDzDxdtJ6gA=;
        b=AVqHCH4a0/LpPXik1fqIiHdsZkkuFrO4ypNlr4703CIGlLKPUknr9X+3HvF/XA+q33
         HfvIdXHXweVPNHtAvQmn1A6LMwRxNa+vL7GVuCzsjJMd7iJ9bDhPSc6I9ulIHQbJEW8Q
         qhxMZV6IYzLQd7kJFcIFxkwn8pwBPRdOHTdePQTt8K4qShmWbgtYNe+bjwph08njgevw
         B5raKFKWLSDtTnI9dHDDLZoA9lAr3XXBXWQZrN9KXswn12g3V9Gd2gAMJOTJiqMIC4E8
         RcRwu34tGFGLUTaRi4OrEd+rAeyemKzsCWJD6iWHtGz9VA3RQF86mw6uLevddhrrTCz5
         O2uQ==
X-Gm-Message-State: AFuF++klDDl2Lph3Quu4gUA4o0frAp8pIdxwaklgdJY9Zghz7d1sDQzL
	OUxhJRjcjp+X+r4O7IwN8WPV60RB18yGwpaZi41qn0WE7eZz+V/XSQwfwBdgUQiwHUWa4DNhX82
	Q7RcusJwE56bUS7n7lVIUfuSl9w5xcjL+45LuJ0VRcZU0R6yal/HR8hJAiRQ2Y1dPBHtClwTpHX
	Fr5vwG6hbmBoVOXORxo85OIijlqsyo2vjksAd9ZjaN
X-Gm-Gg: AYBFou3tlUZCwsuBQOQwI9Q6YEbL9JUexbauVJ/ett1vS3RCeOTDKbzpQHmyVEN+GAx
	55ipYghCfczkIlofChMPoYqdjbhlkV0wQU37wKRiI88XnK/BH3aIX89Oc0hsSUlJUVq2p2BmHFq
	OmfrdpiC3OoTRBmeZFDxaxMAqwI94JTJHYJLZJsanpSr5D9XT6543+q/yEJcE2aIyt27oOWjZ0t
	EUS4sgRkPUIfP4QRrdBl0If3L3ti2FMimGpfqBeP5Ls
X-Received: by 2002:a05:690e:4850:b0:668:568e:8618 with SMTP id 956f58d0204a3-66f9b8f04camr1991134d50.1.1788386600556;
        Wed, 02 Sep 2026 15:03:20 -0700 (PDT)
X-Received: by 2002:a05:690e:4850:b0:668:568e:8618 with SMTP id
 956f58d0204a3-66f9b8f04camr1991110d50.1.1788386600049; Wed, 02 Sep 2026
 15:03:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <dd2fb3c26e999922ebb6413cfdde212903e204b7.1787225676.git.vega@nebusec.ai>
In-Reply-To: <dd2fb3c26e999922ebb6413cfdde212903e204b7.1787225676.git.vega@nebusec.ai>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Thu, 3 Sep 2026 00:03:08 +0200
X-Gm-Features: AcwNN1UenxlnRcHge64OoTYHPjVXDRRTQG3-A2SArjLH77ySOG-L6mixMR47X1U
Message-ID: <CAHc6FU61Jz5w3ExSVq_cEyOEKYsu5t27ef_pbXdgejfJK1AN2Q@mail.gmail.com>
Subject: Re: [PATCH] gfs2: Fix journaled truncate range end offset
To: Jan Kara <jack@suse.cz>
Cc: gfs2@lists.linux.dev, stable@vger.kernel.org, VEGA <vega@nebusec.ai>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JwIhxXaJcIq0MgEoFBZUiJUvN3GggZF28ZSFdBDZOxY_1788386600
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Jan,

On Wed, Sep 2, 2026 at 4:37=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> The third argument to truncate_pagecache_range() is the inclusive end
> offset, but gfs2_journaled_truncate_range() passes the length of each
> chunk. A hole punch at an offset larger than its length therefore
> creates an inverted range.
>
> The MM truncation path then underflows the unsigned partial-folio
> length and passes an oversized range to folio_zero_range(), triggering
> a BUG. Pass the last byte of the chunk so page-cache invalidation
> covers the intended range.
>
> Fixes: 4e56a6411fbc ("gfs2: Implement fallocate(FALLOC_FL_PUNCH_HOLE)")
> Cc: stable@vger.kernel.org

this is not stable material; see below.

> Reported-by: VEGA <vega@nebusec.ai>
> Assisted-by: LLM
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/gfs2/bmap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> This was actually analyzed and fixed by Nebusec AI bot and it looks like =
an
> obviously good fix to me.
>
> diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
> index 51ac1fd44f78..375595235aac 100644
> --- a/fs/gfs2/bmap.c
> +++ b/fs/gfs2/bmap.c
> @@ -2414,7 +2414,7 @@ static int gfs2_journaled_truncate_range(struct ino=
de *inode, loff_t offset,
>                 if (offs && chunk > PAGE_SIZE)
>                         chunk =3D offs + ((chunk - offs) & PAGE_MASK);
>
> -               truncate_pagecache_range(inode, offset, chunk);
> +               truncate_pagecache_range(inode, offset, offset + chunk - =
1);
>                 offset +=3D chunk;
>                 length -=3D chunk;
>
>
> base-commit: 24ef02f934eeb48830cff6b739abc3c62b1d107b
> --
> 2.47.3

I mostly agree with the finding and I will merge the fix. Since the
following commit, fallocate is disabled for journaled data files
though, so the described bug cannot trigger:

86066914edff ("gfs2: Don't support fallocate on jdata files")

When that commit is reverted, the following commands lead to a failed
"blks <=3D sdp->sd_jdesc->jd_blocks" assertion in gfs2_log_reserve.

  touch j
  chattr +j j
  fallocate -l 1G j

That can apparently be fixed easily by limiting the chunk size in
__gfs2_fallocate(), but I haven't run any additional tests.

Thanks,
Andreas

