Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793973973;
	b=uTDXYBijMtEH5V+SAtv0vWjcxICVciVhPdEmlN4nXQolvg/CNK5uJG3D2Za6Ncuv3Bre
	 ZSU6pvPsKbvgzxMNU6SPWvaiaYyy4oJy6wK/iQb9e43cf1V0UkRitJU4mLkezBbLC44un
	 6CgU7kendfmFatnNdwfIpfuxQ+wjJJcPQQAEOKAD+bYak46m7W96/NQe5UBDPscRJUssk
	 LSaafEUdh7jDk8WVq3tVrqdBrH9UK0oAOGQBSWrsrbH9DdNAhGJHyxDUVMi6/MSYUpYRu
	 TPFU6F1TvIgkkNx+3+7hXnPY38voXxyoHUUTNU4DzcnIwhaK/tl1CTlcrLYkWIe6xWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793973973;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=eqhBVbUtw3dy734MGt0XscJMrayl/heBjdE55TwHpBE=;
	b=OUvSCiZErkBkAet9RD1lAl75K0EQSlSgQrPz0x5NoMsTsVKhFiS7BMFSNJsuhxjE23Z/
	 qSCKZhYgNRwSHArXeakFpovA88XA3LWt15y7YbxuDy9foVX9ntoMzvHqGhgR+LmJ+8uhP
	 HNb67hcmI2wckeW65u5kcmL8sU/wqcTorp6fPch6zSnTx9MzUm4Het4j4Nj+wux3Uo7Ov
	 BvEVH4C63k4v5srUwxtPW5Fd8Jpal398jIiLC6SFgcnhDHD59df+k/uSujcDNYEUFM9Zy
	 zaY0nI28/N14BjfYo5PIhbY5FQPRmV+uE3muNWyu4tYt1QLKhTnX1if0USf0xfP1MjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmpxchg.org;
	spf=pass smtp.mailfrom=cmpxchg.org;
	dkim=pass header.d=cmpxchg.org header.i=@cmpxchg.org header.a=rsa-sha256 header.s=google header.b=oQYlrw0w;
	arc=none smtp.remote-ip=209.85.128.169
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69FF606A326
	for <gfs2@lists.linux.dev>; Fri,  6 Nov 2026 14:06:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D69FF606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cmpxchg.org header.i=@cmpxchg.org header.a=rsa-sha256 header.s=google header.b=oQYlrw0w
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-8b309147589so5647097b3.1
        for <gfs2@lists.linux.dev>; Fri, 06 Nov 2026 06:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1793973967; x=1794578767; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eqhBVbUtw3dy734MGt0XscJMrayl/heBjdE55TwHpBE=;
        b=oQYlrw0wlWkN5PyXZYJSL1+ejrbNQUkVRajsXk61r7reY7PI5fMp8o20Z4NyMStlkv
         OFWPg7es1gMOgSjHuGuPXQ4uBeSOhtOxGo08tPDc6ut6drGYhvsZKkAt5FRteCLg1XTj
         h2PThMKdy4eTEPARZFJTK7Xgpv4gCKX3wFY54DwuLLCfUFvmZswDdjOfZ1Go79e65INV
         lZnQmyDAMsclBe7l9sTgMVILtpPh3k8QghrTim9aOt70GiDFhnaj0wMLzZKhCLe+ELrM
         4pGmOypZLVR2uDLggtdMTT/FhnmGDG7ZRZfMPSUXfw8EOvEC2I/KsE2M0wBI5qKYtt1g
         2PKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793973967; x=1794578767;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eqhBVbUtw3dy734MGt0XscJMrayl/heBjdE55TwHpBE=;
        b=oVBxs5dfSom3qoEhCPs9SHXZgUxXHDI61E6fDKSPCQ1QgMoVTs8XZ870YC5S2Fb7J/
         II/ksBvJRyRR5AF9fpWdENWicSV96gcOyGhOwMl74opgIEGk+1lWx8g3iWFc7kVuHOKK
         2ZHm3GbrDjSt4mTQXRUwT2Ui+UPptNLD/Cqwgy5u5RDg/a0At29cVIDggBubqb7bzzql
         3zOycIo9FQIWfJTWl5Um0Enk4zGCK05PsUPPwb3gEVykGXoL0qDK08A+fPtXDQm2OQ7p
         yvDoQUHs7K0Rq8VHeUg+hOP/VYGa76MXe+LCOPyzLlpMlxg2Cmw+dPyCYbQF4g5s93QH
         +h3w==
X-Forwarded-Encrypted: i=1; AL+hErGXGgeTmk1ZVL8qtp2fjsor5T8X9zWEvCpqhlk5aiccY3J0Zn07LpzsfOR+FWPYf/hjxRcH@lists.linux.dev
X-Gm-Message-State: APuU4Z8RWb3eFvvO9NMxiRJvmr7xMP2dkT9KQU9noQcgqGZ33qvuIajQ
	JFk+Q4f7pNWreFQrmQpWzb2LaCBPTkkzwEmEaN38KeWVG0QkrZakXNitPs+uGQ1jTPo=
X-Gm-Gg: AYBFou2jk9iG0Wx6I8/DNvf1qnYUWOUREcGdr9SRqCqMI+QqPqt2bcNUtOQcZVygwJk
	f+tOaRZIbyPhlG6eAKm0H97MZ8UzylKNQSLFN4j4l81e2nlsqT63sFy5VaNUYSqOlzvM4cno4at
	aWhfmEoLwgfW+lmhIX4pGtenNLx/SwVr3v5JAAUxrCyfefwHd+ouwpNFsXnLQ/ABmbF7L4cYPfY
	upcvTvpOsfwwrrNE6rxLNl/mln8W1kbRn7FeMNTqTvf053wX8qKhy9Prk3XWPjzRV3+CRlMp2A7
	55veBdQpJFGZigEdIo59qqSVEYJN9k2Zmh7AX3uAxIN5betuIrUPK6qMEbMHCKwXM+CM5sjdMcf
	VMYff4zrVbrVi/h2kn9tbEkAJONiB5H+It1wA9uQdAi1qQAU5RMHyOG3muGf1tX3H/id45FKxzr
	1s0EG52Uh3etf9/qhuZ+v0ruxB4iftdwl4isW964qNhcsa+cRWDG+ROB8DI8NHc6dF7nu4fsozY
	FTrqyX3S+dqgQ/BRlXm8xiDUOQ3Xy5MCw1+fO6B68/0Cxkq1T7/Y4LGjk8xnS04ouKGHGZwcnSJ
	ZS0eS/+z4DqN4gKHQ5EjPp3PYGZj
X-Received: by 2002:a05:690c:560f:10b0:8b3:10df:54a3 with SMTP id 00721157ae682-8b341b1ebe2mr10611897b3.65.1793973966605;
        Fri, 06 Nov 2026 06:06:06 -0800 (PST)
Received: from localhost ([2605:8600:200:14e3:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b33f856f99sm19108527b3.34.2026.11.06.06.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 06:06:04 -0800 (PST)
Date: Fri, 6 Nov 2026 09:06:00 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Dave Chinner <dgc@kernel.org>
Cc: Kaitao Cheng <kaitao.cheng@linux.dev>, gregkh@linuxfoundation.org,
	arve@android.com, tkjos@android.com, brauner@kernel.org,
	cmllamas@google.com, aliceryhl@google.com, nat@pixelcluster.dev,
	arunpravin.paneerselvam@amd.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
	simona@ffwll.ch, viro@zeniv.linux.org.uk, agruenba@redhat.com,
	trondmy@kernel.org, anna@kernel.org, cel@kernel.org,
	jlayton@kernel.org, cem@kernel.org, akpm@linux-foundation.org,
	david@fromorbit.com, david@kernel.org, hughd@google.com,
	yosry@kernel.org, nphamcs@gmail.com, matthew.auld@intel.com,
	matthew.brost@intel.com, thomas.hellstrom@linux.intel.com,
	jack@suse.cz, neil@brown.name, okorniev@redhat.com,
	Dai.Ngo@oracle.com, tom@talpey.com, qi.zheng@linux.dev,
	roman.gushchin@linux.dev, muchun.song@linux.dev, ziy@nvidia.com,
	baolin.wang@linux.alibaba.com, liam@infradead.org,
	nico.pache@linux.dev, ryan.roberts@arm.com, dev.jain@arm.com,
	baohua@kernel.org, lance.yang@linux.dev, usama.arif@linux.dev,
	kas@kernel.org, mhocko@kernel.org, shakeel.butt@linux.dev,
	ljs@kernel.org, kasong@tencent.com, axelrasmussen@google.com,
	yuanchu@google.com, weixugc@google.com, baoquan.he@linux.dev,
	chengming.zhou@linux.dev, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org,
	gfs2@lists.linux.dev, linux-nfs@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-mm@kvack.org,
	Kaitao Cheng <chengkaitao@kylinos.cn>
Subject: Re: [PATCH] mm/list_lru: Account node removals in isolation helpers
Message-ID: <au3eyCrHiuhbJx3u@cmpxchg.org>
References: <20261103045053.59548-1-kaitao.cheng@linux.dev>
 <aupITfr9pBKPrU20@dread>
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
In-Reply-To: <aupITfr9pBKPrU20@dread>

On Wed, Nov 04, 2026 at 07:47:09AM +1100, Dave Chinner wrote:
> On Tue, Nov 03, 2026 at 12:50:53PM +0800, Kaitao Cheng wrote:
> > From: Kaitao Cheng <chengkaitao@kylinos.cn>
> > 
> > Successful writeback calls zswap_entry_free(), which removes the entry
> > from the LRU and decrements both the sublist and node item counts.
> > shrink_memcg_cb() then returns LRU_REMOVED_RETRY, causing the LRU walker
> > to decrement the node count again.
> > 
> > The affected call path before this change is:
> > 
> >   __list_lru_walk_one()
> >     shrink_memcg_cb()
> >       zswap_writeback_entry()
> >         zswap_entry_free()
> >           zswap_lru_del()
> >             list_lru_del()
> >               __list_lru_del()
> >                 atomic_long_dec()  /* first node count decrement */
> >       return LRU_REMOVED_RETRY
> >     atomic_long_dec()              /* second node count decrement */
> 
> That's a bug in the zswap code. You shouldn't be calling
> list_lru_del() from __list_lru_walk_one() context.

Grr, Kaitao you dropped the wrong thing that I thought had merit in my
proposal...

Dave, would you mind taking a look at my patch at
https://lore.kernel.org/all/auJkvb-Lq0M5Enkz@cmpxchg.org/?

Ignore zswap for a second. I know it has problems. Most of it stems
from the fact that we rely on the swap locking and do none of our own
locking/lifetime on the zswap entry. As a result we work around it in
odd ways. Sorry, you didn't ask :-) That's worth revisiting, although
it's likely more invasive work.

The observation that led to the patch above was a much simpler one:
since we now have the caller-locked __list_lru_del() anyway, the only
difference between that and the list_lru_isolate* is the
accounting. The patch is about one thing: removing the isolate helpers
entirely. There is then simply one tool for caller-locked list
unlinking, __list_lru_del(). It removes an avoidable distinction,
shrinks the API surface, makes it harder to screw up.

The zswap weirdness made me look at list_lru. Consider it a stress
test from idiotic code :-) But I would propose the list_lru
simplification for its own sake, regardless of what we do with zswap.
