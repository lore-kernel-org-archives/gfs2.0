Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68688564F
	for <gfs2@lists.linux.dev>; Thu, 25 Apr 2024 11:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714043372; cv=none; b=Zpnj1KS3hI4WUHqiqjytwmHroJmKb5nOmLqsh44nn8DvBsZygcJ94MFtQ59O4IzmbdR6lK27I5AOCCTFevvm4D6Bj9nfMg/zsi/vWXu5nbYuyV2Nu6xjaDr0q/g4yePdU4kEK7My3RVTEnju8Es/87lyELVsAGapPjsvi0/0UMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714043372; c=relaxed/simple;
	bh=WxRT3GhFqQcicpmthVc/tY1Ez77a7MPeeg/zi6UXFAI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AFAX5iu+gvJ2UK05ORh6ulyofxK6D8Gg2OEZSxNfAnZbpT1lOcvB3V5am3E5KbH/wKy6w91U93nHYj+qCX0cOwQ+jhebzdlFBc5DAWv97qUiRsbYaqCipTZyZYhDHH0Ugfm2X3x1Ye1Y5HhRKMAa2+Q39ngaDnR4NR0a2k16TT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U0B52sRx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U0B52sRx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714043368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=13l4VSJkvftMTOhfIDALxGVZS53fcbHHrPepYC6GY+M=;
	b=U0B52sRxsTxJs7T+TAWcbxx43y0s7gfnPkdIwUO62YoIhAGo6LZzq1hAjoZgOkZ8/o6TiD
	pusoJu4N0HZlM/a1qRyrCP1masmt6ma03BuZuXUCBbf8mb0mFWykWPKmkUe87ry1b5cVrU
	bcsb9RgIwPLRdhlkuD2b7ukR525LqMg=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-m9m-zH34MG6cFhavavJb4w-1; Thu, 25 Apr 2024 07:09:27 -0400
X-MC-Unique: m9m-zH34MG6cFhavavJb4w-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2db869d3805so7479321fa.3
        for <gfs2@lists.linux.dev>; Thu, 25 Apr 2024 04:09:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714043365; x=1714648165;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=13l4VSJkvftMTOhfIDALxGVZS53fcbHHrPepYC6GY+M=;
        b=LKL9W+uBHdo8hdi5+9MwH3yqr/VX6U0EeEACtVdOelCUXTSGhhsK7eWuE9WwOEQnrM
         E+rd7CKnuxOg0oFl9vx8vpMICII8LkFuQTlDsWQxxT1tl6mMBF3Vuw1+4Fy4DVQI2adw
         Rc75tPtJVdD7x6FJbo7kt91NtI73Vrz0JGIGqflMHYVVWKTiIfX5NHDc3BUl4M2C5O49
         8iSYhDyLHDwJYrQS0/gn6J0+kCAuGn//Kd/qkpYX1JDYQUkDxBXYhJUerbItezYTJJkJ
         YmYBpT3mYT9+Vp4OMR4klUA/2C02y+y2xs12rn5aT4sfdNTgvY+5BIh94pQgER87vN0H
         H3eg==
X-Gm-Message-State: AOJu0YxQFzBmmO9+CCSMCbd9yQnD5onHidfd1pcHOA9tX7Q91R9Vv+So
	0HTVDqI9D4NF5ApT1DIaLaNqIDdP5o5LdDCMjSCB8q4Ty7R2lWqL7kZnSwhC7zheOgn/oFUirFD
	/eKGRSa+uDmlF6N1XI/NIt/wZ/+PSJqrqtPaPS1FnRYgBlJEmUWSiUE3ov8YurZCTI18Lijq8ve
	AhffA/wOXP1acsdf4p+7QGRXtARkAaxID5kQ==
X-Received: by 2002:a2e:8395:0:b0:2de:81b8:7e57 with SMTP id x21-20020a2e8395000000b002de81b87e57mr2987361ljg.0.1714043365047;
        Thu, 25 Apr 2024 04:09:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgRxL58xyZtAbLXRFvnzzDkka7fcVl5xdwZ040uGk7B1mvjSC5BUiridcnsbgTOPafW/+Gi7C65OOHcm5qkLE=
X-Received: by 2002:a2e:8395:0:b0:2de:81b8:7e57 with SMTP id
 x21-20020a2e8395000000b002de81b87e57mr2987341ljg.0.1714043364556; Thu, 25 Apr
 2024 04:09:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240423195559.1527187-1-aahringo@redhat.com> <20240423195559.1527187-9-aahringo@redhat.com>
In-Reply-To: <20240423195559.1527187-9-aahringo@redhat.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Thu, 25 Apr 2024 07:09:13 -0400
Message-ID: <CAK-6q+gYRpem117c5Awm2t3=CL8u-UX1K69zpAiHWZO3WNLrEA@mail.gmail.com>
Subject: Re: [PATCH dlm/next 09/10] dlm: merge nodeid field to master_nodeid
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Apr 23, 2024 at 3:56=E2=80=AFPM Alexander Aring <aahringo@redhat.co=
m> wrote:
>
> There is a TODO in dlm_internal.h for the dlm_rsb struct:
>
> "remove res_nodeid and only use res_master_nodeid"
>
> The res_nodeid and res_master_nodeid should represent the same
> information in a different numbers mapping. This patch tries to work on
> this TODO by removing res_nodeid and use res_master_nodeid only. The
> same applies for struct lkb with it's lkb_nodeid and lkb_master_nodeid
> fields. It use the new representation for those numbers and introduce
> backwardscompability because those representation are used for debugfs
> and the DLM protocol. In future we might use the new number
> representation for res_master_nodeid only and remove the copied value in
> struct lkb.
>
> Signed-off-by: Alexander Aring <aahringo@redhat.com>
> ---
>  fs/dlm/debug_fs.c     |  33 +++++-----
>  fs/dlm/dlm_internal.h |  33 ++++++++--
>  fs/dlm/lock.c         | 144 ++++++++++++++++++------------------------
>  fs/dlm/lock.h         |   5 +-
>  fs/dlm/lockspace.c    |   2 +-
>  fs/dlm/rcom.c         |   4 +-
>  fs/dlm/recover.c      |  20 ++----
>  fs/dlm/recoverd.c     |   2 +-
>  8 files changed, 119 insertions(+), 124 deletions(-)
>
> diff --git a/fs/dlm/debug_fs.c b/fs/dlm/debug_fs.c
> index 6ab3ed4074c6..40eb1696f3b6 100644
> --- a/fs/dlm/debug_fs.c
> +++ b/fs/dlm/debug_fs.c
> @@ -58,9 +58,10 @@ static void print_format1_lock(struct seq_file *s, str=
uct dlm_lkb *lkb,
>             lkb->lkb_status =3D=3D DLM_LKSTS_WAITING)
>                 seq_printf(s, " (%s)", print_lockmode(lkb->lkb_rqmode));
>
> -       if (lkb->lkb_nodeid) {
> -               if (lkb->lkb_nodeid !=3D res->res_nodeid)
> -                       seq_printf(s, " Remote: %3d %08x", lkb->lkb_nodei=
d,
> +       if (lkb->lkb_master_nodeid !=3D dlm_our_nodeid()) {
> +               if (lkb->lkb_master_nodeid !=3D res->res_master_nodeid)
> +                       seq_printf(s, " Remote: %3d %08x",
> +                                  dlm_res_nodeid(lkb->lkb_master_nodeid)=
,
>                                    lkb->lkb_remid);
>                 else
>                         seq_printf(s, " Master:     %08x", lkb->lkb_remid=
);
> @@ -88,16 +89,15 @@ static void print_format1(struct dlm_rsb *res, struct=
 seq_file *s)
>                         seq_printf(s, "%c", '.');
>         }
>
> -       if (res->res_nodeid > 0)
> -               seq_printf(s, "\"\nLocal Copy, Master is node %d\n",
> -                          res->res_nodeid);
> -       else if (res->res_nodeid =3D=3D 0)
> -               seq_puts(s, "\"\nMaster Copy\n");
> -       else if (res->res_nodeid =3D=3D -1)
> +
> +       if (res->res_master_nodeid =3D=3D 0)
>                 seq_printf(s, "\"\nLooking up master (lkid %x)\n",
>                            res->res_first_lkid);
> +       else if (res->res_master_nodeid =3D=3D dlm_our_nodeid())
> +               seq_puts(s, "\"\nMaster Copy\n");
>         else
> -               seq_printf(s, "\"\nInvalid master %d\n", res->res_nodeid)=
;
> +               seq_printf(s, "\"\nLocal Copy, Master is node %d\n",
> +                          res->res_master_nodeid);
>         if (seq_has_overflowed(s))
>                 goto out;
>
> @@ -184,7 +184,7 @@ static void print_format2_lock(struct seq_file *s, st=
ruct dlm_lkb *lkb,
>
>         seq_printf(s, "%x %d %x %u %llu %x %x %d %d %d %llu %u %d \"%s\"\=
n",
>                    lkb->lkb_id,
> -                  lkb->lkb_nodeid,
> +                  dlm_res_nodeid(lkb->lkb_master_nodeid),
>                    lkb->lkb_remid,
>                    lkb->lkb_ownpid,
>                    (unsigned long long)xid,
> @@ -194,7 +194,7 @@ static void print_format2_lock(struct seq_file *s, st=
ruct dlm_lkb *lkb,
>                    lkb->lkb_grmode,
>                    lkb->lkb_rqmode,
>                    (unsigned long long)us,
> -                  r->res_nodeid,
> +                  dlm_res_nodeid(r->res_master_nodeid),
>                    r->res_length,
>                    r->res_name);
>  }
> @@ -238,7 +238,7 @@ static void print_format3_lock(struct seq_file *s, st=
ruct dlm_lkb *lkb,
>
>         seq_printf(s, "lkb %x %d %x %u %llu %x %x %d %d %d %d %d %d %u %l=
lu %llu\n",
>                    lkb->lkb_id,
> -                  lkb->lkb_nodeid,
> +                  dlm_res_nodeid(lkb->lkb_master_nodeid),
>                    lkb->lkb_remid,
>                    lkb->lkb_ownpid,
>                    (unsigned long long)xid,
> @@ -265,7 +265,7 @@ static void print_format3(struct dlm_rsb *r, struct s=
eq_file *s)
>
>         seq_printf(s, "rsb %p %d %x %lx %d %d %u %d ",
>                    r,
> -                  r->res_nodeid,
> +                  dlm_res_nodeid(r->res_master_nodeid),
>                    r->res_first_lkid,
>                    r->res_flags,
>                    !list_empty(&r->res_root_list),
> @@ -341,7 +341,7 @@ static void print_format4(struct dlm_rsb *r, struct s=
eq_file *s)
>
>         seq_printf(s, "rsb %p %d %d %d %d %lu %lx %d ",
>                    r,
> -                  r->res_nodeid,
> +                  dlm_res_nodeid(r->res_master_nodeid),
>                    r->res_master_nodeid,
>                    r->res_dir_nodeid,
>                    our_nodeid,
> @@ -611,7 +611,8 @@ static ssize_t waiters_read(struct file *file, char _=
_user *userbuf,
>         list_for_each_entry(lkb, &ls->ls_waiters, lkb_wait_reply) {
>                 ret =3D snprintf(debug_buf + pos, len - pos, "%x %d %d %s=
\n",
>                                lkb->lkb_id, lkb->lkb_wait_type,
> -                              lkb->lkb_nodeid, lkb->lkb_resource->res_na=
me);
> +                              dlm_res_nodeid(lkb->lkb_master_nodeid),
> +                              lkb->lkb_resource->res_name);
>                 if (ret >=3D len - pos)
>                         break;
>                 pos +=3D ret;
> diff --git a/fs/dlm/dlm_internal.h b/fs/dlm/dlm_internal.h
> index aec99ccf2d0d..f2b5a61d6477 100644
> --- a/fs/dlm/dlm_internal.h
> +++ b/fs/dlm/dlm_internal.h
> @@ -253,7 +253,7 @@ struct dlm_callback {
>  struct dlm_lkb {
>         struct dlm_rsb          *lkb_resource;  /* the rsb */
>         struct kref             lkb_ref;
> -       int                     lkb_nodeid;     /* copied from rsb */
> +       unsigned int            lkb_master_nodeid;      /* copied from rs=
b */
>         int                     lkb_ownpid;     /* pid of lock owner */
>         uint32_t                lkb_id;         /* our lock ID */
>         uint32_t                lkb_remid;      /* lock ID on remote part=
ner */
> @@ -303,18 +303,41 @@ struct dlm_lkb {
>   *
>   * res_nodeid is "odd": -1 is unset/invalid, zero means our_nodeid,
>   * greater than zero when another nodeid.
> - *
> - * (TODO: remove res_nodeid and only use res_master_nodeid)
>   */
>
> +/* For backwards compatibility, see above.
> + * The protocol is still using res_nodeid.
> + */
> +static inline int dlm_res_nodeid(unsigned int res_master_nodeid)
> +{
> +       if (res_master_nodeid =3D=3D 0)
> +               return -1;
> +       else if (res_master_nodeid =3D=3D dlm_our_nodeid())
> +               return 0;
> +       else
> +               return res_master_nodeid;
> +}
> +
> +/* For backwards compatibility, see above.
> + * The protocol is still using res_nodeid.
> + */
> +static inline int dlm_res_master_nodeid(int res_nodeid)

I changed this to "unsigned int", but when I would follow net/ then
this needed to be __le32 as nodeid is a addressing scheme on the wire.
This might be a change for future patches.

> +{
> +       if (res_nodeid =3D=3D -1)
> +               return 0;
> +       else if (res_nodeid =3D=3D 0)
> +               return dlm_our_nodeid();
> +       else
> +               return res_nodeid;
> +}
> +

- Alex

