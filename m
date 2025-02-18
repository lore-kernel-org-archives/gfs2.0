Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FDB154C12
	for <gfs2@lists.linux.dev>; Tue, 18 Feb 2025 11:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739879202; cv=none; b=rzDmkvIlyhCeysy/wqfeR3Lez237ppSJ8c94h1RFgI8URQotZPSwgdnEvlDoLoWE0Bn6VzZ3KvfOsZ2tbVPKjAu1c5T4zmLnsidStanoXN2iawuAtvBEzGAb3cpWHCon8VImAZJO0tV+UmmB4ZKcnuchFef0OuSwEvfFe8Vdu+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739879202; c=relaxed/simple;
	bh=YGFp9AUYli5ZlrdS+27XCSj8YwNOPyB8DFTtlvKqQfw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hn8rS5By/6akFGW/J04OrKhU639Oh+y8Y6zg+Al2ldC2kmyaoWdgPuZJfkh5ELHkwaUQJmOdTFZUfTiuEbBHQ8nfu6JBXeHkVP+wM1J67nkUfFv7hSpS83iiRFEagldfO1tBpudLPSo2qq1d5oCYVCVrPXDqONCS8bVvmXjQnNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Q0fcHdhE; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Q0fcHdhE"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4394944f161so4626735e9.3
        for <gfs2@lists.linux.dev>; Tue, 18 Feb 2025 03:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1739879198; x=1740483998; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3KQVeu7kzXUgdMmnykbSIQdnbuLF/FWXdrjG+4kGfCo=;
        b=Q0fcHdhEeDPiaSg3+MEFaM5ukaifY1heBLJs9atJWGPNIfbBGKCgulV5+2k/HC6GIJ
         212jgLb6i8tr7cm7Fua6qslW2/eiQeh08HnF76593Xkc9uBf1L8E4lBaZxvH/qPZVBvT
         dBeWJBsI8/Gmee/PYmUrbPlzl4bilHUpEyQKced6oPZRxsMKoyl77DQLWTb3FY6uxfUT
         U2yAsDtV16jENMfa+u5xLlCRE2Xovshi436Zq9apc3TaS0Q9yMxkiBvyB9mTXk8TQUDO
         Huh0svC1Ev5em/GR2LXOuComnRx88XB9H60Hs5UFpFfcabEgXQq0z4Ui0+/LEtyIEuyI
         DLkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739879198; x=1740483998;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3KQVeu7kzXUgdMmnykbSIQdnbuLF/FWXdrjG+4kGfCo=;
        b=fNIf8HjWDXzV3FAD7Kl+2llu5pm8TF1r+ZduSQ4/82ZuT48krdXG3tSzD+HvtDPNQc
         QehI7JZzycSZfqk2jBKU7z7jc6hTI3/zUyFY1oZVrng9CSc5kJrprYGA70dagWptoHZ8
         v3LYr3pRTyDRKP46oaAW+O1QK4Qnhb053YGlHviuHsaF4afuZ2AG0v9P73TgSpwv2V71
         0Av6u43rfW6DuqeWprn20W0uB1iwF7JMpBroYtYevvdidQw8JzQ0jrOE3hhlnSE7rlqv
         +d/jS9cHGImpHov5I/0YuKaMi5r6ISEC2vPTmHvRTPt2nT1DocYbcSjLzRLQVsCh9Be8
         63qA==
X-Forwarded-Encrypted: i=1; AJvYcCUkvZgc+F72/HuxwXnfT/qxkJ3aBArJffpcbuDUNnkH3EZ9GoRcA/PY11Ut4NgXRyrO80IQ@lists.linux.dev
X-Gm-Message-State: AOJu0YxLCwpq8rDMGI2Ak7QBeGZ8VUHIQQ1H6U8rbjSrLtdeQic9S3Te
	GNuN/CwXJfP4Ghdw5crraCGohu21FugIB3oW8zz0mOyEmCs1J6LanKQEJtQ9OdM=
X-Gm-Gg: ASbGncsy9RChbXSVlm0litI1o8pi9ai3c4OKU8WwpBvv9Eug5vu+Aa+8Sh8kzRbLl+6
	4ClAuHVWQ7wamsRaDB5O6eFGmrPUbrD+N6gXLH73k8uZ9FMH82k1rctbmLyBREGmrWiGO8vW+BF
	hNN626YbVl5tmr0CNBdFL64LEsa0Z1wTdV0NfCp/Kq5PoHNhNlak6lQu55sPnaks0n2AAGc0a5c
	ZE0qcJGF7Sq6yRqv/TzQFy6xOUaDFDVuzc5FupU4aeYp2R0nmAzNCv3jW2RiBeFNdQ2oBhZxWuO
	8N90v4WyvQM7cjwSDt2YWQ==
X-Google-Smtp-Source: AGHT+IFldIC4y2Kwib4QBdaXjPRQAwNRRXaez7rxjxxfcNxyEMRf917oR7LRd5GMMtvJDeiIA1r+Pw==
X-Received: by 2002:a05:6000:2a0c:b0:38c:5cad:1003 with SMTP id ffacd0b85a97d-38f33f28ccfmr5264464f8f.5.1739879198051;
        Tue, 18 Feb 2025 03:46:38 -0800 (PST)
Received: from [192.168.2.101] ([114.254.72.128])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7327793ddb8sm4257987b3a.72.2025.02.18.03.46.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 03:46:37 -0800 (PST)
Message-ID: <ca9f2519-6dba-4927-b61b-6d5852473275@suse.com>
Date: Tue, 18 Feb 2025 19:46:33 +0800
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
 <55a997d3-df7b-4ead-8ddd-d4819ca95cf0@suse.com>
 <CAK-6q+grrJ5K7FTRnyFatZLTq726s5Y_S8CoKXWywedUTzp3rQ@mail.gmail.com>
 <54d17bad-997e-4271-9d76-679a923b4ea8@redhat.com>
Content-Language: en-US
From: Heming Zhao <heming.zhao@suse.com>
In-Reply-To: <54d17bad-997e-4271-9d76-679a923b4ea8@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello Christine and Alexander,

On 1/17/25 23:16, christine caulfield wrote:
> On 17/01/2025 15:11, Alexander Aring wrote:
>> Hi,
>>
>> On Sun, Jan 12, 2025 at 10:13 PM Heming Zhao <heming.zhao@suse.com> wrote:
>> ...
>>>
>>> The current dlm code design doesn't allow reconfiguring the network
>>> protocol on the fly. In the above scenario, the dlm will maintain the
>>> TCP connection until the next dlm_deamon restart.
>>>
>>> In my view, it's not essential for dlm to follow the knet dynamically
>>> multi-link style. if the user hasn't set the 'protocol' item in
>>> dlm.conf, (with my patch, for knet env), dlm will detect the corosync
>>> nodelist on startup, and set the appropriate protocol mode.
>>>
>>> If the user want to keep maintain a multi-link for dlm, they should
>>> set protocl item in dlm.conf.
>>>
>>> On the other hand, if dlm needs to dynamically change the number of
>>> links during runtime, it should always use the SCTP protocol.
>>
>> to move on here, I would at first apply/ack the patches for the static
>> maximum address increase.
>>
>> I see no problems to do that as this is required by you.
>>
>> For the automatic protocol detection and corosync3, at least I need to
>> doing some tests as I have currently 0 ideas how corosync informs the
>> users about new/removed links during runtime.
>>
> 
> To be honest, it mostly doesn't - and it's maybe something we could look into, though I doubt it would be high priority as this is the first time it's been thought of :)
> 
> Currently you can watch for the cmap key config.reload_in_progress and after that goes from 1 back to 0 re-read the new corosync.conf.
> 
> Chrissie
> 
>> - Alex
>>
> 

Sorry to raise this context.

I suspect Chrissie misunderstood Alex's writing, Alex comment is about another
patch [1], not this patch.
In my view, it's not harmful to increase the address number in kernel space.
The multiple addresses are SCTP specific, Even if some of the eight links
go down/break, with the SCTP redundant path feature, the SCTP can still work
normally.

[1]: https://lore.kernel.org/gfs2/20241220071418.16786-2-heming.zhao@suse.com/

- Heming
