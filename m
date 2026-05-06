Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8041175A62
	for <gfs2@lists.linux.dev>; Wed,  6 May 2026 02:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778035520; cv=none; b=JoAeG9x1He2ZXgzjPEZ8KIZ74KgpYa+4iOfxsPsULA8Otts2gIXudq/KDD0cNNsmMxwGAMyd6Q2O4OaEK7cB2R+YDkxV7uj5Nd9mA+/whbiSaYyL6faN8UwoeDINeFzg4qcZvWZCpN0+5ScKsGTF1j3giBnAiJmxbKZmW/w4A6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778035520; c=relaxed/simple;
	bh=jJuioYgRUhzxI3kXVy7VPOuit8HLaZqu1BQXuFqrfU0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bhU5qys2GFv5NH2pxz4xp3oEdYkBcT8SeORvOzAAJGNlxJ4XtNWu/p7JtfUUE6d5fqouOfayvTd7j/q0YYaIWY+TSDslV04jHBd3zUmxYWptLOvTzOB6+XeU5NYB/8n9bCDwMPyI+WWxsPKHJS6TTkf+odaa3LTj+1+ih3xOlAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SbiN8/KJ; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SbiN8/KJ"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3567e2b4159so4623568a91.0
        for <gfs2@lists.linux.dev>; Tue, 05 May 2026 19:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778035518; x=1778640318; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=utswKfOvYzBeesH3lyjj2o/hoPuF2wup/XEUsZplSdw=;
        b=SbiN8/KJ4oRv4UuvFkPtmXDTWo3wAgOgFkswrjbtGQi6VQFARyAnG4qvdbKf18KTsD
         VQ8phsLPmLdtKnK+8RCBT1kVVd7kTj27UsFIKpCxYEkC/ZGzYl3J53UaHoNjpKEZaC0K
         YvaIUzXjBRAHhQ82GS5KFll6W02lThED8mJSQysxqffvrpSXFfLZrlrzRUBPYj+mwYtI
         TYuhVmwNmrMZztq8FiZ1gvlLk9Ee7FJLRw7JT8kOwCEoNvDQ9pn/6Y0tDLO1NXvMZSOr
         8pazo6aqARBNE6wZ4ZVyL3tJiTD3UxDTXbwJTA4zFEsvdVKp9D9eHIAE95QUoUugmO6v
         nIqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778035518; x=1778640318;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=utswKfOvYzBeesH3lyjj2o/hoPuF2wup/XEUsZplSdw=;
        b=n0AT9gDNy0YVSUOwxRHProIMySP8b90wjx1bJu7ATt3OibTs0sb/FNHspr2/sxk/g3
         7VuLX7VcPHhQoPi73KzHe3qM7FamxuVeypBi26A7T4GHKD6gUr8ufy7b31jRcvCkKpK2
         /qtmyfZEsFyXRB32vc1k7ZVAgu2O9rqZb+J230BHEoxuTQxLyit5Tj4z8zEj6crq1ViM
         PVJJP2/wQ6T7Ntt1dnJGB1xuy9L4A6e9dVg79g7QhVRuNPyKS9IS2i7tXLk/lpYgZqTX
         YYOmPKSEF0gEepwgUvBxQci8OTraTMeTINoBZfm/pl7vixrfbbsPlW+eb8tUUu3grheZ
         T+7Q==
X-Gm-Message-State: AOJu0Yy+avLP5iTRDujx5X+Xdd8BV0IRPEtnsTnaXVCby7Cm2XkUD8pa
	EPgYbqct3EibIixuPcyhUNo354/sPZeo727LICYnzNCbePseSkwcAl+r
X-Gm-Gg: AeBDiesT/YEdB6zPs2uRSyrUVARkkfbmSjKQffdot0hKvA3Hzutt9wFunYlT/Ygda0D
	A5JgwcVxXb9N+vDRtReRBStimFF5zx18Cl86+RzgzObR/6kOmC8p6qW39tFKfVDKBLaYB3N9u9e
	tA+y5+RluhMGFaO/Zl8Q+RkK2wfKVF7Rf08RH7BdELOQ3URZnGeXGzk49S21F+4bJ1RjGPZFsvO
	1238mLNAxz133hJbWSrVGbZOUaI/VYtagjQUOaQwca+a/KXJrRphnjSt5ZAiwHd2jP0jK5qPTPg
	KmVNioAYuJgt8QHmpJdLt0cbbVrwgfiWT08q7Evm0SQv8mwiICJVakikjNTuo2geohHeZlo0eDt
	mvqq/qjUAWAGtECGkXejW3w/dZgHgKq2pVGNCS5PZzIQ+NKtcJUmKFZ5Z4JFz/lpui0ZKBUw7ht
	rTmN0IsgmHFfiHa+94EuyLCA/A0QKfLoWucZ+VISP/dCCX1oz7AUpC4NOFrmZdgam/s+9CMyEFX
	uj7zp28MQ==
X-Received: by 2002:a17:90a:d88d:b0:35f:d56d:1c45 with SMTP id 98e67ed59e1d1-365abcf2382mr1380629a91.12.1778035517980;
        Tue, 05 May 2026 19:45:17 -0700 (PDT)
Received: from kernel-fuzz.. ([103.172.182.26])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8242bc1e7dsm538763a12.30.2026.05.05.19.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 19:45:17 -0700 (PDT)
From: ZhengYuan Huang <gality369@gmail.com>
To: agruenba@redhat.com
Cc: gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	r33s3n6@gmail.com,
	zzzccc427@gmail.com,
	ZhengYuan Huang <gality369@gmail.com>
Subject: [PATCH v2] gfs2: validate EA record lengths safely during xattr walks
Date: Wed,  6 May 2026 10:22:57 +0800
Message-ID: <20260506022257.569389-1-gality369@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[BUG]
A fuzzed GFS2 image can crash in ea_split_ea() while servicing setxattr:

slab-out-of-bounds in ea_split_ea+0x1f3/0x230 fs/gfs2/xattr.c:835
Write of size 4 at addr ffff88801550a1c0 by task syz.0.379/950

Stack:
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

use-after-free in ea_split_ea+0x1f3/0x230 fs/gfs2/xattr.c:835
Write of size 4 at addr ffff888023742118 by task syz.0.27/395

Stack:
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
ea_foreach_i() validates that each EA record stays within the block and
has a valid type, but it does not verify that the recorded span covers
the layout encoded by ea_name_len, ea_data_len, and ea_num_ptrs.
Computing that layout from corrupt metadata must also be overflow-safe.

If a malformed record reaches ea_set_simple() with a recorded length
smaller than its computed layout, the unsigned subtraction in the split
test underflows and falsely claims there is enough free space.
ea_split_ea() then writes the new EA header outside the real record.

[FIX]
Add an overflow-safe ea_rec_len_valid() helper and call it from
ea_foreach_i(). The helper folds the zero-length check into the common
record-length validation, rejects records whose computed layout
overflows, and rejects records whose recorded span is smaller than the
aligned layout size.

Signed-off-by: ZhengYuan Huang <gality369@gmail.com>
---
v2:
- combine the zero-length and record-size validation in ea_rec_len_valid()
- make the EA layout size calculation overflow-safe
---
 fs/gfs2/xattr.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/fs/gfs2/xattr.c b/fs/gfs2/xattr.c
index b9f48d6f10a9..38f49382c54b 100644
--- a/fs/gfs2/xattr.c
+++ b/fs/gfs2/xattr.c
@@ -8,6 +8,7 @@
 #include <linux/spinlock.h>
 #include <linux/completion.h>
 #include <linux/buffer_head.h>
+#include <linux/overflow.h>
 #include <linux/xattr.h>
 #include <linux/gfs2_ondisk.h>
 #include <linux/posix_acl_xattr.h>
@@ -81,6 +82,31 @@ static bool gfs2_eatype_valid(struct gfs2_sbd *sdp, u8 type)
 	}
 }
 
+static bool ea_rec_len_valid(const struct gfs2_ea_header *ea)
+{
+	size_t size;
+
+	if (!GFS2_EA_REC_LEN(ea))
+		return false;
+
+	size = sizeof(struct gfs2_ea_header) + ea->ea_name_len;
+	if (GFS2_EA_IS_STUFFED(ea)) {
+		if (check_add_overflow(size, (size_t)GFS2_EA_DATA_LEN(ea), &size))
+			return false;
+	} else {
+		size_t ptr_size;
+
+		if (check_mul_overflow(sizeof(__be64), (size_t)ea->ea_num_ptrs,
+				       &ptr_size) ||
+		    check_add_overflow(size, ptr_size, &size))
+			return false;
+	}
+	if (check_add_overflow(size, (size_t)7, &size))
+		return false;
+
+	return GFS2_EA_REC_LEN(ea) >= round_down(size, (size_t)8);
+}
+
 typedef int (*ea_call_t) (struct gfs2_inode *ip, struct buffer_head *bh,
 			  struct gfs2_ea_header *ea,
 			  struct gfs2_ea_header *prev, void *private);
@@ -96,7 +122,7 @@ static int ea_foreach_i(struct gfs2_inode *ip, struct buffer_head *bh,
 		return -EIO;
 
 	for (ea = GFS2_EA_BH2FIRST(bh);; prev = ea, ea = GFS2_EA2NEXT(ea)) {
-		if (!GFS2_EA_REC_LEN(ea)) {
+		if (!ea_rec_len_valid(ea)) {
 			gfs2_consist_inode(ip);
 			return -EIO;
 		}
-- 
2.43.0
