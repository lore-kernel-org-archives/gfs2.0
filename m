Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FE77347F
	for <gfs2@lists.linux.dev>; Thu,  6 Jun 2024 22:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717714567; cv=none; b=PikdqXQzS4u4vuPwP8Wxuga8VTxsImLfe0Y3W0FFsz7dkdSCmrt0pbx2tqUhbOCYFM601tFrCFRhpEEWAxRaZcZM8LCIGapROf18rUawfzZXr54LkJSOraPe16M0/kFNKSxXv509+W5y6B9fgCEyRxkmzpXNt/8Jp4nwl2ng5Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717714567; c=relaxed/simple;
	bh=zfAJG/dx/KFbiaQWm7ckdwQg8HMwx0/Tpc294oA8f9Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n3AMAgx403lcZvvcFE/DI1XcAZ0+3LD/oRmR2ZFqRykFnAGsh53/ef+Z5JDdHl1AsxX+txzRpAO1mGF1ur7pWhMNIXrmAHwkb7HXkM52Tn7YW61PuZvfBxOaXGurM9d+eL7jJhxJ4aTEswViHxAB97YMQfKRGLrrOBedxZRzCe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZP2WlA5b; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZP2WlA5b"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ea903cd11bso19827871fa.1
        for <gfs2@lists.linux.dev>; Thu, 06 Jun 2024 15:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1717714563; x=1718319363; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wbs9P3xx67wtMJaRxm+g35qxE1ZC9ShgycTHRHTMd/0=;
        b=ZP2WlA5bsiQnnQK7LK3Jgd9syWLXtGJCC3ZWo2tnImTs6xfWbU2yHW2RFEPhoEObcf
         2a2yHnSQJ/x+D98VOotAoqD49WwSblPOuSpBp9csz9l35I1Q+3QfDMGuYOqwwZ+RjpNL
         dzcxxInsCbu4/B5t5qeGEhF6wy0kapDqpq9uuKCBEr7/x7C3PyFnBDJN4fzpQK6yTm+o
         iFCNxssN0+cBcMjTok0jJ/yhNRVNANETLyrVSTylTNKplgRVJzz3ZDHdsfcCfPrtXR+r
         i6yJWvVzlb5v4BcNsUNkuJs0IX7Sg9eTDoPm6kWQZ7wWCBStY9o4756H1zfFU15LNPBZ
         s9yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717714563; x=1718319363;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wbs9P3xx67wtMJaRxm+g35qxE1ZC9ShgycTHRHTMd/0=;
        b=BGzTGOO5ZHKdiy2jMbrivkh7efu3BfZLebPnc7yoaEoYO3vP7XO2Xgz6Mn18j4RWeW
         wsUBXanJeLI/8vKKItxcqZjbTPaUoA3XFsn5UVq1DVWv7LdbVn1YcYzfyX39VExzAZ7y
         3yHA7bTPmj84y+N9wD8RnL/kX164qRww/qYTCMHlTPvZxrACA3U9eP8tXZdtGN0HhseN
         PZpwjXI1qR5siIKmiQ6Nv8ytcVqm12BajuPxf0VzMwstMIyA5uosBO14kNpGfRuKscIk
         Xg+lrDNtUqeDEdNIL8W7QvBAylcJQUNMBjz6iJ+HVEXLCeOMj3g/bjw7oIl+4zjSFHhf
         J9Ow==
X-Forwarded-Encrypted: i=1; AJvYcCW2HSCRJLRt4JLXPqdhJS164epGykg+45+mjeG/dd3cLQvXydq6ZZtrkYn8p85ki20o+FpHEYBn8ge7ABZkZ5TwLf6QPA==
X-Gm-Message-State: AOJu0YykoHblPfO4qRTm99NUQOqPO4ahTVTqIqA1Qx0KR0h1ZiYil3tv
	nTb16bBeAqiCFTaKc+o60m9Q03d2jpkNDkU/rzTXcWJLUDTYk3slZNzDmUxttIs=
X-Google-Smtp-Source: AGHT+IFRoEqtOm0yBbVkLY6IAaHoO2ld+VdSDl2ACdRQg+LI9L5GcqN6rdfFi/Yx03Au0JrnqNijSw==
X-Received: by 2002:a05:651c:d2:b0:2ea:7f78:6d56 with SMTP id 38308e7fff4ca-2eadce258dbmr7409261fa.3.1717714562633;
        Thu, 06 Jun 2024 15:56:02 -0700 (PDT)
Received: from [10.202.0.23] ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6de221268cesm1618305a12.38.2024.06.06.15.56.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 15:56:02 -0700 (PDT)
Message-ID: <b8a06dae-23f8-4684-b969-5d9ca409917b@suse.com>
Date: Fri, 7 Jun 2024 06:55:58 +0800
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dlm/next 8/8] md-cluster: use DLM_LSFL_SOFTIRQ for
 dlm_new_lockspace()
To: Alexander Aring <aahringo@redhat.com>, yukuai3@huawei.com, song@kernel.org
Cc: teigland@redhat.com, gfs2@lists.linux.dev, linux-raid@vger.kernel.org
References: <20240603215558.2722969-1-aahringo@redhat.com>
 <20240603215558.2722969-9-aahringo@redhat.com>
 <CAK-6q+i18_oHfdh6Odfidi0y4hWiR9bn_svWf2BwPqnLwdEFGQ@mail.gmail.com>
 <41da824f-f3e5-429f-a701-5feddf8b2ed1@suse.com>
 <CAK-6q+j0rbQ2CZ9y9wxZBUxsgGV03nF+ahVZPJEQPoUW-Mc8nQ@mail.gmail.com>
Content-Language: en-US
From: Heming Zhao <heming.zhao@suse.com>
In-Reply-To: <CAK-6q+j0rbQ2CZ9y9wxZBUxsgGV03nF+ahVZPJEQPoUW-Mc8nQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/6/24 22:33, Alexander Aring wrote:
> Hi Heming,
> 
> On Wed, Jun 5, 2024 at 10:48 PM Heming Zhao <heming.zhao@suse.com> wrote:
>>
>> On 6/6/24 02:54, Alexander Aring wrote:
>>> Hi,
>>>
>>> On Mon, Jun 3, 2024 at 5:56 PM Alexander Aring <aahringo@redhat.com> wrote:
>>>>
>>>> Recently the DLM subsystem introduced the flag DLM_LSFL_SOFTIRQ for
>>>> dlm_new_lockspace() to signal the capability to handle DLM ast/bast
>>>> callbacks in softirq context to avoid an additional context switch due
>>>> the DLM callback workqueue.
>>>>
>>>> The md-cluster implementation only does synchronized calls above the
>>>> async DLM API. That synchronized API should may be also offered by DLM,
>>>> however it is very simple as md-cluster callbacks only does a complete()
>>>> call for their wait_for_completion() wait that is occurred after the
>>>> async DLM API call. This patch activates the recently introduced
>>>> DLM_LSFL_SOFTIRQ flag that allows that the DLM callbacks are executed in
>>>> a softirq context that md-cluster can handle. It is reducing a
>>>> unnecessary context workqueue switch and should speed up DLM in some
>>>> circumstance.
>>>>
>>>
>>> Can somebody with a md-cluster environment test it as well? All I was
>>> doing was (with a working dlm_controld cluster env):
>>>
>>> mdadm --create /dev/md0 --bitmap=clustered --metadata=1.2
>>> --raid-devices=2 --level=mirror /dev/sda /dev/sdb
>>>
>>> sda and sdb are shared block devices on each node.
>>>
>>> Create a /etc/mdadm.conf with the content mostly out of:
>>>
>>> mdadm --detail --scan
>>>
>>> on each node.
>>>
>>> Then call mdadm --assemble on all nodes where not "mdadm --create ..." happened.
>>> I hope that is the right thing to do and I had with "dlm_tool ls" a
>>> UUID as a lockspace name with some md-cluster locks being around.
>>
>> The above setup method is correct.
>> SUSE doc [1] provides more details on assembling the clustered array.
>>
> 
> yea, I saw that and mostly cut it down into the necessary steps in my
> development setup.
> 
> Thanks for confirming I did something right here.
> 
>> [1]: https://documentation.suse.com/fr-fr/sle-ha/15-SP5/html/SLE-HA-all/cha-ha-cluster-md.html#sec-ha-cluster-md-create
>>
>>>
>>> To bring this new flag upstream, would it be okay to get this through
>>> dlm-tree? I am requesting here for an "Acked-by" tag from the md
>>> maintainers.
>>>
>>
>> I compiled & tested the dlm-tree [2] with SUSE CI env, and didn't see these
>> patches introduce new issue.
>>
> 
> Thanks for doing that. So that means you tried the dlm-tree with this
> patch series applied?

Yes.

-Heming

> 
> Song or Yu, can I get an "Acked-by" from you and an answer if it is
> okay that this md-cluster.c patch goes upstream via dlm-tree?
> 
> Thanks.
> 
> - Alex
> 

