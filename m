Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39A33B47ED
	for <gfs2@lists.linux.dev>; Thu, 12 Mar 2026 07:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773301855; cv=none; b=Z2C1rtUANzlSiBqEd11Z+2fegNDX6kL8Dwo45cX7KGI1QcMR4BmPqUsMCvrAIpjGUXKzmZ/EOEEZgH9/RHzET3fUfJpnn9m8gXlhx2MsLagD2BwAnPw3nuYnucMPyMSLIPIBiGmhdDyc+nxFxN8+/2f6YHrCE81+bcWruZRhIT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773301855; c=relaxed/simple;
	bh=r2PdE6HYGVzZYpXyEn5kett8unUMILRQGQuMPOiuUPo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UxXaCi8p/nq7b9P42petn/k+91pXHzPwjLNyVgcFdX+UNjv2pn2NaF5XrfXZXQtFdNeUlsj742D7GRkJ625pcWFru0Jwosqx2wM3fn8CbabF26VGRomgUX6rFOQ/mjcvTjhwqSA2DeNF4nIEntWl0FsscmakExnP5O0blcK2UZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-82984c077b2so445201b3a.1
        for <gfs2@lists.linux.dev>; Thu, 12 Mar 2026 00:50:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773301851; x=1773906651;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/LhKuHInA3JH1whpdNQPR6DLSzWmpT0VhZEHTHtHiaY=;
        b=amaqFSluLurXGto8vMdG9YwbhaWs2X8KRuBSv249vGY//32jNwF1d4vlisTASYQq7T
         ZCETORoI/dwn6wdf3UWkThi/mTgZXXFFzZe3s+HBVSjTbiqAHqYHQo8oHmKrxclPUXFD
         5qTBkIPgBIdq1dWDKOCDt2lKMqLs46XFy0jT+Fr3v6j5Pihl1EY7pCbF/Nc0QsocyCu6
         98JVbbtg4zbUuWrNh4D7NvSImx1iMSV14HgQ4gJX4NlfugxMs33Cri4Ie1zZGYHKHKyp
         Cn2fwbjEXyw7hUZ1xsQL837Luv/pPcdAv7tRYhDv5Hfoh0br2j3Es3yPlhMSqcOluDSQ
         lDJw==
X-Forwarded-Encrypted: i=1; AJvYcCV06kZN7BUUcmbf/QLOTlCAVc2RO8QYMZ5hXAGpEKgB6Sr9746YfgufTynZBTd0n0iPhH7T@lists.linux.dev
X-Gm-Message-State: AOJu0Yw1Y1GyfsNQnl0nGdmNFYWOsnQ/AgDDRibJALbwywzX/xCFbe2D
	WLqd5pMhAxHp2/2o3xEOgmjUh9peaHr1Vu9lVkcEQDrO7GVbJe9RL1lWh7SaTl4KGFfMJg==
X-Gm-Gg: ATEYQzzMJQnu53PqkNI8debrQeugXIwhrjJv768n1M4t/i5ja8iZ8yq+o5eJ4+aPZxX
	gdEr3w2o2N8qPzHzXqLuXDqDHBroZt1pfb37ucjSn7pQd8kaTfVXY2wBuhDkt9FlNLYmTvutXJM
	4jffc0GmxTL3G9egrplZ3lCI0iIPyyaOWFucwWp+g5t3hSWKzuRVHy3QAUnRQPXeRxWr5zAehZI
	In00crJSS5lCiUtsle+eTN5x2kd3Cee5CV2s/7YlkI0dHJDECWUvVWSGuxmObMnwaG0FO+s/bdx
	m8Z4wwykNg65vRERYoE+8EEGQU4/wcWbEPXSUy77ZNq9RQ2xoCOPHvP1F1dtPSwZePSKp+stCRO
	q/zTdZPVcpzUymUtWRvCh/Jn+GGlPey74uL/P44Y7thOMUqLv2S1nj5s2ArKLgoJDYGDeR3vMCr
	oZhaUYR5dosXGVpmxrhEn2RI7W5/QIR2a29vnor+6c8+/jcn9Wr9LUAP/IPtk=
X-Received: by 2002:a05:6a00:410f:b0:824:a22c:c6d7 with SMTP id d2e1a72fcca58-829f6eadd45mr4698413b3a.18.1773301850980;
        Thu, 12 Mar 2026 00:50:50 -0700 (PDT)
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com. [74.125.82.53])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a0736e64bsm1973100b3a.50.2026.03.12.00.50.50
        for <gfs2@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2026 00:50:50 -0700 (PDT)
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-126ea4e9694so1716954c88.1
        for <gfs2@lists.linux.dev>; Thu, 12 Mar 2026 00:50:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXnPg/8Izf6flbsv1L7cXZHEGAKyEjJ5YWECqGCb7RfCs7213au853Eg6wGtW+GihzMTpSr@lists.linux.dev
X-Received: by 2002:a05:6122:1b0f:b0:56a:9f03:1719 with SMTP id
 71dfb90a1353d-56b47483c0fmr2043365e0c.7.1773301414536; Thu, 12 Mar 2026
 00:43:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260310153506.5181-1-fmancera@suse.de> <20260310153506.5181-2-fmancera@suse.de>
In-Reply-To: <20260310153506.5181-2-fmancera@suse.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 12 Mar 2026 08:43:23 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWj-7J5bMq=wpv12CGaV7xtq7=O3nLHLvOT_odxOE4ueA@mail.gmail.com>
X-Gm-Features: AaiRm50vZ50YS2w5-6lod2s5W_kA6Ap8FK_nMN9HyVzDzz2AFRy7FAD50ZqnaYU
Message-ID: <CAMuHMdWj-7J5bMq=wpv12CGaV7xtq7=O3nLHLvOT_odxOE4ueA@mail.gmail.com>
Subject: Re: [PATCH 01/10 net-next v2] ipv6: convert CONFIG_IPV6 to built-in
 only and clean up Kconfigs
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, rbm@suse.com, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>, Selvin Xavier <selvin.xavier@broadcom.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, Simon Horman <horms@kernel.org>, 
	Saurav Kashyap <skashyap@marvell.com>, Javed Hasan <jhasan@marvell.com>, 
	"maintainer:BROADCOM BNX2FC 10 GIGABIT FCOE DRIVER" <GR-QLogic-Storage-Upstream@marvell.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Nilesh Javali <njavali@marvell.com>, 
	Manish Rangankar <mrangankar@marvell.com>, Varun Prakash <varun@chelsio.com>, 
	Alexander Aring <aahringo@redhat.com>, David Teigland <teigland@redhat.com>, 
	Andreas Gruenbacher <agruenba@redhat.com>, Nikolay Aleksandrov <razor@blackwall.org>, 
	David Ahern <dsahern@kernel.org>, Pablo Neira Ayuso <pablo@netfilter.org>, 
	Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>, David Howells <dhowells@redhat.com>, 
	Marc Dionne <marc.dionne@auristor.com>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, 
	Jon Maloy <jmaloy@redhat.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>, 
	Eric Biggers <ebiggers@kernel.org>, Michal Simek <michal.simek@amd.com>, 
	Luca Weiss <luca.weiss@fairphone.com>, Sven Peter <sven@kernel.org>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Gow <david@davidgow.net>, 
	Kuan-Wei Chiu <visitorckw@gmail.com>, Ryota Sakamoto <sakamo.ryota@gmail.com>, 
	Kir Chou <note351@hotmail.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Vikas Gupta <vikas.gupta@broadcom.com>, 
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>, 
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>, =?UTF-8?Q?Markus_Bl=C3=B6chl?= <markus@blochl.de>, 
	Heiner Kallweit <hkallweit1@gmail.com>, open list <linux-kernel@vger.kernel.org>, 
	"open list:M68K ARCHITECTURE" <linux-m68k@lists.linux-m68k.org>, 
	"open list:INFINIBAND SUBSYSTEM" <linux-rdma@vger.kernel.org>, 
	"open list:NETRONOME ETHERNET DRIVERS" <oss-drivers@corigine.com>, 
	"open list:BROADCOM BNX2FC 10 GIGABIT FCOE DRIVER" <linux-scsi@vger.kernel.org>, 
	"open list:DISTRIBUTED LOCK MANAGER (DLM)" <gfs2@lists.linux.dev>, "open list:ETHERNET BRIDGE" <bridge@lists.linux.dev>, 
	"open list:NETFILTER" <netfilter-devel@vger.kernel.org>, 
	"open list:NETFILTER" <coreteam@netfilter.org>, 
	"open list:RXRPC SOCKETS (AF_RXRPC)" <linux-afs@lists.infradead.org>, 
	"open list:SCTP PROTOCOL" <linux-sctp@vger.kernel.org>, 
	"open list:TIPC NETWORK LAYER" <tipc-discussion@lists.sourceforge.net>
Content-Type: text/plain; charset="UTF-8"

Hi Fernando,

On Tue, 10 Mar 2026 at 16:37, Fernando Fernandez Mancera
<fmancera@suse.de> wrote:
> Maintaining a modular IPv6 stack offers image size and memory savings
> for specific setups, this benefit is outweighed by the architectural
> burden it imposes on the subsystems on implementation and maintenance.
> Therefore, drop it.
>
> Change CONFIG_IPV6 from tristate to bool. Remove all Kconfig
> dependencies across the tree that explicitly checked for IPV6=m. In
> addition, remove MODULE_DESCRIPTION(), MODULE_ALIAS(), MODULE_AUTHOR()
> and MODULE_LICENSE().
>
> This is also replacing module_init() by device_initcall(). It is not
> possible to use fs_initcall() as IPv4 does because that creates a race
> condition on IPv6 addrconf.
>
> Finally, modify the default configs from CONFIG_IPV6=m to CONFIG_IPV6=y
> except for m68k as according to the bloat-o-meter the image is
> increasing by 330KB~ and that isn't acceptable. Instead, disable IPv6 on
> this architecture by default. This is aligned with m68k RAM requirements
> and recommendations [1].
>
> [1] http://www.linux-m68k.org/faq/ram.html
>
> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>

Thanks for your patch!

>  arch/m68k/configs/amiga_defconfig           | 45 +-------------------
>  arch/m68k/configs/apollo_defconfig          | 46 +-------------------
>  arch/m68k/configs/atari_defconfig           | 45 +-------------------
>  arch/m68k/configs/bvme6000_defconfig        | 45 +-------------------
>  arch/m68k/configs/hp300_defconfig           | 47 +--------------------
>  arch/m68k/configs/mac_defconfig             | 45 +-------------------
>  arch/m68k/configs/multi_defconfig           | 45 +-------------------
>  arch/m68k/configs/mvme147_defconfig         | 45 +-------------------
>  arch/m68k/configs/mvme16x_defconfig         | 45 +-------------------
>  arch/m68k/configs/q40_defconfig             | 45 +-------------------
>  arch/m68k/configs/sun3_defconfig            | 45 +-------------------
>  arch/m68k/configs/sun3x_defconfig           | 45 +-------------------

Why are the stats not the same for each file?

> --- a/arch/m68k/configs/apollo_defconfig
> +++ b/arch/m68k/configs/apollo_defconfig

> @@ -384,7 +343,6 @@ CONFIG_FB=y
>  CONFIG_FRAMEBUFFER_CONSOLE=y
>  CONFIG_FRAMEBUFFER_CONSOLE_LEGACY_ACCELERATION=y
>  CONFIG_LOGO=y
> -# CONFIG_LOGO_LINUX_VGA16 is not set

Unrelated change.

>  # CONFIG_LOGO_LINUX_CLUT224 is not set
>  CONFIG_HID=m
>  CONFIG_HIDRAW=y

> --- a/arch/m68k/configs/hp300_defconfig
> +++ b/arch/m68k/configs/hp300_defconfig

> @@ -386,8 +345,6 @@ CONFIG_FB=y
>  CONFIG_FRAMEBUFFER_CONSOLE=y
>  CONFIG_FRAMEBUFFER_CONSOLE_LEGACY_ACCELERATION=y
>  CONFIG_LOGO=y
> -# CONFIG_LOGO_LINUX_MONO is not set
> -# CONFIG_LOGO_LINUX_VGA16 is not set

Two more.

>  CONFIG_HID=m
>  CONFIG_HIDRAW=y
>  CONFIG_UHID=m

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
