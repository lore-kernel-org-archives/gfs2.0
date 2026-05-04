Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E843B8D7E
	for <gfs2@lists.linux.dev>; Mon,  4 May 2026 11:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777894425; cv=none; b=KMIpka0NBvI2Iq7xJ8Q92K1FEdfF0ZRVKciQ6IsFR++w/EpjWwNmnGVCgMLWa1OWDFTZg4E8TiBZpgB6FN2usBPK3qH9NicXLdXoXbqzzlVgAC/41ZueBuRb33oOY/DDx/HYqLxZTNWTp/raNc1V1P/7VI5RgDk7lPLDdM06Amg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777894425; c=relaxed/simple;
	bh=8SDLmHevIlwB/u7ZlGuFSlD6zurYax3/7No2hDObsOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q7AIKyXp+3TVhrOpXyLw1yvzHdKZ6LMPIjsyTCCWJOLzzLMr2yLfoHi6FhXpc/Xj4IJkXZVzE0qITAaCy9LTo1SjKKW12NAzh/U72TmfBBZlW7D+3mP0XqPn21N8/MDI/s1FYZew/Pk/qCTARqNs/nOsIDZ04EwBR/48urLUt4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UGX/x7i1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UGX/x7i1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777894423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cqnd2v1SDhrP0TeXptQ4w+p6QPtBOu2LtlAfgl/gb2A=;
	b=UGX/x7i1VbHHw300/cIIRt+sqjDK4WLV7qSHUS/wyN4H+p7/dNAv5aKg+I8LDxfjZUJdDc
	BXyl5+JWvXAnFP/sQ9Ot9JpdkczA8KBEgTbrczDhSnzCFlDK9tV1qOiz1NbaCeChle2AXY
	5DdlUsuEvz2Poty7b/g6Ut7no6JX4+Q=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-VQQ0lnM9NGOgY098hdmBKA-1; Mon, 04 May 2026 07:33:40 -0400
X-MC-Unique: VQQ0lnM9NGOgY098hdmBKA-1
X-Mimecast-MFC-AGG-ID: VQQ0lnM9NGOgY098hdmBKA_1777894419
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-7bd6f72e5aeso45099727b3.1
        for <gfs2@lists.linux.dev>; Mon, 04 May 2026 04:33:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777894419; x=1778499219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cqnd2v1SDhrP0TeXptQ4w+p6QPtBOu2LtlAfgl/gb2A=;
        b=awqA9mVtruCh3NwiHZecgynxP51GfjTQgOitxp9RWLpLzCNjZ3JHHNJDEV6dCS0yux
         bHNWucD5H0X3ojoRdCgQFT+CGJUI9kwNJvZviM8ehwUDunc8+DVQl1cMOZC3k8zkCchr
         PKk6T0U6wSepGFPw8fI022Oo99oQEXXN74T0zZzF+pq8jaiVYLdqgTOcfBpGLa4Q3e1W
         MF3mAphcdk2Ol96BMdzy/beNzNomglooIDbO0rN/T5SEk+q7hno8c2JlWKBY5HHCPkno
         CHK6G6WAGfqfN9nM5gsRCfa6kh2/U9wFgYAfShM7oGIEU+Sq4TuAEt+zxcPGkxSmKTXS
         Y0sg==
X-Gm-Message-State: AOJu0Yw42abgimZz9ZYj3C6DzvXCsyHQtr3kFm+ed8XMJYzsjhDVu0be
	sw/k5ZO1kBw7lMbKSmDZ9UvgAbHRo2oGlyamn5QZg2nPY9PbDa0a9DLcjmSY9peQejp+pmqDlpo
	it9TMXShpO9M02/y2WNInOjMBp/hRyM5MFcEzW1h2wlVfYoVMe5QycTCNTOfy5lEQw3IdDJbDut
	denTjWogiRJzrvg6n2roGCjoR7QPgZvg==
X-Gm-Gg: AeBDieut03b/GxyoZTmrlTetvZv8l3ZPl21kM0yD8+R0DTgqJylsLhTh8EsW4hSwWrp
	t4BZRDsLbrUKLA4yipEbyU6BZoHwza1Q4Tr0ZVkS0VCnlR/Ztq7Cm7WrLx7b13OeuvjgLNIiFl0
	Bs3s3qjznS4VLR3b8bT2+ul+8BNmcsqJwV3Nyd/d0MyMdx9IjScMnfko4GMw3xBJdRGu2QCDraf
	iYQofLNXXx8px4m9aygEfC3B48feifAtCBMZQ/nOw7KM/QyeEjdjHr0Dbh8H5Mlb1UBIrKBzKQl
X-Received: by 2002:a05:690c:93:b0:7bd:73f3:7a67 with SMTP id 00721157ae682-7bd770b299bmr97676447b3.28.1777894419454;
        Mon, 04 May 2026 04:33:39 -0700 (PDT)
X-Received: by 2002:a05:690c:93:b0:7bd:73f3:7a67 with SMTP id
 00721157ae682-7bd770b299bmr97676187b3.28.1777894418970; Mon, 04 May 2026
 04:33:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260501110203.18771-1-tristmd@gmail.com>
In-Reply-To: <20260501110203.18771-1-tristmd@gmail.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Mon, 4 May 2026 13:33:28 +0200
X-Gm-Features: AVHnY4L9bmQa5IUNT3tNlIxYBRuA1RsJ3l5yFYV1uqU02xQgIy4-3k0W5T6qgdg
Message-ID: <CAHc6FU6drG2y+dD-gkuq52uKUXzdGzBA6dNiwPe79-SF9J2hvg@mail.gmail.com>
Subject: Re: [PATCH] gfs2: fix use-after-free in gfs2_qd_dealloc
To: Tristan Madani <tristmd@gmail.com>
Cc: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Tristan Madani <tristan@talencesecurity.com>, 
	syzbot+42a37bf8045847d8f9d2@syzkaller.appspotmail.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JO_iuiorQVH3bfbDoJQcfptcNXCwzCYo0FG-QLceSms_1777894419
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 1, 2026 at 1:02=E2=80=AFPM Tristan Madani <tristmd@gmail.com> w=
rote:
> From: Tristan Madani <tristan@talencesecurity.com>
>
> gfs2_qd_dealloc(), called as an RCU callback from gfs2_qd_dispose(),
> accesses the superblock object sdp through qd->qd_sbd after freeing qd.
> It does so to decrement sd_quota_count and wake up sd_kill_wait.
>
> However, by the time the RCU callback runs, gfs2_put_super() may have
> already freed sdp via free_sbd().  This can happen when
> gfs2_quota_cleanup() is called during unmount: it disposes of quota
> objects via call_rcu() and then waits on sd_kill_wait with a 60-second
> timeout.  If the timeout expires, or if gfs2_gl_hash_clear() triggers
> additional qd_put() calls that schedule more RCU callbacks after the
> wait completes, gfs2_put_super() will proceed to free the superblock
> while RCU callbacks referencing it are still pending.
>
> Add an rcu_barrier() before free_sbd() in gfs2_put_super() to ensure
> all pending RCU callbacks (including gfs2_qd_dealloc) have completed
> before the superblock is freed.
>
> Fixes: a475c5dd16e5 ("gfs2: Free quota data objects synchronously")
> Reported-by: syzbot+42a37bf8045847d8f9d2@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D42a37bf8045847d8f9d2
> Tested-by: syzbot+42a37bf8045847d8f9d2@syzkaller.appspotmail.com
> Cc: stable@vger.kernel.org
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
> ---
>  fs/gfs2/super.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
> index a2ea121331f18..4d854556b5299 100644
> --- a/fs/gfs2/super.c
> +++ b/fs/gfs2/super.c
> @@ -643,6 +643,7 @@ static void gfs2_put_super(struct super_block *sb)
>         gfs2_delete_debugfs_file(sdp);
>
>         gfs2_sys_fs_del(sdp);
> +       rcu_barrier();
>         free_sbd(sdp);
>  }
>
> --
> 2.47.3
>

Applied, thanks.

Andreas

