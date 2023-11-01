Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC07A28
	for <gfs2@lists.linux.dev>; Wed,  1 Nov 2023 18:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cv2Q599I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698862785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lkvNV151PqWN3htVpy2wNeUnydx+DqZAT2Vz8/icMmE=;
	b=cv2Q599I38xJKXEpdO7TUMuEt+1O8oEug4pH2L+Q6xxhI37lrQiKzlmnrIVS9lrfEzNxvh
	9YLBK8Pvf1Esyfz/Z4SvajsDL5CdADHbd3zyD7GmEAaNt4UUKUkAPVUwlIZ9XD+l4gT2dT
	LFi5XLkcNmaD04WgrtU+uBz0OyJICiY=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-yvEguT-sOdek8VsVeoNHrA-1; Wed, 01 Nov 2023 14:19:39 -0400
X-MC-Unique: yvEguT-sOdek8VsVeoNHrA-1
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-457cbda3299so36078137.1
        for <gfs2@lists.linux.dev>; Wed, 01 Nov 2023 11:19:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698862777; x=1699467577;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lkvNV151PqWN3htVpy2wNeUnydx+DqZAT2Vz8/icMmE=;
        b=T4hNXkq8ywPZpbq5y8PfMShH04jd4LtcqsK1bSE77mh4xpIy7FGNsNf8dscoMDhwl8
         2kNJd1QD4a182HkpxfFzpr2k46DL/c52BfAJ673qukMtmPSE73Dl4OwIW+PHjJFMEYna
         WRjktP5CjFcHI/M6AHysaT/MoKktSaPvSfZrX4Lpy0Igj0eFuRbc+rQ1TrYVB1JIVZSC
         DCerx329QukgS/2EjiyoghZl9OrwxN1CSbWj/z4sGQ5QZwm1otfSsFV6qUnGUv1b90qo
         ZhwmlsRXvENZ/7+lfXFYkv5MUXIztD9rNJe2U30jG1HNQCAlPoj8DQmrzoO0iP2Nugnk
         pk9g==
X-Gm-Message-State: AOJu0YxtgHCYOnFQGPop6cXWw9prMU3d8LR6mhsQ69RW0CIEO8aVmzWf
	nXM/POVjyWSRJtLrynE7i1sdq9ogK+rFt9p51jWVRsJHxwGLnea4JdxvzPtTmUQyAQ7kbm4iEq1
	ZgpyKCdcbtLU9hMRAeCdA6w==
X-Received: by 2002:a67:cf04:0:b0:457:a8fb:3251 with SMTP id y4-20020a67cf04000000b00457a8fb3251mr11799473vsl.0.1698862777032;
        Wed, 01 Nov 2023 11:19:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFT700hEZ4cQ0bpfXRy8HQoAx/z+ukl1O+IokWDHrxorE+LJCn0LyJ5VD6Y5S4+VY4CICJ7kQ==
X-Received: by 2002:a67:cf04:0:b0:457:a8fb:3251 with SMTP id y4-20020a67cf04000000b00457a8fb3251mr11799460vsl.0.1698862776757;
        Wed, 01 Nov 2023 11:19:36 -0700 (PDT)
Received: from ?IPV6:2601:883:c200:210:6ae9:ce2:24c9:b87b? ([2601:883:c200:210:6ae9:ce2:24c9:b87b])
        by smtp.gmail.com with ESMTPSA id bq11-20020a05622a1c0b00b0041950c7f6d8sm1594420qtb.60.2023.11.01.11.19.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Nov 2023 11:19:36 -0700 (PDT)
Message-ID: <c512895f-5d97-4227-9885-6948f5bbbe9b@redhat.com>
Date: Wed, 1 Nov 2023 13:19:35 -0500
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/25] gfs2: Two quota=account mode fixes
To: Andreas Gruenbacher <agruenba@redhat.com>, gfs2@lists.linux.dev
References: <20231101164615.1138692-1-agruenba@redhat.com>
 <20231101164615.1138692-11-agruenba@redhat.com>
From: Bob Peterson <rpeterso@redhat.com>
In-Reply-To: <20231101164615.1138692-11-agruenba@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/1/23 11:46 AM, Andreas Gruenbacher wrote:
> Make sure we don't skip accounting for quota changes with the
> quota=account mount option.
> 
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> ---
>   fs/gfs2/quota.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
> index 41d0232532a0..d0d01d485621 100644
> --- a/fs/gfs2/quota.c
> +++ b/fs/gfs2/quota.c
> @@ -1083,8 +1083,7 @@ int gfs2_quota_lock(struct gfs2_inode *ip, kuid_t uid, kgid_t gid)
>   	u32 x;
>   	int error;
>   
> -	if (sdp->sd_args.ar_quota != GFS2_QUOTA_ON &&
> -	    sdp->sd_args.ar_quota != GFS2_QUOTA_QUIET)
> +	if (sdp->sd_args.ar_quota == GFS2_QUOTA_OFF)
>   		return 0;
>   
>   	error = gfs2_quota_hold(ip, uid, gid);
> @@ -1285,8 +1284,7 @@ void gfs2_quota_change(struct gfs2_inode *ip, s64 change,
>   	u32 x;
>   	struct gfs2_sbd *sdp = GFS2_SB(&ip->i_inode);
>   
> -	if ((sdp->sd_args.ar_quota != GFS2_QUOTA_ON &&
> -	    sdp->sd_args.ar_quota != GFS2_QUOTA_QUIET) ||
> +	if (sdp->sd_args.ar_quota == GFS2_QUOTA_OFF ||
>   	    gfs2_assert_warn(sdp, change))
>   		return;
>   	if (ip->i_diskflags & GFS2_DIF_SYSTEM)
Hi Andreas,

This doesn't look right. I purposely avoided coding my patch as you did 
in this patch because it breaks -o quota=account. I admit I don't know 
much about "quota=account" but it's coded into gfs2 and this patch 
changes its behavior.

The way I coded it says to return if not "on" or "quiet".
With this patch it returns with "off", which means it proceeds with 
"on," "quiet," or "account."

Regards,

Bob Peterson

