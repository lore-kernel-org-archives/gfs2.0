Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507E217555
	for <gfs2@lists.linux.dev>; Sun, 11 May 2025 19:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746991559; cv=none; b=q0ny99EQA5LYJjukhEqxFka6Er+Ovg1WANScRInJ3eJy/0QcYy1W+kncp/sPLisGpQ5ETAgy2C1qAbsCoNK1k0n4LUIFwW1xYT6BGORzPKAtMb8pB8rUSzEIMWxiYSBDfz6aGaZHzblMar2wsROTF6rW4DTZbRLsmZtZuNXH+Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746991559; c=relaxed/simple;
	bh=tQv3a58bV8AQXJV7UVA8pp0/Dlup4/QeUPvx73V+C7M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KcgrejKPUbyogfKzw/Vq9tXtZyfCYxnnnLt55Ha8Phgm9FCtJ5JOpAJHFzcOrcvjMapQO5LzFqqRlQ5ELf4kbv1mN7BD0PdSrBKqHuPraXnmD9r4LXV8ZVOMOAg2FhtWRM/UdTrC458x7p7ZZ8wwLz6e1NjFkrqv0LYlU1eh1LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KCr627nj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KCr627nj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746991557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VSknZWzIXqvAtxKfsugg8SXVU+aLf6cDZHfS/FHiCJU=;
	b=KCr627njYnGWPtVxQqkFI9xj6p9bsPsiXqAIhbLeBQeMIXrWjRveifzrzXBkUI+xgD7smn
	g3+HW9pDItqQ/lHcHG+cpOuRLdsvX2W1wkM1QYAAzA+3AtxqTGhDZXkiHfXO1y7Lfdp87m
	Rb3aWcf1KeAsInJOlLlzmZ5HkmjAc3o=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-36-ele6Sac-MWialNoE8JRnew-1; Sun, 11 May 2025 15:25:56 -0400
X-MC-Unique: ele6Sac-MWialNoE8JRnew-1
X-Mimecast-MFC-AGG-ID: ele6Sac-MWialNoE8JRnew_1746991555
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b240fdc9c20so2372906a12.3
        for <gfs2@lists.linux.dev>; Sun, 11 May 2025 12:25:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746991554; x=1747596354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VSknZWzIXqvAtxKfsugg8SXVU+aLf6cDZHfS/FHiCJU=;
        b=F08JvJrGatklJ1vKauaeqxrWvNjk6MF1wsrbcka26zO1pt4sB4fdzJ644JbHCn2Pg6
         ztxZzwe1c1Vzhhc+Ij1rJhf0y1ZShzp5TutJtR/+vgpakCISOy5daIz7qBvxZfacgkI4
         WKSIJjmtWqECKCyv5sfzm3vS2+fmwHuQIZWDMupsMPnepJRgqBRhIdUtXzNodJ2lbn0a
         WajAlBa00s0qFwSzM4SMpZnRD/qFT4cHeD2d6/99ypXt6NBrnvboyISUQTzdoSoWbJh/
         dKPGPNC0lDRgrL87A9gkQ23Rmxxg5QVAlN/uea/ptjc6vWr9z5VMLJ+86JMIapIfa4Qu
         xxQg==
X-Gm-Message-State: AOJu0YyjILt2R4IK1Mf64YMDZf7eLDlqE6kNGP3nTr/yTR6ua6K4rMlE
	GLjQMCVLEfiYGePjPRtB+HgT6OdmhZ74u2WEjeKEYElXwlgiTHN8fuTdfIJssl3crg+LHLP177G
	/W4FHi3nQ6NivVWzDV+hBrMiQPjaJminBiauKUPH08s8kbzdIvU5mwIz92bnOHP5ubkaboOWDUp
	Xz2Xt8iMw0Y3HvOihLpgDTyunI6RmQdvoIlw==
X-Gm-Gg: ASbGncvM4M8YufFxB7Dceo/1TQN/xwNkt+OdZ2hOJ/HaFRV6X7bHI6UNZyEzm3KjtcW
	ZYeIOb9lhwm2G0zF7QPlNSUgmyYXfMq0jpazSzXB14zO7H2G9LK3zUOz/VNScZZEpXAc=
X-Received: by 2002:a17:902:e88d:b0:227:e74a:a05a with SMTP id d9443c01a7336-22fc91c0c08mr175053195ad.44.1746991553811;
        Sun, 11 May 2025 12:25:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGd/YLMq4KWnGa4/y+2VBdUSxemRLtkrZDS6SVfir+GFJD0h8AuQwX9xu3G10fal9CM5lwlETy228XpuJb55F4=
X-Received: by 2002:a17:902:e88d:b0:227:e74a:a05a with SMTP id
 d9443c01a7336-22fc91c0c08mr175053015ad.44.1746991553434; Sun, 11 May 2025
 12:25:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250511183133.31544-1-ebiggers@kernel.org>
In-Reply-To: <20250511183133.31544-1-ebiggers@kernel.org>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Sun, 11 May 2025 21:25:41 +0200
X-Gm-Features: AX0GCFvKOnEoZfolm9crwWaY9YPoY1xpV9DcdoF9USbgpq_57h4KumRSbr9G6lM
Message-ID: <CAHc6FU7gs_jg8kkZz7-raHLotx55pn-x3hqqDaiV2cpG5YL_pA@mail.gmail.com>
Subject: Re: [PATCH] gfs2: avoid inefficient use of crc32_le_shift()
To: Eric Biggers <ebiggers@kernel.org>
Cc: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: rWO1PClbjMsENHXArGYd8D2c0c9s22fPoQrM_vDqS9Y_1746991555
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 11, 2025 at 8:40=E2=80=AFPM Eric Biggers <ebiggers@kernel.org> =
wrote:
> From: Eric Biggers <ebiggers@google.com>
>
> __get_log_header() was using crc32_le_shift() to update a CRC with four
> zero bytes.  However, this is about 5x slower than just CRC'ing four
> zero bytes in the normal way.  Just do that instead.
>
> (We could instead make crc32_le_shift() faster on short lengths.  But
> all its callers do just fine without it, so I'd like to just remove it.)
>
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>
> Please consider this patch for the gfs2 tree for 6.16.  If it doesn't
> get picked up, I'll take it through the crc tree.
>
>  fs/gfs2/recovery.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/fs/gfs2/recovery.c b/fs/gfs2/recovery.c
> index f4fe7039f725b..9080f1b5f434d 100644
> --- a/fs/gfs2/recovery.c
> +++ b/fs/gfs2/recovery.c
> @@ -116,19 +116,20 @@ void gfs2_revoke_clean(struct gfs2_jdesc *jd)
>  }
>
>  int __get_log_header(struct gfs2_sbd *sdp, const struct gfs2_log_header =
*lh,
>                      unsigned int blkno, struct gfs2_log_header_host *hea=
d)
>  {
> +       const u32 zero =3D 0;
>         u32 hash, crc;
>
>         if (lh->lh_header.mh_magic !=3D cpu_to_be32(GFS2_MAGIC) ||
>             lh->lh_header.mh_type !=3D cpu_to_be32(GFS2_METATYPE_LH) ||
>             (blkno && be32_to_cpu(lh->lh_blkno) !=3D blkno))
>                 return 1;
>
>         hash =3D crc32(~0, lh, LH_V1_SIZE - 4);
> -       hash =3D ~crc32_le_shift(hash, 4); /* assume lh_hash is zero */
> +       hash =3D ~crc32(hash, &zero, 4); /* assume lh_hash is zero */
>
>         if (be32_to_cpu(lh->lh_hash) !=3D hash)
>                 return 1;
>
>         crc =3D crc32c(~0, (void *)lh + LH_V1_SIZE + 4,
>
> base-commit: 3ce9925823c7d6bb0e6eb951bf2db0e9e182582d
> --
> 2.49.0
>

Applied to for-next.

Thanks,
Andreas

