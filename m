Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5953DE42C
	for <gfs2@lists.linux.dev>; Mon,  4 May 2026 18:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777921086; cv=none; b=rp2H98CNBc0Em+6NIHLOKzwX3M08GYC3ZTqLKB/N3FFD3/r283i1U/GiG2XPwAzcvBpIKbwFAbQAPGAkhIX2nkEgUHcVuAbmYzwZde6aQf5OG3EQoZcA82qc0Hq6UjXZUwGLSKUfLUNU7LaQTV0W2QgmMpP4GqAV6bVL77b5+2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777921086; c=relaxed/simple;
	bh=9vldQQyQ8QxWej/+LrSPmubE4dYlmF8mGkXkRZBWrLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F7Xuv/3FrlUXqIzoSThjebi7bko5R3cGhBkmSHI2NDYDq5AWx4egQy5RAiPCyV+jFvb1MNfe3PGZavoRKhiteKzaTRflT2iE8dVC1+iWAHAYpNzOa3YFtFyWk29ZV1Rl2HqQ+kgYfPsHFGh8Eg7PsLstWIs1DUVxXd8lkcv03+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OypNSFXH; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OypNSFXH"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488a14c31eeso32949625e9.0
        for <gfs2@lists.linux.dev>; Mon, 04 May 2026 11:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777921083; x=1778525883; darn=lists.linux.dev;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9vldQQyQ8QxWej/+LrSPmubE4dYlmF8mGkXkRZBWrLw=;
        b=OypNSFXHL0UXFt3QtSNhqHPWBL5M0G2FHxUQCgs6l7rEsRimFbRfahGorKDBzjQQh6
         ZJlj0rHHKtYrUDPSxTAqbtVCqwnhO93HfqgWalxeKWG9uM0S0UPQGm7ULCuypLj/jLWR
         psJxf2INESxk8Cj9llQgtxrQrW4O3Z/Bzc8tt9m/r9jnyRkwcwoQNamUvzHUtyh66nCM
         +uFNLUESdybZBI4u0cRUSLyZXDAeTcRQV2ApytQGvDDn151A1P0KpFDULE+L4qclBiz2
         RcdLUJzfn+N3AM0ZPOHfgnJRE10TD0FemhWpIw+8ZV8TDXmE7zlein7V09uCj9tNK0tN
         YAhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777921083; x=1778525883;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9vldQQyQ8QxWej/+LrSPmubE4dYlmF8mGkXkRZBWrLw=;
        b=pzKwtJy5zWWpr1qmpDyELJZORLuxcvpviNvDjBEHGhxK/ngPcL3WWnESKYhFoaltjQ
         PiFNdMMCwMmMDt6NXMZbMR708+SSW7VEidBwOBPzz2hYfNXmQcJdTkg6J1lwiG21Ihm0
         kd7nNQiRpGXrLlLNeESenxo6FDn1av0RiPY6jiKYktZSRhT+iAavUsZWh7jl1W5nMhsd
         VGQKhPN02WewsiuwUzD/t+IB5d7B/Kh6VqiJ5wQ8qkuH2DfSHEBy9fAUFYGCOxakfGXi
         joGh5h6dh9sq9zZwSupwGH3lRPPwpZg4XBFdO1NNUZ2D4Pdppvg/6wPJTBqplW9HDdRm
         vscw==
X-Gm-Message-State: AOJu0YwJoatZ1uvMD7pd8O5W5t+CF1jRfSbvv/2jYpnvEUOHjTpK1teZ
	K7tvSa8zX/f5lyAicAZj+bjgOXkyCBWfjVtPkA1HfNBZTzPOR+B6y8cGmDva
X-Gm-Gg: AeBDievQlhhpCjKhhLVefcbHUlLacDz3zvU/t6cK4TnizjYsF2OJ35QNmBnA7GgXTHi
	81h1uSoTRafENtt1Q/xlBlaH0qEPZvjm/aTr43s+GuQpryev8kgdioQG27D+0pi2N59qlt+9Ycb
	BrNxw+mq15xtlvSrBWnss41dQ0bMdsFS7AHy0AwMNmLu3xDfJb5Lp/2PJTO3Y3+5wDzvL8uTlBC
	kjDsjnCq8UteKqX2Yi0ily9OZ12r9HYECtOOwYvmkbM2EKQ6Pn/AM/iy7UTRjcfBASLjgS/TvBc
	yQKhydtCE0KeNi+94ZZl+7DhNESwm1MldXgVQxcMtIIZtNLInfnSA5LRztJ1qmc1O/g46WCJ14x
	UhZUmCZ1ejMisuNk+mx93c2zl0y6Z2AphnJWNONu6RX0K+nS2OJk6yuUt15YzkejdKWuVA7r6EY
	7fs5Q4JzGZDj8=
X-Received: by 2002:a05:600c:c058:b0:483:8062:b2f with SMTP id 5b1f17b1804b1-48a9886c2aemr107986535e9.6.1777921082958;
        Mon, 04 May 2026 11:58:02 -0700 (PDT)
Received: from debian ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8ff04927sm102793425e9.36.2026.05.04.11.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 11:58:02 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 tristan@talencesecurity.com,
 syzbot+42a37bf8045847d8f9d2@syzkaller.appspotmail.com
Subject: Re: [PATCH] gfs2: fix use-after-free in gfs2_qd_dealloc
Date: Mon, 04 May 2026 18:58:01 -0000
Message-ID: <177792108170.2736561.9192653094415898517@gmail.com>
In-Reply-To:
 <CAHc6FU6drG2y+dD-gkuq52uKUXzdGzBA6dNiwPe79-SF9J2hvg@mail.gmail.com>
References: <20260501110203.18771-1-tristmd@gmail.com>
 <CAHc6FU6drG2y+dD-gkuq52uKUXzdGzBA6dNiwPe79-SF9J2hvg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Thanks, Andreas.

Thanks,
Tristan
