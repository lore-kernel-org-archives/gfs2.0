Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A134F1DE2A5
	for <gfs2@lists.linux.dev>; Sat, 31 Jan 2026 06:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769840718; cv=none; b=eC2qmpgLmERO9vT80FJbk5TJYcKaTg0BERsEa4DxYG6cPcOZeIbnNwxDSMqaAJF9xLFMqBitjhXe10MkE1bbu1zDHq/Bj4dGL+WPBro3jnJYAf+BNOh+lhajiJohXYTy11d6cUzsJz6S/aky7ZFojPbrq0814/kCHvqPPk6LlDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769840718; c=relaxed/simple;
	bh=OnRpWAwLOyGrpUWVetx1PF7N03UnDjKCqSp2an0V4hc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bvEpDIxuiBigbBe6RoXprTxks9MV2IwNGI93lt6XSYUWtgFEfxTWA9ecdTv/AtQ8rOMCsXFaiX7lm72KIF8COeKwUiSlFla4KRWaSND0pqu9NrMvhX4m6LfY/Mr0RsQ5DmEFc6GxUnAN+nUUoAQi6aWCvHnnvLVccPstQmyjtes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sn4cnX2Y; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sn4cnX2Y"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-82310b74496so1683767b3a.3
        for <gfs2@lists.linux.dev>; Fri, 30 Jan 2026 22:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769840717; x=1770445517; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=of/jk6w1rGgtFqkJD/eLgqCF5bATtfFhSRr/rVMr3d8=;
        b=Sn4cnX2YqRmBWSNhgRS7ksJEZVHJcnobLD8e8xxmhW1p+KcHcCCMEurSHlP3GcMTU9
         WjHtJcSaxsrzW0rHn1tjBXWy62762vU4RanK7e5PnjDv/whsvZdqMrpxJHCz4lO109Xd
         etm1KZLoB4wdKNSMCiQqDfYXp4f5AJeG3ZcHoPsDpPyS4ghaCsTMk2xwMFxR+xWlkrN+
         6ZDxHElmNWW4KM5lpg4mm+HBjpHdeywF9X8EgxM/XLUkHWyffW+qDd+WYGMZ/XR8Lz2C
         cbJrNXJdI8YDPdAO7nC6MgAtrRk1dreiqJnTF3QX8jA4CJYDtGIFW4YDgKS62IyAiqBc
         GQMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769840717; x=1770445517;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=of/jk6w1rGgtFqkJD/eLgqCF5bATtfFhSRr/rVMr3d8=;
        b=ux6fb+4gievb0bAbnilpWwpFAKDc1y62fhV1YY7tZeRQO/Oz+WTrjczboB7m4bxDNG
         Dr+oAgGRPxGgSSWZ5i9v4ebiZOu4hG05aMTM4qUK/XMOKhdinLiED998DJoiAl/u1yAo
         Djm01VHmHg1Nee3IDklVEusH6rIan+Xf3WbDUudy8pXTE9GT5RolNxOvg47bGgaomj8I
         T0YXsDDE7nLn1kES5KGoDj7w293aCnG32HebxjhmC2Uiyrb6zJhRDqirHSjYvrdpbmVq
         9VTFWg9q7XhligOP6OzXHjFg900gUmKwPIN+bHOh2BDn/tIe0+TjH7BtZbMCJmrw4opy
         lQaw==
X-Gm-Message-State: AOJu0Yxp6A0LJ296usvU96rCCgaUw+WZ7sa2+SYzM+ewhr6oQADFzZnw
	XMJhwaEM7VBaxRSJnIpSl/yAadLrlwt0arR0eIROPFABxmMbFdtXcMJP
X-Gm-Gg: AZuq6aLaK3EvfHk8Z8kqos6wUg+6j2HkrGlqThMvUFY9LYQXwXIxihb7kjU680IZFPu
	rOa1xmO74LlDi7kKGKDYd0FL9vClSKwnGfLsVw4tAJsPmz8uOb2xn6SwcK6tlktWKkXx5GXlt3U
	eVr046r1YFlyGK2MeXCSjxSUvgONiV1IYvFKHwQQ6/52kEf4KOHOzbRCcl/qyeFTEUhjdaKY810
	lMXjb/hotNLNt9EE3gZRs2BK/budCT4EiW5VF97Yu8fWgUss8wZHh2+HLo0P4AvoYfFy4ijOp7S
	wTI933BVeIK05uTcfhAPJWAqnssyXNoCI8ytIa3hlwuK3XdPcACNXjQ9klYCJst5hG5NsEvoZ/Z
	0M26hRfiiP5+v4BriAa2OJn5mHQPazy5vdBNAn0Tmga7pOxVhYz9KzmD59lUBLtE/6yvNf/w4nD
	OJV9ruAJVZAs6Izxmno9bosmp9YRVUG0AT9Sp3jUkTWwhrqeZcKzOcIE6r4QDAbDmn4gHPngBRD
	wcShg==
X-Received: by 2002:a05:6a00:1249:b0:81f:473e:e8d7 with SMTP id d2e1a72fcca58-823ab749811mr5105864b3a.54.1769840716959;
        Fri, 30 Jan 2026 22:25:16 -0800 (PST)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:389d:2e0d:61f1:f4e0:f787])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379bfcab8sm9174062b3a.36.2026.01.30.22.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 22:25:15 -0800 (PST)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: agruenba@redhat.com
Cc: gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+aac438d7a1c44071e04b@syzkaller.appspotmail.com,
	Deepanshu Kartikey <Kartikey406@gmail.com>
Subject: [PATCH] gfs2: fix memory leaks in gfs2_fill_super error path
Date: Sat, 31 Jan 2026 11:55:09 +0530
Message-ID: <20260131062509.77974-1-kartikey406@gmail.com>
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
When gfs2_freeze_lock_shared() fails after init_threads() succeeds,
the created kernel threads (logd and quotad) are never destroyed.
This occurs because the fail_per_node label doesn't call
gfs2_destroy_threads().

Second leak: quota bitmap buffer (8192 bytes)
When gfs2_make_fs_rw() fails after gfs2_quota_init() succeeds but
before other operations complete, the allocated quota bitmap is never
freed. The error path destroyed threads but didn't cleanup quota
structures.

The fix consolidates thread cleanup at the fail_per_node label for all
error paths, which is safe because gfs2_destroy_threads() checks for
NULL pointers before calling kthread_stop_put(). Quota cleanup is added
specifically to the gfs2_make_fs_rw() error path where quota structures
were initialized.

Syzbot detected these leaks with the following signatures:

Thread leak (PATH 3: gfs2_freeze_lock_shared failure):
  unreferenced object 0xffff88801d7bca80 (size 4480):
    copy_process+0x3a1/0x4670 kernel/fork.c:2422
    kernel_clone+0xf3/0x6e0 kernel/fork.c:2779
    kthread_create_on_node+0x100/0x150 kernel/kthread.c:478
    init_threads+0xab/0x350 fs/gfs2/ops_fstype.c:611
    gfs2_fill_super+0xe5c/0x1240 fs/gfs2/ops_fstype.c:1265

Quota leak (PATH 4: gfs2_make_fs_rw failure):
  unreferenced object 0xffff88812de7c000 (size 8192):
    gfs2_quota_init+0xe5/0x820 fs/gfs2/quota.c:1409
    gfs2_make_fs_rw+0x7a/0xe0 fs/gfs2/super.c:149
    gfs2_fill_super+0xfbb/0x1240 fs/gfs2/ops_fstype.c:1275

Reported-by: syzbot+aac438d7a1c44071e04b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=aac438d7a1c44071e04b
Signed-off-by: Deepanshu Kartikey <Kartikey406@gmail.com>
---
 fs/gfs2/ops_fstype.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index e7a88b717991..fdc70189e4f1 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -1276,7 +1276,7 @@ static int gfs2_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	if (error) {
 		gfs2_freeze_unlock(sdp);
-		gfs2_destroy_threads(sdp);
+		gfs2_quota_cleanup(sdp);
 		fs_err(sdp, "can't make FS RW: %d\n", error);
 		goto fail_per_node;
 	}
@@ -1286,6 +1286,8 @@ static int gfs2_fill_super(struct super_block *sb, struct fs_context *fc)
 
 fail_per_node:
 	init_per_node(sdp, UNDO);
+	if (!sb_rdonly(sb))
+		gfs2_destroy_threads(sdp);
 fail_inodes:
 	init_inodes(sdp, UNDO);
 fail_sb:
-- 
2.43.0

