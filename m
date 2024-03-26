Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F2914285
	for <gfs2@lists.linux.dev>; Tue, 26 Mar 2024 00:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711413150; cv=none; b=UopWitAibtcDkQZNpvuesLID7kICYf+zALH5cU6ORhuZZiWM1hAl/Gg3b4QFBLsNsLu1xdRxW2oauAxcu7aCwBnNUNbh5ZYrdilDdTgSidxjSXOippDn0AyKWeG7rB8KG45pehkUb7yea+Wkv8IS6Ro8IzFzeAhYs4+JTIoRfKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711413150; c=relaxed/simple;
	bh=Ho3gvo/eVb4Uci4Jb1DdxKkEDu3H06yXH7YrbilacYQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WXZNuV1ZOBI0rJh1jINLIvk8uF6sH5PIHJM9wWT/Hl2/uvFZd5T2RydsmjLmx7JXXjISaT0tbuVXKfq+Tfb9nafCRJhp9aRDGdnMGpptmUyfoCDbDi2Vu8VE4ZJB8OZwJv18ws9c03Vsk26bVZs58ZQV+Nd+FHbPxWGT7Y+KKV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J+8i0BsJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J+8i0BsJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711413147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+NtDHrnqMOimYys5yRs4wfdL9pAKVoz2qt7/B7kalcU=;
	b=J+8i0BsJAbqn6wZvw0q6g0pntgBD8YfA9bGApKdQIGBJKyOhw1dJUsoB+fICOQoIQzekCF
	+we6RmeUsuUQknGorO5rsnW2xxmtLnUDahkiwseBszJDAxWnhs6ZCgXKsMc/qn7Yx/ei82
	kZfHRSPnYYFCojX5qivw0IMs8JzzY6U=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-D-zLWN2bNmu_g5v9zTUwIw-1; Mon, 25 Mar 2024 20:32:23 -0400
X-MC-Unique: D-zLWN2bNmu_g5v9zTUwIw-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2d49fa5dfadso41870861fa.0
        for <gfs2@lists.linux.dev>; Mon, 25 Mar 2024 17:32:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711413142; x=1712017942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+NtDHrnqMOimYys5yRs4wfdL9pAKVoz2qt7/B7kalcU=;
        b=v5nLO0h+sMkqZp5L6HpbaCesjGU/1b3icgoMTlsuTi4NZ4XwyXTWOmR5Kbj3mA7WEx
         Af/jr18Emdw0G8ewE6Csv6VLSNkvgE7usp4btYXVVBhgj6kVoRSys/1ymRDOWaJs7pKs
         HbdVxFPrTpBvj1AaGEbwDgGml1BUANKEgBoMC67bLhF36BQKhjlU+iyQ9nUvQnzjhzrJ
         LTd0Qern+CzNmeV3GlomKODTd0fKN97HvPCubnrTtjtrTaaj19ZTIzAF+/k5TsIlqPqy
         ULOuCZDz8A/QLj9B/wfAxvBmfvhOgyXr58Rm+NQTzx94Owal8esNR5TL3hsvHKqCKlTG
         +Faw==
X-Gm-Message-State: AOJu0YxK6nNklgkmdWaP2nNGAHUJCY6JTM/a2/TGO1X8SAzUERpL+9NR
	lSYZlcDXSkoRfu3ydlMXDdl1H4Kbai2PuhpvBqc7qalRnbWjVt3WHyR+UuDDZHQjlimeMgAsC0z
	S5unPB1om39fpN71sXXGb9SMaEO2EEw9pxs66GrM8YXF9eCPA3xaVcyl3fEpfNK9+Xk4s7PgZR2
	YmNiGXNEML+9MZob9pkULQSTvJ/w==
X-Received: by 2002:a2e:700c:0:b0:2d3:ba98:473 with SMTP id l12-20020a2e700c000000b002d3ba980473mr5234191ljc.19.1711413142115;
        Mon, 25 Mar 2024 17:32:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvoE+/mCHF8+zMwIYmIAUD7DOu2onh1oOKelvZHnmpc5pL0m3qmZPHl7ZQ2ulS9AbgHkiLbCN0+Dk+CpJpQ9k=
X-Received: by 2002:a2e:700c:0:b0:2d3:ba98:473 with SMTP id
 l12-20020a2e700c000000b002d3ba980473mr5234179ljc.19.1711413141730; Mon, 25
 Mar 2024 17:32:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230718180721.745569-1-aahringo@redhat.com> <20230718180721.745569-3-aahringo@redhat.com>
 <CAHc6FU7LBm6RSk_M8BqZRz0LOCmDORKj0bBWSmDjM=3_iB8guQ@mail.gmail.com>
In-Reply-To: <CAHc6FU7LBm6RSk_M8BqZRz0LOCmDORKj0bBWSmDjM=3_iB8guQ@mail.gmail.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Mon, 25 Mar 2024 20:32:10 -0400
Message-ID: <CAK-6q+h8nUXKX0ecFXeHxc5BPONXrtfD+sOGcDgaWWuvWobTEQ@mail.gmail.com>
Subject: Re: [PATCHv3 v6.5-rc2 2/3] fs: dlm: allow to F_SETLKW getting interrupted
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: gfs2 <gfs2@lists.linux.dev>, teigland@redhat.com, mark@fasheh.com, 
	jlbec@evilplan.org, joseph.qi@linux.alibaba.com, ocfs2-devel@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 25, 2024 at 11:09=E2=80=AFAM Andreas Gruenbacher
<agruenba@redhat.com> wrote:
>
> On Tue, Jul 18, 2023 at 8:07=E2=80=AFPM Alexander Aring <aahringo@redhat.=
com> wrote:
> > This patch implements dlm plock F_SETLKW interruption feature. If a
> > blocking posix lock request got interrupted in user space by a signal a
> > cancellation request for a non granted lock request to the user space
> > lock manager will be send. The user lock manager answers either with
> > zero or a negative errno code. A errno of -ENOENT signals that there is
> > currently no blocking lock request waiting to being granted. In case of
> > -ENOENT it was probably to late to request a cancellation and the
> > pending lock got granted. In any error case we will wait until the lock
> > is being granted as cancellation failed, this causes also that in case
> > of an older user lock manager returning -EINVAL we will wait as
> > cancellation is not supported which should be fine. If a user requires
> > this feature the user should update dlm user space to support lock
> > request cancellation.
> >
> > Signed-off-by: Alexander Aring <aahringo@redhat.com>
> > ---
> >  fs/dlm/plock.c                 | 56 ++++++++++++++++++++++------------
> >  include/uapi/linux/dlm_plock.h |  1 +
> >  2 files changed, 37 insertions(+), 20 deletions(-)
> >
> > diff --git a/fs/dlm/plock.c b/fs/dlm/plock.c
> > index a34f605d8505..a8ffa0760913 100644
> > --- a/fs/dlm/plock.c
> > +++ b/fs/dlm/plock.c
> > @@ -74,30 +74,26 @@ static void send_op(struct plock_op *op)
> >         wake_up(&send_wq);
> >  }
> >
> > -/* If a process was killed while waiting for the only plock on a file,
> > -   locks_remove_posix will not see any lock on the file so it won't
> > -   send an unlock-close to us to pass on to userspace to clean up the
> > -   abandoned waiter.  So, we have to insert the unlock-close when the
> > -   lock call is interrupted. */
> > -
> > -static void do_unlock_close(const struct dlm_plock_info *info)
> > +static int do_lock_cancel(const struct dlm_plock_info *orig_info)
> >  {
> >         struct plock_op *op;
> > +       int rv;
> >
> >         op =3D kzalloc(sizeof(*op), GFP_NOFS);
> >         if (!op)
> > -               return;
> > +               return -ENOMEM;
> > +
> > +       op->info =3D *orig_info;
> > +       op->info.optype =3D DLM_PLOCK_OP_CANCEL;
> > +       op->info.wait =3D 0;
> >
> > -       op->info.optype         =3D DLM_PLOCK_OP_UNLOCK;
> > -       op->info.pid            =3D info->pid;
> > -       op->info.fsid           =3D info->fsid;
> > -       op->info.number         =3D info->number;
> > -       op->info.start          =3D 0;
> > -       op->info.end            =3D OFFSET_MAX;
> > -       op->info.owner          =3D info->owner;
> > -
> > -       op->info.flags |=3D DLM_PLOCK_FL_CLOSE;
> >         send_op(op);
> > +       wait_event(recv_wq, (op->done !=3D 0));
> > +
> > +       rv =3D op->info.rv;
> > +
> > +       dlm_release_plock_op(op);
> > +       return rv;
> >  }
> >
> >  int dlm_posix_lock(dlm_lockspace_t *lockspace, u64 number, struct file=
 *file,
> > @@ -156,7 +152,7 @@ int dlm_posix_lock(dlm_lockspace_t *lockspace, u64 =
number, struct file *file,
> >         send_op(op);
> >
> >         if (op->info.wait) {
> > -               rv =3D wait_event_killable(recv_wq, (op->done !=3D 0));
> > +               rv =3D wait_event_interruptible(recv_wq, (op->done !=3D=
 0));
>
> It seems that this patch leads to an unnecessary change in behavior
> when a fatal signal is received (fatal_signal_pending()): before, the
> process would terminate. Now, it will try to cancel the lock, and when
> that fails, the process will keep waiting. In case of a fatal signal,
> can we skip the cancelling and do what we did before?

From my understanding interruptible() "reacts" on everything that is
also killable() and returns -ERESTARTSYS on "fatal signal". I even
tested it because wait_event_killable() has an issue, see reproducer
[0]. The issue was that it cleans too many waiters, the other waiter
of child in F_SETLKW was also cleared and it will never get a result
back from dlm_controld. I fixed that with an additional check on pid
in [1], but I have no idea about other side effects that could have
occurred as FL_CLOSE is also being used on other parts in the DLM
plock handling.

I rechecked the behaviour with the cancellation feature and sent
SIGKILL and the issue was gone without changing anything in user
space. The only thing I see why it would not have the old behaviour
(killable - that having the mentioned issue above) is that the
dlm_controld version is too old. To not run into this known issue we
just do a wait_event() that does not have those issues.

The mentioned "cancellation fails" - is not that it failed to cancel
the lock, there is some unexpected behaviour of dlm_controld, only
then we do wait_event() e.g. when we receive -EINVAL because
dlm_controld does not understand the op.

- Alex

[0] https://gitlab.com/netcoder/ltp/-/blob/dlm_fcntl_owner_testcase/testcas=
es/kernel/syscalls/fcntl/fcntl44.c
[1] https://pagure.io/dlm/blob/main/f/dlm_controld/plock.c#_655

