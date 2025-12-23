Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462522F12AB
	for <gfs2@lists.linux.dev>; Tue, 23 Dec 2025 05:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766468172; cv=none; b=O+Ugl5W6/TFJ5RSrQgXjbJ9HdvqwNoAI96sCfSH7OwuWhXUXS4dmWV0983/U7AePcNiAyDbYoOqa/rtLCuTyQiAtpXFm5JfE797qVVTYY+aWzJBl3ldGh9E/bqTVVLZnxAHtRq4vdagY8TGytBzh/XpKNbcTtftP8Se5oMbKQbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766468172; c=relaxed/simple;
	bh=lW+UmIWRSVZ7zpivjjDN2RAk8y2uECMzZoBmWD3afKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CqRfc5Em9OQDvMJ10+suYMjPgsSttdDCyEA1LFAYHB/whnLa/lNjpir36vZNB+hUn2JiCwG4xrX8DYIfJgTNIK9e3DBRN9Wz7SQuIe1cC8KwENBCB7yP7DpeOXZJrYiKr/Ow/BgX0iOEx4eup8SE+5WrGAjGY9blJyGiIRixMG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ckKwu8ex; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ckKwu8ex"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2a0fe77d141so49841965ad.1
        for <gfs2@lists.linux.dev>; Mon, 22 Dec 2025 21:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766468169; x=1767072969; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lW+UmIWRSVZ7zpivjjDN2RAk8y2uECMzZoBmWD3afKc=;
        b=ckKwu8exRG+x+1X6793LIZ98dUb+SIVujbGKxxy1SVNXcFgdVIqMoqxslW2khgWx07
         CbHjmVxFizoUeBNO6TvB253ESGl7cRRLywqIbm3ZcwHSkTSRaI41naL309Ip3ZjyhFCI
         ci9pfCln0mYEBnHNCZd8t0MTxmDTHv0dHng4sN+LFT5xuQLQceImkSHR4ZaCoP4x2G6m
         /jiQLCMui/Abf9XoNVl4uI0Z2+fZZ//xUjPMKWi9iu9j/kRgYuYol/QVRgdh3TCU10CC
         b6r4q0OKxIsJV/1ARLIMG3d915DfjyyFLoEE6Zj5afwJOi3Rczn7+lolDIWWJWXFbwLp
         mn6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766468169; x=1767072969;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lW+UmIWRSVZ7zpivjjDN2RAk8y2uECMzZoBmWD3afKc=;
        b=D2Bj0INbzdL+icjXZLZ8HP7eVq8nzUdRA3gyn1t9OImQHiiOb42lCbIWBylW7NsRe/
         DimnhmYZOYUSMk0T+VkSOvXdcDuoBRqOeMCH2Acer36a4Fh6DGSmt3UW1oE7SSRUjbwH
         ZDVn7wVuT+Sxtfq8nX9TLdY7dh4rTGvMciQp62enKTzD0NCenXJcr0kvhh7GkHsui5ke
         FjXm7/NThu5iyaTjsex2lBQRIGOESxxC5HTjyjw/eobPymrckCUF5M6U7B4EgxW1T90u
         00OJLPHW/URmPs9wg/9ECHBfxxL/4NAfGwOOFQhUPUEXRYGj0a8VVbKA129R9nbBnt4A
         T3WA==
X-Forwarded-Encrypted: i=1; AJvYcCUBuWjfm+8LvKiS18zKH+QNfgWK1ux6Nl2X3SBVR1ucdLNd582oqqZsoI7Y6ROCFvaIy1/7@lists.linux.dev
X-Gm-Message-State: AOJu0Ywlb1fzXrXA5SBRo1YCNJqrBzU8aEAq1OEFl7TxWv75bB2nrFWw
	cNncNEDbZfm4TzTCoc34NVpKM51wxDKL8Ur2Xj//PfF4h7b3OVwWIlBn
X-Gm-Gg: AY/fxX57EnrRUdQNxr5hfR9wR90X3FHYu0cKTFOU4J134jd9+yqLraAJtqbA7t63R2n
	yR7+vN77PUqDPseZr8h3SAMmh8CAY6svmaXSHSYb6xACEbDAUPCPnixlGyiN6g1YIDG613y2aEp
	MCPS8XofFia1OY9JxsPffF4nJvrEgtmvqveSiJ3IxdxlOp6eDi+iP8W2nru2xsJY79dsxdGAyhl
	FkFSXaxd9O70DDhGqKqqZPtrBoIbroQIdVcpYtYaKW2wkMWZBVZTU7NUCWdlXbTm7IYX/n264LQ
	OnfJY/1jnw1u/nNA+EtsGtrn8jm/UpCs5+6IRKji8WF/U05WNkpOP6XKkEzF7uheGT4C9WxFdtM
	lRH2rJ/N5NaclcH/DnkQIb9R1ZcaI+/zi4mxfnIaDKl0GMYxg1NF/lm4K7R6GvdabsOhjJzOfJO
	Y7kfp048+42Mf9VqnVmpxip1cPymE1OgX21Ayu62gSgoxslj5L8Cyy+zBlKaCjleVs
X-Google-Smtp-Source: AGHT+IH379xsDZ0d7vjKdC6ERRiENfgRNsDKq+A1tK8cXdwsmB2ywvOol5d1N83fquxU7SkCjjJrLg==
X-Received: by 2002:a05:7022:3b8a:b0:11b:79f1:850 with SMTP id a92af1059eb24-121722b7f23mr14589383c88.14.1766468169469;
        Mon, 22 Dec 2025 21:36:09 -0800 (PST)
Received: from ?IPV6:2600:8802:b00:9ce0:637f:5cdc:9df0:d9ab? ([2600:8802:b00:9ce0:637f:5cdc:9df0:d9ab])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1217254ce49sm52556580c88.15.2025.12.22.21.36.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Dec 2025 21:36:09 -0800 (PST)
Message-ID: <e2d34cef-c0f4-4f27-91a0-439f85ed26b5@gmail.com>
Date: Mon, 22 Dec 2025 21:36:08 -0800
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/11] fs: return I_DIRTY_* and allow error returns from
 inode_update_timestamps
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
 <20251223003756.409543-6-hch@lst.de>
Content-Language: en-US
From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
In-Reply-To: <20251223003756.409543-6-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/22/25 16:37, Christoph Hellwig wrote:
> Change the inode_update_timestamps calling convention, so that instead
> of returning the updated flags that are only needed to calculate the
> I_DIRTY_* flags, return the I_DIRTY_* flags diretly in an argument, and
> reserve the return value to return an error code, which will be needed to
> support non-blocking timestamp updates.
>
> Signed-off-by: Christoph Hellwig<hch@lst.de>

Looks good.

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>

-ck


