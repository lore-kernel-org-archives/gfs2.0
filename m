Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFFC32E690
	for <gfs2@lists.linux.dev>; Tue,  3 Feb 2026 12:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770122500; cv=none; b=Nzss4XF9Inutfe15kKR/dQj5FUAJYnuJn2dfm9lu8HyqRLMfRx0IKdwtD/DJJST+55AGehHVoEVupU1Wl87oz56fXYc5mZOQ/plhn8rbWsgvrDikrV/aN/W71qM3/79qXz2WbhGcfUS26AAPYtRcRLzwHHiSnoi5gnEK6EtmfLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770122500; c=relaxed/simple;
	bh=ZeGnsBmUiDIXbw9RtdTObgm5DkhMyd51F+BuBss2Y00=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nlxwseutRogQmrOkBd+I5JKFPTTd/0J8m7ZQH0rnLXGxQev8HSrx6sD6Sz+vAgq5lw4k/va6FN3E5/HNYeY6bOla7KZgm0AfboTmH6vL4nCh9F+/Q56P4m6EPvV0Yw9o7HJlD3ZLggxWOeEWQH/h6P0wMRpYe7iEhlu1DP9LY/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A3c8m4aU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A3c8m4aU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770122497;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZeGnsBmUiDIXbw9RtdTObgm5DkhMyd51F+BuBss2Y00=;
	b=A3c8m4aUGpk7WF6VQNTUsc1UVyOomTAQNS9mzdauYtcywWGb98yZ50gdZK0AU+2zn+WC92
	kui4+sXqaKLvuIlS8UJ4dts+Q7reyORAx427z585z75ov6AuTnvLxS8QW4bIymOXgYZZN2
	y7yvxKBECC5P5zx9/IgSfyvDLfsWUbQ=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-SmB6HywXNOOH_t907w8l_A-1; Tue, 03 Feb 2026 07:41:36 -0500
X-MC-Unique: SmB6HywXNOOH_t907w8l_A-1
X-Mimecast-MFC-AGG-ID: SmB6HywXNOOH_t907w8l_A_1770122496
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-644548b1d9aso7956469d50.1
        for <gfs2@lists.linux.dev>; Tue, 03 Feb 2026 04:41:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770122496; x=1770727296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZeGnsBmUiDIXbw9RtdTObgm5DkhMyd51F+BuBss2Y00=;
        b=a5hifVnVvWbYc13+2ZwY01e8DyIT1q+tRsKbpfSF1JwRYjO4DQ02VJjHw99j2J2UPD
         mQIRtCg8RXMTBxn6tCX0HBInQPoC7gzt5+xhgRHYtrQPA8mRxjKHW09ZLchlvDxkwemP
         Dylb4bLZHByD5rBIZG0JXbU38tacSmUe8Pi+Hde6H6CHdF8TNDH76p20SfnUM1eBI9Qo
         bkw5UNmz8g5Q68pfiRSwi6c9pcDoe77OR6EKCbDyT/WKsGrgknrxiWwC8Is/Klj/entv
         QI7rANpMGRtz1jZim6djqjrfYuybxaHQ40xYm1s817VPcmzwtx5yN50Q8oVYVwLxXBYz
         wQBA==
X-Gm-Message-State: AOJu0Yxz0WeHqkaLe3iA4ABWmdLFYLy18Xt+EOX2NB5vIUXqCSUT2TuY
	Axekt7W6EOXzKj6n0hbJOiqMBoW4+lGdwy+dXGz3Mo0EVE7CjY7dw6jutcXO5TU3/44tm+qvyLG
	PQBLFeMEjjx8T8qcRwLYI8ghrICeO0lKagOBcXWCyN0twM9tZcziEkRefM315UNeKsJreJjqyZs
	JbnFdJamrF6egUXAjp6x3oXHIgqwePng==
X-Gm-Gg: AZuq6aLaj5j3NsMxasPHXwhlFxw/7/a2O/VOMI4gWT+uYAllTQYw8/T6ovI3+TSzFEe
	GIFwxnS6rAKHtIvhzhPbmk3jxICkaqkh3B7MCke/Hs5kL9HEyA32OOt38dSMEcOABCiVMwI4O5a
	wZxT6P1Lt0p31IjiWrMnoy//a3KORImJSA8Ip89BFqXepizr0vIGdQpvAQqTVw8lqm8S3HABkZX
	JRrxOm60Jpm7sFhVEUF4xtHrrmiWJNxpQfG/eM5Tg2hl124cvkUBg==
X-Received: by 2002:a05:690c:39b:b0:793:ac88:2a49 with SMTP id 00721157ae682-7949e060e19mr267118287b3.49.1770122495229;
        Tue, 03 Feb 2026 04:41:35 -0800 (PST)
X-Received: by 2002:a05:690c:39b:b0:793:ac88:2a49 with SMTP id
 00721157ae682-7949e060e19mr267117347b3.49.1770122493857; Tue, 03 Feb 2026
 04:41:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAHc6FU7kH3VfyERRTFuCshiSq0c-ttJLG7OeX_j31K9ehvH7uQ@mail.gmail.com>
 <20260203114257.25469-1-trintaeoitogc@gmail.com>
In-Reply-To: <20260203114257.25469-1-trintaeoitogc@gmail.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Tue, 3 Feb 2026 13:41:22 +0100
X-Gm-Features: AZwV_QjPvlqH1tT-M1NEMjGRtdJIVVATcqiDOL_BtUyYuD_jOgPMOAt0Kj1r7gI
Message-ID: <CAHc6FU5eRLt5X7T1BTK2jCuzKc8PHk7wy0UMCVyfBnerSUF7_Q@mail.gmail.com>
Subject: Re: [RESEND PATCH] gfs2: do not evict glocks with populated address spaces
To: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
Cc: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yLkSdAxHkkTnKcpyTyam8t1sa1iksU_Fm_OMQW-kSiA_1770122496
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 3, 2026 at 12:43=E2=80=AFPM Guilherme Giacomo Simoes
<trintaeoitogc@gmail.com> wrote:
> Andreas Gruenbacher <agruenba@redhat.com> wrote:
> > > Metadata glocks may have associated address spaces used as caches. Av=
oid
> > > reclaiming such glocks under memory pressure while their mappings are
> > > still populated or their state is not unlocked, as this can lead to
> > > invalid page cache state and GLOCK_BUG_ON().
> >
> > What invalid page cache state and GLOCK_BUG_ON() errors is this about, =
exactly?
>
> On __gfs2_glock_put() (fs/gfs2/glock.c) the GLOCK_BUG_ON() is triggered u=
nder
> memory pressure while the glock is still locked or the glock is populated=
 with
> metadata caches.

There are two GLOCK_BUG_ON() assertions in __gfs2_glock_put(). I
assume you are talking about this one:

GLOCK_BUG_ON(gl, !list_empty(&gl->gl_holders));

This should never trigger because each holder has a glock reference
(see the gfs2_glock_hold() in __gfs2_holder_init()), and so
gl->gl_lockref should never reach zero while there are holders.

If none of the holders has the HIF_HOLDER flag set, we don't know if
the glock is actually locked.

> This happens because the __gfs2_glock_put() can't truncate pages with a p=
rivate
> datas (truncate_inode_pages_final(mapping) is failed), how the metadata i=
s a
> private folio, the GLOCK_BUG_ON(gl, !mapping_empty(mapping)) is trigged.

What are the actual messages you are getting?

> > This leaks a glock reference, so it's definitely wrong.
>
> But this glock is a private folio with metadata or is still locked. I thi=
nk
> this can't be evictable

What even makes you think these glocks are evictable?

Thanks,
Andreas

