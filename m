Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179DA24BC06
	for <gfs2@lists.linux.dev>; Thu, 17 Apr 2025 13:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744897203; cv=none; b=ME5dJsvXAMJJTfbrv+lvlC3D5ERJoL8fQ443DI+v7swGQgMN2cKsIibo3sjSPs4BJcua6O4jM0ybi6zA3Y2bfA/rYLCl6T9rHYdGb2GMYYPRaBC7TKXOg/Rzcog5hlnIyPDSe7TivzbGc9wyv4jVvf0Fqyo+sDW+Jtvv3kB5ag0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744897203; c=relaxed/simple;
	bh=Po6jtuQUXfnvs1Q8pYHk8exmHIfvXH6RF3vd2XiCm2A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BujDtC34iDSvDBvh+lyG26Q8KJ770aB9slRWfCOep7Nc+cL7i2uvyDyYV6lAz24oQov9vtoe5q8yMTuYxKnEnDwJn6STa/cVRIfct5NZgGcyo09HSJoSoLF5pSYJQSVrhpxoLDxqi8k4krGex8kdwrQJHFh8pOuxElMGi661qlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WKBaf0Ux; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WKBaf0Ux"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744897200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zcbQrKkHnBeEO0liSW6jmala/g804rGL1ImFAEkY+zQ=;
	b=WKBaf0Ux3wyUXhCCU6q0t9o+JDNmjC0tjqhERWnE45yIbg6OdbZbp3/5Ci9QRxVVszwbHH
	tUYkirzgGGdpnlXZ+NquOALOOlPcKl02S2SEdwJ5rXS0xG5sIpPV79J9XeWJj3+fT42LTf
	wnWqeMIUbFmidK3PUHZDf+mi9wMfh1Q=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-lEMotgLSPhSdZM2UtMmzUQ-1; Thu, 17 Apr 2025 09:39:59 -0400
X-MC-Unique: lEMotgLSPhSdZM2UtMmzUQ-1
X-Mimecast-MFC-AGG-ID: lEMotgLSPhSdZM2UtMmzUQ_1744897198
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2264e5b2b7cso8080005ad.2
        for <gfs2@lists.linux.dev>; Thu, 17 Apr 2025 06:39:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744897198; x=1745501998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zcbQrKkHnBeEO0liSW6jmala/g804rGL1ImFAEkY+zQ=;
        b=GqK7qsLQvaXr5bN1RzCIW2T76a9n40FNIOqIGf6msihXvVx7Bacb8fgvwMSbA0Rfu9
         p2/RePNQPFQiiUOG9U/maH6VIaNp4RuGfNzs+D3ipj+WAaq7+ORE6cyulT3LFDkShl5r
         7ucFtQcggzc3JowM40Fr8RNaH9AvdK2IOeZ9lF9rovu8XDaCJQ61eTB82jZfAQ8oHhm8
         KpjPEolqUhkpUxQM2hAfFPuN1iuEpHwL7NtN0KcutBvQHHiYFa6x/WxHnOxSUzUQ/cO5
         s+W08Ynvc/XNubd/cxi1n61BorC+vYOTtR3zc0onUGRgb1vDGlpaDAj33HxgJlt46jvW
         0b2Q==
X-Gm-Message-State: AOJu0YyXpICRN53i+EyUICvhEdPew7mknrmnjcBhkxsDYlD2D8B9S80R
	uobDStF9W1VWoB5bHHO6hMmr8r56L4zxfk2tcs6MLAHVHxF92x564fPjgM9jLrE3s+CqVqG6J+R
	WeF0WRracjYXPqDo5FGmEFRaWcm6pAvgCy4od6pASYSZKfK1TFDFCiKZN/5UpJjzj8Ama90fa3a
	EKkwIXPyRpctzm23xSg5/0olxVXA==
X-Gm-Gg: ASbGncsUYSSGx+kgsjjNi3QMZitfHkQBE/5p1MV52KRCOfTDIEIOrqrvApd35RhPmJF
	RzuRqJYByx0smuXV7jGcKtAoR7KqcEQJJ4PWbBp3zzIFotRt3pCGYavNbG5itS+sNtG0=
X-Received: by 2002:a17:903:1cb:b0:224:721:ed9 with SMTP id d9443c01a7336-22c35981e16mr89182915ad.44.1744897198396;
        Thu, 17 Apr 2025 06:39:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZ5rAGqIr1cPSxbdxrx7vXjd8oPl3FugfkE48mT3swqzsCyWHYDjO/wTTUzbLLvTBWTzhmtw26XXyoqf17mf4=
X-Received: by 2002:a17:903:1cb:b0:224:721:ed9 with SMTP id
 d9443c01a7336-22c35981e16mr89182705ad.44.1744897198109; Thu, 17 Apr 2025
 06:39:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250417083839.937319-1-nichen@iscas.ac.cn>
In-Reply-To: <20250417083839.937319-1-nichen@iscas.ac.cn>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Thu, 17 Apr 2025 15:39:46 +0200
X-Gm-Features: ATxdqUE4N1weN2vFZ1XfAv7c3eJ5m5rjb8xCU1XP4Da_-Lcn3QJQunSg8dg0C5Q
Message-ID: <CAHc6FU6g5k5-D8E5HjS99TLhRRXDG8xuDYT4JX3Pp=HqY+b9cw@mail.gmail.com>
Subject: Re: [PATCH] gfs2: Remove unnecessary NULL check before free_percpu()
To: Chen Ni <nichen@iscas.ac.cn>
Cc: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: cQ18RCaU1gXp8dJuSEt84ZYpB4jU6bgGAdq2_sOllLc_1744897198
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 17, 2025 at 10:45=E2=80=AFAM Chen Ni <nichen@iscas.ac.cn> wrote=
:
> free_percpu() checks for NULL pointers internally.
> Remove unneeded NULL check here.
>
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
>  fs/gfs2/ops_fstype.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
> index ea5b3c5c6e1c..8f9bb6677db7 100644
> --- a/fs/gfs2/ops_fstype.c
> +++ b/fs/gfs2/ops_fstype.c
> @@ -64,8 +64,7 @@ static void gfs2_tune_init(struct gfs2_tune *gt)
>
>  void free_sbd(struct gfs2_sbd *sdp)
>  {
> -       if (sdp->sd_lkstats)
> -               free_percpu(sdp->sd_lkstats);
> +       free_percpu(sdp->sd_lkstats);
>         kfree(sdp);
>  }
>
> --
> 2.25.1
>

Applied, thanks.

Andreas

