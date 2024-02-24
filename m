Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A094D59C
	for <gfs2@lists.linux.dev>; Sat, 24 Feb 2024 13:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708782537; cv=none; b=GnbhoyACMr0jdlufiWB3cLrLk5C1YIgIDMnT8DllP37/Y5JvcjtCkRBin14gZHUdO80LWU7K/GXmOyRlLpisH+dPfT2kpLvQs9LD470aprmaN3ArwuRKDUAN0c3vm4ucwmvCSlRrv0bCyz66SqSA4mI1SvuXdeS7JIJbZS6+os4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708782537; c=relaxed/simple;
	bh=y2pUB53F1wMAZ04nzFKOITyd4dvsaa9cjjMHjK96d5Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Z2vY0qpmE90SkgEby8vi++U061vbGnhElRFbByc+wI08kK0srx65ufqV4NGFQORgJXQC89JqsRs8f8SINXDf/o/afKXmZf0BgsCUOTrXdMNnZ0b1SDiKRsFGLn/wRIr4pdyQzwMB0Zf+voxHLo82gypoeQa2pExSP98tEJRH5Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ms/zeVZy; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ms/zeVZy"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708782534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rikMo19CagWQcspLQnXP+zWMLIAYXL5i/D+P5ICzeiQ=;
	b=ms/zeVZyBJ5AE0Ryv8ygow1uTLiltSGM7YRvR9KT3WlR5UcXaXJ2GENMtdT3zBCI/rgEAi
	7Un6qkTkajDJJz1lIJvGijrmeMRnBu0hxFcnrv7SnqsUwrkhmKNVidnFyzzCNgBYMcN+OW
	FGzABBKfQhgjeZNO9TeKoMOlyLu98BY=
From: chengming.zhou@linux.dev
To: agruenba@redhat.com
Cc: gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	vbabka@suse.cz,
	roman.gushchin@linux.dev,
	Xiongwei.Song@windriver.com,
	chengming.zhou@linux.dev,
	Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH] gfs2: remove SLAB_MEM_SPREAD flag usage
Date: Sat, 24 Feb 2024 13:48:47 +0000
Message-Id: <20240224134847.829536-1-chengming.zhou@linux.dev>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Chengming Zhou <zhouchengming@bytedance.com>

The SLAB_MEM_SPREAD flag is already a no-op as of 6.8-rc1, remove
its usage so we can delete it from slab. No functional change.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 fs/gfs2/main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/gfs2/main.c b/fs/gfs2/main.c
index 79be0cdc730c..04cadc02e5a6 100644
--- a/fs/gfs2/main.c
+++ b/fs/gfs2/main.c
@@ -111,7 +111,6 @@ static int __init init_gfs2_fs(void)
 	gfs2_inode_cachep = kmem_cache_create("gfs2_inode",
 					      sizeof(struct gfs2_inode),
 					      0,  SLAB_RECLAIM_ACCOUNT|
-						  SLAB_MEM_SPREAD|
 						  SLAB_ACCOUNT,
 					      gfs2_init_inode_once);
 	if (!gfs2_inode_cachep)
-- 
2.40.1

