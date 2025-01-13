Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9166813C8F3
	for <gfs2@lists.linux.dev>; Mon, 13 Jan 2025 03:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736737978; cv=none; b=GJ3ku1tnm8zUvWMRwLbNJfZqhQHMhuG7xUJjNUNrF2NIzWT0zr9rh85a9J1VmfMJ9SojglpbVvos6perZiCamBwDFsCyzSNvFAYrd7nbc9ByC4Gxy7jAhn0nUE+/eTyXoeS8CiHPx1iiwSyHbVVpaoZc5qbs50x7wOT+Q4G4glI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736737978; c=relaxed/simple;
	bh=LmDIkzgWCenKFOa3/srXmZC2GoS2KFsQQBM1GCyoRwI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=edfjQ+NQDGIQQbvZVmF6TXKS3gXhRZfCWqsgjFz3X5ILiIr4YPBIFApf3OphYFUlIYV2WATNcbY92ZoVWM7V/XZHuppMol8W9eS7ZlVMKZiQPxyjeuluDY01ejy1+7DeUPG56MmNTpH8WO7/Lxp1+KZYtgxcGsxWJ39eTh9Mctw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BozW/eB8; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BozW/eB8"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5d3c0bd1cc4so611115a12.0
        for <gfs2@lists.linux.dev>; Sun, 12 Jan 2025 19:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1736737974; x=1737342774; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n8Y/mJDS4jCy1zaqk0wtqCPARythOAqVyrxt7fvDvEo=;
        b=BozW/eB8f+2FMRfEXSiLr/BMqHx39D/BSkr11uIK42li33wccA2Yonxz/i2j2L2ZNj
         PQ7zMTIT/AeJi722tAaozbri0OO8nPMfltNnOZg0hZ5rsdLvET8/46FLwjoaYp1/fp32
         OHLSja9P099IPxiPSlIHNOCQBuHj5tMJ57Katq2JcAFlWehgxGTWTuvZ8fwbH0CmOa2W
         FL81uF7lWxkDg/GA7mWzcc8gI+S5hWfEPSmd+MugWc3bxLT0LAoVQ1wP9UeNLorH9mgK
         7IQbCBsfKMCZ5Vc9toGnB9Z3u8bpkroIx3eOY0FbfS4UjB4XE/gQ5vFlTiaCSR+WBMyb
         vAhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736737974; x=1737342774;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n8Y/mJDS4jCy1zaqk0wtqCPARythOAqVyrxt7fvDvEo=;
        b=jFzXQwEl2dz9up7Z8nd9VBOQW6lzHqsMZbd8SGqBqi2J1AyOi6ZoYngewFvIsqEgXx
         M3H/W5Skn341sR5mNrHutyKZqREZxVeAQmU+s4BjtK0N9zssCrKaRuAE0UGsxosGZGYi
         sTyEFTh1qmqZHyma4GiNkl1TcsGrxQ1+vzFEUxqejoFBdhRCM/AIl9XNTUaqcCfWMz08
         ZVoJxRZYXDv/jJYF3uPVT6/3IDnORp9cUyI2hiDmpYTMvmZ/0FglL9uqzUK5Jg+HBHDu
         Ggcb4XSCV84Zh59WS/PKh7bK1roslECauQ1wzRdaS4l3qLvT3EGI9PGMOLD7qpU2KZo+
         pEPw==
X-Forwarded-Encrypted: i=1; AJvYcCU4lS4M8HP1R0DZkn4mZVNVULHq7BC+2VC/uExd0TmAH1z7uRonAhp0ACdCPDs4kCotECnn@lists.linux.dev
X-Gm-Message-State: AOJu0YzN6JHKE5J9oUGjizT1n9/6rN/U81tQrG6FlDbTExn+K0yb9agB
	VXNLyKXDByDozq4woDWBfNW6fMx9eMz0ElefAUYErrcZTXOBXpQq3hR+FZ4CYQ8=
X-Gm-Gg: ASbGnctmjHzwMDS6TihbcHJZfkVxXh5rlV0nK61oUY0a4ijqyg1Btn5KOqKtm6p1lwc
	MjOWzrEeLdxQ1hM9fovMlrRucSYv5GXmpE9msDO1xCL3fP7Yq2xHa4HXTzpp0cgigTPpICgOF7c
	iCD+en1vJq35w+MmwDf2uCFJX95rrcVJkfEVdv0VYJQDTQB7UhPZB9T3dmpRYtTYZhiTrJqZMdu
	JHovXm0NoyG/+g2QZzwy/ka8eCwk8Nm0ORqPsu+oEtyeDgNZ2b75WF41cMa
X-Google-Smtp-Source: AGHT+IF+chNYygCVWdJYQFWOkv26CyUzyU7JmTCpRxIHeQKamu51ENdGuUnjk4NMs6v7s6hkZxreIw==
X-Received: by 2002:a05:6402:1f4c:b0:5d3:fdf5:4b28 with SMTP id 4fb4d7f45d1cf-5d972e88f88mr6373476a12.10.1736737973843;
        Sun, 12 Jan 2025 19:12:53 -0800 (PST)
Received: from [10.202.32.28] ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f13b0f6sm44713465ad.67.2025.01.12.19.12.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jan 2025 19:12:53 -0800 (PST)
Message-ID: <55a997d3-df7b-4ead-8ddd-d4819ca95cf0@suse.com>
Date: Mon, 13 Jan 2025 11:12:48 +0800
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] dlm_controld: support corosync3/knet multi-link
To: christine caulfield <ccaulfie@redhat.com>,
 Alexander Aring <aahringo@redhat.com>
Cc: teigland@redhat.com, jfriesse@redhat.com, nicholas.yang@suse.com,
 glass.su@suse.com, gfs2@lists.linux.dev, Roger Zhou <ZZhou@suse.com>
References: <20241224084241.13563-1-heming.zhao@suse.com>
 <20241224084241.13563-2-heming.zhao@suse.com>
 <CAK-6q+gbGg9rQKuKkpLyURN_nY1N+k87YPj1e8HqL_zTy0GgUw@mail.gmail.com>
 <efad042e-6035-4045-b4e8-7798055945a1@suse.com>
 <CAK-6q+g0YP+40yQ=8KVOSCcknCRmmn6-LfuvseDW1i4uFDqw5Q@mail.gmail.com>
 <f6062ed5-51aa-4c56-a211-87183e6eb853@suse.com>
 <CAK-6q+jRn+fXdby1tCQSoayO4HfpKKQkfUOH6SGJ75ujbNn1ug@mail.gmail.com>
 <6e96fe53-869a-40b4-8c28-f7568f2987d5@suse.com>
 <aaec163a-fadf-4c7d-a193-9b0eb97d584b@redhat.com>
Content-Language: en-US
From: Heming Zhao <heming.zhao@suse.com>
In-Reply-To: <aaec163a-fadf-4c7d-a193-9b0eb97d584b@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/10/25 22:43, christine caulfield wrote:
> 
> 
> On 10/01/2025 14:28, Heming Zhao wrote:
>> On 1/9/25 23:34, Alexander Aring wrote:
>>> Hi Heming,
>>>
>>> On Wed, Jan 8, 2025 at 9:26 PM Heming Zhao <heming.zhao@suse.com> wrote:
>>>>
>>>> On 1/8/25 23:54, Alexander Aring wrote:
>>>>> Hi,
>>>>>
>>>>> On Mon, Jan 6, 2025 at 11:59 PM Heming Zhao <heming.zhao@suse.com> wrote:
>>>>>>
>>>>>> On 1/7/25 02:11, Alexander Aring wrote:
>>>>>>> Hi Heming,
>>>>>>>
>>>>>>> On Tue, Dec 24, 2024 at 3:42 AM Heming Zhao <heming.zhao@suse.com> wrote:
>>>>>>>>
>>>>>>>> The totem.rrp_mode config item was obsolete in corosync3. And
>>>>>>>> this patch gives dlm_controld the ability to detect multiple
>>>>>>>> links.
>>>>>>>>
>>>>>>>> The corosync and dlm network protocol relationship table:
>>>>>>>>
>>>>>>>>     -------------+-----------------------+---------------------
>>>>>>>>                  | totem.transport=udpu  | totem.transport=udp
>>>>>>>>                  +-----------------------+---------------------
>>>>>>>>     corosync 2.x |            |          |      multicast
>>>>>>>>                  |   1-ring   | 2-ring   |---------------------
>>>>>>>>                  |            |          |  default  | 2-ring
>>>>>>>>     -------------+------------+----------+---------------------
>>>>>>>>        dlm       |     tcp    | sctp     |   tcp     | sctp
>>>>>>>>     -------------+------------+----------+---------------------
>>>>>>>>
>>>>>>>>     -------------+---------------------------- +----------------------
>>>>>>>>                  | totem.transport = udpu/udp | totem.transport=knet
>>>>>>>>     corosync 3.x |---------------------------- +----------------------
>>>>>>>>                  |      1-ring                | 1-link  | multi- links
>>>>>>>>     -------------+----------------------------+---------+-----------
>>>>>>>>        dlm       |       tcp                  |  tcp    | sctp
>>>>>>>>     -------------+----------------------------+---------+-----------
>>>>>>>>
>>>>>>>> At last, this patch should be work with updated kernel dlm module.
>>>>>>>
>>>>>>> I am not getting why the network protocol configuration has anything
>>>>>>> to do with the corosync configuration.
>>>>>>> I know that we currently get the address configurations from corosync
>>>>>>> but with this patch we are forced to use SCTP when corosync provides
>>>>>>> more than one "ring" configuration?
>>>>>>
>>>>>> Yes. this patch will force dlm to change to SCTP when corosync provides
>>>>>> more than one "ring".
>>>>>>
>>>>>> The reason:
>>>>>> (without this patch) When a user sets up multi-links on corosync3
>>>>>> and corosync.conf with an incorrect or missing rrp_mode,
>>>>>> dlm_tcp_listen_validate() will trigger 'dlm_local_count > 1' and report
>>>>>> an error.
>>>>>> Please note, rrp_mode is obsolete; the dlm_daemon will fail to read this
>>>>>> config item in the further. Therefore, the network protocol will
>>>>>> always be TCP.
>>>>>>
>>>>>>>
>>>>>>> Even with corosync3 it should be possible to use corosync in SCTP
>>>>>>> (multiple rings) and the kernel dlm using TCP only, would this not be
>>>>>>> possible with dlm_controld then?
>>>>>>
>>>>>> Only one case for above case: corosync3 on single-link.
>>>>>> A new patch is needed for dlm to work over TCP when corosync3 in SCTP
>>>>>> (multi-link mode). i.e. dlm_tcp_listen_validate() shouldn't return
>>>>>> -EINVAL when 'dlm_local_count > 1'.
>>>>>>
>>>>>
>>>>> I think we should change that condition then.
>>>>>
>>>>>> A key point for dlm is that there is no way to get the corosync version.
>>>>>> This patch is compatible with corosync2 env. In corosync2, the user must
>>>>>> correctly config rrp_mode when using 2-ring.
>>>>>>
>>>>>
>>>>> So far I looked into it, it is anyway for detecting a protocol
>>>>> according to some Corosync functionality it should still be possible
>>>>> to always force dlm_controld using a different protocol by setting the
>>>>> right config values/parameters.
>>>>
>>>> Yes, I forgot the config item 'protocol=[detect|tcp|sctp]', which can bypass
>>>> the detection phase when its value is "tcp|sctp". But in general, dlm.conf
>>>> is seldom used.
>>>>
>>>> Unfortunately, corosync doesn't provide the api.
>>>> ref: https://github.com/corosync/corosync/issues/771
>>>
>>> I have the following scenario in my head with detect_protocol().
>>>
>>> Currently, if somebody uses knet with UDP and has multiple
>>> "nodelist.node.0.ring%d_addr" defined in Corosync but does not set
>>> "totem.rrp_mode" and there is no "protocol" setting in dlm.conf or as
>>> a parameter (it will use detect_protocol()"), then the DLM kernel will
>>> use TCP.
>>
>> Since you wrote knet above, so the corosync version is 3.x.
>> For your description, there are four points/places to notice.
>>
>> 1. The above setting never works in the SUSE HA stack.
>>
>> The reason I wrote in the previous mail is that corosync will report error:
>>> corosync[1284]:   [MAIN  ] parse error in config: 2 is too many configured interfaces for the rrp_mode setting none.
>>
>> 2. (you are right) DLM kernel will uses TCP
>>
>> If corosync doesn't complain that the rrp_mode is missing.
>> The current code (without my patch), dlm_tools func detect_protocol()
>> returns '-1', which makes the DLM kernel use TCP.
>>
>> 3. DLM kernel module doesn't work
>>
>> current code (without my patch), DLM kernel dlm_tcp_listen_validate()
>> will return -EINVAL when 'dlm_local_count > 1'.
>>
>> 4. Corosync using UDP/SCTP is transparent for dlm.
>>
>> UDP/UDPU just means corosync is under single-link. this is one
>> rule of corosync 3.x.
>> knet means corosync is under multi-link. there may be only one
>> link present, or up to 8 links present.
>>
>>>
>>> After your patch the behaviour will be changed and the DLM kernel will
>>> use SCTP with the same configuration as before?
>>>
>>
>> According to the corosync/dlm behaviour in SUSE HA stack
>> (ref above 4 points), my patch:
>> - corosync 3.x env, forces the dlm to use TCP when only one link exists.
> 
> That's dangerous though, because corosync3 can dynamically add and remove links while running. It's quite possible (and explicitly supported) to create a cluster with only 1 link, and then add others later.
> 
> Chrissie

The current dlm code design doesn't allow reconfiguring the network
protocol on the fly. In the above scenario, the dlm will maintain the
TCP connection until the next dlm_deamon restart.

In my view, it's not essential for dlm to follow the knet dynamically
multi-link style. if the user hasn't set the 'protocol' item in
dlm.conf, (with my patch, for knet env), dlm will detect the corosync
nodelist on startup, and set the appropriate protocol mode.

If the user want to keep maintain a multi-link for dlm, they should
set protocl item in dlm.conf.

On the other hand, if dlm needs to dynamically change the number of
links during runtime, it should always use the SCTP protocol.

Thanks,
Heming


