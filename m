Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F332C18C
	for <gfs2@lists.linux.dev>; Tue, 20 Aug 2024 14:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724163766; cv=none; b=RBcDwYstBNwC/xFAFcHyNRX0us7gKtQ5Fc3KnrVTN+wQ+FllcrMHlgsIVCyQdkxq42JjeG02YIYlNJafzMCiA5ZXe4Cndlx0RouQ2qkCdLzG9bbOpMecc+b8Z9W7ekdwfH3Lo8o+NFoU9//cO/6r4sdXrW+RTOrJGKP/rB2GtV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724163766; c=relaxed/simple;
	bh=JEW4NWuGAZES/b91tJA7nvuGMZ5cDMcGOVSXH5zy+kY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IEOT8oVZYReL6WfKuzoF8cXQFW5ob6rTJvZuRWqsnieveoeLqbqtwygu2UOv2gokqcoHo2lt9HBKupP4o/sAThKn+60YS+4yzC+uaZXWcXnZyENhBzUrEp49SHmA7+l4kqqTA6qiF8dScCaOjsxyT/M1RgRCBghuYSoGIOqnDQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jOKNyR1P; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jOKNyR1P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724163763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q6jI//rw3yShTXZczMS6gQeoAbE9NZq1Blrvaj1FYI0=;
	b=jOKNyR1PWwsQHgQV63WBbhrhznPibe0/hTpMuAi/Z4cTWMQ9z5ad+DlJ0G0/JUFqtjq6aW
	8a/MUvHB0fSCv7n0pNbFy0TiEb6Rw5o+Vau+TQTeAs25ZzXJM3wbn9P0JNFJPPWlfwDoI8
	KE8tZIM6bsV0gSSc7g9nb7QHsEKu02w=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-F_QCLMc9O-2GqhvN77d2Iw-1; Tue, 20 Aug 2024 10:22:41 -0400
X-MC-Unique: F_QCLMc9O-2GqhvN77d2Iw-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-7cd849a6077so52761a12.0
        for <gfs2@lists.linux.dev>; Tue, 20 Aug 2024 07:22:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724163760; x=1724768560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q6jI//rw3yShTXZczMS6gQeoAbE9NZq1Blrvaj1FYI0=;
        b=u/rxGzAmSAr26tiNRTK3l5rfxkGjsJrRfze8paj1X6XtOsvZJMkyPaWdEpO0PGd04S
         Z8/ikZRY/ZgAj9qVZf4fQSzup4owTvfUONy8lNeFmcu1oIxjQrKu8VFeBFLcJmZjeqRX
         qtSBLzMfMJVoO523nDI2ZI+dyPO5Lv9Oic0qcDIXlmWf4WfENZyD3EQTYiZ8CHTgpbuA
         nR+wZGyb4nSRVIw9fsy9i0UXYMpFdq7htP5RLB43KqxDIht5wTkv6VrCppS09UzkbQ6X
         FLgIk2TuAUnm3PbReY81vzvX4rQrse4fqmeDmFlLdfkC9hhvzbM+NUnzjtKi8gY0g/mA
         dyOg==
X-Gm-Message-State: AOJu0YwMJXyb23Hn8WOvPkCBJZMatpGQcuBvBHncT/KLn6YDuOxUwsAn
	qyfH1yKHxi7KgOlrhIfyLa79cEdHsQbOO/Agxm0+Qb5lqrbyQ/DmiVIcLbhkGdYSRLD1NP6j945
	EEHNjXakDtaBwY4jDkfSX9TWFILgqni0eowMPkDYZgmsa26OI6BQqapf6EV5BY+J75ON98Me2qq
	QliWihcW8MZloBQgq8cc7jW4yr1w==
X-Received: by 2002:a17:903:8cc:b0:202:49e:6a35 with SMTP id d9443c01a7336-202049e8428mr129220595ad.19.1724163759905;
        Tue, 20 Aug 2024 07:22:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGw4qLWYKGymRWTPsxtyvsNK4GvYqeKgRIw2A2QWzuIE7zdE3CAMJZZ9/DFiY3NBxHcBD7/3Ez0OLxjQlN5cYQ=
X-Received: by 2002:a17:903:8cc:b0:202:49e:6a35 with SMTP id
 d9443c01a7336-202049e8428mr129219965ad.19.1724163758924; Tue, 20 Aug 2024
 07:22:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240820033148.29662-1-sunjunchao2870@gmail.com>
In-Reply-To: <20240820033148.29662-1-sunjunchao2870@gmail.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Tue, 20 Aug 2024 16:22:27 +0200
Message-ID: <CAHc6FU69hYhBS2rRyXUGAJSHpzNY+kNN9tZBcfWQbL_u5N-MvA@mail.gmail.com>
Subject: Re: [PATCH] gfs2: fix double destroy_workqueue error
To: Julian Sun <sunjunchao2870@gmail.com>
Cc: gfs2@lists.linux.dev, 
	syzbot+d34c2a269ed512c531b0@syzkaller.appspotmail.com, stable@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Aug 20, 2024 at 5:32=E2=80=AFAM Julian Sun <sunjunchao2870@gmail.co=
m> wrote:
> When gfs2_fill_super() fails, destroy_workqueue()
> is called within gfs2_gl_hash_clear(), and the
> subsequent code path calls destroy_workqueue()
> on the same work queue again.
>
> This issue can be fixed by setting the work
> queue pointer to NULL after the first
> destroy_workqueue() call and checking for
> a NULL pointer before attempting to destroy
> the work queue again.
>
> Reported-by: syzbot+d34c2a269ed512c531b0@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dd34c2a269ed512c531b0
> Fixes: 30e388d57367 ("gfs2: Switch to a per-filesystem glock workqueue")
> Cc: stable@vger.kernel.org
> Signed-off-by: Julian Sun <sunjunchao2870@gmail.com>
> ---
>  fs/gfs2/glock.c      | 1 +
>  fs/gfs2/ops_fstype.c | 3 ++-
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
> index 12a769077ea0..4775c2cb8ae1 100644
> --- a/fs/gfs2/glock.c
> +++ b/fs/gfs2/glock.c
> @@ -2249,6 +2249,7 @@ void gfs2_gl_hash_clear(struct gfs2_sbd *sdp)
>         gfs2_free_dead_glocks(sdp);
>         glock_hash_walk(dump_glock_func, sdp);
>         destroy_workqueue(sdp->sd_glock_wq);
> +       sdp->sd_glock_wq =3D NULL;

Here, sdp->sd_glock_wq is set to NULL,

>  }
>
>  static const char *state2str(unsigned state)
> diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
> index ff1f3e3dc65c..c1a7ff713c84 100644
> --- a/fs/gfs2/ops_fstype.c
> +++ b/fs/gfs2/ops_fstype.c
> @@ -1305,7 +1305,8 @@ static int gfs2_fill_super(struct super_block *sb, =
struct fs_context *fc)
>         gfs2_delete_debugfs_file(sdp);
>         gfs2_sys_fs_del(sdp);
>  fail_delete_wq:
> -       destroy_workqueue(sdp->sd_delete_wq);
> +       if (sdp->sd_delete_wq)
> +               destroy_workqueue(sdp->sd_delete_wq);

but here, we check if sdp->sd_delete_wq is NULL? That doesn't make sense.

>  fail_glock_wq:
>         destroy_workqueue(sdp->sd_glock_wq);
>  fail_free:
> --
> 2.39.2
>

Thanks,
Andreas

