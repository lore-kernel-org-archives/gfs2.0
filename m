Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F6633262A
	for <gfs2@lists.linux.dev>; Thu, 16 Jul 2026 18:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784225480; cv=none; b=MJdLMUMmFiXGBlkgGWhB1mi9WM0KNM2qTO5eK0g/eS2fXeG1PNHG5TWpNdj5r/97xG5XuIgNEUo/sYA+eE+BsWjjNfwfZw5zmS/OeidSLAWoxCKX704Xwww24ewifiwM9OQCs5Daroml28zWL1HZeKREp+9Vjq5lvWOuNPJo6v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784225480; c=relaxed/simple;
	bh=SEPut8pVciJ34NrJq8aJDWynEarVXzqUl1ETErIZVcM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J1cDxWvlpt9XKCEkhhLWEVjJVnpGz9Cgew+MUQ/ZifZ99x0GW6k6zM7Ej7rD+UsK+yyrbd42LQ1mwLmbNGAImHWz/tIv1s/f6dG8tRlhYTCzlSQWF3/ESTPGN/UNw0liyAMzsVknNuig4i9EGdzT9rTZBp7II3C+lut9vUyLb/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JwPOcm1r; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JwPOcm1r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784225478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gr3s0cw9jEgo/+f6+WQgsXDtEK6lKHFs/BxbKhYUqrk=;
	b=JwPOcm1rlahNaXf7tQVNNfJAIEqz86OfHnEKbx3jTwQSW6e0OEvhixXyshseHUuVWvgrop
	z5R1+lvuhKGjg29ZeTecsK0l/v/togUQg6b4rl5/nfq5tiNpbGVRd4Xb3MwpP4d+gydA8X
	elbgMXVnAPJJY8JgdzGC0rkgKCs71vI=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-FCEflM5XMtux27kZMt_7tA-1; Thu, 16 Jul 2026 14:11:16 -0400
X-MC-Unique: FCEflM5XMtux27kZMt_7tA-1
X-Mimecast-MFC-AGG-ID: FCEflM5XMtux27kZMt_7tA_1784225475
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-39d9337b0d3so4043141fa.0
        for <gfs2@lists.linux.dev>; Thu, 16 Jul 2026 11:11:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784225475; x=1784830275;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Gr3s0cw9jEgo/+f6+WQgsXDtEK6lKHFs/BxbKhYUqrk=;
        b=Bm5/eFFoToKLVZDEbW1xk3dZOcRY4gx3R1A4xq0zX1lEhN445RuDjGyVz4k3qQve4o
         WJLxw8H0jA4Bwy8YHu8lZXLahFU3Xh685joJzzqRz41EVJtFOz9+ByPTN1yAXAGuPbSw
         ezOyKetKj2T2C3/mZNWSx6/YtI5rPi86wAWQh4IWkDMKGubqhXfmS9VvtZEM/Ax7P/rQ
         0ejltNMXEz8z76stravJsOsd5Gi+Np7Nfb0rben184UzaE7cZHFj3Uqqi0RaqPDATCss
         Tx913oijOoEcaJeDEralE6dM+j6osOhQDuOkGn54/2mJwXbgcYtMZeeLeEHaoLnAqGvu
         0eDw==
X-Forwarded-Encrypted: i=1; AHgh+Rp/QK/hY6gVCBzixlu/hNtsTMCusf3KOuSGUsGIumSHpx8JDEDrvzkyjlmIEc2auB5GHmZu@lists.linux.dev
X-Gm-Message-State: AOJu0YxwMWtOfkZqX6kWP88Ll0n5bW2v7toKjxJhLJz7PEpq6Il5nY3X
	gMVBp+dPBepyhlAINTt3AxSbwjBYTbusvBLBOsd/EHrf7ceS4SOYsSY+EyPrV0V8lHykQcdHqyo
	nXl7o8GU2OjfKwcxy2c93U+AdrwvVWUE8WMbS/IsoYTnwxmTxTixzpr/n+crqwxJ1gjN2rUM3du
	ydYd/Om0JmIXA8J0onx3d5LEQKnqUD9w==
X-Gm-Gg: AfdE7cmNMXP/YiHrdRQ7coYFG4UirXqw+h3S4lSCH5gHMQTtkhujcUBhox7Cl6qJ4Jx
	N8FWRW7SJv5E+khx7TFnuL46nAXBl7h1DHuKtB4rE+4X3kXHd/VjHm6f+ZbzFsOXtPAaktptF4y
	PZo7XIq/7O0ekNC2M8wWVDLy5nrLodM4oohWwL0ulNRVJdWt1aR41UqDrom569sf5N6scK9iG/l
	tztwmn7xV3sK6/1
X-Received: by 2002:a2e:a9ab:0:b0:39c:90e4:a8c5 with SMTP id 38308e7fff4ca-39e9ebbecdfmr7011291fa.1.1784225474895;
        Thu, 16 Jul 2026 11:11:14 -0700 (PDT)
X-Received: by 2002:a2e:a9ab:0:b0:39c:90e4:a8c5 with SMTP id
 38308e7fff4ca-39e9ebbecdfmr7011251fa.1.1784225474454; Thu, 16 Jul 2026
 11:11:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260716072152.326803-1-lihaofeng@kylinos.cn> <20260716072152.326803-3-lihaofeng@kylinos.cn>
In-Reply-To: <20260716072152.326803-3-lihaofeng@kylinos.cn>
From: Alexander Aring <aahringo@redhat.com>
Date: Thu, 16 Jul 2026 14:11:02 -0400
X-Gm-Features: AUfX_mxF2FmDUfxRkgri3wDoKGq1YnvOvzIcDcr_LFcByiN6t7Qcn0jff7EwCck
Message-ID: <CAK-6q+hMzFU-+BcJ6Et82zLZnc8ZaESjcOYPTs1LuSukOfkJUg@mail.gmail.com>
Subject: Re: [PATCH 2/2] dlm: require CAP_SYS_ADMIN for dlm-monitor device
To: Haofeng Li <lihaofeng@kylinos.cn>
Cc: teigland@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Haofeng Li <13266079573@163.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3xL5d16WAXj_5DOKj97_lShj0lfRi6qM07TunaPDo_g_1784225475
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jul 16, 2026 at 3:27=E2=80=AFAM Haofeng Li <lihaofeng@kylinos.cn> w=
rote:
>
> monitor_device_open() in fs/dlm/user.c performs only
> atomic_inc(&dlm_monitor_opened) and sets dlm_monitor_unused =3D 0; it
> does no capability check.  monitor_device_close() does
> atomic_dec_and_test(&dlm_monitor_opened) and, when the count reaches
> zero, calls dlm_stop_lockspaces() =E2=80=94 which stops every lockspace o=
n
> the node.  The miscdevice is also registered with no .mode field.
>
> Attack chain (when the device node is reachable by an unprivileged
> opener =E2=80=94 see mitigation note below):
>
>   1. attacker open("/dev/dlm-monitor") with no cap check; the
>      global counter goes 0 -> 1
>   2. attacker close(fd); atomic_dec_and_test reaches zero again
>      and dlm_stop_lockspaces() runs -> every DLM lockspace on the
>      local node is stopped.  Other cluster members then observe
>      the node losing its lockspaces (membership / recovery side
>      effects), so the impact is not strictly local to GFS2 /
>      OCFS2 / lvmlockd / cluster-md workloads on this node.
>   variant: attacker holds the fd open indefinitely to suppress
>      the intended stop when dlm_controld later closes its own fd
>      (inverse abuse =E2=80=94 recovery / shutdown stalls)
>
> Mitigation: devtmpfs creates /dev/dlm-monitor as 0600 root:root on
> a stock kernel, so unprivileged open is blocked by the node mode,
> not by a kernel cap check.  The gap is real wherever the node is
> reachable (udev MODE=3D0666, container bind-mount, fd via SCM_RIGHTS,
> or any setup where dlm_controld shares its monitor fd).
>
> Reproduction (kernel 7.2.0-rc3, dlm loaded, no live lockspace):
>
>   # ./exploit_h3   # as root
>   [*] lockspace devices present: 0
>   [!!!] AUTH BYPASS: opened /dev/dlm-monitor, no cap check (fd=3D3)
>   [VULNERABLE] monitor open auth bypass demonstrated
>
>   $ setpriv --reuid 65534 --regid 65534 ./exploit_h3
>   [OK ] open denied: Permission denied   # node 0600, not cap check
>
> The destructive close path is opt-in in the PoX
> (--i-know-it-stops-lockspaces); we did not drive it here.  Driving
> the close path on a node with active lockspaces would stop them;
> on this throw-away node there are none, but we keep the opt-in gate
> so the same PoX is safe to re-run on production-like clusters.
>
> Fix: gate monitor_device_open() on capable(CAP_SYS_ADMIN) and set
> .mode =3D 0600 on monitor_device, matching the dlm_controld-only
> intended usage.
>
> Signed-off-by: Haofeng Li <lihaofeng@kylinos.cn>

Acked-by: Alexander Aring <aahringo@redhat.com>

Thanks.

- Alex

