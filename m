Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A764120B
	for <gfs2@lists.linux.dev>; Tue, 20 Aug 2024 03:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724124719; cv=none; b=XCbTwF3lZrv+uhjmRAcqlhVMz6wDZ2C/vlx0xsaRxWdwjTOkXNRqjEPQQZyoViInZKSW+MMhY+D9QVDrSjOctb4Oh5HxAaAWeYlLE/+98YkbyqIpD+rswPVmeNBflPH4eLkGDs69l1j6TQ0NLk9/txRX65Hk0o1m1Jy3I3A26CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724124719; c=relaxed/simple;
	bh=Lsks9gT6Mzx0h2HgXjICoo9sTX9N2S+fZp6knFYb9CU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NJu74hMYwv0Uj+2Lt86DlGxX1tEW3qVLZBYAzZUkKD+9p7ZF+GBLSJzO64tT7t1u3SJqRvgCr1K8L1rBWAZUR8iQpUq/qkj9HmNNJpcatLGKH9ZmfWZiSBSLkNAl4J040RkC1oi5hhSwB9RUAFRAJfsazbdMDHtox+TKAdMlRuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BrjClzLz; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BrjClzLz"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2021a99af5eso22538575ad.1
        for <gfs2@lists.linux.dev>; Mon, 19 Aug 2024 20:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724124717; x=1724729517; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nBpomUDHMNH7osuoqx8GMBZw65c4SL4hGXGtEruA0HY=;
        b=BrjClzLzKh54/ZW+Wg/fnaU2zbysAojpf66WvnbzpxCUhbnwVOKQwLDNLS1zvg7bNw
         qJ5TSdxJjOW6twMwLIExrL6BGYf2Wl8K+hf4QVNVHC5tbobu6Mcm8nMneMlF1RyCsVxb
         xMMzHPyfdTlmqQYe9KYaW8Jl49NvZKgsguIyIhltDSyj+WtxhOTRAIiP8UhFcqc5O3RN
         ytP7CHFXGFilMvIrWAylGHuO61kR3BDdSx9g5EgThBgIYWkYq0dhHTVkBMaEFXZiDV8X
         Wax6sA2YNYZ0BKBxO9dGsAIaiHtXe1q/y0D3TfmPKJrW7d8R8uzn8Xy+ybHdbOgTissO
         CPVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724124717; x=1724729517;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nBpomUDHMNH7osuoqx8GMBZw65c4SL4hGXGtEruA0HY=;
        b=W6Sf0lTQ8IrUJtrR980T3nw28O+btykOsyNCYiuCdneathj0kXXYgMNQ3P8dbiUWxA
         nqKKkEE9DsaNQwG7B+J0ZUo0nXEIGnNlQ0Xxi6FeeeOmRqkD4RVPEDI9GGqf8fAkNE9/
         jHVEgLENISZCQlLDQzFvWVeqM3gyOr7F3VK8+aBUYAVXiaCcyPnVN4dTzirvT9dGDiKc
         Wh/dOBz5OE92nxginqfGHsVfSH+SaHVh4aZ+nVnJIVRfKc0hAgl0K/9KHPn5c7UKmqC0
         xk2y2dtPCb/lg5ERGTonPl+6n2XXjDUjyO8Fh4MTXO5sTtCMODzT+YjaA9bck+47BtDz
         pe0g==
X-Gm-Message-State: AOJu0YzivWFAUdypmob0Ur0qc9lt70HOPTGaP70+y0vhCS1Nc+l8bGQU
	6TC0Q/ToHs1cRwaGGeM1S0CTuVHtr0E/R56uSbCrMm4qM+Iq2y61FP0t389t
X-Google-Smtp-Source: AGHT+IEffL7jXIh+0ls5CoWvCOqF31cquBrZihGEprotxLlNle5BEtjn//syfW/d1AuHY06fynYBNQ==
X-Received: by 2002:a17:903:41cf:b0:1fb:973f:866 with SMTP id d9443c01a7336-20203f47a9emr140920385ad.52.1724124716575;
        Mon, 19 Aug 2024 20:31:56 -0700 (PDT)
Received: from localhost ([123.113.109.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f0302d28sm69242465ad.31.2024.08.19.20.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 20:31:56 -0700 (PDT)
From: Julian Sun <sunjunchao2870@gmail.com>
To: gfs2@lists.linux.dev,
	syzbot+d34c2a269ed512c531b0@syzkaller.appspotmail.com
Cc: agruenba@redhat.com,
	Julian Sun <sunjunchao2870@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] gfs2: fix double destroy_workqueue error
Date: Tue, 20 Aug 2024 11:31:48 +0800
Message-Id: <20240820033148.29662-1-sunjunchao2870@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When gfs2_fill_super() fails, destroy_workqueue()
is called within gfs2_gl_hash_clear(), and the
subsequent code path calls destroy_workqueue()
on the same work queue again.

This issue can be fixed by setting the work
queue pointer to NULL after the first
destroy_workqueue() call and checking for
a NULL pointer before attempting to destroy
the work queue again.

Reported-by: syzbot+d34c2a269ed512c531b0@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=d34c2a269ed512c531b0
Fixes: 30e388d57367 ("gfs2: Switch to a per-filesystem glock workqueue")
Cc: stable@vger.kernel.org
Signed-off-by: Julian Sun <sunjunchao2870@gmail.com>
---
 fs/gfs2/glock.c      | 1 +
 fs/gfs2/ops_fstype.c | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 12a769077ea0..4775c2cb8ae1 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -2249,6 +2249,7 @@ void gfs2_gl_hash_clear(struct gfs2_sbd *sdp)
 	gfs2_free_dead_glocks(sdp);
 	glock_hash_walk(dump_glock_func, sdp);
 	destroy_workqueue(sdp->sd_glock_wq);
+	sdp->sd_glock_wq = NULL;
 }
 
 static const char *state2str(unsigned state)
diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index ff1f3e3dc65c..c1a7ff713c84 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -1305,7 +1305,8 @@ static int gfs2_fill_super(struct super_block *sb, struct fs_context *fc)
 	gfs2_delete_debugfs_file(sdp);
 	gfs2_sys_fs_del(sdp);
 fail_delete_wq:
-	destroy_workqueue(sdp->sd_delete_wq);
+	if (sdp->sd_delete_wq)
+		destroy_workqueue(sdp->sd_delete_wq);
 fail_glock_wq:
 	destroy_workqueue(sdp->sd_glock_wq);
 fail_free:
-- 
2.39.2

