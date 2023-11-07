Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A521F2A1A4
	for <gfs2@lists.linux.dev>; Tue,  7 Nov 2023 22:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RdC49szO"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-59e88a28b98so1787157b3.1
        for <gfs2@lists.linux.dev>; Tue, 07 Nov 2023 14:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699395526; x=1700000326; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QctA7Bq+rxWAwGydWIjR1fSKNRz9s8P13IzaEYf+J9E=;
        b=RdC49szOfLtneeDxA8sEBDwDPZn5bfGUDPuV48bgLybqk4yusWbS8YYR+GMjdum/BG
         lyf2FWJJ6V471nlPYpg/K2295InsBf4M0YHapf2Bqsa4+6zNy+9E2NmMXWEdOulZ+eNo
         pf/Yw2bbUOiNmoDVm5S/jUlzsQ7BYDe4y8BtBsc7ch9CcuWD4KaU/2krRXZDY9ttmQCo
         XPD6AN1Zk5reMR5LtcF+UjXf3JqmP5uFsyPjs7Oy2O823pfSWmbwK0D5Bgo0qbzNW+Ob
         s8TF8V73w1z+MBxqzWneIut64heFcOD8vc9WtG08bDZxXV0/WU1+WfXLygctMCf2EKH1
         Ur7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699395526; x=1700000326;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QctA7Bq+rxWAwGydWIjR1fSKNRz9s8P13IzaEYf+J9E=;
        b=eVkJuekPa8z13zzrUcxz8W0y3FxBeGLx1ItPSK2JJOhOoAcyE8hQwibLWeKkUqqkUt
         OXPC+K+eFsbHB1UaRGSJ/tT3HT3QdYPmZxlJqm/K9S/7LA5Ls6v1go30Ko1h6rAfc85X
         wdOyBnqYza/bTju5/WsJe2Nt9tMx/5jJV6TQSOBApmRdsOq8gFEDQQfmfTMzMJlZfk01
         IFqIl+01d6Yvx+o/P94CxMXLAq6IyzBJbwlpuIM2vB9c7x3kWGAULPf8ze/PI1l73l0v
         65zppfCR6I8DjU6JqdNVrIuiXLLZ8lJ8MDc9bJTjYMb6qw/R1cyxaqP+r/YMkRX5auEE
         P8nQ==
X-Gm-Message-State: AOJu0YwQ8TkeJAcfRs3+oXBSCvJ57Ywd74ey6Q0kWB2fwjkxGIgrO8e1
	O6rX8XRdsRIPk/rplQYT12YUdp/80t+sXUzENd8=
X-Google-Smtp-Source: AGHT+IHxqhdp2l6CSzq5JgZwwhFfA23JVB1iFBQyZytpmw4JO1z6E5AAwYnmRirD6Ryy0xiKGvJOfevQySew15int/s=
X-Received: by 2002:a0d:d4d7:0:b0:5a7:dad3:cd21 with SMTP id
 w206-20020a0dd4d7000000b005a7dad3cd21mr88953ywd.10.1699395526548; Tue, 07 Nov
 2023 14:18:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231107142154.613991-1-agruenba@redhat.com> <CAHk-=wie7WsYHkEChV0hpcf7CRRJQw9-E8O8RxrFGKF6mEJ73g@mail.gmail.com>
In-Reply-To: <CAHk-=wie7WsYHkEChV0hpcf7CRRJQw9-E8O8RxrFGKF6mEJ73g@mail.gmail.com>
From: =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date: Tue, 7 Nov 2023 23:18:33 +0100
Message-ID: <CAHpGcM+u=77p_k8dZ6gKu84wnkdvGYA4E6=MXqNw=ZY+ejjiaw@mail.gmail.com>
Subject: Re: [GIT PULL] gfs2 fixes
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andreas Gruenbacher <agruenba@redhat.com>, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Am Di., 7. Nov. 2023 um 21:31 Uhr schrieb Linus Torvalds
<torvalds@linux-foundation.org>:
> On Tue, 7 Nov 2023 at 06:22, Andreas Gruenbacher <agruenba@redhat.com> wrote:
> >
> > please consider pulling the following gfs2 fixes.
>
> You are officially on my shit-list for
>
>  (a) claiming it's fixes
>
>  (b) apparently lying about that fact to make it appear that it's ok
> that this wasn't in linux-next and was committed within the last few
> days
>
> about half of the commits in that pull request are very recent,
> weren't in linux-next when the merge window started, and while a
> couple of of them are fixes, most of them are just minor cleanups.
>
> DON'T LIE ABOUT THINGS. It only annoys the hell out of me when I
> notice that somebody was trying to pull wool over my eyes.

I apologize for referring to the entire set of commits as fixes when
it's really fixes and various other things. I've said so in the tag
description, but I realize now that that's not good enough. Lying
about what those commits are wasn't my intention though.

And I apologize for the last -minute changes. There is one commit that
removes a single line of dead code which could easily have waited. The
rest are fixes, but they should have been completed much sooner.
That's entirely my fault.

> I've pulled this and I'll let it be (because I already merged other
> stuff on top), but dammit, just be honest about what happened, don't
> try to claim this is somehow "fixes" and thus ok to not have gone
> through linux-next.
>
> Or, better yet, get your ducks actually lined up before the merge window.
>
>                         Linus

Thanks,
Andreas
