Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E064D19E990
	for <gfs2@lists.linux.dev>; Mon, 23 Sep 2024 17:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727113775; cv=none; b=cnt8HJfuevxPWBeNzbvPKddFyY5pbCULKT1CI/QudIbeGziwWr78X2j9ytvSxR47KnOrWg/yOpFGiMRkLSWpp260AkhNJdjJIZh5LcbCe9nWWvW0vjQ6Bc6yqEO9UQMhQYVc1Se1Sbc0i2vc+xWC6SrzMKPEwMnzy634chr1i5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727113775; c=relaxed/simple;
	bh=LCi5as8tr2ldxM530hte0aShriHsWKbt0neamqouoKc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a/HmgajuaSEg0Vsp8cBNsY0mMesOT6t7L9qFIuU53KEZTz8PK0ZUafX3VhaR9VMy2U0WSSPt9Sjf2OJOCylRRVXpGs6s1FClq6PI/HDy3qPUd+pdGuX6CPi+y7u9qoziAujRATlMZFOcMLKdjZQ9Zc6G3AAbH4W9zr3ex7fGoRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gnHU0tIp; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gnHU0tIp"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9018103214so673622066b.3
        for <gfs2@lists.linux.dev>; Mon, 23 Sep 2024 10:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1727113770; x=1727718570; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RUYv6+7WELIuXT4Lyojyqw1b8CePFF71EV43HfQ6mr4=;
        b=gnHU0tIpHB69ALRmXkKYeQY687qqv20dtGDBOEQhi0BGOa8cdcmnSghh9I8zGtTpOa
         Y10H9cvqJZESsqUNOAZLcDldFYLr5RvwgKeiYMDgZRX7HI73YYrd6Zlw1ZViJZ+wYSbD
         HzLzYPafBBseVkQD7Xf8eVo1NMOPaIEwK7upM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727113770; x=1727718570;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RUYv6+7WELIuXT4Lyojyqw1b8CePFF71EV43HfQ6mr4=;
        b=JYT2/EDAZpMaQgXkosFVpoAvp++XTyjGLODdYZ/ybnTECNzQxelMaOwfwoFsAbE4Qx
         jKsbTpTfZUuDXxbVtApdYdwuh/7VobjOhU9c8n0J4ImSspj0J0VUmzjZQ135ECFG00fb
         D/Z4G2eCWGnVgMers3j9nMQB6wu2IRO/eeap363DoK8mSWtsgwjqJnhQKrA5gtsZ0w8S
         uqlR3b96xr5A2pGbZJuIxay+3A7tA/yRF9gfOiDCExUDfOQPqbkKniDoGdH8ts+eA3X1
         95r7jXW+62xJr6lPsyLX1yQ+T6IXXekFxfFhmBpFTyAFBEoU0WYuM8h771H6bDYN9oBp
         J4LA==
X-Gm-Message-State: AOJu0Yz8J8RvfX2ses2MpHwtS1sPyaDizEtzkkKO6KzW1eizizBmEcng
	1989xA5yKey9VxLmW1eJ3odK5i20c8UdPr2fDLBQU/XtUuf+3H8oaidrUJFmTczkN7O4Q3TF90D
	PHfk=
X-Google-Smtp-Source: AGHT+IGN+fiYBpJBvoNMIRYLq1iNON17Z/Qdf+rTKyUmyRSu/HNiHdRbFejQK0H7P1cdu8WEKHe52A==
X-Received: by 2002:a17:906:cae1:b0:a8d:2a46:6068 with SMTP id a640c23a62f3a-a90d5775f44mr1059622466b.39.1727113769768;
        Mon, 23 Sep 2024 10:49:29 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90612b3fcesm1257167766b.133.2024.09.23.10.49.29
        for <gfs2@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2024 10:49:29 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a90349aa7e5so693004866b.0
        for <gfs2@lists.linux.dev>; Mon, 23 Sep 2024 10:49:29 -0700 (PDT)
X-Received: by 2002:a17:907:2d22:b0:a8d:3998:2de with SMTP id
 a640c23a62f3a-a90d566cecdmr1222211766b.12.1727113768756; Mon, 23 Sep 2024
 10:49:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240922140047.261100-1-agruenba@redhat.com>
In-Reply-To: <20240922140047.261100-1-agruenba@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 23 Sep 2024 10:49:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wittQGvXXMB5vk5GYyBWSbNmEtuY_i0O1WcR2SZed2dVQ@mail.gmail.com>
Message-ID: <CAHk-=wittQGvXXMB5vk5GYyBWSbNmEtuY_i0O1WcR2SZed2dVQ@mail.gmail.com>
Subject: Re: [GIT PULL] gfs2 changes
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 22 Sept 2024 at 07:00, Andreas Gruenbacher <agruenba@redhat.com> wrote:
>
> The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:
>
>   Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v6.10-rc1-fixes

This is just a repeat of the pull request you did (and I merged) back in July.

I'm assuming you meant for me to pull something more recent, but I
don't see any newer tag names either.

Hmm?

                Linus
