Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF402CCC5
	for <gfs2@lists.linux.dev>; Tue, 15 Jul 2025 12:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752582268; cv=none; b=EPemvnhElpK0L7f08ltH58cO+QcB/uN6raahKXKYOLBfekd9LYqYCqw1gGRDTOLId8MO9QwIuzV5PZqJX6Trt7+z9p1r2lA1yAci1fx1uqtSg+bNnwDRkqma1fiF9NRHgAxjv5wSr04sxO+9fwUOs6Oa3HWlQE2x6D93HzWAqnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752582268; c=relaxed/simple;
	bh=rEiRHG6HAIbV2ucrb6G23Zk+2pFp866wDOUcKdTyO7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=dtHQ1j/fA4PP7MvkjJRuoKFbJzGJIRHcKzjf1FbbvdvoPpu22H3uM94ZX10NF5rkaqBX4Y3CTlJe2YRqN3R8L0Vkpr4f4mE9MxlMXt52WmNxEDHfGcqFFeoGSb0vDv6KWF+BFEBTd3ashTWFyISoWIQXXg/6sTUny1uU5CPjEIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z80kQLT3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z80kQLT3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752582264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vMV0xsqHJ0j7LmZPmZF2apPJfGJJxrjk32U1PoKgpWk=;
	b=Z80kQLT3kEUr2UiK33Ngv3iR01eUvGjj4+97DoKXKpwGi0w+F2JdyNikwARacuOzbFyxuU
	4R8HJKxgvg8DSGjkuqJQA5iRAZJ7dNRn+zgebAZKt5PirEGTlV1kXTbwrAiiTUScLea0Ej
	ECBulu7DVoyEMiG3qrT8n33w0PlJsOk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-QjzvYcVuPgSl2_bt3iA8TA-1; Tue, 15 Jul 2025 08:24:23 -0400
X-MC-Unique: QjzvYcVuPgSl2_bt3iA8TA-1
X-Mimecast-MFC-AGG-ID: QjzvYcVuPgSl2_bt3iA8TA_1752582262
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-455e918d690so19027325e9.1
        for <gfs2@lists.linux.dev>; Tue, 15 Jul 2025 05:24:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752582262; x=1753187062;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vMV0xsqHJ0j7LmZPmZF2apPJfGJJxrjk32U1PoKgpWk=;
        b=wZM1sG5vDPhuM+HwFTWEVuqxNa5JNIWzzQDj6e+GPzaBMW95TCPT8U40LZlwf3eWXA
         Km8sGZWDV4vCByu2ObL16o8wqUjhANSfLZ8ZTd8T2lmo+D/ktezKSOGNEAQzgcBeDJtJ
         dJL5MLHa6XFTWM+bs38cRDO1EFUgeT/yzg96jOhq4xaYzi5fkPoU3qT5c2CYrASw/RsE
         D5ZGFT5dHqJYC58+Pcug8uYgnwUbSmY10Np4C4pzTdenQkCrw4GTe95UDOhgpu/X6E5H
         t09HkbUsJwaJWa9HsjHrxB+tohzCFoSE+dvCr0arHxBFnSf8RPOsR/VzLebDoqTLCZJn
         IUkw==
X-Forwarded-Encrypted: i=1; AJvYcCVwthqTpf+roAmKl/d6xzevuClthoxueUx+F0wVsydCJ6bcEs65cbHLlOE3Hyp5ogybU55U@lists.linux.dev
X-Gm-Message-State: AOJu0YyzTMr8kz4V67b30Rcdg8Aelyin1x/WFbHtwf62SVxL/MdjmO4G
	zswBdBh8hISP0iS9oqCazju/A6G+626wSKKTWJuw9xY34h6p17iZd7IDyhOTtja+7l07efD0rJc
	+U/UCJNfAtTCYsVrTFdLyBH+aqVSuoPld883IVwKPCQNnMe2b27TXYRM=
X-Gm-Gg: ASbGncv8qgavgiyTAdmobCV1SjssqSppxUkXTEV7E+EqzYwu1KDMXYtk68BZRc9ZlwN
	CZxy60rzDu7rPQgFq4hn8M2N9HeY/H3ZGZ5fGoZSzGW4wXaPq/qURytKvVoUvkqjstJ4oIoL3F1
	UkyC8HrmaPytf2nHA1v47IToFXcUPhq6yeXTGqmL5EgdCT7+ryFQiRd+2H8ZuYPAwX9XDPIXQLQ
	F/gxTjhXzfIJahbFKScFbRBBMnPoAXSsqcmilVUBxpoScHeUldAsU9otsdIeFvn+maN8eGcAIGM
	uPuOrjjcYmAK+rExp6VQuTMFJSrWkfin4woajdK2Y25s7oqSGyp+iBzNz+uCWfctTttPwuiIvI3
	GknGgbBb2zHMoDw4vBIwCZ60=
X-Received: by 2002:a05:600d:108:20b0:456:12ad:ec3d with SMTP id 5b1f17b1804b1-45625e79ac3mr20290395e9.14.1752582261827;
        Tue, 15 Jul 2025 05:24:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOecdjNw5cygsLqVU0X3EgZ+tzI9ZGCUAttic2DhZnOH00RJdRSeI42fAVJ674raEM/LllZg==
X-Received: by 2002:a05:600d:108:20b0:456:12ad:ec3d with SMTP id 5b1f17b1804b1-45625e79ac3mr20290235e9.14.1752582261350;
        Tue, 15 Jul 2025 05:24:21 -0700 (PDT)
Received: from [192.168.1.167] (cpc76484-cwma10-2-0-cust967.7-3.cable.virginm.net. [82.31.203.200])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4560eb98a40sm90807825e9.27.2025.07.15.05.24.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 05:24:20 -0700 (PDT)
Message-ID: <76704579-e2a1-4000-8d0c-b3ccd429870d@redhat.com>
Date: Tue, 15 Jul 2025 13:24:19 +0100
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [gfs2?] UBSAN: shift-out-of-bounds in gfs2_dir_read (2)
To: syzbot <syzbot+4708579bb230a0582a57@syzkaller.appspotmail.com>
References: <68754d09.a70a0220.5f69f.0001.GAE@google.com>
Cc: syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org,
 gfs2@lists.linux.dev, agruenba@redhat.com
From: Andrew Price <anprice@redhat.com>
In-Reply-To: <68754d09.a70a0220.5f69f.0001.GAE@google.com>
X-Mimecast-Spam-Score: 1
X-Mimecast-MFC-PROC-ID: aIVWdRdfInVxnP6G6EOhq7UBj3h-ZOqwMuiusJZyBKI_1752582262
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/07/2025 19:31, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    347e9f5043c8 Linux 6.16-rc6
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=11afb18c580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f62a2ef17395702a
> dashboard link: https://syzkaller.appspot.com/bug?extid=4708579bb230a0582a57
> compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=172470f0580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16d0fd82580000
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-347e9f50.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/49ae91eb36e0/vmlinux-347e9f50.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/78497f74bd6b/bzImage-347e9f50.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/2445b7dba270/mount_0.gz
>   fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=15d7918c580000)
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+4708579bb230a0582a57@syzkaller.appspotmail.com
> 
> gfs2: fsid=syz:syz: Now mounting FS (format 1801)...
> gfs2: fsid=syz:syz.s: journal 0 mapped with 5 extents in 0ms
> gfs2: fsid=syz:syz.s: first mount done, others may mount
> ------------[ cut here ]------------
> UBSAN: shift-out-of-bounds in fs/gfs2/dir.c:1544:15
> shift exponent 32 is too large for 32-bit type 'u32' (aka 'unsigned int')
> CPU: 0 UID: 0 PID: 5508 Comm: syz.0.16 Not tainted 6.16.0-rc6-syzkaller #0 PREEMPT(full) 
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
>  ubsan_epilogue+0xa/0x40 lib/ubsan.c:233
>  __ubsan_handle_shift_out_of_bounds+0x386/0x410 lib/ubsan.c:494
>  dir_e_read fs/gfs2/dir.c:1544 [inline]
>  gfs2_dir_read+0x1730/0x1780 fs/gfs2/dir.c:1585
>  gfs2_readdir+0x14c/0x1b0 fs/gfs2/file.c:116
>  iterate_dir+0x5ac/0x770 fs/readdir.c:108
>  __do_sys_getdents64 fs/readdir.c:410 [inline]
>  __se_sys_getdents64+0xe4/0x260 fs/readdir.c:396
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f9672d8e929
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffd2be2c848 EFLAGS: 00000246 ORIG_RAX: 00000000000000d9
> RAX: ffffffffffffffda RBX: 00007f9672fb5fa0 RCX: 00007f9672d8e929
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000004
> RBP: 00007f9672e10b39 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007f9672fb5fa0 R14: 00007f9672fb5fa0 R15: 0000000000000003
>  </TASK>
> ---[ end trace ]---
> 
> 
> ---
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
> 

#syz test

--- a/fs/gfs2/glops.c
+++ b/fs/gfs2/glops.c
@@ -450,6 +450,10 @@ static int gfs2_dinode_in(struct gfs2_inode *ip, const void *buf)
                gfs2_consist_inode(ip);
                return -EIO;
        }
+       if ((ip->i_diskflags & GFS2_DIF_EXHASH) && depth < ilog2(sdp->sd_hash_ptrs)) {
+               gfs2_consist_inode(ip);
+               return -EIO;
+       }
        ip->i_depth = (u8)depth;
        ip->i_entries = be32_to_cpu(str->di_entries);
 


