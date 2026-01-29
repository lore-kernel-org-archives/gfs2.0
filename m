Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4E62D3ED1
	for <gfs2@lists.linux.dev>; Thu, 29 Jan 2026 15:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769700479; cv=none; b=iJYLIGE+8DzcAI6FTjV7+5nxcEyeowfhbA2xm3rxq1K/kGIaRutDao9EmFzS8yW5mIOHT9kFQfd4t+o3gXbjYBZEa0rLI33TOdoVyAUUks4IcMaiMqw070zYYohz0MF+oNf5x7Nm7+mRhNov6jiVVW3VK0z2PT1Tx/zBf3Zo7/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769700479; c=relaxed/simple;
	bh=WGcd+eGZrnT4a8vrCYCQCfONoxvosYN2DwBdqwJnV9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rSLFjMeAwJ9C3izDn070fFBNplWxKi8XzrsJO1EhbKHKMASZwfgTIcbrCfRMFN6Pzn59/XAvshVWIzc5QbM5p4F4MDAHcR/iLWznOiymSL2ikiDEYt5Fz1FE0cLatkhFzA7uazYE45J7d0FxRRA08LEcTI4OPhsMxaNQqHL1WOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SDO3tt1q; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SDO3tt1q"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2a07f8dd9cdso7876375ad.1
        for <gfs2@lists.linux.dev>; Thu, 29 Jan 2026 07:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769700478; x=1770305278; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WGcd+eGZrnT4a8vrCYCQCfONoxvosYN2DwBdqwJnV9o=;
        b=SDO3tt1qWMgURv5DhyxZu0YhNRbRD40a8BDUi3IuZh+FazVYFRfV/gQoyfF5FL8DmQ
         It2cqajHCF7TtUKjvZ3H40PG/mO8Nok0eQXktuug6lSnERdp3dSNQgszJ0y9TEjbzP3H
         JFOIARWHnninx8bQEIlQzUds9ia89j6NCZV2zjM06pXTXwgGeQKmpjKuuFgGNnfsK7bS
         fS291PrAPZqTiAIp88FyiYZmEQpLbzhQPPhuBFxzM5rbWK6hnZFHGJGCLLrx1Ier0yOx
         qlBh0lkSGhzW8Erq8Yno1XeBJRUeU+SRoEaIoZwmAXK5avVZ2LNmWugWbnehoInUboIW
         kjig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769700478; x=1770305278;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WGcd+eGZrnT4a8vrCYCQCfONoxvosYN2DwBdqwJnV9o=;
        b=ICHWLpQ1EZAw4PCO6AMLiIS21QAvwo7fUO4ClwyWVZzdUCylpdhO/8OU63aSdv79+F
         Dh5SL4InC2VEkiAy9lzSjpFzRO5MK/PtkPLkVImmar+CWnqSg5xWV79/n0hWg4K5tTsf
         /+2ZzZa+J71nXFxWLB0RvWV0soVZvTPQU8kwG4LX2xlUcMCgkqHbFekSlN3NZDCqTPkd
         D0QndDIk7TielC0UYGmt3ZyTYuJ68AjIEbsnGDyWyHYhScrHOZVqC15sP+8Q4udHftuF
         GDnzOulWnoPSRW9rOxIcVRSw2Do+rIZDEt13MbFtb0cYWBvu66DkbQTIHFKNQpjVAXOJ
         nfrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMDi618DL3NSheA+Rkma+MdpEpboQPvkk5Qb/g45Z0Q5dcV0MZl0VtdmN5hdrld8zPvg6r@lists.linux.dev
X-Gm-Message-State: AOJu0YxDpL6dpQN9/+RK1csWSj+PPyx1hL1QMsN3Lf0iM9B2SNfFK872
	YZir1aYTrK1OVxtYxlp7QYCnubKCMkjP2xmeaoKCD7tXLpsKqxoRem9d
X-Gm-Gg: AZuq6aL6OEEs94fITLmuS4M/4TtK6oxcEeQvvXZZCOYDNz0kb0yxrugKCYwIVic2vdG
	/WHpEN4c60A+N/rdkcN9vXMZUc4QRCCSJUuz+FPBTUQ6vAJuwCv9qDEMSDwSFxb3BT2XxL3MTvu
	ysV6q46mq5vCWqDnyHGF55BHfzIjxeWw1qPNbcqjEmY0WQ1ZY8Ob4jg2mdMlLV23udnO25e6tk+
	0tYnDD/UmxkhnMczjVm31arHoTQ4Jk997Rz7jOVdVfQFFlEN3XnbfaEShpkBWTfBCXQw4baRCpX
	78cZSCt0DzrdrILoSBp3pRgZ99ciF0e6kIwxaSFtn2wkzv9rkj60KDS70EbkOYZEio4lcgDVb5B
	plbD0k4p5sm0veZiZ8O03wgfpammscz/dC1p3H1yOYOodAejwklbQwGn3F7LIcCmqp8gzuX6r2F
	FSZID7/aUUA8CC/XBCFQ==
X-Received: by 2002:a17:903:2ece:b0:2a0:d074:e9f4 with SMTP id d9443c01a7336-2a870def787mr86840655ad.59.1769700478049;
        Thu, 29 Jan 2026 07:27:58 -0800 (PST)
Received: from fedora ([210.228.119.9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b5d8eabsm54826735ad.68.2026.01.29.07.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 07:27:57 -0800 (PST)
Date: Fri, 30 Jan 2026 00:27:53 +0900
From: Ryota Sakamoto <sakamo.ryota@gmail.com>
To: Andreas =?utf-8?Q?Gr=C3=BCnbacher?= <agruenba@redhat.com>
Cc: Markus Elfring <Markus.Elfring@web.de>, gfs2@lists.linux.dev, 
	linux-kernel@vger.kernel.org, syzbot+4cb0d0336db6bc6930e9@syzkaller.appspotmail.com, 
	stable@vger.kernel.org
Subject: Re: [v2] gfs2: Fix use-after-free in gfs2_fill_super()
Message-ID: <aXt5oYSyrSTjmXMf@fedora>
References: <20251230-fix-use-after-free-gfs2-v2-1-7b2760be547c@gmail.com>
 <57c723e9-d38a-47fe-9737-5b472916f3d2@web.de>
 <CAHMDPKUZgJ80k+u_e45FGSPz5N4sjBfX0AtWu3Oqr79wMSx3MA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHMDPKUZgJ80k+u_e45FGSPz5N4sjBfX0AtWu3Oqr79wMSx3MA@mail.gmail.com>

Hi Andreas, Hi folks,

I'm following up on this patch. It addresses a use-after-free bug reported
by syzbot.

Would you take a look at the patch and let me know if this version is
acceptable, or if you'd prefer any further changes?
Link: https://lore.kernel.org/all/20251230-fix-use-after-free-gfs2-v2-1-7b2760be547c@gmail.com/

Regards,
Ryota Sakamoto
