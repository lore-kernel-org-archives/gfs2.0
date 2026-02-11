Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A8F34E747
	for <gfs2@lists.linux.dev>; Wed, 11 Feb 2026 07:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770793545; cv=none; b=Kz9wbH0g+ODUo3h6yePCpI6b4fkueMODHQnOR8gu26dxxx40s2z0nXgm8beKKiL5BUhU5+9LmlNqqp9Rtwert0prWKLwlL6EMhfAgKCYgoMG1m+Drs4pRvld7OFDpoi08YPKFKHsHtQUVxGhX3rnn1TznHzvlODubGCzXOQS+iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770793545; c=relaxed/simple;
	bh=M1NRjmEMDyy+oOgvl+VQv+6y7EvEZ/LU64AnDJ077DQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=rzoLFgyIHyYRAnOARKp+Kz5mvgyp5L9zujIhHzEQzv9q2zSm5Fkqzwe4Y5Wx77MCynyWFZicmaR0LcybTM/q2vicnD0akzRvaJsn/u9ziKt3c01oAHI5pNL09gpeBWlAHHSFP7Q9sShBmFsw3RJfuZQqMcdlPVwl0xNymq3f/KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=aH7kH25Z; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="aH7kH25Z"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20260211070541epoutp033c642da83af6c2099eb15254e69d6c44~TH1gifS5b3035730357epoutp03X
	for <gfs2@lists.linux.dev>; Wed, 11 Feb 2026 07:05:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20260211070541epoutp033c642da83af6c2099eb15254e69d6c44~TH1gifS5b3035730357epoutp03X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1770793541;
	bh=edeVYa6HjHZ4mu4TNinC+G+5M3aq+ckeGzSwrEoltMw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aH7kH25ZyT7pyRQPignlNgiFNjjwRnxACeUltC5fCGZkiRkeW1x/5xksxISc6Sgee
	 PI8PrslZaQ7lD4yQm6eHxjT/E7xNozuLuk7ozXJblFDAnC6aObzdO9EeV1N1mOelqX
	 oQxnQQrshd4lRSimPyae7sjj3aJ58FOALWfw/e60=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20260211070541epcas5p22ea11564e42c12bf2d2a7997c38e4772~TH1gGnm850532905329epcas5p2P;
	Wed, 11 Feb 2026 07:05:41 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.89]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4f9qFw3zKpz6B9m5; Wed, 11 Feb
	2026 07:05:40 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20260211070540epcas5p3ba81064a4695a85d47735158b49f16e7~TH1e6Q9yM1263912639epcas5p3N;
	Wed, 11 Feb 2026 07:05:40 +0000 (GMT)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260211070537epsmtip2d73bad556e4e9fae0a3866bd2089ad7c~TH1cP-LPZ0195901959epsmtip2X;
	Wed, 11 Feb 2026 07:05:37 +0000 (GMT)
From: Kundan Kumar <kundan.kumar@samsung.com>
To: jaegeuk@kernel.org, chao@kernel.org, agruenba@redhat.com,
	trondmy@kernel.org, anna@kernel.org, hch@lst.de, brauner@kernel.org,
	jack@suse.cz, viro@zeniv.linux.org.uk, djwong@kernel.org,
	pankaj.raghav@linux.dev
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	gfs2@lists.linux.dev, linux-nfs@vger.kernel.org, gost.dev@samsung.com,
	anuj20.g@samsung.com, vishak.g@samsung.com, joshi.k@samsung.com,
	mcgrof@kernel.org, Kundan Kumar <kundan.kumar@samsung.com>
Subject: [PATCH 2/4] f2fs: stop using writeback internals for dirty_exceeded
 checks
Date: Wed, 11 Feb 2026 12:30:55 +0530
Message-Id: <20260211070057.22001-3-kundan.kumar@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260211070057.22001-1-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260211070540epcas5p3ba81064a4695a85d47735158b49f16e7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260211070540epcas5p3ba81064a4695a85d47735158b49f16e7
References: <20260211070057.22001-1-kundan.kumar@samsung.com>
	<CGME20260211070540epcas5p3ba81064a4695a85d47735158b49f16e7@epcas5p3.samsung.com>

Replace direct dereferences of dirty_exceeded with the core helper
bdi_wb_dirty_exceeded(), removing f2fs dependencies on writeback
internals.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Kundan Kumar <kundan.kumar@samsung.com>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 fs/f2fs/node.c    | 4 ++--
 fs/f2fs/segment.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 482a362f2625..d450b282cc55 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -78,7 +78,7 @@ bool f2fs_available_free_memory(struct f2fs_sb_info *sbi, int type)
 		if (excess_cached_nats(sbi))
 			res = false;
 	} else if (type == DIRTY_DENTS) {
-		if (sbi->sb->s_bdi->wb.dirty_exceeded)
+		if (bdi_wb_dirty_exceeded(sbi->sb->s_bdi))
 			return false;
 		mem_size = get_pages(sbi, F2FS_DIRTY_DENTS);
 		res = mem_size < ((avail_ram * nm_i->ram_thresh / 100) >> 1);
@@ -119,7 +119,7 @@ bool f2fs_available_free_memory(struct f2fs_sb_info *sbi, int type)
 		res = false;
 #endif
 	} else {
-		if (!sbi->sb->s_bdi->wb.dirty_exceeded)
+		if (!bdi_wb_dirty_exceeded(sbi->sb->s_bdi))
 			return true;
 	}
 	return res;
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 07dcbcbeb7c6..d7166f1f000a 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -1000,7 +1000,7 @@ static inline bool sec_usage_check(struct f2fs_sb_info *sbi, unsigned int secno)
  */
 static inline int nr_pages_to_skip(struct f2fs_sb_info *sbi, int type)
 {
-	if (sbi->sb->s_bdi->wb.dirty_exceeded)
+	if (bdi_wb_dirty_exceeded(sbi->sb->s_bdi))
 		return 0;
 
 	if (type == DATA)
-- 
2.25.1

