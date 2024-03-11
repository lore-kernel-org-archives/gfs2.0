Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5BD1BDF4
	for <gfs2@lists.linux.dev>; Mon, 11 Mar 2024 23:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710200639; cv=none; b=j52ceX+tcVhmFiF+4eDLvveOsxE/h614eJbbXSEhmr0DlnLJ5+zq4uPGqd0vxreCT7rhZlQTR4+KwNshaFpq3vnpljzCkG8BmiGrSzGb7EK8mVYlSoVOD3Qq8c0GbwptNWIc7dOwNV/hd9wvcLt5GuKRuE9oVm/m17iW/58yTa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710200639; c=relaxed/simple;
	bh=75n7O/uvrGTWt8CA3JXjQRqrpG9C0VaQAem2Is7GTXw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t4DPK1aC2fL+U0b90J6WzqyVwxwSed3XspwudIBxluFgGwr3Eg/Z155Imqo4tb/2umfjIOnmfgDwfqr5i4IsaU/JCV6hdymBf1fT1VUNmOG6Ljzr2mOoqlPKzAxdrqKSRTdM6hNbxs8xxDZkkEV7dSCOXWiEoqhjI5J211ItBsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ATrnGb4O; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ATrnGb4O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710200636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bBuncCQndOreXFN09uwU4KsPowvBP1fe40gMcZu6WPE=;
	b=ATrnGb4OMfSzE5Hpkg1blikxWVnYB+TNscJNDM5NtdZsB6veoNlEXwWAoHiTtB4wRN/ufB
	UUhggKQBp03CrA6v06a+73oV0xnejnAbihnhZ0NtvKDUBtXEHD7Ino2j6IclS5R9VyTzC6
	fR6d7CtuLts6BRnW0kmNnYdYwdZaz+I=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471-a_MHV02RPcKOimJ2cExu1Q-1; Mon, 11 Mar 2024 19:43:54 -0400
X-MC-Unique: a_MHV02RPcKOimJ2cExu1Q-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2d44551e1ccso9154251fa.3
        for <gfs2@lists.linux.dev>; Mon, 11 Mar 2024 16:43:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710200633; x=1710805433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bBuncCQndOreXFN09uwU4KsPowvBP1fe40gMcZu6WPE=;
        b=oxdkubk0RTFDN5q+mOGLg7Pmo1mzt+sdiv587NrmzZuwYef49vxNYRDf3JDEn1m8pS
         kvjdh6IywxBRIuJURks0I8/DtD/8o7rIzb1oRCqnd+p7YE/hvq6o9O9r8mUmPusc7+Lx
         tKFRoaLp+Uws5uw8kzIBd1qJ8RppBCkUD06ZES7Wct5NMWFAtZqnTRZXFuQsnMqaqGgc
         6LUdZSbPPCSo7l7DaHaeqJmIjZaJVTKGk2ex+yI8hrJk7ZZSp778Y0G/5bR5FGgN0wF0
         c4smqZ/PwV5x8VlVRccS6cTxudIasT1HMDAridzkma4J/ajGgZAVInyZGa/KRlWKpj//
         a08w==
X-Forwarded-Encrypted: i=1; AJvYcCXH8J9q/54y0axgVehxSVZLrUbkWhe/h8ZLkSgm01wgNKsKPOvzhbOdWsF+L9c1tTbAFu0/tt+qyqhK8tmi6sfG6RRKFg==
X-Gm-Message-State: AOJu0Yxq7+3xAGez6YJThCXJzj5POraTYvT2QbHjT48mm2y3JphmyPiG
	WOyimblB+faH3ilkqBlFkO8a2zX3f0pSmUtMJawUHDR38A6swNwGYnnEH793eerqOIs4g2IvJbg
	bBZVyNnOWU8A4g27uNFjUEkavpx2N3H1rGf7Xk6GrF3zMNdj/Zs2mC0kZpRpEigIQAWMdOiVk/X
	S+P77fgNmIGgyRL8VTK8XGbBtsCw==
X-Received: by 2002:a05:651c:221e:b0:2d3:1f1:d473 with SMTP id y30-20020a05651c221e00b002d301f1d473mr1557955ljq.0.1710200632983;
        Mon, 11 Mar 2024 16:43:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHI4l2OMl4XMCjWnul9UC6aO0qoUpHvEHJB3fqQ/wUBgG/0n8Y6o8svNsKcSQIGMaJyowJd17BtQeppzgO5//g=
X-Received: by 2002:a05:651c:221e:b0:2d3:1f1:d473 with SMTP id
 y30-20020a05651c221e00b002d301f1d473mr1557946ljq.0.1710200632560; Mon, 11 Mar
 2024 16:43:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <Ze4qSvzGJDt5yxC3@valentin-vidic.from.hr> <49396145-712d-44eb-884e-58eb19b1f4f2@linux.alibaba.com>
 <Ze7IiZmlhRaOgdhm@valentin-vidic.from.hr> <CAK-6q+jFv8tK4rF-xY6okTwhK87zMtOKP6fthzCQ-H8-4q=wbQ@mail.gmail.com>
 <Ze9bIiT3rAWTtPJp@valentin-vidic.from.hr>
In-Reply-To: <Ze9bIiT3rAWTtPJp@valentin-vidic.from.hr>
From: Alexander Aring <aahringo@redhat.com>
Date: Mon, 11 Mar 2024 19:43:41 -0400
Message-ID: <CAK-6q+j2UDh0mi0KUTdtsRE8pj4+tuw_SU+yjzjsR3GCLURz=w@mail.gmail.com>
Subject: Re: ocfs2 mount error
To: =?UTF-8?Q?Valentin_Vidi=C4=87?= <vvidic@valentin-vidic.from.hr>
Cc: Joseph Qi <joseph.qi@linux.alibaba.com>, ocfs2-devel@oss.oracle.com, 
	David Teigland <teigland@redhat.com>, gfs2@lists.linux.dev, ocfs2-devel@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 11, 2024 at 3:27=E2=80=AFPM Valentin Vidi=C4=87
<vvidic@valentin-vidic.from.hr> wrote:
>
> On Mon, Mar 11, 2024 at 11:20:56AM -0400, Alexander Aring wrote:
> > when I try doing your steps (btw: thanks for sharing) to run
> > fsck.ocfs2 it tells me:
> >
> > fsck.ocfs2: Unable to access cluster service while initializing the DLM
> >
> > Looking into strace right before that I see a:
> >
> > connect(4, {sa_family=3DAF_UNIX, sun_path=3D@"ocfs2_controld_sock"}, 22=
) =3D
> > -1 ECONNREFUSED (Connection refused)
> >
> > it's true I don't have ocfs2_controld running, after looking into
> > ocfs2-tools source code, I declare it as not compilable with recent
> > corosync versions.
>
> Not sure about that, because I also don't have ocfs2_controld running.
> This is ocfs2-tools v1.8.8 with corosync v3.1.7. Perhaps cluster stack
> should be set with:
>
>   echo pcmk > /sys/fs/ocfs2/cluster_stack
>

I step forward here, but still I am not able to set a cluster name. I
hardcoded it in the kernel and "it seems" to work. How do you set the
cluster name? It seems that setting the cluster name in mkfs is not
the way to go.
I am able to run fsck and I see on "dlm_tool ls" a lockspace with a
similar name you have.

The bad news is, I can't reproduce it. After fsck the lockspace
releases successfully.

I see on your debug information that it uses dlm user space locks, in
my case I am using dlm kernel locks and I am asking myself why. Can
you tell me more about your cluster configuration?

Somehow in your case fsck is using the DLM user space locks
functionality from libdlm (the user space DLM locking library) but in
my case fsck goes over the ocfs2_fsdlm filesystem and then does DLM
kernel locks.
I am asking myself how this is supposed to work.

> > btw: a "trace-cmd stream -e dlm" would be nice to debug this issue.
> > After I look at your debugging information it would be nice to see if
> > the device() read for ast callbacks are there.
>
> Here is a trace report for the fsck call:
>
> cpus=3D1
>       fsck.ocfs2-1696  [000]    54.621075: dlm_lock_start:       ls_id=3D=
2352585329 lkb_id=3D1 mode=3DPR flags=3DVALBLK res_name=3D2e393235396566623=
13866316162386331
>       fsck.ocfs2-1696  [000]    54.692487: dlm_lock_end:         ls_id=3D=
2352585329 lkb_id=3D1 mode=3DPR flags=3DVALBLK error=3D0 res_name=3D2e39323=
539656662313866316162386331
>       fsck.ocfs2-1696  [000]    54.695447: dlm_ast:              ls_id=3D=
2352585329 lkb_id=3D1 sb_flags=3D sb_status=3D0 res_name=3D2e39323539656662=
313866316162386331
>       fsck.ocfs2-1696  [000]    54.695636: dlm_lock_start:       ls_id=3D=
2352585329 lkb_id=3D2 mode=3DEX flags=3DNOQUEUE|VALBLK res_name=3D533030303=
03030303030303030303030303030303030323030303030303030
>       fsck.ocfs2-1696  [000]    54.766959: dlm_lock_end:         ls_id=3D=
2352585329 lkb_id=3D2 mode=3DEX flags=3DNOQUEUE|VALBLK error=3D0 res_name=
=3D53303030303030303030303030303030303030303030323030303030303030
>       fsck.ocfs2-1696  [000]    54.770765: dlm_ast:              ls_id=3D=
2352585329 lkb_id=3D2 sb_flags=3D sb_status=3D0 res_name=3D5330303030303030=
3030303030303030303030303030323030303030303030
>       fsck.ocfs2-1696  [000]    54.770821: dlm_lock_start:       ls_id=3D=
2352585329 lkb_id=3D3 mode=3DEX flags=3DNOQUEUE|VALBLK res_name=3D4d3030303=
03030303030303030303030303030303031383937333737316531
>       fsck.ocfs2-1696  [000]    54.845613: dlm_lock_end:         ls_id=3D=
2352585329 lkb_id=3D3 mode=3DEX flags=3DNOQUEUE|VALBLK error=3D0 res_name=
=3D4d303030303030303030303030303030303030303031383937333737316531
>       fsck.ocfs2-1696  [000]    54.848395: dlm_ast:              ls_id=3D=
2352585329 lkb_id=3D3 sb_flags=3D sb_status=3D0 res_name=3D4d30303030303030=
3030303030303030303030303031383937333737316531
>       fsck.ocfs2-1696  [000]    54.868951: dlm_unlock_start:     ls_id=3D=
2352585329 lkb_id=3D3 flags=3DVALBLK res_name=3D4d3030303030303030303030303=
03030303030303031383937333737316531
>       fsck.ocfs2-1696  [000]    54.958319: dlm_unlock_end:       ls_id=3D=
2352585329 lkb_id=3D3 flags=3DVALBLK error=3D0 res_name=3D4d303030303030303=
030303030303030303030303031383937333737316531
>       fsck.ocfs2-1696  [000]    54.982397: dlm_ast:              ls_id=3D=
2352585329 lkb_id=3D3 sb_flags=3D sb_status=3D-65538 res_name=3D4d303030303=
030303030303030303030303030303031383937333737316531
>       fsck.ocfs2-1696  [000]    54.982450: dlm_lock_start:       ls_id=3D=
2352585329 lkb_id=3D4 mode=3DEX flags=3DNOQUEUE|VALBLK res_name=3D4d3030303=
03030303030303030303030303030303031393937333737316531
>       fsck.ocfs2-1696  [000]    55.056390: dlm_lock_end:         ls_id=3D=
2352585329 lkb_id=3D4 mode=3DEX flags=3DNOQUEUE|VALBLK error=3D0 res_name=
=3D4d303030303030303030303030303030303030303031393937333737316531
>       fsck.ocfs2-1696  [000]    55.058946: dlm_ast:              ls_id=3D=
2352585329 lkb_id=3D4 sb_flags=3D sb_status=3D0 res_name=3D4d30303030303030=
3030303030303030303030303031393937333737316531
>       fsck.ocfs2-1696  [000]    55.082546: dlm_unlock_start:     ls_id=3D=
2352585329 lkb_id=3D4 flags=3DVALBLK res_name=3D4d3030303030303030303030303=
03030303030303031393937333737316531
>       fsck.ocfs2-1696  [000]    55.182903: dlm_unlock_end:       ls_id=3D=
2352585329 lkb_id=3D4 flags=3DVALBLK error=3D0 res_name=3D4d303030303030303=
030303030303030303030303031393937333737316531
>       fsck.ocfs2-1696  [000]    55.210128: dlm_ast:              ls_id=3D=
2352585329 lkb_id=3D4 sb_flags=3D sb_status=3D-65538 res_name=3D4d303030303=
030303030303030303030303030303031393937333737316531
>       fsck.ocfs2-1696  [000]    55.530687: dlm_unlock_start:     ls_id=3D=
2352585329 lkb_id=3D2 flags=3DVALBLK res_name=3D533030303030303030303030303=
03030303030303030323030303030303030
>       fsck.ocfs2-1696  [000]    55.625015: dlm_unlock_end:       ls_id=3D=
2352585329 lkb_id=3D2 flags=3DVALBLK error=3D0 res_name=3D53303030303030303=
030303030303030303030303030323030303030303030
>       fsck.ocfs2-1696  [000]    55.650054: dlm_ast:              ls_id=3D=
2352585329 lkb_id=3D2 sb_flags=3D sb_status=3D-65538 res_name=3D53303030303=
030303030303030303030303030303030323030303030303030
>       fsck.ocfs2-1696  [000]    55.672033: dlm_unlock_start:     ls_id=3D=
2352585329 lkb_id=3D1 flags=3DVALBLK res_name=3D2e3932353965666231386631616=
2386331
>       fsck.ocfs2-1696  [000]    55.766844: dlm_unlock_end:       ls_id=3D=
2352585329 lkb_id=3D1 flags=3DVALBLK error=3D0 res_name=3D2e393235396566623=
13866316162386331
>       fsck.ocfs2-1696  [000]    55.791829: dlm_ast:              ls_id=3D=
2352585329 lkb_id=3D1 sb_flags=3D sb_status=3D-65538 res_name=3D2e393235396=
56662313866316162386331
>

looks okay to me. For dlm user locks there is currently an issue with
lvbarea, see [0]. Not sure if this is why you have such issues right
now, it depends what fsck is doing with the lvb.

- Alex

[0] https://lore.kernel.org/gfs2/CAK-6q+h-RngJqJ6Rx2h4a0Qy1j+ZRvCn5E-3Qee7_=
P3pWXJonQ@mail.gmail.com/T/#ma861c86ab54991a0d9a2742c6983544289f3bdd0

