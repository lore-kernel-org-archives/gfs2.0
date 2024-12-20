Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD6B1304B0
	for <gfs2@lists.linux.dev>; Fri, 20 Dec 2024 07:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734680343; cv=none; b=MdWVM61w3cVPrV53PFYOS+NM+NA8IVAck+yLc5rqq6BL7uMLfD19NAVgRZRBo9erQABPdW1pDTkuqO8QH2EE1Ak9leQlECdggNg+E+p6ZfHa9lMdjezxgSWlg691h8nEfcUBGsVBYJonT5EVaycXKrgNipY0glG8d/SBk3AU7Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734680343; c=relaxed/simple;
	bh=VE+UbCwtYrrPHgkfdixLl8d84ULL5RJVxYIMLUhwmTU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A1pXqrxxdhFoe7+k/nd+VtXIL7ztIv0sI6XfahliqYIFqGq7SQkh1MhzxnPmQSAZ5/XS5Ig4erVsgLC7QR0L1uYjr0eQBlAjd5T6/o1ebcFHxFC/Sv4yQQ8HFjv2s3nHGwaxHd+8gb53JpodZRD1LxngrOAQI/XTPzntbSc9vpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TkMZBhoz; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TkMZBhoz"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5d3ea2a5a9fso226195a12.2
        for <gfs2@lists.linux.dev>; Thu, 19 Dec 2024 23:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734680340; x=1735285140; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T/pdG4My4JxU9WAxhU58yoe+++bJRnbrQOzQBV7RVp4=;
        b=TkMZBhoz/vvabH6fPQ6QtVYrbA0E0nUXelDd4xZJwgXLoSsxpl73p01aNoLbGUafzb
         QjhF5Yrn6k9fEq5Wgc1O0Q/VeqI1mIf2LDtnS1J0/GOx0s2bLVHWQzFmLJsGJjhSOsn/
         dyCgyJeBKcEAflkwJTG8sYOFI3C+9nYakx2/cIBhOKPQxhxxZ6Rmj/ItAbTWou1cLZLx
         FNKY3t8RcrgbCIJHZAPQXyzyEE1SdjowIAjni+6IN9atekcBtUQnz6F7xkL12/L5OQDC
         CIMUrw45gDFOwnipxhxMtag8OqBJSdRnDCNyKBmDo8m2AXTFpY7FjIIbloY7X3iC4irq
         gPYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734680340; x=1735285140;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T/pdG4My4JxU9WAxhU58yoe+++bJRnbrQOzQBV7RVp4=;
        b=Uizl6lImAkxjO7nRernnHUQ5LtofcRN8IaY2Cc9yzAMg3NnnJLej+yaiA3MjaR2nri
         jGJ02xYAvFp0AWiwEvZ4x042Z4hm21X7mOtlrJPHT+FDie7QjkVdXW1diGU91GQYRF3Z
         sAFfa45dApwHz7Xh0yWhXtr/SQvxYpY3c0dK/heENhdh5ccx5irLUXJekaEu21mnYzMa
         NAkLDPDNDUE1YOGJBdNZStsWmSPbYDSPYxNhGAAnOQTGI+KARgQBvNNn/QrAYvXQZxJ1
         HXQ+FI9zKPQTDrJ4oW/v5AHYDB/dv2r2Q/l/+XzlLIahqQHurk0/xr886jElBH9jsrDo
         XIig==
X-Gm-Message-State: AOJu0Yxeeytl1RVBtbpQ8MyqntRbvR9bPwsESlDjJortb1W3ikPpDfPv
	Dim+L/F21VObh/Y7KBqbpkU2TXk8ka07ZMhKORohJZu0IahptQkfLf+ewHRasoo=
X-Gm-Gg: ASbGncvmtr3W9Ifi957OQir/1CkX9nhVGqZPrxeAokGQUnQAGGuGWTAnnitnPc9+Pqs
	M5ysKjikW0ehb0kBOBz2t+eYfNGo+2k2PPHd+eE/1lJiiyxT7r5UNHhc2IIqQPVjanKw80C467l
	BG8sZcu8lh/ajlq+fQVQ0blMMxKhkoM/+cMA0R5MMfTJ7j/63AAxZdzj+xxx3q4D/kGPmwXKKvp
	N8EkKwMPssgHaBjlIihLIulKvI9oHtzUez0stYtGGua8F166BznrQzjkUgk
X-Google-Smtp-Source: AGHT+IG38MGkwQrE4KXq3rZD6ryEIM4Z+ESQZF7IGYJujmw38ni3nfBiXpcTMrnq7iFcG8Ie2uMIJA==
X-Received: by 2002:a05:6402:3596:b0:5d0:d0c5:f26a with SMTP id 4fb4d7f45d1cf-5d81de063admr528140a12.9.1734680339839;
        Thu, 19 Dec 2024 23:38:59 -0800 (PST)
Received: from [10.202.32.28] ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842dc605001sm2276168a12.54.2024.12.19.23.38.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2024 23:38:58 -0800 (PST)
Message-ID: <fa60f3b1-77d0-42ee-858f-fecb497a6e37@suse.com>
Date: Fri, 20 Dec 2024 15:38:54 +0800
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/1] dlm_tools: support corosync3/knet multi-link
To: teigland@redhat.com, aahringo@redhat.com
Cc: gfs2@lists.linux.dev, ccaulfie@redhat.com, jfriesse@redhat.com,
 nicholas.yang@suse.com
References: <20241220071440.16803-1-heming.zhao@suse.com>
Content-Language: en-US
From: Heming Zhao <heming.zhao@suse.com>
In-Reply-To: <20241220071440.16803-1-heming.zhao@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

Nicholas notified me the new code is not compatible with corosync2
multicast mode. I withdraw this patch and will send a new patch.

Thanks,
Heming

On 12/20/24 15:14, Heming Zhao wrote:
> This patch is to support corosync3/knet multi-link.
> 
> btw, this mailing list (gfs2@lists.linux.dev) is the right place
> to send this patch?
> 
> Heming Zhao (1):
>    dlm_controld: support corosync3/knet multi-link
> 
>   dlm_controld/action.c     | 31 ++++++++++++++++++++-----------
>   dlm_controld/dlm_daemon.h |  4 ++--
>   dlm_sand/sand_internal.h  |  4 ++--
>   3 files changed, 24 insertions(+), 15 deletions(-)
> 


