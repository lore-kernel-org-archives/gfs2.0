Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE19250E2
	for <gfs2@lists.linux.dev>; Wed, 17 Jan 2024 21:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705525365; cv=none; b=okTeKfqBhau0ZXb8hJfhkXrEpq+pV/ZvR/OBLW/zCez8bF+OzqiVhH2gVK2xhHFkgIBhh0ivpcjXKzZhlZ2/JUF8dZZOiPRyGvGohniFPOYhmZpPeSK4lg8UOeoJDWrCTCjwF9sB5zlQgVk/1zu/joWYM/31fZ7AIfPz0yRWpoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705525365; c=relaxed/simple;
	bh=gXC8vhHEypDFAD+2EMd1iJlmoDPhd9SxDcDQbBVes5k=;
	h=DKIM-Signature:Received:X-MC-Unique:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Received:
	 X-Google-Smtp-Source:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 X-Mimecast-Spam-Score:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding; b=OhoNfdXr7GbLYYqGR3OV7sZxABFJtO1DNtE+zLUPkgTo17kNz5k2tGHA2dPeVy6GaQ9t0+jzGoaGwzMwQfgHxmP7X+WLGQDyzjCmQhvVlgkVUnWboETvyU3X0pbThG9vnwQ5eHsIw96Mpfxwhk/nQW+q61Ym9N47rPEFEVi1KUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FQG2UYFL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FQG2UYFL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705525363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n+DzpEr/4DH+2H07cTiqH57tznzr6NoeA4/02gf07O8=;
	b=FQG2UYFLTaN482gdo5NY0uSBcKuxfkOztQS3Jj94TgFDRm6RW4pid8RkqBIu6KH7/75Z2N
	OxP1bCHP2eXe0AUY+rD/OkqLUb4rAEP+c78VPeYNlPPNELlgI2MHJJBakTfARCnwmpdS7P
	Q+YK9HOd8I81H49Gke4Bj7JITE5e5qA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-qPxYSml3Ph2JTcinQ2NM0Q-1; Wed, 17 Jan 2024 16:02:41 -0500
X-MC-Unique: qPxYSml3Ph2JTcinQ2NM0Q-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a28f6a78b83so726965866b.1
        for <gfs2@lists.linux.dev>; Wed, 17 Jan 2024 13:02:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705525360; x=1706130160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n+DzpEr/4DH+2H07cTiqH57tznzr6NoeA4/02gf07O8=;
        b=LyHADxF/rQOwGsTmWLDSqw88+I8WmeLhx3erhF4voMyjCBw3x5iyXbHBsXX04Rvw3d
         PKl5OYAEsMJ6YcbSuTtfgXmcnnp2RG17mBq2ELKWXNNKgawgSCO2qw0kDH0QDtB7USp4
         /ctNxqgJtwQTYp7Ha9Uz04MP1ulzyAmFG40gedssL67M8STsFkLrB+DdmgcgamHf6Hv0
         9BPKPDQgQWZ4VnFHXQnV87bbu35jB6EL2kwk+iaX8YQeJUzdb6sFjrCbK8QZ5uKkskgb
         oiQJDCR0PjtgdEISQBRuwq1FWGHxIEjJwdDmAegNyd58cYOdW923ZRBSM9fBdkuVEFnr
         IKEQ==
X-Gm-Message-State: AOJu0YwyFsou6Nlqr+YpL7EIMOri/VD1pbX8nGWza4OdU21NQhVWE30f
	p+7uvDK4R4sUs4aKdhBSDzxTON5L1Zcb76ryZWv78J04arfYhwv/h64KH34dIhuZaf/KmQNEkmm
	U7g5wv7lkfQXcjY3im9hvjrDX8Exr4MbKMy853/jrG+AMdw==
X-Received: by 2002:a17:907:8e9b:b0:a2d:372d:e890 with SMTP id tx27-20020a1709078e9b00b00a2d372de890mr4115816ejc.40.1705525360504;
        Wed, 17 Jan 2024 13:02:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHQz/Dw47Pi+fHfpYSqlqFV3ZetQl5qaxFDQSjRPTH9F2ge0jXKcKubjfhE29n4rUofs5Oy1vj7o9ZZKeaa7ec=
X-Received: by 2002:a17:907:8e9b:b0:a2d:372d:e890 with SMTP id
 tx27-20020a1709078e9b00b00a2d372de890mr4115810ejc.40.1705525360249; Wed, 17
 Jan 2024 13:02:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231119163817.751872-1-aahringo@redhat.com> <20231119163817.751872-14-aahringo@redhat.com>
In-Reply-To: <20231119163817.751872-14-aahringo@redhat.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Wed, 17 Jan 2024 16:02:28 -0500
Message-ID: <CAK-6q+iEwBUzWej8znaEQBePAKA1mT=Ya0DkPCFvPjuLJSOK-A@mail.gmail.com>
Subject: Re: [PATCHv2 dlm/next 13/13] dlm: do dlm message processing in
 softirq context
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Nov 19, 2023 at 11:38=E2=80=AFAM Alexander Aring <aahringo@redhat.c=
om> wrote:
>
> This patch moves the dlm message processing from a ordered workqueue
> context to a ordered softirq context. Later we want to call the user
> defined ast/bast callbacks directly inside the dlm message processing
> context instead of doing an additional context switch to the exisiting
> callback workqueue. This should slightly improve the dlm message parsing
> behaviour. There are two main reasons why to change to this behaviour:
>
> 1. Bringing the ast/callback callback to softirq context that the use is
>    aware it should not block into this context. Later patches will
>    introduce a per lockspace flag to signal that the user is capable to
>    handling these callbacks in softirq context to solve backwards
>    compatibility.
>
> 2. We can easily switch to a per dlm instance concurrent dlm message
>    parsing when DLM is ready to handle it. This instance could be in
>    e.g. per lockspace instance or more fine granulatiry instance such as
>    per lock instance.
>
> Futher patches will unveil more improvements to switch to a per message
> softirq parsing context. Especially if we getting DLM in a state that we
> can allow concurrent message parsing.
>

I forgot to take care about [0], which seems to be a rare case because
I never triggered a sleep while atomic warning.

Nevertheless I need to send a new version when rc1 is out and fix this
because it's called in dlm message processing.

- Alex

[0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/fs/dlm/lock.c?h=3Dv6.7#n2538

