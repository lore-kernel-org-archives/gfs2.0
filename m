Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606CE3242D8
	for <gfs2@lists.linux.dev>; Tue,  1 Sep 2026 12:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788266658; cv=none; b=Tn84rdFz6lRnx+6MZIt8LyeFHahSqljkdaKP8MwxM84pkcSHWUC9vJc2NkeGtTfWxhdwoyBaj1ijdgoy0dXPQB7V5zKXjCRbVurqhM61IS9ONS4PDXNGAFZe3v1ohPd0XeI4tfOQvRD+9zRn9E/YPTVQMLXbiFL66qd8rqLog9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788266658; c=relaxed/simple;
	bh=axs/Jp9HfnieSJ6N1EsRzIxQNGZCjsD4t7RdlBvZuPo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=miZq0bHvAVZn7zs2YSwcfrHM9c0vvI68Ff/ctvdUmAL7+8mqCmy9eecEZV4BILyrUJtmc29tOexXyapEA6PcUC+3C+7/Eiyvwlz0wFm/hEttOukgBUgH85XcAjWVG/AoTfe7lNksAxJlodX8CQf/BweF/czWmtbE29oCo6WaRag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KrZFHxmy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KrZFHxmy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788266656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t13gfeGKJNDjr51aQbYjUF+RjWjwjo9NSAsZPS54F3E=;
	b=KrZFHxmyOX5rC7uJC1wRYLa8u8GYknkYw+jrO2tV3H1gmgPtQWpfbJlL9CV982e2B/JUI3
	I3C35R6rQx3Ut2f2P3JVE3CtEgRfFQyrjyZ1rkw6QlQIic+20aTTTrTjpqH8g+/q7V9Rf4
	KUXLBtLzUHO3lv2ZDXKV0VJN5djPuME=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-bmcE4abGM8CNN7FZsfFbVw-1; Tue, 01 Sept 2026 08:44:14 -0400
X-MC-Unique: bmcE4abGM8CNN7FZsfFbVw-1
X-Mimecast-MFC-AGG-ID: bmcE4abGM8CNN7FZsfFbVw_1788266654
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-836c8fc03a4so12038027b3.1
        for <gfs2@lists.linux.dev>; Tue, 01 Sep 2026 05:44:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788266654; x=1788871454;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=t13gfeGKJNDjr51aQbYjUF+RjWjwjo9NSAsZPS54F3E=;
        b=NCNjHRzJKfl/ZNM4GVJ/FPfAHCtC+qNDK06zVnL4a4nqX0LS97U2bjEYzXwVtjLH0z
         bOCiY2ZBYDvYPnOkMCGYtbxpJTR5BNJgM3ZETMfp59YquCXIEfZqqlHRLWm7PEWedwcX
         yR91iSGMWUn90SBj894v8AZ1X9kY0SwzH45btrck9ZjgVKeSuddP7TzAnCZJs7lMBixZ
         bWVNahWZFZqfs4cZmkNDSLfizIu8zX/S+d24sPjKJlorlz2kkOUazUXPmIna/OX1YXSI
         05CCHeENDR8oQSeFLvMTkTH+u6OGV0lS02wYKrlZwrYnqnkeSbld9BP3CqWi+fGiGymr
         hjfA==
X-Gm-Message-State: AFuF++lzI0lbZe385OkrQtiBF5tmatR9zyLZNSP6UF0/sI2eObuViJrE
	A7ALNRFlmtYXvRfCjfvEOgl11W/PrWa+u4pHPjfkKnz/fqQAKmSaBYJb5ZMob0IkhE7roTXFOce
	keOdgwbqfIhE/1WcD6NWK3+gxJfJiHZA1PU4Rx6cM8AMM9MS07Qekayw/SQsAmNQY9rya4j6ocL
	P+Q4JRBQ8riSMDrtXKaVOlCBus6Fz0SzFHGATjvQ==
X-Gm-Gg: AYBFou1uTQ3Tmr1xXAuNXDIrHEWYuHQ+83GR1oEC3pXSMgRrNUrrN2XhcefiFfvMBE2
	xOEy/a/0oSt/LczjLLzpmAquftB3I/2OIrDOvQASOs359ytrvNNeYjSgRROI1w2iyq3vpuRl5Nt
	qT9RCL9+Brtw84qKnE2HO1/PDBpmcqV8feusaSoEGggK6uwTKqcRV7X+O5L0pbVjrTma0nPChAi
	Yxn3ir1AC/AZJPwjkg6KWpDOVAyXLo+xm5ExoqIwWhe
X-Received: by 2002:a05:690e:b8e:b0:66e:6231:5735 with SMTP id 956f58d0204a3-66e62315a4dmr5919488d50.18.1788266654052;
        Tue, 01 Sep 2026 05:44:14 -0700 (PDT)
X-Received: by 2002:a05:690e:b8e:b0:66e:6231:5735 with SMTP id
 956f58d0204a3-66e62315a4dmr5919470d50.18.1788266653354; Tue, 01 Sep 2026
 05:44:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260831130903.572605-1-agruenba@redhat.com>
In-Reply-To: <20260831130903.572605-1-agruenba@redhat.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Tue, 1 Sep 2026 14:44:02 +0200
X-Gm-Features: AcwNN1ULHnZJbcPFh3YHCylO6WhHtFsN_DOaSVCaksEHfqbCS9RtnOlXHRex3WI
Message-ID: <CAHc6FU7B7ACGkWhnGBxTQey9vS1sOAVOkEOq6kazrfq4K5D5UA@mail.gmail.com>
Subject: Re: [PATCH] gfs2: Get rid of sd_async_glock_wait
To: gfs2@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GDQ4RvmIGvC59zuh564JSfc4uV918UI5XQsyZXf56jE_1788266654
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2026 at 3:09=E2=80=AFPM Andreas Gruenbacher <agruenba@redha=
t.com> wrote:
> Get rid of the per-superblock wait queue for asynchronous locking request=
s.
> Instead, wait for the specific events we are interested in.  Use multiple=
 wait
> queue entries when waiting for multiple events at once.
>
> Without this patch, the per-superblock wait queue for asynchronous lockin=
g
> requests can become a bottleneck when many inodes are deleted remotely: i=
n that
> case, we schedule delayed work with gfs2_queue_verify_delete().  When tha=
t work
> later runs, we end up in delete_work_func() -> iput() -> gfs2_evict_inode=
() ->
> gfs2_upgrade_iopen_glock(), which uses asynchronous locking.  Each comple=
ting
> locking asynchronous request will wake up sdp->sd_async_glock_wait, and a=
ll the
> waiters will compete with each other and waste resources.  Avoid that by
> eliminating the per-superblock wait queue.
>
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> ---
>  fs/gfs2/glock.c      | 56 ++++++++++++++++++++++++++++++--------------
>  fs/gfs2/incore.h     |  1 -
>  fs/gfs2/ops_fstype.c |  1 -
>  fs/gfs2/super.c      | 30 ++++++++++++++++++++----
>  4 files changed, 63 insertions(+), 25 deletions(-)
>
> diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
> index d0612014408e..d22a088c66cd 100644
> --- a/fs/gfs2/glock.c
> +++ b/fs/gfs2/glock.c
> @@ -329,11 +329,6 @@ static void gfs2_holder_wake(struct gfs2_holder *gh)
>         clear_bit(HIF_WAIT, &gh->gh_iflags);
>         smp_mb__after_atomic();
>         wake_up_bit(&gh->gh_iflags, HIF_WAIT);
> -       if (gh->gh_flags & GL_ASYNC) {
> -               struct gfs2_sbd *sdp =3D glock_sbd(gh->gh_gl);
> -
> -               wake_up(&sdp->sd_async_glock_wait);
> -       }
>  }
>
>  /**
> @@ -512,11 +507,9 @@ static void state_change(struct gfs2_glock *gl, unsi=
gned int new_state)
>
>  static void gfs2_set_demote(int nr, struct gfs2_glock *gl)
>  {
> -       struct gfs2_sbd *sdp =3D glock_sbd(gl);
> -
>         set_bit(nr, &gl->gl_flags);
> -       smp_mb();
> -       wake_up(&sdp->sd_async_glock_wait);
> +       smp_mb__after_atomic();
> +       wake_up_bit(&gl->gl_flags, GLF_DEMOTE);
>  }
>
>  static void gfs2_demote_wake(struct gfs2_glock *gl)
> @@ -1272,11 +1265,14 @@ static int glocks_pending(unsigned int num_gh, st=
ruct gfs2_holder *ghs)
>  int gfs2_glock_async_wait(unsigned int num_gh, struct gfs2_holder *ghs,
>                           unsigned int retries)
>  {
> -       struct gfs2_sbd *sdp =3D glock_sbd(ghs[0].gh_gl);
>         unsigned long start_time =3D jiffies;
> -       int i, ret =3D 0;
> -       long timeout;
> +       struct wait_queue_head *waitq[4];
> +       struct wait_queue_entry wait[4];
> +       long ret, timeout;
> +       int i;
>
> +       BUILD_BUG_ON(ARRAY_SIZE(waitq) !=3D ARRAY_SIZE(wait));
> +       BUG_ON(num_gh > ARRAY_SIZE(wait));
>         might_sleep();
>
>         timeout =3D GL_GLOCK_MIN_HOLD;
> @@ -1294,14 +1290,38 @@ int gfs2_glock_async_wait(unsigned int num_gh, st=
ruct gfs2_holder *ghs,
>                 timeout +=3D (incr / 3) + get_random_long() % (incr / 3);
>         }
>
> -       if (!wait_event_interruptible_timeout(sdp->sd_async_glock_wait,
> -                               !glocks_pending(num_gh, ghs), timeout)) {
> -               ret =3D -ESTALE; /* request timed out. */
> -               goto out;
> +       ret =3D timeout;
> +       for (i =3D 0; i < num_gh; i++) {
> +               waitq[i] =3D bit_waitqueue(&ghs[i].gh_iflags, HIF_WAIT);
> +               init_wait(wait + i);
> +       }
> +       for (;;) {
> +               for (i =3D 0; i < num_gh; i++)
> +                       prepare_to_wait(waitq[i], wait + i, TASK_INTERRUP=
TIBLE);
> +               if (!glocks_pending(num_gh, ghs))
> +                       break;
> +               if (signal_pending(current)) {
> +                       ret =3D -EINTR;
> +                       break;
> +               }
> +               ret =3D schedule_timeout(ret);
> +               if (!glocks_pending(num_gh, ghs))
> +                       break;
> +               if (!ret) {
> +                       ret =3D -ESTALE; /* request timed out. */
> +                       break;
> +               }
> +               if (signal_pending(current)) {
> +                       ret =3D -EINTR;
> +                       break;
> +               }
>         }
> -       if (signal_pending(current))
> -               goto interrupted;
> +       for (i =3D 0; i < num_gh; i++)
> +               finish_wait(waitq[i], wait + i);
> +       if (ret < 0)
> +               goto out;
>
> +       ret =3D 0;
>         for (i =3D 0; i < num_gh; i++) {
>                 struct gfs2_holder *gh =3D &ghs[i];
>                 int ret2;
> diff --git a/fs/gfs2/incore.h b/fs/gfs2/incore.h
> index 0a48f8e8ed6c..49cc232942a2 100644
> --- a/fs/gfs2/incore.h
> +++ b/fs/gfs2/incore.h
> @@ -716,7 +716,6 @@ struct gfs2_sbd {
>         struct work_struct sd_freeze_work;
>         struct work_struct sd_withdraw_work;
>         wait_queue_head_t sd_kill_wait;
> -       wait_queue_head_t sd_async_glock_wait;
>         atomic_t sd_glock_disposal;
>         struct completion sd_locking_init;
>         struct completion sd_withdraw_helper;
> diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
> index 188b3e67f2d1..6ec47376aecf 100644
> --- a/fs/gfs2/ops_fstype.c
> +++ b/fs/gfs2/ops_fstype.c
> @@ -90,7 +90,6 @@ static struct gfs2_sbd *init_sbd(struct super_block *sb=
)
>         gfs2_tune_init(&sdp->sd_tune);
>
>         init_waitqueue_head(&sdp->sd_kill_wait);
> -       init_waitqueue_head(&sdp->sd_async_glock_wait);
>         atomic_set(&sdp->sd_glock_disposal, 0);
>         init_completion(&sdp->sd_locking_init);
>         init_completion(&sdp->sd_withdraw_helper);
> diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
> index af8c71576833..f8297c58e491 100644
> --- a/fs/gfs2/super.c
> +++ b/fs/gfs2/super.c
> @@ -1180,8 +1180,10 @@ static enum evict_behavior gfs2_upgrade_iopen_gloc=
k(struct inode *inode)
>  {
>         struct gfs2_glock *gl =3D gfs2_inode_glock(inode);
>         struct gfs2_inode *ip =3D GFS2_I(inode);
> -       struct gfs2_sbd *sdp =3D GFS2_SB(inode);
>         struct gfs2_holder *gh =3D &ip->i_iopen_gh;
> +       struct wait_queue_head *holder_waitq, *glock_waitq;
> +       struct wait_queue_entry holder_wait, glock_wait;
> +       long ret =3D 5 * HZ;
>         int error;
>
>         gh->gh_flags |=3D GL_NOCACHE;
> @@ -1212,10 +1214,28 @@ static enum evict_behavior gfs2_upgrade_iopen_glo=
ck(struct inode *inode)
>         if (error)
>                 return EVICT_SHOULD_SKIP_DELETE;
>
> -       wait_event_interruptible_timeout(sdp->sd_async_glock_wait,
> -               !test_bit(HIF_WAIT, &gh->gh_iflags) ||
> -               glock_needs_demote(gl),
> -               5 * HZ);
> +       holder_waitq =3D bit_waitqueue(&gh->gh_iflags, HIF_WAIT);
> +       glock_waitq =3D bit_waitqueue(&gl->gl_flags, GLF_DEMOTE);
> +       init_wait(&holder_wait);
> +       init_wait(&glock_wait);
> +       for (;;) {
> +               prepare_to_wait(holder_waitq, &holder_wait, TASK_INTERRUP=
TIBLE);
> +               prepare_to_wait(glock_waitq, &glock_wait, TASK_INTERRUPTI=
BLE);
> +               if (!test_bit(HIF_WAIT, &gh->gh_iflags) ||
> +                   glock_needs_demote(gl))
> +                       break;
> +               if (signal_pending(current))
> +                       break;
> +               ret =3D schedule_timeout(ret);
> +               if (!test_bit(HIF_WAIT, &gh->gh_iflags) ||
> +                   glock_needs_demote(gl))
> +                       break;

Check for ret =3D=3D 0 missing here; will post an update.

> +               if (signal_pending(current))
> +                       break;
> +       }
> +       finish_wait(holder_waitq, &holder_wait);
> +       finish_wait(glock_waitq, &glock_wait);
> +
>         if (!test_bit(HIF_HOLDER, &gh->gh_iflags)) {
>                 gfs2_glock_dq(gh);
>                 if (glock_needs_demote(gl))
> --
> 2.55.0
>

