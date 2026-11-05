Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.112
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793857591;
	b=c5Tr94rPss4JZ1CiVz76+pGE2R6lo2hfQk4y24FQnrH9WhMLF6iQQpynC5GjMGNITByC
	 V0m37/0NPNzSZY0QOGalYwTHCb192yZl7JRz4Wx71pLKSph5Y7R1uYIlJ6BArQtt3nIN7
	 O3tKAPP21AYsavRTln5TMsUKx92HSTo6v1g95JZsjD5u3uK1vyQyWRefcdqDGEphtn2G8
	 Vn/Kf7YGIjyFeC7Oox8qhjzjM/5vMcYARUEm1IGc2UvzW0ssfnzrcLkveBFbWafoBz7Ok
	 SfTrFqURZUuQmdDoRYaYsKBXrodQbPV2CRo0ghtLa/Oa4h1/upbpPwRcGnHbgm5uqww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793857591;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=2shg/YMi6akEFOyYGyHnGFQBSOWevhHvo+heT6+0RCs=;
	b=I4VR2wwujJ7p74NRTvuSCi2C1Ye4Xr9c2lvBG3LKV22JJFn7ZgcYb/bB4eLjQOW3kOtS
	 lyMsknxVzSZY/pSu2GwiTMMQo//gi7SRiacURZrNKwVxtAz49ik5eC3NHrP4bPO6iJe8D
	 A4c4AMfuFNW5+UUwwEhMd2BRnmsPIaimCScKWQ64wNsAYALs2Un1to1WfkQOxFvd7wzx9
	 jA7ho2dAhlaq/S/lzqx8sI1q23WCneBVCG79G001Ajx5RNE6r7rgIXNlfvkGftgtgCdLJ
	 Nywd7QIsFLIBGGuZsXSWklpY4CwlwzaBDtDjTnlnpZgaqWFoIfsyLwn+z0W/JP/EtRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=NLC4Gi4U;
	arc=none smtp.remote-ip=115.124.30.112
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE19606A328
	for <gfs2@lists.linux.dev>; Thu,  5 Nov 2026 05:46:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9BE19606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=NLC4Gi4U
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793857578; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=2shg/YMi6akEFOyYGyHnGFQBSOWevhHvo+heT6+0RCs=;
	b=NLC4Gi4UMwdtBjm48mmA/eJlVTi21Zh9uBtDieX+RycJhGAq8WUnbiPm/9oWcV6C12dRrnCjMLGSDGwyz/wuswxq9wwsmvgAJdElyDQwHqpvSan+4hJ3XZNwcIeIQgdrZ4URoI6SHNhxQp+dWzN+V4OKOwB3U1qZIeNe+iaWbFY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R361e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0XE7dCa2_1793857577;
Received: from localhost(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0XE7dCa2_1793857577 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 05 Nov 2026 13:46:18 +0800
From: Joseph Qi <joseph.qi@linux.alibaba.com>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] gfs2: release the statfs glock when gfs2_clear_beyond_eof() fails
Date: Thu,  5 Nov 2026 13:46:08 +0800
Message-Id: <20261105054609.2759418-1-joseph.qi@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Post: <mailto:gfs2@lists.linux.dev>
List-Help: <mailto:gfs2+help@lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
List-Owner: <mailto:gfs2+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

gfs2_file_buffered_write() acquires the master statfs glock before
writing to the rindex and releases it once the write is done.  The only
error path in between used to be the failure of that acquisition, which
gfs2_glock_nq_init() unwinds by itself, so the cleanup code at the end of
the function never had to deal with a held statfs glock.

Commit 4982e58669b1 ("gfs2: page poisoning fix") added a call to
gfs2_clear_beyond_eof() right after the acquisition and made it jump to
out_unlock on failure.  That path only drops the inode glock and then
frees statfs_gh, so a failed write to the rindex leaves the master
statfs glock held exclusively and frees a holder that is still linked
into the glock's holder list.  The GL_NOCACHE demote is requested by
__gfs2_glock_dq(), which is never reached, so the glock stays locked for
the rest of the mount, and the glock and pid references taken by
__gfs2_holder_init() leak as well.  Walking the stale list entry later
on, for instance from do_promote() or from a demote callback, is a
use-after-free.

gfs2_clear_beyond_eof() zeroes the space beyond eof, which for the
rindex ends up in adjust_fs_space(), so the call cannot be moved out
from under the statfs glock.  Release the holder in the error path
instead, guarded by gfs2_holder_initialized() so that the paths which
never acquired it and the one which already released it are unaffected.

Fixes: 4982e58669b1 ("gfs2: page poisoning fix")
Cc: stable@vger.kernel.org
Signed-off-by: Joseph Qi <joseph.qi@linux.alibaba.com>
---
 fs/gfs2/file.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index 1efd0679badd9..2452d3ecf09c7 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -1087,6 +1087,8 @@ static ssize_t gfs2_file_buffered_write(struct kiocb *iocb,
 		goto retry;
 	}
 out_unlock:
+	if (inode == sdp->sd_rindex && gfs2_holder_initialized(statfs_gh))
+		gfs2_glock_dq_uninit(statfs_gh);
 	if (gfs2_holder_queued(gh))
 		gfs2_glock_dq(gh);
 out_uninit:
-- 
2.39.3

