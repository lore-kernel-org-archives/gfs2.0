Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A91E35958
	for <gfs2@lists.linux.dev>; Thu, 20 Feb 2025 03:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740023803; cv=none; b=YbxBKFjLvFfqC2Es2pS9p5OZy+6RLpJKlV7YCsfSOLr5JIKsIFqfmvsyKRfyhcB9xgQLNeavLA4UD1C1E1lKcG7pPIlX7wsLGGlQYCq8BsEX2+T+6cgynB2bwe4eKzjM9kF7T5xg5oON7i3PlwsMqIz8PiTSuI/GYkq31HtohfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740023803; c=relaxed/simple;
	bh=ZjuYGvVtbnuyXaMlHBp53kMTcTQvAQ/jCKYgBy5VHWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bNOGCOQQLTOEsHEsrBpA8IbEhCYDwaM+guw2wxAUq15Lbiunu5IlRuL6ayjGbnHzKPR5RJqzn75z+Yam0Rb0q4VcaQvukV7JChFusld/nAJjfZoqfnLuuKdf2AvPdAVXFKojKZr+13l/d+kELkz/B3lFxiwV1jXu42SOoyc+lNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=aCAz14Qk; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aCAz14Qk"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43982cede30so678165e9.2
        for <gfs2@lists.linux.dev>; Wed, 19 Feb 2025 19:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1740023799; x=1740628599; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q12SDHCkSIoKaeQoohFrmB4puu8Hpo7qSuNP9pqzRRg=;
        b=aCAz14QkVSODYSWGLisdCNeaj7CGJmFpeA0cjgBgHlw95T4DN7Dx6d+edchubu4JzX
         6A5FB8BgBs0bxVf3h9//tblUUwvzb2pJ0wgp49n8Ds/A4zP6Hn4DQj4bMwtQjkr8Qhwp
         +P4eY1yX9HRm2oUMtiKGORtBV25XJ3AsMn8AFTsY9NUy6Si8Sc+rL0Gyi8cxqq46ikPW
         fyRZ5SUG7Un2Zz+UL2mwbmzd3xh4tJh1aFN1BtiGvuywweDZUR/b2/uE+Qhv0/r5Pzs5
         kQs2AQimFa8uVTuT6+sjeS5ELJFxP9aDxxBIeRhvrfCYsadJkblyliv3u/0b2Xmf1uOM
         mafQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740023799; x=1740628599;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q12SDHCkSIoKaeQoohFrmB4puu8Hpo7qSuNP9pqzRRg=;
        b=iB8lmUoTzkHhrSUy4p1adDcWrtQK4mYRJEuRqn7fIcAg+pGh/zG1vFH3Yum5K63tc5
         089FXr+NYp6SAN3ht/whCMsV0rNKgwEclfoC7qRvswMuTZGzBjRbrU9SNY8yteNLXkYk
         WOmXW9EjntJ/5VHTTKSz/5WTMHrvwUTOjNm24KUqB4duR+XoPPEg0DBkLLCIGdglWyB3
         PGlQwIkv/ynCbFDrf2ko2UR8bjJPADnJcZnH6M1t8a7mastgxVhylHMCbzeaM+ih8CJO
         0JNG3sOKlUd/awxrgpKGCcw/GN7R/t9agvPSVp10zFEZic7HRx9Lu7ZUnCQ/85osUsuN
         WrwQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7t1xJnjZ6Vl4OZq12+25VuxlmEOhH+3rDiFbBNEZkBajT1g5Eb2PFnOx38zgYbIM5IQFw@lists.linux.dev
X-Gm-Message-State: AOJu0YxedH8mbuPYA2d+VeC3rrmskrGlh01GpyP/xfgf1ahA3hIwBTV3
	CfidwcJuaRSOmnT/gM8R7/JuSGRUBemXa0dHMqmdP/i8b4xMG/AuIawa9O2fUC4=
X-Gm-Gg: ASbGnctrQ6cEAwMvSAbrZD+z9xNdMO3CU7rgdIwyzhpEaPnUw6qsmM/fAkOJ24c3KDf
	DxUq4Ldah+4vtcaDc9aBUVZe7wYM0noO6DWox4wc6mMYnQA3CjSoBvJQfnHAlHiFkcntcNLpEBM
	lV2JRf46BOCbJX1R0xaYg6R2/IajGO8rb2WPnN8Do3OrqJYSo63o5RhYlZpsncCK4hmn3Hvld2H
	ck85N6QaBnCA4yNDnIfEcXsV3/Cmgm7E2M7Ht6k5Qsg3qItn4KhTxK53JMfh2GBBBr5jZeZ3AgH
	7/MjBekAtxkU95k5A4s=
X-Google-Smtp-Source: AGHT+IES4tVBtTRbhEfqB9pNPX+zXsKFhI91pH3+f7qRH/6qTPj6h5Qk2xbdueeGGauBTBJuQWeshg==
X-Received: by 2002:a5d:6c66:0:b0:38d:d99d:d20b with SMTP id ffacd0b85a97d-38f33f105cemr7090835f8f.1.1740023799148;
        Wed, 19 Feb 2025 19:56:39 -0800 (PST)
Received: from [10.202.32.28] ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fc13ab0ff5sm12735929a91.3.2025.02.19.19.56.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 19:56:38 -0800 (PST)
Message-ID: <17094325-6e08-4417-9647-77b8c6fd4390@suse.com>
Date: Thu, 20 Feb 2025 11:56:34 +0800
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] dlm_controld: support corosync3/knet multi-link
To: Alexander Aring <aahringo@redhat.com>
Cc: christine caulfield <ccaulfie@redhat.com>, teigland@redhat.com,
 jfriesse@redhat.com, nicholas.yang@suse.com, glass.su@suse.com,
 gfs2@lists.linux.dev, Roger Zhou <ZZhou@suse.com>
References: <20241224084241.13563-1-heming.zhao@suse.com>
 <20241224084241.13563-2-heming.zhao@suse.com>
 <CAK-6q+gbGg9rQKuKkpLyURN_nY1N+k87YPj1e8HqL_zTy0GgUw@mail.gmail.com>
 <efad042e-6035-4045-b4e8-7798055945a1@suse.com>
 <CAK-6q+g0YP+40yQ=8KVOSCcknCRmmn6-LfuvseDW1i4uFDqw5Q@mail.gmail.com>
 <f6062ed5-51aa-4c56-a211-87183e6eb853@suse.com>
 <CAK-6q+jRn+fXdby1tCQSoayO4HfpKKQkfUOH6SGJ75ujbNn1ug@mail.gmail.com>
 <6e96fe53-869a-40b4-8c28-f7568f2987d5@suse.com>
 <aaec163a-fadf-4c7d-a193-9b0eb97d584b@redhat.com>
 <55a997d3-df7b-4ead-8ddd-d4819ca95cf0@suse.com>
 <CAK-6q+grrJ5K7FTRnyFatZLTq726s5Y_S8CoKXWywedUTzp3rQ@mail.gmail.com>
 <54d17bad-997e-4271-9d76-679a923b4ea8@redhat.com>
 <ca9f2519-6dba-4927-b61b-6d5852473275@suse.com>
 <CAK-6q+iw_rqmqt3w0ZwOZ4xiMwV6EZN-V0bqqyy3rAhTB8Oomg@mail.gmail.com>
Content-Language: en-US
From: Heming Zhao <heming.zhao@suse.com>
In-Reply-To: <CAK-6q+iw_rqmqt3w0ZwOZ4xiMwV6EZN-V0bqqyy3rAhTB8Oomg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/19/25 00:35, Alexander Aring wrote:
> Hi,
> 
> On Tue, Feb 18, 2025 at 6:46 AM Heming Zhao <heming.zhao@suse.com> wrote:
>>
>> Hello Christine and Alexander,
>>
>> On 1/17/25 23:16, christine caulfield wrote:
>>> On 17/01/2025 15:11, Alexander Aring wrote:
>>>> Hi,
>>>>
>>>> On Sun, Jan 12, 2025 at 10:13 PM Heming Zhao <heming.zhao@suse.com> wrote:
>>>> ...
>>>>>
>>>>> The current dlm code design doesn't allow reconfiguring the network
>>>>> protocol on the fly. In the above scenario, the dlm will maintain the
>>>>> TCP connection until the next dlm_deamon restart.
>>>>>
>>>>> In my view, it's not essential for dlm to follow the knet dynamically
>>>>> multi-link style. if the user hasn't set the 'protocol' item in
>>>>> dlm.conf, (with my patch, for knet env), dlm will detect the corosync
>>>>> nodelist on startup, and set the appropriate protocol mode.
>>>>>
>>>>> If the user want to keep maintain a multi-link for dlm, they should
>>>>> set protocl item in dlm.conf.
>>>>>
>>>>> On the other hand, if dlm needs to dynamically change the number of
>>>>> links during runtime, it should always use the SCTP protocol.
>>>>
>>>> to move on here, I would at first apply/ack the patches for the static
>>>> maximum address increase.
>>>>
>>>> I see no problems to do that as this is required by you.
>>>>
>>>> For the automatic protocol detection and corosync3, at least I need to
>>>> doing some tests as I have currently 0 ideas how corosync informs the
>>>> users about new/removed links during runtime.
>>>>
>>>
>>> To be honest, it mostly doesn't - and it's maybe something we could look into, though I doubt it would be high priority as this is the first time it's been thought of :)
>>>
>>> Currently you can watch for the cmap key config.reload_in_progress and after that goes from 1 back to 0 re-read the new corosync.conf.
>>>
>>> Chrissie
>>>
>>>> - Alex
>>>>
>>>
>>
>> Sorry to raise this context.
>>
>> I suspect Chrissie misunderstood Alex's writing, Alex comment is about another
>> patch [1], not this patch.
>> In my view, it's not harmful to increase the address number in kernel space.
> 
> good news, the patch is already upstream. [0] Yes it is indeed not
> harmful to increase that value.
> 
> We need to test/discuss the user space changes with corosync v2 vs v3
> related to detect_protocol()?

Welcome to discuss.
If we want to follow corosync/knet style to support dynamically network link changes,
more code modifications will be necessary.

> 
> If you split this patch to have only the "MAX_NODE_ADDRESSES", then I

zhm: I will send a split patch for 'MAX_NODE_ADDRESSES'.

> can already apply this change. Btw: should it not be 9 (kernel 8) when
> previously it was 4 (kernel 3)? I feel there might be a termination
> entry at the end of the array?

The macro used in both kernel-space and user-space play a termination role.
However, in my view, both values are incorrect.
The correct and workable values for Corosync 2 are:
- DLM_MAX_ADDR_COUNT (kernel-space) should be 2, not 3
- MAX_NODE_ADDRESSES (user-space) should be 2, not 4.

The original author seems to use an enough number to accommodate potential
future increases in network links.

Regarding MAX_NODE_ADDRESSES, the dlm_controld process uses corosync_cfg_get_node_addrs() to request a maximum of four addresses.
However, Corosync 2 only supports a two-ring network.

Similarly, the current DLM kernel code can accept three sets of network addresses.

I tested the modifications with DLM_MAX_ADDR_COUNT set to 2 and
MAX_NODE_ADDRESSES also set to 2, and the cluster operated normally.

So for my patches:
- in kernel-space, I define DLM_MAX_ADDR_COUNT as 8 (not 9)
- in user-space, I define MAX_NODE_ADDRESSES as 8 (not the kernel value plus 1)
- I tested the code before sending both the v1 and v2 patches.

If you very like the style of kernel value plus 1, I am OK to define
MAX_NODE_ADDRESSES as 9.

- Heming

