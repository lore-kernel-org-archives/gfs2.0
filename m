Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5322E7378
	for <gfs2@lists.linux.dev>; Tue, 22 Sep 2026 01:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790039443; cv=pass; b=gLkSheGoIZmlezAWmCse2zTsEvHRK0wuZA9y+ZVcaCrteCOYA6ONMkv0bcOTcawpAd6wuosYTW+qpl9Jedceq2YXx1aOtaDrZc9SbNTQAB9bPKOMZxwAcKGX8V0X9Ks1wCEU9nS3BRdHlJWLpfp4huAPJewgTQv5AS+o7E8FUQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790039443; c=relaxed/simple;
	bh=rDphcxVK0cLwUUna1tpHZp2v6qK6oFhLgiPUmxWlUKc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m0lLfGGE0BHRVRMpiAysvadCturrbwwWSLlHR3EtIsfZfmNPnuUoaAnY6ZxCtW6jM2aOmSg6m10aNV5xf8PzQpKYARsUPJ1Q9VvROiS93wcXgnmNvuVk1xZDkMSYhqE584Fj2iHYT9Yt0zd4AVEyJ1eLaSF3wr2TRRKVIB6QF9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qijog01E; arc=pass smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qijog01E"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-52fb76c9deeso42935041cf.1
        for <gfs2@lists.linux.dev>; Mon, 21 Sep 2026 18:10:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790039440; cv=none;
        d=google.com; s=arc-20260327;
        b=Jn4DM0P/iQZyawD8tET1RLXf+MrhsNVeAlgP3DC4H9UUhK+ALxDrUN1EqzJTeH19hb
         Yg/x7nCyjGoeO89NJcSz8V/8A5uztmIXBC3trzhZ8TkBQ1PvYvyRm9tvg/D39yu3XF9M
         wrHbh7LMrlXltcp/WwJ1U86RcNVKPS8Iqzao3Ev+SQvkpQOfF1aEWFIVxBip0uBGX8Hx
         LmWysyjfWRY9zLOp0rOa82v09iUO7y/APZXTvYu1GBdD77MrqbuHXogEqFc11uomXm1x
         /zSYv9gr6T4BdCl9/dRt0WVIZPDS4aGg55XxdyENfAwhEzuo2rpYmfWCvZ2EVi3RrDi4
         mxNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=u6Z2U4vAuJb/VjzAk0+RtK9FDIXwMhOB79JAT2yh+ek=;
        fh=DOvZVE/v+KghiM/6hKpaHtzlfu9xh0fjvQX6KWiGVg4=;
        b=nHT0ZWab8oGK9rZSS5cxWlsNX+26kA6iOsMA3wdJ8ng6iPaXpawnHfT6g26JPmmvNS
         YrSK1wQsLheza3oDTWrUMw5tzLzVVRfn4XxU8Sm76t+GAyHT1cqF44oF0UxUMwlhJqJx
         VkebhHFxdEovU64BGceHmtJVERhusFamqoguadsBeUTS0EABcNrPeM5LT9lLz28/UvEN
         KMbYkna/jY6/FyGWf2OKHNPjbfu+04UII4Isj1pqFthGik7RItzY9WFkphDAs91pJpK0
         HcD3wkdlQCnosCNkwvk1EeJlvXGx7wsAtHO8ml2oXkmYNimbRyPEIz/CAJX7Zyok1YgI
         9qKg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790039440; x=1790644240; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=u6Z2U4vAuJb/VjzAk0+RtK9FDIXwMhOB79JAT2yh+ek=;
        b=qijog01E5z0xNzySItpC+6jBCCfZ0SzRN60gCi/MOKgIw4wbAN5StkhvFftXzcn18x
         IYK7PumUJ+WRPhAXDryUTJkUUFFnNLkiI7O66ELq0QB6x5z2klP0cAsHfD9zvvy0S+s8
         LqJvE0SYFHpw/oEJ7mnCic6w7QeedRXcDGoNwPhS7l3n77OWiq6NpHDLJZir3N3E+1dR
         V8rGDQfeYg0cg/0rv9KM8Es1Qt2usa7rlo//jNnpUwz/lBOV3eaPxnUeozV/rlnoZEtH
         xCEYieRN9CEA07N5uDaGD4NKA6+iB7GWAO2xwHkBoaWj9FamQoYaPMXCgtDU0iqSZl0W
         YyXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790039440; x=1790644240;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u6Z2U4vAuJb/VjzAk0+RtK9FDIXwMhOB79JAT2yh+ek=;
        b=jxMkB+NEooJyltmk+vHvJm8ieTz6p4r0ywtGqXqarj2g4FEYbfzhrEIRVqN/a5BGod
         +ROY6FvcFPqAlj+w510KrJ2dAYfQrJucF/mSKDw+razKR/tTIJcUVxzYyXxNc+kyJNFx
         YYk6B5vVr4lqGo++aFOi+yupoa1avbUrRYCXBzeXTMcccpZbkCYDWbDRaukRClEYdfdu
         2bzp6LuScDbly+PgqVISeb63EEG3MP8yGLFsBOh7vsL44Z4cZY3nlVMbujL7bPeWbCVV
         Xex7VRHX6B5xVhc9mev6E5hubxTTdb9Pd1LDlRJrKNcyWHFpXx/bww0gTl7CrNpvSX+g
         7tZw==
X-Forwarded-Encrypted: i=1; AKwUvBxlZtLjjjDjBUdATkD+zkgxnVsYWSPBCzJwAAg1GaE/cGrM5+M1/KRDIhXG4fGVKzpOwp4J@lists.linux.dev
X-Gm-Message-State: AFuF++l2AJ+zyDXU0FvD/bFSmlj3H8AaBtaXrm7Q+8x941jKPzYupq/r
	LqJ+AcY2JOqAgEW8PDXqI3wmBprKxwUUPjrzlTvXqf9sBu0612pKX7snZZg2N4cA4RCQgORUlkW
	nNbQPMnkngqTienszPcZew/PBjSexQJ4nmimOcDFV
X-Gm-Gg: AYBFou2egzOXEIzqyOPWrJenBNz+A4yvpY38bEhRfkCfPyjjCn+9lCHKrX0k9JjPtgo
	1j87Ox4Mp91d82GqWLCBjN4NH5TRv+x1k8bNklKJ6eEhB0icO1yqWCDSLNY+z5Fj3yu+Yglgm6t
	eZTv5He0MS6LMgGce3PH0oEi5y2l7i5E9NynN4Rzr1HqKttF2+lzqTg9o14y7N+xoVnQANpZgTK
	MHue5mQANjT/WFz0aVpg18phUqFxsbx9H0m7b3QmgZ/clvZUuC9pt4GCQsjwWWptiKQ8rcnM6SN
	fOMTtC4gB1ktqGaN4t0NjyyFsOx2uT8gGImvFPjIgxT40RkTI3MnvX4K//KLW6snnt1U2dp/2LI
	2cm2Vy0VXksfbxs9PIDBI2HS66j0chisWRxcqY9rXgxsujxGNbe92szu3VH00GnABJ7BLvg==
X-Received: by 2002:a05:622a:2287:b0:52e:8ef:5960 with SMTP id
 d75a77b69052e-532d8e32ebfmr30057471cf.33.1790039439462; Mon, 21 Sep 2026
 18:10:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260914164400.2738350-1-edumazet@google.com>
In-Reply-To: <20260914164400.2738350-1-edumazet@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 22 Sep 2026 03:10:27 +0200
X-Gm-Features: AcwNN1XENI3C6DJEuWKSVfu123kER72zrEHAvPUuiU4gn9CTQlz-0sfrY4BfkQw
Message-ID: <CANn89i+HYuqNO_ifR7XgpZO89r9ZRWk8MOVzezmDff5KfLMp7g@mail.gmail.com>
Subject: Re: [PATCH] dlm: fix send buffer backpressure handling
To: Alexander Aring <aahringo@redhat.com>, David Teigland <teigland@redhat.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, gfs2@lists.linux.dev, 
	Eric Dumazet <eric.dumazet@gmail.com>, netdev@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 6:44=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> lowcomms.c tests and clears SOCKWQ_ASYNC_NOSPACE in con->sock->flags,
> but this bit has not been stored there for ten years.
>
> Commit 9cd3e072b0be ("net: rename SOCK_ASYNC_NOSPACE and
> SOCK_ASYNC_WAITDATA") mechanically renamed the two dlm users, then
> commit ceb5d58b2170 ("net: fix sock_wake_async() rcu protection") moved
> the bit from socket->flags to the RCU protected socket_wq->flags, where
> it is reachable only through sk_set_bit() and sk_clear_bit(), and is
> only maintained for sockets having SOCK_FASYNC set.  dlm uses kernel
> sockets, which never have SOCK_FASYNC set, and never sets the bit
> itself, so the test in send_to_sock() has been false ever since.
>
> The consequence is that when sock_sendmsg() returns -EAGAIN because the
> socket send buffer is full, dlm no longer sets CF_APP_LIMITED, does not
> increment sk_write_pending, and does not return DLM_IO_END to wait for
> lowcomms_write_space().  It returns DLM_IO_RESCHED instead, and
> process_send_sockets() immediately requeues the send work.  A connection
> to a peer that is slow to drain thus keeps cycling through
> sock_sendmsg() and -EAGAIN, burning CPU, instead of sleeping until TCP
> reports that space is available again.
>
> Test SOCK_NOSPACE instead.  This is the bit that lives in socket->flags,
> that TCP sets whenever sendmsg() returns -EAGAIN for lack of send buffer
> space (tcp_sendmsg_locked() and sk_stream_wait_memory()), and that
> lowcomms_write_space() already clears.  This restores the semantics dlm
> had before the bit moved.
>
> Also remove the clear_bit() of SOCKWQ_ASYNC_NOSPACE from
> lowcomms_write_space(), for the same reason.
>
> SCTP connections are deliberately left as they are.  SCTP does not set
> SOCK_NOSPACE, and it never calls sk->sk_write_space(): sctp_wfree() ends
> up in sctp_wake_up_waiters(), which calls sctp_write_space() directly.
> lowcomms_write_space() is thus never invoked for an SCTP connection, and
> the test added here stays false, so send_to_sock() keeps returning
> DLM_IO_RESCHED as it does today.  This is the only safe behavior, as
> returning DLM_IO_END would wait for a callback that never comes.
>
> Fixes: ceb5d58b2170 ("net: fix sock_wake_async() rcu protection")
> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  fs/dlm/lowcomms.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
> index 2aff1c7c17de..abe9ae4c643f 100644
> --- a/fs/dlm/lowcomms.c
> +++ b/fs/dlm/lowcomms.c
> @@ -522,10 +522,8 @@ static void lowcomms_write_space(struct sock *sk)
>         clear_bit(SOCK_NOSPACE, &con->sock->flags);
>
>         spin_lock_bh(&con->writequeue_lock);
> -       if (test_and_clear_bit(CF_APP_LIMITED, &con->flags)) {
> +       if (test_and_clear_bit(CF_APP_LIMITED, &con->flags))
>                 con->sock->sk->sk_write_pending--;
> -               clear_bit(SOCKWQ_ASYNC_NOSPACE, &con->sock->flags);
> -       }
>
>         lowcomms_queue_swork(con);
>         spin_unlock_bh(&con->writequeue_lock);
> @@ -1391,7 +1389,7 @@ static int send_to_sock(struct connection *con)
>         if (ret =3D=3D -EAGAIN || ret =3D=3D 0) {
>                 lock_sock(con->sock->sk);
>                 spin_lock_bh(&con->writequeue_lock);
> -               if (test_bit(SOCKWQ_ASYNC_NOSPACE, &con->sock->flags) &&
> +               if (test_bit(SOCK_NOSPACE, &con->sock->flags) &&
>                     !test_and_set_bit(CF_APP_LIMITED, &con->flags)) {
>                         /* Notify TCP that we're limited by the
>                          * application window size.
> --
> 2.55.0.1007.g17ff1f9808-goog
>

Gentle ping ?

I have an ongoing series for net-next removing one cache line miss in
TCP sendmsg() and ACK processing,
blocked by this patch.

If you prefer, I can insert this patch into my net-next series.

Thanks.
