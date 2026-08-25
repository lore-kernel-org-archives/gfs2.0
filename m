Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790C92F2914
	for <gfs2@lists.linux.dev>; Tue, 25 Aug 2026 01:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787621765; cv=none; b=QLy00/JEaOXL4vvnm27lRMIQB0UGYbsn3vshRfhSONnRsYwWzDIUAGBEj0O+wUSV+I3joD2oZavApU6IVNxlfuZj34y9Zjx5wpE9T5hS/3oSeKoKajUsbVqxZzdEek3IqlMZK9vLulw2f+rboXjieHvNCgAixy/RwuEjTbZg8as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787621765; c=relaxed/simple;
	bh=/C1OwKjY/SeOLQW1AWdn5XbmvXmSxPuqFH9xJnFIUdg=;
	h=Message-ID:Date:From:MIME-Version:To:CC:Subject:References:
	 In-Reply-To:Content-Type; b=GnsMlSRj7k6xHaKMp5Mqo5vd18TT1pQtT6yW7Iq9TsuIYo5mMfhHTJSyhmlX8QnFVTCFQl6evC8Z5t8I7Wbrck0o3KJ7CkGxJuemI1KpT45bydQknnFewAhwy0x+RWlwaSPk72C4UBQPbZuE9b5uroezs50Iwp0yW2rTUG8c+wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=eeBw9dgB; arc=none smtp.client-ip=117.135.210.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="eeBw9dgB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:From:MIME-Version:To:Subject:
	Content-Type; bh=dlJF9b3kub7tqUdVEVlByaJ8q51DYAdubTPXgQQccvk=;
	b=eeBw9dgBU2/CK2jUwGalJYvmvj1pHPUXslabD9BHcZIapXPYTJz+tnNhT0k+Kh
	WkkHwaE6Dm/2VAqWqaDqMeDaEmMbc/RJUaHp0KypjoW8BEwIsLnLD6vqEuvwFt3/
	kY8cdT03Xc2NME7glje751l1sgOjycKRJaMPdEDrQwHko=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wDX_4dq8YxqhbSAGQ--.31165S2;
	Tue, 25 Aug 2026 09:35:39 +0800 (CST)
Message-ID: <6A8CF151.8040704@126.com>
Date: Tue, 25 Aug 2026 09:35:13 +0800
From: Hongling Zeng <zhongling0719@126.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
To: Andreas Gruenbacher <agruenba@redhat.com>
CC: Andrew Price <anprice@redhat.com>, 
 Hongling Zeng <zenghongling@kylinos.cn>,
 swhiteho@redhat.com, gregkh@linuxfoundation.org, gfs2@lists.linux.dev, 
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gfs2: Fix use-after-free in gfs2_remove_from_journal()
References: <20260617090143.735219-1-zenghongling@kylinos.cn> <d8d1d7fc-4028-4913-8025-cb4c39ab437c@redhat.com> <6A334EF9.3080504@126.com> <CAHc6FU4GD=QjKr5nBsxL2pO6Krj-WOtD_dND=hpzHfYwcuZ8Jw@mail.gmail.com>
In-Reply-To: <CAHc6FU4GD=QjKr5nBsxL2pO6Krj-WOtD_dND=hpzHfYwcuZ8Jw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDX_4dq8YxqhbSAGQ--.31165S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGF4rXrWrXF4fAw43Kr48WFg_yoW5AF47pw
	4rKa1jyF4kJr1kJr1Ig34rX3s3tw43tFy5Wrs5Gw17Z3sIy3W2vF17tr4DuFWkurs3Gr10
	qr4UGwsI9r90yaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j52-nUUUUU=
X-CM-SenderInfo: x2kr0wpolqwiqxrzqiyswou0bp/xtbBoQtUJWqM8WtJhwAA3p


在 2026年08月24日 23:35, Andreas Gruenbacher 写道:
> Hi Hongling Zeng,
>
> On Thu, Jun 18, 2026 at 3:58 AM Hongling Zeng <zhongling0719@126.com> wrote:
>> 在 2026年06月17日 18:51, Andrew Price 写道:
>>> On 17/06/2026 10:01, Hongling Zeng wrote:
>>>> The function calls brelse(bh) but then continues to access
>>>> the buffer head through bh->b_private, clear_buffer_dirty(),
>>>> and clear_buffer_uptodate().
>>>>
>>>> After brelse() decreases the reference count, the buffer head
>>>> may be freed, making the subsequent accesses use-after-free.
>>> When buffers are pinned their refcount is incremented and the brelse() here is only called for pinned buffers so I'm not convinced that there's a bug.
>>>
>>> Callers of gfs2_remove_from_journal() also use the bh afterwards so if there was a use-after-free this patch wouldn't fix it.
>>>
>>> Did you see a use-after-free in testing?
>>>
>>> Andy
>>>
>>    Thanks for your detailed explanation!  this is not a real bug in
>> practice, the reference counting protects against real UAF.
>>    I'm seeing smatch warnings :
>>
>>         fs/gfs2/log.c:1044 error: dereferencing freed memory 'bh'
>>         fs/gfs2/log.c:1051 warn: passing freed memory 'bh'
> a "make C=2 CHECK="smatch" fs/gfs2/" doesn't result in those messages.
> How can I reproduce?
>
> Thanks,
> Andreas
>
   Hi Andreas and Andy,

   Thank you for the review. The smatch warnings were reported by the Intel
   LKP test robot:

     https://lore.kernel.org/all/202607110908.l7Owhul4-lkp@intel.com/

   I will update the patch with a better commit message based on your 
feedback,
   clarifying that this is a defensive improvement to address the pattern
   flagged by static analysis, rather than fixing a real-world 
use-after-free
   bug.

   I'll send a v2 version .

>>     And there are potential concerns:
>>     1. Future maintainers might not understand the ref counting semantics
>>     2. The code pattern (brelse then access) is error-prone
>>     3. smatch warnings clutter output for real issues
>>>> Fix by moving the brelse(bh) call to the end of the function,
>>>> after all accesses to bh have been completed.
>>>>
>>>> Fixes: e93b100931a4 ("GFS2: Fix slab memory leak in gfs2_bufdata")
>>>> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
>>>> ---
>>>>    fs/gfs2/log.c | 3 ++-
>>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/fs/gfs2/log.c b/fs/gfs2/log.c
>>>> index 78bba8cc10b8..a92c84146de9 100644
>>>> --- a/fs/gfs2/log.c
>>>> +++ b/fs/gfs2/log.c
>>>> @@ -1038,7 +1038,6 @@ void gfs2_remove_from_journal(struct buffer_head *bh, int meta)
>>>>                       set_bit(TR_TOUCHED, &tr->tr_flags);
>>>>               }
>>>>               was_pinned = 1;
>>>> -            brelse(bh);
>>>>       }
>>>>       if (bd) {
>>>>               if (bd->bd_tr) {
>>>> @@ -1056,6 +1055,8 @@ void gfs2_remove_from_journal(struct buffer_head *bh, int meta)
>>>>       }
>>>>       clear_buffer_dirty(bh);
>>>>       clear_buffer_uptodate(bh);
>>>> +    if (was_pinned)
>>>> +            brelse(bh);
>>>>    }
>>>>
>>>>    /**

