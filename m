Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C022222D2
	for <gfs2@lists.linux.dev>; Mon, 29 Dec 2025 17:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767029506; cv=none; b=e/6Q4O/152QklDfpVDL/TI6eojM+W/lqjS5OIvP3B7pabYHWVJhn7spamvozFeYVGxzMAD/Lgdu1u6s9faU2Ntr96rsxdAOwdr5z8cv5V2dQM+1yMHxc31TMSKMhb20eftOII/4FolhapWkpT7y9p1mQKMoEZyAtMS6BmBu0Ky8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767029506; c=relaxed/simple;
	bh=sB7PMENR+fUJKBXKq/NIHJWq5FasyFV7oFqxpse5Luw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p6olilPj+MELV2scw8K4IxpE7DFPVxl74Xn2+WGnA+rlUM4iX8iHZUhunOpndqgo/gQyyPV+IfY+nEyA39GfdKM0NhV9YXo0kYXrL6GXh83hFS2+p1ssL4z33hJLbXSOuxP2VP2FbIFmZxnbSofgJ2FIrcmf1HXKIlHoducv6sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HVY+vSoh; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HVY+vSoh"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-88a37cb5afdso123596946d6.0
        for <gfs2@lists.linux.dev>; Mon, 29 Dec 2025 09:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767029504; x=1767634304; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sB7PMENR+fUJKBXKq/NIHJWq5FasyFV7oFqxpse5Luw=;
        b=HVY+vSohKOWrLtltzr1Xc1X9R5Z9YpmQlb0BB2QF1eMJ+tO2GjedwsKXm+2wWKSQNk
         ST1cyr7ssRiCwP3FRjNMxYA5E7u5c46MkdMowJLT9zHXjPBp2KTXajaFIxoBqTzGfpgG
         8bNVgTwpTKPD6jE8DYcosF2+CT4pJrFa4EQYuycyrsC1DWvJLYLRU6bxlJ5/P3FuW54o
         FUeRAV5YXcpg40CLhSMgAqftAAf+bwNHYNxRl60CyuFLOm+xpxhqFWl4NTT0H3SirP17
         pRqSWkwYEfdoXfDlIR5FOsyoxd6N/aTxFjoeH/NZYica5/WS/IimS+pxUiv3wu7xulLJ
         hJpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767029504; x=1767634304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sB7PMENR+fUJKBXKq/NIHJWq5FasyFV7oFqxpse5Luw=;
        b=PNGMMMChkEcCf9ayv4ArlWQnmJsWPX3sNSZFTYvs00hK9mFnE0kJhbysy0ye+acQyH
         lBfvT8Ms4Gim0xPTNlGM934dRhHDWDapWVhkuwf2MbimT+dXn8YiclvelHIsPdyXLoPg
         oHd/NWUnZ5kfs78M0NO3gMbWS5g0nEEokq5SLQbgk8SWkRgceIEHPwB/zxHY9CjT54HC
         0KFD3/uUkrpE5T2mdBQEJvmTrJNRfFD8fu7kXVkjUzcsxM9s7sT0I+P4p79KPUlloqAk
         l/69ZsmSy0DEsDRQngzJzoJZKbviJHJDhW6yWkGLaEnTgK6Jj6mvTQwX/zVKL4k6IGhk
         tykw==
X-Gm-Message-State: AOJu0YwtbriU7xJLozlzVpsU71jIYuICfNye6EzbDzK4dMPzDDLArRps
	kuFFx9mFRgm9MmXfyXhIkyV+NN0YnBplMxQCGkD+IWyDICRcuN16gRT5++K+GpLs4T0Z7ubSkrx
	baQj2FXQlVcDD2zQHjG9l37yp4Mk+X+s=
X-Gm-Gg: AY/fxX4V0e0GtftJ0rHx74o/Ha/0bcoWF+Og8P1PNWXzla/nQgpNZz8zZPHycSD2Yld
	3ZXexg1QWGQLbFsNajXlKV50oQGyNul1G59d9HN8iOO7lSwCvzPkP67Q7pjo84nCzF81c+zBQ/q
	FADGMBbFOkQGrw6WnD4jxX8hEYOxNy3hysp5s+xdapMbAZrUcwxzAlZ7JXL1Qlre3JHTN6LrJ6m
	jS8cQCDoyGZCZ2oJ9n/rMuxzzLi3clHnIQpdfmu600jmgPElDyD3Rwr85jDOLckVkaBWik=
X-Google-Smtp-Source: AGHT+IGDxLR7Z03xV3XbEXKkFDRlCfk/m3k4fSRe5IvkmWIbomYdGm1s3a5gug/3SMMWc8tWJUxPNceY4vdDTLUDSpQ=
X-Received: by 2002:a05:6214:acb:b0:88a:2d2c:3b4 with SMTP id
 6a1803df08f44-88c52cec520mr545716466d6.29.1767029503921; Mon, 29 Dec 2025
 09:31:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251230-fix-use-after-free-gfs2-v1-1-ef0e46db6ec9@gmail.com> <1c3ede9c-3dc8-4ad4-9068-4e8747305856@web.de>
In-Reply-To: <1c3ede9c-3dc8-4ad4-9068-4e8747305856@web.de>
From: Ryota Sakamoto <sakamo.ryota@gmail.com>
Date: Tue, 30 Dec 2025 02:31:32 +0900
X-Gm-Features: AQt7F2pbCId_uS0ILL_uCPZpwjAY6zlh9s_alBDWmFy8aNpk1UeY1OWbNgmFXwg
Message-ID: <CAHMDPKVyKBiiDN+SDv7D41Apgmw8_tdVPM388vnYb4NPkXapPg@mail.gmail.com>
Subject: Re: [PATCH] gfs2: Fix use-after-free in gfs2_fill_super
To: Markus Elfring <Markus.Elfring@web.de>
Cc: gfs2@lists.linux.dev, =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <agruenba@redhat.com>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	syzbot+4cb0d0336db6bc6930e9@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 30, 2025 at 2:25=E2=80=AFAM Markus Elfring <Markus.Elfring@web.=
de> wrote:
> See also once more:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/process/submitting-patches.rst?h=3Dv6.19-rc3#n94

Thank you for pointing this out. I will fix the commit message by v2.

Regards,
