Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98F01F76D5
	for <gfs2@lists.linux.dev>; Wed,  8 Jan 2025 15:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736351718; cv=none; b=C5Ft9Ptro3g/WExQDtgKlwmsNP+j+zVpJ4fS0pfmEwV1evbODgGl9vyyiAG6wEkM0jX77Mc7V6dqyhDG3AyDXDLKerGNekzpmj3b+1BXBMUKDLSae0IwjBQvGDlKBmFZmFjAeqhfZkXDMdGhZ9EQA8ACknOX9mz4XA0fLyrNuV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736351718; c=relaxed/simple;
	bh=49ylCZWfYAZChjCCUYeYkWIcIMk9KMGTs3xooLMCxvQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tc61h2EPrTqUPch7L+hkTdgDRyHi+aj87oHm0XCgd7V0SRY0m+VAxfKMC2K/lHPxpFm3oy6kkTVQAhq7fELM/KFYbbWTMJBfgtAsVBJ5KlHbjHwH+r+mMJL3+KvqMfv15QAED/GdaN+wtKFRGv6OdzY7AFisQUbMVuaFuMV5qx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h9Yd5e/4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h9Yd5e/4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736351715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+eXczqZSwoEBETJXyp13hPp9hNWWw+IltuOfuruIRhg=;
	b=h9Yd5e/4GWFIFgi95ETXUm6hN1ZQBRFR1cn39NoKlCj3luUr7C1R9CFXPTAMr/0Yh5/bRS
	2eStcDVmeReN9Ds/47l6O92iaF9549NJZwHe7hfO6G/SP0VLWKZWiG4VyzpWWYoXb8TGH6
	lI6eX99kDqOc2O6ztPDpuAxSl2KEaQQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-UZg5zaz_PRqtAynfaue35Q-1; Wed, 08 Jan 2025 10:55:13 -0500
X-MC-Unique: UZg5zaz_PRqtAynfaue35Q-1
X-Mimecast-MFC-AGG-ID: UZg5zaz_PRqtAynfaue35Q
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3878ad4bf8cso10361329f8f.1
        for <gfs2@lists.linux.dev>; Wed, 08 Jan 2025 07:55:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736351712; x=1736956512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+eXczqZSwoEBETJXyp13hPp9hNWWw+IltuOfuruIRhg=;
        b=lKTeX/MAokEk75PUGcNCh9hCN7kX3VxcIir9UwsIXiV5ALrsCleHyImqNefMUfzV/6
         V6LD/8yhxdWBzCKraozxW6sLCCbAMkcX0UZ2SSykqaC1aE+NCQl4yMYdmKe19vT5RSfh
         s1F1guSdAulajDAGspoiy908mSZeFNB4e82aVmFYqwX5mRwEzoNLID5QUrT98Y9NR+OS
         7WdHGp08SsUsQnu7I4WKj8AvC9WXXKzP4Pi2D9f6IMEd9i8Sh3ioaAO6djNVDrt3gbar
         zi9F5zdumAUFyLE7PYelS4KcelntP2Zm4AviTDpzn4EUU4j39sZKlkGbH4p1I0RjBQwj
         wzCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoUM30x5LgNRHUl6PHLtEqt0+NUq2ykAIyR9O7sRxRswyAXzJV6lyfdlNQplBkPF7Wxumq@lists.linux.dev
X-Gm-Message-State: AOJu0YyhwzFU3H2A4l2PoWHuzUHzCGE2Be5LyK5/YkyNfGgtdSjvPDMF
	qFi2Ycam8LoCrYbuPZZUfUB1hA6A14uEmGnlgPf02Y2LG9iRvnGMFtsFikE+6PD80xm9wTNFQ8l
	yjgjueOIITTwk6LJqpwxkoiTcy/kBMKVhcKzljaZMH/LjDPNXAnHMrcxHCedKwUtbXYrAl7Z0eq
	Z0SycP2IochEBoLNNfJbbnrXTAZQ==
X-Gm-Gg: ASbGncsf1w3BZTmD2TBm/QCJxRw8rdc/ymYYfB1Y7N9JXDesgEy1AIDsc4lh17S51oJ
	FkFjpCWXHu0Bwwxxc/gUgnsVsSkyaaLFSqxl3pKc=
X-Received: by 2002:a05:6000:461e:b0:386:2ebe:7ac3 with SMTP id ffacd0b85a97d-38a87318087mr3226062f8f.56.1736351711950;
        Wed, 08 Jan 2025 07:55:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFKE1tF20R1xtdpA8dbM0YWahq7MpLrz6pTasx4KpfQSjDycaMhCcYaGpIW3LJYNPvgyniMwh7gAXCgf3aewmk=
X-Received: by 2002:a05:6000:461e:b0:386:2ebe:7ac3 with SMTP id
 ffacd0b85a97d-38a87318087mr3226026f8f.56.1736351711590; Wed, 08 Jan 2025
 07:55:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241224084241.13563-1-heming.zhao@suse.com> <20241224084241.13563-2-heming.zhao@suse.com>
 <CAK-6q+gbGg9rQKuKkpLyURN_nY1N+k87YPj1e8HqL_zTy0GgUw@mail.gmail.com> <efad042e-6035-4045-b4e8-7798055945a1@suse.com>
In-Reply-To: <efad042e-6035-4045-b4e8-7798055945a1@suse.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Wed, 8 Jan 2025 10:54:57 -0500
X-Gm-Features: AbW1kvYeLUhJQiuOx4HeZyICShTXXFNIZfdcH7yHPoEyxdI8HT22SX_cp0bfqzk
Message-ID: <CAK-6q+g0YP+40yQ=8KVOSCcknCRmmn6-LfuvseDW1i4uFDqw5Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] dlm_controld: support corosync3/knet multi-link
To: Heming Zhao <heming.zhao@suse.com>
Cc: teigland@redhat.com, ccaulfie@redhat.com, jfriesse@redhat.com, 
	nicholas.yang@suse.com, glass.su@suse.com, gfs2@lists.linux.dev, 
	Roger Zhou <ZZhou@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: DGJ7_NiF5S_7pTaENqspaQQJLxv5qMdFiqZT5xJ5h2Y_1736351712
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jan 6, 2025 at 11:59=E2=80=AFPM Heming Zhao <heming.zhao@suse.com> =
wrote:
>
> On 1/7/25 02:11, Alexander Aring wrote:
> > Hi Heming,
> >
> > On Tue, Dec 24, 2024 at 3:42=E2=80=AFAM Heming Zhao <heming.zhao@suse.c=
om> wrote:
> >>
> >> The totem.rrp_mode config item was obsolete in corosync3. And
> >> this patch gives dlm_controld the ability to detect multiple
> >> links.
> >>
> >> The corosync and dlm network protocol relationship table:
> >>
> >>   -------------+-----------------------+---------------------
> >>                | totem.transport=3Dudpu  | totem.transport=3Dudp
> >>                +-----------------------+---------------------
> >>   corosync 2.x |            |          |      multicast
> >>                |   1-ring   | 2-ring   |---------------------
> >>                |            |          |  default  | 2-ring
> >>   -------------+------------+----------+---------------------
> >>      dlm       |     tcp    | sctp     |   tcp     | sctp
> >>   -------------+------------+----------+---------------------
> >>
> >>   -------------+----------------------------+----------------------
> >>                | totem.transport =3D udpu/udp | totem.transport=3Dknet
> >>   corosync 3.x |----------------------------+----------------------
> >>                |      1-ring                | 1-link  | multi-links
> >>   -------------+----------------------------+---------+-----------
> >>      dlm       |       tcp                  |  tcp    | sctp
> >>   -------------+----------------------------+---------+-----------
> >>
> >> At last, this patch should be work with updated kernel dlm module.
> >
> > I am not getting why the network protocol configuration has anything
> > to do with the corosync configuration.
> > I know that we currently get the address configurations from corosync
> > but with this patch we are forced to use SCTP when corosync provides
> > more than one "ring" configuration?
>
> Yes. this patch will force dlm to change to SCTP when corosync provides
> more than one "ring".
>
> The reason:
> (without this patch) When a user sets up multi-links on corosync3
> and corosync.conf with an incorrect or missing rrp_mode,
> dlm_tcp_listen_validate() will trigger 'dlm_local_count > 1' and report
> an error.
> Please note, rrp_mode is obsolete; the dlm_daemon will fail to read this
> config item in the further. Therefore, the network protocol will
> always be TCP.
>
> >
> > Even with corosync3 it should be possible to use corosync in SCTP
> > (multiple rings) and the kernel dlm using TCP only, would this not be
> > possible with dlm_controld then?
>
> Only one case for above case: corosync3 on single-link.
> A new patch is needed for dlm to work over TCP when corosync3 in SCTP
> (multi-link mode). i.e. dlm_tcp_listen_validate() shouldn't return
> -EINVAL when 'dlm_local_count > 1'.
>

I think we should change that condition then.

> A key point for dlm is that there is no way to get the corosync version.
> This patch is compatible with corosync2 env. In corosync2, the user must
> correctly config rrp_mode when using 2-ring.
>

So far I looked into it, it is anyway for detecting a protocol
according to some Corosync functionality it should still be possible
to always force dlm_controld using a different protocol by setting the
right config values/parameters.

> i.e.:
> In corosync2, change to 2-ring from 1-ring (whatever multicast mode).
> There must include rrp_mode item, if not, error report:
>    corosync[1284]:   [MAIN  ] parse error in config: 2 is too many config=
ured interfaces for the rrp_mode setting none.
>    corosync[1284]:   [MAIN  ] Corosync Cluster Engine exiting with status=
 8 at main.c:1415.
>
> Even more, since corosync3 isn't compatible with corosync2,
> in my view, latest version of dlm_tools should only focus on corosync3
> and drop corosync2 support. If any Linux distribution stay with
> corosync2, they should choose an old version of dlm_tools.
>

Is dlm_tool not just a domain socket talking to dlm_controld? It does
not use any library of the Corosync project?

- Alex

