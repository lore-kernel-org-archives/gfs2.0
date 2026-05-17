Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4522DF153
	for <gfs2@lists.linux.dev>; Sun, 17 May 2026 01:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778981420; cv=none; b=HUfj+owAMEaO7XMJFKpkaVTbdA521E7Mrx6FOzty5Qox2nFdAfQNNOBN05LAlJoYQLe1LsTpomNGuiVTXLUM5UwU9tS8iiJ+sHJ7OvE9ky0PTWCkhZ7LnU9GkVasqSY8Z99B5mTZ1r6oWt9IyUDA5GwCCdr2OinN7Eqx/VHqo8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778981420; c=relaxed/simple;
	bh=pY7jT+FHIl6TGBdXOf0fhE0guUQnRzUe5EXtkHTkc78=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AXBPQ1ArgwkZ1f4YRJwxWfpi2sgkIl4OgasVD4eZX5FlOw2l4x6Omxl28dCOcN2La0Y8A7PpCpuE4agxitJ+2ymYrEXqJJXUFERHZJCkwISvp5Rv8DB2y0ukja9qOeDml4erJ9ixpoDdyIkjRNVQcyznpSGQZGFMRaXjvbaQt1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=imVgm904; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="imVgm904"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1778981410; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=rY2fKZC15AlNuDObsio3jOgX4I+lwxicQAmHr7YE/Jw=;
	b=imVgm9044g1eN0h3q/FZd8T0Kv5aLylBsLnLd/qsU+XSEX0qQCrzhPCsoypnR4ns0ICNLEEZm8xiEa+9EiMsBZcSQiuB033kh/VRyIGdIVOMEh6fqUYdimrKuLFNIBRLCrBJPwoOwmCVuf5QEdFJT3uPcx9jFTt9bMS6Z2u370c=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0X30fzWu_1778981408;
Received: from 30.41.171.241(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0X30fzWu_1778981408 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 17 May 2026 09:30:09 +0800
Message-ID: <a32e5105-a573-4918-9fe9-166dad67df5e@linux.alibaba.com>
Date: Sun, 17 May 2026 09:30:06 +0800
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dlm: check negative length in dlm_search_rsb_tree
To: Alexander Aring <aahringo@redhat.com>
Cc: David Teigland <teigland@redhat.com>, gfs2@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260515073933.1978699-1-joseph.qi@linux.alibaba.com>
 <CAK-6q+iOFTdw0caweFQ7tw_amBHzW5xXM+H0_FicBAkHVz5OKA@mail.gmail.com>
From: Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <CAK-6q+iOFTdw0caweFQ7tw_amBHzW5xXM+H0_FicBAkHVz5OKA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 5/15/26 9:30 PM, Alexander Aring wrote:
> Hi,
> 
> On Fri, May 15, 2026 at 3:39 AM Joseph Qi <joseph.qi@linux.alibaba.com> wrote:
>>
>> commit 080e5563f878 only checks for len > DLM_RESNAME_MAXLEN, which does
>> not catch negative values. While the input 'len' can be negative and a
>> negative int passed to memcpy() is implicitly converted to a large
>> size_t, causing a stack buffer overflow on the key[] array.
>>
>> Fix this by also rejecting len <= 0.
> 
> or change the parameter to unsigned?
> 

Yes, it would be fine. I'll work on it and send v2 later.

Thanks,
Joseph

