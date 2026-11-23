Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795466342;
	b=XirSd0urr7q3bxBLAbwLVmtMpWRSd11cBKJ47C8USqu62GAzeIZnizaReCB5NN6gZRhO
	 Ut6YzcxtPYPl71mQz0soanNewgVqjpXxglxLESBwuRtCIPo8c21R/kBLrvxMA5au6rJzS
	 3jgrnMdBXnuu7e76MWyGS4JW2x3+J3KYAMnUCAGzsMmqPsZac1ufmlregtgozlcdfoS8N
	 JZR12h8UD/e18PNvFD7Hha2ZFR39AW/jFblFGjc+qJ92NjQsh6ee89YOcWSUZkF3+juNw
	 qPcnNGWclgNtTrXbufjZ6NNKl8Mb7UciwVzLb4OLcZRV4RT+iGjV6fhvPB5QjAjfhug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795466342;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=LFLVokrBsb7TBY4fGinZW7FsteZvqVhuj4Pzl3hc1RE=;
	b=IvL7QPn6T2ot8GimIMlfVuHVswZn+eEZBIdkEr5GTF0xyizTYDdaMU+f8g640JMJC4c6
	 lFnJ06yN+JwPNaPU1/jya05Cl7Zv6Qn3SSYonm4PlWGwq2rpbeLqjA9e1r/h5SavZ+WgB
	 BnCS9eryIoQs5SriHomblDgXb6DGS3puWl7hHycA0h8i0+QXEv2YKM9zyN6+YtDnH5he4
	 2fZ47GXUvf+G+VefGx1CP+6LuGfV5qmUnWtGCXH8cwVPTrTOvrNU8Qj12w0mqxDdrDvtq
	 jLaO7NRLSYBNPgsKR7fC12k892F1v9EhuvRz/fUg99HPqM5YIWkim4lCmUnYr4jNz8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=H7o8zX1j;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F143606A321
	for <gfs2@lists.linux.dev>; Mon, 23 Nov 2026 20:39:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F143606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=H7o8zX1j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795466341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LFLVokrBsb7TBY4fGinZW7FsteZvqVhuj4Pzl3hc1RE=;
	b=H7o8zX1j0rA90kn5jQxA9iKnkUG1CQhIKiZ/XUA5nBHy3PAJfaIV4wBQQY5DwzPpi+JkFD
	F4F+ewtweqAO4T7RUW4AcLBd3IP7T8lb+tlookHKG7DKd0FmX9t6yfNhbr95F8Qma7WteK
	9a7MB8BA/QR3XFlYzeTomTozYOxeHbw=
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-7Cl_AoezMsysvWqf6nJ2qw-1; Mon, 23 Nov 2026 20:38:58 +0000
X-MC-Unique: 7Cl_AoezMsysvWqf6nJ2qw-1
X-Mimecast-MFC-AGG-ID: 7Cl_AoezMsysvWqf6nJ2qw_1795466337
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-384c78aa0dbso5211836eec.0
        for <gfs2@lists.linux.dev>; Mon, 23 Nov 2026 12:38:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795466337; x=1796071137;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LFLVokrBsb7TBY4fGinZW7FsteZvqVhuj4Pzl3hc1RE=;
        b=PcEjooG2UV3KYdIAIAZFvtZMP9vzYPw5UNsWEy6HuOIilq+i8UYLF6jVyKfUgku2PY
         b0RhZBvzaiTiOEY2QbI3hglErgzPY9xHyiwjOQ92Qewx521Bea5sDfGQt9DRKahG5V33
         hkOJ2r1c2bi49XqK/ztyp/NigzFRDgZweObZJwNe40uByLWwkV3phnSCmhvZZLFJeAA3
         6xFxUTy98c3uBy7hhcwuDXP0/BRLeYhTfV13YIyb+DvH6Fpun2/h7kN7819wptUeIKLw
         hAq6Web0+l2ysGV+YyY4TpOtFjMZ4FEH9v6nVCaROLDWYo1A04Cf00aLm3v+RzZxvff6
         P/Eg==
X-Forwarded-Encrypted: i=1; AL+hErEEiXd3B4EvDXc+tfpTfmhhFgcIWQ9ngrbfWhyqkEHrjc2r12KIpYLsVNadhdctb4bDSv1F@lists.linux.dev
X-Gm-Message-State: APuU4Z9l4ujCC1o5KGo+BlIFCALInOkNYbs44Pnyl6gZTipdhYpjHy10
	d2hMuv/AED+TXx4GM892J2wx3AHKfBq+3lVJj0UIY5mqqc90QkrzKAjacOD/iOZ1B4DTwJjBnDk
	k1ricgwz6slO9EFhf1bR3TYBuWyTGbSISxA06O9Dq4ryJzNsmslsScJN4bWca7ZdzDOJW92CTpT
	G6AjFGbSbdf7tbNnMnGnso8B86lILNiw==
X-Gm-Gg: AZFdTZdZ9eToTQQcGGCbOxZHfPOytq1A1e7Ir2nMSMlvP9uK5C6UkcKoRuUR09iTbkr
	AU/5/zoPrwi8UdX2+cEupmIWZfb+sNJCmWaYzt8a+KzIXKmWjD3Ygb8L/4h1o1HbFhv2msg2Ypc
	dmCaDmfW3SnGf3WXc9RYyS2pAxwyYZLmCaoRDseAUuJjNBvl/aEtpem4hS
X-Received: by 2002:a05:7301:1501:b0:385:1e1c:9ab5 with SMTP id 5a478bee46e88-385701527f3mr12378478eec.20.1795466337094;
        Mon, 23 Nov 2026 12:38:57 -0800 (PST)
X-Received: by 2002:a05:7301:1501:b0:385:1e1c:9ab5 with SMTP id
 5a478bee46e88-385701527f3mr12378458eec.20.1795466336504; Mon, 23 Nov 2026
 12:38:56 -0800 (PST)
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
 <sashiko-outbox-226084@kernel.org>
In-Reply-To: <sashiko-outbox-226084@kernel.org>
From: Alexander Aring <aahringo@redhat.com>
Date: Mon, 23 Nov 2026 15:38:44 -0500
X-Gm-Features: Aa3M54ojJQmMrjkk6bT0MGL_Bud8_Tprawe3tZZkWm05hYL-HKiNnnV7OASLkAU
Message-ID: <CAK-6q+iQSn2S68FgHNNT5+vB7zTGnNN5Duujk6zU9HPP5ckgMg@mail.gmail.com>
Subject: Re: [PATCHv2 RESEND v7.4-rc3 1/5] dlm: fix socket hang on send buffer
 limitation with socket error
To: sashiko-reviews@lists.linux.dev
Cc: teigland@redhat.com, gfs2@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0HgIBcsQTvggiT-F1RjGLAbHLrW2x8-cKClYeooKrEo_1795466337
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Nov 20, 2026 at 3:40=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 4 potential
> issues to consider:
> - [High] dlm: missing CF_APP_LIMITED clear in lowcomms_error_report()
>   hangs send queue
> - [High] dlm: unconditional swork queue in lowcomms_error_report()
>   breaks invariants
> - [Medium] dlm: race in send_to_sock() sets CF_APP_LIMITED after socket
>   error
> - [Low] dlm: missing Fixes trailer in commit message
> --
>
> commit 796bee147607d968d752eb2e6e9611c521fe108f
> Author: Alexander Aring <aahringo@redhat.com>
>
> > dlm: fix socket hang on send buffer limitation with socket error
> >
> > As Sashiko AI bot mentioned [0], a socket connection can get stuck when
> > the send buffer limitation is reached and a socket error simultaneously
> > occurs.
> >
> > This issue can be reproduced with the following setup:
> > 1. Set sk_sndbuf to SOCK_MIN_SNDBUF.
> > 2. Slow down DLM connections using netem.
> > 3. Use tcpkill to randomly send TCP resets to DLM connections.
> >
> > I instrumented debug printouts to confirm that the sk_write_space()
> > notifier callbacks were being executed, using step 3 to trigger random
> > socket errors.
> >
> > With these changes, I can no longer reproduce the hang.
> >
> > Changes included:
> > - Removed sk_write_pending counting, as this should not be modified
> >   at the socket application layer (or is at least unnecessary).
> > - Moved clearing the CF_SEND_PENDING bit=E2=80=94which allows re-queuin=
g
> >   swork (send worker for sendmsg())=E2=80=94to the sk_write_space() cal=
lback,
> >   since this callback notifies us that the underlying socket is no long=
er
> >   constrained by its send buffer.
> > - Handled the race condition between sendmsg() and evaluating
> >   SOCK_NOSPACE after sendmsg(), where sk_write_space() could be called
> >   in between, using CF_APP_LIMITED:
> >   - In sk_write_space(), queue swork again if CF_APP_LIMITED is set.
> >   - If CF_APP_LIMITED is not set, do nothing as send_to_sock() will han=
dle
> >     it, confirming the race occurred.
> > - Introduced new handling in lowcomms_error_report() when a socket erro=
r
> >   occurs during send buffer limitation. If CF_APP_LIMITED is set, swork
> >   will be re-queued, which will fail and trigger a reconnect.
> > - Added various comments explaining the interaction with CF_APP_LIMITED=
.
> >
> > [0] https://lore.kernel.org/netdev/179090395863.434549.3668493667259120=
759@kernel.org/
> >
> > Signed-off-by: Alexander Aring <aahringo@redhat.com>
>
> [Severity: Low]
> Should this bug fix include a Fixes: tag for the commit that gated
> lowcomms_queue_swork() on CF_APP_LIMITED?
>
>   Fixes: dbb751ffab0b ("fs: dlm: parallelize lowcomms socket handling")
>

This is not the right fixes tag, that a socket error comes in when the
sending buffer is limited was not handled in the commit that was
introducing CF_APP_LIMITED b36930dd508e ("dlm: Handle application
limited situations properly.") so far I can see.

> > diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
> > index 3929b164dc0d4..6c972f1b412ca 100644
> > --- a/fs/dlm/lowcomms.c
> > +++ b/fs/dlm/lowcomms.c
>
> [ ... ]
>
> > @@ -623,6 +631,20 @@ static void lowcomms_error_report(struct sock *sk)
> >               break;
> >       }
> >
> > +     /* if waiting on sk_write_space() and an sk_err occurs, the callb=
ack
> > +      * won't fire. Clear CF_SEND_PENDING so resend tasks can re-queue
> > +      * swork, triggering a sendmsg() failure to initiate reconnection=
.
> > +      */
> > +     spin_lock_bh(&con->writequeue_lock);
> > +     clear_bit(CF_SEND_PENDING, &con->flags);
> > +     /* dlm_midcomms_unack_msg_resend() does not always
> > +      * trigger lowcomms_queue_swork() as it tries to
> > +      * avoid to put pending messages into the lowcomms
> > +      * sending buffer. Force it here again.
> > +      */
> > +     lowcomms_queue_swork(con);
> > +     spin_unlock_bh(&con->writequeue_lock);
> > +
> >       dlm_midcomms_unack_msg_resend(con->nodeid);
> >
> >       listen_sock.sk_error_report(sk);
>
> [Severity: High]
> Does lowcomms_error_report() also need to clear CF_APP_LIMITED before
> calling lowcomms_queue_swork(con)?
>
> lowcomms_queue_swork() refuses to schedule con->swork while CF_APP_LIMITE=
D
> is set:
>
> fs/dlm/lowcomms.c:lowcomms_queue_swork() {
>         if (!test_bit(CF_IO_STOP, &con->flags) &&
>             !test_bit(CF_APP_LIMITED, &con->flags) &&
>             !test_and_set_bit(CF_SEND_PENDING, &con->flags))
>                 queue_work(io_workqueue, &con->swork);
> }
>
> When a socket error arrives while CF_APP_LIMITED is set, sk_write_space()
> will not fire, so leaving CF_APP_LIMITED set here causes every
> lowcomms_queue_swork(con) call to be a no-op and leaves the connection
> permanently hung.

Yes that makes sense and I had this in a previous version [0]. However
I wanted to drop the "test_bit()" check.

>
> [Severity: High]
> Should lowcomms_error_report() only clear CF_SEND_PENDING and queue
> con->swork when test_and_clear_bit(CF_APP_LIMITED, &con->flags) succeeds,
> matching lowcomms_write_space()?
>
> Accepting a crossover connection in accept_from_sock() attaches the socke=
t
> to othercon (which has CF_IS_OTHERCON set) via add_sock(), installing
> lowcomms_error_report() as sk_error_report.  Because othercon is
> receive-only, unconditionally queuing con->swork on a socket error
> schedules process_send_sockets() on othercon, triggering
> WARN_ON_ONCE(test_bit(CF_IS_OTHERCON, &con->flags)) and entering an
> infinite reconnect loop calling dlm_connect(othercon) once othercon->sock
> is closed.
>
> On a primary connection where CF_APP_LIMITED is not set, unconditionally
> clearing CF_SEND_PENDING also breaks swork serialization on the unbound
> io_workqueue by allowing a second con->swork to be queued while
> process_send_sockets() is already running.

From what I see in the context of the othercon, that second connection
"othercon" will never queue swork as the primary connection is used
for connection "lookup". The "othercon" logic is a mess and we should
have removed it long ago, as I am sure it causes other problems. I
added a TODO a long time ago regarding how an othercon could be
introduced using a global DLM pre-known rule where a higher nodeid
makes the connection and the other node waits for accept (though the
other node can still request a reconnection). [1]

I experimented with that, but I was never able to create a
backward-compatible mode that still works. I think if we fix this, we
should add an option to opt-in and later make it the default.

- Alex

[0] https://lore.kernel.org/gfs2/20261002232107.1578646-3-aahringo@redhat.c=
om/
[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/fs/dlm/lowcomms.c?h=3Dv7.4-rc4#n91

