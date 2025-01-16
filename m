Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC4324A7C9
	for <gfs2@lists.linux.dev>; Thu, 16 Jan 2025 14:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737037846; cv=none; b=p7arrO+30FUW8IQVuoSYakVNsGDE13dkZyVy9coFY/E7FFKWxyOH9awNTMrCGNbmxIykXaOPHfxTCbmSoyQbsbLmXOmocfL1lYajtZWZMRL0Ws0PSvtX3BITO1IpbYdav23Fs1i9NLvj67THLXa242dbUBSMmaSEvAyLxQ2fM8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737037846; c=relaxed/simple;
	bh=QIK3mQe4K7FH/eHBcZ7DiEnvNZxJbMC6Z+6vZ8P2xxE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b2JRGUbfDOWnPkRX0eE3fIofJdi5ktl9yU3GeJgysAvd6zx4iCEHAexC1GbAAzYD0xzX3nO2QnYkIDz4HEDYdlNmIti98Z25RyKADQFGWrQW4XL/StQUNaNidShc4yye2oBo2I4KeTJVoDQKNR3ZMVPJGXxo59dk8ctkkIUPRIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KaiNkpTp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KaiNkpTp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737037843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HezSLtbLt6I3kDFST2dooQpti29iMwi6cy67iAjHZZA=;
	b=KaiNkpTpUOAFNbu3QlWQ7qqS/XVDHNzpFX8KjJ1DIPA0jkh3MhfOfsTNS9WKnBP36d0bK0
	eZ5wgJgwT3JcNSLYG5FstuxX4JHOWrKr969ethrNnRJB4qpqXpVskFM/f+kK4MgQOaNQMm
	Ds5G8v//159nYg+qyCa9DxJHrigD32k=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-186-qkE5h_CVMsSex7ZArYBhVw-1; Thu, 16 Jan 2025 09:30:42 -0500
X-MC-Unique: qkE5h_CVMsSex7ZArYBhVw-1
X-Mimecast-MFC-AGG-ID: qkE5h_CVMsSex7ZArYBhVw
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-38a2140a400so727060f8f.0
        for <gfs2@lists.linux.dev>; Thu, 16 Jan 2025 06:30:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737037841; x=1737642641;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HezSLtbLt6I3kDFST2dooQpti29iMwi6cy67iAjHZZA=;
        b=t7+RVmN893u8MEFRehNXoc2uWV81HBNBli+1IluFYe/j2N+DwrO9vHtWkyh+JsDa6p
         GH6xjI1Redbr7esmXNSET2EvWZfRY/3VWAQdyWU0ZDSaTfRZwyofv4txMylTaMrJZE9T
         TQLm7GXwkUJ1RtifBPiEr1EdvQIzUQ9vwEOMGzXPdBFmp3Kh2fyFpFECHqV4o8KTYXNF
         3l3pwDU52q010YZy+MHHH+hQaKaIhHG3ATsM1SPxSzF41n1klpmjkbfDijjUuZ9Hd+Dm
         lvhddFCKZWBo0kdNBcBFB/LwQQECcoTtUy625V86+VuNXW4fUv7fvYnJl+4rjzz2FZLw
         GpgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEDbSMfsCvLh3NxjUP9E7i5M1k+taCZYVDAQCKfwT/0ZC63ll2BOOh21HA0KUyoUck6V+S@lists.linux.dev
X-Gm-Message-State: AOJu0YyCrtDzoUkDjcYuvnPVgPqaPeonCh5mqvfp7uZGerCQviamEcNu
	5Ih3Uy+X70tpV9Jf2+Nh+I85JYsysnIvv/MTN/uTn68WVQK9IOjPeMQ8v+26V+ExYTf3BhtFHxr
	4ad00jZx/jdPWnk9zQItFkoVrwBkHnvLqD5XBDQJfL8ESj71o2ew=
X-Gm-Gg: ASbGncsFj06agN2O2CLcYffQ/gajKmPlEqhVMPhgtD2K6aXo9DRq/z2QxX2Rpeacr3Z
	pk9Xc8l3uQUinSEv1JSJ1zlE1KbNFLyJ8lsqUO7SxKDlkeTxm62gsnGY0lfc1p2eCMtGDaNkW4T
	iWpRBSj1paZ13PfTtH/5HrYfGBLxpa0pbBMdow9lKYOyIoddD/f0NncSMjqqLnyw6qjJCYPsT4k
	YqiXVHHzwUHyGWFfYdxDIT66gIUdXE1LmYIij86uVtvVNrDgSxMippuoSVbAkM6qVyOeoRod4ZU
	MOPZ0eTuY1492tqUEhU6qjDs6brx9XDXQ6Vs0BHi
X-Received: by 2002:a5d:6d0c:0:b0:38b:d7d2:12f6 with SMTP id ffacd0b85a97d-38bd7d2152bmr16922006f8f.2.1737037840705;
        Thu, 16 Jan 2025 06:30:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH5blT5qJsPmn5YMfOhaY9D2QzZQ3/j9n+qpA+7oxjjuOMEuGsOLpy1own/fxtthhPqHcfg5w==
X-Received: by 2002:a5d:6d0c:0:b0:38b:d7d2:12f6 with SMTP id ffacd0b85a97d-38bd7d2152bmr16921963f8f.2.1737037840175;
        Thu, 16 Jan 2025 06:30:40 -0800 (PST)
Received: from [192.168.1.167] (cpc76484-cwma10-2-0-cust967.7-3.cable.virginm.net. [82.31.203.200])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf32222ebsm23999f8f.40.2025.01.16.06.30.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2025 06:30:39 -0800 (PST)
Message-ID: <eb78dcaf-5acc-4317-911d-cff3b53e424d@redhat.com>
Date: Thu, 16 Jan 2025 14:30:38 +0000
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bug: slab-out-of-bounds Write in __bh_read
To: Kun Hu <huk23@m.fudan.edu.cn>, Andreas Gruenbacher <agruenba@redhat.com>
Cc: "jjtan24@m.fudan.edu.cn" <jjtan24@m.fudan.edu.cn>,
 viro@zeniv.linux.org.uk, brauner@kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, gfs2@lists.linux.dev
References: <F0E0E5DD-572E-4F05-8016-46D36682C8BB@m.fudan.edu.cn>
 <brheoinx2gsmonf6uxobqicuxnqpxnsum26c3hcuroztmccl3m@lnmielvfe4v7>
 <5757218E-52F8-49C7-95F1-9051EB51A2F3@m.fudan.edu.cn>
 <6yd5s7fxnr7wtmluqa667lok54sphgtg4eppubntulelwidvca@ffyohkeovnyn>
 <31A10938-C36E-40A2-8A1D-180BD95528DD@m.fudan.edu.cn>
 <xqx6qkwti3ouotgkq5teay3adsja37ypjinrhur4m3wzagf5ia@ippcgcsvem5b>
 <86F5589E-BC3A-49E5-824F-0E840F75F46D@m.fudan.edu.cn>
 <CAHc6FU5YgChLiiUtEmS8pJGHUUhHAK3eYrrGd+FaNMDLti786g@mail.gmail.com>
 <27DB604A-8C3B-4703-BB8A-CBC16B9C4969@m.fudan.edu.cn>
 <31f0da2e-4dd7-44eb-95ee-6d22d310a2d6@redhat.com>
 <CAHc6FU63eqRqUnrPz0JHJdenfsCTWLgagX+2zywHNTcFoZA8XQ@mail.gmail.com>
 <A184824F-B892-46D3-B086-556E9ACF4EA0@m.fudan.edu.cn>
From: Andrew Price <anprice@redhat.com>
In-Reply-To: <A184824F-B892-46D3-B086-556E9ACF4EA0@m.fudan.edu.cn>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jhCFxDutELUfs_4KEKZCCrCs3EFBnvHK7X5JXL9h6XU_1737037841
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 16/01/2025 10:41, Kun Hu wrote:
> 
>> 2025年1月15日 02:05，Andreas Gruenbacher <agruenba@redhat.com> 写道：
>> I've posted a fix and pushed it to for-next:
>>
>> https://lore.kernel.org/gfs2/20250114175949.1196275-1-agruenba@redhat.com/
>>
>> Thanks for reporting!
>>
>> Andreas
> 
>> Syzlang reproducer: https://drive.google.com/file/d/1R9QDUP2r7MI4kYMiT_yn-tzm6NqmcEW-/view?usp=sharing
> 
> Hi Andreas,
> 
> Thank you for the patch. I tested it using the syscall reproducer and was still able to reproduce the issue.
> 
> Crash log: Link: https://github.com/pghk13/Kernel-Bug/blob/main/0103_6.13rc5_%E6%9C%AA%E6%8A%A5%E5%91%8A/%E5%AE%8C%E5%85%A8%E6%97%A0%E8%AE%B0%E5%BD%95/32-KASAN_%20slab-out-of-bounds%20Write%20in%20__bh_read/crashlog_0116_rc7%2Bpatch.txt
> 

That's not the slab-out-of-bounds failure. It's failing to mount with:

"kobject: kobject_add_internal failed for syz:syz with -EEXIST, don't 
try to register things with the same name in the same directory."

This can happen when a gfs2 fs is mounted with the same locktable twice, 
so I expect it's a problem in the test. Please make sure you're running 
the same reproducer from the original report, in the same way. The patch 
fixes both reproducers for me.

Andy

