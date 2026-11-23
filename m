Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795466454;
	b=1tTml7grylwxjpJq0sv4ZcsFyIXcG4yZvX+MGWXeM8p09fa3/DYVPQkZF2w3pz4S2ygx
	 kA8U8jU85zmHi0ESSl9VZWYf6BdlrSiT3fjPLp+SJ8kHUoZNmkvSbchdRJBuKPXCqqU8G
	 vUUt8DcOgJS5siOwH1+muhstGEs3BamcAWPlvgBOo9LEdL8KJ108FMzkQu6qeuHyWKPUl
	 h94fA/NDHgnPNAE/7jTqo6ijwLpGp+Jawimbu0qhEUO7jwmvDhs9DeUdjLk6MIiY22UL0
	 DpEcZ5BsyI033AIp5DXjiUxU5OMiX5pQ9b7w554gd7ReTkdWDzONYRR+qqjK5Vx54bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795466454;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=656j90knWebYst0jQZVxiCz3q4DVhvKmDJLy9bbfaDE=;
	b=twCjob8zmsdPHGC6EW59yz4UQYeW2rwhT1AauaRr2XH6BxmZhhZKblkDra04GQ7E6rW1
	 uK3ZFXP+djykfCEkCqLbYH70k8B1L6iEFVPE5u6FBcDpfY4pk/Ji38cxGGMTwCiHo5wOl
	 jl6EsSorJJ6pelps6a3Yi9r+PJ1QW7Dpkh6FGGe/j1kpnzBpC83HmJrIImMLohBvzTP4E
	 UdVVXMecD+ih2JT7V97US+XXlx3mWe+Q4ZYtQjOQ8QMo/UmGfEI1AEJqJVw8PprnKEAg3
	 u1BbuaU+Sus5nLARmON8umx7AAvzalQoj37RBIAUcImNfasw9z6wj8qnj8iPvD+Pbgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XdBH+7Qh;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECF8606A335
	for <gfs2@lists.linux.dev>; Mon, 23 Nov 2026 20:40:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3ECF8606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XdBH+7Qh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795466453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=656j90knWebYst0jQZVxiCz3q4DVhvKmDJLy9bbfaDE=;
	b=XdBH+7QhXpCYkQSLntPHgrOrf8yP10HQtBiNcXREOsa4qeFzlAkqjOgYhomSTwkCHYDEbC
	+tffyZl6eP6Sa86CNezrmdIaWAusROwQfGPvH8/8cVcE6VEVryvQD6t4LGQY3DpNGXuIE8
	vgcoufzAlcRdjB26y1kN5gSmauQtkTE=
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-euIZpwPFM-252gushIuYDQ-1; Mon, 23 Nov 2026 20:40:51 +0000
X-MC-Unique: euIZpwPFM-252gushIuYDQ-1
X-Mimecast-MFC-AGG-ID: euIZpwPFM-252gushIuYDQ_1795466450
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-384c78aa0dbso5213558eec.0
        for <gfs2@lists.linux.dev>; Mon, 23 Nov 2026 12:40:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795466450; x=1796071250;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=656j90knWebYst0jQZVxiCz3q4DVhvKmDJLy9bbfaDE=;
        b=UAPFWmjyfGD46wNIcEu9DOcXa33+60Sf0UX4pqXWe/2lStS9gF0EOsfaeu9HPlX/k/
         ctodaJ1DikiV9K00osjIXVaJ5avkt4XLJi8ruMN/2TbHC+6dUOtF3nb2sjgzwq8CLI7m
         KGbcqe4s65qsL/Ag1enyfV6fwd0qsxLK8LdAluQa/HLX1yDc8rrnxK6Y3TPr8ZgEKDwm
         zJxjQlYlOZudDTjpwUfC66373JmhkJAhU2VYVPZ4B0VjYKiUsveyWuzaFRX7YR7Q0mN6
         gn2zuOiyPRYquxba4MMpINv3qDAl1Hu0nojVdH/vKuYPorwczL7+3XqD3+4hcqfeSA3a
         3sOg==
X-Forwarded-Encrypted: i=1; AL+hErF6x5ATijNXt6nOKwN28pLIcCeXQuzJk7j0Krg4fSvcS5G2IKyuC4RO+B6j5qy3ehEFROgb@lists.linux.dev
X-Gm-Message-State: APuU4Z/8z+8si+CIEF3Kny9fz1cJfSwyHoqJnMERr8BlJZw02kkNgqpO
	iZklo3IA47eB/r1c8X3UiMIfBlgLGxEFuCjWRokE/cF9Jp7LCTFWZRP6HlC5JWFSElmfhW3bGYe
	S6chhESP8pRz1QJH8UHdh9XUJlNdiszXD6v3/kpVXI2X4XEQ4lTUrokbnuAjz+8+2Q9dNu1vesO
	rJdqZC7Txa2CiIroISuSPzw4uiaYEmesRvnX6PjA==
X-Gm-Gg: AZFdTZfQtOH51+uSvRlr8GWeb5zyl08OdoY6pYaTzVFLMlOk3p+1LqFri0IiD6NnaK2
	+xNyfkNiTJw1u/tbywpR938OG0yW++LGcPnJE6Ntd4vl3oP4gmRC4ntjXubBK4wvDqcco/0c4Et
	eQdiVe5PytUGWvbx8ds27szzu8K6pM4Q3fKoKmQ49mVgPx2/hDVCzOiVnI
X-Received: by 2002:a05:7301:85cb:b0:381:edba:caba with SMTP id 5a478bee46e88-3856fd5cceamr14425157eec.17.1795466449730;
        Mon, 23 Nov 2026 12:40:49 -0800 (PST)
X-Received: by 2002:a05:7301:85cb:b0:381:edba:caba with SMTP id
 5a478bee46e88-3856fd5cceamr14425137eec.17.1795466449240; Mon, 23 Nov 2026
 12:40:49 -0800 (PST)
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Post: <mailto:gfs2@lists.linux.dev>
List-Help: <mailto:gfs2+help@lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
List-Owner: <mailto:gfs2+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261120200040.257152-1-aahringo@redhat.com> <20261120200040.257152-2-aahringo@redhat.com>
 <sashiko-outbox-226084@kernel.org> <CAK-6q+iQSn2S68FgHNNT5+vB7zTGnNN5Duujk6zU9HPP5ckgMg@mail.gmail.com>
In-Reply-To: <CAK-6q+iQSn2S68FgHNNT5+vB7zTGnNN5Duujk6zU9HPP5ckgMg@mail.gmail.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Mon, 23 Nov 2026 15:40:37 -0500
X-Gm-Features: Aa3M54rJth5FztZiScMYecJH5sszJMqj-IHjfRdlNObFng_Q1wDluYLLGTjFIl8
Message-ID: <CAK-6q+j0imuGwDydUX3BkWhVMo00C0TSgJ2i4CUy562YmUiCqg@mail.gmail.com>
Subject: Re: [PATCHv2 RESEND v7.4-rc3 1/5] dlm: fix socket hang on send buffer
 limitation with socket error
To: sashiko-reviews@lists.linux.dev
Cc: teigland@redhat.com, gfs2@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Dh-uvaJLZxhUYplfigKKU0hk1rsBFdZj9TfoAEPGR6I_1795466450
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Nov 23, 2026 at 3:38=E2=80=AFPM Alexander Aring <aahringo@redhat.co=
m> wrote:
...
>
> From what I see in the context of the othercon, that second connection
> "othercon" will never queue swork as the primary connection is used
> for connection "lookup". The "othercon" logic is a mess and we should
> have removed it long ago, as I am sure it causes other problems. I
> added a TODO a long time ago regarding how an othercon could be
> introduced using a global DLM pre-known rule where a higher nodeid

* how the othercon could be removed using...

 - Alex

