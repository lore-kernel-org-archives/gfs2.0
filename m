Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A89418509D
	for <gfs2@lists.linux.dev>; Wed, 17 Jul 2024 20:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721247062; cv=none; b=OlVvvFEa13UTngsdR6GAWp7cCLLcd8kwyxTWl856LQe3PB4OTTPFC3DYKxKIUjkp2xPtco6mE6JtSkmxlMpim1/946u9zkLi/hT3/GWJ+jE1kmtpvFiUsXF3gFc8xzH5VSq0hyC2BNseXZ9WLjhgcAcYKD1/A4Ne6KTl7CtEiDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721247062; c=relaxed/simple;
	bh=dqw5Qeh2xp7WhjNIwZjRLJC8bY9vGPDrCHCpJxFD1dQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JZxDgAcB/Ng0sHauiCZ3qvETkgm5mVuQM4zGkecmS0qObnK20kKf/3UslzqscAiTePodPyzei0KIokIlcdO9/kzs1J150D6SkXnAEe34XR0VBnsI0ij49FhDxM8US5/+UmqO+NfHA90VOSoR6EpbLHiGpCmmMTISQBx5IYE42GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LpOsx9qY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LpOsx9qY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721247059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wUuy8Fm1573t8h+fqy2o6dRDaXACJrIuqRSm7ii11lY=;
	b=LpOsx9qYc3+1zCF1QJ2Y2x9yH6wZEZLrEYRfp883a1m1Q/OuiFSWScht3VT0ucIZcK4aXD
	bRbqeATjAeEBIkqAM90eGjhnqNg4kCQSiixlGHy7S2pRXeg/WTTa8AgHGpd+CiRpCf696Y
	rh2pX5TsSact1K2DMuINeK9KzlMp1fw=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-6-Zhzyk1qDNSeH9Y3cCUTlOw-1; Wed, 17 Jul 2024 16:10:56 -0400
X-MC-Unique: Zhzyk1qDNSeH9Y3cCUTlOw-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1fc5e61f0bbso1022185ad.1
        for <gfs2@lists.linux.dev>; Wed, 17 Jul 2024 13:10:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721247054; x=1721851854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wUuy8Fm1573t8h+fqy2o6dRDaXACJrIuqRSm7ii11lY=;
        b=bNVoz6+oVRR9bmhQsL1qSOKxUSpUOdaDSTVBGLyhUF3spcVHwaqQBw23Jz3x9hstW5
         AmMdNhBA6zfeuZ7P6GVgH8DboU2z5Upp7FYZhVlgTrgJDhT57f15Ma2s4Mf+SLIsoAU2
         hMgb+2JK9da99VEUmnccBj+GZ+k5zSIaxq0ZbnLM5WRxOx5LgkTNmZDI/n9v8S4JNTqa
         TlUuUghBG3XYKdbIrjAOWecieLnzbxrMlRcDfM1gmGtmeY81GqvHLO2dU+t079wlUASM
         F3Cacpj57spY1lOXyLYZU9GILy44qooizcl3obb87An+JJHx9PDAOMValSS0eP5tBJZ7
         MTag==
X-Gm-Message-State: AOJu0YyPfKuFQQtjjgV8rAjVtc/DQz5OugkpMTWqwaUt7cr2JcRBh9zw
	h2JQ2EYDlK6E0YHYcV65LPUi9W9ToiZ+aKqbLpbkOp1+1uWKj2a8GJlgv1hpvuegTsfkb2GVnnZ
	YYUMgsBA17y5aarv/DRQIRPZIl1p8MXsSqVWCcZwPxifwuGcHJRH5MsIWEy0b61Eg52++b06wDI
	D1gM7vtJ2G5rcikzJJLn+XQGuqHA==
X-Received: by 2002:a17:903:2288:b0:1fc:287f:623 with SMTP id d9443c01a7336-1fc4e154aebmr22813745ad.11.1721247053964;
        Wed, 17 Jul 2024 13:10:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTxL2wGq4qFVRg2dVJl/Fkrg4wVfEqLIKk8VPK81qtTGJ+uA+Dr22xE7RfaMxJsxhvqD2CfBFqlBqX5PmSb0E=
X-Received: by 2002:a17:903:2288:b0:1fc:287f:623 with SMTP id
 d9443c01a7336-1fc4e154aebmr22813655ad.11.1721247053525; Wed, 17 Jul 2024
 13:10:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240715174757.876203-1-agruenba@redhat.com> <CAHk-=wi68M2mAY82Ss264_++2q2x1fumXnjK2Lxt5LZoDHbr9A@mail.gmail.com>
In-Reply-To: <CAHk-=wi68M2mAY82Ss264_++2q2x1fumXnjK2Lxt5LZoDHbr9A@mail.gmail.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Wed, 17 Jul 2024 22:10:41 +0200
Message-ID: <CAHc6FU6Up+wLg=3Kho5mE8fa5h5-4bNKtTu2fPJ4Q8X=XwJNOg@mail.gmail.com>
Subject: Re: [GIT PULL] gfs2 changes
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2024 at 9:25=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Mon, 15 Jul 2024 at 10:48, Andreas Gruenbacher <agruenba@redhat.com> w=
rote:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tag=
s/gfs2-v6.10-rc1-fixes
>
> Btw, your key has expired, and neither a "gpg --refresh" nor looking
> it up on kernel.org seems to find a new expiration date.
>
> Please update the key somewhere, and use *long* expiration dates. This
> kind of noise is pointless.
>
>               Linus

Sorry for that. I've pushed an updated key with an extended expiry time now=
.

Andreas

