Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96CB43B489
	for <gfs2@lists.linux.dev>; Mon, 24 Aug 2026 14:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787582700; cv=none; b=jNkQZnK8Z22cP3aKrA1YqB7vdoX88tyssU5dRJ9YyP9lJObW6qKHzAtoPqVRJpgl9UiQ0GDO8W6orab1968gkNkWoabARx1V2YyOSNN4yki33HKdz2F1Wa21RoNknEqxqWFiDRnpXA7GoBjKVfXy95fkye4+Qq/CflRTQTne/Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787582700; c=relaxed/simple;
	bh=qElLoDfyhdcb42ATgQhM92H08wn7Cw5DZ7qSj02j4bg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hHm5f4/QCY5WljG6uoC8Txv0PjzBZPygXJbDOimGx93zoOWSrziyLjn1AeEwAWhiKqYiYxFiGHz3AnB939mk4nlwIZ2/AWpjLoxIGalF96u+RGrAEtLyMSTXiocUBAuTb3XXAWMSqvcGPMzIR3dj8x9FFw13W6H84480XisYphY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F0N+W1AC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F0N+W1AC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787582697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3XAYzlXublgAVX17Erk+AQVD3TzEZ8AvJwaJrSwAy3U=;
	b=F0N+W1ACn/TEFFhCJ7ieIBvph/8cy96jH+DnEJtpjgRUWyayNpxu9nZaewsfeAa7veVRTP
	JsYINKn0bdK92Z7UNS5L1NVU4e3rH/6HA7mV7IdDSoVXQbw17oCHNS2hf/VgeH6g623mYa
	suUlYBg3u9mT6pWMCHbDTi++8sV8+Ho=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-7pS7X3I3MpCfIobE6UhnnQ-1; Mon, 24 Aug 2026 10:44:56 -0400
X-MC-Unique: 7pS7X3I3MpCfIobE6UhnnQ-1
X-Mimecast-MFC-AGG-ID: 7pS7X3I3MpCfIobE6UhnnQ_1787582695
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-6a57aa074f7so3781971a12.0
        for <gfs2@lists.linux.dev>; Mon, 24 Aug 2026 07:44:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787582695; x=1788187495;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3XAYzlXublgAVX17Erk+AQVD3TzEZ8AvJwaJrSwAy3U=;
        b=mLV9+8dukNTxerrtDFaCh007OeMC6PG4fFBNFjfT6zlPd17im+QWoPSEK/wiBzOYdN
         r4EeULYbkou9QQgBYjUT7X3RyeEtG4qm45HazUyG55Ws4rI838J6JU4bpRmjsTldyejR
         cosOJEwU0iHXKFyRcrlizPhzl8V9z5Y7MTn0GUiCJaSKUGn3zAefc8DjHURHDXivTRQH
         N61cVqgRKsS5eAPadiTWmH1lf99aVxWTfZMnm6LH4PN5CA2x6I2ZmhJzv4Y+ETQYhu+o
         oMOa1UHiu/OgxLs9aVotCF6U4TII0Fke6FyH+GbRTBFlbP+7Y5c+ezKnXnOtwBSg8dJJ
         l76g==
X-Forwarded-Encrypted: i=1; AHgh+RpH/Xfll9vNVymUKUpEmBjrIad6/iu/ESiximIfHZFKco4HjX3YRgG9OaGsNBWXv3Oyqdn1@lists.linux.dev
X-Gm-Message-State: AFuF++mUYeoLUvz9eazOy/GQ1ixaVCCkAbwN/yUa330IhE38/H/2joC5
	j0vjpRkoh1OB6EWD/niRENxow53JUFjJ4NtE+UimiOUqAaSlHQHaPAzPES8+kYOo9uPlpQLA6XN
	AEDfVzQJ690NHCZHgASoM9cdLIuxuRYaYeOqTH9gYq5vQM2ZRU5A3oQQ=
X-Gm-Gg: AR+sD11Mf4PpjTBRplHx8d3RpNUMdY/fkfnvz1KVgFLuYmmV9odl4beKBGVyucFrRiz
	sCApQ0wGVVDBL9/dnTb+7QV7jLb8ySY/mx44UIf1mn2Ql5aP13XOUwp6HqnQDG+K0i7HzOcSIR7
	5iGsAMr3+HrD9wxdprBG3TikBiKLfjWrF8XOaPewoJQ5aBOp9jsXpDKgcSl8BCVaZCk8Ug4PY+E
	9hAmczHmku2P/gzV6GpX1PQJeLS9Y25APAe+Jmym2KBcLVftxdHMJu4ZzktNjaYoQQTRA6AuHP4
	+OePvDWLUVrr0+ekhRgkCY79iLCmNcUQK4C99wahif44DiRf2+1l9Nuz5BEeFxUgACDsd9fVg6S
	s8Z8j5NgHgurtp8oa5JBX/Eg4cblNgUy9RpRTbdHIO82O/Q10GLZ3xoDcQGpn
X-Received: by 2002:a05:6402:7cf:b0:6a3:edfe:1d9a with SMTP id 4fb4d7f45d1cf-6a41123c23fmr23050718a12.2.1787582695441;
        Mon, 24 Aug 2026 07:44:55 -0700 (PDT)
X-Received: by 2002:a05:6402:7cf:b0:6a3:edfe:1d9a with SMTP id 4fb4d7f45d1cf-6a41123c23fmr23050696a12.2.1787582695044;
        Mon, 24 Aug 2026 07:44:55 -0700 (PDT)
Received: from [192.168.1.167] (cpc76484-cwma10-2-0-cust967.7-3.cable.virginm.net. [82.31.203.200])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a59e012f84sm13240527a12.8.2026.08.24.07.44.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2026 07:44:54 -0700 (PDT)
Message-ID: <9801cd18-e25c-406b-af05-ab0b21184b67@redhat.com>
Date: Mon, 24 Aug 2026 15:44:53 +0100
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gfs2: Fix use-after-free in gfs2_remove_from_journal()
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Hongling Zeng <zenghongling@kylinos.cn>, swhiteho@redhat.com,
 gregkh@linuxfoundation.org, gfs2@lists.linux.dev,
 linux-kernel@vger.kernel.org, zhongling0719@126.com
References: <20260617090143.735219-1-zenghongling@kylinos.cn>
 <d8d1d7fc-4028-4913-8025-cb4c39ab437c@redhat.com>
 <CAHc6FU6b00qRUXzTR27TL0u4Nf39zzvrCUjjFAa7ttwWYtRBmQ@mail.gmail.com>
From: Andrew Price <anprice@redhat.com>
In-Reply-To: <CAHc6FU6b00qRUXzTR27TL0u4Nf39zzvrCUjjFAa7ttwWYtRBmQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: z5-DbXZj-z5xpNrLqG6qaxRwZnuWsaRQ3ERUaohKSDM_1787582695
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 24/08/2026 15:20, Andreas Gruenbacher wrote:
> Andy,
> 
> On Wed, Jun 17, 2026 at 12:52 PM Andrew Price <anprice@redhat.com> wrote:
>> On 17/06/2026 10:01, Hongling Zeng wrote:
>>> The function calls brelse(bh) but then continues to access
>>> the buffer head through bh->b_private, clear_buffer_dirty(),
>>> and clear_buffer_uptodate().
>>>
>>> After brelse() decreases the reference count, the buffer head
>>> may be freed, making the subsequent accesses use-after-free.
>>
>> When buffers are pinned their refcount is incremented and the brelse() here is only called for pinned buffers so I'm not convinced that there's a bug.
> 
> Not sure what you mean by that. The patch still only calls brelse() on
> buffers it unpins, it only changes when it does it.

The context is not fresh in my mind but I suppose was trying to locate the UAF that the patch reportedly fixed and I couldn't find one.

>> Callers of gfs2_remove_from_journal() also use the bh afterwards so if there was a use-after-free this patch wouldn't fix it.
> 
> Do we have any callers that do that when they don't clearly still hold
> a reference? I don't think so.
> 
> In any case, if there are any callers that don't certainly hold an
> extra reference, we need to be careful in gfs2_remove_from_journal().
> This patch achieves that, so I'm inclined to merge it.
No objections here. I'd like the commit description to be clear about whether it's fixing a bug or just cleaning up a static analysis warning.

Andy

