Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D154C1F4C98
	for <gfs2@lists.linux.dev>; Tue, 22 Apr 2025 09:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745314823; cv=none; b=DtWpzDDSaPXWCghv6wAfNnet6WiL8e6QoDmRLat8B/NpsAB7wi1Rm31fbkZtdITpMLDAN7o45Rj5SSyZaa8tFPTXtBPuYWQ20/8zWUoj3VrGl28B9l0b4YN1Chhdm8dy55LxBG6JHFe8rRLHEB4n9xE2JDvLBcf+Az0Hg5kYzkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745314823; c=relaxed/simple;
	bh=vSc6C77anbZSr0BTjeu5hDkJZcawUnYxsfHM+CNCxhk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=lvkdQQ6Rdb4oBgr90lT8wiM8muNh0g3Q5BX+sWoAeL7VnmWvWYClL7X5dx6tZYtMNkP45xaM7fsdPSDdNg7HWCv4TQ0FJQJZDq9lkizOQVfpBZH/6VrxAfjH7Iwz2PNQDP1nZ/D03o2UWQwKSq+GTwj1tkarT9Urp0N1hUecwiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FY+34oFS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FY+34oFS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745314820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DxZC7ZHXyoU8VWAq430BHU1z/Lf0T1Y7KH2aHb+Mkyc=;
	b=FY+34oFSFhT2IJbjcGiEDj4xOFgfNGvuPpFlhhSfjoe4F1Uv4tUvXoEHjT9ZLltutIvLoT
	FmI727U9rKO2Xon88yNt8453TntG5PNvqiiTMAUD91tNpt8PO16U877UkEFL8sMVM0anrm
	47dtta8f2r7K8Y4m6KYo/YCePZwvZzs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-339-kvCd-GJbNnqYBUi1G2NPhA-1; Tue,
 22 Apr 2025 05:40:18 -0400
X-MC-Unique: kvCd-GJbNnqYBUi1G2NPhA-1
X-Mimecast-MFC-AGG-ID: kvCd-GJbNnqYBUi1G2NPhA_1745314818
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 117E519560B7
	for <gfs2@lists.linux.dev>; Tue, 22 Apr 2025 09:40:18 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.40])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 022191801396;
	Tue, 22 Apr 2025 09:40:16 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH] gfs2: gfs2_create_inode error handling fix
Date: Tue, 22 Apr 2025 11:40:15 +0200
Message-ID: <20250422094015.1221153-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xIUo7Fd0fnRz3SutJ-Uz9Lm-CAbcD0LKMsOkeITngQE_1745314818
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

When gfs2_create_inode() finds a directory, make sure to return -EISDIR.

Fixes: 571a4b57975a ("GFS2: bugger off early if O_CREAT open finds a directory")
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/inode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index 198a8cbaf5e5..9621680814b8 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -659,7 +659,8 @@ static int gfs2_create_inode(struct inode *dir, struct dentry *dentry,
 	if (!IS_ERR(inode)) {
 		if (S_ISDIR(inode->i_mode)) {
 			iput(inode);
-			inode = ERR_PTR(-EISDIR);
+			inode = NULL;
+			error = -EISDIR;
 			goto fail_gunlock;
 		}
 		d_instantiate(dentry, inode);
-- 
2.49.0

