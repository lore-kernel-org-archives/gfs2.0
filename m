Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115A938E5E1
	for <gfs2@lists.linux.dev>; Wed, 25 Mar 2026 23:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774482862; cv=pass; b=pLNGdccBryMk7pdhTZAE8S73Ii0jLXRMbTsalSWLVYrf/W8bdIoa5FKFZ2D4MSXP+DPJw++A1XdXWxB0ZEh2dGmoz9IDO4seNCcJxqN6mB8e5p6kciB/aQi5bpPTLdnAaN62XLQS33LdRUfEawF/WSdggEdn+jp4DY69Wsl3MAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774482862; c=relaxed/simple;
	bh=Cmt7t9af9r91jM2YotNPUOFMc+Jt7S9bb7Sd3CLM7IY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mrq2VPlz5IYVFptH1umvwXh95U5/VKymKHO0dSE5FlYT20MJj1Aprn80OwpX03gXx6Veb+GCOtpdzavLR3XMCLo8hcCVhRX6Dxj24cwqwrzsxGiqrc4fUqii2UP9I2SkI9cJTk0UseV4Sy9iBbNFS3508xVwSBKQzBgkCVLcegk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VmOZffWw; arc=pass smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VmOZffWw"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-79800183233so4488717b3.1
        for <gfs2@lists.linux.dev>; Wed, 25 Mar 2026 16:54:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774482860; cv=none;
        d=google.com; s=arc-20240605;
        b=TXA/Bj0nL3z/CaWj3/ZSx4p72rnMr0QX6DLTAz5W5C2H+EkZ/ki1dwePkQHpgn5cJw
         LUKdwNNsKgEH05zPFm7RqKhG/ScJitD46j87uJ9McdPynQfUpXkcNGhSLwrrDHl+xLzQ
         hxeoCLEflL5YcMQvBXF04OLO2Ol2iY0SUkvHdWXWorOtQMf3rvj2Os5q9q936f41mN4i
         H+XgH+eRYVw9uSbM+YXYrAX4F4E2lXH+FqPLOXoVyPrUrIPR0amjI7WOFR0TdKFukyA8
         ltHhNQt3wZjgJo3jlhXywSM4mDJFe5iV3dqrzIsF0XzOZplyRRZJzzbRLpIFfr8BtDlX
         rGKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hn2h3lzm4taz4/nrMi56nooNgDl1NkRBfkgit91qChc=;
        fh=OSVWPD2bctoNObtxUVLdUTmkpFYDSVEt1ebgMw+Bi08=;
        b=B4FVCtDky4GXhwSG6udJSh6R0ePHZ0bmSKr+IAoHpbtbnziFxuNTXPUyPpuLZG0l1f
         72IrWwvyYW9OTnEdEiI93i5bh4Wm9EymTaud68fFFvkOjiGh3UEEGAGsssVEG9ZScxe1
         grXaFDjqA0uQqVJtZiWcerrufL0d3CEurhF0/0PMSepdeoDakMlMkutvqFJ38699zKIR
         QUFYbqFmc5XU9E4yopj0yZc7BinMLUmFZNJWOD6e7FoSfT+Ee3iAJhLBgiwEAQ0bJUV0
         JMekmO0uj4wrm6xcQ5caPHmepM0lS7IT8BAVdvli3lPmAZi/u9lL6rIinDAF9l1IAdof
         a90g==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774482860; x=1775087660; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hn2h3lzm4taz4/nrMi56nooNgDl1NkRBfkgit91qChc=;
        b=VmOZffWwnoCpztsOF1V9p4EC+GYZxmkSrm4Ed5FK/eN7BWIwQcJ+0Vdz8C3P6S6dnK
         EQCdKjAoxoSQzocuBl8x715I6vWjRI5cka06xv1TTREMSTACNOb6hXHe+cqB6O7T7xCa
         KIYwwWGNc6//1gpKyGILg1GrDN7IPKONQO2yKhkALIduP0vfvTODDTjGWVDm+pIhYZ5V
         s+OAA2hTIcGAPml6DzfBHvjQcziSwnXY/NRvJeW+1cAjzguPBiE19MDgJZwbDV6pq1S0
         GJurs91EZINWYzyLQ42fHh/EluioM83VYewGGKZD6xkfWGxp2FaX7it4n0J14yDVXrD5
         4Azg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774482860; x=1775087660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hn2h3lzm4taz4/nrMi56nooNgDl1NkRBfkgit91qChc=;
        b=LdCX0GMsU+BJRsPu022zw04wZAVsyoNNNlomzE071j4isPzEbykctctNr1JUT/voy4
         iBt7kIhekZ5eAnmuI/QmW9Krzuc3ASYcbeZNwI0qKJeyJfHGLrdhKStUMSOgQ+2wcEWG
         1WMHWBBoeTVgf19Qsemia87yFXCOZX0la0iicIHwIx8pFYZ6aodcXul0aMvRFLUxlOJZ
         oCnghHKkVD2K8HU/GjqATpqXXSkUYhQjpvaE3/iqCdefDy1jBKbS0CKHlOdYZW/vJEL5
         XvQEBPEfaufm55R4HZXppXkWXMlD6eNR8zw8dJ7XVNfy3ncKw0AOb9HexA5vj/Eh9rX2
         PhOg==
X-Forwarded-Encrypted: i=1; AJvYcCVSHCaz6ZnfZ5VVgeYqHsKhJW47FOMvqDUNBdcQTUef8izb/KaWxMF4dY7+pEY84rwHRbbz@lists.linux.dev
X-Gm-Message-State: AOJu0YzPY0RwW+920/byb070Bxbm3YmoDOrvo+Wg+8xz8IYZHnW7BOfJ
	VHqAZzzx6acWuujmVVsAG88BUNEALzBDiVGH1W1Ga2b/j+6txO8parc4+2000r3dswSp16z9ZA1
	2NL0qonwwN7bwnnO7AbHd91tVOtfVeAo=
X-Gm-Gg: ATEYQzxoJyg0XzJmYBlDovHwnkL1J5A+h+FnQKtecDoLeiMCpdMS2DSzhtlhPBMkTVZ
	VtyAYtX1WnO31ZpEeUbDCm70hOqurLqnC4d6FP+8h/zmOaw0y2I1SRCDFZKnGxMMM0CFdGbtGqU
	2p86UUEZL9RmSECq3ou0PPdhlmbF7TF3DCTflFmIAWk5IvohvKpLRcu64q4ZJ1e2X+RE8EG5ZZe
	qnLA4MHZ83UOFDw3C+lEX0VHE/CYo0NfeuAlH8F5h7Yif64sL7DKEa+0W8Y7pRF4m6gfBqTrjaH
	hNa27NaNpBfpsm8Ycxp4ZxEtNu1iqo0EuElnbW6JBhdzz290hYyS2vxYW0/1w2EDb9xXo/q+ejt
	72ILTvF4=
X-Received: by 2002:a05:690c:388:b0:796:2f6c:70b7 with SMTP id
 00721157ae682-79ac2f69fbdmr89859277b3.27.1774482860109; Wed, 25 Mar 2026
 16:54:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260324033959.1456418-1-kartikey406@gmail.com>
 <acKjtaMVQS_d0Esi@casper.infradead.org> <CADhLXY5fxo_fOUTZv_DoHn3FJr6dFkKhRopzCLQYCKEjat71Zw@mail.gmail.com>
 <CAHc6FU5YouqqiyPgPsNshw50NCEiptzf=yePwEujGKu8NtHA7Q@mail.gmail.com>
In-Reply-To: <CAHc6FU5YouqqiyPgPsNshw50NCEiptzf=yePwEujGKu8NtHA7Q@mail.gmail.com>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Thu, 26 Mar 2026 05:24:09 +0530
X-Gm-Features: AQROBzDOsi3f48dMWSHBVxaHIpw59YGDseLWM9gs3A235IHhWiZ11jS9sUdaARQ
Message-ID: <CADhLXY4cahmyYEYvKaBXQddmermnDBpjbgAzt5roqGVvzcPGYw@mail.gmail.com>
Subject: Re: [PATCH] gfs2: fix hung task in gfs2_jhead_process_page
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzbot+9013411dc43f3582823a@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 25, 2026 at 7:12=E2=80=AFAM Andreas Gruenbacher <agruenba@redha=
t.com> wrote:
>
>
> How about something like this?
>
> --- a/fs/gfs2/bmap.c
> +++ b/fs/gfs2/bmap.c
> @@ -2210,7 +2210,7 @@ void gfs2_free_journal_extents(struct gfs2_jdesc *j=
d)
>   * @dblock: The physical block at start of new extent
>   * @blocks: Size of extent in fs blocks
>   *
> - * Returns: 0 on success or -ENOMEM
> + * Returns: 0 on success, or an error code
>   */
>
>  static int gfs2_add_jextent(struct gfs2_jdesc *jd, u64 lblock, u64
> dblock, u64 blocks)
> @@ -2219,6 +2219,8 @@ static int gfs2_add_jextent(struct gfs2_jdesc
> *jd, u64 lblock, u64 dblock, u64 b
>
>      if (!list_empty(&jd->extent_list)) {
>          jext =3D list_last_entry(&jd->extent_list, struct
> gfs2_journal_extent, list);
> +        if (jext->lblock + jext->blocks !=3D lblock)
> +            return -EINVAL;
>          if ((jext->dblock + jext->blocks) =3D=3D dblock) {
>              jext->blocks +=3D blocks;
>              return 0;
>
> Thanks,
> Andreas
>

Thanks for the clarification. It looks good.

I have sent the patch v2

Deepanshu
