Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9210155C87
	for <gfs2@lists.linux.dev>; Fri,  2 Jan 2026 08:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767343216; cv=none; b=oiwxgitLBj2rvlnLuA0sP/QshHFMgwiWuMXlujdKbxslXz9YyGhLmB8/izGw3MAV+BJWnXsSLNMxNTttshZuSusXsMJkAX71nwVCOZl90VRBZTl2xxALVgnMLy42p56jgydp+YtzXxfZDO1sE1YscYiP8bz5xoyQjm1jqBj8cgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767343216; c=relaxed/simple;
	bh=olNTr7I4hkgrpvZVCoLMbgXt9KH+lEPgDgfgKBefTsw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gae6kQEV3cbMm9aGmykYambo9hSXYwz2cOfxXj8rxmeItn1YksUZrkd141H3hz/Qt0fGYnzjwl2DLUdxZkz57gM3D1MpOoAQvT2l5YshDu7a9/OrTyOpM7mVrKSB8KOia/9ygFI0xFvSVeHusb7OBqeXb8DRO9P63JuUAqedg24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SkAXTJW3; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SkAXTJW3"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-88888c41a13so157710216d6.3
        for <gfs2@lists.linux.dev>; Fri, 02 Jan 2026 00:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767343214; x=1767948014; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=olNTr7I4hkgrpvZVCoLMbgXt9KH+lEPgDgfgKBefTsw=;
        b=SkAXTJW32COvraGvJG0u+1II1LWNxttB11qoFcOFGFJZya5M6kt37rti4faaujLNyq
         wvUwiRSgf2/bs8Gae6Yz6HWQVOWNwAogv8E7pQvvrb8KwDastWe+mXOZjR993w4uC2tY
         7wcqRH7v67MARtXmuZXWSbc0lYjNZA8taxjGVMm9KE1esJhUe5L2JLLhSZKwBU0OUyjS
         IIPKCCx+y/nlglDYqRwJ8ZYiMrSnzEqjSV8UQh+HuOX6en58F3p39AIhZFYq/G+vlCwB
         3AhQJFSLcDO/jL8IKZ4uh7/PpYZwRu6vEL0EtMMAei6aZELCdWAH8XFZTMYLvfny/7BG
         EHDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767343214; x=1767948014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=olNTr7I4hkgrpvZVCoLMbgXt9KH+lEPgDgfgKBefTsw=;
        b=cGEGXaZL6AFaMdQ5xAPjq2Frdiqdhhuue7uFPFuB0SO2iRo18OyOSvZXEOqB+hysmG
         6jTI9STUsXCsY6AS5aR/GGdWFp0wB/bJ/5gvxbb81fPccVWeTBlJ8V5HqSbNq2gEn2pa
         8UUdyvSLgkJiHQAwKalVqGB5cFvAXNTdDpp+v4QnLNlhXy6iHF7TLHBv7I2GS7c3wGJW
         7ZS7iShXqTdqQYjYGOYhP5QTWPfTZZronxaXxwwAktTBA6GhXuE/aRbMXf08KdSgQuEk
         WFpvMk9MVO7bfvwQTn7gpkBPZb0PTczp2OG4063XPU92tfmnOtu5t0EvPF5NtlatR41R
         +VqA==
X-Forwarded-Encrypted: i=1; AJvYcCXXnto3p16meAmOMVzY1UpqRPeLc5uewYCGlw1lBuRmjOHBYUpVMOGxL00paaHt0Eb952SY@lists.linux.dev
X-Gm-Message-State: AOJu0YxKn8qudXs2XqsXcTkQHgB9ejPF8P7tQNbqvNUUR9W/6wiqQe7Y
	7ik8dFBaywRP6HGvh0QM1Id/K4QZRT1sxxdO98+GdGjnA14pi/Ryoe8k6UOgSzT8a1ki+TM9WI4
	o2VHQSx/iaxWUquSaPPRnNoJa7+HgF20=
X-Gm-Gg: AY/fxX6GvOJ76TGVEE3+4zxi4WRW53CEOawX2aXzyyeGFjAcdEx4dzEsm8Gfr6k+2id
	4RkDCj341x7kY7GUkxRs57ZrzabC1l5m5eCumbeTeLAxKcSyzQt5x6uyVIPaz3HyNz/EOuxAL8U
	Rz6DS6gy69nkUcI5SDCz2sx7mNBcZePwmYl3WYXFPmYS0qlnXEeqJ2I5xkjGPVAlT9wy1HTEwpD
	gl9C9SY6GqMtFNwbbDmCRV6yR/cFfZxfgfcxYHvGNnYgTWPtYb9iH4TYgsunE9TN0UUpKk=
X-Google-Smtp-Source: AGHT+IGC6CuYzGpscftFjWf5+gmMzki6w7/Iy7X2Zql16cmak2tCVDp7at2bcPo1WOtb39jHX+LdpWUm1mnZBbUac4Q=
X-Received: by 2002:a05:6214:23c6:b0:88a:261f:6af4 with SMTP id
 6a1803df08f44-88d8404df6amr636211446d6.58.1767343213797; Fri, 02 Jan 2026
 00:40:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251230-fix-use-after-free-gfs2-v2-1-7b2760be547c@gmail.com> <57c723e9-d38a-47fe-9737-5b472916f3d2@web.de>
In-Reply-To: <57c723e9-d38a-47fe-9737-5b472916f3d2@web.de>
From: Ryota Sakamoto <sakamo.ryota@gmail.com>
Date: Fri, 2 Jan 2026 17:40:02 +0900
X-Gm-Features: AQt7F2r0MrGfokVOhyqLOTiI52EVobi3HtPfSH9ESALiCshy7ly_MguWuQFVcmY
Message-ID: <CAHMDPKUZgJ80k+u_e45FGSPz5N4sjBfX0AtWu3Oqr79wMSx3MA@mail.gmail.com>
Subject: Re: [v2] gfs2: Fix use-after-free in gfs2_fill_super()
To: Markus Elfring <Markus.Elfring@web.de>
Cc: =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <agruenba@redhat.com>, 
	gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzbot+4cb0d0336db6bc6930e9@syzkaller.appspotmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 30, 2025 at 4:46=E2=80=AFPM Markus Elfring <Markus.Elfring@web.=
de> wrote:
> Is there a need to indicate a role for the mentioned identifier?

Yes, "fail_threads" is a goto label. And including "label" in the message
explicitly is precise.

> Do you propose to use another label here?

Yes, I am proposing a new label "fail_threads".
I chose this name to maintain consistency with the existing error labels
in this function (e.g., fail_per_node, fail_inodes).

If a v3 is required for other reasons, I will update the commit message
to include "label".

Regards,
