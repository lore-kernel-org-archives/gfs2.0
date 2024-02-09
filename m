Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A2A768F8
	for <gfs2@lists.linux.dev>; Fri,  9 Feb 2024 16:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707496151; cv=none; b=VoH5FZPMnFcHCop4fSX3Ytb+NKvvOyjc1NcyKcXCtiWCVsk6lIRlufa6mDTkxgIn8LgXJgsg4t9uh/a6G/Bysb7cMOBPIso2QIsudQ037ugtgp6E/CqMjwOLOcvOUk6NsaFUws/dQsmztphjnMjkDnxYJiIv8Q0uE1LwqyVWdms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707496151; c=relaxed/simple;
	bh=kVG4rmAX1MzvfP4plhvh6t2XV6btpWEjQfp2YBQC/uk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZfxeGdHjzd8t9ovjdl+KX3LChTUywM3xxl3lysMTjPSQQW28iTp3/tk3OTr55H4OaHqOvU2NhehviUqaSJgjl1+Ero3ZePU6L0ZnOXBQF5qRifPDwAsPM698+pxvhyP/MXV6XKmabv6DFHkDKHANs8gx9+qbA+p8f+CiA4TVTR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NeUm0dyH; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NeUm0dyH"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a3a9cbd198dso140972966b.2
        for <gfs2@lists.linux.dev>; Fri, 09 Feb 2024 08:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707496149; x=1708100949; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kVG4rmAX1MzvfP4plhvh6t2XV6btpWEjQfp2YBQC/uk=;
        b=NeUm0dyHZm6/LTDHNLdFX7aYEVFXvlNuEB2XYd5RGuj8QY8SNOus01ifYo5Sv50azb
         zrj1DfF4JCax3Lq0AvUoOTWLGdDZEBNnWnEIMAV1J6+hSE1ZJbEmmzLot7zwqORFaQFJ
         xoCVzPd/cEcHhiS0h01nwFi2zGmzIJ6Gwter2NxQzFINl+nmEj1EUIIuJU+8lz8c/UHE
         OzgEAbrr8hdFQiKI2BmAAr2+edY2fVVCWlX6oXZYig5R78zzSFtQhanHB8+IPO/epZka
         npW14afJ1zkTjKhCr/4e+oC8FvV1ZFXClSNLiHbAN72RGdsfBlrkdqV/sa5E8exwFG3e
         pZBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707496149; x=1708100949;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kVG4rmAX1MzvfP4plhvh6t2XV6btpWEjQfp2YBQC/uk=;
        b=Ecdg9QniRQma7xWw6B5nASjIFBLkV0D/OxV23hB0au/3qwcmhmGojxWvs/FeOmzuL5
         iPo18GrF34STqTZVv/nbKarG9srjSeJ1mXAl1xlSp55Aj48j1C2MNPqqc5s1LJOsOpSL
         R28BdrVcd7mogJYpR4N8uyUe3bHubns96BHFu/g91HPSqBoJmAw8yXOgO95DJLIAcXxK
         Sv0uX0AmZsURbI22X3jRV56SP24xLeqJmVysweurzgHAH5dngAPYakDu4ZFLUXEjxyYS
         x04p4v4SYyOCXrVZ3V3izkv8ec31ZPesDwvcnH2ESpaQcQZyj6K6co7Donh9CrnP/VLi
         gEFg==
X-Forwarded-Encrypted: i=1; AJvYcCWGlD/lmNV3/x8EMGfb7djqpomJE6A193cehbfNDzDrzeIM1noFfm6GQF3EFhfNiFcTCN/sswU1oL+yB0M9iJQ6+y0irw==
X-Gm-Message-State: AOJu0YzEK/aY1O/0VEkpkf0Bna0VutzNQBrIKeERc+Srp9gr7Ggv2mcB
	bEV8Jdx2IcyFulJm6qD51R+vo00SzpwvmtZlXST+B2M/pbTfWsNsvRpqSBhupoVkx7/6hBkzmFv
	fEMNTNWCihQOk/xjXfr+1A3SxFuEgr6F+XQw2
X-Google-Smtp-Source: AGHT+IFIjW6afRZSpR9rGbKLm/rdPxyNG0Z79tvHaAuAYu4k5p6b6BVAISbXhE/E21/MzIbNn74/BFd1oyH24+ZmDyE=
X-Received: by 2002:a17:906:2b53:b0:a3c:177d:cb1b with SMTP id
 b19-20020a1709062b5300b00a3c177dcb1bmr43168ejg.10.1707496148741; Fri, 09 Feb
 2024 08:29:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <38f51dbb-65aa-4ec2-bed2-e914aef27d25@vrvis.at>
 <ZcNdzZVPD76uSbps@eldamar.lan> <CADKFtnRfqi-A_Ak_S-YC52jPn604+ekcmCmNoTA_yEpAcW4JJg@mail.gmail.com>
 <1d4c7d06-0c02-4adb-a2a3-ec85fd802ddb@vrvis.at> <CADKFtnQUQt=M32tYhcutP0q6exOgk9R6xgxddDdewbms+7xwTQ@mail.gmail.com>
 <CADKFtnQnz0NEWQT2K1AGARY5=_o2dhS3gRyMo-=9kuxqeQvcqQ@mail.gmail.com> <cf6b1264-8639-46e7-8dae-5aff0306e958@vrvis.at>
In-Reply-To: <cf6b1264-8639-46e7-8dae-5aff0306e958@vrvis.at>
From: Jordan Rife <jrife@google.com>
Date: Fri, 9 Feb 2024 08:28:56 -0800
Message-ID: <CADKFtnS3gkGWfwD80intR906y4Hn39WHOraY65mFtqzE_-iMyw@mail.gmail.com>
Subject: Re: [regression 6.1.76] dlm: cannot start dlm midcomms -97 after
 backport of e9cdebbe23f1 ("dlm: use kernel_connect() and kernel_bind()")
To: Valentin Kleibel <valentin@vrvis.at>
Cc: Salvatore Bonaccorso <carnil@debian.org>, David Teigland <teigland@redhat.com>, 
	Alexander Aring <aahringo@redhat.com>, 1063338@bugs.debian.org, gfs2@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	gregkh@linuxfoundation.org, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

I sent this patch out to stable@vger.kernel.org. Everyone should be
CCd. Thanks for your help in confirming the fix works.

-Jordan
