Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F8C5A4FF
	for <gfs2@lists.linux.dev>; Mon, 18 Mar 2024 22:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710801878; cv=none; b=ImmeJmImZ4x3hrD59f9BlA0PvzjWWlqONJ4VAopC1DvANRe2cVRBuHzF10hO0LYPrT5WZUeZiUj1ed5chv0gGStl2+ksBGfp3HZ8T/AJltd76TJ40RLM5CsL708z/tgukg0/CpUQs70xQTPnfhYDcbUwiuns+FPBNibRCGFE3Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710801878; c=relaxed/simple;
	bh=eduRgU53QZDWrAPUCPvkckYSrnk3rAFitEKcGg7eVzw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LtY8F/Q8PR4HVHSXBzDYeQZiuQjXyY3P2yz1qBHDWPuDnyj87l9aDK+h05MOE+HM+6BKNXChLDMZVJgi3ewJURx2WGz/ipdNTZLx8fmDn7gHfTs2C1uoztS/cWHa6t/mu9byLBge7xtcueamNwg4OztNbomFkMSnKNagNYpdTIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=V3gMMU5t; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="V3gMMU5t"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-513cfc93f4eso5541422e87.3
        for <gfs2@lists.linux.dev>; Mon, 18 Mar 2024 15:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1710801874; x=1711406674; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MH75aKXvoDEeQu9H6jcn+rQWkXLmzRwG/v/RnlP4n7w=;
        b=V3gMMU5thF1CdbY/Q6u1N1QHBVgC/mtg7KQ/cWIr52tsKQXrkpxrJ/VBJr3m84VKqd
         aN+mGRTQKh+SsfRv6bGwJaCikbAczvLQbPr46atXlt252pnOkd4FHxr3xe+tbATJGaoK
         sJNBoPaGykUoYdnsvRhxU3Opt71hyJL2wIQss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710801874; x=1711406674;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MH75aKXvoDEeQu9H6jcn+rQWkXLmzRwG/v/RnlP4n7w=;
        b=bw2u/mrPkNLgbryplQkc254bHmX4hNqspyQpJR697KzKvVoo267Ii8PycrLi30VQPU
         tGbvYIQKYZxZcJ5SGfgz1SNZ7fGhhfLyhc0EaTaCCq5wxYXDqKt/2PzEZy3Fv90ew3XU
         pYZaoP6gA+ASv9vhPU9lghboGViL5cO6Npbk09/8p87czIpxTDHDZgV6F202kuvThByb
         kbl355DCpLDXoF6up2YO9bMynsMmEn02i6BM25bP0d8JMszmABLzrNvm2rffeVycGCuS
         s8XCrriz98lV8+21Y0TfzX9ui9mkQqs8Ms5JU8sonscDRJ6arYW54r4cGcR+vwnp2OKx
         FwJA==
X-Forwarded-Encrypted: i=1; AJvYcCVZby0NHsE8kgFGryBWGlvboiAXLeqwAUbEQ/3JbhmPTkxSgdES7poMNrVcUZML9UvA8JGBbejZ9TtmLDBAyE422h46lA==
X-Gm-Message-State: AOJu0Yz6y0lZxukXgJ6m5VjbGtLllmJCNUiSY7JmXw2tY9UTs8OwxHsY
	3zR3f6BlRXOgR2IOozn3CpLqGKUpe7C7Zh0nPGYIz2lj5N9M6sLb5YJ/MMBWQRhF/I5YFjw5FPY
	PpwKhDQ==
X-Google-Smtp-Source: AGHT+IGaMhIkeqvog4bRxBBFznpykXVNPwnf9gzDcBaJYoEvX1jTYL6+Ns7HrW46f1/h/C54X6kztA==
X-Received: by 2002:a05:6512:3134:b0:513:da38:3381 with SMTP id p20-20020a056512313400b00513da383381mr7320981lfd.25.1710801872856;
        Mon, 18 Mar 2024 15:44:32 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id x14-20020a056512046e00b00513b62be12esm1717432lfd.87.2024.03.18.15.44.32
        for <gfs2@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 15:44:32 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-513cfc93f4eso5541398e87.3
        for <gfs2@lists.linux.dev>; Mon, 18 Mar 2024 15:44:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVkBnoCvVDGuDUXWK8C+lphZAGI9T4SkYZib9ndGBQxR1fVqsvVlQLeDG5Ewcd/dK2XQ12n/oJ80yUbtbGOpib99Kt9yA==
X-Received: by 2002:a19:ee14:0:b0:513:aef9:5401 with SMTP id
 g20-20020a19ee14000000b00513aef95401mr9139293lfb.66.1710801871842; Mon, 18
 Mar 2024 15:44:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <ZfixMxRWFNmkf-Ta@redhat.com>
In-Reply-To: <ZfixMxRWFNmkf-Ta@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 18 Mar 2024 15:44:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjnxmpk1L9+ibbZmia0qNNwa8Qnk31_57O-DZqQfL08OQ@mail.gmail.com>
Message-ID: <CAHk-=wjnxmpk1L9+ibbZmia0qNNwa8Qnk31_57O-DZqQfL08OQ@mail.gmail.com>
Subject: Re: [GIT PULL v2] dlm fixes for 6.9
To: David Teigland <teigland@redhat.com>
Cc: linux-kernel@vger.kernel.org, gfs2@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Mon, 18 Mar 2024 at 14:25, David Teigland <teigland@redhat.com> wrote:
>
> I dropped the commit with the bad atomic usage, and replaced it with two
> other commits: the first reverts the unnecessary change that began using
> atomic_t for lkb_wait_count, and the second adds comments to the recovery
> code that forcibly resets the wait_count state.

Ok, the diff certainly looks saner. I didn't look at the code outside
the context of the diff, so that's literally just going by the patches
themselves, but I appreciate the comment ("The wait_count will almost
always be 1, but in case of an overlapping unlock/cancel it could be
2: see ..") and yes, it just makes the old atomic thing sound even
odder.

Thanks,

            Linus
