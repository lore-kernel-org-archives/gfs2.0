Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF91C1DFC3
	for <gfs2@lists.linux.dev>; Thu, 19 Oct 2023 12:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FyVL85J4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697718499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XEW0SGr4MbR9CQVpzv4tkcFfYyLm9TH0drmlL9slatc=;
	b=FyVL85J49cQ/BvI+S4I2SqpUBzu2qThPUGtRQXga9Isnv5Bc+hm6CJ2OzlfuLh/vXPCRUc
	oyui4PXN52xd+agVBdwTh/fIHkaOq9YoM7RwXe8jBK/PSiVJsWBQWI0sx5JaGkTl1nfv2v
	TVhbymZr4QVcjpPRyPpl7fMIqlltW5c=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-2nkWuPK3MJ6Ik1ViTpe80Q-1; Thu, 19 Oct 2023 08:28:18 -0400
X-MC-Unique: 2nkWuPK3MJ6Ik1ViTpe80Q-1
Received: by mail-yb1-f198.google.com with SMTP id 3f1490d57ef6-d9cbe745e7eso457400276.3
        for <gfs2@lists.linux.dev>; Thu, 19 Oct 2023 05:28:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697718497; x=1698323297;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XEW0SGr4MbR9CQVpzv4tkcFfYyLm9TH0drmlL9slatc=;
        b=s+PcpPb/GPbtBeBKAPYPuyKCC3SpjuQgxIdefJEH7cm/05oQZnSzt6cKjNLIKXpzov
         d4c0yQV6ld4Dj8TNa+Zl4EBgchfYfKh6l7n6VsQaooryGgXFNnaOfe1SMigEHayD0O1s
         CiVKgEJJ4rFGy6l21jO5DTyIvPKeCWOzNRiD32qId9t0dUjpz4LBeF89q1r66xOcaTGP
         kvXTo+FJH3Uw7qPU8pAKSjXfUGARozHoKZdQ8/yA1ab/64rI6gV1HeKSwfuwJk6kk1Lm
         MCuAfMgCTeZuP1Xicva1Us0Q3WtFCQMl/9XTTOEi9x+idH/XjW1xyIUn59IkfmvGDamb
         rYsA==
X-Gm-Message-State: AOJu0YwOE+9F4kfbL465J31xWBoisuQThW0yNwCUOsncYzADNn97adG4
	/h7FRgsmJytUoyr9wiWc6Hfm2JGXgzA4cP172q80RyutK1LJkC4DH+VZJY0hNzDaBNwZHPpnzsh
	oXIApuAGruN4rmQ==
X-Received: by 2002:a25:9802:0:b0:d9a:4fa0:dca9 with SMTP id a2-20020a259802000000b00d9a4fa0dca9mr1959644ybo.25.1697718497664;
        Thu, 19 Oct 2023 05:28:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsBhf8CkOk5LzOFaZntyg+KF/j0oUcdZXQZzrNvkHBmp4jM6uNdGp07fJUfPbFCGQ8CVNaTw==
X-Received: by 2002:a25:9802:0:b0:d9a:4fa0:dca9 with SMTP id a2-20020a259802000000b00d9a4fa0dca9mr1959632ybo.25.1697718497403;
        Thu, 19 Oct 2023 05:28:17 -0700 (PDT)
Received: from [192.168.1.165] (cpc76484-cwma10-2-0-cust967.7-3.cable.virginm.net. [82.31.203.200])
        by smtp.gmail.com with ESMTPSA id e13-20020ad450cd000000b0065cffe12ae9sm740160qvq.36.2023.10.19.05.28.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 05:28:16 -0700 (PDT)
Message-ID: <be0ce0c5-5278-4d29-94d2-e5ce26e8e3b5@redhat.com>
Date: Thu, 19 Oct 2023 13:28:13 +0100
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Cluster-devel] [gfs2:extents 14/14] fs/gfs2/extents.c:123:23-27:
 WARNING use flexible-array member instead
 (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
 (fwd)
To: Julia Lawall <julia.lawall@inria.fr>
Cc: oe-kbuild-all@lists.linux.dev, gfs2@lists.linux.dev,
 Andreas Gruenbacher <agruenba@redhat.com>
References: <a8791f89-ed7b-1649-3b53-72349899c5d@inria.fr>
From: Andrew Price <anprice@redhat.com>
In-Reply-To: <a8791f89-ed7b-1649-3b53-72349899c5d@inria.fr>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/10/2023 06:27, Julia Lawall wrote:
> 
> 
> ---------- Forwarded message ----------
> Date: Thu, 19 Oct 2023 05:56:44 +0800
> From: kernel test robot <lkp@intel.com>
> To: oe-kbuild@lists.linux.dev
> Cc: lkp@intel.com, Julia Lawall <julia.lawall@inria.fr>
> Subject: [gfs2:extents 14/14] fs/gfs2/extents.c:123:23-27: WARNING use
>      flexible-array member instead
>      (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-
>      and-one-element-arrays)
> 
> BCC: lkp@intel.com
> CC: oe-kbuild-all@lists.linux.dev
> CC: cluster-devel@redhat.com

The lkp-tests contact info is out of date. I've opened a PR to fix it at 
https://github.com/intel/lkp-tests/pull/319 but it should probably use 
the latest MAINTAINERS file always. CCing the new gfs2 list.

Thanks,
Andy

> TO: Andreas Gruenbacher <agruenba@redhat.com>
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git extents
> head:   86474c69cac46872bd311318c02fb8e9e25abd10
> commit: 86474c69cac46872bd311318c02fb8e9e25abd10 [14/14] gfs2: Add some initial extents-based inode code
> :::::: branch date: 9 days ago
> :::::: commit date: 9 days ago
> config: x86_64-randconfig-101-20231018 (https://download.01.org/0day-ci/archive/20231019/202310190541.0impmnL4-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce: (https://download.01.org/0day-ci/archive/20231019/202310190541.0impmnL4-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Julia Lawall <julia.lawall@inria.fr>
> | Closes: https://lore.kernel.org/r/202310190541.0impmnL4-lkp@intel.com/
> 
> cocci warnings: (new ones prefixed by >>)
>>> fs/gfs2/extents.c:123:23-27: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> 
> vim +123 fs/gfs2/extents.c
> 
> 86474c69cac468 Andreas Gruenbacher 2021-03-25  115
> 86474c69cac468 Andreas Gruenbacher 2021-03-25  116  /*
> 86474c69cac468 Andreas Gruenbacher 2021-03-25  117   * The path components in struct gfs2_extent_path are stored in "reverse"
> 86474c69cac468 Andreas Gruenbacher 2021-03-25  118   * order: the leaf is stored first, and when the tree grows at the root,
> 86474c69cac468 Andreas Gruenbacher 2021-03-25  119   * this happens at the end of the array.
> 86474c69cac468 Andreas Gruenbacher 2021-03-25  120   */
> 86474c69cac468 Andreas Gruenbacher 2021-03-25  121  struct gfs2_extent_path {
> 86474c69cac468 Andreas Gruenbacher 2021-03-25  122  	unsigned int p_height;
> 86474c69cac468 Andreas Gruenbacher 2021-03-25 @123  	struct gfs2_extent_pc p_pc[1];
> 86474c69cac468 Andreas Gruenbacher 2021-03-25  124  };
> 86474c69cac468 Andreas Gruenbacher 2021-03-25  125
> 

