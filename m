Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38402770FE
	for <gfs2@lists.linux.dev>; Tue,  7 Jan 2025 04:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736225973; cv=none; b=pzTPFGUZPp3aP7qnFcooWQk0P+cwQ8cYs0jjWuEGJYAh+hb9Myy1JCkod4QuH2hfZjWFe4KLQ/5qvqH6fEaA0PfYnZI40bOrDKsqehdR/m5upyW7+PlGWXcR0KSqtrnhwwudOygunmq+3Gvsz9jhqRtf24QTA64btc6vCsRzpz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736225973; c=relaxed/simple;
	bh=D0s8Db2mlxEP3Puce8OD50tdYOfDkYVyZhl2nbXMPuQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mdbyUZxtQW79p+BBdddua50WqSu3Ufcwh8+BTEd+QxES5Tp2l195+kM4kv2Xo2ZOrcOxKdvQEEtN67jzH8rNsiq39FCqmCWmr3P1RiY/c42B/x6y7O5LSMyGEbx9U1TBT+9if6Q7qxilb6QWZPtd08DYudroBN4mFtEDVVxSWMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ISnSptez; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ISnSptez"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5d3d69e5b63so2487690a12.1
        for <gfs2@lists.linux.dev>; Mon, 06 Jan 2025 20:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1736225968; x=1736830768; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g2bL4gv28llZvsMY92+EdaIglPB7sKAG0HtFE6R2fxA=;
        b=ISnSpteztL1ED5KL8EDq70FyZKIVTDJRLXvO+TOR1rZsWu5+WPvflHjB2RaRWBaCSw
         COWPKpHWAJ7x4zjfqP7UxJTnr1DCjUrP1vjt3n1/NR8eM/KQzIXBkkiYrQwFx9Y7Zpty
         NpZgxqT2Yhsug4g0k7C5AkO66NcFdGYO+EEjjtAU2Y8LvVaOZBj/sFhGpyQYR/sgKgfB
         ApIcl/V3OnFPAjBNXnu/7eXssFthTHriVlWm//tDERaU3YZ5jaonxtJsbvtDiJFIGIO2
         oX+zo/kPp3qWiTOoAXneNMQTgbvt6y1oU4QLIsjVQirYs++iDuzwGUCzrGjjUQxThyJP
         5aCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736225968; x=1736830768;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g2bL4gv28llZvsMY92+EdaIglPB7sKAG0HtFE6R2fxA=;
        b=sAqV1LaTvjQjNu6n9x7mzFwuh/IunH/wjSFcpoEmXJ8OWciQuXbYADTNSjeOYmBf+t
         gxOrovYMXXsdzUU6OJAePlFmTS0j/54i9Ndz/yZvgVESNtVrH4cJd62KKq/zGGNli1hO
         7Fhi0yvx4JTwmnQIM5uK4ZqZ4+8K0PilsZfSoyP2kqndxFe+E7UAu/f01tWZwXRNgIZa
         Ed5VAfHEFgRuCZ42YGHugOTwvpPv8fv0AAsJ2hC43AfnH7t+ECYHzxuqCGj5rWiieQCc
         J45ihddLQ/OYlcd2VX01MpsnVv549KW3pjcxsA4NyljQDpz2cq79iWEAMhaJ5u62EDmO
         XTsg==
X-Forwarded-Encrypted: i=1; AJvYcCXHKvzjhWA7wFWK0aSuHLxNrxYyQsH9sSyhFkTPNBOzczCoZSGOmcK7p3F7s15jdfHAUXCw@lists.linux.dev
X-Gm-Message-State: AOJu0YwJfDP4HHqwkbAoQ3+fKgmb+Od0fWNYCmvYpRz6tYLsBm6PeKux
	ZlFRRHsfrRrZSS8egTiXME62oSy28TBDEQZdpH9hV0MJnD2yc1fYfkk/ECf9fkg=
X-Gm-Gg: ASbGnctfjG1FK6pMZgYAwkg9kEigWbYedVVQG/AMRu8ptF+zwZvsk8FfcE+vyF/IaYn
	PYQu3fk/fpYP13yia2crpbi2pEE0pB9SS2ACJHYocysLMu5jnF+yc/OjVaBEgBj3rG5TxiB/y+N
	v9XcbGC+fZAqX3iDuYxLf0DFYCz6h60wzA8HSFBmURueKz4osuUu7OU1K2tH0A+J62MgOepV4lm
	bk06OIKBnGB8Bsa14QfvnXzhHr9QqM+ME2ohKwNssJVTe4ruHhkd7KgUwRa
X-Google-Smtp-Source: AGHT+IHRDx6sdp9LdtjZW4A5ZrfiNczSPyWdnY82pI4Q2Ug0E4jOZIfA0OwRkyuPB5e8Hk3AvOGBsg==
X-Received: by 2002:a05:6402:3487:b0:5cf:6635:858f with SMTP id 4fb4d7f45d1cf-5d81dd83dfamr20604825a12.3.1736225968473;
        Mon, 06 Jan 2025 20:59:28 -0800 (PST)
Received: from [10.202.32.28] ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8dd180sm33408710b3a.109.2025.01.06.20.59.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2025 20:59:28 -0800 (PST)
Message-ID: <efad042e-6035-4045-b4e8-7798055945a1@suse.com>
Date: Tue, 7 Jan 2025 12:59:22 +0800
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
Content-Language: en-US
From: Heming Zhao <heming.zhao@suse.com>
In-Reply-To: <CAK-6q+gbGg9rQKuKkpLyURN_nY1N+k87YPj1e8HqL_zTy0GgUw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/7/25 02:11, Alexander Aring wrote:
> Hi Heming,
> 
> On Tue, Dec 24, 2024 at 3:42 AM Heming Zhao <heming.zhao@suse.com> wrote:
>>
>> The totem.rrp_mode config item was obsolete in corosync3. And
>> this patch gives dlm_controld the ability to detect multiple
>> links.
>>
>> The corosync and dlm network protocol relationship table:
>>
>>   -------------+-----------------------+---------------------
>>                | totem.transport=udpu  | totem.transport=udp
>>                +-----------------------+---------------------
>>   corosync 2.x |            |          |      multicast
>>                |   1-ring   | 2-ring   |---------------------
>>                |            |          |  default  | 2-ring
>>   -------------+------------+----------+---------------------
>>      dlm       |     tcp    | sctp     |   tcp     | sctp
>>   -------------+------------+----------+---------------------
>>
>>   -------------+----------------------------+----------------------
>>                | totem.transport = udpu/udp | totem.transport=knet
>>   corosync 3.x |----------------------------+----------------------
>>                |      1-ring                | 1-link  | multi-links
>>   -------------+----------------------------+---------+-----------
>>      dlm       |       tcp                  |  tcp    | sctp
>>   -------------+----------------------------+---------+-----------
>>
>> At last, this patch should be work with updated kernel dlm module.
> 
> I am not getting why the network protocol configuration has anything
> to do with the corosync configuration.
> I know that we currently get the address configurations from corosync
> but with this patch we are forced to use SCTP when corosync provides
> more than one "ring" configuration?

Yes. this patch will force dlm to change to SCTP when corosync provides
more than one "ring".

The reason:
(without this patch) When a user sets up multi-links on corosync3
and corosync.conf with an incorrect or missing rrp_mode,
dlm_tcp_listen_validate() will trigger 'dlm_local_count > 1' and report
an error.
Please note, rrp_mode is obsolete; the dlm_daemon will fail to read this
config item in the further. Therefore, the network protocol will
always be TCP.

> 
> Even with corosync3 it should be possible to use corosync in SCTP
> (multiple rings) and the kernel dlm using TCP only, would this not be
> possible with dlm_controld then?

Only one case for above case: corosync3 on single-link.
A new patch is needed for dlm to work over TCP when corosync3 in SCTP
(multi-link mode). i.e. dlm_tcp_listen_validate() shouldn't return
-EINVAL when 'dlm_local_count > 1'.

A key point for dlm is that there is no way to get the corosync version.
This patch is compatible with corosync2 env. In corosync2, the user must
correctly config rrp_mode when using 2-ring.

i.e.:
In corosync2, change to 2-ring from 1-ring (whatever multicast mode).
There must include rrp_mode item, if not, error report:
   corosync[1284]:   [MAIN  ] parse error in config: 2 is too many configured interfaces for the rrp_mode setting none.
   corosync[1284]:   [MAIN  ] Corosync Cluster Engine exiting with status 8 at main.c:1415.

Even more, since corosync3 isn't compatible with corosync2,
in my view, latest version of dlm_tools should only focus on corosync3
and drop corosync2 support. If any Linux distribution stay with
corosync2, they should choose an old version of dlm_tools.

- Heming
