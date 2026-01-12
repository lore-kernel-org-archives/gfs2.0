Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B562F39A3
	for <gfs2@lists.linux.dev>; Mon, 12 Jan 2026 19:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768245186; cv=none; b=derOwHd1fMJJx2TGFRXR/YCT7L32/b+xIXVLcEfR14EIArdYhxuUILcyvSDjJZ4rOnjYEprHXqtvgKbggy2LJHyUNayDDvVEi8ZMCFUxgs7Xf/cZgBVTnL96DtvengWDPrLM9GIDBanMQ/A1XCJJBjePmnpvErVAHNKOh8TF3eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768245186; c=relaxed/simple;
	bh=GzJ6XVWa2r4zVf7krtugyMXldgpLAfA6hmjcVRijFUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=G5ukjvOX6uySJe7SvOcSlZ18nK/kJTyJ8DLFHhRU7cxJGRs4R6JxCjoyCu074+wWjBbjQSpHE1sVSJ76M911un8UWw0NnfjjwDKAGDZCOIeJRD/RF+dSmn3uHNVnA9YuFKvdw5AlAuD+nhYCtoOspvma1m1sVrFvNLRSVlu2nNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XNBJq94j; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XNBJq94j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768245184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B/LS3+D2+0JGACQST8G26iX5o4ix4SU35Pj9rPbsm5Y=;
	b=XNBJq94jKpJGgSRB9PTnXm3ClfwfZozIRjkm06efnEER9N+YvWsyH4WYgtYh9FbkWIsaWZ
	SDrBTgBT4Y6whmKAXUPmPDWlKWhvT/Qb1vJQ9u3+kef/A8p3EqxT0sq6z+lc5meti8SqVe
	6P4iE0GDVmeu9sj7XFSLbM51kkcw93w=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465--n-MFiMuOHiflJKuBcRfLw-1; Mon, 12 Jan 2026 14:12:54 -0500
X-MC-Unique: -n-MFiMuOHiflJKuBcRfLw-1
X-Mimecast-MFC-AGG-ID: -n-MFiMuOHiflJKuBcRfLw_1768245173
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47d5bd981c8so46574315e9.0
        for <gfs2@lists.linux.dev>; Mon, 12 Jan 2026 11:12:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768245173; x=1768849973;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B/LS3+D2+0JGACQST8G26iX5o4ix4SU35Pj9rPbsm5Y=;
        b=gNA3T3tpgDzq1vv0OUqA3l8iUz+PDC6wrFG9MkGEjZQSVJvv/T0ulfci4boxkrZeTF
         cm3SmcaHcRTBi2jzk4mg6CHqneKp3cxIAspoMWAi+4pPb+4A2SFwrpUVYdhcWO9pxFTK
         op865JWI8Wi4s+OO3HdgYCs8WCkAa/93Q9igcwxwOEq2TM+DLDb8yQrO/Hd0yzhUnFIE
         HCzq6WVeluCLvonxLQvbU0i9Z2X9SODPl3A6U5tG/w664l5GRluBZBcG0RI9RAELLR1D
         gJZnZ3zFf12wGXmYDPoB15oVxRHtIAa2GyQgR/5d0yIcL+OJKMWBVGZqVAUeA3C/lFWg
         2FeA==
X-Forwarded-Encrypted: i=1; AJvYcCXgEtBltPnfhY59AsGJeimgDYRTlQu+V5M9dJn11Bzyy/PDPs60fUbI7va1KVauEahxZkTf@lists.linux.dev
X-Gm-Message-State: AOJu0Yx28FmplP1PfbRDPUfKWRmcsoXgqRBKdv9ROCbzKOcDxIFig7CC
	tZK2+rCAa33ZLFQAC73rrkKg4v4bbYSu0Xgy/uFoTjgd9j32X7liWwGiHL6AY0NCSkINL3/a90r
	r6Rzk3BtEe6VTjCYqPj/hJ5AcR0aIsCrLhkfsAqGhrePCAXjT05iVu3c=
X-Gm-Gg: AY/fxX5MWGsGuoOsLA31bkQJqLhsxnm2R1l6/iH/6PyTFHNcLHGhtO2uf5TrbLK3ctG
	EQdknCKflbwDoodsXBTnmObKpxPuxbENHwKdGSyrPI6lJIbMHtkSxE91PZapsmQOf8g0yQQ61AR
	J43igm0B59ZRIiRGTZsQwJbQiHuO7p/zjlWk5v458cMWcWzkRDQKNNojuW3ll/3xK69NA3EicAY
	FvRyoYOw+DkqMldomxcfTdOZo4EndaQ7XeTzY9tK0Qx0QGAqIASHmPavMyhC1o0q2aEiNB78wj5
	TizODHOGsM4YaDzUGalyqqDONCbXSJdLR4BvbsXD+6hJR3l8BrQAgbN9qsWCF0T7Qsiy8QfOsmK
	8dI933hqumiEaMfyeJ3tBl4kQUsvZq1ST3/NcppVo7x0Enkk9g7FJ5+hgJ8hW+gk5AMuovw==
X-Received: by 2002:a05:600c:500d:b0:476:d494:41d2 with SMTP id 5b1f17b1804b1-47d84b3bc37mr166004745e9.29.1768245173363;
        Mon, 12 Jan 2026 11:12:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFDfgCZHyxfDNzopCdhCdbmTHkg1Lro5Bs5rh2uwlheYxWEnkW5GyIfRIOS+fD5ZOP1ovVcXg==
X-Received: by 2002:a05:600c:500d:b0:476:d494:41d2 with SMTP id 5b1f17b1804b1-47d84b3bc37mr166004565e9.29.1768245172924;
        Mon, 12 Jan 2026 11:12:52 -0800 (PST)
Received: from [192.168.1.167] (cpc76484-cwma10-2-0-cust967.7-3.cable.virginm.net. [82.31.203.200])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d8717a48asm141719035e9.8.2026.01.12.11.12.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jan 2026 11:12:52 -0800 (PST)
Message-ID: <bfe98f76-2c8a-4bb9-a37a-f9b184a9621f@redhat.com>
Date: Mon, 12 Jan 2026 19:12:51 +0000
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [gfs2?] WARNING in rgblk_free (2)
To: syzbot <syzbot+3e2c95229d1ab81a0bfd@syzkaller.appspotmail.com>,
 gfs2@lists.linux.dev, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <69651807.050a0220.eaf7.00b2.GAE@google.com>
From: Andrew Price <anprice@redhat.com>
In-Reply-To: <69651807.050a0220.eaf7.00b2.GAE@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PwvW6qLiAGI192DuwJ2ovYsWl5-mflcBJGq8RxOy3EE_1768245173
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/01/2026 15:49, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    54e82e93ca93 Merge tag 'core_urgent_for_v6.19_rc4' of git:..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1216e5fa580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=513255d80ab78f2b
> dashboard link: https://syzkaller.appspot.com/bug?extid=3e2c95229d1ab81a0bfd
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11b4bc3a580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1015b922580000
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-54e82e93.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/f3befb5f53a4/vmlinux-54e82e93.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/92820ca1dbd8/bzImage-54e82e93.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/074df7c33445/mount_0.gz
>   fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=10da39fc580000)
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+3e2c95229d1ab81a0bfd@syzkaller.appspotmail.com
> 
> gfs2: fsid=syz:syz.0: first mount done, others may mount
> gfs2: fsid=syz:syz.0: found 1 quota changes
> ------------[ cut here ]------------
> WARNING: fs/gfs2/rgrp.c:2267 at rgblk_free+0x136/0x750 fs/gfs2/rgrp.c:2267, CPU#0: syz.0.17/5483

The test is scribbling on an rindex entry's ri_data0.

#syz test

--- a/fs/gfs2/rgrp.c
+++ b/fs/gfs2/rgrp.c
@@ -871,11 +871,15 @@ static int rgd_insert(struct gfs2_rgrpd *rgd)
                                                  rd_node);
 
                parent = *newn;
-               if (rgd->rd_addr < cur->rd_addr)
+               if (rgd->rd_addr < cur->rd_addr) {
+                       if (rgd->rd_data0 + rgd->rd_data > cur->rd_addr)
+                               return -EUCLEAN;
                        newn = &((*newn)->rb_left);
-               else if (rgd->rd_addr > cur->rd_addr)
+               } else if (rgd->rd_addr > cur->rd_addr) {
+                       if (rgd->rd_addr < cur->rd_data0)
+                               return -EUCLEAN;
                        newn = &((*newn)->rb_right);
-               else
+               } else
                        return -EEXIST;
        }
 
@@ -944,7 +948,8 @@ static int read_rindex_entry(struct gfs2_inode *ip)
                return 0;
        }
 
-       error = 0; /* someone else read in the rgrp; free it and ignore it */
+       if (error == -EEXIST)
+               error = 0; /* someone else read in the rgrp; free it and ignore it */
 fail_glock:
        gfs2_glock_put(rgd->rd_gl);
 

