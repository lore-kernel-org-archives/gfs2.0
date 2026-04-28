Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4501A6822
	for <gfs2@lists.linux.dev>; Tue, 28 Apr 2026 04:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777349121; cv=none; b=ZRMWg+1/q2UjRmKeHhhM/CU9kneWDf60zKOkKIE2G1AX5LFFNw4ZedZOZ1yb2KtkXPn6zEfhJosNx6ldcW0c0HX7qUozQ7OsEuaRc7W6iU/7SoPlIxBu+4K9FwEQnPzmg9JLdtbyXDbEco1VP3LrmC24/U7YVRIEiUFF2rTaH3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777349121; c=relaxed/simple;
	bh=B9W3KZ+jiACN47c6ASxvLPF4dhxdcEJuibCMyNwqudA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RjoeYxUOgaWvro+ViblFHrJLqFGz/AxSiYqcYd7qJWClLmbg3o4IFo+9BZ+Ll+ouwlsoE6+q1QP++59tJaP37CXGtdPqkKnKJzsi/6GXkYd1ogU6VMcA6VggWDFuEuPPHvbcPqehtTMMeuZ9rSwPixln9C6mSKuTakA0g+UaiVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lCYd4qnG; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lCYd4qnG"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-36146ae9dd4so9184100a91.3
        for <gfs2@lists.linux.dev>; Mon, 27 Apr 2026 21:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777349119; x=1777953919; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w3XEYSwscXJlArL4mbBUzfBOav+8GJKW6Xs9PInyTwA=;
        b=lCYd4qnGvv/2t+Gde52q6dRRiFouJCBfdb8Hg82bVR1+4KW6gPGD0OShFFhIN5DeKc
         4kuqJFuw7W+rSK0+q4MvIZPTIFnXZO7qHs7WDPxKtY4JORfEpd5Yk2lCKGjAc7MUDHn5
         Yap7PICFSOj3uuUKzaeNFvWxYSJeko3cQ1b3Pqvdt/RlOYVg3FiGN9hS8mq8kxseX0MM
         eAO1xUSdQYqvhfz/dZWiYtQLfOL6abkaHg2c2BHhZonYG6FHijf3qo+vio9cEINJEfh5
         AdpA5k0zp9HQUKuvoRELZdeXkrL4nHsQVQI5D8iuEU2ZJg5eoBajEcjZuAp2m34pgUvz
         Q/0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777349119; x=1777953919;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w3XEYSwscXJlArL4mbBUzfBOav+8GJKW6Xs9PInyTwA=;
        b=D2fFwVwnliMMnnvKFjivU/91ZFVPeXImFr4keDbiCNcqMpNWXBls8+gge7/cCu06dv
         /2HmyoLjVdYFPUykwVL2zHtHqHIK/ljLvImW4y6HyzFRXQygPSwHgIG4R5rajNTuxw3C
         ra+7LFan4nN2/i83wQo48vgFORn1lpNKM9gi3zdCLwu7Wv3DqjoU5S1muOHOEf6yVktj
         UHvALt3XkLeRBmNfPafmNJVS94Z5uSsc9fB/JOW1v98B6bpucUt27AVkJKMW52+CmOB7
         5t+rVNG+E/MwEFYgR1kK2clwXcjUS+DBq8+bj0GGvrCADPLU09nvFAt/v4U3FygddpWF
         Vzlg==
X-Gm-Message-State: AOJu0Yy4MjiKG4oCp0bA213FsDe6KQTotd5h6FonPVk5y7Prwx8VjfY9
	vMOwfF3XNLomYeJroyR1xOrlRStSubCNIqyH63Hp/x4CrUkSCGdqcXwi
X-Gm-Gg: AeBDiev76lPw3ZWmuB7+CPg58DqFPi8O4rLP1HbSHz+TyNmh+ISDZPWYRc1DCFyHZhO
	zUPDvCiEXOdJfu5x/o/OcjiCg9mzTpJHZ5h0Nm6aPORCeoQGfS834abbDaFL986XjCPefvqabMV
	yJxVCGGduUId31vXG+gSZ1zWlIacLDpxZpDyFiGGI43vifAVLS1cIt7LxJk9NY138EyaxacmqeA
	9vZICNqm/PYXbGkrj9DXcyS3rCUhz+ZF+9euHHgj4n7x+Jq27Q6a7oO5SQO6PHniumI9DTklV0t
	Apzu6wJfhdCj6exwSi7j/NhypsitXpNqma4sTHj1XkY+Wtdr6nS4Z4LgCvoSv0GXnTeaFcO8aMK
	TR4eB1eNEukPz1ZFF4rLNSqX8B08qxSEKKxUp+JRU7uOzQLF7EPaY5ZnJNbs6AoU48uAbF1bXUY
	+bTceFU6nBnLbWnwP8e+x26jl9mlPGcWorIkizbKjhfMk8HqKFwK+7h23zN32ZVgqPnHOwZpp5G
	PNo+FtX1g==
X-Received: by 2002:a17:90b:5291:b0:35d:a90d:580e with SMTP id 98e67ed59e1d1-36492046369mr1318942a91.23.1777349119410;
        Mon, 27 Apr 2026 21:05:19 -0700 (PDT)
Received: from kernel-fuzz.. ([103.172.182.26])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36490a6b5b6sm418718a91.8.2026.04.27.21.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 21:05:18 -0700 (PDT)
From: ZhengYuan Huang <gality369@gmail.com>
To: agruenba@redhat.com
Cc: gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	r33s3n6@gmail.com,
	zzzccc427@gmail.com,
	ZhengYuan Huang <gality369@gmail.com>
Subject: [PATCH] gfs2: reject undersized EA records during xattr walks
Date: Tue, 28 Apr 2026 12:04:08 +0800
Message-ID: <20260428040408.981582-1-gality369@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[BUG]
A fuzzed GFS2 image can crash in `ea_split_ea()` while servicing setxattr:

BUG: KASAN: slab-out-of-bounds in ea_split_ea+0x1f3/0x230 fs/gfs2/xattr.c:835
Write of size 4 at addr ffff88801550a1c0 by task syz.0.379/950

Call Trace:
 ...
 ea_split_ea+0x1f3/0x230 fs/gfs2/xattr.c:835
 ea_set_simple_noalloc fs/gfs2/xattr.c:888 [inline]
 ea_set_simple+0x66f/0x7c0 fs/gfs2/xattr.c:951
 ea_foreach_i+0x2a1/0x560 fs/gfs2/xattr.c:112
 ea_foreach+0x3cd/0x5d0 fs/gfs2/xattr.c:140
 ea_set_i+0x176/0x3d0 fs/gfs2/xattr.c:1063
 __gfs2_xattr_set+0x8de/0xc60 fs/gfs2/xattr.c:1215
 gfs2_xattr_set+0x2ed/0x450 fs/gfs2/xattr.c:1258
 __vfs_setxattr+0x14f/0x1c0 fs/xattr.c:200
 __vfs_setxattr_noperm+0x10b/0x5c0 fs/xattr.c:234
 __vfs_setxattr_locked+0x172/0x240 fs/xattr.c:295
 vfs_setxattr+0x167/0x390 fs/xattr.c:321
 do_setxattr+0x13c/0x180 fs/xattr.c:636
 filename_setxattr+0x16b/0x1c0 fs/xattr.c:665
 path_setxattrat+0x1d8/0x280 fs/xattr.c:713
 __do_sys_setxattr fs/xattr.c:747 [inline]
 __se_sys_setxattr fs/xattr.c:743 [inline]
 __x64_sys_setxattr+0xcd/0x150 fs/xattr.c:743
 ...

Allocated by task 893:
 kasan_save_stack+0x39/0x70 mm/kasan/common.c:56
 kasan_save_track+0x14/0x40 mm/kasan/common.c:77
 kasan_save_alloc_info+0x37/0x60 mm/kasan/generic.c:573
 unpoison_slab_object mm/kasan/common.c:342 [inline]
 __kasan_slab_alloc+0x9d/0xa0 mm/kasan/common.c:368
 kasan_slab_alloc include/linux/kasan.h:252 [inline]
 slab_post_alloc_hook mm/slub.c:4978 [inline]
 slab_alloc_node mm/slub.c:5288 [inline]
 kmem_cache_alloc_noprof+0x1f0/0x7d0 mm/slub.c:5295
 __do_sys_getcwd+0xe0/0x730 fs/d_path.c:416
 __se_sys_getcwd fs/d_path.c:412 [inline]
 __x64_sys_getcwd+0x59/0x80 fs/d_path.c:412
 x64_sys_call+0x15ac/0x26a0 arch/x86/include/generated/asm/syscalls_64.h:80
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x93/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

Freed by task 893:
 kasan_save_stack+0x39/0x70 mm/kasan/common.c:56
 kasan_save_track+0x14/0x40 mm/kasan/common.c:77
 __kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:587
 kasan_save_free_info mm/kasan/kasan.h:406 [inline]
 poison_slab_object mm/kasan/common.c:252 [inline]
 __kasan_slab_free+0x6f/0xa0 mm/kasan/common.c:284
 kasan_slab_free include/linux/kasan.h:234 [inline]
 slab_free_hook mm/slub.c:2543 [inline]
 slab_free mm/slub.c:6642 [inline]
 kmem_cache_free+0x384/0x7a0 mm/slub.c:6752
 __do_sys_getcwd+0x3f8/0x730 fs/d_path.c:446
 __se_sys_getcwd fs/d_path.c:412 [inline]
 __x64_sys_getcwd+0x59/0x80 fs/d_path.c:412
 x64_sys_call+0x15ac/0x26a0 arch/x86/include/generated/asm/syscalls_64.h:80
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x93/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

and also as:

BUG: KASAN: use-after-free in ea_split_ea+0x1f3/0x230 fs/gfs2/xattr.c:835
Write of size 4 at addr ffff888023742118 by task syz.0.27/395

Call Trace:
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0xbe/0x130 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xd1/0x650 mm/kasan/report.c:482
 kasan_report+0xfb/0x140 mm/kasan/report.c:595
 __asan_report_store4_noabort+0x17/0x30 mm/kasan/report_generic.c:385
 ea_split_ea+0x1f3/0x230 fs/gfs2/xattr.c:835
 ea_set_simple_noalloc fs/gfs2/xattr.c:888 [inline]
 ea_set_simple+0x66f/0x7c0 fs/gfs2/xattr.c:951
 ea_foreach_i+0x2a1/0x560 fs/gfs2/xattr.c:112
 ea_foreach+0x334/0x5d0 fs/gfs2/xattr.c:162
 ea_set_i+0x176/0x3d0 fs/gfs2/xattr.c:1063
 __gfs2_xattr_set+0x8de/0xc60 fs/gfs2/xattr.c:1215
 gfs2_xattr_set+0x2ed/0x450 fs/gfs2/xattr.c:1258
 __vfs_setxattr+0x14f/0x1c0 fs/xattr.c:200
 __vfs_setxattr_noperm+0x10b/0x5c0 fs/xattr.c:234
 __vfs_setxattr_locked+0x172/0x240 fs/xattr.c:295
 vfs_setxattr+0x167/0x390 fs/xattr.c:321
 do_setxattr+0x13c/0x180 fs/xattr.c:636
 filename_setxattr+0x16b/0x1c0 fs/xattr.c:665
 path_setxattrat+0x1d8/0x280 fs/xattr.c:713
 __do_sys_setxattr fs/xattr.c:747 [inline]
 __se_sys_setxattr fs/xattr.c:743 [inline]
 __x64_sys_setxattr+0xcd/0x150 fs/xattr.c:743
 ...

[CAUSE]
`ea_foreach_i()` validates only that each EA record has a non-zero
`ea_rec_len`, stays within the block, and has a valid type. It never checks
that the record span actually covers the layout encoded by
`ea_name_len`, `ea_data_len`, and `ea_num_ptrs`.

If a malformed record reaches `ea_set_simple()` with
`GFS2_EA_REC_LEN(ea) < GFS2_EA_SIZE(ea)`, the unsigned subtraction in the
split test underflows and falsely claims there is enough free space.
`ea_split_ea()` then writes the new EA header outside the real record.

[FIX]
Reject EA records whose reserved record length is smaller than their
computed layout size in `ea_foreach_i()`, which is the common parse
boundary for existing xattr metadata. This stops malformed records before
any update path can split or otherwise trust the broken geometry.

Signed-off-by: ZhengYuan Huang <gality369@gmail.com>
---
fs/gfs2/xattr.c | 7 +++++++
1 file changed, 7 insertions(+)

diff --git a/fs/gfs2/xattr.c b/fs/gfs2/xattr.c
index b9f48d6f10a9..16cf31bde99a 100644
--- a/fs/gfs2/xattr.c
+++ b/fs/gfs2/xattr.c
@@ -96,6 +96,8 @@ static int ea_foreach_i(struct gfs2_inode *ip, struct buffer_head *bh,
 		return -EIO;
 
 	for (ea = GFS2_EA_BH2FIRST(bh);; prev = ea, ea = GFS2_EA2NEXT(ea)) {
+		u32 ea_size;
+
 		if (!GFS2_EA_REC_LEN(ea)) {
 			gfs2_consist_inode(ip);
 			return -EIO;
@@ -109,6 +111,11 @@ static int ea_foreach_i(struct gfs2_inode *ip, struct buffer_head *bh,
 			gfs2_consist_inode(ip);
 			return -EIO;
 		}
+		ea_size = GFS2_EA_SIZE(ea);
+		if (GFS2_EA_REC_LEN(ea) < ea_size) {
+			gfs2_consist_inode(ip);
+			return -EIO;
+		}
 		error = ea_call(ip, bh, ea, prev, data);
 		if (error)
 			return error;
-- 
2.43.0
