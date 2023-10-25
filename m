Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6552F1CA94
	for <gfs2@lists.linux.dev>; Wed, 25 Oct 2023 12:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RYc5hthB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698237360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vvU+ODlhbBzCksS16LHKl+sMj+DM+WDalvoXiTfFa+g=;
	b=RYc5hthBKMJPZje1BHIm6mXvDJqiA6alVL7l5EySZ7WXEHLTmzHU7pe5pVUtiD/Te1apfv
	aP44ByU0D/YuCflrQRfDC0FAhLDCYPDDHhS+tI3RPkv18lu05n1jLgPHm6HWjm6f30qaLT
	2xddBcud3Jzx5d0BbW2RnzLQaSM0UvE=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-wW72yeCBPUWK2RBP_ffCXg-1; Wed, 25 Oct 2023 08:35:58 -0400
X-MC-Unique: wW72yeCBPUWK2RBP_ffCXg-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1c5ff1ee155so58784845ad.2
        for <gfs2@lists.linux.dev>; Wed, 25 Oct 2023 05:35:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698237358; x=1698842158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vvU+ODlhbBzCksS16LHKl+sMj+DM+WDalvoXiTfFa+g=;
        b=WRQV2KdXfk1QD9wQQlq6okClx1Ut6j3hcRhhVbZvA4iq9bocNjlslbPDe8uPdlf73y
         lIsirtSr5PQGNFzJDQJXQkHsMGzdXm+fjufCKUa3IzAzKX+yMaqvRPh0so9jK1v9bV0+
         +jQjiVPzDjFHzIkUHSaQjMG7WZN1ftT4NYp+tKVzSwws5uz4syuJaSrhWWLOnpRsvRA6
         tOItrhIfHCwhqC8+Z4jIf7Lq1N8/FPRorgQCFNCW5fCxn+JYm5BCgG3pQxWFFk/K9pbt
         Ci0SN5aq9lIVqh6MXCuPzLCulgewWW69UTwEskCQFDb7cXadSNJ8y1660OHgZWka5csF
         KhLw==
X-Gm-Message-State: AOJu0YznzJR7HYFi9SWrTqd3Kef+rHhStrsl8GSBmPcW5eG1xA0lIFxq
	A05QXdvA2y/rLv2Fi6uRnFSm65YRQFVBEw9zu0bntH0biFfEm6sitU3x3p4/1xeUKL9uWZ2RL6Q
	cmyqFQyDUzcqN9kjA9d7oPRKIHvDlfA==
X-Received: by 2002:a17:902:e841:b0:1b6:6f12:502e with SMTP id t1-20020a170902e84100b001b66f12502emr17465923plg.49.1698237357773;
        Wed, 25 Oct 2023 05:35:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/lVpfMUNBBfWqBo8bfvljBYSBCHKzm8BaAaoys67eChIuLm8w5Asc6ul+K1gzocSNYltZL1dL0BrIqtcbXRQ=
X-Received: by 2002:a17:902:e841:b0:1b6:6f12:502e with SMTP id
 t1-20020a170902e84100b001b66f12502emr17465908plg.49.1698237357450; Wed, 25
 Oct 2023 05:35:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <0b9cb1ea-4656-4802-b7a7-811c1e9e118a@moroto.mountain>
In-Reply-To: <0b9cb1ea-4656-4802-b7a7-811c1e9e118a@moroto.mountain>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Wed, 25 Oct 2023 14:35:45 +0200
Message-ID: <CAHc6FU646Jj3iODoHoAYpps2PL732Feb_w+5p=8GfUOMfYTHhw@mail.gmail.com>
Subject: Re: [PATCH] gfs2: uninitialized variable in __gfs2_iomap_get()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Bob Peterson <rpeterso@redhat.com>, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dan,

On Wed, Oct 25, 2023 at 1:57=E2=80=AFPM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
> The "ret" variable is uninitialized when we goto out because
> gfs2_is_stuffed(ip).
>
> Fixes: 2cd225820b91 ("gfs2: Initialize metapaths outside of __gfs2_iomap_=
get")

thanks for catching this. I've fixed that patch directly.

Andreas

