Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EC386136
	for <gfs2@lists.linux.dev>; Thu, 13 Jun 2024 17:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718299487; cv=none; b=KnOieKb6IsWYF9ye7JPWojcOrA8rvj5yMHSUQBDjXy9Ew/GXaVMcm16/w/ZLqjjyYabpJorbiE3MYHUYZCGV6lQTPL12ZvpU63W+6EyxbeNIArEBm3JhOyTsQVWxm5dtjSG9MOasw71NUCRag2Hce9G4RT1jFffjfI13AUJQ+84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718299487; c=relaxed/simple;
	bh=SZAopEC6ML4XT2E0uR7yvWzsje9GyRhXiiWSUH5esXc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DdboSuv4YDpIxUJyaiR0wfRS421YG0N5IFMGrDoMtiyGocu+KgfUQkbnLZdJr4nM060ol3t058zL2HlwsaLR2WsT4vigOlEpUFrDvvOIRdKIGMtPb2bgnKmEUF8pSFz33VG30oi74V+AC5RgopW08hHbryx4NdhGAiDt0r5ytoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DGbA4rGY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DGbA4rGY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718299485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SZAopEC6ML4XT2E0uR7yvWzsje9GyRhXiiWSUH5esXc=;
	b=DGbA4rGYzqAUF2ib2YhjxveKeg4qwfmaPKvGhS47ObM/NrAWkToDzqZVSCqIsUsx/OMFSy
	VV1ZjIjxy95NO/AVWCFmrw7nfJGcAr5W5zjkTTYjOvKPq2248khJMtg4CAIrkRdWoBeDKT
	tQwgrZ92H7pRMyJWx2f+6sXz5KqvyOk=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-U-w2_rADP0GxO62ssqHCSg-1; Thu, 13 Jun 2024 13:24:43 -0400
X-MC-Unique: U-w2_rADP0GxO62ssqHCSg-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2ebe629c467so11866251fa.3
        for <gfs2@lists.linux.dev>; Thu, 13 Jun 2024 10:24:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718299481; x=1718904281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SZAopEC6ML4XT2E0uR7yvWzsje9GyRhXiiWSUH5esXc=;
        b=Ya2ygfH9xP6WjXPBynGmR7MLj5gMGH5UsN7uBofuLim+qJx0zsqI+9XTpTGcPjmHyD
         gqK7f6a9qzejoc545hL1PTduLbzKioJlyEnUDJxStbe8vknwaPjbp7EVMq4Y7RK4rUUv
         HhMvubiuHLfTgsAI8OvdA0+DO/Rj15y5MPF6/6BE4inbhBLEVHQkdVmPRPhfdF5E0P/G
         aEol5bkzIDzGWRY1JJJS7GwqzO9xq7/hoBG97x6WKQJCl5H+hTy1BzLCdgJdl9gab6Ow
         cvDo+NPiqBbcgn3Cs8qKD/Kzzt9sUhpxXDpq0bQU2GyQKjmzE3r4M8ygG0OQKC8d8WBR
         0PzA==
X-Gm-Message-State: AOJu0YwEa0E8CoZ0a657BSnqm3ZzgjhPTwQDoe0ZFbXIyAAfaSBcavmw
	6wd5Nm/RHIbeDv15JZSkvTp+jBwVtlyH+KgNCA5x/MGcRiWs1CkbvdJLkhPvRRuvLJ7EIrsqkmq
	k3OU9fE1KpPvVw9yW+anu8iamWc3jEsY5JK6XH4/BOw5QIDe3V75l/YBw6v7zPBCjDFOMrPMphW
	3NgIbAWfN03OVmDJwwb4UovYVvBQ==
X-Received: by 2002:a2e:96d7:0:b0:2eb:f6bd:e4ec with SMTP id 38308e7fff4ca-2ec0e5d1350mr3269941fa.24.1718299480975;
        Thu, 13 Jun 2024 10:24:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGl3eKRFGnaPEpmNK7eLAN0MhrvVTksicUE+bfk1asqYAY2HOJQw1m6pTJRG+EYA0mNrtIK+SczF7YXTwMprvk=
X-Received: by 2002:a2e:96d7:0:b0:2eb:f6bd:e4ec with SMTP id
 38308e7fff4ca-2ec0e5d1350mr3269821fa.24.1718299480599; Thu, 13 Jun 2024
 10:24:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240613170640.3556585-1-aahringo@redhat.com>
In-Reply-To: <20240613170640.3556585-1-aahringo@redhat.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Thu, 13 Jun 2024 13:24:29 -0400
Message-ID: <CAK-6q+jUZxys-2xyhvaQ9f72AkXdKgGjHZXa3TPWoVQqPWra3A@mail.gmail.com>
Subject: Re: [PATCH dlm/next] dlm: add rcu_barrier before destroy kmem cache
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jun 13, 2024 at 1:06=E2=80=AFPM Alexander Aring <aahringo@redhat.co=
m> wrote:
>
> In the case we trigger dlm_free_rsb() that does a call_rcu() and the
> responding kfree() of res_lvbptr and a kmem_cache_free() of the rsb
> pointer we need to wait until this pending operation is done before
> calling kmem_cache_destroy(). We doing that by using rcu_barrier() that
> waits until all pending call_rcu() are done. This avoids that
> kmem_cache_destroy() complains about active objects around that are not
> being freed yet by call_rcu().
>
> There is currently more discussions about to make this behaviour better,
> see:
>
> https://lore.kernel.org/netdev/20240609082726.32742-1-Julia.Lawall@inria.=
fr/
>
> However this is only for call_rcu() if the callback calls
> kmem_cache_destroy() only to replace it by kfree_rcu() call which has
> currently some issue. This isn't our case because we also free the
> res_lvbptr if being set.
>
> For our case, to avoid the above race rcu_barrier() should be used before
> calling kmem_cache_destroy() to be sure that there are no active objects
> around. This is exactly what net/batman-adv is also doing before calling =
their
> kmem_cache_destroy() in module unloading.
>
> Signed-off-by: Alexander Aring <aahringo@redhat.com>

missing "Fixes" tag:

Fixes: 01fdeca1cc2d ("dlm: use rcu to avoid an extra rsb struct lookup")

- Alex

