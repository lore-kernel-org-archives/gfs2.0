Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B654A13CA97
	for <gfs2@lists.linux.dev>; Wed, 30 Apr 2025 07:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745997349; cv=none; b=LTCUsVWZyeXPteGGVCvA3BoS/5oPNyNuTqVdeJSzP2BJZde0V1Ev/ZLVj+jVlv00vRQgzPTi1Vl9GWjlhjIOQZ72Hsj4IAh98tM3C1fPtHIGQCr3Yzu/vKmw0s+EiRYDC3ZT93brm5tp6fk1KYwLH+GWTnM6g2QsEvSIx5QCT+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745997349; c=relaxed/simple;
	bh=x1jcpg9klYeMJELrWOWhBCuB2OelGAYpnItF46VAV0Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DExH/PO2Z7SGkPIWb82Qjsku/f9ZTNHK3pweRwD1KRPmqIxsIS8I0xMQSsFm3NnV73ia1ycpNO+2EXlHl+kAGFx+y0j49AlhUkKG8ShhcOj9GlNv72tkCoDGqlI7EkNkveEalHuNC96PBTFyjKlNdRB5Uj7jezMYTX3p/jJ62ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZOyOU8Y9; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZOyOU8Y9"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-39123ad8a9fso448624f8f.2
        for <gfs2@lists.linux.dev>; Wed, 30 Apr 2025 00:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1745997346; x=1746602146; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AXM/uiHSLcRQojb1GB9XZq3OlDQ0VXk5FBFMfENhUtI=;
        b=ZOyOU8Y9bTdijkqXeVCNhnDOraJp/PwJs5iO2SuDCw1Sh8NsFZ2BSUukt1RPXpQ46z
         njiRqUC5E97yY9TLnEuBVX0bNzcsAIRfpfgl3yBL+lRAybFx6NS5A5fkr2O16NTkJbht
         p3gpnD2s0H7mMGJLdfj0RjRjWyPmICaWh/UEs1XYBU8yB5riV+icpkRK+MGeY4aNXLY/
         RT2WzoOlOONAG55yaqyL1exlu04kWO/O/bSkwcM+KX/YXeE/d+9jyOLLKu1S0WAa8sYg
         88y3B2oG7SXjg0wzs4Yq9ybVqXnDc6Stm7ZAz6x8X+l3gkg9NM9GGYLlTQTISQUFmQG8
         ZsGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745997346; x=1746602146;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AXM/uiHSLcRQojb1GB9XZq3OlDQ0VXk5FBFMfENhUtI=;
        b=IaHf5D6al/eUaMVVsVGBLjvDKmEyzcvb6IrwBaLKKCGuPvqy0Ou522GpVJtVS1EWLc
         EwuIoymzGWoD+kwC8JnPu3jGZWRH71ChIDfCwFBxiKJdue4jGBcqBGr3VWCiqn9a8u2E
         HkcJGOk5wjvvRy9UkeYHXNdqxsLOJx3U0lTdHo6UZ6Hk/oFJhibqajbMofm84D7riPfZ
         udQK8p3NXpTkrMAGL9oojorgikP6Lbvnvq0jQKtiGO5bpddJA8POXfVineKPJgHmFYru
         J1erCP9RFQPEaWxnZtUsrkuNMzdR3YPJZW97Lo00v/bh7KWzZRrpUdBdqaSKqhkg+lWh
         t08g==
X-Gm-Message-State: AOJu0YzJutPe0JNWHTF3BHgFRt8JXrMbSnGsxM8gay8KEcTLb4OkJTxv
	ZP440cECFstXmloZKKKDlfWeH/AT/hACGqZQ9nNesRhHbWLUShENkqmK7ChvINo=
X-Gm-Gg: ASbGncsSptKCqRXgqb6YjJRYGfgSNs0a4MQlq6nClBmRaxRA6NijXm5iElHqXbaQYor
	PRsgnnD+IaKc694RqphR8/VaATn3kP8tFb0JmyfsATqVgnwhQ8chdU5YnJIThsS+UDPR05Svaw+
	hK1zJisDDIrcuYyrAFDvV4VASrTiEitA15fYEVGMtw8wZ93NrCbowGTdNpwSsEGs5G3uUyDgBIX
	sIWxh3D/pdlt6WIJLK1y6MZk0TccDSu4gNa/7fPvo8g2znNmdmXNyS2C9Uhy9IAKb2OiAXJIvVg
	5Ejmz/uvzv1t0xjr9y1tWQa452kjDpzT31icis7/wHQUeuA=
X-Google-Smtp-Source: AGHT+IEyPzOsfEnT2vzqNHormGL8OsGLQ0nvRZR1TlIu3vk7SQGXCFHBlSzyDCFtjUorQ0ZLdQFrpA==
X-Received: by 2002:a05:6000:1846:b0:39c:30d8:a44 with SMTP id ffacd0b85a97d-3a08ff5c739mr364974f8f.5.1745997346062;
        Wed, 30 Apr 2025 00:15:46 -0700 (PDT)
Received: from [10.202.112.30] ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4d77395sm114785525ad.5.2025.04.30.00.15.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Apr 2025 00:15:45 -0700 (PDT)
Message-ID: <edc1fa0f-58ea-4fc5-be2a-b83ec2270ed0@suse.com>
Date: Wed, 30 Apr 2025 15:15:43 +0800
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH dlm/next 4/4] dlm: drop SCTP Kconfig dependency
To: Alexander Aring <aahringo@redhat.com>, teigland@redhat.com
Cc: gfs2@lists.linux.dev, glass.su@suse.com, lidong.zhong@suse.com
References: <20250429202913.2908521-1-aahringo@redhat.com>
 <20250429202913.2908521-4-aahringo@redhat.com>
From: Heming Zhao <heming.zhao@suse.com>
Content-Language: en-US
In-Reply-To: <20250429202913.2908521-4-aahringo@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/30/25 04:29, Alexander Aring wrote:
> DLM does not use any exported SCTP function. SCTP is registered
> dynamically as protocol to the kernel and can be used over the right
> protocol identifiers on the socket api. We drop the SCTP dependency as
> DLM can also be used with TCP only.
> 
> Signed-off-by: Alexander Aring <aahringo@redhat.com>

Reviewed-by: Heming zhao <heming.zhao@suse.com>

> ---
>   fs/dlm/Kconfig | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/fs/dlm/Kconfig b/fs/dlm/Kconfig
> index f82a4952769d..b46165df5a91 100644
> --- a/fs/dlm/Kconfig
> +++ b/fs/dlm/Kconfig
> @@ -3,7 +3,6 @@ menuconfig DLM
>   	tristate "Distributed Lock Manager (DLM)"
>   	depends on INET
>   	depends on SYSFS && CONFIGFS_FS && (IPV6 || IPV6=n)
> -	select IP_SCTP
>   	help
>   	A general purpose distributed lock manager for kernel or userspace
>   	applications.

