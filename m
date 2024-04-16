Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BE384E11
	for <gfs2@lists.linux.dev>; Tue, 16 Apr 2024 16:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713286564; cv=none; b=HdYbY7Xx7t6WFVhT5l//3rzMCZw3wzsZqZgjgwvDIR9nAF0NJBie0ZYxNtpxe/jOGTxKBGZGgBW2L9hvZX7yWspOLFyxYFxHfPArtQArGqsBwmLzq3Wo1lX7lI25sjEwHjx+fkWE8z5XDfYS7ls3HyRC/ibb1Hby7yctI2uZsTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713286564; c=relaxed/simple;
	bh=onvZp+a/+L3ZA5BZGevSkOr68252znWc1zkjQ1z5/Ow=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=FO+Xpp0p5EaLxQ+SC0m8rNOsJx2Sa3bv/Vcj7iSvsa+m40Cs86Z7SVH0SIQWs8Qa3moCaCGPk2L0e/HdiCE3bxyp2TIeVL83y9NVMaSwloYb41Q7coi4Dq99UgFwAXWy/2F+pV79lEpvJKeiQj6yXJHb4EnhRGPpoE2aMVnxy5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iEQaCELE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iEQaCELE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713286561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zsBUN5rcyjSPJmuXASTIo60So2ed1W3NoWY7T8zLCPk=;
	b=iEQaCELE2oN/REsuLcBCY0HYQNZQQ4SIHT71leEI7B+4Vgk+tBT3R+T1brLWqnGAvMhagH
	u/EGYm9dbtCpC0ULpWd2eei3lut23aUBKRgWTxBGAFlMon+LQIwHHFb2NIKP/Hln+CW9Hx
	J/n4a9y50ZZp6YOFwAhXMcwwF4vreao=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-264-PhXUh3-gPSyQu_0G0Fc-PA-1; Tue, 16 Apr 2024 12:55:59 -0400
X-MC-Unique: PhXUh3-gPSyQu_0G0Fc-PA-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-78ef59dd0d1so98582485a.0
        for <gfs2@lists.linux.dev>; Tue, 16 Apr 2024 09:55:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713286559; x=1713891359;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zsBUN5rcyjSPJmuXASTIo60So2ed1W3NoWY7T8zLCPk=;
        b=HmJfbWm3HZbglqgDjyEi+pKVyV74+FOoU2UYvZkoGdDF74slTsQloy4J92tfF52YVu
         MNShqBJdBS2Ti6kSl9yac9SCvGXPIqgEFZarwqFWYEf5r7xXmTtLBxCvWiQkyq8jb2Tw
         pSPrws5sCnbjczB16Xc1VgrFfnnq+6EJ3UyH6DGOKawR2hgSNfcH4/nFU0jL7sn45GoL
         XXlLqRFAUPaxBI+p42D157nK8c8pNEtHeUusoMHxWMG3+iX4TO9o9eZvWlDvmVg8FpAF
         Nc0gPAJtSIIjRcGyECYOmNypLWRo6px+8aR/+Q7xdXOOsqN3b0pvqo+KCcKJA7UKk7U4
         Dskg==
X-Gm-Message-State: AOJu0YyRtn6x5kDTyLLZIrvHqbyIrPOzMVVVZ+klbGFdRbcO9MCnkufB
	XpVsMwNnYWrwIb8m/bvU0wUbMebqAI3GKBzWuTfdTZewEyKjdonDv+SEuv5r/CGGnJbtF1ln6xr
	HbGn2/Fb/eurRcghuN/jgQhtVX8APTVBFoIDpVQUtL4jrHBADkd4=
X-Received: by 2002:a05:620a:3181:b0:78e:d962:5171 with SMTP id bi1-20020a05620a318100b0078ed9625171mr11176699qkb.28.1713286559300;
        Tue, 16 Apr 2024 09:55:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1DM+SsyXiUYmjKxc4s7M6qdSbmaILbBd6qoOY+CcZf9Xpc12r73Vg2/SneYOROWiZgu4B8w==
X-Received: by 2002:a05:620a:3181:b0:78e:d962:5171 with SMTP id bi1-20020a05620a318100b0078ed9625171mr11176677qkb.28.1713286558868;
        Tue, 16 Apr 2024 09:55:58 -0700 (PDT)
Received: from [192.168.1.165] (cpc76484-cwma10-2-0-cust967.7-3.cable.virginm.net. [82.31.203.200])
        by smtp.gmail.com with ESMTPSA id z28-20020a05620a08dc00b0078d6303c099sm7632114qkz.112.2024.04.16.09.55.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Apr 2024 09:55:58 -0700 (PDT)
Message-ID: <f1c9bcc3-475f-4b1c-8a0a-078c200d31e2@redhat.com>
Date: Tue, 16 Apr 2024 17:55:54 +0100
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/15] gfs2: Fix "Make glock lru list scanning safer"
To: Andreas Gruenbacher <agruenba@redhat.com>
References: <20240409164508.79570-1-agruenba@redhat.com>
 <20240409164508.79570-14-agruenba@redhat.com>
Cc: gfs2@lists.linux.dev
From: Andrew Price <anprice@redhat.com>
In-Reply-To: <20240409164508.79570-14-agruenba@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09/04/2024 17:45, Andreas Gruenbacher wrote:
> Commit 228804a35caa tried to add a refcount check to
> gfs2_scan_glock_lru() to make sure that glocks that are still referenced
> cannot be freed.  It failed to account for the bias state_change() adds
> to the refcount for held glocks, so held glocks are no longer removed
> from the glock cache, which can lead to out-of-memory problems.  Fix
> that.  (The inodes those glocks are associated with do get shrunk and do
> get pushed out of memory.)
> 
> In addition, use the same eligibility check in gfs2_scan_glock_lru() and
> gfs2_dispose_glock_lru().
> 
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> ---
>   fs/gfs2/glock.c | 24 +++++++++++++-----------
>   1 file changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
> index 2882a42e88aa..04e0a8ac61d7 100644
> --- a/fs/gfs2/glock.c
> +++ b/fs/gfs2/glock.c
> @@ -1987,6 +1987,14 @@ static int glock_cmp(void *priv, const struct list_head *a,
>   	return 0;
>   }
>   
> +static bool can_free_glock(struct gfs2_glock *gl)
> +{
> +	bool held = gl->gl_state != LM_ST_UNLOCKED;
> +
> +	return !test_bit(GLF_LOCK, &gl->gl_flags) &&
> +	       gl->gl_lockref.count == held;

Wouldn't this comparison go wrong when the lockref count is > 1? In any 
case it's unusual to see a lockref count being compared to a bool.

Andy

> +}
> +
>   /**
>    * gfs2_dispose_glock_lru - Demote a list of glocks
>    * @list: The list to dispose of
> @@ -2020,7 +2028,7 @@ __acquires(&lru_lock)
>   			atomic_inc(&lru_count);
>   			continue;
>   		}
> -		if (test_bit(GLF_LOCK, &gl->gl_flags)) {
> +		if (!can_free_glock(gl)) {
>   			spin_unlock(&gl->gl_lockref.lock);
>   			goto add_back_to_lru;
>   		}
> @@ -2052,16 +2060,10 @@ static long gfs2_scan_glock_lru(int nr)
>   	list_for_each_entry_safe(gl, next, &lru_list, gl_lru) {
>   		if (nr-- <= 0)
>   			break;
> -		/* Test for being demotable */
> -		if (!test_bit(GLF_LOCK, &gl->gl_flags)) {
> -			if (!spin_trylock(&gl->gl_lockref.lock))
> -				continue;
> -			if (!gl->gl_lockref.count) {
> -				list_move(&gl->gl_lru, &dispose);
> -				atomic_dec(&lru_count);
> -				freed++;
> -			}
> -			spin_unlock(&gl->gl_lockref.lock);
> +		if (can_free_glock(gl)) {
> +			list_move(&gl->gl_lru, &dispose);
> +			atomic_dec(&lru_count);
> +			freed++;
>   		}
>   	}
>   	if (!list_empty(&dispose))

