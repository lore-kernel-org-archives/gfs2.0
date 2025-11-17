Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7B6225390
	for <gfs2@lists.linux.dev>; Mon, 17 Nov 2025 12:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763381800; cv=none; b=dsCPic466kQPJkCVA1UzG5YJDXiZnMzudV9OT7xZxSACjoyPoNDHyedzliAM7TOJ72/GQlQCQ2JsR91vAWmVxub4QYUmumAyR4IgKKWmVBiXGUoU5yNnuKFQd6MOjVQkgQRRHxtGKaLqpqAkqETiLyraD8+pIa/fGNNGyBczNgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763381800; c=relaxed/simple;
	bh=gr23ZeY1I4hSMTNuQyKnmR98iMS/Fbk0O4eN4Mdv+9A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oqFVw6dj2G2Y2Vx0C3hxiHOkAxrhfRRViC0Oc34wEQ5XXfoZgi43FWfrPj8sTHFxjV9u0hFPZaEufa/djnlLXfT1014lfRs4PNosc59qNjITQS1BiaL0jhUt1ttDYiFC9AuOsvrI1Skd0Pm23evnoJPFAjQCOf58czE2OzbhckU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PlT5rROx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PlT5rROx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763381798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mH7dqTza5/ICxttpe5ZYHzkQvkuaT6VLnv2Ytl8moUo=;
	b=PlT5rROxLOLn8c5fpb+R8r7zOluSt8DWYVxH542JwdBFghlKMWh+ciRk9NIsSAiuMO2qdL
	TJmkM/LJilXiZXr1Tv1nxS8ogJjnUtVchAHIqaishNaGOfbPl20CZGuXJ6wn748W4gvEkx
	ETcGplehiKhSFT6IMvG6MXCJh5+Z72k=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-9mwqY2y0M2GjpkETIcGosA-1; Mon, 17 Nov 2025 07:16:36 -0500
X-MC-Unique: 9mwqY2y0M2GjpkETIcGosA-1
X-Mimecast-MFC-AGG-ID: 9mwqY2y0M2GjpkETIcGosA_1763381796
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-787dd35fb9dso36978117b3.2
        for <gfs2@lists.linux.dev>; Mon, 17 Nov 2025 04:16:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763381796; x=1763986596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mH7dqTza5/ICxttpe5ZYHzkQvkuaT6VLnv2Ytl8moUo=;
        b=aTUFUoZY3+P1wkf+7f91FHznoMhLwKz6IdaIN5NJp7y0sLiKK0SwfkhRBEGAundJCM
         P6lfnoKHvgqSGkl3MPR/fvSGuxACT4uFK10S5FXLGxmU2EKotiYLJT1wAvpfHdqHTYZd
         1q5C5/goggcfJAcqJYUNby9sDxI3MltxyjsrGUkDj8E+VnMGmyL2e5mVNq+4e1lyYU6s
         lKZq/PtpxM43L2eYCWFeRLOkIzoi4uA6G4zKisSk1d6caJ/n4A5Wu/RSjoM771At2gfJ
         0T1GnKL0Wnw+en1FzMlsa+qksqzQfPHzPe7AlDAKOcJ7xwuoRTghCxS2eZjRhmeoX75x
         H4OQ==
X-Gm-Message-State: AOJu0Yyc5AWymR8Nxg0NGQXSJja/nlq6QZ4Z4MooBMUEyBmaeDGi0Xb7
	WCHMLQe+wUJTUWEVoSlh7tIetrABc+GJ4m/P11xiUCNvo6jIplz/ZbBhLWLDi9jFHtJx69dGAu9
	2bWF2eSitWHOg5yS834lXKTMmJR/qdYllInouWZqUJ5WXEO2A50UuS04tBBxwcl87CZ45IcK5HV
	1vc3n8Lt6MalaMMUY1AesjPIczgEcqmLW7p8SJgA==
X-Gm-Gg: ASbGncvPEzVw5lF8xxgBZwiAoZhcSQBsGS5A1mFRBGrwJs7Hzt/eIFH0jS5NkSYP/og
	7mcms2nWmAV0L5R8Gi4W/JISU5ivIZwLiDDMkamBqm/82uGCit5IPKmqN5ueNtcE7xAn8aaSZzx
	4y06FG6ZZ/77YxG2ssGdH/+i/fwWGL8TQGM81MCHDkUpQzTE7nuyNeVw==
X-Received: by 2002:a05:690e:1542:10b0:640:dfa4:2a50 with SMTP id 956f58d0204a3-641e770c6bdmr8207901d50.62.1763381796180;
        Mon, 17 Nov 2025 04:16:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEQLIm+pbLoRuOW0i+kGG264Vq4lbJgRyjSePRLRntw0Ayy6GmrJaroLrGoALIRpTgAkyId8h3tJRcyUEYr8lg=
X-Received: by 2002:a05:690e:1542:10b0:640:dfa4:2a50 with SMTP id
 956f58d0204a3-641e770c6bdmr8207887d50.62.1763381795826; Mon, 17 Nov 2025
 04:16:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251101080919.1290117-1-agruenba@redhat.com>
In-Reply-To: <20251101080919.1290117-1-agruenba@redhat.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Mon, 17 Nov 2025 13:16:24 +0100
X-Gm-Features: AWmQ_bkZ3PrH05zVh0ifYZcqZjBkobVJSPgRJ3dx0BZ0fazXa24uBAl24PLTRBc
Message-ID: <CAHc6FU6KW2zsmoX5XqX2aJ=2qPgt_RtZq7BDApG55Jgf0jdJGQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] gfs2 non-blocking lookup
To: gfs2@lists.linux.dev, Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: a-sBsI61NCks5eLuxOtzFAkyzOtrcXXCOADXIEJFR-Y_1763381796
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 1, 2025 at 9:09=E2=80=AFAM Andreas Gruenbacher <agruenba@redhat=
.com> wrote:
> This patch queue implements non-blocking lookup in gfs2.
>
> A previous attempt to implement this feature was made in December 2023
> [1], but issues were found [2] and that attempt was aborted.  This new
> implementation should be free of those problems.
>
> Please review.

Note that I'm removing this patch queue from for-next for the upcoming
merge window to give them some more bake time to.

Thanks,
Andreas

> Thanks,
> Andreas
>
> [1] https://lore.kernel.org/gfs2/20231220202457.1581334-2-agruenba@redhat=
.com/
> [2] https://lore.kernel.org/gfs2/20240119212056.805617-1-agruenba@redhat.=
com/
>
>
> Andreas Gruenbacher (5):
>   gfs2: No d_revalidate op for "lock_nolock" mounts
>   gfs2: Get rid of had_lock in gfs2_drevalidate
>   gfs2: Use unique tokens for gfs2_revalidate
>   gfs2: Enable non-blocking lookup in gfs2_permission
>   Revert "gfs2: Add GL_NOBLOCK flag"
>
>  fs/gfs2/dentry.c     | 63 +++++++++++++++++++++++++++++---------------
>  fs/gfs2/glock.c      | 39 +--------------------------
>  fs/gfs2/glock.h      |  1 -
>  fs/gfs2/glops.c      | 15 +++++++++--
>  fs/gfs2/incore.h     |  1 +
>  fs/gfs2/inode.c      | 20 +++++++++-----
>  fs/gfs2/ops_fstype.c |  6 ++++-
>  fs/gfs2/super.h      |  1 +
>  8 files changed, 76 insertions(+), 70 deletions(-)
>
> --
> 2.51.0
>

