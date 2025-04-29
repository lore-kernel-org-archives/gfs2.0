Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783CD8F49
	for <gfs2@lists.linux.dev>; Tue, 29 Apr 2025 07:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745910588; cv=none; b=kc8yXOk04Xzf7XF55c4lPr6+CqmjmwGSiABRuy4EuI/JK2T7SQJO54ghA99HVIb7+drd3qJpZ4Q+WbdNrgo5SRbAI33dAb9sC2oY2IaVFYoa33WL8Lolaw2UlYMn2E6mBRgIl9TSk10YN0yKhd6YYT8S4To/hEy7CsiYfLb2rDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745910588; c=relaxed/simple;
	bh=Z/RrqAkkhfDnbX41vnDu+B1ALC7jYtR/6KxkCppBu4Q=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=LVuxfnsizwqo0IiRJu14C9kn//fgWIgZyYbjXRlpL/CSqIHP/4WTZMY54sTkqr9GjkMiG3g8stcZA27Q5stiI1wfRpMjiEtkKF5633Ul9smFFERDCodb6g/GIHKYXQ80fGbhwVLGO7iiCwVy/KyTsedc61Pn51zClQCQTzt3Yzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cQVH5UaV; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cQVH5UaV"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43d0c18e84eso26963545e9.3
        for <gfs2@lists.linux.dev>; Tue, 29 Apr 2025 00:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1745910584; x=1746515384; darn=lists.linux.dev;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hiGZppm4aFUGATxI6PvNW6XbsqfqvDrzjmlDkBowWs8=;
        b=cQVH5UaVbJ+V7skMbJh/qUUDQE4iyF5zstBwdo7v2eqgl7LsAhHivgzXjjBJAjtyjy
         JAFzYNI+RPufZcvHfBhRYAea43yo8/2/XPty6DjRJPUDS/F1Hy1mKqafdjEcgmSM9W5y
         zimJooZSS+7o+rYIlyCAD8raKFYeAgbQlxbTNG94PRdO8xKYNnM1gfsM3OF7N0X0rdJ4
         j90Y+6+Qd8vVkv0zScUpyaS/srnM6k6bQzt2AqvLN7sH1qwx2PY/mUT/DN69kpirGfb9
         CxX/9S26qpiErlJbyadj3lQy8zy6ClsIJHn/Kpiu/Qhp+QzkxWdIZzfyxMCoKk8PVt/a
         2IPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745910584; x=1746515384;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hiGZppm4aFUGATxI6PvNW6XbsqfqvDrzjmlDkBowWs8=;
        b=DhATFOK+gzMJA4+twqi1AYEGuHfKSlxcJ2PzSqs2vefdMtsrFMNw9n3Wl6iVZU8dER
         q15iYLNI8VcgGsTgz6ynbakJsaYjTsX4p8d744wtrSTyvhRvEoNpLP5XJjS0J+8i6y4k
         eA0kXreudayfdIH4tFbzlAshJaAt4fxfLWsJVpEvzYsGqF7jj6WdPZK1BbPT0nYPZuam
         npJoTXfYE+XDr8hJ42c0hQV0WZywpTBKxvxXBkRcJjd7gs8bZpM1vbuA3z12lSK+69+7
         76mkCd7HDFdXl8PGHFlgB9hdTL+5ypOQN2qojUOwbg4I9soFKjUBnRf01G2YvaC1mT4c
         T8Xw==
X-Gm-Message-State: AOJu0Yw1FeRUrLm76Ka4NSEfsiPaaKIdd43z83G0SPZqhpTT/o6vprN3
	B5GnYInvFvBp0WI9Co5pEL7B/IwiLqaCBgW7DiVbKIfc5EG1UmrGwlBQehUxtjDAcEEqhP1ryDH
	Lcmo=
X-Gm-Gg: ASbGnctYicBRlwKj+PZ37rjIs+TK7g7U6+sv6pwhu9tvvLEBgvQgGiUQwSx/+gQTuPP
	jkS0Q8PLEWah8xTKJSwiQxgkARGc4XAjsBPsPPgILbF0b4KdOjPCRBhQ2URL3Mr34b+1xMOl7ku
	BMVCapaJ+DY8wMMhFPidAbH8KTk/FdnfLrsmi9VLEjmRC7qcGaMU1gas8y4D5z/YZFRIt3yMxWM
	gtD3TMCWFpKYKQ7112RlyNbNUJEM2uHD3fZ4cqzfze2gzFBqQ7lppbAOlfYcl/MaFY7/Kj/tmi+
	vsQSCt5eoOEdu7ZSl1BspLgT+jIyNqbx+7e50lmIoKX5fg1lyp5sHwA=
X-Google-Smtp-Source: AGHT+IHnYT6VWxaVC1Yhs10pIYBf1sOp6cDtJxKseMyKpM2YQPg7pnPyPhtuUuFctGChTGxCfefG0g==
X-Received: by 2002:a05:600c:c87:b0:43d:8ea:8d7a with SMTP id 5b1f17b1804b1-441ac893f27mr14077155e9.28.1745910584206;
        Tue, 29 Apr 2025 00:09:44 -0700 (PDT)
Received: from smtpclient.apple ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db50e7676sm95541695ad.137.2025.04.29.00.09.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Apr 2025 00:09:43 -0700 (PDT)
From: Glass Su <glass.su@suse.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: [Question] dlm: shutdown sctp sock always timeouts
Message-Id: <CCD305AF-06AA-46B1-8761-4DF1F82B8054@suse.com>
Date: Tue, 29 Apr 2025 15:09:19 +0800
Cc: aahringo@redhat.com,
 teigland@redhat.com,
 Heming Zhao <heming.zhao@suse.com>,
 Lidong Zhong <lidong.zhong@suse.com>
To: gfs2@lists.linux.dev
X-Mailer: Apple Mail (2.3826.500.181.1.5)

Hi dlm folks
 Recently out team found a dlm timeout bug with lvmlockd. When sctp is =
used by dlm as underlying
protocol, there always are ~10s timeout for dlm to finish =
dlm_release_lockspace():

Each connection costs DLM_SHUTDOWN_WAIT_TIMEOUT to be shutdown:

> 38794 Apr 11 08:46:54 sapcrt-as2 kern.err kernel: [T1171911] dlm: =
Connection 000000001c3b445d shutdown timed out, will force close

It's caused by the following code from fs/dlm/lowcomms.c when releasing =
a lockspace:

static void shutdown_connection(struct connection *con, bool and_other)
{
...

        ret =3D kernel_sock_shutdown(con->sock, SHUT_WR);
        up_read(&con->sock_lock);
        if (ret) {
                log_print("Connection %p failed to shutdown: %d will =
force close",
                          con, ret);
                goto force_close;
        } else {
                ret =3D wait_event_timeout(con->shutdown_wait, =
!con->sock,
                                         DLM_SHUTDOWN_WAIT_TIMEOUT);
                if (ret =3D=3D 0) {
                        log_print("Connection %p shutdown timed out, =
will force close",
                                  con);
                        goto force_close;
                }
        }

        return;

force_close:
        close_connection(con, false);
}



The problem is after kernel_sock_shutdown(), shutdown_connection() is =
waiting con->sock to be NULL(closed)
until DLM_SHUTDOWN_WAIT_TIMEOUT but there is no other =
wake_up(&con->shutdown_wait) unless the one in
process_recv_sockets().

Assume there are two nodes in the cluster. kernel_sock_shutdown() is =
called by node A, sctp sock
will send SHUTDOWN to node B. When NODE B receives the SHUTDOWN signal, =
sctp layer sends=20
SHUTDOWN ACK to NODE A. At the moment, NODE A is waiting the connection =
to be closed until timeout.
However, lowcomms_state_change() only handles RCV_SHUTDOWN case, in NODE =
A, sk->sk_shutdown
is SEND_SHUTDOWN even the lower sctp layer received SHUTDOWN ACK from =
NODE B.

Then we noticed there is commit 54fbe0c15d9a ("fs: dlm: bring back =
previous shutdown handling=E2=80=9D). Before
the commit, sctp socks are not shutdown gracefully, all sctp socks are =
closed ungracefully. The commit message
says  =E2=80=9CThis patch( mostly* reverts commit 4f567acb0b86=E2=80=9D.=20=


The commits introduces the issue,  so my question is that is the =
behavior change of sctp intentional?=20
It seems reasonable for the graceful shutdown of sctp socks change =
though.



=E2=80=94=20
Su


