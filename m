Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C7C3BC668
	for <gfs2@lists.linux.dev>; Thu,  1 Oct 2026 15:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790869787; cv=none; b=nf6v9R7j8Emcaws7cWWc3uMC+IMs+oDGC1NEuffvXvc3pV0oa+PQxyiRLm2Msjv/Va29keqp6IMO3q7YGnvYEe4mJuS+5EvvFnj8ZuhqE36pYDF+VTe372Cvsm0YYxilD8ly84qAbwMj0D6SE05qXhpsvp+sEFrOiqDTu2yziOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790869787; c=relaxed/simple;
	bh=imGym7H3xdk+9H7Fls0NrMjMZi/9ARkfuUXchkCCb1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I/ZriCPeJ5yF3j8pWCqFzl8/vhQ+nMLsvf7vV0zJmPOeYtQfXtOXRDZ8eILVd5dtawfaJQdmqGFXKQcfyXs5M5o1EuiJzGk8lsCFhPrSzXnCcj8PZ+3VKEsR1tIOIE1Ie/KlyBKduaRziAu2J1/O//3fNwJOp92QvCgwC4ESNAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KUDaYAO8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KUDaYAO8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790869784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cHiqWfgtBsJj8mrcl3AxgZnDW5A+tCT50pFobrqOgrs=;
	b=KUDaYAO88pZOFJ9TD2aDO6/9b6OvOoVEfXZEbq6Le/rQy8vQGLeFWL5tnSHqkNBt+GZWu/
	nWQi4JgmB2Z8mDCYu/g/u9Ngj2XrADFP0Ry/WYsYuyM2dFLDxvFSGdMLSLoIlWF3PRE6ON
	wkbjBfi1K6T5TcfWqK/VNwgDSTEv+3k=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-T6NdNO6kMY6SJLK-MUXnFQ-1; Thu, 01 Oct 2026 11:49:43 -0400
X-MC-Unique: T6NdNO6kMY6SJLK-MUXnFQ-1
X-Mimecast-MFC-AGG-ID: T6NdNO6kMY6SJLK-MUXnFQ_1790869782
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-3a77cbb4202so10989421fa.2
        for <gfs2@lists.linux.dev>; Thu, 01 Oct 2026 08:49:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790869781; x=1791474581;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cHiqWfgtBsJj8mrcl3AxgZnDW5A+tCT50pFobrqOgrs=;
        b=aZgSh6nyKKhlQ/Js5TXByntWicNcyVcNBrzGt29I2cyZk8bqgAfUzK6Bsg4mPhxO+M
         +7yvJHBCch0GjOdZcmTegCKbg70TAH32Y+wzZAeXEG4lLSXjwHNBI/bilayDWhIBpHBR
         dp2WbPgxY62/o2xwgsTdEiGRW7YOb8UfboT0ySlxSsJ1f3C1JDLezdEe1Xea0/mP/RIN
         xOe6ApbzS66rHlpqmBVdWeJG+xzpYXXFiSlTECXocu3fQS5r2YULElTX40yrBPlATrJ5
         XgtkFEQ4DOII0Nl4JJwVeTVYItWtgpO0iUCSixfJm5+DchH4G6KqNZofqkzkJV+Fg1WX
         DSRA==
X-Forwarded-Encrypted: i=1; AKwUvBwtk1t3ZjZF6Q7aVIFIuaz9X7KtGEjCqOvXzCWySBj0kAJvA5WmCsz2T6MuJkgto4H9yecO@lists.linux.dev
X-Gm-Message-State: AFq9FYIZ0tC5UyCcjfUOhR1qPIYqtEIQ+no+9rrjKp5u1UuOhbY2ZwTu
	NDG3ZE43oMjFMJfb6lLluEyIbG0uqpOViE8KwDjNQC8fHtCvNBVgjzAAb2Ns0rM3hT2br+rCY7Q
	1QTEnz8dGVrrYnJ4I0VFhjx++nhhdlctSLwZfWF4xU6Mv2cc13ZRzKuip9Y3YDrrNlS9YDWz9TN
	mifjlj/yf5xiAm1dq8ipeUH9Y1hZRFmA==
X-Gm-Gg: AYBFou3OJRvvPhfFgUSakqtt73yZAdUJZDqKqKqZVLs0ZefxiDTfjMAZYamiLtVM4H0
	qktMltuym0g/zWaYthdlXw6Qm/yOYxiSTdCRNPESvX3o/qqbsPGiJOWvqZ/bR6NuoOIO2hxaFdA
	6+iM0hejdZKUOJ764P0oPBGvVqB2JqzWM8/qQHetH3M+Z4YNknrcRbUXZk
X-Received: by 2002:a05:651c:a383:20b0:3a6:772c:2757 with SMTP id 38308e7fff4ca-3a7791ee046mr12891271fa.12.1790869781445;
        Thu, 01 Oct 2026 08:49:41 -0700 (PDT)
X-Received: by 2002:a05:651c:a383:20b0:3a6:772c:2757 with SMTP id
 38308e7fff4ca-3a7791ee046mr12891221fa.12.1790869781005; Thu, 01 Oct 2026
 08:49:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260824103743.162021-1-mark.syms@citrix.com>
In-Reply-To: <20260824103743.162021-1-mark.syms@citrix.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Thu, 1 Oct 2026 11:49:29 -0400
X-Gm-Features: AclHuK_XYJjaW4qt7cQr70fmk2TN8aul5VWC1WmotVfQRvrZ757v_TPaaezUEoM
Message-ID: <CAK-6q+hZ_RfT-0ryGqtfnwamDwPE8D6dXJ7t4iBqRT0Ep-yh1w@mail.gmail.com>
Subject: Re: [PATCH] dlm: bound TCP failure detection with TCP_USER_TIMEOUT
To: Mark Syms <mark.syms@citrix.com>
Cc: teigland@redhat.com, gfs2@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7YKhWdd0V3-0Rdby4Blln56fpSK6QA1eKNGIZcSv8Aw_1790869782
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

sorry for the late reply,

On Mon, Aug 24, 2026 at 6:47=E2=80=AFAM Mark Syms <mark.syms@citrix.com> wr=
ote:
>
> DLM sets no timeout of any kind on its TCP sockets. When a connection
> blackholes - the peer is still up, but the flow is silently broken - DLM
> only finds out once TCP itself gives up after tcp_retries2
> retransmissions, which is around 15 minutes with the default value of
> 15.
>
> Until then the reliable transmission layer cannot make progress:
> dlm_midcomms_unack_msg_resend() is only ever called from the socket
> error/close path, so the unacknowledged message stays queued and every
> node waiting on a lock held by the stuck node waits with it. This was
> observed as a cluster-wide GFS2 stall of just under 16 minutes, with all
> five nodes blocked in gfs2_glock_wait() on a single inode glock whose EX
> holder could not be demoted because one DLM message to one peer was
> stranded on a dead socket. Once TCP finally reported the error the
> socket was reconnected, the message retransmitted, and the cluster
> recovered in about two seconds.
>

I never experienced this behaviour. What you describe suggests the
master node would send a GRANT message to nodes in contention if it
can be granted.
As soon as this message cannot be delivered for whatever reason and
sendmsg() fails it should close the socket and retransmit.

However, if this parameter makes your life easier and resolves an
issue, I believe upstreaming this tweak should do no harm and will
improve the situations you describe above.

> The only lever available today is the system wide net.ipv4.tcp_retries2
> sysctl, which also governs iSCSI, NFS and every other TCP user on the
> host.
>
> Set TCP_USER_TIMEOUT on DLM sockets instead, so that DLM bounds its own
> failure detection independently of the global TCP tuning, and expose it
> as a new cluster configfs attribute tcp_user_timeout_secs alongside
> mark. Zero keeps the previous behaviour of relying on tcp_retries2.
>
> On expiry the socket is aborted with ETIMEDOUT, which drives the
> existing lowcomms_error_report() -> dlm_midcomms_unack_msg_resend()
> path, i.e. exactly the recovery that already unwound the stall, just
> promptly. Because the option is applied before connect() it also caps
> SYN retransmission, which is harmless here as dlm_connect() retries
> indefinitely.
>
> The value is read when a socket is created, so a change made through
> configfs takes effect for subsequent connections.
>
> Accepted sockets now get the protocol socket options set explicitly
> rather than inheriting them from the listening socket, so that inbound
> connections also pick up the current configuration.
>
> SCTP is not affected; TCP_USER_TIMEOUT has no SCTP equivalent.
>
> Signed-off-by: Mark Syms <mark.syms@citrix.com>
> ---
>  fs/dlm/config.c   | 16 ++++++++++++++++
>  fs/dlm/config.h   |  1 +
>  fs/dlm/lowcomms.c | 20 ++++++++++++++++++++
>  3 files changed, 37 insertions(+)
>
> diff --git a/fs/dlm/config.c b/fs/dlm/config.c
> index 53cd33293042..dd4d741c8797 100644
> --- a/fs/dlm/config.c
> +++ b/fs/dlm/config.c
> @@ -98,6 +98,7 @@ enum {
>         CLUSTER_ATTR_NEW_RSB_COUNT,
>         CLUSTER_ATTR_RECOVER_CALLBACKS,
>         CLUSTER_ATTR_CLUSTER_NAME,
> +       CLUSTER_ATTR_TCP_USER_TIMEOUT_SECS,
>  };
>
>  static ssize_t cluster_cluster_name_show(struct config_item *item, char =
*buf)
> @@ -220,6 +221,17 @@ static int dlm_check_zero(unsigned int x)
>         return 0;
>  }
>
> +static int dlm_check_tcp_user_timeout_secs(unsigned int x)
> +{
> +       /* zero disables the timeout, anything else must survive the
> +        * conversion to the milliseconds tcp_sock_set_user_timeout() tak=
es
> +        */
> +       if (x > INT_MAX / MSEC_PER_SEC)
> +               return -EINVAL;
> +
> +       return 0;
> +}
> +
>  static int dlm_check_buffer_size(unsigned int x)
>  {
>         if (x < DLM_MAX_SOCKET_BUFSIZE)
> @@ -237,6 +249,7 @@ CLUSTER_ATTR(log_debug, NULL);
>  CLUSTER_ATTR(log_info, NULL);
>  CLUSTER_ATTR(protocol, dlm_check_protocol_and_dlm_running);
>  CLUSTER_ATTR(mark, NULL);
> +CLUSTER_ATTR(tcp_user_timeout_secs, dlm_check_tcp_user_timeout_secs);
>  CLUSTER_ATTR(new_rsb_count, NULL);
>  CLUSTER_ATTR(recover_callbacks, NULL);
>
> @@ -254,6 +267,7 @@ static struct configfs_attribute *cluster_attrs[] =3D=
 {
>         [CLUSTER_ATTR_NEW_RSB_COUNT] =3D &cluster_attr_new_rsb_count,
>         [CLUSTER_ATTR_RECOVER_CALLBACKS] =3D &cluster_attr_recover_callba=
cks,
>         [CLUSTER_ATTR_CLUSTER_NAME] =3D &cluster_attr_cluster_name,
> +       [CLUSTER_ATTR_TCP_USER_TIMEOUT_SECS] =3D &cluster_attr_tcp_user_t=
imeout_secs,
>         NULL,
>  };
>
> @@ -1031,6 +1045,7 @@ int dlm_our_addr(struct sockaddr_storage *addr, int=
 num)
>  #define DEFAULT_LOG_INFO           1
>  #define DEFAULT_PROTOCOL           DLM_PROTO_TCP
>  #define DEFAULT_MARK               0
> +#define DEFAULT_TCP_USER_TIMEOUT_SECS 0
>  #define DEFAULT_NEW_RSB_COUNT    128
>  #define DEFAULT_RECOVER_CALLBACKS  0
>  #define DEFAULT_CLUSTER_NAME      ""
> @@ -1046,6 +1061,7 @@ struct dlm_config_info dlm_config =3D {
>         .ci_log_info =3D DEFAULT_LOG_INFO,
>         .ci_protocol =3D DEFAULT_PROTOCOL,
>         .ci_mark =3D DEFAULT_MARK,
> +       .ci_tcp_user_timeout_secs =3D DEFAULT_TCP_USER_TIMEOUT_SECS,
>         .ci_new_rsb_count =3D DEFAULT_NEW_RSB_COUNT,
>         .ci_recover_callbacks =3D DEFAULT_RECOVER_CALLBACKS,
>         .ci_cluster_name =3D DEFAULT_CLUSTER_NAME
> diff --git a/fs/dlm/config.h b/fs/dlm/config.h
> index 4ebd45f75276..3843d3bf0d0e 100644
> --- a/fs/dlm/config.h
> +++ b/fs/dlm/config.h
> @@ -41,6 +41,7 @@ struct dlm_config_info {
>         unsigned int ci_log_info;
>         unsigned int ci_protocol;
>         unsigned int ci_mark;
> +       unsigned int ci_tcp_user_timeout_secs;
>         unsigned int ci_new_rsb_count;
>         unsigned int ci_recover_callbacks;
>         char ci_cluster_name[DLM_LOCKSPACE_LEN];
> diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
> index 2aff1c7c17de..571a4d4094ec 100644
> --- a/fs/dlm/lowcomms.c
> +++ b/fs/dlm/lowcomms.c
> @@ -1049,6 +1049,12 @@ static int accept_from_sock(void)
>
>         sock_set_mark(newsock->sk, mark);
>
> +       /* set the socket options explicitly instead of relying on them b=
eing
> +        * inherited from the listening socket, so that an accepted socke=
t
> +        * picks up the current configuration
> +        */
> +       dlm_proto_ops->sockopts(newsock);
> +

Yes you can do that, but someone else will remove it later as the
socket implementation should already handle this; if it doesn't, the
problem lies there.

>         down_write(&newcon->sock_lock);
>         if (newcon->sock) {
>                 struct connection *othercon =3D newcon->othercon;
> @@ -1839,8 +1845,22 @@ static int dlm_tcp_listen_validate(void)
>
>  static void dlm_tcp_sockopts(struct socket *sock)
>  {
> +       unsigned int timeout_secs;
> +
>         /* Turn off Nagle's algorithm */
>         tcp_sock_set_nodelay(sock->sk);
> +
> +       /* Bound the time a message may stay unacknowledged on a silently
> +        * broken flow. Without this DLM only finds out that a connection=
 is
> +        * dead once TCP gives up after tcp_retries2, which is roughly 15
> +        * minutes with the default value of 15, and every lockspace user
> +        * waiting on a lock held by that node stalls for as long. On exp=
iry
> +        * the socket is aborted, the error report path resends the
> +        * unacknowledged messages and lowcomms reconnects.
> +        */
> +       timeout_secs =3D READ_ONCE(dlm_config.ci_tcp_user_timeout_secs);
> +       if (timeout_secs)
> +               tcp_sock_set_user_timeout(sock->sk, timeout_secs * MSEC_P=
ER_SEC);

why making this value not the same dimension as
tcp_sock_set_user_timeout() handles it, msecs?

- Alex

