Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700DD14D43D
	for <gfs2@lists.linux.dev>; Thu, 11 Apr 2024 13:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712843919; cv=none; b=ZEAw/B9jTYKTVJhG4iY6AqiIoUhqWbKrHfQCo3Vs59Hc2Zf9WNPc2K5jbZbuUmqt9apsYC6Jiu7QTw+u4bs90OEBWvXnJTPGE9pbdvVjvPjwJRD8ymcuBxF3AOo4ETN4PDnLFihrzGAr3xM5kRfxq2OAk7bcuSIa63/MfKl/sZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712843919; c=relaxed/simple;
	bh=E7FR86SV5jKgR77a06BgPcCOZK5ZZ0k5rX64dOQoVpc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MfN3dkYzIakrgJLtiW8SiiEtgZkxnKcWL3umOxpxG6Ci8asvN0436y8sYmBSOzkuPEPTugDuhTQbDvKofuorr4rKBySlvL9WmaBXlHwLMngYWeOSzwjyB26Q/CegS28OZMIfg3h9XOXB/FejhI/ZxmCk6JTRyjuEt791EoU45Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ba3M0N2D; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ba3M0N2D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712843917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C5cU4RIbW8D5PBQZwH8C60lZ07auoc69/mw0kAF3dWI=;
	b=Ba3M0N2Dd7Pcj0S7sLREk26jHRdwrJlUckISgGEgEnUTLo92JFVcN2EBnNjI+LRJ5Xy0gL
	kpRM+pSGmriacpp4HZM6qyMdGdyhhkNeVoKpjAjH871xMZQWcp6WY+kklKP91bBPB7pDAz
	8uE5rem6WV7GW1UlFAEBhwYeI3zqhr8=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-RdvehAocNI2A6OD_gZphfw-1; Thu, 11 Apr 2024 09:58:35 -0400
X-MC-Unique: RdvehAocNI2A6OD_gZphfw-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2d45c064742so83437461fa.3
        for <gfs2@lists.linux.dev>; Thu, 11 Apr 2024 06:58:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712843914; x=1713448714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C5cU4RIbW8D5PBQZwH8C60lZ07auoc69/mw0kAF3dWI=;
        b=BflywyVFx9mZ4GulsvMuR8Tx2JlrimPgu4JTv7UWpA4AOdq1/1R/db431c0bQUz54M
         I+JGEdT4fOizT53LdWqz2aHg9tio63n7W90F4nyCtTFCdOF6t57pnTdNY7lzsDZsANDs
         ZkK9YPekPQ2Ljxzytq+e6KhGSE1oe9DSN+4nF+OatGD0kB28o6svwKfj8oH9g6/i+fY7
         tJREmiyBkgM+7JPNXMeJbG74Zguahxl5bFIIdGqudC/TxyEPzUzZbZEWAnUtumhjjW7a
         EWnTrmUvuT4FYQ8xZ+shludjX7NJsrZEDL+QSjxJCaDYRIhFrQGHjNE62c3FKAJFNbEg
         CeOQ==
X-Gm-Message-State: AOJu0YwKXEwLr+VwHOJFm8569dZ+0sGERqq9t7WCi//UDjLTTs+cq5Dr
	6utVowy0Ttl0Xga7oMewfrJ2AazE0s0lbiMfnMSapI980t8fCtlUQCRho5ab+BIk6LVmDU4z/go
	eyok9bcvKEoUPdBGU4mL0fBSjchf70MMf5fHwwuPxzBA3HsNYr2Ri1FKWcTvoeYnnKxKNvKeFHu
	3HHpL0OWVYdTxEI6Il/3oCvfjVhWRK4Qm/rA==
X-Received: by 2002:a2e:9c09:0:b0:2d6:c5cd:144a with SMTP id s9-20020a2e9c09000000b002d6c5cd144amr3631503lji.16.1712843914078;
        Thu, 11 Apr 2024 06:58:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1dksZIJBuoimk7uD9bh6uNvwLcmT/lG5LuPGxJ2G78EDNhcGxbhJdi+ZPTnSVnL59NLHCO+q6x2T2KP382Fc=
X-Received: by 2002:a2e:9c09:0:b0:2d6:c5cd:144a with SMTP id
 s9-20020a2e9c09000000b002d6c5cd144amr3631490lji.16.1712843913760; Thu, 11 Apr
 2024 06:58:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240410134858.3295266-1-aahringo@redhat.com> <20240410134858.3295266-9-aahringo@redhat.com>
In-Reply-To: <20240410134858.3295266-9-aahringo@redhat.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Thu, 11 Apr 2024 09:58:22 -0400
Message-ID: <CAK-6q+g5jQbwStQvUCxDfcLfaRxEgsGCZq4LqqnkrcYKAdRj6g@mail.gmail.com>
Subject: Re: [RFC dlm/next 8/9] dlm: likely read lock path for rsb lookup
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Apr 10, 2024 at 9:49=E2=80=AFAM Alexander Aring <aahringo@redhat.co=
m> wrote:
>
> As the conversion to rhashtable introduced a hash lock per lockspace
> instead of doing a per bucket hash, this patch will change the hash lock
> handling as holding only a read lock in a very likely hot path in DLM.
>
> This hot path is to lookup rsbs and they are in keep state. Keep state
> means that the RSB_TOSS flag isn't set. If this likely read lock path is
> the case we don't need to hold the ls_rsbtbl_lock in write lock at all.
> If it's on toss state holding the ls_rsbtbl_lock in write lock is
> required. If we see that the rsb is in toss state, we hold the
> ls_rsbtbl_lock in write state and relookup (because the rsb could get
> removed into the transition from read to write state) and check if the
> rsb is still in toss state. However this is an unlikely path as toss
> rsbs are cached rsbs. Having the rsb in keep state is very likely.
>
...
> @@ -858,7 +885,9 @@ static int find_rsb_nodir(struct dlm_ls *ls, const vo=
id *name, int len,
>          */
>
>         kref_get(&r->res_ref);
> -       goto out_unlock;
> +       read_unlock_bh(&ls->ls_rsbtbl_lock);
> +
> +       goto out;
>
>
>   do_toss:

we need to start to get the write lock here and then do the relookup
and test if the state has been changed (again do_toss is an unlikely
path as the first lookup that can be done under read lock only).
The reason is that there can be a remove and add again and we check on
some fields in the toss path that can be different then, the whole
do_toss path needs to be under write lock.

It makes more sense that the first lookup is in toss state and drops
the read lock, in do_toss we take the write lock and check if the
lookup and the states are still the same under this condition, if so
we go ahead with the toss lookup path under the write lock.

Same for the other lookup functions that look for the rsb being in
toss state and bring it to the keep state (unlikely case), because it
is mostly on the keep list that can be done under read lock.

- Alex

