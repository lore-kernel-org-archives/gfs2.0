Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B8C3126DC
	for <gfs2@lists.linux.dev>; Tue, 14 Oct 2025 12:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760443847; cv=none; b=edAcSmBDRXks2g/+z+b/EJfSAA7nuDQ5iNjQ3mK4nuTee8TWD/UrNY1itwsXXpN8EDzX7Ma5wspp3bvDsGaW+keC+7L0AzIcuKB79J7LYv8OyInbPWu1+6B3g8iTB/coooK3TPD4aIIq4oyewm4I4bGE4ea2FCLdpqjG1DvjPc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760443847; c=relaxed/simple;
	bh=J+pOFwFHc5MdTbyOWG6elVAn+TzaOGlfdoY3exz5yDA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=n8/E9cDJyAuj/rB/kUfL3EkdM+bTsGZEeizstslaQMu2wLObhPPKJPwIjK9mI+s77yDjD11Acc6+p9uzeoArGYWGMUL+iYJ+U3UuGGm0bM1EP+AkRz+hXCxEgHdjUksCmk/O7jT4hm9xQXu3RIDWYy7qF12BEuGdhYoBAWAF9dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=j4EoRb05; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="j4EoRb05"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20251014121039epoutp035ccf5294f31ed79567fd2ff7ae681d9c~uWlg7ykIq0487904879epoutp03K
	for <gfs2@lists.linux.dev>; Tue, 14 Oct 2025 12:10:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20251014121039epoutp035ccf5294f31ed79567fd2ff7ae681d9c~uWlg7ykIq0487904879epoutp03K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1760443839;
	bh=O2U42LWZMM8201UpxKxW6f/AsVjv4jB1OSfEppuAbYw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j4EoRb052CyFlWparM6vJ+IGSCEWjIS6wVo+S87KDQqDA0Ocmw/12pWxJHIIh31zH
	 Esi8h9OyxeOyR15xYVX5wm7qtnvdwsg04HJRPmJ/1moWx5u2peXU8xFWHwP0Tb4pM0
	 +fUQ0OawY0mVdzW1x06h3YX1hssKOUzItdHKdfpU=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20251014121038epcas5p4685b828d668366916b45d174d16a3637~uWlgJt7Oo0610406104epcas5p4-;
	Tue, 14 Oct 2025 12:10:38 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.95]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4cmCj93Ktwz6B9m6; Tue, 14 Oct
	2025 12:10:37 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20251014121036epcas5p17c607955db032d076daa2e5cfecfe8ea~uWleqppMN1447514475epcas5p1j;
	Tue, 14 Oct 2025 12:10:36 +0000 (GMT)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20251014121032epsmtip1fbff11e9fef5c6232ce81ec58fd0763b~uWlaFqXYA1256112561epsmtip1p;
	Tue, 14 Oct 2025 12:10:31 +0000 (GMT)
From: Kundan Kumar <kundan.kumar@samsung.com>
To: jaegeuk@kernel.org, chao@kernel.org, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, miklos@szeredi.hu, agruenba@redhat.com,
	trondmy@kernel.org, anna@kernel.org, akpm@linux-foundation.org,
	willy@infradead.org, mcgrof@kernel.org, clm@meta.com, david@fromorbit.com,
	amir73il@gmail.com, axboe@kernel.dk, hch@lst.de, ritesh.list@gmail.com,
	djwong@kernel.org, dave@stgolabs.net, wangyufei@vivo.com
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
	gfs2@lists.linux.dev, linux-nfs@vger.kernel.org, linux-mm@kvack.org,
	gost.dev@samsung.com, kundan.kumar@samsung.com, anuj20.g@samsung.com,
	vishak.g@samsung.com, joshi.k@samsung.com
Subject: [PATCH v2 05/16] writeback: modify bdi_writeback search logic to
 search across all wb ctxs
Date: Tue, 14 Oct 2025 17:38:34 +0530
Message-Id: <20251014120845.2361-6-kundan.kumar@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251014120845.2361-1-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20251014121036epcas5p17c607955db032d076daa2e5cfecfe8ea
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20251014121036epcas5p17c607955db032d076daa2e5cfecfe8ea
References: <20251014120845.2361-1-kundan.kumar@samsung.com>
	<CGME20251014121036epcas5p17c607955db032d076daa2e5cfecfe8ea@epcas5p1.samsung.com>

Since we have multiple cgwb per bdi, embedded in writeback_ctx now, we
iterate over all of them to find the associated writeback.

Signed-off-by: Kundan Kumar <kundan.kumar@samsung.com>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 fs/fs-writeback.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 56c048e22f72..93f8ea340247 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -1090,7 +1090,8 @@ int cgroup_writeback_by_id(u64 bdi_id, int memcg_id,
 {
 	struct backing_dev_info *bdi;
 	struct cgroup_subsys_state *memcg_css;
-	struct bdi_writeback *wb;
+	struct bdi_writeback *wb = NULL;
+	struct bdi_writeback_ctx *bdi_wb_ctx;
 	struct wb_writeback_work *work;
 	unsigned long dirty;
 	int ret;
@@ -1114,7 +1115,11 @@ int cgroup_writeback_by_id(u64 bdi_id, int memcg_id,
 	 * And find the associated wb.  If the wb isn't there already
 	 * there's nothing to flush, don't create one.
 	 */
-	wb = wb_get_lookup(bdi->wb_ctx[0], memcg_css);
+	for_each_bdi_wb_ctx(bdi, bdi_wb_ctx) {
+		wb = wb_get_lookup(bdi_wb_ctx, memcg_css);
+		if (wb)
+			break;
+	}
 	if (!wb) {
 		ret = -ENOENT;
 		goto out_css_put;
-- 
2.25.1

