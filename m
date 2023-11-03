Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217B01C69B
	for <gfs2@lists.linux.dev>; Fri,  3 Nov 2023 16:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EAqcNNnI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699028176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7QQeJpr2zjvbNqxX2bA7c6FOgbcuy6KNgv8XsJ+YCUk=;
	b=EAqcNNnIEURV4Jq5vSKxruA4QvZUmhmTMHbo7oW7mlAaqvNhrRvCJZY3N86F4TAWTx5Dkm
	Pts6RIGUzjz3wqlNnzMzPFb3wExjf+zXDBMTMURUPvneLpDMndTqTDwRHL4jokTG3Sp9oW
	ufC9/SvNtHOM1osp6tuTKMy3WO8vjGQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-5-WEzTpsPaCJgZWWeW090A-1; Fri, 03 Nov 2023 12:16:13 -0400
X-MC-Unique: 5-WEzTpsPaCJgZWWeW090A-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9bea60bd1adso372523066b.0
        for <gfs2@lists.linux.dev>; Fri, 03 Nov 2023 09:16:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699028172; x=1699632972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7QQeJpr2zjvbNqxX2bA7c6FOgbcuy6KNgv8XsJ+YCUk=;
        b=KlG0/irBuiOXHasY1VFNNodV6nzwOfutMahhEh5PoxIdbDwY4ITRKiADeVHj+Ujztt
         1MvGCy9sD8LTPB1Ii28PONO2WgEjyXpgmNlvKu8zrQYptmfrK4xpO1W1e+Ajs9NWmWFZ
         ua+/hQ4UmEePvUNP/zHNoi16SOZxm4DGLn1ozfuBZEqDRF0h+pBLJNLJMTakCWj4DDpL
         eEWPXymHJMUj1E227ntnrbYjxweE+hPCiqUFwBO+fMA9/GTfHeBeOHlKgGJYkfux0U0e
         5ioue+WQczxS5IWIWz+kQZIxQjGp1zwstHo0jAx3t41+Wih/GSvc7VoM4OO+uZ7VfBTW
         uwTQ==
X-Gm-Message-State: AOJu0YyyWOAx5TVKZJh25s7FRQ0vtpe7b0WeQyKsL50hL0/FnLHSDV56
	ZFI0FeLGmo3Gu6fX6NHjij909xXje6iMlzfPqjqpQvCZOcrcdMwmzk7aSL9WFK4nYKQiAjDBy6h
	c9gr6+rqz0TRFC7rJt3+5DGNRly91dQ==
X-Received: by 2002:a17:906:7c93:b0:9c7:59ff:b7fd with SMTP id w19-20020a1709067c9300b009c759ffb7fdmr2714623ejo.28.1699028172348;
        Fri, 03 Nov 2023 09:16:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECppYMeETjQko/O1s+sAmhIaK4D3KzpBZaDcLCFTLHAONeGodSDFHu6dtfJxTXq36FgeguPO6FY+Q6Con4qkk=
X-Received: by 2002:a17:906:7c93:b0:9c7:59ff:b7fd with SMTP id
 w19-20020a1709067c9300b009c759ffb7fdmr2714607ejo.28.1699028172076; Fri, 03
 Nov 2023 09:16:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231103160651.1902460-1-aahringo@redhat.com> <CAK-6q+ivcgxLiYmU7NBLCuiq1HC4RO61yqf_DZDR290sLDbqtw@mail.gmail.com>
In-Reply-To: <CAK-6q+ivcgxLiYmU7NBLCuiq1HC4RO61yqf_DZDR290sLDbqtw@mail.gmail.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Fri, 3 Nov 2023 12:16:01 -0400
Message-ID: <CAK-6q+jyGH4Mc2BtzWKOFRjdxwGz35E_JvM6Q4iZD4T4pHxbUw@mail.gmail.com>
Subject: Re: [RFC 1/2] refcount: introduce generic lockptr funcs
To: will@kernel.org
Cc: gfs2@lists.linux.dev, peterz@infradead.org, boqun.feng@gmail.com, 
	mark.rutland@arm.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Nov 3, 2023 at 12:14=E2=80=AFPM Alexander Aring <aahringo@redhat.co=
m> wrote:
>
> Hi,
>
> On Fri, Nov 3, 2023 at 12:07=E2=80=AFPM Alexander Aring <aahringo@redhat.=
com> wrote:
> >
> > This patch introduce lockptr refcount operations. Currently refcount ha=
s
> > a lot of refcount_dec_and_lock() functionality for most common used
> > locktype. Those functions look mostly all the same and is duplicated
> > inside the refcount implementation. Instead of introducing a new whole
> > refcount_dec_and_lock() functionality e.g. for rwlock_t and their _bh
> > variants this patch will introduce lockptr. A lockptr is just a void *
> > and refers to the actual locking instance that can even be an own
> > locking type. Over the passed callbacks for lock and unlock operations
> > the void *lockptr becomes to the real thing by casting it and do the
> > locktype specific lock operation.
>
> just an RFC to check if there is any interest to introduce something
> like this. I think the idea is clear. My current use case is to have
> rwlock_t and its bh lock operations using something like
> refcount_dec_and_write_lock_bh() and later kref_put_write_lock_bh(). I
> try to avoid copying some copy code again. I am open to any better
> design change. Or telling me to just duplicate code again for what I
> need it for. However this has the advantage that somebody can use
> their "own" locktype implementation out of kernel core code.

I will resubmit this RFC series because I forgot to cc the linux
kernel mailing list that indeed makes sense here.

- Alex

