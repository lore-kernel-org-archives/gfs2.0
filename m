Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52733FBF4
	for <gfs2@lists.linux.dev>; Fri,  3 Nov 2023 16:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VFvnUOE5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699028088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u+f5GLGbXha+Kg5EMNgWhWd4/votIEpuH4V0O0du/gQ=;
	b=VFvnUOE51N6oAfy+BOXpG6nYORQuH5DCPk/foOumES/GY4LlAZWVb0BpEkbHCvqpnudch6
	3GeCMsvP7U0usGaJk06eu5issv33/iLJX1ZX5yHl1sBZ7zUOvalUJEyj/Q8Dr9Xl+7Mm2Z
	uUrj5L6ygr5hdknANA4MwxObgqHYdbk=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-v8me0tliNz-oF1Kkn_AYTQ-1; Fri, 03 Nov 2023 12:14:46 -0400
X-MC-Unique: v8me0tliNz-oF1Kkn_AYTQ-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-54132059c6aso1853510a12.1
        for <gfs2@lists.linux.dev>; Fri, 03 Nov 2023 09:14:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699028085; x=1699632885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u+f5GLGbXha+Kg5EMNgWhWd4/votIEpuH4V0O0du/gQ=;
        b=QsrsdfP79P9hFtfeL+WMvOrKLxHYH1LJSzKghaCkFkpWJB4GKRRrKnptgA6en042eM
         cQwgk9I5kwZmzeyuIFlEEw4j23no7u2KITcBIgR5fuoUSA0bLv0csXKU6TPsgzkxrizL
         i6IyRG3s48+VLUrEifC9OA5QgRIF3laMX/OoIzB1+3AMukCOf9K6oyJvWgCVEGEpDuu+
         noauTw7tWQxJ3/mCtTX+sYcmyQN4byxIxcZgryzTah5a6aVkcciUZVf1X0us2LSn7bR5
         BxOCvoTR3DSyeJYWswR8hatqRth+i8+1HSiYsuwTqrRvfhcEfjz6N9bEynoL0y1DBPqC
         5TWA==
X-Gm-Message-State: AOJu0YysrsRzkRGoHZWYQKktEiAUSeC1KrBnunOcB0ywxas++p8AG1fO
	Hk+59XNkGA1cWET1l40kGmq+/R7mfkwzFzDmbw8xAqhvj6FGP2SgRQrWWi/tG1IXYQ3pIXV0wNT
	H7UuY6hlcy8mxiEDThrn71yEJwbph4g==
X-Received: by 2002:a17:907:3e1a:b0:9c5:8a6b:29e with SMTP id hp26-20020a1709073e1a00b009c58a6b029emr8981148ejc.13.1699028085542;
        Fri, 03 Nov 2023 09:14:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFm8X9tCy8oU/ZCtM04kcVKdFcTmaQ9tyffbCN+Om1jeCg9AhisBOLUhPVrxGrWVeLj5t+wBqlkIMITG2TE/T8=
X-Received: by 2002:a17:907:3e1a:b0:9c5:8a6b:29e with SMTP id
 hp26-20020a1709073e1a00b009c58a6b029emr8981125ejc.13.1699028085173; Fri, 03
 Nov 2023 09:14:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231103160651.1902460-1-aahringo@redhat.com>
In-Reply-To: <20231103160651.1902460-1-aahringo@redhat.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Fri, 3 Nov 2023 12:14:33 -0400
Message-ID: <CAK-6q+ivcgxLiYmU7NBLCuiq1HC4RO61yqf_DZDR290sLDbqtw@mail.gmail.com>
Subject: Re: [RFC 1/2] refcount: introduce generic lockptr funcs
To: will@kernel.org
Cc: gfs2@lists.linux.dev, peterz@infradead.org, boqun.feng@gmail.com, 
	mark.rutland@arm.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Nov 3, 2023 at 12:07=E2=80=AFPM Alexander Aring <aahringo@redhat.co=
m> wrote:
>
> This patch introduce lockptr refcount operations. Currently refcount has
> a lot of refcount_dec_and_lock() functionality for most common used
> locktype. Those functions look mostly all the same and is duplicated
> inside the refcount implementation. Instead of introducing a new whole
> refcount_dec_and_lock() functionality e.g. for rwlock_t and their _bh
> variants this patch will introduce lockptr. A lockptr is just a void *
> and refers to the actual locking instance that can even be an own
> locking type. Over the passed callbacks for lock and unlock operations
> the void *lockptr becomes to the real thing by casting it and do the
> locktype specific lock operation.

just an RFC to check if there is any interest to introduce something
like this. I think the idea is clear. My current use case is to have
rwlock_t and its bh lock operations using something like
refcount_dec_and_write_lock_bh() and later kref_put_write_lock_bh(). I
try to avoid copying some copy code again. I am open to any better
design change. Or telling me to just duplicate code again for what I
need it for. However this has the advantage that somebody can use
their "own" locktype implementation out of kernel core code.

Thanks.

- Alex

