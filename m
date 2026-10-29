Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793282382;
	b=U02h7JYeCLlH7I42FhJq9Lse2m6XtGOduvicki7YV9noQHE4tgCjN2YM9FXN6GQQePPJ
	 mwaZ+fjos+8C3iEB4t1VAanabAobnZsU935nJfgMm5Q9Z2ILl5+POcji4TC/gaus+5lmL
	 bsWnfEnwIoGGlcvD3pgAabGWQaqvCTLI5mZDiK0HLjDIGv9mbCHHI4CgtyANJJs5AX41A
	 fl48r2ZxiVpTCCo9+lzK+NApzXSdAFxbP0usgUW3/d6249qDqtXQHylvvF4EGWqupkjrX
	 zMDuYGOlROd36g31htYg9lRZGoG2Shcbo0JLc8pNym8B4/e8Nco0qIX2+zeZVGGc5mQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793282382;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:MIME-Version:X-Scanned-By:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type;
	bh=nsHKxMjuz/4Ld490lPCaq5a+an7rLm3vcrroSrFaza4=;
	b=OsHmX+KDb/mjdVSlyWu87Ihgjru4pS/WPOWv7lmu+NSCeI2Sm7usEhM12GshUMoJd1BW
	 Jas8DE64rPYRZdhoDtcbrXCs8OkVvctDWhYSnBBTYIbYIGVq3mKKtu7SVPdF0k4iwCuJ5
	 7pPmGHzCKbaHkZDX5Y04JmWBsB8ykO19eTyyWvME4/Dt4rikR7SFr3fRBmuEzt5BxpSD1
	 z7VjFhgjPBBCjV69jMy72xcjxy4KvUYxmS1PNaclay2bN7MV4P9Qix/lO95tgZ22FJ9a3
	 wwLrhAcO2IPtC+mRN4PCqkw7NKSN7GlB+tkU++qbzsA/jy+8GDFzXWNyWWbACQ3cQWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QoHIwF6t;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55635606A31C
	for <gfs2@lists.linux.dev>; Thu, 29 Oct 2026 13:59:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55635606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QoHIwF6t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793282381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nsHKxMjuz/4Ld490lPCaq5a+an7rLm3vcrroSrFaza4=;
	b=QoHIwF6tL7pUt9n1Tsq9zOr0Yr06KZlyH8mxyp8+vZ/rQd/Tbahdqo4+UoEkYI83gkASPC
	ucRaKInxq0QQjMCSG565tgCw0r14wEwAwY+8Dt5u4iCN3MgOxkRWcQY4mbOHfLNsc0Uqqz
	8FRZVJjxzTJxcmmZ7D1W5zWWpWR/Fw0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-596-lIJg6UwsOP6jJyP_UfnhMA-1; Thu,
 29 Oct 2026 09:59:33 -0400
X-MC-Unique: lIJg6UwsOP6jJyP_UfnhMA-1
X-Mimecast-MFC-AGG-ID: lIJg6UwsOP6jJyP_UfnhMA_1793282373
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CF9F71955D87
	for <gfs2@lists.linux.dev>; Thu, 29 Oct 2026 13:59:32 +0000 (UTC)
Received: from agruenba-thinkpadx1carbongen9.rmtat.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C97F11800480;
	Thu, 29 Oct 2026 13:59:31 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH] gfs2: Fix freeze sysfs interface
Date: Thu, 29 Oct 2026 14:59:30 +0100
Message-ID: <20261029135930.352352-1-agruenba@redhat.com>
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Post: <mailto:gfs2@lists.linux.dev>
List-Help: <mailto:gfs2+help@lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
List-Owner: <mailto:gfs2+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: UQ8KTNrZws3_a6oqjull2t8YPIGssDT9z5oBFYojNoI_1793282373
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

According to commit d564053f0746 ("GFS2: Clean up freeze code"), the
freeze sysfs attribute is supposed to behave in the same way as the
FIFREEZE / FITHAW ioctls.  This broke in commit 2e60d7683c8d ("GFS2:
update freeze code to use freeze/thaw_super on all nodes") when the
gfs2_freeze_super and gfs2_thaw_super operations were added.  Since
then, the freeze sysfs attribute was performing local instead of
cluster-wide freeze / thaw operations.  Fix that by calling the
filesystem-specific operations.

Fixes: 2e60d7683c8d ("GFS2: update freeze code to use freeze/thaw_super on all nodes")
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>

diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index 04bb4cf787d4..bcb90ffe1816 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -727,8 +727,8 @@ void gfs2_freeze_func(struct work_struct *work)
  *
  */
 
-static int gfs2_freeze_super(struct super_block *sb, enum freeze_holder who,
-			     const void *freeze_owner)
+int gfs2_freeze_super(struct super_block *sb, enum freeze_holder who,
+		      const void *freeze_owner)
 {
 	struct gfs2_sbd *sdp = sb->s_fs_info;
 	int error;
@@ -796,8 +796,8 @@ static int gfs2_freeze_fs(struct super_block *sb)
  *
  */
 
-static int gfs2_thaw_super(struct super_block *sb, enum freeze_holder who,
-			   const void *freeze_owner)
+int gfs2_thaw_super(struct super_block *sb, enum freeze_holder who,
+		    const void *freeze_owner)
 {
 	struct gfs2_sbd *sdp = sb->s_fs_info;
 	int error;
diff --git a/fs/gfs2/super.h b/fs/gfs2/super.h
index 173f1e74c2a9..f0d1c3659742 100644
--- a/fs/gfs2/super.h
+++ b/fs/gfs2/super.h
@@ -35,6 +35,10 @@ int gfs2_lookup_in_master_dir(struct gfs2_sbd *sdp, char *filename,
 
 int gfs2_make_fs_rw(struct gfs2_sbd *sdp);
 void gfs2_make_fs_ro(struct gfs2_sbd *sdp);
+int gfs2_freeze_super(struct super_block *sb, enum freeze_holder who,
+		      const void *freeze_owner);
+int gfs2_thaw_super(struct super_block *sb, enum freeze_holder who,
+		    const void *freeze_owner);
 void gfs2_online_uevent(struct gfs2_sbd *sdp);
 void gfs2_destroy_threads(struct gfs2_sbd *sdp);
 int gfs2_statfs_init(struct gfs2_sbd *sdp);
diff --git a/fs/gfs2/sys.c b/fs/gfs2/sys.c
index ea2c7b9e4a77..2702f53f5acb 100644
--- a/fs/gfs2/sys.c
+++ b/fs/gfs2/sys.c
@@ -164,10 +164,12 @@ static ssize_t freeze_store(struct gfs2_sbd *sdp, const char *buf, size_t len)
 
 	switch (n) {
 	case 0:
-		error = thaw_super(sdp->sd_vfs, FREEZE_HOLDER_USERSPACE, NULL);
+		error = gfs2_thaw_super(sdp->sd_vfs, FREEZE_HOLDER_USERSPACE,
+				NULL);
 		break;
 	case 1:
-		error = freeze_super(sdp->sd_vfs, FREEZE_HOLDER_USERSPACE, NULL);
+		error = gfs2_freeze_super(sdp->sd_vfs, FREEZE_HOLDER_USERSPACE,
+				NULL);
 		break;
 	default:
 		return -EINVAL;

