Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EF4446AC
	for <gfs2@lists.linux.dev>; Wed, 27 Dec 2023 12:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U9o8IilU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703680228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rLibSYCp99yt3VCTta/qJvclPWLHJrAsxecwnHoh0R4=;
	b=U9o8IilUAKD1FYs7iSL+dbb4DHs8HAnaWB1kROMH+wwaSbH0PDZKnsRndZsvjVecGFuu+u
	eBUs7Ro2a34YtGESrTMGr4UwXS7aZkQ1p1lUO4gJPyFN4zpumqT35s8wRvVeIjOSBPyIvE
	xb0j1gHN/CXIvqSQQ7F8tWne8VxiORM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-264-dcYqGP2tNYWar4EiBhIPug-1; Wed,
 27 Dec 2023 07:30:27 -0500
X-MC-Unique: dcYqGP2tNYWar4EiBhIPug-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BB7C01C0BA4C
	for <gfs2@lists.linux.dev>; Wed, 27 Dec 2023 12:30:26 +0000 (UTC)
Received: from pasta.redhat.com (unknown [10.45.224.39])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 42F74492BC6;
	Wed, 27 Dec 2023 12:30:26 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 3/3] gfs2: Fix freeze consistency check in log_write_header
Date: Wed, 27 Dec 2023 13:30:24 +0100
Message-ID: <20231227123024.2698471-3-agruenba@redhat.com>
In-Reply-To: <20231227123024.2698471-1-agruenba@redhat.com>
References: <20231227123024.2698471-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Functions gfs2_freeze_super() and gfs2_thaw_super() are using the
SDF_FROZEN flag to indicate when the filesystem is frozen, synchronized
by sd_freeze_mutex.  However, this doesn't prevent writes from happening
between the point of calling thaw_super() and the point where the
SDF_FROZEN flag is cleared, so the following assert can trigger in
log_write_header():

    gfs2_assert_withdraw(sdp, !test_bit(SDF_FROZEN, &sdp->sd_flags));

Fix that by checking for sb->s_writers.frozen != SB_FREEZE_COMPLETE in
log_write_header() instead.  To make sure that the filesystem-specific
part of freezing happens before sb->s_writers.frozen is set to
SB_FREEZE_COMPLETE, move that code from gfs2_freeze_locally() into
gfs2_freeze_fs() and hook that up to the .freeze_fs operation.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/log.c   |  3 ++-
 fs/gfs2/super.c | 40 ++++++++++++++++------------------------
 2 files changed, 18 insertions(+), 25 deletions(-)

diff --git a/fs/gfs2/log.c b/fs/gfs2/log.c
index 6b3ba8f7b67a..8cddf955ebc0 100644
--- a/fs/gfs2/log.c
+++ b/fs/gfs2/log.c
@@ -913,8 +913,9 @@ void gfs2_write_log_header(struct gfs2_sbd *sdp, struct gfs2_jdesc *jd,
 static void log_write_header(struct gfs2_sbd *sdp, u32 flags)
 {
 	blk_opf_t op_flags = REQ_PREFLUSH | REQ_FUA | REQ_META | REQ_SYNC;
+	struct super_block *sb = sdp->sd_vfs;
 
-	gfs2_assert_withdraw(sdp, !test_bit(SDF_FROZEN, &sdp->sd_flags));
+	gfs2_assert_withdraw(sdp, sb->s_writers.frozen != SB_FREEZE_COMPLETE);
 
 	if (test_bit(SDF_NOBARRIERS, &sdp->sd_flags)) {
 		gfs2_ordered_wait(sdp);
diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index ae92ae1203d8..e5f79466340d 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -673,28 +673,6 @@ static int gfs2_sync_fs(struct super_block *sb, int wait)
 	return sdp->sd_log_error;
 }
 
-static int gfs2_freeze_locally(struct gfs2_sbd *sdp)
-{
-	struct super_block *sb = sdp->sd_vfs;
-	int error;
-
-	error = freeze_super(sb, FREEZE_HOLDER_USERSPACE);
-	if (error)
-		return error;
-
-	if (test_bit(SDF_JOURNAL_LIVE, &sdp->sd_flags)) {
-		gfs2_log_flush(sdp, NULL, GFS2_LOG_HEAD_FLUSH_FREEZE |
-			       GFS2_LFC_FREEZE_GO_SYNC);
-		if (gfs2_withdrawing_or_withdrawn(sdp)) {
-			error = thaw_super(sb, FREEZE_HOLDER_USERSPACE);
-			if (error)
-				return error;
-			return -EIO;
-		}
-	}
-	return 0;
-}
-
 static int gfs2_do_thaw(struct gfs2_sbd *sdp)
 {
 	struct super_block *sb = sdp->sd_vfs;
@@ -724,7 +702,7 @@ void gfs2_freeze_func(struct work_struct *work)
 	if (test_bit(SDF_FROZEN, &sdp->sd_flags))
 		goto freeze_failed;
 
-	error = gfs2_freeze_locally(sdp);
+	error = freeze_super(sb, FREEZE_HOLDER_USERSPACE);
 	if (error)
 		goto freeze_failed;
 
@@ -765,7 +743,7 @@ static int gfs2_freeze_super(struct super_block *sb, enum freeze_holder who)
 	}
 
 	for (;;) {
-		error = gfs2_freeze_locally(sdp);
+		error = freeze_super(sb, FREEZE_HOLDER_USERSPACE);
 		if (error) {
 			fs_info(sdp, "GFS2: couldn't freeze filesystem: %d\n",
 				error);
@@ -801,6 +779,19 @@ static int gfs2_freeze_super(struct super_block *sb, enum freeze_holder who)
 	return error;
 }
 
+static int gfs2_freeze_fs(struct super_block *sb)
+{
+	struct gfs2_sbd *sdp = sb->s_fs_info;
+
+	if (test_bit(SDF_JOURNAL_LIVE, &sdp->sd_flags)) {
+		gfs2_log_flush(sdp, NULL, GFS2_LOG_HEAD_FLUSH_FREEZE |
+			       GFS2_LFC_FREEZE_GO_SYNC);
+		if (gfs2_withdrawing_or_withdrawn(sdp))
+			return -EIO;
+	}
+	return 0;
+}
+
 /**
  * gfs2_thaw_super - reallow writes to the filesystem
  * @sb: the VFS structure for the filesystem
@@ -1599,6 +1590,7 @@ const struct super_operations gfs2_super_ops = {
 	.put_super		= gfs2_put_super,
 	.sync_fs		= gfs2_sync_fs,
 	.freeze_super		= gfs2_freeze_super,
+	.freeze_fs		= gfs2_freeze_fs,
 	.thaw_super		= gfs2_thaw_super,
 	.statfs			= gfs2_statfs,
 	.drop_inode		= gfs2_drop_inode,
-- 
2.43.0

