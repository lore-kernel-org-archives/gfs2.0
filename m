Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591DF3B5840
	for <gfs2@lists.linux.dev>; Mon, 30 Mar 2026 09:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774863756; cv=pass; b=N+slXbQKzpHzeTtj+PiU4uWYcT2I/TzmrpDaLPEUCk//nxFBcL5C7nBnfKWrFH9uC66zE+/c/KsD0aqEpDx6l359htKj/TN7snAF8zRjYS2ySMA9dI+mzAPm5AjHdy24z5U81sVvITR8I+7ekGBJgKrwvy5WlQAFUfmtu9mOMSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774863756; c=relaxed/simple;
	bh=Oksqstngzx8o7kbTAhgowV32hBs+IFLeiXb1N9TPknI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XJXignrLzbdYpMKApASTLQW/YTLgwZ5rK1rKqtz7s6SMvFZriL9zgyyJVdnFRJE9VzK23+vjN5UEWwYZjADHJw5ihp9PknUF+Qp0EYCqr2NcSKlmrlXnEsr5WMgtkbXQfHs3VyNiR7WpgSGGJwMX5ihGKXKxqEep1hltDUuyImw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NZM3brzv; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NZM3brzv"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-650158138d9so1646823d50.3
        for <gfs2@lists.linux.dev>; Mon, 30 Mar 2026 02:42:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774863754; cv=none;
        d=google.com; s=arc-20240605;
        b=UDAR1v4MhI7dOmi+kJ/EzTmkaWVjcwDwubiQOTaolhzDVR5IKtyH8RCqL/lxINL0CE
         Vol+VXO8xlvIFEunNbYGX+PSEibM0zyQdTzBUG1lfsjXz8W5BvhV8zmscs04Zs44IQeC
         uNlpipo48jNd6R7i9AZqsScrD1HiMUQZUrIVCamCE3zsgVTb56/IL5ViAvweyX689RzZ
         LBz2H+JlpvfCg08aNXxAqLBWT7v4HfLZ2yA27mikpdPuwbuEAHSHvskUn6J857bGysNb
         QA55pVVYwDmnHyBK1S6Vi2ExGnFGJ5uNWri8ISXRvUQd2Jqmlo+qamUA5xWVpZ1fufdt
         aQgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sgRnnEM5K/+aiY8f/LT05IopSt+bcaUZn2uF40o+s4g=;
        fh=s2efXf/3B+tbwxT0Qq979hxXXr1Kq0iYAvqSa5uhqbU=;
        b=fwOqjubFWuWB8hIC7EKLWXI4Orp8tXmRzNhi9MvGu+OL6ZJxOrhy2KyMwTycwtOeod
         sYN+SZWJ74Hk/NLjLtX6DU7ifde98pfF0Kk+PnLuarsrcJNIPlnpPU6F7lvh1rB6ISgp
         EozjtDpSxrNs/4cOBQDU/pdTNtu5ejoUUiY4wSAGsoejEiaeQ0BMpwfKwsPrSs9TVsoA
         3NeFtrFxUu5qm9oGWpkMXtldHkt+8Hv5snmK7JOeUavLjWrZ33TABLsrPReTQTpXrffA
         e++G6lSR/CCPo1Hr2yqKLAZGUHgCzLGTWiSmJ71DpBVC/8uCMZ57fDjl6hwPAWZG9+3B
         GOWg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774863754; x=1775468554; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sgRnnEM5K/+aiY8f/LT05IopSt+bcaUZn2uF40o+s4g=;
        b=NZM3brzvwkf54MG5vLi9AbW0wnsHhG+Kv3IHLzh9Sk1/pJ/izuKvYkaU71NwQLeGvn
         RC2R/J1UzUTGIBJH1f8zA8UTfwIOWJmhH2KfzIKJLB2TcyfmCiVPKCeaYrEqQKTvFw5I
         /pyJGlaWBn5VhLvQ8ygi8YfGSum/Uf5RoBclXp+YYu5bITJvSGucFnBNYWeRwsmQSLLR
         r1RmQb/qmaBg9l5TO4utDym/rIErLyCBCosi19Tc1h2jfLTJLUsV/S1aLzo//hRqFWOp
         to7qgJebJxhpUK7vbt7KV1OhMFoz+hFPTwBI3awVBSp1q+Q9Qzd5uwyoYeLyYnCq6FSf
         8OUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774863754; x=1775468554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sgRnnEM5K/+aiY8f/LT05IopSt+bcaUZn2uF40o+s4g=;
        b=RX6MC4ZptamXFscyYlhuAX9n8RMRn76JT014vgEkRBjZNfxqxOaIdlXOGz7QoZi81b
         AHn5+OHc6sGMqtxtKJkzvqXyfOVvNFjl7LcNTGsNl1iknyFQgukrigBCn+D1Q5rxkq5D
         tYYXLkZfDZZo84aj/I8wj0lHjT7UDYBA7gvP1o6k/C8hT2GXUN4bBuSJDitquO6tvL7X
         y8C3HR0ntjhiaAb4n3zy2j5bX6oiTCmfkG4PKoC2z5+as8p/BGt16ATCur6r0Udmex6m
         DzzeMfZoXMb+H7XrHZvgfkQJGKjvMRX1ywYv//sIKW6pFTDSTJZui6sOsQluYa9kwegH
         j64A==
X-Forwarded-Encrypted: i=1; AJvYcCVPcsfz533faOEf8NylJ+nFoj3qi2jHyC2H1pidAlUIKC1NAPlYpCyuaoTG1wghNECWsHIP@lists.linux.dev
X-Gm-Message-State: AOJu0Yx52BpRtWK8qSyhm6H81I0K3dO4o3BBD43wTXIwjTv4Wuw7a+VR
	oRq1clm34YxXVR8AbcApqtI8EYh+1t4JH5Rbxgr194sKQhCUCPPhKJHYa8Imv5qoJsbxSVPL6Eq
	1MnEuitYUr6Qk5XwuOPcsuX8sLUnvBvA=
X-Gm-Gg: ATEYQzyHlnvnXRnxNfBNPNwCwUC/FRozsE2O/FpPsLGwX8Gi7nQHhnGK7HIhLh8YaeR
	JohGRRsMQRILyRnTfAOh93YgsXhkZ1EDVTlM8hxff0eTBEj4cgZt1HNqdWEdLGTBMBGM850XEhs
	U7X5aLlC1TlUZUY/UbA7UfKHRtvopyyjfLccpCMFLaa9eNkKfEUFbKUBC40ZNbNa8RVNgCvLSu8
	bqNgzTKAoG9fukmtBMml77NKfFcx8PZmZviK1wNC6Tplib6CN5rRfvayDfLusQUrZmszxSry/rq
	d62xFUokRG+lCL8HiQzAcZ9tue8qJoMdBhd8H1a0gqAdEwH0yNC3SyzGSwTkcp7Z8Umekkad
X-Received: by 2002:a05:690c:c4f9:b0:79f:3b8c:a818 with SMTP id
 00721157ae682-79f3b8cae62mr19775337b3.31.1774863754262; Mon, 30 Mar 2026
 02:42:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260325235155.9503-1-kartikey406@gmail.com>
In-Reply-To: <20260325235155.9503-1-kartikey406@gmail.com>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Mon, 30 Mar 2026 15:12:23 +0530
X-Gm-Features: AQROBzChOqhrppmGfaUS3E2tzP2yLvrGkT9f90LVzHqCHlsTQcz3oICSGR0H7WE
Message-ID: <CADhLXY5-mQw-_KBsgxVVKURdLEn1HQzODWpuhfrtp0Z7sk9g7w@mail.gmail.com>
Subject: Re: [PATCH v2] gfs2: reject journal extents with gaps
To: agruenba@redhat.com, willy@infradead.org
Cc: adas@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzbot+9013411dc43f3582823a@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 5:22=E2=80=AFAM Deepanshu Kartikey
<kartikey406@gmail.com> wrote:
>
> A malicious or corrupted GFS2 filesystem image can have a journal
> extent list with gaps between extents. gfs2_find_jhead() advances
> blocks_read sequentially through all page indices, but only grabs
> pages for blocks it actually visits via filemap_grab_folio(). Pages
> falling in the gaps between extents are never grabbed. When the
> cleanup loop at out: calls gfs2_jhead_process_page() for these
> pages, filemap_get_folio() returns ERR_PTR(-ENOENT) which is passed
> directly to folio_wait_locked() without checking for errors, hanging
> the kernel task in uninterruptible sleep (state D) forever,
> triggering the hung task watchdog.
>
> Fix this by rejecting journal extents with gaps at mapping time
> in gfs2_add_jextent(). If the new extent does not start exactly
> where the previous one ended, return -EINVAL to reject the
> corrupted journal early, before any I/O is submitted.
>
> Fixes: f4686c26ecc3 ("gfs2: read journal in large chunks")
> Reported-by: syzbot+9013411dc43f3582823a@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D9013411dc43f3582823a
> Link: https://lore.kernel.org/all/20260324033959.1456418-1-kartikey406@gm=
ail.com/T/ [v1]
> Suggested-by: Andreas Gruenbacher <agruenba@redhat.com>
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
>
> ---
> Changes in v2:
> - Instead of checking ERR_PTR in gfs2_jhead_process_page(), reject
>   the gap at extent mapping time in gfs2_add_jextent() as suggested
>   by Andreas Gruenbacher.
> ---
>  fs/gfs2/bmap.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
> index 1cd8ec0bce83..d3ba37291e4c 100644
> --- a/fs/gfs2/bmap.c
> +++ b/fs/gfs2/bmap.c
> @@ -2219,6 +2219,8 @@ static int gfs2_add_jextent(struct gfs2_jdesc *jd, =
u64 lblock, u64 dblock, u64 b
>
>         if (!list_empty(&jd->extent_list)) {
>                 jext =3D list_last_entry(&jd->extent_list, struct gfs2_jo=
urnal_extent, list);
> +               if (jext->lblock + jext->blocks !=3D lblock)
> +                       return -EINVAL;
>                 if ((jext->dblock + jext->blocks) =3D=3D dblock) {
>                         jext->blocks +=3D blocks;
>                         return 0;
> --
> 2.43.0
>
Hi Andreas,

gentle ping on this patch . Let me know if anything else required from my s=
ide

Thanks
Deepanshu
