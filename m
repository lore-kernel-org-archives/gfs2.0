Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D733B3E835E
	for <gfs2@lists.linux.dev>; Thu, 27 Aug 2026 09:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787821612; cv=none; b=PFPldSWJP6qP2WNI45nGdRxQCEWcvUT1M6yPqggeESPCPXP2ev4W9S9owcA0aBMIhz0xU8gnimBLXFdqfAieVUroHYY6uDUAz4ePNpJ+9OFJ4UcvGnW0MESz1w+jlgAeQK558HgLRTtAAOHUH3Gldl/Um4unYioDz/YZq0lVaQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787821612; c=relaxed/simple;
	bh=8W2TZU7hf0bBc8S6oSJTogkd/v18T2vhjg24AiPdsG8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=cY0sqNtb7LACuEJkmyY+/+o22+p+gyc9CcBZZlVlpY8mmaNzzVxDPYo8HAw6EH3S3yJls8UIEzkUxTOf2VWjiyf3tjq64knxAhOAlnrupzMAKFOugTJ8MBqKIbaPxaoUAwYye1ciyHK8df7Yhgdr1cL9W3w1c6iit8UmRBOt158=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F4Uu6u+f; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F4Uu6u+f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787821604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CCRQ4gsLG/cMbjBIzvct3Pui215swoUP3SncBxGf6Xk=;
	b=F4Uu6u+f8SzDiyJ80z9P0AHAqruMe9PxuS9Q1c8zuX+XBmSneo2Gvf84mc5E+mzAZLt+La
	IjWwgMfAXOHS05Zw8JIRlhZFfh7a9JIZLXh6bGx9zpRleWsGJg+41z+4UuJdEQHLjkai4l
	0MrdrwXy/Dfxk42vSj35IqDlcp03Z60=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-36-c_JVaFbrNQq6OKZYKj_BgQ-1; Thu,
 27 Aug 2026 05:06:40 -0400
X-MC-Unique: c_JVaFbrNQq6OKZYKj_BgQ-1
X-Mimecast-MFC-AGG-ID: c_JVaFbrNQq6OKZYKj_BgQ_1787821600
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C3B891955F11;
	Thu, 27 Aug 2026 09:06:39 +0000 (UTC)
Received: from pasta.redhat.com (unknown [10.44.32.182])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6D7A21956044;
	Thu, 27 Aug 2026 09:06:38 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	syzbot+cb79de2cc8b76fbf474f@syzkaller.appspotmail.com
Subject: [PATCH] gfs2: No quotas for meta inodes
Date: Thu, 27 Aug 2026 11:06:37 +0200
Message-ID: <20260827090637.676820-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YsZsjDS_ZvVsYxmqYqAh50VbCuot1F1dSWoDAlwiaJI_1787821600
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Inodes on the meta filesystem (mount -o meta) can never have quotas, so skip
them entirely in the quota code.  This avoids allocating ip->i_qadata
unnecessarily.

Without this fix, unlinking meta inodes like "statfs" on the meta filesystem
will result in a NULL pointer dereference at unmount time:

  gfs2_evict_inode() -> gfs2_dinode_dealloc() -> gfs2_quota_hold()
    -> qdsb_get() -> slot_get() -> find_first_zero_bit(sd_quota_bitmap)

Unlinking inodes on the meta filesystem isn't a useful operation, but it still
shouldn't cause the kernel to misbehave.

Reported-by: syzbot+cb79de2cc8b76fbf474f@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=cb79de2cc8b76fbf474f
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/quota.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
index b62431724eea..dbfc21693dd5 100644
--- a/fs/gfs2/quota.c
+++ b/fs/gfs2/quota.c
@@ -562,6 +562,8 @@ int gfs2_qa_get(struct gfs2_inode *ip)
 
 	if (sdp->sd_args.ar_quota == GFS2_QUOTA_OFF)
 		return 0;
+	if (ip->i_diskflags & GFS2_DIF_SYSTEM)
+		return 0;
 
 	spin_lock(&inode->i_lock);
 	if (ip->i_qadata == NULL) {
@@ -605,7 +607,7 @@ int gfs2_quota_hold(struct gfs2_inode *ip, kuid_t uid, kgid_t gid)
 		return 0;
 
 	error = gfs2_qa_get(ip);
-	if (error)
+	if (error || !ip->i_qadata)
 		return error;
 
 	qd = ip->i_qadata->qa_qd;
-- 
2.55.0

