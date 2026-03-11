Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B0E2FD7BC
	for <gfs2@lists.linux.dev>; Wed, 11 Mar 2026 13:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773234970; cv=none; b=tT+4ijEmYqKRCdP2hDXCmqiD3KxXS86gqqrkZlLsx+gJOPm61sXDBPjVw4vs2eGX/qL5MeTgqfyei1lYBAvxV6VXpWHqMNhPjVg2pp862O2g7FjxrwvwMA4S6bg0g9s67eEb7DRxkxU+of12xTwA7y0uX7ZoRWdDTchftYkxDWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773234970; c=relaxed/simple;
	bh=bQRlE5OR+3/41N9B/xBGXfMeOTv3hgeQ2WrY6jcTpBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T3GqgHlVDsOI44E0xyJcc+Vb68QWR9+I3wYlFBEqyzhegUkLdRdHudPBcHfyfiOgiagfLrp7qHqgseRQEI9HMuUWfRQoyzlUB7IzZSIYCWKkrumLPs90RzxfsuOlUPSYpot0ruAJgbMGP8AhNS2DwJGjnb6J91wXG0PCeVRe/uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5675d609621so11786910e0c.2
        for <gfs2@lists.linux.dev>; Wed, 11 Mar 2026 06:16:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773234968; x=1773839768;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=34DR94e/1PAvLLEaib58vFA4GW0m5SGe6jvxchEhMek=;
        b=cGM9IFR8o4aw96jU/Hcnojlep3gYrgZ4JGfapMjeeM47ugNRzMEq9hEX096hM9W5Rh
         k8NMFrg9UlOT5ImsIvEyfAYuAcM+Y60KKAbyv4NK8lioDgVaP7T3m/Mzur5hCoDExvh7
         mTkUQTixJIvwf1IG9B+qxyvSnT3q7JFBNy6zwwUTvO9Ls9R6AFCL2BdjheMxwgfqQ8rj
         fN0xsfnp3KlBZpBjWhdnxB5thlWaRuMetE9VgXgWKxqgwQrQQ4MWKpS2OhgfQYQM9cKF
         rVTVTzmY9dX6PK5drIFjyZYVuzWUZAX333Rdmh/TVVN9PAQSRzbpb9BXJiPIXc9ZeqCT
         0ofQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDM8Ix1bQhcb79rETcSV501G8me2S0DzkqQdaGGP9lniU9AshatRtr+SxoK6z7nOFSlCcw@lists.linux.dev
X-Gm-Message-State: AOJu0YxZ+r7/MFo0vGZvsB1+Ej5R3tG7mJI8f75oFsNuP68r9Xepl9rS
	oA5nZsuqVfI/49dDsQ/rBh2SSJiL257VBNZRRNdN8+TOe+oUA135d/HOjfioe7Y1oU0=
X-Gm-Gg: ATEYQzxejLzHIxFnuQ0t/Td7OFIYn36RJ88E6q6zXqcTf9zoxSxxV69qT3w5AL2Gp1b
	bokQEyB0BtDSdFhgBBc8bsi5HZQFnF8GLGtJwCAvMAtw2BG/NNHn11Q93f73y46BwwqDxks472U
	MOmbm6woZjKfTfVJBpKMnKyY2ZqtMrc3ypTb+ySYYHNeU0z9NBTsbf1eGNnB6PGFIvYzpZkNWCY
	PdMQKrbKVJRmby+zz7yABwMKEanwezmDcjTBYAWvdkThEbE+X7MmeE2CIzVnfsFcw7Xw26aCvlK
	QqvFPDPouX8L5pNvkQVRCZVHtiz8A5mvQFAneIfSYKfr3dRj0n1dRmOTvqBJS8g9P5Hm1d1iqAK
	4s/ZoPNRHY1yJi9EzJm3Uoqi7hYrIVQYFlZQ9m+ci1jeYvcFqTmW034TXUYX78vp7Kcz9yezcmK
	Q2LGvI0IjKKL6nzFk8C9abIqvvLAUyJzD2j81KAvfBx/Xf0elAG+rAZT0EMbT9W/Xv
X-Received: by 2002:a05:6122:4b14:b0:56a:f5d2:286b with SMTP id 71dfb90a1353d-56b47476003mr933944e0c.5.1773234968027;
        Wed, 11 Mar 2026 06:16:08 -0700 (PDT)
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com. [209.85.221.177])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56b4645d11csm894859e0c.12.2026.03.11.06.16.07
        for <gfs2@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 06:16:07 -0700 (PDT)
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-56739adfa1aso10524040e0c.0
        for <gfs2@lists.linux.dev>; Wed, 11 Mar 2026 06:16:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXD5Kln1oKlJcj4/zlPapXog6tD3hDq2eyCCVboEDlNyNejS5jQHhreD+Hxzvf0fbpAyXzc@lists.linux.dev
X-Received: by 2002:a05:6122:1d05:b0:55b:7494:177b with SMTP id
 71dfb90a1353d-56b4752d806mr922396e0c.10.1773234967338; Wed, 11 Mar 2026
 06:16:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de> <20260310-b4-is_err_or_null-v1-36-bd63b656022d@avm.de>
In-Reply-To: <20260310-b4-is_err_or_null-v1-36-bd63b656022d@avm.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 11 Mar 2026 14:15:56 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXQ8Q4jvkgFRJYhghz2BZRDC-9Mk6DbXxuaOc6C9DFHZQ@mail.gmail.com>
X-Gm-Features: AaiRm52J84H77ROK64ZWWtJfaiCpnFeKyoSRmPbi-NC8CN6Ju1TJEFxJU9gZQQ8
Message-ID: <CAMuHMdXQ8Q4jvkgFRJYhghz2BZRDC-9Mk6DbXxuaOc6C9DFHZQ@mail.gmail.com>
Subject: Re: [PATCH 36/61] arch/sh: Prefer IS_ERR_OR_NULL over manual NULL check
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
	v9fs@lists.linux.dev, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"

On Tue, 10 Mar 2026 at 12:56, Philipp Hahn <phahn-oss@avm.de> wrote:
> Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
> check.
>
> Change generated with coccinelle.
>
> To: Yoshinori Sato <ysato@users.sourceforge.jp>
> To: Rich Felker <dalias@libc.org>
> To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Cc: linux-sh@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Philipp Hahn <phahn-oss@avm.de>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
