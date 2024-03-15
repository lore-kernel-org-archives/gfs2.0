Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017C91426B
	for <gfs2@lists.linux.dev>; Fri, 15 Mar 2024 08:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710491763; cv=none; b=Vic5u+aZKaIaEGiNFKmotRohP0YocZmE3EaX3L42+0wFdzG8mV8Ni7LlpI96MUPA19vdBnEAB0Nvrt7RBKEQk9B9b7rt5cB72vDXCqt5XdllpaKTQ/WBKxbI8ekk+rdn0AvyHpQFjPDY4tKUyhSqGHlByzUC0UVFRBtaMn7gCvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710491763; c=relaxed/simple;
	bh=n4G4T8oSzvPqCykLFBPu7YRsZb7NCUXHPm7H7F+I6B8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ul5LuFih6bdY8eXACGPjtBQpeoOxPJ0gMFrakKvg+0kbWftDEmKSrAJ9urp28VY2gN+qjcQ+WzE+kY4IhM2epW8AuVRrziCnzoJFAYSZ0g7rFnGHjp/5i1KwuLWk1gHAlMUVQU1tLIQS66sHOufN3wm2pRMtVdLMcO2i6TEqx7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=NNNrQ2nw; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="NNNrQ2nw"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710491757; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=OS1OAx3gqUeFAauhXemYnWq9aR/43E4kD1qguWWMjps=;
	b=NNNrQ2nw8EygNHWcwChlvW5BEpQUW1mTpOVlbo42mejixEODRikX8ido4Bf58TVoyvNzyKDTC1YQsoSBVR9gxNatAAdDXZrWkEPKSvgRD9WKRk0mDPpByQf7cpLbDMYgTgprrlaZmU/y5URSnLC5Xmq4Uae33K2+nJPSZmLhHyg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0W2Vhqfq_1710491754;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0W2Vhqfq_1710491754)
          by smtp.aliyun-inc.com;
          Fri, 15 Mar 2024 16:35:55 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: agruenba@redhat.com
Cc: gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next] fs: Add kernel-doc comments to __gfs2_holder_init()
Date: Fri, 15 Mar 2024 16:35:51 +0800
Message-Id: <20240315083551.76624-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds kernel-doc style comments with complete parameter
descriptions for the function __gfs2_holder_init.

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 fs/gfs2/glock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 34540f9d011c..08e2fe282190 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -1260,6 +1260,7 @@ int gfs2_glock_get(struct gfs2_sbd *sdp, u64 number,
  * @state: the state we're requesting
  * @flags: the modifier flags
  * @gh: the holder structure
+ * @ip: an opaque identifier for the caller
  *
  */
 
-- 
2.20.1.7.g153144c

