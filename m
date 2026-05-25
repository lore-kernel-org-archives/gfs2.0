Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD4126C3B0
	for <gfs2@lists.linux.dev>; Mon, 25 May 2026 17:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779730789; cv=none; b=UMRoldcXIfsy2lKsP3/OWbU+YygBwiy3un3fSg2G58ptoNKaESbVaL+NMkqCAxm2sNyAylms/yufwZ1ZZPemAorQeVk6MZZ/TCGUiIzEQSb5swBWLLNks0dh0fyPFg+0WUciphtWKI2txrHjvaDvxUano0Dd/PDyDWBL9d+B030=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779730789; c=relaxed/simple;
	bh=iLOCzA1gUDIeE93A/v6WGRoVyWNSPyc+g7eKkglKPWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=asGNu2F2x9nbz0sdlyURL7QH5z0n/22yAjEnw/tee+wJ0gIWRpRO/6UAm3DDIEPxPxr13Uz4560akShU8lf+I3YEfJ//avTP2TXViZf+pJ4cg82Ub9Icy6+ZPWtgixJM1iKGMqxS7j4LTM0pBhGD3UkZIB5NyP8D5ou2u1P1ZpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WrxNwQQQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WrxNwQQQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779730785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iLOCzA1gUDIeE93A/v6WGRoVyWNSPyc+g7eKkglKPWo=;
	b=WrxNwQQQLhxKJ0LC4AqocVY89gdvlPJnq5Qs7Io62IbKH0yAXVBlkgK4aoZaDW/K+se5YJ
	TwuWytMCKfzNemo7205vJAYkNa1vJ1Re7Led80nBQZnEu6d7lRd5AnWY32E5AOFvoK5VYn
	/gJrudYNezOPtlxPMJ97IIkn0JNdGo8=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-buyjAcM2NlO2XXI59IzLLw-1; Mon, 25 May 2026 13:39:39 -0400
X-MC-Unique: buyjAcM2NlO2XXI59IzLLw-1
X-Mimecast-MFC-AGG-ID: buyjAcM2NlO2XXI59IzLLw_1779730777
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-393d72477bfso46980941fa.0
        for <gfs2@lists.linux.dev>; Mon, 25 May 2026 10:39:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779730777; x=1780335577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iLOCzA1gUDIeE93A/v6WGRoVyWNSPyc+g7eKkglKPWo=;
        b=aTi8nXQawP9CbMa89av9lbDFotqUqJVhXyZ+fkySnQMzj7+ASLNMkLV1cO+J7guMhk
         uKWWFELEHsVue88px3LDM3PIpOJxUBq9BuwqHibpZJNXFV6oRqpQYzTzHd5seqNz8jpE
         wTIQzel58U+k2yIWKEN5FrM3RVF/IRFAUW10+c58EYIrkBGFQnoFDKwx83XvKllgBtCf
         ItPed08UTss12hl0HeWaWgBdja+w2CK94cy8yv36em4856UNAoMP0dcrZ7SSIhg2g7D5
         g7e1D/lDG9mGnSGZoVeGks/rizhz0/5ni8KZYWMq+Nx6MuyZZehYFePNAZwd3ogUFV4o
         4TzQ==
X-Forwarded-Encrypted: i=1; AFNElJ/wOrosrAUry8EtRBM7cgOuWPWm+L403K86tKYezV1Rq4xtiJUIAgEBSGrJ4qmdKQtBMV/6@lists.linux.dev
X-Gm-Message-State: AOJu0YwoZejGAHc5SrfsU1KWO2nwfY2FquWu6OkySH+Af8gcC9Lns5W7
	sdRZ9sAINjPV/391bEbZV5TUk2EGdwGgQc4HeqnAWmUHgzJ5PNSGKkglE0dWFcMBCz0s58nbKlV
	EuuX/H1n/NDzHFGeBrxEhaMrqM5RbAh5cgYjqxoYlHChx2+UOwi6epz6lSR76Jwi+J6whrTaLXi
	GD1FwY2lWEhAosnwoUT7Jriei+0A3ucg==
X-Gm-Gg: Acq92OEcHG/w/yqfcOUZFa0phurN6atoEtsECU5kzS4MpkgT49T7HNA/kqbYGda3BlF
	EPIKOKJnElZEDVe3eeLXzHdai8svibdzEE4oNxW420PgloBfy+Pf68KlgfdvWts0U0yb8xdcUoz
	6pgjzLexL37z5Wb/utZl6UKZDML/LWIGED2pQnQtNQQPcN+bH7Q4oB3Ga2PJltIO9KVDTzc9hAe
	ey1m6FsAzICluyP1t/itZHXZaRE5/LY3MuAAa4k
X-Received: by 2002:a2e:bc90:0:b0:395:ae3b:3375 with SMTP id 38308e7fff4ca-395d8bbc610mr55796101fa.2.1779730776681;
        Mon, 25 May 2026 10:39:36 -0700 (PDT)
X-Received: by 2002:a2e:bc90:0:b0:395:ae3b:3375 with SMTP id
 38308e7fff4ca-395d8bbc610mr55795881fa.2.1779730776262; Mon, 25 May 2026
 10:39:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260517020315.1064253-1-joseph.qi@linux.alibaba.com> <CAK-6q+jvaQx6y_tOzks3utBWaTRjvVnDWrznBYRfWjTQBcefBA@mail.gmail.com>
In-Reply-To: <CAK-6q+jvaQx6y_tOzks3utBWaTRjvVnDWrznBYRfWjTQBcefBA@mail.gmail.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Mon, 25 May 2026 13:39:24 -0400
X-Gm-Features: AVHnY4JF0gHQDXu_5lLKhCPGLJuvKMSImwvBzHqgGlax84j1innCIdrlJBHtSws
Message-ID: <CAK-6q+iC3AgX7r2fZkvDJHibS0oqTwVCF4ZgV-1OFkV0d=R2Vw@mail.gmail.com>
Subject: Re: [PATCH v2] dlm: fix buffer overflow from negative len in dlm_search_rsb_tree
To: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: David Teigland <teigland@redhat.com>, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-cve-announce@vger.kernel.org, gregkh@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QncJQZPALrWoFYrlP-SA5tjSkVpSFnM9RSqnI8ePHDo_1779730777
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, May 25, 2026 at 10:27=E2=80=AFAM Alexander Aring <aahringo@redhat.c=
om> wrote:
>
> Hi,
>
> On Sat, May 16, 2026 at 10:03=E2=80=AFPM Joseph Qi <joseph.qi@linux.aliba=
ba.com> wrote:
> >
> > commit 080e5563f878 only checks for len > DLM_RESNAME_MAXLEN, which doe=
s
>
> check with checkpath, it reports an error regarding how this commit
> reference is done.
>

This also addresses CVE-2026-43125 [0].

- Alex

[0] https://lore.kernel.org/linux-cve-announce/2026050619-CVE-2026-43125-c9=
f9@gregkh/

