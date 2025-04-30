Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FEB13CA97
	for <gfs2@lists.linux.dev>; Wed, 30 Apr 2025 07:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745997340; cv=none; b=kp5jpHlEL0veWa2LWfL3n6W27DnGx8gpyvtbjzYBMWZptcAyRjndp0EA/s2CWh4SBD9/MMgQ07CyWpTLD6lBsiiANCEPPulnzDAQaUJhUqW1kguRXsCP87b1xA9K1sOPvgMJli/B0nOJiyUaoSLKA/ALpgL+GrBvPDrXAa9TYhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745997340; c=relaxed/simple;
	bh=kYE1vlOcVKQB19qKydYtFXdRynQVB+uPq7zb97muKv8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QMZSQyMR8+FYLYNIG9zxVGLjziShWjzgJmJfWNo9g7whf+aw/t4oF0tzSQI8jAJqmBN8ecEfUCydtvQyS7xCZjTbMaIJ67ZWRVsnyS2s70Jobm3Xli6Cq0P/zn9tMWIk3OJS0FEQ4UCx5h3btQM70JAkSinggyzYjHhZaLMsfLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=V0PUd1p7; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="V0PUd1p7"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e78378051aso1016534a12.3
        for <gfs2@lists.linux.dev>; Wed, 30 Apr 2025 00:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1745997336; x=1746602136; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dcUEg2VUenpStGxn0KGV117l/A3GxmFE8DcZr26M4es=;
        b=V0PUd1p7HsJu/nPnkz6K+lgxKKten/rOz6xgByi/XlhnaoJ9r3Cto/3j9ed9qfILyW
         Bd6R3vnL4umOeMuwqe55aKRXpOeYcXuFgCUG+UfVgD8UUtvUwjOmL+FM8aECSRymr3kx
         oeZV8zyHIfPADJFOvFoXM6opjMQX17RyWaot4dKH9Gy0J6wKYd7xCj9eFyPMtaX3d6dJ
         0It68g9AXveBQIgNEs8YYJrTcYdyrT7CddBQUunO1st5ti/BoA9zntl7EFUKaxpKV2Ix
         Bd69Cprk+f7lakCh8Nz2b22o03A2uuLxwC1SFc+DTjLy1s46rPFmcAOFiiNsASNN++eS
         iFBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745997336; x=1746602136;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dcUEg2VUenpStGxn0KGV117l/A3GxmFE8DcZr26M4es=;
        b=Q/rZb5xlvKyEpBxXP/aTkTlpMkCDNDHzt0UxuhVi7+nO3oZIfIBAAJvTYbyg8Pahs6
         TSgaNfZReULcO08yRzldAOipkNgzGfT3GWi/7fSnNxhgG68+aC1ESuzVnuEwcnvp5y98
         bv5/V0yVViaHMx/JGH9UGVwKOx6tEZ/R5tkak5mJmdYPwEyeU2cNFLBxtQDfXbsWbv1O
         ri9tKua6Uvf5qZaW4gmDocgwR5sKDtlCgmhmKAiOuPHScPYziU+lc98mwnw7aRAT3KPi
         VQWpONwcPjD4PDM+ruCXl7MuZrRigXgKaAW+K6Ix3hPSNs5V2LdD3kkIUXEqOSF2XnTl
         TRyg==
X-Gm-Message-State: AOJu0YxDt1wQdulBBmDz+U71/BiwKtfAN4d7fHybWvHUXV47WVi0Hl7J
	DfeKJ291VEKtCXHRgA6RFNbDv1gr56RCGQiHigNybY0zXOst+1Pw+ta8rEzu+WU=
X-Gm-Gg: ASbGncsP0zq6dr+uPEPhaLICAq4/1rzB2HTYUEk9R1Vp+oknavUX//LkWuCLUz4pIos
	EtlDHg04MZbH5TjF7XmhZhnDjugbHjWKNtwazBTH60SBm2TkPKDas5ym0s3nkeq5u1bNeb/QrEN
	dgPE2idQ2j26KsKAmgXXAryjqXxQCrmLWAtE1JA7n3OQmGPUvpd+iBqaFHfu+mMlSjdTr7fZiw8
	FY/4pXSWEAP/+0a86VWZerVv/nhxYGrk1WW5r8b7UPW5N/Yh3mdFRbA+Xd7MqjpaU2fuGpaEuhS
	+G3xOc++vfo35fFimD27ula/G7JdAdYsLwEAHIczCcaK8RxYMFwC1ILtZQ==
X-Google-Smtp-Source: AGHT+IGupNa6Z7B2ky7JnyAGGZscNJL+Yy+PXYN1q4kN4xhZY7yTwOZK6nhtxbO3hK4/VZzn2WF2Og==
X-Received: by 2002:a05:6402:2790:b0:5f6:c5e3:faa0 with SMTP id 4fb4d7f45d1cf-5f8af0e1ea1mr363701a12.10.1745997336057;
        Wed, 30 Apr 2025 00:15:36 -0700 (PDT)
Received: from [10.202.112.30] ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4d77395sm114785525ad.5.2025.04.30.00.15.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Apr 2025 00:15:35 -0700 (PDT)
Message-ID: <d70408cf-be11-4092-b8b0-abee4486348f@suse.com>
Date: Wed, 30 Apr 2025 15:15:31 +0800
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH dlm/next 1/4] dlm: mask sk_shutdown value
To: Alexander Aring <aahringo@redhat.com>, teigland@redhat.com
Cc: gfs2@lists.linux.dev, glass.su@suse.com, lidong.zhong@suse.com
References: <20250429202913.2908521-1-aahringo@redhat.com>
From: Heming Zhao <heming.zhao@suse.com>
Content-Language: en-US
In-Reply-To: <20250429202913.2908521-1-aahringo@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/30/25 04:29, Alexander Aring wrote:
> The sk->sk_shutdown value is flag value so use masking to check if
> RCV_SHUTDOWN is set as other possible values like SEND_SHUTDOWN can set
> as well.
> 
> Signed-off-by: Alexander Aring <aahringo@redhat.com>

Tested-by: Heming zhao <heming.zhao@suse.com>
Reviewed-by: Heming zhao <heming.zhao@suse.com>

> ---
>   fs/dlm/lowcomms.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
> index 70abd4da17a6..50c42b368c83 100644
> --- a/fs/dlm/lowcomms.c
> +++ b/fs/dlm/lowcomms.c
> @@ -533,7 +533,7 @@ static void lowcomms_state_change(struct sock *sk)
>   	/* SCTP layer is not calling sk_data_ready when the connection
>   	 * is done, so we catch the signal through here.
>   	 */
> -	if (sk->sk_shutdown == RCV_SHUTDOWN)
> +	if (sk->sk_shutdown & RCV_SHUTDOWN)
>   		lowcomms_data_ready(sk);
>   }
>   

