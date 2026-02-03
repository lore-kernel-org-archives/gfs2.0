Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402EB31A571
	for <gfs2@lists.linux.dev>; Tue,  3 Feb 2026 11:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770117433; cv=none; b=T/cuIZBpqSDGXtqPGsRjM5lbWADEH3pOwAsHRVT1OrnOrSwW4igb5WRd2wMtivaIVqT63AgTd5Cx4k8sy6rQj4dxVG9Ht4yInARIQe9uLxdK/WiUwRVK2gXgx1mXBPdwB2PwLW2CEaRjSraRUPX13EhH34B0CKnU/NVCMnSBaMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770117433; c=relaxed/simple;
	bh=Iqbb0NRtHrMLVZMstvNL/lygo3fhKe618V4dj4LwTyA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JLHTetVoE38Oxpgf24K6/ZCeMMgfeSysZ1otV/+t60jmm5zfIMbpe+VIdTbJynNbM/05Q4STJFVCxqg/pTRzqiC4br8p/7J2QIdsmzzxfEnhgyGTCiXmFXuDwclLYp9koTXNOybtG3Q8fwHTZEG+Yqx814vw53z7Z/qpX3xp438=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XLWB8mhJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XLWB8mhJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770117431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZB7pys7aVTpydspegTtd64qmcsFblDzpu2L3xqTfUK8=;
	b=XLWB8mhJ7TCtQF4+cY5UgStkA36CohIcSiYIHtxNN4r2ySei/JqM+z2Tlxim3cjydCO912
	TrpMrBKuDDEiMkBUCKN4/HwcpIHhZ8gxJ7UFTaWDTOhXgX3CGlHJtcS39PGcrykva3/z2G
	uijKe55cbUSTVNUmsz+z7hSWqtHhjtU=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-ACWvsvxdNHW1LtlZhx0LRg-1; Tue, 03 Feb 2026 06:17:09 -0500
X-MC-Unique: ACWvsvxdNHW1LtlZhx0LRg-1
X-Mimecast-MFC-AGG-ID: ACWvsvxdNHW1LtlZhx0LRg_1770117429
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-649b28b7a67so5880034d50.2
        for <gfs2@lists.linux.dev>; Tue, 03 Feb 2026 03:17:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770117429; x=1770722229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZB7pys7aVTpydspegTtd64qmcsFblDzpu2L3xqTfUK8=;
        b=pkx+EEKqM3PJlvNG9+cIN7RqhIJzWtihUs5cRXzbQ2GPD6ZhQiR0ItzoWUU2pg+dcU
         sbANaandPX2jtTsAXojx7aFqa/JW818y2SseEQqbO1SVAcuK8vX3kU/63LVNis163Buq
         cfRqYzk2RDaesxA4CKnpw0lz5thrCaa2HbzYLQpnMISm+merwa/CwG6O2GXsJCzJ9RI4
         IsfxUBM+d8QUR5FQCMxOlk1t50OeVtlfZ8IFn6eup7Ylo7hErcN/EFGw9GdKxpr5tYLW
         L4ld9D8JZzBSr4OdkZ53e+pASAMZ5dlIslRTz765zMHFP7nKh/ycs802fSCTBtDl40Dw
         wGKA==
X-Gm-Message-State: AOJu0YwvsBvc+6RDhwTm+oDVUKdHFaToE3T+Kn/Ht9UzhEJbwuwJLlG9
	V+YqqQ7QRpNgeBKQLbpFUuHdTZLjwVT5Wlmo9UJVAzWC+QoW554biZt8M5RoW25wyJIZo6RFpmz
	OA+aCGomhZijWe8VwZSdHjqvwXPjzIyubLnZl0Ef1z2GWJjFzsbocCtzUzIWTw7Qlg1T9VY1YmS
	NF9YxsBjqLZMMCwLE2FWnnC8mLg0u6yG2YEj95iG4A
X-Gm-Gg: AZuq6aLbjpl0PLcTsfBhCv4leeO5twRSP/rfZgYvFU3xX0tGFClrqK4W2ofJwBzk/ML
	KlLFqNUEVPgML+muHximEXoYlrBWlWi+oJxm3kJrgoLW1tYzT5nJZtWBgWPWbCr9gyVnrmjzWS5
	TBYp+vdbtz7Y9fQSmRSKlN5Cm7x9egdDnOP14tYswiYREFDaYeF2UIjUIchHh4BBHDxlXIjvduB
	AicWnLViafH0KA0/aZSUVuJAZcAC7UupeRhyFYbhVfsxzr5ZGUXhg==
X-Received: by 2002:a05:690e:1248:b0:645:443d:10a2 with SMTP id 956f58d0204a3-649a83c066dmr11736476d50.26.1770117429317;
        Tue, 03 Feb 2026 03:17:09 -0800 (PST)
X-Received: by 2002:a05:690e:1248:b0:645:443d:10a2 with SMTP id
 956f58d0204a3-649a83c066dmr11736458d50.26.1770117428962; Tue, 03 Feb 2026
 03:17:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260203103941.12918-1-trintaeoitogc@gmail.com>
In-Reply-To: <20260203103941.12918-1-trintaeoitogc@gmail.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Tue, 3 Feb 2026 12:16:57 +0100
X-Gm-Features: AZwV_Qis4Buq6oKsnT9sgN2fZYtor8IOs8Q3eHTbUB5-9Q5L2rlGh6cYxtpXYdg
Message-ID: <CAHc6FU7kH3VfyERRTFuCshiSq0c-ttJLG7OeX_j31K9ehvH7uQ@mail.gmail.com>
Subject: Re: [RESEND PATCH] gfs2: do not evict glocks with populated address spaces
To: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
Cc: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: aSYyImT61mMd9VpjnvUJIOd_gJTgWyNWy7ZHJwukKAw_1770117429
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Guilherme,

On Tue, Feb 3, 2026 at 11:40=E2=80=AFAM Guilherme Giacomo Simoes
<trintaeoitogc@gmail.com> wrote:
> Metadata glocks may have associated address spaces used as caches. Avoid
> reclaiming such glocks under memory pressure while their mappings are
> still populated or their state is not unlocked, as this can lead to
> invalid page cache state and GLOCK_BUG_ON().

What invalid page cache state and GLOCK_BUG_ON() errors is this about, exac=
tly?

> Signed-off-by: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
> ---
>  fs/gfs2/glock.h | 30 ++++++++++++++++++++++++++++++
>  fs/gfs2/super.c |  3 +++
>  2 files changed, 33 insertions(+)
>
> diff --git a/fs/gfs2/glock.h b/fs/gfs2/glock.h
> index 55d5985f32a0..12f57461f687 100644
> --- a/fs/gfs2/glock.h
> +++ b/fs/gfs2/glock.h
> @@ -305,4 +305,34 @@ static inline bool glock_needs_demote(struct gfs2_gl=
ock *gl)
>                 test_bit(GLF_PENDING_DEMOTE, &gl->gl_flags));
>  }
>
> +/*
> + * gfs2_glock_not_evictable - check if a glock is not evictable
> + * @gl:        The glock to check
> + *
> + * Glocks which do not represent normal filesystem inodes (e.g. statfs, =
quota, rindex)
> + * may have associated address spaces used as metadata caches. These glo=
cks must not
> + * be reclaimed under memory pressure while their mappings are still pop=
ulated or their
> + * state is not unlocked.
> + */
> +
> +static inline bool gfs2_glock_not_evictable(struct gfs2_glock *gl)
> +{
> +       if (gl->gl_name.ln_type =3D=3D LM_TYPE_INODE)
> +               return false;
> +
> +       if (gl->gl_ops->go_flags & GLOF_ASPACE) {
> +               struct gfs2_glock_aspace *gla;
> +
> +               gla =3D container_of(gl, struct gfs2_glock_aspace, glock)=
;
> +
> +               if (!mapping_empty(&gla->mapping))
> +                       return true;
> +       }
> +
> +       if (gl->gl_state !=3D LM_ST_UNLOCKED)
> +               return true;
> +
> +       return false;
> +}
> +
>  #endif /* __GLOCK_DOT_H__ */
> diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
> index f6cd907b3ec6..86544cdafe53 100644
> --- a/fs/gfs2/super.c
> +++ b/fs/gfs2/super.c
> @@ -1164,6 +1164,9 @@ static int gfs2_show_options(struct seq_file *s, st=
ruct dentry *root)
>
>  static void gfs2_glock_put_eventually(struct gfs2_glock *gl)
>  {
> +       if (gfs2_glock_not_evictable(gl))
> +               return;
> +

This leaks a glock reference, so it's definitely wrong.

>         if (current->flags & PF_MEMALLOC)
>                 gfs2_glock_put_async(gl);
>         else
> --
> 2.34.1
>

Thanks,
Andreas

