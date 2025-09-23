Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AD47464
	for <gfs2@lists.linux.dev>; Tue, 23 Sep 2025 19:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758655149; cv=none; b=Rkz1e7BwDwVF0CvkHjMiaULHPPvWo6MLX9jioi1M3vSBsgy/B0oWQQQYyHpBE8cGbFP8rCLJGC+y+1l7dYCzjTzRjowIQqVO+ilL9mqnjIdA2k1xmFneEoJYUdCHL5reEBVOWAi31mfrZ02CzmqxvjysS2OQvWrLBxkCJJBs5hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758655149; c=relaxed/simple;
	bh=j68iQkt8LYLdP0pm2TDkZXC3Z0j2EiGpwyDL1OR3bT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JWX5n3Wsx3uLzYiULQDOJUB7Ry97eZDYo/8uOmto/STWkCHY4YE948Th3T/JVxETzclLAH2cS3/MF39OoA9T3DqCVXHFuOw/xwkNsSUwL5R3uOx7+x+2CrxqojtDvANLqq1OFhJ3C4z/l1rFfFJI0oozSCsz9X2fxkVnxswgs/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ioQyJHaK; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ioQyJHaK"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3322e63602eso3210095a91.0
        for <gfs2@lists.linux.dev>; Tue, 23 Sep 2025 12:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758655147; x=1759259947; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kbcsb0sCYvY+w5FFqDnmrTgzyDe/+Ah4Gp2qKelA9Qo=;
        b=ioQyJHaKtWLb8gNmbnyIxIw4xE2/aBKfSb+vNUqE9XjFT1K61lLtfAukZpZ5ox/lox
         eNC9X4frMszko5IV792Nv2dzYK21X1Ow2XRs9dAUP/WdqoLtVAsvEThnhm4h4p7IRihN
         9njClIYuhN77vINFyEDLY0BzlZR+sRPZezF/M/5Q6Fmq/3P56BC7JxnDf2hKZLIQL1Z9
         O6N5lnBlRclnFsy7ESp63Cyp/1RKapp13MLbf5CWykYrHFpxsDMiWzEXRsZ5mzUy2z4v
         QwWUg1xIUffV7fg4l+0kNV207rW88ogHqkPLd2ZJ5qN/4K1e2d5JBpx1C9eIs0VSa5Dx
         80gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758655147; x=1759259947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kbcsb0sCYvY+w5FFqDnmrTgzyDe/+Ah4Gp2qKelA9Qo=;
        b=NnFxx7Oc2/eJlk7l+N2sBKIwjsVLeZx6JOLzeVIj9NiHl0uKA3wka3W2oxrBYLMpM2
         8rfRPjkDm4z0DX8mPt+I3Z/ygp4IQM1BqNHZ28jrwcSjnGmpo3DQlvQ5K3BCtren5YlB
         TBuaz3p1Bk+CR/LFPYFUQ65AFmSxnJf/NP4G2/NySRTRpPn29jnskzAEtvpvz9nTeJbH
         kxaLqvdB3qddZRVsebfl4YVcCc9o4i9v4jdonCr11XKshzYj0P5JzDmeNiKptbI4oB1I
         MA732QFdQhGNGdk71Y6aANVNulHrxJFxZDX2TUkyU6Sj5DNHodGZuOz2Zh8BOWN3ae74
         5hOw==
X-Forwarded-Encrypted: i=1; AJvYcCWMQsSPxt4HB0kOKBbWgNcaMQlif74/ADrwsjpN5KYqz+J+k4J0AJ6av/7TrPOt7RwX1X7m@lists.linux.dev
X-Gm-Message-State: AOJu0Yze0TEV+HnAO3Tq6d4g6WKaq2KAMmTy+Hvnpu3Ydh8jikwv92YV
	HObWb0Lin6ZdswZNMuZZy++FNDsfPFFQhJTGEHQYmnQ3uow056156h7D
X-Gm-Gg: ASbGnctFU3xzHM02UMqIZNkPzrYc6Eko9Anp8KcXgy0h5FsBa9hiPf/HcgfVJbn+iIO
	NN/RL+MjYWetnupOXXCGSn1t9/E3i7z17OCQom23Z7Cco6b8jv6R5ABozDytLATwP03sbLM89mP
	Nt0yNu/ofsOOu5lz7BbfEx7TH1yIpZZI7A1r/sxN0Clc/7uJaDt4g2iZrkOtzbUQgCJnJwJTrb0
	AjDPZkbGEwQpsPSM7Qlqb6RtBkdzI9v9FMF1oW6XSdw1gdKOImTF6H9t/UcVauq/MIrbHQ0CZX/
	ZJV7ndwnrVl0O29FRvp0mheYewXWQ5Hso8hSCa+lk6Uca8zJn+4TqVBHEE+IMM0bC4qRGSWQ1YD
	0tlTOKJx/tJWYXatH1qkI54PFdv1Z
X-Google-Smtp-Source: AGHT+IGqTmIgP7qTZknYhTvVrzzHpibNAC682mdtjrUwFehLQmjekC62tWj/TgAncaBjZCC9EqgTGg==
X-Received: by 2002:a17:90b:5109:b0:32e:a54a:be4a with SMTP id 98e67ed59e1d1-332a9515ca4mr4405139a91.2.1758655146795;
        Tue, 23 Sep 2025 12:19:06 -0700 (PDT)
Received: from itsmeut.. ([103.215.237.82])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-330607f0ddesm16995681a91.20.2025.09.23.12.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 12:19:06 -0700 (PDT)
From: Utkarsh Singh <utkarsh.singh.em@gmail.com>
To: agruenba@redhat.com
Cc: david.hunter.linux@gmail.com,
	gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	rpeterso@redhat.com,
	skhan@linuxfoundation.org,
	utkarsh.singh.em@gmail.com
Subject: Re: [PATCH v2] gfs2/sysfs: Replace sprintf/snprintf with sysfs_emit()
Date: Wed, 24 Sep 2025 00:48:57 +0530
Message-ID: <20250923191900.77568-1-utkarsh.singh.em@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAHc6FU5C3n2wyO91gcDVLGr643d1Y5e4xPmM1d9rw18A=fod9g@mail.gmail.com>
References: <CAHc6FU5C3n2wyO91gcDVLGr643d1Y5e4xPmM1d9rw18A=fod9g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

>> Documentation/filesystems/sysfs.rst mentions that show() should only
>> use sysfs_emit() or sysfs_emit_at() when formatting values returned
>> to user space. This patch updates the GFS2 sysfs interface accordingly.
>>
>> It replaces uses of sprintf() and snprintf() in all *_show() functions
>> with sysfs_emit() to align with current kernel sysfs API best practices.
>
>I've applied that part. I'm not pushing this into the upcoming merge
>window anymore, though.
>
Am I correct in understanding that these changes have already been applied?
If so, could you please advise where I might track them to avoid any 
redundant work in the future?
>> It also updates the GFS2_SHOW_UINT macro to use sysfs_emit() instead
>> of snprintf().
>
>Huh, what's that?
>
Sorry for the confusion — that was meant to refer to the `TUNE_ATTR_2`
macro in fs/gfs2/sys.c, which defines the *_show functions for tuning
parameters.

Thanks,
Utkarsh 
