Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2A07082F
	for <gfs2@lists.linux.dev>; Sun,  9 Nov 2025 20:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762718801; cv=none; b=cdxjpX4P3/L9ENjuM5/rdlEKe0ING3hEanHG8dfvQ/VOXZQx8VRSNa49TxNvVhiOSU9w5kBTUB1NCHCjaW+4g6YtXEhrHrMlXkKkiC3zLTasPpgcHYFu/idmqai/8RDo2W01iSWoyk2oluDo0waUclNycK8/xLM+JlP5wpOG3bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762718801; c=relaxed/simple;
	bh=boSSzMEXB7844a4cL1y7Tp7xITLx7lwtKv2WKXCb4lY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=SxWflb6HAJFv29KpGGvqhZALJVFVSaiydUieO22cooKWUYUnuEVyFfGzVPG2r1Cp50v8ub/nTdM078WvldwwPkiO3R5joy0kGDm55J2sQ+vxBh1r4NX2Azw6ltM4X0iehREjR5SFHnjE8eITtMba7xDNMIjVr32QEzgFHr7eEkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KJSubE4w; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KJSubE4w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762718798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iSOIOerU3a/JKFzVGKyW07x9hnnmaC3EyeavKIr7W14=;
	b=KJSubE4w4FS34FCcjP8gfhku19MAo3LTaMfJQpp3aloPGZ2URbnqhk5HmerA9tVLID/e/N
	BwfypxwTJJBI09OUox2IUJGO9i32Rt6eklsjxP/yZy2zsIQPfi4Xq7LtK6ZGapllT8bR12
	8YpxfaR98Rh61+HaVti90KO4MYWh35k=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183-NiDTGkThMkGWUQ04cXWCwA-1; Sun, 09 Nov 2025 15:06:37 -0500
X-MC-Unique: NiDTGkThMkGWUQ04cXWCwA-1
X-Mimecast-MFC-AGG-ID: NiDTGkThMkGWUQ04cXWCwA_1762718797
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-63e29ad5503so3436357d50.2
        for <gfs2@lists.linux.dev>; Sun, 09 Nov 2025 12:06:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762718797; x=1763323597;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iSOIOerU3a/JKFzVGKyW07x9hnnmaC3EyeavKIr7W14=;
        b=MeTDTYlgOEzaw/nOfpPVzfYFdEV4qSa0MyM24LBX53KJo5zSA/fCTXXZeRGD9BdpMS
         RKUdYSEWu/PLgUeSDt3znKE/PGjsNu9W6XvzBOLoDVYtZKE5WDm10E+t3nTUJ+9T7Qm6
         iGIO5hLRVVAX6hrNyh6sZNaQkr/T5VkEtgsX/ZDcHHKJi6jzqutgFit7zvhGWigWvyr6
         6aAEI/ZYD41MgDHoAQouwqns3/Ughnao7xDX0vJttjjYK6tIS5QOuJUIn+GKMQITe5aL
         BtKS5yiz0tZd+R9g4Hap/59CSE3Bh4xRNxlSPPgpzHA8GTHE46QG3COcjdzp8RUvQkI/
         Xa8Q==
X-Gm-Message-State: AOJu0YzSmmmiAglfVXPHpZKZX0bN/6XjUhKXwlW+q081PFApLpKhW0ab
	WHO1a6dQguIDJAQ2Ov7LjnCMpZgaocSgHy6qaPloVdQesyNKtwzvtkN/XgYMnOg6z9e5j+F+R4J
	T1mQ/Z7l1C/JtoJL7JU2n5WkjibvxjHGZR9TtmJj8j6WohC+jLxyx9I0rRcixeAaq7KJBcaxfCl
	yi0ru99beHhoymt4Q1bdpfnW0VRtepmsSlM897QKNg
X-Gm-Gg: ASbGncv5wA5M1rTTEUWxnOep73WEdDbV7b4R5kzDPG4lo3aQJBAswem4+WxoEPkZ3Ng
	vGm9MCzczwtM6jqcbaCQoyFhMZxObtVhhCK2sXMgNRAzm5i6w906qnPdpbAzlwXv9E3Tf1rn5M0
	X6vjKLtqufvEy+VfUjTLeN5pmh489rTfn4PHFdFUePIQNUJq72MxznsQ==
X-Received: by 2002:a05:690e:2483:b0:63f:b922:ed8e with SMTP id 956f58d0204a3-640d452b7d7mr4439184d50.3.1762718796575;
        Sun, 09 Nov 2025 12:06:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEm/IwDZdDC8EIhI7D4D2ZbRRm7USIZpmiecILuEhczvASel2S9jY87Pf35Pfe7raXnHvmi4hKfPenvpUXwDTc=
X-Received: by 2002:a05:690e:2483:b0:63f:b922:ed8e with SMTP id
 956f58d0204a3-640d452b7d7mr4439172d50.3.1762718796228; Sun, 09 Nov 2025
 12:06:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251101002234.1286383-1-agruenba@redhat.com> <20251101002234.1286383-21-agruenba@redhat.com>
In-Reply-To: <20251101002234.1286383-21-agruenba@redhat.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Sun, 9 Nov 2025 21:06:25 +0100
X-Gm-Features: AWmQ_bnqnvzwR_SfS6dCC8PfKchX6OBU2JZUSZF2EvEZHT0QLm93CqhDBl6ZDrA
Message-ID: <CAHc6FU7wRMSpQmc+X3MfHPZueVxnvw+ZGPsMQ2=-n1UbYdSMKw@mail.gmail.com>
Subject: Re: [PATCH 20/24] gfs2: Clean up properly during a withdraw
To: gfs2@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XyPED90gJ3AtwVuTDRnxu2UKHNN-5mQfmZciKi6tFg4_1762718797
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 1, 2025 at 1:23=E2=80=AFAM Andreas Gruenbacher <agruenba@redhat=
.com> wrote:
> During a withdraw, we don't want to write out any more data than we have
> to, so in do_xmote(), skip the ->go_sync() glock operation.  We still
> want to keep calling ->go_inval() to discard any cached data or
> metadata, whether clean or dirty.
>
> We do still allow glocks to transition into state LM_ST_UNLOCKED.  This
> has the desired side effect of calling ->go_inval() and invalidating the
> glock caches.
>
> Function gfs2_withdraw_glocks() is already used for dequeuing any
> left-over waiters.  We still want that to happen, but additionally, we
> want all glocks to be unlocked.
>
> Finally, we change function do_promote() to refuse any further
> promotions.
>
> This commit cleans up the leftovers of commit 86934198eefa ("gfs2: Clear
> flags when withdraw prevents xmote").
>
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> ---
>  fs/gfs2/glock.c | 83 +++++++++++++++++++++++++++----------------------
>  1 file changed, 46 insertions(+), 37 deletions(-)
>
> diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
> index 7c20750e482d..bc6f236b899c 100644
> --- a/fs/gfs2/glock.c
> +++ b/fs/gfs2/glock.c
> @@ -458,8 +458,12 @@ int gfs2_instantiate(struct gfs2_holder *gh)
>
>  static void do_promote(struct gfs2_glock *gl)
>  {
> +       struct gfs2_sbd *sdp =3D gl->gl_name.ln_sbd;
>         struct gfs2_holder *gh, *current_gh;
>
> +       if (gfs2_withdrawn(sdp))

Need to call do_error(gl, LM_OUT_ERROR) here to fail all pending
requests or else run_queue() will get confused about the lack of
progress.

> +               return;
> +
>         current_gh =3D find_first_holder(gl);
>         list_for_each_entry(gh, &gl->gl_holders, gh_list) {
>                 if (test_bit(HIF_HOLDER, &gh->gh_iflags))
> @@ -565,7 +569,6 @@ static void finish_xmote(struct gfs2_glock *gl, unsig=
ned int ret)
>                 state_change(gl, state);
>         }
>
> -
>         /* Demote to UN request arrived during demote to SH or DF */
>         if (test_bit(GLF_DEMOTE_IN_PROGRESS, &gl->gl_flags) &&
>             gl->gl_state !=3D LM_ST_UNLOCKED &&
> @@ -654,28 +657,36 @@ __acquires(&gl->gl_lockref.lock)
>         struct lm_lockstruct *ls =3D &sdp->sd_lockstruct;
>         int ret;
>
> -       if (target !=3D LM_ST_UNLOCKED && gfs2_withdrawn(sdp))
> -               goto skip_inval;
> +       /*
> +        * When a filesystem is withdrawing, the remaining cluster nodes =
will
> +        * take care of recovering the withdrawing node's journal.  We on=
ly
> +        * need to make sure that once we trigger remote recovery, we won=
't
> +        * write to the shared block device anymore.  This means that her=
e,
> +        *
> +        * - no new writes to the filesystem must be triggered (->go_sync=
()).
> +        *
> +        * - any cached data should be discarded by calling ->go_inval(),=
 dirty
> +        *   or not and journaled or unjournaled.
> +        *
> +        * - no more dlm locking operations should be issued (->lm_lock()=
).
> +        */
>
>         GLOCK_BUG_ON(gl, gl->gl_state =3D=3D target);
>         GLOCK_BUG_ON(gl, gl->gl_state =3D=3D gl->gl_target);
> +
>         if (!glops->go_inval || !glops->go_sync)
>                 goto skip_inval;
>
>         spin_unlock(&gl->gl_lockref.lock);
> -       ret =3D glops->go_sync(gl);
> -       /* If we had a problem syncing (due to io errors or whatever,
> -        * we should not invalidate the metadata or tell dlm to
> -        * release the glock to other nodes.
> -        */
> -       if (ret) {
> -               if (cmpxchg(&sdp->sd_log_error, 0, ret)) {
> -                       fs_err(sdp, "Error %d syncing glock\n", ret);
> -                       gfs2_dump_glock(NULL, gl, true);
> -                       gfs2_withdraw(sdp);
> +       if (!gfs2_withdrawn(sdp)) {
> +               ret =3D glops->go_sync(gl);
> +               if (ret) {
> +                       if (cmpxchg(&sdp->sd_log_error, 0, ret)) {
> +                               fs_err(sdp, "Error %d syncing glock\n", r=
et);
> +                               gfs2_dump_glock(NULL, gl, true);
> +                               gfs2_withdraw(sdp);
> +                       }
>                 }
> -               spin_lock(&gl->gl_lockref.lock);
> -               goto skip_inval;
>         }
>
>         if (target =3D=3D LM_ST_UNLOCKED || target =3D=3D LM_ST_DEFERRED)
> @@ -683,25 +694,10 @@ __acquires(&gl->gl_lockref.lock)
>         spin_lock(&gl->gl_lockref.lock);
>
>  skip_inval:
> -       if (gfs2_withdrawn(sdp) && target !=3D LM_ST_UNLOCKED) {
> -               request_demote(gl, LM_ST_UNLOCKED, 0, false);
> -               /*
> -                * Ordinarily, we would call dlm and its callback would c=
all
> -                * finish_xmote, which would call state_change() to the n=
ew state.
> -                * Since we withdrew, we won't call dlm, so call state_ch=
ange
> -                * manually, but to the UNLOCKED state we desire.
> -                */
> -               state_change(gl, LM_ST_UNLOCKED);
> -               /*
> -                * We skip telling dlm to do the locking, so we won't get=
 a
> -                * reply that would otherwise clear GLF_LOCK. So we clear=
 it here.
> -                */
> -               if (!test_bit(GLF_CANCELING, &gl->gl_flags))
> -                       clear_bit(GLF_LOCK, &gl->gl_flags);
> -               clear_bit(GLF_DEMOTE_IN_PROGRESS, &gl->gl_flags);
> -               gl->gl_lockref.count++;
> -               gfs2_glock_queue_work(gl, GL_GLOCK_DFT_HOLD);
> -               return;
> +       if (gfs2_withdrawn(sdp)) {
> +               if (target !=3D LM_ST_UNLOCKED)
> +                       target =3D LM_OUT_ERROR;
> +               goto out;
>         }
>
>         if (ls->ls_ops->lm_lock) {
> @@ -717,12 +713,15 @@ __acquires(&gl->gl_lockref.lock)
>                 }
>                 clear_bit(GLF_PENDING_REPLY, &gl->gl_flags);
>
> -               if (ret =3D=3D -ENODEV && gl->gl_target =3D=3D LM_ST_UNLO=
CKED &&
> -                   target =3D=3D LM_ST_UNLOCKED) {
> +               if (ret =3D=3D -ENODEV) {
>                         /*
>                          * The lockspace has been released and the lock h=
as
>                          * been unlocked implicitly.
>                          */
> +                       if (target !=3D LM_ST_UNLOCKED) {
> +                               target =3D LM_OUT_ERROR;
> +                               goto out;
> +                       }
>                 } else {
>                         fs_err(sdp, "lm_lock ret %d\n", ret);
>                         GLOCK_BUG_ON(gl, !gfs2_withdrawn(sdp));
> @@ -730,6 +729,7 @@ __acquires(&gl->gl_lockref.lock)
>                 }
>         }
>
> +out:
>         /* Complete the operation now. */
>         finish_xmote(gl, target);
>         gl->gl_lockref.count++;
> @@ -2072,8 +2072,17 @@ static void dump_glock_func(struct gfs2_glock *gl)
>  static void withdraw_glock(struct gfs2_glock *gl)
>  {
>         spin_lock(&gl->gl_lockref.lock);
> -       if (!__lockref_is_dead(&gl->gl_lockref))
> +       if (!__lockref_is_dead(&gl->gl_lockref)) {
> +               /*
> +                * We don't want to write back any more dirty data.  Unlo=
ck the
> +                * remaining inode and resource group glocks; this will c=
ause
> +                * their ->go_inval() hooks to toss out all the remaining
> +                * cached data, dirty or not.
> +                */
> +               if (gl->gl_ops->go_inval && gl->gl_state !=3D LM_ST_UNLOC=
KED)
> +                       request_demote(gl, LM_ST_UNLOCKED, 0, false);
>                 do_error(gl, LM_OUT_ERROR); /* remove pending waiters */
> +       }
>         spin_unlock(&gl->gl_lockref.lock);
>  }
>
> --
> 2.51.0
>

