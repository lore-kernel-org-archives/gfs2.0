Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197E2381B0D
	for <gfs2@lists.linux.dev>; Mon,  6 Jul 2026 15:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783350898; cv=none; b=CvkzJwtCvxUnc4IVwvr9JT4tdVu5pK1qst2PGZPjTuYFjdZ4MGZXa00Tj6E12OeGR5E2uFpUSWSpF5jb3CR9nm3WVHFQlEDmTMDkqz6iGQIOq5inil+o+5EbOSjF0uW170R9chMmEXaLaYPx/SFwhV1zQAAgmiifAVaDNF68bRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783350898; c=relaxed/simple;
	bh=vDU41NdjFea6rhG0v3jf/z1FWs9UPuWRum9UfbYivKg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MD9bO4YGuJcGTBU3kUglNOr6viUKCvpO99Zgk0SXCioZwtZ8aCyeWh/wsqI++lIs8yDDuLwomkL8tZxOAVRmdrcKiW1dl7o4WQrVuybZ64wEcQAllLdYn042/RJHpQ12Zz2wu92Lb4TgF507tXzpQBytWfzKDz631uAIfFLlVnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I6V81ji6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I6V81ji6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783350896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XVa6ctAi5t78VnS5MdfYUXx+WGiwq/yUHuM1oy2LXDs=;
	b=I6V81ji60xF3dDkSlHZnJIcn5PKeVVDDXneEYu0ah+mnVf0SQvBEc8u1j+BLscjzzyMF62
	k/ZpfnnTt0O9FDdl7ID4b/Ify/SGOkh46Jmd953cN8Wm0wtP1m8Uhn4DVnSr1OPYQHXrqa
	aJbax4s2KwAwYsAnjbcXrB6AAgVYET4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-LflKwD6_MAeEhNqOQKPZ6g-1; Mon, 06 Jul 2026 11:14:54 -0400
X-MC-Unique: LflKwD6_MAeEhNqOQKPZ6g-1
X-Mimecast-MFC-AGG-ID: LflKwD6_MAeEhNqOQKPZ6g_1783350894
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-47bbe3b9705so1724670f8f.0
        for <gfs2@lists.linux.dev>; Mon, 06 Jul 2026 08:14:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783350893; x=1783955693;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XVa6ctAi5t78VnS5MdfYUXx+WGiwq/yUHuM1oy2LXDs=;
        b=s4CEnfrWlasYnnRCrzcqsZe0lkJ6hoUtFxRZih4mAPWBuP5wX7rPihiPtuhK8hCE4u
         n+rT5N9+9g0H9IRd6NQxBduKNLvaEs0fTnbB79lMoJTTbTcqJ1eVCS/tWbaO9y0q5Qgd
         ImYTPkG+7rQgcxphjfO0xAbnzFYU0/bjZxAzlKUfhcJlgsOnXf3uaVi4rFyxHLcTtczE
         j+bUMIJHQwLlA+IE7UMQzHDfxC300noU2h+8ehbAUqAR+1WbBl/v4ZgCeENfrwYSpkVk
         9nr3eQtHiYgFoi3o+zyVooHcktx8nse1mI189G2quzMxru1b26Q6hscyZ6andy82l4Zl
         3PsA==
X-Forwarded-Encrypted: i=1; AHgh+RoV95kIkHYc5AxYpzU5NZ6fAJVi8uk2nccs2frSCy71NtT8KhcxLMsybPYm4yY6Bcv0S3ls@lists.linux.dev
X-Gm-Message-State: AOJu0YxltBC1uJR/nyYjDucG3RVVRMl5DWhMURpg/gVOLFdMf83qQy/b
	yatVRM1xyMmnWLH7gIDiMpyVO/ZtpOvuqcVHecakeTW9Hb2lVmh0q86n3oqQp/FZ2ogl7yjv/+F
	8ZsFXDDu4XootlzWT8A5U/wGu/VZyt9jONXx3S/Kyf/ggUpbLQlJFvI0=
X-Gm-Gg: AfdE7clBljDCGm4DqRYmcJPoVRskZEfntCkxlzy1+fLk1FjNufPFDNgfAXukm91i7cr
	cY1wUIPcfrZ7t8UbUYTkDLgUKTc+fu4USyfuLX5F/vvpKwvzh5H3T19rg6yLyfwaIs39ajpnsiY
	YUuAv0+vRW68kns2eru8S9BjrqvqABGdZApcMyBBCpWYl5R/4gcAcVGg8flWiHLeV6Gnihw/8bq
	MYPGu2IWsLAZSdUv3upKa/Kymvvym5xPw88jC9bKEH2mHmtuUXXmNyiUNw0uJsizUfisu5pZbod
	YgzmT7ppvk5kve5JNs+bQdlIZ0eqMWcaDwS9LM5L3jFlZVY86vhMZd45EC+N9Sd39CV5C9MBtw6
	7hpzim9zhvRHKvULHMP/iHqclsvHHh0aW9Izid99+3/y5HiBwpTsTfzzHD0zBpNyT9tWAsaU=
X-Received: by 2002:adf:e40e:0:b0:475:f0c2:75a6 with SMTP id ffacd0b85a97d-47de66f2e70mr550495f8f.55.1783350893622;
        Mon, 06 Jul 2026 08:14:53 -0700 (PDT)
X-Received: by 2002:adf:e40e:0:b0:475:f0c2:75a6 with SMTP id ffacd0b85a97d-47de66f2e70mr550456f8f.55.1783350893203;
        Mon, 06 Jul 2026 08:14:53 -0700 (PDT)
Received: from [192.168.1.167] (cpc76484-cwma10-2-0-cust967.7-3.cable.virginm.net. [82.31.203.200])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0f213e8sm22403251f8f.34.2026.07.06.08.14.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 08:14:52 -0700 (PDT)
Message-ID: <74871a78-5243-4898-8e63-92e918912980@redhat.com>
Date: Mon, 6 Jul 2026 16:14:51 +0100
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gfs2: validate stuffed inode size before unstuffing
To: Jiaming Zhang <r772577952@gmail.com>, agruenba@redhat.com
Cc: linux-kernel@vger.kernel.org, syzkaller@googlegroups.com,
 stable@vger.kernel.org, gfs2@lists.linux.dev
References: <CANypQFaF6bvORKKbRALvEL0k_epFaneFiOQqco4gjdmKVbdURg@mail.gmail.com>
 <20260705140620.1732914-1-r772577952@gmail.com>
From: Andrew Price <anprice@redhat.com>
In-Reply-To: <20260705140620.1732914-1-r772577952@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BryP5UcBgotEKBcSqEb-oiqsipzXCsz748QD0xALilo_1783350894
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/07/2026 15:06, Jiaming Zhang wrote:
> A corrupted GFS2 image can store a dinode size that is larger than what VFS
> i_size can represent. gfs2_dinode_in() reads the on-disk di_size as a u64 and
> writes it directly into inode->i_size. If the value is larger than S64_MAX, the
> incore i_size becomes negative. That negative value can bypass the existing
> stuffed inode size check:
> 
> inode->i_size > gfs2_max_stuffed_size(ip)
> 
> Later, gfs2_quotad may try to sync the quota file and unstuff the quota inode.
> gfs2_unstuffer_folio() reads the negative i_size into an unsigned length and
> passes it to memcpy(), turning it into a huge copy size and triggering a
> out-of-bound issue.
> 
> Reject dinodes whose size exceeds sb->s_maxbytes before storing the value in
> inode->i_size. Also make the stuffed inode check use the raw on-disk size while
> it is still unsigned. As a defensive measure, validate the incore i_size again
> before unstuffing and pass the checked size down to gfs2_unstuffer_folio().
> 
> Fixes: 70376c7ff312 ("gfs2: Always check inode size of inline inodes")
> Closes: https://lore.kernel.org/lkml/CANypQFaF6bvORKKbRALvEL0k_epFaneFiOQqco4gjdmKVbdURg@mail.gmail.com/
> Assisted-by: Codex:gpt-5.5-xhigh
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiaming Zhang <r772577952@gmail.com>
> ---
>  fs/gfs2/bmap.c  | 18 ++++++++++++------
>  fs/gfs2/glops.c | 10 +++++++---
>  2 files changed, 19 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
> index 51ac1fd44f78..89c46c1d622c 100644
> --- a/fs/gfs2/bmap.c
> +++ b/fs/gfs2/bmap.c
> @@ -52,16 +52,15 @@ static int punch_hole(struct gfs2_inode *ip, u64 offset, u64 length);
>   * Returns: errno
>   */
>  static int gfs2_unstuffer_folio(struct gfs2_inode *ip, struct buffer_head *dibh,
> -			       u64 block, struct folio *folio)
> +			       u64 block, struct folio *folio, size_t size)
>  {
>  	struct inode *inode = &ip->i_inode;
>  
>  	if (!folio_test_uptodate(folio)) {
>  		void *kaddr = kmap_local_folio(folio, 0);
> -		u64 dsize = i_size_read(inode);
> - 
> -		memcpy(kaddr, dibh->b_data + sizeof(struct gfs2_dinode), dsize);
> -		memset(kaddr + dsize, 0, folio_size(folio) - dsize);
> +
> +		memcpy(kaddr, dibh->b_data + sizeof(struct gfs2_dinode), size);
> +		memset(kaddr + size, 0, folio_size(folio) - size);
>  		kunmap_local(kaddr);
>  
>  		folio_mark_uptodate(folio);
> @@ -92,9 +91,15 @@ static int __gfs2_unstuff_inode(struct gfs2_inode *ip, struct folio *folio)
>  	struct buffer_head *bh, *dibh;
>  	struct gfs2_dinode *di;
>  	u64 block = 0;
> +	loff_t size = i_size_read(&ip->i_inode);
>  	int isdir = gfs2_is_dir(ip);
>  	int error;
>  
> +	if (unlikely(size < 0 || size > gfs2_max_stuffed_size(ip))) {

How might the size be invalid here?

> +		gfs2_consist_inode(ip);
> +		return -EIO;
> +	}
> +
>  	error = gfs2_meta_inode_buffer(ip, &dibh);
>  	if (error)
>  		return error;
> @@ -116,7 +121,8 @@ static int __gfs2_unstuff_inode(struct gfs2_inode *ip, struct folio *folio)
>  					      dibh, sizeof(struct gfs2_dinode));
>  			brelse(bh);
>  		} else {
> -			error = gfs2_unstuffer_folio(ip, dibh, block, folio);
> +			error = gfs2_unstuffer_folio(ip, dibh, block, folio,
> +						     size);
>  			if (error)
>  				goto out_brelse;
>  		}
> diff --git a/fs/gfs2/glops.c b/fs/gfs2/glops.c
> index 28f32424ee64..33575fa681f5 100644
> --- a/fs/gfs2/glops.c
> +++ b/fs/gfs2/glops.c
> @@ -393,11 +393,16 @@ static int gfs2_dinode_in(struct gfs2_inode *ip, const void *buf)
>  	umode_t mode = be32_to_cpu(str->di_mode);
>  	struct inode *inode = &ip->i_inode;
>  	bool is_new = inode_state_read_once(inode) & I_NEW;
> +	u64 size = be64_to_cpu(str->di_size);
>  
>  	if (unlikely(ip->i_no_addr != be64_to_cpu(str->di_num.no_addr))) {
>  		gfs2_consist_inode(ip);
>  		return -EIO;
>  	}
> +	if (unlikely(size > (u64)inode->i_sb->s_maxbytes)) {
> +		gfs2_consist_inode(ip);
> +		return -EIO;
> +	}

This check is likely all that's needed.

Andy

>  	if (unlikely(!is_new && inode_wrong_type(inode, mode))) {
>  		gfs2_consist_inode(ip);
>  		return -EIO;
> @@ -418,7 +423,7 @@ static int gfs2_dinode_in(struct gfs2_inode *ip, const void *buf)
>  	i_uid_write(inode, be32_to_cpu(str->di_uid));
>  	i_gid_write(inode, be32_to_cpu(str->di_gid));
>  	set_nlink(inode, be32_to_cpu(str->di_nlink));
> -	i_size_write(inode, be64_to_cpu(str->di_size));
> +	i_size_write(inode, size);
>  	gfs2_set_inode_blocks(inode, be64_to_cpu(str->di_blocks));
>  	atime.tv_sec = be64_to_cpu(str->di_atime);
>  	atime.tv_nsec = be32_to_cpu(str->di_atime_nsec);
> @@ -462,7 +467,7 @@ static int gfs2_dinode_in(struct gfs2_inode *ip, const void *buf)
>  		return -EIO;
>  	}
>  
> -	if (gfs2_is_stuffed(ip) && inode->i_size > gfs2_max_stuffed_size(ip)) {
> +	if (gfs2_is_stuffed(ip) && size > gfs2_max_stuffed_size(ip)) {
>  		gfs2_consist_inode(ip);
>  		return -EIO;
>  	}
> @@ -707,4 +712,3 @@ const struct gfs2_glock_operations *gfs2_glops_list[] = {
>  	[LM_TYPE_QUOTA] = &gfs2_quota_glops,
>  	[LM_TYPE_JOURNAL] = &gfs2_journal_glops,
>  };
> -

