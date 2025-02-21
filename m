Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6546820B7EC
	for <gfs2@lists.linux.dev>; Fri, 21 Feb 2025 15:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740150741; cv=none; b=lN45wqhpXZR5R/H3ufB3Htm29yO6zu641IpMXoeKUcLPI8bMocySGqdjEZHdUGANIqOLGV5IRJVPl3pt/k1EYCQzekwo1isckduHYUYpQ8v9pbQn1N8int3vV9ul75SaZdO6zyj+cU6GfWPnY5OW9GUpeCWMGaMQFKxqG11In8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740150741; c=relaxed/simple;
	bh=fPmGistsZDf9vSo4ekmAz52j5KAqSQNLO63e3mAXnNE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sh8xjvm8GLJHV+r1Qhq9ExnsNQ9T8k/akC9nPShYSl8NT1OlyO+BZWCkwozBTOugFaTj+tiXsdjo+dET13utIkuQo2PPOfCJPHCcBqe8LNxhuAAuAbJLkzxXrd8/h0Z3i+QbijQas0zF/apOcdnG4hDO6CJrcYhDIKtmwhFVkcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PhkEQ7iB; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PhkEQ7iB"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-38c62ef85daso203414f8f.3
        for <gfs2@lists.linux.dev>; Fri, 21 Feb 2025 07:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1740150737; x=1740755537; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NqJ72K3YWgundhmc5uzYd+tDFnFIUgsgxyGB5WfsPdY=;
        b=PhkEQ7iBM1fIMoquFH3iheBOL4o4BYdWvH53CdV7AcwlaW0T8kRBcQnQMs3G9+X8Ke
         ESaPqwSM6QuhTVkmFs98SDnhY/mKHJZuxGLBOTnq1Eu/iCOofN8B/zCrRsA783M0FnJm
         ozI2ROkchUzndRnXrOrc4fZpNyTQ6+gpMqLLSihM7N0Y37y/QZotG9yEzRga+soAZHhj
         Zr1enl6ccxCVG9UfbsgtK4Lo96Oti+H++oWduoQ+BwLf3QXwb55GDmO6tzVKwFOqdxqE
         IUC08fFxIt+uupzm1oc50uZMWF7MUM+CO7DNCLh0FHNDzhQ6hUaEi16hqGR4z4fb5EJ/
         UCLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740150737; x=1740755537;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NqJ72K3YWgundhmc5uzYd+tDFnFIUgsgxyGB5WfsPdY=;
        b=Sbyxlxo3T7SW7teWZo/otbzFyJYduSh0axUTTZQDBxCOVVuQG7aacpHy0bgIMyVW7U
         WyjGjQLMv2UDYYJo9M6YYJGRoJ0pNJ4vW4XouIV1htf0gd32naKM9gnWpQiany2CXTVv
         XneRb88P8bGeL7BxUyRWXDx2Tml0SZFQ4qpkL+QXLBRCaO/n6HYt+3uJl8uR/gCIwGkd
         Dv+M7SKgMgXATOyTwlwYvLHGVJQTQF7nnxq4wDaXyAGm4FPA4/HaimsW1PTqUjJPjnvy
         dPUyBh/maxKMCVCV3MywrXufWVHrO5pK7G9ZaoVNenv7LgQmbWiGbkWM/TU2mFeEqrMP
         lvgg==
X-Forwarded-Encrypted: i=1; AJvYcCXQKC/+R7soeKQd/bTgm1h2D9JOAMcRmvJS6+XuPGZtidCgFTJIIZwdBjy+Q+iwbOFAVJUT@lists.linux.dev
X-Gm-Message-State: AOJu0YxxGBXtp5wFqwQRBTLJOsDMa8fuU/jvu8MMEk2lBxBvYwFuTSMO
	rxNr1mcDRR3Gn3DvoMpstoH8AoLw44RB2AJoLBOKqSIoEWxBbZNypokzRLmCnEQ=
X-Gm-Gg: ASbGnctRjcAFi0WhMbUg5anyEmwRmwwQt/auBL5nhT7i5SttsEWjno9QQE/QrGhwuop
	aIJ2lcuFirl2+PTwNR+5H2bVk52mwZtQRrf4S4kyrRYKfZUjHwTRdof6jOP2BUrL6/5XrHl0Mnd
	Llhq+i6KgcOBdWZ+I6Vp2eQ/CyfkuOaa//eHyPZfUqDoZzh7CyRb40VkKvyE4YW52VkHDRfQESQ
	+pIX86bpcDcI3HNejyHp48nQvVEslmL5whq3GzbeotRrr2fcqVLdpXOJfA2KrWhtkMXPgewQvNX
	st3Sh1WrNj5quprC007PvJC3995qzA==
X-Google-Smtp-Source: AGHT+IF6ElaNY7+ZdpYUY9iHfgZ1tIkhMfEeeis18eWV5u3smmGM/LWpj1o0UWYZjN4ihYz9vbizqw==
X-Received: by 2002:a5d:5f52:0:b0:38d:d371:e03d with SMTP id ffacd0b85a97d-38f6e74f6cemr1367441f8f.3.1740150737594;
        Fri, 21 Feb 2025 07:12:17 -0800 (PST)
Received: from [10.202.32.28] ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d558edd1sm139314595ad.235.2025.02.21.07.12.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 07:12:17 -0800 (PST)
Message-ID: <ec8aef3d-7a97-4d67-ac7e-9837a1350e06@suse.com>
Date: Fri, 21 Feb 2025 23:12:12 +0800
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dlm_controld: Support for extended value of kernel
To: teigland@redhat.com, aahringo@redhat.com
Cc: ccaulfie@redhat.com, jfriesse@redhat.com, nicholas.yang@suse.com,
 glass.su@suse.com, gfs2@lists.linux.dev
References: <20250221150611.21167-1-heming.zhao@suse.com>
Content-Language: en-US
From: Heming Zhao <heming.zhao@suse.com>
In-Reply-To: <20250221150611.21167-1-heming.zhao@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Sorry, please ignore this mail and check next mail.
This mail's patch subject too long and has been wrapped by editor.

On 2/21/25 23:06, Heming Zhao wrote:
> This patch should work with the updated kernel dlm module, because
> the code changes need to be aligned with the DLM_MAX_ADDR_COUNT value.
> 
> Another notice is that with the current dlm_controld code, users
> should explicitly add 'protocol=sctp' to the dlm.conf in a corosync
> 3.x env.
> 
> Signed-off-by: Heming Zhao <heming.zhao@suse.com>
> ---
>   dlm_controld/dlm_daemon.h | 6 +++---
>   dlm_sand/sand_internal.h  | 4 ++--
>   2 files changed, 5 insertions(+), 5 deletions(-)
> 
