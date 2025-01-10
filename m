Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AF820E709
	for <gfs2@lists.linux.dev>; Fri, 10 Jan 2025 14:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736520204; cv=none; b=Ci1KPOjvO5yxH5iFxnhxwBiRCy1Gbx3vCz5noU57TPcVjh4g1GRGfeZddFwt8Z/KajYe9MGhYMK2xCxcvxAolLrQ1KOV819VI0naHau+J41A3YW0Df9QoSE20q4JvysvvnGkNSYYjuQ2MzglUNkjHECnNF7hvsUYQnfi0QQf8Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736520204; c=relaxed/simple;
	bh=8Ugo601oqX3syAsjTutoA3SkwudfsUYIvytwJdOis6Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LjEy82Q31T+qBYS6JoHY6XIE79GcEtjOiHajFATBr25RHc1osVq7blOHaVDSSO6svWk0CCgPH2b7rKR0wg2yRusngEgG2AP7aOuRQajw/7bC1vL2CORbCLcifhJ1dBJ+OYf1DaoAqPEWYRP4D1zu3wf/uwqYXw+T6rJuUv97B+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N0Zf8Faq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N0Zf8Faq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736520200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Pr/qZsuag9QlMdizYjfY4LEEcrPI4PFUNSExm3AB0c=;
	b=N0Zf8FaqG2xonXRz62rdOkRQNdRc3Fu7QP/VnGNMkfN3zueX933lW5Byi6hinAw0DYlcB/
	Ym4WQdrr9YiMreg0jwpoY88pf80kWtm0A5jMOEEJdmQdnz6FPngQ7ugULWB4wFM4c6eH5A
	xhKf09pvsDbmmWaC7FPlDyu2jBOGDAE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-ZG2eKrYxPaaR8MEDkQkNvw-1; Fri, 10 Jan 2025 09:43:18 -0500
X-MC-Unique: ZG2eKrYxPaaR8MEDkQkNvw-1
X-Mimecast-MFC-AGG-ID: ZG2eKrYxPaaR8MEDkQkNvw
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-436379713baso10402155e9.2
        for <gfs2@lists.linux.dev>; Fri, 10 Jan 2025 06:43:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736520195; x=1737124995;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+Pr/qZsuag9QlMdizYjfY4LEEcrPI4PFUNSExm3AB0c=;
        b=JZgqD7kwDYfcfC+WS59yCjaqwzjuBwktMHwOorpdBFIbupQvrZYIu8XDSl7hvkfjG6
         EbQF7JoRCIUH8UvK0JiVbBGvGPy2XIduH5q7FVDTAXUnrWG5NzmLcI9oSiQd9rZD/V+E
         ZyngDrG+GcDIdYLt3QzsMXdLM/hFvgHBapV/I0wRXFnsHHxMWaf2/FX3YhLxaI7JA91W
         ZGneMwRfCa1Dv91Z9NWxySuQk9U2VVIJ3iA/jo4Goo0rIckycT6wrI8KHIfb6jadzMYo
         1DjAjWwXNGDMW15CV8/EhSsAbxtBqcu/RGKEq9CrxTChGWSySDq+PitSKrT7FLM44WSq
         wMAw==
X-Forwarded-Encrypted: i=1; AJvYcCUHtL3NBwkNusLmf7dNJ54fPN0/pCO671IwJoVGrDaMrHbH78NdMak4jKTrRxT7Zt1pQrKn@lists.linux.dev
X-Gm-Message-State: AOJu0YzK6LidGkx4Zpl9oKJyvZhW9mxXbu2iP4L8BWZPgulyAagzZV1p
	sTQbCOudDvtVt+Ahx3k5d+E3dhAmKixV0A5WZpSE0CdjIDs9hZNQgkubF3e9vfpWHK2IyEBcqgP
	HNuCIAOLJec746I3jgmCjp5Dt3/YvHM3ZLGEIRtiGzWU/jCUNmmg=
X-Gm-Gg: ASbGncsow9NDckQv7xReJxRjzdmlWiPxJzZKVsQxAfOectp7JmjTI+oJoQllzf9pb2r
	Le68YM6seMjvxAeiubqSvKBUXc7kiGAYdV9re/lO1coTASaiJXGEQdCLZSie2q66spJOrUKrzV9
	Q5zyqtD1W6I9ywFB/ITB0zE25kewwleYw2SEHafwCmlY5EYCWu8oaDnJt9co5vISKhDWolfL1rs
	aPzu7KF+Va29mnm+Jxv5wZ4fcew0iGQh4vPuEYIcy85cdDXCU6IKJxHBwyKf6BoEm3vjiP0WxQV
	mKrHgcQqHCLrwujnqzEqa8rKLM0xWAAAnZEB4CTHGh29mqfX
X-Received: by 2002:a05:600c:4713:b0:434:ff08:202b with SMTP id 5b1f17b1804b1-436e26970bcmr105843675e9.12.1736520194981;
        Fri, 10 Jan 2025 06:43:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFKxT+p6pDH5tpb8R8xaz4dnqLP+GsalPtCtHaDWugQOJIlx9+yBx+1rHzzry4QiGSKbrsc5w==
X-Received: by 2002:a05:600c:4713:b0:434:ff08:202b with SMTP id 5b1f17b1804b1-436e26970bcmr105843355e9.12.1736520194567;
        Fri, 10 Jan 2025 06:43:14 -0800 (PST)
Received: from [192.168.1.44] (seac-27-b2-v4wan-169614-cust2769.vm25.cable.virginm.net. [81.99.250.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436dd11d8b4sm79084535e9.1.2025.01.10.06.43.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2025 06:43:14 -0800 (PST)
Message-ID: <aaec163a-fadf-4c7d-a193-9b0eb97d584b@redhat.com>
Date: Fri, 10 Jan 2025 14:43:13 +0000
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] dlm_controld: support corosync3/knet multi-link
To: Heming Zhao <heming.zhao@suse.com>, Alexander Aring <aahringo@redhat.com>
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
From: christine caulfield <ccaulfie@redhat.com>
In-Reply-To: <6e96fe53-869a-40b4-8c28-f7568f2987d5@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: om6RuYS_kSnr0FT7iG1tTXsTbIzC3Q0bmVabTclzahU_1736520195
X-Mimecast-Originator: redhat.com
Content-Language: en-GB
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/01/2025 14:28, Heming Zhao wrote:
> On 1/9/25 23:34, Alexander Aring wrote:
>> Hi Heming,
>>
>> On Wed, Jan 8, 2025 at 9:26 PM Heming Zhao <heming.zhao@suse.com> wrote:
>>>
>>> On 1/8/25 23:54, Alexander Aring wrote:
>>>> Hi,
>>>>
>>>> On Mon, Jan 6, 2025 at 11:59 PM Heming Zhao <heming.zhao@suse.com> 
>>>> wrote:
>>>>>
>>>>> On 1/7/25 02:11, Alexander Aring wrote:
>>>>>> Hi Heming,
>>>>>>
>>>>>> On Tue, Dec 24, 2024 at 3:42 AM Heming Zhao <heming.zhao@suse.com> 
>>>>>> wrote:
>>>>>>>
>>>>>>> The totem.rrp_mode config item was obsolete in corosync3. And
>>>>>>> this patch gives dlm_controld the ability to detect multiple
>>>>>>> links.
>>>>>>>
>>>>>>> The corosync and dlm network protocol relationship table:
>>>>>>>
>>>>>>>     -------------+-----------------------+---------------------
>>>>>>>                  | totem.transport=udpu  | totem.transport=udp
>>>>>>>                  +-----------------------+---------------------
>>>>>>>     corosync 2.x |            |          |      multicast
>>>>>>>                  |   1-ring   | 2-ring   |---------------------
>>>>>>>                  |            |          |  default  | 2-ring
>>>>>>>     -------------+------------+----------+---------------------
>>>>>>>        dlm       |     tcp    | sctp     |   tcp     | sctp
>>>>>>>     -------------+------------+----------+---------------------
>>>>>>>
>>>>>>>     -------------+---------------------------- 
>>>>>>> +----------------------
>>>>>>>                  | totem.transport = udpu/udp | totem.transport=knet
>>>>>>>     corosync 3.x |---------------------------- 
>>>>>>> +----------------------
>>>>>>>                  |      1-ring                | 1-link  | multi- 
>>>>>>> links
>>>>>>>     -------------+----------------------------+---------+-----------
>>>>>>>        dlm       |       tcp                  |  tcp    | sctp
>>>>>>>     -------------+----------------------------+---------+-----------
>>>>>>>
>>>>>>> At last, this patch should be work with updated kernel dlm module.
>>>>>>
>>>>>> I am not getting why the network protocol configuration has anything
>>>>>> to do with the corosync configuration.
>>>>>> I know that we currently get the address configurations from corosync
>>>>>> but with this patch we are forced to use SCTP when corosync provides
>>>>>> more than one "ring" configuration?
>>>>>
>>>>> Yes. this patch will force dlm to change to SCTP when corosync 
>>>>> provides
>>>>> more than one "ring".
>>>>>
>>>>> The reason:
>>>>> (without this patch) When a user sets up multi-links on corosync3
>>>>> and corosync.conf with an incorrect or missing rrp_mode,
>>>>> dlm_tcp_listen_validate() will trigger 'dlm_local_count > 1' and 
>>>>> report
>>>>> an error.
>>>>> Please note, rrp_mode is obsolete; the dlm_daemon will fail to read 
>>>>> this
>>>>> config item in the further. Therefore, the network protocol will
>>>>> always be TCP.
>>>>>
>>>>>>
>>>>>> Even with corosync3 it should be possible to use corosync in SCTP
>>>>>> (multiple rings) and the kernel dlm using TCP only, would this not be
>>>>>> possible with dlm_controld then?
>>>>>
>>>>> Only one case for above case: corosync3 on single-link.
>>>>> A new patch is needed for dlm to work over TCP when corosync3 in SCTP
>>>>> (multi-link mode). i.e. dlm_tcp_listen_validate() shouldn't return
>>>>> -EINVAL when 'dlm_local_count > 1'.
>>>>>
>>>>
>>>> I think we should change that condition then.
>>>>
>>>>> A key point for dlm is that there is no way to get the corosync 
>>>>> version.
>>>>> This patch is compatible with corosync2 env. In corosync2, the user 
>>>>> must
>>>>> correctly config rrp_mode when using 2-ring.
>>>>>
>>>>
>>>> So far I looked into it, it is anyway for detecting a protocol
>>>> according to some Corosync functionality it should still be possible
>>>> to always force dlm_controld using a different protocol by setting the
>>>> right config values/parameters.
>>>
>>> Yes, I forgot the config item 'protocol=[detect|tcp|sctp]', which can 
>>> bypass
>>> the detection phase when its value is "tcp|sctp". But in general, 
>>> dlm.conf
>>> is seldom used.
>>>
>>> Unfortunately, corosync doesn't provide the api.
>>> ref: https://github.com/corosync/corosync/issues/771
>>
>> I have the following scenario in my head with detect_protocol().
>>
>> Currently, if somebody uses knet with UDP and has multiple
>> "nodelist.node.0.ring%d_addr" defined in Corosync but does not set
>> "totem.rrp_mode" and there is no "protocol" setting in dlm.conf or as
>> a parameter (it will use detect_protocol()"), then the DLM kernel will
>> use TCP.
> 
> Since you wrote knet above, so the corosync version is 3.x.
> For your description, there are four points/places to notice.
> 
> 1. The above setting never works in the SUSE HA stack.
> 
> The reason I wrote in the previous mail is that corosync will report error:
>> corosync[1284]:   [MAIN  ] parse error in config: 2 is too many 
>> configured interfaces for the rrp_mode setting none.
> 
> 2. (you are right) DLM kernel will uses TCP
> 
> If corosync doesn't complain that the rrp_mode is missing.
> The current code (without my patch), dlm_tools func detect_protocol()
> returns '-1', which makes the DLM kernel use TCP.
> 
> 3. DLM kernel module doesn't work
> 
> current code (without my patch), DLM kernel dlm_tcp_listen_validate()
> will return -EINVAL when 'dlm_local_count > 1'.
> 
> 4. Corosync using UDP/SCTP is transparent for dlm.
> 
> UDP/UDPU just means corosync is under single-link. this is one
> rule of corosync 3.x.
> knet means corosync is under multi-link. there may be only one
> link present, or up to 8 links present.
> 
>>
>> After your patch the behaviour will be changed and the DLM kernel will
>> use SCTP with the same configuration as before?
>>
> 
> According to the corosync/dlm behaviour in SUSE HA stack
> (ref above 4 points), my patch:
> - corosync 3.x env, forces the dlm to use TCP when only one link exists.

That's dangerous though, because corosync3 can dynamically add and 
remove links while running. It's quite possible (and explicitly 
supported) to create a cluster with only 1 link, and then add others later.

Chrissie

> - corosync 3.x env, forces the dlm kernel to use SCTP when more than
>    one link exists.
> - keep the same behaviour when running corosync 2.x. (since user must
>    correctly set rrp_mode).
> 
> 
> /Heming
> 

