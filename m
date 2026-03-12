Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071A73EDAC0
	for <gfs2@lists.linux.dev>; Thu, 12 Mar 2026 16:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773332035; cv=none; b=JzZ0pMclGPrRwUkpyRi3gacGW/6T9LumR2jna9sRaZgjTOuJEDxxuFoKCnAS+kmzHeVnrPI9pWQ77/nD+Nan6jNNSFe+mAp2cWD/T8sWnm2ZFA+53Irq83Q9WjvHR6zlm7CjP7pvv9QR/gKR6UdU69eRMYPBVTTHPJVXrFmGAKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773332035; c=relaxed/simple;
	bh=J0G6eyWjCZe2EavnpoZMaa3QDnbvlnCWthcPft0y1xg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ULxm8VD0AwcZlP3Sr5S+3gRkLAXfOookBaPIbJHVfDw4RpDERx67szJl9IhJURDJj7GdGKmXyoF02g/B3lT2n4ObKLD1sDKAUmWidj82b5rPkMNTou5c7KrayF2hfTc8nR8hkuQfrKRrHQ+75dJJJC268oBq+qNUYEPwAHvfI0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-67bb04151dcso674361eaf.0
        for <gfs2@lists.linux.dev>; Thu, 12 Mar 2026 09:13:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773332033; x=1773936833;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r8DuBIlRqwUybKw9BKko7+xZruw6jP0mIyTYZl7vHWM=;
        b=AEdvOIDZnltQYDmAhXUZ1R0nn2YNEf7N+UkNRBYT+ozOWpFn7oItQwFkvi/4GNLfsk
         bUbuwS9mExFGivGa6D+sHXrcluqgqV0Mzuo2eLvckqbIiASKDqm7xnOpmaYs1g1s/0SS
         PC7hTGG8b9qgO8V6nDzORm6dPvp5p4eEDVrYoTvViaECsXghvnY7Z5v5IA/ZrZ0VwZ91
         QJG7TWz7wPpjrJhBo5ClKHWpenyWp4E+ggE3XTw7ziGPyExi+I9+k9WXPzpRnMgGv4d1
         ctOI3l8fzldanqBjNOIz+p8jxVl2AmETQXIty9aHx5EHdw36KXDKmDQHLv/Yh3XOZxUN
         wthw==
X-Forwarded-Encrypted: i=1; AJvYcCUysjy4wyMVfWx2LOPiX5NfBTOVQ+2J1aKBZ4C4Nq/emTsChy4scbkWW2Z+GHj5ZoJxK/EN@lists.linux.dev
X-Gm-Message-State: AOJu0YwNg6hzJmW8RJetQIKSL/jiQyaBcO8In2TNywBxGNxZlStmr+wD
	oJzKN8cxwRGVMbrVYabaymImDamRLTDVGBOzXRKGldM9N1tGP5US+rMXpsallQ==
X-Gm-Gg: ATEYQzyYPERyNqiOtyeQ4bqwCmAQDS/eCRwb57B0BJeOD+1OPqkkLdA8vhB+5r8u1f0
	n6AGaixL4wJJU6wRYuMG8cdNJS20vhC2N24Ww/hrI0qt0mp93WEiX67Ys7YwhYRp4mjD3jnzHFI
	iXGFwyeONijeEgKILE5rCPHIWgnOxwHLwMwoku3PYHZu2CstYjHn91uHV+lpYJ9EHeSEo/9JH+2
	TYNbDZOSnxSNdi7lJstYPcUeJypq5+xvinI15ekWhEJrWmxZWscHp90IYKw020C105TpLwfkxG0
	objkRerRkw6BS45Xd2l4Ca4fuHOqBDUsNTwOt9IoTEFBQFHVEYQzKKzbC5iwgpN+UrRQrDqVHrF
	5mnal7GnSJ13jNRTSmS0932BKDCpusea2NObtvWEp0lY0V+ro9SZjiQ7PPRuy0XYt5qjT+Pp+gM
	0TvmegMT1gJ6En4OOCIwE4mLTRs9WHwfBtuNXwr8B+twLIVuxVhjfNIQbym5Pf
X-Received: by 2002:a05:6820:4c8c:b0:67b:c368:1352 with SMTP id 006d021491bc7-67bc88d3af2mr4518785eaf.33.1773332032661;
        Thu, 12 Mar 2026 09:13:52 -0700 (PDT)
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com. [209.85.160.54])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-67bc93279c6sm3209228eaf.12.2026.03.12.09.13.51
        for <gfs2@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2026 09:13:52 -0700 (PDT)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-41708f6aa5fso805629fac.2
        for <gfs2@lists.linux.dev>; Thu, 12 Mar 2026 09:13:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVdHIJCGfwpnJgKM8wUVeyTjsXwx/I5jx6DdzdjWL8TGriQRztTDgkel+tR9LF116MRifJ5@lists.linux.dev
X-Received: by 2002:a05:6102:512b:b0:5ff:22f5:e37e with SMTP id
 ada2fe7eead31-601deb4d089mr2630417137.10.1773331557630; Thu, 12 Mar 2026
 09:05:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260310153506.5181-1-fmancera@suse.de> <20260310153506.5181-2-fmancera@suse.de>
 <20260311200219.45796ec4@kernel.org> <aebac89f-f3b9-4983-8139-353a3ff19c98@suse.de>
In-Reply-To: <aebac89f-f3b9-4983-8139-353a3ff19c98@suse.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 12 Mar 2026 17:05:46 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWK0P+EEQXOQ8FMb7DYt-95dAmmbOjMhxCKHnvHRntojA@mail.gmail.com>
X-Gm-Features: AaiRm51vTFby3MbWyu4EKyWe_lBoIWwNWM0L5hUj3OB8Sdn3mba4moA7Rj12Mh4
Message-ID: <CAMuHMdWK0P+EEQXOQ8FMb7DYt-95dAmmbOjMhxCKHnvHRntojA@mail.gmail.com>
Subject: Re: [PATCH 01/10 net-next v2] ipv6: convert CONFIG_IPV6 to built-in
 only and clean up Kconfigs
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, rbm@suse.com, 
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, 
	Selvin Xavier <selvin.xavier@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, 
	Simon Horman <horms@kernel.org>, Saurav Kashyap <skashyap@marvell.com>, 
	Javed Hasan <jhasan@marvell.com>, 
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

On Thu, 12 Mar 2026 at 16:12, Fernando Fernandez Mancera
<fmancera@suse.de> wrote:
> On 3/12/26 4:02 AM, Jakub Kicinski wrote:
> > On Tue, 10 Mar 2026 16:34:24 +0100 Fernando Fernandez Mancera wrote:
> >> Maintaining a modular IPv6 stack offers image size and memory savings
> >> for specific setups, this benefit is outweighed by the architectural
> >> burden it imposes on the subsystems on implementation and maintenance.
> >> Therefore, drop it.
> >>
> >> Change CONFIG_IPV6 from tristate to bool. Remove all Kconfig
> >> dependencies across the tree that explicitly checked for IPV6=m. In
> >> addition, remove MODULE_DESCRIPTION(), MODULE_ALIAS(), MODULE_AUTHOR()
> >> and MODULE_LICENSE().
> >>
> >> This is also replacing module_init() by device_initcall(). It is not
> >> possible to use fs_initcall() as IPv4 does because that creates a race
> >> condition on IPv6 addrconf.
> >>
> >> Finally, modify the default configs from CONFIG_IPV6=m to CONFIG_IPV6=y
> >> except for m68k as according to the bloat-o-meter the image is
> >> increasing by 330KB~ and that isn't acceptable. Instead, disable IPv6 on
> >> this architecture by default. This is aligned with m68k RAM requirements
> >> and recommendations [1].
> >
> > AI has spotted:
> >
> >> diff --git a/arch/m68k/configs/amiga_defconfig b/arch/m68k/configs/amiga_defconfig
> >> index 31d16cba9879..de088071dde4 100644
> >> --- a/arch/m68k/configs/amiga_defconfig
> >> +++ b/arch/m68k/configs/amiga_defconfig
> >> @@ -64,7 +64,6 @@ CONFIG_NET_IPIP=m
> >>   CONFIG_NET_IPGRE_DEMUX=m
> >>   CONFIG_NET_IPGRE=m
> >>   CONFIG_NET_IPVTI=m
> >> -CONFIG_NET_FOU_IP_TUNNELS=y
> >>   CONFIG_INET_AH=m
> >
> > Is CONFIG_NET_FOU_IP_TUNNELS=y removed intentionally? This option
> > provides FOU/GUE encapsulation for IP tunnels and has 'depends on
> > NET_IPIP || NET_IPGRE || IPV6_SIT' as its Kconfig dependency. With IPv6
> > disabled, IPV6_SIT becomes unavailable, but CONFIG_NET_IPIP=m and
> > CONFIG_NET_IPGRE=m are both still present in the defconfig, so the
> > dependency remains satisfiable.
> >
> > Since CONFIG_NET_FOU_IP_TUNNELS has no 'default y', removing it from the
> > defconfig means FOU/GUE encapsulation for IP tunnels will be silently
> > disabled by default on m68k. The commit message describes only disabling
> > IPv6 on m68k, not removing IPv4 FOU tunnel support.
> >
>
> I noticed that when running
>
> ./scripts/config --disable CONFIG_IPV6
>
> for the m68k, the script was adding CONFIG_LWTUNNEL=y and CONFIG_NET_FOU=y.
>
> CONFIG_LWTUNNEL was selected by multiple IPV6 features. I do not think
> it makes sense to keep it for m68k given the information there is on
> http://www.linux-m68k.org/faq/platinfo.html.

Dunno about lwtunnel...

> CONFIG_NET_FOU was something IPV6_FOU required, probably it should be
> just dropped from the config instead of explicitly turn it off as it
> turns off FOU_IP_TUNNELS too. It will be selected by FOU_IP_TUNNELS too
> anyway.

... but CONFIG_NET_FOU seems to be just a gatekeeping symbol
for the tristate symbol IPV6_FOU, so FOU is still a module., which is good.



Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
