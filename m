Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CD215B57B
	for <gfs2@lists.linux.dev>; Tue,  2 Apr 2024 19:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712085504; cv=none; b=XGJ/7FUbpIPuMZFwiVPIgw9og4Z/SVG4hwaomwk6nKt9rWNEqYG17yot9NQ6cCh5MjDdxVlylJuFfph0nM7e1UhILKYVYoHT6lgz1j9OJ63MFwLHXeIUQrfayvA8ewwB1xLuwoJkPG0XduSE17jdsKhuzfmnrTpb3ewEuYpAFXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712085504; c=relaxed/simple;
	bh=2U1QN6zOo17ICOsNv0BdBUyrkkhlvDduX1lFEc6iKUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FO50NT+nxVvfFSBR6favmPOk+ZnHAvmV+xVpzN5xGC7gyow5sYYkFY7L1q75PHYo6dM85FI5FlFdCSuje2lG32HpuHamnZRLtQyBWiJAp7sBpDHs6w8NYVW5oiCHEBaKUuqITaJt27VHJbic+sNTP1GsmCVltLIj42uyYOCEpoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ej020tst; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ej020tst"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712085501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FS2f4mgZsHbzo9qDe3j80t4rjcsETjmiaAttXsdBIcc=;
	b=Ej020tstHRItk2poOCYEN3IRbSBUMeUYVSl6YGoijdTc+DkiqkpekIcSJp9og3lneTMOaH
	m4lC/h/F9vycSNYsPjEi38Nf1Z7aiQ5BLQymeB2hGOXyw+2t7NqqByMH7tMAmJ3/j3fcxf
	uY7cE99hfl3y/js7K0RHnxkVh+EANyo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-8lL9yPevOuKTiwBbpZ6DOQ-1; Tue, 02 Apr 2024 15:18:19 -0400
X-MC-Unique: 8lL9yPevOuKTiwBbpZ6DOQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9E352185A782
	for <gfs2@lists.linux.dev>; Tue,  2 Apr 2024 19:18:18 +0000 (UTC)
Received: from fs-i40c-03.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 95E6240C6DAE;
	Tue,  2 Apr 2024 19:18:18 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCHv4 dlm/next 08/15] dlm: drop holding waiters mutex in waiters recovery
Date: Tue,  2 Apr 2024 15:18:03 -0400
Message-ID: <20240402191810.1932939-9-aahringo@redhat.com>
In-Reply-To: <20240402191810.1932939-1-aahringo@redhat.com>
References: <20240402191810.1932939-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

This patch drops to hold the ls_waiters_mutex in
dlm_recover_waiters_pre(). The dlm_recover_waiters_pre() function is
only being called when recovery handling is being done for the specific
lockspace. During this time there can't be new lock requests initiated
or dlm messages being processed that manipulates the lockspace waiters
list.

Only debugfs can access the lockspace waiters list when
dlm_recover_waiters_pre() may manipulates it. This is not possible
anymore because debugfs will hold the recovery lock when it's acccessing
the waiters list.

A check was introduced in remove_from_waiters_ms() for local dlm
messaging to check if really the lockspace is stopped and no new lock
requests can be initiated.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/debug_fs.c | 13 +++++++++++++
 fs/dlm/lock.c     | 17 +++++++++--------
 fs/dlm/lock.h     |  1 +
 3 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/fs/dlm/debug_fs.c b/fs/dlm/debug_fs.c
index 19cdedd56629..c238a9308323 100644
--- a/fs/dlm/debug_fs.c
+++ b/fs/dlm/debug_fs.c
@@ -737,6 +737,12 @@ static ssize_t waiters_read(struct file *file, char __user *userbuf,
 	size_t len = DLM_DEBUG_BUF_LEN, pos = 0, ret, rv;
 
 	mutex_lock(&debug_buf_lock);
+	ret = dlm_lock_recovery_try(ls);
+	if (!ret) {
+		rv = -EAGAIN;
+		goto out;
+	}
+
 	mutex_lock(&ls->ls_waiters_mutex);
 	memset(debug_buf, 0, sizeof(debug_buf));
 
@@ -749,8 +755,10 @@ static ssize_t waiters_read(struct file *file, char __user *userbuf,
 		pos += ret;
 	}
 	mutex_unlock(&ls->ls_waiters_mutex);
+	dlm_unlock_recovery(ls);
 
 	rv = simple_read_from_buffer(userbuf, count, ppos, debug_buf, pos);
+out:
 	mutex_unlock(&debug_buf_lock);
 	return rv;
 }
@@ -772,7 +780,12 @@ static ssize_t waiters_write(struct file *file, const char __user *user_buf,
 	if (n != 3)
 		return -EINVAL;
 
+	error = dlm_lock_recovery_try(ls);
+	if (!error)
+		return -EAGAIN;
+
 	error = dlm_debug_add_lkb_to_waiters(ls, lkb_id, mstype, to_nodeid);
+	dlm_unlock_recovery(ls);
 	if (error)
 		return error;
 
diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index 43a2f4d0af53..395b904a82f4 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -201,7 +201,7 @@ void dlm_dump_rsb(struct dlm_rsb *r)
 
 /* Threads cannot use the lockspace while it's being recovered */
 
-static inline void dlm_lock_recovery(struct dlm_ls *ls)
+void dlm_lock_recovery(struct dlm_ls *ls)
 {
 	down_read(&ls->ls_in_recovery);
 }
@@ -1556,7 +1556,11 @@ static int remove_from_waiters(struct dlm_lkb *lkb, int mstype)
 }
 
 /* Handles situations where we might be processing a "fake" or "local" reply in
-   which we can't try to take waiters_mutex again. */
+ * the recovery context which stops any locking activity. Only debugfs might
+ * change the lockspace waiters but they will held the recovery lock to ensure
+ * remove_from_waiters_ms() in local case will be the only user manipulating the
+ * lockspace waiters in recovery context.
+ */
 
 static int remove_from_waiters_ms(struct dlm_lkb *lkb,
 				  const struct dlm_message *ms, bool local)
@@ -1566,6 +1570,9 @@ static int remove_from_waiters_ms(struct dlm_lkb *lkb,
 
 	if (!local)
 		mutex_lock(&ls->ls_waiters_mutex);
+	else
+		WARN_ON_ONCE(!rwsem_is_locked(&ls->ls_in_recovery) ||
+			     !dlm_locking_stopped(ls));
 	error = _remove_from_waiters(lkb, le32_to_cpu(ms->m_type), ms);
 	if (!local)
 		mutex_unlock(&ls->ls_waiters_mutex);
@@ -4398,7 +4405,6 @@ static void _receive_convert_reply(struct dlm_lkb *lkb,
 	if (error)
 		goto out;
 
-	/* local reply can happen with waiters_mutex held */
 	error = remove_from_waiters_ms(lkb, ms, local);
 	if (error)
 		goto out;
@@ -4437,7 +4443,6 @@ static void _receive_unlock_reply(struct dlm_lkb *lkb,
 	if (error)
 		goto out;
 
-	/* local reply can happen with waiters_mutex held */
 	error = remove_from_waiters_ms(lkb, ms, local);
 	if (error)
 		goto out;
@@ -4489,7 +4494,6 @@ static void _receive_cancel_reply(struct dlm_lkb *lkb,
 	if (error)
 		goto out;
 
-	/* local reply can happen with waiters_mutex held */
 	error = remove_from_waiters_ms(lkb, ms, local);
 	if (error)
 		goto out;
@@ -4890,8 +4894,6 @@ void dlm_recover_waiters_pre(struct dlm_ls *ls)
 	if (!ms_local)
 		return;
 
-	mutex_lock(&ls->ls_waiters_mutex);
-
 	list_for_each_entry_safe(lkb, safe, &ls->ls_waiters, lkb_wait_reply) {
 
 		dir_nodeid = dlm_dir_nodeid(lkb->lkb_resource);
@@ -4984,7 +4986,6 @@ void dlm_recover_waiters_pre(struct dlm_ls *ls)
 		}
 		schedule();
 	}
-	mutex_unlock(&ls->ls_waiters_mutex);
 	kfree(ms_local);
 }
 
diff --git a/fs/dlm/lock.h b/fs/dlm/lock.h
index c8ff7780d3cc..b2fd74a2f8eb 100644
--- a/fs/dlm/lock.h
+++ b/fs/dlm/lock.h
@@ -23,6 +23,7 @@ void dlm_hold_rsb(struct dlm_rsb *r);
 int dlm_put_lkb(struct dlm_lkb *lkb);
 void dlm_scan_rsbs(struct dlm_ls *ls);
 int dlm_lock_recovery_try(struct dlm_ls *ls);
+void dlm_lock_recovery(struct dlm_ls *ls);
 void dlm_unlock_recovery(struct dlm_ls *ls);
 
 int dlm_master_lookup(struct dlm_ls *ls, int from_nodeid, const char *name,
-- 
2.43.0

