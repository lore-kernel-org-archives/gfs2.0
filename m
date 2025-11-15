Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5CAFBF6
	for <gfs2@lists.linux.dev>; Sat, 15 Nov 2025 16:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763223151; cv=none; b=YNzq8fst5htfGcGEyt94+8BvMcbVV5O9MGafkxHVJnX0Y3l9hS0qbxPoeBmP/JjQJFamfNQJea4OkM2SPW126m3LobFb3zug264EhWp64SUlclNoX6DjLULMad5TUNeVi0/SfnDmJEpDBVShDIeoGDv0eftM6shpZffeF9pRDH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763223151; c=relaxed/simple;
	bh=ZnpkSR77rpxwOiypBKfNZpIP5HVzuOahGXkvMl2mC78=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hro+4N9idwlTYJhcLK/h2dVnjQikn7H5IrGQpKo6nw847iaEbasU5GSt4K0t6lb0xT8nfeYH6+cJI/Q/QYGcpNByXQsmFr9CACMQ0ev5kXXTSpsz4impfrzDK3sR1c4BmyOV637D+PXpaYpdyMPsbiOTj+ENjms3D6YmQV9umBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lWyVPdMs; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lWyVPdMs"
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-9352cbe2e14so743399241.3
        for <gfs2@lists.linux.dev>; Sat, 15 Nov 2025 08:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763223148; x=1763827948; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y4ZZROaO2AtV1FcryfogKXlOY1JjkeOo1Pb1PB2vqI8=;
        b=lWyVPdMsLeihx81vxmZW3kgc3iTB2Sb4/zFgC28hE6lPEpMjwXZ5n/p4iSplaNO3vy
         fHBEErXym4/RNvL43sx8Is1IKGxLxkHMzz40hghooxcj9U7lICyeQJ/b50SduH0utQit
         C8zLK9YS4NG4f7JNhF7mHO4kdidrDATBXEtg4o/kif1/+uUroJzwdOxYJ4OgN3mnXv2Y
         /NPuOXY1g2UiJKfnCULPdsVy1UEJ9BE1iB/qu7UZvcr7gafjr8sTNJQaPQsspxBl/z1O
         PRT0LnhzWF3Bv0iDJb91MZ4YlJCZXX/OOFbrizb69Mw4baSBh/erj+U8nlmFzHbwHEeA
         zfKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763223148; x=1763827948;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y4ZZROaO2AtV1FcryfogKXlOY1JjkeOo1Pb1PB2vqI8=;
        b=aYSbDQh7c1jK+NicpmUUD4GFxQVhj6X8KfamK8805N0cwOnNbnndyAoSRJCF1ZVsyW
         QVmA4LvLl7FYTF/XUzjtnFnhcQlKEKcjEuDiyJR4URXU1FxI94f5DIX42ydBAAxWXw+5
         Wd4ZeCHoSRsCYGTy6Cm5T1YG8ggf8jGLYjuDdVUKZuRuLZ23iRKhQBSKGd7OIeRb6Ml8
         kmnmvOv2mPB1sG41bGiU0Dx5pzFoIxGgvtoezSd4DHjSM4w/3x3yO4mEcKuvK1hlbROM
         YTjn8fpAfzkEEU8ka3C4/SPd2YIGdn/YH2yR1jFz7MujEAUNOwK6Bw331GBQpTgChd+W
         uBAg==
X-Gm-Message-State: AOJu0YyRi5VLKtITk9Pl24a/iZc2aJWpXWjEmsPmTDPdp4fmw+4XWT74
	L+iilPYoXfNbOpksfvrAZ0s7AlHgE6DPZD96OhCAjwrVMGrRRX3eTrH8
X-Gm-Gg: ASbGnct4BLZ4rS50dwZNhCNIa/6Utfqo/N5+4+I1WYfeSpAlsKnpPu4gzZmRnv8Bdy0
	BCHs7xpqbAgqKyFlqdVCXPspNmMGFCh6av1XZmtm84oz1F/ljVkJg7iM3/wOspU6zTwmuW5dFrF
	8FQL3s8jz0NxZBxXc3Ro2DVBtq7o43ccrsv+wnlbDvkmAT4mIyvwl51aMlgp9hZbz5ve0c0JvuT
	8jiOGidCCI+7zDvTZOSRjzdKWN17k9CtHwhJeOvkii55HZqorkxsNUkxYzMDde6KHspm9yjcNsf
	Ip13LES+CY02o0TTbe5J7hZsXn4JNd59XZ0EqCm7MmtU/WRcSt7g3gy4YxuE/+5XDC9+miEm/y9
	oKEPShkG5+TgNdcuWaOWjpqwGfyqhA1W39/6PWq42hB99ID11ZxqpCNGXkY+O7mPwJ+V4VValWd
	mLS7HFq3bekphRQqwFVirxAdG/Jeb7isMV23xzUg==
X-Google-Smtp-Source: AGHT+IF6afF+Sk5OqXufe5DnIInP/wLQgPhexqZnCnJvERed0HkkNXpn1BqSwn2dy7VPQkM2oelwCw==
X-Received: by 2002:a05:6102:b0f:b0:5db:ecdd:1816 with SMTP id ada2fe7eead31-5dfc564a0b0mr2274620137.24.1763223148354;
        Sat, 15 Nov 2025 08:12:28 -0800 (PST)
Received: from [192.168.1.145] ([104.203.11.126])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5dfb726ff96sm2758596137.14.2025.11.15.08.12.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Nov 2025 08:12:27 -0800 (PST)
Message-ID: <48a69d90-68f7-4ec7-97c4-89ba9896b663@gmail.com>
Date: Sat, 15 Nov 2025 11:12:25 -0500
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gfs2: flush withdraw work before freeing gfs2_sbd
To: Nirbhay Sharma <nirbhay.lkd@gmail.com>,
 Andreas Gruenbacher <agruenba@redhat.com>
Cc: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org,
 syzbot+19e0be39cc25dfcb0858@syzkaller.appspotmail.com,
 skhan@linuxfoundation.org, linux-kernel-mentees@lists.linuxfoundation.org
References: <68f6a48f.050a0220.91a22.0451.GAE@google.com>
 <20251024144332.33773-2-nirbhay.lkd@gmail.com>
 <8f270474-7ced-4668-97da-f3d7709a82e7@gmail.com>
Content-Language: en-US
From: David Hunter <david.hunter.linux@gmail.com>
In-Reply-To: <8f270474-7ced-4668-97da-f3d7709a82e7@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/13/25 15:24, Nirbhay Sharma wrote:
> Hi Andreas,
> 
> I hope this email finds you well.
> 
> I'm writing to follow up on the GFS2 patch I submitted regarding the
> ODEBUG warning in free_sbd(). The patch addressed the syzbot report
> where sd_withdraw_work was being freed while still active.
> 
> I wanted to check if you've had a chance to review the patch, or if
> there's any feedback or additional information I can provide to help
> with the review process.
> 
> I understand maintainers are busy, and I'm happy to make any necessary
> revisions or provide further clarification on the testing that was
> performed.
> 
> Best regards,
> Nirbhay Sharma
> 
> 


Hey Nirbay,

The reply that you write should be below the message you are talking
about. If you put it above, it is called "top-posting", and the kernel
community does not like top-posting.

For long email chains, it becomes difficult to keep track of the
conversations.

What I am doing now is called in-line posting. I am responding below
your message, but there are still other messages below mine.


> On 10/24/25 8:13 PM, Nirbhay Sharma wrote:
>> Syzbot reported an ODEBUG warning where free_sbd() was freeing memory
>> containing an active work_struct (sd_withdraw_work):
>>
>>   ODEBUG: free active (active state 0) object: ffff888026c285a0
>>   object type: work_struct hint: gfs2_withdraw_func+0x0/0x430
>>   WARNING: CPU: 0 PID: 6010 at lib/debugobjects.c:545
>>   Call Trace:
>>    free_sbd+0x1e4/0x270 fs/gfs2/ops_fstype.c:1308
>>
>> The issue occurs when gfs2_fill_super() fails after initializing
>> sd_withdraw_work at line 1218. Some error paths (fail_lm, fail_debug,
>> etc.) skip the existing flush_work() at the fail_inodes label and jump
>> directly to fail_free, which calls free_sbd() without flushing the
>> potentially pending work.
>>
>> free_sbd() is also called from init_sbd()'s error path before
>> sd_withdraw_work is initialized. Since the structure is allocated with
>> kzalloc(), work.func is NULL in this case.
>>
>> Fix by adding a guarded flush_work() to free_sbd(). Check work.func
>> before flushing to handle both cases: when called after INIT_WORK()
>> (work must be flushed), and when called before INIT_WORK() (work.func
>> is NULL, skip flushing). This avoids the WARN_ON(!work->func) in
>> __flush_work().
>>
>> Note: gfs2_put_super() already calls flush_work() before free_sbd()
>> (line 606), so the flush in free_sbd() will be redundant but harmless
>> for the normal unmount path.
>>
>> Reported-by: syzbot+19e0be39cc25dfcb0858@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=19e0be39cc25dfcb0858
>> Fixes: 8fdd8a28fe5c ("gfs2: Asynchronous withdraw")
>> Signed-off-by: Nirbhay Sharma <nirbhay.lkd@gmail.com>
>> ---
>> Testing performed:
>> - Reproduced original bug with syzbot C reproducer
>> - Verified fix prevents ODEBUG warnings in all error paths
>> - Tested early mount failures (unformatted devices)
>> - Tested all gfs2_fill_super error paths (4 scenarios)
>> - Parallel mount stress test (3 concurrent operations)
>> - Memory leak test (50 mount/unmount cycles, <4MB variance)
>> - Race condition testing passed
>> - Validated with syzbot on linux-next (Oct 22)
>> - All tests completed with zero ODEBUG warnings
>>
>>  fs/gfs2/ops_fstype.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
>> index 08502d967e71..6cea03410e57 100644
>> --- a/fs/gfs2/ops_fstype.c
>> +++ b/fs/gfs2/ops_fstype.c
>> @@ -67,6 +67,14 @@ void free_sbd(struct gfs2_sbd *sdp)
>>  {
>>  	struct super_block *sb = sdp->sd_vfs;
>>  
>> +	/*
>> +	 * Only flush withdraw work if initialized. Work is initialized in
>> +	 * gfs2_fill_super() at line 1218, after init_sbd() succeeds.
>> +	 * Checking func avoids WARN_ON in __flush_work() for early failures.
>> +	 */
>> +	if (sdp->sd_withdraw_work.func)
>> +		flush_work(&sdp->sd_withdraw_work);
>> +
>>  	free_percpu(sdp->sd_lkstats);
>>  	sb->s_fs_info = NULL;
>>  	kfree(sdp);
If I respond down here, it is bottom-posting. Both inline and bottom
posting are encouraged. Top posting is to be avoided.

Thanks,
David Hunter

