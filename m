Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFB61CB530
	for <gfs2@lists.linux.dev>; Mon,  2 Sep 2024 15:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725290075; cv=none; b=QTvTjU5N4ybbOcYV3H/MNTKXEPbbiNtDnprn8mlFNRT0vnfj/zdAST9Dmzt9o65SKWlPwgYygiqZJEkQkFyHtyo14i6c5DisjlLgoYjSODtwGrS9WEbZOmYy0b4aNlSF3Ju1EEuWwYpeX+sW76Mab0U4O3XhRxUdw5Ldb2FLAMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725290075; c=relaxed/simple;
	bh=XKr8vqXp0pyLcoY0li2Ip+KFTpcQBVzs/038PQ1e5UI=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=TgdMTNoE2qwdFmIrHS1TMGWTqeTiex54GtuWs+QCV0bC4j5IPn50DWgr6WoIeAwM/cT3H6gI9NJxSoy4WDpO9GBdIHCYI3Ii7qfFHc+dWMvS7atx0i9EI20I0Mfp55hjhgyRWWY3zp1udXyovvxGI2garbvow7okMU69PXmrdtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZR4x1A73; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZR4x1A73"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5e16cb56d4aso722752eaf.1
        for <gfs2@lists.linux.dev>; Mon, 02 Sep 2024 08:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725290072; x=1725894872; darn=lists.linux.dev;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FJU0CDkLtI4hgbVSjU/NdSl7KcYwPPqpC+O6OX8LpEs=;
        b=ZR4x1A73HIeazCgXbvQ1+f8wZfuyYfMLqJOwSGkNb8It2TtjrtGJalcvtm0IIZfi/z
         kmSFvIDz6hdffjeR3MvYPFuhI0/huzjUC71CSJiFys1C49bdumSMsEkiGjZzTNcQjw94
         IKk3o4SlAcIvjwq5YGvFsfehoiCax3nXEix+w1m+P78gdLiRZCWNUx6B38ji2LeIgrpk
         EPEbE3SWeJPisfWoL3GYAxX0AoM0e0rcYbXgrxSiyMXfsSw9ZdAcWM9Wv6EVr6/V4oq4
         7zA9JGFN917NBjKYELz+ou+6brMsxAhNopE2xSDbtQQjj6wMWSLu0Tt8tOBdlIobN6bd
         Vb8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725290072; x=1725894872;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FJU0CDkLtI4hgbVSjU/NdSl7KcYwPPqpC+O6OX8LpEs=;
        b=hgN7MX+nL6D+lOLqNWEo3j2/LzTorFPJMpPdjsT1ngcTH41MIzDXlXTPm3c3ZvUAvG
         HWEWVkTJjTvwGcr8065VLNKHB9mCFT4x+YzIUvdop9yrqGiY9R3+NqSNGxjTBsI/ObLU
         KESjsBVP0xSUDdF7oK4zWj5cfvnVPlQRJkC1TRxK4/oS4Ym4pJeaD/9t3paHXnMgqvEC
         n2RIy6TqHTTD3+K/A4AeQGEf1apUJ/GLGNgfkRaiq/ph5XqjIaMyi3Au0/pbTxUgjH2N
         ELPVSqBo3p/BcIobLGKIazOUy75o2RnGzucyGP2zlBJpUxbgbj4j4sHTcbK0JmYcvgKh
         0Wtw==
X-Gm-Message-State: AOJu0YyaWj1wUzYlEIVN3VfUPm0SUMnpWvwoFNy3XYVxnx+n1ojDHEUO
	NkapaXnmhW3zrJ+F5P21K/zYLdBTMDI3fs5Tat1muHZl9X1m/ONMgVVTQg==
X-Google-Smtp-Source: AGHT+IFwjK878OfBX/nfaUby9oNN/Al7JyPpfgSsSmsvFwG/aUvZ1iWbuR1s3xck9yatfv8WlgeUlQ==
X-Received: by 2002:a05:6358:50c4:b0:1b8:106c:dd83 with SMTP id e5c5f4694b2df-1b8106cde06mr65355555d.30.1725290072185;
        Mon, 02 Sep 2024 08:14:32 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d22e9be627sm7696297a12.57.2024.09.02.08.14.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 08:14:31 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <2142bfe8-c91f-4c56-a3e9-3d5cf11826a2@roeck-us.net>
Date: Mon, 2 Sep 2024 08:14:30 -0700
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
From: Guenter Roeck <linux@roeck-us.net>
Subject: lockdep warnings in gfs2 code
Autocrypt: addr=linux@roeck-us.net; keydata=
 xsFNBE6H1WcBEACu6jIcw5kZ5dGeJ7E7B2uweQR/4FGxH10/H1O1+ApmcQ9i87XdZQiB9cpN
 RYHA7RCEK2dh6dDccykQk3bC90xXMPg+O3R+C/SkwcnUak1UZaeK/SwQbq/t0tkMzYDRxfJ7
 nyFiKxUehbNF3r9qlJgPqONwX5vJy4/GvDHdddSCxV41P/ejsZ8PykxyJs98UWhF54tGRWFl
 7i1xvaDB9lN5WTLRKSO7wICuLiSz5WZHXMkyF4d+/O5ll7yz/o/JxK5vO/sduYDIlFTvBZDh
 gzaEtNf5tQjsjG4io8E0Yq0ViobLkS2RTNZT8ICq/Jmvl0SpbHRvYwa2DhNsK0YjHFQBB0FX
 IdhdUEzNefcNcYvqigJpdICoP2e4yJSyflHFO4dr0OrdnGLe1Zi/8Xo/2+M1dSSEt196rXaC
 kwu2KgIgmkRBb3cp2vIBBIIowU8W3qC1+w+RdMUrZxKGWJ3juwcgveJlzMpMZNyM1jobSXZ0
 VHGMNJ3MwXlrEFPXaYJgibcg6brM6wGfX/LBvc/haWw4yO24lT5eitm4UBdIy9pKkKmHHh7s
 jfZJkB5fWKVdoCv/omy6UyH6ykLOPFugl+hVL2Prf8xrXuZe1CMS7ID9Lc8FaL1ROIN/W8Vk
 BIsJMaWOhks//7d92Uf3EArDlDShwR2+D+AMon8NULuLBHiEUQARAQABzTJHdWVudGVyIFJv
 ZWNrIChMaW51eCBhY2NvdW50KSA8bGludXhAcm9lY2stdXMubmV0PsLBgQQTAQIAKwIbAwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4ACGQEFAlVcphcFCRmg06EACgkQyx8mb86fmYFg0RAA
 nzXJzuPkLJaOmSIzPAqqnutACchT/meCOgMEpS5oLf6xn5ySZkl23OxuhpMZTVX+49c9pvBx
 hpvl5bCWFu5qC1jC2eWRYU+aZZE4sxMaAGeWenQJsiG9lP8wkfCJP3ockNu0ZXXAXwIbY1O1
 c+l11zQkZw89zNgWgKobKzrDMBFOYtAh0pAInZ9TSn7oA4Ctejouo5wUugmk8MrDtUVXmEA9
 7f9fgKYSwl/H7dfKKsS1bDOpyJlqhEAH94BHJdK/b1tzwJCFAXFhMlmlbYEk8kWjcxQgDWMu
 GAthQzSuAyhqyZwFcOlMCNbAcTSQawSo3B9yM9mHJne5RrAbVz4TWLnEaX8gA5xK3uCNCeyI
 sqYuzA4OzcMwnnTASvzsGZoYHTFP3DQwf2nzxD6yBGCfwNGIYfS0i8YN8XcBgEcDFMWpOQhT
 Pu3HeztMnF3HXrc0t7e5rDW9zCh3k2PA6D2NV4fews9KDFhLlTfCVzf0PS1dRVVWM+4jVl6l
 HRIAgWp+2/f8dx5vPc4Ycp4IsZN0l1h9uT7qm1KTwz+sSl1zOqKD/BpfGNZfLRRxrXthvvY8
 BltcuZ4+PGFTcRkMytUbMDFMF9Cjd2W9dXD35PEtvj8wnEyzIos8bbgtLrGTv/SYhmPpahJA
 l8hPhYvmAvpOmusUUyB30StsHIU2LLccUPPOwU0ETofVZwEQALlLbQeBDTDbwQYrj0gbx3bq
 7kpKABxN2MqeuqGr02DpS9883d/t7ontxasXoEz2GTioevvRmllJlPQERVxM8gQoNg22twF7
 pB/zsrIjxkE9heE4wYfN1AyzT+AxgYN6f8hVQ7Nrc9XgZZe+8IkuW/Nf64KzNJXnSH4u6nJM
 J2+Dt274YoFcXR1nG76Q259mKwzbCukKbd6piL+VsT/qBrLhZe9Ivbjq5WMdkQKnP7gYKCAi
 pNVJC4enWfivZsYupMd9qn7Uv/oCZDYoBTdMSBUblaLMwlcjnPpOYK5rfHvC4opxl+P/Vzyz
 6WC2TLkPtKvYvXmdsI6rnEI4Uucg0Au/Ulg7aqqKhzGPIbVaL+U0Wk82nz6hz+WP2ggTrY1w
 ZlPlRt8WM9w6WfLf2j+PuGklj37m+KvaOEfLsF1v464dSpy1tQVHhhp8LFTxh/6RWkRIR2uF
 I4v3Xu/k5D0LhaZHpQ4C+xKsQxpTGuYh2tnRaRL14YMW1dlI3HfeB2gj7Yc8XdHh9vkpPyuT
 nY/ZsFbnvBtiw7GchKKri2gDhRb2QNNDyBnQn5mRFw7CyuFclAksOdV/sdpQnYlYcRQWOUGY
 HhQ5eqTRZjm9z+qQe/T0HQpmiPTqQcIaG/edgKVTUjITfA7AJMKLQHgp04Vylb+G6jocnQQX
 JqvvP09whbqrABEBAAHCwWUEGAECAA8CGwwFAlVcpi8FCRmg08MACgkQyx8mb86fmYHNRQ/+
 J0OZsBYP4leJvQF8lx9zif+v4ZY/6C9tTcUv/KNAE5leyrD4IKbnV4PnbrVhjq861it/zRQW
 cFpWQszZyWRwNPWUUz7ejmm9lAwPbr8xWT4qMSA43VKQ7ZCeTQJ4TC8kjqtcbw41SjkjrcTG
 wF52zFO4bOWyovVAPncvV9eGA/vtnd3xEZXQiSt91kBSqK28yjxAqK/c3G6i7IX2rg6pzgqh
 hiH3/1qM2M/LSuqAv0Rwrt/k+pZXE+B4Ud42hwmMr0TfhNxG+X7YKvjKC+SjPjqp0CaztQ0H
 nsDLSLElVROxCd9m8CAUuHplgmR3seYCOrT4jriMFBtKNPtj2EE4DNV4s7k0Zy+6iRQ8G8ng
 QjsSqYJx8iAR8JRB7Gm2rQOMv8lSRdjva++GT0VLXtHULdlzg8VjDnFZ3lfz5PWEOeIMk7Rj
 trjv82EZtrhLuLjHRCaG50OOm0hwPSk1J64R8O3HjSLdertmw7eyAYOo4RuWJguYMg5DRnBk
 WkRwrSuCn7UG+qVWZeKEsFKFOkynOs3pVbcbq1pxbhk3TRWCGRU5JolI4ohy/7JV1TVbjiDI
 HP/aVnm6NC8of26P40Pg8EdAhajZnHHjA7FrJXsy3cyIGqvg9os4rNkUWmrCfLLsZDHD8FnU
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I keep getting the following warnings when testing gfs2.
This is with CONFIG_LOCKDEP=y.

[   12.210205] gfs2: fsid=sda2.0: first mount done, others may mount
[   20.014136] ------------[ cut here ]------------
[   20.014417] WARNING: CPU: 0 PID: 2154 at include/linux/backing-dev.h:251 __folio_mark_dirty+0x318/0x350
...
[   20.016969] Call trace:
[   20.017017]  __folio_mark_dirty+0x318/0x350
[   20.017088]  mark_buffer_dirty+0x8c/0x18c
[   20.017145]  gfs2_unpin+0x6c/0x434
[   20.017198]  buf_lo_after_commit+0x6c/0x90
[   20.017253]  gfs2_log_flush+0x3b8/0xd08
[   20.017310]  gfs2_kill_sb+0x3c/0x1fc


[   20.033440] WARNING: CPU: 0 PID: 2154 at include/linux/backing-dev.h:251 __folio_start_writeback+0x2f0/0x32c
[   20.033551] Modules linked in:
...
[   20.035108] Call trace:
[   20.035148]  __folio_start_writeback+0x2f0/0x32c
[   20.035210]  gfs2_aspace_writepage+0xdc/0x208
[   20.035268]  __gfs2_writepage+0x20/0xc8
[   20.035322]  write_cache_pages+0x70/0xe4
[   20.035381]  gfs2_ail1_flush+0x20c/0x600
[   20.035436]  gfs2_ail1_start+0x50/0x80
[   20.035490]  gfs2_log_flush+0xb40/0xd08
[   20.035544]  gfs2_kill_sb+0x3c/0x1fc


[   20.043396] WARNING: CPU: 1 PID: 79 at include/linux/backing-dev.h:251 __folio_end_writeback+0x368/0x40c
...
[   20.045083] Call trace:
[   20.045123]  __folio_end_writeback+0x368/0x40c
[   20.045195]  folio_end_writeback+0xec/0x140
[   20.045252]  end_buffer_async_write+0xe4/0x1a0
[   20.045311]  end_bio_bh_io_sync+0x34/0x74
[   20.045369]  bio_endio+0x184/0x26c
[   20.045422]  blk_update_request+0x230/0x4e4
[   20.045496]  scsi_end_request+0x30/0x40c
[   20.045554]  scsi_io_completion+0x48/0x5b4

This is seen all the way back to v6.1.y.

Would it be possible to get this fixed ? It should be easy to
reproduce by enabling lock debugging.

Thanks,
Guenter
