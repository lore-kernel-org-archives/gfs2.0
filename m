Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C8F1487FA
	for <gfs2@lists.linux.dev>; Tue,  4 Mar 2025 03:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741057635; cv=none; b=jPytU6VtsMrCTNRgy/zMyZMqA7aMujSVSVTDWj7AnUbpszLT/YjqO/LsBen48a5BLBOjMrCjJWEyNbdQpabGQGDDfMv/qRbScgkmBWi+Ns8kCY43tBAmJNl2iihLDVCGg2BcVRQwW+tsH3wBSHc6YcB1LuwdkfEYuwE7FeNxzdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741057635; c=relaxed/simple;
	bh=ggJb4jmnSYgRJsl1W4s2SdWzsoJ1mvK3FVywE6dYGSU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RRCID15q1n+/IcTAZcY2SnlyHGv37n31Q9REQj8voXCXqgMWFwpaFK5ue5NPRYY+jHkx9yJswYY8Z2W20FeOXDdr6E129nf+XuBnNCw3AuMx2AZ9uEojR1HVsatszxqXXxy3/Ul9PqaBql7jTt76VpHHaM4D8nLFJDvLnXWYzz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ILQiE/NN; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ILQiE/NN"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e4d18a2c51so577311a12.0
        for <gfs2@lists.linux.dev>; Mon, 03 Mar 2025 19:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741057631; x=1741662431; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wUCE8GWBBfBS88m09tYyeVsNFif8EE5jbTBVVVjwG5Y=;
        b=ILQiE/NNPw7kcrl/Vf7h7HMVBk3mIPlY08JLZW6QfBtDAZ/TC4C+s7/h31WkZkQAPm
         35vuZ7JneB8Bf/vk+0khLy7SAHj//2OwtY4xPPKgfdgB3qSSgC+WHLvXsy4oLkqM8sms
         45o6IWOK5s6cJWLJisZ+aqVPFWgEIxu/Y8AWFHq/8elMGGZkyUpeUAImRIxV/F/uaT9h
         F/XTnqTXkRx6hk4FqgbtxVFUc2Nzd4Ejs1OMjFwYymP9ntKcGy1hZxZ73xkx/FvcgiPx
         1+UwLAI4rGXciZVsDctrd+/ddMsWG1bDPPlRRlULFtCbsDAU3GcNtJPHUeyMZDm1FbDH
         uTzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741057631; x=1741662431;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wUCE8GWBBfBS88m09tYyeVsNFif8EE5jbTBVVVjwG5Y=;
        b=Sc5rg9w08/3lhUhL2hih0DFR7664Br31TuuPXAtm3UXZwJlEVv6rtZScgxzNsc5hm+
         d37wBSovVRQoR4Qr//9qdo81NvluS3OAPBB7jk5ZNyltZ4CBXgJB3CmFkMbqKyvCfIxe
         KJSMJ+mTzwDOtuwZ6Za4vyNwTLevLYlfEXVYsVNrM7x2l5fEUgXZMtbkNCA7acz8SiHM
         2PVXqNGJKiQnmu5AsBXRgBIE7M22DDQxQ11oVL/8k1NXVQs5bbFErLqvRlDfuu0/6uwk
         vbuyj1B6tLj0lbxESnVpIlC1pF7zQMs/4AW9SkJVaESBo6pAxp6H26aGaQs9AaTMXb1Y
         bGHg==
X-Forwarded-Encrypted: i=1; AJvYcCWhuxskpHnhd50uAQ2I3n+8s7eex/EW3BGs6HXe4Um4HYW7F/LrTC5xizYq5wVPGErhI464@lists.linux.dev
X-Gm-Message-State: AOJu0YyAEGIhZ6/SY+aJGLKyApKgRkPJUeIe7rmFoZCTbf5YCjSntYid
	Fw8mESJexC/LE7uTMQ+uQ8OwaYtNvvTEGcRfVwiIG4CBej+LNCjHSfEjLCQFYKk=
X-Gm-Gg: ASbGncsnLyF0HUh5Ba62phsXNEIh9A0tQHYLK3+CgmnUrZ5SlSo18Lkt6i/BGLYsU99
	XKCqlRlN+IykEZq4+UOgUyo0xW3wTp14XcnekydLYgfKWPewNn2ugI+Hw6ED6HKA8z7NasgNRM3
	jz/KkBA1nc5nRLHqn5QViisGOecpn5hoVyfKGxTkXNYNbjMLT2PF3hQJ/CgNqEnuhiASYTYn4w4
	qPUuD8BvXCsdfIDC26IN4dRb5GrIoQMkpaEE4eZa/P+lg8FFa6emk6M3dbsMeGZxvSs/jRgwZ6B
	PWjMv2fuWBL9XeBluORoa1xG6Sg1Degvjhv3xgOxyyMxPvkL+ws=
X-Google-Smtp-Source: AGHT+IGrDb7zBwU3Hh6dSGJGbiWBOtRkjsJvX+lXgzsPjucuetSi7030V8s6dgYMciXwO8B7FPN4YQ==
X-Received: by 2002:a05:6402:4406:b0:5e0:e845:c825 with SMTP id 4fb4d7f45d1cf-5e4d6b98391mr5925527a12.10.1741057630685;
        Mon, 03 Mar 2025 19:07:10 -0800 (PST)
Received: from [10.202.112.30] ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2235051132asm84779535ad.221.2025.03.03.19.07.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 19:07:10 -0800 (PST)
Message-ID: <e5a4315c-c608-4133-8e1a-fc14c29d1594@suse.com>
Date: Tue, 4 Mar 2025 11:07:05 +0800
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dlm_controld: Support for extended value of kernel
 DLM_MAX_ADDR_COUNT
To: Alexander Aring <aahringo@redhat.com>
Cc: David Teigland <teigland@redhat.com>, ccaulfie@redhat.com,
 jfriesse@redhat.com, nicholas.yang@suse.com, glass.su@suse.com,
 gfs2@lists.linux.dev, Roger Zhou <ZZhou@suse.com>
References: <20250221150937.21642-1-heming.zhao@suse.com>
 <CAK-6q+iiMqW9eknqgVZiKjeUgSEAkL61Q-EbP8xwy_bayjS=fA@mail.gmail.com>
 <Z7zJ6OQIzC9Q20sG@redhat.com> <456aa9b1-a197-4de4-a062-2fe11bdaf179@suse.com>
 <3a8cbc24-c024-48ea-869f-687ea740ad7d@suse.com>
 <CAK-6q+g_bdNoptQ_bPUbzE9uL=strr6utQ3jM_1fxoMOpEjA7A@mail.gmail.com>
 <468a9169-3de2-4226-8aa1-61e0e211e4bd@suse.com>
 <CAK-6q+jEhV5hQSjZu6xj7Ap8FzzkFosQ04X+qH2MW8+MOd8Zvg@mail.gmail.com>
From: Heming Zhao <heming.zhao@suse.com>
Content-Language: en-US
In-Reply-To: <CAK-6q+jEhV5hQSjZu6xj7Ap8FzzkFosQ04X+qH2MW8+MOd8Zvg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/28/25 23:34, Alexander Aring wrote:
> Hi,
> 
> On Thu, Feb 27, 2025 at 8:09 PM Heming Zhao <heming.zhao@suse.com> wrote:
> ...
>>
>> Let me summarize the above discussion/description:
>> - TCP is the default.
>> - stop trying to detect:
>>     - use dlm.conf to switch from TCP to SCTP.
>>     - corosync.conf 'rrp_mode' is not supported in corosync 2.x.
> 
> yes, I would just drop the whole detect_protocol() function and don't
> have the protocol setting depending on any corosync.conf related.
> 
>> - TCP can work with multi-link, but only accept the first ip addr from corosync.
> 
> yes.
> 
>> - SCTP can support max 8 ip addr for corosync 3.x.
>>
> 
> It shouldn't depend on which corosync version we are using, or? It
> should be the same way for 3.x and any other version, see [0]?
> 

Sorry for my English.
Yes, there is the same way. There is no special code for corosync 3.x.
My mean:
After changing DLM_MAX_ADDR_COUNT (kernel) & MAX_NODE_ADDRESSES (dlm_tools),
the dlm layer supports max of 8 ip addrs (in SCTP mode). And the number 8
is equal to the max number of multi-links in corosync 3.x.

- Heming

> Thanks!
> 
> - Alex
> 
> [0[ https://pagure.io/dlm/blob/main/f/dlm_controld/member.c#_216
> 

