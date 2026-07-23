Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3493E274E
	for <gfs2@lists.linux.dev>; Thu, 23 Jul 2026 07:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784790687; cv=pass; b=ZC6UnUwqQublqq7NBjqcNrCaCkQDh3XiLJGwNYAq5/FStyiggDeELTh3lByb1OSejzs07Svk3gD6/Fgx58gpS4FHY+AW+ZtXUMFYCiezbYgyn8zT5OH3O03pf9YtUUC1qxzSiG/ZC4Ii8+g+bA5lcPdeqcX4XmFCVCHMgYxFwX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784790687; c=relaxed/simple;
	bh=izblklCfX3mlIOXUg0YT/dJ+XEHqli5azo9A+2NJYSw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jaNRt58ifxsg7MpJ7Hw0/9qJ+JUg3GywogwTZTN8l1qVPbmImH8rX3VVErejzTUULGvyyUcqvEVk2qY8dO91+3t4TA5wq48QhOvLhyAMT8RDl9BQZLxdzeyB+l1xceNmDBHPU5xtQyWO1JUMjFhViDUbDMDZndz1OuIdf4h3BFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CtVkpFrN; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CtVkpFrN"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c15cb6f5c12so59419066b.0
        for <gfs2@lists.linux.dev>; Thu, 23 Jul 2026 00:11:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784790681; cv=none;
        d=google.com; s=arc-20260327;
        b=JQj3m9xJACbm6cn9EQrz+7AIn6qjHHPd9KnRh82SU3co1q2GqWRYrG5Yh/Opdusn7I
         rvg6eu+IyQ0y6FZM0N3SbVmDU1osz4bIM4R/UpauYID59bouKCgVD8HiEIsg8ZtxcCYu
         1T+AKhB1qaxhCQZk2z/sfxwfIicKlUxJrgXjHFvoaOSqWiN9II6cCjesxWvFReO91E5/
         +uJyywjrXddUPR14LNTs4pxL4DZIh98/onrPkiG7L0Vtu4XY9DXf7izozTW2qcAhBFjf
         xWayL+da4REo9eoI5qXC3oJ46uLy9lxz5I8kcci/CYcSv8pCnp1xcFT7JqpreWXyjTfh
         mlDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zfBTtydsINhPmhdGmRbCcZlHwfscEB9iD0uPUM7TzXw=;
        fh=nyzhBcot83zT6kdAfxnmMhyJxPpZRWbWxhHBRZVl8Vg=;
        b=sPWEdhHv3hDgMpZ+T1IkcegDbR4oAAYEzvA0lCUcta7T250HYkiY32tC7Mh3unUfI4
         77DCaPi52Gc2hk0jzBQ0HxiR7lm0zTEqovASOD1mHPO2ufirM1nuMGLhp2Srcmr6udYa
         sfh8zoupgOhb+wCJZcqEAGwWgK6lXRYr4hx7kZ+VGoFkTytu1pJeuRg9HERiUnAN5M2c
         y8S7a5WtC0iZiP+bpDH57tkF6TQQFTm/iv6yNHhzLcQrrRgZDAowkKvByivAyyfy+qOu
         235dKk5h1UBAKIPj8/MDKRUcfNqNX7OI8X/tbMY3/PlOORUzmy3FqVWaWKXTflqhy5MP
         PTEA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784790681; x=1785395481; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zfBTtydsINhPmhdGmRbCcZlHwfscEB9iD0uPUM7TzXw=;
        b=CtVkpFrNPxG0lC4apprI8mbBRdFhXE4cbgop38meF7bsoLnGB3JmGkJYkTARUpo5Bo
         2Oc5UAP7+UlWq7uYrqadDHTbytl8o3eVzlRA9ZFDGge/dAwJVylLS5zJXBdsUvAoNKSL
         esqEhYMiN5F2R4yitSFYneqmB7A5P1GExhxANKElhE12liIemTTEreLDdMTKkfd14CTB
         KJwBqDbrCQkeX0pLbGPSzKrREzT6JgiLSVvxLv83rof8mnTdTUYJqa1wMEJFkabcizRu
         olhJ5wvAvGD629OED/BbHm/8sohixpPWCTWZcJ6xju5EsnSwDmSrGH5yUDgqvNYjLDxk
         XMoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784790681; x=1785395481;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zfBTtydsINhPmhdGmRbCcZlHwfscEB9iD0uPUM7TzXw=;
        b=rbKWBN4X90fBeagcJxTkicdUlljk9Bbu55u4x64MRWu9bmmHacVziT+jg+l2ZIJ+YK
         7Y2nTI2aVEHnGZfpGAktLy/tOsM+psd/pzCYVKcqE5At9YDHDJ+yRJQ2vwudX47o+T7c
         N59OtcZ9k/gS/G91HH7hZRAKx/0Vu6Mqstbk40C3xSiagmw2T2v6JUmrXgpIZ4XZwVU5
         5YJj3G1F2PB2OVWzoX1h33+Gb/A6UpBGy4fb6IxN5/NA35VXKPtYb6J6xTm5n/3gt3av
         ZhsuKex17idqb9yF8PQzrmKE0/QT00meFF2PWjdxXcCzRsxqIX6ot8Fy8RSrx4wWI7Im
         6oaw==
X-Forwarded-Encrypted: i=1; AHgh+RqxviboYU42ZMtflvlVc7rDUn4ce/sXb8K5ly8TjEdVur2zKorS3Tt+owMUzLeGAC+l7A/v@lists.linux.dev
X-Gm-Message-State: AOJu0YzUBHC8Zz3alIgRYlSawgCTmZ8QOUQ4TVaajSq7F3vp0FZoVq+A
	mYpHFenB6zR6jAeUWdI5c6MEbYysW508BYvR7KKadTWGNitBWNm1DjRQGczt029IQWemSlMiyT2
	ifcXOf9QeHR4fHi8FFTCoX/r7BDtt5oI=
X-Gm-Gg: AR+sD10FjdK2xyqyew+G7ax4kbuFHgcJgQUvaJCFAPae6rbqLGda46ZsX9qemrB979x
	SWkkeI0NUHROxDE9z+meExkMTGJQIb9tMEHCupciwqoSCh9E+k7XRbgql2FMfyD2n0w7yA+TS5U
	3wEkTDnvSXLiVV9teRCxc7zNl+xEVcmQmwHldfQyxYUPbcyGaSRhZp5d6UgvOFFuBGqZbAgz8ok
	XkvdIWFsMAO2QgMGO1PjX3h0rZG3m0sb1bSEpo4y3u2uu9Zt+ZRSc3/PmnJGDI=
X-Received: by 2002:a17:907:c705:b0:c16:44c3:5a1e with SMTP id
 a640c23a62f3a-c1c50d176cbmr78475566b.63.1784790680541; Thu, 23 Jul 2026
 00:11:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <74871a78-5243-4898-8e63-92e918912980@redhat.com> <20260706180003.2124317-1-r772577952@gmail.com>
In-Reply-To: <20260706180003.2124317-1-r772577952@gmail.com>
From: Jiaming Zhang <r772577952@gmail.com>
Date: Thu, 23 Jul 2026 15:10:34 +0800
X-Gm-Features: AUfX_mwPnqmMBMWdKJ66LyMUpkptmu9t1rSpdg_jQKv2KoRFDgP0cZ6BKZv59hQ
Message-ID: <CANypQFZTFMxk5W4d3GViW6T1Nkxua3nVk3RNx0fie-26fpmXSg@mail.gmail.com>
Subject: Re: [PATCH v2] gfs2: reject oversized dinode sizes before i_size_write
To: anprice@redhat.com, agruenba@redhat.com, gfs2@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Jiaming Zhang <r772577952@gmail.com> =E4=BA=8E2026=E5=B9=B47=E6=9C=887=E6=
=97=A5=E5=91=A8=E4=BA=8C 02:00=E5=86=99=E9=81=93=EF=BC=9A

Hi,

>
> A corrupted GFS2 image can store a dinode size that is larger than what V=
FS
> i_size can represent. gfs2_dinode_in() reads the on-disk di_size as a u64=
 and
> writes it directly into inode->i_size. If the value is larger than S64_MA=
X, the
> incore i_size becomes negative. That negative value can bypass the existi=
ng
> stuffed inode size check:
>
> inode->i_size > gfs2_max_stuffed_size(ip)
>
> Later, gfs2_quotad may try to sync the quota file and unstuff the quota i=
node.
> gfs2_unstuffer_folio() reads the negative i_size into an unsigned length =
and
> passes it to memcpy(), turning it into a huge copy size and triggering a
> out-of-bound issue.
>
> Reject dinodes whose size exceeds sb->s_maxbytes before storing the value=
 in
> inode->i_size. Also make the stuffed inode check use the raw on-disk size=
 while
> it is still unsigned.
>
> Fixes: 70376c7ff312 ("gfs2: Always check inode size of inline inodes")
> Closes: https://lore.kernel.org/lkml/CANypQFaF6bvORKKbRALvEL0k_epFaneFiOQ=
qco4gjdmKVbdURg@mail.gmail.com/
> Assisted-by: Codex:gpt-5.5-xhigh
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiaming Zhang <r772577952@gmail.com>
> ---
> Changes in v2:
> - Drop the defensive unstuffing changes in bmap.c.
>
>  fs/gfs2/glops.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/fs/gfs2/glops.c b/fs/gfs2/glops.c
> index 28f32424ee64..8c5d257451d5 100644
> --- a/fs/gfs2/glops.c
> +++ b/fs/gfs2/glops.c
> @@ -393,11 +393,16 @@ static int gfs2_dinode_in(struct gfs2_inode *ip, co=
nst void *buf)
>         umode_t mode =3D be32_to_cpu(str->di_mode);
>         struct inode *inode =3D &ip->i_inode;
>         bool is_new =3D inode_state_read_once(inode) & I_NEW;
> +       u64 size =3D be64_to_cpu(str->di_size);
>
>         if (unlikely(ip->i_no_addr !=3D be64_to_cpu(str->di_num.no_addr))=
) {
>                 gfs2_consist_inode(ip);
>                 return -EIO;
>         }
> +       if (unlikely(size > (u64)inode->i_sb->s_maxbytes)) {
> +               gfs2_consist_inode(ip);
> +               return -EIO;
> +       }
>         if (unlikely(!is_new && inode_wrong_type(inode, mode))) {
>                 gfs2_consist_inode(ip);
>                 return -EIO;
> @@ -418,7 +423,7 @@ static int gfs2_dinode_in(struct gfs2_inode *ip, cons=
t void *buf)
>         i_uid_write(inode, be32_to_cpu(str->di_uid));
>         i_gid_write(inode, be32_to_cpu(str->di_gid));
>         set_nlink(inode, be32_to_cpu(str->di_nlink));
> -       i_size_write(inode, be64_to_cpu(str->di_size));
> +       i_size_write(inode, size);
>         gfs2_set_inode_blocks(inode, be64_to_cpu(str->di_blocks));
>         atime.tv_sec =3D be64_to_cpu(str->di_atime);
>         atime.tv_nsec =3D be32_to_cpu(str->di_atime_nsec);
> @@ -462,7 +467,7 @@ static int gfs2_dinode_in(struct gfs2_inode *ip, cons=
t void *buf)
>                 return -EIO;
>         }
>
> -       if (gfs2_is_stuffed(ip) && inode->i_size > gfs2_max_stuffed_size(=
ip)) {
> +       if (gfs2_is_stuffed(ip) && size > gfs2_max_stuffed_size(ip)) {
>                 gfs2_consist_inode(ip);
>                 return -EIO;
>         }
> --
> 2.43.0
>

Friendly ping. Please let me know if there's anything you'd like me to chan=
ge.

Best Regards,
Jiaming Zhang
