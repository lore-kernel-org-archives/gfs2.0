Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C052C3382DC
	for <gfs2@lists.linux.dev>; Thu, 16 Jul 2026 18:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784226862; cv=none; b=jjdTsoiMafJ2tCkucPpIpi1S967dGvF7CHes7SYLBPn8/8p6s2v5McLXeFYYRH5B7Kj/1NzkWONcm50TXKVBq1xSOoJECQ5sn3Sl1PM6Jgs2b+IClr+txNv1QwSIvvUDGq/GH0ss+qeP8XkcMhheRGvBIWr4MynX7mYa6Iyeoa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784226862; c=relaxed/simple;
	bh=VeCTio51MpzR/+I3EhFL0EM4fgMtTnmN0R5K1/J0uHY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NphIhhe9YXC8PwOZw7sexSQfzq9S3DYbNi4NgrFKgR8fCYp6XJvJvIKOdkgPtqn2ZpDThZy883pxkRAa5h7xX6dJ0GcuHUUgmSbkxLdYjFYior5Wo6U5HK+NHKTkthFw/JWkpOL2fytw51HO8eEi/FUDtNyfvlkcVfmmjyX4GDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cuq0KZMV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cuq0KZMV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784226859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DbRVF81ffLi24DwJe7aZIuIDZ+mqKmveWoNDZp3NzVE=;
	b=Cuq0KZMVq2m9KgDiXIVkwVAxesNWl6un0cRu6ZDqQnjC5W/8G6LGh0HjxfTk6pL4gZmHTQ
	LB5CFYlj/gcYSPFK/EiEPD5FQT7mnBXh52xMU9Iv5mLXHiFmAjGnLUXYp2MxRnMN8jgdqJ
	4Q8JhB2aM+27/DBqt+FOaJxvIt/4ie8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-7GpfpG8GMBOHufHGndMauA-1; Thu, 16 Jul 2026 14:34:17 -0400
X-MC-Unique: 7GpfpG8GMBOHufHGndMauA-1
X-Mimecast-MFC-AGG-ID: 7GpfpG8GMBOHufHGndMauA_1784226856
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-493d742c668so54396265e9.2
        for <gfs2@lists.linux.dev>; Thu, 16 Jul 2026 11:34:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784226856; x=1784831656;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DbRVF81ffLi24DwJe7aZIuIDZ+mqKmveWoNDZp3NzVE=;
        b=Hh9siPfW8oAL26q9H/Az4j+8VPdQNmym1kjrsmgp2dAP7W5mYfF4GGMRWpn1YU5k+i
         H/TsFyHYKyEC0kf1JZGta1190SY5EbYrNOQPEGkj8nzu135aOZL8OUH2pHoWB8jbBPXv
         08mQecu2kLVhtBaMeoBidNH0k71SiWiNsWpEZ08V16JrFJH9m69ql/zGmx2f7ZfnB5FG
         dY2yGhW3wZWCfL6yctlwglNPnasUFVNGHQbdIbwKbUVXxZqiZK0j9i7A9IYixG1ajvVM
         HUduxwS8RVimnlwBbXyKppozNhweWsztPPAns6bUTYuGbUpjesd3Tg5a3kboyPF1RqUS
         g1EQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr5lPp+TROOv+siJMmYwneJxx/ooRZKaU6NSBdVUOzhcZiw1Tq/liDdfaiDWXsnE60I4BdT@lists.linux.dev
X-Gm-Message-State: AOJu0YwyqO/+gu/vZYMeWffcpuoSObN9FZBG7Y19YSDl6taYskNqUxZp
	4X1+az689PU+KIwLjaoGpqTkZTWHhO0F+w84jwwpWHYunCVEYFwZB6eFJBokGvfe71D+SmvRJIc
	sRKFWISuDARHbtDTgnvK2lmAaYSuQQl4bwq0ksixX3uWSpSc8bESSiSwDmFpOY7iK6+xDzSQ07t
	vcCOi4mMVJTbe75J4vPFnh6Bop82FfYA==
X-Gm-Gg: AfdE7cniTKZrCh1wAniuAWrP4OT8jlnIqZlfG7ZwGLkku5F8c3fYnjBvbCkeHPUCf4v
	uhQhQkGH3NYY1qmzTRXqtcAP+VwCg5bEUyigYbj6Csls0Z/Jo1cokImcJCSFfBDre4InCUNNz7J
	NMm6IK4JuFE882cHLlb0lxZbsUEz0VJJRiPlIYFBsjhUjcdX8AYG/XLIuLvy6OrVxFhbIekGE3r
	fkQit1bvvOYlZ1Y
X-Received: by 2002:a05:600c:34c9:b0:492:3e44:214b with SMTP id 5b1f17b1804b1-4953905c59emr139195135e9.13.1784226856504;
        Thu, 16 Jul 2026 11:34:16 -0700 (PDT)
X-Received: by 2002:a05:600c:34c9:b0:492:3e44:214b with SMTP id
 5b1f17b1804b1-4953905c59emr139194825e9.13.1784226856177; Thu, 16 Jul 2026
 11:34:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260627161721.129861-1-listdansp@mail.ru>
In-Reply-To: <20260627161721.129861-1-listdansp@mail.ru>
From: Alexander Aring <aahringo@redhat.com>
Date: Thu, 16 Jul 2026 14:34:02 -0400
X-Gm-Features: AUfX_mwa-qRqltPCdXNb6fPXSKr2TvHPSsy-Th62HURzMMTnLAIz12EOCQ8-o7g
Message-ID: <CAK-6q+jdpOMPzNmC6C33z2hfq+5S8PGC2gizqf6mtZPWwZZuJQ@mail.gmail.com>
Subject: Re: [PATCH] dlm: The core of the DLM for GFS2/CLVM
To: Danila Chernetsov <listdansp@mail.ru>
Cc: David Teigland <teigland@redhat.com>, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	lvc-project@linuxtesting.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pSQhDHwvEgpYPetOyftPMHs71g7oKdNpr8UH7e2Uihk_1784226856
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Jun 27, 2026 at 12:18=E2=80=AFPM Danila Chernetsov <listdansp@mail.=
ru> wrote:
>
> The DLM recovery path restores lock state from rcom_lock messages
> received from remote nodes. The lock modes in these messages are
> copied directly into the local lkb state without validating that they
> are within the valid DLM lock mode range.
>
> The rest of the DLM code assumes that lkb_rqmode and lkb_grmode
> contain valid lock modes. In particular, LVB callback handling in
> dlm_may_skip_callback() uses lock modes as indexes into the
> dlm_lvb_operations array:
>
>     dlm_lvb_operations[prev_mode + 1][mode + 1]
>
> An invalid lock mode received during recovery could therefore result in
> an out-of-bounds read during subsequent LVB callback processing.
>
> Validate rl_rqmode and rl_grmode before storing them into the local LKB
> state. This preserves the lock mode invariant required by the rest of
> the DLM code.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Fixes: e7fd41792fc0 ("[DLM] The core of the DLM for GFS2/CLVM")
> Signed-off-by: Danila Chernetsov <listdansp@mail.ru>

Acked-by: Alexander Aring <aahringo@redhat.com>

This issue dates back to the initial DLM commit, and we've never
implemented validation for many DLM message fields.

I am sure there are more issues like that; a follow-up patch should
clean up or revisit this whole part of DLM and validate messages at
the lower message parsing level...
I will add this to my list for follow-up patches to improve this
situation in DLM.

- Alex

