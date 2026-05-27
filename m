Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FD323EAB2
	for <gfs2@lists.linux.dev>; Wed, 27 May 2026 01:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779843711; cv=none; b=IZQ3ErmMs4a2Xw3bEQ45dw8PfrL8jL2JEwG1y3/ijag+6uTj7w2pFBVdV6haug8ML00lM9XcwTLyJ/u2QFnxY1j0Qs+mXF8grxC+Yfe12zwNWjBkEJ5hcqeHrIZa8YdshoofDxpmgJI2+J9RLtLGwMM/Fb868IVRP7KsxM+GhRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779843711; c=relaxed/simple;
	bh=AXNgKE7IMBMBPp2uUdqvy6O0+oK8n/o6K4CX6jVcZRA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qmjcIS8c7iPZFhdg19hBN5G+bWs+tF936XsVfUKqqVZSC1JD0RPEOoKgcjb0yth3ezMBlpFLgDWM4KAzj2pGMfMhJsF+GYn6DFetMzaeaiRXhkoSV/FVMd+SGIBG7qji0bFZOcY4/D2hR/CDqNUJW6lLrC2X7lzMJ0FjwlJsAks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=O8r8xx6Z; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="O8r8xx6Z"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779843701; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=8UPnQmPmHOKtatf9aRk8ua5PuPET0fpGTLCpiKEFZ/E=;
	b=O8r8xx6ZAQP/cG183vJitwt62ps4c+2NdkeULTBHigHuR+QfDMsC4IiUROUvLg93Z/Fktji9KwpYZDDnLdwUxp2907ycx+g9Dw/aq1zY0EdJPvCYSVXtDPDSz9J6wuDgm8XtbvUFCzI06/qL11GPqzTlQg0Q8LpoxzvkisgNCKA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R691e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0X3hSoIm_1779843699;
Received: from 30.221.145.39(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0X3hSoIm_1779843699 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 27 May 2026 09:01:40 +0800
Message-ID: <464dd360-f4b9-4c47-90ac-2d1f558814a9@linux.alibaba.com>
Date: Wed, 27 May 2026 09:01:38 +0800
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dlm: fix buffer overflow from negative len in
 dlm_search_rsb_tree
To: Alexander Aring <aahringo@redhat.com>, cve@kernel.org
Cc: David Teigland <teigland@redhat.com>, gfs2@lists.linux.dev,
 linux-kernel@vger.kernel.org, gregkh@kernel.org
References: <20260517020315.1064253-1-joseph.qi@linux.alibaba.com>
 <CAK-6q+jvaQx6y_tOzks3utBWaTRjvVnDWrznBYRfWjTQBcefBA@mail.gmail.com>
 <CAK-6q+iC3AgX7r2fZkvDJHibS0oqTwVCF4ZgV-1OFkV0d=R2Vw@mail.gmail.com>
 <CAK-6q+hPM=+fXkPSbr60Y6S1O_RfYGBUeL3mfVu0H1ymZ0gp6w@mail.gmail.com>
From: Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <CAK-6q+hPM=+fXkPSbr60Y6S1O_RfYGBUeL3mfVu0H1ymZ0gp6w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 5/26/26 9:58 PM, Alexander Aring wrote:
> Hi,
> 
> On Mon, May 25, 2026 at 1:39 PM Alexander Aring <aahringo@redhat.com> wrote:
>>
>> Hi,
>>
>> On Mon, May 25, 2026 at 10:27 AM Alexander Aring <aahringo@redhat.com> wrote:
>>>
>>> Hi,
>>>
>>> On Sat, May 16, 2026 at 10:03 PM Joseph Qi <joseph.qi@linux.alibaba.com> wrote:
>>>>
>>>> commit 080e5563f878 only checks for len > DLM_RESNAME_MAXLEN, which does
>>>
>>> check with checkpath, it reports an error regarding how this commit
>>> reference is done.
>>>
>>
>> This also addresses CVE-2026-43125 [0].
>>
>> - Alex
>>
>> [0] https://lore.kernel.org/linux-cve-announce/2026050619-CVE-2026-43125-c9f9@gregkh/
> 
> cc the right folks cve@kernel.org as described in the kernel documentation.
> 
> There is another patch required for CVE-2026-43125 [0].
> 
> Joseph I think for v3 you should cc also cve@kernel.org and mention
> this in your commit msg.
> 

This is indeed found when I backport this CVE into our tree.
But I think it is a different case so I just send to upstream first.

Thanks,
Joseph

