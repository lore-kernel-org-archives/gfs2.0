Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8011386B8
	for <gfs2@lists.linux.dev>; Tue, 12 Mar 2024 17:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710266171; cv=none; b=doeasImoTg3ki7o5AlVK8As/2F/r8XjRAOCgw3/K7b8fJulcF6h8NVRTJmTSDwh2Wq1L8fMHikQpg2h4wB0EiNQVY0GJfTOcTDXDdzBp5VR5AvBwjaYXXQ2uvi+nYkyoNP1Cj6XeG5luY812VBUS2MMrsLcydrPLRK8CLFTuDtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710266171; c=relaxed/simple;
	bh=B3oN55Izc5W/amZBLUxgUVKnKsa+28z3Nq8HHWQoheE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kpFtfK3PJS4ZOeMwj3gkLuVJjiT7cbxoa08vontxegsGKp4je+LrFTmqybGOOHbCx9Tx/fZYOQbQ5mmcPv40uC4wHb6bx9yEtDw5HFhWmgpQRwtXnq8HztRNk3ym8OGBACl6Wn7bfzhShtx4EG11RJzSue2089XmuoI0GTNdSUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PZZg/BNK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PZZg/BNK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710266168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p1fvJC0fWzHHjhr3U9fffxIT2ptQBNpCCGMY7iwnAHs=;
	b=PZZg/BNKIQVaGL8YhCMw2JdRt91IjId9RoQne7HWckd9m15EgW+Vn29nwaEFDc255Jb5/U
	lrEfOGJIv/WHD1ACznrrBabr7gKaB6Yo/0i2VXJIt3ubyYlFjX2W6gNlNL65rqr6VYhSPy
	z8xq9+botPHwdXQ2qX6X41klVxxwVes=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-280-M7qnfHpgPN-Ohon9JNb5GA-1; Tue, 12 Mar 2024 13:56:07 -0400
X-MC-Unique: M7qnfHpgPN-Ohon9JNb5GA-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2d2b9aa4e35so41935661fa.3
        for <gfs2@lists.linux.dev>; Tue, 12 Mar 2024 10:56:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710266166; x=1710870966;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p1fvJC0fWzHHjhr3U9fffxIT2ptQBNpCCGMY7iwnAHs=;
        b=luTxnMIjWCRaRafX8FVYt6pgrlHoFiDz6g6ms+WezpS6/4j8BXLz3SgbB4mxWWHvGX
         UvYqm8JBW85KhZ7BATWBLqSRDzen6ImYJu3qk/EKalEYVqqLb4p4zhHwf+Y4WLFIjlg2
         tDbJG/4sdgEyRxPjfhi044X0YBQfx6Izg20VILRQ7VVXBgVeIhXIUaJu58yV6XWIQK6o
         5+WXeiZXauABZucMYLv9AugfwRomcHLIcr9jQYkQbI6QeqqUfNXiOSjL7WoBUFZNWGvS
         OW6hHBHpjViSuT4l5DvBkH8YyEKdgO3qMCimR56FBAYJk2r2UeXPrGnSZ0HPM9AJuk/T
         GNyw==
X-Forwarded-Encrypted: i=1; AJvYcCUUm4d4H/vpGg5r4fA7g3KUIhpWL1owu3ar55BcX6sswAPhklsnaxzI9DI9C4T4P42U4UJiwo1xr3e/4ILXCldxuaXHxg==
X-Gm-Message-State: AOJu0YyHJeN7Q7l4gztPiWzVjy2vgiJqNwxeIFuUnODe6TvlPq0lPzyO
	Ta6oljHde8eGkCU4/t2Cgos880EQEMM7mvhl79L7ZwqpsOR56esYnnQF+Yodd4RtTg6oQ+GcByq
	DN/G9Lm/Jn2NaDQ3uP+cL17rlTgtrlSiP5UOR8HSOi8zdAUOoSQhhwS6jqp+owcwv+m9seM/DQP
	MrLOcnKS+ZDmR13CSmOu7L+abuxQ==
X-Received: by 2002:a2e:be84:0:b0:2d3:b502:3fee with SMTP id a4-20020a2ebe84000000b002d3b5023feemr7108201ljr.0.1710266166020;
        Tue, 12 Mar 2024 10:56:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHf33eB2y4kHRAs6a/dCPhNLXhytT6Dnlg9oW5IR2BDx5DeuZWhUUOvL+eMzBIwjk65EW3fr6Gcs/gekBg5fMs=
X-Received: by 2002:a2e:be84:0:b0:2d3:b502:3fee with SMTP id
 a4-20020a2ebe84000000b002d3b5023feemr7108184ljr.0.1710266165633; Tue, 12 Mar
 2024 10:56:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <Ze4qSvzGJDt5yxC3@valentin-vidic.from.hr> <49396145-712d-44eb-884e-58eb19b1f4f2@linux.alibaba.com>
 <Ze7IiZmlhRaOgdhm@valentin-vidic.from.hr> <CAK-6q+jFv8tK4rF-xY6okTwhK87zMtOKP6fthzCQ-H8-4q=wbQ@mail.gmail.com>
 <Ze9bIiT3rAWTtPJp@valentin-vidic.from.hr> <CAK-6q+j2UDh0mi0KUTdtsRE8pj4+tuw_SU+yjzjsR3GCLURz=w@mail.gmail.com>
 <ZfANyOkQh4SgXoty@valentin-vidic.from.hr>
In-Reply-To: <ZfANyOkQh4SgXoty@valentin-vidic.from.hr>
From: Alexander Aring <aahringo@redhat.com>
Date: Tue, 12 Mar 2024 13:55:54 -0400
Message-ID: <CAK-6q+hBa08LoAEhsdiiG4DarCGF-CWy41zDjU3zB81P7hHx1A@mail.gmail.com>
Subject: Re: ocfs2 mount error
To: =?UTF-8?Q?Valentin_Vidi=C4=87?= <vvidic@valentin-vidic.from.hr>
Cc: Joseph Qi <joseph.qi@linux.alibaba.com>, ocfs2-devel@oss.oracle.com, 
	David Teigland <teigland@redhat.com>, gfs2@lists.linux.dev, ocfs2-devel@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Mar 12, 2024 at 4:09=E2=80=AFAM Valentin Vidi=C4=87
<vvidic@valentin-vidic.from.hr> wrote:
>
> On Mon, Mar 11, 2024 at 07:43:41PM -0400, Alexander Aring wrote:
> > I step forward here, but still I am not able to set a cluster name. I
> > hardcoded it in the kernel and "it seems" to work. How do you set the
> > cluster name? It seems that setting the cluster name in mkfs is not
> > the way to go.
>
> I think the cluster name comes from corosync, here is the config I have
> there:
>
> totem {
>         version: 2
>         cluster_name: debian
>         crypto_cipher: none
>         crypto_hash: none
> }
> logging {
>         fileline: off
>         to_stderr: yes
>         to_logfile: yes
>         logfile: /var/log/corosync/corosync.log
>         to_syslog: yes
>         debug: off
>         logger_subsys {
>                 subsys: QUORUM
>                 debug: off
>         }
> }
> quorum {
>         provider: corosync_votequorum
> }
> nodelist {
>         node {
>                 name: node1
>                 nodeid: 1
>                 ring0_addr: 127.0.0.1
>         }
> }
>
> The status of the services is as follows:
>
> # corosync-quorumtool
> Quorum information
> ------------------
> Date:             Tue Mar 12 07:49:18 2024
> Quorum provider:  corosync_votequorum
> Nodes:            1
> Node ID:          1
> Ring ID:          1.5
> Quorate:          Yes
>
> Votequorum information
> ----------------------
> Expected votes:   1
> Highest expected: 1
> Total votes:      1
> Quorum:           1
> Flags:            Quorate
>
> Membership information
> ----------------------
>     Nodeid      Votes Name
>          1          1 node1 (local)
>
> # dlm_tool dump_config
> daemon_debug=3D0
> foreground=3D1 (cli option)
> log_debug=3D0
> protocol=3Ddetect
> port=3D21064
> debug_logfile=3D0
> bind_all=3D0
> mark=3D0
> enable_fscontrol=3D0
> enable_plock=3D1
> plock_debug=3D0
> plock_rate_limit=3D0
> plock_ownership=3D0
> drop_resources_time=3D10000
> drop_resources_count=3D10
> drop_resources_age=3D10000
> post_join_delay=3D30
> enable_fencing=3D1
> enable_concurrent_fencing=3D0
> enable_startup_fencing=3D1
> repeat_failed_fencing=3D1
> enable_quorum_fencing=3D1
> enable_quorum_lockspace=3D1
> enable_helper=3D1
> help=3D-1
> version=3D-1
>
> > I am able to run fsck and I see on "dlm_tool ls" a lockspace with a
> > similar name you have.
> >
> > The bad news is, I can't reproduce it. After fsck the lockspace
> > releases successfully.
> >
> > I see on your debug information that it uses dlm user space locks, in
> > my case I am using dlm kernel locks and I am asking myself why. Can
> > you tell me more about your cluster configuration?
> >
> > Somehow in your case fsck is using the DLM user space locks
> > functionality from libdlm (the user space DLM locking library) but in
> > my case fsck goes over the ocfs2_fsdlm filesystem and then does DLM
> > kernel locks.
> > I am asking myself how this is supposed to work.
>
> I'm attaching the strace from fsck below, but it could be that ocfs2_dlmf=
s
> module is not loaded, so it falls back to user space locks?

I was able to reproduce the issue and sent a fix out.
If you want to extend your debian testing using different approach
(not libdlm) this can be done by:

mount -t ocfs2_dlmfs none /dlm

this will somehow do some UAPI that triggers dlm kernel locking (so
far I see it). How it is intended to work and which combination works
or not? I have no idea, all I can say is that you should avoid using
the same lockspace "name" for libdlm user and kernel dlm locking. I
need to recheck if we have a check for that, that might break stuff
but should not be used in such a way anyway... and maybe in future
there is no difference between kernel/user locks.

I am curious about your testing at debian cluster, do you also test gfs2?

- Alex

