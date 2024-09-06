Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F4074BF5
	for <gfs2@lists.linux.dev>; Fri,  6 Sep 2024 06:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725603551; cv=none; b=SZMAlUwq1LutDHDpkZCfuP+buvzBfLzJP+7md39FCJkLnzPxN4riIzEl/KX+22zbzBwYcyibN/mHxLekrz6hk4wwoUjhqh9g4QdTroGEKJa8NKzb8broj+Z8pVDu7uK/CG6j6eoiTopB6S3Tw8ahS+y39/33maI9asl9nkBTmyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725603551; c=relaxed/simple;
	bh=/z9BUTspTYTyCpbpvwg/0LvLuAIgJLO8Sryoouivmhw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n/25MrpXV4Mr8kAIPvm6BVN6IjP0OaNdIGumdzb9pmju94KfYxk4Z+10zbW8zUd8WjBbf6pqdtAXIkIqPdItn6MG5KECW7d3SxiE5/33smL+dR6jDJcBX3VyHXFOzul1x542qbpVcqEfIlhoiiUNiv3QGm+cYEw7d38tgqkcAQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4X0QxF15D9z1xx4X;
	Fri,  6 Sep 2024 14:17:05 +0800 (CST)
Received: from kwepemf500003.china.huawei.com (unknown [7.202.181.241])
	by mail.maildlp.com (Postfix) with ESMTPS id B40861400DB;
	Fri,  6 Sep 2024 14:19:06 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemf500003.china.huawei.com
 (7.202.181.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 6 Sep
 2024 14:19:06 +0800
From: Zhang Zekun <zhangzekun11@huawei.com>
To: <aahringo@redhat.com>, <teigland@redhat.com>, <gfs2@lists.linux.dev>
CC: <chenjun102@huawei.com>, <zhangzekun11@huawei.com>
Subject: [PATCH] dlm: Remove unused declartions in header files
Date: Fri, 6 Sep 2024 14:05:29 +0800
Message-ID: <20240906060529.9887-1-zhangzekun11@huawei.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemf500003.china.huawei.com (7.202.181.241)

The definition of dlm_lowcomms_shutdown_node() has been removed since
commit 54fbe0c15d9a ("fs: dlm: bring back previous shutdown handling").

Also, the definition of dlm_midcomms_receive_done has been removed
since commit 1696c75f1864 ("fs: dlm: add send ack threshold and append
acks to msgs"). Let's remove these empty declartions.

Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>
---
 fs/dlm/lowcomms.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/dlm/lowcomms.h b/fs/dlm/lowcomms.h
index fd0df604eb93..d3654f052972 100644
--- a/fs/dlm/lowcomms.h
+++ b/fs/dlm/lowcomms.h
@@ -34,7 +34,6 @@ bool dlm_lowcomms_is_running(void);
 
 int dlm_lowcomms_start(void);
 void dlm_lowcomms_shutdown(void);
-void dlm_lowcomms_shutdown_node(int nodeid, bool force);
 void dlm_lowcomms_stop(void);
 void dlm_lowcomms_init(void);
 void dlm_lowcomms_exit(void);
@@ -47,7 +46,6 @@ int dlm_lowcomms_resend_msg(struct dlm_msg *msg);
 int dlm_lowcomms_connect_node(int nodeid);
 int dlm_lowcomms_nodes_set_mark(int nodeid, unsigned int mark);
 int dlm_lowcomms_addr(int nodeid, struct sockaddr_storage *addr);
-void dlm_midcomms_receive_done(int nodeid);
 struct kmem_cache *dlm_lowcomms_writequeue_cache_create(void);
 struct kmem_cache *dlm_lowcomms_msg_cache_create(void);
 
-- 
2.17.1

