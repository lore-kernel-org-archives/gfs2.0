Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1CB1B0425
	for <gfs2@lists.linux.dev>; Tue, 18 Feb 2025 06:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739861862; cv=none; b=a7nRytOMbCqUv2NTAVoIJnHgaHlzwi0AcIPvSs/0Com2pJSdiksMDf+W6AMEf8GP3NMdKmyT++dHMdgK+sawgGklrKbBbzXO9fP5j2q3T9iO5yWesDVEznGB8fiPh/qZbkCnFNSuFd4iviXYQ7XuLqpP7a2tIxFedTuGxfCVZmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739861862; c=relaxed/simple;
	bh=XQ/NVnfVE7NNvDTmpfLLDpqgGlSMILACTRheTT216ng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nq7WFUAI8qpJMycvpSg9nYb3bWEQwl+8hvKlA496XWIlxc1JnLBskYNNhIUxNw3inFaq0B2s6RUKOwPUilqg9fd9CeAY4ZzEYc3tb3nliFViP48yzFI0kvqWgiU493nQAZoyfAF8nbksqkHHK2hIzcKiKMSUrVLP7PGm6T2+OHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mp9qPZmJ; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mp9qPZmJ"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-54626a71b40so1210519e87.3
        for <gfs2@lists.linux.dev>; Mon, 17 Feb 2025 22:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739861858; x=1740466658; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iRBSYqRtQX5z3bqMamdRSkx7Zu9m86472PmcDCtWIMo=;
        b=mp9qPZmJdNaMqy1jw5Hge6Z159QVsKjZ8i/LdLpWp2hp2MV/DockejxRqi4H/6oKbi
         yZt22VAPrFfEjT61kGvpyVjjoaioYfRMK9H0i0Fn0Ih037GSLzh1spEgeNi14suigbn1
         nNILOAcD7obc9rXcbknWzZHLhlSh2zXRil+Opb4ph2phhW6btCckDEtuyCELQHM002xz
         /g77VQ7qstydQmYyMr+l9sHh/tg2zIgNiNHaM28TKv5bN9O3/G9vEFIc0Qkgcfcs7hmr
         MzXtVYEU1ZCitHajS/+AUpAUwAu2J0JbX+6rqjer8Y6ZXTv813twBJueKZax/TKJwGu8
         yvzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739861858; x=1740466658;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iRBSYqRtQX5z3bqMamdRSkx7Zu9m86472PmcDCtWIMo=;
        b=SlYxZYzw2yDbimiK7kexwYNANq7gA0/ippQLkuGvS0xrn8hOwSmWzNzipD6hdXnEPQ
         jyog87Osk8zK8ihy3tTYphOQnWXATcZjbxIfnOG0ae1yJZ0aCgqyJneOgbVPbiluPssu
         cikAufIQ6MtDb+vWjPw6m617KVU2Ws5hhqxRQqwtJk2yiyqGsVS3p2Xykw/hjHOFnHbh
         eF6tzQf1IqNTIZqKBAvN3f6EKj/XRz3xO8ybpSSoNYMeeuJzBclEsE1jvJE5nMdpyMW1
         wcF+TLWcXHZw8/MGd4yExAWBSMAzaTBf0lWwAeEsXxMadHT6lLOnOH+woLESGjF7/Z+P
         LI4A==
X-Forwarded-Encrypted: i=1; AJvYcCXdHrpIh9W06wdNMMSB3cQkIohBNOd+NSnNV6XBrFFNKGkzGWPU36FX8M+xCsrC+lYexET8@lists.linux.dev
X-Gm-Message-State: AOJu0YxyO8qwmQQed7ltbYH6IbS8QOcoVrOUeUbsIi7Uy+Rz2MmTP2hv
	IVM05wxCRSxj+hsQZm2nyiikvbI1LHGrSGFcdztKMt6TTuAZozOq2pDZcfFWLOP/EQK+u+EYyrv
	yMcpJkWpxmdn/qqSh6pepVFf9UQw=
X-Gm-Gg: ASbGncs5gHJ2RUhDgZskdOqac85+SQxYj5updUlpPBavKA6+EFOxiY6BX5vynVGY3S8
	7arZoJh1vRJQbD6fBgUX9JoLDBiHHCH1q1MUPrRrz3ArHyM43p67LMfbosAr1DfPgTF9rXCpu
X-Google-Smtp-Source: AGHT+IER7wjl6f9njeMck7m0ivCclnh4kfcs7yKY0+I1guG8f5sYgtFMtdPO/1a8VTFbDz5EyQv2cPIiaAaMAZBQ268=
X-Received: by 2002:a05:6512:a8f:b0:545:576:cbca with SMTP id
 2adb3069b0e04-5452fe2ef99mr3503855e87.8.1739861858234; Mon, 17 Feb 2025
 22:57:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250217040928.34561-1-chunjie.zhu@cloud.com>
In-Reply-To: <20250217040928.34561-1-chunjie.zhu@cloud.com>
From: =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date: Tue, 18 Feb 2025 07:57:25 +0100
X-Gm-Features: AWEUYZnV-Lx0KP6OYcQcbVwoe36BP9Dfghup5ZWfXQ0Y3N-qXvk2GRJ-CxLSgXM
Message-ID: <CAHpGcMK0vez+c0NT-U40=JYy+_X-rtfR50KEZXiFXuA6E-tUmQ@mail.gmail.com>
Subject: Re: [PATCH] fix gfs2 umount timeout bug
To: Chunjie Zhu <chunjie.zhu@cloud.com>
Cc: Andreas Gruenbacher <agruenba@redhat.com>, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

Am Mo., 17. Feb. 2025 um 05:10 Uhr schrieb Chunjie Zhu <chunjie.zhu@cloud.com>:
>   If there are heavy lock contenions between nodes in a cluster, at
>   fs umount time,
>
>           node 1                           node 2
>             |                                |
>             |                                |
>      iopen glock lock    -->       iopen glock go_callback
>             |                                |
>             |                                |
>          EAGAIN                       try evict failure
>             |                                |
>             |                                |
>        DLM_ECANCEL                           |
>             |                                |
>             |                                |
>       glock complete                         |
>             |                                |
>             |                                |
>     umount(clear_glock)                      |
>             |                                |
>             |                                |
>  cannot free iopen glock                     |
>             |                                |
>             |                                |
>     umount timeout (*)                       |
>             |                                |
>             |                                |
>       umount complete                        |
>                                              |
>                                              |
>                                        umount succeed

Thank you for your bug report. I'm having a hard time following what
you are trying to say, and the patch itself doesn't look right to me.
If there was a reference counting problem like the patch suggests, we
would probably see regular left-over glocks at unmount time, but I'm
not aware of any such problems. So you ld you please explain in a bit
more detail what you think the problem is? Do you get any messages in
the syslog? The file checksum in the patch refers to commit
bb25b97562e5 ("gfs2: remove dead code in add_to_queue") from 2023.
What exact kernel version are you running?

Thanks,
Andreas

> Signed-off-by: Chunjie Zhu <chunjie.zhu@cloud.com>
> ---
>  fs/gfs2/glock.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
> index 4a280be229a6..bf2445f0afa9 100644
> --- a/fs/gfs2/glock.c
> +++ b/fs/gfs2/glock.c
> @@ -2120,6 +2120,23 @@ static void thaw_glock(struct gfs2_glock *gl)
>         gfs2_glock_queue_work(gl, 0);
>  }
>
> +/**
> + * IOPEN glock might be a zombie glock instance due to lock contention
> + * between nodes in the cluster during fs umount, then it causes umount
> + * timeout
> + */
> +
> +static int is_zombie_glock(struct gfs2_glock *gl)
> +{
> +       if (test_bit(GLF_LOCK, &gl->gl_flags) &&
> +               test_bit(GLF_DEMOTE, &gl->gl_flags) &&
> +               test_bit(GLF_BLOCKING, &gl->gl_flags) &&
> +               (gl->gl_name.ln_type == LM_TYPE_IOPEN) &&
> +               list_empty(&gl->gl_holders))
> +               return 1;
> +       return 0;
> +}
> +
>  /**
>   * clear_glock - look at a glock and see if we can free it from glock cache
>   * @gl: the glock to look at
> @@ -2132,7 +2149,8 @@ static void clear_glock(struct gfs2_glock *gl)
>
>         spin_lock(&gl->gl_lockref.lock);
>         if (!__lockref_is_dead(&gl->gl_lockref)) {
> -               gl->gl_lockref.count++;
> +               if (!is_zombie_glock(gl))
> +                       gl->gl_lockref.count++;
>                 if (gl->gl_state != LM_ST_UNLOCKED)
>                         handle_callback(gl, LM_ST_UNLOCKED, 0, false);
>                 __gfs2_glock_queue_work(gl, 0);
> --
> 2.34.1
>
>
