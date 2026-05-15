Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D04241139
	for <gfs2@lists.linux.dev>; Fri, 15 May 2026 07:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778830789; cv=none; b=qDshUY9wzKZRZOBHNe4WIC7ywcYEHh83xOheV6e7HZKgCQ565uHGCtm6FpYyUioHzBZZh6gxRAyIrrGO8vXMmxq4queIDUaROgx+dxQyGXPR0UKLaf+B5upnfwGGnE/7ZGAXZEz0TgslPy3nZ+WMuzmlJqAfjDr3H2eVfm3BUHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778830789; c=relaxed/simple;
	bh=uRGzNLtKB5gJo7fBnMw4GOh7Q0O4cUErR4+W/is611o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MS2WmbSfYB+2ib2iB/vdUkineFEIHYW3XbpUYfXc344jF/WjF8oC3U9q8AGi2/FjHAI7P593L3PcuXGiZ8NguMlbVBjwvGwDzzHvZ0tdS0kq/Df4ph6yorfjKgVgPYlXJTGW9cVlYqqs8EUF9RnwGM7meFzVdx9ByNg+WfPvysE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Fdfh97xO; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Fdfh97xO"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1778830776; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=OxH/8aoS7IFjzJmSWB5+Aa/p3DfI/UF05mzvwqxmoY4=;
	b=Fdfh97xOZD9KmxlBGGoWguW/THCC9k993hJeCcdn32FHpN16o7XJhluXU9Jul8cUvVDRnlzCAGAFwLu76X7VJ7LwcDVaWmw3u1ISYNRdhh8u9IY2MBxYHdgx5zhjc1vQcmxmLY+IGZN53mn5g9Bc78aSwQXWUDufBOQCxTlAwAc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R291e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0X2yoTdf_1778830774;
Received: from localhost(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0X2yoTdf_1778830774 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 15 May 2026 15:39:34 +0800
From: Joseph Qi <joseph.qi@linux.alibaba.com>
To: Alexander Aring <aahringo@redhat.com>,
	David Teigland <teigland@redhat.com>
Cc: gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dlm: check negative length in dlm_search_rsb_tree
Date: Fri, 15 May 2026 15:39:33 +0800
Message-Id: <20260515073933.1978699-1-joseph.qi@linux.alibaba.com>
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

Fix this by also rejecting len <= 0.

Signed-off-by: Joseph Qi <joseph.qi@linux.alibaba.com>
---
 fs/dlm/lock.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index c381e1028446..124f68c8e653 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -626,8 +626,10 @@ int dlm_search_rsb_tree(struct rhashtable *rhash, const void *name, int len,
 			struct dlm_rsb **r_ret)
 {
 	char key[DLM_RESNAME_MAXLEN] = {};
-	if (len > DLM_RESNAME_MAXLEN)
+
+	if (len <= 0 || len > DLM_RESNAME_MAXLEN)
 		return -EINVAL;
+
 	memcpy(key, name, len);
 	*r_ret = rhashtable_lookup_fast(rhash, &key, dlm_rhash_rsb_params);
 	if (*r_ret)
-- 
2.39.3

