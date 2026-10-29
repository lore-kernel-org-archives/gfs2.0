Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793281826;
	b=XQG5pt5k6oQFkVeYA9JgFvyQ2l40FF3DMJwRYdfoWaKzAFBHyYaaGNFl/lynCFdR//VH
	 ueAUiR2kbhBdrm0gkeE6NL4c4wBI9hETYeJHwKdpS4m4Co4CBmDHuWGDR5Oy2siCDwqev
	 mFrDYtgBvSq1i8atkvngEjBUP73U+TH7Wz3hzNeyHenEMxYmSadOC8NUUdGz4pVNHKvTb
	 bPcWddSEbPfMKzYpZtztjV6KAMNJLcxZJgpmeZvPdWI/VF6CfVjzvN3+yRNeAjIP/nqHm
	 burWYUTOoKGfa5UcXE3wqBf7KdULJ9IbHH/xqf/kF5nIg8XZMZVDKJ6b3oV3Zx+5eUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793281826;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Type:Content-Transfer-Encoding;
	bh=K4ilaixi7PzQ3jyW2MqZwExvQII83Z2kevqQDSBbKdo=;
	b=v/d/PJvpMxPSulJs0VZbpcw/dd8ycoVXT8O4Sw1fTBBz6kwLjcbI846wSUYTxZ5FPDFf
	 y+dFxhi2xRGKDgOPJGiQXVO4lmIETPSNrCqzMxmDy3MCP2HXUVQ71CmU0+LY47RvFD688
	 321sUXOamR8pcY+SQpUP6JCamhNCaBWv3hkoXEYgplXcau9M4hWTP16e842OygJAU03Gi
	 SMtuE3CzmoParklZyFIFfi8NsXx7ZrP5N3PBT2a5Ro+BL6cRMBcmf+9SjAQ7mZHzZXI1q
	 QVeVsexj6Q2HVoNJES0RxsUEr3p2hO8zgzOksNvN2pckLbxttVqp/apClJIoE3IbfXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Yr96gSSD;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A3F606A31A
	for <gfs2@lists.linux.dev>; Thu, 29 Oct 2026 13:50:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3A3F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Yr96gSSD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793281824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K4ilaixi7PzQ3jyW2MqZwExvQII83Z2kevqQDSBbKdo=;
	b=Yr96gSSDvv1yTHC7plRDLwdZovTqiFpuQoJwl/65U3ipIIQdMRxnpu+Sp+8yGGYHGXILDv
	y9t2OQnR5Tfx+k8saKeh3xwvwZxW42RslyDKFDuL7P2lcVfn6EdKArjBd1w2OFGuE3lP6W
	fFfVlKS4G0iGAZ/22c5OExXjr3TvygM=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-WkoIh_IJN2qgcE_P2Gsf2Q-1; Thu, 29 Oct 2026 09:50:21 -0400
X-MC-Unique: WkoIh_IJN2qgcE_P2Gsf2Q-1
X-Mimecast-MFC-AGG-ID: WkoIh_IJN2qgcE_P2Gsf2Q_1793281820
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-8b18c67095dso31697527b3.2
        for <gfs2@lists.linux.dev>; Thu, 29 Oct 2026 06:50:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793281820; x=1793886620;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K4ilaixi7PzQ3jyW2MqZwExvQII83Z2kevqQDSBbKdo=;
        b=CSUvpM92JU9hbne4XtM1Dw+dMGoHtVNzrL4gcxttCo+mmY+EwaJ4kOYg4Lju/Xg39a
         by6GWpY3S/rBHmQgYgg6k4HXKwunSxZR081vwKpwydy4uq1qN3fwVutNdmi7uVo225W2
         w0BFpr1onUgoQklPf3tVPXQPU3bfr5iNMvSUJiFvCgBgWhLTo6KMeBjzkPtcoy4LI6ma
         CqRT4ON4Ae3v5WRCPe4/iF00dqP7sYp4eoQvIZSHCN2lvP8hK8rabyuO+cZZxgWmTMJ8
         msc68dl7lAtq+CjFwqKFdaCVJB1L5U5r1Yce+9l8i53lOR7oo2YpGKw9HfnoPkct20dH
         r+gQ==
X-Gm-Message-State: AFq9FYJelwRuCDYjqhNmkQi2QVJZtUd0CRFNiRBHHeDfn5a/elv+z+Vz
	SyhK4l7wn7QiFxRYEhkFJXe54jxpGoiViTKZplNtVg6Z60Dah4AZAvH9lL0YWPs/JKrTyzSfa1p
	zAWbXWTV2woqypBxdDINcqimrXPjyEsQ56EYAwe+31cVRixtGt9D7eWrXsOX7SC9Byd7912IIpW
	A1ufr3+Xn3cTuxqtBimLxVj8tE2xryhA==
X-Gm-Gg: AYBFou3wYV6HRg8SZ91WCsx1HvmSafkNxbhJ4q0vqfPu2wItpyLoXni4KQIIgoVJVHw
	O8nCwN8YjWDj9KmO7JNc/o7KoTjKbPjO91yj06Zd/Hbzw0lY0dhw3XCG2O/NB2OtcJ0L5nY0bCa
	c9B5SZReUxR1N+5bREBogJdH01lZPDKkUh493p05hgy+nAvZJV5g1ocrQ1YqKHMwhJmdMGZkRRD
	/uaYTdQ1qo8e4iuP15qE9aHtT3JmhgC5WrkvmHu2IKzig==
X-Received: by 2002:a05:690e:43c6:b0:679:943f:b192 with SMTP id 956f58d0204a3-67a7bd34f4bmr3441792d50.76.1793281819667;
        Thu, 29 Oct 2026 06:50:19 -0700 (PDT)
X-Received: by 2002:a05:690e:43c6:b0:679:943f:b192 with SMTP id
 956f58d0204a3-67a7bd34f4bmr3441771d50.76.1793281818946; Thu, 29 Oct 2026
 06:50:18 -0700 (PDT)
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Post: <mailto:gfs2@lists.linux.dev>
List-Help: <mailto:gfs2+help@lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
List-Owner: <mailto:gfs2+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261023101830.139094-1-hackerowskiy@gmail.com>
In-Reply-To: <20261023101830.139094-1-hackerowskiy@gmail.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Thu, 29 Oct 2026 14:50:07 +0100
X-Gm-Features: AclHuK-JLcGWRfpdOvPnvmGXH13NO45FtGdQUfg0yCXNZWHwDHDohNE_RnQ41sc
Message-ID: <CAHc6FU6Pmu6MfJKNRZ+WhE2y9viU23HsKx9wCbumShCxU45avA@mail.gmail.com>
Subject: Re: [PATCH] gfs2: keep glocks alive while AIL entries exist
To: Eduard Zateev <hackerowskiy@gmail.com>
Cc: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzbot+ab91b239b20ae188b9cb@syzkaller.appspotmail.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jSZC_w0c4h3EycbHDPsktQ0ZLcboB1EU9nkNulhN4rE_1793281820
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Eduard,

On Fri, Oct 23, 2026 at 12:19=E2=80=AFPM Eduard Zateev <hackerowskiy@gmail.=
com> wrote:
> A buffer on a glock AIL list can outlive the glock reference held by its
> inode. During withdrawal, gfs2_ail_drain() later removes the buffer from
> gl_ail_list, which dereferences the freed glock.
>
> Hold one glock reference while its AIL count is nonzero. Acquire the
> reference for the first AIL entry and release it asynchronously when the
> last entry is removed, since AIL removal runs under sd_ail_lock.
>
> Build-tested: x86-64 GFS2 objects with W=3D1; arm64 GFS2 objects
> also compile.
> The syzbot report has no usable reproducer on current HEAD, so a runtime
> test was not possible.

thank you for this patch. I agree with the solution, but I'll merge it
with a better description.

> Fixes: 864174f97647 ("gfs2: Don't cache unreferenced glocks")
> Reported-by: syzbot+ab91b239b20ae188b9cb@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dab91b239b20ae188b9cb
> Assisted-by: LLM

Nit: Assisted-by tags are now discouraged.

> Signed-off-by: Eduard Zateev <hackerowskiy@gmail.com>
> ---
>  fs/gfs2/log.c  | 5 ++++-
>  fs/gfs2/lops.c | 3 ++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/fs/gfs2/log.c b/fs/gfs2/log.c
> index b55daf1e638..aa5f2a9a94f 100644
> --- a/fs/gfs2/log.c
> +++ b/fs/gfs2/log.c
> @@ -74,10 +74,13 @@ unsigned int gfs2_struct2blk(struct gfs2_sbd *sdp, un=
signed int nstruct)
>
>  static void gfs2_remove_from_ail(struct gfs2_bufdata *bd)
>  {
> +       struct gfs2_glock *gl =3D bd->bd_gl;
> +
>         bd->bd_tr =3D NULL;
>         list_del_init(&bd->bd_ail_st_list);
>         list_del_init(&bd->bd_ail_gl_list);
> -       atomic_dec(&bd->bd_gl->gl_ail_count);
> +       if (atomic_dec_and_test(&gl->gl_ail_count))
> +               gfs2_glock_put_async(gl);
>         brelse(bd->bd_bh);
>  }
>
> diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
> index 341f5bb844b..c4e63fb375b 100644
> --- a/fs/gfs2/lops.c
> +++ b/fs/gfs2/lops.c
> @@ -120,8 +120,9 @@ static void gfs2_unpin(struct gfs2_sbd *sdp, struct b=
uffer_head *bh,
>                 brelse(bh);
>         } else {
>                 struct gfs2_glock *gl =3D bd->bd_gl;
> +               if (atomic_inc_return(&gl->gl_ail_count) =3D=3D 1)
> +                       gfs2_glock_hold(gl);
>                 list_add(&bd->bd_ail_gl_list, &gl->gl_ail_list);
> -               atomic_inc(&gl->gl_ail_count);
>         }
>         bd->bd_tr =3D tr;
>         list_add(&bd->bd_ail_st_list, &tr->tr_ail1_list);
> --
> 2.55.0
>

