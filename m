Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793653406;
	b=pM3mBs8U0VmbGEC8hN/4yrju88DLsPFQj/FKuQDHpODWuuVubF3C4eITp9dNMi/MaCkT
	 UVfhm3jbUKHsVFET80zzCOG01C2rRlccjJQGqbEkRf7ZZheavo3weSqMxxjDO+sKcKTPt
	 bCEHlp0TgFTyw4bUy2cA48KWvo0fhG51sjQ/YbsQ/aZ9p1IDfbtj4v3LD+bSK7KKeGMm6
	 1+bLPB320+mEhHc3eRSuvolaufx6QYFidccxAwOVXQZcOxLeQLvzXDfvA9esql1ba7Hna
	 ccr6HfX8BhMJ4YTgV8EIOANCGVLmqte/tJs8XLrEUkV3fqCMLauvLJa2NrdWWobTBrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793653406;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=ENsxoMePPaNpj45xMew1J4DNmbZyl2G7RIxxd5drqLY=;
	b=OlnfGgEeTenU+s5R5nQ7CgajqDJ7drjMh8Itw17Lzi2VPxC13Gbh6VibMltvERiVgPP+
	 9XVZndNnYOvTrOjzDRQJDY4tfDxAm13LaCqVT7yUC85/ytQlXVOF5GziC1chZQo60XrJ7
	 xwEmiYgMTeA1435ezC76PhxwoONWygJooXhbOwBsGA5AvEola4i7jkX/6WxK2o2VrmCnp
	 PnPl7cokup4XVZXdIGukCBnlAsilhAG/GJTrOIRq+CiY0dI61DHbDMY7tKQYZbHqxOICW
	 6k+UbIqwH3UQ1nixudUIOukqVrIgnmsbz76M7/cLNLB9OHhTxckuUIzbXUdr8YIvK7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=truenas.com;
	spf=pass smtp.mailfrom=truenas.com;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28644606A326
	for <gfs2@lists.linux.dev>; Mon,  2 Nov 2026 21:03:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28644606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=truenas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=truenas.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-48e6eb21a8fso1381185f8f.1
        for <gfs2@lists.linux.dev>; Mon, 02 Nov 2026 13:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=truenas.com; s=google; t=1793653397; x=1794258197; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ENsxoMePPaNpj45xMew1J4DNmbZyl2G7RIxxd5drqLY=;
        b=cqvjpJ9Fc5kp/hcM033NCoo1QuoScFdkSQkPbe0IO2eLZMZyLLaiymX4oS01Gz1pxd
         LTGJX8uhhNVEHSUzFzrJwlJH5aMJGN2kaaSSO98BJLkGLmzG25+uNGcytPGbcxem3F/f
         Gqnq+ltH9BDILGffY+HMeAyes6m8RRPpIAgTPBniN7agVWZYjIB4o43dN3Tc7baLaHMU
         6/Hr5h3kbah0n4HKuZPOyI0xp5ms80uwhwPaZtgpc5kPNdpCMOo1sW9LgWS+pUJu+O0h
         dCD2WYbqOTBK6gYJS9MGIvEFuErqG3iv55qRWt1fxBSv9j/8tCDoT2UunPHCTly2uHZK
         8klg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793653397; x=1794258197;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ENsxoMePPaNpj45xMew1J4DNmbZyl2G7RIxxd5drqLY=;
        b=1DKDaXCXknxrDD7jUvL564CEqCufS+NoyAwIrr6EIjQ6HWk7cjriBPXjXmLIiakuYO
         Vh1B54kIpKSWuiQVQ2Mq3r9ZMA1DAL8tiNqlfl2+WWdsBya5uaKnzEWs9gtaodLzlQKk
         LrLfk0rGTq6PFzcUPEb7CMAOwqjFqlM1ya41yphl0MjhZAHonGi5zRwEG1dA+8bQGe0o
         FKP1vz4iKPg4b2711+uiwJlNSAUVZfgt3t3ECZMsLHGBFd3IWEyGWnabIZcr6RFCHaN1
         1gllbM2ZzIKpiZJW88XBi3korLqPGyM0I56JcxpEgWbNfXsP2lkexDHUYbeOXIJOUpW+
         rlFA==
X-Forwarded-Encrypted: i=1; AKwUvByi+PwoqhdUZr/smnQ64dCTWQI8ea6C0qC7JCOEx3WpQJ3o+Djhj/fgdzJhLaO3+sqGUuG8@lists.linux.dev
X-Gm-Message-State: APuU4Z/g6SrO9kdsCT+WLeka7iIS7liZ5PiZMpTsxthoJ8gjJiaYyIFv
	X7W5L8WzVX/lvVYZQ0S7s2FleH66yreLMuhFG2J3QuGQa7VyD5yoATCwL0uS9TCpVg==
X-Gm-Gg: AYBFou0AWJKSVtvg3BrUTEi9GsnsJBKzkS3R1I/N4S4MrJTTOwoZOM7Ijle8cjPG4Mw
	hhWgjLAQu7gIoD+nbBs1kSxPJFUrLuuvt/GAbt6b5N+416jG5DvxiatiQVdp3QdEKBFOL9ajvAj
	KxoE2H/LAYbc9YDChszfjBjBU4A9UESE5XtB39LlZ3HO3j3bmbLHJbnrqV+7EwZbDqMeNk1QCxh
	//sp1hVL7vK6ppyH+SIs3E17v84uj6LNeOVHvVXzCTN4j0ILc42+qJCvMzNkR09O85xYijm5jg+
	H8WX0xa2WrJWF/QF26w6zxdrnmTfgaleAl3Ob95Tg8YOXg33gXqWdnY0oPktBGff6SOIEBmfjnp
	b7Natn52b7yDtiI4yjNQulqwf3vh3Z3cNX7jKKGU37vHZ87Cy1wMYpfraUrOxgztg8+gFXnpPYZ
	eAlOVHCcFPnM8fWzXf4Zu8cODKmoniyR9pL/LYyLtw11SQPJkpfN+D/kIisq0lVXWpPAKS7ZF60
	h3+oeLaMiX89IRmiwH16O8WWtzMoR5DNnwRU27snOJv0eCUVU49nZVBjXgLdZLZ3XsPot1rEpdl
	65DXBAE=
X-Received: by 2002:adf:e68b:0:b0:48d:b940:af7a with SMTP id ffacd0b85a97d-48e6e5016bamr17560067f8f.55.1793653397396;
        Mon, 02 Nov 2026 13:03:17 -0800 (PST)
Received: from hamza-PC ([2400:adc1:158:c700::1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b8c0b6sm20919464f8f.41.2026.11.02.13.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 13:03:16 -0800 (PST)
Date: Tue, 3 Nov 2026 02:03:13 +0500
From: Ameer Hamza <ameer.hamza@truenas.com>
To: Alexander Aring <aahringo@redhat.com>
Cc: David Teigland <teigland@redhat.com>, gfs2@lists.linux.dev, 
	linux-kernel@vger.kernel.org, caleb.stjohn@truenas.com
Subject: Re: [PATCH] dlm: don't set RSB_MASTER_UNCERTAIN on rsb with no master
Message-ID: <auj4LE0bq7w7lOF8@hamza-PC>
References: <20261019151627.3324886-1-ameer.hamza@truenas.com>
 <CAK-6q+j64=mSzuufOaSGjsC2aSwhb0hs9MKxxaAhbwugdztHZw@mail.gmail.com>
 <aujr6x9t2gXbXfFw@hamza-PC>
 <CAK-6q+jBNKN=oSCmm+i011FdhPS+42BZc0iUfbqGiLDBc0Py5A@mail.gmail.com>
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Post: <mailto:gfs2@lists.linux.dev>
List-Help: <mailto:gfs2+help@lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
List-Owner: <mailto:gfs2+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK-6q+jBNKN=oSCmm+i011FdhPS+42BZc0iUfbqGiLDBc0Py5A@mail.gmail.com>

On Mon, Nov 02, 2026 at 03:38:12PM -0500, Alexander Aring wrote:
> Hi,
> 
> On Mon, Nov 2, 2026 at 3:03 PM Ameer Hamza <ameer.hamza@truenas.com> wrote:
> >
> > On Mon, Nov 02, 2026 at 02:49:04PM -0500, Alexander Aring wrote:
> > > question:
> > >
> > > how do you "pause" anything in DLM?
> >
> > The nodes are VMs, so I freeze the dir node from the QEMU monitor. It
> > stays a member but never answers the lookup, and after the cancel I
> > evict it through configfs. That is what happens on our HA systems when
> > the peer reboots without leaving the lockspace and a pending request
> > gets cancelled before the peer is evicted.
> 
> Still, do you just randomly freeze it, or do you busy/poll wait on
> specific struct field changes?

I don't poll anything. The peer is frozen before the request is made,
so the lookup to it can never complete. Then the request is cancelled,
the peer is evicted and the name is requested again, and it asserts
every time.

Best Regards,
Ameer Hamza
