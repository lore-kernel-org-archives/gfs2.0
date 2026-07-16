Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A08A2F5491
	for <gfs2@lists.linux.dev>; Thu, 16 Jul 2026 18:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784227091; cv=none; b=WJ5fxsoJlrhZzS4iVroB+S5yTyZLfB/Lln4uiz06edj35rirRD+SeNIMtT8LN9U48lWqOnDQXXQpnzS3AGwxjaOTEx+gleTgj0Z/ivhQJCRhY5hCXbYKzEOujzfaHsBQpRLpfYByD/e7bdwiRk55qvGfeTx8Q3Hy0pD0fWrkbVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784227091; c=relaxed/simple;
	bh=99sv31NHwv6wbIAv7+ODM/fKFD6UsahfozkexNjfqhU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rI/HB4G8wJlxxpIRFI0CcvERyWnJbI6uIuafgZC8qOUmOlR+3OqDYFoUQmtlAt6wNP+ftgp+YdY2Wn+pvqzfMezUoQU5u8LGUfRnIZkgpMY1/Ib/8/UgaPt7fewSz68B+FHJ5sa7Vmi0tCZUBxmtWE7LRr51KshTApg5VHfc4RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dgaad8Xs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dgaad8Xs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784227089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ujX4wyirRrkY8+HhjimOu4AbJOKpKNwAetNRUfMyvSk=;
	b=dgaad8XsnRv3RRxKkABJlybdFmmuZoEETwEpl4uYff5qNugavbBYHWHIYbJZt5Zm8jwvAJ
	+MVo94Nrm5eIPqP4u3aQ9k4/pbZdezeoHH0zkM9nmBJp0R5ssIYx3H9E8VchIPR6rxkb9d
	aTloF9IydT938kCVklVPQeAp//neAmg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-216-juMwAC22OLentDopxPwZkg-1; Thu, 16 Jul 2026 14:38:07 -0400
X-MC-Unique: juMwAC22OLentDopxPwZkg-1
X-Mimecast-MFC-AGG-ID: juMwAC22OLentDopxPwZkg_1784227086
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-493ce4b7777so53159205e9.3
        for <gfs2@lists.linux.dev>; Thu, 16 Jul 2026 11:38:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784227086; x=1784831886;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ujX4wyirRrkY8+HhjimOu4AbJOKpKNwAetNRUfMyvSk=;
        b=KL41OA5HHX+qKhgHkQNbK1db25hCJhhweaUl9OSYukGaj3nmKdrcl44h5ERROrOTKD
         GRovS4PiEmLWM7gQJUnoRJZqcAT9x4dSb2SFqP8s7ja0eZXo8VVHS4Dsn+D8L5yGX4ie
         Ep6JQUYq1IKc9NfobA8VXTs4itQ1uEddRlys0B/2UIq8XTb/eMVzYqIlnOEw25RLugxA
         iWkNSxHDxzBBD94fnxOoexCPbYSq8Rh3i/nzkxNIDV/rIGehBI5bD448iuAmN+PHazKB
         NKjNZGCixrZulMHxaqDEt7k6JwWYB1h8DMe4CiGIb4OM/bZmKaT6CUyZjE2lMMDkDDXl
         aFxQ==
X-Forwarded-Encrypted: i=1; AHgh+RrtVv8p1BaLECiJ1xrr7xIWYCGy6YCclV/jrNy7ZmIeydq1mC3LJa13XELvJm/wHThWwxmf@lists.linux.dev
X-Gm-Message-State: AOJu0YxSwjvjQf6tLbH/0npkQeLKjpOx6Cxc/UmgrUUOQqsuf89BmMJD
	YudOCq1h4PuZievxI0FEd8ans7mfzawxKHw8ea6bVrF113iamkWitUmDyXO1/SIF0OnF9wwGkWt
	jknWTmQ1qaApyD3JWRFcGnFBkAJbrUG0PxVB/zHU0BXqMY7hOsHkHyG1oc2Y0EueTSoXyT49heV
	uR1acVvkics1SNOsjmDqPT/InFIbT7BA==
X-Gm-Gg: AfdE7cmH6vdoyuNETrX6Ce6m1OQKlGSL1fqpxyQHKvWO/Q3htLj+ULuyj00iWiF8Z3Z
	2Tn7R/R/Ol06I9LLsHtsmdS+hrCW4dxsMTo4x/y98VpwfAxBblYiHbbm/+QemPeUzBC40AYYzn6
	iKOJdtnY3xKK5GS7z+s4BPS8oL1Mf/TEZrWA2HZU8sBJ8oMj/LGkNomcehlPBBGwoLxEcaKh+Wv
	5qnRSGwcibqj9Mb
X-Received: by 2002:a05:600c:1f94:b0:493:e52f:6ee1 with SMTP id 5b1f17b1804b1-4953bfffbc8mr94584895e9.0.1784227086407;
        Thu, 16 Jul 2026 11:38:06 -0700 (PDT)
X-Received: by 2002:a05:600c:1f94:b0:493:e52f:6ee1 with SMTP id
 5b1f17b1804b1-4953bfffbc8mr94584685e9.0.1784227086080; Thu, 16 Jul 2026
 11:38:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260627161721.129861-1-listdansp@mail.ru> <20260627164211.134982-1-listdansp@mail.ru>
In-Reply-To: <20260627164211.134982-1-listdansp@mail.ru>
From: Alexander Aring <aahringo@redhat.com>
Date: Thu, 16 Jul 2026 14:37:53 -0400
X-Gm-Features: AUfX_mwcjxGHlYvpXDWvVYoZzJpbZmZ6hsKnF8Wh8wKsB5B4riylx-BvQvwjH7w
Message-ID: <CAK-6q+icgD9fK5bqjQtVn89DhsyYOxhO4KsNDzBhw9Sv_8sHXw@mail.gmail.com>
Subject: Re: [PATCH v2] dlm: validate lock modes in recovery messages
To: Danila Chernetsov <listdansp@mail.ru>
Cc: David Teigland <teigland@redhat.com>, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	lvc-project@linuxtesting.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: NDSDt9HJCaBmvfl4y_3PNOJC3RX0xLCfcxOSekFPHP0_1784227086
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Jun 27, 2026 at 1:04=E2=80=AFPM Danila Chernetsov <listdansp@mail.r=
u> wrote:
>
> The DLM recovery path restores lock state from rcom_lock messages
> received from remote nodes. The lock modes in these messages are
> copied directly into the local lkb state without validating that they
> are within the valid DLM lock mode range.
>
> The rest of the DLM code assumes that lkb_rqmode and lkb_grmode
> contain valid lock modes. In particular, LVB callback handling in
> dlm_may_skip_callback() uses lock modes as indexes into the
> dlm_lvb_operations array:
>
>     dlm_lvb_operations[prev_mode + 1][mode + 1]
>
> An invalid lock mode received during recovery could therefore result in
> an out-of-bounds read during subsequent LVB callback processing.
>
> Validate rl_rqmode and rl_grmode before storing them into the local LKB
> state. This preserves the lock mode invariant required by the rest of
> the DLM code.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Fixes: e7fd41792fc0 ("[DLM] The core of the DLM for GFS2/CLVM")
> Signed-off-by: Danila Chernetsov <listdansp@mail.ru>

Acked-by: Alexander Aring <aahringo@redhat.com>

> ---
> Changes in v2:
> - Fixed an incorrect patch subject from the previous submission.

ehm yes, for some reason this was under spam. This is a better version.

Thanks.

- Alex

