Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7360B2EAB90
	for <gfs2@lists.linux.dev>; Tue, 17 Jun 2025 19:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750189458; cv=none; b=NG6hgscS71ze8oDTLqCz45Hu8n0lzzTL4/q0YZKHXOU10mWd3skZprogCiANmm/7/IFzMVMNJvC3hjWoCgHOwoW4scuFbr8oW3l4T1inU7OLNc1UlhGX8lbMVG0SQJX/OW+yVyWp9sblOv5rHxM0FKwPggw2TyAI/z/7LZ8qEMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750189458; c=relaxed/simple;
	bh=WtRi0Xw2Twgw40N7BsMXWRD7K0MQidwWcJ60lfUYY90=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NrsAdNPVr6oHJtRNSoB/EPNCLxuZevkqtSteFxJJkcOJwc85ci5VdBHqcN4z5q+o2y0zWLRJo+0T6PZlTNMPeml42xaCTnAXwIOFNOP6oTofjgmX6nBgYaMzfMijwI809CuU79W0y1KUsDJCsOr6yD+8giL9SwOxGEYzBUdePaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ND9hFoqR; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ND9hFoqR"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7d3cc0017fdso390575385a.3
        for <gfs2@lists.linux.dev>; Tue, 17 Jun 2025 12:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750189455; x=1750794255; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WtRi0Xw2Twgw40N7BsMXWRD7K0MQidwWcJ60lfUYY90=;
        b=ND9hFoqRBg1QDo03bdOR9/Fs0gVFfiEu21jZmEMVVQCEOwiOh/wxLqx4qpmTF+o4nj
         j0Z7k+nTS0hpDeVvhx4Q2QM6XUP/wl1dwly42AWM1P/MB/9N5CjX1WgVGif2XdUB4ZNh
         46Wn4jOc1inWUJMn3YI5gRlDSfFC3l6ghNEF5VPeMQrpcby+s+ql5UPQraFHAe0JmThj
         Ydo7UQvmxoGY8aEbqGy5hIrEM06YKIFwv6FcftUrKnBbvWt7fwryc50S3n27Fex4PIkW
         H3+I7SXTRTM2JiWwAYSM+tCecbwMGmXPPqQifXjXF5ammtnJDZo2va+D+BTrXiUmATi/
         ORoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750189455; x=1750794255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WtRi0Xw2Twgw40N7BsMXWRD7K0MQidwWcJ60lfUYY90=;
        b=eGG69sx2da/vYb213NhwKieJTHBJOSno4lB+0Fs78upjIShVQBIq2egNhsOlhYpdor
         3Ni940OI4u4gGf8WNOjmmul9P767ZvbOzrHmPeLLQJ8wLBRdCx5uQedYf4PdTbjmlt84
         dG98jColgi6QPMjXSGSU9VhS0BLyr+LXRkkl0hCuoA02Sj8jklB3ECyX0gHjjl25TIXH
         jBGtgK7FaPE9jjvR5+a8XVHDr9NsCYF2FeDjRF9YaPdOBnD11QW4pWIMmHobNdcycXEM
         vj51Qm97sobaCXCfqlRTWqKPMNXZPxRY9vWvzfSD9OwmIruiY6DkqaEfP1M/aWgNDAAc
         VVvg==
X-Forwarded-Encrypted: i=1; AJvYcCU92hnEaQN56Rr6YYPz0Bu5N7iPPi8OIZwjh8tRpxVfALuIWE/JtPf4t7tgt5b7gEiGazuK@lists.linux.dev
X-Gm-Message-State: AOJu0Yx75H6u93gyFn+6bu3712ittKUQ5HlpnT+xDDf6YcfQRByDzuKg
	A0qslfpCtWufXJCpJKH6KkQ+Qo2y8fHQTiJll7kLnBkhQISSxOBzCahwpfEMUjK/Vr/GECZg5GB
	ceHoxlp3Bkp/SCRBq1lWe+Z6pU/DTO2o=
X-Gm-Gg: ASbGncvjq08WPRSDVM9Mecu3ysJwAqW6gdXp3YGJxiHV83fujmNVKpLCeavpSTkNltm
	xrYFCEtuQlDSRs+kN0VbmEz5r7D/09ndrXMfEXNyrncbYAX5KGsNhzeQoOsbHrlVjdYmNEmh+f+
	n4L7rmWDcKCawzI9zwjCC5U5F9njhuINOc9mIQUiEoGEkU8M6euaCQQonwNA8=
X-Google-Smtp-Source: AGHT+IGguM90A5WxxBaJKHgMpi7W4GY/IAJU72MFE1HdL/TGwi0nyeWd9Ec3aNenmuUCOhCzBRC++OpmIdkKrJt7+34=
X-Received: by 2002:a05:620a:3727:b0:7c5:4278:d15e with SMTP id
 af79cd13be357-7d3c6cdeecamr2004479285a.33.1750189455435; Tue, 17 Jun 2025
 12:44:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250617105514.3393938-1-hch@lst.de> <20250617105514.3393938-8-hch@lst.de>
In-Reply-To: <20250617105514.3393938-8-hch@lst.de>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 17 Jun 2025 12:44:04 -0700
X-Gm-Features: AX0GCFtyYBSleZJx9jXRFkbq-wNgS1gcTjSW6ILPiwvxDyVA37lLb6eefOFCCuA
Message-ID: <CAJnrk1bdps-eetwZOu_2Sri7oeVAa7F+22LOjo=Z+Bh86drWwA@mail.gmail.com>
Subject: Re: [PATCH 07/11] iomap: rename iomap_writepage_map to iomap_writeback_folio
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-block@vger.kernel.org, gfs2@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 17, 2025 at 3:55=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> ->writepage is gone, and our naming wasn't always that great to start
> with.

Should iomap_writepage_ctx be renamed too then?

Not trying to be pedantic, but the commit title only mentions
iomap_writepage_map, but this also has stuff for
iomap_writepage_handle_eof, so maybe the title should be reworded?
