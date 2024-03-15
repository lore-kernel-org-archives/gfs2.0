Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A383C17581
	for <gfs2@lists.linux.dev>; Fri, 15 Mar 2024 08:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710490421; cv=none; b=P8QagAzxxZc73qnfdebRu1opY7XEp0KZ+NTrxk/FG0G9Nu/Opso5xIQH05F2r5ehohj7FUIwKoFzIV4IxjbvXwXnA/PVR9KTbbF6SDol2uXnDlQu3Ckd5NnpTz/68MDXbFYppcF27BLMzD3lCNrlazonIYenDBFXuumedTJSees=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710490421; c=relaxed/simple;
	bh=bC7My8oeg0T3EHs8tbxbV7WmTFSCamPB62t8Ch/QUFE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lE6rSYyiO+GH9FNYCXg7qyEn2F46zal3eBw/9z1oE/OZNaTcgHyzKrwiy+Rzh723UDIzEMAicjB7moggmSr5RlXwz8+UaVx3EhoAGHzxh+cYGHKI2wYifspjI7rEeP77A9rPu0xtKuLiTUN/OYozUjRfJO7ePsWvfN92+STkHMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=q6yDouKM; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="q6yDouKM"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710490417; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=SQuXMqSOanP/j7MWbwE28K2yMx+KaDM6sNBTCkxedCA=;
	b=q6yDouKM+dyH5Rl6QQpryJebEmMGq5vIH90YBNseVq11dC3EZtunFUB7JcOW/oyJI1D+BED30Lh46RWYGJZPqS1BJh02K/U1OYLq78Yoe794qgPOWJ+mU3yaqck3BVf60/eZUWDMnn12AfwTti0oykWG+a8+PmFz7i9PQsHyx8U=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R221e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0W2Vb1QP_1710490413;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0W2Vb1QP_1710490413)
          by smtp.aliyun-inc.com;
          Fri, 15 Mar 2024 16:13:34 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: agruenba@redhat.com
Cc: gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next] fs: Add kernel-doc comments to functions gfs2_freeze_super and gfs2_thaw_super
Date: Fri, 15 Mar 2024 16:13:32 +0800
Message-Id: <20240315081332.27389-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds kernel-doc style comments with complete parameter
descriptions for the functions gfs2_freeze_super and gfs2_thaw_super.

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 fs/gfs2/super.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index 9de789b78bc5..240822fee6fb 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -731,6 +731,7 @@ void gfs2_freeze_func(struct work_struct *work)
 /**
  * gfs2_freeze_super - prevent further writes to the filesystem
  * @sb: the VFS structure for the filesystem
+ * @who: indicates the entity that holds the freeze
  *
  */
 
@@ -799,6 +800,7 @@ static int gfs2_freeze_fs(struct super_block *sb)
 /**
  * gfs2_thaw_super - reallow writes to the filesystem
  * @sb: the VFS structure for the filesystem
+ * @who: indicates the entity that holds the freeze
  *
  */
 
-- 
2.20.1.7.g153144c

