Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B33521CC59
	for <gfs2@lists.linux.dev>; Wed, 11 Feb 2026 13:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770817810; cv=none; b=eluPoJTJYQSO7CmBKaWT0EbCQVJcGGgORhWv6BXFCr/iBESpUyDkbxxLi1ZhHoPcW5y60MlN2FaqP4m8X+3zkoleOl14xw+pOS3pgwwZ8vyjKUWe22WyVRvXwDRzRmHihT8IupKFZYErN9ypWtDDoAmLQCJ0NZWLnoILqt5D+Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770817810; c=relaxed/simple;
	bh=9sZWJXMrsvFSIpM2gpX8H/TzEeebXEBNrwxUqhUTzq8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cBDri7A0ZsQcYXtev7vQ5NaLp6En+5DqeLY5aErFuph4q0OvuQonKYo7xbIGaL3pJ4IyZeAprn/+2Wxkp+Rc5AO26iHE4oBEc//NBDBIavdpqzowrGq/w09D8cHxvn3teYLhyurSMMzsmOJCYkzR7w9RjWD8HUgjjm26FatJMsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eR/238IG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eR/238IG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770817808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NyGxR5LQHMgd3AjzZ3ErlH/2lpT7HfDqYV4EqF+AD+E=;
	b=eR/238IGT8jTn4sdPWxALomPmhLJ9TURIwDpwULelgISUfh6cqH8X1crohw0mHWW/lNjvl
	T1qFo/+ac+nIyVJ4EaHIKdxRCXFctPOW6tf0VbfW/4LtHituayTA16vcBVhzk6Tt6cczt7
	kDDhKE9484QaK8E8UGqkQRw7oqre8JI=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-EKsNeH9tMRaJZ2GrIOHb_w-1; Wed, 11 Feb 2026 08:50:07 -0500
X-MC-Unique: EKsNeH9tMRaJZ2GrIOHb_w-1
X-Mimecast-MFC-AGG-ID: EKsNeH9tMRaJZ2GrIOHb_w_1770817807
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-79628adff03so76553577b3.2
        for <gfs2@lists.linux.dev>; Wed, 11 Feb 2026 05:50:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770817807; x=1771422607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NyGxR5LQHMgd3AjzZ3ErlH/2lpT7HfDqYV4EqF+AD+E=;
        b=OtMjVQGY9seYbvT1S9+U/zLEnv8pcNP1hBzW91Wg7leM2kmj8k1OHa59woDd8GYolL
         NiL1B6vTvjq5fc9X+WU9M8aqv19TAu88WIjNFeEwOgZE1xNrpykMzMwPcAGU5HBmIEew
         jZ7tyRGTJoV0DApVzHUnGPZins5cxWWbWw/Iu8o9aU3zKmGvMsxxNj9bZREja5p8FgkB
         0ZnnONZJBSz+Tp438AiKIGPHloN59lNqDrqdJ4wW7TDEoOHBp9Jp0YL33Eh0DjBX+KwT
         5v6fWcqWY3qCQ9Xgfy6lenHFWaborJAGpn9Z6QcKQ/tYARdgbyPorGq1+42pJE/oFxzd
         5Jew==
X-Forwarded-Encrypted: i=1; AJvYcCVqKFHklJFnp3xj5dhZdW6Gq3StFCx3MPaCYRDqUVopSfcI5CslF+K0aBHFUbB5wxsbGGyy@lists.linux.dev
X-Gm-Message-State: AOJu0YwHkdA5+C1iFUhFTw20R2Dz8ORsDQNNvY7+tUJbo5gX55ueCGdY
	plLS/MxhW+YKPfrETww7XGif0+cfR0Yu3K3TyT5LgAF09n+lSv5CUkpe53eVgtGcIHLJKNOJlyC
	9d/ftTCEUZh9dDT7xsw5S+CScIU1gNTQhfTa24slC8xke/RZuOuEdSTw62XRWddL1TQ3AMUTzuB
	ihGZTbST3yDDESPeYjuGrXEEd7ZsQghw==
X-Gm-Gg: AZuq6aI+6pQi7ASw4mfc5B8D2+ThcJVGhsVklykCEFG1HlxIo2+ceEmnPPunogO35nc
	7rIefK8X08Ao73ZgaJu4dkHt0rOXlxRG51omwZ4jQeib9mqHQ+qD49xwjrvwnIGZqQv5Tluq5OF
	hiwDBxBQNRrgnjSLA1vkhaaVt8hJXAlgg0mFhGubHStORoiHrvwrhWolcUMf+NI4k780JHqDrrZ
	dfFEiXubrPfqqlviUnKkAq4wKQJaEnoFjnVwUwdoEa1OO84/JYJMPzbU0ueToXpVg==
X-Received: by 2002:a05:690e:dcf:b0:64a:dd9d:e944 with SMTP id 956f58d0204a3-64afe30abbcmr1311171d50.25.1770817806877;
        Wed, 11 Feb 2026 05:50:06 -0800 (PST)
X-Received: by 2002:a05:690e:dcf:b0:64a:dd9d:e944 with SMTP id
 956f58d0204a3-64afe30abbcmr1311156d50.25.1770817806461; Wed, 11 Feb 2026
 05:50:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CGME20260211070533epcas5p32f50f317b20250bb61b1b5a0b3a2a5d9@epcas5p3.samsung.com>
 <20260211070057.22001-1-kundan.kumar@samsung.com>
In-Reply-To: <20260211070057.22001-1-kundan.kumar@samsung.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Wed, 11 Feb 2026 14:49:55 +0100
X-Gm-Features: AZwV_QjumAFlbk9ZsPEeDmvoG4FkvqsDNDq1VBbfmeKSRae7isamuXkM1GDbV04
Message-ID: <CAHc6FU4O4YTm-0cU+kpqY2L3BRaA_Jsyh20tTk2KjmGN7-kKCg@mail.gmail.com>
Subject: Re: [PATCH 0/4] Avoid filesystem references to writeback internals
To: Kundan Kumar <kundan.kumar@samsung.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, trondmy@kernel.org, anna@kernel.org, 
	hch@lst.de, brauner@kernel.org, jack@suse.cz, viro@zeniv.linux.org.uk, 
	djwong@kernel.org, pankaj.raghav@linux.dev, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	gfs2@lists.linux.dev, linux-nfs@vger.kernel.org, gost.dev@samsung.com, 
	anuj20.g@samsung.com, vishak.g@samsung.com, joshi.k@samsung.com, 
	mcgrof@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -xoZfe3LIgHWHH5kure_IpcE7QTP02UKdx1TqpFDeUo_1770817807
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 11, 2026 at 8:13=E2=80=AFAM Kundan Kumar <kundan.kumar@samsung.=
com> wrote:
> The series introduces writeback helper APIs and converts f2fs, gfs2
> and nfs to stop accessing writeback internals directly.
>
> As suggested by Christoph [1], filesystem code that directly accesses
> writeback internals is split out:
> [1] https://lore.kernel.org/all/20251015072912.GA11294@lst.de/
>
> No functional changes intended
>
> Kundan Kumar (4):
>   writeback: prep helpers for dirty-limit and writeback accounting
>   f2fs: stop using writeback internals for dirty_exceeded checks
>   gfs2: stop using writeback internals for dirty_exceeded check
>   nfs: stop using writeback internals for WB_WRITEBACK accounting
>
>  fs/f2fs/node.c              |  4 ++--
>  fs/f2fs/segment.h           |  2 +-
>  fs/gfs2/super.c             |  2 +-
>  fs/nfs/internal.h           |  2 +-
>  fs/nfs/write.c              |  4 ++--
>  include/linux/backing-dev.h | 11 +++++++++++
>  6 files changed, 18 insertions(+), 7 deletions(-)
>
>
> base-commit: 05f7e89ab9731565d8a62e3b5d1ec206485eeb0b

Sure, that won't hurt.

Reviewed-by: Andreas Gruenbacher <agruenba@redhat.com>

