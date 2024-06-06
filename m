Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258F21C69A
	for <gfs2@lists.linux.dev>; Thu,  6 Jun 2024 02:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717642090; cv=none; b=Pn30GUjnuYXDApgq81PV4ui6FjDoHkMkjQbaQBAxJD+v/VHFH1QGkkKlFrZg2KVC6PqZCjkdz1Oyawp0Jf216XPNYNt9No9SN/E4F5gNXdWa74+PJVIvdh2vRZ97p6E+vLVkVmzcbAXkPIO7B5f9u+YrK4jmm79133jZFoiKOOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717642090; c=relaxed/simple;
	bh=5NSZrFpB/GonGD46gDAy0SbbwmVebNNq7DJjorbO0dk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rlQwKWqnHK7ZPlMz+bRU/4R8hlkUwsuIZfUgzhWUrIWoKTWPwFALk6rwTP2FmxwGUZ8T1rL8mhR7tdw4BEX8ijbS503BczETx+8yJA6gpUvCf4wg25CPecvPmQWyYmBnGuVgdpHRU0HwAUY42YhLlzdGq71MHQfXKYf/9ny/Zi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Og5AyO3B; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Og5AyO3B"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2eaa89464a3so4938111fa.3
        for <gfs2@lists.linux.dev>; Wed, 05 Jun 2024 19:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1717642085; x=1718246885; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N0jfz+nnR88SF/3jl+2qqnrwZqfMXV0m/DMzFLp5rwQ=;
        b=Og5AyO3ByGhFbdUQ90d+Y3WvA92/QVm3Ov1zmhmcu7MwN6bmkX9aYQzYBecpjmN72m
         nS+DHmWpcOuLEdi+zQsJNWGKBcxyJe0o0gEq9juRDC+k2XO6wN7f1dXlPkT+zWQLcLZO
         P7dvBqSKV6uu6mzH64nJEq9IhI0QzssQdiqkhGyx+/N1tgYXTGxZVSkM8GbcM2fBCD6q
         06ihYDoi22/ZvHr20fkestLl+b2mQuYCmVXZISr9DMpikzFbxqsqYoGqoyAXhOawQ8Mr
         afVHHtsvC+72/800S2IK14Mnolg7mia7HSBA7RO07ySTz6Fyza7Xw8qPm0B00PeHsjAy
         B4Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717642085; x=1718246885;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N0jfz+nnR88SF/3jl+2qqnrwZqfMXV0m/DMzFLp5rwQ=;
        b=cTzE5/fdOzcIOMft2nsHJaXICNz2PXxLTUGvaK3BEij35J+ztrpsBrF1oHN89e+Lur
         DgWh/hR/s2KmS11NnxZ78Csblcy0LZg8ywma5aZrpYV0JXYnvyokjrSXvo/aV6V3GPas
         daSkmREQqbvbYap5iA/HaIPIjaWnk5HW0y6MOwiFylRSJ8JEwM/4dbyaoJ8B0unbKr97
         +8OLofbnyS4qbx/N+YmvXaW5bHRFVyGWrNVwMv5PzM3yZgeX20Nd+4zZttyYfhgOMpfX
         mg1etFjPG4bSM+DhkT9tzHZqP1H4EyflYj6CGZn6FSYyFSoZ/Q87ttNUtdeSjPlq3x47
         wDIg==
X-Gm-Message-State: AOJu0YzSCnfrmCssIJVWm9X6FytqAhPm0gqmrfWWIMl7l79UcjneRAkP
	a0OPqDRdeekjmeYMRcCdfG3MwJPskEmpF7DuYwqMqcXCRb2H2JmYs3HPKpyEey8=
X-Google-Smtp-Source: AGHT+IGazauN7aYw4PWByspyMiWDy+JywTjNvJ4Lkfm0DiySPRKfR6McZKYIQ8XSsbXI4yyAp55L5Q==
X-Received: by 2002:a05:651c:2224:b0:2ea:8188:5bdf with SMTP id 38308e7fff4ca-2eac7a52b99mr29005151fa.36.1717642085173;
        Wed, 05 Jun 2024 19:48:05 -0700 (PDT)
Received: from [10.202.32.28] ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c2806cfa62sm2240261a91.48.2024.06.05.19.48.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jun 2024 19:48:04 -0700 (PDT)
Message-ID: <41da824f-f3e5-429f-a701-5feddf8b2ed1@suse.com>
Date: Thu, 6 Jun 2024 10:48:00 +0800
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dlm/next 8/8] md-cluster: use DLM_LSFL_SOFTIRQ for
 dlm_new_lockspace()
To: Alexander Aring <aahringo@redhat.com>, teigland@redhat.com,
 yukuai3@huawei.com, song@kernel.org
Cc: gfs2@lists.linux.dev, linux-raid@vger.kernel.org
References: <20240603215558.2722969-1-aahringo@redhat.com>
 <20240603215558.2722969-9-aahringo@redhat.com>
 <CAK-6q+i18_oHfdh6Odfidi0y4hWiR9bn_svWf2BwPqnLwdEFGQ@mail.gmail.com>
Content-Language: en-US
From: Heming Zhao <heming.zhao@suse.com>
In-Reply-To: <CAK-6q+i18_oHfdh6Odfidi0y4hWiR9bn_svWf2BwPqnLwdEFGQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/6/24 02:54, Alexander Aring wrote:
> Hi,
> 
> On Mon, Jun 3, 2024 at 5:56 PM Alexander Aring <aahringo@redhat.com> wrote:
>>
>> Recently the DLM subsystem introduced the flag DLM_LSFL_SOFTIRQ for
>> dlm_new_lockspace() to signal the capability to handle DLM ast/bast
>> callbacks in softirq context to avoid an additional context switch due
>> the DLM callback workqueue.
>>
>> The md-cluster implementation only does synchronized calls above the
>> async DLM API. That synchronized API should may be also offered by DLM,
>> however it is very simple as md-cluster callbacks only does a complete()
>> call for their wait_for_completion() wait that is occurred after the
>> async DLM API call. This patch activates the recently introduced
>> DLM_LSFL_SOFTIRQ flag that allows that the DLM callbacks are executed in
>> a softirq context that md-cluster can handle. It is reducing a
>> unnecessary context workqueue switch and should speed up DLM in some
>> circumstance.
>>
> 
> Can somebody with a md-cluster environment test it as well? All I was
> doing was (with a working dlm_controld cluster env):
> 
> mdadm --create /dev/md0 --bitmap=clustered --metadata=1.2
> --raid-devices=2 --level=mirror /dev/sda /dev/sdb
> 
> sda and sdb are shared block devices on each node.
> 
> Create a /etc/mdadm.conf with the content mostly out of:
> 
> mdadm --detail --scan
> 
> on each node.
> 
> Then call mdadm --assemble on all nodes where not "mdadm --create ..." happened.
> I hope that is the right thing to do and I had with "dlm_tool ls" a
> UUID as a lockspace name with some md-cluster locks being around.

The above setup method is correct.
SUSE doc [1] provides more details on assembling the clustered array.

[1]: https://documentation.suse.com/fr-fr/sle-ha/15-SP5/html/SLE-HA-all/cha-ha-cluster-md.html#sec-ha-cluster-md-create

> 
> To bring this new flag upstream, would it be okay to get this through
> dlm-tree? I am requesting here for an "Acked-by" tag from the md
> maintainers.
> 

I compiled & tested the dlm-tree [2] with SUSE CI env, and didn't see these
patches introduce new issue.

[2]: https://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git/log/?h=next

Thanks,
Heming
