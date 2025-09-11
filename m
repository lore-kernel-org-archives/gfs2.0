Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007832E541E
	for <gfs2@lists.linux.dev>; Thu, 11 Sep 2025 13:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757599088; cv=none; b=QT2MRa6wYCfwlA8jm8JlVnmH1ihEPZd8uCMVpREhFNI0oCmGHMstJwADXP4vdXUJ9Ilejso8y9hVb7203T4GdQ5DAFt51uRpEk0vS0pFz98UHGaWi0xFlCocimhYoKSqCD8UZexGQZZbuuN6/MTUlE+vpMmZXNfUJ9yt0y6rUaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757599088; c=relaxed/simple;
	bh=kQxenAgw121G0VW9iDtCjPWKrn8g7G6yfwiwahPw6ow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=BOAPStlfNozfCCG/woD8NKwenQ9GdeF12A07/ukpWEc1hghPpKxuXo0LM9BE76fmyU3TXmd8rWxFK3CxvzFcRJRywE6FL+U5IAY8BJF2VHsHocQ9XeF+WCYcXX4q8xNDQSp93AyfyNgyLVGSRNKaKnB3rMI7+f08EvuaEbNe/lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vn1B1eDa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vn1B1eDa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757599086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BoWBhNc3wRMMvmyxj0YWbsckx9p9Uedo2Fps1j33mII=;
	b=Vn1B1eDaQDdV6oaVb64jfNF4LNFzSgyqeD2USGv26asCE6PX5e7RzkwfobEF+6rIIg/4NB
	t9oufYaCWt09by0TKosrsmHLDSscSlcmp+ONVVsuCPODVDOHQ5H4TFoa24YbbfzKskzzMf
	1QYmHF0Zh1drf+LWlRnR107bssBe5OA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-304-4N7gI34BODq_HLEaGzfnqQ-1; Thu,
 11 Sep 2025 09:58:04 -0400
X-MC-Unique: 4N7gI34BODq_HLEaGzfnqQ-1
X-Mimecast-MFC-AGG-ID: 4N7gI34BODq_HLEaGzfnqQ_1757599084
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 16D01180045C
	for <gfs2@lists.linux.dev>; Thu, 11 Sep 2025 13:58:04 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.44.32.31])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B331C19560B1;
	Thu, 11 Sep 2025 13:58:02 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 19/20] gfs2: Add proper lockspace locking
Date: Thu, 11 Sep 2025 15:57:24 +0200
Message-ID: <20250911135726.657575-20-agruenba@redhat.com>
In-Reply-To: <20250911135726.657575-1-agruenba@redhat.com>
References: <20250911135726.657575-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MmtgcAWHNhye-FMmIhyW9HevXo9g_l8ePNfAV8vnCbY_1757599084
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

GFS2 has been calling functions like dlm_lock() even after the lockspace
that these functions operate on has been released with
dlm_release_lockspace().  It has always assumed that those functions
would return -EINVAL in that case, but that was never guaranteed, and it
certainly is no longer the case since commit 4db41bf4f04f ("dlm: remove
ls_local_handle from struct dlm_ls").

To fix that, add proper lockspace locking.

Fixes: 3e11e5304150 ("GFS2: ignore unlock failures after withdraw")
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/file.c     | 23 +++++++++++++++--------
 fs/gfs2/glock.c    |  5 ++---
 fs/gfs2/incore.h   |  2 ++
 fs/gfs2/lock_dlm.c | 46 +++++++++++++++++++++++++++++++++++++---------
 4 files changed, 56 insertions(+), 20 deletions(-)

diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index 72d95185a39f..bc67fa058c84 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -1442,6 +1442,7 @@ static int gfs2_lock(struct file *file, int cmd, struct file_lock *fl)
 	struct gfs2_inode *ip = GFS2_I(file->f_mapping->host);
 	struct gfs2_sbd *sdp = GFS2_SB(file->f_mapping->host);
 	struct lm_lockstruct *ls = &sdp->sd_lockstruct;
+	int ret;
 
 	if (!(fl->c.flc_flags & FL_POSIX))
 		return -ENOLCK;
@@ -1450,14 +1451,20 @@ static int gfs2_lock(struct file *file, int cmd, struct file_lock *fl)
 			locks_lock_file_wait(file, fl);
 		return -EIO;
 	}
-	if (cmd == F_CANCELLK)
-		return dlm_posix_cancel(ls->ls_dlm, ip->i_no_addr, file, fl);
-	else if (IS_GETLK(cmd))
-		return dlm_posix_get(ls->ls_dlm, ip->i_no_addr, file, fl);
-	else if (lock_is_unlock(fl))
-		return dlm_posix_unlock(ls->ls_dlm, ip->i_no_addr, file, fl);
-	else
-		return dlm_posix_lock(ls->ls_dlm, ip->i_no_addr, file, cmd, fl);
+	down_read(&ls->ls_sem);
+	ret = -ENODEV;
+	if (likely(ls->ls_dlm != NULL)) {
+		if (cmd == F_CANCELLK)
+			ret = dlm_posix_cancel(ls->ls_dlm, ip->i_no_addr, file, fl);
+		else if (IS_GETLK(cmd))
+			ret = dlm_posix_get(ls->ls_dlm, ip->i_no_addr, file, fl);
+		else if (lock_is_unlock(fl))
+			ret = dlm_posix_unlock(ls->ls_dlm, ip->i_no_addr, file, fl);
+		else
+			ret = dlm_posix_lock(ls->ls_dlm, ip->i_no_addr, file, cmd, fl);
+	}
+	up_read(&ls->ls_sem);
+	return ret;
 }
 
 static void __flock_holder_uninit(struct file *file, struct gfs2_holder *fl_gh)
diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 747ee7ca44e2..b677c0e6b9ab 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -795,9 +795,8 @@ __acquires(&gl->gl_lockref.lock)
 		}
 		clear_bit(GLF_PENDING_REPLY, &gl->gl_flags);
 
-		if (ret == -EINVAL && gl->gl_target == LM_ST_UNLOCKED &&
-		    target == LM_ST_UNLOCKED &&
-		    test_bit(DFL_UNMOUNT, &ls->ls_recover_flags)) {
+		if (ret == -ENODEV && gl->gl_target == LM_ST_UNLOCKED &&
+		    target == LM_ST_UNLOCKED) {
 			/*
 			 * The lockspace has been released and the lock has
 			 * been unlocked implicitly.
diff --git a/fs/gfs2/incore.h b/fs/gfs2/incore.h
index cd8a3f469291..5a0ea416cfda 100644
--- a/fs/gfs2/incore.h
+++ b/fs/gfs2/incore.h
@@ -656,6 +656,8 @@ struct lm_lockstruct {
 	struct completion ls_sync_wait; /* {control,mounted}_{lock,unlock} */
 	char *ls_lvb_bits;
 
+	struct rw_semaphore ls_sem;
+
 	spinlock_t ls_recover_spin; /* protects following fields */
 	unsigned long ls_recover_flags; /* DFL_ */
 	uint32_t ls_recover_mount; /* gen in first recover_done cb */
diff --git a/fs/gfs2/lock_dlm.c b/fs/gfs2/lock_dlm.c
index 427150a206cf..3c7db20ce564 100644
--- a/fs/gfs2/lock_dlm.c
+++ b/fs/gfs2/lock_dlm.c
@@ -312,8 +312,13 @@ static int gdlm_lock(struct gfs2_glock *gl, unsigned int req_state,
 	 */
 
 again:
-	error = dlm_lock(ls->ls_dlm, req, &gl->gl_lksb, lkf, strname,
-			GDLM_STRNAME_BYTES - 1, 0, gdlm_ast, gl, gdlm_bast);
+	down_read(&ls->ls_sem);
+	error = -ENODEV;
+	if (likely(ls->ls_dlm != NULL)) {
+		error = dlm_lock(ls->ls_dlm, req, &gl->gl_lksb, lkf, strname,
+				GDLM_STRNAME_BYTES - 1, 0, gdlm_ast, gl, gdlm_bast);
+	}
+	up_read(&ls->ls_sem);
 	if (error == -EBUSY) {
 		msleep(20);
 		goto again;
@@ -362,8 +367,13 @@ static void gdlm_put_lock(struct gfs2_glock *gl)
 		flags |= DLM_LKF_VALBLK;
 
 again:
-	error = dlm_unlock(ls->ls_dlm, gl->gl_lksb.sb_lkid, flags,
-			   NULL, gl);
+	down_read(&ls->ls_sem);
+	error = -ENODEV;
+	if (likely(ls->ls_dlm != NULL)) {
+		error = dlm_unlock(ls->ls_dlm, gl->gl_lksb.sb_lkid, flags,
+				   NULL, gl);
+	}
+	up_read(&ls->ls_sem);
 	if (error == -EBUSY) {
 		msleep(20);
 		goto again;
@@ -379,7 +389,12 @@ static void gdlm_put_lock(struct gfs2_glock *gl)
 static void gdlm_cancel(struct gfs2_glock *gl)
 {
 	struct lm_lockstruct *ls = &gl->gl_name.ln_sbd->sd_lockstruct;
-	dlm_unlock(ls->ls_dlm, gl->gl_lksb.sb_lkid, DLM_LKF_CANCEL, NULL, gl);
+
+	down_read(&ls->ls_sem);
+	if (likely(ls->ls_dlm != NULL)) {
+		dlm_unlock(ls->ls_dlm, gl->gl_lksb.sb_lkid, DLM_LKF_CANCEL, NULL, gl);
+	}
+	up_read(&ls->ls_sem);
 }
 
 /*
@@ -560,7 +575,11 @@ static int sync_unlock(struct gfs2_sbd *sdp, struct dlm_lksb *lksb, char *name)
 	struct lm_lockstruct *ls = &sdp->sd_lockstruct;
 	int error;
 
-	error = dlm_unlock(ls->ls_dlm, lksb->sb_lkid, 0, lksb, ls);
+	down_read(&ls->ls_sem);
+	error = -ENODEV;
+	if (likely(ls->ls_dlm != NULL))
+		error = dlm_unlock(ls->ls_dlm, lksb->sb_lkid, 0, lksb, ls);
+	up_read(&ls->ls_sem);
 	if (error) {
 		fs_err(sdp, "%s lkid %x error %d\n",
 		       name, lksb->sb_lkid, error);
@@ -587,9 +606,14 @@ static int sync_lock(struct gfs2_sbd *sdp, int mode, uint32_t flags,
 	memset(strname, 0, GDLM_STRNAME_BYTES);
 	snprintf(strname, GDLM_STRNAME_BYTES, "%8x%16x", LM_TYPE_NONDISK, num);
 
-	error = dlm_lock(ls->ls_dlm, mode, lksb, flags,
-			 strname, GDLM_STRNAME_BYTES - 1,
-			 0, sync_wait_cb, ls, NULL);
+	down_read(&ls->ls_sem);
+	error = -ENODEV;
+	if (likely(ls->ls_dlm != NULL)) {
+		error = dlm_lock(ls->ls_dlm, mode, lksb, flags,
+				 strname, GDLM_STRNAME_BYTES - 1,
+				 0, sync_wait_cb, ls, NULL);
+	}
+	up_read(&ls->ls_sem);
 	if (error) {
 		fs_err(sdp, "%s lkid %x flags %x mode %d error %d\n",
 		       name, lksb->sb_lkid, flags, mode, error);
@@ -1316,6 +1340,7 @@ static int gdlm_mount(struct gfs2_sbd *sdp, const char *table)
 	 */
 
 	INIT_DELAYED_WORK(&sdp->sd_control_work, gfs2_control_func);
+	ls->ls_dlm = NULL;
 	spin_lock_init(&ls->ls_recover_spin);
 	ls->ls_recover_flags = 0;
 	ls->ls_recover_mount = 0;
@@ -1350,6 +1375,7 @@ static int gdlm_mount(struct gfs2_sbd *sdp, const char *table)
 	 * create/join lockspace
 	 */
 
+	init_rwsem(&ls->ls_sem);
 	error = dlm_new_lockspace(fsname, cluster, flags, GDLM_LVB_SIZE,
 				  &gdlm_lockspace_ops, sdp, &ops_result,
 				  &ls->ls_dlm);
@@ -1429,10 +1455,12 @@ static void gdlm_unmount(struct gfs2_sbd *sdp)
 
 	/* mounted_lock and control_lock will be purged in dlm recovery */
 release:
+	down_write(&ls->ls_sem);
 	if (ls->ls_dlm) {
 		dlm_release_lockspace(ls->ls_dlm, 2);
 		ls->ls_dlm = NULL;
 	}
+	up_write(&ls->ls_sem);
 
 	free_recover_size(ls);
 }
-- 
2.51.0

