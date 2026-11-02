Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793651908;
	b=XAV2nTKDPRht6DsTyJB6PjND260ao9pSs1BDEoCPK5RjFtbYj+ryCcocTdbSDlW2844e
	 Jaw/7+0SLeQAK6sKsv2p0EDrj71OIXPpt+mhw3MQXguyJYM8KSD7YjJFg4O0D5ac8GVYi
	 YnBsCHbhEaHGacwz3wTlXXBfSevZ2triiNNpBwCubj8ef3e2uvb3Bsq8KYScgMOJ3Wnvr
	 lQbmJf8mQgT6LR9qkFekIADBbC3pg7EOQHng9H3RaEdLsQzdwb/HqyFerXqUOw0n4hsE8
	 eZh3D8j63M/nj4C5IZ9Mi//UvLyi90IOIg7LQ4ZmXr00KoN67qkfUaTCl170emwxPmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793651908;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=DDP21sO6dH3L6F1rpSILTUYDUuHIujf8RdZUCMtfKH4=;
	b=J0TNWzIwe+2tTcbzZcfuBfVub7J+3fI0fKApapWQTrwuO6Qq1RiwEst5WOlMlz5TlW1x
	 N7MH7HG/Qv0yWVVV9Y8+WQitc9H+jzWDjBuQxSgSpaT971T7oN2fxxISvtjheqQTxNjXM
	 oB08K6w/ql5CHL25vNf0jnNXcgtGe2L4m1csDDwoxswNlhkW6E5SGO38MM6DQN2MJPgD0
	 xL9i8OXcxSgIiSXzvFUR7wO/ZyNmRgTk45J0Y/C10HAsx2g6u1Vy/ciNwZ91v7+/ecgko
	 sNUu4q1nRagoDXHLXFdbOVMOz14pMXfPc1iJ6CDDN9ezUie7GcCyXZI1A4wDc6ZckZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Orpr6pRh;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA5E606A327
	for <gfs2@lists.linux.dev>; Mon,  2 Nov 2026 20:38:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CCA5E606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Orpr6pRh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793651906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DDP21sO6dH3L6F1rpSILTUYDUuHIujf8RdZUCMtfKH4=;
	b=Orpr6pRhK7kcku8CgLLWMo81N3po0RwlklhFgckAvLDLoVABTMUka0hfkJmHGfS/DNPgXg
	mKU98D9+PVq2/RteVQyCnVRrK3Bo2an0F9PcheUoNWs7uxt5le3l3D36nUXo2Xe3+SEoUi
	qva6xBhQhIu/s3lA5TbGTa76Arrqmpc=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-VnVeU8PEOFODXUiGIQIpFw-1; Mon, 02 Nov 2026 15:38:25 -0500
X-MC-Unique: VnVeU8PEOFODXUiGIQIpFw-1
X-Mimecast-MFC-AGG-ID: VnVeU8PEOFODXUiGIQIpFw_1793651904
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-3ab2f8ce13dso164351fa.1
        for <gfs2@lists.linux.dev>; Mon, 02 Nov 2026 12:38:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793651904; x=1794256704;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DDP21sO6dH3L6F1rpSILTUYDUuHIujf8RdZUCMtfKH4=;
        b=xvb7G1ftqrkD/uDxJlgE/oLg6ajTp4hw2Y6u6XKl3GIhANhz8ANCC0clioy0h9cBTA
         NMOJGUS/RcLTdX6QG82WKmTvcpYI/DLmbxRnhymGrBZZ8E0PBl/ONbJgTDBosZ9+RiAV
         PeFxQKPDVdmuR667L9bvbu5p6nvRuBZL59rDgZkP+7cH/sgr2mzACzjLjQJtkuY6cNo1
         LrB2YcxdLtYRgvW3f+ehsbb9EPSRmUMWWMPbZ1NWqjgW6QlCQCYROOtOvDFKsTn97PIC
         0CNuJFoua9LwGUpfScTC4hW4U6hQxOHaEmZ/PMKW017GFHNVQ5ivFhNregrL1tE9y/mw
         /eng==
X-Forwarded-Encrypted: i=1; AKwUvBwItaAitQ3OO1ib/EfwnkZsZKCU87nHZ0nTle7/J6N5mnlI9xrVO/7uhVpwmRW01xMUYPvF@lists.linux.dev
X-Gm-Message-State: APuU4Z+tohX8Wg8Qn8Kf8Xt65xTAJqTI4XGFxqPIUgH5zIqY7mnCmm9u
	aIsw8yWB9yo3xkO1W+zH4YzrsjEfiBQBQ//qhvqaflkYB/uMASy3g4wXYDqiTGSH9ZHIx0+TUCZ
	+O253+KYyxBF0xmO9kDf1/6ELjm88fY+WUL28DAtyz/659BhImERt/gGe1oYy6p/1G6WDyVClm+
	3laZPMtwPsAlz/CYFSWsB7mztpSJa/eQ==
X-Gm-Gg: AYBFou1HInSem1RNzPc7yur5FehR4EBO354KyqxxHYqhqu/Ut76A6BTzqwf0U0OBJxL
	rdE1hyrAlFoIgnV7Lnj2Giyi7seW/n6Tmj1QAOcSGwxmkqsh5+RywzorOcYHa0CaFQa1UU6i4pj
	WfIaHuWifyoqcqbl6Sm/KS+ID5ssUU8aC9KbIUojGQqtGK/Yd13NfCf3vv
X-Received: by 2002:a05:651c:553:b0:3a6:5c8f:857 with SMTP id 38308e7fff4ca-3aca57a559cmr30300071fa.8.1793651904083;
        Mon, 02 Nov 2026 12:38:24 -0800 (PST)
X-Received: by 2002:a05:651c:553:b0:3a6:5c8f:857 with SMTP id
 38308e7fff4ca-3aca57a559cmr30300041fa.8.1793651903708; Mon, 02 Nov 2026
 12:38:23 -0800 (PST)
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Post: <mailto:gfs2@lists.linux.dev>
List-Help: <mailto:gfs2+help@lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
List-Owner: <mailto:gfs2+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261019151627.3324886-1-ameer.hamza@truenas.com>
 <CAK-6q+j64=mSzuufOaSGjsC2aSwhb0hs9MKxxaAhbwugdztHZw@mail.gmail.com> <aujr6x9t2gXbXfFw@hamza-PC>
In-Reply-To: <aujr6x9t2gXbXfFw@hamza-PC>
From: Alexander Aring <aahringo@redhat.com>
Date: Mon, 2 Nov 2026 15:38:12 -0500
X-Gm-Features: AclHuK8EBIgCcOEpy9zoAe7u3ZQc5iU2X8Ha2AYq5mu6ejtrrJMK1XULaVzy1LI
Message-ID: <CAK-6q+jBNKN=oSCmm+i011FdhPS+42BZc0iUfbqGiLDBc0Py5A@mail.gmail.com>
Subject: Re: [PATCH] dlm: don't set RSB_MASTER_UNCERTAIN on rsb with no master
To: Ameer Hamza <ameer.hamza@truenas.com>
Cc: David Teigland <teigland@redhat.com>, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	caleb.stjohn@truenas.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: KiUV3dw9f48n6EDiuuuz-hDDCS8EMrO-NbMz7p2D-HY_1793651904
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Nov 2, 2026 at 3:03=E2=80=AFPM Ameer Hamza <ameer.hamza@truenas.com=
> wrote:
>
> On Mon, Nov 02, 2026 at 02:49:04PM -0500, Alexander Aring wrote:
> > question:
> >
> > how do you "pause" anything in DLM?
>
> The nodes are VMs, so I freeze the dir node from the QEMU monitor. It
> stays a member but never answers the lookup, and after the cancel I
> evict it through configfs. That is what happens on our HA systems when
> the peer reboots without leaving the lockspace and a pending request
> gets cancelled before the peer is evicted.

Still, do you just randomly freeze it, or do you busy/poll wait on
specific struct field changes?

- Alex

