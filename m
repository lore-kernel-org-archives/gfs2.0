Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795207226;
	b=2rKVI0wa/73JEHBrlq+vjTsdub20a2Nc00p4DmlF3PdO61urFvPynXtFHGZd36b6OdEV
	 YpLAJq6gpVhZaHK8xH5z87HM7tfQOSubhdHVzjNhSuSlWYuGMx9XV3VyhxzFcGPs48z7K
	 XyCuAYyGhaHP5PD35AwHwMR51tu8l4G9BTdRXgYcBzQukex9DFJMxIGhhTzg6vGrWSWRm
	 XG8jgQoyQxR1jtgytaqLAcEHHX8ZimdBOdfucSmPAP9gaXNaQ8lUtyjjLSJP8nHYCCIIa
	 gu1plYLqneJFZS4Cbj7yhHum/H3dCVxJ7PwFiBTe44mKQCL2pjR/0drNnasgfV/kDbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795207226;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=R7MBPe9RyZXuJGK8uwnt8tfOC8Vd2TgDOs0wKutymvs=;
	b=Wmhk5UM+TZmeuHqQeKxwSo3S78i1qdDo0Lq2TIp6NLGnLjf1zrX+HmHiNOPJ7FZ6dRmE
	 VNSgZWfeTKBB2wzDXdfoYVrQFCGn0IfEVC630abxiD08JcDlyjbhDLMp1OoHSVMZgUNK/
	 cZ5ODb9gBr/HAWHJKRoV2WSL8BrlZnSIgPbDse8diI0TVrf8lBIPhzCoIuUuXxpyoGj2Q
	 P6MFCSbtsx/B+50SKreqHmwswXONbEredKlPO4U53PLwkuSto7mwBvkYJFPbY0mUVByy/
	 9mrOO7mettE2TwQNMwr2wmdKxfmzklubTV8ANPgBWKWN3/0q0+VCyf0Gx0Uspl25W1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PaUZnYwH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C2B606A6FA
	for <gfs2@lists.linux.dev>; Fri, 20 Nov 2026 20:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PaUZnYwH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D26C01F000C6;
	Fri, 20 Nov 2026 20:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795207226;
	bh=R7MBPe9RyZXuJGK8uwnt8tfOC8Vd2TgDOs0wKutymvs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PaUZnYwHYtqwjkHyNnHEorYzfp4fjKNOyddBsFb51pBJZv+VuIeAvtwoxt1+r/AGE
	 S3Qg3790ytSE8Ahok6hDDu+GRl6FzmWaD7+JBl70XxwJHVg7nf90GtIpDbgG1wAlrU
	 L4ssipu4XykmMwW/zL5Lv2oGLqUYZgcXtQB/E+07nWsmNBsvN+KLgukpnfgNaIGgaG
	 350AmfagEuH8GJyWGzOFEgMDGpP7765voXH2ZcJlqLL3T7f3uZuRttBz9jQ7VuDGFQ
	 pP8JCLGdfXiWR3EkGtBWwyW6YUJxrVTlmId/xp7cIv5DqPdEt2lb5MziWz3j4/HOwP
	 hCfLCVVc4i40A==
Message-ID: <sashiko-outbox-226084@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv2 RESEND v7.4-rc3 1/5] dlm: fix socket hang on send
 buffer limitation with socket error
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexander Aring" <aahringo@redhat.com>, teigland@redhat.com
Cc: gfs2@lists.linux.dev
In-Reply-To: <20261120200040.257152-2-aahringo@redhat.com>
References: <20261120200040.257152-1-aahringo@redhat.com>
 <20261120200040.257152-2-aahringo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 20:40:25 +0000
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Post: <mailto:gfs2@lists.linux.dev>
List-Help: <mailto:gfs2+help@lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
List-Owner: <mailto:gfs2+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [High] dlm: missing CF_APP_LIMITED clear in lowcomms_error_report()
  hangs send queue
- [High] dlm: unconditional swork queue in lowcomms_error_report()
  breaks invariants
- [Medium] dlm: race in send_to_sock() sets CF_APP_LIMITED after socket
  error
- [Low] dlm: missing Fixes trailer in commit message
--

commit 796bee147607d968d752eb2e6e9611c521fe108f
Author: Alexander Aring <aahringo@redhat.com>

> dlm: fix socket hang on send buffer limitation with socket error
>
> As Sashiko AI bot mentioned [0], a socket connection can get stuck when
> the send buffer limitation is reached and a socket error simultaneously
> occurs.
>
> This issue can be reproduced with the following setup:
> 1. Set sk_sndbuf to SOCK_MIN_SNDBUF.
> 2. Slow down DLM connections using netem.
> 3. Use tcpkill to randomly send TCP resets to DLM connections.
>
> I instrumented debug printouts to confirm that the sk_write_space()
> notifier callbacks were being executed, using step 3 to trigger random
> socket errors.
>
> With these changes, I can no longer reproduce the hang.
>
> Changes included:
> - Removed sk_write_pending counting, as this should not be modified
>   at the socket application layer (or is at least unnecessary).
> - Moved clearing the CF_SEND_PENDING bit=E2=80=94which allows re-queuing
>   swork (send worker for sendmsg())=E2=80=94to the sk_write_space() callb=
ack,
>   since this callback notifies us that the underlying socket is no longer
>   constrained by its send buffer.
> - Handled the race condition between sendmsg() and evaluating
>   SOCK_NOSPACE after sendmsg(), where sk_write_space() could be called
>   in between, using CF_APP_LIMITED:
>   - In sk_write_space(), queue swork again if CF_APP_LIMITED is set.
>   - If CF_APP_LIMITED is not set, do nothing as send_to_sock() will handle
>     it, confirming the race occurred.
> - Introduced new handling in lowcomms_error_report() when a socket error
>   occurs during send buffer limitation. If CF_APP_LIMITED is set, swork
>   will be re-queued, which will fail and trigger a reconnect.
> - Added various comments explaining the interaction with CF_APP_LIMITED.
>
> [0] https://lore.kernel.org/netdev/179090395863.434549.366849366725912075=
9@kernel.org/
>
> Signed-off-by: Alexander Aring <aahringo@redhat.com>

[Severity: Low]
Should this bug fix include a Fixes: tag for the commit that gated
lowcomms_queue_swork() on CF_APP_LIMITED?

  Fixes: dbb751ffab0b ("fs: dlm: parallelize lowcomms socket handling")

> diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
> index 3929b164dc0d4..6c972f1b412ca 100644
> --- a/fs/dlm/lowcomms.c
> +++ b/fs/dlm/lowcomms.c

[ ... ]

> @@ -623,6 +631,20 @@ static void lowcomms_error_report(struct sock *sk)
>  		break;
>  	}
> =20
> +	/* if waiting on sk_write_space() and an sk_err occurs, the callback
> +	 * won't fire. Clear CF_SEND_PENDING so resend tasks can re-queue
> +	 * swork, triggering a sendmsg() failure to initiate reconnection.
> +	 */
> +	spin_lock_bh(&con->writequeue_lock);
> +	clear_bit(CF_SEND_PENDING, &con->flags);
> +	/* dlm_midcomms_unack_msg_resend() does not always
> +	 * trigger lowcomms_queue_swork() as it tries to
> +	 * avoid to put pending messages into the lowcomms
> +	 * sending buffer. Force it here again.
> +	 */
> +	lowcomms_queue_swork(con);
> +	spin_unlock_bh(&con->writequeue_lock);
> +
>  	dlm_midcomms_unack_msg_resend(con->nodeid);
> =20
>  	listen_sock.sk_error_report(sk);

[Severity: High]
Does lowcomms_error_report() also need to clear CF_APP_LIMITED before
calling lowcomms_queue_swork(con)?

lowcomms_queue_swork() refuses to schedule con->swork while CF_APP_LIMITED
is set:

fs/dlm/lowcomms.c:lowcomms_queue_swork() {
	if (!test_bit(CF_IO_STOP, &con->flags) &&
	    !test_bit(CF_APP_LIMITED, &con->flags) &&
	    !test_and_set_bit(CF_SEND_PENDING, &con->flags))
		queue_work(io_workqueue, &con->swork);
}

When a socket error arrives while CF_APP_LIMITED is set, sk_write_space()
will not fire, so leaving CF_APP_LIMITED set here causes every
lowcomms_queue_swork(con) call to be a no-op and leaves the connection
permanently hung.

[Severity: High]
Should lowcomms_error_report() only clear CF_SEND_PENDING and queue
con->swork when test_and_clear_bit(CF_APP_LIMITED, &con->flags) succeeds,
matching lowcomms_write_space()?

Accepting a crossover connection in accept_from_sock() attaches the socket
to othercon (which has CF_IS_OTHERCON set) via add_sock(), installing
lowcomms_error_report() as sk_error_report.  Because othercon is
receive-only, unconditionally queuing con->swork on a socket error
schedules process_send_sockets() on othercon, triggering
WARN_ON_ONCE(test_bit(CF_IS_OTHERCON, &con->flags)) and entering an
infinite reconnect loop calling dlm_connect(othercon) once othercon->sock
is closed.

On a primary connection where CF_APP_LIMITED is not set, unconditionally
clearing CF_SEND_PENDING also breaks swork serialization on the unbound
io_workqueue by allowing a second con->swork to be queued while
process_send_sockets() is already running.

> @@ -1391,22 +1413,19 @@ static int send_to_sock(struct connection *con)
>  		spin_lock_bh(&con->writequeue_lock);
>  		if (test_bit(SOCK_NOSPACE, &con->sock->flags) &&
>  		    !test_and_set_bit(CF_APP_LIMITED, &con->flags)) {
> -			/* Notify TCP that we're limited by the
> -			 * application window size.
> -			 */
> -			sk_set_nospace(con->sock->sk);
> -			con->sock->sk->sk_write_pending++;
> -
> -			clear_bit(CF_SEND_PENDING, &con->flags);
>  			spin_unlock_bh(&con->writequeue_lock);
>  			release_sock(con->sock->sk);
> =20
> -			/* wait for write_space() event */
> +			/* wait for sk_write_space() event */
>  			return DLM_IO_END;
>  		}
>  		spin_unlock_bh(&con->writequeue_lock);
>  		release_sock(con->sock->sk);
> =20
> +		/* the sk_write_space() came in between sock_sendmsg()
> +		 * and check on SOCK_NOSPACE and the socket became
> +		 * writeable again so just resched swork.
> +		 */
>  		return DLM_IO_RESCHED;
>  	} else if (ret < 0) {
>  		return ret;

[Severity: Medium]
Can send_to_sock() still set CF_APP_LIMITED and hang after a socket error
if the error arrives before lock_sock()?

kworker                                <softirq>
send_to_sock()
  sock_sendmsg()
    ...
      sk_set_nospace()
      return -EAGAIN
                                       tcp_v4_rcv() (TCP RST)
                                         tcp_reset()
                                           tcp_done_with_error()
                                             lowcomms_error_report()
  lock_sock(sk)
  spin_lock_bh(&con->writequeue_lock)
  test_bit(SOCK_NOSPACE, ...)
  !test_and_set_bit(CF_APP_LIMITED, ...)
  return DLM_IO_END  <-- waits forever

Unlike lowcomms_write_space(), neither tcp_done_with_error() nor
lowcomms_error_report() clears SOCK_NOSPACE.  When send_to_sock() then
checks SOCK_NOSPACE without checking sk->sk_err, it sets CF_APP_LIMITED
after lowcomms_error_report() has already finished and returns DLM_IO_END
on a dead socket that will never fire sk_write_space() or
sk_error_report() again.  Checking !con->sock->sk->sk_err under lock_sock()
(or clearing SOCK_NOSPACE in lowcomms_error_report()) would avoid entering
CF_APP_LIMITED on an errored socket.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120200040.2571=
52-1-aahringo@redhat.com?part=3D1
