Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75513546E2
	for <gfs2@lists.linux.dev>; Mon, 22 Jun 2026 10:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782122722; cv=none; b=tKLonb8HRIx/Yy/fr1wvfAZDqoBFByMGvC0eZOAGGccFfcPg0fJAE3tMjbOkKzAAUfOal/bprM4H/rvZ72eRV9XvS6hF6O76urlImHJrYASlyw+ixQDRtDZHKmRdkKfX/8dsExNOOcsFGfms54RUKqd2/1GPz+7ooggBPAtqiTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782122722; c=relaxed/simple;
	bh=D6uW7oILWyoNuW2FQEDrt4TlJ/lpRlLc3gfWBtRB9FI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Rr8H76mslJW9PSNTkLkIUgK8YERgbyFxRA8rucTYWbjbegDayBHcDgDB08yoYpmgS0kI1bIc+q8MOjFdHwpnIAfxZMGKx6TzbmqmtGCtGrGkAmJNrWdQnTbPUtd4sLbaMA8PyFcMJdKtECHMMdj5q/BxXyNJK8NEHc4bSUs+BD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=FyWQzv3M; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="FyWQzv3M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=cM
	4731X8fNSCrK8dyrlCQZYgV8fTo8AyRxfviCfZkNQ=; b=FyWQzv3McoS+3Ywime
	69MRVsjwoWtyqtx1j2P8cSwzomONyVlHoA7/1e0IOsqAnu08m+wWFfYOV84eeql3
	igLEOjSdNpt4aQIUB5iSR1Zx9dDoatUWVu24PtIsmgqez2W7K/DO31ugTPDt9g5/
	fvka2VHubm8CszULP/Pwe73lk=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wCnEJPZCDlqPgGgEg--.6755S2;
	Mon, 22 Jun 2026 18:05:14 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: agruenba@redhat.com
Cc: gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>
Subject: [PATCH] gfs2: Unregister debugfs on filesystem registration failure
Date: Mon, 22 Jun 2026 18:05:12 +0800
Message-Id: <20260622100512.940751-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCnEJPZCDlqPgGgEg--.6755S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7JFWkXF1kWw1DXF4DXrykuFg_yoW3ZFgEgr
	Z3trykZwnIkryrGa4kCFWvvrs5uFW3G3ZxXr43tFnxCr10qrs5KF1DWw15Zr17WrW2yrn3
	KFWDAFn3Gw1UCjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sR_l4EJUUUUU==
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbC7Rohj2o5CNoHLgAA3x

init_gfs2_fs() registers debugfs before registering the GFS2
filesystems. If either filesystem registration fails, the
error path tears down the other resources but leaves debugfs
registered. Call gfs2_unregister_debugfs() from the filesystem
registration failure path.

Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 fs/gfs2/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/gfs2/main.c b/fs/gfs2/main.c
index 9d65719353fa..9fc4835f209d 100644
--- a/fs/gfs2/main.c
+++ b/fs/gfs2/main.c
@@ -187,6 +187,7 @@ static int __init init_gfs2_fs(void)
 fail_fs2:
 	unregister_filesystem(&gfs2_fs_type);
 fail_fs1:
+	gfs2_unregister_debugfs();
 	mempool_destroy(gfs2_page_pool);
 fail_mempool:
 	destroy_workqueue(gfs2_freeze_wq);
-- 
2.25.1

