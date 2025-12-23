Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E812F12AB
	for <gfs2@lists.linux.dev>; Tue, 23 Dec 2025 05:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766468186; cv=none; b=a7MAP22zs8ASFrolELvSdIDcUD8zek1LREa/YTZ8BXRq5CMOJpQSfZBiFLHebbbn+hgZ3D8wb+DxKPtsHv0wc2hSNJtoVhM00H9X/U6sTLqkTiILBzVB9dbp8++8GEvmCiWBIAt3fn+Dtk79Q7vlgfoyMojStqQVDxCg8KQmEZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766468186; c=relaxed/simple;
	bh=VlgqwkzGyrE3K5mQqCM6bG2Y747dQIeSyi7etFJLJbQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b5J0O8oEZAhugHGpN9b+lr/1TLcO3InXvIT1u5kK7uqXdUMaLylABdDx6jxWjeP8QXkP7GScmus3/LzK1NZwX23ddOX50QRFByCxg09ma7r1HAjMornyDPqCG84xejI15t72iJU3OIGCeZ8Bt49K05j8iSnKAIi5kOLWGY87k7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I4P/VdFu; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I4P/VdFu"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-34ccbf37205so3490884a91.2
        for <gfs2@lists.linux.dev>; Mon, 22 Dec 2025 21:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766468184; x=1767072984; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VlgqwkzGyrE3K5mQqCM6bG2Y747dQIeSyi7etFJLJbQ=;
        b=I4P/VdFuAvZKd2Ym09roskIZsC6lllOPnfup88XZLtDSD4oFAVu2LGb4cCvdZ9WEEM
         gU8U55B4Ks1xM36XfkGLE4W2r6qZZfRafW55IZq6QciUI4Co2eDqGujdLtTCYm8ROASQ
         /s+IZbNA9CWPXgSCv8UAto/qWzYano5fVyZd+MHLoPq4sONGDOaaNQXC2FddXkEbMzaB
         v3md4Wdhgs6C5al2XeotRzmbjYF+Id0L1hVsWT6Z+dOOrI7IKkTzsyBYNHUrxoILylfi
         lqItVeEXcxk/GVOUyMvomI2jgGUm4brOlUaD2P0wwzz+ys12e6EMS4t5YXwVZHRfQQah
         V6kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766468184; x=1767072984;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VlgqwkzGyrE3K5mQqCM6bG2Y747dQIeSyi7etFJLJbQ=;
        b=WWTleWEQc/GqVIyv/kOviLJi/gWOX5SzfRjY8wtFwV7pK8qwQWJvZZ8xiCko6voidd
         zSmWMDo+jLKHeJ0nU/8fxTatb+oX87xLkhv3QeFXcXP7Tv2q7qUTu1D12PVTUvmqLdX5
         s3Ut73es5F1oi5ze5YUC+cnWkH0UWbu6jUAjOMc/u97fGnaOv3bCiuQ1HYsIILVXfu9L
         oYPnYBnVP7QsvINpwrEIIORH3q+iB/6RRuMfT8Y3HDiv4fQi3fE/es2xPkkZv5E4Z+/d
         fMfW0Ap1749IMwnX0TUwmE7UTS0hDMQ9X65cWi4RtOK/v7WMutiGkMCQ4r07DGRUTMD4
         uRvg==
X-Forwarded-Encrypted: i=1; AJvYcCXAXgfk1vT2PJ0wzoGlbFc4sNMfJRz1/SSjwiMvXAoX5nSjAutTKGF6aqcy/SZFZitgEcdF@lists.linux.dev
X-Gm-Message-State: AOJu0Ywe5NBjloCPkmGNhrr2P5J7y2I/uY+RBWHzDcv0VBucZv9AsB1b
	Zvgg2W2H71jJKMleyDYSnGfKQLMziz/bLwzejTJlNAnlQSAJHXAITA3Z
X-Gm-Gg: AY/fxX4v4Gozc62Q+9r0DdUtUz+p0Zjpv38Fb14fSkNXW8T0NkxfebixildcbyN8pPz
	kYFVyB0OMfj5/EEMcnmA0WDHwalx1ArOjH2qi0Kt04xGYNgYjpUINllviDOG1IDGjezmCSLW2oz
	MdlT2EUeH9gYwWxWm+sfkD4TN6pkHZPq/JipaqUh+ZfUZsZCSxNwtRwgfh1+q+XUpGvyfIznf3o
	6dEfZFco5bt3UhTGTJqznK07CfKSNvAsN5TzYMvs+rpmJUNoK+wFTE8bbXlyoQBFWgXKs/0dE5a
	pVH7k8tKu4N3ZuRYcR5kM/ff7hIqq937YVwRaCRKRYSqtToqTFqkmhoYgvMbwjB+dSpRSriI70c
	TvNbrWh5uTddH6g8HPTRsFnJwh9k06Bx9scDTEZFY2m23MG+0h8hjCFDFTNoDCf9SAwc587BbcZ
	AFMs+xr0MN0+SbhTJExKkkZhL68wikoVL/FD7euYbtN1i1u2bjFomukr3S2i6JKWvI
X-Google-Smtp-Source: AGHT+IFX/6+bwcWXg/4km6FqYdkuwnUGcop1hJcfw4hTgcVNu0v2yNrPtPf/mgK+hd5hIFUJyC/N+g==
X-Received: by 2002:a05:7022:3705:b0:119:e56b:91e9 with SMTP id a92af1059eb24-121722dff1cmr11158229c88.26.1766468183950;
        Mon, 22 Dec 2025 21:36:23 -0800 (PST)
Received: from ?IPV6:2600:8802:b00:9ce0:637f:5cdc:9df0:d9ab? ([2600:8802:b00:9ce0:637f:5cdc:9df0:d9ab])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1217243bbe3sm54039368c88.0.2025.12.22.21.36.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Dec 2025 21:36:23 -0800 (PST)
Message-ID: <4e5f6df4-b446-4ec0-a0d9-231756ee934c@gmail.com>
Date: Mon, 22 Dec 2025 21:36:22 -0800
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/11] fs: factor out a sync_lazytime helper
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
 <20251223003756.409543-7-hch@lst.de>
Content-Language: en-US
From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
In-Reply-To: <20251223003756.409543-7-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/22/25 16:37, Christoph Hellwig wrote:
> Centralize how we synchronize a lazytime update into the actual on-disk
> timestamp into a single helper.
>
> Signed-off-by: Christoph Hellwig<hch@lst.de>
> Reviewed-by: Jan Kara<jack@suse.cz>
> Reviewed-by: Jeff Layton<jlayton@kernel.org>

Looks good.

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>

-ck


