Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883A522D9E7
	for <gfs2@lists.linux.dev>; Thu,  8 May 2025 13:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746709824; cv=none; b=gFZExt8IujG+gld8MOPfr4/2GynKwln5wH3aIDgNr8HuAvtuuf5Bqw87KNQcqWD/mN+smYEha7+vvgUFERoQjHcclrBSgcDGKeb55IJmM6YtlHfMyM9YFgm7HDuE+sWUa98Pzc8wloi3Yxj7CbJUTZY1TGFasnd4S0uuKm99tm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746709824; c=relaxed/simple;
	bh=p3igjo1WeQ4ei3xNoOb2bq7IvOmv4IUIwEwUY8QYhsA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jkgOoQCtjaA6bF2tKV13K7V+maAkR5GvUBMDWLwn+qgOPylfxcsRhUO+P31oTwGSSXZFBJVW7D4H/uU5OTDA5i2y0KAALk7CL2vUxQ0Ze+ZRSYK/ezTCzPRj1CZAPPN4SZoaOvyRuAu4fV7GbvKKYb9jZo13nQMgZ3TMR4VAZis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=k9GBu8Dd; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="k9GBu8Dd"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6f2b04a6169so11246406d6.1
        for <gfs2@lists.linux.dev>; Thu, 08 May 2025 06:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1746709821; x=1747314621; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XTDtbe4K12xhEpViDB+3A6qWj2g+MO64MrS+vZvyuzM=;
        b=k9GBu8Dda6Zd3Ev7Qo0uONa/telNJo+KipihTka3942F+3ykDt4zQ2WYAQ3YA/lM8J
         rGOD5IPuO0WEC2Jem/hUqYp/W4oaGrd0TQSTFUefmTWQ/7JhSKm+LXwv6CpxCTjbpYqa
         ZQk94VZzhSmKmiy8vhKWjgqp51/pzsWzm1yxj/oMB5a77C0Iu7tpy/AaKObc6RDzRcpO
         5/T+7Y54TN61DYtTpvaRtQUVuT6j7o1hLJKMk2dbu9aVjTrxGvWwbkqDvKcEl3S9UOg5
         f0NcQY8d7YKYmB5I90fXwRCdxabztyMjJMQt6gaqesAuo4SAQc7Yjk7Ddl3e+j46nWpH
         bijA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746709821; x=1747314621;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XTDtbe4K12xhEpViDB+3A6qWj2g+MO64MrS+vZvyuzM=;
        b=CU6ymuqOzRqAcjxZqVj86h0DwMXl6qP6YrLo0dDdPaQk64jWOW6suez4pDn24xFVW/
         HJH3Likk4RUxt3rZoQoGnje4ikNUvQbhGiD1akv+gO/0Dow7TbO/U4d++adzU47DeYjJ
         G3kGYC/c2txBeKumvTSTqtzOELSqCVgCMNUU6mAdx0mziViHGqIp7rci8PKXOlr3tKYN
         VBhyhXzijEPuK6l2f2MfOnzAThv678yBWo36xfd7o83ok9eZUlECz9PZS33z8X1E5kzU
         +PC2p9s4L9NywXxJCdoAz2P7kwkzdOx0s7Iv7dzE6PDtGzNGDzNdgkPhImGqDtA3Cm5C
         cORg==
X-Forwarded-Encrypted: i=1; AJvYcCUJCVZudLv9yeys4LDNodGQ2S8dT8UsNLjBTZiFDEWjz4YmerxqWMVZCIBVUD/vJ/HAvnGG@lists.linux.dev
X-Gm-Message-State: AOJu0YyLTPnYyTiMzq8vbzTmWIWui0xQkWOSGKjTscADuc8D+lnJFnXZ
	BZH6otoOgihhriq2s1G3XlNJP8k0/EKS1Kb2KPKlvd4cZpKfiH7+F2lqt24gwYncwB7WmuD50S8
	q
X-Gm-Gg: ASbGncuOMNHHMOskZUEJQNvdgB6cl8fNL6wiLrgjQ/RxIRjfF5qDGiSTPfotRxH4gLN
	F6ZYmoSxiMuTzmc3W9bxcy1AIXgUDcjMYLjSjP5/c7Hl+GmW6RhxuxhqRUjXD789dagF7Iwm+cC
	Vz+Sj4+ocGY7BKyjp5hHeqHV72sL13RMMKxdNgTleTF3PVQDLAsHzRUE04IEZtqPmwsPxYsjtKm
	II5XaWhb4ncZ8n4qQwJqxjY1kip8ObRrBpb7FET+cYI+oVX2YS/NFmmID4fazbKdoxTJp1CCJwj
	n5VkoE5oCN1/8E4JCaEjTXdPwWEvFkrwnr1H
X-Google-Smtp-Source: AGHT+IFc67B3rj29wLwGe5b9hNdUhbBaJDAFmOrgjOa9uQdS/eOlhjhIK4I5PRu/Z5lCJQDbW0IFWg==
X-Received: by 2002:a05:6e02:12ef:b0:3d4:6ff4:261e with SMTP id e9e14a558f8ab-3da73867d6fmr68904585ab.0.1746709805765;
        Thu, 08 May 2025 06:10:05 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f88a945471sm3173148173.70.2025.05.08.06.10.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 May 2025 06:10:05 -0700 (PDT)
Message-ID: <0df727b4-c0fb-4051-9169-3bd11035d3e0@kernel.dk>
Date: Thu, 8 May 2025 07:10:03 -0600
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/19] block: add a bdev_rw_virt helper
To: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
 "Md. Haris Iqbal" <haris.iqbal@ionos.com>, Jack Wang <jinpu.wang@ionos.com>,
 Coly Li <colyli@kernel.org>, Kent Overstreet <kent.overstreet@linux.dev>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, Andreas Gruenbacher <agruenba@redhat.com>,
 Carlos Maiolino <cem@kernel.org>, Damien Le Moal <dlemoal@kernel.org>,
 Naohiro Aota <naohiro.aota@wdc.com>, Johannes Thumshirn <jth@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>,
 slava@dubeyko.com, glaubitz@physik.fu-berlin.de, frank.li@vivo.com,
 linux-bcache@vger.kernel.org, dm-devel@lists.linux.dev,
 linux-btrfs@vger.kernel.org, gfs2@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-pm@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20250507120451.4000627-1-hch@lst.de>
 <20250507120451.4000627-3-hch@lst.de>
 <a789a0bd-3eaf-46de-9349-f19a3712a37c@kernel.dk>
 <aBypK_nunRy92bi5@casper.infradead.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aBypK_nunRy92bi5@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/8/25 6:52 AM, Matthew Wilcox wrote:
> On Wed, May 07, 2025 at 08:01:52AM -0600, Jens Axboe wrote:
>> On 5/7/25 6:04 AM, Christoph Hellwig wrote:
>>> +int bdev_rw_virt(struct block_device *bdev, sector_t sector, void *data,
>>> +		size_t len, enum req_op op)
>>
>> I applied the series, but did notice a lot of these - I know some parts
>> like to use the 2-tab approach, but I still very much like to line these
>> up. Just a style note for future patches, let's please have it remain
>> consistent and not drift towards that.
> 
> The problem with "line it up" is that if we want to make it return
> void or add __must_check to it or ... then we either have to reindent
> (and possibly reflow) all trailing lines which makes the patch review
> harder than it needs to be.  Or the trailing arguments then don't line
> up the paren, getting to the situation we don't want.

Yeah I'm well aware of why people like the 2 tab approach, I just don't
like to look at it aesthetically. And I've been dealing that kind of
reflowing for decades, never been a big deal.

> I can't wait until we're using rust and the argument goes away because
> it's just "whatever rustfmt says".

Heh one can hope, but I suspect hoping for a generic style for the whole
kernel across sub-systems is a tad naive ;-)

-- 
Jens Axboe
