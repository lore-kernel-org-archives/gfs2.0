Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F741429E
	for <gfs2@lists.linux.dev>; Thu,  2 Nov 2023 13:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="APT6DI/C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698930863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4VLgJL0v6YOBTvlgSs90Y42whRmngJggDBoFYPWtLC4=;
	b=APT6DI/CaVHVDTKIW0FpdNzc54zjvhisBDZnLnQCXnpuXg53EAlKOBBEY194PrPnDgQXWP
	lBIOJsJgyrsaFBhX1dLAKGjGKu4QKeJmTuQpg9yBp/GHuN41I09bba1hUAM5GyvxeUmTaP
	8tgXKLg4AxwPsCBp0BxtR3l7JuNrFHY=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-hpHpxtLvNAuhksrhJMS6mA-1; Thu, 02 Nov 2023 09:14:21 -0400
X-MC-Unique: hpHpxtLvNAuhksrhJMS6mA-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-66d03dcdc6bso10296546d6.1
        for <gfs2@lists.linux.dev>; Thu, 02 Nov 2023 06:14:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698930860; x=1699535660;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4VLgJL0v6YOBTvlgSs90Y42whRmngJggDBoFYPWtLC4=;
        b=pdHkpDOaHz31DU7fe7UieD5eRJdBpGdlU+l3rQaD1Lh5OKv0IydPGIrPaicZHt9Gki
         3bsfMMjjcImLs0Oz3ihMHS5z3tYGR9dwSN/NKSD2VbVibYUn2IBalV7Fw8BjdlR/9iVS
         2mjx3pWyWF0iycdvkzbBrKKVd2uggaP7uIACovQIXLHoTrG0usmrM61V6A6Xw4UnIAUl
         htcEPoywARRDZmIXDHUa43ZlCcvoKwPFmMC2RFC5qVA45Ee+kuwGH1w745mrPgPVe1tX
         x2OFBvHpQpgk32i+z7NP0wQS0yZDgVhO/tA0QXqrwzOopS3iKH696J8rOyAYv/xx/PUD
         aTGg==
X-Gm-Message-State: AOJu0YyBdCKs/1hDJfQqO6yEttFJ7KEdr9pIIchgvp7JU0/sVYOM0pRW
	6Dfb6v0kO94FuxYsNRHfM+q5gE+u8YQ23wPRmsCE+p1WU1tYnZUooXVF1AFerk1PA7YIP67AAoE
	iwC83ooj6KDskFHkWdC6rEg==
X-Received: by 2002:a05:6214:2464:b0:65b:a66:3109 with SMTP id im4-20020a056214246400b0065b0a663109mr24065285qvb.8.1698930860410;
        Thu, 02 Nov 2023 06:14:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFe64pBsFJa8i0IOR88XHTY1HN653StlxTTPqLZEaJrkd8ebqXzqwh9w4KaAdqBse/uXQYL6w==
X-Received: by 2002:a05:6214:2464:b0:65b:a66:3109 with SMTP id im4-20020a056214246400b0065b0a663109mr24065274qvb.8.1698930860159;
        Thu, 02 Nov 2023 06:14:20 -0700 (PDT)
Received: from ?IPV6:2601:883:c200:210:6ae9:ce2:24c9:b87b? ([2601:883:c200:210:6ae9:ce2:24c9:b87b])
        by smtp.gmail.com with ESMTPSA id s4-20020ad45244000000b0066cf4fa7b47sm2389277qvq.4.2023.11.02.06.14.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Nov 2023 06:14:19 -0700 (PDT)
Message-ID: <9831e5bf-ee77-480e-98a6-68a852911ab2@redhat.com>
Date: Thu, 2 Nov 2023 08:14:18 -0500
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/25] gfs2: Two quota=account mode fixes
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: gfs2@lists.linux.dev
References: <20231101164615.1138692-1-agruenba@redhat.com>
 <20231101164615.1138692-11-agruenba@redhat.com>
 <c512895f-5d97-4227-9885-6948f5bbbe9b@redhat.com>
 <CAHc6FU4Tz-M7uYaKy3vw9ycrqOiS6B_cHys0=txNvTHc3P+JZg@mail.gmail.com>
From: Bob Peterson <rpeterso@redhat.com>
In-Reply-To: <CAHc6FU4Tz-M7uYaKy3vw9ycrqOiS6B_cHys0=txNvTHc3P+JZg@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/1/23 5:06 PM, Andreas Gruenbacher wrote:
> Hi Bob,
> 
> On Wed, Nov 1, 2023 at 7:19 PM Bob Peterson <rpeterso@redhat.com> wrote:
>> This doesn't look right. I purposely avoided coding my patch as you did
>> in this patch because it breaks -o quota=account. I admit I don't know
>> much about "quota=account" but it's coded into gfs2 and this patch
>> changes its behavior.
>>
>> The way I coded it says to return if not "on" or "quiet".
>> With this patch it returns with "off", which means it proceeds with
>> "on," "quiet," or "account."
> 
> you've said exactly this in a related conversation, and my response was:
> 
>> According to the documentation, the "quota=account" mode is supposed
>> to do the quota accounting while skipping the warning and enforcement
>> logic. How is it supposed to do that when it bails out of gfs2_quota_change()
>> immediately? And gfs2_quota_change() depends on gfs2_quota_hold()
>> being called first, often through gfs2_quota_lock_check() gfs2_quota_lock(), no?
>> So at best, the way you've coded this leaves "quota=account" mode broken,
>> but the code actually makes no sense.
> 
> So how do you think this breaks quota=account mode?
> 
> Thanks,
> Andreas
> 
Hi Andreas,

I did not see your earlier response, (which is odd) so thanks for 
including it. The important thing is:

Your patch changes the behavior of quota=account from today's gfs2 code 
and should therefore be treated as separate.

My recent gfs2 quota patches were all bug fixes or cleanups, plus adding 
the new quota=quiet option. None intentionally affected behavior.

If it's true that quota=account is broken today, we should probably do a 
thorough investigation of how it's supposed to work, because I suspect 
it may very well be broken elsewhere as well.

The gfs2 quota code is really ugly and hard to understand, so changes in 
current behavior are scary at best. It sounds like your patch will at 
least improve it, but I have not looked into it. I'm just wary about 
adding patches that change behavior without "my" fully understanding the 
consequences. And I don't have time to investigate it thoroughly.

As I said, I don't know much about quota=account. I've never used it, 
nor do any of my tests use it. Maybe the patch should be included in a 
group of patches designed explicitly to fix quota=account?
And maybe we should add new testing for it.

Regards,

Bob Peterson

