Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A1714F98
	for <gfs2@lists.linux.dev>; Thu,  9 Jan 2025 15:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736437137; cv=none; b=CRyniLTFYA4fSPfw4+DvJ3mC/zjhoKEOVY+JB/afNBgLpCxAV6uWbHQhpcG/sN8qljoRczWcpQyYFV4rClRIkZ9UfXIWN9lBc1+6vzAc0iASO0lUw+zqu4Ekb6lSe5/Rlyo67fte0sdyAZMeZ2ABW14CsOJ20EUdpOD6bwElI7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736437137; c=relaxed/simple;
	bh=8+jyXzNK/KV3Fne5gAAj0WfCBT+RHRwrjmwaEb6eR1I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MgghUNPFRYo5gwtuyywLc/0INq33L2IPmZc/Upq/eyYCJ1IzoKOj6UJtniEaGvmjx1RdMM4Jrqz5rmBWSPQw0AeHfLfSEFMqYg9wfuBR12gzg4MXihQbe2zVsOXhnRneLMg59lyzTU2ad0aIjiPVL3Ianvq2cHpvQOEvsy5LvW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DRJeh0fj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DRJeh0fj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736437134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qqx+xDqbREkNbnQ9Gpqi5/5gi7dejZXeVIrtfIAIs5Y=;
	b=DRJeh0fjFk/7fHCMU21QyOc/r2C9fO30WrToCA4DMeFPI6sk+00BGEDkCmqzgMgjeBKKjp
	PcoV+t6WgPEJDh44WKCNe3EBHaj8MpkpCjjPpTaNxn7Ln611ZLdLzS/7xWAWFayO7F4Qq6
	8MNgL69nIgHdVcXbc03t9TPEI9G3uXA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-104zvZqpPEmM0tHtfzeW3A-1; Thu, 09 Jan 2025 10:38:53 -0500
X-MC-Unique: 104zvZqpPEmM0tHtfzeW3A-1
X-Mimecast-MFC-AGG-ID: 104zvZqpPEmM0tHtfzeW3A
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43631d8d9c7so5352265e9.1
        for <gfs2@lists.linux.dev>; Thu, 09 Jan 2025 07:38:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736437132; x=1737041932;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qqx+xDqbREkNbnQ9Gpqi5/5gi7dejZXeVIrtfIAIs5Y=;
        b=hyq2XOwSGNxyEVK3K7mIcqBMeSjBNizl7wc89YfmwRK65OISIhZDhhNehsiZLiuRVa
         PFv9ULKXsVnERzTcnVYVmMQu4lsk1Gz8z9FwWFvAjzpmBiRbToOs5FQOhQkm5Iw2Gewk
         hwvRkReOhvb7NyB0YCL5xD/lVyGC4VPPqMbb1uuzN/e6fgwjCmOxpjEPWLIq60Glcs1+
         N0HPPIr3tZJaPX+/YtVesbEgtTJZkY/z87/aZMsYzY3eUYset63Nw/OQIQHQKzIrh2wY
         gjLVZnOUfRibzKigFlA1GFQDIBZuf+YcWPXGfNR1zD917/SRleWpZ2PF6N8KGEWP1xTC
         G9Pg==
X-Forwarded-Encrypted: i=1; AJvYcCUQUISHqmX4pM06qzu/KJmrfVxhL9yjMr+pc3P6Bq9RK3eO9ovltlPTJlSJGeKn5kS3cFYJ@lists.linux.dev
X-Gm-Message-State: AOJu0YzI8vbJVA+pF0gVqm2bKKqt3pSxS82klOmMmaCBlNB8PIdheEhN
	KwMV+s4rhSP/o34AsiA/SM8fW+C4H9dydzcJlJ5w+VDdX3w9o725dux9nIqiFWBmjpGNBiCRtSK
	jsco6FcSN40gWSERQamoojY87S2FY3toY5JP3AockRVbfKr3M1GE=
X-Gm-Gg: ASbGncvJbXzRYTZ9wwb8AqkVdODVsSbI5J4Rvez8fbo/gdEp8jY56lohs1MEDRn0otl
	nMNIUSHgWIfQ/buXGvQtX1yVp6N/4WChRy2LxUu6iWTYLuOxfnHsy25UFmBdYG2uFxNA4izy5A7
	7rFqOqh6qWkPAcGQYdDprY2oz1HIFHHyOp8XJfKHkdrf8A1UGPqzVkijZSTqb3nqNyao1ZFnWjc
	INBOsol2FCj+5UoxMCudONNkQgjiUOvgZQF24tO6UO5XLI4XKWFhvNpLzz2B/KnELXcDxbePPvJ
	kELQnAwALBN3oiQd/GMuTEQ29K+up+CcMBQ0ambqsuoKBlAw
X-Received: by 2002:a05:600c:5124:b0:434:ff08:202e with SMTP id 5b1f17b1804b1-436e9d748e8mr24321445e9.8.1736437131988;
        Thu, 09 Jan 2025 07:38:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHBimefby0eZyto5qOvqpWEaCAZ70qAmuRyrBeOKZl2jVQDXbF8Ef4mSWZfRs7HykXsUJ/ckw==
X-Received: by 2002:a05:600c:5124:b0:434:ff08:202e with SMTP id 5b1f17b1804b1-436e9d748e8mr24321245e9.8.1736437131529;
        Thu, 09 Jan 2025 07:38:51 -0800 (PST)
Received: from [192.168.1.44] (seac-27-b2-v4wan-169614-cust2769.vm25.cable.virginm.net. [81.99.250.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e9d8fc5csm24649795e9.2.2025.01.09.07.38.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2025 07:38:50 -0800 (PST)
Message-ID: <f5caa22f-7b4b-4633-89c8-fb373508bf03@redhat.com>
Date: Thu, 9 Jan 2025 15:38:49 +0000
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] dlm_controld: support corosync3/knet multi-link
To: Alexander Aring <aahringo@redhat.com>, Heming Zhao <heming.zhao@suse.com>
Cc: teigland@redhat.com, jfriesse@redhat.com, nicholas.yang@suse.com,
 glass.su@suse.com, gfs2@lists.linux.dev, Roger Zhou <ZZhou@suse.com>
References: <20241224084241.13563-1-heming.zhao@suse.com>
 <20241224084241.13563-2-heming.zhao@suse.com>
 <CAK-6q+gbGg9rQKuKkpLyURN_nY1N+k87YPj1e8HqL_zTy0GgUw@mail.gmail.com>
 <efad042e-6035-4045-b4e8-7798055945a1@suse.com>
 <CAK-6q+g0YP+40yQ=8KVOSCcknCRmmn6-LfuvseDW1i4uFDqw5Q@mail.gmail.com>
 <f6062ed5-51aa-4c56-a211-87183e6eb853@suse.com>
 <CAK-6q+jRn+fXdby1tCQSoayO4HfpKKQkfUOH6SGJ75ujbNn1ug@mail.gmail.com>
From: christine caulfield <ccaulfie@redhat.com>
In-Reply-To: <CAK-6q+jRn+fXdby1tCQSoayO4HfpKKQkfUOH6SGJ75ujbNn1ug@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: M8KeVrD4akbFSz1hqLIz1wZBPRNcEXY_0o6q-CXYgv4_1736437132
X-Mimecast-Originator: redhat.com
Content-Language: en-GB
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 09/01/2025 15:34, Alexander Aring wrote:
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


Just a quick intervention here. If corosync is using knet, then it 
doesn't matter if knet's protocol is UDP or SCTP, it can still provide 
up to 8 links. There is no point in you checking that value (also, 
different links can use different protocols).

Yes, check corosync's transport: key for knet/udp/udpu - THAT will tell 
you whether multi-link is available.


So, the logic goes:

multilink = false
if totem.rrp_mode == 1 then multilink = true
if totem.transport == 'knet' then multilink = true

That should cover it.

Chrissie



> "nodelist.node.0.ring%d_addr" defined in Corosync but does not set
> "totem.rrp_mode" and there is no "protocol" setting in dlm.conf or as
> a parameter (it will use detect_protocol()"), then the DLM kernel will
> use TCP.
> 
> After your patch the behaviour will be changed and the DLM kernel will
> use SCTP with the same configuration as before?
> 
> - Alex
> 

