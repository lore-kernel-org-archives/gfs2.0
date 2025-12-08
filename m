Received: from out203-205-221-221.mail.qq.com (out203-205-221-221.mail.qq.com [203.205.221.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9789F28695
	for <gfs2@lists.linux.dev>; Mon,  8 Dec 2025 06:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765174356; cv=none; b=lYrpkxtyn8sAh2HHiCoex8pwIo8sWC0F8fd3YvVq7ykGq3/c72J/n5KTaVdqBNNMjQkI8GYpYayVxWAkiO0MfP8FM9ZRuJfWnVC2U148q0Qn3X7YIS2TAnHkiOPs9dUQvkR95A5whmUuRl48zxX+hR0hqp1DaUGPuEb1tLp2zoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765174356; c=relaxed/simple;
	bh=2MccI9ijysGzmtEpmSs/8U7WQbacdBsVNC2AVKaGa3M=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=CN91pcvOo+UJXJKSOKQQGJI3/ur71/wCOBUWu9kYqo35ZdPRtyZEk+Go7T3/vdubcuR/31XvkRp5gvKK/CGWzevPX6KNWUeEoxrQdrucKOLXrZUxTuceShEbc+20kZwcHVWNWz8gtOnoGieUJyz09+xWGIc4z0ng8Kia3oztx0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=LeuP/F9Q; arc=none smtp.client-ip=203.205.221.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="LeuP/F9Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1765174343; bh=EkAQOGmig8RWXdbFQGHpAAG9Q2rxBVByGXHl/9kFcRE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LeuP/F9QZNkouZ/VHDrw07ujxbl365Z3IKAmxFqlRfK1mKyfjvGWyBpuozAK9tqrd
	 W23pf9c4o+sdnAmFmXQwqE6vd7C9NEp1WPmBhxHDIlvrIdCNXy3nLdJALM+8BaQs7z
	 jOFlTUR3rorSLK8oo3lDLH7SccIVTxFEer28R+xs=
Received: from lxu-ped-host.. ([111.201.7.117])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id 3159A6A3; Mon, 08 Dec 2025 14:12:21 +0800
X-QQ-mid: xmsmtpt1765174341t0jd0dkoo
Message-ID: <tencent_0136C09726370A4A04742377C566063C7109@qq.com>
X-QQ-XMAILINFO: MRMtjO3A6C9X+fVda2AaJpDv1ux4O4yKvvQZ3rG2ALqX7a178uLTaifqB10X1n
	 3+NQPEB/gEBnzYLfP6ylUTJChGpuXUNJnA6dl4f5iu8WFXWci2sfdXZ2BKfrPkc6L0z4QSziXvri
	 jsMMXeHF/46cQlOSQNji0InYU1pgF22I5NMR7tPy4fnnzhEByORpwHmjD0ixQdIQ8nxNlCQY81y4
	 4lBy6EcMd8g+6lV2ljOjchReHyCL+JzcZvV23lMM05Uk90eOHoNAx6MtkAoqav6B7LIRq2NWkGPC
	 Mw8UplWA6RXGabb7RGjvh+RQZCJpqi9Cq1HVXlyhztf7d5FekoRvdvszrLQv+ixHCKl8jPrLT2PV
	 XSJEf8oTOJPsqs5HJCH9b4A54eSyQxWJqK0vi0q7O3NaEB+CNAPc1HSc95dzLmiafWe4FGBy5sFA
	 Bvl4Yp6KUX7QhGVAXyeOAdSWfJhQgKoGsNFCWY8X52kuim+McqePX2A81w1SLV6vscUR2NHLxcxm
	 fjnszBkNPgnuvb6w+zcPO64jSgMZn8e28SD0wO3+7w8JM72M/MsQ2Iu6bLMfl2VQ7lC5+0zK1ewt
	 j9pvanm3hm9H/6nOwlKL5XhRLnE+oG8Ark1bD1g8sZPC39NgSz4kzklnXLNxVBFWywCakIm2jMt8
	 QQIUJZAFdW3bc6ZXHo/K7wEHpA4GTEJUkl9M85xZYCsRonyekRvtnqnBZmfORUv00cpavxcnchQG
	 mK4LHVrDoK3G9SJsXvoLT/hzaQCmE63t0EqPBN5344VdtVUNQjN7xGr1mCjvXYlmpQO2mwEPotDE
	 X7zGqEcGMibx2CoVo9qOG/YcF71xwnyrqOaL8ko8+m3Y+VEz+11tlQcBz3gHyTKswOps+nwyON1h
	 w0+TJ2rLdEf6qsFyhJjBUlDU3cBu4/yRU0jHYFAhjBXiFB8Mb8at0f7t56VEmOO+OZd7cPoSQwhH
	 zWfnV/dbGXxuO0bdWFMmidTQWLldgM1o/PSdDFCxzEfqKKyc+0YrqueTB+DzA4ZOSSgP91Lrg=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+f6539d4ce3f775aee0cc@syzkaller.appspotmail.com
Cc: agruenba@redhat.com,
	gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH Next] gfs2: update end and prev bio for chain bio
Date: Mon,  8 Dec 2025 14:12:21 +0800
X-OQ-MSGID: <20251208061220.472205-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <69351d9c.a70a0220.38f243.0049.GAE@google.com>
References: <69351d9c.a70a0220.38f243.0049.GAE@google.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bios are created and initialized using gfs2_log_alloc_bio() in
gfs2_find_jhead(), which sets bi_end_io and bi_private. When the I/O
request is too large and needs to be split into multiple bios and
submitted as a chain, the bug reported by syzbot [1] is triggered.

When we need to submit multiple bios in a chain, we need to pass the
bi_end_io and bi_private of the previous bio to the end bio to ensure
that the multiple bios are correctly assembled into a submission chain.

[1]
kernel BUG at block/bio.c:342!
Call Trace:
 gfs2_chain_bio fs/gfs2/lops.c:487 [inline]
 gfs2_find_jhead+0x627/0xe40 fs/gfs2/lops.c:549
 gfs2_recover_func+0x5f5/0x1c90 fs/gfs2/recovery.c:459

Fixes: 8a157e0a0aa5 ("gfs2: Fix use of bio_chain")
Reported-by: syzbot+f6539d4ce3f775aee0cc@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=f6539d4ce3f775aee0cc
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 fs/gfs2/lops.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
index 97ebe457c00a..2de334034c74 100644
--- a/fs/gfs2/lops.c
+++ b/fs/gfs2/lops.c
@@ -484,6 +484,10 @@ static struct bio *gfs2_chain_bio(struct bio *prev, unsigned int nr_iovecs)
 	new = bio_alloc(prev->bi_bdev, nr_iovecs, prev->bi_opf, GFP_NOIO);
 	bio_clone_blkg_association(new, prev);
 	new->bi_iter.bi_sector = bio_end_sector(prev);
+	new->bi_end_io = prev->bi_end_io;
+	new->bi_private = prev->bi_private;
+	prev->bi_end_io = NULL;
+	prev->bi_private = NULL;
 	bio_chain(prev, new);
 	submit_bio(prev);
 	return new;
-- 
2.43.0

