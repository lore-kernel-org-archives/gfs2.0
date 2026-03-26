Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DC42868A7
	for <gfs2@lists.linux.dev>; Thu, 26 Mar 2026 00:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774484226; cv=pass; b=hZVqLhxOZNhkCnwPQmBdpFofL0yW/XEGsALOpwqqR/npylQPJaIEi53qGx9wJpQ1lamMXavHi1qjpV0as4GVQUi0GbinGU7PJhT3VxDSpCIhJ1ytijoydz1BxbNsHs3OKKgc9Xx+VvJWQ1Z3jWP63NuQZOygHjtpoEe3gPMgmLI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774484226; c=relaxed/simple;
	bh=phS3IJli2t/FV99ktGizqLCYwv3l0LjIFEj8T4i780Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GrAkfImJEEJAVPznEO+WBW5IEYBdJLa+83qGoP2nzFVQxMS/ZjDBxzXqhR03uqtdphlexMvQxMQhlF2AlSF/9sFRPXmqfQz+ubg62kHMPMhC9/Tt02iIH0GlpOQZ9T7IYeLXBXpWrgt+LmIpRI8TH0RHn0qJuAycyb72hI/7T5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W+dzQf7y; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+dzQf7y"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-64e8c7f5082so490941d50.0
        for <gfs2@lists.linux.dev>; Wed, 25 Mar 2026 17:17:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774484220; cv=none;
        d=google.com; s=arc-20240605;
        b=ijSgxYuEHZ0GstxXkJ/fzG2EEShJG6f/eppHfceIn/UF36EESvwTxNYw+dFfnvxBGk
         QvoGympqzKvaOh1iQYGJEYDkpDn1X8ydXjQV7dgUNI55KUGfBxsmh1xUzViEJiE1Rslw
         I9JY6cbbDGSQQ7BqrbzJR9Qvp5i6lVIpa/HUOBUjiVKL9Mo9d/Ny4LQi+9c4mSyWnn5U
         cfpAGumgLHuKEp80SAV0kdkJqkjB6GqpyjAHTOzOIzJ8LMYhtaraaxZB4qrh9mIgPak1
         n+Hml3Ht1ePSATwA/sgr8e0GWJ27QmgLL/riFP7uIjviGYpjU1ZR4GzN9JhAPV1tU5+r
         IvNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JF4acbbSt5E73IKAZSEOEPirPhAB/yqaiKbDvN7a8Pk=;
        fh=xduXSkFGzmi1grN7qXykA8DXQbvM9x8sys57JdMwOA8=;
        b=lFsj40sj+gitbPSyObqUeArBXl3DHmasQqMb1yJZLEaOIuL1rkQjBPxQWGCJcgkDm/
         KgiX7sv//XhlYaIHK7iNYxO7njPjT+z4Px1f4ib9BOU9sAwwN9IT/EYt1BxNKFcVCO3H
         rDUFppq/4Edl+Yxd8BBhJuJU47tbetje6CRzST5v5Uc6sJQKCYYEYXWAtKYUtDRNiyx0
         h+wCaAZLp4lhUS/hD3WYhv9lKyi3vzTn5ubiKs2jwEQsQE6b8KGDT/BQ7JJ/+uIeKz0m
         kvdNQlzS5NAf1b7ynsx9Hlo6wuOWRY9QTdPMBaQYDZEGeLral2z3gsbwLgtPuy3S17Ac
         opug==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774484220; x=1775089020; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JF4acbbSt5E73IKAZSEOEPirPhAB/yqaiKbDvN7a8Pk=;
        b=W+dzQf7y3eqUTFMDQJGjqGkyShDrfpV6l4754FHW688/t/Wah1hv/2n+G39E1zxOtA
         vpLz2lbyAs6eh940do8FGGkRf/KKM6iFzirms10Pcl389Ih7P4jb8avQo1kDDMj3skWa
         tT7Hsel80DfXKkN06D90DJQfNlFEKI/HgC/ZUQsS8wC/EVeQiHuE/HAGsVDIXr+FIo8H
         cjQceu7w9kfLe3a7pdHfYmyFKVEKmHFWCxkOoS8wPQwvBewXOx8fA3dTO2lXmgISZgPg
         a56zG6LtV5UFo6afUR0fvZLutQc4boW7oX/t/7L+T60NHuCZRIBgdsMesrJhEoNuURnr
         iLKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774484220; x=1775089020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JF4acbbSt5E73IKAZSEOEPirPhAB/yqaiKbDvN7a8Pk=;
        b=COrMEAXDCyK9FvpaBTyQG+xcDM+7+S3udGG9ZhCdBv3dGIG1721fwiaTKa0RznLdv8
         hYv6BCRylEZYyI+EGqh7d2prHbOk4wUe1t+dUdeBrjeqF2JB1wae55+k9qliwAuS0I+S
         /JGC1bmNY0+oO+PxBmOTdYEkepyHrOLPi+6flK8Bm3Ocxdhngf+OmhZMy1Z0787vvW/h
         NEOxF95c5DYnecPEZEic2uguvzR20HlAvUekYWuQH5RkfkgshhynskmwLuyDN2SVRXFR
         8CEr9cNuX26yaBNn8XJaS4IleCaseaP0l/u7lLh00rpSBYOGkDKV1L8HilL+uIFTuAZL
         MVjw==
X-Forwarded-Encrypted: i=1; AJvYcCUhgQchESrhi/mwJ+H9K7x5hbFuiHCTVfI9PCIeS7CJVScz65ASoYVWBYTObHfScCZbTKJX@lists.linux.dev
X-Gm-Message-State: AOJu0YwtyV4S3Wf6YwuHz69lyiZuvGM5FOpgIbblH1gIXnYSsYvACPlJ
	/Opa0FneTmASlpHmU66+PfnicXcT7bC27TerVX/3/crMWQ1JXilGoAfD70yy4dDCEfiGN6KbrI+
	x/pKKQOhk/u9IoN7k+lzkZ9s8+Hk6yig=
X-Gm-Gg: ATEYQzyhNIsEneTeBQCO5uj6lnV1YHra9h4DJbvl1QazHQJOMUb659AFLVVUwR2Mb/v
	p3DM6DoU5DBQgZzqu6XNcIFtkJvtbeDaF9uRrJfEFOUWPlp5BJAdXUVdTgr0ELw3NNF9sQ+M2o3
	SISPQ+qoncWsisF6WMfAVZU+g0qIIaAEQYUmic3XJo206dPXr7PZX8eIYIN8w7/XTNrYB8mxjqz
	Q7ib96/j0f7SnCFJShBFFz/RuxFAjUUMZeCwVnaOvCZtXPt1cpHpNTshq4tuDSa+ahHzuliM+zw
	yws7OJTFs3x8/KkInUPklgKurRSgA17X7GwJCaiBqg4cJeL6d+S5XgDXxGXpnWPhG6pL4clD
X-Received: by 2002:a53:d017:0:b0:64e:a8fc:a29a with SMTP id
 956f58d0204a3-64ee60792a6mr4893790d50.21.1774484220067; Wed, 25 Mar 2026
 17:17:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260325060506.4868-1-kartikey406@gmail.com> <b15d7b72-134a-4e00-8220-5482e1ae2489@redhat.com>
In-Reply-To: <b15d7b72-134a-4e00-8220-5482e1ae2489@redhat.com>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Thu, 26 Mar 2026 05:46:49 +0530
X-Gm-Features: AQROBzBy1nIQ7Fi1-fKGZWcKceFt_GYXBEy7njhYldFAl1e-isn7uwCG_ndVDJA
Message-ID: <CADhLXY5Hghaqhiw+mdHRhuzdxBCwYO-_FX2oRdNiBtVStXY+8A@mail.gmail.com>
Subject: Re: [PATCH] gfs2: fix duplicate kmem_cache name on concurrent mounts
To: Andrew Price <anprice@redhat.com>
Cc: agruenba@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzbot+b441db1854c360b83221@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 25, 2026 at 11:28=E2=80=AFPM Andrew Price <anprice@redhat.com> =
wrote:
>
> On 25/03/2026 06:05, Deepanshu Kartikey wrote:
> > When gfs2_fill_super() creates the per-filesystem bufdata cache, it
> > uses sd_fsname as part of the cache name:
> >
> >   sdp->sd_bufdata =3D kmem_cache_create("gfs2-bufdata/<fsname>", ...);
> >
> > At this point sd_fsname is set from sd_table_name (e.g. "syz:syz"),
> > which is the same for all concurrent mounts of the same device.
> > The unique suffix (.s for spectator, .N for journal ID) is only
> > added to sd_fsname AFTER wait_on_journal() completes, since the
> > journal ID is assigned by the locking subsystem during mount.
> >
> > With multiple concurrent mounts of the same device (as triggered by
> > syzkaller with procs:5), multiple calls to gfs2_fill_super() all try
> > to create a cache named "gfs2-bufdata/syz:syz" before any of them
> > reaches the point where sd_fsname becomes unique, triggering:
> >
> >   kmem_cache of name 'gfs2-bufdata/syz:syz' already exists
> >   WARNING: mm/slab_common.c:112
> >
> > Fix this by moving the bufdata cache creation to after
> > wait_on_journal() completes and sd_fsname has been updated with its
> > unique suffix. Also move the fail_bufdata cleanup label accordingly
> > in the error unwind path.
>
> I don't think the description is accurate as the patch moves the kmem_cac=
he_create() to after the gfs2_sys_fs_add(), which fails the mount cleanly o=
n a duplicate lock table instead of triggering a warning.
>
> That said, 767e4de3ffce ("gfs2: per-filesystem bufdata cache") is likely =
to get pulled out of for-next as it was more of a debugging aid so it's pro=
bably not worth a v2.
>
> Andy
>

Hi Andy,

Thank you for the explanation.

I went back and traced through the code more carefully. The real
protection comes from gfs2_sys_fs_add() which calls
kobject_init_and_add() with sd_table_name =E2=80=94 this fails cleanly
when a duplicate mount is attempted since the sysfs path already
exists.

The bug was that kmem_cache_create() was called BEFORE
gfs2_sys_fs_add(), so concurrent mounts both created a cache
with the same name before either reached the duplicate check.
Moving the cache creation to after gfs2_sys_fs_add() means
duplicate mounts are rejected cleanly there first.

I also understand now why sd_fsname uniqueness is not the real
fix =E2=80=94 with lock_nolock, ls_jid comes from mount options and
can be the same (jid=3D0) for all concurrent mounts, so
sd_fsname would still be "syz:syz.0" for all of them.

Thanks for your time,
Deepanshu Kartikey
