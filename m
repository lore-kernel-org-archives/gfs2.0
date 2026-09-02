Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEFD49B209
	for <gfs2@lists.linux.dev>; Wed,  2 Sep 2026 13:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788355282; cv=none; b=ikOUcp2YA0uvhiLyyczo52X53bhPc1NRdIkO8ejZmenADbiou1ADNWUWUbDvNEhwfyh+c5wF/6h27xUsQ8ipcx19xTqDcOr4NWpru+2vC31iWWeasBtBESjIMD3Oj7TO+AZHEhzaecxjsQFrrR7jdXFXxadhgaaGSGh6ZWmsCe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788355282; c=relaxed/simple;
	bh=CX4jXXsYiq4+K/WAEmy2HAUQc54C6pP3SiHUP0fLUOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t7uT5KKoqzW350lJ8ZVUzCPnLjVXMojW+4m65u6zqvfVJjbSmf/idKjX6saRxbk8PX3aAIH/PNYwun6Pu+HFqjNwPgz/PtZ3op1P2dkdSU8bt9Sv3M3ibYdXb3dJAJoO58rHxYsRCMNdcSr7ySQiz8w7FGieg2UThzVbqieEUAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X7b7EcwK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X7b7EcwK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788355280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WETgVeFgKR8QqwYjitWNqHJK5UZu3CUf41ydcXPg9og=;
	b=X7b7EcwK8qJFvdQpSchOXStvAoLJBjWiwCJAVkVRDEaigjIsDnjqN0lSList4KwTMZMo7c
	bAwox67/ZjV0k1P+oZIZQnWEhn2rtOwgEWgyFNQ/Sh2YTlr9odI37/z7rdWueV2ga4MB6I
	/9qfPE7HZsoA0ZYP5QAobcrVxmueGqo=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-NFnwOSbhOhmOS64JUI2jjQ-1; Wed, 02 Sep 2026 09:21:19 -0400
X-MC-Unique: NFnwOSbhOhmOS64JUI2jjQ-1
X-Mimecast-MFC-AGG-ID: NFnwOSbhOhmOS64JUI2jjQ_1788355278
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-3a27721662eso4734501fa.1
        for <gfs2@lists.linux.dev>; Wed, 02 Sep 2026 06:21:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788355277; x=1788960077;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WETgVeFgKR8QqwYjitWNqHJK5UZu3CUf41ydcXPg9og=;
        b=d9LhqK4xD9rutlUEC2897EhmOGLGL+wbDTBdXEYImpjJ5Ky5elqzOqPl26xd8R4kcH
         0+auUL+2e9F2mIgBBlRbPv4VI9mXf7eSKEazsuQL28QJCtY3+Q9v+lIOWV5ycdCG+3su
         c6s+KdgCQtSAto6Pukx7cVXzcdLaAoS3oEjSGPoOOA86TYB6TzLSudehlJIqSDuak+ZG
         4dFRI5b2OnbgHSm7t+q5kdu1GAkfbWFN/DyV1ofa6M/oVuDIsbG/avAW8HNfkcxxIyIB
         RVosFRs4bJjy+LNzB/8YIfC6wqZh5BZ4rL9ms1+7mXOtTU5w2rZfBYQkO1NePqWEaxw0
         vxow==
X-Forwarded-Encrypted: i=1; AKwUvBzXtbY7Ms+h22VPEgh8Ib8GW1Ra2OGqVlcDD5pl6g6szk6Ggv3C30aWF3NH4x2HSjr89Yf1@lists.linux.dev
X-Gm-Message-State: AFuF++l7HA1pvkTIsNyCb5SCBxh9zvXM3WLOHfaAp7KmsuLPvjAlboGL
	VMftcy/3lIOL5nHHreZEB2e0cokvb7LGzQIzfVhyRpORMWccMJv4jIf0pCRZ9iUqtIiV1Aa0adf
	Z5hSmZ8agzqGi3Iqjo3mS0mWN4Pa0JP3BqDuNIKvhnDoVrSZ5/t+DriYJ1W3vZzStA+fsYfkyNH
	32bTvp3UIAiWc+KZRX9j9PFkaGRhfSZg==
X-Gm-Gg: AYBFou1NJKW+DpbEvmzRBNMuaGZAsXnejl0ONifkFVWPcvJcLbsSsjf6KNJAcxmESgx
	zAOSgX3OJhPPyYjqE9DU8gL6SEJY7tXb+kwOu6wqjAgmekSvX1/t+6hq+mxOPIgNFwRoKztyx1N
	xaBCbTU6EQ/uWBLzWigwEOYR8+j3zu7DHYFzv3SbaHvV5E/yU3Z6CoIYPq
X-Received: by 2002:a05:651c:41ca:b0:3a3:63a:baf8 with SMTP id 38308e7fff4ca-3a34fe23718mr11727581fa.3.1788355277514;
        Wed, 02 Sep 2026 06:21:17 -0700 (PDT)
X-Received: by 2002:a05:651c:41ca:b0:3a3:63a:baf8 with SMTP id
 38308e7fff4ca-3a34fe23718mr11727111fa.3.1788355276321; Wed, 02 Sep 2026
 06:21:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260901091836.16906-1-qiang.zhang@linux.dev>
In-Reply-To: <20260901091836.16906-1-qiang.zhang@linux.dev>
From: Alexander Aring <aahringo@redhat.com>
Date: Wed, 2 Sep 2026 09:21:04 -0400
X-Gm-Features: AcwNN1XQfrKRMkjAT-v4HHjnaOQ8UWFl-GmdYVXEnby5LRXI1Kj-CpyfJLPtdoA
Message-ID: <CAK-6q+jFXsZpWHrm0CSa8Tr+P3qHDmWVQA+9stXViyUf48CuvA@mail.gmail.com>
Subject: Re: [PATCH] dlm: wait for outstanding SRCU callbacks to complete in
 exit paths
To: Zqiang <qiang.zhang@linux.dev>
Cc: teigland@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	rcu@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yfy08NY44xzbZjth2bvPXZOtZLiEukuj6ivlyrXxSLc_1788355278
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Sep 1, 2026 at 5:19=E2=80=AFAM Zqiang <qiang.zhang@linux.dev> wrote=
:
>
> The dlm_lowcomms_exit() and dlm_midcomms_exit() iterate over the
> srcu protected connection and node hash tables and hand each
> element to call_srcu() for deferred freeing (connection_release()
> and midcomms_node_release()). call_srcu() is asynchronous: the
> callbacks are invoked only after an SRCU grace period, which may
> happen after the exit function has already returned.
>
> These exit functions are reached from exit_dlm() on module unload.
> Once they return, module teardown continues and the module text
> may be unloaded while call_srcu() callbacks are still pending. When
> such a callback finally runs, it executes freed module code and
> touches the static SRCU domains that are being torn down, resulting
> in a use-after-free.
>

I thought again about this and in my opinion this is not possible as
it is already being handled by DEFINE_STATIC_SRCU() with a cleanup
handling when the module is unloaded.
I know that srcu subsystem does a lot of magic with modules init/exit
functionality to call init_srcu_struct() and cleanup_srcu_struct().
See

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/ker=
nel/module/main.c?h=3Dv7.3-rc1#n2711

so this patch should be reverted. If they don't use a barrier there,
the fix should be in the SRCU subsystem, but I believe the current
SRCU implementation already handles this.

- Alex

> Add an srcu_barrier() after the call_srcu() loop in each exit function
> to wait for all outstanding callbacks of the respective SRCU domain to
> complete before returning. In dlm_midcomms_exit() the barrier is issued
> before dlm_lowcomms_exit() so that node callbacks are drained prior to
> tearing down the lower layer.
>
> Signed-off-by: Zqiang <qiang.zhang@linux.dev>
> ---
>  fs/dlm/lowcomms.c | 1 +
>  fs/dlm/midcomms.c | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
> index 2aff1c7c17de..ea8353c4638d 100644
> --- a/fs/dlm/lowcomms.c
> +++ b/fs/dlm/lowcomms.c
> @@ -1984,4 +1984,5 @@ void dlm_lowcomms_exit(void)
>                 }
>         }
>         srcu_read_unlock(&connections_srcu, idx);
> +       srcu_barrier(&connections_srcu);
>  }
> diff --git a/fs/dlm/midcomms.c b/fs/dlm/midcomms.c
> index 8964164600d2..045431524494 100644
> --- a/fs/dlm/midcomms.c
> +++ b/fs/dlm/midcomms.c
> @@ -1178,6 +1178,7 @@ void dlm_midcomms_exit(void)
>                 }
>         }
>         srcu_read_unlock(&nodes_srcu, idx);
> +       srcu_barrier(&nodes_srcu);
>
>         dlm_lowcomms_exit();
>  }
> --
> 2.17.1
>

