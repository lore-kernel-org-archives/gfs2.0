Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1190274B42
	for <gfs2@lists.linux.dev>; Wed, 11 Mar 2026 14:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773237986; cv=none; b=oP/IOSalWI+9dYQWz35QzZsq5Q8oYzIoqeQHtAP28+fDmbEvBlzSMMWMnyHUN5JMFV2aZn6kdWjiJFroYCd0W8MAG64iMpvhpFyBEDtSki0GYPVZ1rMvoE3F7ZK9oTyN/C7ZMQrJy0WMHf5Zvf//Px1QakwmKe4Mssku1LretBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773237986; c=relaxed/simple;
	bh=POUJjzeRhBIXfPGojdZfC417KH92loTKx1KmDpRcfoc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dnwZv1IRgxnQgmZXttXmTzWZ3zxJ2w61m80kQGeSoJxaPNDtjYimzD1lJ+W7E0wyzaivZTqNmi6L0ALWA4oBFVgW+lGEDOgHqgDSAWNsCtjsSGT31hKu+629fmSLBloTrMIE3+9079XFMMIb0kgm7C7Dd5l1mdQbWDO1AuoEJ4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b9423d62cbbso150074166b.1
        for <gfs2@lists.linux.dev>; Wed, 11 Mar 2026 07:06:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773237983; x=1773842783;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wIz9Fr5w5J45ZN4rxwvT/0kjXMGfLP1VpB2aKPOax7k=;
        b=LbT/xVulaIdE4vz7TxYLyezycliJo2Bf0QWeyeDZt00352ckCs/7reLk3x85PZEO7m
         KwqrwDi/GE7ES+jM1W/Gp42FI6d9pAYmOBVbiViJ1ENFBGVDWJ9tRhQnNsBH/WfhKU2t
         rJidhOJK9pm2AhECZbF6D3K6SkqiWkjZHEp0OvU7KZ9ted7vP6QMPokEK3z80SsAbllV
         6anheFAhE0jkicSmMojyjnbiLyxo+otWejTlvhXrGSjroaV9zN8dIn4DJIUzX6THPdyb
         H3vCprl0DFJzxc1M/jafZy1/cTbJw8QLxrCNDbl+GsHxhoTm/p7r7f9rzU8GHMeFCH00
         xGUA==
X-Forwarded-Encrypted: i=1; AJvYcCWujD96ErA7LxLx7JRPam2DKcrBpU5P/nEadgvvAE30Y1I6Qmgu/uphSmk4obGl3d6nBVUF@lists.linux.dev
X-Gm-Message-State: AOJu0Ywk+oiSXukOi1Cw1QLgCuh/Ztz4O5vNHuelZqMcR9/qho/UtBh1
	5/S+Ll4ft3bmTd5AxKdF8d0wCe2pJrEe3J4EazaNT31hlkjjjbXtIDdRYjTCgFeaca+qGA==
X-Gm-Gg: ATEYQzyF9WHd59uYDe2AU9tum44D7p0g1gja3xJkPtYmwDU3Jargzvu3GeHIuR0m2GP
	6zGZx4Zlo1tesIl3NoNhSJWXioj7qLiAQ/Fy1bWyYoa1QCjHHewYu08JGl6IffIo58YyoZwlKdh
	U4AVugC7rm1YDmSmHJkh87w2nzIkR6jSabp7iKtR3cQFTEMami9eePNtCZfYH3LRpqKfIJVjegh
	WShfWF7Qj9wNJHth9xNcmeoJ/LMn4QcZn8Q645ygPKLkpYG3U/yYCZjDMLq/fYXYA9aTo6NdsIO
	FscVxQwLoJDa2RE2Arda1/m8m0/r9VOtF/2HV3FaHMgo1dOCoKRR6QOzBkQx0IxfPPMR5ClisOX
	FrM0Bz6iIH4p6KBvayhGQx7hTsKpu6j5CycGopj4Fth/DN7a+tcYiom2eV6qH14iPLM4XDXdBJu
	o94QXPGI8/XhwRBeTL1y0e9urNp/sDoIVZnv8EOl2y0PcJm9KueC76MHd2F3yg
X-Received: by 2002:a17:907:940b:b0:b84:3fab:4251 with SMTP id a640c23a62f3a-b972d7b332cmr171277266b.15.1773237982801;
        Wed, 11 Mar 2026 07:06:22 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b972de48cfbsm59210366b.22.2026.03.11.07.06.21
        for <gfs2@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 07:06:21 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b93698bb57aso169021566b.0
        for <gfs2@lists.linux.dev>; Wed, 11 Mar 2026 07:06:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUw6aBXvAHo13KbWKuvx3FzMr1L7lc68uvzenct+scya3Cnm6bQF+OHc8EXn9XpyE6vTUCu@lists.linux.dev
X-Received: by 2002:a17:907:6d16:b0:b88:4f25:81da with SMTP id
 a640c23a62f3a-b97113ff0b9mr462021166b.0.1773237981235; Wed, 11 Mar 2026
 07:06:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-15-bd63b656022d@avm.de> <20260310100750.303af303@gandalf.local.home>
 <20260311141332.b611237d36b61b2409e66cb3@kernel.org> <20260311100332.6a2ce4b1@gandalf.local.home>
In-Reply-To: <20260311100332.6a2ce4b1@gandalf.local.home>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 11 Mar 2026 15:06:07 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX4kRGLaKMzPuhS1Pmxh609eiqQW-cAS_jWBBbt-vE6SA@mail.gmail.com>
X-Gm-Features: AaiRm53WEGMMLW4z34e7P-lM1qFvsCJGZ_o4JNL5NPWbhJPKmcqz6k9bJcyL--8
Message-ID: <CAMuHMdX4kRGLaKMzPuhS1Pmxh609eiqQW-cAS_jWBBbt-vE6SA@mail.gmail.com>
Subject: Re: [PATCH 15/61] trace: Prefer IS_ERR_OR_NULL over manual NULL check
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Philipp Hahn <phahn-oss@avm.de>, amd-gfx@lists.freedesktop.org, 
	apparmor@lists.ubuntu.com, bpf@vger.kernel.org, ceph-devel@vger.kernel.org, 
	cocci@inria.fr, dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org, 
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
	v9fs@lists.linux.dev, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="UTF-8"

Hi Steven,

On Wed, 11 Mar 2026 at 15:03, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Wed, 11 Mar 2026 14:13:32 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
>
> > Hmm, now IS_ERR_OR_NULL() is an inline function, so it is safe.
> > But if you want to use IS_ERR_OR_NULL() here, it will be better something like
> >
> > node = rhashtable_walk_next(&iter);
> > while (!IS_ERR_OR_NULL(node)) {
> >       fprobe_remove_node_in_module(mod, node, &alist);
> >       node = rhashtable_walk_next(&iter);
> > }
>
> But now you need to have a duplicate code in order to acquire "node"
>
> I think the patch just makes the code worse.

Obviously we need a new for_each_*() helper hiding all the gory internals?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
