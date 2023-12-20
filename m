Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FCC487A8
	for <gfs2@lists.linux.dev>; Wed, 20 Dec 2023 20:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OaqS7TM8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703103145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O0t7u+5yi8fmTR4QFVdzRX5+k2Z3kJJzoIjop94vMqg=;
	b=OaqS7TM8wkLPICSjNYdy+jPSW2iAPd1ptAtewog5HA3SQD+jX4EQaiye5j/5GCMkQO7UI3
	r3uZdDEjNHW9aEoI+cCqU8f600+NKaH6C2/JlYtom6TN9SoiB7HrN9mfcYEt/wayonszx2
	hUh4NET/vCq8ENuqF3uhPbm95SF7ne4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-663-5zuv43WcM4OU5UH1PzLrTQ-1; Wed,
 20 Dec 2023 15:12:24 -0500
X-MC-Unique: 5zuv43WcM4OU5UH1PzLrTQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2221C2824762
	for <gfs2@lists.linux.dev>; Wed, 20 Dec 2023 20:12:24 +0000 (UTC)
Received: from pasta.redhat.com (unknown [10.45.224.39])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9DD0D492BE6;
	Wed, 20 Dec 2023 20:12:23 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 2/4] gfs2: Mark withdraws as unlikely
Date: Wed, 20 Dec 2023 21:12:20 +0100
Message-ID: <20231220201222.1581061-2-agruenba@redhat.com>
In-Reply-To: <20231220201222.1581061-1-agruenba@redhat.com>
References: <20231220201222.1581061-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Mark the gfs2_withdrawn(), gfs2_withdrawing(), and
gfs2_withdraw_in_prog() inline functions as likely to return %false.
This allows to get rid of likely() and unlikely() annotations at the
call sites of those functions.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/aops.c       |  2 +-
 fs/gfs2/file.c       |  2 +-
 fs/gfs2/glock.c      |  4 ++--
 fs/gfs2/meta_io.c    |  6 +++---
 fs/gfs2/ops_fstype.c |  2 +-
 fs/gfs2/super.c      |  2 +-
 fs/gfs2/trans.c      |  2 +-
 fs/gfs2/util.h       | 10 +++++-----
 8 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index 9611bfceda4b..4482a5a9bdc9 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -462,7 +462,7 @@ static int gfs2_read_folio(struct file *file, struct folio *folio)
 		error = mpage_read_folio(folio, gfs2_block_map);
 	}
 
-	if (unlikely(gfs2_withdrawn(sdp)))
+	if (gfs2_withdrawn(sdp))
 		return -EIO;
 
 	return error;
diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index 4b66efc1a82a..03902e780935 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -1442,7 +1442,7 @@ static int gfs2_lock(struct file *file, int cmd, struct file_lock *fl)
 
 	if (!(fl->fl_flags & FL_POSIX))
 		return -ENOLCK;
-	if (unlikely(gfs2_withdrawn(sdp))) {
+	if (gfs2_withdrawn(sdp)) {
 		if (fl->fl_type == F_UNLCK)
 			locks_lock_file_wait(file, fl);
 		return -EIO;
diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 2cb65f76eec8..b71dd7c8f65e 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -156,7 +156,7 @@ static bool glock_blocked_by_withdraw(struct gfs2_glock *gl)
 {
 	struct gfs2_sbd *sdp = gl->gl_name.ln_sbd;
 
-	if (likely(!gfs2_withdrawn(sdp)))
+	if (!gfs2_withdrawn(sdp))
 		return false;
 	if (gl->gl_ops->go_flags & GLOF_NONDISK)
 		return false;
@@ -774,7 +774,7 @@ __acquires(&gl->gl_lockref.lock)
 	 * gfs2_gl_hash_clear calls clear_glock) and recovery is complete
 	 * then it's okay to tell dlm to unlock it.
 	 */
-	if (unlikely(sdp->sd_log_error && !gfs2_withdrawn(sdp)))
+	if (unlikely(sdp->sd_log_error) && !gfs2_withdrawn(sdp))
 		gfs2_withdraw_delayed(sdp);
 	if (glock_blocked_by_withdraw(gl) &&
 	    (target != LM_ST_UNLOCKED ||
diff --git a/fs/gfs2/meta_io.c b/fs/gfs2/meta_io.c
index 25ceb0805df2..299ae67ae85e 100644
--- a/fs/gfs2/meta_io.c
+++ b/fs/gfs2/meta_io.c
@@ -252,7 +252,7 @@ int gfs2_meta_read(struct gfs2_glock *gl, u64 blkno, int flags,
 	struct buffer_head *bh, *bhs[2];
 	int num = 0;
 
-	if (unlikely(gfs2_withdrawn(sdp)) && !gfs2_withdraw_in_prog(sdp)) {
+	if (gfs2_withdrawn(sdp) && !gfs2_withdraw_in_prog(sdp)) {
 		*bhp = NULL;
 		return -EIO;
 	}
@@ -310,7 +310,7 @@ int gfs2_meta_read(struct gfs2_glock *gl, u64 blkno, int flags,
 
 int gfs2_meta_wait(struct gfs2_sbd *sdp, struct buffer_head *bh)
 {
-	if (unlikely(gfs2_withdrawn(sdp)) && !gfs2_withdraw_in_prog(sdp))
+	if (gfs2_withdrawn(sdp) && !gfs2_withdraw_in_prog(sdp))
 		return -EIO;
 
 	wait_on_buffer(bh);
@@ -321,7 +321,7 @@ int gfs2_meta_wait(struct gfs2_sbd *sdp, struct buffer_head *bh)
 			gfs2_io_error_bh_wd(sdp, bh);
 		return -EIO;
 	}
-	if (unlikely(gfs2_withdrawn(sdp)) && !gfs2_withdraw_in_prog(sdp))
+	if (gfs2_withdrawn(sdp) && !gfs2_withdraw_in_prog(sdp))
 		return -EIO;
 
 	return 0;
diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index b108c5d26839..c6ec08909c69 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -1073,7 +1073,7 @@ static int gfs2_lm_mount(struct gfs2_sbd *sdp, int silent)
 void gfs2_lm_unmount(struct gfs2_sbd *sdp)
 {
 	const struct lm_lockops *lm = sdp->sd_lockstruct.ls_ops;
-	if (likely(!gfs2_withdrawn(sdp)) && lm->lm_unmount)
+	if (!gfs2_withdrawn(sdp) && lm->lm_unmount)
 		lm->lm_unmount(sdp);
 }
 
diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index b5c75c8a8d62..85c77dd327ec 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -499,7 +499,7 @@ static void gfs2_dirty_inode(struct inode *inode, int flags)
 		return;
 	}
 
-	if (unlikely(gfs2_withdrawn(sdp)))
+	if (gfs2_withdrawn(sdp))
 		return;
 	if (!gfs2_glock_is_locked_by_me(ip->i_gl)) {
 		ret = gfs2_glock_nq_init(ip->i_gl, LM_ST_EXCLUSIVE, 0, &gh);
diff --git a/fs/gfs2/trans.c b/fs/gfs2/trans.c
index 7e835be7032d..1487fbb62d84 100644
--- a/fs/gfs2/trans.c
+++ b/fs/gfs2/trans.c
@@ -268,7 +268,7 @@ void gfs2_trans_add_meta(struct gfs2_glock *gl, struct buffer_head *bh)
 		       (unsigned long long)bd->bd_bh->b_blocknr);
 		BUG();
 	}
-	if (unlikely(gfs2_withdrawn(sdp))) {
+	if (gfs2_withdrawn(sdp)) {
 		fs_info(sdp, "GFS2:adding buf while withdrawn! 0x%llx\n",
 			(unsigned long long)bd->bd_bh->b_blocknr);
 		goto out_unlock;
diff --git a/fs/gfs2/util.h b/fs/gfs2/util.h
index 11c9d59b6889..76acf0b39814 100644
--- a/fs/gfs2/util.h
+++ b/fs/gfs2/util.h
@@ -203,8 +203,8 @@ static inline void gfs2_withdraw_delayed(struct gfs2_sbd *sdp)
  */
 static inline bool gfs2_withdrawn(struct gfs2_sbd *sdp)
 {
-	return test_bit(SDF_WITHDRAWN, &sdp->sd_flags) ||
-		test_bit(SDF_WITHDRAWING, &sdp->sd_flags);
+	return unlikely(test_bit(SDF_WITHDRAWN, &sdp->sd_flags) ||
+			test_bit(SDF_WITHDRAWING, &sdp->sd_flags));
 }
 
 /**
@@ -213,13 +213,13 @@ static inline bool gfs2_withdrawn(struct gfs2_sbd *sdp)
  */
 static inline bool gfs2_withdrawing(struct gfs2_sbd *sdp)
 {
-	return test_bit(SDF_WITHDRAWING, &sdp->sd_flags) &&
-	       !test_bit(SDF_WITHDRAWN, &sdp->sd_flags);
+	return unlikely(test_bit(SDF_WITHDRAWING, &sdp->sd_flags) &&
+			!test_bit(SDF_WITHDRAWN, &sdp->sd_flags));
 }
 
 static inline bool gfs2_withdraw_in_prog(struct gfs2_sbd *sdp)
 {
-	return test_bit(SDF_WITHDRAW_IN_PROG, &sdp->sd_flags);
+	return unlikely(test_bit(SDF_WITHDRAW_IN_PROG, &sdp->sd_flags));
 }
 
 #define gfs2_tune_get(sdp, field) \
-- 
2.43.0

