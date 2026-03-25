Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5970DEEBA
	for <gfs2@lists.linux.dev>; Wed, 25 Mar 2026 00:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774397231; cv=pass; b=twaENsSXNSNiND8wuUCGU7vxjTMLsW8aIFqrSd0mYVBkpoewhomlH3o51S8+yNC9QFSHGk17A48z86nOgaYZ7C5QErVSNqxVQlQOSfwAuxttHA2uPGlF7Uwnr7AUf/xK0D5FD8p6dsETgOU+5f87hMV9qA+WV/hJFBWLt26u0X0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774397231; c=relaxed/simple;
	bh=YHenlH/IT6rhwEHQUYK+jKLgrn/hE28KeTYZ/tmgass=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JJSSloBsn3o35B6tE3hd97vSNm6o0ybgvnQfLrzHr7IYDlNPxJWimew9s+xUUuqO40mQwpFLU5jx4xLRPqQ3cBRkVEqEEf7ucdzfUh6yEMEmACLA1nCVKrcCIkQyaE+5awc0UPEaoCb2XK/A70neZUrpJyxb/bcckwbxR+m/oxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rDmqTRdX; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rDmqTRdX"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-79ac94fc3ffso13229777b3.2
        for <gfs2@lists.linux.dev>; Tue, 24 Mar 2026 17:07:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774397229; cv=none;
        d=google.com; s=arc-20240605;
        b=RXMx9RyU/LYWXQbChPQVt3PVfS2z8VSnApCAw9SjRGnb/IRakM1NG7Bh5U1U3REGVy
         Lyrm5QqSk7NMZjJ+IrmeVQrf978ctmbgGzStluJAK6yDCGQpJT5U5S3HQ/bM5tQvPVpV
         wjpDgZ9TgyfSHqBbITVRkIb6nmn4ySl+cYQvDHFb0rldV/dDN2EsqvY3y4g9V0UdCnfR
         z/NNByXeFc+0KfHJ1LBVXw4Hs509MU+VFrRi4x/UB3d+f9weBgmV/KYigQD6oxOzTt/7
         CJhRVb9On6wGYmoLevirBy/wNpr+b2d7nlE5CVY0e3UC6ogkENnAaKvI0x3QegxiJ9F+
         9IwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AGyQjvLu1Ql7Zeq/StLjHb2ndTrdv+mf7PXD7sxxReA=;
        fh=TtaNTj9B+/s2FBvsz4rfb53eFl8HrlqGPIE7fR08LRs=;
        b=Xs84Z7M/0qECSLKTj5anZVfoEihFS2hFNiE0rOI4waE6vurUlOZEbCrDWKxIi1w9wb
         AXe6DUSlcrwBg8c+TAbH/xqC3LzHFqh0RY9A85mU1rVHrBYXnjjVUcfFthGKXgCqobuY
         CfrzPNw1aE+K29ZKfpc1zojejFSRKx9XO8+BoKvmTHrMeCfTPgwQF6ER7u+G+BJFt0eV
         3IvljW2+8/DYyQYW2TARlN9ClFGY0LiFfw3NkmrY8wJ1RWXBjT9IMmbP0VeUkB+aFhtk
         DxUyD/91EeAzSbUaA8u8ZDkwx4yAJbrHRQ3Cf/ot7ebF+KDqufAyaXxSdAF/OUq5hWTr
         h7Tg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774397229; x=1775002029; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AGyQjvLu1Ql7Zeq/StLjHb2ndTrdv+mf7PXD7sxxReA=;
        b=rDmqTRdXJd9GtAY1uv9eaEh51kSvmIUxhp4pmPaFHhu9/qURpVK9Q7F9p2yySgr5Zv
         NcZTNi7ob+vgBUg1G+oEOBkCjobvlJwSU4mKDlEagSVK7YGRQgbH2mAO3HsxDw7xqcLm
         3//qk3OX5xNKsBPmwU9haPdakN4hx0ppJmFo/lEtPORxt24LOXv5XWvXi7k7677VmwsT
         Kmn4eyBXimDW/DKA7hvX+uZI8DN8mOL6/2aK9CmKQyKdjEvvqlGTrN8e6olTcY4m/s0T
         0OEOvzG9EBL3ynFwp2pVzrvntmyoQQsssHWQUU5mk3uC+uRr8xBPK4SqqcGAyDLUWDSS
         zECg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774397229; x=1775002029;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AGyQjvLu1Ql7Zeq/StLjHb2ndTrdv+mf7PXD7sxxReA=;
        b=tS358F3Kq0DlZLdDz/ZiITVt2mqenjGmKyF1uEiyIMeBZLWeMAXxepwtF/wQDke85q
         3UUbC5/zz0zxGCT1wWtgfqqGCk6MjMc/xakXEqqz6yHvt2z6JZTBaq3XsiwZnGyef7ZS
         PxvDy8ICoaueaHmkEAA1pMd6Q8/YqdsbI0y7eM2LmI4HwEmu3pwhYlonHOd01juNAEM0
         sgLarL3BjEpuswgN6f9xHVNGgydvV9czWOMS88OHlS9A0sz3O5ZNw5PMkfOwzDTgkd7m
         7cM5dQVMlaZxeFa5jAa1UlKQ/jXhOlXKZoAPsMHFSlS64iVYSiAti63CW7Q3625aAu+c
         gUPg==
X-Forwarded-Encrypted: i=1; AJvYcCU1A9EqU9OFEZ22Ei3yl56yUgAPnu/cvoCEo83aNHQ3NXZLyRvrIbtH8sUBg8r09FtOzRxb@lists.linux.dev
X-Gm-Message-State: AOJu0YzR/+gXNM8TC4hOABlgtooabwktCV5XbJrmv340Td8oAfZoHU21
	vb9IfUk2I+jw8EgarLBJkKXBqevsxfq8C9y0XhI++BEYXMRtBtvGI8qlEtvGfPWmL6pVmh33yRt
	ejKKqVpyA5pRZMfVRjYe8TaqnbHFtPqo=
X-Gm-Gg: ATEYQzz/OGGEop1bCIdSKWuoYlJcffLIfqXD7KVqeVMQj1ToIx5/A+e3mHn5stSsLI3
	9wO1edmz6SsYAMXrnKRQRvOKzjLeimpvLo7FmUni2Vjm16SBB/LibofuUG0nOO7c7qSTAV+6iSf
	ve3w1Rll4T/vzVHpdLPB9FzuPf5onj9tggsFaZtJ7L6HKIH0OOUv0YydmLKExwHqPPHg9bzBd20
	fYWnrzVdBL/2BXlhBO8fJWXwWAa9MEsz5GnFx5CRumYPVMHW0cVSyNTyMp9tJV/5GRV2kk5yOJu
	j16YLsshNsDxpxUgGeHqUWZFyvLL5Ky+p3widvEIFMN+eczUb1Oi+wwk62qR/Nfer4oEmAKH
X-Received: by 2002:a05:690c:6b12:b0:79a:616d:b321 with SMTP id
 00721157ae682-79acf2e9a29mr17117507b3.8.1774397229344; Tue, 24 Mar 2026
 17:07:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260324033959.1456418-1-kartikey406@gmail.com> <acKjtaMVQS_d0Esi@casper.infradead.org>
In-Reply-To: <acKjtaMVQS_d0Esi@casper.infradead.org>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Wed, 25 Mar 2026 05:36:57 +0530
X-Gm-Features: AaiRm51mVEfXYaEL5jCAJDFaXc9o52XhflK0Sti2Z8Qrap72tbCiVVPYjMd77Yw
Message-ID: <CADhLXY5fxo_fOUTZv_DoHn3FJr6dFkKhRopzCLQYCKEjat71Zw@mail.gmail.com>
Subject: Re: [PATCH] gfs2: fix hung task in gfs2_jhead_process_page
To: Matthew Wilcox <willy@infradead.org>
Cc: agruenba@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzbot+9013411dc43f3582823a@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 8:16=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> I have my doubts that this is the right fix.  If you look at the entire
> function, it assumes that the folio was already created and added to
> the page cache.  The error should surely be detected earlier, not by
> this function.
>

Hi Mathew,

Thank you for the review. After further analysis, we found that the
bug is triggered by a malicious/corrupted GFS2 filesystem image
whose journal extent list contains extents with gaps between them:

  extent 1: lblock=3D0,   dblock=3D1000, blocks=3D2
  extent 2: lblock=3D100, dblock=3D2000, blocks=3D2

gfs2_find_jhead() only grabs pages for blocks it visits:

  extent 1: filemap_grab_folio(page 0) -> success
  extent 2: filemap_grab_folio(page 12) -> success

Pages 1-11 are never grabbed. But the cleanup loop at out: advances
blocks_read sequentially through ALL page indices including the gaps:

  while (blocks_read < block=3D101):
    blocks_read=3D0  -> process page 0  =E2=9C=93 grabbed
    blocks_read=3D8  -> process page 1  =E2=9C=97 NEVER grabbed
                      filemap_get_folio() -> ERR_PTR(-ENOENT)
                      folio_wait_locked(ERR_PTR) -> HANG FOREVER

We considered fixing this by tracking blocks_grabbed in
gfs2_find_jhead() and limiting the cleanup loop to only process
pages that were actually grabbed:

  while (blocks_read < blocks_grabbed) { ... }

However this does not work because blocks_read advances
page-by-page sequentially. Even if we track the last successfully
grabbed block, the cleanup loop will still walk through page indices
that fall in the gaps between extents and were never grabbed.

I believe the correct fix is to handle ERR_PTR in
gfs2_jhead_process_page(), since that is the only place that can
distinguish between a page that was grabbed but not yet read versus
a page that was never grabbed at all due to gaps between extents.
But I may be missing something =E2=80=94 could you suggest a better
approach?

Thank you for your guidance.

Deepanshu
