Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0936B3D9DAA
	for <gfs2@lists.linux.dev>; Thu, 17 Sep 2026 08:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789633066; cv=none; b=Ys1x5MYL0gqRSKzvoNAN507XC5dxDmGLoT6yD1PDqR20yIfvK3KRfpqwBdZQ7/fjxI9cilN03Diis67jmZ8wWrr8UVAT4lPPZE1CUefAr1c84foBUZQhP8YAzPqqKgztaGtV13kzRrydawh1LH2DBTYZPOzUQcw8efDjkMVQY2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789633066; c=relaxed/simple;
	bh=6Vua3enAHbmXaDGuGCt78TCaAfW6297ou862ewk7Tzs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Q4F9ygSPyATMGkfly7Yqc2v6tjcIXUKnbfVRO3FO/IxQRY2uIAcRkmCXKu0QyxUeOJXrp5uE5LqI5BvP1NOa4MZzT8zNRPp5Dg6ILo7f/vk3RYc4LXhcJ+dF8Y8q9SkckxDNjOxyTDUeY54kFmSHZw4Kr6wDcof8yHbtnH/x8tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=MJrffqtS; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="MJrffqtS"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=DIZ//ngLWWGofSQmLjgUk3u/tZSditcABNCCKH8NojQ=;
	b=MJrffqtSwkOpWLLUZHzJ+XbIJRz/JCj8WvAutpxznBt5IUXf3T1yyrv9ve5jdJXDPZdPFjVeS
	snPiFGXylmr0fdRkkcUUj1tz6bGt2f4PvYtA7JlUCPbEPowlAjtQzvN/eRmN0EHAhds//6p+fnK
	eRhIGbcZYLW7Mz/P9QWvzMk=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4hlpHV6RqSzmV7C;
	Thu, 17 Sep 2026 16:06:30 +0800 (CST)
Received: from whupemk100018.china.huawei.com (unknown [7.152.184.13])
	by mail.maildlp.com (Postfix) with ESMTPS id 532B84057C;
	Thu, 17 Sep 2026 16:17:30 +0800 (CST)
Received: from dggphis33418.huawei.com (10.244.148.83) by
 whupemk100018.china.huawei.com (7.152.184.13) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 17 Sep 2026 16:17:29 +0800
From: Gaosheng Cui <cuigaosheng1@huawei.com>
To: <cuigaosheng1@huawei.com>, <lujialin4@huawei.com>,
	<gongruiqi1@huawei.com>, <aahringo@redhat.com>, <teigland@redhat.com>
CC: <gfs2@lists.linux.dev>
Subject: [PATCH -next] dlm: fix WARN_ON_ONCE in dlm_lowcomms_close when no connection exists
Date: Thu, 17 Sep 2026 16:13:46 +0800
Message-ID: <20260917081346.4078281-1-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 whupemk100018.china.huawei.com (7.152.184.13)

From: Cui GaoSheng <cuigaosheng1@huawei.com>

Since commit 7138c7903468 ("dlm: disallow different configs nodeid
storages") a comm's nodeid is parsed from the configfs directory name,
e.g. "mkdir .../comms/0" creates a comm with nodeid 0. rmdir on a comm
whose addr was never written passes that nodeid through drop_comm()
and dlm_midcomms_close() into dlm_lowcomms_close(), where nodeid2con()
finds no connection in the hash table and WARN_ON_ONCE(!con) fires.
With panic_on_warn enabled this turns a harmless lookup miss into a
kernel panic that is reachable with two plain configfs operations:

  mkdir /sys/kernel/config/dlm/c/comms/0
  rmdir /sys/kernel/config/dlm/c/comms/0

Having no connection for a configfs-provided nodeid is a legitimate
state and not a kernel invariant violation. Before commit 6f0b0b5d7ae7
("fs: dlm: remove dlm_node_addrs lookup list") this case was handled
tolerantly with 'if (con)'. Downgrade the WARN_ON_ONCE to a plain
check again and quietly return -ENOENT, which drop_comm() already
ignores.

Fixes: 6f0b0b5d7ae7 ("fs: dlm: remove dlm_node_addrs lookup list")
Signed-off-by: Cui GaoSheng <cuigaosheng1@huawei.com>
---
 fs/dlm/lowcomms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
index ea8353c4638d..93c98f1fd793 100644
--- a/fs/dlm/lowcomms.c
+++ b/fs/dlm/lowcomms.c
@@ -1452,7 +1452,7 @@ int dlm_lowcomms_close(int nodeid)
 
 	idx = srcu_read_lock(&connections_srcu);
 	con = nodeid2con(nodeid, 0);
-	if (WARN_ON_ONCE(!con)) {
+	if (!con) {
 		srcu_read_unlock(&connections_srcu, idx);
 		return -ENOENT;
 	}
-- 
2.43.0

