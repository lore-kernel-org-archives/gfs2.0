Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC2F18B0D
	for <gfs2@lists.linux.dev>; Wed,  1 Nov 2023 18:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JWqnDjis"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-1f03fdfcfacso77770fac.0
        for <gfs2@lists.linux.dev>; Wed, 01 Nov 2023 11:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698862165; x=1699466965; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=GJzy8pHObqLNabFjvHQa3HjdGGWCC6wlzROR9dFBGQY=;
        b=JWqnDjis09wn1HW8rHHxJl6uL6f804lPVyX7fviXkkNeer5JIJFoj9yAB/IdDmaiix
         sRxLPiRywXJDjxVXepjUcfvOvtlBmCkZ30vOZp2oS5lQN1K6YouBd7kkmTWqRGkADrbE
         QuwxX0UHyr049wHWfG6MZxneqS6GsKQaB0zX2/7ju96M5FSJK2qI0JKd9gBIIpoVPO7Q
         /u8y5Bo8vsOtsMgKvcIjRfoCtatsOSIcR5qJgohY6RILZeYsKG2/pqwBC5Cxjkl0YPz0
         YU3sJ/gFA87MwzdP41CVfkfFD3y02a1U1hlGcqWLaXuh7pcN1nyvL+QDrkqmp+sSaeyC
         Eubw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698862165; x=1699466965;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GJzy8pHObqLNabFjvHQa3HjdGGWCC6wlzROR9dFBGQY=;
        b=tZTTmzBmPby/XaBYoWsJn6crVMQvgpgey1rw9Tzgwn/QDrxsNFrIlPSPkAsLMv3inC
         Kj/trakh9GBWoxfJa2exdh4QDch1MuD+5j74f2gBXoYQEpHHh8xjZEPYWSNNpfnDPUm/
         YqIjjMN9x/n+tBbq73DTLPoCud+Ys2erBEriW0XALv2aVCLfMNRtiq7913J16EM2AG6o
         PzKlErAZt9bbf8j5nCAZqCPq/A+i5fSZdxvMn+FIvlJWmRL0hh/R2HcQ6LEcRJ/mFwT/
         AADq1aRsD9RavDjbGRtzrLU0X1KdGz4BjpeC/10S83L1Oq/Zae0U9A2Z9r0ilp/fu+J2
         2ZTg==
X-Gm-Message-State: AOJu0YzhOpB6rlLFJKqeCo9TGyeQpwa2L+kj9iFnppQ76brPUzbsH8U0
	7jQOT2iEcduw3HJFIbq7Cwo=
X-Google-Smtp-Source: AGHT+IHF8b8qqdCkRA8NdXssoRq+q+DBI92t+9SYIN0hnVRnlpAve4kj7oE8Jfho030swS8qaR6t0Q==
X-Received: by 2002:a05:6870:a9a1:b0:1e9:e605:279f with SMTP id ep33-20020a056870a9a100b001e9e605279fmr22508916oab.13.1698862164390;
        Wed, 01 Nov 2023 11:09:24 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h40-20020a056870172800b001e9a253afa3sm303456oae.49.2023.11.01.11.09.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Nov 2023 11:09:24 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <1d91871c-773c-41de-ab7b-abf13e5e9773@roeck-us.net>
Date: Wed, 1 Nov 2023 11:09:22 -0700
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gfs2: Initialize metapaths outside of __gfs2_iomap_get
Content-Language: en-US
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Bob Peterson <rpeterso@redhat.com>, gfs2@lists.linux.dev
References: <fba6fc06-f274-4c05-9ace-b5bd6c36f08d@roeck-us.net>
 <CAHc6FU6PKutc1Ya+9Xqa0qXeJVVXMEcsX4HWwVnoZS-n9bmCgQ@mail.gmail.com>
 <7d405b46-7a22-414b-9ee6-99602ba309ea@roeck-us.net>
 <CAHc6FU6xYPCGK1MLpJ6JNsz6=Hej-ja7dgHUQLoVnis_vSKbAg@mail.gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <CAHc6FU6xYPCGK1MLpJ6JNsz6=Hej-ja7dgHUQLoVnis_vSKbAg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/1/23 09:39, Andreas Gruenbacher wrote:
> Guenter,
> 
> On Tue, Oct 31, 2023 at 1:59 AM Guenter Roeck <linux@roeck-us.net> wrote:
>> Unfortunately that does not help. With the above on top of next-20231030, I still get:
>>
>> [   15.531621] ------------[ cut here ]------------
>> [   15.531981] kernel BUG at fs/gfs2/bmap.c:695!
> 
> Sorry for this. I've pushed a fixed version to for-next already, so
> things should be fine again now.
> 

I still see the problem in next-20231101. Maybe the fix wasn't included in that
release. I'll try again with the next version.

Guenter

