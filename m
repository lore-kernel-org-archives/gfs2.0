Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D4718C36
	for <gfs2@lists.linux.dev>; Wed, 17 Jul 2024 19:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721244353; cv=none; b=Xk57KF2de1m7ISG/mhDrBwkf2fkzShr8Xj06PRi15U7TbDoOL8+YUJlvUaIkIdWb1dw30r21BnFN4YKh0oWavETZ7LzYD762ZCuLK5uJrY35iDXznNoqz0Jt9JF/40kam2VFRXYpU+3fYPWviP7fi3MJf2dmJKgsAHMEjE6vQEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721244353; c=relaxed/simple;
	bh=X5I1Jca5JWMI8M85d8SM7CW/rneWZxNjiPERP/alBrw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RGnJDCbAnr3oK38g3O6/ZtLgzNBzopYAxHQqcLGtwVobYMc3Lk4xCc4KHfIn0zYCK9Ps/Upve6Gw1vkYt29SN4OHvR8FQIvEuqtwvhjq1joSpKJ51VdHRNtHvXGQUrPcY47FjRxAzrmCJ1Zdgxe2soFeyfChj9PQ+IKNkTQ/FJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=RQ749dp2; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RQ749dp2"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2eedeca1c79so723391fa.3
        for <gfs2@lists.linux.dev>; Wed, 17 Jul 2024 12:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721244349; x=1721849149; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WYGugfNX65ySLvjWZV3rRRf/smmfI9uMFFwL3s80P2k=;
        b=RQ749dp2XmI4wJr2VIZam9qwzjSGZhdAQz3qMmvsVf9vOUr4zH4XhFF6kQUEul6jV7
         A71pkTqdf/80ywtCgrmhjZRtM/sdi9qDOhly9q0RMEPbWIzUVYh7wZSzYCU692oLcHiu
         sV87NB+2EGRejypjT/1d+9wAtFJuqdZtlxArE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721244349; x=1721849149;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WYGugfNX65ySLvjWZV3rRRf/smmfI9uMFFwL3s80P2k=;
        b=h3I2K6rNYfufA6FV8c22rgIKRv51KQRs7BABmLrMwTkLB0XVXB2+IptZJNEDv7e/4K
         gh/OGdNoYIVRSp0xowaDEKfL6gUATA7c0tFc6encvFfodtddB1QlKyqL18M059XSCYhD
         eAuHLV2OSUFOh1/8HJGiLNe0IZn5QPDd3768b4KFKk57xp/HjyAsgtm/b2MehtzdCgjH
         D3OdFvnUJwS2ULu9wwss48fdfP06RznQh7MPsE2zx727mvwAlUlxqpcfP5SR62C0Tuuo
         ouXf0dezidT5eGHwrM6B2BKM2CLnHri5M/uPIgY9gF1pj1gpKgC3oucNQMgnbjoy6Qmc
         lYJA==
X-Gm-Message-State: AOJu0YxWQmTUFWo6xFncqZ3vkGhOj9qjeenS/jik7lKOMzv46lucp7rg
	GACn8kcl9/yGoeUtPiX/BHLQqY4dmuKLkbJqVrVtWoEDtV/J64UD1Sb3Onges/BEoxwzmOTMEKy
	UhEVV4g==
X-Google-Smtp-Source: AGHT+IGmCSIShvqBOdNK+YqI5ahjSlaa6br4XGQq0LA+qYTPluXF5xC+OGAi6lKrI0O3X++tCfBpdQ==
X-Received: by 2002:a2e:8194:0:b0:2ee:8d19:85af with SMTP id 38308e7fff4ca-2ef05d2ca6fmr3116321fa.36.1721244348646;
        Wed, 17 Jul 2024 12:25:48 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ef05cd9641sm339421fa.64.2024.07.17.12.25.47
        for <gfs2@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 12:25:47 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2eedebccfa4so716901fa.1
        for <gfs2@lists.linux.dev>; Wed, 17 Jul 2024 12:25:47 -0700 (PDT)
X-Received: by 2002:a2e:9ed3:0:b0:2ee:87e9:319d with SMTP id
 38308e7fff4ca-2ef05d48368mr2478791fa.48.1721244346888; Wed, 17 Jul 2024
 12:25:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240715174757.876203-1-agruenba@redhat.com>
In-Reply-To: <20240715174757.876203-1-agruenba@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 17 Jul 2024 12:25:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi68M2mAY82Ss264_++2q2x1fumXnjK2Lxt5LZoDHbr9A@mail.gmail.com>
Message-ID: <CAHk-=wi68M2mAY82Ss264_++2q2x1fumXnjK2Lxt5LZoDHbr9A@mail.gmail.com>
Subject: Re: [GIT PULL] gfs2 changes
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 15 Jul 2024 at 10:48, Andreas Gruenbacher <agruenba@redhat.com> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v6.10-rc1-fixes

Btw, your key has expired, and neither a "gpg --refresh" nor looking
it up on kernel.org seems to find a new expiration date.

Please update the key somewhere, and use *long* expiration dates. This
kind of noise is pointless.

              Linus
