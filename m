Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4D87E107
	for <gfs2@lists.linux.dev>; Wed, 30 Apr 2025 07:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745997346; cv=none; b=C3uxWCqXqssLRC0bPdAFPDTDeOn9lAwVcleRAYHq2WwHZrPHQ6MoVxiXcvj3tNCwwjZWdmYa09iPfUYNeCVCDViBacVF/5veboZeYqY0DWsOSaggklxk1qCgVfru+Sz0aEnaYUbgrv/QiyqEAaN49X+XCITRXHhc5dFoUy3wnqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745997346; c=relaxed/simple;
	bh=q5mewFHgD6ewqkMwkfs6kFpnfqK/6j7OvCVyxKLHRHs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t+nr4WlnZ1VF8IOp0EwI46tKz3r1WzPU/29hkPfxNEiF03h/Vbp0prBqoto9IvpQcIo47yNqPVixwQoUsovyQ0YfqiWCNnEa6r5dG081MECLDgcuTQOh5L/2ibNDmUOhqOcovtBd0BEWiZO7/k6C86CyCM3DDMlo/kEXQo1GWEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Ep9qjdSg; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Ep9qjdSg"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-440668acbf3so9385965e9.0
        for <gfs2@lists.linux.dev>; Wed, 30 Apr 2025 00:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1745997343; x=1746602143; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8U7Bpoqu0mtahKU2z6nyeMLr9R6D8MnsR5hdgo7wmeY=;
        b=Ep9qjdSgX+TtlV8f38qau6UNbP334fl0bWSfvB+J0RxR0u5YaAqIOpyyeST/bM4QPO
         95mcev3J+kWNRY9soo4zpAqaiCtJbVDyePKI/9i/pPFZ1l4A+t5UbN9AcrlSGk55bOp1
         eYlfSY6fySVg/d6aF3dCd+uWzXXkJyXNdgd8NtqhBEdeRXRuoK6kW8hNhLGY2WHAhqS6
         T7LcznHXxjgUZezcJMExDAdGM37fFiEiXzrDsDGBWubOJyY/giCNZyXbab+DdSXnq486
         CEngPRxNkfTz3ZjjAQOUs/EV6JWzxps27YmoNWGGwt95vr3Oyd+eQkckYXof7/zLNAjE
         OCuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745997343; x=1746602143;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8U7Bpoqu0mtahKU2z6nyeMLr9R6D8MnsR5hdgo7wmeY=;
        b=mvTPcQDU6D+VmSz2+LiZTixISDxQk9ZN/0Hpp4NgwCj6PHxZv8tPbrWA8SuwYmMx7k
         Ou5pKaZFdrsoJdCFjcKZkxRaR7iqmFdncYPYdKR0L6U6URcxCZnGxp7XcpcLK8vhlyTg
         CzY1dSxIepU0JVrCinvFc5PgxteB+XQkP07zXQ5PStoBiO08RxZ/s0Plo6zEmK8KS2sR
         /zfLjzRyC2jW1RuOG7rSbjm6c+HDLKQ3gQvNnKBIaSSsD5sSxZ4sl2JScUv3S1l7Xq8H
         U3hhFx5o6qgAVscOMSsCBPKGcgSv2FE8Zmo63+cu1BCeTxL6I3mQfYVNSnj1fvrzy5dO
         YxzQ==
X-Gm-Message-State: AOJu0Yz542U8lG4QXpjRW6ziz3O/tUx+WnlD+u88r6sPptWUjlGk88P+
	j53nrA7+W1vY4/xAp8paCT5YUQ0BBm3E9SOuQvsAvUghE6ks6iKRAKr0nAPV45A=
X-Gm-Gg: ASbGncuqTTH/aCy/lY1n4pTjLg1+Rzlx7I5/icDMWcdTDqaCn7Nk2CyA7ZsYm2fLNbD
	zuM9QP4wzXPozYArqbpKmUM44I0QIIxBseWMRX/om3IeOZpoLyLatYST1Irsp/DRka7dBbz15FP
	2AMoctZ5dWiebSwUU0TKcV3VasvNXp++daIigSxxP879PWA7xqllezCqsUhORN2uNAPkwIKSO6C
	/hChtOwnS9odlI620khKDU+lRXskKLd4LXvUSxNzDOcRGyuEBORU8YhS59v8RGr27aZQq8l366i
	kUzVrHN3Pr/97jTAmT8wI2Y0ZtFy99cyA9OcryLohP4+jBGtf+y4DFNJPg==
X-Google-Smtp-Source: AGHT+IFkStHObZZv7LnrT9J62bNO4tZYve4Brcye7zZefk4SjVHcZ+7IY0H6cWK8ErKPL/rTRmAE5w==
X-Received: by 2002:a05:6000:2504:b0:3a0:75ff:2d94 with SMTP id ffacd0b85a97d-3a08ff58062mr366750f8f.1.1745997342794;
        Wed, 30 Apr 2025 00:15:42 -0700 (PDT)
Received: from [10.202.112.30] ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4d77395sm114785525ad.5.2025.04.30.00.15.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Apr 2025 00:15:42 -0700 (PDT)
Message-ID: <d5891b63-a939-41e0-88d2-7d74b12a9025@suse.com>
Date: Wed, 30 Apr 2025 15:15:40 +0800
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH dlm/next 3/4] dlm: reject SCTP configuration if not
 enabled
To: Alexander Aring <aahringo@redhat.com>, teigland@redhat.com
Cc: gfs2@lists.linux.dev, glass.su@suse.com, lidong.zhong@suse.com
References: <20250429202913.2908521-1-aahringo@redhat.com>
 <20250429202913.2908521-3-aahringo@redhat.com>
From: Heming Zhao <heming.zhao@suse.com>
Content-Language: en-US
In-Reply-To: <20250429202913.2908521-3-aahringo@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/30/25 04:29, Alexander Aring wrote:
> Reject SCTP dlm configuration if the kernel was never build with SCTP.
> Currently the only one known user space tool "dlm_controld" will drop an
> error in the logs and getting stuck. This behaviour should be fixed to
> deliver an error to the user or fallback to TCP.
> 
> Signed-off-by: Alexander Aring <aahringo@redhat.com>

Reviewed-by: Heming zhao <heming.zhao@suse.com>

> ---
>   fs/dlm/config.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/fs/dlm/config.c b/fs/dlm/config.c
> index cf9ba6fd7a28..a23fd524a6ee 100644
> --- a/fs/dlm/config.c
> +++ b/fs/dlm/config.c
> @@ -197,6 +197,9 @@ static int dlm_check_protocol_and_dlm_running(unsigned int x)
>   		break;
>   	case 1:
>   		/* SCTP */
> +		if (!IS_ENABLED(CONFIG_IP_SCTP))
> +			return -EOPNOTSUPP;
> +
>   		break;
>   	default:
>   		return -EINVAL;

