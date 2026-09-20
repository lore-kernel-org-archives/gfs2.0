Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0AAC3EB0E8
	for <gfs2@lists.linux.dev>; Sun, 20 Sep 2026 08:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789893101; cv=none; b=ZofpvW3tESJ1mz5reMhlltOsJK5cAYlTPDOsBUsAGW4HoDIApL5fZz6FPVnMxj/HUTwOURAXExKmjlDVJG3sOXgqR3ZaB4vK748/IP9DHvvi22TPundLSL3hsB0oRwJ4CKcRUaNULJsH4gWuSv4dqLgq9Vykp2z8ms6lt1IRfX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789893101; c=relaxed/simple;
	bh=CHhlOoPa7lx28znIBmmKknG7qrENE5LL/JiYPgofib8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K1hbhUPMlxsBx+moOxfYeSto7gL8QuHVAD+Jkzjv5UIj5CcdVrrhzvsieBAjK43pcxDbRxUvo+CzOOsKm8TGKoXR9zYxJ8bDARIFNQkDeFNm0/5Fm4aVyLRzgI+2KOGhUaFLqPwrP2dcilIcvozl64Vo5inG07mOk3L0S2WcrRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [117.147.104.32])
	by mtasvr (Coremail) with SMTP id _____wAn0zzgma9quNImAQ--.24630S3;
	Sun, 20 Sep 2026 16:31:28 +0800 (CST)
Received: from localhost.localdomain (unknown [117.147.104.32])
	by mail-app3 (Coremail) with SMTP id zS_KCgAHQXTSma9qV+dHBQ--.54809S3;
	Sun, 20 Sep 2026 16:31:27 +0800 (CST)
From: Jiacheng Xu <stitch@zju.edu.cn>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Jiacheng Xu <stitch@zju.edu.cn>,
	gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/4] gfs2: protect quota refresh from superblock teardown
Date: Sun, 20 Sep 2026 16:31:02 +0800
Message-ID: <20260920083109.30798-2-stitch@zju.edu.cn>
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
X-CM-TRANSID:zS_KCgAHQXTSma9qV+dHBQ--.54809S3
X-CM-SenderInfo: qtrxiiaqttimo62m3hxhgxhubq/
X-CM-DELIVERINFO: =?B?ZqNvyQXKKxbFmtjJiESix3B1w3tMoM3snk/k5SVzZVydjEqe1eefKHnLf95EnB4iem
	egWzO/wNhIP+pglnkLd0BnOseRu3vBlUcX6QlLMsS925UAZSEknj3LGDy6z/wpMoOg8cy1
	tPbWVAvh7xu1Ium4Jp1zGNLdsMyhd8Xna2fzX/b1
X-Coremail-Antispam: 1Uk129KBj93XoWxZFykJFWUAw1xXrW3Kr13Jrc_yoW5Wr47pF
	4jv3yfJr4kCrnrXF4SkF4rW34rG393ZFy7trZ7W3Z3Aw42ywnxKFyfJFy0vFyrG348Jrnr
	XF1jvFZxCrWUGrcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvmb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0Y48IcxkI7V
	AKI48G6xCjnVAKz4kxMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I
	3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxV
	WUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8I
	cVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aV
	AFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZE
	Xa7IU88hL5UUUUU==

The quota_refresh sysfs attributes become visible before fill_super()
has completed, so the quota inode can still be uninitialized when a
userspace write reaches gfs2_quota_refresh(). The same callback can
also race with superblock teardown.

Serialize the callback with the superblock lifetime using a read-side
s_umount lock. Use down_read_trylock() so the mount failure path can
remove the sysfs files while holding the write side of the lock without
deadlocking, and reject accesses before SB_ACTIVE is set.

Keep the locking in the user and group sysfs callbacks and introduce
shared helpers for the other sysfs operations.

Return -EAGAIN when the filesystem is not available for the callback.

Signed-off-by: Jiacheng Xu <stitch@zju.edu.cn>
---
 fs/gfs2/sys.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/fs/gfs2/sys.c b/fs/gfs2/sys.c
index ea2c7b9e4a77..0d247299625c 100644
--- a/fs/gfs2/sys.c
+++ b/fs/gfs2/sys.c
@@ -63,6 +63,25 @@ static ssize_t id_show(struct gfs2_sbd *sdp, char *buf)
 			MAJOR(sdp->sd_vfs->s_dev), MINOR(sdp->sd_vfs->s_dev));
 }
 
+/*
+ * Sysfs callbacks must not block on s_umount: mount failure and unmount
+ * remove the sysfs files while holding it for writing.
+ */
+static bool super_trylock_shared_active(struct super_block *sb)
+{
+	if (!down_read_trylock(&sb->s_umount))
+		return false;
+	if (sb->s_flags & SB_ACTIVE)
+		return true;
+	up_read(&sb->s_umount);
+	return false;
+}
+
+static void super_unlock_active(struct super_block *sb)
+{
+	up_read(&sb->s_umount);
+}
+
 static ssize_t status_show(struct gfs2_sbd *sdp, char *buf)
 {
 	unsigned long f = sdp->sd_flags;
@@ -248,6 +267,7 @@ static ssize_t quota_sync_store(struct gfs2_sbd *sdp, const char *buf,
 static ssize_t quota_refresh_user_store(struct gfs2_sbd *sdp, const char *buf,
 					size_t len)
 {
+	struct super_block *sb = sdp->sd_vfs;
 	struct kqid qid;
 	int error;
 	u32 id;
@@ -263,13 +283,19 @@ static ssize_t quota_refresh_user_store(struct gfs2_sbd *sdp, const char *buf,
 	if (!qid_valid(qid))
 		return -EINVAL;
 
+	if (!super_trylock_shared_active(sb))
+		return -EAGAIN;
+
 	error = gfs2_quota_refresh(sdp, qid);
+
+	super_unlock_active(sb);
 	return error ? error : len;
 }
 
 static ssize_t quota_refresh_group_store(struct gfs2_sbd *sdp, const char *buf,
 					 size_t len)
 {
+	struct super_block *sb = sdp->sd_vfs;
 	struct kqid qid;
 	int error;
 	u32 id;
@@ -285,7 +311,12 @@ static ssize_t quota_refresh_group_store(struct gfs2_sbd *sdp, const char *buf,
 	if (!qid_valid(qid))
 		return -EINVAL;
 
+	if (!super_trylock_shared_active(sb))
+		return -EAGAIN;
+
 	error = gfs2_quota_refresh(sdp, qid);
+
+	super_unlock_active(sb);
 	return error ? error : len;
 }
 
-- 
2.51.0

