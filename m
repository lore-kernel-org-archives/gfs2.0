Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B6237144
	for <gfs2@lists.linux.dev>; Tue,  7 Nov 2023 20:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Iuur49Ae"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-53d9f001b35so10346239a12.2
        for <gfs2@lists.linux.dev>; Tue, 07 Nov 2023 12:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1699389054; x=1699993854; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Yw7CS/F9NhUtUI8gorhN6ZH3SNhxyTq9HRKbQWVFK2s=;
        b=Iuur49AeuvSH0pMggHjx/fPb6kO/qNASSyIPECVQ++uxP/fkumhLL8ODDQ/Ly/PtgT
         Ih8x6TJeNe5KRj+WgFY/Z3rt00qs1r3/mBi1Ik4vseJLLqAP4If/2J79RUAek1ge3puG
         iavSQ3LQIo29QQ7iDE01sGyAAUdVBylg36S64=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699389054; x=1699993854;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yw7CS/F9NhUtUI8gorhN6ZH3SNhxyTq9HRKbQWVFK2s=;
        b=bQI5iy9bBi75kuvHJOaK1fOISTxTKY9pyTYaj0IAkKsOjDbyMMI3xP4CX458Ii3Whw
         Itvl1wHRwajcYsybBu50wCZ7ocv8toWttahEWiZEjmO3fD0sixsHAAs7ORy9VeVFSvjj
         IUUCFw2oKGofLjQ79FZc6pCaIuTza21gUVTvhWulISfL3pgMMpv1soGa7nmw7Q0xgb+X
         jpOniuOQL05IzO4/LNLLUf1/mxPsOyKaaEPaunynYOBDF0+CbfXvKCscfogttE09j3bg
         Ik9OC3ztAf6Vqxs437hrXXl2s138h0M2cIHVnwqi/uHr403Y2Ud+lWOViE+KanJd2hcB
         +vvg==
X-Gm-Message-State: AOJu0YwVTa9oHQQs704Y7bTfBj7c/jUhawpUdRNPD6eziNxVEKUYu2bx
	iBSRJhl2kvnOzS8fAqY54clV/X8rnnuAaJ9W1rLd2w==
X-Google-Smtp-Source: AGHT+IHbuka6aevkWJCBix7bcdaIzUYrhL49wTlBJcJwdz+zfbnKKZQLID1MN/R+NchMb2peq9yF2A==
X-Received: by 2002:a05:6402:1290:b0:53f:6c6d:2e30 with SMTP id w16-20020a056402129000b0053f6c6d2e30mr27687005edv.2.1699389054089;
        Tue, 07 Nov 2023 12:30:54 -0800 (PST)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id b17-20020aa7d491000000b0053443c8fd90sm5693648edr.24.2023.11.07.12.30.53
        for <gfs2@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Nov 2023 12:30:53 -0800 (PST)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-9e213f198dfso211166566b.2
        for <gfs2@lists.linux.dev>; Tue, 07 Nov 2023 12:30:53 -0800 (PST)
X-Received: by 2002:a17:906:51ce:b0:9bd:a5a3:3328 with SMTP id
 v14-20020a17090651ce00b009bda5a33328mr15423134ejk.13.1699389053151; Tue, 07
 Nov 2023 12:30:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231107142154.613991-1-agruenba@redhat.com>
In-Reply-To: <20231107142154.613991-1-agruenba@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 7 Nov 2023 12:30:36 -0800
X-Gmail-Original-Message-ID: <CAHk-=wie7WsYHkEChV0hpcf7CRRJQw9-E8O8RxrFGKF6mEJ73g@mail.gmail.com>
Message-ID: <CAHk-=wie7WsYHkEChV0hpcf7CRRJQw9-E8O8RxrFGKF6mEJ73g@mail.gmail.com>
Subject: Re: [GIT PULL] gfs2 fixes
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 7 Nov 2023 at 06:22, Andreas Gruenbacher <agruenba@redhat.com> wrote:
>
> please consider pulling the following gfs2 fixes.

You are officially on my shit-list for

 (a) claiming it's fixes

 (b) apparently lying about that fact to make it appear that it's ok
that this wasn't in linux-next and was committed within the last few
days

about half of the commits in that pull request are very recent,
weren't in linux-next when the merge window started, and while a
couple of of them are fixes, most of them are just minor cleanups.

DON'T LIE ABOUT THINGS. It only annoys the hell out of me when I
notice that somebody was trying to pull wool over my eyes.

I've pulled this and I'll let it be (because I already merged other
stuff on top), but dammit, just be honest about what happened, don't
try to claim this is somehow "fixes" and thus ok to not have gone
through linux-next.

Or, better yet, get your ducks actually lined up before the merge window.

                        Linus
