Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F3332B107
	for <gfs2@lists.linux.dev>; Thu,  6 Aug 2026 07:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786002973; cv=pass; b=AHICD6a3PHMAsKoZIIgJbZbZD9hfSViorTy81rHU8lxkrX22PWAJMGF64LFa1bAoVnqt1ofhTd63kTuFrJtbh1o4MY1WOzfWkG+xtPv9fHIH3l9QIsKsJguH6hQ5h77xYoJ9jWI98txsFzze9YBcVZ2ktrEAp2l0XsxGEBXTxlU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786002973; c=relaxed/simple;
	bh=mZA2+co8JyR8AhVnXKsyn8qV/VAQ25/BehkWnTRIakA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MQTrEnKR+2q0FYOLn+BgZbhMLw7H4A6lr6Xu4WaONtSXFhTNqlU7rDpdk6+w/g/ksGO20pjRKQ99BQ1ANizFadiEm9YesZr41mQ44Ysn+z6JeVaT9GG6CSAHFFumPjxcBTR5stdsdBOAqT39dSj10thjO//Kdyif+5QacMpg/m8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oEHhitul; arc=pass smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oEHhitul"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c1c52d920b8so285552566b.2
        for <gfs2@lists.linux.dev>; Thu, 06 Aug 2026 00:56:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786002970; cv=none;
        d=google.com; s=arc-20260327;
        b=puvBzg/KLSojcPFA1MPuzh6ctfR4g22bhavgOa7j6PfLvRnQcifd5Q7KUCbnxkNsZ+
         DarehG6McHuh7JPOj9KVDHKbacju5TeekmsrosYXGUBwosu0d36PQg5qJtKNXGTGdsvu
         tLI2LGMcuvTe61ZwlaqTeCy+9m/YICK4tJSlmYSMhLdQiRlmApsBTHw/Do4GePWI45/7
         lU25cuHZe/JQba9GVmGFZMPPxnt1mPepIl5r03LQ9ci6BX5E7kxuzdKUnesFffO4O3kA
         yrxKI5vuKT293u7gUUUwqHlDdTHJfYQPYp6qYlWCcQbKr+HwSZcSJ7DvKrg7vyVdT/su
         w6iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=alVwMbl9VBoTW/xDEpAPX7cYZNzoRuTYckTUnVBoUW8=;
        fh=V6DtqvSiJlUIE5gyyIA+TTxUw7PcZhnQ0oLSkgcE09w=;
        b=Sg0u8eHkEIYQJ7b8Uk/byo2UijogO9Nb9ZpK7IXcJCxRau5+Qu7AechlSDuMCBHvFW
         6mEpsGBfPWlE4464+bEddYT3llcWheFnfheCyuuWtwlSq/wAoFx5dp2NdrkTD2Kh9oGL
         A79A5qi/CkNm2UkssA/jsonAmth8TV+cceOYEkWXOLJef3JFxJHO+YuVaIeVQy516ghB
         3xmDjRLsFyuNuZEKxEcMenZjmTCUxdoWQaMbrf5ix8g9F/APGVsNjQZCF0FEYvbedLGb
         EKJ7+YgYv7dx4qK5j6T1YbmU9g90ICCjvQzWNdr9Af+74igXOJN1D8BVOcMZiTl9CAKA
         zbsw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786002970; x=1786607770; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=alVwMbl9VBoTW/xDEpAPX7cYZNzoRuTYckTUnVBoUW8=;
        b=oEHhitulHUspMGTdCPxfuByKZS2Yeq+gId/x5XkZI7Y+i2Pu9YtgvOBwCxjXq81saV
         hbB06StVni4SyLqvBClwUOGCGhJMq6a+0dS+aQmmW5tVKAP6YdpXXCj1TCNctiNbPsZw
         cmjKysd+CJQEwc3egdU8yFk4ysMCh20jSlAmLxF7/iJCLj8Alw9X5++6sELl6FCCdXsB
         zRAlLICSCSTFn1mlFDm1G44wIu6GJlwN2RC4/jxgag6y8u5w4KV6UmfX08FozYenGI7d
         VQjOvvLuLfGAZ/l4fgfGVWg15bgPzCYU//cI6N5FrRPd86UzXt00TNOBgAM9SbaTORh7
         kxTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786002970; x=1786607770;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=alVwMbl9VBoTW/xDEpAPX7cYZNzoRuTYckTUnVBoUW8=;
        b=KyIsuFrs/Z90qUs6Gmxml2xmMDyaJS553L9JEkt15BCFrR4iXtcBEfWINUI/914+u7
         m2laT3ER3dbngRKFwh9CCX5HFglm+dQabr8MaoAg2HzBhh7FGO3wB4ASsFnv5Zci7C/g
         Bg0k0lNA+ZpbbSORiqkxBgI6TwYZyZh5HuErl/lfu5TsFPTSsBHrGTikxWys0WvyV74v
         qa2kzHxNg2Fk3IHqi3B88kOo7NiiCgf9jiohlqQ6ldzvkjqcTvCXvnKfTRFnCAXP+6wJ
         mV3nH+URdEDsQ1k6HPnuzTN/RP2glDB5NmnCxhV9sDhNFnbglg9lnbz7KyAxbfDZYn5u
         hkww==
X-Forwarded-Encrypted: i=1; AHgh+Rr8u+GD6obWCnEC/G5h25ZbvaL0LXmLdG6IHT5tR+rWJW5N3Qno3zr8IlXVWx1BMp9SBmqz@lists.linux.dev
X-Gm-Message-State: AOJu0YzYvb4fbW/dfQwwa6LxkAruJ/+dJdwoucjtS3fK7AHsoTtti1/0
	PeeyvT3HWA1SL5+jHimIVDPoQnXzqba9GAxdOKsGmgriQGk0q7EqgxezbvTi2pSu+OmR3jGMPXR
	kFRVq8kf1Kx7TopUloweM7q1/6nAJb6g=
X-Gm-Gg: AR+sD10UZG/FxDBMpq6xioe8U/p+vGjeY6rhuIfNVRGiGpQ4vfBSsf9BAE+BPelbrUl
	mP/Mk3JUSuc+A4aDIw5xGW4cUIviHKVwB5xHac1EWtNnbp8Ji/Wb34BKb43xRkfHs2tQFegmPg0
	qtMpN0t1sIPlDCg9S8/Axm2ODHxGkQ6ZMicgLUN0juvbdeEhI0otUF9oNo4pdE5R05C2orDXmzM
	+mWqjxK36D/FWmVuyHcuZ+tsYHFCWYHFsnW84pviIeGH2qfQ/jHBciynYBKSQ2FRnPGnmPLg2wm
	ZiK9hGOa5xRvp83TY/BwEMdEut2FSYj3wNMEMOKk3kzGNfxHHehePXqR0g==
X-Received: by 2002:a17:907:8995:b0:c12:525b:4e84 with SMTP id
 a640c23a62f3a-c2039b07297mr596013266b.9.1786002969976; Thu, 06 Aug 2026
 00:56:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <74871a78-5243-4898-8e63-92e918912980@redhat.com>
 <20260706180003.2124317-1-r772577952@gmail.com> <CANypQFZTFMxk5W4d3GViW6T1Nkxua3nVk3RNx0fie-26fpmXSg@mail.gmail.com>
In-Reply-To: <CANypQFZTFMxk5W4d3GViW6T1Nkxua3nVk3RNx0fie-26fpmXSg@mail.gmail.com>
From: Jiaming Zhang <r772577952@gmail.com>
Date: Thu, 6 Aug 2026 15:55:28 +0800
X-Gm-Features: AUfX_mxtNC4c7CPA0o1izUT8H_DyX4nTJyNBaErx8W8Ejd3wshynsUlDa_fGDSU
Message-ID: <CANypQFaqi25O5jh16KfLxeA7QJZwEKaEgq-t-hw-ErxS8a34jg@mail.gmail.com>
Subject: Re: [PATCH v2] gfs2: reject oversized dinode sizes before i_size_write
To: anprice@redhat.com, agruenba@redhat.com, gfs2@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Jiaming Zhang <r772577952@gmail.com> =E4=BA=8E2026=E5=B9=B47=E6=9C=8823=E6=
=97=A5=E5=91=A8=E5=9B=9B 15:10=E5=86=99=E9=81=93=EF=BC=9A
>
> Jiaming Zhang <r772577952@gmail.com> =E4=BA=8E2026=E5=B9=B47=E6=9C=887=E6=
=97=A5=E5=91=A8=E4=BA=8C 02:00=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi,
>
> >
> > A corrupted GFS2 image can store a dinode size that is larger than what=
 VFS
> > i_size can represent. gfs2_dinode_in() reads the on-disk di_size as a u=
64 and
> > writes it directly into inode->i_size. If the value is larger than S64_=
MAX, the
> > incore i_size becomes negative. That negative value can bypass the exis=
ting
> > stuffed inode size check:
> >
> > inode->i_size > gfs2_max_stuffed_size(ip)
> >
> > Later, gfs2_quotad may try to sync the quota file and unstuff the quota=
 inode.
> > gfs2_unstuffer_folio() reads the negative i_size into an unsigned lengt=
h and
> > passes it to memcpy(), turning it into a huge copy size and triggering =
a
> > out-of-bound issue.
> >
> > Reject dinodes whose size exceeds sb->s_maxbytes before storing the val=
ue in
> > inode->i_size. Also make the stuffed inode check use the raw on-disk si=
ze while
> > it is still unsigned.
> >
> > Fixes: 70376c7ff312 ("gfs2: Always check inode size of inline inodes")
> > Closes: https://lore.kernel.org/lkml/CANypQFaF6bvORKKbRALvEL0k_epFaneFi=
OQqco4gjdmKVbdURg@mail.gmail.com/
> > Assisted-by: Codex:gpt-5.5-xhigh
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Jiaming Zhang <r772577952@gmail.com>
> > ---
> > Changes in v2:
> > - Drop the defensive unstuffing changes in bmap.c.
> >
> >  fs/gfs2/glops.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/gfs2/glops.c b/fs/gfs2/glops.c
> > index 28f32424ee64..8c5d257451d5 100644
> > --- a/fs/gfs2/glops.c
> > +++ b/fs/gfs2/glops.c
> > @@ -393,11 +393,16 @@ static int gfs2_dinode_in(struct gfs2_inode *ip, =
const void *buf)
> >         umode_t mode =3D be32_to_cpu(str->di_mode);
> >         struct inode *inode =3D &ip->i_inode;
> >         bool is_new =3D inode_state_read_once(inode) & I_NEW;
> > +       u64 size =3D be64_to_cpu(str->di_size);
> >
> >         if (unlikely(ip->i_no_addr !=3D be64_to_cpu(str->di_num.no_addr=
))) {
> >                 gfs2_consist_inode(ip);
> >                 return -EIO;
> >         }
> > +       if (unlikely(size > (u64)inode->i_sb->s_maxbytes)) {
> > +               gfs2_consist_inode(ip);
> > +               return -EIO;
> > +       }
> >         if (unlikely(!is_new && inode_wrong_type(inode, mode))) {
> >                 gfs2_consist_inode(ip);
> >                 return -EIO;
> > @@ -418,7 +423,7 @@ static int gfs2_dinode_in(struct gfs2_inode *ip, co=
nst void *buf)
> >         i_uid_write(inode, be32_to_cpu(str->di_uid));
> >         i_gid_write(inode, be32_to_cpu(str->di_gid));
> >         set_nlink(inode, be32_to_cpu(str->di_nlink));
> > -       i_size_write(inode, be64_to_cpu(str->di_size));
> > +       i_size_write(inode, size);
> >         gfs2_set_inode_blocks(inode, be64_to_cpu(str->di_blocks));
> >         atime.tv_sec =3D be64_to_cpu(str->di_atime);
> >         atime.tv_nsec =3D be32_to_cpu(str->di_atime_nsec);
> > @@ -462,7 +467,7 @@ static int gfs2_dinode_in(struct gfs2_inode *ip, co=
nst void *buf)
> >                 return -EIO;
> >         }
> >
> > -       if (gfs2_is_stuffed(ip) && inode->i_size > gfs2_max_stuffed_siz=
e(ip)) {
> > +       if (gfs2_is_stuffed(ip) && size > gfs2_max_stuffed_size(ip)) {
> >                 gfs2_consist_inode(ip);
> >                 return -EIO;
> >         }
> > --
> > 2.43.0
> >
>
> Friendly ping. Please let me know if there's anything you'd like me to ch=
ange.
>
> Best Regards,
> Jiaming Zhang

Friendly ping. Please let me know if there's anything you'd like me to chan=
ge.

Best Regards,
Jiaming Zhang
