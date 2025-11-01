Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406F71C75E2
	for <gfs2@lists.linux.dev>; Sat,  1 Nov 2025 00:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761956572; cv=none; b=nEXkPPBOolI8bwSdU8WWeK5RCSl+p6zwI2wsJQis2p7e8q67ogU9xldP/+ffBkIGeOQ6KU2kU/8MK+u4K0csfkYUXXGBFPFp5vBwY9/cjb2hUP1J8QGsJ1a69enj4C85WNU3MRZySlwS12bILrPpXNbwhdvTf+vIc4r7KzOmqp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761956572; c=relaxed/simple;
	bh=c4OAPDVh/E7Lrxy92sYvfwpCg9ha4V+ADGI8CTOdmwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=bKfxcO/VLOx9v3A85I+CHCosvuQw8WBI4GLfUzh+zfeuT2yXHyhypwhN8dP8tMjpiQZ67SZ5QAEoC/hpishyVLUpfYHv2lJNp7BxkXzR60RRtD9eD5lXgadt16MpiB4MN+dKPMrHeyqdOHkxKur1fnxPrcTOXerXyplqL7Nh2Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bfXRUeV9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bfXRUeV9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761956570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sHqu7dz4IrHE5aQaXPSGJNHqgPAkBaxfSjSQAWGp/hw=;
	b=bfXRUeV94tEAGDtwJqfwtkSmFd3R2UY1u1RvzmCn103ZDATIj0AwIJnfZLyxDFSxWVR3ui
	qBpB7WhK/5MKG2BvGuaPXybeLFhoObwXnYsPpRcqS2tRUqo+B/DSECcMEMvVqwYI+0ttiq
	/HCRZl1+wXl3lqwNRcs2ZeqYlscvtFY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-497-2s5MbqY4NniQPLKFlD4sDA-1; Fri,
 31 Oct 2025 20:22:48 -0400
X-MC-Unique: 2s5MbqY4NniQPLKFlD4sDA-1
X-Mimecast-MFC-AGG-ID: 2s5MbqY4NniQPLKFlD4sDA_1761956568
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 07F9318001D1
	for <gfs2@lists.linux.dev>; Sat,  1 Nov 2025 00:22:48 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.12])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F14FC180035A;
	Sat,  1 Nov 2025 00:22:46 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 07/24] gfs2: Rename LM_FLAG_{NOEXP -> RECOVER}
Date: Sat,  1 Nov 2025 00:22:16 +0000
Message-ID: <20251101002234.1286383-8-agruenba@redhat.com>
In-Reply-To: <20251101002234.1286383-1-agruenba@redhat.com>
References: <20251101002234.1286383-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HMbunpo_HW1iWV8-aojPIknMb3JKO6NiyJabuugE53c_1761956568
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

GFS sets the LM_FLAG_NOEXP flag on locking requests it makes during
journal recovery, so rename the flag to LM_FLAG_RECOVER for improved
code readability.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/glock.c      | 10 +++++-----
 fs/gfs2/glock.h      |  8 ++++----
 fs/gfs2/ops_fstype.c |  9 +++++----
 fs/gfs2/recovery.c   |  6 ++++--
 fs/gfs2/super.c      |  2 +-
 fs/gfs2/util.c       |  6 +++---
 6 files changed, 22 insertions(+), 19 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 3be366bd6e01..1b0f47e694f3 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -692,7 +692,7 @@ __acquires(&gl->gl_lockref.lock)
 	int ret;
 
 	if (target != LM_ST_UNLOCKED && glock_blocked_by_withdraw(gl) &&
-	    gh && !(gh->gh_flags & LM_FLAG_NOEXP))
+	    gh && !(gh->gh_flags & LM_FLAG_RECOVER))
 		goto skip_inval;
 
 	GLOCK_BUG_ON(gl, gl->gl_state == target);
@@ -1541,7 +1541,7 @@ int gfs2_glock_nq(struct gfs2_holder *gh)
 	struct gfs2_glock *gl = gh->gh_gl;
 	int error;
 
-	if (glock_blocked_by_withdraw(gl) && !(gh->gh_flags & LM_FLAG_NOEXP))
+	if (glock_blocked_by_withdraw(gl) && !(gh->gh_flags & LM_FLAG_RECOVER))
 		return -EIO;
 
 	if (gh->gh_flags & GL_NOBLOCK) {
@@ -1566,7 +1566,7 @@ int gfs2_glock_nq(struct gfs2_holder *gh)
 	gh->gh_error = 0;
 	spin_lock(&gl->gl_lockref.lock);
 	add_to_queue(gh);
-	if (unlikely((LM_FLAG_NOEXP & gh->gh_flags) &&
+	if (unlikely((LM_FLAG_RECOVER & gh->gh_flags) &&
 		     test_and_clear_bit(GLF_HAVE_FROZEN_REPLY, &gl->gl_flags))) {
 		set_bit(GLF_HAVE_REPLY, &gl->gl_flags);
 		gl->gl_lockref.count++;
@@ -1888,7 +1888,7 @@ static int gfs2_should_freeze(const struct gfs2_glock *gl)
 	list_for_each_entry(gh, &gl->gl_holders, gh_list) {
 		if (test_bit(HIF_HOLDER, &gh->gh_iflags))
 			continue;
-		if (LM_FLAG_NOEXP & gh->gh_flags)
+		if (LM_FLAG_RECOVER & gh->gh_flags)
 			return 0;
 	}
 
@@ -2237,7 +2237,7 @@ static const char *hflags2str(char *buf, u16 flags, unsigned long iflags)
 		*p++ = 't';
 	if (flags & LM_FLAG_TRY_1CB)
 		*p++ = 'T';
-	if (flags & LM_FLAG_NOEXP)
+	if (flags & LM_FLAG_RECOVER)
 		*p++ = 'e';
 	if (flags & LM_FLAG_ANY)
 		*p++ = 'A';
diff --git a/fs/gfs2/glock.h b/fs/gfs2/glock.h
index dfbe06346b35..e84ef6c6164d 100644
--- a/fs/gfs2/glock.h
+++ b/fs/gfs2/glock.h
@@ -58,10 +58,10 @@ enum {
  * LM_FLAG_TRY_1CB
  * Send one blocking callback if TRY is set and the lock is not granted.
  *
- * LM_FLAG_NOEXP
+ * LM_FLAG_RECOVER
  * GFS sets this flag on lock requests it makes while doing journal recovery.
- * These special requests should not be blocked due to the recovery like
- * ordinary locks would be.
+ * While ordinary requests are blocked until the end of recovery, requests
+ * with this flag set do proceed.
  *
  * LM_FLAG_ANY
  * A SHARED request may also be granted in DEFERRED, or a DEFERRED request may
@@ -80,7 +80,7 @@ enum {
 
 #define LM_FLAG_TRY		0x0001
 #define LM_FLAG_TRY_1CB		0x0002
-#define LM_FLAG_NOEXP		0x0004
+#define LM_FLAG_RECOVER		0x0004
 #define LM_FLAG_ANY		0x0008
 #define LM_FLAG_NODE_SCOPE	0x0020
 #define GL_ASYNC		0x0040
diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index 8dab5e87b5a6..6be5f61d7541 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -370,7 +370,7 @@ static int init_locking(struct gfs2_sbd *sdp, struct gfs2_holder *mount_gh,
 	error = gfs2_glock_nq_num(sdp,
 				  GFS2_MOUNT_LOCK, &gfs2_nondisk_glops,
 				  LM_ST_EXCLUSIVE,
-				  LM_FLAG_NOEXP | GL_NOCACHE | GL_NOPID,
+				  LM_FLAG_RECOVER | GL_NOCACHE | GL_NOPID,
 				  mount_gh);
 	if (error) {
 		fs_err(sdp, "can't acquire mount glock: %d\n", error);
@@ -380,7 +380,7 @@ static int init_locking(struct gfs2_sbd *sdp, struct gfs2_holder *mount_gh,
 	error = gfs2_glock_nq_num(sdp,
 				  GFS2_LIVE_LOCK, &gfs2_nondisk_glops,
 				  LM_ST_SHARED,
-				  LM_FLAG_NOEXP | GL_EXACT | GL_NOPID,
+				  LM_FLAG_RECOVER | GL_EXACT | GL_NOPID,
 				  &sdp->sd_live_gh);
 	if (error) {
 		fs_err(sdp, "can't acquire live glock: %d\n", error);
@@ -745,7 +745,8 @@ static int init_journal(struct gfs2_sbd *sdp, int undo)
 		error = gfs2_glock_nq_num(sdp, sdp->sd_lockstruct.ls_jid,
 					  &gfs2_journal_glops,
 					  LM_ST_EXCLUSIVE,
-					  LM_FLAG_NOEXP | GL_NOCACHE | GL_NOPID,
+					  LM_FLAG_RECOVER |
+					  GL_NOCACHE | GL_NOPID,
 					  &sdp->sd_journal_gh);
 		if (error) {
 			fs_err(sdp, "can't acquire journal glock: %d\n", error);
@@ -755,7 +756,7 @@ static int init_journal(struct gfs2_sbd *sdp, int undo)
 		ip = GFS2_I(sdp->sd_jdesc->jd_inode);
 		sdp->sd_jinode_gl = ip->i_gl;
 		error = gfs2_glock_nq_init(ip->i_gl, LM_ST_SHARED,
-					   LM_FLAG_NOEXP | GL_EXACT |
+					   LM_FLAG_RECOVER | GL_EXACT |
 					   GL_NOCACHE | GL_NOPID,
 					   &sdp->sd_jinode_gh);
 		if (error) {
diff --git a/fs/gfs2/recovery.c b/fs/gfs2/recovery.c
index 4873b1c0e1bd..8c8202c68b64 100644
--- a/fs/gfs2/recovery.c
+++ b/fs/gfs2/recovery.c
@@ -424,7 +424,8 @@ void gfs2_recover_func(struct work_struct *work)
 
 		error = gfs2_glock_nq_num(sdp, jd->jd_jid, &gfs2_journal_glops,
 					  LM_ST_EXCLUSIVE,
-					  LM_FLAG_NOEXP | LM_FLAG_TRY | GL_NOCACHE,
+					  LM_FLAG_RECOVER | LM_FLAG_TRY |
+					  GL_NOCACHE,
 					  &j_gh);
 		switch (error) {
 		case 0:
@@ -440,7 +441,8 @@ void gfs2_recover_func(struct work_struct *work)
 		}
 
 		error = gfs2_glock_nq_init(ip->i_gl, LM_ST_SHARED,
-					   LM_FLAG_NOEXP | GL_NOCACHE, &ji_gh);
+					   LM_FLAG_RECOVER | GL_NOCACHE,
+					   &ji_gh);
 		if (error)
 			goto fail_gunlock_j;
 	} else {
diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index 2e4f75f17d46..7e560eff9216 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -351,7 +351,7 @@ static int gfs2_lock_fs_check_clean(struct gfs2_sbd *sdp)
 	gfs2_freeze_unlock(sdp);
 
 	error = gfs2_glock_nq_init(sdp->sd_freeze_gl, LM_ST_EXCLUSIVE,
-				   LM_FLAG_NOEXP | GL_NOPID,
+				   LM_FLAG_RECOVER | GL_NOPID,
 				   &sdp->sd_freeze_gh);
 	if (error)
 		goto relock_shared;
diff --git a/fs/gfs2/util.c b/fs/gfs2/util.c
index d0c1345421fc..8e47f106e2ba 100644
--- a/fs/gfs2/util.c
+++ b/fs/gfs2/util.c
@@ -58,7 +58,7 @@ int check_journal_clean(struct gfs2_sbd *sdp, struct gfs2_jdesc *jd,
 	struct gfs2_inode *ip;
 
 	ip = GFS2_I(jd->jd_inode);
-	error = gfs2_glock_nq_init(ip->i_gl, LM_ST_SHARED, LM_FLAG_NOEXP |
+	error = gfs2_glock_nq_init(ip->i_gl, LM_ST_SHARED, LM_FLAG_RECOVER |
 				   GL_EXACT | GL_NOCACHE, &j_gh);
 	if (error) {
 		if (verbose)
@@ -99,7 +99,7 @@ int check_journal_clean(struct gfs2_sbd *sdp, struct gfs2_jdesc *jd,
  */
 int gfs2_freeze_lock_shared(struct gfs2_sbd *sdp)
 {
-	int flags = LM_FLAG_NOEXP | GL_EXACT;
+	int flags = LM_FLAG_RECOVER | GL_EXACT;
 	int error;
 
 	error = gfs2_glock_nq_init(sdp->sd_freeze_gl, LM_ST_SHARED, flags,
@@ -224,7 +224,7 @@ static void signal_our_withdraw(struct gfs2_sbd *sdp)
 	fs_warn(sdp, "Requesting recovery of jid %d.\n",
 		sdp->sd_lockstruct.ls_jid);
 	gfs2_holder_reinit(LM_ST_EXCLUSIVE,
-			   LM_FLAG_TRY_1CB | LM_FLAG_NOEXP | GL_NOPID,
+			   LM_FLAG_TRY_1CB | LM_FLAG_RECOVER | GL_NOPID,
 			   &sdp->sd_live_gh);
 	msleep(GL_GLOCK_MAX_HOLD);
 	/*
-- 
2.51.0

