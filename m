Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF10E28DA4
	for <gfs2@lists.linux.dev>; Wed,  6 Dec 2023 10:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N69V8jp8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701857853;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8W9H8eFcQ50zSqzObuWRnLLXlGzFyDXsARs6CIgSL84=;
	b=N69V8jp8MScR0lNvpNCxCm8nSDHV8UaSJ8tQIfMEcIk9zFF45KEDu64TSlJxZZKz/XqatY
	3qTM7E+5mc+SbeOeehiRE9SYc32ejpfkMH4ZBDY4c3giI8QqMDUVu3tW21wfNVp6g+dtTd
	25Ele4lFYX4fF45N/utlRIWQgGgg0pU=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-92-oZfhfVabMvqN7UCua7DB0A-1; Wed, 06 Dec 2023 05:17:31 -0500
X-MC-Unique: oZfhfVabMvqN7UCua7DB0A-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1d08555b0ffso20543555ad.1
        for <gfs2@lists.linux.dev>; Wed, 06 Dec 2023 02:17:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701857851; x=1702462651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8W9H8eFcQ50zSqzObuWRnLLXlGzFyDXsARs6CIgSL84=;
        b=gbXX8LPwwg8j3NznjsVUaL9Yq7YjYQKBOKA8TYt9BGd2UgOF2TeNjq4J8X09LV2yVH
         gC4GUdbNr4fJKWiJsfU+ATihoPCU5ewz9EBzGd0pF3TJguEfKbY+4viJPbMSCfKuRqEe
         dVuX5gXvInxV0Mn4n0LUjWakBZWGkFN4FuFuldaruqEJuDhMr+xL4AleEGHl1FcRj7q+
         K3T8OBPNlXqmx+Cj0K9dAhz1YJydQTZ8GsAZQ9iFohOyMPbPT4dW+Rw7YPKED1I2vUqO
         yTswyvqGjgWuxQMtnZeEd0A5hDYZnmDTS7gObvDd/u7ciuzaoh4/JBxplS36E9YFiwHw
         +/XQ==
X-Gm-Message-State: AOJu0YwBz9d9dvFlEwaT8t6IhK1vXBRlObo99kQhxdb2gl807jBh1Jjl
	6xvuqv4I+uk2p0+pVTkLtjCWjGW/FBPqMmUYs8c8uusOzz/UaHzRItXeQ2XPAAMHmbpwE7J21Sw
	t8FrQfh3KRV+KwVMW+1ozBeHGrpzEzw==
X-Received: by 2002:a17:902:aa03:b0:1d1:d009:8093 with SMTP id be3-20020a170902aa0300b001d1d0098093mr269291plb.28.1701857850874;
        Wed, 06 Dec 2023 02:17:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFCqI9x33oYIlyTwWmTyW54JXi0mygGAUa53c7PG525Q5UjnxuJ8dR4nrzFwWvIIg3ahN1V/qUpa9D53OeK6a8=
X-Received: by 2002:a17:902:aa03:b0:1d1:d009:8093 with SMTP id
 be3-20020a170902aa0300b001d1d0098093mr269285plb.28.1701857850531; Wed, 06 Dec
 2023 02:17:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231206023636.30460-1-rdunlap@infradead.org>
In-Reply-To: <20231206023636.30460-1-rdunlap@infradead.org>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Wed, 6 Dec 2023 11:17:18 +0100
Message-ID: <CAHc6FU5joEytPYKZ0KMgtQm4r_qqJh2mO1s_YH8cKRWTjyEiHQ@mail.gmail.com>
Subject: Re: [PATCH] gfs2: rgrp: fix kernel-doc warnings
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Randy,

thanks, I've pushed this to for-next.

On Wed, Dec 6, 2023 at 3:46=E2=80=AFAM Randy Dunlap <rdunlap@infradead.org>=
 wrote:
> Fix kernel-doc warnings found when using "W=3D1".
>
> rgrp.c:162: warning: missing initial short description on line:
>  * gfs2_bit_search
> rgrp.c:1200: warning: Function parameter or member 'gl' not described in =
'gfs2_rgrp_go_instantiate'
> rgrp.c:1200: warning: Excess function parameter 'gh' description in 'gfs2=
_rgrp_go_instantiate'
> rgrp.c:1970: warning: missing initial short description on line:
>  * gfs2_rgrp_used_recently
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Andreas Gruenbacher <agruenba@redhat.com>
> Cc: gfs2@lists.linux.dev
> ---
>  fs/gfs2/rgrp.c |   10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff -- a/fs/gfs2/rgrp.c b/fs/gfs2/rgrp.c
> --- a/fs/gfs2/rgrp.c
> +++ b/fs/gfs2/rgrp.c
> @@ -159,13 +159,13 @@ static inline u8 gfs2_testbit(const stru
>  }
>
>  /**
> - * gfs2_bit_search
> + * gfs2_bit_search - search bitmap for a state
>   * @ptr: Pointer to bitmap data
>   * @mask: Mask to use (normally 0x55555.... but adjusted for search star=
t)
>   * @state: The state we are searching for
>   *
> - * We xor the bitmap data with a patter which is the bitwise opposite
> - * of what we are looking for, this gives rise to a pattern of ones
> + * We xor the bitmap data with a pattern which is the bitwise opposite
> + * of what we are looking for. This gives rise to a pattern of ones
>   * wherever there is a match. Since we have two bits per entry, we
>   * take this pattern, shift it down by one place and then and it with
>   * the original. All the even bit positions (0,2,4, etc) then represent
> @@ -1188,7 +1188,7 @@ static void rgrp_set_bitmap_flags(struct
>
>  /**
>   * gfs2_rgrp_go_instantiate - Read in a RG's header and bitmaps
> - * @gh: the glock holder representing the rgrpd to read in
> + * @gl: the glock holder representing the rgrpd to read in

So it's a glock, not a glock holder. I've fixed up the description.

>   *
>   * Read in all of a Resource Group's header and bitmap blocks.
>   * Caller must eventually call gfs2_rgrp_brelse() to free the bitmaps.
> @@ -1967,7 +1967,7 @@ static bool gfs2_rgrp_congested(const st
>  }
>
>  /**
> - * gfs2_rgrp_used_recently
> + * gfs2_rgrp_used_recently - test if an rgrp has been used recently
>   * @rs: The block reservation with the rgrp to test
>   * @msecs: The time limit in milliseconds
>   *
>

Thanks,
Andreas

