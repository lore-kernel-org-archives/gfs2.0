Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5EE17AA2
	for <gfs2@lists.linux.dev>; Fri, 25 Aug 2023 16:34:53 +0000 (UTC)
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2bcc187e0b5so16864411fa.1
        for <gfs2@lists.linux.dev>; Fri, 25 Aug 2023 09:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=contractor.linuxfoundation.org; s=google; t=1692981291; x=1693586091;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/Onvocl7z9tTV39RCCW1Yld6Uw1oloVdWrBn7K39z6I=;
        b=WSTQM1azEcPba+Ho6pVTeblCtOYjeJQaz3/+77RIKfTZylkUcAzSz1aXTjA0yc0Ucj
         PJGQC6zx2DLU/1foZUOlQ/Znk7zT3wC1uKPtBWMLHVpC8xaQyjkIM14LnEvIYhFsN5qg
         7JtWyxu/FYBMA4/8r177g7S6K1/YFquT+iDMBk8kuR5tByeLHlDQSL0zdbBAMP7FtzZV
         /Cj8Q5IXpyrr2JU402ACmjlMtVpqmbcmvlwUcI3Yuvqv8873QiH13jed0LweSxHKLCIs
         57HK/6izMZ3+4w7HijbX1cjE/TAFhFMFoTgknJrR6pLGmBc1rRJoe/0iyEpiysSSohLz
         BBIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692981291; x=1693586091;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/Onvocl7z9tTV39RCCW1Yld6Uw1oloVdWrBn7K39z6I=;
        b=cgawWEHrdi/2gAu6jYwRGqERM3b1d2kTwaWRrUyl/yt7Xv3JAEvp9xUy9+HXZws0sR
         BXUa96/kqJ39Od2qN1GiwCZE1yPPUYYarEbQMFEah3BJrTQ9G1aNHU0gRcrtxoXuD0i2
         Eub/BwX2bl2AXirML2qpoIUgSJ4QtH7h+ZVV9+k8MNk27uqckVEKXvKw2a1+D9oKEZD6
         CQ8/ih1ZpfAHCyl0zlUSi+1Ghk/I6XcE6KGQ1QfgdDSiCQKjym9gnqhxRQ/zVqrpzhZS
         UBuypANG86xbispj9RMGzmcyJAcV/qTLfuWYAdnoL3J07oa4rNp4nlFH7kypakt4A5y5
         hwhQ==
X-Gm-Message-State: AOJu0YwZ+ldZr+eV/YVsSohjVBuSJecY1GgCKQ41PzN3g4HRvpJmpqdL
	2Lq9MYFKOmVtKw9Swi5hI5cvXL7NhVGmQ5q7iju+o43/9JK1rg5pb2s=
X-Google-Smtp-Source: AGHT+IFoRer3e94u696HwaxD7VNbq0tEjgbSLSbmGC2+eFesY/HrwtIYQTnqZjDke+uT6RRfLqaNklnXpXZ58ICth+Y=
X-Received: by 2002:a2e:9f48:0:b0:2bc:e470:1405 with SMTP id
 v8-20020a2e9f48000000b002bce4701405mr4296948ljk.46.1692981291041; Fri, 25 Aug
 2023 09:34:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Shyam Kumar <skachukattu@contractor.linuxfoundation.org>
Date: Fri, 25 Aug 2023 22:04:40 +0530
Message-ID: <CAH=dH984Oycz9Wpjmv_FOKMULjWUsK+6YO_JaAcv1hnMFvz35g@mail.gmail.com>
Subject: Test delivery for gfs2
To: gfs2@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello:

 This is a test message to test successful delivery and start the
 archive for the list. Please ignore.

-- 
Regards
Shyam Kumar
The Linux Foundation Core Projects
