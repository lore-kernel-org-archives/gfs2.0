Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB50248869
	for <gfs2@lists.linux.dev>; Thu, 24 Jul 2025 12:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753359072; cv=none; b=ldUFbmVUlGxIZCfgZA6F/vj1ZbuP2zeUnODk4uENF/8/w6irfUWF96JKfq06k11U33o8WdjedB7Z9vUniHSiiFg2r1wII2WlnO0qnTcUPHthM5rGOWUDX1jPwoJAg+PYykIhZnLYHsIkR0gPZsCDrQmGYAuRnnzb0kJYmDvc/Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753359072; c=relaxed/simple;
	bh=UxsS2GjHcScoiiigsJgJiik/r8vQ5BSRyqxBk1r1+DI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pJQIcszK3Lyqw/elIXHW8M8J0E6spGhBZJJYBvC7bOi4tyGR31febdNu1lNneNO24oRvDeqH0JhUup4EAAXhQidfymiN224i+GfPSa+z6RgghhuODDhJrrgCgFIyxDEeb0hvLj6wHeMj5gQK9XBu/YGQuxLZtMB8liDiyqGd+tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=URcCBSV5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="URcCBSV5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753359069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5mkKNHB1ujzJMQ37K0nRPi6hxxvezhtgPMBlD0jPTNs=;
	b=URcCBSV5P+8YxmWXNg7cq0ihivASl4IoZ0lZyO4rvUGr8epn5U6OGAZaF4V4SuFt/c9+L+
	KYw0+7Q6a/QDE+91qxe04r77cJQbW0UoX05wGkDL1V1Xn5fZNvYWhXUM+ZVk8EWDnQb62h
	snN/KHz+b4g5n/kv/TGF5WojtM6y3kQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-lS18MXZiP3WH-pvB3phZzw-1; Thu, 24 Jul 2025 08:11:08 -0400
X-MC-Unique: lS18MXZiP3WH-pvB3phZzw-1
X-Mimecast-MFC-AGG-ID: lS18MXZiP3WH-pvB3phZzw_1753359067
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3b7737aed7bso62338f8f.3
        for <gfs2@lists.linux.dev>; Thu, 24 Jul 2025 05:11:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753359067; x=1753963867;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5mkKNHB1ujzJMQ37K0nRPi6hxxvezhtgPMBlD0jPTNs=;
        b=QVW3PWppq5pFRG6spENaZmYEVaiYYDIpUNtJ78CpopSeqOyD2LHyKJiLIbkk2iqF06
         CXBIm7wEq/pVcWgvRrKC8cYOTv6WJNw1JX0tvdOC+xubIPPRbRZzGcK22puaKKvpX4Hu
         IXzU/7z2u0zC8dFA3u9y9FXmVxVMBRaJlGeLmKr047hQ0co9Y0eIEWTCwnvi3uJbVLSj
         pUajlBaG8fYup2WK78vTU4w6sImQ+YRtZpjU7Xx8cCtByjDkYREolQp091/DAiJ8z/t8
         5l1FQiKKiwBM5Jcjzu8XmWYeVKgRW9qqFaxWazwjKePqzUheYZIVVr5YbcB0JhZfkElx
         1cTA==
X-Forwarded-Encrypted: i=1; AJvYcCUQM+qW0KcfVnjtOzRxxvZhU0aqklxQDEQ20dXgnSAOq0QtthdWOT180VhAVmLj7ROqa/EK@lists.linux.dev
X-Gm-Message-State: AOJu0YwIS/LsiGmEhAo18nM1cIdcEtGrxJQSv1fYumHK4x8urmU2mY1r
	L22rqx6wBkv5uOfaL9k3sHH0sCNzfZ0jdhZNE1RTKFt519q6g0nmM5+LVK083pkojoX29Rqg6Iz
	kbp8RQyccMJ2KNj6upZXNidELNv0QikoTE222Yj3pIh0u2ug248nFZ4k=
X-Gm-Gg: ASbGncsqcM4FM1TEzqMiOxa1ZeKzQENtMFNuMB+O9Hj55eVIPM8ev8Vsf3WwjF0zSmv
	Y2B8Ar/i+dcgnLvt7yaxBKmGylWuzvJDy/YLestfYnqDXCXIzNWAjbREo/FFrYct4eKfCcftXkP
	wvYijhdqWgnECkFcjUvYYH613dhkwO8+O1OHYO4h/TrIH7TdMEnuFBfV08O8dP5fmVwlmkggnDp
	2ktK1X4JM4Gu8NROHB2gxsBIQTdZGGi5/xHks2rrUCPgI1hW9Y6BIeperjg06jIIz7ieVhpCzDu
	ut90+fTmUEHEmdTAYwovFCQMKhSTbrub2xqZrJGPbRKJDCfKPKsIDQgbBsBZJrD44R/voiAEqEG
	Y39CX5Gx8oFHiI4n9WCecUhw=
X-Received: by 2002:a05:6000:1886:b0:3a5:27ba:479c with SMTP id ffacd0b85a97d-3b768effafdmr5361208f8f.43.1753359067066;
        Thu, 24 Jul 2025 05:11:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqEH23+Rs8PjWmI9mi/mJrpP114BgbVWsJt01naHoZe9YaHAc0Dr+Zfm3Qw2dd4ZeDKZbtRw==
X-Received: by 2002:a05:6000:1886:b0:3a5:27ba:479c with SMTP id ffacd0b85a97d-3b768effafdmr5361179f8f.43.1753359066657;
        Thu, 24 Jul 2025 05:11:06 -0700 (PDT)
Received: from [192.168.1.167] (cpc76484-cwma10-2-0-cust967.7-3.cable.virginm.net. [82.31.203.200])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b76fc6055dsm2054443f8f.7.2025.07.24.05.11.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 05:11:05 -0700 (PDT)
Message-ID: <c6a5d07d-4c00-4047-b86f-cce27177e353@redhat.com>
Date: Thu, 24 Jul 2025 13:11:05 +0100
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [gfs2?] KASAN: slab-use-after-free Write in
 gfs2_qd_dealloc (3)
To: syzbot <syzbot+42a37bf8045847d8f9d2@syzkaller.appspotmail.com>,
 agruenba@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <68821f8f.a00a0220.2f88df.0024.GAE@google.com>
From: Andrew Price <anprice@redhat.com>
In-Reply-To: <68821f8f.a00a0220.2f88df.0024.GAE@google.com>
X-Mimecast-Spam-Score: 1
X-Mimecast-MFC-PROC-ID: 4O-YF_hmms0MotnJnGydqOAhZasmYoHkhfQcvsn6QXU_1753359067
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/07/2025 12:57, syzbot wrote:
> Hello,
> 
> syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> WARNING in move_to_new_folio
> 
> ------------[ cut here ]------------
> gfs2_meta_aops does not implement migrate_folio

This is a separate issue, fixed in for-next.

Andy

> WARNING: CPU: 0 PID: 30 at mm/migrate.c:944 fallback_migrate_folio mm/migrate.c:942 [inline]
> WARNING: CPU: 0 PID: 30 at mm/migrate.c:944 move_to_new_folio+0x696/0x7a0 mm/migrate.c:996
> Modules linked in:
> CPU: 0 UID: 0 PID: 30 Comm: kcompactd1 Not tainted 6.16.0-rc7-syzkaller-g25fae0b93d1d-dirty #0 PREEMPT(full) 
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> RIP: 0010:fallback_migrate_folio mm/migrate.c:942 [inline]
> RIP: 0010:move_to_new_folio+0x696/0x7a0 mm/migrate.c:996
> Code: 0d 01 90 42 80 7c 3d 00 00 74 0a 48 8b 7c 24 20 e8 2f 53 fe ff 48 8b 44 24 20 48 8b 30 48 c7 c7 20 bb 97 8b e8 bb b7 5e ff 90 <0f> 0b 90 90 49 bf 00 00 00 00 00 fc ff df e9 7e fd ff ff e8 62 d2
> RSP: 0018:ffffc90000516fd0 EFLAGS: 00010246
> RAX: daec11f2299abc00 RBX: ffffea000100abc0 RCX: ffff888030f88000
> RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000002
> RBP: 1ffff1100887b921 R08: 0000000000000003 R09: 0000000000000004
> R10: dffffc0000000000 R11: fffffbfff1bfaa6c R12: ffffea00014e3d40
> R13: ffff8880443dc7e8 R14: ffffea000100abc8 R15: dffffc0000000000
> FS:  0000000000000000(0000) GS:ffff88808d218000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fce2e39a000 CR3: 0000000057fda000 CR4: 0000000000352ef0
> Call Trace:
>  <TASK>
>  migrate_folio_move mm/migrate.c:1301 [inline]
>  migrate_folios_move mm/migrate.c:1653 [inline]
>  migrate_pages_batch+0x1c34/0x2830 mm/migrate.c:1900
>  migrate_pages_sync mm/migrate.c:1930 [inline]
>  migrate_pages+0x1bcc/0x2930 mm/migrate.c:2039
>  compact_zone+0x23f4/0x4ad0 mm/compaction.c:2683
>  compact_node+0x1d2/0x280 mm/compaction.c:2952
>  kcompactd+0xbc8/0x1290 mm/compaction.c:3250
>  kthread+0x70e/0x8a0 kernel/kthread.c:464
>  ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>  </TASK>
> 
> 
> Tested on:
> 
> commit:         25fae0b9 Merge tag 'drm-fixes-2025-07-24' of https://g..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=12eac0a2580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=8adfe52da0de2761
> dashboard link: https://syzkaller.appspot.com/bug?extid=42a37bf8045847d8f9d2
> compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
> patch:          https://syzkaller.appspot.com/x/patch.diff?x=118ee0a2580000
> 

