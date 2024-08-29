Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7752D18E348
	for <gfs2@lists.linux.dev>; Thu, 29 Aug 2024 11:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724930790; cv=none; b=KhqG8wl+DBwJyThJrGhW26x8SbbmNDoU4ESoo1S9Ca6h6Leir0VtJZfQKugTb6kFew1P7vAVH34KLyg4BtY6hGzEnHLcXrjbYr4Eei8/RzK4PLZyd1K64ebxyX08rpqAtvO4EK+z/mYWRaCRZj6KSV3Fb9sZ+RSXeQ0M5dhwBAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724930790; c=relaxed/simple;
	bh=gOx6qmYz1ck2X6HyQGme0UfMW99Cp51bAJbqgEhNEeo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EnKmFXA1AMEOqIZtTBp82J9BrMYlqg4hQ9uqA6MovbhOZdWa1tMKuqSQMb7ZaM3vsx0a5IbrANd3vQv5lTI2WvXOcJ0CnhfTw7ypRAScjo70j1sa/LY3sjpaL1kOutBmsZDkOWJNaFC6OY4wGWFk+PutsfDA/1muuGuG6C/ouEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bzXOAsQb; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bzXOAsQb"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6bf92f96f83so2793166d6.3
        for <gfs2@lists.linux.dev>; Thu, 29 Aug 2024 04:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724930788; x=1725535588; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gOx6qmYz1ck2X6HyQGme0UfMW99Cp51bAJbqgEhNEeo=;
        b=bzXOAsQbY3MBQ0WcxEdIoc5mMcgqajjjKOcTNcTrirm0lC2bPqx8GNRGhLcyCtDbvU
         309hd1ZftMguWal0WPlv8MaZVCxYFQ5DqzEXiQ/s/Cendh0UzpSsrJWrVrRcer4KAhmO
         zF2u1LjKq491H6B9wfX6CP4ZrWj1vCS75Ypzfptpr2Eg/8B6azfHKmWDACn4ZMgk/0ui
         bWq2SgCgo2zYgIvh+0XXmTGhkVz2s7knVAlhCZPk3xBc9jhBkUQ+TdgQ5jUoQkuQIH5n
         01hFdhKomnCkBLm0nc3TDnPLUk9ZTr/0Idshi0ztxGJuvtlmTdtcgzJMzvHY3tXE1y5b
         ZRFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724930788; x=1725535588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gOx6qmYz1ck2X6HyQGme0UfMW99Cp51bAJbqgEhNEeo=;
        b=H3BUfF79QHtUnnVD0J6fL78Jpvkw2/4KpvJepaIwdsKTPxkxLMSoMV2kzSIshFsjhC
         2HO8riV9SRRzzuPahKvMJUVelsiN8aOnaAevKoDa0F3otQg//HrZgL+L+Mla2sdaNEwQ
         nmtnkqe8E2cDkM+s6NDqG/CEi+aYvnmBCbXulruYPhfC9eoMrpS7sxiD63EuRWwr/Kye
         jUgjTXN7YyjCneEDSywceeSpPZN/gn0ycuUBjbHTVnTF93XHJARuZ8AkLH6Az7Zt2qLR
         FlLIjkDjuPugyDfDaYtRKW7QQWcyEgXY/XzFUYHeoBqGUXwf5JTabmHT3V23dJsLsqMQ
         RTsg==
X-Forwarded-Encrypted: i=1; AJvYcCUQpkTX1bi/XLcEnTKcqtUsY9Wqzgxoi5t3f+8QjFfjQs38dygaCHcAp8YLlR76SOBa7LR+@lists.linux.dev
X-Gm-Message-State: AOJu0YyObE2AO19AbDbzyhm2aIQFjkIBopK6X2vtWcvdZ3a2g7rlyZ8z
	FAIyd/wGIWs89fxz4eD8+VlrwBOYy33KS+XG27br0zDguTe2OPgpcBBCNw2b3Fy6eHP80APz4ui
	G08QqYNS/27WPwevtJVSE+1zOZYI=
X-Google-Smtp-Source: AGHT+IF9Q1Ms8z/doAt1y4SkEv8z6ZQR3pz6NK2GvaKkD36Rbpxx93lLppwh2O+ZQ4ORSU1yEkhjdAHk+vkdNGr/aKc=
X-Received: by 2002:a05:6214:3388:b0:6c1:6ad1:72af with SMTP id
 6a1803df08f44-6c33e62452fmr25327836d6.29.1724930788119; Thu, 29 Aug 2024
 04:26:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1723670362.git.josef@toxicpanda.com> <2bd333be8352f31163eac7528fdcb8b47a1f97b4.1723670362.git.josef@toxicpanda.com>
 <20240829111510.dfyqczbyzefqzdtx@quack3>
In-Reply-To: <20240829111510.dfyqczbyzefqzdtx@quack3>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 29 Aug 2024 13:26:17 +0200
Message-ID: <CAOQ4uxjuySfiOXy_R28nhQnF+=ty=hL2Zj3h=aVrGXjm_v7gug@mail.gmail.com>
Subject: Re: [PATCH v4 15/16] gfs2: add pre-content fsnotify hook to fault
To: Jan Kara <jack@suse.cz>
Cc: Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com, linux-fsdevel@vger.kernel.org, 
	brauner@kernel.org, linux-xfs@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-bcachefs@vger.kernel.org, Andreas Gruenbacher <agruenba@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 1:15=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 14-08-24 17:25:33, Josef Bacik wrote:
> > gfs2 takes the glock before calling into filemap fault, so add the
> > fsnotify hook for ->fault before we take the glock in order to avoid an=
y
> > possible deadlock with the HSM.
> >
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>
> The idea of interactions between GFS2 cluster locking and HSM gives me
> creeps. But yes, this patch looks good to me. Would be nice to get ack fr=
om
> GFS2 guys. Andreas?

If we are being honest, I think that the fact that HSM events require caref=
ul
handling in ->fault() and not to mention no documentation of this fact,
perhaps we should let HSM events be an opt-in file_system_type feature?

Additionally, we had to introduce FS_DISALLOW_NOTIFY_PERM
and restrict sb marks on SB_NOUSER, all because these fanotify
features did not require fs opt-in to begin with.

I think we would be repeating this mistake if we do not add
FS_ALLOW_HSM from the start.

After all, I cannot imagine HSM being used on anything but
the major disk filesystems.

Hmm?

Amir.
