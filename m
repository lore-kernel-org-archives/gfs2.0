Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA5A221F20
	for <gfs2@lists.linux.dev>; Wed, 12 Aug 2026 01:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786498645; cv=pass; b=oTO8SPkVLLHwQVgUPvu5EMd0TFlac/5aUzaGn+BvHNG16z1Qt5IpJ8nBg4FWX1GpMhlFr4vx3dKSsrZhwChp71pWgRo7yQCFC59sW6K9k/XV1oD+9JWJP6mosGDghq66W/1ZwxuNn0DSKfZVRK36c9QJzIQowJT7EKVlSiHh/9k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786498645; c=relaxed/simple;
	bh=MzM5oOBWe2rVVHtSNyNDzjdpCPZ3ET6tb4EqIDl9rYU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D0uQagBbkeBwyUsJhH4cTKMK3EVFVhZcmY8p7Y8YRdJfrDSZflozjF8FP4YGMMgGQjcKwPqdTI+hK37tZUuieVkBM6a1PksadAoEnokYmYMOq71j/Egx3aTgSNh+CwPlA5P3ceSm2ZbsKqYNicBWRfxXGGsubSBQWiOAFifn+M8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ggm4xpP8; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ggm4xpP8"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c15ca7a7ca9so44209666b.0
        for <gfs2@lists.linux.dev>; Tue, 11 Aug 2026 18:37:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786498642; cv=none;
        d=google.com; s=arc-20260327;
        b=ZbF29IDJ4QzvoNW5ezuuPvehd26qktU3kI3opwMJBzq8wXmYpcRHSsUzbxcs/CddWw
         Ol5F2HWEyokyn6j6uqH4l/bPbC+fox4E/sGfXL24yI1NU6zENFjKw4GnZpsNTNn1JGSI
         8RBSYwIFavBZAUGjYnewPqbdE9smhmgFldqLq/ysIs/VEWzOkHE/xnG//m+ntKYvGTCD
         YRVH0xZKD4zJj+Ity/WazuqHGuSmfq85XAGC/zVbyNGbmnLriR9No0wZIy6bpeM4PjB7
         +5ptMl1PqDVaXxmyowhXe1Dq5KW45M4ibuFQUaWTfeJ0OgsuUpxEd1kHsGA74+baE2dJ
         zSFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=m6I6ES+poJdPEE6jca90KgbmyPtxCPdFVXMB03i5vsA=;
        fh=CBK3fnc3G/I/3+8ad0XHTDDZRDvu8dH85mkIB0woqiA=;
        b=ahtcMrZV4wFUJ90P3ZvuGRih4uwGdrKlRzVuO/6nm2osW6bebgOMWmSaq0gkJ6eyLB
         1YfQV4FDgUniM2qcdU4c/y4XCG633MCqRqclZY68hPYoveMVseFaMb2clCfpHDAveYnf
         cJCzORrCaFfc5qORP5CkwxN5wR0C2GJcSIn9O1qG0617Don7U1OvS+Vg1wRdof3HB4Wu
         WivQCpE59YM6w5QisI/XZ0r97BA7OMUMhxWGJ6s8s7IQm+yV8X8I8PW8f9ev23vJkerW
         5m3+Db0PcwMt0Jo9/eUXcUiw7uhz1IWmzEMRhnIWAFyBodc83MiEE8V/S/mx9zwRNTg1
         +uYA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786498642; x=1787103442; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=m6I6ES+poJdPEE6jca90KgbmyPtxCPdFVXMB03i5vsA=;
        b=Ggm4xpP8IUFKwuwV4eE4013iyRRS0yqTUuy1dPBnlILmS0H6wlliRwVUoGDQJKtkzh
         DlsvClyFL05/hJw9YUQzFt9RXgvxH5wgL8mVsDKO8805KGQdDIDHkUbsvIwsw1eZo3lD
         uLQ/mBAqNge+4Qj52aPva1dihtNkxwh00Na28yC+Zq8GA3H/CSs4hY2l/B4nfKNqAw2Q
         bIKe+68t2piC3QCszMOVLlw0rv2cW69eZEyQwLQSC8cQrcG5z0W9uzRYcLNiTONP3pkv
         MFyhFzSa9XuVtckDSNoT6eKabC3iHYLPrzzstnDKernyKT3sX3kJfgvJ5AQLWQfnQTyb
         OuFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786498642; x=1787103442;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m6I6ES+poJdPEE6jca90KgbmyPtxCPdFVXMB03i5vsA=;
        b=D45PoFy62S08Rk/YxIezflXlNHc1Nmt8GYAX/ndQcvev01NJkg+YwHNPi541xdZ7MQ
         5v/AmjE+94MghLXTSssUWEbUqfttu5SL07LWukj05UMFe2LaJIJulgjn5rmLdd9IAFin
         mDj2+XNC6wW0LJ3l6EEr9KNr5SJRQk+GSMQZq1Xy4RaZjVK34y/JeFjzg2oMYUrmY4bu
         SLpMGg7dgqCqFpLTluUnSeQy+8cRRh2ubC1hYcUNw3f/XFUxvzSTtGyLRJbkx63p8MmG
         o7CsM4P/x2DfIOREJ9bSjTh3mF88EbEFye0sX98P0jMR4OflxwR0TkS5Sgmu0v6X8/x7
         yCKw==
X-Forwarded-Encrypted: i=1; AHgh+RoFhAWxypDvAuqITUKvqwgUnC0sOOyJ8Xc+Sqywe0b/nvWI5GU/hiIO/CNTZmZQodNCdojo@lists.linux.dev
X-Gm-Message-State: AOJu0YxWJ2qhjqE+hgOpnyUnFeAKjh6kcjx1FbpIj6MCyc5sD4ZLgpdx
	EpP147v5EAW5Dabd5aS37PM9Uz4IJTNN/JtdcI1DL3/snbojl5KxyFzbB4j+AX4RufWDBTF1uVT
	saQgQsWO43X4vGOTaNBVm2rzG7d1WiCw=
X-Gm-Gg: AR+sD12B1ZbVJm3khkHd03n9mjrQWjHUHqY5IBSezU6JSk+AsMad9VKEr0TthXX8fq/
	/I4GJBKdD0XNf4RhJKousfMlz+OAssWL+O98i3capo0/vcqWinh7hfcidWoaC4BNb9xyPWzvodC
	3UAc3L1ouAVbpNJcPOXXtboGkNK/BDnxkSy8TftfHnhsWl49duplxzJE7c+SOktxNEBMKvvF7W4
	+Rkq1vZ+JvI2QBwXJaX6bYn5SC9jQZXUJVDXML1pnO20cJjgXEQxC5XpTf5VClqTl8F2z4j01pJ
	Mp91qJBxGpSbbTRF1m6qIKyT8QLynp768Ty2NfYiSILR/judn86ukqKO
X-Received: by 2002:a17:907:a46:b0:c20:e709:f944 with SMTP id
 a640c23a62f3a-c20f30507c7mr53249966b.27.1786498641287; Tue, 11 Aug 2026
 18:37:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <74871a78-5243-4898-8e63-92e918912980@redhat.com> <20260706180003.2124317-1-r772577952@gmail.com>
In-Reply-To: <20260706180003.2124317-1-r772577952@gmail.com>
From: Jiaming Zhang <r772577952@gmail.com>
Date: Wed, 12 Aug 2026 09:36:43 +0800
X-Gm-Features: AUfX_mz_sFTQ_X7muC45bcq2GPZk5Ug0Dk4RTT4P57_TR_B2GxG0kXl_LxWLo60
Message-ID: <CANypQFbv4bDaN1eF+GYsHfJmeau_4d8fc=THSNq-rZNtqk8i-g@mail.gmail.com>
Subject: Re: [PATCH v2] gfs2: reject oversized dinode sizes before i_size_write
To: anprice@redhat.com, agruenba@redhat.com, gfs2@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Jiaming Zhang <r772577952@gmail.com> =E4=BA=8E2026=E5=B9=B47=E6=9C=887=E6=
=97=A5=E5=91=A8=E4=BA=8C 02:00=E5=86=99=E9=81=93=EF=BC=9A
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
