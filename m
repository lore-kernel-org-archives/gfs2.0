Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB3714F104
	for <gfs2@lists.linux.dev>; Fri, 17 Jan 2025 15:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737127019; cv=none; b=cQJCEkUXggszrZn5+ohPR7NHCL6RP8qUMLfteuBECA6VaQeEsQyWp3fOWY2fZ54nKN374uZmVFEEDow8A47PwaX4SOzsvaFjZm0/xLFuOr6vD5Q9FNmUjp1qPFjHFLq4MUE1b0QAKHSO/6hcVwD50eu9/By7LMzkvpJXyJE7XZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737127019; c=relaxed/simple;
	bh=G19fGvQFsaKs0p90CImvMMDVxn6RhYqwvVURRdhJLL4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XWuZq2mUk9UZdwbDh2C+PdbvIX4ESwr1z24JWUtYYd4e/dHLIZOgA29YnaUM83Cs9ilGLvUAs5ZQPSqO0ycRQ9rWnkppCJLHdZk7JvRU5gXmbC3PwinAq3KcKI3TDR5hRVMc4Pm23+zJzg6XG+bnBnoNZR7q5BDTTfV1DCRL3HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eGStpDg8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eGStpDg8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737127016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zc1xCt28z1O5jDwXa4OJm5oK+9rhHE+x5Zaan8txRDE=;
	b=eGStpDg8NJrzvM/NY4AKfI6NBef/0JhQvjnJ3Mg7FhtUfz7qQ7oHsRnklsAdjTHNPFWJva
	QEkSUjGo7VO4EwsWkVhG9gjVXcrC4t4KwjfjpAP+IGfIosnhGlKda7UeLFHzgITQVUGHBL
	RyZW+apa16dM4IysZzG5cs95aNG8MH0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-KS83X3FXPoe8TPcw1uRgQg-1; Fri, 17 Jan 2025 10:16:55 -0500
X-MC-Unique: KS83X3FXPoe8TPcw1uRgQg-1
X-Mimecast-MFC-AGG-ID: KS83X3FXPoe8TPcw1uRgQg
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4361fc2b2d6so11699625e9.3
        for <gfs2@lists.linux.dev>; Fri, 17 Jan 2025 07:16:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737127014; x=1737731814;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zc1xCt28z1O5jDwXa4OJm5oK+9rhHE+x5Zaan8txRDE=;
        b=CZgDl5MVYerDs17TK4AW5huVypleW3W0seJFDiRMV0crlOiNFyjZuoZLG4aJOxW2u0
         0tNxtjOxFZu8ZvuspWB3iJ+i28t/lwsRlSrbHnQvzYOG9I67otcE768EBTwRUtedcuIy
         I0lW1iDhJoJHl663vLEfmb5ksMu5CtCI2nX6yJC3J2MG3QFZDsGj6ls5FCdrMctu0mQE
         tTd9OkwTgblBV3ffNasFwsI8h8v5qlMLob4JYlrJcGAn0In0+qkHWa5qzV/ILJthD2PF
         tB0QN+WCNXnMyhMjVvjmC6W3G6IiXIsCoOrcOqBG8DG3WrC3Bip1GRpxyQWY6hcyxJRW
         4vdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPrKJK2vOpssaafb6++OHxBlAbMPATxB8M/1+D56+eLyKrPx6PN9QkrJvfRFtK8m41Rs22@lists.linux.dev
X-Gm-Message-State: AOJu0YwNjOgw3yLgdX51lo+2vA1sTRMnStLkxA37ab3sbOXwZPsdijxD
	DPAQjV3/4T1t58WTdvYcIQEKvJ6DRwxHG+Mn/T4pxCTipSskG99WzIKfoPUBP1VfYi2CAmS1XFg
	PyTcAPZFfM1Yf3ybjhuTErMG25rM4qBbOimM2vQsTKN5l1ZAztQs=
X-Gm-Gg: ASbGnctuVVO1b9VQXl6qqCj6iczoJOnYJ7+CfD7nnyrAJl09l9sZX564OiYhXYC8B0E
	8JuJlkX07B7oUKpQKFtpYfPfzSYv65OBsj8xQOjinsAIMvlCIsThpapQhJnZrOTJY+vsx/jnvzv
	YZraImAClN973jdi12GoskcIzZ2atqOib7nzEMo7b1tDz8WePMbTRd/h9mL38RpnIBZpZDwuEnj
	NftFbZkSYLFdl1YjguYWMrYUVoPo/DLWVyXOaC2FJxrtKBwQOOm6/dOSRqG5bYCxTNva/DrBW4S
	TRS9Qo4IOmrMyyLeKTwvsqBK2rK61irdCYUytRX8eSqMY0ms
X-Received: by 2002:a05:600c:1d14:b0:436:46f9:4fc6 with SMTP id 5b1f17b1804b1-438913d63cfmr31606405e9.8.1737127013743;
        Fri, 17 Jan 2025 07:16:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGtn0K7L+eLqVwIOTYO7nIbB/eFi2wxpw+a7EP9qZw4dhn9Mb41U4vw+cqyfcyY+RJjcNXuIA==
X-Received: by 2002:a05:600c:1d14:b0:436:46f9:4fc6 with SMTP id 5b1f17b1804b1-438913d63cfmr31605975e9.8.1737127013370;
        Fri, 17 Jan 2025 07:16:53 -0800 (PST)
Received: from [192.168.1.44] (seac-27-b2-v4wan-169614-cust2769.vm25.cable.virginm.net. [81.99.250.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf327e19fsm2816366f8f.93.2025.01.17.07.16.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jan 2025 07:16:52 -0800 (PST)
Message-ID: <54d17bad-997e-4271-9d76-679a923b4ea8@redhat.com>
Date: Fri, 17 Jan 2025 15:16:51 +0000
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
 <6e96fe53-869a-40b4-8c28-f7568f2987d5@suse.com>
 <aaec163a-fadf-4c7d-a193-9b0eb97d584b@redhat.com>
 <55a997d3-df7b-4ead-8ddd-d4819ca95cf0@suse.com>
 <CAK-6q+grrJ5K7FTRnyFatZLTq726s5Y_S8CoKXWywedUTzp3rQ@mail.gmail.com>
From: christine caulfield <ccaulfie@redhat.com>
In-Reply-To: <CAK-6q+grrJ5K7FTRnyFatZLTq726s5Y_S8CoKXWywedUTzp3rQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: oFLBK8PvLm_XjYZsRd_6Bq7Jw9aNc10gXMMYF8O-4s0_1737127014
X-Mimecast-Originator: redhat.com
Content-Language: en-GB
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 17/01/2025 15:11, Alexander Aring wrote:
> Hi,
> 
> On Sun, Jan 12, 2025 at 10:13 PM Heming Zhao <heming.zhao@suse.com> wrote:
> ...
>>
>> The current dlm code design doesn't allow reconfiguring the network
>> protocol on the fly. In the above scenario, the dlm will maintain the
>> TCP connection until the next dlm_deamon restart.
>>
>> In my view, it's not essential for dlm to follow the knet dynamically
>> multi-link style. if the user hasn't set the 'protocol' item in
>> dlm.conf, (with my patch, for knet env), dlm will detect the corosync
>> nodelist on startup, and set the appropriate protocol mode.
>>
>> If the user want to keep maintain a multi-link for dlm, they should
>> set protocl item in dlm.conf.
>>
>> On the other hand, if dlm needs to dynamically change the number of
>> links during runtime, it should always use the SCTP protocol.
> 
> to move on here, I would at first apply/ack the patches for the static
> maximum address increase.
> 
> I see no problems to do that as this is required by you.
> 
> For the automatic protocol detection and corosync3, at least I need to
> doing some tests as I have currently 0 ideas how corosync informs the
> users about new/removed links during runtime.
> 

To be honest, it mostly doesn't - and it's maybe something we could look 
into, though I doubt it would be high priority as this is the first time 
it's been thought of :)

Currently you can watch for the cmap key config.reload_in_progress and 
after that goes from 1 back to 0 re-read the new corosync.conf.

Chrissie

> - Alex
> 

