Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0326749F109
	for <gfs2@lists.linux.dev>; Wed,  2 Sep 2026 13:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788355515; cv=none; b=M59uQEmUxlzhOFrFR/DdFM0T3n8gWfA/sn8+JsCm+mFC5XUjZVrUcjFZ87KQMKZa6DwTok5hU21kLZHFNBM77WODFG1HeMmG1C36pQui0o7ZDI/A/yXQCiSkUK1M/ZwV0jzc/VmfmVtOgjZRI3mm7zn+ieLzbKM6p9D7gxE+IiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788355515; c=relaxed/simple;
	bh=1V4ue058AY3RtGPMrqxuELVFnwR59VitySPMsodXmVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xdq60Inpsct+W1sM4Q/I6cRR/S6OiToRHGoZsgz+zRGT7LcQNUZmg0C8F3rkxrzK7G49SoRks4ddjx9B4IEKv0NuilAdNZ0V+1F0iIPRXFIWAnxGPGCqdr8VxkllAIHl13F2i3a/GMNxjNh3UQDYO/tdeewh0hY7O+MOumaeCKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZxOXfIvy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZxOXfIvy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788355512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1V4ue058AY3RtGPMrqxuELVFnwR59VitySPMsodXmVY=;
	b=ZxOXfIvy6M1P8mHOg0RY0QZ/hvKJwnrzbVJXzbOmOZGJgkfsTtQfwh+u6zg3HmzY5MmG0j
	Vzn0q2IYOqj7JGL5oymAAWpiNVP6m56ibm8n5XA19ZJNLvLX7eis55Qb7pyxQIyjmpKnBB
	/AofW4ZwOfUeUiVFoI6DF/mzmmYh0dc=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-zhNC7o8eOqymfEKhkyeSpQ-1; Wed, 02 Sep 2026 09:25:11 -0400
X-MC-Unique: zhNC7o8eOqymfEKhkyeSpQ-1
X-Mimecast-MFC-AGG-ID: zhNC7o8eOqymfEKhkyeSpQ_1788355510
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-39b1a8b8bb1so4578521fa.2
        for <gfs2@lists.linux.dev>; Wed, 02 Sep 2026 06:25:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788355509; x=1788960309;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1V4ue058AY3RtGPMrqxuELVFnwR59VitySPMsodXmVY=;
        b=qIESanDJsAKbyaY+nQD+uD/kJGvbcvSNku1+0XggXIQ9TLrULo9O6jJXDQWL3FdoBV
         SW31dJupNCr8bFq9ghRXukoKWhR5CicF/QRRmBVrp2Jtk4h6i1MsVsj9l2wEdnW0hyd2
         dmtYx6b6Jo/boEWDMNDEJfPMDuPtwaCn+13MScTTa7qKzDR9ZbDxbw3A4UXThUm9NSjN
         QOYHgCYVJ4XQw0XotRgNMeGMBswQ8kHg+n1vCbWXa+LhubyiSnyUMr2Tgjbmt6eg3Py0
         uOqE5cfHWh1lgnFVwZ/FDNPR3X3eJwM9VWB1ZLzF49Bsx3wPaB+2nzHXGkJqIpok1EWS
         Mpuw==
X-Gm-Message-State: AFuF++mkUSrKItFh5AxzsQni4uP+1eDPRMzPI7/DWy/n6Jh3qmlIU74e
	YpHSTRmDeC/0dwa7BCdnXSDhZ+ZTxhHevznkxLyF0kOnlgZGasgmzfV7Xi03LpI9kKwh3lLYxC+
	yXkSzfyuGN13jfg859L+WSKF4Z6j+pA9crlZkH7cKTCxi1ZvNFwrrU/lpkj12PQhecy2PdpwD7v
	6yWNa52NjRj36sZESXZnNn1DCtjMwbIQ==
X-Gm-Gg: AYBFou0+qHLf4mBvDgOTjNbhP36XxHYsyg+O1cJm4AukcYHVlOcPOrr78nf2Jz92Uiq
	3DtNK4pDHmBZrYkU6O8A1DNQFIof0trX1qh8wQykH2kVV2nJZYIRfJavTPptWJ8RQ3rwD4bnsvU
	v379FGwkHI3mJUkwhLmSxprzE8k9wteHNaYe1ASLwR65Jz0fDrfuadlJcW
X-Received: by 2002:a05:651c:1443:b0:3a3:1391:fb19 with SMTP id 38308e7fff4ca-3a34ff11646mr10568681fa.9.1788355509613;
        Wed, 02 Sep 2026 06:25:09 -0700 (PDT)
X-Received: by 2002:a05:651c:1443:b0:3a3:1391:fb19 with SMTP id
 38308e7fff4ca-3a34ff11646mr10568561fa.9.1788355509199; Wed, 02 Sep 2026
 06:25:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260901174715.3825582-1-aahringo@redhat.com> <20260901174715.3825582-8-aahringo@redhat.com>
In-Reply-To: <20260901174715.3825582-8-aahringo@redhat.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Wed, 2 Sep 2026 09:24:57 -0400
X-Gm-Features: AcwNN1XjwZrPwrKFBUauGbjERjVzUncK0FBoQtadWb6A-0XXzHdPkhhNrpLn2tg
Message-ID: <CAK-6q+ia+XhKgXY9cGw1T0dbo6ptx8nb-uUqe8EdjySLDPysMw@mail.gmail.com>
Subject: Re: [PATCH RESEND dlm/next 7/8] dlm: wait for outstanding SRCU
 callbacks to complete in exit paths
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2ZGmGu_b5YzO_4_DZISyzlkg5NOKWjMAfx7AI2zuuQE_1788355510
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi David,

On Tue, Sep 1, 2026 at 1:47=E2=80=AFPM Alexander Aring <aahringo@redhat.com=
> wrote:
>
> From: Zqiang <qiang.zhang@linux.dev>
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
> Add an srcu_barrier() after the call_srcu() loop in each exit function
> to wait for all outstanding callbacks of the respective SRCU domain to
> complete before returning. In dlm_midcomms_exit() the barrier is issued
> before dlm_lowcomms_exit() so that node callbacks are drained prior to
> tearing down the lower layer.
>
> Signed-off-by: Zqiang <qiang.zhang@linux.dev>
> Acked-by: Alexander Aring <aahringo@redhat.com>
> Signed-off-by: Alexander Aring <aahringo@redhat.com>

Please drop this patch for dlm/next as I currently see the patch
series has not been applied yet to next.

Thanks.

- Alex

