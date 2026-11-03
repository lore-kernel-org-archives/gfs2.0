Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793730991;
	b=hoRpyDhPfvnI+S5t2h0Hx+l6vvtCr/Bi6td0ZD3LsoDIZ3okbRdpRRVRmAmr8ouBfm0x
	 hvKnhT2GFTo5vWsFbESmBiKCThYCRtaUmMKZ1fwzyMu/cYhHs6Bquc9qqK/AYztOYyqnN
	 ytc0bDTPy3afbnG8z120GeWuDrFTHAUpwrvzaExB+oQiOrMiPxhEe3pThUjpUBUnBwuX1
	 Qn0vSGNKDZQQSQaOJTxBlqVs7JbFixP6bhN+eJwoCoO82CcCvie/KL+4YttrSvpgm27nz
	 f6nE90kiQVNh3NIa7qcuPhbWC+wa6gsTjrGzvQBkxqJgOPhGSl3/AV4s2TlCk5U1nCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793730991;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=j01sPplkCpeqYoQ1XyPHZ4w2xiW/+AulZEOKO4lkg9A=;
	b=iWNjnxB1v8pmTa2R9Y7XTYK5Bpd67NKhU0+dYgynb2c+NwGx3E5eP5ZtxhP9oYOyx9Rd
	 NxGyPbOVM+aJEIlLufWKsyf+puOstP0FjPUQHycPObzizD64hiANHMnyvq4itQPpvE3Jf
	 hwxC02sBOvxuFrKqnYZe9XLsoYM0opgV9suldmCaL7Rl8JWQIojR4FhsV3ttQ/831tjR8
	 DguZqAreisCv5o93OAVdmExhKP7vYfh3uo6DBmIpyDabgCbDLGvY0c141rOm/6H27czcQ
	 Aylb++RugAVMx67RYhASu46TInnrYRFue55JsKrYtadZHhLLq3YcoY3gq9pXPgpmasw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DuRrYOC1;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FC4606A328
	for <gfs2@lists.linux.dev>; Tue,  3 Nov 2026 18:36:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1FC4606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DuRrYOC1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793730990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j01sPplkCpeqYoQ1XyPHZ4w2xiW/+AulZEOKO4lkg9A=;
	b=DuRrYOC1dngAPxnW+wVbTdNu2r7WtChZ71vj8fbMlt29KuG9frdcPG++14zj0NTu5WTeTi
	pWkX1MO++ohdy61mrElr3ezID2znh/oPZz5s422XDf85VKi1vJ3PKDpiiZdWVCFgMr+JgC
	q/6Vqb55/fzqVXZ+CpTFzcbBE57GK3o=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-eTVCvLlzPv6nUaoM8HfUnw-1; Tue, 03 Nov 2026 13:36:28 -0500
X-MC-Unique: eTVCvLlzPv6nUaoM8HfUnw-1
X-Mimecast-MFC-AGG-ID: eTVCvLlzPv6nUaoM8HfUnw_1793730987
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-3ac608b6600so35032901fa.2
        for <gfs2@lists.linux.dev>; Tue, 03 Nov 2026 10:36:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793730987; x=1794335787;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j01sPplkCpeqYoQ1XyPHZ4w2xiW/+AulZEOKO4lkg9A=;
        b=rqFNw0UjcNYUkhOXvlJf+AmDdDF5a2mFJ1iFJ7+lPz4O56drFiEXpnY5AkyssBiVTn
         AqbT6EL773JFq0+BLMFeE9h4GkkO5NgMzu5hkVmBuf4b7szJb9w3hFt+TTjmXcejtcTh
         n+n1OKuF3AU/SR1ou6ZUs+ZUE16917Cm3K78V+5K3Kl13v1qCZWwHxRolfSFPryoR0XG
         1ET0+yZrt+ZRcUwNUGc+wrzI2855RvXD31yqCP+2WjaU7vUBgYjWMY1mw/iUtIEmOrKx
         2oXAei33K4PIJKYpHseMtPUXk5cwjjp4PPR+VCeSRXQ6Z6Av6odud1yei/iZlSZYldR+
         UgBQ==
X-Forwarded-Encrypted: i=1; AKwUvBzX+32KA7W+8nDgfsT/KH9M49KmaXJXmSjs4eXm6CkCk1RJ2uz61RWVAu3xkrUoWUVIDvLk@lists.linux.dev
X-Gm-Message-State: APuU4Z/OPAkDhzz6iUzKLQPGOGQ6n2bYAUJhjGj7vIgseq3eFrbs6chu
	CHZhkxWnr4tunw784vsNoI1buvidPb0e2gaLdxqgzTBNpkFrEV27vERe0KrVaEEhpzck9dNLP44
	Wy/RGOdx8D6/11nLlwAmEQK0bX5T7f85BhqYWOfhfoJlK5EiULrXPM+LbhxqHDzRaa+BNRbHXmo
	zJDR73W/JnvGTEzw1K6kBFHiPwT0E5Ow==
X-Gm-Gg: AYBFou1dqR+9n+JE50bQj62bMZg9Rjff9O743MUlHny85FwCpjM5yMRk10TDbvTECWD
	92RLco/8/tQ/fwDYEMxzkWuzrdp2rwlnxjzdltSJlGvu5KH64+Q1Xk3rmW1Byr5GDEkBeKlXAFr
	S7M8qtsndIrc9nGOpyPIK520q+T6fkciKFyF+BOX1WQ2XmuZEvdvVqEt7S
X-Received: by 2002:a2e:a883:0:b0:3ac:4ce6:8b7e with SMTP id 38308e7fff4ca-3acb7b4dcf4mr36387091fa.26.1793730987146;
        Tue, 03 Nov 2026 10:36:27 -0800 (PST)
X-Received: by 2002:a2e:a883:0:b0:3ac:4ce6:8b7e with SMTP id
 38308e7fff4ca-3acb7b4dcf4mr36387021fa.26.1793730986742; Tue, 03 Nov 2026
 10:36:26 -0800 (PST)
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Post: <mailto:gfs2@lists.linux.dev>
List-Help: <mailto:gfs2+help@lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
List-Owner: <mailto:gfs2+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20260818140746.1913226-2-Jeremy.Jean@oss.cyber.gouv.fr>
 <CAK-6q+g8ZFFWRZfhW5AsKM3_LcxBei_RdBfxgSdsa=x8=7b+jA@mail.gmail.com> <868a092d4d27c0f8999057916b1de4da@oss.cyber.gouv.fr>
In-Reply-To: <868a092d4d27c0f8999057916b1de4da@oss.cyber.gouv.fr>
From: Alexander Aring <aahringo@redhat.com>
Date: Tue, 3 Nov 2026 13:36:15 -0500
X-Gm-Features: AclHuK9184TyvecLrVXGuMPslSGYXWlRccRhA098qg00_x4VCfICGj5GbqjeGHA
Message-ID: <CAK-6q+jPTQ1BXP5NKdFXSwPjXVimgg11oFBzvW-T787azxWnag@mail.gmail.com>
Subject: Re: [PATCH] dlm: reject wrapped messages with oversized inner lengths
To: =?UTF-8?B?SsOpcsOpbXkgSmVhbg==?= <jeremy.jean@oss.cyber.gouv.fr>
Cc: David Teigland <teigland@redhat.com>, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Stable <stable@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MkVvHGXRYooeTgW9nXUUtq_okYDMAuOop6RmsVljKIE_1793730987
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Nov 3, 2026 at 1:13=E2=80=AFPM J=C3=A9r=C3=A9my Jean
<jeremy.jean@oss.cyber.gouv.fr> wrote:
...
>
> Hello,
>
> Has anyone had time to check or process this further?
> Current commit on master still has the issue.
>

I don't know what happened. I will resend them on Friday and ensure
this is applied to dlm/next [0] soon.

Sorry.

- Alex

[0] https://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git/=
log/?h=3Dnext

