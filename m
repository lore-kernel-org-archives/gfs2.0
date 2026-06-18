Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80952E6CC0
	for <gfs2@lists.linux.dev>; Thu, 18 Jun 2026 01:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781747620; cv=none; b=bM+KHxDqSVQ5w5Q0YsNYJJVKhkZ43jTheY5M25MzbAaF+qm1OXFIDajmH8kab9BnhCIcexqyoXh0YSod/GJhHfq3o3r67bH1h/xAJA6fvM4OVjYVT3Ev5vsB/QJu44i6ZQnM2Btwn9BHLiCi3PS+nH7CmrfMA9MztUVBlqDDdGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781747620; c=relaxed/simple;
	bh=enVqJFPXNJ/76fVdTLAY6xiZbj7ChZ80b6eXSD5+CDY=;
	h=Message-ID:Date:From:MIME-Version:To:CC:Subject:References:
	 In-Reply-To:Content-Type; b=BKfF8ZUkpRVtPd/eMKAh09XEMc+v+8haUNSbfjX5t7va4nTa8JUh7VSQcvkGjVuMEXUfpUJWig2gk2ex16/zN3U86o9bSY8q799apONFVKAmBvIxGqQJ7sBsrHek67TyLrp9Qnbuc8rPKfd5icONR8fvUW2S/uGQ0WSmpDsSpCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=Rwm6rRo/; arc=none smtp.client-ip=220.197.31.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="Rwm6rRo/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:From:MIME-Version:To:Subject:
	Content-Type; bh=qOx0fHWPrJexnY5a+ZrlNV8t4JthNSRx/Eh0FPCjmIg=;
	b=Rwm6rRo/oD7lqqQPT/2oN4IfLT0v0Om6CZQ8fRwuOObVBIQBbTVfxNbedJw8tr
	KHtSfxVKzBse9ky1frmNp8yi21aZ0GYUnYGwhTqc7ZWi9q62Gd/dAsap8eLCN6Vw
	LMXP2eG+Um9HVP8YrEbf8ABEUVGvgMZKNR9nyccSE3W38=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wDHb3T7TjNq1asrBw--.18705S2;
	Thu, 18 Jun 2026 09:50:52 +0800 (CST)
Message-ID: <6A334EF9.3080504@126.com>
Date: Thu, 18 Jun 2026 09:50:49 +0800
From: Hongling Zeng <zhongling0719@126.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
To: Andrew Price <anprice@redhat.com>, 
 Hongling Zeng <zenghongling@kylinos.cn>,
 agruenba@redhat.com, swhiteho@redhat.com, gregkh@linuxfoundation.org
CC: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gfs2: Fix use-after-free in gfs2_remove_from_journal()
References: <20260617090143.735219-1-zenghongling@kylinos.cn> <d8d1d7fc-4028-4913-8025-cb4c39ab437c@redhat.com>
In-Reply-To: <d8d1d7fc-4028-4913-8025-cb4c39ab437c@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHb3T7TjNq1asrBw--.18705S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uF4kKFy5JrWDZr48JF13Arb_yoW8uF48pF
	4rKa1IkF4kJr1DJr1IgFyrX3sF9wsayFWrC39YkwnrZ39xZ3sFvFyaqr4kWFWv9rs7Gr1F
	qF4UKwsI9wn0y3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j52-nUUUUU=
X-CM-SenderInfo: x2kr0wpolqwiqxrzqiyswou0bp/xtbBoBw6C2ozTvyoEQAA3f


在 2026年06月17日 18:51, Andrew Price 写道:
> On 17/06/2026 10:01, Hongling Zeng wrote:
>> The function calls brelse(bh) but then continues to access
>> the buffer head through bh->b_private, clear_buffer_dirty(),
>> and clear_buffer_uptodate().
>>
>> After brelse() decreases the reference count, the buffer head
>> may be freed, making the subsequent accesses use-after-free.
> When buffers are pinned their refcount is incremented and the brelse() here is only called for pinned buffers so I'm not convinced that there's a bug.
>
> Callers of gfs2_remove_from_journal() also use the bh afterwards so if there was a use-after-free this patch wouldn't fix it.
>
> Did you see a use-after-free in testing?
>
> Andy
>
  Thanks for your detailed explanation!  this is not a real bug in 
practice, the reference counting protects against real UAF.
  I'm seeing smatch warnings :

       fs/gfs2/log.c:1044 error: dereferencing freed memory 'bh'
       fs/gfs2/log.c:1051 warn: passing freed memory 'bh'

   And there are potential concerns:
   1. Future maintainers might not understand the ref counting semantics
   2. The code pattern (brelse then access) is error-prone
   3. smatch warnings clutter output for real issues
>> Fix by moving the brelse(bh) call to the end of the function,
>> after all accesses to bh have been completed.
>>
>> Fixes: e93b100931a4 ("GFS2: Fix slab memory leak in gfs2_bufdata")
>> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
>> ---
>>   fs/gfs2/log.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/gfs2/log.c b/fs/gfs2/log.c
>> index 78bba8cc10b8..a92c84146de9 100644
>> --- a/fs/gfs2/log.c
>> +++ b/fs/gfs2/log.c
>> @@ -1038,7 +1038,6 @@ void gfs2_remove_from_journal(struct buffer_head *bh, int meta)
>>   			set_bit(TR_TOUCHED, &tr->tr_flags);
>>   		}
>>   		was_pinned = 1;
>> -		brelse(bh);
>>   	}
>>   	if (bd) {
>>   		if (bd->bd_tr) {
>> @@ -1056,6 +1055,8 @@ void gfs2_remove_from_journal(struct buffer_head *bh, int meta)
>>   	}
>>   	clear_buffer_dirty(bh);
>>   	clear_buffer_uptodate(bh);
>> +	if (was_pinned)
>> +		brelse(bh);
>>   }
>>   
>>   /**

