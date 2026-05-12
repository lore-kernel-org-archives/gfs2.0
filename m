Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD2F25B0A3
	for <gfs2@lists.linux.dev>; Tue, 12 May 2026 06:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778567245; cv=none; b=Yz4bBmeEWX6YeIwZ7xjRqmUBMSZhIfbuLftCc7EvldLZvTbUjDZt3nKxGK/FxjhVSMAW0wFOmdRCwVpG0kaCM7uMTAl6Cu3FDKte0sxZiMej5ZUaj0TIxPpo725dlxRo/a3gA/yL7adJ/74bRKLCAtv2009kFo7NQP3DSuASpeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778567245; c=relaxed/simple;
	bh=tFLvmSxp4htg8B4KZDDmMq/bcP6GsrTV6SVZmFUptD4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IuxWXkz5Ry8249Cg+zP9LSFab0Vwvsu2lew6U91BBtAPgKzTi8Bm5L5S25IFtMkydR26lzmrWThUbZQ9j8K1GA+NI3Y6bO/Z0ODElN8y4lGwbPInn0981NRcJKW6PqtKzvlp6V7UBQgFbH5Weay//3F4jwW3k8OCNeZ1acPUX8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mails.ucas.ac.cn; spf=pass smtp.mailfrom=mails.ucas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mails.ucas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.ucas.ac.cn
Received: from fric.. (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowABniN80yAJqsrLCEA--.13642S2;
	Tue, 12 May 2026 14:27:00 +0800 (CST)
From: Jiakai Xu <xujiakai24@mails.ucas.ac.cn>
To: gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	Steven Whitehouse <swhiteho@redhat.com>,
	Jiakai Xu <xujiakai24@mails.ucas.ac.cn>
Subject: [PATCH] gfs2: Fix recursive quota glock locking in do_sync
Date: Tue, 12 May 2026 06:26:59 +0000
Message-Id: <20260512062659.2037092-1-xujiakai24@mails.ucas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowABniN80yAJqsrLCEA--.13642S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww1xuw47WF4rAFWUWrWUtwb_yoW8urW8pr
	4DC3WfX3WDJrWIgayaqr4FvF1rK3yxuF1UGFZ7CrnxZrs8trsavryvyw4qqF1Fqrs3JFnY
	gFyqqrsxGw1DCF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvC14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr0_Cr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
	rcIFxwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2Kf
	nxnUUI43ZEXa7VUjwSdDUUUUU==
X-CM-SenderInfo: 50xmxthndljko6pdxz3voxutnvoduhdfq/

During GFS2 unmount, do_sync() in gfs2_quota_sync() may try to re-acquire
quota data glocks that the current process already holds (from earlier
file operations that performed quota accounting). The GFS2 glock layer's
add_to_queue() detects this as recursive locking via the trap_recursive
mechanism and hits BUG().

Fix this by checking gfs2_glock_is_locked_by_me() before each
gfs2_glock_nq_init() call in do_sync(). If the current process already
holds the glock, skip the acquisition. The cleanup path is updated to
only call gfs2_glock_dq_uninit() on holders that were actually acquired.

Fixes: 1e72c0f7c40e ("GFS2: Clean up gfs2_adjust_quota() and do_glock()")
Signed-off-by: Jiakai Xu <xujiakai24@mails.ucas.ac.cn>
---
 fs/gfs2/quota.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
index 91e9975d25e8..f2a09869ee8f 100644
--- a/fs/gfs2/quota.c
+++ b/fs/gfs2/quota.c
@@ -929,6 +929,19 @@ static int do_sync(unsigned int num_qd, struct gfs2_quota_data **qda,
 	sort(qda, num_qd, sizeof(struct gfs2_quota_data *), sort_qd, NULL);
 	inode_lock(&ip->i_inode);
 	for (qx = 0; qx < num_qd; qx++) {
+		/*
+		 * If we already hold this quota glock (because do_sync was
+		 * called from a context where quota glocks are already held,
+		 * such as during unmount), skip the recursive acquisition.
+		 *
+		 * We mark the holder with a NULL glock pointer so the cleanup
+		 * path knows not to release it.
+		 */
+		if (gfs2_glock_is_locked_by_me(qda[qx]->qd_gl)) {
+			memset(&ghs[qx], 0, sizeof(ghs[qx]));
+			continue;
+		}
+
 		error = gfs2_glock_nq_init(qda[qx]->qd_gl, LM_ST_EXCLUSIVE,
 					   GL_NOCACHE, &ghs[qx]);
 		if (error)
@@ -990,7 +1003,8 @@ static int do_sync(unsigned int num_qd, struct gfs2_quota_data **qda,
 	gfs2_glock_dq_uninit(&i_gh);
 out_dq:
 	while (qx--)
-		gfs2_glock_dq_uninit(&ghs[qx]);
+		if (ghs[qx].gh_gl)
+			gfs2_glock_dq_uninit(&ghs[qx]);
 	inode_unlock(&ip->i_inode);
 	kfree(ghs);
 	gfs2_log_flush(glock_sbd(ip->i_gl), ip->i_gl,
-- 
2.34.1

