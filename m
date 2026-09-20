Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F5A3BBFD8
	for <gfs2@lists.linux.dev>; Sun, 20 Sep 2026 08:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789893098; cv=none; b=NVMeRNf8RvpIrtMdoPIhgANhq9lo4RnzBdCBWLonwnc1WPKy2eI0bLzLkwIszCzMI27sb8eUVhd0KWBY4fbWtUTxkm8oxsFXbfDkBMTfgOZW+1iHnFwXDYtQ8YDJqxegPJhU2YtIOn75Z6m7R6r0y1JGBCeRpCmW3F7eL5mQh6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789893098; c=relaxed/simple;
	bh=0mavBG8jADwhQv6KhYL+X91lG6MhE7mLPcuhg51y/rk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kZyV5aDTavZITtg+76XYMYW+LUS+DIQFoaRo83sDlFlG9Q+CD01PM1JOsusgd3nqE3tSnGmqaZOx2xELzMgY+g5/1etwTOlcZPOHVXkB5wY9Tsp+915uIYeTOqGp09FArVgZsDhBhbG8rZJsC9TYS8VFEfMgZ6QNw0+8JNRqby0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [117.147.104.32])
	by mtasvr (Coremail) with SMTP id _____wCHgD_ima9qvdImAQ--.25120S3;
	Sun, 20 Sep 2026 16:31:30 +0800 (CST)
Received: from localhost.localdomain (unknown [117.147.104.32])
	by mail-app3 (Coremail) with SMTP id zS_KCgAHQXTSma9qV+dHBQ--.54809S4;
	Sun, 20 Sep 2026 16:31:29 +0800 (CST)
From: Jiacheng Xu <stitch@zju.edu.cn>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Jiacheng Xu <stitch@zju.edu.cn>,
	gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/4] gfs2: protect statfs sync sysfs callback
Date: Sun, 20 Sep 2026 16:31:03 +0800
Message-ID: <20260920083109.30798-3-stitch@zju.edu.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260920083109.30798-1-stitch@zju.edu.cn>
References: <20260920083109.30798-1-stitch@zju.edu.cn>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zS_KCgAHQXTSma9qV+dHBQ--.54809S4
X-CM-SenderInfo: qtrxiiaqttimo62m3hxhgxhubq/
X-CM-DELIVERINFO: =?B?ZJr9bgXKKxbFmtjJiESix3B1w3tMoM3snk/k5SVzZVydjEqe1eefKHnLf95EnB4iem
	egWzO/wNhIP+pglnkLd0BnOscvQVO6NqLDoKOrWoE6q5PZHv56cT8BWJRDUtThYGkWp+Pf
	LkD8QZ23s48MrbYdbPISji9OAfmK+DAn36hRITZ1
X-Coremail-Antispam: 1Uk129KBj93XoW7tw45Xw1xKry8XF1rKw13KFX_yoW8Gr13pF
	nrZr15Gw1kGr18Xa4vkF4Fg3W8CayrtFy3K34vqwnrZan8JwnIq34xKFyj9Fy8ArZrGry7
	Wr4vvasIyFWUGrcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvmb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0Y48IcxkI7V
	AKI48G6xCjnVAKz4kxMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I
	3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxV
	WUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8I
	cVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aV
	AFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZE
	Xa7IU8c4S7UUUUU==

The statfs_sync sysfs file remains accessible while gfs2_put_super()
releases sd_statfs_inode during unmount. A concurrent write can then
enter gfs2_statfs_sync() and dereference the released inode.

Serialize the sysfs callback with the superblock lifetime. Use a
non-blocking read lock so mount failure and unmount paths can remove
the sysfs files while holding s_umount for writing, and reject access
before the superblock becomes active.

Signed-off-by: Jiacheng Xu <stitch@zju.edu.cn>
---
 fs/gfs2/sys.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/gfs2/sys.c b/fs/gfs2/sys.c
index 0d247299625c..fd6e8e34651d 100644
--- a/fs/gfs2/sys.c
+++ b/fs/gfs2/sys.c
@@ -229,6 +229,7 @@ static ssize_t withdraw_store(struct gfs2_sbd *sdp, const char *buf, size_t len)
 static ssize_t statfs_sync_store(struct gfs2_sbd *sdp, const char *buf,
 				 size_t len)
 {
+	struct super_block *sb = sdp->sd_vfs;
 	int error, val;
 
 	if (!capable(CAP_SYS_ADMIN))
@@ -241,7 +242,12 @@ static ssize_t statfs_sync_store(struct gfs2_sbd *sdp, const char *buf,
 	if (val != 1)
 		return -EINVAL;
 
-	gfs2_statfs_sync(sdp->sd_vfs, 0);
+	if (!super_trylock_shared_active(sb))
+		return -EAGAIN;
+
+	gfs2_statfs_sync(sb, 0);
+
+	super_unlock_active(sb);
 	return len;
 }
 
-- 
2.51.0

