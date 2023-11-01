Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7FA17758
	for <gfs2@lists.linux.dev>; Wed,  1 Nov 2023 17:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KLrbKTFH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698859958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nyu7HF3UflsOZglFrCjM4lQ4i04fMoibl8Of3lm+pII=;
	b=KLrbKTFHryTYlu+FdvYtj9/MJdYOP7GwtsDCpZsFU8WLNZmmBG7q+Ytn2d/YJbI6uY6uJp
	KE8oOsRkVBD78fp/R4drrs24XYCtmtHFxgtBkE9bAgYP1G0fPuFGaBv09tet1HG5LtPWzw
	9t05+GkwCR9ckTg+hIDdXWCbAh3ju9k=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-IYPHi-pHO-G0ukLPVchRfg-1; Wed, 01 Nov 2023 13:32:35 -0400
X-MC-Unique: IYPHi-pHO-G0ukLPVchRfg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40837aa4a58so530265e9.0
        for <gfs2@lists.linux.dev>; Wed, 01 Nov 2023 10:32:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698859954; x=1699464754;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nyu7HF3UflsOZglFrCjM4lQ4i04fMoibl8Of3lm+pII=;
        b=ax5xYkwvm6Xzhdt1hLzsORC+EkdyQZ2mW8ZwIT9TsESf4VtScRxtQR+2ow1Z1hM/2u
         646KtG6WBGMWDXAMkoBkF7Azyc+wCt3CH9jUlHZeRazSEjhogNULQF8SbVct8ZBCta0/
         oeVcGMrfbgMiawoKVf7eUV9ZQO7D6WjXrf01jv8NFyGnRMDFLDtSA7fkMBfLQwjDZez7
         LApSFwac533rzyGVL5d3Hn27n52PptFwDuvp8HnhHvdaflqHkEqHicQwXlo8pz1yERyW
         D4QGZJqYEkk8sIxT8AzVM67bkcazppuFepOS/DuRHiN4tAAhT6MtEtkP8A7QfEoLJ/g9
         pLhQ==
X-Gm-Message-State: AOJu0YxPqUAclcGQEWbkoB+Ny2A0bmrhZVTGql+DNykIV0gQbzWvgfS1
	aDKGaCkD0VXjgfNgs6rvraMJIM/gLaw7dtDvRp/iGNNFDemgDjSOaEAjJ9h3oYf5dRcbiz00VQ4
	7kW45m9TQ1noS9g==
X-Received: by 2002:a05:600c:6021:b0:406:5a14:5c1e with SMTP id az33-20020a05600c602100b004065a145c1emr3844036wmb.1.1698859954624;
        Wed, 01 Nov 2023 10:32:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHu3AiKroVntUnzHgFnVXA6JwkthaFvDJoy8UZdpSLrihVkaFaTpP4pAxvvBVNasp26QrHBKQ==
X-Received: by 2002:a05:600c:6021:b0:406:5a14:5c1e with SMTP id az33-20020a05600c602100b004065a145c1emr3844018wmb.1.1698859954309;
        Wed, 01 Nov 2023 10:32:34 -0700 (PDT)
Received: from [192.168.1.165] (cpc76484-cwma10-2-0-cust967.7-3.cable.virginm.net. [82.31.203.200])
        by smtp.gmail.com with ESMTPSA id q10-20020a05600c46ca00b00407efbc4361sm404847wmo.9.2023.11.01.10.32.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Nov 2023 10:32:28 -0700 (PDT)
Message-ID: <4f8bdeaa-4376-48aa-8ecd-f6c0f327f743@redhat.com>
Date: Wed, 1 Nov 2023 17:32:24 +0000
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/25] gfs2: Stop using GFS2_BASIC_BLOCK and
 GFS2_BASIC_BLOCK_SHIFT
To: Andreas Gruenbacher <agruenba@redhat.com>
References: <20231101164615.1138692-1-agruenba@redhat.com>
 <20231101164615.1138692-10-agruenba@redhat.com>
Cc: gfs2@lists.linux.dev
From: Andrew Price <anprice@redhat.com>
In-Reply-To: <20231101164615.1138692-10-agruenba@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/11/2023 16:45, Andreas Gruenbacher wrote:
> Header gfs2_ondisk.h defines GFS2_BASIC_BLOCK and GFS2_BASIC_BLOCK_SHIFT
> in a misguided attempt to abstract away the fact that sectors on block
> devices are 512 or (1 << 9) bytes in size.  Stop using those definitions.
> 
> I would be inclinded to remove those definitions altogether, but the
> gfs2 user-space tools are using them.

The latest gfs2-utils has its own copy of the header so removing them 
wouldn't break the latest version, but it would break building older 
versions (e.g. for bisecting). We have historically taken a "no symbol 
removals from the uapi header" approach, just in case, too.

That said, I'll look into where gfs2-utils uses them as an area for 
potential cleanup.

Cheers,
Andy

(P.S. I've scanned through the 25 patches; no concerns to report.)

> In addition, instead of GFS2_SB(inode)->sd_sb.sb_bsize_shift, simply use
> inode->i_blkbits.
> 
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> Cc: Andrew Price <anprice@redhat.com>
> ---
>   fs/gfs2/inode.h      | 8 +++-----
>   fs/gfs2/ops_fstype.c | 8 +++-----
>   2 files changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/gfs2/inode.h b/fs/gfs2/inode.h
> index c8c5814e7295..908c739220b8 100644
> --- a/fs/gfs2/inode.h
> +++ b/fs/gfs2/inode.h
> @@ -44,19 +44,17 @@ static inline int gfs2_is_dir(const struct gfs2_inode *ip)
>   
>   static inline void gfs2_set_inode_blocks(struct inode *inode, u64 blocks)
>   {
> -	inode->i_blocks = blocks <<
> -		(GFS2_SB(inode)->sd_sb.sb_bsize_shift - GFS2_BASIC_BLOCK_SHIFT);
> +	inode->i_blocks = blocks << (inode->i_blkbits - 9);
>   }
>   
>   static inline u64 gfs2_get_inode_blocks(const struct inode *inode)
>   {
> -	return inode->i_blocks >>
> -		(GFS2_SB(inode)->sd_sb.sb_bsize_shift - GFS2_BASIC_BLOCK_SHIFT);
> +	return inode->i_blocks >> (inode->i_blkbits - 9);
>   }
>   
>   static inline void gfs2_add_inode_blocks(struct inode *inode, s64 change)
>   {
> -	change <<= inode->i_blkbits - GFS2_BASIC_BLOCK_SHIFT;
> +	change <<= inode->i_blkbits - 9;
>   	gfs2_assert(GFS2_SB(inode), (change >= 0 || inode->i_blocks >= -change));
>   	inode->i_blocks += change;
>   }
> diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
> index 33ca04733e93..ecca978419e8 100644
> --- a/fs/gfs2/ops_fstype.c
> +++ b/fs/gfs2/ops_fstype.c
> @@ -292,8 +292,7 @@ static int gfs2_read_sb(struct gfs2_sbd *sdp, int silent)
>   		return error;
>   	}
>   
> -	sdp->sd_fsb2bb_shift = sdp->sd_sb.sb_bsize_shift -
> -			       GFS2_BASIC_BLOCK_SHIFT;
> +	sdp->sd_fsb2bb_shift = sdp->sd_sb.sb_bsize_shift - 9;
>   	sdp->sd_fsb2bb = BIT(sdp->sd_fsb2bb_shift);
>   	sdp->sd_diptrs = (sdp->sd_sb.sb_bsize -
>   			  sizeof(struct gfs2_dinode)) / sizeof(u64);
> @@ -1190,10 +1189,9 @@ static int gfs2_fill_super(struct super_block *sb, struct fs_context *fc)
>   
>   	/* Set up the buffer cache and fill in some fake block size values
>   	   to allow us to read-in the on-disk superblock. */
> -	sdp->sd_sb.sb_bsize = sb_min_blocksize(sb, GFS2_BASIC_BLOCK);
> +	sdp->sd_sb.sb_bsize = sb_min_blocksize(sb, 512);
>   	sdp->sd_sb.sb_bsize_shift = sb->s_blocksize_bits;
> -	sdp->sd_fsb2bb_shift = sdp->sd_sb.sb_bsize_shift -
> -                               GFS2_BASIC_BLOCK_SHIFT;
> +	sdp->sd_fsb2bb_shift = sdp->sd_sb.sb_bsize_shift - 9;
>   	sdp->sd_fsb2bb = BIT(sdp->sd_fsb2bb_shift);
>   
>   	sdp->sd_tune.gt_logd_secs = sdp->sd_args.ar_commit;

