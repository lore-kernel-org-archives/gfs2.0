Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793333155;
	b=F2ZUUEntqqV2QxsKGcBEDBXMvBLcBGb6T1Tc+WHijSF1on7STx2BH/ve2OVMnKnKzKHh
	 HyhLYY/6Mw3H9LNf68x96m/XgZOZVaInkHdQtAf9w6TEog+ooqdXkFcL66m3bn2ZKqf2s
	 U+Gk8+rvbcl5+Z+Ljtr0RJkUZXQMx/H5UaewQm6nXg5Phfzmc+K+vJ4vTod9OzAkQrn80
	 8/TQksnuz2FCaL4opx8owl+sA9tpzLfFlVOr+nnS/Lc6y4z0oo4ucS44ArFkRAad0dmmh
	 UXLb+6ZAiuRCJ1rvNSgwUQTZnyGa2IZ5izBWm2Q21DyBixMpr4OM632sMJvX6BB3h3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793333155;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=9CvywPHpjrCT0zo2JhnH11M0JaZbySgNZTi9n8+NQFc=;
	b=Fvhd0cyKuSups+y+9wDYZFibs24P4j95vPWTIcGrqj2pHfpdsgBSEY26Okgtc5gOzP5N
	 RnVLwmuQ/9PJDznfjqsPW3IbHaur8J5kar5hY0745bL6LElyXdMqnGdntpLbgoP0yQ20O
	 dd9t+dlg2ba5FIpShQFOLZxAEInV+Ir5rv2nX7MW8olr3zzVn0c3sJ4DnRPQMXSv2a7zJ
	 MfBq44ALHOLk0QajvnZ+dV7EA+UXyTfQ7MEwYliCmGmMoGImFpJXvzxqsCwR4YLTAXS95
	 k+QZeeRzggEeYtKLXgRfpcdSN1ZsS5mSOeKfm1uhXqEAqzR4zMk878Oz7wfppTbGBKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=pNcRgMIZ;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9054F606A320
	for <gfs2@lists.linux.dev>; Fri, 30 Oct 2026 04:05:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9054F606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=pNcRgMIZ
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-3535bf8b3e0so519846eec.0
        for <gfs2@lists.linux.dev>; Thu, 29 Oct 2026 21:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793333154; x=1793937954; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9CvywPHpjrCT0zo2JhnH11M0JaZbySgNZTi9n8+NQFc=;
        b=pNcRgMIZIY2oZG+KBCWHOETi9ENJBfSv74eJI/QEk0Qv49pNOktbBQPM0cNGUV55/3
         ePz7BhW8pNjZ8f4f1LSwcic33EABoFyd47SE7TUqqEmcPmDgzlYbefkW2jeKuHT9YCoX
         EiEloNWcp73OAUo/HN1DbeN3mKUw6BNxygKbGN9KW1u8cfNeGOpnY0+APiLbZl6JIuHe
         42Vpoc/I6bR38uspIwB297pgPGcOf+fOJrpxGnUHkpQsB9afSCO4oOjMTYQ5DOvt2Tk+
         O73Kg0pG7Kj1iQoIowPPMoPHVY/KUvk8TmKThPcHK/hqxS3j+QlHVAereljRk0sZO8Q8
         iIIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793333154; x=1793937954;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9CvywPHpjrCT0zo2JhnH11M0JaZbySgNZTi9n8+NQFc=;
        b=dEqgjar3FlMyRLvbObR9GHaMf7Ma5dWMJ15jmHTSZG7pzOLGb+IsgTY4MRNrcqbpUn
         Qwkub6Ml9vTBfumPhK3hOVvYV06kialz0DdK57VIb2iBi7a5XkoPF42rc4RUCJza4HvX
         mvwgO5P9POMAv/QUvl5CW5vmoq6wtvp+vpWB2BFt0XOKZjvAfzckvw4bj8/eNSmnsLm2
         tbvlB2l+ewLQcJ8CebUF5PgMic73s7W/LUaSDuVDi1pQu7I24J2xhVOlCVTHfIbfzzjc
         H4yib6KmWyW8mXjfU6d3UeVZpWbMgLnWpyjwUGQuST/5e7rEZCc9trgqBaNb2K5jZIDy
         T0Hg==
X-Forwarded-Encrypted: i=1; AKwUvBx7u0nhCAk7rWqcrwmUMrc+0gb+a4Q2XoNhiaYPa0Ce6rw4kPai3AYwoEAjOP6Kz+pDiqkJ@lists.linux.dev
X-Gm-Message-State: AFq9FYK/LRH1ZPhuzc7+6jy6U6yK7MUIpue4pILE3BevcnJOoyYlWuPf
	UMzpXeSSWld8tHUZzys3cAMWT+QDh1v135gm/fnH7wDn6uuU5y+NuEYwItgHBcePIQc=
X-Gm-Gg: AYBFou0SIBHA+sEoQfj02kz2VGRaBg6bnSLwhtO3RYErN5oi9aiNpSS5AtiHf+ucodP
	s1DjoHUNQO+kiL4sPzDzEQkm8GGqCFuStTVeZGPVGFH0DdwV7Lwizj49dAWNILkL/RKS4SiJVqh
	ZuZrRElfsI7Hmxx3ZgR2VrklWoipPf4b8AEu8HkCuRHB3Nsujfvh54iJzzLxvFfuH2y62haVYjB
	lljLr2Q85Q5s32INqZ3McnATgFwlXrF06eNzPM2L59Fq4hlv4NyKqhH7Ab7QhBWqpYMqr6rEXcF
	q82Y8MwyIN/iLdyHR6mWKs17UsfKaLjh7z0sR3FysGZNwm5x5ArLER+l8F2ybRTnK3ojQGxEXyu
	SH4JdTrkZbkwzSd7tqNEJzyvYcPZ8uaSC6/eTPNG3t+MRgU4ZQ6CvW12u7ePQCuw58gyBZcqXdr
	iM5avbi0n1sDb7FGU1Aamz7u344OR3AKiKIw/xr45Xbs1sUIrfFY7ssFJNnl4a2Kx4por5B6V52
	0Eraj4z4d67WDHdINA6R3oze+Wqxot9R4V5IUmwdegEKcDW22CrFP/T/2NYLgSFIosY8w4rQr2b
	LDPLqSVuztn/plpvSJwhrN9VgMwC40E=
X-Received: by 2002:a05:7301:53cb:b0:35c:e696:2d4a with SMTP id 5a478bee46e88-36a423ea99dmr1772736eec.24.1793333153319;
        Thu, 29 Oct 2026 21:05:53 -0700 (PDT)
Received: from localhost ([122.172.82.240])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a4291e38fsm3512579eec.15.2026.10.29.21.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 21:05:52 -0700 (PDT)
Date: Fri, 30 Oct 2026 09:35:49 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kees Cook <kees@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Miguel Ojeda <ojeda@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
	Sumanth Korikkar <sumanthk@linux.ibm.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, driver-core@lists.linux.dev,
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
	linux-s390@vger.kernel.org, gfs2@lists.linux.dev,
	xen-devel@lists.xenproject.org, linux-mtd@lists.infradead.org,
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/9] cpufreq: governor: Initialize kobj_type release
 callback statically
Message-ID: <auQXnep2xKpuNJOF@vireshk-B250M-D3H>
References: <20261027223847.652884-1-irogers@google.com>
 <20261027223847.652884-5-irogers@google.com>
 <CAJZ5v0juvZ2ZVRBkY6FxBM=NhPt9vMA3+yRugXc5u=U1jO9AXg@mail.gmail.com>
 <CAP-5=fWVZ=7-qDRODiEQzRzhpQqribv9Morj=OoAXW_6uaW2dA@mail.gmail.com>
 <CAJZ5v0i0YoOW+ueh_aZJdYVS0etuCqfrf_S0NTKzCE9_6oKxPQ@mail.gmail.com>
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Post: <mailto:gfs2@lists.linux.dev>
List-Help: <mailto:gfs2+help@lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
List-Owner: <mailto:gfs2+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0i0YoOW+ueh_aZJdYVS0etuCqfrf_S0NTKzCE9_6oKxPQ@mail.gmail.com>

On 28-10-26, 16:39, Rafael J. Wysocki (Intel) wrote:
> I'd expect the driver core to pick up the series as a whole then, so
> please feel free to add
> 
> Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org> # cpufreq

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
