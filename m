Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7926E2517BA
	for <gfs2@lists.linux.dev>; Wed, 19 Mar 2025 12:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742385870; cv=none; b=cl+nlMWj2gFZDPqam24TAQvO5W6ac/zuqOFAQIrKF5LbXwpg6afZukhKfgTJw9f0RXgbqNdDTkVW1wAZQ1tfHvnHWzmo40oX5JyvFBWs01Huku7WlBKfMqrcWOZYGc89dYHccvlvMJbYjp61kPAllLKu6l3kuxgBWR+dwzqoT7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742385870; c=relaxed/simple;
	bh=WmXx4bS7gYhJjRBKivFDUzEpM9fup72qFUElBjByfJs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RNkRKqiofmJnaAg89h1Q8jmejUcLJSWzEpHd5HRfxjTcA9uAKoa3d4pJidlpWU9EsgT0vi26G/g+NOHcCVv8nF7G9UcoOSXhblVkoaIyLs+6iqsIvGKlKAMNph1qW8LQDH0jT2YpPoXIFyTNv970eOQadzCd6T4QlxbLU3tGraE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JqACWi6l; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JqACWi6l"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5e8be1c6ff8so2963199a12.1
        for <gfs2@lists.linux.dev>; Wed, 19 Mar 2025 05:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742385867; x=1742990667; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WmXx4bS7gYhJjRBKivFDUzEpM9fup72qFUElBjByfJs=;
        b=JqACWi6lUKe2Ikt9rBYNt8Sy+qRAv4Y/Gk8RkKZcwHSCKiihbxc5UnXg7JxMqNxaEH
         xjYcuL7Xaf7iIM6PljCPCzQBgkP6JON2kgORaI7Ri9a748IPxUGpqgb95cBoRc7Q5ZEF
         v5046PBuFoDI90wXa8veyjMhlnj0qJD+OTJcQvQ5gPn+hPtgDMhGvf5J4MyVixfxH8xh
         GPzQdUWdo9cJbl9oBr+R6sEjconEUpdJkq9AkNI9Jyfuq1L4d0qCOmihD33ZtGcPMs3X
         jMaSlJ8OvS6OKopNe6gMoBmykfjYt2ykCOcD3K3RIEPglmMQsp0IBKLalk3/C5sScTB/
         W8DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742385867; x=1742990667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WmXx4bS7gYhJjRBKivFDUzEpM9fup72qFUElBjByfJs=;
        b=jUoyVshrfKuP9OKL03zgDAwclqFoe1Rj2LNFOZqwdSz42rF5QXX0QijiYa6TDg6BK2
         jz78gsi6H2yMotVQ8dc6z6794WNamOazXPamHP7OFUdDz7kpUI+3/LFbnw2xTYY9CF2z
         ScVDKhN954XDxmr9LjmtnefC7bbuW2W8i2XofpEqruV7Tz/VwoMFhf26rfB69tg9bvIo
         Ibnnxr4Rcs4UURyaQuSx/pfLw602DdLpx5XKAnP3NNqxp7VLZdAVtk3xC2sD4QZ7WEwq
         xthQnd/tA4boSkLyGbvwqA1oeNVeRygXqHSShIoefJkAwdtvHM24OYpvC9yTk45v8HUC
         bJtw==
X-Forwarded-Encrypted: i=1; AJvYcCWNyUceI1p3osMdD/E5SeWqNXwXc6FILDI3mAfo1t+7kgml1TiBWCuYOUIviTGyB0XxOQ/l@lists.linux.dev
X-Gm-Message-State: AOJu0Ywj6FyGYHrweJiOq5BOdiDqLdCl9Ad1pFgZPtXT9PAD62ulUvnc
	oHsAMA4JKjrbhgUxjc4yqCuTCut/RgmuefWudefEeEHi8T58vZ7LcyQ+9VZ3igsx5EzKE7JKC/s
	42YWOoJ79x2Qbli5yzYa2/2m7ITwiDuNm
X-Gm-Gg: ASbGncska4B0ois4Bzg2eikgxI9nW5phjWczsaAI1tsdR88Sa/uyrtGTQ65FYXFJVg0
	g2vF88BI3GeBk3EwgnGG7+0dERWx555k+eYd0V6f0BMdzfxEjeR8ARrPYOUrS08f6BFT5MXeL5F
	gSmnPTKw3LjTyzBJtwMrN9xpI4fmhHPuxgYIK9
X-Google-Smtp-Source: AGHT+IG6PF4ZQtoeh6iicrqQsCPPEvyzdAtYtZscAoUXBB+3C5gG7BWG47ZdqLIy50KcE4Lgbg4+Hv6J9EZax4UGhr4=
X-Received: by 2002:a05:6402:1ed3:b0:5e6:17e6:9510 with SMTP id
 4fb4d7f45d1cf-5eb80d06482mr2849727a12.6.1742385866463; Wed, 19 Mar 2025
 05:04:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250115094702.504610-1-hch@lst.de> <20250115094702.504610-4-hch@lst.de>
 <ptwb6urnzbov545jsndxa4d324ezvor5vutbcev64dwauibwaj@kammuj4pbi45>
 <CAGudoHEW=MmNLQSnvZ3MJy0KAnGuKKNGevOccd2LdiuUWcb0Yg@mail.gmail.com> <20250319062923.GA23686@lst.de>
In-Reply-To: <20250319062923.GA23686@lst.de>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 19 Mar 2025 13:04:14 +0100
X-Gm-Features: AQ5f1JqADt1B5Vnfp9K-CCKF_SgF_2UO8WraUUYZPvq8yjlFO1pbUd0LcklvaxU
Message-ID: <CAGudoHHVd8twoP5VsZkkW_V45X+i7rrApZctW=HGakM9tcnyHA@mail.gmail.com>
Subject: Re: [PATCH 3/8] lockref: use bool for false/true returns
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, 
	Andreas Gruenbacher <agruenba@redhat.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
	gfs2@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 7:29=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Tue, Mar 18, 2025 at 04:51:27PM +0100, Mateusz Guzik wrote:
> > fwiw I confirmed clang does *not* have the problem, I don't know about =
gcc 14.
> >
> > Maybe I'll get around to testing it, but first I'm gonna need to carve
> > out the custom asm into a standalone testcase.
> >
> > Regardless, 13 suffering the problem is imo a good enough reason to
> > whack the change.
>
> Reverting a change because a specific compiler generates sligtly worse
> code without even showing it has any real life impact feels like I'm
> missing something important.
>

The change is cosmetic and has an unintended impact on code gen, which
imo already puts a question mark on it.

Neither the change itself nor the resulting impact are of note and in
that case I would err on just not including it for the time being, but
that's just my $0.03.
--=20
Mateusz Guzik <mjguzik gmail.com>
