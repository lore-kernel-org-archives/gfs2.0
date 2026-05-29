Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FC131F9B4
	for <gfs2@lists.linux.dev>; Fri, 29 May 2026 13:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780060796; cv=none; b=m1yxDJlBPXqH8wod7ShpL5zm3B642QI7uUO6d2cA8jJDM/OjQfEY8VEeCEAi9vmbbDIYOlCCmF3S5fE24MvUG8v0u/9Oa6rwIIVghdjECWTqkr2Xdq1Dllg/U1Qgve47O6a2BY0Ihfyn/ETzSz3J2X7kaiWuYRlK/SxkBXOdSlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780060796; c=relaxed/simple;
	bh=o9dT1GCzFnD4RakUDPWqB5BrmylODm9qfKsB3V7IVmE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NDIXY62bmJyuvYZvV6TuZzsQlwQGWH0I+GNhoobCLAl9ZP5itIb+YmFUCZ3dutwrCqykHVz0ItRjktpiflYyrSg2jMVAWgM1tiAOhTeFIgC/IKyqf3PSfPrC+pDgK6eI7GoC1BP5P/PXiBchYs2nwJLx3mxVRcLxTGKV3w1bU/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W+bu5lvk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W+bu5lvk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780060793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o9dT1GCzFnD4RakUDPWqB5BrmylODm9qfKsB3V7IVmE=;
	b=W+bu5lvkMyq/LYxjSYfgdVCh32eLgBtJY9MQVmOo2onPwgFjVi/QgT/LU1EOFNi9/gci4D
	h2CZsJw+2jLldtFy5yCWcJHrPfBgIP6/itGDY07ZDqbvIM4eUIrsxvOf3oHxP5wSLUdSvc
	CGJSqgUD452/sNhPUg2YgCaiylN++8A=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-DtHvcXaMNSqkqJVu8dY0Qw-1; Fri, 29 May 2026 09:19:52 -0400
X-MC-Unique: DtHvcXaMNSqkqJVu8dY0Qw-1
X-Mimecast-MFC-AGG-ID: DtHvcXaMNSqkqJVu8dY0Qw_1780060790
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-395246cabc4so58159181fa.3
        for <gfs2@lists.linux.dev>; Fri, 29 May 2026 06:19:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780060790; x=1780665590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o9dT1GCzFnD4RakUDPWqB5BrmylODm9qfKsB3V7IVmE=;
        b=hRoryBPzX2fS3I7qRVaQovOALNB/xmIazXgFUkA4/WdypOb6yINDJOPI/hJNmNEJ9P
         J5JCRKqa2E2eHvm/XovtynmMCW52rsPdG+HqjITaVfJ1Cx/aFby85pzAoNs4KdtBuUTr
         OZVxQRpT1OEhlhV0lA5lxwPT9gW5dtkJcXAYehOvKjAcfOxoBP3lB2hQZ0MPQGk6gVTN
         q0OzIcheW9fFSJRjr0cqUr6VrkeQLp1J7cXpoQTwFUVkxi13SCAXpf/lne2KvFjsKvTD
         a2fAcZNFU0UIUX0BQ7g0FsKxD7KAUXU/JTpS/wBptu0k+3hiFtfnSMrCP3XmDGOHfo4S
         3g4g==
X-Forwarded-Encrypted: i=1; AFNElJ8fSH8eKVJVkCkbOWoEpUWH2ZHFTuqz7k4MZ4qz5PiyE3Kw7yk7iIrcIZCkvAM9qViLqbOm@lists.linux.dev
X-Gm-Message-State: AOJu0Yynp2YsGkOjmxVTOjTKz6Qp2D8B9EQlDkKdrVdC+ciUoh0ABH01
	KW/BLTwe6+25UC3a7/U/MvcEqiOAqwD8CIpQ1FpnX0p3HzrQxzoRjZ+IyZlmF+70GJ7nDUcLWNi
	pCOvZrIZKI/dUsvblJpg1Jl38ECuCb2wvCkH5czUxDkiUspLVURQNsA/khi6dRMwvs7oWy9K9d1
	dQIDyin5QhpkoC727ec+PynAQ5h57E9g==
X-Gm-Gg: Acq92OE7QSDia7CzSonq95e4HPiKEbgI35FXppiuXmQryW+lS1iB6XSPLSLNdcfz/de
	xaXXNntqwuvaXgjVNAUwVs2dWMF/z5W2ARNN48tSXAYbbDZgUxn+D0Y6PuwtgowgK5pOMN3c4jw
	Q47MGwDHk9qnX4doHNJNwEifUmwx9sCSvyGGzNCWUTFNkb7yGmuE5QICLjAI50xgvCM1oQHqolC
	1QJJ0vKLkUto4DSLlpu334z26ytlnlGl+UOkLSl3fidRpZjRYU=
X-Received: by 2002:a2e:91d6:0:b0:38e:83bc:1573 with SMTP id 38308e7fff4ca-396539c20b2mr6747661fa.24.1780060790009;
        Fri, 29 May 2026 06:19:50 -0700 (PDT)
X-Received: by 2002:a2e:91d6:0:b0:38e:83bc:1573 with SMTP id
 38308e7fff4ca-396539c20b2mr6747501fa.24.1780060789433; Fri, 29 May 2026
 06:19:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260517020315.1064253-1-joseph.qi@linux.alibaba.com>
 <CAK-6q+jvaQx6y_tOzks3utBWaTRjvVnDWrznBYRfWjTQBcefBA@mail.gmail.com>
 <CAK-6q+iC3AgX7r2fZkvDJHibS0oqTwVCF4ZgV-1OFkV0d=R2Vw@mail.gmail.com>
 <CAK-6q+hPM=+fXkPSbr60Y6S1O_RfYGBUeL3mfVu0H1ymZ0gp6w@mail.gmail.com> <464dd360-f4b9-4c47-90ac-2d1f558814a9@linux.alibaba.com>
In-Reply-To: <464dd360-f4b9-4c47-90ac-2d1f558814a9@linux.alibaba.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Fri, 29 May 2026 09:19:38 -0400
X-Gm-Features: AVHnY4LdC5Ob4ByLJJ_9I4_a0ni6G67eh032uDWtvf5TRlCEC8CXirjya3e7WKI
Message-ID: <CAK-6q+iW+_Hyui2KPUhLpFZtDFY1WnPu3ybr2gHPJYBZh4eaQw@mail.gmail.com>
Subject: Re: [PATCH v2] dlm: fix buffer overflow from negative len in dlm_search_rsb_tree
To: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: cve@kernel.org, David Teigland <teigland@redhat.com>, gfs2@lists.linux.dev, 
	linux-kernel@vger.kernel.org, gregkh@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ddGTBkzK5jwsc8Ps9IbrHYlP1UMWSRVEyx8tYhcjeN4_1780060790
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, May 26, 2026 at 9:01=E2=80=AFPM Joseph Qi <joseph.qi@linux.alibaba.=
com> wrote:
>
>
>
> On 5/26/26 9:58 PM, Alexander Aring wrote:
> > Hi,
> >
> > On Mon, May 25, 2026 at 1:39=E2=80=AFPM Alexander Aring <aahringo@redha=
t.com> wrote:
> >>
> >> Hi,
> >>
> >> On Mon, May 25, 2026 at 10:27=E2=80=AFAM Alexander Aring <aahringo@red=
hat.com> wrote:
> >>>
> >>> Hi,
> >>>
> >>> On Sat, May 16, 2026 at 10:03=E2=80=AFPM Joseph Qi <joseph.qi@linux.a=
libaba.com> wrote:
> >>>>
> >>>> commit 080e5563f878 only checks for len > DLM_RESNAME_MAXLEN, which =
does
> >>>
> >>> check with checkpath, it reports an error regarding how this commit
> >>> reference is done.
> >>>
> >>
> >> This also addresses CVE-2026-43125 [0].
> >>
> >> - Alex
> >>
> >> [0] https://lore.kernel.org/linux-cve-announce/2026050619-CVE-2026-431=
25-c9f9@gregkh/
> >
> > cc the right folks cve@kernel.org as described in the kernel documentat=
ion.
> >
> > There is another patch required for CVE-2026-43125 [0].
> >
> > Joseph I think for v3 you should cc also cve@kernel.org and mention
> > this in your commit msg.
> >
>
> This is indeed found when I backport this CVE into our tree.
> But I think it is a different case so I just send to upstream first.
>

In my opinion the first patch did not fix the vulnerability described
in CVE-2026-43125, but with your additional changes it does. This
means it is the same case.

A different case would be if -EINVAL is returned and we cannot recover
from it (e.g., deadlock or something, but probably not a CVE). That is
a different case, DLM is mostly currently running in a local
environment, which is why I am not very worried about it. I have it on
my list to check. I wrote once a scapy module [0] to create and feed
DLM messages to discover such things; it might be a starting point.

- Alex

[0] https://github.com/alexaring/scapy/commits/dlm/

