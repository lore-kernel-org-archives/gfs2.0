Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B487256C92
	for <gfs2@lists.linux.dev>; Tue, 25 Feb 2025 06:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740464830; cv=none; b=fA8Ui1AAu8YAJAunvDs1ecUViwJsnbdLW6Q03D2aaUs9xHCqiz3YDxQX5APPwNoTA8FyjDdPkALTOAI2AYzpTA/E9My/GaeON2l+oAaiJ0q2bGUwog9HkwpBbbOWkAqphe4Y6Wm54ZeRO2irB9Y7Audj99wsBEJu+qbJlvFl/pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740464830; c=relaxed/simple;
	bh=0DB/5WBDGfYkhbcBI+jJDwgON9DPWQxIFSOh7FHrPQQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DuPoS41mCMuTC9IB432JVCT8Vj4WMXhNgIHwXa+Vf7c9dU2fARdd8t8ZlS4kImyRo1prnyEnE6YrzdiEmRNLIivtRni/u4CnJ7BZy+ExWhYbBQgkh+e0dCJ9MiRG/Y1Ox1aIBrx2wCgL6KQraTUyDT5bUWfvKnYE3ydB8jwpgy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bqXDYRvv; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bqXDYRvv"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5dbf65c0c4fso1121722a12.0
        for <gfs2@lists.linux.dev>; Mon, 24 Feb 2025 22:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1740464826; x=1741069626; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XofMw2Vp1gyn9nO9LkkW5RKPZQjn0uN77SCZ0ciTdV4=;
        b=bqXDYRvv5PafQPW1vE0xTQEpP3stMtF77n0K+vWmoq1rcKnPS6JJqOTHLTI3eyc5Nb
         UUXL3rdaHQ2ps9sYP6w+GjxeEgPCA5hdZWh4wf6G6zH+eepyGM4SCokH0GVNHymuZGh3
         qOyUgy9IUdqiO6pDGR+aqFF7o4MoIrJx66iG/weHC4U2f1ta9B6DN9KccBbStREXdcDL
         Y58o6+Cc4WS4MjEfWKvgi9u2DkXyRkLrHOH5ONV5j6qay0bF+qiNGGE+eWRCxM0a6bui
         xyRRtldkMUNv/AXAMX1/qrc5v7vKNb75mXlSsicxuEVE3f5eMeaIAPSvU/z9XbdRZKF+
         +5ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740464826; x=1741069626;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XofMw2Vp1gyn9nO9LkkW5RKPZQjn0uN77SCZ0ciTdV4=;
        b=HUV2v0QkflRJa4u233uzMsHZnQ93uUlM7/IUA6ynQR/2tEI/32LOTERyyD6l/D+53j
         g8PISBgKb8SOMgEiJftUehmcyrTPGKAJFkGbvDveCTzxAgTTb4j7Hvz54+wz98HyxxVb
         tYnFEYYlNJVouxi3EmEEwvEhz4Ks98MaoBOISnjW7ayIeE1URUaHp19dshpnJDZQRxad
         /iPUs++QLzNWSHPzO0bbZkis0bPAMAMrnp94a4mDvHrxooaJDnuk0Bi5UebD4Wt9zWsX
         V1Ges14OOg/JsZYU1PHGL460fLayRVktgrHGBOUxZa1tHyxQhDj+c2/MH0mQnxktkJO4
         z4mQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMw1FX3O8jYT4iJeu/KkRMwbp+CCV7E3gv22ZWJgKcdU3kYYKB6sr0fYttGo9kDCW1w+nG@lists.linux.dev
X-Gm-Message-State: AOJu0Yx89k9rk8JVIGZXoRqZuhjGmxsTgbztQOVYXUjlqFMgpMGZ5Vpi
	Uwp7BngKU3HuiGMzedNiix+P3rKcctCowQ7JJajCIKMVfgzNUmZebJcCsBEKW0A=
X-Gm-Gg: ASbGncs7LN5IjDeSDHI8c1HTRU8Kxm+Q1irMuivTinSt2lYxSmrAVmeE51/ODmVlLyq
	NfSJuLbvol7h4IZtdcmyJ/jcvwv6IYy6QdlLnlTLqGRxd64QVd4Lt5ZDuJ56Ql3rLRqiJH3WlX/
	pDlctoFRsf1pte5CYIXs87cum8SM718tq9IggPwE0DWMeteh6JmqxbW0BDVLduErBvHqhsQbjzf
	4blLiYg3uJb+R9KBJMd1EBonh3/Xa1G9h47mHHkUL++U5j3asMpo7B6tNwag5pb6dMcLJVHB9j8
	5OhvZTS0l+sWSyxDjBfCs+X+tGk/xm0=
X-Google-Smtp-Source: AGHT+IFvaJTAUopo03PFN5Qfk14BgYnE4+uwTDgDXTaCNhDzgFMeVSzOng61+K0uU8+VA0XPpYunow==
X-Received: by 2002:a17:906:7312:b0:ab6:d660:c84a with SMTP id a640c23a62f3a-abc09a0c05fmr719172266b.4.1740464826398;
        Mon, 24 Feb 2025 22:27:06 -0800 (PST)
Received: from [10.202.32.28] ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a092ecfsm6483675ad.110.2025.02.24.22.27.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 22:27:05 -0800 (PST)
Message-ID: <456aa9b1-a197-4de4-a062-2fe11bdaf179@suse.com>
Date: Tue, 25 Feb 2025 14:27:00 +0800
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dlm_controld: Support for extended value of kernel
 DLM_MAX_ADDR_COUNT
To: David Teigland <teigland@redhat.com>,
 Alexander Aring <aahringo@redhat.com>
Cc: ccaulfie@redhat.com, jfriesse@redhat.com, nicholas.yang@suse.com,
 glass.su@suse.com, gfs2@lists.linux.dev
References: <20250221150937.21642-1-heming.zhao@suse.com>
 <CAK-6q+iiMqW9eknqgVZiKjeUgSEAkL61Q-EbP8xwy_bayjS=fA@mail.gmail.com>
 <Z7zJ6OQIzC9Q20sG@redhat.com>
Content-Language: en-US
From: Heming Zhao <heming.zhao@suse.com>
In-Reply-To: <Z7zJ6OQIzC9Q20sG@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/25/25 03:35, David Teigland wrote:
> On Mon, Feb 24, 2025 at 10:27:04AM -0500, Alexander Aring wrote:
>> What are we doing with the detect_protocol() change? You want to
>> submit the current version again? I would like to test it with
>> corosync 2 vs 3 with no configuration changes on an upgrade (if this
>> is even possible).
> 
> I suggest we stop trying to detect, and always use tcp unless protocol is
> set to sctp.
> 
> Dave
> 

That's fine with me
For corosync 3.x, there is a lot of work to support dynamic multi-link.
However, to support config mode, the current dlm code only requires a few modifications.

- Heming
