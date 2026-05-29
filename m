Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8066F1C84BC
	for <gfs2@lists.linux.dev>; Fri, 29 May 2026 09:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780046413; cv=none; b=is4sbiA7fzVbngjU+wIyM3OL78yq5gv2fD5RM1TCvvklL7dv2Pg+2Xdhy+pFjT3gNX2zTwgTfeCVShH079RCuAdydTE1zkfl+gTS+W2QNpGu25JYiFiZj62GdVQQUHz7RZnqd6oSD1ZF0aVK6wJKsVHcX321Vla7IksEMt9pzfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780046413; c=relaxed/simple;
	bh=2lBSwEHLv7bDjFFn59boKXTrDJ2Ozq77R+5BMoFPUKM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=H9dSrtlYQnphyuj4uYdjY9RSc3puhSIb8SFSZvs4/8kbXy6u36iAEKT6OcPsctnj506X+dmHogK2mUhNp77LMyklhubhkwpZah3RQjjeLUa0/GWpiEvktg3M2ZUvUaomgnPMaBW24PPKbWfWcwGvVx/ZWMFRPsOkD9mo/LcwR00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L6M2GbCV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L6M2GbCV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780046411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jIlP4eE8bJRb3yfQv9KaGNyUGAE7ZQL+1Pw/V+ph8Wc=;
	b=L6M2GbCVm7tK9VK4D8XSJlAPFe+4B0SD+2/57uls+47haPv1XekNjnxrjFjZESXye21oBm
	/I0DpLOt08oDmfEV4zF78W/6nkGSDEhIgSSCTOo2eOIa+pBQzqUMemQL74tSKUxzptYEH7
	91GsnEKHMzDV5Bjhah2PwGMAnbDBPPE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-507-Kk4nJaFAN6WHK08JKj4LjQ-1; Fri,
 29 May 2026 05:20:08 -0400
X-MC-Unique: Kk4nJaFAN6WHK08JKj4LjQ-1
X-Mimecast-MFC-AGG-ID: Kk4nJaFAN6WHK08JKj4LjQ_1780046407
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D0D0A18002EA
	for <gfs2@lists.linux.dev>; Fri, 29 May 2026 09:20:07 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.44.48.35])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D8E1E180056E;
	Fri, 29 May 2026 09:20:06 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 1/2] gfs2: Remove unused fallocate_chunk argument
Date: Fri, 29 May 2026 11:20:04 +0200
Message-ID: <20260529092005.954183-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2vY8kNc4s4k2puGeGunBWZx8xKeZOvs3V8An1Tposj8_1780046407
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The mode argument of fallocate_chunk() became unused in commit
1885867b84d5 ("GFS2: Update i_size properly on fallocate"), so remove it.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/file.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index 9704f1ef6ad1..48ebda5ba808 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -1173,8 +1173,7 @@ static ssize_t gfs2_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	return ret;
 }
 
-static int fallocate_chunk(struct inode *inode, loff_t offset, loff_t len,
-			   int mode)
+static int fallocate_chunk(struct inode *inode, loff_t offset, loff_t len)
 {
 	struct super_block *sb = inode->i_sb;
 	struct gfs2_inode *ip = GFS2_I(inode);
@@ -1336,7 +1335,7 @@ static long __gfs2_fallocate(struct file *file, int mode, loff_t offset, loff_t
 		if (error)
 			goto out_trans_fail;
 
-		error = fallocate_chunk(inode, offset, max_bytes, mode);
+		error = fallocate_chunk(inode, offset, max_bytes);
 		gfs2_trans_end(sdp);
 
 		if (error)
-- 
2.54.0

