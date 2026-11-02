Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793658192;
	b=HyB1U8AVTr6rH45/Hg5Um6Kta8+GpjXsUB5SmoOgURa8o5DzQ1ZfXUVKF0uWJ2AWTI90
	 nRoyrNdxHKdmd59x1n1k0O4oF7N2ehWYmibi07UcawBv3qMTe+VuLMpX0YeWvBXDRzYK3
	 JJfNZQWFHqY/EV/xs0UWeriZW9e9CuCx2vaRG/kyrIYmXikbXdJKZdyETzIMV9TU72lzO
	 mNpktDiUDYSK0NfoPlr2nQ0Jwj1VNOkRq+ZBsereIK7OgKav3QjNxW6XpUFHOJhWrhzgb
	 2zB4OHSHTnP6g5P8QC3Bqyl72K1CkaWLb0hfemLEipZJlOHTkOoy4xIHpVgIve3lsVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793658192;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=Srq5bM4JSJDOJRn0G0Ykn/jY5yw6rK/skZ/5tb3CWkg=;
	b=P0Ga0Pi93Dnm2JyHlxRf+tQ86PLHyYz4F1dMNAhnuNA0F52ONOKik/964gPMZiYgRaVw
	 10nmlEr2WzqYb/RJMWWuTkmctKjJW4cdz719u1bf9MaOMnINvh5hYUiFx3Y5mjdh0d4BU
	 BqprTn9M0RfR5yGNt17T8J47wRYS2m2VpscDUIkDsV16W1Hxll7ew46JnrcFFqxlVIyjJ
	 QrfEIhVFuI1xtjJXtF4zwfzywBLdW6nhHbs42O0Ba4PvX1S8UdufKTzSEqmNRUDfBi9yT
	 koHIaHggP4QjHNs33mIeofav73IaFnmjur5V0dT4XD8uHIERMkrUiUoW8VBH1KyXcaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PDAHr0hs;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B57B606A327
	for <gfs2@lists.linux.dev>; Mon,  2 Nov 2026 22:23:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B57B606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PDAHr0hs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793658190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Srq5bM4JSJDOJRn0G0Ykn/jY5yw6rK/skZ/5tb3CWkg=;
	b=PDAHr0hsqhKjeM6A0awidP3SE5/Vcun6wdvoqp73a4DcgcUtTXY+YdbxdTYq8LYsGHU8tR
	uY1mbVNUqDn01FD+f1bha/Fgwurhag7GZ4ZmlLwfaFHfExazRmLvFyugP7IdnmJXidX2pz
	qV+wtOx2Z2skNemqvpsLzaMzVkndWEw=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-42-ED9IxdJsNk-BWXomGRQSHw-1; Mon, 02 Nov 2026 17:23:09 -0500
X-MC-Unique: ED9IxdJsNk-BWXomGRQSHw-1
X-Mimecast-MFC-AGG-ID: ED9IxdJsNk-BWXomGRQSHw_1793658188
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-3a9a58a0ab8so14106751fa.3
        for <gfs2@lists.linux.dev>; Mon, 02 Nov 2026 14:23:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793658188; x=1794262988;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Srq5bM4JSJDOJRn0G0Ykn/jY5yw6rK/skZ/5tb3CWkg=;
        b=vB/zShmbR/8hHns3SN6ZaEJ76xM2W/rWsUnXvrBSsbd5aFucXtp5vMvVhUl7vKBENF
         X7ODjngd78pPGEirvHvz2c3Y/QbXFBJ2/ll23XmRQPrfTbunuSsobmEeLblhi/lKlNb4
         woRpKzxR6VqJFonACgIqhXRHtjuK/Y8cqt1ugLQEXmlmvrOl/cQdaLVxqhVUznh0nOSY
         1DV25sGO03OB/41kiRIxzwOd8PIhdYWM3O0K8oY/gwY5nlUOQkvVhn9Gqd41t/7B6yHC
         ZNKXCYgPBUX7P1NaUb+/XAXUVCJ39l46QikS+q9l+XEz4r++Vo/PT2ZuhKu5y8bQsTnf
         Osig==
X-Forwarded-Encrypted: i=1; AKwUvBzkaqZ3+Mop4dtSneolikSLRMOcHeoihepI3GVxUeWNHPdB3ALSlL0lzTjvAmGgoGK99KaR@lists.linux.dev
X-Gm-Message-State: APuU4Z+SBv5jHSAY67t1a8b5iFaoqgK3D/BrQVI+a5V1Y37lsrjN2NGh
	rA32Q51KjVY2fsVoo7p2RFdzSNhjOKq6Us7/5CYYb6AEvHQ3qkl7OB7XdKOOdsc42WItyll6/Wp
	44cEaWWO8uuL71Qw0eI1d2shhFO8397sUM3/zwcZHOvm8kxLuH6Lywkic51cJ4TKVaFt3rdzfFU
	j7zRf4jyFyIO18cLhyUJQJKK5ib7S6Eg==
X-Gm-Gg: AYBFou1GtlL2Lp6UH2N/QdxBwzpjG1w6Y9ydMoixZXvztLkRa9iDJkD3oUz2yCtXOcd
	W7AuXeg4VvDWbXP5hNHVr/8wIFXDFgJg9fIiJOenzR/V+6psbv4IKLMBLR2Rz7ES7Y/r8VVcft+
	mL5mJEDlbaQxNIE17k1TpizODcFENtx8qUY5brNit2HeQ9t91jgSN4YJAf
X-Received: by 2002:a2e:a988:0:b0:3a9:bb20:27ca with SMTP id 38308e7fff4ca-3acb7aaca8amr28813001fa.27.1793658187676;
        Mon, 02 Nov 2026 14:23:07 -0800 (PST)
X-Received: by 2002:a2e:a988:0:b0:3a9:bb20:27ca with SMTP id
 38308e7fff4ca-3acb7aaca8amr28812941fa.27.1793658187250; Mon, 02 Nov 2026
 14:23:07 -0800 (PST)
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
 <CAK-6q+j64=mSzuufOaSGjsC2aSwhb0hs9MKxxaAhbwugdztHZw@mail.gmail.com>
 <aujr6x9t2gXbXfFw@hamza-PC> <CAK-6q+jBNKN=oSCmm+i011FdhPS+42BZc0iUfbqGiLDBc0Py5A@mail.gmail.com>
 <auj4LE0bq7w7lOF8@hamza-PC>
In-Reply-To: <auj4LE0bq7w7lOF8@hamza-PC>
From: Alexander Aring <aahringo@redhat.com>
Date: Mon, 2 Nov 2026 17:22:54 -0500
X-Gm-Features: AclHuK-jPk_10wd7dw5HRXH6KuFHPFe2h1VxKPzJFXDKCKLHQXwWBWUxRIFhqWg
Message-ID: <CAK-6q+gqM6O4h762H5NVJ_B==VL2zaBVTBDiwUdbf5zxGNEDsA@mail.gmail.com>
Subject: Re: [PATCH] dlm: don't set RSB_MASTER_UNCERTAIN on rsb with no master
To: Ameer Hamza <ameer.hamza@truenas.com>
Cc: David Teigland <teigland@redhat.com>, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	caleb.stjohn@truenas.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XeUaZ8DXn9EGHf6I3gLZFkH4AaPYacjUDXcfu8TinWM_1793658188
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Nov 2, 2026 at 4:03=E2=80=AFPM Ameer Hamza <ameer.hamza@truenas.com=
> wrote:
>
> On Mon, Nov 02, 2026 at 03:38:12PM -0500, Alexander Aring wrote:
> > Hi,
> >
> > On Mon, Nov 2, 2026 at 3:03=E2=80=AFPM Ameer Hamza <ameer.hamza@truenas=
.com> wrote:
> > >
> > > On Mon, Nov 02, 2026 at 02:49:04PM -0500, Alexander Aring wrote:
> > > > question:
> > > >
> > > > how do you "pause" anything in DLM?
> > >
> > > The nodes are VMs, so I freeze the dir node from the QEMU monitor. It
> > > stays a member but never answers the lookup, and after the cancel I
> > > evict it through configfs. That is what happens on our HA systems whe=
n
> > > the peer reboots without leaving the lockspace and a pending request
> > > gets cancelled before the peer is evicted.
> >
> > Still, do you just randomly freeze it, or do you busy/poll wait on
> > specific struct field changes?
>
> I don't poll anything. The peer is frozen before the request is made,
> so the lookup to it can never complete. Then the request is cancelled,
> the peer is evicted and the name is requested again, and it asserts
> every time.
>

I see, do you use dlm_controld/corosync as cluster manager?

I would assume at some point they should fence the frozen peer.

- Alex

