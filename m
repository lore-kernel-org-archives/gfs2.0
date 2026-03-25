Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA36DDCD
	for <gfs2@lists.linux.dev>; Wed, 25 Mar 2026 06:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774418716; cv=none; b=e8RH/rewr6W1lWzrceR5UrSXFUgOdXk0b+W40oeJ65oq7eRE8HYvCD3EVqhkwhJed6ECryR93MRN2G0+N2oSFqT+ciOrzOf4ho50fQPXi0U66eqhvYW/YJw5KoXt2f7aK9+kjM61NKZOqRWnOGxJPWboBqDJAnpOTbQTiQ278Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774418716; c=relaxed/simple;
	bh=/4mxWxOqGckXCdBuwHyFJ5q+lUz9GVFn9INW9heN1mI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o/nF5LNZH2ZpKDrt44GruR6AZ67Grh4gss4BK6v0XVRi2D5KjrOGKa7OAq4Pu3ryKzc8oGzx4MxuVNlRmBBLuGSnL0pK5L2kZigocBzHzf8zKIKtRnoEdqD6MgAyYAIz053oWxTWaWxkmVEfazGSAC4Vge7bcbeINBFoUxdU44k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CXboCj3h; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CXboCj3h"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-829a9d08644so2656222b3a.1
        for <gfs2@lists.linux.dev>; Tue, 24 Mar 2026 23:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774418714; x=1775023514; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Dc6uWoEfFNbFTheB/eDVqLTVVcoFwHuuAP4HhmTUaKY=;
        b=CXboCj3hbmSBBv9TS4dZL9P5p884GqkMgl34DU2JUMjragZdVpKBO/ezwcdkT9dsHm
         ggh5cLp/ACw4P4prKHhFlsnxOwh7rmO7PmR2DbH6GacvKK8b2Zs2+FMMY2kWAdywVuMJ
         RgEVwp1olp+ritF86N0uwzDDvs0GihgTFNYb6Npfe0yS04kYCG8B0jLT+R3ay+4mcTuH
         XcxZOuKsnq/d39+kXdDCS5jBdsQeo7gzjbwvHFr+DfkfxxdLappaJQPWi3EnTBbIt9HF
         aY2njQyDQnG/oL1VNMfM943hGU8W1kJuEz0EN4WAqRLgDwQzPp3roHzEnuqu+t6a2kXb
         LZZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774418714; x=1775023514;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dc6uWoEfFNbFTheB/eDVqLTVVcoFwHuuAP4HhmTUaKY=;
        b=Kt5M5Ox8/I3z4Qw//zpofobkkauU93/eb8PP86B0nKhAJdYseV3fNZN5qTJGwYhLuq
         NA4+noXrToM6+Ka+jo7z6eUBvD+nVsvNV218DE3jaZcDDz6qQWglAxU6+KU2tB8VktCw
         acgd0Tb879wSQSChjZfu9Yf4BMq6dKm3faWCbF76uQxoORSspwCDLlreTyR43lGmEKrM
         bevpk69EQND3fnFD3hfMHZYrzoZ/6NcmO4C0iFJbupKsfIh9tyWlcNtupMvWeGW340Xv
         U39xyARmF3u23iaWk3JxgEpO6N/024jSqt/4/l/hQDPgVr72SJsxKp+QjZdQBx3EQi9K
         1vdQ==
X-Gm-Message-State: AOJu0YzZ0WdsK5/eJqn74dTPyYPcc1zK7kzCNsj7zAEeAynVYQ92VQxz
	iAxMkGbsBYA6SJStfu/VQO4GNWxOwo6D53iPs8S+H52Cm/Kx7lX8n3SX
X-Gm-Gg: ATEYQzyNCxsxmbn00toZORUs0ECLHhHbiQq9XqxY58YQG1kBi2bdKV5C2hZ50yltKu9
	B6VPUsTPXtZzWU/qL1UyUJ/xkVU0YIbOtVrqSzZoTyomirKwYiC03NjPfsn86ibUIPbiqFJ0eqb
	8qnnA99b9Pw3EaV9jvugzq6VPOEoNq8btbHcsbj3B8qd2uVksgmECHcI7vgQs/6VVDgTWG1+92p
	ut3erPMGxVyAjlKhsat4Qxpvdu2AUVZBRrl4iaipZO55aiSA+EHDH7bPZ3xpejsNu65qEyQzQNh
	tc3VqyTJ8slnt9rFg9aJ0biCij2Z4I7TOOSzs8T2HQ9urvka/bOabzFzi2OmKQ9dZE7O0pj79KS
	rQubzNHGIeW3tBci3nFQLBVrVMNN7mgdI7oXQ9H77gxGZjvuG4t5448MclllAFv0PINcYSfEb6B
	72ndRcy8s18oX7DwdKauBg283BH8HnUDzmzLJfDYHWWau2+DU/LrB4a5oiG2bOtXRjVjTfhAQMZ
	JPnhBE/CpEHsFlwMQ==
X-Received: by 2002:a05:6a00:448d:b0:828:d9a1:c604 with SMTP id d2e1a72fcca58-82c6de860e9mr2148875b3a.12.1774418714111;
        Tue, 24 Mar 2026 23:05:14 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:389d:4391:3576:53a6:e191])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b0409c681sm17104789b3a.37.2026.03.24.23.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 23:05:13 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: agruenba@redhat.com
Cc: gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+b441db1854c360b83221@syzkaller.appspotmail.com
Subject: [PATCH] gfs2: fix duplicate kmem_cache name on concurrent mounts
Date: Wed, 25 Mar 2026 11:35:06 +0530
Message-ID: <20260325060506.4868-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When gfs2_fill_super() creates the per-filesystem bufdata cache, it
uses sd_fsname as part of the cache name:

  sdp->sd_bufdata = kmem_cache_create("gfs2-bufdata/<fsname>", ...);

At this point sd_fsname is set from sd_table_name (e.g. "syz:syz"),
which is the same for all concurrent mounts of the same device.
The unique suffix (.s for spectator, .N for journal ID) is only
added to sd_fsname AFTER wait_on_journal() completes, since the
journal ID is assigned by the locking subsystem during mount.

With multiple concurrent mounts of the same device (as triggered by
syzkaller with procs:5), multiple calls to gfs2_fill_super() all try
to create a cache named "gfs2-bufdata/syz:syz" before any of them
reaches the point where sd_fsname becomes unique, triggering:

  kmem_cache of name 'gfs2-bufdata/syz:syz' already exists
  WARNING: mm/slab_common.c:112

Fix this by moving the bufdata cache creation to after
wait_on_journal() completes and sd_fsname has been updated with its
unique suffix. Also move the fail_bufdata cleanup label accordingly
in the error unwind path.

Reported-by: syzbot+b441db1854c360b83221@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=b441db1854c360b83221
Fixes: 767e4de3ffce ("gfs2: per-filesystem bufdata cache")
Tested-by: syzbot+b441db1854c360b83221@syzkaller.appspotmail.com
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 fs/gfs2/ops_fstype.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index b44adb40635d..7f8e04c11494 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -1198,17 +1198,9 @@ static int gfs2_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (!sdp->sd_delete_wq)
 		goto fail_glock_wq;
 
-	char *bufdata_name = kasprintf(GFP_KERNEL, "gfs2-bufdata/%s", sdp->sd_fsname);
-	sdp->sd_bufdata = kmem_cache_create(bufdata_name,
-					    sizeof(struct gfs2_bufdata),
-					    0, 0, NULL);
-	kfree(bufdata_name);
-	if (!sdp->sd_bufdata)
-		goto fail_delete_wq;
-
 	error = gfs2_sys_fs_add(sdp);
 	if (error)
-		goto fail_bufdata;
+		goto fail_delete_wq;
 
 	gfs2_create_debugfs_file(sdp);
 
@@ -1255,6 +1247,15 @@ static int gfs2_fill_super(struct super_block *sb, struct fs_context *fc)
 		snprintf(sdp->sd_fsname, sizeof(sdp->sd_fsname), "%s.%u",
 			 sdp->sd_table_name, sdp->sd_lockstruct.ls_jid);
 
+	char *bufdata_name = kasprintf(GFP_KERNEL, "gfs2-bufdata/%s", sdp->sd_fsname);
+
+	sdp->sd_bufdata = kmem_cache_create(bufdata_name,
+					    sizeof(struct gfs2_bufdata),
+					     0, 0, NULL);
+	kfree(bufdata_name);
+	if (!sdp->sd_bufdata)
+		goto fail_sb;
+
 	error = init_inodes(sdp, DO);
 	if (error)
 		goto fail_sb;
@@ -1304,6 +1305,7 @@ static int gfs2_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (sb->s_root)
 		dput(sb->s_root);
 	sb->s_root = NULL;
+	kmem_cache_destroy(sdp->sd_bufdata);
 fail_locking:
 	init_locking(sdp, &mount_gh, UNDO);
 fail_lm:
@@ -1313,8 +1315,6 @@ static int gfs2_fill_super(struct super_block *sb, struct fs_context *fc)
 fail_debug:
 	gfs2_delete_debugfs_file(sdp);
 	gfs2_sys_fs_del(sdp);
-fail_bufdata:
-	kmem_cache_destroy(sdp->sd_bufdata);
 fail_delete_wq:
 	destroy_workqueue(sdp->sd_delete_wq);
 fail_glock_wq:
-- 
2.43.0

