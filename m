Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4FF42077
	for <gfs2@lists.linux.dev>; Wed, 13 Mar 2024 13:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710337692; cv=none; b=s6NZbVXabJ94UbkWSnHzLncFq6plKym4RGtc12JNXwxagdTUOo+FOhpZHQ+JuiJ9+9YD2tTmaXdlm/NJXGC0GZpl9EozQB//ywhloZxHdvPFCTkW9V6Ydb0qiMgLqJerKIQKbukwdOXx7NLsxpH5nm00z2Vq+ODIs5IRdEnvHrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710337692; c=relaxed/simple;
	bh=wCCqrOyMSaVVHAQzkdRhqtOMf5YmEFiPfHPR1pwm4IE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eePeKqnEu8weR8qKqeH9EfrnZRt5KZp/ILec0jt3jVkjLGlpeFBkPdzpd52XZMqHjij7GFV48jA3evg2pA7x38ACrfVLrRyM+66smYVUETBEQOh+PGJPRrCWwrBzIiw6msYSb4j98zELLCUkm+J6LYPd9itN30MJecIJfEWNbu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UdLQqjcR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UdLQqjcR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710337689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IF47/t92NPMCtniy7mp8xPf8zIvGcZxq7kQI+91TZqQ=;
	b=UdLQqjcRa5g4E8cZpBFRXlueQN2tnUi83ytNMlvKtW6SFCM7efUS4i7ryuc+RGy7UxSmKH
	XlnJ0svs9kQJSDetTJX5LQ4RZ06qTecM+xA5eYQYAU32LLqqIerV/GKnikkeMSC0wmTb9D
	ZSD3fHA51Qa/JIoSVMRlKtCBOq6wipU=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-Cl0mPvi4Pq-9cFhScKJboA-1; Wed, 13 Mar 2024 09:47:01 -0400
X-MC-Unique: Cl0mPvi4Pq-9cFhScKJboA-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2d416cddf57so45964311fa.3
        for <gfs2@lists.linux.dev>; Wed, 13 Mar 2024 06:47:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710337619; x=1710942419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IF47/t92NPMCtniy7mp8xPf8zIvGcZxq7kQI+91TZqQ=;
        b=kp4tMJuNxOcXZylCMu8IJTWSjsDxjobBr4Fno/sOEb2hTPBV6A73c19vQKfHjPuPQ2
         bTd9EY9RfMrhBib+EA055TkRdJp0OgpjbqBasz0K92lloiqRVmSeCBFepG5XNUstd6aQ
         3VEvaXrSHyek3Q/e3tX6BLuUK9j3iu6aWOC5H+SJtGVhe7+THg/+0Dw8khSeW2vR5Z9V
         uefvrEiPDH2XSbr4R1/n/guBj/x7tdVfXUZ6cPmSyQhiK1tfrks+d1Tx39KqXmDhxWVx
         ccTqmHF8b101RMAnM9Invzh0YQWRCLKurpWDHQRqSZ3p8Xy+nnoS1+FdWkIJikwHppds
         U8ug==
X-Gm-Message-State: AOJu0YxY5nzmKNlyGCCoXOm1havlRboe5ItPJM6Yj5I9yhs1YqebqhGA
	VrOxpPiNFm64QFD7NZBWN6FDhJHq0ndJP93v33MYOn03zv9TNRg5kVEDaJ/Yjoyixm6m/eM8eCS
	LIYcPx1LjZqTeTQo1F+jOiQRpRNEYOaK3u6GyXPBZCGTh0TsmA5OhwAsxK1kK2hV8S/htyNsn7Q
	RU8dGGlWVDAyDituiYgh7fs0XS99gMhuRsily4
X-Received: by 2002:a05:651c:102c:b0:2d2:2b2e:1680 with SMTP id w12-20020a05651c102c00b002d22b2e1680mr2382082ljm.35.1710337619792;
        Wed, 13 Mar 2024 06:46:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHaoaO9Jr60qHN0u9wWHGhL88mob6EDcHzqEpjbtPMndISBMsjsTYu2KnCE45hvyj7SL4RaIpOfc3Ul6bVoE1Q=
X-Received: by 2002:a05:651c:102c:b0:2d2:2b2e:1680 with SMTP id
 w12-20020a05651c102c00b002d22b2e1680mr2382071ljm.35.1710337619463; Wed, 13
 Mar 2024 06:46:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240308161818.2388451-1-aahringo@redhat.com> <20240308161818.2388451-7-aahringo@redhat.com>
In-Reply-To: <20240308161818.2388451-7-aahringo@redhat.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Wed, 13 Mar 2024 09:46:48 -0400
Message-ID: <CAK-6q+gUrY7EaNSiOJfgtf-SgHsC8N+dQOCL8X+3_bMFuuSu9g@mail.gmail.com>
Subject: Re: [RFC v6.8-rc6 6/7] dlm: fix race between final callback and remove
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Mar 8, 2024 at 11:18=E2=80=AFAM Alexander Aring <aahringo@redhat.co=
m> wrote:
...
>
> -       spin_lock(&lkb->lkb_cb_lock);
> -       rv =3D dlm_enqueue_lkb_callback(lkb, flags, mode, status, sbflags=
);
> +       rv =3D dlm_queue_lkb_callback(lkb, flags, mode, status, sbflags,
> +                                   &cb);
>         switch (rv) {
>         case DLM_ENQUEUE_CALLBACK_NEED_SCHED:
> -               kref_get(&lkb->lkb_ref);
> +               cb->astfn =3D lkb->lkb_astfn;
> +               cb->bastfn =3D lkb->lkb_bastfn;
> +               cb->astparam =3D lkb->lkb_astparam;
> +               INIT_WORK(&cb->work, dlm_callback_work);
>
>                 spin_lock(&ls->ls_cb_lock);
>                 if (test_bit(LSFL_CB_DELAY, &ls->ls_flags)) {
> -                       list_add(&lkb->lkb_cb_list, &ls->ls_cb_delay);
> +                       list_add(&cb->list, &ls->ls_cb_delay);
> +                       spin_unlock(&ls->ls_cb_lock);
>                 } else {
> -                       queue_work(ls->ls_callback_wq, &lkb->lkb_cb_work)=
;
> +                       spin_unlock(&ls->ls_cb_lock);
> +                       queue_work(ls->ls_callback_wq, &cb->work);

The queue_work() needs to be protected by ls_cb_lock because it races
with flush_workqueue() and  LSFL_CB_DELAY setting.

- Alex

