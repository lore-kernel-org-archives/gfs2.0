Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD4C19E97A
	for <gfs2@lists.linux.dev>; Mon, 23 Sep 2024 18:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727117054; cv=none; b=rUxgeaFkmdM9JIzLqDMn7Xj8KGXeyaxWHyKV3LW9IJ+SYZUUZHtmrOJHQuCr9XSK1Trc/w6awMtI4GIkWcF0iUZUvPEWTXu5ygQKsSWKqSVNUczmxrdwIRaaevgjeHOdXaAmchN4MIIDks755k+1p3xrne1D52Je4Qj8a4i3Ybk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727117054; c=relaxed/simple;
	bh=P+8RSoZYpn4i1QWoYAMFPg4MPU/K9mqWhjadfR5Z54k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KfW6/QfK6mUr233hcICrt0e5+rxuKVwfvUPH/ZtuAsQ8nW+YP5zEePS/OEyvcz4UGBuFUf78pHopHynRba/DrPvf5crmpghhIku6HQO5aQ68WsnHWmUe1ULSbXcyQtM03RWgAZex/98eoykbHVTDBB4Px5BFgGnkBL9wo7QcbLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=IHR4rveO; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IHR4rveO"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a8d2b4a5bf1so674283466b.2
        for <gfs2@lists.linux.dev>; Mon, 23 Sep 2024 11:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1727117051; x=1727721851; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8QNKTwa377j4ekDDJ2WhXczOsWiGSIZrBf1uUxHYML4=;
        b=IHR4rveOml+mzxv/9/EBiQVWuUiGyksZtoK6gszsWvFXyfEO10Ox8l2QqiMV0/039J
         aSMQCmDHbnDDxgagqsvQdEG4c/8m20I76eNnS0SKXdzBJS1kYepu46AVQXhQlbOh5aai
         Ba74A0hyLykYpFVx8Ww0yKLli9gDrGHLMOWEA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727117051; x=1727721851;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8QNKTwa377j4ekDDJ2WhXczOsWiGSIZrBf1uUxHYML4=;
        b=p/yBnXrBUmXW5nt1f2CjLU9HbbPlb8VeQplM1v3/kXSpSh36hn/3j0bXquF6nXvSEQ
         YzO0CaAKKp7hFklbNKYYbloek+a8heaCFBv3jkdCnhofXLN2mdgIxAM03VdpYWwSF3Ev
         K/+reVYFItJAk8+rwJDVoBzxgAfLYgKCmgmzTrtlmV8u67fd9LTcDmRXxjTWpC85cXOJ
         sufLmmY56048wsP0wFyBWV3UloFSG/yQxzy7OsjhRX1BT+shhwJNWF4gO3zh2mHhYU3i
         9FklhKHPxGm1NTVbCtVal6mf78qghWo5GznD8CA/KzePRtFubfuge8nD5S8yr4qQtflG
         Kt9g==
X-Gm-Message-State: AOJu0YyXsqwiFVpAcxYwhtzfMTXgESL0OsBV6CULRcQTNPzPEfFGoE3g
	aRFQDdpzgGUkyepVK/KVoM7SVF3FfefR876TLDCUa+uvO0bXtwFLy1dnVxszEXuwtck1mnbgO18
	izas=
X-Google-Smtp-Source: AGHT+IFzwCMMyi0aPJzh6E4J1dCR86adP5WMxMDhqwuwLuN/lv00cfCcUWMoPhTL0qzZNuffjvauEA==
X-Received: by 2002:a17:907:d3e7:b0:a8d:250a:52a8 with SMTP id a640c23a62f3a-a90d4fdef2dmr1361013666b.3.1727117050824;
        Mon, 23 Sep 2024 11:44:10 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9061330c1fsm1250169166b.206.2024.09.23.11.44.09
        for <gfs2@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2024 11:44:09 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a8d2b4a5bf1so674280566b.2
        for <gfs2@lists.linux.dev>; Mon, 23 Sep 2024 11:44:09 -0700 (PDT)
X-Received: by 2002:a17:907:f1d1:b0:a8d:14e4:f94a with SMTP id
 a640c23a62f3a-a90d508b54dmr1204787666b.38.1727117049536; Mon, 23 Sep 2024
 11:44:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240922140047.261100-1-agruenba@redhat.com> <CAHk-=wittQGvXXMB5vk5GYyBWSbNmEtuY_i0O1WcR2SZed2dVQ@mail.gmail.com>
 <CAHc6FU7hZkHy5uTJ867zYJ1_Lp+ozP5tvBtW5_dDH1n6OruhTQ@mail.gmail.com>
In-Reply-To: <CAHc6FU7hZkHy5uTJ867zYJ1_Lp+ozP5tvBtW5_dDH1n6OruhTQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 23 Sep 2024 11:43:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgoEasfoxjU5ThjqW2JXnpvYGkmmxyBjuyOZsLOR=F8_w@mail.gmail.com>
Message-ID: <CAHk-=wgoEasfoxjU5ThjqW2JXnpvYGkmmxyBjuyOZsLOR=F8_w@mail.gmail.com>
Subject: Re: [GIT PULL] gfs2 changes
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 23 Sept 2024 at 11:10, Andreas Gruenbacher <agruenba@redhat.com> wrote:
>
> It's tag gfs2-v6.10-fixes from yesterday; you should see that.

Your tag naming is surreal. It's not a "fixes" pull, and it has
nothing to do with v6.10.

                  Linus
