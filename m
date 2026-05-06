Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02CD2EC0A6
	for <gfs2@lists.linux.dev>; Wed,  6 May 2026 03:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778038226; cv=none; b=NjWzbg8ndEcmN/7/HGYgoKHZIDB1tswgsm7ICDnIuKK03VBKCrztJ3qd1rYRuyZC7455sLy3eGMzE7UZh1ZbEkzEIPIPsHEteQtBW9omTPldYnhwjPR7dHiOLt6etgXpDejcOOovwL5wf1hNSTev415yQnU5pdihDk4d2XPVp/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778038226; c=relaxed/simple;
	bh=DtZnbMldZzpcj8xKwN8IxppILePPOAEeh/78TPyjl7A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lZLu2wvY+tJQ/9d1IPbpGIzV0oJhR+jqN/lU8Bxo03G5BiPUSyeko3cmyZsxM9K9BNBF8D4A7HHYYHoC57jqDgLRqJKs7x676fTr5F9orA29cERXbykOsOb7pVILwkgdjVqG+95pKGPRaj1nPHoo5IKb1B1oYXZBHc5HxHBhdd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rX90/nWu; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rX90/nWu"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-36534668247so3152304a91.1
        for <gfs2@lists.linux.dev>; Tue, 05 May 2026 20:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778038223; x=1778643023; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u1siffNkSw6kZS+yHHcYL0Aeb4TL9uEZaLBE4hMzNnQ=;
        b=rX90/nWuqBmEDP5e6puXZnxY45tCzMFsPyMxNSoE22geRshVFJNiacj/CQoaw0yeMn
         v3K6ykOJDBaxItK635H5TnoPp7AmsdW4hvtGf5000N1zp3K2ZDZ4Y5xNvapAxXcgSyWv
         q7bu5X8u9fQzfgJNYVw8Ho3goH9vVUwoSQGugVeMBvfMUA0r2kQF3bPdb+GkbzMCipSv
         Y7jXHhrl1Gov7db2HA32WKFvqhB7xu2BEwsu3qKwCbN7iNaUdFyAmbNToaqhrtbtkd9x
         HEZ+QQTNYVnwp9fWoUtzp6Q2o+e4w/MCqIC1Y+2d+pzZ7IPufMe8l3E4kJlAlRWO/93T
         wK0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778038223; x=1778643023;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u1siffNkSw6kZS+yHHcYL0Aeb4TL9uEZaLBE4hMzNnQ=;
        b=DKB7j3Z2ul7bzdEda/Homf8sXKlcrOtQcTAnfi5xnjTIteVIjlptMmjjm90E/s5tRY
         xSytF43mLWK64ez/rMDKbqkMUkkP5HE5aA/ImMYrgLLEW0vHIPTnFyeeSpTlMH4jO7T/
         SEY3dCHzaruK27PjObup3u4aeeyHKit7w40Z1ce1lNnqRgqlJpF2d5upgBsklE80Bcip
         80UtX+06iCuxLhzNcg00nwt7tP3AE6fctziE8345XC9meGMpyOCJuy5qthalbllsZthB
         Lk+sZZfmOck3nNiQzialGigcL/i1XuzfFBJhFxwh5Mj09FWEviRlpccypidZNFmyJ0m+
         jjmw==
X-Gm-Message-State: AOJu0YxaDngXKCzpifAPLLYWFnyDN9xjfKM95HfTWi6TEZWlOkX6Cx+Q
	MXLRnw9fr4L5MPdHviLv7erDMVyUJNJNV4vhd1oSHXZSOA8ktgBTco8lZ3VZzGvhhuE=
X-Gm-Gg: AeBDieu3ymXKoJd3rMZDkrumvv1tk/FrP6iKJcFcmn5uTiqW+m5M9k4J/mG0FsnGJrR
	clYQEnUOTxRlCzYjL3o1gJ+v3F5i/nDPcq/7OO166v48okDx5Nqt6OC3Qhi+/QtO6Fd7I7EUZxg
	qhdOyUPdTuaR6xyienuT8F6VBmfXkepMgyC5jfa8JTAE/nZsxRBx6GiAEgpnKey5v3KeSQYVhTA
	ZrlC/4e69DKjthf0SazK0vTbUVIRJWWNM7pW3dtCUVWaOVZ8Of4c+q/TaXysRkOrt933XK8UjhJ
	wFstQ0ldrMG/o/QaPoVgKQPhBNry5ONuyXpgWRY8D0nebxXsHSyvzsfiYXPtDgXbC6OB3B+UP6K
	L812dALj4DmU6hRnPscb4P1vGbB+GTmjxhnZE7VM80EU+AHvKhgyUqEgL1UpNKb3XhzCeovZJAf
	AIW5nsD77VjKEQWM73mBKs/KpXqxAtsU/xIZJOaIkbhDlZGwOhx0+O1z+kyhwb2r1PFVL/w/Mpz
	3G3Fv/JG8XQIs48/CkF
X-Received: by 2002:a17:90b:2fc4:b0:364:7464:12a3 with SMTP id 98e67ed59e1d1-365abcdd8d0mr1539927a91.10.1778038223034;
        Tue, 05 May 2026 20:30:23 -0700 (PDT)
Received: from kernel-fuzz.. ([103.172.182.26])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-365b4fb5e7esm516656a91.15.2026.05.05.20.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 20:30:22 -0700 (PDT)
From: ZhengYuan Huang <gality369@gmail.com>
To: agruenba@redhat.com,
	rpeterso@redhat.com
Cc: gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	r33s3n6@gmail.com,
	zzzccc427@gmail.com,
	ZhengYuan Huang <gality369@gmail.com>
Subject: [PATCH] gfs2: Only dequeue seek holders after successful glock acquisition
Date: Wed,  6 May 2026 11:30:03 +0800
Message-ID: <20260506033003.1040487-1-gality369@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[BUG]
On a withdrawn GFS2 filesystem, lseek(fd, 0x3ff, SEEK_HOLE) can crash
with:

KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
RIP: 0010:gfs2_glock_dq+0x5a/0x960 fs/gfs2/glock.c:1642
Call Trace:
 gfs2_glock_dq_uninit+0x1c/0xe0 fs/gfs2/glock.c:1708
 gfs2_seek_hole+0x152/0x270 fs/gfs2/inode.c:2222
 gfs2_llseek+0x187/0x260 fs/gfs2/file.c:79
 vfs_llseek fs/read_write.c:389 [inline]
 ksys_lseek+0xda/0x170 fs/read_write.c:402
 __do_sys_lseek fs/read_write.c:412 [inline]
 __se_sys_lseek fs/read_write.c:410 [inline]
 __x64_sys_lseek+0x77/0xc0 fs/read_write.c:410
 ...

[CAUSE]
gfs2_seek_data() and gfs2_seek_hole() call gfs2_glock_dq_uninit()
unconditionally. When gfs2_glock_nq_init() fails, it already calls
gfs2_holder_uninit(), which clears gh->gh_gl. Since gfs2_glock_nq()
returns -EIO on withdrawn filesystems, the unconditional dequeue
dereferences a NULL glock pointer.

[FIX]
Only dequeue the seek helper's holder when glock acquisition succeeded.
This keeps the fix at the caller-side lifecycle boundary, matches the
existing SEEK_END pattern, and returns the original glock acquisition
error instead of crashing.

Fixes: 3a27411cb4bc ("gfs2: Implement SEEK_HOLE / SEEK_DATA via iomap")
Signed-off-by: ZhengYuan Huang <gality369@gmail.com>
---
 fs/gfs2/inode.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index e9bf4879c07f..9af50d79231e 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -2238,9 +2238,10 @@ loff_t gfs2_seek_data(struct file *file, loff_t offset)
 
 	inode_lock_shared(inode);
 	ret = gfs2_glock_nq_init(ip->i_gl, LM_ST_SHARED, 0, &gh);
-	if (!ret)
+	if (!ret) {
 		ret = iomap_seek_data(inode, offset, &gfs2_iomap_ops);
-	gfs2_glock_dq_uninit(&gh);
+		gfs2_glock_dq_uninit(&gh);
+	}
 	inode_unlock_shared(inode);
 
 	if (ret < 0)
@@ -2257,9 +2258,10 @@ loff_t gfs2_seek_hole(struct file *file, loff_t offset)
 
 	inode_lock_shared(inode);
 	ret = gfs2_glock_nq_init(ip->i_gl, LM_ST_SHARED, 0, &gh);
-	if (!ret)
+	if (!ret) {
 		ret = iomap_seek_hole(inode, offset, &gfs2_iomap_ops);
-	gfs2_glock_dq_uninit(&gh);
+		gfs2_glock_dq_uninit(&gh);
+	}
 	inode_unlock_shared(inode);
 
 	if (ret < 0)
-- 
2.43.0
