Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE962147EA
	for <gfs2@lists.linux.dev>; Thu, 24 Apr 2025 12:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745496525; cv=none; b=OkMxxT9HizaKJ6ehVi9w+3HuC6HmqTCIVDrrLyYp0p4cSOJEE4VLtWg2k81TZZUIS2jBl9q5Vag6L8MsW6zzS2j+e0372yvBxp8dRWyQrJUp8QPL3C0jpfh0pM4lPasLuGmaSN/lSJ5iRWS/euPN4eqlDPEFH1WO6VZWHsGkTjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745496525; c=relaxed/simple;
	bh=riKBxCMa3TXEufx7N0V3A1ztqyyIIrklchkK2hx520M=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=SsrYkl23c5az9QYZ2YVgfrzZNq9SQehDBm+VIJlINjMMvKLSlZccrj/dgoXoJU9nqsePmTpph8QRyHb7LJ1RqXm53HrJii4hH/UXArH5MC5Ykp81mxpo0Ii3tk8hfwQi7hUxh9BXXIpPgbiYSonFXYdJDzpU0i9HwOHXASJF2H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U22y10YA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U22y10YA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745496522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OQJAOgjSijdH8q+PLtVdmnGnZJKEdp8GSZiELold8/M=;
	b=U22y10YAVzLu1rx3KX2gqX5Tde3IRVhaCwj+Kchj75R8u7W3R7v8hjF1BKK480efhVDV/0
	0fP4DAjVrSZMOEpU4ZbJPRYYfAMYRRESuwvEprXm1CjyJo+RSLiru4DSz87x8ldKT0y6NE
	T5f2BiiqDobwvBQVOuCkhUB8RzRiFTA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-2ddTJcnCNAyJin6ED2-eyQ-1; Thu, 24 Apr 2025 08:08:40 -0400
X-MC-Unique: 2ddTJcnCNAyJin6ED2-eyQ-1
X-Mimecast-MFC-AGG-ID: 2ddTJcnCNAyJin6ED2-eyQ_1745496519
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3913aaf1e32so426852f8f.0
        for <gfs2@lists.linux.dev>; Thu, 24 Apr 2025 05:08:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745496519; x=1746101319;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OQJAOgjSijdH8q+PLtVdmnGnZJKEdp8GSZiELold8/M=;
        b=FFfDGa/G+efk+l4umcwiA9wo+KiMaWA5OjFMiwEs4RHvAI9xoEvYHso7UWD37kw+uE
         smNzd5lWl92bBD6Cj3l0TJXL8s3AGT3ExBnL5yXP6+O9n1z+P8rRX62b/bO6SCdzQGW6
         Qj6PhAloiEiOxZveEcKk//DP0Li/6QRuIU1SnvVMI5yO5I3boGE4nYBwDpV0xyCjJp14
         yvWnP0EVLhhjrmqohHSiIg5dpUn1hqwPPb+KcaKUxzs7vTUcmU4i0+Il6bn5HeZhMVUc
         Huki4mn/DoLjq+p9tCj5Pwplq/gCPmgi7dC6gkZ5bTdKFqQOMvunsLBZLy2+YKzG/8xA
         KMcQ==
X-Gm-Message-State: AOJu0YwpTQhEyYGTjZfyJy5eQwXWIJzjEyfjXhUcqN6S04g4W/Ko7ZV+
	oQqYooKYXqwSs17R3wFZ6JVaEIYOxn98Wn4CESMjd6PZgoNfhJxrkYrEGnpBf0eckDb8Y9T2STc
	It6B4EQSlhJv3S7psBKyvTs3jRfH9lGectHQRIQwckS2lt5h6lAs=
X-Gm-Gg: ASbGncvTUORtxbHHhGU0iKnCdrEKWoQCk3vcHEA/P1UZzENbOdvHnjNDGgzwtrsXkVI
	HTcrotZuQaSoU+dWkkTlXWNiZyxERIivh1kLWSC9qqbfzSiJ5MOnaGb7LLnnXPOnmOuoxW/1XzS
	fIgpQVRM2GMhb9aDsDnzsUBLI+aWla+vNHAzhW61tEsAVHvcNy0wwsStvu8Aqwdt2slN4l07BrK
	Tl8sOoMGxAXuiNqJm4uM7jrn5TlQ1ZfJSJvkuSqA4yrIeq5Ur6rITxaSd1gb3nXy6zYBOCiUteP
	THKLqQGo554CkUBH//QR6SrDenO/G0Cb/eEVa3A7hlS8OZFfzCOynWvvfek2n7rG/YNU768=
X-Received: by 2002:a05:6000:420c:b0:391:2932:e67b with SMTP id ffacd0b85a97d-3a06cf639abmr1799046f8f.35.1745496519481;
        Thu, 24 Apr 2025 05:08:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3Miu04m7FtRfb+BQvMSkE70IfLDMTYy4ogQJc2vcsVNUADU1m8/exPPRN+p4IdxlLyvpJAQ==
X-Received: by 2002:a05:6000:420c:b0:391:2932:e67b with SMTP id ffacd0b85a97d-3a06cf639abmr1799023f8f.35.1745496519050;
        Thu, 24 Apr 2025 05:08:39 -0700 (PDT)
Received: from [192.168.1.167] (cpc76484-cwma10-2-0-cust967.7-3.cable.virginm.net. [82.31.203.200])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a06d4c30edsm1853528f8f.43.2025.04.24.05.08.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Apr 2025 05:08:38 -0700 (PDT)
Message-ID: <e3af30f8-f777-487a-a0b1-9b2ac3bd546d@redhat.com>
Date: Thu, 24 Apr 2025 13:08:37 +0100
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] gfs2: deallocate inodes in gfs2_create_inode
To: Andreas Gruenbacher <agruenba@redhat.com>
References: <20250423162717.1234285-1-agruenba@redhat.com>
Cc: gfs2@lists.linux.dev
From: Andrew Price <anprice@redhat.com>
In-Reply-To: <20250423162717.1234285-1-agruenba@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CQW5T7qERyyeutNdeg4lNDehNdyMvU2ppttLnlxsJPE_1745496519
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23/04/2025 17:27, Andreas Gruenbacher wrote:
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
> longer see partially created inodes, and so some simplifications are
> possible there.
> 
> Fixes: f1046a472b70 ("gfs2: gl_object races fix")
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> ---
>   fs/gfs2/inode.c | 23 +++++++++++++++--------
>   fs/gfs2/super.c |  8 ++------
>   fs/gfs2/super.h |  2 ++
>   3 files changed, 19 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
> index 0b2d75106b1c..95c39798901b 100644
> --- a/fs/gfs2/inode.c
> +++ b/fs/gfs2/inode.c
> @@ -697,10 +697,11 @@ static int gfs2_create_inode(struct inode *dir, struct dentry *dentry,
>   	struct gfs2_inode *dip = GFS2_I(dir), *ip;
>   	struct gfs2_sbd *sdp = GFS2_SB(&dip->i_inode);
>   	struct gfs2_glock *io_gl;
> -	int error;
> +	int error, error2;
>   	u32 aflags = 0;
>   	unsigned blocks = 1;
>   	struct gfs2_diradd da = { .bh = NULL, .save_loc = 1, };
> +	bool xattr_initialized = false;

This variable isn't used in this version.

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
> +	clear_nlink(inode);
> +	mark_inode_dirty(inode);
> +	error2 = evict_unlinked_inode(inode);

So we're switching to only checking ip->i_eattr and calling 
gfs2_ea_dealloc() indirectly with the initialized argument always true. 
I don't think that's right as ip->i_eattr gets set much earlier than the 
gfs2_init_xattr() call.

Andy

> +	if (error2)
> +		fs_warn(sdp, "%s: %d\n", __func__, error2);
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
> index e25a24ae2197..c154fc209816 100644
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
> @@ -1301,7 +1297,7 @@ static enum evict_behavior evict_should_delete(struct inode *inode,
>    * evict_unlinked_inode - delete the pieces of an unlinked evicted inode
>    * @inode: The inode to evict
>    */
> -static int evict_unlinked_inode(struct inode *inode)
> +int evict_unlinked_inode(struct inode *inode)
>   {
>   	struct gfs2_inode *ip = GFS2_I(inode);
>   	int ret;
> @@ -1314,7 +1310,7 @@ static int evict_unlinked_inode(struct inode *inode)
>   	}
>   
>   	if (ip->i_eattr) {
> -		ret = gfs2_ea_dealloc(ip, !test_bit(GIF_ALLOC_FAILED, &ip->i_flags));
> +		ret = gfs2_ea_dealloc(ip, true);
>   		if (ret)
>   			goto out;
>   	}
> diff --git a/fs/gfs2/super.h b/fs/gfs2/super.h
> index b27a774d9580..46f32f66082b 100644
> --- a/fs/gfs2/super.h
> +++ b/fs/gfs2/super.h
> @@ -15,6 +15,8 @@
>   #define GFS2_FS_FORMAT_MIN (1801)
>   #define GFS2_FS_FORMAT_MAX (1802)
>   
> +int evict_unlinked_inode(struct inode *inode);
> +
>   void gfs2_lm_unmount(struct gfs2_sbd *sdp);
>   
>   static inline unsigned int gfs2_jindex_size(struct gfs2_sbd *sdp)

