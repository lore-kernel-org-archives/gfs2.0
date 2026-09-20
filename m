Received: from zg8tmja2lje4os43os4xodqa.icoremail.net (zg8tmja2lje4os43os4xodqa.icoremail.net [206.189.79.184])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 576A53EB0F2
	for <gfs2@lists.linux.dev>; Sun, 20 Sep 2026 08:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.79.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789893103; cv=none; b=Asu7f1Gzf+tnDN7TsMFW2WTm+TeptXiPLps6sIvlxtyGLH5eEYQG3hUDIAdQINGMMggutuy7NTC/yS4Iwczs8yQEdqFy6mZ37R36E83mCOFs/SD/i3CtJ32BWo9Nf+31n5IvqnlLrHscTPJsDe6JVspRH83yqx+XoycPdQO1CLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789893103; c=relaxed/simple;
	bh=63zvDyDYTKhpsmfDe4JGT9VugeFbT7PqwwXNnTQkqJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CT4pFfonPAILISOgc2PXgqkCHPleVkbAX98KsfdpEgn9UZ48RdRvxDFgANd5//zRk1HzM6f+mjyow0GwLomhIAelw1l9jXKX7IMC3a8SSZxru+hqyryRyZJRfKUVEEGJl1Qo3V8NvESs+VspwVbh+98kGFgRwurAxI5tbLinkVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=206.189.79.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [117.147.104.32])
	by mtasvr (Coremail) with SMTP id _____wC3oH7lma9qw9ImAQ--.24617S3;
	Sun, 20 Sep 2026 16:31:33 +0800 (CST)
Received: from localhost.localdomain (unknown [117.147.104.32])
	by mail-app3 (Coremail) with SMTP id zS_KCgAHQXTSma9qV+dHBQ--.54809S5;
	Sun, 20 Sep 2026 16:31:31 +0800 (CST)
From: Jiacheng Xu <stitch@zju.edu.cn>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Jiacheng Xu <stitch@zju.edu.cn>,
	gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/4] gfs2: protect quota sync sysfs callback
Date: Sun, 20 Sep 2026 16:31:04 +0800
Message-ID: <20260920083109.30798-4-stitch@zju.edu.cn>
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
X-CM-TRANSID:zS_KCgAHQXTSma9qV+dHBQ--.54809S5
X-CM-SenderInfo: qtrxiiaqttimo62m3hxhgxhubq/
X-CM-DELIVERINFO: =?B?wcOPBAXKKxbFmtjJiESix3B1w3tMoM3snk/k5SVzZVydjEqe1eefKHnLf95EnB4iem
	egWzO/wNhIP+pglnkLd0BnOsedvbXcnNGX/UIepARfWBncHv56cT8BWJRDUtThYGkWp+Pf
	LkD8QZ23s48MrbYdbPJPcfx2W6bE1TLvArMXh2x0
X-Coremail-Antispam: 1Uk129KBj93XoW7Xw48tr4xtFyrAw4kWFyfAFc_yoW8Jr4UpF
	4DAr13Cas8Jr1UWFWDKFsYgw1rGa92qFW7trZrX3ZrJ3ZxJwnxJFyxKa40vFyUXrW7Jr13
	ur9YvasIyFW8GFcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
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
	cVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aV
	AFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZE
	Xa7IU8c4S7UUUUU==

The quota_sync sysfs callback can run while quota cleanup is releasing
the quota bitmap and internal quota inodes during mount rollback or
unmount.

Hold s_umount for reading while synchronizing quota data and reject
requests before the superblock is active. Use trylock semantics so the
callback cannot deadlock with the write-side teardown path.

Signed-off-by: Jiacheng Xu <stitch@zju.edu.cn>
---
 fs/gfs2/sys.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/gfs2/sys.c b/fs/gfs2/sys.c
index fd6e8e34651d..c5868354073a 100644
--- a/fs/gfs2/sys.c
+++ b/fs/gfs2/sys.c
@@ -254,6 +254,7 @@ static ssize_t statfs_sync_store(struct gfs2_sbd *sdp, const char *buf,
 static ssize_t quota_sync_store(struct gfs2_sbd *sdp, const char *buf,
 				size_t len)
 {
+	struct super_block *sb = sdp->sd_vfs;
 	int error, val;
 
 	if (!capable(CAP_SYS_ADMIN))
@@ -266,7 +267,12 @@ static ssize_t quota_sync_store(struct gfs2_sbd *sdp, const char *buf,
 	if (val != 1)
 		return -EINVAL;
 
-	gfs2_quota_sync(sdp->sd_vfs, 0);
+	if (!super_trylock_shared_active(sb))
+		return -EAGAIN;
+
+	gfs2_quota_sync(sb, 0);
+
+	super_unlock_active(sb);
 	return len;
 }
 
-- 
2.51.0

