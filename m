Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E7D361
	for <gfs2@lists.linux.dev>; Wed,  8 Nov 2023 00:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TKalxMOt"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-543456dbd7bso454190a12.1
        for <gfs2@lists.linux.dev>; Tue, 07 Nov 2023 16:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1699401878; x=1700006678; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M1gFsj3ZQRKq2XSC6mkK8HfxUGZGy5exG2oL8DwFzoo=;
        b=TKalxMOtHKDFBXyLvTcm4JYD9/FGbrR/ULsCFljznZ+3IrLRn6i0b8XuqhdOUfm8tp
         OQlTMf6w627TvyKhfRt0WhU8+9rJ1IXAjvTiJyyzJlGI6+QCI2m/+dKT415wI4cnl1tA
         Xa7X7oMYzrsbpg8O34bgPf1rWv1327HG2ZuTo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699401878; x=1700006678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M1gFsj3ZQRKq2XSC6mkK8HfxUGZGy5exG2oL8DwFzoo=;
        b=VAY9QWREaX5AbhATwMxplN+aiMY2fj0YCmc+FZcwguSlrop5Wj+g+byVk2493B5zrB
         b8Mh6Dlyv4mNhx/xSWSE13lD9KBDMATgZ+cu/wQtPmMuwYZ/aQCIrkfLWctsr20ccQB/
         p0v38nNsUI2WT2oN4G1cgxAqIJJOMR2qsz5nBRKR1WPW86ikq5eiILF04ys6nErE5VGK
         Y7btJz7aP5PiPhaTV0UDdqJTLICkr/uGGVjzUgIhd6ZA6R7GS3I29cBSGkIXeBqKuUdv
         pfDgQDFLIFcWVIiunF6z7x4I9KO5/0SXwzF2QzwAzrbep4I3t65+LY3Bjl+cRKpI9f2a
         EQLA==
X-Gm-Message-State: AOJu0Yx7fo0qLeUg8WrLf4jObTktGcVKInWhXs9RBlW5nI2M1FQOGNQc
	sk8NSCMAQ6oGbiU37RlKiJNwOFw4qLHiXJlQmwBRjg==
X-Google-Smtp-Source: AGHT+IEEOC1BpXyWmxuJ9F4E/oh8DbSDIIEtbbIOyV64U8KtKLwmTPuu5sPvrNrk8J4QMuOnElVhLA==
X-Received: by 2002:a50:d74e:0:b0:542:fe59:2234 with SMTP id i14-20020a50d74e000000b00542fe592234mr337503edj.6.1699401878515;
        Tue, 07 Nov 2023 16:04:38 -0800 (PST)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id j28-20020a508a9c000000b0053e3839fc79sm6094405edj.96.2023.11.07.16.04.37
        for <gfs2@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Nov 2023 16:04:38 -0800 (PST)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-9c3aec5f326so45972466b.1
        for <gfs2@lists.linux.dev>; Tue, 07 Nov 2023 16:04:37 -0800 (PST)
X-Received: by 2002:a17:907:7784:b0:9bd:81c3:2a85 with SMTP id
 ky4-20020a170907778400b009bd81c32a85mr3252018ejc.32.1699401877597; Tue, 07
 Nov 2023 16:04:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231107142154.613991-1-agruenba@redhat.com> <CAHk-=wie7WsYHkEChV0hpcf7CRRJQw9-E8O8RxrFGKF6mEJ73g@mail.gmail.com>
 <CAHpGcM+u=77p_k8dZ6gKu84wnkdvGYA4E6=MXqNw=ZY+ejjiaw@mail.gmail.com>
In-Reply-To: <CAHpGcM+u=77p_k8dZ6gKu84wnkdvGYA4E6=MXqNw=ZY+ejjiaw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 7 Nov 2023 16:04:19 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiN4e_C+tONr6p+f51ae8QoXB8tvoN8zQFdyiRi1DzO1A@mail.gmail.com>
Message-ID: <CAHk-=wiN4e_C+tONr6p+f51ae8QoXB8tvoN8zQFdyiRi1DzO1A@mail.gmail.com>
Subject: Re: [GIT PULL] gfs2 fixes
To: =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Cc: Andreas Gruenbacher <agruenba@redhat.com>, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 7 Nov 2023 at 14:18, Andreas Gr=C3=BCnbacher
<andreas.gruenbacher@gmail.com> wrote:
>
> I apologize for referring to the entire set of commits as fixes when
> it's really fixes and various other things. I've said so in the tag
> description, but I realize now that that's not good enough. Lying
> about what those commits are wasn't my intention though.

.. and hey, sorry about my outburst.

Your pull request was the first one this merge window where I reacted
to how many of the commits weren't in my copy of the linux-next tree,
and there wasn't any reason why in the description. So I reacted very
strongly.

It didn't help that I had a headache. Rather than look at how many
other of the pending pull requests I have that ended up coming in in
the last 24 hours have the same issue, I decided to lie down in a dark
room for a few hours.

                  Linus
