Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F8535957
	for <gfs2@lists.linux.dev>; Fri, 28 Feb 2025 01:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740704960; cv=none; b=fviB5nVD1FP/bfAh+bkPRqe3jUQfKavw2SPoC+sImICq2Yw4YsHWLRrEpIDCXKRzQix1lZyi1sVa7FEoeo/4+gdLrd2T1yPwP/RqTA2e+dJjm2AGtfL3du7YZ+/62I8dg47NACqg741i5OMtKfY0XW2i/Hn+P8ZyREhVCVFaEOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740704960; c=relaxed/simple;
	bh=gLybkQreDejnVbsKHaD/Q42JgIZHwEUtPrNQ4dzZIes=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UBDuhoLyKDwAK1k2QGdOa5u0hIXT83T8CXrP3ZN2gruza9N+IcUQa5smSoyhX0SSyshlAOFrMurb683Z68k4II43rPGAKwGL2WAzRQCbo4NX3aL+qpYjQHqPquCBkJOsgr5NVo+v8QW+OFY5axaUb4FWrN5OGwQ+hf+oBUqHhLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RZCiC6s4; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RZCiC6s4"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-390e2404ee6so123049f8f.0
        for <gfs2@lists.linux.dev>; Thu, 27 Feb 2025 17:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1740704956; x=1741309756; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QhkUel2jhPPH68HQyU5mplRlE/67Gh+9DKPgH0Wxyrs=;
        b=RZCiC6s4xga9nekl8iyHsHsrNUWCKx70GtJXnsyWooPqWEfAPzY2GgBcF2XkTqLn0o
         0hKN2dUGhrP9Ai1rbCwMFji8CcR/Ntk/qN65NpLHJUl25CVXYv22zc+2xatxw1VjDZ2v
         oHEKda5fhxi+MGu2Ueh4p67hT0u0IUxmPuIGOtxN7WXOp9sCg5O8FiHuceXPfQU0EFEl
         k22kJN3tqEPDsx2qM3TvsGONrerbvvl4Farc9g2t3asl67YSRXAS9YBQd//irRHN78wh
         a6OjrQmmW5xBEkdH2CqG5aw5foD9dPn+xNN9z5UjR5whJJAIALNd6Onl1QJsc5XwyXw7
         0mAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740704956; x=1741309756;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QhkUel2jhPPH68HQyU5mplRlE/67Gh+9DKPgH0Wxyrs=;
        b=PaAkoJJpJKmBve/uaqKg038enrZx0q705XDd5/T/pJQqIOWHlLt2VWsFpzmS0vzctP
         PRQeP0h113LZby/kCDqurPL540LCDWurUL0yHxWIqjgtiIaSzeRjIt5zg58Wf4DvnTgY
         i0mQdxTxuuv1giYZ9w6TKcoHKmnhEv/31eNscD08sb6t3R+uvWRxMIJ3SXEIjZwC4p6x
         bWfVRxPMUJQNiuLDyV/CVUJmYxk4zoeYstaTFq0tCbZj4TfMWMnlqMq6DZx61OwyBBDn
         rbm7jbBxtJLs73YkdE+71ETacpi6IaQ22N2SL3dEuA703XLyDrQj6UUGv3Sth0jUV+4q
         HV5A==
X-Forwarded-Encrypted: i=1; AJvYcCXHZb/zazdLTWuhc66kOkRPOCNi+hmRnTlKYmTthVs91YmQOqV8gucQA9LK5wLfy6DAyWQz@lists.linux.dev
X-Gm-Message-State: AOJu0Yz1cGG4FQTD4hFGaxpDVkw2v6YFRA81fBgkhYyXJe61nBcmO+yf
	SAXdYExpY0gKZddujC0dm4urOy3I1ETxGdB0KibcAiKCK/DNjXTsb9WTgmQUSnY=
X-Gm-Gg: ASbGnctn41Jp478Pbl/t8fn+FzVMWRLfVYGIvzMGvM7Ftkm6JFL+OChZhWC6zwzyEOj
	8vHijPFUqqPKcsgiBxnDk4e9fykZMwd4p0js6YO1POivmOR73zN/yOu8vVA+qCfJRuN88co6VDZ
	OWjZwkidejEVMB/67M9Ta741F30YFUQwQlrV8Q6xZn1UrtRkHH/N7joqh7IRK8ijnk+9hxmKK49
	oK6xSpnRVZED7e4yH/jBxjfNd8ozWiRcDGDcrXwK+LacBqBk+vDQxKlDttNLWDJnWneEVakFdqA
	eiJgwZDxxl4BMX+qTzri4oj5pC1+aEsz
X-Google-Smtp-Source: AGHT+IFxI71G2lBewtVj+GzhGIHQT3U68Ac8ADXdeQGXd+JvaljQQ1whLi+9NsEJJLdRYXRdvf75SA==
X-Received: by 2002:a5d:64cf:0:b0:38d:b090:a0c4 with SMTP id ffacd0b85a97d-390eca0af97mr402022f8f.10.1740704956588;
        Thu, 27 Feb 2025 17:09:16 -0800 (PST)
Received: from [10.202.112.30] ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-734aed45c21sm413715b3a.176.2025.02.27.17.09.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 17:09:15 -0800 (PST)
Message-ID: <468a9169-3de2-4226-8aa1-61e0e211e4bd@suse.com>
Date: Fri, 28 Feb 2025 09:09:10 +0800
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
Content-Language: en-US
From: Heming Zhao <heming.zhao@suse.com>
In-Reply-To: <CAK-6q+g_bdNoptQ_bPUbzE9uL=strr6utQ3jM_1fxoMOpEjA7A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/25/25 22:19, Alexander Aring wrote:
> Hi,
> 
> On Tue, Feb 25, 2025 at 2:34 AM Heming Zhao <heming.zhao@suse.com> wrote:
>>
>> Hello Dave,
>>
>> On 2/25/25 14:27, Heming Zhao wrote:
>>> On 2/25/25 03:35, David Teigland wrote:
>>>> On Mon, Feb 24, 2025 at 10:27:04AM -0500, Alexander Aring wrote:
>>>>> What are we doing with the detect_protocol() change? You want to
>>>>> submit the current version again? I would like to test it with
>>>>> corosync 2 vs 3 with no configuration changes on an upgrade (if this
>>>>> is even possible).
>>>>
>>>> I suggest we stop trying to detect, and always use tcp unless protocol is
>>>> set to sctp.
>>>>
>>>> Dave
>>>>
>>>
>>> That's fine with me
>>> For corosync 3.x, there is a lot of work to support dynamic multi-link.
>>> However, to support config mode, the current dlm code only requires a few modifications.
>>>
>>> - Heming
>>
>> Following your idea, if TCP is used by default, what will happen when a user
>> sets up multiple links in Corosync 3.x without changing config file?
>> The TCP mode of the current DLM only accepts one link. Therefore, in this
>> scenario, DLM will refuse to run and report an error.
>>
>> Do you think we need to invest effort in changing the TCP mode code to allow
>> TCP to work when the Corosync layer sets up multiple links?
>> For example, to simplify the code, we could take only the first network link
>> from the Corosync callback and ignore the others. Or we could keep the current
>> behavior and prevent running in multi-link mode under TCP.
> 
> I would ignore the others, there exists ways to run multipath TCP on
> top of multiple TCP sockets (similar to what mptcp is doing but mptcp
> might be overkill, lookup "mptcp redudant scheduler").
> This can be future work, existing code regarding sequence numbers of
> dlm messages can be reused.
> 
> If somebody applies multiple links we assume any of them would work.
> Later additional handling as mentioned above could just begin to work
> in a magical way.
> 
> - Alex
> 

Let me summarize the above discussion/description:
- TCP is the default.
- stop trying to detect:
   - use dlm.conf to switch from TCP to SCTP.
   - corosync.conf 'rrp_mode' is not supported in corosync 2.x.
- TCP can work with multi-link, but only accept the first ip addr from corosync.
- SCTP can support max 8 ip addr for corosync 3.x.

If there are no further discussions, I will provide a patch.

- Heming
