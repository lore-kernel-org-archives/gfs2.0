Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C10158851
	for <gfs2@lists.linux.dev>; Thu, 26 Sep 2024 12:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727353114; cv=none; b=f+EWACNNpy1zSh/a+bnl7jjX8X/KHGbwjDM/HewhYgGFt3jZ9kSoik+hiVXPY2UZLk3sG0DTz1CdU8S5IYCXb+FwPoUvHzl7zUUoeY3/IHnBAiOw0Z1NoaCKKl318z7xENBeziF0tR6PvkEzmnC8HwDEL6yhJlccP2f3CRLc8Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727353114; c=relaxed/simple;
	bh=35IAnmg+Ou2ujyv8rNuH9+NG7P8dyPMLTV6ua36IzZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=Ett5PFnGzKlKS/KzsLODeInA6NALhlI7zghKAnovlHgBB/RPqRKNCJqjIFhmL9ECJuhTHrpjKtq5tTjd1HaXVeluv88TDNQoS5E+VZhhnmYaVUIbtqZNg+IYmtU5df7M5JmGCNdBJD75Ok0082FVMjb0/z9LtO8xl/eVv1RoDy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PjEnLDSj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PjEnLDSj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727353112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9j5ulUBRF3RNc1/1PEm2eA9tpmRkg67InFO3B+cjLCg=;
	b=PjEnLDSjSowX/kKuN8w3x1LU5HFe/nCHbzw5Qy2zlZQ0XskCaBcsG9VeT+FAhFxIXAGQc6
	D5W+H/PAZ81xwWkul3/Y++Sm7cDAGmfUs0tT/tk/aw4Z6yn4KCaaONNZY45A8fEhPR3v3c
	UMEjTrpTtYhAdI46gGNrSjhSgRiTjig=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-0uqwnRPDNEWziZWbAosgMA-1; Thu, 26 Sep 2024 08:18:30 -0400
X-MC-Unique: 0uqwnRPDNEWziZWbAosgMA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42cb5f6708aso5095435e9.2
        for <gfs2@lists.linux.dev>; Thu, 26 Sep 2024 05:18:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727353109; x=1727957909;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9j5ulUBRF3RNc1/1PEm2eA9tpmRkg67InFO3B+cjLCg=;
        b=MUtm0dNi+zlkxMm7Omp2hmPHN6nlJxGhK/kup2q+pAJWPrlLyx99mtCkSI0QPyyZmN
         cd1zgQODGxIadcqUXy5wfyJtGgSpeJLWDPYBMk6yr/VLdpS1NQK/BkwTkhU66bR0iRDl
         OT2HbdS+Z81YmU0DvCWbmNwjMHtK9WREMwW2YH3KpAURnI3F2jTTNVhUKPIlLTJ/bHoW
         hX2drMNgWilbOlAOAFvj+JZI7BucF4opfZjUgmALOwJn717M6d7mJRKxSED4YQ1jWdtJ
         6OZebKJf50mRsfnRraYdW3xntwipFEE7ac92ck3sa4LyXObV4UNhbJyHdM0IUYNSIY/H
         MGAw==
X-Gm-Message-State: AOJu0YzC0YRwVFo/3Lg+BmN+OXn5SsEd/taOvii+Z4Pq1i0ZqPPj12FO
	7oC3yVL9hQPkqRjaLLGHXJ9fL4Lxyj+Gz5vkCpwln0TWZB04la6jgcJDEjRE5fOQLsLLFYZlDxQ
	lH4BHbWO45xPjubEEgNc2ghhy7hPrTF1awTsCQq9u6hb2aoid28M=
X-Received: by 2002:a7b:c5d9:0:b0:426:5440:8541 with SMTP id 5b1f17b1804b1-42e96ab6613mr37358205e9.27.1727353109625;
        Thu, 26 Sep 2024 05:18:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbT+ecKbMK2RXsDY1KYO21bYyPZ/117U0dWaOhPELAXbC9v6rc2SuiDVoP9lUY23A7Qw1Aug==
X-Received: by 2002:a7b:c5d9:0:b0:426:5440:8541 with SMTP id 5b1f17b1804b1-42e96ab6613mr37358015e9.27.1727353109261;
        Thu, 26 Sep 2024 05:18:29 -0700 (PDT)
Received: from [192.168.1.167] (cpc76484-cwma10-2-0-cust967.7-3.cable.virginm.net. [82.31.203.200])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e969e18f7sm45674195e9.5.2024.09.26.05.18.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2024 05:18:28 -0700 (PDT)
Message-ID: <524af8c6-62cd-4ae0-af8d-3d02102f9045@redhat.com>
Date: Thu, 26 Sep 2024 13:18:27 +0100
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/16] gfs2: unlinked inodes
To: Andreas Gruenbacher <agruenba@redhat.com>
References: <20240925220331.417856-1-agruenba@redhat.com>
Cc: gfs2@lists.linux.dev
From: Andrew Price <anprice@redhat.com>
In-Reply-To: <20240925220331.417856-1-agruenba@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25/09/2024 23:03, Andreas Gruenbacher wrote:
> We have recently run into cases where unlinked inodes end up
> accumulating.  This should only happen as a result of cluster node
> failures, and those unlinked inodes should be cleaned up during
> allocations.  Sometimes, for some reason, neiter happened.
> 
> In turns out that this is mainly due to a bug in commit f0e56edc2ec7
> ("gfs2: Split the two kinds of glock "delete" work"); see patch "gfs2:
> Fix unlinked inode cleanup".
> 
> While going through the relevant parts of the code, I noticed a number
> of additional minor problems which this patch set addresses as well.
> 
> Any thoughts?

Looks reasonable to me, and I appreciate the code clarity improvements.

Thanks,
Andy

> 
> Thanks,
> Andreas
> 
> Andreas Gruenbacher (16):
>    gfs2: Rename GLF_VERIFY_EVICT to GLF_VERIFY_DELETE
>    gfs2: Initialize gl_no_formal_ino earlier
>    gfs2: Allow immediate GLF_VERIFY_DELETE work
>    gfs2: Fix unlinked inode cleanup
>    gfs2: Faster gfs2_upgrade_iopen_glock wakeups
>    gfs2: Rename GIF_{DEFERRED -> DEFER}_DELETE
>    gfs2: Rename dinode_demise to evict_behavior
>    gfs2: Return enum evict_behavior from gfs2_upgrade_iopen_glock
>    gfs2: Minor delete_work_func cleanup
>    gfs2: Clean up delete work processing
>    gfs2: Call gfs2_queue_verify_delete from gfs2_evict_inode
>    gfs2: Update to the evict / remote delete documentation
>    gfs2: Use mod_delayed_work in gfs2_queue_try_to_evict
>    gfs2: Randomize GLF_VERIFY_DELETE work delay
>    gfs2: Use get_random_u32 in gfs2_orlov_skip
>    gfs2: Make gfs2_inode_refresh static
> 
>   fs/gfs2/glock.c  | 100 ++++++++++++++++-------------------------------
>   fs/gfs2/glock.h  |   7 ++++
>   fs/gfs2/glops.c  |  11 +++++-
>   fs/gfs2/incore.h |   4 +-
>   fs/gfs2/inode.c  |   1 +
>   fs/gfs2/inode.h  |   2 -
>   fs/gfs2/rgrp.c   |   6 +--
>   fs/gfs2/super.c  |  76 +++++++++++++++++++++--------------
>   8 files changed, 101 insertions(+), 106 deletions(-)
> 

