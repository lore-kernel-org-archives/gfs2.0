Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A754E443A82
	for <gfs2@lists.linux.dev>; Thu, 16 Jul 2026 18:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784225521; cv=none; b=s7gVmDvu2CDjwi0jgb2eg/AqSGqDeZnj36PHZqjJUq8tjTm7k1OzYTH6IKeKAEmYl0zvh5p16LFMmwlgHraz+ymI3AYAysA+3unBdqHSap6XK8vAyLtzRzvAHcRNhJtKRGZRpxADIAb6pdrmGXKJIo1s8NWdDQtAVzIhfxsgW78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784225521; c=relaxed/simple;
	bh=oojqvYPQa+9yE1pzPPf+Z0nA6OnsnInexucM7ncnbjo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZqkxnVvKaC+p/VWUNm+8uARHtoKHhzx1pQOEtVUeejQkZ5NLZ+De0O9GpccftfdWoxPdzpsecnJ+HgUnYpLDUYnE2Vh6AvM/qYcMJRcduX6Gx7Q0cAOMa1/+qXqkTXctHymJf2UmZd9TCwXTRLAaKA7rMVVopzHnXDDRhhDCPdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ip6S8E+c; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ip6S8E+c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784225518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rJwHFghyK79yp0NaMutQrKWS8KZVupQBZr3UwXycI64=;
	b=ip6S8E+cLuZrAz91095G9Kj0O8ZYjmp8Lx2CCK0RDxwPnlJIJs7scNMIghIcwTY+Vdgrrx
	njbDtEkvhIb+w0pics356x8DLPT/eT9v1P3C7/ckvL4hPpZXxEcCfbLHFvqxBshOWx5z92
	frLltg/W3C+8lUtqr5TlCmPGSJ1lz8s=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-kvDorQ5kPx6BuIgeHyv0ow-1; Thu, 16 Jul 2026 14:11:56 -0400
X-MC-Unique: kvDorQ5kPx6BuIgeHyv0ow-1
X-Mimecast-MFC-AGG-ID: kvDorQ5kPx6BuIgeHyv0ow_1784225515
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-39973e6c155so27384001fa.2
        for <gfs2@lists.linux.dev>; Thu, 16 Jul 2026 11:11:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784225515; x=1784830315;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rJwHFghyK79yp0NaMutQrKWS8KZVupQBZr3UwXycI64=;
        b=GLyzIiWms5ftf93ODROmccwvxPBY6UBXyfrxUBep4M3wtgSB9M9nsF/xc4XyQ2jr5Y
         pK6C1hcdZARCES3hzxAWSAKfaud5AJqcRRi0Zd1BEjHGNu0ZpLCiltdbM3Imlb+8dmBs
         YV+CNpGt41CXY6Id4VB8jyMhkdRwrb8pvyMKPrdf7xVXPp0qfQBODbhrfY03JzIS1BmS
         VZ9hD0qxDMsrZlinpmGjP4zSC93jOYkRjUHSGV+NS2U+h0o5LMg/uVKlOlfCwXHR9pJU
         a01uWuRRwAaoEPzPN40NERETSImgvUfpajoSHldcd95J//2fTVez0crg+fFdy2368KWP
         NSPQ==
X-Forwarded-Encrypted: i=1; AHgh+RrmY0pQRV3sfa3ZQ0fpUahTR/V3UkkQ/8RwrxXSQsYoYwStEeIIpFiT0x5UlvozwDgNxsHp@lists.linux.dev
X-Gm-Message-State: AOJu0YwxWD4yfoO7WXSN8gbLNPD+bhG+qP+Oh0jUSUYF49B3En3GnCrM
	DLxnvwrrjjX1zEM5gSWfKKjb6p5cH4b78OKvvpv6kHHNeGe/N85OOHOeoT/yhp05hT0j0Dnkqxx
	E5Y+bYLzUIiBBHK02mjFCq51hHEyYCHWbi6C4VUU84wGyeiatOgz5wcPN9j4yHFx/V+vvvDjtoj
	FJ2lyCCPQ0Q5UNPrWFgfh1Xyx04jhwgQ==
X-Gm-Gg: AfdE7clqT6bZ+WWrLo6DBveu9MrCbxAgfdk7CG1G1nM3Rj3eIZUBdTF/+/icaDK7zyE
	Yo68IEphERWT4WkrhcTyE+PpiTVLTI1F/ZjneSuJyIBFmuHiR/wYDJAIr3PxGzsFP6xs//JI2n6
	Cu1e6tDkCyCmOgG7BoMapG4kxdWMzuTzgeYT2MVKrucrTyYfuwWHjDhSHz8gdSm2t5+lq0gydQ/
	PSS9X/lnmhCzy7z
X-Received: by 2002:a2e:bcc6:0:b0:39a:e32c:39a3 with SMTP id 38308e7fff4ca-39dadc9f9demr28145061fa.35.1784225515072;
        Thu, 16 Jul 2026 11:11:55 -0700 (PDT)
X-Received: by 2002:a2e:bcc6:0:b0:39a:e32c:39a3 with SMTP id
 38308e7fff4ca-39dadc9f9demr28144951fa.35.1784225514663; Thu, 16 Jul 2026
 11:11:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260716072152.326803-1-lihaofeng@kylinos.cn> <20260716072152.326803-2-lihaofeng@kylinos.cn>
In-Reply-To: <20260716072152.326803-2-lihaofeng@kylinos.cn>
From: Alexander Aring <aahringo@redhat.com>
Date: Thu, 16 Jul 2026 14:11:42 -0400
X-Gm-Features: AUfX_mwXEKD0HRb7sNJZ_6K8MPvZIVnrOgOihlg61jPbzUrRoW8BEXayQ9GUd0s
Message-ID: <CAK-6q+jkA3_sYQZhRRHNBCrX4MsjsLJMRODr-d6t6n3T3tFTOg@mail.gmail.com>
Subject: Re: [PATCH 1/2] dlm: gate dlm_plock device on CAP_SYS_ADMIN
To: Haofeng Li <lihaofeng@kylinos.cn>
Cc: teigland@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Haofeng Li <13266079573@163.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1eIFqfR5lIybezZgbl-s9xW1nUHlnC8lWDNl49oc_fg_1784225515
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jul 16, 2026 at 3:27=E2=80=AFAM Haofeng Li <lihaofeng@kylinos.cn> w=
rote:
>
> fs/dlm/plock.c registers /dev/dlm_plock via a miscdevice whose
> file_operations has no .open callback and whose .mode field is unset.
> The kernel therefore performs no capability check on open, and any
> process that can open the node becomes an unprivileged plock daemon
> with full read+write access to the pending-plock queue.
>
> Attack chain (when the device node is reachable by an unprivileged
> opener =E2=80=94 see mitigation note below):
>
>   1. attacker open("/dev/dlm_plock") succeeds with no cap check
>   2. dev_read() drains pending plock requests straight to user
>      space, leaking dlm_plock_info fields: fsid, number (resource
>      id / inode), start, end, owner, pid, ex, wait
>   3. dev_write() matches an attacker-supplied dlm_plock_info
>      against a pending op on recv_list (matched on fsid+number+
>      owner+pid+start+end+ex+wait) and memcpy()'s it into the
>      in-kernel op, including a forged .rv =3D=3D 0
>   4. when a matched op exists, the forged result is then applied:
>      for async ops (op->data !=3D NULL), dlm_plock_callback() runs
>      posix_lock_file(); for sync ops, the requester wakes and
>      proceeds as if the cluster had granted the lock.  Either way
>      the requester ends up holding a POSIX lock without a real DLM
>      grant, or sees attacker-chosen rv that breaks lock correctness.
>      With no pending op on recv_list, dev_write() still returns
>      sizeof(info) but does nothing beyond a pr_debug ("dlm dev_write
>      no op ...") =E2=80=94 so a syntactically accepted write does not by
>      itself prove an applied grant.
>
> Mitigation: on a stock kernel, devtmpfs creates /dev/dlm_plock as
> 0600 root:root, so steps 1-4 are only reachable where the node is
> exposed to a less privileged principal =E2=80=94 e.g. udev MODE=3D0666,
> container bind-mount of the node, or an fd passed via SCM_RIGHTS.
> The in-kernel capability gap is real regardless of node mode.
>
> Reproduction (kernel 7.2.0-rc3, dlm loaded):
>
>   # ./exploit_h2   # as root
>   [*] node /dev/dlm_plock mode=3D0600 uid=3D0 gid=3D0
>   [!!!] AUTH BYPASS: opened with no capability check (fd=3D3)
>   [!!!] FORGE ACCEPTED: kernel accepted forged plock result (rv=3D0);
>        pending ops are grant-forgeable
>   [VULNERABLE] open + read-leak + grant-forge demonstrated
>
>   The "FORGE ACCEPTED" line means dev_write() returned sizeof(info),
>   i.e. the write path is reachable and the version check passed; it
>   does not by itself mean a grant was applied.  Demonstrating an
>   actual forged grant requires a concurrent plock op on recv_list to
>   match against.
>
>   $ setpriv --reuid 65534 --regid 65534 ./exploit_h2
>   [OK ] open denied: Permission denied   # devtmpfs 0600,
>                                          not a kernel cap check
>
> Fix: add a .open callback that requires CAP_SYS_ADMIN, and set
> .mode =3D 0600 on the miscdevice so the explicit expectation matches
> the devtmpfs default and survives future defaults.
>
> Signed-off-by: Haofeng Li <lihaofeng@kylinos.cn>

Acked-by: Alexander Aring <aahringo@redhat.com>

Thanks.

- Alex

