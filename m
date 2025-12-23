Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5EA2B2D7
	for <gfs2@lists.linux.dev>; Tue, 23 Dec 2025 05:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766467989; cv=none; b=dXMhL8c6Vija1lOfPJ9YPUR9ea65pCQUQRZcEbNY4gMZaI0ZACTsCxcDYjLbsRL6s9vAD+SCtTQYzTBtG00l8n1q12SvFHH+DPPpVXh4vOZ0B8Ak350o4CtMC17iQ7hmVgXUHqGjn1lqVEZV1RJOmRpCHlKINx56TNe52aTV0XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766467989; c=relaxed/simple;
	bh=NqkuKEROb/OmRVYRZgeOKw/Kls8Un9PKgqEiKcwkGnk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kHxOqfZAiNtkWyPIGGjp2bHSTBpIyYRcw07K9wzO/1DdWvaXY9I6Q2NxByG3ovDNdg/2ZgMQarX3FTooCDaqIdh4+RoxYpA0QImX5UlQjZYSSaWo7d9RHTE57ZG6MBLnD70O0uBG0toH8MMtMMfF6qZTSz2tmAFbhuZgySZFFKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aWemaWzc; arc=none smtp.client-ip=209.85.215.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aWemaWzc"
Received: by mail-pg1-f196.google.com with SMTP id 41be03b00d2f7-bc29d64b39dso2482141a12.3
        for <gfs2@lists.linux.dev>; Mon, 22 Dec 2025 21:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766467986; x=1767072786; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NqkuKEROb/OmRVYRZgeOKw/Kls8Un9PKgqEiKcwkGnk=;
        b=aWemaWzcgkBAt8CumoRFLK1ejTswB/cev2dcIQN6t01gK6gcqzdHqtC7j0jQ4UXqpa
         o/YB5ohzsrdU66k3ey/snYaWkZAKZ2IJQzWVsv5GGDr9DL53B36Z7Q4rWVwP9Hh/Pi9p
         dA5i8Hqq9VACl55yn4X386n+bisdruxaR9cQ795v2WcAsZytD+hTwTThs+dbyFBBrWRG
         bba3GJdH04b+olAG6tEHSNmVwjfEwJnOjnuNNOPrKwCiPAzWnun7k6GkCfJt1fjbJoYv
         jRpQCkZT9iVNyEnRdSWsyxS8Urx6UvtVakmgqVbp2IcWp2OMObsFPZEuKC3LzwqR/35J
         C2kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766467986; x=1767072786;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NqkuKEROb/OmRVYRZgeOKw/Kls8Un9PKgqEiKcwkGnk=;
        b=LhWQLR9YMSGqR5e0tlpg1PoG09HVpcvBlraMcSSuOAhkhzYACEU9DwbSoDHyWewwhf
         en5tTXYc7iMbnDJNvlopOWtOXjt1JqyJ3uSW6IXVia2nIfZ7zy5O4MtdMT0GxYAifHqh
         0neLQeLozw4tLJlaShRQFJHj/LmP8B+7oF52bV0nlYcGqYeZrHUA5UG8jkecgW9VACiF
         42tShuPBLsFylrCRA6Bx4s6C3eL9QpRbVC7acl1oDXCDgSzE2GCow2cj9LBbzCLeIclk
         0JRIQYuoNcjsY+NfjtJK8+gOm7IFEvmg7A6zFMdBWVJvoQwTPxJpI3Pwg1SSceNMieWu
         +86w==
X-Forwarded-Encrypted: i=1; AJvYcCW1lSjae71MJGSN5IonVKeuWtc7ANxt+yH+lkNz0sjXYx5YXSlUXdVyheRTGKt8iUlMQHyc@lists.linux.dev
X-Gm-Message-State: AOJu0YxRUG+oBxlT46QIrcvdriT9571siVyHWGwrMQYHxu4pu6qXbRgC
	m7iPz6wQ/LfRhD/l82VJBiu2h2lw4oYOagblMl//p2jNMmhSnjqk3TRb
X-Gm-Gg: AY/fxX4Y77IyE3Z9cc1RRVPLpoFGbMwYiYFW/WYR8FftZokWabZNkXIY6DIhSQSIvhf
	l0ag+KsjJ4cPqDySazXwnRhKK/Y/B8tGp3ZQldZrlopl2RrZCZUCOh/lbYhevhIC2/BQdJ0lUYK
	6vxfAQsm7oDYld2zOJW4S0WUw4M70I0s+ctdGMsHZEC/TYM2Of8b7qJlCKhR7ZqeWWAZgtWKkH6
	guI5Ae+MBtjDfIm2qUasQ+C0EAl+aZYGik3NM7DVRo9j3hBXD2hRnmv3GvXJ1Vv84WT0p8LKohV
	BS2sBVRAAupkKR53F8xsaWKXuq6r0eVMZVpQgDU5Aj2xX4hymz6DNYHx7THMUXhM+O8rDJF7RHm
	IeOWnPhh2KERsXLRy7gfTSqO7kPxMlUY69B6yOW5R3vznb9lpzNyfUyvVIRqgj6ljJTvhOHwIMh
	QBNN5mh/g58NPgw/An09Qbg6Yvxft5TbHRrMkCs539Jt9YkdrGvThzEViyN2qFXTC2
X-Google-Smtp-Source: AGHT+IG5Qf4dCPxqVYyhhZiZ2cPZHWZcc5Jl8Dom3Sf+VbFYEbzUaslYB9RlXBdrrGXOm7O8E9bw2A==
X-Received: by 2002:a05:7301:1a12:b0:2a4:3593:ddd6 with SMTP id 5a478bee46e88-2b05ebb6038mr11158060eec.3.1766467986000;
        Mon, 22 Dec 2025 21:33:06 -0800 (PST)
Received: from ?IPV6:2600:8802:b00:9ce0:637f:5cdc:9df0:d9ab? ([2600:8802:b00:9ce0:637f:5cdc:9df0:d9ab])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1217243bbe3sm54002618c88.0.2025.12.22.21.33.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Dec 2025 21:33:05 -0800 (PST)
Message-ID: <12bb96b6-1e2e-4f53-b4ea-1fae2500aa21@gmail.com>
Date: Mon, 22 Dec 2025 21:33:04 -0800
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/11] fs: exit early in generic_update_time when there is
 no work
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
 <20251223003756.409543-4-hch@lst.de>
Content-Language: en-US
From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
In-Reply-To: <20251223003756.409543-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/22/25 16:37, Christoph Hellwig wrote:
> Exit early if no attributes are to be updated, to avoid a spurious call
> to __mark_inode_dirty which can turn into a fairly expensive no-op due to
> the extra checks and locking.
>
> Signed-off-by: Christoph Hellwig<hch@lst.de>
> Reviewed-by: Jan Kara<jack@suse.cz>
> Reviewed-by: Jeff Layton<jlayton@kernel.org>


Looks good.

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>

-ck


