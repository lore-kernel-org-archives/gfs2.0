Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8A526A1A0
	for <gfs2@lists.linux.dev>; Tue, 25 Feb 2025 14:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740493178; cv=none; b=sN3XICRwuP30ppM2FSjLM4NYVgfHOi6nYu8iw1zpRvqegLSBmG6spTBXMGZQwb6SYuWcr6z8Jpk/R6DIBCEn/6km4CesfteHRTHSBzV+hugBe4AqeemYHTr18jPfxXOkJNxWvlidxOTSo68pCafzdCF/FYiibmPTeV+Wsz4Ys+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740493178; c=relaxed/simple;
	bh=EtxnZUOM0e6JZ/BRgdLYW/HVu2MeWnRkE801YzD7NXw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R+lvMvuSTpxOKnhcKWbc/R/r2PpUaYbhW/1y2EECGaL0hw6thiexal08YVJrikJzHi2jbMYLRJB8guKkL8DP+4GWOx8heRmqHaHMOmGW4fKb/iv/ojGN2mKJEsgjRunPijNmyHnxWQdTcP6TbYV6SrtzCS3EX9wa2IzODFrBe7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R6WcXyb+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R6WcXyb+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740493173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EtxnZUOM0e6JZ/BRgdLYW/HVu2MeWnRkE801YzD7NXw=;
	b=R6WcXyb+w2dVodE7ecu70OcTh+2UsTfjGadtAHDN117D7uW/CLWgMPqTm7IEBnpqJ39KKd
	6KJRhrxj6wkZa4JTPuUapKLAlOgkw9TCdh4S+KsKp8pF7Ww7tTMCjmmqfeqTtP/JizZmZI
	su2XIu2MB4sFzbLMJmzycnv7js8qULQ=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-42-K32sh3tyOreAi5f3keKyNg-1; Tue, 25 Feb 2025 09:19:32 -0500
X-MC-Unique: K32sh3tyOreAi5f3keKyNg-1
X-Mimecast-MFC-AGG-ID: K32sh3tyOreAi5f3keKyNg_1740493170
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-5462c601f4eso2840578e87.3
        for <gfs2@lists.linux.dev>; Tue, 25 Feb 2025 06:19:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740493170; x=1741097970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EtxnZUOM0e6JZ/BRgdLYW/HVu2MeWnRkE801YzD7NXw=;
        b=X96kWcJVsmZ+yoCisZ85KJZjBfPJ/gbdsSMSMNKV3hThtKC4+92RE58QxAO3h+bj9T
         Gt+XhSIhuHPIk/0SuXGk5bUnfszn/32FMs7wFGDndBADe1lIcLZwbWy5T0+n19ZOwTCH
         m1G6sl0T/JHwHyXxZGxCayjsLc7ppk2CsI8G3JJzDfb0AqGefG5sI72zqFNC4OZalZmA
         tCV3p8k645RHEWCfsAHY6EqKB4Cj+x5Tu77IylRo+MKgwAE7t2cJ4uTcH8pZZC1khsyJ
         9ZATf3CB0T/q5Exe/eHyhRhgYdXXi7U8RRaAVJVz4+CSOu5jhbjo1p4C5okzSG/WtW1L
         aiWQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8FprRojHpJSuypa5Ehuj7qeyQpEKDvYfrtlQc6ELBUJgUHDHUc7mhbJpYMTzi+t+tQTeC@lists.linux.dev
X-Gm-Message-State: AOJu0YxvtiEkXwmRvrV9/HHLHjTrGNb3tny8e9tki+ZsZ8sK+vbE3yDH
	5uwZ6J3jpVXCIEFV93RJSH4tswaOa8NK6HeELLXX77ZTVuB+tcnbDwWRx4idljBIwzcup1H8A78
	9g/pg8UThO5Cm81y1Ts9OASIsqN6q+BX5EJhY2u/MSlHUaRdLYjMYM5PPxjnpsfcLisDXvJm/3S
	21e/cmELtIyBdJtDSTMvHWKpTFhA==
X-Gm-Gg: ASbGncscdC4bXQtpgfAO2wZc33q6vWSEeZJbhTtd+6v60NWIkNOc6U3S9wKn2IzairG
	oFuOEAFZ39iZSFABcN84ME2iSckewoEpeTBfDwzwhZ6DjzlczhONEiRM+vdAXpr5lYN/1JKByfh
	v4OGDx8vSwATMZBQCe4iJCdOippLfxig==
X-Received: by 2002:a05:6512:1305:b0:545:27af:f2d1 with SMTP id 2adb3069b0e04-54838f79525mr6999815e87.44.1740493170346;
        Tue, 25 Feb 2025 06:19:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGnCPuep99B5vAAtIhRoT6nxQmzEXVkd6arHf4a+zFOJqttHMMlfALiuBEccG0eqdQ3u1Umc2/N90LfW2dutO8=
X-Received: by 2002:a05:6512:1305:b0:545:27af:f2d1 with SMTP id
 2adb3069b0e04-54838f79525mr6999775e87.44.1740493169790; Tue, 25 Feb 2025
 06:19:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250221150937.21642-1-heming.zhao@suse.com> <CAK-6q+iiMqW9eknqgVZiKjeUgSEAkL61Q-EbP8xwy_bayjS=fA@mail.gmail.com>
 <Z7zJ6OQIzC9Q20sG@redhat.com> <456aa9b1-a197-4de4-a062-2fe11bdaf179@suse.com> <3a8cbc24-c024-48ea-869f-687ea740ad7d@suse.com>
In-Reply-To: <3a8cbc24-c024-48ea-869f-687ea740ad7d@suse.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Tue, 25 Feb 2025 09:19:18 -0500
X-Gm-Features: AQ5f1JrB4PuYvTsdvMmzUVm-GhFG0uX_V6imz1r-O9sDQF_Z_fIGiRtd8_k8bxw
Message-ID: <CAK-6q+g_bdNoptQ_bPUbzE9uL=strr6utQ3jM_1fxoMOpEjA7A@mail.gmail.com>
Subject: Re: [PATCH] dlm_controld: Support for extended value of kernel DLM_MAX_ADDR_COUNT
To: Heming Zhao <heming.zhao@suse.com>
Cc: David Teigland <teigland@redhat.com>, ccaulfie@redhat.com, jfriesse@redhat.com, 
	nicholas.yang@suse.com, glass.su@suse.com, gfs2@lists.linux.dev, 
	Roger Zhou <ZZhou@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: agk86wyOosNv2nCc2kSAKff2pWM5izNkpEz_-Eo1JD8_1740493170
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Feb 25, 2025 at 2:34=E2=80=AFAM Heming Zhao <heming.zhao@suse.com> =
wrote:
>
> Hello Dave,
>
> On 2/25/25 14:27, Heming Zhao wrote:
> > On 2/25/25 03:35, David Teigland wrote:
> >> On Mon, Feb 24, 2025 at 10:27:04AM -0500, Alexander Aring wrote:
> >>> What are we doing with the detect_protocol() change? You want to
> >>> submit the current version again? I would like to test it with
> >>> corosync 2 vs 3 with no configuration changes on an upgrade (if this
> >>> is even possible).
> >>
> >> I suggest we stop trying to detect, and always use tcp unless protocol=
 is
> >> set to sctp.
> >>
> >> Dave
> >>
> >
> > That's fine with me
> > For corosync 3.x, there is a lot of work to support dynamic multi-link.
> > However, to support config mode, the current dlm code only requires a f=
ew modifications.
> >
> > - Heming
>
> Following your idea, if TCP is used by default, what will happen when a u=
ser
> sets up multiple links in Corosync 3.x without changing config file?
> The TCP mode of the current DLM only accepts one link. Therefore, in this
> scenario, DLM will refuse to run and report an error.
>
> Do you think we need to invest effort in changing the TCP mode code to al=
low
> TCP to work when the Corosync layer sets up multiple links?
> For example, to simplify the code, we could take only the first network l=
ink
> from the Corosync callback and ignore the others. Or we could keep the cu=
rrent
> behavior and prevent running in multi-link mode under TCP.

I would ignore the others, there exists ways to run multipath TCP on
top of multiple TCP sockets (similar to what mptcp is doing but mptcp
might be overkill, lookup "mptcp redudant scheduler").
This can be future work, existing code regarding sequence numbers of
dlm messages can be reused.

If somebody applies multiple links we assume any of them would work.
Later additional handling as mentioned above could just begin to work
in a magical way.

- Alex

