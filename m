Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FDA1CFB6
	for <gfs2@lists.linux.dev>; Thu,  2 Nov 2023 19:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TDv19/SB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698951959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZOb3cN0261e51Lyi7UdrZ4gHVTUZsTyGnmgymIT690U=;
	b=TDv19/SBFUQVd8bGbMO6zQE0sPFZ588CXv6kwzBKCkQynEJnIHSuVnl4bYHN/3xbAmN+ko
	bpFaa9tjqQTFC1wdj06zJWKXsi0TxEDeoLhOsJxBUKvQx54g2l/ZHw5li9d1VVeOaGzYp7
	8WJhZPrIk05Zzkxj8vT+2VSCKmmHHDw=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-386-OR-ANWR1NiOX4_3ED7E4BQ-1; Thu, 02 Nov 2023 15:05:58 -0400
X-MC-Unique: OR-ANWR1NiOX4_3ED7E4BQ-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-66d155fc53eso15290796d6.1
        for <gfs2@lists.linux.dev>; Thu, 02 Nov 2023 12:05:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698951957; x=1699556757;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZOb3cN0261e51Lyi7UdrZ4gHVTUZsTyGnmgymIT690U=;
        b=vdgp3Xx4AKbIi1wooOFVp7f/JinsMxHJe0qeJHJBX3Ym6RZ5uxsyvV5aCdBHF2BmfA
         asUVpKLDSZNbGq+n3DXs2irVU14h0qZNhFcIpHQVXtzHdpXjmrLNLdTuKN9jWWAQVfmH
         nZm7xkisHlkNCi73bkJlEiUAk4yp/UHqGh/USJr/Ynry5bI8b6pLnVPMTZhh/6A6XNKy
         yeqShRx8UCf81vIxR9YJWHoEx6SC5Wz0NTttaopeXgz2uF1/0jw/G9EaHvXOr2hxYddA
         dljAcfXyjem7ercxKC2sjN8o6zdjjrHo4IP3eAQBPPeZYB+oZl+bIbuadNyVQ7/F0pPJ
         NBdQ==
X-Gm-Message-State: AOJu0Yxe4jdouT8IynvlPOxZxEo4A201b3Cci4oCU1gBjhSMqbvOCDVl
	CbKUhVggW/UQ0jI7Sade/GzxgNbe+Ed7PAjHr1/9fxgcvvvvmPgcK7vM/eYlRQXrsT6nRSRIszm
	Zd/DiVGr6+oBFYQ==
X-Received: by 2002:a05:6214:2a48:b0:66f:bc4b:2246 with SMTP id jf8-20020a0562142a4800b0066fbc4b2246mr24034580qvb.51.1698951957818;
        Thu, 02 Nov 2023 12:05:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdtwXGcNgMebSSCdtDOp+Y4MXNDfdOnskgc1LdUOnwMkil+z6d9R+pUzQus0DH0BDRy3qBkA==
X-Received: by 2002:a05:6214:2a48:b0:66f:bc4b:2246 with SMTP id jf8-20020a0562142a4800b0066fbc4b2246mr24034563qvb.51.1698951957577;
        Thu, 02 Nov 2023 12:05:57 -0700 (PDT)
Received: from ?IPV6:2601:883:c200:210:6ae9:ce2:24c9:b87b? ([2601:883:c200:210:6ae9:ce2:24c9:b87b])
        by smtp.gmail.com with ESMTPSA id br14-20020a05622a1e0e00b0041e28dc9e6fsm10663qtb.70.2023.11.02.12.05.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Nov 2023 12:05:57 -0700 (PDT)
Message-ID: <6300c3e9-0d11-444d-a4bc-b3d3210df74f@redhat.com>
Date: Thu, 2 Nov 2023 14:05:54 -0500
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/25] gfs2: Two quota=account mode fixes
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: gfs2@lists.linux.dev
References: <20231101164615.1138692-1-agruenba@redhat.com>
 <20231101164615.1138692-11-agruenba@redhat.com>
 <c512895f-5d97-4227-9885-6948f5bbbe9b@redhat.com>
 <CAHc6FU4Tz-M7uYaKy3vw9ycrqOiS6B_cHys0=txNvTHc3P+JZg@mail.gmail.com>
 <9831e5bf-ee77-480e-98a6-68a852911ab2@redhat.com>
 <CAHc6FU4-yzaQOGGVj5G5CZmPV=hh9mk3YpdJgpWReW54VTioww@mail.gmail.com>
From: Bob Peterson <rpeterso@redhat.com>
In-Reply-To: <CAHc6FU4-yzaQOGGVj5G5CZmPV=hh9mk3YpdJgpWReW54VTioww@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/2/23 1:08 PM, Andreas Gruenbacher wrote:
> I'm inclined to add the following functionality-preserving change for
> clarity, but other than that, this seems to fix the implementation of
> quota=account mode. The testing I've done seems to confirm that. This
> has probably been broken in one way or another since the day of the
> gfs2 merge, so it's obviously not that big a deal.
> 
> @@ -50,8 +50,7 @@ static inline int gfs2_quota_lock_check(struct gfs2_inode *ip,
>          ret = gfs2_quota_lock(ip, NO_UID_QUOTA_CHANGE, NO_GID_QUOTA_CHANGE);
>          if (ret)
>                  return ret;
> -       if (sdp->sd_args.ar_quota != GFS2_QUOTA_ON &&
> -           sdp->sd_args.ar_quota != GFS2_QUOTA_QUIET)
> +       if (sdp->sd_args.ar_quota == GFS2_QUOTA_ACCOUNT)
>                  return 0;
>          ret = gfs2_quota_check(ip, ip->i_inode.i_uid, ip->i_inode.i_gid, ap);
>          if (ret)
> 
> Thanks,
> Andreas
> 
Yes, that looks good. You can add my Reviewed-by:
I agree it's probably been broken for a long time.

Regards,

Bob Peterson

