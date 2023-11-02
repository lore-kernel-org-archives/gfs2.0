Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C992135D
	for <gfs2@lists.linux.dev>; Thu,  2 Nov 2023 19:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RCp7gbBI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698955095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ak1p6YSj3xPThwJvo/ekOh1XL+UpwNUYzPWPQrlUBg0=;
	b=RCp7gbBIBADmCHVZRT0xzHiPAff+aShG5M06g5jC8UkD/U0kMVF0QWcmIXRlQ3JQ3QNh2m
	CaVr6C29TnnR5ken+717WmORABQosjfRborGnqs+IEglbFhigSHSUoJDl7+XjPxGqrJXYK
	pwO6ELfQiW1stn6jn84atUnhu8oLT9g=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-Y6Kny53jP4CRsmQhFCR7ow-1; Thu, 02 Nov 2023 15:58:13 -0400
X-MC-Unique: Y6Kny53jP4CRsmQhFCR7ow-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5b62a669d61so1072435a12.1
        for <gfs2@lists.linux.dev>; Thu, 02 Nov 2023 12:58:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698955092; x=1699559892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ak1p6YSj3xPThwJvo/ekOh1XL+UpwNUYzPWPQrlUBg0=;
        b=e76+YMRzqC3Gkcv4PX9ve0dGSewEkwlxMymarHsRwdqw2q8vzAK8LrgivpbdpdkCv1
         MPdE6BkiVcojotqyQMxJ/wO7hAZ4jABl2Z5cEN926TrmG5haFespW/y2HjL2cN1U80SA
         9lBZeXk9NtkGasvmUtzYjPn3qfd2AxmeZPvTKeDdKoF8JX/XXOvJgtB2mmy7myZx8Qis
         1mWmo96SeFZ+euNk5Uq6WDUjjqzMo8zJ+2HGQWxXWnCCRCq28WnTUaka20kasxjhcc4Q
         PpL47EbiMnNuu1f+fI9tmKUhs8sYLkdG5mKvqtioEEOHWPNDkIKn2eoffJkE3uYIz8wt
         Da0A==
X-Gm-Message-State: AOJu0YyxeIjm6Z3W0NEWzZdF1aeiEiQ3UQFpjPZ0MisjBjMhGys+bupB
	Z5czRd8jBHf5wM+vZWXnr/mYBJoiP7xmqpwvuH2hjy3I5rX87p41Th210BXohacxbdgJWOdR6Og
	YP6ylgdBSeDnV6g0kpAyG7RS7tszFtw==
X-Received: by 2002:a17:903:30d4:b0:1ca:86b:7ed9 with SMTP id s20-20020a17090330d400b001ca086b7ed9mr14508200plc.40.1698955092663;
        Thu, 02 Nov 2023 12:58:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvPGYoSqhpPBcQTxQ/Vi2CHTGBtTkNtBVDCNxM0DSF3hNeGPEkfp6ntnsHa0FJP9ef1ZsBXlhE9Wpw7UIc7HY=
X-Received: by 2002:a17:903:30d4:b0:1ca:86b:7ed9 with SMTP id
 s20-20020a17090330d400b001ca086b7ed9mr14508189plc.40.1698955092363; Thu, 02
 Nov 2023 12:58:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231031143328.1364741-1-aahringo@redhat.com>
In-Reply-To: <20231031143328.1364741-1-aahringo@redhat.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Thu, 2 Nov 2023 20:58:00 +0100
Message-ID: <CAHc6FU4kzYQCmtX+hDBNwufvgZio-zxhO5kGtxJjWfWJMjNZjA@mail.gmail.com>
Subject: Re: [PATCH] gfs2: don't withdraw if init_threads() got interrupted
To: Alexander Aring <aahringo@redhat.com>
Cc: rpeterso@redhat.com, gfs2@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Alex,

On Tue, Oct 31, 2023 at 3:33=E2=80=AFPM Alexander Aring <aahringo@redhat.co=
m> wrote:
> This patch just don't call gfs2_withdraw_delayed() if init_threads()
> returns -EINTR.

that's close, but calling gfs2_withdraw_delayed() actually never makes
sense in this context. I'll follow up with a patch that describes why.

Thanks,
Andreas

