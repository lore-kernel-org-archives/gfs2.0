Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627AE2773DE
	for <gfs2@lists.linux.dev>; Fri, 24 Jul 2026 16:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784911615; cv=none; b=dr7P2aMtoQNSlYHmt2RizkjSzt7hRiKW7N64dgHbAOBQYI7tQqryXC6RqDAOXp2eloch0R4/Pss6rt59l0IX2AJ6q5xDiJA9Sqct5/eUFmwHD/+QvtwSA74iph2EQ8e3Ex7Qf6opQsqF0wFtjHqL8fj6LK6jWL73KhYtikWQKSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784911615; c=relaxed/simple;
	bh=NlW+F/nuqDnCLeWoqSNVhBg5HnvalQ1J2+NfildmlI0=;
	h=Message-ID:From:To:Cc:Subject:Date; b=qZPmDUJ2msu8FVa40pYNRVWnGbB1qc/1VS1yG+xSobqpORAaNeFWR5/wka4PzqdQKNHdCc9sQrYo84oxAXlJhxdJljD+0Jt2oK7WOyd/4NSG6m6tojkrb1rWBpWKD1a5F5RDQvw1kWbmAfw1w2QFvsP4y4qyTrJiKVHir8Is6+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TwQqSpCB; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TwQqSpCB"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4954aff6088so5909405e9.3
        for <gfs2@lists.linux.dev>; Fri, 24 Jul 2026 09:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784911613; x=1785516413; darn=lists.linux.dev;
        h=date:subject:cc:to:from:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZFt7lvmec9ZHmQrixKXCVjhocrLUzFfyf0VlpAqvzNM=;
        b=TwQqSpCB+nsgbQzdYxZkOCT4BjOVjRnrwR3QDe+1ZwaODJWNtSya9RjZhZTnK0Z9/N
         ha+nTQLw7H5uQuUCnK7jR/1NvkwSpD0McJYNtZNfnC7BrZ12sy8JohPKFiqJT8rmhWUH
         dXlRIenR50kpsAzQ44rOolFN31lArnkllobHIs4QEoU8lW2pM8KbNeMbwOhlBCVXWjYN
         evtK3m67ANXYDaeeq9BYLo4rAXeM7JzvL23bg1ewEpIStSGxjh0FuJuKeYpOITouCdR6
         a1BVSuln2Vf1IhmVs4HSTkLX9KRMYdNYvQv6QQeF0UCu8fsEncXsLVlag1BzwxA1kDJw
         uaAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784911613; x=1785516413;
        h=date:subject:cc:to:from:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZFt7lvmec9ZHmQrixKXCVjhocrLUzFfyf0VlpAqvzNM=;
        b=UCh5UQwgAIAxfwdLZTUMOTIn2LoGKKeyomsNHt1TDS/Msi8ZbHMuzTNyac7p/AIPRs
         6cgiHOKqs/DBadHsOKwRfu6JMxl/UuE9Og426M1upQwcQJe6WQ/+6BRyEv9PdNr8hfMD
         wqYOKM3pCpuup2pT5KPSwstPywFGinjL8yLqc0pUKoSKcHTmCEXPkSicq56sxLWzjU8s
         4au2pPsxKA4vZQzZFOshHGsMP1OjpaEJNW9le/g8hahi2cEgWi1f9r2JbsioyvATimeJ
         C3LOcwoUlDe5II9t2n23DxVjpMWd/zYCeWagzN10XkuUo/cF7YrXdycG1jtYnEc05Qz0
         PLcA==
X-Gm-Message-State: AOJu0YwDIzOSMHzjboBcCGAzddAoZbmdwG2WEebr9vBSCSeeOheUASSD
	QKZzjLKayBiRGu3BtH/YQRkdkSMe9VIxKwm/gaTAq45OGvpTZ8Vv6FrLnAxGL9bmh7M=
X-Gm-Gg: AR+sD13iswO147mTf0R8MKP10j4HWpkpMLmo9iXp+fIzy+SriS6AuPhxbD43dARGf+l
	Ycl7QMOj8VxF5JJin+KaQsIJ6+Lt3DnMQxUw2dlYAaFfv+tnv8WqD5LdP3M0J8/5KlA9aP8Vmm3
	Twl81RvRk5EQZ6aZNgG0s+DEQH11/1kAZwFhIBcx9YD3uv6h/e26v/3aiq3H4M6uMHW/Km/AKKj
	AAdXLjEHS/fV58htS5VeTcNlK71Z/U0P9WBGZk74C25V/O5ZCtV1zs2NO599GTcHO+QKfdyQbF8
	EbUGZxpmcc75oBfQo5C+tmVT5PoqmtrzJ3dwT1KKP3GCVY3RP6jN6ALizE70/0frE3RCF0YI5Sc
	fgx55hpPbI9KYHFpIYSV4CgWueNGKSup3LKvmGhHq8iSBJnhY5SpgbLGo1+lo2XRZsvVRG3EH4Q
	ROYf1tHZ2DGBK3DnjEUwfu2FBx
X-Received: by 2002:a05:600c:6b6a:b0:495:3f0f:d515 with SMTP id 5b1f17b1804b1-49573cf4d25mr69027685e9.36.1784911612402;
        Fri, 24 Jul 2026 09:46:52 -0700 (PDT)
Received: from respuesta_gfs2.eml ([171.22.87.132])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957f9b8b67sm47880195e9.4.2026.07.24.09.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 09:46:51 -0700 (PDT)
Message-ID: <6a6396fb.1ec2db65.334318.e4b9@mx.google.com>
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

