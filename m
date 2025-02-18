Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1073922A80F
	for <gfs2@lists.linux.dev>; Tue, 18 Feb 2025 16:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739896572; cv=none; b=XMNngunbTkW+kIeGf2yTVYjUkaMru6DEw+gQyPPU51thetC3lM/uPFdhLx19vyTUKhtweiXIKZ5tupVCBsCMBhRLcYxL/RkuJwQT21wEl2LE5HOMEBT576RmAIefGbaBCpdtyFB4LCKiCp4ky8unYuJdkLuokZe2zGH7evASgH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739896572; c=relaxed/simple;
	bh=i8OWY2rfrEeaMVhZ4Wy742HgbMECSvdwr0PIDXiyAo8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iN9Vga57mcdyZsqW6ORSWfPL5KndGcGM7bYaC02rClgXj8P2FCo6N9Dnod1FbRzM/pb0DKKwnCHgjNSPIUrbr09eBnSFMBQH3vB7DnHqHJ/rHcp/C/KbFTOHMW9UBU+zDCRMjvyNaU+aohaLSRSoHJgItBSVRslcHjmjYP27UXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MvfgmMaS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MvfgmMaS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739896570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i8OWY2rfrEeaMVhZ4Wy742HgbMECSvdwr0PIDXiyAo8=;
	b=MvfgmMaShRrNLCR1Hg5qPXTJUbEZNIRVB7tDEncTsd15UH6t9wAklW1lwzvUgvquIT/io0
	2LCmoXxmvlF/VQrRO57vn3YnGaRwvnCY9QIb1dq6Ytd85HOITVOT2VDNaOhBkEH3hAp2sG
	1UvG1WsxfFOVqY1HOJFtU1isCZZyr0E=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-f0sxDxINPr-gIy5XBOo3Jw-1; Tue, 18 Feb 2025 11:36:08 -0500
X-MC-Unique: f0sxDxINPr-gIy5XBOo3Jw-1
X-Mimecast-MFC-AGG-ID: f0sxDxINPr-gIy5XBOo3Jw_1739896567
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-5452e03593eso2317385e87.1
        for <gfs2@lists.linux.dev>; Tue, 18 Feb 2025 08:36:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739896567; x=1740501367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i8OWY2rfrEeaMVhZ4Wy742HgbMECSvdwr0PIDXiyAo8=;
        b=knYhMVOi0amSkdLo0x+HJoz+Ps2OqLXdkP7Es8itoPJedfzrix8Yf3PrB83x4Rs7Bs
         2cQCV35w8xJg7cQh4/kNkcPD3C930krgVpovHqyilE7LkPJzypPVaTgbiM3WejXdx4oR
         hQj6bPZvi8wnJbrs+LuTAwAAIMRsMv79suZpsf8LKsCb7DkuHO3xpG5XbKR7wnC8x9IS
         LlnwSZnEl3ytWSD5aCrCA89uTezI+xMiaH6pT9DmC4OExDRjCYEUROKnKhYPji0NGWpK
         k9W+6v1duQoPHB737crFjF4TlfKBmC/GP9e7a6fMcBW3vmBkcyyYD9syHK7GQhEUh+c9
         iplA==
X-Forwarded-Encrypted: i=1; AJvYcCVCfewYp++5jjCRkagBG0LTXgJepE2QzvYSihBW+AHd0dJ3KTz4+6hA7SpmKM/Mu7Qksnec@lists.linux.dev
X-Gm-Message-State: AOJu0YzxQsAWIX/6iPeToD9ttWUlHx/qOcRTZo9l+UE9zLZdRu7lhGKH
	RgvEf3a2CJnqiZN8GRh8G5oUUJFgCx6qR3YtcE9+IG6ifXk/Q6aq/XqvPNJKkiQkjm+bV9KVCnd
	4XrJd+v4hjFxRFv+ld6kfZUraGTzqN/hQweGbHWRXvjd/Ne+pr8KhcI3Q6azATfTKtZRRfZ6WEu
	ewLnxtlm+qRVw7t+lnG8JBCoNPmw==
X-Gm-Gg: ASbGncshDA1b4gnDkdRX9OgmZ8KfDe4YqCakBuDEDt7X2n259pz8CFl5RRvOeYDfPFn
	TJohO4vFlkngQX70+FUAKIoH040qH8SsKg70YTBcqhCxlypH5cNOWH6bJ+bgihbAKsQlwqMA+09
	krxRVmkotc6K1f43uC+ZdX
X-Received: by 2002:a05:6512:104e:b0:545:2b24:c714 with SMTP id 2adb3069b0e04-5452fe56d73mr5861475e87.18.1739896566962;
        Tue, 18 Feb 2025 08:36:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGSEhE84auHcSlXJjSMlqZo3bFnGnmJa6RBmjqL5i6sqiEKa0AgpfwlRMbvPEjXC++mVUlRCTSHj7jNvKNfmQM=
X-Received: by 2002:a05:6512:104e:b0:545:2b24:c714 with SMTP id
 2adb3069b0e04-5452fe56d73mr5861455e87.18.1739896566462; Tue, 18 Feb 2025
 08:36:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241224084241.13563-1-heming.zhao@suse.com> <20241224084241.13563-2-heming.zhao@suse.com>
 <CAK-6q+gbGg9rQKuKkpLyURN_nY1N+k87YPj1e8HqL_zTy0GgUw@mail.gmail.com>
 <efad042e-6035-4045-b4e8-7798055945a1@suse.com> <CAK-6q+g0YP+40yQ=8KVOSCcknCRmmn6-LfuvseDW1i4uFDqw5Q@mail.gmail.com>
 <f6062ed5-51aa-4c56-a211-87183e6eb853@suse.com> <CAK-6q+jRn+fXdby1tCQSoayO4HfpKKQkfUOH6SGJ75ujbNn1ug@mail.gmail.com>
 <6e96fe53-869a-40b4-8c28-f7568f2987d5@suse.com> <aaec163a-fadf-4c7d-a193-9b0eb97d584b@redhat.com>
 <55a997d3-df7b-4ead-8ddd-d4819ca95cf0@suse.com> <CAK-6q+grrJ5K7FTRnyFatZLTq726s5Y_S8CoKXWywedUTzp3rQ@mail.gmail.com>
 <54d17bad-997e-4271-9d76-679a923b4ea8@redhat.com> <ca9f2519-6dba-4927-b61b-6d5852473275@suse.com>
In-Reply-To: <ca9f2519-6dba-4927-b61b-6d5852473275@suse.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Tue, 18 Feb 2025 11:35:55 -0500
X-Gm-Features: AWEUYZkXJxKu66ObFo5_SMH64MyQW-SBfRzwukGagB9ucxdmqRZl0pXYW9VWX4k
Message-ID: <CAK-6q+iw_rqmqt3w0ZwOZ4xiMwV6EZN-V0bqqyy3rAhTB8Oomg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] dlm_controld: support corosync3/knet multi-link
To: Heming Zhao <heming.zhao@suse.com>
Cc: christine caulfield <ccaulfie@redhat.com>, teigland@redhat.com, jfriesse@redhat.com, 
	nicholas.yang@suse.com, glass.su@suse.com, gfs2@lists.linux.dev, 
	Roger Zhou <ZZhou@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0q1ZecJZGfwvCZ9BFUg1x1EAT1S9VYcP2T7xFyEK4tA_1739896567
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Feb 18, 2025 at 6:46=E2=80=AFAM Heming Zhao <heming.zhao@suse.com> =
wrote:
>
> Hello Christine and Alexander,
>
> On 1/17/25 23:16, christine caulfield wrote:
> > On 17/01/2025 15:11, Alexander Aring wrote:
> >> Hi,
> >>
> >> On Sun, Jan 12, 2025 at 10:13=E2=80=AFPM Heming Zhao <heming.zhao@suse=
.com> wrote:
> >> ...
> >>>
> >>> The current dlm code design doesn't allow reconfiguring the network
> >>> protocol on the fly. In the above scenario, the dlm will maintain the
> >>> TCP connection until the next dlm_deamon restart.
> >>>
> >>> In my view, it's not essential for dlm to follow the knet dynamically
> >>> multi-link style. if the user hasn't set the 'protocol' item in
> >>> dlm.conf, (with my patch, for knet env), dlm will detect the corosync
> >>> nodelist on startup, and set the appropriate protocol mode.
> >>>
> >>> If the user want to keep maintain a multi-link for dlm, they should
> >>> set protocl item in dlm.conf.
> >>>
> >>> On the other hand, if dlm needs to dynamically change the number of
> >>> links during runtime, it should always use the SCTP protocol.
> >>
> >> to move on here, I would at first apply/ack the patches for the static
> >> maximum address increase.
> >>
> >> I see no problems to do that as this is required by you.
> >>
> >> For the automatic protocol detection and corosync3, at least I need to
> >> doing some tests as I have currently 0 ideas how corosync informs the
> >> users about new/removed links during runtime.
> >>
> >
> > To be honest, it mostly doesn't - and it's maybe something we could loo=
k into, though I doubt it would be high priority as this is the first time =
it's been thought of :)
> >
> > Currently you can watch for the cmap key config.reload_in_progress and =
after that goes from 1 back to 0 re-read the new corosync.conf.
> >
> > Chrissie
> >
> >> - Alex
> >>
> >
>
> Sorry to raise this context.
>
> I suspect Chrissie misunderstood Alex's writing, Alex comment is about an=
other
> patch [1], not this patch.
> In my view, it's not harmful to increase the address number in kernel spa=
ce.

good news, the patch is already upstream. [0] Yes it is indeed not
harmful to increase that value.

We need to test/discuss the user space changes with corosync v2 vs v3
related to detect_protocol()?

If you split this patch to have only the "MAX_NODE_ADDRESSES", then I
can already apply this change. Btw: should it not be 9 (kernel 8) when
previously it was 4 (kernel 3)? I feel there might be a termination
entry at the end of the array?

- Alex

[0] https://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git/=
commit/?h=3Dnext&id=3Da53a6336171bd722aac6e98964a79d56841c5416

