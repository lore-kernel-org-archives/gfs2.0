Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC5040855
	for <gfs2@lists.linux.dev>; Sun, 17 May 2026 02:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778983401; cv=none; b=U5O128osWBddxKcFvKYKCmKK2N5Bdbafo4AsGZgl5WH0af5AWi8gDoHC8kH6jXmbMsa30WlI0+UMxdHRqBD5GiqBgmq80V+pbRsP9wCu799hutBV/jdlfdfN2+sC88Zk7DkxpolKFKeJg6TfXivdx5UZ6W/ZrZIf7BoiYPWBurI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778983401; c=relaxed/simple;
	bh=OZaF65CAxpQhqrTwoAcvSbsy6bo+yvZQtd4kOuTOz/Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZSvnh/K8qFUOSUMaRLWAIZG1p3wAwkngGCffNDmxV1j1gmO8Lzb5OtY4y1F+iz+WXQb7Me3IOBdgwYAqsDVYOf99Uhe7wDGWD+hKkM5xuIpfZfq8QSw3sZX44Ko3v8c2S8ZDm97RIrqJkElf1re0Gi6uQkfuvVmQNDpU8UkS+qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=CAIgwEQj; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="CAIgwEQj"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1778983396; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=QXS3hNbrZ4Nzu6OYlroIi+JUoZXxAzaSbf2a0n1gpr8=;
	b=CAIgwEQjMlM9CL95IW/nRTAXdwnvLFXMYgtoAMznHZ7MBZg4i8p2nCSdn2URpSCBuuPCgPYbPzsetateJmhTeZJMd9jrtURasgcRw0KU7rGuziRpgdT7x0xB26N71NHn6AN0ZqmoqLyfBk2gt7OH+x6mDSLVQScmdPNUz8pVKyw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0X30jt-c_1778983395;
Received: from localhost(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0X30jt-c_1778983395 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 17 May 2026 10:03:15 +0800
From: Joseph Qi <joseph.qi@linux.alibaba.com>
To: Alexander Aring <aahringo@redhat.com>,
	David Teigland <teigland@redhat.com>
Cc: gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] dlm: fix buffer overflow from negative len in dlm_search_rsb_tree
Date: Sun, 17 May 2026 10:03:15 +0800
Message-Id: <20260517020315.1064253-1-joseph.qi@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 080e5563f878 only checks for len > DLM_RESNAME_MAXLEN, which does
not catch negative values. While the input 'len' can be negative and a
negative int passed to memcpy() is implicitly converted to a large
size_t, causing a stack buffer overflow on the key[] array.

Fix this by changing the 'len' parameter type from int to unsigned int.
This ensures negative values from callers are implicitly converted to
large unsigned values that are caught by the existing
len > DLM_RESNAME_MAXLEN check.

Signed-off-by: Joseph Qi <joseph.qi@linux.alibaba.com>
---
 fs/dlm/lock.c | 6 ++++--
 fs/dlm/lock.h | 4 ++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index c381e1028446..373abdb4354a 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -622,12 +622,14 @@ static int get_rsb_struct(struct dlm_ls *ls, const void *name, int len,
 	return 0;
 }
 
-int dlm_search_rsb_tree(struct rhashtable *rhash, const void *name, int len,
-			struct dlm_rsb **r_ret)
+int dlm_search_rsb_tree(struct rhashtable *rhash, const void *name,
+			unsigned int len, struct dlm_rsb **r_ret)
 {
 	char key[DLM_RESNAME_MAXLEN] = {};
+
 	if (len > DLM_RESNAME_MAXLEN)
 		return -EINVAL;
+
 	memcpy(key, name, len);
 	*r_ret = rhashtable_lookup_fast(rhash, &key, dlm_rhash_rsb_params);
 	if (*r_ret)
diff --git a/fs/dlm/lock.h b/fs/dlm/lock.h
index b23d7b854ed4..c75975937331 100644
--- a/fs/dlm/lock.h
+++ b/fs/dlm/lock.h
@@ -31,8 +31,8 @@ void resume_scan_timer(struct dlm_ls *ls);
 int dlm_master_lookup(struct dlm_ls *ls, int from_nodeid, const char *name,
 		      int len, unsigned int flags, int *r_nodeid, int *result);
 
-int dlm_search_rsb_tree(struct rhashtable *rhash, const void *name, int len,
-			struct dlm_rsb **r_ret);
+int dlm_search_rsb_tree(struct rhashtable *rhash, const void *name,
+			unsigned int len, struct dlm_rsb **r_ret);
 
 void dlm_recover_purge(struct dlm_ls *ls, const struct list_head *root_list);
 void dlm_purge_mstcpy_locks(struct dlm_rsb *r);
-- 
2.39.3

