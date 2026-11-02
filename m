Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793648962;
	b=WsUTcJBWUTT1RaYKeZuKc2O2d9d6xcFuc516c/esU7Kit+M7Oro16NHlkz/JV+EInhNZ
	 uhx3UCDus9yM/GHfRstaRJar4MKVZN50lku6C7nhpBIvSWfbVek1sKuZDPFFkmCtR7hIH
	 I3yJeP9OvZvPtnyc3DxrLNg4NdxG0nX5/WB4+h2ga9eCRgRDTmS113BIPEHrE0Z0r9+qF
	 +I8rT088fhKATSqoK7WYZ92iRESmniQBFRpxgdOTK94ahoi25aGYXDHSKtRehRwEOdHMw
	 qtk3NJkahBhymiYNwohOitk6a7i2MAA6oOJqX17vWLZDZXMYaCfaKsxlVipcNyvRbYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793648962;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=WWVCxwNmclKBiA1HWgH44SVxokhuUVv65U9BSPMB8hM=;
	b=Ql6VLFc5bL6Zpk3mgrSV1JPqj+f0xztCByhLn1IceeBPRZBZgu33Ljnu9K9rn582D5wg
	 EXiZVnmsgaeQbfh3+jqf5RGXxetqLzAGOoRwJIS+8y171WFsYiwH0lxKWS3zp5SHJ5qkX
	 /PbwzX/cdplcIiFIt6C2ebFBRIoMk69PEC1YI8Co2+yxp3jvjZWJbEUW4xsCyfp/qvt1G
	 gMPHdZmFy4OEDgQfCp90o7RUxshPw4B5Cbb4iPdEMolPzhT4WaQ1VLRTB9SY7yw+qToaB
	 AqLVsc4TPa3KToy0/G6UNmO1noNd3aXKtE++e8DKgMxKye8un4MyY9mV8gZaOE99OcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ck5NrcZJ;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E86606A326
	for <gfs2@lists.linux.dev>; Mon,  2 Nov 2026 19:49:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95E86606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ck5NrcZJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793648960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WWVCxwNmclKBiA1HWgH44SVxokhuUVv65U9BSPMB8hM=;
	b=Ck5NrcZJmfsGvPoDSkLAPbQDfPoOpdcZuuLY1H8uqKr5FH1N42cvXtQO37DvrXu4pB04qe
	VQbqsZU2YYb4jYe3ls9wPWZg12Q6VTv3yk0sOJlr7HULKiynKbE3l6k5o/Ur/zN/j3lskZ
	+nT40YPxQ6QO51vUAakuRQlHiJqbHGg=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-dUPwbfYdM76H6xKWw5r1Rw-1; Mon, 02 Nov 2026 14:49:19 -0500
X-MC-Unique: dUPwbfYdM76H6xKWw5r1Rw-1
X-Mimecast-MFC-AGG-ID: dUPwbfYdM76H6xKWw5r1Rw_1793648957
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-3ab2cf30ab5so20149851fa.1
        for <gfs2@lists.linux.dev>; Mon, 02 Nov 2026 11:49:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793648957; x=1794253757;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WWVCxwNmclKBiA1HWgH44SVxokhuUVv65U9BSPMB8hM=;
        b=cWQlO1tb8bgi0fM0g7V87ZRYfgtYxn7qz2MAjhUnU7RneK5bKYo1xWevRC1ZkV6biM
         /IhG5iCsrA9fXaISnZl9lzAcpXCGKkyP5ZEAfQkLUccROBOsXZRL8Gyzkl8dBtig4MF7
         aXO9zsAIXJQduRVA+F19JVsQPJmjhIxKD9XGvaaOr/f3hgeGKjpPcsQfbpycV21dq+nC
         bU4/BK2o3EG4ieYOB+Y7pqIcTFNC5/P5sJ+juBC6h3iJJGk11z6riDp2Ls/QWKpAtAHA
         cxKbZZ70zQFgtCLfFAgJ8bGXmDhdRNLx4dwhE4feZxGKyMFiWGPkvdfWT4XaDYgpnSxQ
         JUbA==
X-Forwarded-Encrypted: i=1; AKwUvBzZqlmQKGC1qlSmUWCiVNdG8SuCkOQvca62HclwLz/fhQODHW79ZiGFcnM3RxP2HYinpK6R@lists.linux.dev
X-Gm-Message-State: APuU4Z+Arv1cR+Cx+0SAc9BzRSFR7AHQr9hXtlipXDwz+pXzaqKO/Z5y
	KAazs5HjtSLDBeJBcz+iH24d/glk5MzJbN3jonhhSCVcsm/+HvlizzohujrUZ4qG5ihfU9poanH
	ADDsnSRjtn7ZpIpwLTCVGeCid4JqPohF0wkDGmDkH3JJMOmakDdDHzt5j9XjYeUHfKIYmMVNHx2
	84R05P17HeNME63r7nzyBKkJb8mEY3rQ==
X-Gm-Gg: AYBFou011nAuJL2YSkG1lfZELV5pHS54YYH9zU/iWiYqmxW2A9Xckrt22CwmB7TlqV3
	y/9dWi3Nw9t2hPP1j7wizy0Mf/iaGaCGqIDz6PEjDNqy2aq06PVZxxXZq2RjAT0yEz60KL0i/48
	dEYK+ZuB+6/7FS4sJ4gYdOTQQth5HsxNeGs+yiREPWEj4rJQWRG7mhOLWl
X-Received: by 2002:a2e:a551:0:b0:3ac:8ce3:c477 with SMTP id 38308e7fff4ca-3acb7b30453mr24991621fa.21.1793648957438;
        Mon, 02 Nov 2026 11:49:17 -0800 (PST)
X-Received: by 2002:a2e:a551:0:b0:3ac:8ce3:c477 with SMTP id
 38308e7fff4ca-3acb7b30453mr24991601fa.21.1793648957032; Mon, 02 Nov 2026
 11:49:17 -0800 (PST)
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Post: <mailto:gfs2@lists.linux.dev>
List-Help: <mailto:gfs2+help@lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
List-Owner: <mailto:gfs2+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261019151627.3324886-1-ameer.hamza@truenas.com>
In-Reply-To: <20261019151627.3324886-1-ameer.hamza@truenas.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Mon, 2 Nov 2026 14:49:04 -0500
X-Gm-Features: AclHuK9ZeucLYL1DScuSSaHH7_rMZLYot-5hfyfC4xJE5FYtmB70sxRvxJe_mfg
Message-ID: <CAK-6q+j64=mSzuufOaSGjsC2aSwhb0hs9MKxxaAhbwugdztHZw@mail.gmail.com>
Subject: Re: [PATCH] dlm: don't set RSB_MASTER_UNCERTAIN on rsb with no master
To: Ameer Hamza <ameer.hamza@truenas.com>
Cc: David Teigland <teigland@redhat.com>, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	caleb.stjohn@truenas.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: d4amsCKOYKwuy2XHCfug0LGzIiiqBXx_0q7l-utLMuw_1793648957
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Oct 19, 2026 at 11:17=E2=80=AFAM Ameer Hamza <ameer.hamza@truenas.c=
om> wrote:
>
> When a local request reuses an inactive rsb, find_rsb_dir() sets
> RSB_MASTER_UNCERTAIN if res_master_nodeid is not our nodeid. This also
> matches an rsb that never got a master (res_master_nodeid 0, res_nodeid
> -1). set_master() then trusts the "cached" master, copies res_nodeid -1
> into lkb_nodeid and skips the lookup, and _request_lock() hits the
> DLM_ASSERT(r->res_nodeid >=3D 0) in is_remote():
>
>   rsb: nodeid -1 master 0 dir 1 flags 200 first 1 rlc 0 name pr
>   Kernel panic - not syncing: DLM:  Record message above and reboot.
>   Call Trace:
>    _request_lock.cold+0x3e/0x3e [dlm]
>    request_lock+0xcc/0x110 [dlm]
>    dlm_user_request+0x110/0x340 [dlm]
>    device_write+0x605/0x6d0 [dlm]
>
> Such an rsb is left behind when a request is cancelled while its lookup
> is still outstanding and the lockspace then recovers, e.g. because the
> dir node died: dlm_recover_waiters_post() completes the cancelled lkb
> instead of resending it, so no master is ever set. Once the rsb is
> inactive, the next request for the name revives it and crashes as
> above. If we became the dir node in that recovery, deactivate_rsb()
> even keeps the rsb as a dir record, so it does not age out.
>
> Before commit c04fecb4d9f7 ("dlm: use rsbtbl as resource directory")
> the flag was only set when res_nodeid was > 0. Restore that and set the
> flag only when a master is actually cached, so that set_master() does a
> normal lookup (or becomes the master itself as dir node) for an rsb
> that has none. res_first_lkid is still cleared, as the cancelled lkb
> leaves a stale id behind.
>
> Fixes: c04fecb4d9f7 ("dlm: use rsbtbl as resource directory")
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Ameer Hamza <ameer.hamza@truenas.com>
> ---
> Reproduced with two nodes: pause the dir node for a name, request the
> name, cancel the request once the lookup is out, remove the paused node,
> request the name again. The second request asserts without this patch
> and is granted with it, also when the dir node moves to a third live
> node.
>

question:

how do you "pause" anything in DLM?

>  fs/dlm/lock.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
> index c715e171bab7..2323c7709aa1 100644
> --- a/fs/dlm/lock.c
> +++ b/fs/dlm/lock.c
> @@ -826,8 +826,12 @@ static int find_rsb_dir(struct dlm_ls *ls, const voi=
d *name, int len,
>
>         if (from_local && (r->res_master_nodeid !=3D our_nodeid)) {
>                 /* Because we have held no locks on this rsb,
> -                  res_master_nodeid could have become stale. */
> -               rsb_set_flag(r, RSB_MASTER_UNCERTAIN);
> +                * res_master_nodeid could have become stale.  If no mast=
er
> +                * was ever set, there is nothing to confirm and set_mast=
er()
> +                * must resolve it as for a new rsb.
> +                */
> +               if (r->res_master_nodeid)
> +                       rsb_set_flag(r, RSB_MASTER_UNCERTAIN);
>                 r->res_first_lkid =3D 0;
>         }

I tried this patch and no significant failure occurred, although your
case is difficult to hit with a normal workload. So I will ack this
patch...

Acked-by: Alexander Aring <aahringo@redhat.com>

This reminds me that there are too many places that determine the
master or when the master isn't set, instead of having one central
place. I tried to improve this situation, but the changes seemed too
extensive to be accepted upstream. [0]

- Alex

[0] https://lore.kernel.org/gfs2/20240423195559.1527187-9-aahringo@redhat.c=
om/

