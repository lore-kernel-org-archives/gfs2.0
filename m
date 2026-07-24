Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126C62931F9
	for <gfs2@lists.linux.dev>; Fri, 24 Jul 2026 16:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784909463; cv=none; b=q9dOjVZ7fljxHFpg6wYA0fMaljNj7ij7WUQQXRQrz1fdGJgZFNPaJLSXd0AeQcfku9zhmGhlfagjJktqb5QEqK4bfynW5reurx1XQkklP7D1/8aJyphOFT4ZnIswL6GBsgU5svC7IMtr9vD9p2dALS+v/LgQdiKVWK+zz4awtxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784909463; c=relaxed/simple;
	bh=NlW+F/nuqDnCLeWoqSNVhBg5HnvalQ1J2+NfildmlI0=;
	h=Message-ID:From:To:Cc:Subject:Date; b=PFwMPb+Iq3XWBJWWwOphCaXrwC6/jo3sg3W+XEQ8oPaD8ReTQyAhfH8kMqnK2tffgbzeT0cczsYcZIOGGZ5P2ovfVy6p4Q7AzWeSvjaD/d5X09zi9+88MgB8zDLwqK/lPXiF2jfMldO7OrFi2FfnKc4TuqQFJd+dbQ9fxJfMgcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HXIDn+QB; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HXIDn+QB"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-49557167508so6246195e9.1
        for <gfs2@lists.linux.dev>; Fri, 24 Jul 2026 09:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784909460; x=1785514260; darn=lists.linux.dev;
        h=date:subject:cc:to:from:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZFt7lvmec9ZHmQrixKXCVjhocrLUzFfyf0VlpAqvzNM=;
        b=HXIDn+QBSfYh5iVTT/IVxNxwzNbyW0eyHpD6/yJQ66ZDkwyj7g4OMYPwOV01s+yvea
         vW1JB5WZYtAjJpCCoITy1QPvURlg1qyBYhNeKRRIUYQ0GwvqebFaffNPOYJWiIjd3pRv
         MqdyqJOF1VndwaAJPEWNKGrWtAcg2E1yX/gWfWm3ulGalRMXjeyrKKVlVtrCu58SUTm6
         I+KS9ZzZ/APfxW/NhkCBfnq7jQfVLXeIgqgLxUJb2orTFg9Xlg4ghna47I4luuG4RR7W
         Xnl7LujV+AZztFIS+lzxWjVDrpUW8IOyCYiLEYW1fQ/9VTb+KKjr0Dm1nXfpI4OQXRRM
         Qcew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784909460; x=1785514260;
        h=date:subject:cc:to:from:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZFt7lvmec9ZHmQrixKXCVjhocrLUzFfyf0VlpAqvzNM=;
        b=SUJ/VCxX542kznzABmdMXiFG4jUwhkQwZae8eUBbwLWp+Zv3PVOdhUNNRqj1DAb0rm
         8UyiwxSo5zRE4nQKz8usGunbK3ooF0BPwLGOoBsQ/uKZ0OHUYC6Ch4FKg+5Btxj8Bb5H
         BsRESMjoyG/Ukzpt2EpljHpQeW3isFtxcYi+fMZjB7ZPKZjFwNqlUVIvmr0DEmhFzB7a
         YLOQP3eYa7R4N3XZTFGqSlSN4IOKi7TZCl+9laFyyBXk7k2j+Z2pdH2gTUx/2W9U9rnd
         y0D2TsN+fJajTOcjZ0ts+IKDFamgmhjISay4uFZaMFSEQ/5uRmtGCKgzRRgaOpDV8tNc
         o20g==
X-Gm-Message-State: AOJu0YxLh0EfjoAThyBNlXNf+ZDmlb0PZHh1BTUONWKcEfD1ePBM+ouN
	mX7Fk9QS5wv5aEkV20xUTXHV/6kdfLyX1JTXjQLbVWSPGb0J2wHVLxb3l65APV0cm+8=
X-Gm-Gg: AR+sD13ioF6/nxEYWUHX/ahQMPaNJaoZrDmx0ePXOIY3AK1yTukov1BlbEpfwOAEB8k
	EwsM/JzQYk7K2a6OY38jfnoLuFQq70K8H9J+sFeKndQfiJbcP0AHrkaX0S+cQyBGynhPGXJ61t9
	0Z6MM0QqUnkJEaTewo6shdSK1Fiqy9uR0r4PTyO58HD/TrIlfWBs6JHQYlrZxq//qBfIvCMZxNR
	WJm0+XjUfxm/mxvsYlFu56hHbjK+Ukyl75Ir8oFKAPsDDUJwMHpNcqu1fkt405duUNp8TGpRJ1R
	UMFjdtpWkRbhWHidyimFt97utG0CY6Ovk+knPuLhZEC5f4QEDvYFBgW4jAkslApfUqxgVOOioFW
	JtE9ESd6/tymSTQs3SwmaXfjPp9x5jJthvDXZO4fndMw5A9XXmCa3R4R4sXIywk137JS98TpUyP
	7HCzV+J/q5tSyc0uidDBTEd1o+
X-Received: by 2002:a05:600c:3143:b0:495:67b8:d97e with SMTP id 5b1f17b1804b1-49573d0cd6dmr103760655e9.30.1784909460026;
        Fri, 24 Jul 2026 09:11:00 -0700 (PDT)
Received: from respuesta_gfs2.eml ([171.22.87.132])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496b48627cfsm1420675e9.8.2026.07.24.09.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 09:10:59 -0700 (PDT)
Message-ID: <6a638e93.80d8f3ad.1bf45d.1dc8@mx.google.com>
From: Adrian Garcia Casado <adriangarciacasado42@gmail.com>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gfs2: add missing __rcu annotation to i_gl in incore.h
Date: Fri, 24 Jul 2026 18:08:00 +0200
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>

Hi Andreas,

Thanks for applying the patch!

For the record, I have successfully boot-tested the patched v7.2-rc4+
kernel on bare-metal x86_64 (Debian 13 native on an ASUS Vivobook).

To stress-test the kernel stability under load, I ran some heavy workloads:
- A standalone loopback mount of GFS2 (using lock_nolock) with I/O stress
  tests (100+ concurrent files).
- A full multi-threaded compilation of the PCSX2 emulator (using CMake
  and Ninja) with all CPU cores sustained at 100% load.

The system behaved completely stable with no deadlocks, hangs, or OOM.

Tested-by: Adrian Garcia Casado <adriangarciacasado42@gmail.com>

Best regards,
Adrian

