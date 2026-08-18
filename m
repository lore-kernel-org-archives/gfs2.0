Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B383164B4
	for <gfs2@lists.linux.dev>; Tue, 18 Aug 2026 19:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787080791; cv=none; b=RNTiKXrI0eIbqMbUFhj39SMgACf2OrRmsJT+DZPUhKnTov7MMZzC2JCi2OwlPChmP1SPt3I0vXsWCbD2pQofq/m89H+bQbE8TjVmMQs58yB4qf2pZq4ouSTipWZ2xMY/1Xo7aN5LLbHFc42C1TKEeQwVW6LEsjZH+p8E13HFs70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787080791; c=relaxed/simple;
	bh=ECwp38TQc2LVI/YbHfQVrN9+kiOLWbThTEN8jFYhiWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bk/4Hj0F2kVLIc4pzDds9qp9OIKrdutCpo15rrC586KdKvhIn2kb0LX8Ff8vLH7qRR47y79ENsEVYeBYzWJMQdFZIDuPzW+npj2GfrNyxVIoX1iiFhZtQb94FVrMv/5MtnyZxcNrrcui3n+7hTfOVBLoeCW0ba9I3HoInsCalqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vcny/nIh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vcny/nIh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787080789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ECwp38TQc2LVI/YbHfQVrN9+kiOLWbThTEN8jFYhiWU=;
	b=Vcny/nIhoE9Tma2pBCp2kYnZSqAKZoN/9Dnuhd7rgJeeJgd5c5tvpRgnds3pu2Saq/iu7C
	YFXkr2JqY6Veo2vFGp83ArI7sCQZ9Uum74C12C8ZRWIRshQm71d/c4CmZ4VUW/s8/z4jFH
	Y5+UpP1cXo9dsOlKMltKgXkkjetVZms=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-kTCZ5ZfWMOuxYV-zDWgEAw-1; Tue, 18 Aug 2026 15:19:48 -0400
X-MC-Unique: kTCZ5ZfWMOuxYV-zDWgEAw-1
X-Mimecast-MFC-AGG-ID: kTCZ5ZfWMOuxYV-zDWgEAw_1787080787
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-5b14d09aa7fso113571e87.3
        for <gfs2@lists.linux.dev>; Tue, 18 Aug 2026 12:19:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787080787; x=1787685587;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ECwp38TQc2LVI/YbHfQVrN9+kiOLWbThTEN8jFYhiWU=;
        b=fBPh9ixx7Cj+LKHNTK9xaRVYCnGdnRAq5AgeNqyFS/9XHGhbxxZmzhmbKrqLq+lane
         V9EmiaviNsWJrdN+qvlhBjE1A8Q402LjUE9MNDqGLMyyZYOAl9u/9heyJAayU91vUvlh
         ga/BXSd1M+zZaJn6Ab4IbdkqPlGww2PEjm9mggZepJFApOOlEvug/O4t5Yb8ibgTprUD
         uYevvhUhSOdcGj0EE2C0HHaseOo2wUUoAeJeaIXnExyBzyVWn56m9JFG6VHWfUu5ZMCJ
         FrjeEzem/um7RwUajGcZXyfy2CSbkV4otazB6JsmsAqvrLLGj+LeubU1UN+n2HaJxUAU
         rfrQ==
X-Forwarded-Encrypted: i=1; AHgh+RrfbroB2mmb942hX59pwhb9QdcmtV0dmB62I51cMs7LJSXwzuVYaiQfLGHpXrEUevfVRgNG@lists.linux.dev
X-Gm-Message-State: AOJu0Yw/CU51fqar01k7e3T4Vq2SCj2ERQr0Ix78rOjaOAisCCRxXLO8
	ppp5F9LnyaXZtuUhrxSyEIoW8awfYCDffvJvyKSwd+FMWpirZxTofxomyaOkhK7a/M/5Sl0JIgv
	wn52Q51Nb5vE4nN5SA4n2tKk/OguF4gXvFIbgLKZkRp7mAjwYVyWWdwiva1dBpUxgvyN2/6nE7e
	4uq8p07qF0DANUe4hb6sNZlwJk5858ng==
X-Gm-Gg: AR+sD12VoPp7rvr/Y6KcmZK1X8pGXqjs86pyFoNT508lyDGD9zRj+L+QZJpitPYtq05
	mnhTeM91aUHZEsMf6ETUEggrLgX/UI8CnayEumunglZjIO0FDA0bVCfvMrUwk8regU1EE5AxRce
	GZXGYQH9hEBL3IFB+nvIns+DH6a5yHGbg3eW4ETCCOjFfTxyNDxWwoQf0S
X-Received: by 2002:a05:6512:acb:b0:5b2:f426:9c67 with SMTP id 2adb3069b0e04-5b477cd0e37mr204870e87.19.1787080786572;
        Tue, 18 Aug 2026 12:19:46 -0700 (PDT)
X-Received: by 2002:a05:6512:acb:b0:5b2:f426:9c67 with SMTP id
 2adb3069b0e04-5b477cd0e37mr204857e87.19.1787080786182; Tue, 18 Aug 2026
 12:19:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260818140746.1913226-2-Jeremy.Jean@oss.cyber.gouv.fr>
In-Reply-To: <20260818140746.1913226-2-Jeremy.Jean@oss.cyber.gouv.fr>
From: Alexander Aring <aahringo@redhat.com>
Date: Tue, 18 Aug 2026 15:19:35 -0400
X-Gm-Features: AcwNN1XTEexjNXHSWPG3bYWNQ1LgtttKyK40zHUY-eMIzylmdo9MC2bS3M-5khQ
Message-ID: <CAK-6q+g8ZFFWRZfhW5AsKM3_LcxBei_RdBfxgSdsa=x8=7b+jA@mail.gmail.com>
Subject: Re: [PATCH] dlm: reject wrapped messages with oversized inner lengths
To: =?UTF-8?B?SsOpcsOpbXkgSmVhbg==?= <Jeremy.Jean@oss.cyber.gouv.fr>
Cc: David Teigland <teigland@redhat.com>, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lVQez9VZO9f_LGXPSlHAtP6D8SZRemimInLAplZs-zA_1787080787
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Aug 18, 2026 at 10:28=E2=80=AFAM J=C3=A9r=C3=A9my Jean
<Jeremy.Jean@oss.cyber.gouv.fr> wrote:
>
> Reject DLM_OPTS packets whose wrapped inner message length exceeds the
> bytes remaining inside the validated outer packet. This keeps malformed
> wrapped RCOM replies from reaching downstream length-driven copies.
>
> Fixes: 489d8e559c65 ("fs: dlm: add reliable connection if reconnect")
> Assisted-by: Codex:gpt-5
> Signed-off-by: J=C3=A9r=C3=A9my Jean <Jeremy.Jean@oss.cyber.gouv.fr>

Acked-by: Alexander Aring <aahringo@redhat.com>

Thanks!

- Alex

