Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A80D3BB37
	for <gfs2@lists.linux.dev>; Mon, 22 Jan 2024 12:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705927950; cv=none; b=kogLnQUVsUO+Iimb4aQj9x+zxKf/D89FjYUgVoO3ewZbx5ZG2E9Kr29fGPNygK+Uc5BBZ540w/bu8PZk0zoiCjpCXAXgOylu1OvlWkmY1diwZbzUacWuIJAgGhlgBnsBHLBMehdzJfGIjwVlDYZmfcTttgh3rSLoFCJrI4yYbTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705927950; c=relaxed/simple;
	bh=uE68hIkQXsjJiWFkYcXe0I3Q5yg/CldjKKuzWKZNh4o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o0wH29TnTzaMgpMdbtKMA9LZ4dJZCknxiZFvv2F+78SqZFE8mDJu5/PX643Q3QPLtFCP6IHCBpzXgaq8/qfQPow81QSllE3oAgsBLzR9hIguTQZHg2Gx9wOo95cH4I7XfpNhHdkw8hozda1B5CbTzUu219JNnbzLeD9I7coYn+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OxVob/8Z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OxVob/8Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705927948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mtMnnYRMn0f7y2TJq10wMGHBBkogVw9XvplaGxITIMU=;
	b=OxVob/8ZmEA3Ffi9tFgEPhoKQfeHgt6ksYgHyklQPLfb04Ux217olVjTr5oivg72grgmC0
	zV7MLOsccAWH2Sb/hcp2inznjMwPlhQmxJ6vNKCH91MRANDeEahVR9yufwILb14J/kfiyw
	bVMqAV5o7sJ7aPgAlWl/bD8V9GvEugc=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-ygro4NyANBia_xgdDmoNKg-1; Mon, 22 Jan 2024 07:52:27 -0500
X-MC-Unique: ygro4NyANBia_xgdDmoNKg-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7831ed4bb2aso615564385a.0
        for <gfs2@lists.linux.dev>; Mon, 22 Jan 2024 04:52:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705927946; x=1706532746;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mtMnnYRMn0f7y2TJq10wMGHBBkogVw9XvplaGxITIMU=;
        b=OjK8DQvethkgd6fHvcIYKMgs12qMqk4FenvRNnZ3fw0zchekgdRsYqUfZ+BjvePY0I
         milRzDCcI5d9Xb0wkp9p9U8azVIH2BzaLI1sL4Vj+LeedBqk2r6qIqpxu+cewd0UEBVV
         K9h7ONKQL/zaJEUDAYb5Ywp7YD/00DYeOIO17RcMOeCGQZhIQ7T+zz3pDjmpDie0p5D3
         c2UuPSgz/scn9gz8c8zITZUIx7zKrKGlS59/7LILAqFn7gr85SpmJFpjiV1h8Sjq+8ff
         UQHIarL/jEd15oob2S2n56TD0SEeyxijo8RuOGE08yDbi1XaB6liG1RmeiwXJJKV7L7B
         Ez0A==
X-Gm-Message-State: AOJu0Yw3IwUkgMeInVzigVC16e8GoaVAcidClgoGibMIJpWAlTIGz5Lr
	MK0un2nrtL4JofCPcQl0IqQHadvFkq5odm88YRaRhobEVXa5+1W0VL/fxqowUYWYFdvHlsWxVW0
	oMG5hM54YqKAyzSLUE8V+aRDYqHC4xMRovzKD3lGAdpgZaMGPUyI=
X-Received: by 2002:a05:620a:4311:b0:783:9b6f:ae23 with SMTP id u17-20020a05620a431100b007839b6fae23mr2490214qko.153.1705927946653;
        Mon, 22 Jan 2024 04:52:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEMqqqJmvOF+gAFd/RTBY8cnlc2DjqScjRJACd6EeZHO7GqmSI2jb4pZe1wPox2qe7BBvmm9A==
X-Received: by 2002:a05:620a:4311:b0:783:9b6f:ae23 with SMTP id u17-20020a05620a431100b007839b6fae23mr2490208qko.153.1705927946345;
        Mon, 22 Jan 2024 04:52:26 -0800 (PST)
Received: from [192.168.1.165] (cpc76484-cwma10-2-0-cust967.7-3.cable.virginm.net. [82.31.203.200])
        by smtp.gmail.com with ESMTPSA id n18-20020a05620a223200b0078366823711sm2085227qkh.119.2024.01.22.04.52.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 04:52:25 -0800 (PST)
Message-ID: <d8a68db9-9834-4c3f-bbbe-9c19354c09e2@redhat.com>
Date: Mon, 22 Jan 2024 12:52:22 +0000
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] gfs2: Bugs in "Use GL_NOBLOCK flag for non-blocking
 lookups"
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, gfs2@lists.linux.dev
References: <20240119212056.805617-1-agruenba@redhat.com>
From: Andrew Price <anprice@redhat.com>
In-Reply-To: <20240119212056.805617-1-agruenba@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/01/2024 21:20, Andreas Gruenbacher wrote:
> Hello,
> 
> Al Viro has reported issues with commit dd00aaeb3432 ("gfs2: Use
> GL_NOBLOCK flag for non-blocking lookups"):
> 
> * First, parent can now be NULL and dereferencing it in
>    gfs2_dir_check(d_inode(parent), &dentry->d_name, ip) isn't going to
>    work;
> 
> * Second, gfs2_dir_check() can still sleep, which breaks LOOKUP_RCU
>    mode.
> 
> These patches should fix both of these problems.  We'll either need
> these fixes added, or commit dd00aaeb3432 reverted for now.

No issues spotted. I like the gfs2_meta_read() improvement. If it helps:

Reviewed-by: Andrew Price <anprice@redhat.com>

Andy

> Thanks,
> Andreas
> 
> Andreas Gruenbacher (9):
>    gfs2: Fix gfs2_drevalidate NULL pointer dereference
>    gfs2: Pass FGP flags to gfs2_getbuf
>    gfs2: Split gfs2_meta_read_async off from gfs2_meta_read
>    gfs2: Add FGP_NOWAIT support to gfs2_meta_read_async
>    gfs2: Pass FGP flags to gfs2_meta_{,inode_}buffer
>    gfs2: Pass FGP flags to gfs2_dirent_search
>    gfs2: Pass FGP flags to gfs2_dir_check
>    gfs2: Minor gfs2_drevalidate cleanup
>    gfs2: Fix LOOKUP_RCU support in gfs2_drevalidate
> 
>   fs/gfs2/aops.c       |   4 +-
>   fs/gfs2/bmap.c       |  21 ++++----
>   fs/gfs2/dentry.c     |  32 ++++++++-----
>   fs/gfs2/dir.c        |  52 +++++++++++---------
>   fs/gfs2/dir.h        |   2 +-
>   fs/gfs2/file.c       |   4 +-
>   fs/gfs2/glops.c      |   2 +-
>   fs/gfs2/incore.h     |   1 -
>   fs/gfs2/inode.c      |  10 ++--
>   fs/gfs2/meta_io.c    | 112 ++++++++++++++++++++++++++++---------------
>   fs/gfs2/meta_io.h    |  15 +++---
>   fs/gfs2/ops_fstype.c |   4 +-
>   fs/gfs2/quota.c      |   2 +-
>   fs/gfs2/recovery.c   |   2 +-
>   fs/gfs2/rgrp.c       |   5 +-
>   fs/gfs2/super.c      |   6 +--
>   fs/gfs2/xattr.c      |  17 ++++---
>   17 files changed, 173 insertions(+), 118 deletions(-)
> 

