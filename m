Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB67B14011
	for <gfs2@lists.linux.dev>; Sun, 10 Mar 2024 14:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710080772; cv=none; b=WLgGa4vHu+FSH1E3aShPb5ncmiZPaJOEgWshAmsPr3zpe1kkpjK2p9f4BATdhk9Rok6ZUXSyNZBi00xWrXNuOz6ubA+9Y+pbfOXMvMHlpw8yRC+IjA7tzi3/AvmbiocP1B2ZJIwKK1pfSz0jxWTMuiajx6f8bNp8/FaKoQxqUGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710080772; c=relaxed/simple;
	bh=gHOT0ts784PWLiHc2pprYe+vnaatMuKSH6dqdW/TX2s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d+KMP+uDiaCrrhniZDDx0ZRWtBZT8aHh+Mw7F0UduIALu6n/u4y/Yp2TlH3nLBzzxFqRYD5X6kciXiBD0g9YBfdB9U406mYBi8MFYu9srUkLJaQhlXDf3OYYY2Bu8SO949ELPxDO1+mC6ro844gyiGYuOe5aZrE9n4yacB6jUtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c9e0QM2f; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c9e0QM2f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710080768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gHOT0ts784PWLiHc2pprYe+vnaatMuKSH6dqdW/TX2s=;
	b=c9e0QM2fDN47flk5j/vvssrZwuC+QvuVqRI2UEhFl9qhqdmD87L2KsKZMflVU/vej1Qj5Q
	RS0wmefGiD+eOYChHyODEa8Dw6ufzRwAyn5ZRf8I4/lvrZot9FEetEZQbtLqZzczqNBiYQ
	bU8u2W+g3GqISE7aPse6dnVk10rie8o=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-IifglruLP8KleQHB3gFzXA-1; Sun, 10 Mar 2024 10:26:07 -0400
X-MC-Unique: IifglruLP8KleQHB3gFzXA-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2d2b256e617so16078961fa.0
        for <gfs2@lists.linux.dev>; Sun, 10 Mar 2024 07:26:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710080765; x=1710685565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gHOT0ts784PWLiHc2pprYe+vnaatMuKSH6dqdW/TX2s=;
        b=wGNjPxMQtqF7zTkKo6kmDL3F0zdTvVGI78C2rkZH+Bf7dDgZx7AOGbJ7SWoxf0cwt5
         u6v2yyBapP1Ztx7uuBmCi3a3mVpFe5D9aNUv2pHGDxtIVNUXMJI4DwYkBWEjeJL39ccM
         AfhZHSF9Gy//VeS8iV94jkxg9gWUV9tz+6D88ZErRoObpVkEL7XNl52acDSG9eYaLPS5
         wvIu/KTbPFtSQd0p2+9tK5w1b8gp3CretNhMmmxWoeaqLiG/+ThHeI3GU42zoaw+btmn
         zYr+JWSGIkhpug/yTfzDggDUJl+gdKXIrkSFVuAK389dPnCt87OK1Y2a4sR8NNXFo7pi
         3lBQ==
X-Gm-Message-State: AOJu0Ywq6HPrHt8pJO1vxmxX3TVrQZQqVczoixWWx6Xm1W0KC75SpuhD
	A1/m1ScSutDX8jWZVgib3RMnfUd8DXsNeu+XBCWSXMOpaKcLjB8akeQn6YSiWjMKhmvurs5rbDH
	DwAcwZiblCvsBbz3lAbtN5mPdPmAk7Pxg13HsuTubPK/Y004O1DPVrGboXX1RsMsUokslhwK0r+
	gGxq/JrJD0u8LfulfWcSZ4ZqSm7g==
X-Received: by 2002:a2e:aa26:0:b0:2d4:16a5:b361 with SMTP id bf38-20020a2eaa26000000b002d416a5b361mr2278948ljb.25.1710080765568;
        Sun, 10 Mar 2024 07:26:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHakKgJTk3xuJ59U2nnDB4Ef7EHw5PHHqgAJGZw1bnT/yJq3stKyLupXwfNhl2ekqXR8KcL1Vu0b+TvjkufKBo=
X-Received: by 2002:a2e:aa26:0:b0:2d4:16a5:b361 with SMTP id
 bf38-20020a2eaa26000000b002d416a5b361mr2278942ljb.25.1710080765234; Sun, 10
 Mar 2024 07:26:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240308161818.2388451-1-aahringo@redhat.com> <20240308161818.2388451-8-aahringo@redhat.com>
In-Reply-To: <20240308161818.2388451-8-aahringo@redhat.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Sun, 10 Mar 2024 10:25:54 -0400
Message-ID: <CAK-6q+iRdTb4yRsOxCv--_W2HQmkdhbMB4jmjzqq5hXVT_41aA@mail.gmail.com>
Subject: Re: [RFC v6.8-rc6 7/7] dlm: remove callback reference counting
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Mar 8, 2024 at 11:18=E2=80=AFAM Alexander Aring <aahringo@redhat.co=
m> wrote:
>
> Since we copying all necessary callback information from the lkb to the
> per callback structure this structure increased in the amount of memory
> being used. As each lkb structure holds a callback structure reference
> for the last callback that occurred this can hold more memory than
> necessary. We just copy the necessary information as it was before since
> commit 61bed0baa4db ("fs: dlm: use a non-static queue for callbacks").
>

We can also remove the struct kref from the callback struct now. I
will add it for the next iteration.

- Alex

