Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793649825;
	b=Uafwf4Ixpu+2wz+qQEURbQ2P8+gy6S3vlgPnW/CdgX7tRjW6GeIfv74ybjgP7PX6NVYa
	 pQVnbq/Haix3BEq5TvkGPq89DKGZ/a1FyPrazlPK9Zv34wXH87Kv+i5ZENMBKZZjcKfli
	 OeVp1tbJ2wLh9s9zaYYXZfLT0Wj1RC+gVyfxiAA1pyq66+hnulYP4U8HlikZzbmJ5f0Mx
	 Wl3RlGQcsuD6wQ7SRtRicaaAQWzrn2HOPda7vj2NVNr0Fo1NuzUWDZVmsm5dt0zumIvFo
	 z55q+KPRXxHRQG7CfE4rBVz0JX8VpkG9SIg+F7a7j3NZEGQ9ugBeqguETBV7/oK43VA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793649825;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=jA2sADdkR8l/KpxMWwZUfijC8Wp/cwKXJFqTWTFWy8A=;
	b=UQhOlYXwgWFimtoZaKZooVUojbmIvxxSc5gp5qnAgjc6i4RusMwNKSIfyeT37Hw2K6FD
	 T4uY38oWsIo2K3Quzw5wG8HuGen70hKHMB9iBJU8E/xn0TV6eodPC5DI7sWcuIOTIA3pJ
	 PC3x57ogdx6NyrQ4o5MMRJL4IvoR8EzwcEB9kD2dpLOULtieS5tZzwzHUXERxA7j01gf8
	 clqX6bHJpsV5SJw4tcqsi5DZ04mTMUIlVAGSsm+M3ThK8+rnULbF3Yb/MA/JOW+3cXqCU
	 eubCFbAgB+b7110xe0DkeBfxf5I7GgE0wBWSZCrh//CC0/uLDky2yTHTVA8eUIHry9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=truenas.com;
	spf=pass smtp.mailfrom=truenas.com;
	dkim=pass header.d=truenas.com header.i=@truenas.com header.a=rsa-sha256 header.s=google header.b=RiGoe7ra;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14945606D812
	for <gfs2@lists.linux.dev>; Mon,  2 Nov 2026 20:03:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14945606D812
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=truenas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=truenas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=truenas.com header.i=@truenas.com header.a=rsa-sha256 header.s=google header.b=RiGoe7ra
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48b042c0759so1785191f8f.2
        for <gfs2@lists.linux.dev>; Mon, 02 Nov 2026 12:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=truenas.com; s=google; t=1793649822; x=1794254622; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jA2sADdkR8l/KpxMWwZUfijC8Wp/cwKXJFqTWTFWy8A=;
        b=RiGoe7raJJKPKRDPaxOXyjHOx5CK40YEsvWHfCJAKYXqho3iyZh4xAXXAh/P/IOhQt
         UVwV7cCwOAgjozUDbs2rCnfB95+cZDYrcP+83BMRy+r3Iz6Llf+5AtST82hRhQmb1Z3D
         4MAkkmztdQX0i1urW7b7LXLRbxpTFE5OwIu+xtn8Sbc69hj4uxEcY0rWHeygvK3YXz7w
         65K3G93TAuc85uwssfyvlJxyVoHp9PWu4X0o4RYrJcUhAgwuvmlBXV+7fAc+o36/x8A9
         Kdbrm3rDMsGQJXwyWi0htFCmc4xRcBDVGuEHHbwK6bj1xMGzd9cj+m5tHHWozQ4AFs2i
         k52A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793649822; x=1794254622;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jA2sADdkR8l/KpxMWwZUfijC8Wp/cwKXJFqTWTFWy8A=;
        b=GEq0Qz8mg+LpagKZygKlMqVHKpU3ZERzxUEdKZSXsFezuZC0OOb1tn5moT5cz00Gmz
         5ZPwtbfeCPd6tiKgeJkE5/BZPxAJ+H6uUbzbFojQglq01s0OFw/jhHIVik2HGIuR8YBH
         QVadZ9acOiIzyB9AxG+ODfG2zHco2aPR1vWBVGAwaTJVLUfezy2KveNip+RXL3fzGv+T
         lTko89qXn0XdUOCTyEbEHmIqpXbSPbK0tGdUuirnb6p8uUsxlWftvXTLQm34GR9YFz0g
         1Vz8rNEpT61GRte+PsVLAXhLIshU1bwqGe1/nZadfSjYx0dNTi40BFekhiVzORBTwLjn
         ZAHw==
X-Forwarded-Encrypted: i=1; AKwUvBzIs9N4PA5KzKVw0kKikuqTkCXs9MOhjcmMWLipRclZiQwXoAwcuLgMiO3UVsTMR8ocS/ao@lists.linux.dev
X-Gm-Message-State: APuU4Z+hlGtm5+iJVdGQiXGyYXPtEzcuXSJnFf/FzOKPAGADjnzk1CQO
	8ytF+Oqx/MI9KQ/5dEXGBBTigUW4rr1zfgCqO4dErBk+g+aQbgkAyjveQtlahvKyDw==
X-Gm-Gg: AYBFou317YKorVSIHbZvuFgFF62XXXplYeatKqAyXS+z54WaUz/cBg2RQ/9nptgumbv
	+UncbPbpsgnyxuM1MZWKe/Txbtv4jIONiuQb5t2WR1TgT308uYRDD9TrJOLp9jOBiC++81NV7Np
	pRPyVhao3jlo6zGDP1B9LEmdz+qEVLiPQkjluRYOqP/cyB8iXRrwCkCGgQ2IKQCSIKWPAT6/8Vo
	0pasf7KgEXbIFPKZU9jvdUExnMxuf6kW5MMxSNtmgSsjB4Gqu+WiVXkPfGAAkQSDcPswT3D4U0o
	+QCGMnK8aUyhZHpcYMOnt7Xg4kGDMblkcakAE3MSOji8M2pP4pU0CisOP9JGsB/ibTUpkuiyZj6
	Vm0S5/4eXDqdNT05kLATjM1txgyh/hyW5ftCXR69XBQW+oIsd41gNtrj68nvgdWhROrF8bPe5HK
	B5LseG5NbpT1Jlwrpda6Pgx7tWu49YsKZERLARh825/otRPfz08Rsk29vxjdbsMWq6gXYBLSUZG
	W2X81ziooZe+nFiuw7qhkCRmt7BvBJu+roVIFWk/tKdKLUs9jYxe7/TnWh+ombJ/+n5U0CPQohW
	reXp1uRZ
X-Received: by 2002:a05:6000:184b:b0:48e:7026:5243 with SMTP id ffacd0b85a97d-48e702652d7mr24934699f8f.20.1793649822375;
        Mon, 02 Nov 2026 12:03:42 -0800 (PST)
Received: from hamza-PC ([2400:adc1:158:c700::1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b78a4csm21400319f8f.23.2026.11.02.12.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 12:03:41 -0800 (PST)
Date: Tue, 3 Nov 2026 01:03:38 +0500
From: Ameer Hamza <ameer.hamza@truenas.com>
To: Alexander Aring <aahringo@redhat.com>
Cc: David Teigland <teigland@redhat.com>, gfs2@lists.linux.dev, 
	linux-kernel@vger.kernel.org, caleb.stjohn@truenas.com
Subject: Re: [PATCH] dlm: don't set RSB_MASTER_UNCERTAIN on rsb with no master
Message-ID: <aujr6x9t2gXbXfFw@hamza-PC>
References: <20261019151627.3324886-1-ameer.hamza@truenas.com>
 <CAK-6q+j64=mSzuufOaSGjsC2aSwhb0hs9MKxxaAhbwugdztHZw@mail.gmail.com>
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
In-Reply-To: <CAK-6q+j64=mSzuufOaSGjsC2aSwhb0hs9MKxxaAhbwugdztHZw@mail.gmail.com>

On Mon, Nov 02, 2026 at 02:49:04PM -0500, Alexander Aring wrote:
> question:
> 
> how do you "pause" anything in DLM?

The nodes are VMs, so I freeze the dir node from the QEMU monitor. It
stays a member but never answers the lookup, and after the cancel I
evict it through configfs. That is what happens on our HA systems when
the peer reboots without leaving the lockspace and a pending request
gets cancelled before the peer is evicted.

> Acked-by: Alexander Aring <aahringo@redhat.com>

Thanks for testing and the ack.

Best Regards,
Ameer Hamza
