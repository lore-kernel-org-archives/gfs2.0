Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160272F25F8
	for <gfs2@lists.linux.dev>; Tue,  3 Feb 2026 02:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770085243; cv=none; b=AQDVV93f/WistGM9TuZEnQ/ttPmKsj3tetYSHyoPzkIYGJjJyCqkfDhqvoxwanZIIn2sJM0xfD8nqr+90GJMeBStZpEPi45Qe2gU+gW2bYCnFuIlMWQMla5HAvVJ0PIBHS/zxUV6de5sBxG2jy4oPu4R0I31xERc0U6w0kJgaEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770085243; c=relaxed/simple;
	bh=XzXGxAY3+hvOBubuRFnwt32d8yDz9HfIbvbLddXh1QQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hM90tSpsTdul3F6fwsiyENJKWMB6EnU9stVgYJJnZR+wGGw6jggGunI8eCdHlLktx9bzq554sIc9yU8jr0jBnKzWG+2NTqxZI/OaitHhbIT39p2IyFG+9C7TRdvFRCmH9wQyYoUer3/ZAq25HMPM3JcIAEuEWGnkjdy5b7YOIlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AXswTUte; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AXswTUte"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c626bd75628so1891344a12.3
        for <gfs2@lists.linux.dev>; Mon, 02 Feb 2026 18:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770085241; x=1770690041; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iz/BewUOL5mTCy3HXx+oHUtEMSk6DW46tY5mVHCh/Oo=;
        b=AXswTUte1ybhs3e3KRhkSJgdFzGJpF9kujEPf0/DsalsiVVKQihmRFL24PFcYtGso6
         KVoXrHRwKVMCufkYXBHsk8XkiXj8Wq6yl2M0oedGefLWBJ3goK3USEBagNCkH9MtYXjF
         8p7FH1ZWOlRdJkONbSuW8Pq8NhiKd8O790WbiBRCqy7EnQFsTYbvORZKrmoAJUpqI0QZ
         Zu3ObayuVHCu48Dh8X+zkhviyyRHetWpiHk73cGBc9RB2x0uUKYrnMk0S9nqFa+kSJ4E
         UmCuuxsEiljY0lEXyBT9jokJV8LdL9eah8n5uFg46IThR1pOpYj4B9HxNYf4GrcYom4Q
         /yuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770085241; x=1770690041;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iz/BewUOL5mTCy3HXx+oHUtEMSk6DW46tY5mVHCh/Oo=;
        b=Xg8GN64n2MbbIjjnSC3oDIafRwMUx5nTWN89ZBDPvrJRnxMQIgJ2DdrRaxzMvbMniR
         SnBZZTv/QL6ecBYFOBMR64jjcONKR+1/R+3MBAqWHqKEyEbg0tYjzO26mT467oHaTdkz
         pN4CdFc7jZcPeYfExS1Z2D/LHCPDKMAWHbbMqyi7Pb3cD9f4rIbqc3pxJ+ZpVtNbLAnz
         tyONLnWNjtkETMmNArFQp54jMsM8I5uUsYfwnaw8weIlfYAZDQThHZIviUmwuP5QpZ67
         FOTA3dSBpFknw/+7AUTrTsQihUz2RVASh10aCrIGitUXNcrarToOtCkuEdX3KNIa6o3/
         cXZg==
X-Gm-Message-State: AOJu0YyEPfLeqqK9TtgArYIdGB2237mDdeWE0/ZebJT+7FySnMH8goQW
	sDs8EUNNb6+hHO5TF3UpZi+oJhlY+MQQmIwAonAobRvPFViR9slyMB/V
X-Gm-Gg: AZuq6aLcdR+4dzP7bksM1gB3j/qzTn+RNI1gmrDSjToWDFuRtsl4I3Yqgt1bBCIN7Sx
	rz5Dv325SrNdSAU1a0hmNspys1gAJomXAV9jc2SGm1L8+NBsrsgJkoGrLCSIMYgHtcIoQpwE1i+
	/529Bg4/7fJoXM1euE33FXmmCZ30m061lpxxTF4Fn0FPs8NrEEjBG+XxNOaqn0lz7pR49EwVyBS
	oHITjZmcvYuFMsv1eNib4yUhAbsTH51UgexNTBpK/TqnHGeyfVZM8o/doXlSAVo50jyGzceJ4+L
	OCLG4A1KWytMRubuAsNruKZOl1cNBpaLJWFY26TBlkw5IcbQgpNAUreKtEXS/sCvV1T8SAO8dGM
	FcRv1Gt2L9c7G4HomuD1k5QAaAuCMT83XE9a2wCfz4zWuBo9RRF40iRwMCGVjSiGbIAIWQ8xYfi
	B6ssulaxVxqkzbKGQWtOIbb1KAMaWfRH+S76rIm3nowD4P6RqCQ2/P8LUz8yoHvVxC4dE=
X-Received: by 2002:a17:902:ccc7:b0:2a1:3cd8:d2dc with SMTP id d9443c01a7336-2a8d9951c06mr131932585ad.57.1770085241336;
        Mon, 02 Feb 2026 18:20:41 -0800 (PST)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:389d:210f:e92c:6af6:77e9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a8ec56da8esm83828205ad.13.2026.02.02.18.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 18:20:40 -0800 (PST)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: agruenba@redhat.com
Cc: gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+aac438d7a1c44071e04b@syzkaller.appspotmail.com
Subject: [PATCH v2] gfs2: fix memory leaks in gfs2_fill_super error path
Date: Tue,  3 Feb 2026 07:50:33 +0530
Message-ID: <20260203022033.101652-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix two memory leaks in the gfs2_fill_super() error handling path when
transitioning a filesystem to read-write mode fails.

First leak: kthread objects (thread_struct, task_struct, etc.)
When gfs2_freeze_lock_shared() fails after init_threads() succeeds, the
created kernel threads (logd and quotad) are never destroyed. This
occurs because the fail_per_node label doesn't call
gfs2_destroy_threads().

Second leak: quota bitmap buffer (8192 bytes)
When gfs2_make_fs_rw() fails after gfs2_quota_init() succeeds but
before other operations complete, the allocated quota bitmap is never
freed.

The fix moves thread cleanup to the fail_per_node label to handle all
error paths uniformly. gfs2_destroy_threads() is safe to call
unconditionally as it checks for NULL pointers. Quota cleanup is added
in gfs2_make_fs_rw() to properly handle the withdrawal case where
quota initialization succeeds but the filesystem is then withdrawn.

Thread leak backtrace (gfs2_freeze_lock_shared failure):
  unreferenced object 0xffff88801d7bca80 (size 4480):
    copy_process+0x3a1/0x4670 kernel/fork.c:2422
    kernel_clone+0xf3/0x6e0 kernel/fork.c:2779
    kthread_create_on_node+0x100/0x150 kernel/kthread.c:478
    init_threads+0xab/0x350 fs/gfs2/ops_fstype.c:611
    gfs2_fill_super+0xe5c/0x1240 fs/gfs2/ops_fstype.c:1265

Quota leak backtrace (gfs2_make_fs_rw failure):
  unreferenced object 0xffff88812de7c000 (size 8192):
    gfs2_quota_init+0xe5/0x820 fs/gfs2/quota.c:1409
    gfs2_make_fs_rw+0x7a/0xe0 fs/gfs2/super.c:149
    gfs2_fill_super+0xfbb/0x1240 fs/gfs2/ops_fstype.c:1275

Reported-by: syzbot+aac438d7a1c44071e04b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=aac438d7a1c44071e04b
Fixes: 6c7410f44961 ("gfs2: gfs2_freeze_lock_shared cleanup")
Fixes: b66f723bb552 ("gfs2: Improve gfs2_make_fs_rw error handling")
Link: https://lore.kernel.org/all/20260131062509.77974-1-kartikey406@gmail.com/T/ [v1]
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
Changes in v2:
- Moved quota cleanup to gfs2_make_fs_rw() as suggested by Andreas
  Gruenbacher
- Removed conditional check for gfs2_destroy_threads() as it's safe to
  call unconditionally
---
 fs/gfs2/ops_fstype.c | 2 +-
 fs/gfs2/super.c      | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index e7a88b717991..c7d57de7c8f0 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -1276,7 +1276,6 @@ static int gfs2_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	if (error) {
 		gfs2_freeze_unlock(sdp);
-		gfs2_destroy_threads(sdp);
 		fs_err(sdp, "can't make FS RW: %d\n", error);
 		goto fail_per_node;
 	}
@@ -1286,6 +1285,7 @@ static int gfs2_fill_super(struct super_block *sb, struct fs_context *fc)
 
 fail_per_node:
 	init_per_node(sdp, UNDO);
+	gfs2_destroy_threads(sdp);
 fail_inodes:
 	init_inodes(sdp, UNDO);
 fail_sb:
diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index f6cd907b3ec6..d96160636161 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -147,8 +147,10 @@ int gfs2_make_fs_rw(struct gfs2_sbd *sdp)
 	}
 
 	error = gfs2_quota_init(sdp);
-	if (!error && gfs2_withdrawn(sdp))
+	if (!error && gfs2_withdrawn(sdp)) {
+		gfs2_quota_cleanup(sdp);
 		error = -EIO;
+	}
 	if (!error)
 		set_bit(SDF_JOURNAL_LIVE, &sdp->sd_flags);
 	return error;
-- 
2.43.0

