Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651E51AB35E
	for <gfs2@lists.linux.dev>; Thu, 20 Jun 2024 14:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718893362; cv=none; b=KvrTKdny0HFcCDiJv7jVAvGm/BUcLlMrgyQezYrzin8vxYNOtwaguTxi/uYpISiNFcXmY0GJubd93EJV2AxdkzAsYbJ28wJjFBNQJckucz043hIL0MSy8ni5dEA/Fw+GyueS4OZLbqtrZnSKfD9wwyKn1xqB8/OgTu8yO6lnWHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718893362; c=relaxed/simple;
	bh=I2E/3ksL+3LCVvQOta3EVLTTpATOPVLtzfaMLXGmMWw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sGMBYeGNQxtlfSLgg66FUllKxDP6jpX3m7k2+6pdbk62nvC3lsrSmhNvxFnCYHEUGi8YrNum+1qFEZq/LMfp+S46uEQR9HfRzeECYC25Y1C1y72SEPeVFFQDEMJPHokLib5reCTeJ1/Norv0KmBryidj5fxP5sXbhs7rCopHHps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UnQ/PcLE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UnQ/PcLE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718893360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o1+r8bZpc0Kx9tYjJmctL1RfQARyNZlqT/Fhd/4ikcM=;
	b=UnQ/PcLEif11ko4lmjVbX6Zcq2djy9snuu0U/yxCY6bTFTl6W1aEAQRiyQvf8CM6oS7mJc
	x9ZdyGkHVWHrg3lKXU44z3kHgMMevQcZA8grF+YRGh/PtbZLFiR8Cc5tyxzabpP7Xx86eD
	F08SReTbclfp38S/M1hvl6JSKRujAXo=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-92-_fkMb885NOOOlpvGe5uoDg-1; Thu, 20 Jun 2024 10:22:39 -0400
X-MC-Unique: _fkMb885NOOOlpvGe5uoDg-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-52bf72615baso535609e87.0
        for <gfs2@lists.linux.dev>; Thu, 20 Jun 2024 07:22:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718893357; x=1719498157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o1+r8bZpc0Kx9tYjJmctL1RfQARyNZlqT/Fhd/4ikcM=;
        b=tf3KYO3LSa7k5ftj/Xiu3f/ODYJPkUpQeOUmcpvn+zInHd8s6Wj7TiKIUYbXOq/DM5
         ZOiQLy4wbAZC/q61k6ja3BVhUMC26PWA+IpetA8C4KyyNSjFqWgh9ws14IVLF9bIv4Tl
         S0BFHWn8kIEJKnCgKa2j48hN6puAt7rsDnQ4cTwz4wV6R5Y6LAA4rktZtmDFBiWJLtx4
         qPDGCOAO/3tksFxxz8rnW6yABFrNgOYphFtuYVaxk51XjOOrW0/Lrk/pBNZ/I4ZyDuRh
         ovp/RUVwiUVtzMBbIvWzMjnZ8zyh0W5K8J/iDtuuWpLUG8oJj/vXZsF4mQa92JhV/EUN
         GKOw==
X-Gm-Message-State: AOJu0YwRCowF7RTt8+U+f68I/1yOJyy85eb1rIu2jmDyAjnTPWVR8eyf
	oaV2jaUEoVkqQDmbeLHH13HrfIHfNs1OBaNEhUHjMThThQwbp48s4HS6h1R6ObI5jEq3xU5x2BU
	c4jhMYaBTvVessx5Bj98YFNKHWdOy0mO22YnfpJIzHnDEG2Sleea0PkGxUYAsmIAt/WQM49qEBs
	Y2LkNmAzAK5kNkHgD9JvCcCX7BdumM4EorKA==
X-Received: by 2002:ac2:47f6:0:b0:52b:c233:113b with SMTP id 2adb3069b0e04-52cc47ed0c1mr2070919e87.15.1718893357135;
        Thu, 20 Jun 2024 07:22:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjtGDkZy0G/3+IgjXnHkxDg+1llHsXxNf1ESBeD6dloG7MmZFksbgkypo6HqRAV2tbXraVSngGJDN3Q5kN4F8=
X-Received: by 2002:ac2:47f6:0:b0:52b:c233:113b with SMTP id
 2adb3069b0e04-52cc47ed0c1mr2070912e87.15.1718893356725; Thu, 20 Jun 2024
 07:22:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240618160517.901589-1-agruenba@redhat.com> <20240618160517.901589-12-agruenba@redhat.com>
In-Reply-To: <20240618160517.901589-12-agruenba@redhat.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Thu, 20 Jun 2024 10:22:25 -0400
Message-ID: <CAK-6q+i4YsSPX5i3zAUK5PX1XZ4JY_U=hhx-8N8mEeoOiRKw5g@mail.gmail.com>
Subject: Re: [PATCH 11/13] gfs2: Get rid of some unnecessary quota locking
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: gfs2@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jun 18, 2024 at 12:13=E2=80=AFPM Andreas Gruenbacher
<agruenba@redhat.com> wrote:
>
> With the locking the previous patch has introduced for each struct
> gfs2_quota_data object, sd_quota_mutex has become largely irrelevant.
> By waiting on the buffer head instead of waiting on the mutex in
> get_bh(), it becomes completely irrelevant and can be removed.
>
...
>         error =3D -EIO;
>         if (gfs2_metatype_check(sdp, bh, GFS2_METATYPE_QC))
> -               goto fail_brelse;
> -
> -       qd->qd_bh =3D bh;
> -       qd->qd_bh_qc =3D (struct gfs2_quota_change *)
> -               (bh->b_data + sizeof(struct gfs2_meta_header) +
> -                offset * sizeof(struct gfs2_quota_change));
> -
> -       mutex_unlock(&sdp->sd_quota_mutex);
> +               goto out;
>
> -       return 0;
> +       spin_lock(&qd->qd_lockref.lock);
> +       if (qd->qd_bh =3D=3D NULL) {
> +               qd->qd_bh =3D bh;
> +               qd->qd_bh_qc =3D (struct gfs2_quota_change *)
> +                       (bh->b_data + sizeof(struct gfs2_meta_header) +
> +                        offset * sizeof(struct gfs2_quota_change));
> +               bh =3D NULL;

here you set bh to NULL.

> +       }
> +       qd->qd_bh_count++;
> +       spin_unlock(&qd->qd_lockref.lock);
> +       error =3D 0;
>
> -fail_brelse:
> +out:
>         brelse(bh);

It might be called with bh =3D=3D NULL?

> -fail:
> -       qd->qd_bh_count--;
> -       mutex_unlock(&sdp->sd_quota_mutex);
>         return error;
>  }
>
>  static void bh_put(struct gfs2_quota_data *qd)
>  {
>         struct gfs2_sbd *sdp =3D qd->qd_sbd;
> +       struct buffer_head *bh =3D NULL;
>
> -       mutex_lock(&sdp->sd_quota_mutex);
> +       spin_lock(&qd->qd_lockref.lock);
>         gfs2_assert(sdp, qd->qd_bh_count);
>         if (!--qd->qd_bh_count) {
> -               brelse(qd->qd_bh);
> +               bh =3D qd->qd_bh;
>                 qd->qd_bh =3D NULL;
>                 qd->qd_bh_qc =3D NULL;
>         }
> -       mutex_unlock(&sdp->sd_quota_mutex);
> +       spin_unlock(&qd->qd_lockref.lock);
> +
> +       if (bh)
> +               brelse(bh);

Here you care about that bh is !=3D NULL.

is breise() now NULL proofed?

- Alex

