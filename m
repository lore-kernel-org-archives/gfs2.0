Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F43A3E7BBD
	for <gfs2@lists.linux.dev>; Sun, 20 Sep 2026 08:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.46.229.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789893098; cv=none; b=msTBTr//hpnAWE7WbzIH7LPW9kmCSEcebptFxvMoM1i9nVkPQwfRPHTCdPdsnfP//s9r1LC2xFE0YEb9YQ0NlZjRn60JS0B3IMXCLyMdjhf/QhPgKDH3QRBoYTQz6k/gfgYsghvrnzk8maHIm32eiN6OBHuOYpZSrKKR+R4Li5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789893098; c=relaxed/simple;
	bh=8lAtYxsbh9XSCK/h97LLLPIQu2azj5WKFVETV22p1A0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pZl6HznY2rlaf+VppCHTH4lZamEg/eLLmzhoWd1tMZNswL2aPtE/KQ5eXV+N7pQx97a5rioxb6KvvFXi7HAfoZLHlEALfdtD9xH8uJhfcSJScqz8tObspI7qQ1BsnX8cjiLbfRatHbsIxEjcbC1g0RwEMPDoGZB14uHMsLaQR+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=207.46.229.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [117.147.104.32])
	by mtasvr (Coremail) with SMTP id _____wCntizYma9qptImAQ--.24858S3;
	Sun, 20 Sep 2026 16:31:22 +0800 (CST)
Received: from localhost.localdomain (unknown [117.147.104.32])
	by mail-app3 (Coremail) with SMTP id zS_KCgAHQXTSma9qV+dHBQ--.54809S2;
	Sun, 20 Sep 2026 16:31:15 +0800 (CST)
From: Jiacheng Xu <stitch@zju.edu.cn>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Jiacheng Xu <stitch@zju.edu.cn>,
	gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] gfs2: protect sysfs callbacks from superblock teardown
Date: Sun, 20 Sep 2026 16:31:01 +0800
Message-ID: <20260920083109.30798-1-stitch@zju.edu.cn>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zS_KCgAHQXTSma9qV+dHBQ--.54809S2
X-CM-SenderInfo: qtrxiiaqttimo62m3hxhgxhubq/
X-CM-DELIVERINFO: =?B?f9+aQQXKKxbFmtjJiESix3B1w3tMoM3snk/k5SVzZVydjEqe1eefKHnLf95EnB4iem
	egWzO/wNhIP+pglnkLd0BnOsfDtOcHjOzq64m8aVDLtb0nHv56cT8BWJRDUtThYGkWp+Pf
	LkD8QZ23s48MrbYdbPIbV7qDIvV0+iuJq/aMPg3U
X-Coremail-Antispam: 1Uk129KBj93XoW7Zr1rWF1UtFWkCFWfJFWrZwc_yoW8JFWUpF
	srXrWFkr4UAF1xX3yfCayfua4rWw4rJ3W7X3s7WwnrCry3Xr17Cr1xKFW8Xr4UArs7tryj
	vw1DZry3uFW8WagCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvvb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0Y48IcxkI7V
	AKI48G6xCjnVAKz4kxMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I
	3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxV
	WUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8I
	cVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aV
	AFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuY
	vjxU26pBDUUUU

The GFS2 sysfs files become visible before fill_super() completes and
remain present during filesystem teardown. Protect quota refresh,
statfs sync, quota sync and demote requests with a non-blocking read
lock on s_umount, and require SB_ACTIVE before accessing their state.

Changes in v3:
- Rebase onto 518e5b794c06c0f0eb40df3e202274a66202c137.
- Introduce super_trylock_shared_active() and super_unlock_active().
- Move quota refresh locking into the user and group sysfs callbacks.
- Use the shared helpers in statfs_sync, quota_sync and demote_rq.
- Drop the status patch as requested by Andreas, in favor of his separate
  fix: https://lore.kernel.org/gfs2/20260827190632.686583-1-agruenba@redhat.com/

Previous version:
https://lore.kernel.org/all/6a91508.162bd.1a0228251e8.Coremail.stitch@zju.edu.cn/

Jiacheng Xu (4):
  gfs2: protect quota refresh from superblock teardown
  gfs2: protect statfs sync sysfs callback
  gfs2: protect quota sync sysfs callback
  gfs2: protect demote requests during superblock teardown

 fs/gfs2/sys.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 56 insertions(+), 4 deletions(-)


base-commit: 518e5b794c06c0f0eb40df3e202274a66202c137
-- 
2.51.0

