Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B1213FEE
	for <gfs2@lists.linux.dev>; Wed, 11 Mar 2026 02:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773194855; cv=pass; b=fOuzuR1yuLM6gnsMJBVIdFGhiIL+lsOHHqtnOsYNZNjGH8TnLdREG4n1JrFtxzJDtnE6y2RlTw+iCgfrxG4mbJ5+tDStW1W570SfyeO+BIl1HNWg+B2xaGCJoZz7he1tE2DQ0FGk6+nI5EJE3QH85j+BDW/a++w/RaavT/iK3Q8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773194855; c=relaxed/simple;
	bh=8UJnLa/DDQ+b65RDSHa97nR/Rm6zetnRjswOkVb13wc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BXpJVfRbo4LlXCcOZcdMTSZguzp+cVIx0KISpfGfBR5GZsgpQoVAlwFx48a7FZe92mvAfCs4pISJzIGD35j4fUHxXz1jh6LAAkO/dRo3RdeyRnOvOMKB8uyqlSRY6aMKh1lACEP4J4hko00bjgaT9gA/dJ05ihAnODVVoWzn1po=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=G46rxFFc; arc=pass smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="G46rxFFc"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5a0ff30b240so8038069e87.0
        for <gfs2@lists.linux.dev>; Tue, 10 Mar 2026 19:07:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773194852; cv=none;
        d=google.com; s=arc-20240605;
        b=I5RBQY0sjW6CCC8MUrc+yzMqCosHfUrFQXo0a+7GY/c/EFGRKwS5Ra2YMMMVAuZ4a8
         /gdq5QHGBf6JPtfwmmT+bflwg228Milvk3aVDA6G9dRyKhZo1YPmkdc1bR6K0q/spNvh
         T1bCz2205FeuEdo1K5oN6r/bwjjH34xMQLduzeN/O/V4Kftgy23MaGEMJqUMxX6CUM34
         6DntfyehKlL+YdKQpP6YHNtcL9QXlesMWsynLVOPnV7uE1ExnC+5st3s7a1jsT8ELIRG
         h2FXtgB4oo3M13Jotvemw5qZFt7klRcoobrru1wmDi/qU86XrovsVtiun0T/9S1ZIqYO
         ITWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+zLBLQzKjcztDlxJqoLP6w+B6xnZmfHibV4jlBQCebA=;
        fh=AZx7JeGrNLU/yovFI5wq5aZmK2WTKS9vT0MdpBFcfgU=;
        b=J3KrGUhd9yC+a6IercerAJ0RGh/T/lD9vK4UOydgv3YRoXDoizM3cFiuU15TM5IAyd
         CJtzAbTHygXl+XCXZOWVgzTvL48zTOY3UmyVRx99DG3eQaAMcGxdnQjxpULoouAz0yXT
         lQ0XtwSaWxVnXV/FI1ImIsyTCpwBbQ3xQpoj6uOPI58gn5DTIVZRFBnEnjL6jNuOdphL
         BOZPmpj6NNRlo14LE7CBqWULIk+qDtpUYQjGS5Y4A9c+eW7154S4t/Vo3/TjdUO/7hhv
         t0voKOcr1TaxgIA4isp2QS7zrr4u0FXOa96m1bUuSht0aoMF/5nd/3k92hk9/+geJT0A
         Lf7g==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1773194852; x=1773799652; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+zLBLQzKjcztDlxJqoLP6w+B6xnZmfHibV4jlBQCebA=;
        b=G46rxFFcX1hnQKxUUrTijJdlDpB5OBfdKVt7tJqloBNXcNg5JAjWvjlGBTrQCSFpEL
         kw5r/kEngKAkJ0pkN558AqUScugTYRjvdhsBLXq38oLpcnNpxGDuEjo6TpPJTbZMKzhC
         YhKhvGGnSCYDK9QQnvadjQAxBlN7qho59qSI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773194852; x=1773799652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+zLBLQzKjcztDlxJqoLP6w+B6xnZmfHibV4jlBQCebA=;
        b=qXg48dUunyOHIdlsyKFcWx/z0lLPtZguDdOG+boNlj0DKIV+5HBQC716MEFVI/MKZA
         aQWNVa2pwAYHWECR70qsTBM9LPYkV1VasAUr+brNIo2Tm6AEMo2tBgIhUvYCcFFGZkSt
         UrXueT3hvXmsxvhbPdMgU1jpRNoJrTGshsD8o/XD2vvwmBSYH4IoYyyCJX2cMu2aKoBj
         8lQHoLpNKeqyU76mI7qFV4c8S2rMxQCBcgFseBesGhLT5OeeIwigQLHxkXbe4+uYfWYn
         YzHNqD6dsYdpZ7vK1jrzuH7eXtEK4f8rkMKOUuiYArlzim31aQ6D4/PyRHN4R+jtG9Hx
         LzIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMQrbPixk0H+sGZn7lxSoQQNakCx4VOhDMJUzdAvUIpd+8SHt/45cpZ8+mp7WRFTx5kAaf@lists.linux.dev
X-Gm-Message-State: AOJu0Yw8OrZeQF2nPyVOJF+neJQ328V1cNMbD1pH08e5wkbCRYltJ3YB
	RBbs3UnYyc18F5s/zfU3VLgTD7KUIX10E65RQtbuyf1jZaK6KTi6sWXUNTSF7nXacRCzIHrghvi
	pzqQKRuB7vd0f4A4hTxhMlIKnus/nVwBG2nErqtTj
X-Gm-Gg: ATEYQzynA+xf2JxKpQ58euHdeSbZFcK8JLXZBpK94VycSJOJzI4dK42x3m+6V2wWvz4
	xCXFh6psM1M3j6A/DwMRxPYsJLgSt5a/w3rhJShxWtxeqFpHiaY0N7V1ASsYj78y2DsLJEzNyZV
	CoAMs+UzJ2wJylwqRo9q/GHp88Y5bVBcXxWw0W8Tcg+sQgclBQwCp9Gr4h/LMOnPZQ0yKkFybpV
	qHQh9dwni/dA4Hs1G+sR+YZQj2OKxheMN8X5gmI6254uopIaBf3DJSAJOOWsiF/heQ9F3PxD/1A
	0rDckio7dw==
X-Received: by 2002:ac2:4427:0:b0:5a1:3134:9bac with SMTP id
 2adb3069b0e04-5a156cbd1bbmr169453e87.28.1773194852284; Tue, 10 Mar 2026
 19:07:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de> <20260310-b4-is_err_or_null-v1-56-bd63b656022d@avm.de>
In-Reply-To: <20260310-b4-is_err_or_null-v1-56-bd63b656022d@avm.de>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Wed, 11 Mar 2026 11:07:21 +0900
X-Gm-Features: AaiRm5028PWt8n-JnveiRgn8oYMksdR_-_nk4JOkvxMfplWs-GDr7RRk-OxICyw
Message-ID: <CAGXv+5FQAVaJjqhv+Xq-ysOc4SHQn2mCNTgCAp8XocmWBWGGoA@mail.gmail.com>
Subject: Re: [PATCH 56/61] clk: Prefer IS_ERR_OR_NULL over manual NULL check
To: Philipp Hahn <phahn-oss@avm.de>
Cc: amd-gfx@lists.freedesktop.org, apparmor@lists.ubuntu.com, 
	bpf@vger.kernel.org, ceph-devel@vger.kernel.org, cocci@inria.fr, 
	dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org, 
	gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org, 
	intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-mips@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org, 
	linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, ntfs3@lists.linux.dev, 
	samba-technical@lists.samba.org, sched-ext@lists.linux.dev, 
	target-devel@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
	v9fs@lists.linux.dev, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 9:57=E2=80=AFPM Philipp Hahn <phahn-oss@avm.de> wro=
te:
>
> Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
> check.
>
> Semantich change: Previously the code only printed the warning on error,
> but not when the pointer was NULL. Now the warning is printed in both
> cases!
>
> Change found with coccinelle.
>
> To: Michael Turquette <mturquette@baylibre.com>
> To: Stephen Boyd <sboyd@kernel.org>
> To: Daniel Lezcano <daniel.lezcano@kernel.org>
> To: Thomas Gleixner <tglx@kernel.org>
> Cc: linux-clk@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
> ---
>  drivers/clk/clk.c               | 4 ++--
>  drivers/clocksource/timer-pxa.c | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 47093cda9df32223c1120c3710261296027c4cd3..35146e3869a7dd93741d10b72=
23d4488a9216ed1 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -4558,7 +4558,7 @@ void clk_unregister(struct clk *clk)
>         unsigned long flags;
>         const struct clk_ops *ops;
>
> -       if (!clk || WARN_ON_ONCE(IS_ERR(clk)))
> +       if (WARN_ON_ONCE(IS_ERR_OR_NULL(clk)))
>                 return;
>
>         clk_debug_unregister(clk->core);
> @@ -4744,7 +4744,7 @@ void __clk_put(struct clk *clk)
>  {
>         struct module *owner;
>
> -       if (!clk || WARN_ON_ONCE(IS_ERR(clk)))
> +       if (WARN_ON_ONCE(IS_ERR_OR_NULL(clk)))

clk_get_optional() returns NULL if the clk isn't present.

Drivers would just pass this to clk_put(). Your change here would cause
this pattern to emit a very big warning.

I don't think this change should be landed.


ChenYu

>                 return;
>
>         clk_prepare_lock();
> diff --git a/drivers/clocksource/timer-pxa.c b/drivers/clocksource/timer-=
pxa.c
> index 7ad0e5adb2ffac4125c34710fc67f4b45f30331d..f65fb0b7fc318b766227e5e7a=
4c0fb08ba11c8f9 100644
> --- a/drivers/clocksource/timer-pxa.c
> +++ b/drivers/clocksource/timer-pxa.c
> @@ -218,7 +218,7 @@ void __init pxa_timer_nodt_init(int irq, void __iomem=
 *base)
>
>         timer_base =3D base;
>         clk =3D clk_get(NULL, "OSTIMER0");
> -       if (clk && !IS_ERR(clk)) {
> +       if (!IS_ERR_OR_NULL(clk)) {
>                 clk_prepare_enable(clk);
>                 pxa_timer_common_init(irq, clk_get_rate(clk));
>         } else {
>
> --
> 2.43.0
>
>
