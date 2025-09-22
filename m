Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DB522259A
	for <gfs2@lists.linux.dev>; Mon, 22 Sep 2025 21:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758576959; cv=none; b=jtD10spXSyr/0f00LQs8k8ogjCuAAUcPcAHa+zqQA5WEV6mpXy0SahnbkWnx/e3ixmhLUCKnlH86cmpq4aQbKikr/KfRWQqhRHr7Fbr828vGTWXHg0Jk8YF7cbndriuYkTvxyy7akqabet6pYVW1zvHtgzkLFmav0nPv+TBNdBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758576959; c=relaxed/simple;
	bh=VbyGb0ADaJP1LnboWK9/Ki5sqHZlnzSV2T4UXWHw9/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BbJgD2UiUcvTrbghKhZVsYPSiVeOietmkA6lBWgYuV0vVQtODSpSsAet6U8ftit6pIMHWRlW2S5fxc8+dsoEqLsPLisz7vJUjo9CHiFcL1YZMo3a5+1Exz7nUb8aAdy8fHM0uGenrPK+VhrfSSsRvuE8dpg0lPmod2XojQtWuPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dz7ovSlU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dz7ovSlU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758576956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1RPEUkun/q94eBr285fzSBnT9trDj+RI+RBAslAHtYU=;
	b=Dz7ovSlU0CV5xIloC6m1FXBClqiGXHK7oRc0aScdiw7TGmyrO/MMr2jUlyNisW8Wzi2k2H
	X1E4UTLkIzLosqTdMV/oEE8g2WW6U42kn7X0Qkg4NW8UrVHLSoxh9Hedm0KTdZzRHF8QE8
	5VYyfqA96kQ0naQ61EXxcm1ZB9b3gbA=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-upjpeRjQNNCL9nW6h8gZPg-1; Mon, 22 Sep 2025 17:35:55 -0400
X-MC-Unique: upjpeRjQNNCL9nW6h8gZPg-1
X-Mimecast-MFC-AGG-ID: upjpeRjQNNCL9nW6h8gZPg_1758576954
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b54a30515cfso4507030a12.1
        for <gfs2@lists.linux.dev>; Mon, 22 Sep 2025 14:35:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758576954; x=1759181754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1RPEUkun/q94eBr285fzSBnT9trDj+RI+RBAslAHtYU=;
        b=fe9rzvSwV7ATqMeJgyyB42pyy1npeYTWQH+qrioqihc3ejXspj5Coehq0bM/O9EKRk
         81GOP5Z25vgff65fC52AnIW5HfoUZqD9vZycJMrecJrp88r7W+lyPdOqOYG84/GIY4Qd
         +qsJ0VQhQ7HasYqsg6IZrgmveXvW/uXPz5F6e8Irb01B490FA5ckdT+NErc7Lwa6Vs8j
         Kx4X9a1WIyUV1k8q42baZqOgMLVcEyHReg7UToY08R++vFl6slx1495ITInZXUlGyzaO
         UJjObWQAc6sf6qDDdXBlbv/TFPvoiWLBDGat7o7+RUBFf/JRkRTWqtV6yNDr/S9fov84
         VNNw==
X-Gm-Message-State: AOJu0YzC7uHDiu1Q21iWq6Kahg20jDa1xJXHzjsrPAostpbRLy5AqRoE
	4OaLI5XFIdAXg6AE0BpcObtM9oROPAhfdpH7XlYdZPY99cgh9RKtrH7LpZ4aIIUyt3+IpF007pD
	WwDbrnoVkVDldLe9fIZAGy6AI45BneEvQVD3SzMC5Y4Rco6anDVWP0Q6H8TiwP0E1Fg2eDIUwRg
	bWnlO8vL3lDUs+aS9C1HBA+ddsXVgnTQ==
X-Gm-Gg: ASbGncvfOXufQRylHVgOd6WYE0WWTVtFZqd5UumY+QAmz6K/KpBbYJW3gBuRk3BHNfB
	FuMEQdLP9/1mKW0ixAqTgZjulnkXdlPGQy/05kjibGwhcyrEFPBSyYl5hra/TVBhRB9U76qHgQA
	J3QZJiEXpVyd/4i556OeE=
X-Received: by 2002:a17:903:11c9:b0:271:9b0e:54c7 with SMTP id d9443c01a7336-27cd783aaddmr2162555ad.11.1758576954189;
        Mon, 22 Sep 2025 14:35:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxbJnNy7LS1zhaed02+B0QANrc9D8VB3JxCVwMOEf2ETpnZsqXiVqB5gnwqCQu5ljt0HxTySAOL9QwmgCJxbc=
X-Received: by 2002:a17:903:11c9:b0:271:9b0e:54c7 with SMTP id
 d9443c01a7336-27cd783aaddmr2162305ad.11.1758576953749; Mon, 22 Sep 2025
 14:35:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250922175237.37474-1-utkarsh.singh.em@gmail.com>
In-Reply-To: <20250922175237.37474-1-utkarsh.singh.em@gmail.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Mon, 22 Sep 2025 23:35:42 +0200
X-Gm-Features: AS18NWBRPoK2cK1D6IHxCDq1KCuIosAbx4R9u3PG5dUF71-5tH5KkSxGfyVxq4o
Message-ID: <CAHc6FU5C3n2wyO91gcDVLGr643d1Y5e4xPmM1d9rw18A=fod9g@mail.gmail.com>
Subject: Re: [PATCH v2] gfs2/sysfs: Replace sprintf/snprintf with sysfs_emit()
To: Utkarsh Singh <utkarsh.singh.em@gmail.com>
Cc: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	skhan@linuxfoundation.org, rpeterso@redhat.com, david.hunter.linux@gmail.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: KqIGoBv4snrDs7NY-R86oi8MSkACxAEwyx2rdNlVQH8_1758576954
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 7:53=E2=80=AFPM Utkarsh Singh
<utkarsh.singh.em@gmail.com> wrote:
> Documentation/filesystems/sysfs.rst mentions that show() should only
> use sysfs_emit() or sysfs_emit_at() when formatting values returned
> to user space. This patch updates the GFS2 sysfs interface accordingly.
>
> It replaces uses of sprintf() and snprintf() in all *_show() functions
> with sysfs_emit() to align with current kernel sysfs API best practices.

I've applied that part. I'm not pushing this into the upcoming merge
window anymore, though.

> It also updates the GFS2_SHOW_UINT macro to use sysfs_emit() instead
> of snprintf().

Huh, what's that?

> Signed-off-by: Utkarsh Singh <utkarsh.singh.em@gmail.com>
> ---
>  v1 --> v2: Code style cleanup and maintainer updates
>
>  fs/gfs2/sys.c | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
>
> diff --git a/fs/gfs2/sys.c b/fs/gfs2/sys.c
> index c3c8842920d2..487fff098465 100644
> --- a/fs/gfs2/sys.c
> +++ b/fs/gfs2/sys.c
> @@ -59,7 +59,7 @@ static struct kset *gfs2_kset;
>
>  static ssize_t id_show(struct gfs2_sbd *sdp, char *buf)
>  {
> -       return snprintf(buf, PAGE_SIZE, "%u:%u\n",
> +       return sysfs_emit(buf, "%u:%u\n",
>                         MAJOR(sdp->sd_vfs->s_dev), MINOR(sdp->sd_vfs->s_d=
ev));
>  }
>
> @@ -68,7 +68,7 @@ static ssize_t status_show(struct gfs2_sbd *sdp, char *=
buf)
>         unsigned long f =3D sdp->sd_flags;
>         ssize_t s;
>
> -       s =3D snprintf(buf, PAGE_SIZE,
> +       s =3D sysfs_emit(buf,
>                      "Journal Checked:          %d\n"
>                      "Journal Live:             %d\n"
>                      "Journal ID:               %d\n"
> @@ -140,7 +140,7 @@ static ssize_t status_show(struct gfs2_sbd *sdp, char=
 *buf)
>
>  static ssize_t fsname_show(struct gfs2_sbd *sdp, char *buf)
>  {
> -       return snprintf(buf, PAGE_SIZE, "%s\n", sdp->sd_fsname);
> +       return sysfs_emit(buf, "%s\n", sdp->sd_fsname);
>  }
>
>  static ssize_t uuid_show(struct gfs2_sbd *sdp, char *buf)
> @@ -150,7 +150,7 @@ static ssize_t uuid_show(struct gfs2_sbd *sdp, char *=
buf)
>         buf[0] =3D '\0';
>         if (uuid_is_null(&s->s_uuid))
>                 return 0;
> -       return snprintf(buf, PAGE_SIZE, "%pUB\n", &s->s_uuid);
> +       return sysfs_emit(buf, "%pUB\n", &s->s_uuid);
>  }
>
>  static ssize_t freeze_show(struct gfs2_sbd *sdp, char *buf)
> @@ -158,7 +158,7 @@ static ssize_t freeze_show(struct gfs2_sbd *sdp, char=
 *buf)
>         struct super_block *sb =3D sdp->sd_vfs;
>         int frozen =3D (sb->s_writers.frozen =3D=3D SB_UNFROZEN) ? 0 : 1;
>
> -       return snprintf(buf, PAGE_SIZE, "%d\n", frozen);
> +       return sysfs_emit(buf, "%d\n", frozen);
>  }
>
>  static ssize_t freeze_store(struct gfs2_sbd *sdp, const char *buf, size_=
t len)
> @@ -194,7 +194,7 @@ static ssize_t freeze_store(struct gfs2_sbd *sdp, con=
st char *buf, size_t len)
>  static ssize_t withdraw_show(struct gfs2_sbd *sdp, char *buf)
>  {
>         unsigned int b =3D gfs2_withdrawing_or_withdrawn(sdp);
> -       return snprintf(buf, PAGE_SIZE, "%u\n", b);
> +       return sysfs_emit(buf, "%u\n", b);
>  }
>
>  static ssize_t withdraw_store(struct gfs2_sbd *sdp, const char *buf, siz=
e_t len)
> @@ -397,7 +397,7 @@ static struct kobj_type gfs2_ktype =3D {
>  static ssize_t proto_name_show(struct gfs2_sbd *sdp, char *buf)
>  {
>         const struct lm_lockops *ops =3D sdp->sd_lockstruct.ls_ops;
> -       return sprintf(buf, "%s\n", ops->lm_proto_name);
> +       return sysfs_emit(buf, "%s\n", ops->lm_proto_name);
>  }
>
>  static ssize_t block_show(struct gfs2_sbd *sdp, char *buf)
> @@ -408,7 +408,7 @@ static ssize_t block_show(struct gfs2_sbd *sdp, char =
*buf)
>
>         if (test_bit(DFL_BLOCK_LOCKS, &ls->ls_recover_flags))
>                 val =3D 1;
> -       ret =3D sprintf(buf, "%d\n", val);
> +       ret =3D sysfs_emit(buf, "%d\n", val);
>         return ret;
>  }
>
> @@ -437,7 +437,7 @@ static ssize_t wdack_show(struct gfs2_sbd *sdp, char =
*buf)
>  {
>         int val =3D completion_done(&sdp->sd_wdack) ? 1 : 0;
>
> -       return sprintf(buf, "%d\n", val);
> +       return sysfs_emit(buf, "%d\n", val);
>  }
>
>  static ssize_t wdack_store(struct gfs2_sbd *sdp, const char *buf, size_t=
 len)
> @@ -459,7 +459,7 @@ static ssize_t wdack_store(struct gfs2_sbd *sdp, cons=
t char *buf, size_t len)
>  static ssize_t lkfirst_show(struct gfs2_sbd *sdp, char *buf)
>  {
>         struct lm_lockstruct *ls =3D &sdp->sd_lockstruct;
> -       return sprintf(buf, "%d\n", ls->ls_first);
> +       return sysfs_emit(buf, "%d\n", ls->ls_first);
>  }
>
>  static ssize_t lkfirst_store(struct gfs2_sbd *sdp, const char *buf, size=
_t len)
> @@ -492,7 +492,7 @@ static ssize_t lkfirst_store(struct gfs2_sbd *sdp, co=
nst char *buf, size_t len)
>  static ssize_t first_done_show(struct gfs2_sbd *sdp, char *buf)
>  {
>         struct lm_lockstruct *ls =3D &sdp->sd_lockstruct;
> -       return sprintf(buf, "%d\n", !!test_bit(DFL_FIRST_MOUNT_DONE, &ls-=
>ls_recover_flags));
> +       return sysfs_emit(buf, "%d\n", !!test_bit(DFL_FIRST_MOUNT_DONE, &=
ls->ls_recover_flags));
>  }
>
>  int gfs2_recover_set(struct gfs2_sbd *sdp, unsigned jid)
> @@ -550,18 +550,18 @@ static ssize_t recover_store(struct gfs2_sbd *sdp, =
const char *buf, size_t len)
>  static ssize_t recover_done_show(struct gfs2_sbd *sdp, char *buf)
>  {
>         struct lm_lockstruct *ls =3D &sdp->sd_lockstruct;
> -       return sprintf(buf, "%d\n", ls->ls_recover_jid_done);
> +       return sysfs_emit(buf, "%d\n", ls->ls_recover_jid_done);
>  }
>
>  static ssize_t recover_status_show(struct gfs2_sbd *sdp, char *buf)
>  {
>         struct lm_lockstruct *ls =3D &sdp->sd_lockstruct;
> -       return sprintf(buf, "%d\n", ls->ls_recover_jid_status);
> +       return sysfs_emit(buf, "%d\n", ls->ls_recover_jid_status);
>  }
>
>  static ssize_t jid_show(struct gfs2_sbd *sdp, char *buf)
>  {
> -       return sprintf(buf, "%d\n", sdp->sd_lockstruct.ls_jid);
> +       return sysfs_emit(buf, "%d\n", sdp->sd_lockstruct.ls_jid);
>  }
>
>  static ssize_t jid_store(struct gfs2_sbd *sdp, const char *buf, size_t l=
en)
> @@ -626,7 +626,7 @@ static struct attribute *lock_module_attrs[] =3D {
>
>  static ssize_t quota_scale_show(struct gfs2_sbd *sdp, char *buf)
>  {
> -       return snprintf(buf, PAGE_SIZE, "%u %u\n",
> +       return sysfs_emit(buf, "%u %u\n",
>                         sdp->sd_tune.gt_quota_scale_num,
>                         sdp->sd_tune.gt_quota_scale_den);
>  }
> @@ -679,7 +679,7 @@ static struct gfs2_attr tune_attr_##name =3D __ATTR(n=
ame, 0644, show, store)
>  #define TUNE_ATTR_2(name, store)                                        =
      \
>  static ssize_t name##_show(struct gfs2_sbd *sdp, char *buf)             =
      \
>  {                                                                       =
      \
> -       return snprintf(buf, PAGE_SIZE, "%u\n", sdp->sd_tune.gt_##name); =
     \
> +       return sysfs_emit(buf, "%u\n", sdp->sd_tune.gt_##name);          =
     \
>  }                                                                       =
      \
>  TUNE_ATTR_3(name, name##_show, store)
>
> --
> 2.43.0
>

Thanks,
Andreas

