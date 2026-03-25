Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C923DBD65
	for <gfs2@lists.linux.dev>; Wed, 25 Mar 2026 17:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774461544; cv=none; b=WIGBauH+ME1Ot9L2/andlaSPq7hegRE9jozGMRQ01wOB2y8ESPSHk0IMmzIMfRbAr97VwV3GWzQRrcNFBxrmdSutrvs0wtDKhl1ClJQJbGI1Q3FY97eESZRsrlwHHQqMmWw4HpAlPQMOswu0ziiaFYPonaUbZouFTgO8EZhbnow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774461544; c=relaxed/simple;
	bh=27WiXbuz7LQ7SUuHNpU/TxCpmFZwuLH8dnK7tVbqWYk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jTZ9ZUnSMxwxYAXpz0ysiLrVU1pyMDvdaGkkjIiWlbT1274+H1a/XV5A80gdg2PzZhj8f/31Jdj7dRs5PmkRVMF2nbk0vARCmcuIOjz4k52NrCopyqRR8AuxPWbyhWR8v11zogWFEBf7I4JX2lO7i0k6Evr+Bsr/7hrfngt6O+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xsk7HYDa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xsk7HYDa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774461538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XV6+p1ZjMFp6dFSyL4EnqGiwU7NN8uAoneHl7K50Fzw=;
	b=Xsk7HYDaRJDr/9vn/67siBdL7W2OtbR2XUaF0ULk0Fm8ylkyXsQfOcrf3I6ywruz/KGiup
	+DpA94meFdwaLNs2zxQZsJrvKjkE/ai4OH7a3klHIoQaCunvKPTWZx2uR2+gzc62NuV6Sk
	Hm6dkjo9PJ2JW5iJ89q0oT9UBbKSBPw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-370-D2Cg8cBWOyqUHDM68ecAZg-1; Wed, 25 Mar 2026 13:58:56 -0400
X-MC-Unique: D2Cg8cBWOyqUHDM68ecAZg-1
X-Mimecast-MFC-AGG-ID: D2Cg8cBWOyqUHDM68ecAZg_1774461535
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-43b93781cb8so13953f8f.3
        for <gfs2@lists.linux.dev>; Wed, 25 Mar 2026 10:58:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774461535; x=1775066335;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XV6+p1ZjMFp6dFSyL4EnqGiwU7NN8uAoneHl7K50Fzw=;
        b=mt0RxTFsfCUj6J4VT+baO7OagT7j8FBoG57V5qzNclW1BTdef9b8hRUCHV8mjmmxtJ
         R9mRt1DBH+oKcxkPVrXEX7D2vmyDt3WncinbpAtczGL1Yu6rCh8uovOCUjyiOoyNG8Vq
         UwX/i+zkJjrvsmvfQbIbMPICYnLhCtXI1Zf1CjIDc/BoZio32s9CjxJuz4LVno1Wa30R
         R9ibP2ru20HmEatjyCp4k1M/gxsTGA6rV/xTx1QaHheTlpirJdIcPbIx8XgtWGtBGeAp
         nVy6DTjYYv/sxH8Ftf/kG9KWdR+MEwe5LJn16NLVurKq2Vhop4mPHtCeygayz9M3ZpLC
         kVmA==
X-Gm-Message-State: AOJu0Yx4xQVAi5P9FCHwjtwdStSbaX0Ek8e7xqjZTL1028LJ/rQHJdaT
	lUwOgp/Lk0X4j72gEdSZctf1C4+UJz2V1tE+nc0Sb/FyloSM8UPF6dn9TXEUq+KP1MOhCnLw+B9
	KsX8Hgtzg5oCb4DJLx5Ey6XZxiOQzxvHjigqmOQu/gZj4/kuHUCq9STuA2bF4pho=
X-Gm-Gg: ATEYQzx4atym9ZAuIdTgns7rxZiRtXTCPltP+MmwBF1DK5J+gHe+iou3HnnY9mtiGDv
	d1Cs3UO3+RAJntKfu+WOQ8hkFmuxywVvVoKUEOEzxtH0FtCKmKJfyqW4lYMVH81l7DaeAumOkx1
	4STsfKCii/sOpxxafi+kBYwTaxQZwoUYwWqhB1pBvfGiJ92JMiir4YfpObUVSxu4eoJToSjDTRa
	g9aWembJvn7MJuV+AdAPBn1j1LjiIHqBN5eT4HYSbp7wPEPNrfm6aopEjYuqd+G2OqWdnoWgVzE
	FU76onmOl0UooqFqJWlw9G4pwt+RXYeYhGqCG4JEqT1QzN289vgHWw2iI0DomFdWa/L2F6+fWm7
	QoXYuMK1x4mH05VKon+dzwh60lS6lCRj9TY12Fa9RnEQjwQlOiuAMVjzVIjeJVa2GLkHVWBz4V5
	4WO9PcJQ==
X-Received: by 2002:adf:e6cd:0:b0:43b:4989:869d with SMTP id ffacd0b85a97d-43b88a055f2mr4780232f8f.33.1774461535232;
        Wed, 25 Mar 2026 10:58:55 -0700 (PDT)
X-Received: by 2002:adf:e6cd:0:b0:43b:4989:869d with SMTP id ffacd0b85a97d-43b88a055f2mr4780206f8f.33.1774461534738;
        Wed, 25 Mar 2026 10:58:54 -0700 (PDT)
Received: from [192.168.1.167] (cpc76484-cwma10-2-0-cust967.7-3.cable.virginm.net. [82.31.203.200])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b919df85csm1719148f8f.28.2026.03.25.10.58.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2026 10:58:54 -0700 (PDT)
Message-ID: <b15d7b72-134a-4e00-8220-5482e1ae2489@redhat.com>
Date: Wed, 25 Mar 2026 17:58:53 +0000
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gfs2: fix duplicate kmem_cache name on concurrent mounts
To: Deepanshu Kartikey <kartikey406@gmail.com>, agruenba@redhat.com
Cc: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org,
 syzbot+b441db1854c360b83221@syzkaller.appspotmail.com
References: <20260325060506.4868-1-kartikey406@gmail.com>
From: Andrew Price <anprice@redhat.com>
In-Reply-To: <20260325060506.4868-1-kartikey406@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: n5BEF8mgSZ3H1BA14PRvADhqsYA45Yw3X_Bde_7WTjE_1774461535
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/03/2026 06:05, Deepanshu Kartikey wrote:
> When gfs2_fill_super() creates the per-filesystem bufdata cache, it
> uses sd_fsname as part of the cache name:
> 
>   sdp->sd_bufdata = kmem_cache_create("gfs2-bufdata/<fsname>", ...);
> 
> At this point sd_fsname is set from sd_table_name (e.g. "syz:syz"),
> which is the same for all concurrent mounts of the same device.
> The unique suffix (.s for spectator, .N for journal ID) is only
> added to sd_fsname AFTER wait_on_journal() completes, since the
> journal ID is assigned by the locking subsystem during mount.
> 
> With multiple concurrent mounts of the same device (as triggered by
> syzkaller with procs:5), multiple calls to gfs2_fill_super() all try
> to create a cache named "gfs2-bufdata/syz:syz" before any of them
> reaches the point where sd_fsname becomes unique, triggering:
> 
>   kmem_cache of name 'gfs2-bufdata/syz:syz' already exists
>   WARNING: mm/slab_common.c:112
> 
> Fix this by moving the bufdata cache creation to after
> wait_on_journal() completes and sd_fsname has been updated with its
> unique suffix. Also move the fail_bufdata cleanup label accordingly
> in the error unwind path.

I don't think the description is accurate as the patch moves the kmem_cache_create() to after the gfs2_sys_fs_add(), which fails the mount cleanly on a duplicate lock table instead of triggering a warning.

That said, 767e4de3ffce ("gfs2: per-filesystem bufdata cache") is likely to get pulled out of for-next as it was more of a debugging aid so it's probably not worth a v2.

Andy

> 
> Reported-by: syzbot+b441db1854c360b83221@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=b441db1854c360b83221
> Fixes: 767e4de3ffce ("gfs2: per-filesystem bufdata cache")
> Tested-by: syzbot+b441db1854c360b83221@syzkaller.appspotmail.com
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> ---
>  fs/gfs2/ops_fstype.c | 21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
> index b44adb40635d..7f8e04c11494 100644
> --- a/fs/gfs2/ops_fstype.c
> +++ b/fs/gfs2/ops_fstype.c
> @@ -1198,17 +1198,9 @@ static int gfs2_fill_super(struct super_block *sb, struct fs_context *fc)
>  	if (!sdp->sd_delete_wq)
>  		goto fail_glock_wq;
>  
> -	char *bufdata_name = kasprintf(GFP_KERNEL, "gfs2-bufdata/%s", sdp->sd_fsname);
> -	sdp->sd_bufdata = kmem_cache_create(bufdata_name,
> -					    sizeof(struct gfs2_bufdata),
> -					    0, 0, NULL);
> -	kfree(bufdata_name);
> -	if (!sdp->sd_bufdata)
> -		goto fail_delete_wq;
> -
>  	error = gfs2_sys_fs_add(sdp);
>  	if (error)
> -		goto fail_bufdata;
> +		goto fail_delete_wq;
>  
>  	gfs2_create_debugfs_file(sdp);
>  
> @@ -1255,6 +1247,15 @@ static int gfs2_fill_super(struct super_block *sb, struct fs_context *fc)
>  		snprintf(sdp->sd_fsname, sizeof(sdp->sd_fsname), "%s.%u",
>  			 sdp->sd_table_name, sdp->sd_lockstruct.ls_jid);
>  
> +	char *bufdata_name = kasprintf(GFP_KERNEL, "gfs2-bufdata/%s", sdp->sd_fsname);
> +
> +	sdp->sd_bufdata = kmem_cache_create(bufdata_name,
> +					    sizeof(struct gfs2_bufdata),
> +					     0, 0, NULL);
> +	kfree(bufdata_name);
> +	if (!sdp->sd_bufdata)
> +		goto fail_sb;
> +
>  	error = init_inodes(sdp, DO);
>  	if (error)
>  		goto fail_sb;
> @@ -1304,6 +1305,7 @@ static int gfs2_fill_super(struct super_block *sb, struct fs_context *fc)
>  	if (sb->s_root)
>  		dput(sb->s_root);
>  	sb->s_root = NULL;
> +	kmem_cache_destroy(sdp->sd_bufdata);
>  fail_locking:
>  	init_locking(sdp, &mount_gh, UNDO);
>  fail_lm:
> @@ -1313,8 +1315,6 @@ static int gfs2_fill_super(struct super_block *sb, struct fs_context *fc)
>  fail_debug:
>  	gfs2_delete_debugfs_file(sdp);
>  	gfs2_sys_fs_del(sdp);
> -fail_bufdata:
> -	kmem_cache_destroy(sdp->sd_bufdata);
>  fail_delete_wq:
>  	destroy_workqueue(sdp->sd_delete_wq);
>  fail_glock_wq:

