Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAE0152DFC
	for <gfs2@lists.linux.dev>; Thu, 11 Apr 2024 14:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712844031; cv=none; b=FhLFeBccXSpeu6ytx9eIASdETbDqdGOkomnshKUY4Livl+5jMTe6QCe6rvS4BriZZV8ZAHE6pzHJJ8l9qxuZwfm1dW2WY5XRgza9kLaAQuCR73mI5EPbkz5NvgDVIPUnLIrp8G8/tJ8LzurIAs+vIR1B/sZx35KRL6r3cE40Dp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712844031; c=relaxed/simple;
	bh=BF/eYiKh5Kkhq6X7teygEr5y+xHjztwFXXVrHafmkpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SoL9s0986MPqYWwWwgkjEZg+Y+Quytn5Z5tws2QhRIy6GzBNsmxTUM8Ns+kNi9wRIcKJBhUkBmfSC0/6kFpEd08FcofKlc3JT4/iAqp+zjb2NMPmL4aZkm76o4lCCMKQKb5hcLmKpzzdkMJ/xYh6zl1Pj76uH7U8G+11a3Mue74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X2onNDBv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X2onNDBv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712844029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BF/eYiKh5Kkhq6X7teygEr5y+xHjztwFXXVrHafmkpg=;
	b=X2onNDBvgwKf5JT6GRVwNAjTUxQVR7AzKSd9GGOHxZmiGG6gpXgld86PNmqpfA6gkUaUvO
	/xwsuGZITOyBHGD9699s7MQu75nUZWThGg/sprQ8MWBTnB6TdgcQqWFpBfzYOuA99OEcLo
	ChqDSeZkkUZo6bWdxvvfCWntso/3OkI=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-mGh3YVE1Oa-0tGOBHOZuiA-1; Thu, 11 Apr 2024 10:00:27 -0400
X-MC-Unique: mGh3YVE1Oa-0tGOBHOZuiA-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2d88bc8e8a4so40740761fa.2
        for <gfs2@lists.linux.dev>; Thu, 11 Apr 2024 07:00:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712844025; x=1713448825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BF/eYiKh5Kkhq6X7teygEr5y+xHjztwFXXVrHafmkpg=;
        b=IAcVoz31TscEKDKmv8nLE08x+09ssIiV360tU0pQe68u609IA3fs/oRkAhAIpS4MqB
         5u5qlsfiaU50FiXxBWLIT7690XT4Qb4Vzcln/HtKVp+OWt5l8fQUZoA7qrTcQJ2i4JGX
         LgtBte2/q4VCjFxAlV4DxnhWEK+t+9hxMwfqhweZSlR779jbg+dFmevWc9lzgGpnPvXb
         saCA3PkWi/35XU4Jxpa2PQVnSOoCTb6GW+S5viheWicz1Kb82uU9GoT+Xlsva6UJhSqK
         8wO3/l2zqC/+53t/pj+w8bNglvC0AOx8gOV3oMDDlRZhYD3/OTWwZ8dAgfo0fPRq2Nbz
         tS8g==
X-Gm-Message-State: AOJu0Yz3YHm/sdvFp3UC9NkH8ZtXjmUpG3PqdtQPDhnGtjYzQDH+sqZ2
	6Sqnl8kcgFgPXdEgC7EJSB1uOlkubY9btBpWRsAfPGXIZFG6CzAbP5xa8jPGVlooSefF4KDiQaE
	KaOJdjjtm9Cb6j8tWQV7hpk2Dc1LKxw3Id7Q/5nWcQbiaWMMOFC1PHrewMaHqjss1sal5U/9xkk
	N5J2U3UBCOTytIakIjZWKjOXfz1w==
X-Received: by 2002:a2e:8457:0:b0:2d8:d23a:f43d with SMTP id u23-20020a2e8457000000b002d8d23af43dmr3367029ljh.2.1712844025737;
        Thu, 11 Apr 2024 07:00:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfxWisjawO9zSLwcdOqz/Ii3I/drE4htC5lDqR6d729dv6SA7p3OfsaFCFpZnU1mTmk9O3x8pNNGEtvI1YRpo=
X-Received: by 2002:a2e:8457:0:b0:2d8:d23a:f43d with SMTP id
 u23-20020a2e8457000000b002d8d23af43dmr3367011ljh.2.1712844025420; Thu, 11 Apr
 2024 07:00:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240410134858.3295266-1-aahringo@redhat.com> <20240410134858.3295266-8-aahringo@redhat.com>
In-Reply-To: <20240410134858.3295266-8-aahringo@redhat.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Thu, 11 Apr 2024 10:00:14 -0400
Message-ID: <CAK-6q+hyW4tHLZJ-R_himF0uROUO_Qp05Lj++sDF6MYM8w-j1g@mail.gmail.com>
Subject: Re: [RFC dlm/next 7/9] dlm: drop scand kthread and use timers
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
> Currently the scand kthread acts like a garbage collection for expired
> rsbs on toss list to clean them up after a certain timeout. It triggers
> every couple of seconds and iterates over the toss list while holding
> ls_rsbtbl_lock for the whole hash bucket iteration. To reduce the amount
> of holding the ls_rsbtbl_lock time we handle free of cached rsbs (tossed
> rsbs) on a per rsb timer. If it expires the rsb deletes itseld out of
> rsb data structures. Addtional the timer can run on any cpu instead of
> scand that was only running on one cpu, so there should be a performance
> speedup handling such freeing of resources.
>

I currently try to work on a per lockspace timer that gets rearmed
when the next rsb is expired instead of spamming the timer subsystems
with a lot of timers.

That has also the advantage to simply shutdown the per ls timer,
instead iterating over all timers which is done by some flags in this
version.

- Alex

