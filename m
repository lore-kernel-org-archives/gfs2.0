Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC12254B17
	for <gfs2@lists.linux.dev>; Wed, 23 Apr 2025 11:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745406757; cv=none; b=tlMxo80r0d23yDjPh4tZOMBvgmtNfvFfFdphN7RdUOsakEeTM3nRA6Dvc5uGa13UdSY+AsWOAxw58nZQAYfsUxrXjVXqFQMXCLRC0YL9LoyKIJMEnsFVNASzZI1Xeq6teCZP/pdRwE8ywJCO8xrJtLdQFnZqIRtHJT8lTdMrcEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745406757; c=relaxed/simple;
	bh=jEU6ClDco71tjwxvtd6g/vDKXA4IEr6kJQP26T7aQ58=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=XJ8zSJZOKv2iXfX4wurPD8OqY2E2j/lQmpzm1qfBWkcxapvPCFxsIFF25jbmZXLnPrIqGQYZbv/Q8Q6GZnOI6SeePGBYKHJ9HAHcm3zxMkUDHS0prd5tYwV9ODTp0RuUl0vPnjOa/AOD8gFnqKnnD0BSGHzrJXvc1PUMbK+ROls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ji+jS3MM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ji+jS3MM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745406753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OKLnLzVfP1S/ieYEVp7N/uY8Fzm9vHsC+LeDAiLV4ks=;
	b=Ji+jS3MMeCJjtt600lSO+yGHXEypI1XHx2gHOicgfA13N09+STdf+ylk7+4XiNBfFadxGs
	UxDzZSzVdtABQwJJEPNQAtSuPQg4IZ954osv5UZB8mTPYKZu4SCmKB4nC6Qn5UJ9ryAZBP
	cn5McQlQ9j8o/yyZDoGCaMsDJXWOfN0=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-540-a7WhZ_ChMk60Jz9hL6Z_dg-1; Wed, 23 Apr 2025 07:12:32 -0400
X-MC-Unique: a7WhZ_ChMk60Jz9hL6Z_dg-1
X-Mimecast-MFC-AGG-ID: a7WhZ_ChMk60Jz9hL6Z_dg_1745406752
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6e8ed78717eso106732436d6.2
        for <gfs2@lists.linux.dev>; Wed, 23 Apr 2025 04:12:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745406752; x=1746011552;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OKLnLzVfP1S/ieYEVp7N/uY8Fzm9vHsC+LeDAiLV4ks=;
        b=FOPNEdETb9SaRR9rhk8jBPm0yQGZd+3nR1w0a8g8Cf24zLAvVfAbboCEBxKuKaTO9J
         75sn6610YSsDtYK8bzsQnHZ6NcA8jW8Qh+XwAFanFaIUFQmUHFRBH3IPOf/934+0YvLW
         41OUDk6d/Y+VNgpneVF2NeblxKAZ1UVu988VoKlkoYUMNPQ/EcaJyy1X3OgSDGzA08nJ
         MJfv6MlPjJsoUyvY6NDlNSvu63w1vTLpQJ7LcwuJqF+hqLGtJhfCNRLpO00xUE+6E73U
         E4yDlunr/gr+IqOOVzvnTytqWReopxz3gB8fwXHEf8eSez530VDQBtk/1OREJDuRE963
         BxWQ==
X-Gm-Message-State: AOJu0Yw9MYk11GN7YRj2thsCsHN+b563zM+gMrW4LgXhus9kt1EAOwPO
	4QLYDUzJAVE6LO5VjT/+d4QghLAVf1+92axMONSRjAAT5dZ5BumkohKwO968RMnIL1Hqn2HrVeJ
	1qTYZ2g+zY5hXmfMeqWafJ5VN2f4a8XC5nAZ0A29b8VtxlFA6ecU=
X-Gm-Gg: ASbGncuFt0AUdw6xuJj0EdkIfxBTOVwPQj/ZadNZFG/77eqOly6sBi+fauITYUXfnGj
	EM8GIBs5120ujUsdP4ng28VBZLrMZcb2Gg+kys7RzcEgT4oUY15nwXEsbmUGZi7NRxpCLQHNz3f
	dtr6OnNqrCgNvTy2KTK0EanmELIRkLAr9szxWZh8loLFvlP/otQFOkbCBlHy/oBaa8QtQo4pLAg
	lz/gtlsikQTd7bEh4hsFlw1S5Qo5VfQ70Se1ffP7aNM3Ka/TReg1eIAuIm6r2+4S+MYxEyBwCUQ
	dtltxflY3yiKEth18ibWekPsiQWHxksY5lyLrUWue9XYVlJxQqNpRc/QM4gGWt1UbxGvz1s=
X-Received: by 2002:a05:6214:212e:b0:6d8:ada3:26c9 with SMTP id 6a1803df08f44-6f2c4553366mr426797026d6.10.1745406752119;
        Wed, 23 Apr 2025 04:12:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5xFe8uHZhCPrJYhGcsC1po+4JG4JHcxec3ojgCyqJZ2RjpqWmfl1dJlIawkb28EZ200D5ug==
X-Received: by 2002:a05:6214:212e:b0:6d8:ada3:26c9 with SMTP id 6a1803df08f44-6f2c4553366mr426796756d6.10.1745406751777;
        Wed, 23 Apr 2025 04:12:31 -0700 (PDT)
Received: from [192.168.1.167] (cpc76484-cwma10-2-0-cust967.7-3.cable.virginm.net. [82.31.203.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f2c2c3b8a0sm69308436d6.123.2025.04.23.04.12.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Apr 2025 04:12:31 -0700 (PDT)
Message-ID: <07f44d28-2c77-4e2f-acb7-63ffb607a919@redhat.com>
Date: Wed, 23 Apr 2025 12:12:27 +0100
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] gfs2: deallocate inodes in gfs2_create_inode
To: Andreas Gruenbacher <agruenba@redhat.com>
References: <20250422095407.1221362-1-agruenba@redhat.com>
 <20250422095407.1221362-3-agruenba@redhat.com>
Cc: gfs2@lists.linux.dev
From: Andrew Price <anprice@redhat.com>
In-Reply-To: <20250422095407.1221362-3-agruenba@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: T9w9YCjNhQehne9mucaqi200pSCA_pflZID1TqyqF_I_1745406752
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/04/2025 10:54, Andreas Gruenbacher wrote:
> When creating and destroying inodes, we are relying on the inode hash
> table to make sure that for a given inode number, only a single inode
> will exist.  We then link that inode to its inode and iopen glock and
> let those glocks point back at the inode.  However, when iget_failed()
> is called, the inode is removed from the inode hash table before
> gfs_evict_inode() is called, and uniqueness is no longer guaranteed.
> 
> Commit f1046a472b70 ("gfs2: gl_object races fix") was trying to work
> around that problem by detaching the inode glock from the inode before
> calling iget_failed(), but that broke the inode deallocation code in
> gfs_evict_inode().
> 
> To fix that, deallocate partially created inodes in gfs2_create_inode()
> instead of relying on gfs_evict_inode() for doing that.
> 
> This means that gfs2_evict_inode() and its helper functions will no
> longer see partially created inodes, and some simplifications are
> possible there.

Looks good. It survived an overnight run of generic/256 on 3 VMs.

Andy

> 
> Fixes: f1046a472b70 ("gfs2: gl_object races fix")
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> ---
>   fs/gfs2/inode.c | 21 ++++++++++++++-------
>   fs/gfs2/super.c |  6 +-----
>   2 files changed, 15 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
> index 0b2d75106b1c..2812cce21817 100644
> --- a/fs/gfs2/inode.c
> +++ b/fs/gfs2/inode.c
> @@ -701,6 +701,7 @@ static int gfs2_create_inode(struct inode *dir, struct dentry *dentry,
>   	u32 aflags = 0;
>   	unsigned blocks = 1;
>   	struct gfs2_diradd da = { .bh = NULL, .save_loc = 1, };
> +	bool xattr_initialized = false;
>   
>   	if (!name->len || name->len > GFS2_FNAMESIZE)
>   		return -ENAMETOOLONG;
> @@ -813,11 +814,11 @@ static int gfs2_create_inode(struct inode *dir, struct dentry *dentry,
>   
>   	error = gfs2_glock_get(sdp, ip->i_no_addr, &gfs2_inode_glops, CREATE, &ip->i_gl);
>   	if (error)
> -		goto fail_free_inode;
> +		goto fail_dealloc_inode;
>   
>   	error = gfs2_glock_get(sdp, ip->i_no_addr, &gfs2_iopen_glops, CREATE, &io_gl);
>   	if (error)
> -		goto fail_free_inode;
> +		goto fail_dealloc_inode;
>   	gfs2_cancel_delete_work(io_gl);
>   	io_gl->gl_no_formal_ino = ip->i_no_formal_ino;
>   
> @@ -842,8 +843,10 @@ static int gfs2_create_inode(struct inode *dir, struct dentry *dentry,
>   	if (error)
>   		goto fail_gunlock3;
>   
> -	if (blocks > 1)
> +	if (blocks > 1) {
>   		gfs2_init_xattr(ip);
> +		xattr_initialized = true;
> +	}
>   	init_dinode(dip, ip, symname);
>   	gfs2_trans_end(sdp);
>   
> @@ -898,6 +901,14 @@ static int gfs2_create_inode(struct inode *dir, struct dentry *dentry,
>   	gfs2_glock_dq_uninit(&ip->i_iopen_gh);
>   fail_gunlock2:
>   	gfs2_glock_put(io_gl);
> +fail_dealloc_inode:
> +	set_bit(GIF_ALLOC_FAILED, &ip->i_flags);
> +	if (ip->i_eattr)
> +		gfs2_ea_dealloc(ip, xattr_initialized);
> +	clear_nlink(inode);
> +	mark_inode_dirty(inode);
> +	gfs2_dinode_dealloc(ip);
> +	ip->i_no_addr = 0;
>   fail_free_inode:
>   	if (ip->i_gl) {
>   		gfs2_glock_put(ip->i_gl);
> @@ -912,10 +923,6 @@ static int gfs2_create_inode(struct inode *dir, struct dentry *dentry,
>   	gfs2_dir_no_add(&da);
>   	gfs2_glock_dq_uninit(&d_gh);
>   	if (!IS_ERR_OR_NULL(inode)) {
> -		set_bit(GIF_ALLOC_FAILED, &ip->i_flags);
> -		clear_nlink(inode);
> -		if (ip->i_no_addr)
> -			mark_inode_dirty(inode);
>   		if (inode->i_state & I_NEW)
>   			iget_failed(inode);
>   		else
> diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
> index e25a24ae2197..54f1efd47a3e 100644
> --- a/fs/gfs2/super.c
> +++ b/fs/gfs2/super.c
> @@ -1258,9 +1258,6 @@ static enum evict_behavior evict_should_delete(struct inode *inode,
>   	struct gfs2_sbd *sdp = sb->s_fs_info;
>   	int ret;
>   
> -	if (unlikely(test_bit(GIF_ALLOC_FAILED, &ip->i_flags)))
> -		goto should_delete;
> -
>   	if (gfs2_holder_initialized(&ip->i_iopen_gh) &&
>   	    test_bit(GLF_DEFER_DELETE, &ip->i_iopen_gh.gh_gl->gl_flags))
>   		return EVICT_SHOULD_DEFER_DELETE;
> @@ -1290,7 +1287,6 @@ static enum evict_behavior evict_should_delete(struct inode *inode,
>   	if (inode->i_nlink)
>   		return EVICT_SHOULD_SKIP_DELETE;
>   
> -should_delete:
>   	if (gfs2_holder_initialized(&ip->i_iopen_gh) &&
>   	    test_bit(HIF_HOLDER, &ip->i_iopen_gh.gh_iflags))
>   		return gfs2_upgrade_iopen_glock(inode);
> @@ -1314,7 +1310,7 @@ static int evict_unlinked_inode(struct inode *inode)
>   	}
>   
>   	if (ip->i_eattr) {
> -		ret = gfs2_ea_dealloc(ip, !test_bit(GIF_ALLOC_FAILED, &ip->i_flags));
> +		ret = gfs2_ea_dealloc(ip, true);
>   		if (ret)
>   			goto out;
>   	}

