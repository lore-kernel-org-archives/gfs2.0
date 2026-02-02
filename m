Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1E821C9F9
	for <gfs2@lists.linux.dev>; Mon,  2 Feb 2026 18:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770058641; cv=none; b=E4G7x6fPhSqm/pEnPxh1s4kOqPd2YkSI6V80T2KLbXai7v9TezWnx1/uxW1KTS+5paP6s5KBvCVwdX9NUC27fM8n4Wlm5oh3tr/oDW6tS8e/FDviQNLhzeGPvewGVDAAT+4pAhxvwG7bdRk5jWSGpYR7vjpK3j40Be2RVl10MHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770058641; c=relaxed/simple;
	bh=lct/DZnk7sqRALTvgy3AdMWHwdT/DbV09U7r8onMmeU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bAYDBzibZwXh1OpWtB77E/ooSHkifP890tO/tppVPz2uMe0c1UQ6w+1KvdOnx5a22G5cMKieZKXMMdpUWS+TRJcB8yk9ta4GOWs0KXO65oVf07MJof4zULNZu6Tz3X7z8ND4xA5v3thR0UVW6el7kiM43/aP7XAhCn9ym6k+fKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CwMrCb+t; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CwMrCb+t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770058639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JbO1YBvtvGpTjSxCJjpKrZ6MA06vKPjL86HGyqGrOVw=;
	b=CwMrCb+tFRZmcsD78hSX9AyxCAqv8wpuiEYxFx2jFIZvKWBTdQ7vndzBUcHU9aHLbaL6hq
	FBfnMi5LbXVFKzo7mRWaVJ4uxatNerSTTH1teVlYY2lSI1nW+2tCgiG0xF5dWGQDGIh5h3
	FpdyRYHovP1b2+/kCr01VWTUOura5Z0=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214-ufKnY-gdMNW9zXN-Lp5TLA-1; Mon, 02 Feb 2026 13:57:17 -0500
X-MC-Unique: ufKnY-gdMNW9zXN-Lp5TLA-1
X-Mimecast-MFC-AGG-ID: ufKnY-gdMNW9zXN-Lp5TLA_1770058637
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-649b2db7b8fso3691022d50.0
        for <gfs2@lists.linux.dev>; Mon, 02 Feb 2026 10:57:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770058637; x=1770663437;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JbO1YBvtvGpTjSxCJjpKrZ6MA06vKPjL86HGyqGrOVw=;
        b=KduNXGuRnMQufcDTgjKYBDxSmkXLaiZtkHvs9fbY4s0TWiE9uaEuTPoVySkPEfb5XH
         yfNFm8P5jAO/rp3VYZ5sBb7TES7PorJqnW1XKCwgQrfIth/65IPNev8TI+Nwf/zZYt7A
         NmpXLMgbJon6+KTYPfetTlsVAK9BYIPvSBjgJT+lIOa5TyicS8P5vWTIFGDArqeV2a8D
         iDjsr7wPQ0yTpTJIUqlOhfDfZXqN/GXvdWYS6vDndmCLPuHU7WAIR+EwJ8a13cFYTdL4
         VIoiQ1xkgVLiyp41A0zH7QPPVgmr+0xRX8QpDCPo6pDZLEo9/NVfz+1rsO7uJfGc1Gx2
         nwTQ==
X-Gm-Message-State: AOJu0YxlJWR6cNgNFxvOGyMbqjoXAcaZhV1XWoSiwMmmm2B9ng1POQ05
	zaxwlSmwDvhCxmSdoCtJSSK0ioT+d5lIgSCRXgCLNzCn/OBYFT+kNorfOUwbNRFnbwaa8S1E5rj
	rpgXiFv/aXNKjZp2A7vLe/fOOZxdz3Z+yynL1DqukzSjMdAocqxfYodPXlBMiW03kBd9DSeOw2O
	ZKV3opMeJ5sAU9Kt8KWxSRa+imAz2j4w==
X-Gm-Gg: AZuq6aKpJIDJKA4GxdMxyQ76H0rGGLUv4mf2LpLZ2eC/cSWkmHFZN96hMlk+D955rda
	RxCUiji02Xq2hdM7QZknLXkzI36Q/DptwuddRlnRhkEgl3aYIfWfFwMSn3G/MlrGRJWdLyG21rV
	lILDgowCyWZQO4gz7TgzgakdlLa8yBBd0ttg2Zc8sCzfcnE7MvcuM21ixiW6AefH5EqffGgOuYN
	yPAs8GchO7FDP10Qmuahl5raV4NyDX2VqOApYkgDjayCugFOkHdKw==
X-Received: by 2002:a05:690e:4146:b0:646:7c25:5f86 with SMTP id 956f58d0204a3-649a83c9c75mr9631532d50.27.1770058637281;
        Mon, 02 Feb 2026 10:57:17 -0800 (PST)
X-Received: by 2002:a05:690e:4146:b0:646:7c25:5f86 with SMTP id
 956f58d0204a3-649a83c9c75mr9631518d50.27.1770058636928; Mon, 02 Feb 2026
 10:57:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260131062509.77974-1-kartikey406@gmail.com>
In-Reply-To: <20260131062509.77974-1-kartikey406@gmail.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Mon, 2 Feb 2026 19:57:06 +0100
X-Gm-Features: AZwV_QgmLsrVI02fPsd_50lrpkKplv_JQPx9QfpdzDJzKSKD1yhin_JgPWsme2Q
Message-ID: <CAHc6FU5=rG-GaSnHsU2aUO83i8zNpsYDyryuenJzRov64BsQ_g@mail.gmail.com>
Subject: Re: [PATCH] gfs2: fix memory leaks in gfs2_fill_super error path
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzbot+aac438d7a1c44071e04b@syzkaller.appspotmail.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ItqyvCe2di6UfwBaww31zGAKh0-_CgKXAmaT6WAuLGA_1770058637
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Deepanshu,

thanks for this patch; see below.

On Sat, Jan 31, 2026 at 7:25=E2=80=AFAM Deepanshu Kartikey
<kartikey406@gmail.com> wrote:
> Fix two memory leaks in the gfs2_fill_super() error handling path when
> transitioning a filesystem to read-write mode fails.
>
> First leak: kthread objects (thread_struct, task_struct, etc.)
> When gfs2_freeze_lock_shared() fails after init_threads() succeeds,
> the created kernel threads (logd and quotad) are never destroyed.
> This occurs because the fail_per_node label doesn't call
> gfs2_destroy_threads().
>
> Second leak: quota bitmap buffer (8192 bytes)
> When gfs2_make_fs_rw() fails after gfs2_quota_init() succeeds but
> before other operations complete, the allocated quota bitmap is never
> freed. The error path destroyed threads but didn't cleanup quota
> structures.
>
> The fix consolidates thread cleanup at the fail_per_node label for all
> error paths, which is safe because gfs2_destroy_threads() checks for
> NULL pointers before calling kthread_stop_put(). Quota cleanup is added
> specifically to the gfs2_make_fs_rw() error path where quota structures
> were initialized.
>
> Syzbot detected these leaks with the following signatures:
>
> Thread leak (PATH 3: gfs2_freeze_lock_shared failure):
>   unreferenced object 0xffff88801d7bca80 (size 4480):
>     copy_process+0x3a1/0x4670 kernel/fork.c:2422
>     kernel_clone+0xf3/0x6e0 kernel/fork.c:2779
>     kthread_create_on_node+0x100/0x150 kernel/kthread.c:478
>     init_threads+0xab/0x350 fs/gfs2/ops_fstype.c:611
>     gfs2_fill_super+0xe5c/0x1240 fs/gfs2/ops_fstype.c:1265
>
> Quota leak (PATH 4: gfs2_make_fs_rw failure):
>   unreferenced object 0xffff88812de7c000 (size 8192):
>     gfs2_quota_init+0xe5/0x820 fs/gfs2/quota.c:1409
>     gfs2_make_fs_rw+0x7a/0xe0 fs/gfs2/super.c:149
>     gfs2_fill_super+0xfbb/0x1240 fs/gfs2/ops_fstype.c:1275
>
> Reported-by: syzbot+aac438d7a1c44071e04b@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Daac438d7a1c44071e04b
> Signed-off-by: Deepanshu Kartikey <Kartikey406@gmail.com>
> ---
>  fs/gfs2/ops_fstype.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
> index e7a88b717991..fdc70189e4f1 100644
> --- a/fs/gfs2/ops_fstype.c
> +++ b/fs/gfs2/ops_fstype.c
> @@ -1276,7 +1276,7 @@ static int gfs2_fill_super(struct super_block *sb, =
struct fs_context *fc)
>
>         if (error) {
>                 gfs2_freeze_unlock(sdp);
> -               gfs2_destroy_threads(sdp);
> +               gfs2_quota_cleanup(sdp);

This isn't pretty. Can it be replaced by the following?

--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -147,8 +147,10 @@ int gfs2_make_fs_rw(struct gfs2_sbd *sdp)
        }

        error =3D gfs2_quota_init(sdp);
-       if (!error && gfs2_withdrawn(sdp))
+       if (!error && gfs2_withdrawn(sdp)) {
+               gfs2_quota_cleanup(sdp);
                error =3D -EIO;
+       }
        if (!error)
                set_bit(SDF_JOURNAL_LIVE, &sdp->sd_flags);
        return error;

>                 fs_err(sdp, "can't make FS RW: %d\n", error);
>                 goto fail_per_node;
>         }
> @@ -1286,6 +1286,8 @@ static int gfs2_fill_super(struct super_block *sb, =
struct fs_context *fc)
>
>  fail_per_node:
>         init_per_node(sdp, UNDO);
> +       if (!sb_rdonly(sb))
> +               gfs2_destroy_threads(sdp);

gfs2_destroy_threads() can be called unconditionally here.

>  fail_inodes:
>         init_inodes(sdp, UNDO);
>  fail_sb:
> --
> 2.43.0
>

Thanks,
Andreas

