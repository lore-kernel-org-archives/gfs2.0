Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE24F2F5479
	for <gfs2@lists.linux.dev>; Tue, 23 Dec 2025 05:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766468242; cv=none; b=GPviUGjKhSHZHME0xjif1BfqdnCFar8lKzJKn2qxAOXo8gRgM+vWVNCbnfznomISMEAIKN6gJwUIXDj5mNeVpBkt91Kz98wZVBMXk6nM7AoYvwMZG1XX0mtowFt/KXRFfxehtpUcYS3mdHz+uO91an2z1rfPVS4aQOIbbPcDOBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766468242; c=relaxed/simple;
	bh=PhRs88mwlwkazk+ENj6MoiJDiZn71PTbJFD0EWthhgk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SofpC52g4DAykYo4BvSTGGNdAtT0gywyfoUPsXFdmiqvjpwyyy5++RrgmbEcsyg00lwPgH4qT1lx6fBvdlbpo7pMB8vNNXiYriOqtdUjnMltWCcRzy+RV2FMUxLOPuLdnILQXw95/k9wL3ZtuDPu4A2RKQmKz7kWhVg1n38E884=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DVDeipPP; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DVDeipPP"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-34a4078f669so4648573a91.1
        for <gfs2@lists.linux.dev>; Mon, 22 Dec 2025 21:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766468238; x=1767073038; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A82QF1EkZtulULncIKG5BayS1YlCBJFC1tpTXCRjsWA=;
        b=DVDeipPPulMcYP234p3wJwRFTSM939pPCrI0ER9RXnHtTi+s4dcOcG1I8CoXOgRq39
         M+kHxanePbS4cbfzY1zmesdq/wv7qkhOhOa2l2nlG7Bn5fTzYq9F73VCkPx2z7aQCabV
         TCqGH/nIrLmIPkihZrij63kcrn5WXSffFssCVqPCEqrmZlY1+ukujYwOR07wPzGR9AnD
         QrCcqLNqcXxhkTYDitNtvoJ3Tl/G7UV7gSQZTDuNcqbltdjvwEWuy4WwxqSj8aJGuTyj
         0G75fDhVnwYz8qQ+E4YPiA9Da5YSMhmrt6nsuj0aJLQ+CV8QraRBr8nHSNuoLFCznvTc
         vRUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766468238; x=1767073038;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A82QF1EkZtulULncIKG5BayS1YlCBJFC1tpTXCRjsWA=;
        b=l0cIqK7yw7yRaiTVK43RogBwz59+R4BKGwawsHphSS5yOkEzZur/FvtNHZOjI/iRL1
         w/hpvULQQ1rA1pZVOcBXYxyBfR32N1hZiNyBU3MtAugfj/y5Ru7uihO2uMgmlSkokSvK
         ogA2Szg88XKSIUPdarZSTqxSt0IKzKMMUl4cUNWKY8cobd+vhrIhqlknbCL+bq52lQtK
         0ag+MNaBxFMd4hEXRU0n67mjXfKIjS1UFoAq+vRqVl3p3OBYLEFA6QCG7wOW6pabKaOs
         kyggNjg0zs1OgzxnI7162tngs8DtgDrURDRLgYjkSUwr3lTd3wyEG/qCh5WOtSCgWDZJ
         91tQ==
X-Forwarded-Encrypted: i=1; AJvYcCU52i01HvQpvIhyPPGwVbnOF3wKrxpo4gFS1iL9s4eRtFFLB1k5YW1K6896kQ5/KOz8OxBG@lists.linux.dev
X-Gm-Message-State: AOJu0Yy2BJVm9uGirgaerLWTTFCLsUT9wiowRglDCwix0ncwtFA9JyND
	SknSow1V5kHB2uG4ZzjgsXEinxMaBJoF4jtIjJ9uJVm03eCixJT8Z+nD
X-Gm-Gg: AY/fxX6sgBDJTq28aZbrQmRkVmkaMRK4X5A7jBsKjepPvLBckQPuKyEUZVh1Ybw1u6h
	lhBvRJe4csP1XzZUpi55RMC1nDt6NCvI0SKHLXFphrtI92xo2qvvbNum6+3JKAGOSyklVdUTQ2E
	YfENPxNhQxUm6KG6JMeybTeBMcfsih+ewneO8uEO6Lp72Jhbg8RZKSwlsaS8QBgdlLYVWRBVEIE
	wOcOmQZecZ+wGeqHA1kO0QInMsaYBAQpONWT2BrKj0qtf3N8jS1HsCFSgoBrZ18orE3ZFb17cNS
	etXZpR3icGfj0s9rprhKFUHapMS7yYy7BuQ6qQOe+Rq+jj4e1hC567QQqW6wXRXyKIOIoBB9boP
	mQCiCJspYTEoOWFRJNeVUJF6IvgUf4l+zIG52nWI1yHglxAhmWfXFH6hwyFc2/ku0VXDWKPTEf5
	no7BWFo8K9fXWeRmLVcHw4UTDNmAkG3nkxOK6NkA40QHSvewnwj63teDo12hOkwQKhywZkY8B7Y
	4c=
X-Google-Smtp-Source: AGHT+IFuAa1bEi9iXQ/fVsFOwY92P7NTqag0Itb/bLEcgCW/+Bj05+w6CIPRTwzaf559s5BnxudUFg==
X-Received: by 2002:a05:7022:1e01:b0:11a:5ee1:fd8a with SMTP id a92af1059eb24-121722ab372mr13830811c88.13.1766468237569;
        Mon, 22 Dec 2025 21:37:17 -0800 (PST)
Received: from ?IPV6:2600:8802:b00:9ce0:637f:5cdc:9df0:d9ab? ([2600:8802:b00:9ce0:637f:5cdc:9df0:d9ab])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724cfd95sm52514131c88.1.2025.12.22.21.37.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Dec 2025 21:37:17 -0800 (PST)
Message-ID: <5789c903-d3f6-4c41-b342-8d29387688e5@gmail.com>
Date: Mon, 22 Dec 2025 21:37:16 -0800
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/11] fs: add a ->sync_lazytime method
To: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, David Sterba <dsterba@suse.com>,
 Jan Kara <jack@suse.cz>, Mike Marshall <hubcap@omnibond.com>,
 Martin Brandenburg <martin@omnibond.com>, Carlos Maiolino <cem@kernel.org>,
 Stefan Roesch <shr@fb.com>, Jeff Layton <jlayton@kernel.org>,
 linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev,
 io-uring@vger.kernel.org, devel@lists.orangefs.org,
 linux-unionfs@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org
References: <20251223003756.409543-1-hch@lst.de>
 <20251223003756.409543-8-hch@lst.de>
Content-Language: en-US
From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
In-Reply-To: <20251223003756.409543-8-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/22/25 16:37, Christoph Hellwig wrote:
> Allow the file system to explicitly implement lazytime syncing instead
> of pigging back on generic inode dirtying.  This allows to simplify
> the XFS implementation and prepares for non-blocking lazytime timestamp
> updates.
>
> Signed-off-by: Christoph Hellwig<hch@lst.de>
> Reviewed-by: Jeff Layton<jlayton@kernel.org>


Looks good.

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>

-ck

