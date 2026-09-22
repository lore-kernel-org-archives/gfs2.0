Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E0E54DAE6
	for <gfs2@lists.linux.dev>; Tue, 22 Sep 2026 13:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790082850; cv=none; b=qIWA+NWHpsNZN1ANiOmaYOd4FaALc8P3KGd4t9+VRdORnAuJFD7BEY9Qq/ySmMLF+NbGAnRypK+77Ai4aGr0s4ph0H/GDmFlYK1WHwYAb4ESGPg9zFksubrnOo9yjP5DH902HTSZ1A1LTVs9Elx8A3yDM8tfGd7W147e4XCeJYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790082850; c=relaxed/simple;
	bh=H8mYDxezL3zeNOcyBRY8j7tO17JD8uUtMkU+mIQ++QQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nVdqC51JARuOO0IR8WDfCSIBySX+8z2V8senN8J1tufLyP5+hZyrJHP2PIYTSezP4redGU4EUvnvCRj3ruiPWluTgFJ9Gd9cNt1u7zTXNWLRFYzrO3YxBMYi2XzJgWppX755XXGfEsw86L/1kE97DpEQoISE5SlRv4s/eKMWu9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L0mA1MXl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L0mA1MXl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790082847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pwTfpD/qGiXwMKgdLNdLdxigBjWDGioNSbd9xxXMy9o=;
	b=L0mA1MXlWJJEEDVexc25QP7hCkvozK7LxWDQiWIEyOWszV3gxzVfvVuXlokyjtE0j0m0lg
	/a7pCVRWD08hIsZ5d6fDUS8IsvFKxTOyXKD3Ahu1aIPASfVkJlA8YtgvXBfGtEQMZHIP/d
	GqMIBZszOSVe24pIXgjIgSJS/euYJFU=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-389-x4C4qTnyPBmebfwVXOlsZQ-1; Tue, 22 Sep 2026 09:14:05 -0400
X-MC-Unique: x4C4qTnyPBmebfwVXOlsZQ-1
X-Mimecast-MFC-AGG-ID: x4C4qTnyPBmebfwVXOlsZQ_1790082841
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-39d93d95a21so32908931fa.0
        for <gfs2@lists.linux.dev>; Tue, 22 Sep 2026 06:14:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790082841; x=1790687641;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pwTfpD/qGiXwMKgdLNdLdxigBjWDGioNSbd9xxXMy9o=;
        b=yR0tKXN/nbTk3Ff+Ww1pwe1u1fCND/5F9OqSNnutDVJqboP9EXQUNrBnmm+cr+zIO5
         QEsI3yLimsUgu6DPEZbFuNaBY1jlEsoaAHTIpPTuYHi5FsCpfnOw2nUwMMUY+IuJxQpp
         SBLSFt3V/H1ltVhBBnV77zu6Tr8JXXMVYWfWD/PRozy9SUrbdWKtUpHNcBmDnmJXopNh
         scAOJw0wWqjPQyUg4u5Ahc74gydd9/uMfHPnaZjy8ct6R2T2JfSHvnFkmLBgNORWnvEa
         GY3yNN1JEiVud31uF8sqEe7eGsrKu4NY0dUKrgbwsFeNIbuHvUpTX2+dOAUnh5s0J6Na
         Zjkw==
X-Forwarded-Encrypted: i=1; AKwUvBwPfBkO65EDQV/6Ei94qH+OhAKyX2A/GC25ebjJq6z6ZbbwW9vO9gWPAIIBc+VC2ueqqHmv@lists.linux.dev
X-Gm-Message-State: AFuF++mip7jDYPcE0tosL6YbNVgpJYMH5Y0CSdcJyBjOH1KrBShVeZwL
	yZCpc/+DZ5uVf2OprvD/vLIO2tCeGeOOi+CzhZUx8KVKB+ABf/abKcOJBrnmWt4D9+07IX2uOsw
	RcjxzgfinVRaBa8R5LM8nlvUh6pX2WXNk3ZXMGtIUk7OsdBJaFnHduA5QziWv2nLxcM+Ck4wtHe
	b4LWwJ3H2pdyeKGRSBYhe4Fnx4asSmOA==
X-Gm-Gg: AYBFou3yDJcJvc+Nate+N8rj3XvLtU0oAJJpANYBxXHlLsiNkX1ppgp3P92PUv6UdRQ
	F0rEvQvu6bZ0+Dh+AZq7Ur1NHnw6CBcZ3kGriUz5/3WRqbN6Cwvbc1wA0G6ZGdWtnmqKmRnl6W3
	hQpQwKlkrj9JJrwAIIWkHFFVPm5siPEapfR6zwm+mOVUQgHva13tE/2vzV
X-Received: by 2002:a05:651c:199f:b0:3a3:7682:49a1 with SMTP id 38308e7fff4ca-3a5fc0a8e42mr30269671fa.22.1790082841035;
        Tue, 22 Sep 2026 06:14:01 -0700 (PDT)
X-Received: by 2002:a05:651c:199f:b0:3a3:7682:49a1 with SMTP id
 38308e7fff4ca-3a5fc0a8e42mr30269581fa.22.1790082840630; Tue, 22 Sep 2026
 06:14:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260914164400.2738350-1-edumazet@google.com> <CANn89i+HYuqNO_ifR7XgpZO89r9ZRWk8MOVzezmDff5KfLMp7g@mail.gmail.com>
In-Reply-To: <CANn89i+HYuqNO_ifR7XgpZO89r9ZRWk8MOVzezmDff5KfLMp7g@mail.gmail.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Tue, 22 Sep 2026 09:13:49 -0400
X-Gm-Features: AcwNN1UAobSneypZDRm5AEaXEmdxsqqxBxlScBCWnvk4mCfcbmcf4C0NVj22bjQ
Message-ID: <CAK-6q+hc2+7x1+WuqZtj7e8C9Vx3aL0DOyA7RA1G3ADqpoBJJQ@mail.gmail.com>
Subject: Re: [PATCH] dlm: fix send buffer backpressure handling
To: Eric Dumazet <edumazet@google.com>
Cc: David Teigland <teigland@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>, 
	gfs2@lists.linux.dev, Eric Dumazet <eric.dumazet@gmail.com>, netdev@vger.kernel.org, 
	stable@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2tYXq-KPGWjerR53r_I38mjGlY1rVIeFUSLWtyJ6an8_1790082841
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 21, 2026 at 9:10=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Mon, Sep 14, 2026 at 6:44=E2=80=AFPM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > lowcomms.c tests and clears SOCKWQ_ASYNC_NOSPACE in con->sock->flags,
> > but this bit has not been stored there for ten years.
> >
> > Commit 9cd3e072b0be ("net: rename SOCK_ASYNC_NOSPACE and
> > SOCK_ASYNC_WAITDATA") mechanically renamed the two dlm users, then
> > commit ceb5d58b2170 ("net: fix sock_wake_async() rcu protection") moved
> > the bit from socket->flags to the RCU protected socket_wq->flags, where
> > it is reachable only through sk_set_bit() and sk_clear_bit(), and is
> > only maintained for sockets having SOCK_FASYNC set.  dlm uses kernel
> > sockets, which never have SOCK_FASYNC set, and never sets the bit
> > itself, so the test in send_to_sock() has been false ever since.
> >
> > The consequence is that when sock_sendmsg() returns -EAGAIN because the
> > socket send buffer is full, dlm no longer sets CF_APP_LIMITED, does not
> > increment sk_write_pending, and does not return DLM_IO_END to wait for
> > lowcomms_write_space().  It returns DLM_IO_RESCHED instead, and
> > process_send_sockets() immediately requeues the send work.  A connectio=
n
> > to a peer that is slow to drain thus keeps cycling through
> > sock_sendmsg() and -EAGAIN, burning CPU, instead of sleeping until TCP
> > reports that space is available again.
> >
> > Test SOCK_NOSPACE instead.  This is the bit that lives in socket->flags=
,
> > that TCP sets whenever sendmsg() returns -EAGAIN for lack of send buffe=
r
> > space (tcp_sendmsg_locked() and sk_stream_wait_memory()), and that
> > lowcomms_write_space() already clears.  This restores the semantics dlm
> > had before the bit moved.
> >
> > Also remove the clear_bit() of SOCKWQ_ASYNC_NOSPACE from
> > lowcomms_write_space(), for the same reason.
> >
> > SCTP connections are deliberately left as they are.  SCTP does not set
> > SOCK_NOSPACE, and it never calls sk->sk_write_space(): sctp_wfree() end=
s
> > up in sctp_wake_up_waiters(), which calls sctp_write_space() directly.
> > lowcomms_write_space() is thus never invoked for an SCTP connection, an=
d
> > the test added here stays false, so send_to_sock() keeps returning
> > DLM_IO_RESCHED as it does today.  This is the only safe behavior, as
> > returning DLM_IO_END would wait for a callback that never comes.
> >
> > Fixes: ceb5d58b2170 ("net: fix sock_wake_async() rcu protection")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > ---
> >  fs/dlm/lowcomms.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
> > index 2aff1c7c17de..abe9ae4c643f 100644
> > --- a/fs/dlm/lowcomms.c
> > +++ b/fs/dlm/lowcomms.c
> > @@ -522,10 +522,8 @@ static void lowcomms_write_space(struct sock *sk)
> >         clear_bit(SOCK_NOSPACE, &con->sock->flags);
> >
> >         spin_lock_bh(&con->writequeue_lock);
> > -       if (test_and_clear_bit(CF_APP_LIMITED, &con->flags)) {
> > +       if (test_and_clear_bit(CF_APP_LIMITED, &con->flags))
> >                 con->sock->sk->sk_write_pending--;
> > -               clear_bit(SOCKWQ_ASYNC_NOSPACE, &con->sock->flags);
> > -       }
> >
> >         lowcomms_queue_swork(con);
> >         spin_unlock_bh(&con->writequeue_lock);
> > @@ -1391,7 +1389,7 @@ static int send_to_sock(struct connection *con)
> >         if (ret =3D=3D -EAGAIN || ret =3D=3D 0) {
> >                 lock_sock(con->sock->sk);
> >                 spin_lock_bh(&con->writequeue_lock);
> > -               if (test_bit(SOCKWQ_ASYNC_NOSPACE, &con->sock->flags) &=
&
> > +               if (test_bit(SOCK_NOSPACE, &con->sock->flags) &&
> >                     !test_and_set_bit(CF_APP_LIMITED, &con->flags)) {
> >                         /* Notify TCP that we're limited by the
> >                          * application window size.
> > --
> > 2.55.0.1007.g17ff1f9808-goog
> >
>
> Gentle ping ?
>
> I have an ongoing series for net-next removing one cache line miss in
> TCP sendmsg() and ACK processing,
> blocked by this patch.
>
> If you prefer, I can insert this patch into my net-next series.

I acked the patch in your patch series.

Again thanks for looking into that!

- Alex

