Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591FE2C029C
	for <gfs2@lists.linux.dev>; Wed, 15 Oct 2025 08:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760518513; cv=none; b=J+EDtv+PnKFAww2QewCXhTsZxG13yBdNuc9eb0EIVG+eyUZuVRAXrRMTW3wk2qMTX8AM34qt0cc4WRDz6dVJh/BgXUAfeO5Bvb4ob0bYRlHoGiS3QjAebmIHO9n1cT30wEmMYM1PgF82//6Ful+GrVh+Egi4JZl+ZwfXMJZKiT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760518513; c=relaxed/simple;
	bh=PnZYoZixlZe2UBYMbO2OeSihGeWSGTpgJH47W2yN5lE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U5WWt+uDsFMreYgqcDQY98R6ibuF+2fxyWjNgOJ8PH96KxDMHCI3lRbBwFzC/pqbGLP7bli6sNaoqWEMPiLSmmCUMGEX/X1oOMtaxMakV2cZw3qVmOpNZykUwOa+9e++KF+ggpepRIQvzTDdxTHuuSyHQJGlVN0Vu36wnpmI+dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QTSsyR87; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QTSsyR87"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6399706fd3cso9343405a12.2
        for <gfs2@lists.linux.dev>; Wed, 15 Oct 2025 01:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760518510; x=1761123310; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fgEqnrxX4R0u2xnG7ixfV3NvX2lvrI5nPU8w2RGCEiE=;
        b=QTSsyR87N3eOXmgCZYm4Ocqetz8Rq/c8pMyhvbkNHU3U2OTgZ6VIyDtgqQx8nQ9e3d
         TW7mqlNukSjRPOiwblgOzfs5PcFpNan8mXOOmUeqT9PXXFwMPKeS+k9Lvl+XUKW2vWEk
         t/nptsHRRKJpHf5+49cayCPPsr8gZd351mq4ldaEWHXtDj/lYLm5q/LIJI7XoWhkYjAX
         Uz91w51vX4z5EHgEz80JMqGKTIpXPuUN3wkfN9tOPjsFLOY1CxP5rxArp1zymm55Roff
         +2rb3kMItj8/9vB0D1a1zzZDMy4cK9pXB7fS6e2uOdOw/pvKRCNIhEecYr7/gZXA8rFn
         HOsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760518510; x=1761123310;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fgEqnrxX4R0u2xnG7ixfV3NvX2lvrI5nPU8w2RGCEiE=;
        b=GqbY+kOn5rjdJMlFXi64efSfds3imLNKgm94ONTr2OrJMD74oWIrAW0F1c9aJa31JG
         xRfRBYpw7mkkpSNVZcv9biw684V0PsImYljbBB4PD75ARgy0Mx0L3rVG/24/63VbWXgR
         5fXkklhdBv+cgzTKiF2qjaqlZ2sUWWJ89ac+XxeA9LmUG22+1zzmttX3X0YCsHX8EKYc
         SRWa2GhkOOnoEE/a1cfl3IvYP9YqgaDzjj5eRXXGgpS1XxZIfNerXVEr+n91/LzYsUr5
         sAX8z2WenPzvKYVXAObLlDfOoqeCHWGw3P1CDyisJlSPUV+gSC2Zlbw3GqUR3yl+8jzf
         OFQA==
X-Forwarded-Encrypted: i=1; AJvYcCUzthg3Q3O2uCI9mW0DQvBjNgBuNpjiu6H+LeK9rApVC93Y+GtOEYq00xDmLtjAT8Pb1xaH@lists.linux.dev
X-Gm-Message-State: AOJu0YxHz94PZa2x0tP687JrmUNghJ+Wp6OiEek28q5/RN+//mXh7tJq
	aU6VzZYOb2YCjx8ARXsjEF7mlAAe/oNAh/LEP9ql4Uqfx1nfDdfj+wXnY/Ed08fou8Rs2NCguZP
	6hcOz44Rv0X1oU1twRwI1j085b3W6V4U=
X-Gm-Gg: ASbGncsqJQqC5JZjMK8YB16mfNm98El5qEHKkxzrb5B3JURfw3hOfquDoR9N3RBZgjP
	Zfxl4go5NuAiSf3M0D8zMIUJIWM/9pWofqtiNBDjMaWv2FcuHi34ln0PKy8AQjYVfeGANp0s1fB
	cB/sNheL2qsy8YB5u7gK+qc7o36bzUnpvOxi0sYFt8pLGMjxboSsexlU5DupuQY+KYt9AuKQdHg
	ZIzGONSa6qizoq2ci32PMzdvse7fEQL565aN4SqFEWmfqov
X-Google-Smtp-Source: AGHT+IFTcVXJ2k4Io0gR55B+LOiUs0D6lc9nA2FkAagSET75wVrURhguyB7dmaTVjRb2yFF3HFNEaUx2J8d6K4IUlfA=
X-Received: by 2002:a17:907:9448:b0:b40:a71b:151f with SMTP id
 a640c23a62f3a-b50ac1c4e7cmr3185549666b.30.1760518509261; Wed, 15 Oct 2025
 01:55:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CGME20251014120958epcas5p267c3c9f9dbe6ffc53c25755327de89f9@epcas5p2.samsung.com>
 <20251014120845.2361-1-kundan.kumar@samsung.com> <20251014180312.6917d7bd5681d4c8ca356691@linux-foundation.org>
In-Reply-To: <20251014180312.6917d7bd5681d4c8ca356691@linux-foundation.org>
From: Kundan Kumar <kundanthebest@gmail.com>
Date: Wed, 15 Oct 2025 14:24:57 +0530
X-Gm-Features: AS18NWBrpUjyPc8mxzcKZ88p2FW9F32bwQuz9_BbcqcNCJwm-Zl4oTpr4byxBk0
Message-ID: <CALYkqXp9Wewk=P79r+Q8HjngUOSWq71ZA6NBm5fPSj9EZHh1Ng@mail.gmail.com>
Subject: Re: [PATCH v2 00/16] Parallelizing filesystem writeback
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kundan Kumar <kundan.kumar@samsung.com>, jaegeuk@kernel.org, chao@kernel.org, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, miklos@szeredi.hu, 
	agruenba@redhat.com, trondmy@kernel.org, anna@kernel.org, willy@infradead.org, 
	mcgrof@kernel.org, clm@meta.com, david@fromorbit.com, amir73il@gmail.com, 
	axboe@kernel.dk, hch@lst.de, ritesh.list@gmail.com, djwong@kernel.org, 
	dave@stgolabs.net, wangyufei@vivo.com, linux-f2fs-devel@lists.sourceforge.net, 
	linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-nfs@vger.kernel.org, linux-mm@kvack.org, gost.dev@samsung.com, 
	anuj20.g@samsung.com, vishak.g@samsung.com, joshi.k@samsung.com
Content-Type: text/plain; charset="UTF-8"

>
> Nice results.  Is testing planned for other filesystems?
>

The changes currently improve the writeback performance for XFS only.
We have introduced a callback that other filesystems can implement to
decide which writeback context an inode should be affined to.

This is because the decision to affine an inode to a particular
writeback context depends on the FS geometry. For example, in XFS
inodes belonging to the same allocation group should be affined to the
same writeback context. Arbitrarily distributing inodes across
different writeback contexts can lead to contention of FS resources,
which can degrade performance.

I conducted a sanity check on the performance of EXT4, BTRFS, and F2FS
with the current changes, and the results show no performance impact.
