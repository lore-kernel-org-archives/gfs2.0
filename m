Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76AC18E20
	for <gfs2@lists.linux.dev>; Fri, 20 Jun 2025 17:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750441130; cv=none; b=gNCOjW68p6rQnsV116n1kKjbkWpDVomUeQI81Kxt/UiVpK1FDMFm4CJ07nn1BGC6GDFFu29YhqjCiSutM4jArUkyIGojH1f9GeLPTrlHLKnyH8qik5mETB7pLh57iq22VFTyECv3pvLTQ5LrIpsNVgNKLA1QFW2dUbHSF8GFz7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750441130; c=relaxed/simple;
	bh=lqEhx3Tq9ef6EiQT7yhsgJN26gh6j2b8+Vw+neK46lo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ZfTDRc0g5DuM3Mc0fpuyrdAmV3HjJ9qfT+Xh2AkqOLWFFiG1NoqfNMQMPKRGGelypoUPAiDQukMoZmmGO2DxtkQHk9INswgK33rEDecX0Ug2FFSWViWDx+d0PIKAjR+gpxeWczyiWynGzCATEZOfyO4I6A1wj6xNvu/cngaV2Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hnbw2smk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hnbw2smk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750441127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JD47MP/D35rJlJK+W0fohHkbJdlRqA+G8YCEoRCkt9E=;
	b=Hnbw2smkvmNN2WFgY8AXejosFLq6nmUSoNYrJV+Jn7oroxpPNpNE3ee+gCJKgasC3ZLGWx
	VBFnrpE5MclvP7BuRRr5VksFr652k//m61wk9wTJjCifHKAy2iRz88wMlhXh8L12lYNHU7
	DTCCyx3YG0y/cT9vXi9Ebfz/eH4Gmn4=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-e0CX2MiXM5-5UcjTnyILlA-1; Fri, 20 Jun 2025 13:38:46 -0400
X-MC-Unique: e0CX2MiXM5-5UcjTnyILlA-1
X-Mimecast-MFC-AGG-ID: e0CX2MiXM5-5UcjTnyILlA_1750441125
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b2eeff19115so2671795a12.0
        for <gfs2@lists.linux.dev>; Fri, 20 Jun 2025 10:38:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750441125; x=1751045925;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JD47MP/D35rJlJK+W0fohHkbJdlRqA+G8YCEoRCkt9E=;
        b=Ej8UCrbiAvoufiXJ+GhltO+HnGARVR9DbwQ+Ge4wliQHomFCwjNFIzaUX6SFDXnjFQ
         xLQ1kVNC/FL7CeLlafY7muWhOEv8uTfX658kJJdsCYyCiexRCYsIdQIsVoaPYeJjGW4I
         Ch0Bt6bhrMqtaEooLXwCFYY6OOV7Ttm5In+LUnSpSYKCsCl/iFUfRzqiOcgEPpBrKi6P
         fzM6+yTy/DTiSt8g5jbrAeeBEdoSLyp2glwXJqr1c5ohpXQ1y72HKX4dXO0nmHeSItfw
         IT6bm9VNh4tZS3KzxbtTtufUeWDDXGC9x89L34ZEOvA0mopAp/jhLTIcjc+/S6YfZltr
         D+GA==
X-Forwarded-Encrypted: i=1; AJvYcCUSwOGKCd66v6r/e2w+lnMIl9WQMDu5On6jNO6U+FBM/D8dYKV2tH/9W4u01o5o36rkEsMR@lists.linux.dev
X-Gm-Message-State: AOJu0YxFM8BwvwPRX9RyP/uRitYABG6aNEL6fqJgdRaDnMdasgVVyo4n
	jVvLIPyZEPTCFTwi+N9vDxz+P67LfaYC/mCZXKuYaLw+qP7JYC7oxMBfhB+mhKw2aX+vbJ0Vowk
	DqYV+RLjaKqe2PVy+/Fp4HCWJnW1IKrtsELXKkfUn0zcunHAGD68ZjWC4ZsfOVxA=
X-Gm-Gg: ASbGncv8hB5YFB/gOjAaR/SpzQAAgxrd1NQZbnok8PiPOgM30uPrWcnYwdGCw0Br7lA
	2SZ2S88IkOQotoZP8gxf0n/NMfI0WQsdV4k9qMTZNf2Pwj1ZLf0mw4Re7ekpAdd2mo8gDnnCrWV
	lJvxP30aOMkVZwdKqd07N9xSCvtrV16QcZTlriMFrD7FB6TjQzT8+KpLWjgdEIY504AT1jbb2Ui
	toSe+jsDYalbYUSKccZxIVY4ssjWg0zPjhsgpvqceUVfkOkILgix8tnTHr22z0r4z7MY1HRvlGS
	J1zKhUE/y3mv5nnSkfUVGvNl2AhiGl8QV+sbIMAXaqxlGVpvN1KoocI8gEoEXeE=
X-Received: by 2002:a05:6a20:3d85:b0:215:e60b:3bd3 with SMTP id adf61e73a8af0-22026efe3f9mr7315809637.29.1750441125094;
        Fri, 20 Jun 2025 10:38:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwH5975YRUAMegPcfvcHN9wY4KebcZODQS2JViA9DaMRD9UKcgm5r8yqrteNswGViEEnJNQA==
X-Received: by 2002:a05:6a20:3d85:b0:215:e60b:3bd3 with SMTP id adf61e73a8af0-22026efe3f9mr7315774637.29.1750441124730;
        Fri, 20 Jun 2025 10:38:44 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b31f12587fbsm2111744a12.62.2025.06.20.10.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 10:38:44 -0700 (PDT)
Date: Sat, 21 Jun 2025 01:38:39 +0800
From: Zorro Lang <zlang@redhat.com>
To: Su Yue <glass.su@suse.com>
Cc: fstests@vger.kernel.org, l@damenly.org, gfs2@lists.linux.dev
Subject: Re: [PATCH] common/quota: adjust _qmount_option for gfs2
Message-ID: <20250620173839.q735lweoglone5cp@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250603041009.59811-1-glass.su@suse.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250603041009.59811-1-glass.su@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: X4i9xeImc1Tdo6vwL7-Q2FPXzhz_1t7yOn4UmZGdM_E_1750441125
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 03, 2025 at 12:10:09PM +0800, Su Yue wrote:
> gfs2 supports mount options 'quota=[off/account/quiet/on]' but
> 'usrquota' and 'grpquota' are unsupported.
> So in _qmount_option, transform $OPTS to 'quota=on' first.
> 
> Signed-off-by: Su Yue <glass.su@suse.com>
> ---
>  common/quota | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/common/quota b/common/quota
> index a51386b1dd24..4b8052e07dde 100644
> --- a/common/quota
> +++ b/common/quota
> @@ -283,6 +283,12 @@ _qmount_option()
>  {
>  	OPTS=$1
>  
> +	if [[ "$FSTYP" == gfs2 ]]; then
> +		OPTS=`echo $OPTS \
> +		| sed   -e 's/usrquota/quota=on/g' \
> +			-e 's/grpquota/quota=on/g'`
> +	fi

There's not response from gfs list. I'm not familiar with gfs2, so I have to
ask some questions about your patch...

From the manual of gfs2:
  quota=[off/account/on]
  Turns quotas on or off for a filesystem. Setting the quotas to be in the "account" state causes the per UID/GID usage statistics to be correctly maintained by the filesystem, limit and warn values are ignored. The default value is "off".

Looks like there's only one mount option "quota=..." for gfs2. And I didn't
find a description about project quota, so
1. What will gfs2 do if there's a "prjquota" or "pquota"?
2. Do you need to replace "noquota" with "quota=off"?
3. And "quota" to "quota=on" ?
4. Have you tried your patch on gfs2, can all quota related generic cases pass/notrun
   on gfs2?

BTW, in this function you can see:
        # ext4 doesn't _do_ "-o pquota/prjquota" because reasons
        # Switch it to "quota" to enable mkfs-time pquota
        if [[ "$FSTYP" == ext[234] ]]; then
                OPTS=`echo $OPTS \
                | sed   -e 's/\bpquota/quota/g' \
                        -e 's/prjquota/quota/g'`
        # ocfs2 doesn't support "-o projquota"
        elif [[ "$FSTYP" == ocfs2 ]]; then
                OPTS=`echo $OPTS | sed -e 's/prjquota//g'`
        fi

please move your gfs2 specific codes here ^^, and give it enough comments.

> +
>  	# Replace any user defined quota options
>  	# with the quota option that we want.
>  	# Simplest to do this rather than delete existing ones first because
> @@ -300,6 +306,7 @@ _qmount_option()
>  		-e 's/\bpquota/QUOTA/g'    \
>  		-e 's/prjquota/QUOTA/g'    \
>  		-e 's/noquota/QUOTA/g'     \
> +		-e 's/quota=[^, ]*/QUOTA/g' \

I think you might need a word boundary, e.g. "\bquota=..."

Thanks,
Zorro

>  		-e 's/quota/QUOTA/g'       \
>  		-e 's/uqnoenforce/QUOTA/g' \
>  		-e 's/gqnoenforce/QUOTA/g' \
> -- 
> 2.48.1
> 
> 

