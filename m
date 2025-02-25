Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822732571CD
	for <gfs2@lists.linux.dev>; Tue, 25 Feb 2025 07:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740468896; cv=none; b=fXsTXHOW1ZkL5YyyLFdBCqf2XBdcCujHjhuz1xRIlT7mZxCtconssQFfYIM75wpEaHua3SYxwjffWsiITVJH7RYY9X8PKgE/cL/kX1w+gk2Lv+JY7vgUippwmWrbgxXvG8e3KZmWQVb7DhnFus4ECHVxiMwbhOM1GHNdHS9JJRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740468896; c=relaxed/simple;
	bh=47tSG+PzESrZGT5JSe+KZ592PvEiUVWQDTE6sDTzR8E=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=oVLjjDeWrEHVwEfrOSXAtKTlCS9pyzOwFMKIi7d/TYGrrPtks5fMAs1bxY6dvl338LmuXsvLl/rGOwcojPgUBEc+ijr+png0QuiAJvJl1p2aysbxBKdxNr644AydN0fFhzUDrs8ZRMK+4nB7btEOrOnEJ7cwLgIbxvNsctCU/YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eHyqt9hW; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eHyqt9hW"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5dbf5fb2c39so870130a12.2
        for <gfs2@lists.linux.dev>; Mon, 24 Feb 2025 23:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1740468893; x=1741073693; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Dllg/hUBVLh9Bc2V6k7MlCKYvnjpn0O3XeDRZ013oIU=;
        b=eHyqt9hW2/qocSpYUBtIigpBEkryVUkpvKGhb1Y+QsFnvpZ6uIou0DWfJfwMLkeQ10
         EVCMT2UqaJKZBFpyMkNesFIJxGT1fyVPv77Nu1qfy6rCVOWZ52JmiMZPWDcgf64twTR/
         7f4+FY5F7Ko/U2uUH8GnKAaU4F4nHk5C3BlkLnv5H1vDFy0SSWdrKIU8/dejQAAE/4T9
         WsbP5d+fuH/w65gojcc4TBAG1OLASsA8ePmDoanvwK7vAy8D3iLRl2nD8NrrEtT4ciqc
         RW6sgCYKarLJs99RQAwvw6b6YhGALAYvZ2tr0roTFnjGH4Pdhv1EzqVwe24fYcLGzygw
         YlgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740468893; x=1741073693;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dllg/hUBVLh9Bc2V6k7MlCKYvnjpn0O3XeDRZ013oIU=;
        b=elY13LfcIdQEDjI79ZAsFyjQK5AhMN+4zrYFaNZ97RPGFdeqVmx5Qvs9if9cD+SZDq
         0x1CkpFhrpWSTWL37/BvJdWOn5KhGtTbUYEg8LnMVTLFKOOeRCjTxCxoms92YsJ1W/bb
         R928XtgqBfJIpvXygHcsXA5cIow3Q+P904t8YXVdcaIJKcKYS6dHeGiP4IFm41u2Omi3
         eyNCmxz+wgSl5eYcjozQcP5zJbr9V+OQD3o6tOEJO3XvxrwIQIBmqF3i0HJSAk+dUGXI
         Kkzd0XUZiRQ2/MLO59yQ4XzvBRYkBIJ7cb/024RM3IZrhyGvzu83bUoc7eA6aatwPuIm
         Vyyw==
X-Forwarded-Encrypted: i=1; AJvYcCWgMfyRVews3yID5OonQYsuFIdf2pmz9yEYVeMCY4Gj5fGYLQm/FJxChtg25pxt3Th1TVsP@lists.linux.dev
X-Gm-Message-State: AOJu0Ywnhc8SHySlrAPsDU41bEHV9PeWA0rKOlqqTQoPbb4Wrs7WDpBV
	ee62ZDLRORzTlVrhviMmYdFBrGWXUdvmaIz31wei3rhd3UMMLNOkrDDGgzAnbw8=
X-Gm-Gg: ASbGncsaZ5U3XvBlmkdoieJsAQA0jLiatgKOd+a7w0OK5CrBtzdtjjiS2t0bmWVdhZ5
	Th2iyKMzXUfEXKNYE6uSqKzG3f7wwbLL2LdcSk80FRFerkN/sv3kfsfWTY/w9CnjA5gtKgd54JX
	2VgLjdsT8n9KhN+Ysy5s5PNFTO3lnOfqLMKxfGVc02haE8SXTnvweJRrbZTE3CQ4ewn6efpavyk
	fo5fRc0+DW3UaKEyPRkowx0udSYx5m6aTlyIoD++MmoQ9KRd/1bZFH1vZ2juY6ZlhwY8C0/Z9hf
	VBQvMHMXXeH/T/LV2AMQJFEGx+4ZlYs=
X-Google-Smtp-Source: AGHT+IGMK9m+BvA37Ztfv/zSIaTJkB+2EOKZMM3poaqMrwWkOGHOegoTnfWVV1r9IWJ953YzzUO4jw==
X-Received: by 2002:a05:6402:2112:b0:5de:dd27:540e with SMTP id 4fb4d7f45d1cf-5e0b7236f2emr6422094a12.8.1740468892679;
        Mon, 24 Feb 2025 23:34:52 -0800 (PST)
Received: from [10.202.32.28] ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a6ad30fsm829341b3a.27.2025.02.24.23.34.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 23:34:51 -0800 (PST)
Message-ID: <3a8cbc24-c024-48ea-869f-687ea740ad7d@suse.com>
Date: Tue, 25 Feb 2025 15:34:42 +0800
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dlm_controld: Support for extended value of kernel
 DLM_MAX_ADDR_COUNT
From: Heming Zhao <heming.zhao@suse.com>
To: David Teigland <teigland@redhat.com>,
 Alexander Aring <aahringo@redhat.com>
Cc: ccaulfie@redhat.com, jfriesse@redhat.com, nicholas.yang@suse.com,
 glass.su@suse.com, gfs2@lists.linux.dev, Roger Zhou <ZZhou@suse.com>
References: <20250221150937.21642-1-heming.zhao@suse.com>
 <CAK-6q+iiMqW9eknqgVZiKjeUgSEAkL61Q-EbP8xwy_bayjS=fA@mail.gmail.com>
 <Z7zJ6OQIzC9Q20sG@redhat.com> <456aa9b1-a197-4de4-a062-2fe11bdaf179@suse.com>
Content-Language: en-US
In-Reply-To: <456aa9b1-a197-4de4-a062-2fe11bdaf179@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Dave,

On 2/25/25 14:27, Heming Zhao wrote:
> On 2/25/25 03:35, David Teigland wrote:
>> On Mon, Feb 24, 2025 at 10:27:04AM -0500, Alexander Aring wrote:
>>> What are we doing with the detect_protocol() change? You want to
>>> submit the current version again? I would like to test it with
>>> corosync 2 vs 3 with no configuration changes on an upgrade (if this
>>> is even possible).
>>
>> I suggest we stop trying to detect, and always use tcp unless protocol is
>> set to sctp.
>>
>> Dave
>>
> 
> That's fine with me
> For corosync 3.x, there is a lot of work to support dynamic multi-link.
> However, to support config mode, the current dlm code only requires a few modifications.
> 
> - Heming

Following your idea, if TCP is used by default, what will happen when a user
sets up multiple links in Corosync 3.x without changing config file?
The TCP mode of the current DLM only accepts one link. Therefore, in this
scenario, DLM will refuse to run and report an error.

Do you think we need to invest effort in changing the TCP mode code to allow
TCP to work when the Corosync layer sets up multiple links?
For example, to simplify the code, we could take only the first network link
from the Corosync callback and ignore the others. Or we could keep the current
behavior and prevent running in multi-link mode under TCP.

- Heming
