Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1051E20AF71
	for <gfs2@lists.linux.dev>; Mon, 13 Jan 2025 16:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736784739; cv=none; b=LkpSgdb+DhXBRxED3DNueAEqB/WDPpd2pTtHB6/xZWrYokFn+zuANlYYJXUV88OkM498x/QZsmJTF2B2oAgToofAZh5cpV0qUFkuYvCXXSjcF5C44d7clI5hCWYL04Sui5ERrUbr/BBGPcXe6Bjy5HtbzC6neNc1pLgXr65Yg+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736784739; c=relaxed/simple;
	bh=H+F9tHVBR0fQmf71J3gLkHC9qgPnJkYNp5GS5S4g+7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RK4vxhNjNUOqtgavcAdxJzREoGUfrh3htJgmx7fMHLUu3ww2Mk/YI924zxqAk6R+uoAMF9uj39JCvra+ninAniAQyjd3Fv5CQqbU7KovCVqumr1LpY5lfIzrUwQ1u386QDanLyGRAPt4KTtkw5tphigKfyXr82/T+K7FuOIqj1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fmpoWUHA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fmpoWUHA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736784737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+pjWyIe8mnk7g6/F83/ZX7003rIKqe+bESoWt3TOXDo=;
	b=fmpoWUHARcHa1L5eBdiJm/uSkhcGrmcmjnJW219VmUgXm6qCED5+Kk2BgmFFGJ+sQH5WEl
	4wjzyr8vr9hy3rpp46JLpf5fe96EkAv3skAgoYWM3yB0+1CLBinYwNr2VsnymP+00zI/Sy
	wVVXBopl40WkIK++BXMVwH4oWSxaBRI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-G0MBboP-M1mX-2qtTjzPTg-1; Mon, 13 Jan 2025 11:12:15 -0500
X-MC-Unique: G0MBboP-M1mX-2qtTjzPTg-1
X-Mimecast-MFC-AGG-ID: G0MBboP-M1mX-2qtTjzPTg
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4361c040ba8so25723555e9.1
        for <gfs2@lists.linux.dev>; Mon, 13 Jan 2025 08:12:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736784734; x=1737389534;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+pjWyIe8mnk7g6/F83/ZX7003rIKqe+bESoWt3TOXDo=;
        b=AESoABOpHzaBJJyNaHuaTWXAdejh+Ig3huZhIYSNIvNCE7amXeO4Au/BdM3fePYOaM
         +Hsd9x9NILJGP6oEB4ZmLI612GgDRFoGNUfA0KOnpmiE0nfWYYm3bsdhPOUpi+zRAygb
         S1FcMZKFqlDfpAfwpxeriaKQ6tj7F1Hf2hjTXCPoFSvUAeeXymMujJiHuxSf7i9R8UBi
         P8JGogm/Txsow7qD8Is5aimHjF6Zqx8fA9Az0C/l3a0HXp7a2t8rXzjReUBwUeZK3ijX
         EqL5eDCm+wo4Cq25p8dUfcNyqHOjmP6yoJFlPdblhihatSpRyecBAPKyLIfvNcj0NGkd
         zl6w==
X-Forwarded-Encrypted: i=1; AJvYcCXOUom2cLoGjWd5LU03UuoN3r73OUCt9T+zzxILRutThrm/+VPigFFpts3S6oLUYB9/gQIr@lists.linux.dev
X-Gm-Message-State: AOJu0YwlHd9UptpQjJS8li8u5IqmuPGucDwA+Z8r1K7QBmWbGXucoH9s
	DmzMP8MoN7WAWIvO4IEF+BpHwcyckHbFk6FRwDW+nttz2g3rzDp3Uv1HV5yoYdtgSK6xmzSvD8m
	t627eY8pyK1V1vlyzLNlK5ja1ZZ2UqfhNe72XzlMqFfWM8lg0EEk=
X-Gm-Gg: ASbGncuTAw8AVzxGx/7Mbjmpju29Z83X7cy1lh2VmwOtrN9qH9PAAstJ9Z+jd7rjr/z
	85/lFSc8z/3dyg57DmyzmNj4Yb/5dldWXAsS6hiGXtAuQSvCBbJ1T60NnlZpFpqmSNt1NeT22d7
	5gYd8/QkacIqfoU+PXiKHk6H0n99cdyH+Trgw0FhOnJgN7qXX+2oDNZLqctiDo2X/84ERV+MyNK
	nTcAQxBG5sDy7b0R6tSJXVR4aiCKNCGoKw4mFqibQPv7oXPgGWQ+xFUq07ME8VabVMn4hrYChzm
	xnXnh83IQ5U9KvMmym+K4Eztlz10BoMJknn5zBo/
X-Received: by 2002:a05:600c:a44:b0:434:a852:ba6d with SMTP id 5b1f17b1804b1-436e2692d98mr192763445e9.9.1736784734403;
        Mon, 13 Jan 2025 08:12:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFf6XW1cvL5UoHvdjbD30b+iBZ9HkwmTvZwbT8O+46nwB/B8rcXEgT73vr2SwiShA/NK8OOuA==
X-Received: by 2002:a05:600c:a44:b0:434:a852:ba6d with SMTP id 5b1f17b1804b1-436e2692d98mr192763035e9.9.1736784733859;
        Mon, 13 Jan 2025 08:12:13 -0800 (PST)
Received: from [192.168.1.167] (cpc76484-cwma10-2-0-cust967.7-3.cable.virginm.net. [82.31.203.200])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e38bd0dsm12465616f8f.45.2025.01.13.08.12.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2025 08:12:13 -0800 (PST)
Message-ID: <31f0da2e-4dd7-44eb-95ee-6d22d310a2d6@redhat.com>
Date: Mon, 13 Jan 2025 16:12:12 +0000
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bug: slab-out-of-bounds Write in __bh_read
To: Kun Hu <huk23@m.fudan.edu.cn>, Andreas Gruenbacher <agruenba@redhat.com>
Cc: Jan Kara <jack@suse.cz>, viro@zeniv.linux.org.uk, brauner@kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 "jjtan24@m.fudan.edu.cn" <jjtan24@m.fudan.edu.cn>, gfs2@lists.linux.dev
References: <F0E0E5DD-572E-4F05-8016-46D36682C8BB@m.fudan.edu.cn>
 <brheoinx2gsmonf6uxobqicuxnqpxnsum26c3hcuroztmccl3m@lnmielvfe4v7>
 <5757218E-52F8-49C7-95F1-9051EB51A2F3@m.fudan.edu.cn>
 <6yd5s7fxnr7wtmluqa667lok54sphgtg4eppubntulelwidvca@ffyohkeovnyn>
 <31A10938-C36E-40A2-8A1D-180BD95528DD@m.fudan.edu.cn>
 <xqx6qkwti3ouotgkq5teay3adsja37ypjinrhur4m3wzagf5ia@ippcgcsvem5b>
 <86F5589E-BC3A-49E5-824F-0E840F75F46D@m.fudan.edu.cn>
 <CAHc6FU5YgChLiiUtEmS8pJGHUUhHAK3eYrrGd+FaNMDLti786g@mail.gmail.com>
 <27DB604A-8C3B-4703-BB8A-CBC16B9C4969@m.fudan.edu.cn>
From: Andrew Price <anprice@redhat.com>
In-Reply-To: <27DB604A-8C3B-4703-BB8A-CBC16B9C4969@m.fudan.edu.cn>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ud85rgdqypZoHZktdwFH7gf6YXUf8Nx-0f5UfbGAk6M_1736784735
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 13/01/2025 15:54, Kun Hu wrote:
> 
>>
>> 32generated_program.c memory maps the filesystem image, mounts it, and
>> then modifies it through the memory map. It's those modifications that
>> cause gfs2 to crash, so the test case is invalid.
>>
>> Is disabling CONFIG_BLK_DEV_WRITE_MOUNTED supposed to prevent that? If
>> so, then it doesn't seem to be working.
>>
>> Thanks,
>> Andreas
> 
> 
>>   We have reproduced the crash with CONFIG_BLK_DEV_WRITE_MOUNTED disabled to obtain the same crash log. The new crash log, along with C and Syzlang reproducers are provided below:
> 
>> Crash log: https://drive.google.com/file/d/1FiCgo05oPheAt4sDQzRYTQwl0-CY6rvi/view?usp=sharing
>> C reproducer: https://drive.google.com/file/d/1TTR9cquaJcMYER6vtYUGh3gOn_mROME4/view?usp=sharing
>> Syzlang reproducer: https://drive.google.com/file/d/1R9QDUP2r7MI4kYMiT_yn-tzm6NqmcEW-/view?usp=sharing
> 
> Hi Andreas,
> 
> As per Jan's suggestion, we’ve successfully reproduced the crash with CONFIG_BLK_DEV_WRITE_MOUNTED disabled. Should you require us to test this issue again, we are happy to do so.
> 
FWIW the reproducer boils down to

   #include <fcntl.h>
   #include <unistd.h>
   #include <sys/ioctl.h>
   #include <linux/fs.h>

   /*
      mkfs.gfs2 -b 2048 -p lock_nolock $DEV
      mount $DEV $MNT
      cd $MNT
      /path/to/this_test
    */
   int main(void)
   {
           unsigned flag = FS_JOURNAL_DATA_FL;
           char buf[4102] = {0};
           int fd;

           /* Error checking omitted for clarity */
           fd = open("f", O_CREAT|O_RDWR);
           write(fd, buf, sizeof(buf));
           ioctl(fd, FS_IOC_SETFLAGS, &flag);
           write(fd, buf, sizeof(buf)); /* boom */
           close(fd);
           return 0;
   }

So it's switching the file to journaled data mode between two writes.

The size of the writes seems to be relevant and the fs needs to be 
created with a 2K block size (I'm guessing it could reproduce with other 
combinations).

Andy

