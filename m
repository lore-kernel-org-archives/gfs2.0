Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6607D11736
	for <gfs2@lists.linux.dev>; Thu,  2 Nov 2023 20:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FtIRoCFV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698958215;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IrLxZV+XrSf0I48Leusyu5iFH1pARB97h86sIalAdVo=;
	b=FtIRoCFVz1X7SoPaQSpGSF7eDFM/ou7A5Jc9MlhpegXINAO0pMqGGdj5ibuFy/6LdBuDpE
	JybNYjqiDYCSA8XJvFCswzlKkNENl5qRh/1tFF+j2gLDJssxrl6DfqsZYwmMVcfCDQEHIJ
	VldlgAXbVRPJulNt546rgwJOEQhFVXo=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-jzDuGHciPtiVKLdWrH2HAg-1; Thu, 02 Nov 2023 16:50:13 -0400
X-MC-Unique: jzDuGHciPtiVKLdWrH2HAg-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9ae57d8b502so104671566b.2
        for <gfs2@lists.linux.dev>; Thu, 02 Nov 2023 13:50:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698958212; x=1699563012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IrLxZV+XrSf0I48Leusyu5iFH1pARB97h86sIalAdVo=;
        b=oiBpm7pYULOgMA6MtF0UBcaj4/bExJyhdPzlHdCx2P6p4xc95KmpXn3Kcic0YJDGjC
         B1BG/5SYQ6Mts5NMcDlL3QpezByrPuXGkOdXKHkD9qc5kpuGnivT+KOQq4kz5YguMH+n
         Qhtyen33GYul3GIJsgIVEZcNtbq+xQb3Jr1V9ev0+pqjMhy5DrUeVE5Ygq6noqSHmkIt
         KfgLbcJftZZBPHhbbFlbpyNxbZgGv1lee0WhlB+qmFJzfm+uBsdi/EKKIXUkJMZjB4Ra
         gn8KogT6zj/6han7zL8lJMYwKSDI753xuD+4kQJI5E0P4M5ROA4TpPq0uThahK0DGo4J
         lkWQ==
X-Gm-Message-State: AOJu0YzgJ3m6UuFECN0fzyrFzC1/40wzUMz+k0p1iDENxvoTRbXupePV
	NP/phwWKiNPzcG5WXOb02KLt1UPRSulgpv6RfO0x4Sdnr1VTDUKpuT9nM1CCG4SZmM9akZ5CplJ
	jMUH6gy6WtdPDmC5U2Okc4XJojAGNWg==
X-Received: by 2002:a17:907:36c2:b0:9a5:846d:d81f with SMTP id bj2-20020a17090736c200b009a5846dd81fmr5095937ejc.17.1698958212685;
        Thu, 02 Nov 2023 13:50:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPkbajaRcT+JvALtTXr81rdvqeY0iAs0XtXCgrwHtKr2YQrzZlOSrZTOGrHKaeGhF8BReyRFzlAaRrUjpbuXQ=
X-Received: by 2002:a17:907:36c2:b0:9a5:846d:d81f with SMTP id
 bj2-20020a17090736c200b009a5846dd81fmr5095924ejc.17.1698958212068; Thu, 02
 Nov 2023 13:50:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231102195803.1212539-1-agruenba@redhat.com>
In-Reply-To: <20231102195803.1212539-1-agruenba@redhat.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Thu, 2 Nov 2023 16:50:00 -0400
Message-ID: <CAK-6q+h7zaCy7DZjYsmc0Z+w6iVhrWvLL2icrhXpWH5Z=aYEog@mail.gmail.com>
Subject: Re: [PATCH] gfs2: don't withdraw if init_threads() got interrupted
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: gfs2@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Nov 2, 2023 at 3:58=E2=80=AFPM Andreas Gruenbacher <agruenba@redhat=
.com> wrote:
>
> In gfs2_fill_super(), when mounting a gfs2 filesystem is interrupted,
> kthread_create() can return -EINTR.  When that happens, we roll back
> what has already been done and abort the mount.
>
> Since commit a28dc123fa66, we also call gfs2_withdraw_delayed() in
> gfs2_fill_super(), but that only marks the filesystem as withdrawing and
> relies on a caller further up the stack to do the actual withdraw --
> which doesn't exist in the gfs2_fill_super() case.  Because the
> filesystem is marked as withdrawing / withdrawn, function
> gfs2_lm_unmount() doesn't release the dlm lockspace, so when we try to
> mount that filesystem again, we get:
>
>     gfs2: fsid=3Dgohan:gohan0: Trying to join cluster "lock_dlm", "gohan:=
gohan0"
>     gfs2: fsid=3Dgohan:gohan0: dlm_new_lockspace error -17
>
> Fix this by getting rid of the ill-conceived gfs2_withdraw_delayed() in
> gfs2_fill_super().
>
> Reported-by: Alexander Aring <aahringo@redhat.com>
> Fixes: a28dc123fa66 ("gfs2: init system threads before freeze lock")

nitpik, this is not the right commit, calling gfs2_withdraw_delayed()
was already been there before if init_threads() fails just in super.c

I was looking there as well..., but I am happy that this is fixed now.

- Alex

