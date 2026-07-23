Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7163DEAF2
	for <gfs2@lists.linux.dev>; Thu, 23 Jul 2026 07:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784790729; cv=pass; b=UZOoM93MUmewlG3+DHQDmSbw9lbPhjrV9iPlAHiOcfyeFAvlufKmEHDQ8BFLL58A6yr2Ry1cDUC+bOd9WIC0zOx/BBXAc3BlH9rnkgSnj9hjQXeO6DdsXv27s9FCoYGdjy6q3Sh9e4wITH6u0fHw0LZEPjnhBm3Uc7X4lUWaHV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784790729; c=relaxed/simple;
	bh=5NiWOGnxsMKR6Y7Ktao+SroKZ3GKM9CKFPaVhFIzaB0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U14KOYFjikolFhpSKOeaxppR74Usz6ivhhK4Y4ZY4deg6QBGH+zIIeNCpz3/NB5uhaxkh0MUlEApOpaK/LdiWqZhaYB3FtfAwm8JBcDuF4kFxTTlNdruuRcGsQwETMvX1F8Gf5rwEHSJdxtUTX59QgOODMAICk5vzWe2Xp9kdxg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AupAQtnX; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AupAQtnX"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c1c52d920b8so44877566b.2
        for <gfs2@lists.linux.dev>; Thu, 23 Jul 2026 00:12:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784790724; cv=none;
        d=google.com; s=arc-20260327;
        b=Z4H6D9VuXwVMkTgrtteqwXPGlLWoZyMGtb49lmHaCiBmsa0BYrVz9FgxuKB/MwfxBk
         TBfFnRUs4h7QVyshAx0lNz//yHfk2WnWJpmUXQwQLD3jR0vzA1x3ywA72FwUTj8TCH8z
         6PEcRXnO0ua2Lax5R1vZ3rSohhnjysuOLyYr8sPdOC3PyICar1pyYerVe8wizyKIid1p
         MSeM3Ag2eqWCem6V5YwzwVWFjQ9Gv7RISyPzbtdnVCyZHsvrn7UgDZmN0kXC8SWTzAY6
         8t5XMTJLN0EJjBm+cInwUNMGktMseWFJ1ggw2rpZf8TftzOkF5+ceFj8nER9G7A8rL1K
         +9Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=67tBP+uVC+SaNQnmOv5yOW1I9ePYbjiEsgc1u662Y84=;
        fh=rCdFjFpIx+qCLEm4YtESHU3wnfxKMLpam206mlDiQe8=;
        b=TelAI9KvqH7gtMsShsYXXGi81KO8yozaOFKD+iLgPay62tcBH+oWbpSBYpDnqfAePb
         YU+7CpTqVb0hR4sr07jgakdqBI5vEPfZZ852ZMAc2ZvBSejpcKG1OWSDdHLKbTnz6/xM
         eiZlV6zyMtcp6uhekXcZaiLdp5QK/+p4g0OGVLlw9FROOZqovdcKJLLO+/0ccEeBuva6
         X8hgKhLhCOChnzpsUXOj+yp9m8ufrVm3LCRDNkKobA7PZIEVM9uc3PgB9nhdFGr3vW9w
         MPlK+pGMc42+13yQXci6OQAjRzgIhGm+7UcINekAOrXB16QgQ+vj15puANRus2vueTkH
         ya5g==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784790724; x=1785395524; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=67tBP+uVC+SaNQnmOv5yOW1I9ePYbjiEsgc1u662Y84=;
        b=AupAQtnX9D9xAcvuf6CQ0vyRCF5RRWv75IXcZQG1noN+bT80uwj1rhucIXvXsaW+HH
         OntfKfFA4D4ppRlqeiC4h8Ov6Nm9R4OSXT3GpPUaEOuYcyLKjxvWb2w60dr389QtDSSU
         p6sZ9Ysw6obOJ3TrYksq5hxbC5hxltBJ9EzNonhfAYs4XbK0u+kaLg/CWmOHUcd2kt1t
         r8hdkH6v/v19G9mUpwciXDLw1DQPHfyquTjBRj6CjqC/vpm2eDMxYMzvZUFbES2KWKho
         wxq+FrABCF5NsdQKAeAredsyASzPFlcY3DUIiLAAy0zToFC6297QYCj7zFObqP3VrEpv
         uADw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784790724; x=1785395524;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=67tBP+uVC+SaNQnmOv5yOW1I9ePYbjiEsgc1u662Y84=;
        b=Fw1faQP6OrQWTPwudQEzGcjH2bMEBcfjxZxDrrZ0hJYCSKoAxd16jk2tH4f5ZR++tY
         ZHrEw3zCjG5Jb4FQuqn7RELiIQ52kqZrNLBaMKb9F5CXCp9mGd54X8/9SoSAT8PDUWBX
         2gIea6nFOKtD+4meYlLYOPdBVBxD4xCk8bPAGC5QtgNckxmoo1wJokZJXVgRzGCsklTQ
         9+rfXHxxNUZmTZcvQgTDFVy/z8hjHj+8HCJfW4mJk5Sfevym71cbqwM/7dxlTQJvANE0
         l+8oqaOVYNx2nnWvRC9c8o837wSjOzWrrV2aDAHm1sC+gTMdj//HJgeRm1sCLI5NaFA9
         JtvA==
X-Forwarded-Encrypted: i=1; AHgh+RqucSR6E5FISAoLr/R6y1be3C0m8bCh/sSEeWMk1JR84LiRhzJVatvetjdUH3Oj3RYaly+5@lists.linux.dev
X-Gm-Message-State: AOJu0Yw2ufBWfD7lTEJP8OUaJy5IqFEEeWNicIhTrYGBBMfrGmg11Jbt
	oJSVXSPdjFrP5Jc4/GRDSCjnj3c+3hmn6IeSSsMw/XPbpFYBISh2i1JQgCIxYxQIllCyBgRSErI
	xAhdJYosnqxmYFX9E/8WZm6vg7N/8ooOSAdux5sVkHw==
X-Gm-Gg: AR+sD11btbBRcvy9CSi0QljXiAzKQfvG6JElA0upUPKmREnWMyMNOZJs0AZhmdICLc/
	YJyaUis3tjhe3SCbbrycSOGzRs0Vrlw6tccya9JRavqJfUhY4A8U1QEHqhO9ZFHfx8hdYQRCyhh
	qoz6B+FWnjvH3o+4CZUPPDfxgMoU4ZlLVQlON04TklbdNXlZfgLvxuU5ujcetK9Iaom5ucKD92u
	ahQmI+IdXydI24UXX/zkB/IFsofIfmo43Rrn18xsoIdhufY0tzFQzl1yrjy7js=
X-Received: by 2002:a17:907:72c6:b0:c16:5855:6594 with SMTP id
 a640c23a62f3a-c1c509a88a8mr78873066b.55.1784790723811; Thu, 23 Jul 2026
 00:12:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CANypQFasb8voDrg=O9xJikYHdRFeupb5VP2VeJaZ_wFNMoGr2Q@mail.gmail.com>
 <20260710092933.3631376-1-r772577952@gmail.com>
In-Reply-To: <20260710092933.3631376-1-r772577952@gmail.com>
From: Jiaming Zhang <r772577952@gmail.com>
Date: Thu, 23 Jul 2026 15:11:18 +0800
X-Gm-Features: AUfX_myo1Vjbatxc8KRRJByNYdmMhAyb2kEPWuIuJa3znpiRChKHuTJVgaf5nmg
Message-ID: <CANypQFY_AYRXuiO++tQuZfdnb4mmM4dbkBJ93xD1BmVYL3bRvQ@mail.gmail.com>
Subject: Re: [PATCH] gfs2: stop logd and quotad before kill_sb log flush
To: agruenba@redhat.com, gfs2@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Jiaming Zhang <r772577952@gmail.com> =E4=BA=8E2026=E5=B9=B47=E6=9C=8810=E6=
=97=A5=E5=91=A8=E4=BA=94 17:29=E5=86=99=E9=81=93=EF=BC=9A
>
> gfs2_kill_sb() issues a synchronous log flush before stopping the gfs2_lo=
gd and
> gfs2_quotad kthreads. Given a corrupted filesystem image, that flush can =
spend a
> long time while holding sd_log_flush_lock. Since the background threads a=
re
> still alive at that point, gfs2_logd can be woken and block on sd_log_flu=
sh_lock
> in gfs2_logd(), and gfs2_quotad can block on the same lock through
> gfs2_statfs_sync() -> __gfs2_trans_begin(). The threads can then remain i=
n
> uninterruptible sleep long enough to trigger the hung task.
>
> Stop the background threads before the kill_sb log flush. gfs2_destroy_th=
reads()
> waits for both kthreads to exit via kthread_stop_put(), so after it retur=
ns
> there is no live logd or quotad thread that can wait behind sd_log_flush_=
lock.
>
> Closes: https://lore.kernel.org/lkml/CANypQFasb8voDrg=3DO9xJikYHdRFeupb5V=
P2VeJaZ_wFNMoGr2Q@mail.gmail.com/
> Assisted-by: Codex:gpt-5.5-xhigh
> Signed-off-by: Jiaming Zhang <r772577952@gmail.com>
> ---
>  fs/gfs2/ops_fstype.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
> index 9b9e70f14d25..d087845a75d6 100644
> --- a/fs/gfs2/ops_fstype.c
> +++ b/fs/gfs2/ops_fstype.c
> @@ -1776,6 +1776,8 @@ static void gfs2_kill_sb(struct super_block *sb)
>                 return;
>         }
>
> +       gfs2_destroy_threads(sdp);
> +
>         gfs2_log_flush(sdp, NULL, GFS2_LOG_HEAD_FLUSH_SYNC | GFS2_LFC_KIL=
L_SB);
>         dput(sdp->sd_root_dir);
>         dput(sdp->sd_master_dir);
> --
> 2.43.0
>

Friendly ping. Please let me know if there's anything you'd like me to chan=
ge.

Best Regards,
Jiaming Zhang
