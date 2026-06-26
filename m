Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943963BFACF
	for <gfs2@lists.linux.dev>; Fri, 26 Jun 2026 21:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782509194; cv=none; b=h6cgLNFSgOB82y12GzwG38jYZ/iJpx6NGE5c1R7ymvcb8XlTI12Yi+qtRBM0snqfH1fsxV1U2IvovhHlRlwsvL9Yyqy3EItTRzHgSE0NVuIgwkUTIR5aWoRJNCWsPqOARyXaOeWIvsMKWy8tO2ij3u5BedvXgkqSvgQdEsM9M7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782509194; c=relaxed/simple;
	bh=u5lWhfL0fmWfmb1trbFXotZMK1xP2fJNScO3sxFIPTc=;
	h=Message-ID:Date:Subject:To:Cc:Content-Type:MIME-Version:From; b=elKz52OUd0DLtD932POaOQQe02CELr3LeWBYPUs002hbltCD0fwcf9zhAhp5f++yqFnnnEq0U5kY82PhMIA1y6snxstf5LzaK7gCDBoRyasfGscDcSaQV9mn2FCPGOkV2p/7Dip99u3u+6STYREhoj4CVh1XoeU2XzqeMAti/LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SJOAeZvJ; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SJOAeZvJ"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5ab02fb66easo40617e0c.0
        for <gfs2@lists.linux.dev>; Fri, 26 Jun 2026 14:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782509192; x=1783113992; darn=lists.linux.dev;
        h=from:mime-version:content-transfer-encoding:content-type:cc:to
         :subject:date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u7TLADTxBmGPePdQh3oBcsyeSM3cjpv6K4YkLZhYvM0=;
        b=SJOAeZvJJp1FCej+K7taj6ULdDfKnjDEVXqMZrljhbsjMjKaz0vd1LxEPNHEpXDjIY
         WLbHYq3ZsZp2dhpQwJVQUmo/7NK7Rrz8YnITevpoYS6AyIBhi+T15MGLfA8soqX2vNbO
         WittY/NY11dpMAYj1yHrmcjC/+DzR6Dn2ERdxEJtUk8LktXLk0S81MQWQaiR3IAW6Iy2
         agpL3bSrBngERt7WPeNDX5k76UDKzzzc8yHoBw9w7POY9bkMYeR5lHwRcb9y5k5KPag5
         iqn7d4/eUurG+VauiXZ1mdB7PpEBpewqAJRIzpz6naP1G+LoBrxf6BXkuerdEcuT0kkt
         LMSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782509192; x=1783113992;
        h=from:mime-version:content-transfer-encoding:content-type:cc:to
         :subject:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=u7TLADTxBmGPePdQh3oBcsyeSM3cjpv6K4YkLZhYvM0=;
        b=N/PSOSqf3C59V0VjYaW06/SNbvHWpoTAjkBYHLfYPv0L1qQBoRFQcWfQTfuYLfpWsU
         FrSlGPEH+zlb6x6+RMw4q9f2dOm2YrGVTbW/+9yj6yB1/DAnj68d7BfRGb70N/t1BVu1
         XQFhNK0HINNGKmOzYZNm1elKLjlLICzDCicQ9qUTTaMfm5PEhvAFOnISJPWUGKiZ6QQx
         9693CAqwLyeMo9cB+UW9h5UPcXqtCa5kd5gzGbS+EWycR3X3z4D1RG+7Y7DDk+wxfHfT
         fTJBGGVZKm9i5ZyuxSTdO3m02DpjoZssjsy1gNVLz9Q1UFOUO6cKCG9XUvNkvZdxiDuF
         SCbw==
X-Forwarded-Encrypted: i=1; AHgh+Rr3FprjQgdqDDivhPWVKJRx5i1UtAoerxlB1llfNWKl9pJfVaSRNUSjhXkVowgTExpF46jM@lists.linux.dev
X-Gm-Message-State: AOJu0Yx+Ff2QtQrYBaDxviokWY2D65t4TxkGbRYWtSggv+eFvD8afPCb
	JEK133e8cA8J1/wFYw8IKKnpRKJwBXOCAHJFSPoUBXzb58KE8XBIWFsJ
X-Gm-Gg: AfdE7cmk27j0sXSjfGuJKcCNppsMXAIt4hWEFi1Ewf/zY6YVEN8u58oActIeqwxJA+H
	5Gt5vQAIS8ACRdMh0DR/WUueFGMbgnGTbL1+d5+rriwRC/0pJzhOO0aYBSsRkQE0VvFldfBwxvn
	TiHPHnezrBKwxV9pmh7OhiUdKLhuaqspZRazr3wRmYg8L2pBH1VW22F/obEGsT/Ee/9TjsxxA24
	9pnoiad/DyRY+Mb9UuNnuLUbdk7YdAea8/op9RnGGkvCquDGOZQfHXRrwxjA8tSWu0seFRrWca+
	DLYTgUprgeeVgUCmSOQiVpCAhRQBTxVccs/m/FXHc4Ylu9Nf7fQ+nki25v/GKw3chd0c2dqp7yy
	fh7BFEwYSwSmAhWJB7wXuBQJwWbPC8/qNB8gRYEaNB7DQlY41RIR61NCJoqEZqhmP7o+GLedPgY
	G6s1OzqJoG0MYyC2xJTTwMTzlqmZN3OyGnQ8i1wvC683d2ZXurdxNb3Y9kPiraLHLBvhXwSxpFN
	I/kVpC7akR25VqIdqCWl6A=
X-Received: by 2002:a05:6102:304c:b0:726:c60b:e9d3 with SMTP id ada2fe7eead31-73435c8bb7dmr1562333137.3.1782509192551;
        Fri, 26 Jun 2026 14:26:32 -0700 (PDT)
Received: from [192.168.10.115] ([132.170.207.48])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-96916e88e59sm1899309241.6.2026.06.26.14.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 14:26:32 -0700 (PDT)
Message-ID: <6a3eee88.87857ece.10923b.6809@mx.google.com>
Date: Fri, 26 Jun 2026 14:26:32 -0700 (PDT)
Subject: invalid opcode in do_qc
To: agruenba@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: syzkaller@googlegroups.com, contact@pgazz.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: sanan.hasanou@gmail.com

Good day, dear maintainers,

We found a bug using a modified version of syzkaller.

Kernel Branch: 7.0-rc1
Kernel Config: <https://drive.google.com/open?id=1pN21FuDB9QSbn_3jaZGO1S5v7x7Qe-yl>
Unfortunately, we don't have any reproducer for this bug yet.
Thank you!

Best regards,
Sanan Hasanov

gfs2: fsid=syz:syz.0: found 1 quota changes
gfs2: fsid=syz:syz.0: fatal assertion failed
Oops: invalid opcode: 0000 [#1] SMP KASAN
CPU: 1 UID: 0 PID: 23411 Comm: syz.9.2470 Tainted: G             L      7.0.0-rc1 #1 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:__qd_hold fs/gfs2/quota.c:320 [inline]
RIP: 0010:do_qc+0x5bc/0x5d0 fs/gfs2/quota.c:706
Code: 00 00 00 00 00 fc ff df 48 8b 0c 24 80 3c 01 00 74 0a 48 8b 7c 24 10 e8 22 8b 2b fe 48 8b 44 24 10 48 8b 38 e8 35 66 33 fd 90 <0f> 0b e8 ad fe c7 fd 48 8b 7c 24 10 e8 23 66 33 fd 90 0f 0b f3 0f
RSP: 0018:ffffc9000cc679c8 EFLAGS: 00010246
RAX: 000000000000002c RBX: 1ffff110034ec50a RCX: 9a6c65fb1fe81500
RDX: ffffc90012400000 RSI: 0000000000001797 RDI: 0000000000001798
RBP: ffffffffffffffff R08: ffffc9000cc67747 R09: 1ffff9200198cee8
R10: dffffc0000000000 R11: fffff5200198cee9 R12: ffff88801a7627e0
R13: ffff88801a762850 R14: ffff88801a762870 R15: 0000000000000000
FS:  00007f9a12a336c0(0000) GS:ffff8880be7b6000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b32323ffc CR3: 000000003a30d000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 gfs2_quota_change+0x38c/0x800 fs/gfs2/quota.c:1305
 setattr_chown+0x418/0x560 fs/gfs2/inode.c:2072
 gfs2_setattr+0x217/0x3f0 fs/gfs2/inode.c:2124
 notify_change+0xc00/0xf10 fs/attr.c:556
 chown_common+0x441/0x670 fs/open.c:778
 vfs_fchown fs/open.c:843 [inline]
 ksys_fchown+0xe6/0x160 fs/open.c:855
 __do_sys_fchown fs/open.c:860 [inline]
 __se_sys_fchown fs/open.c:858 [inline]
 __x64_sys_fchown+0x7a/0x90 fs/open.c:858
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x11c/0x800 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x4b/0x53
RIP: 0033:0x7f9a11ba3b6d
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f9a12a33018 EFLAGS: 00000246 ORIG_RAX: 000000000000005d
RAX: ffffffffffffffda RBX: 00007f9a11e15fa0 RCX: 00007f9a11ba3b6d
RDX: 000000000000ee01 RSI: 0000000000000000 RDI: 0000000000000004
RBP: 00007f9a11c47c3e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f9a11e16038 R14: 00007f9a11e15fa0 R15: 00007ffd820de320
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__qd_hold fs/gfs2/quota.c:320 [inline]
RIP: 0010:do_qc+0x5bc/0x5d0 fs/gfs2/quota.c:706
Code: 00 00 00 00 00 fc ff df 48 8b 0c 24 80 3c 01 00 74 0a 48 8b 7c 24 10 e8 22 8b 2b fe 48 8b 44 24 10 48 8b 38 e8 35 66 33 fd 90 <0f> 0b e8 ad fe c7 fd 48 8b 7c 24 10 e8 23 66 33 fd 90 0f 0b f3 0f
RSP: 0018:ffffc9000cc679c8 EFLAGS: 00010246
RAX: 000000000000002c RBX: 1ffff110034ec50a RCX: 9a6c65fb1fe81500
RDX: ffffc90012400000 RSI: 0000000000001797 RDI: 0000000000001798
RBP: ffffffffffffffff R08: ffffc9000cc67747 R09: 1ffff9200198cee8
R10: dffffc0000000000 R11: fffff5200198cee9 R12: ffff88801a7627e0
R13: ffff88801a762850 R14: ffff88801a762870 R15: 0000000000000000
FS:  00007f9a12a336c0(0000) GS:ffff8880be7b6000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b32323ffc CR3: 000000003a30d000 CR4: 00000000000006f0

<<<<<<<<<<<<<<< tail report >>>>>>>>>>>>>>>
