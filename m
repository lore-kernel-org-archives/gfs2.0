Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6172101B6
	for <gfs2@lists.linux.dev>; Fri, 10 Jan 2025 14:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736519315; cv=none; b=LUszhkm6j72Agmszrt4aHBYfRuaVOc5DeN6cjkKB73rcpfnEHvfXNBTm7HKTPdioTyx/vCMPTZ4qDfILCFwyh2Qji9NZ2ov5nIB1yS6Zg7PCbJ+rOs5WaIM1jOTKZ9uIhfouvjPYuxb+cL/0eIqn72B/b2/B432MEY/XEg9FjLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736519315; c=relaxed/simple;
	bh=jjOMeGFKCpWiUMK7IiV8OECiI+qm0YnRIGuNb2WdQas=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GUzSk2PjFPS333WgJMecTH89b3EJRocpwf/QMU9TSM7BrojrRfQFfHkRtZb+0dDNDRoieIiz+yKPSR2m60GkCox9qJbmcxpHrXwylSekmswFjj7NvkbSYnUUl1CQVzAd7JlL8nqxZYNo+ZkA40KvjwYqxUOKGRTn/dAT20r+LcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gwFBaAnI; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gwFBaAnI"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aa6965ad2a5so33598866b.3
        for <gfs2@lists.linux.dev>; Fri, 10 Jan 2025 06:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1736519311; x=1737124111; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QtFSZFnjgHyJvyo5UGN0VN+ycMwNUwTfg17tl6OoegU=;
        b=gwFBaAnIu7N/ocSEAwuQUhIRzcZH8yB7hGh/n4ivmLx5E/m+Jf2Exf6ieDnhLmXE9x
         FE/ZaNcrmGgGC2CBL9LCGEIStxcE8FzXohm5fv8oFGOz2eDu1XSQ3VptV//9yNpYqIAH
         mvJt6X/2WAqeVyB6huLhPwOagJK/gQpb36sr7HdvVoCn/QEt+dRCxBLXfaa/p3DAl5E0
         WGzLwo0cQSm2iBYSeVcVSvG+8sSmDVJ/i27CtpWFyusE+MI5dSN9hJQqkTuSAGiQ/Q8x
         cbmYHz43b/I4HZVbHZCjstELm5RtMIGBun8aM2X0xTLDMP9psaADLRIS3d72ERm0IQzU
         FejQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736519311; x=1737124111;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QtFSZFnjgHyJvyo5UGN0VN+ycMwNUwTfg17tl6OoegU=;
        b=BHI6LSk3eVVzWVd/QHcKfYHw6a6mexzfx9GZzrVIFjtr+PqSRyV5ri8nCmz3nrfqW6
         sdjzLpe549ltBj7oAKo3OWHSs1N8JDlZ3JSgYH7ihccTEai4i5y7hqG9OQqW0BcpFoFp
         GOW0ycC2NoO2/FgOUa3wvH1k4ICXE5Yu5DCEEtbvtvpZEkhK1AITUidQwHdXkvVMUTB1
         uhHM9rWKXxoKxq4uug9THXWXUnBsAqG2mKPjpeW7t7LnS82mLVdFkCZSHUNppICH7eku
         nCl9zQW+/hD9wX/rKTVYJFK8aVtEgMOA8eTDHbM3EBNv5pxlxbUzMBjAg9cjgauCNrir
         +GiA==
X-Forwarded-Encrypted: i=1; AJvYcCUQMKYYkhNjn06myNt/MLh8Ivket03Hac83GXP0our7Jsbv8S40l582BhbB5WPorYN0OQpF@lists.linux.dev
X-Gm-Message-State: AOJu0YxmP7YXG0+GGrw6gK+T9/7y8GFDZSNmXDVI5XweKW/UcyypEjPe
	ibqdoyOtwLSyV25wCIQ6BINzA0Tte/5YnMl8GqWOjvt5Tt1rPt/qUQQ6LqiFPJ0=
X-Gm-Gg: ASbGncua4UPoRMJ3IMI/GcpCin2RbWIywTYdMWkH81AlNv0jM1+gtX41QEZv9qS3TQU
	nlOTZ+9YYq4O3SoHI1+735CGwH7acNaOcyapppRe+cfzhh7segtXLIvQAFEQw8IDNKFUqjfT0V6
	lqMbNvegnxXsNGUyLF33+ocfStshTOY9VDmhBeuDv4idFfKZ3aPs/eRhx8KLPs8suL3uDZXHAeh
	azS59xBfFHqGiSswgXyCQrDXf2acT0c95aj6lZ5D9kVcMXyuRh32bDXYqcEKBw=
X-Google-Smtp-Source: AGHT+IH8dE6PGzt6BZYH0yoV1OeyP+fpGxBM1xBtxvJeSva1OPNNtnN17DjkoAqWyx0PsR3Vo5CGOQ==
X-Received: by 2002:a17:907:c244:b0:aae:d199:6eaf with SMTP id a640c23a62f3a-ab2ab6a8db1mr374972466b.1.1736519311265;
        Fri, 10 Jan 2025 06:28:31 -0800 (PST)
Received: from [10.202.112.30] ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f2354bfsm14355155ad.206.2025.01.10.06.28.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2025 06:28:30 -0800 (PST)
Message-ID: <6e96fe53-869a-40b4-8c28-f7568f2987d5@suse.com>
Date: Fri, 10 Jan 2025 22:28:25 +0800
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] dlm_controld: support corosync3/knet multi-link
To: Alexander Aring <aahringo@redhat.com>
Cc: teigland@redhat.com, ccaulfie@redhat.com, jfriesse@redhat.com,
 nicholas.yang@suse.com, glass.su@suse.com, gfs2@lists.linux.dev,
 Roger Zhou <ZZhou@suse.com>
References: <20241224084241.13563-1-heming.zhao@suse.com>
 <20241224084241.13563-2-heming.zhao@suse.com>
 <CAK-6q+gbGg9rQKuKkpLyURN_nY1N+k87YPj1e8HqL_zTy0GgUw@mail.gmail.com>
 <efad042e-6035-4045-b4e8-7798055945a1@suse.com>
 <CAK-6q+g0YP+40yQ=8KVOSCcknCRmmn6-LfuvseDW1i4uFDqw5Q@mail.gmail.com>
 <f6062ed5-51aa-4c56-a211-87183e6eb853@suse.com>
 <CAK-6q+jRn+fXdby1tCQSoayO4HfpKKQkfUOH6SGJ75ujbNn1ug@mail.gmail.com>
Content-Language: en-US
From: Heming Zhao <heming.zhao@suse.com>
In-Reply-To: <CAK-6q+jRn+fXdby1tCQSoayO4HfpKKQkfUOH6SGJ75ujbNn1ug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/9/25 23:34, Alexander Aring wrote:
> Hi Heming,
> 
> On Wed, Jan 8, 2025 at 9:26 PM Heming Zhao <heming.zhao@suse.com> wrote:
>>
>> On 1/8/25 23:54, Alexander Aring wrote:
>>> Hi,
>>>
>>> On Mon, Jan 6, 2025 at 11:59 PM Heming Zhao <heming.zhao@suse.com> wrote:
>>>>
>>>> On 1/7/25 02:11, Alexander Aring wrote:
>>>>> Hi Heming,
>>>>>
>>>>> On Tue, Dec 24, 2024 at 3:42 AM Heming Zhao <heming.zhao@suse.com> wrote:
>>>>>>
>>>>>> The totem.rrp_mode config item was obsolete in corosync3. And
>>>>>> this patch gives dlm_controld the ability to detect multiple
>>>>>> links.
>>>>>>
>>>>>> The corosync and dlm network protocol relationship table:
>>>>>>
>>>>>>     -------------+-----------------------+---------------------
>>>>>>                  | totem.transport=udpu  | totem.transport=udp
>>>>>>                  +-----------------------+---------------------
>>>>>>     corosync 2.x |            |          |      multicast
>>>>>>                  |   1-ring   | 2-ring   |---------------------
>>>>>>                  |            |          |  default  | 2-ring
>>>>>>     -------------+------------+----------+---------------------
>>>>>>        dlm       |     tcp    | sctp     |   tcp     | sctp
>>>>>>     -------------+------------+----------+---------------------
>>>>>>
>>>>>>     -------------+----------------------------+----------------------
>>>>>>                  | totem.transport = udpu/udp | totem.transport=knet
>>>>>>     corosync 3.x |----------------------------+----------------------
>>>>>>                  |      1-ring                | 1-link  | multi-links
>>>>>>     -------------+----------------------------+---------+-----------
>>>>>>        dlm       |       tcp                  |  tcp    | sctp
>>>>>>     -------------+----------------------------+---------+-----------
>>>>>>
>>>>>> At last, this patch should be work with updated kernel dlm module.
>>>>>
>>>>> I am not getting why the network protocol configuration has anything
>>>>> to do with the corosync configuration.
>>>>> I know that we currently get the address configurations from corosync
>>>>> but with this patch we are forced to use SCTP when corosync provides
>>>>> more than one "ring" configuration?
>>>>
>>>> Yes. this patch will force dlm to change to SCTP when corosync provides
>>>> more than one "ring".
>>>>
>>>> The reason:
>>>> (without this patch) When a user sets up multi-links on corosync3
>>>> and corosync.conf with an incorrect or missing rrp_mode,
>>>> dlm_tcp_listen_validate() will trigger 'dlm_local_count > 1' and report
>>>> an error.
>>>> Please note, rrp_mode is obsolete; the dlm_daemon will fail to read this
>>>> config item in the further. Therefore, the network protocol will
>>>> always be TCP.
>>>>
>>>>>
>>>>> Even with corosync3 it should be possible to use corosync in SCTP
>>>>> (multiple rings) and the kernel dlm using TCP only, would this not be
>>>>> possible with dlm_controld then?
>>>>
>>>> Only one case for above case: corosync3 on single-link.
>>>> A new patch is needed for dlm to work over TCP when corosync3 in SCTP
>>>> (multi-link mode). i.e. dlm_tcp_listen_validate() shouldn't return
>>>> -EINVAL when 'dlm_local_count > 1'.
>>>>
>>>
>>> I think we should change that condition then.
>>>
>>>> A key point for dlm is that there is no way to get the corosync version.
>>>> This patch is compatible with corosync2 env. In corosync2, the user must
>>>> correctly config rrp_mode when using 2-ring.
>>>>
>>>
>>> So far I looked into it, it is anyway for detecting a protocol
>>> according to some Corosync functionality it should still be possible
>>> to always force dlm_controld using a different protocol by setting the
>>> right config values/parameters.
>>
>> Yes, I forgot the config item 'protocol=[detect|tcp|sctp]', which can bypass
>> the detection phase when its value is "tcp|sctp". But in general, dlm.conf
>> is seldom used.
>>
>> Unfortunately, corosync doesn't provide the api.
>> ref: https://github.com/corosync/corosync/issues/771
> 
> I have the following scenario in my head with detect_protocol().
> 
> Currently, if somebody uses knet with UDP and has multiple
> "nodelist.node.0.ring%d_addr" defined in Corosync but does not set
> "totem.rrp_mode" and there is no "protocol" setting in dlm.conf or as
> a parameter (it will use detect_protocol()"), then the DLM kernel will
> use TCP.

Since you wrote knet above, so the corosync version is 3.x.
For your description, there are four points/places to notice.

1. The above setting never works in the SUSE HA stack.

The reason I wrote in the previous mail is that corosync will report error:
> corosync[1284]:   [MAIN  ] parse error in config: 2 is too many configured interfaces for the rrp_mode setting none.

2. (you are right) DLM kernel will uses TCP

If corosync doesn't complain that the rrp_mode is missing.
The current code (without my patch), dlm_tools func detect_protocol()
returns '-1', which makes the DLM kernel use TCP.

3. DLM kernel module doesn't work

current code (without my patch), DLM kernel dlm_tcp_listen_validate()
will return -EINVAL when 'dlm_local_count > 1'.

4. Corosync using UDP/SCTP is transparent for dlm.

UDP/UDPU just means corosync is under single-link. this is one
rule of corosync 3.x.
knet means corosync is under multi-link. there may be only one
link present, or up to 8 links present.

> 
> After your patch the behaviour will be changed and the DLM kernel will
> use SCTP with the same configuration as before?
> 

According to the corosync/dlm behaviour in SUSE HA stack
(ref above 4 points), my patch:
- corosync 3.x env, forces the dlm to use TCP when only one link exists.
- corosync 3.x env, forces the dlm kernel to use SCTP when more than
   one link exists.
- keep the same behaviour when running corosync 2.x. (since user must
   correctly set rrp_mode).


/Heming
