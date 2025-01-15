Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4522459AC
	for <gfs2@lists.linux.dev>; Wed, 15 Jan 2025 13:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736948121; cv=none; b=rm2W9tgyCSLbFy/UfILNgji7OKteuMAqovZMt9sGjefhU3IwQKSK2ylW4T10rCFhgzv9N/Ip23P5jfwc/7e/YBZ6CPi436Uyf5ELMl/hCIvt6Ong1C5sThPTUOyESYt0feXIDDOpWRYfgkJWZHTfQnx3QNo/rl63i1Tn7D6xIx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736948121; c=relaxed/simple;
	bh=RIL+nwqLthbjx+M+EsQdph+tsv5s12wizfoAqsoo2lY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r6lcqRZ20coL8rg6KOUaqxwPjBhZaG9rOH9tChksUBQyOnvayu7p36My+1f4QcaT3pQkxSdR/vOxqTWnHXh6BS3kgiZ2NiydMHLQtSIELKQ+vXa4HbeHXqzsxiyCieuwkDXY22RwMeAyRkbLyoZt2ES1coTZ5f1nblOKA1e7iyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M0WCYaQC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M0WCYaQC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736948118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EHMPieLiEBxInJQ6B0H0UcMOipXZzYAKvCo+eqZFwfU=;
	b=M0WCYaQCEKWDtcykVOJyD28jtJsKG4ZrWV442+zinW8zxn+3ObqkKdjv9Nq2JBHTTX273o
	7kIGSskESIMhccDwPC+1hExlu33hy9ZsBhCdTW2FjCQ7lH464NLJsYRbFjPnmpQWZmTiQh
	XXWJydouPAr31rzpYWcIzVueF4BNA88=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-Uv8SXqwGOmCfrj4qCQbS_w-1; Wed, 15 Jan 2025 08:35:16 -0500
X-MC-Unique: Uv8SXqwGOmCfrj4qCQbS_w-1
X-Mimecast-MFC-AGG-ID: Uv8SXqwGOmCfrj4qCQbS_w
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-21648c8601cso113359315ad.2
        for <gfs2@lists.linux.dev>; Wed, 15 Jan 2025 05:35:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736948115; x=1737552915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EHMPieLiEBxInJQ6B0H0UcMOipXZzYAKvCo+eqZFwfU=;
        b=WuKf22jPMKIBFM71VOLyEXpgfpb2VrMQuoLoBTBbjMl5/sHl5B/e/tY5jI2BxtaRDW
         LoaHXJYn0IPTnzy9eNkgjFSbUkWH3zwt3m9+M4ucNDbsm/dOd5KY77XAZCcg5WfZOSCo
         HBZXk/R738PW4TFnNnx6kPywBG3P/9hM6XdoCHeXeOW5nSOLRPCz02OjQDJe69J6lG73
         zun7nJLd2R86oYyob+uytWcJvZglrTw6ZnilwjKjiHq2HgiP98ItcPoczw4ZBUZ9AgbS
         1n72W8nstOrt2xHcmHQ6oEBxLXRF36amS6XX3qJuLrwVbqgLzU4/U7kPDkxUhkbr7sEe
         vEPA==
X-Forwarded-Encrypted: i=1; AJvYcCWMi7WerOMdsroV/0gwL2dvMLzzacbVwnODSXe8YXdvE6aUx8FMBszCVWSjbA9Nqm/HYIkL@lists.linux.dev
X-Gm-Message-State: AOJu0YxEDuhB7b9ntvUr3bNPr5EUlxYRziABdwpXdwW7mdT3cMPRHqsQ
	lCNV/5EJKboZdb+5Yf88WwkGvnOmtTBOeb/CgQIcyglaTjFnknDnRgE17ddx/JsKpCmbJ9DucE+
	gfiWAhu3A8szI40cmUxCP8PjnTh26hWJvPjGhoPpY/Un7tjZbAeqW6T8ZsOOMSTHNhTiw7m9Keh
	dwHuoGn2hxIXt/XjTGtfhNeQ+5DQ==
X-Gm-Gg: ASbGncvneeWG0JMzwkEkcWYUcKeTSmsZh7/V1nfb3WJqBVjFzkPl4JXLFLGx0db7qil
	hbtvl1KD+nb6lAypR7TN3eK+iwo5HvGWPClnp
X-Received: by 2002:a17:902:e548:b0:216:30f9:93d4 with SMTP id d9443c01a7336-21a83f3706amr390736925ad.8.1736948115362;
        Wed, 15 Jan 2025 05:35:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE4uFvmvU7kjxrhOu/tKhko5zsquSsHGxstfr2wyI0IDTeSXaYwdT9BokTtob0w3UYMJQDUxkbCE6bgd9fA2Go=
X-Received: by 2002:a17:902:e548:b0:216:30f9:93d4 with SMTP id
 d9443c01a7336-21a83f3706amr390736605ad.8.1736948115070; Wed, 15 Jan 2025
 05:35:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250115094702.504610-1-hch@lst.de> <20250115094702.504610-9-hch@lst.de>
In-Reply-To: <20250115094702.504610-9-hch@lst.de>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Wed, 15 Jan 2025 14:35:03 +0100
X-Gm-Features: AbW1kvauTrK99eaFRcWITgoY8moGa8lcIr8CyUarTCKymnr2mM79lYdYrNNq1Dk
Message-ID: <CAHc6FU58eBO0i8er5+gK--eAMVHULCzHPnJ9H5oN12fr=AAnbg@mail.gmail.com>
Subject: Re: [PATCH 8/8] gfs2: use lockref_init for qd_lockref
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, gfs2@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0nFHBvwOoodAzNpclOhn4xlzg1vHvcCyukJiJLCDICA_1736948115
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2025 at 10:56=E2=80=AFAM Christoph Hellwig <hch@lst.de> wro=
te:
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/gfs2/quota.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
> index 72b48f6f5561..58bc5013ca49 100644
> --- a/fs/gfs2/quota.c
> +++ b/fs/gfs2/quota.c
> @@ -236,8 +236,7 @@ static struct gfs2_quota_data *qd_alloc(unsigned hash=
, struct gfs2_sbd *sdp, str
>                 return NULL;
>
>         qd->qd_sbd =3D sdp;
> -       qd->qd_lockref.count =3D 0;
> -       spin_lock_init(&qd->qd_lockref.lock);
> +       lockref_init(&qd->qd_lockref, 0);

Hmm, initializing count to 0 seems to be the odd case and it's fairly
simple to change gfs2 to work with an initial value of 1. I wonder if
lockref_init() should really have a count argument.

>         qd->qd_id =3D qid;
>         qd->qd_slot =3D -1;
>         INIT_LIST_HEAD(&qd->qd_lru);
> --
> 2.45.2

Thanks,
Andreas

