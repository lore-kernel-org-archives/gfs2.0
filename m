Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933EA1B0131
	for <gfs2@lists.linux.dev>; Thu, 29 Aug 2024 12:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724935811; cv=none; b=FkM4rX5u8cw+ZYHYVaa0lUwTbwddftKd/XrZVA+whjWu1dU/gi3OCPwbeXJIW+7BP/lE/BWJ1jQe4skJDfFKj1dCaOZN2ClpBqkhPummKb633pceWS4ffdFY11Zw/y0VLuhsGwUHcUh//0zotZozvD7AOCLuHxaGS9TLJHSTbII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724935811; c=relaxed/simple;
	bh=LfSCKmw0/BJUJ964F95/aGYZ9qmVOStY3H19rr/nolk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X9UGUexRoliPvdzAiPpCuHkbr65U/Y/n6jNvdk3BZqr+C0tbFkaRF1orxvslv3IXCmolyLw1KVWEMHZ5wNdvU4rKbNxyp4raWyV/XiKEDGWR79ynBDbk9ct2o8kaPo6sYK3hDuhgAwsYd+YdqWPVKwTdroNeyviNG/pvQxGkrg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AN17Oo7o; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AN17Oo7o"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-70968db52d0so576632a34.3
        for <gfs2@lists.linux.dev>; Thu, 29 Aug 2024 05:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724935808; x=1725540608; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=87Xt3iZvibBSnMheRJRNqlcSZdIV5Fv5uwTTbjkUYLQ=;
        b=AN17Oo7opIkgMSzHn9VwJqHEt3Cfi8JTRGyF+/VQw/Gpra+9CknnhCjDs08n5c2iVz
         MitM+2yC/SyhpElNFQZm6nPUJxiIIZSkRrv6oWaKGkuaRe7jotSPE05QnOCSCRPkuXCL
         EOebkGx6kV4AZr0rC2Tk93v1Se5kzN9CNx7GbxQ4C2KYCabJm8QUjBJOaafcf7mOILvm
         MUQjrUoXFuO9wMLhP/pR88gBzTNaHomluVjZwBFbGUCUkJVsRFyPVKsfxkJPPCy3Bo+Z
         b/ypaMttsyfdpN5PxbuRlUe5lGDK3vP//iRXJjGsGGCjScHTUdQEp04dgVB95pyr2c/3
         zHSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724935808; x=1725540608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=87Xt3iZvibBSnMheRJRNqlcSZdIV5Fv5uwTTbjkUYLQ=;
        b=IDESeGR7zkj0GQ4yr9y59MhzuM6PuAxgV+4Mxf9LkqQS6cHAiK2ojgaiFgzF3M75TI
         CIitELA0ZptBRKszBITYdPG7Vx6QMer6mEivvWiGGR+iarAr4ujnkvgfug1clTstFFp4
         FU/ctvFR8uxtx8KYX7cpOAaU6NlZLahzaShDwH6ne/lWMBuV665jbcVkyTdaEEyiVCPn
         vPbPvLjdCC5DK2N4hsfMtScxESS6i2QOaqyDCgQ7mcJS0PhTUV3MUST/upWFwcXQor3b
         09zt6E3gqssdY6PTO2mivQWHoi/rTQcmJ2Lnxj3E0bBDtvTkKcfdXzZUgBw/mX7PEzSs
         TjAw==
X-Forwarded-Encrypted: i=1; AJvYcCV20CQtK88ZOzBUwz5ulS3E11GWFff7GTS9A6J8p4pwemn0Z6KpbcK404pzOaEBe6QC8uzf@lists.linux.dev
X-Gm-Message-State: AOJu0Yztcv096BYpPLl01w+9WdIG/VFxST3CLGubUBLrL5U1cHYFPLOH
	ReA5p7WKuDO2Ls4S5IEkCOzaoBjzdD6wxRWEzACcCr+8WqilfhGQlM3hYsNufPz7d1x9eWe6JPR
	Z39JAZ4IWc257E06Y2jxU3Dx8qD8=
X-Google-Smtp-Source: AGHT+IGT9E2+JJFVG63aD5jzMummcaDjfiwTyrwxdYlQH7uv/ISUdBWyKvTI2ZdWWqricgQZLl0+A4xmQmiU6J8eyTk=
X-Received: by 2002:a05:6830:4188:b0:709:339e:525d with SMTP id
 46e09a7af769-70f5c3e39e5mr2675449a34.21.1724935808513; Thu, 29 Aug 2024
 05:50:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1723670362.git.josef@toxicpanda.com> <2bd333be8352f31163eac7528fdcb8b47a1f97b4.1723670362.git.josef@toxicpanda.com>
 <20240829111510.dfyqczbyzefqzdtx@quack3> <CAOQ4uxjuySfiOXy_R28nhQnF+=ty=hL2Zj3h=aVrGXjm_v7gug@mail.gmail.com>
 <20240829114327.zm3ghtjic3abvucy@quack3>
In-Reply-To: <20240829114327.zm3ghtjic3abvucy@quack3>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 29 Aug 2024 14:49:56 +0200
Message-ID: <CAOQ4uxiDD00LMNNMH1Y5SA83L-5mhwqG9mKe=DKyQ7Qrqk4eaQ@mail.gmail.com>
Subject: Re: [PATCH v4 15/16] gfs2: add pre-content fsnotify hook to fault
To: Jan Kara <jack@suse.cz>
Cc: Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com, linux-fsdevel@vger.kernel.org, 
	brauner@kernel.org, linux-xfs@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-bcachefs@vger.kernel.org, Andreas Gruenbacher <agruenba@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 1:43=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 29-08-24 13:26:17, Amir Goldstein wrote:
> > On Thu, Aug 29, 2024 at 1:15=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Wed 14-08-24 17:25:33, Josef Bacik wrote:
> > > > gfs2 takes the glock before calling into filemap fault, so add the
> > > > fsnotify hook for ->fault before we take the glock in order to avoi=
d any
> > > > possible deadlock with the HSM.
> > > >
> > > > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > >
> > > The idea of interactions between GFS2 cluster locking and HSM gives m=
e
> > > creeps. But yes, this patch looks good to me. Would be nice to get ac=
k from
> > > GFS2 guys. Andreas?
> >
> > If we are being honest, I think that the fact that HSM events require c=
areful
> > handling in ->fault() and not to mention no documentation of this fact,
> > perhaps we should let HSM events be an opt-in file_system_type feature?
> >
> > Additionally, we had to introduce FS_DISALLOW_NOTIFY_PERM
> > and restrict sb marks on SB_NOUSER, all because these fanotify
> > features did not require fs opt-in to begin with.
> >
> > I think we would be repeating this mistake if we do not add
> > FS_ALLOW_HSM from the start.
> >
> > After all, I cannot imagine HSM being used on anything but
> > the major disk filesystems.
> >
> > Hmm?
>
> Yeah, I was considering this already when thinking about btrfs quirks wit=
h
> readahead and various special filesystem ioctls and I agree that a need t=
o be
> careful with page faults is another good reason to make this a
> per-filesystem opt in. Will you send a patch?

Huh! I am still struggling to keep my head above the water
coming back from a long vacation, so I think it is better if Josef takes
that as well.

But here is a trivial, untested, probably broken, space damaged patch,
that should be broken and squashed into other patches in the series
if this is any help at all...

Thanks,
Amir.

index c3c8b2ea80b6..07c3cf038221 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1672,6 +1672,11 @@ static int fanotify_events_supported(struct
fsnotify_group *group,
                                 (mask & FAN_RENAME) ||
                                 (flags & FAN_MARK_IGNORE);

+       /* Filesystems need to opt-into pre-content evnets (a.k.a HSM) */
+       if (mask & FANOTIFY_PRE_CONTENT_EVENTS &&
+           path->mnt->mnt_sb->s_type->fs_flags & FS_ALLOW_HSM)
+               return -EINVAL;
+
        /*
         * Some filesystems such as 'proc' acquire unusual locks when openi=
ng
         * files. For them fanotify permission events have high chances of
diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index cbfaa000f815..32690e5c4815 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -207,7 +207,8 @@ bool fsnotify_file_has_pre_content_watches(struct
file *file)
        struct inode *inode =3D file_inode(file);
        __u32 mnt_mask =3D real_mount(file->f_path.mnt)->mnt_fsnotify_mask;

-       return fsnotify_object_watched(inode, mnt_mask,
+       return inode->i_sb->s_type->fs_flags & FS_ALLOW_HSM &&
+              fsnotify_object_watched(inode, mnt_mask,
                                       FSNOTIFY_PRE_CONTENT_EVENTS);
 }
 #endif
diff --git a/include/linux/fs.h b/include/linux/fs.h
index fb0426f349fc..14468736d15b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2499,6 +2499,7 @@ struct file_system_type {
 #define FS_USERNS_MOUNT                8       /* Can be mounted by
userns root */
 #define FS_DISALLOW_NOTIFY_PERM        16      /* Disable fanotify
permission events */
 #define FS_ALLOW_IDMAP         32      /* FS has been updated to
handle vfs idmappings. */
+#define FS_ALLOW_HSM           64      /* FS can handle fanotify
pre-content events. */
 #define FS_RENAME_DOES_D_MOVE  32768   /* FS will handle d_move()
during rename() internally. */
        int (*init_fs_context)(struct fs_context *);
        const struct fs_parameter_spec *parameters;
diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index ec1e88342442..b6845ab477d6 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -178,6 +178,7 @@ static inline int fsnotify_file_area_perm(struct
file *file, int perm_mask,
         * if there are any pre-content event watchers on this sb.
         */
        if ((!S_ISDIR(inode->i_mode) && !S_ISREG(inode->i_mode)) ||
+           !(inode->i_sb->s_type->fs_flags & FS_ALLOW_HSM) ||
            !fsnotify_sb_has_priority_watchers(inode->i_sb,
                                               FSNOTIFY_PRIO_PRE_CONTENT))
                return 0;

---
