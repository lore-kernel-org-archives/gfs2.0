Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7613136D
	for <gfs2@lists.linux.dev>; Wed, 25 Oct 2023 00:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iN/SqDeh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698195240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MnzWiGGPNVDLKbfxnTF16kQYaPzCyHLUIkpfaEjayzc=;
	b=iN/SqDehwnJbnBgkURoWxAmBhJRyQrXUGeog3RWOtz1do3lsZo6zWSteS9pv2qFdVtsda1
	SgmctbpHEU5gLCkiqI8bc6gZYrlhJyQd/NX4mtoe45wYWGHTAr2AMrFa58RqfCyDdSGTQQ
	ypq9m4+9Knk0VF61mUmhysxoDsrrIwU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-BfOHekN4MUixYwMEK6iaAQ-1; Tue, 24 Oct 2023 20:53:59 -0400
X-MC-Unique: BfOHekN4MUixYwMEK6iaAQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CD0D885CBE4
	for <gfs2@lists.linux.dev>; Wed, 25 Oct 2023 00:53:58 +0000 (UTC)
Received: from fs-i40c-03.fs.lab.eng.bos.redhat.com (fs-i40c-03.fast.rdu2.eng.redhat.com [10.6.23.54])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C5F4940C6F7B;
	Wed, 25 Oct 2023 00:53:58 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCH dlm/next 04/10] dlm: drop holding waiters mutex in waiters recovery
Date: Tue, 24 Oct 2023 20:53:47 -0400
Message-Id: <20231025005353.855904-4-aahringo@redhat.com>
In-Reply-To: <20231025005353.855904-1-aahringo@redhat.com>
References: <20231025005353.855904-1-aahringo@redhat.com>
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
 fs/dlm/debug_fs.c |  4 ++++
 fs/dlm/lock.c     | 17 +++++++++--------
 fs/dlm/lock.h     |  1 +
 3 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/fs/dlm/debug_fs.c b/fs/dlm/debug_fs.c
index 42f332f46359..1ef59f7223a6 100644
--- a/fs/dlm/debug_fs.c
+++ b/fs/dlm/debug_fs.c
@@ -823,6 +823,7 @@ static ssize_t waiters_read(struct file *file, char __user *userbuf,
 	size_t len = DLM_DEBUG_BUF_LEN, pos = 0, ret, rv;
 
 	mutex_lock(&debug_buf_lock);
+	dlm_lock_recovery(ls);
 	mutex_lock(&ls->ls_waiters_mutex);
 	memset(debug_buf, 0, sizeof(debug_buf));
 
@@ -835,6 +836,7 @@ static ssize_t waiters_read(struct file *file, char __user *userbuf,
 		pos += ret;
 	}
 	mutex_unlock(&ls->ls_waiters_mutex);
+	dlm_unlock_recovery(ls);
 
 	rv = simple_read_from_buffer(userbuf, count, ppos, debug_buf, pos);
 	mutex_unlock(&debug_buf_lock);
@@ -858,7 +860,9 @@ static ssize_t waiters_write(struct file *file, const char __user *user_buf,
 	if (n != 3)
 		return -EINVAL;
 
+	dlm_lock_recovery(ls);
 	error = dlm_debug_add_lkb_to_waiters(ls, lkb_id, mstype, to_nodeid);
+	dlm_unlock_recovery(ls);
 	if (error)
 		return error;
 
diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index 0218645e2f90..79f1f741af13 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -201,7 +201,7 @@ void dlm_dump_rsb(struct dlm_rsb *r)
 
 /* Threads cannot use the lockspace while it's being recovered */
 
-static inline void dlm_lock_recovery(struct dlm_ls *ls)
+void dlm_lock_recovery(struct dlm_ls *ls)
 {
 	down_read(&ls->ls_in_recovery);
 }
@@ -1553,7 +1553,11 @@ static int remove_from_waiters(struct dlm_lkb *lkb, int mstype)
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
@@ -1563,6 +1567,9 @@ static int remove_from_waiters_ms(struct dlm_lkb *lkb,
 
 	if (!local)
 		mutex_lock(&ls->ls_waiters_mutex);
+	else
+		WARN_ON_ONCE(!rwsem_is_locked(&ls->ls_in_recovery) ||
+			     !dlm_locking_stopped(ls));
 	error = _remove_from_waiters(lkb, le32_to_cpu(ms->m_type), ms);
 	if (!local)
 		mutex_unlock(&ls->ls_waiters_mutex);
@@ -4395,7 +4402,6 @@ static void _receive_convert_reply(struct dlm_lkb *lkb,
 	if (error)
 		goto out;
 
-	/* local reply can happen with waiters_mutex held */
 	error = remove_from_waiters_ms(lkb, ms, local);
 	if (error)
 		goto out;
@@ -4434,7 +4440,6 @@ static void _receive_unlock_reply(struct dlm_lkb *lkb,
 	if (error)
 		goto out;
 
-	/* local reply can happen with waiters_mutex held */
 	error = remove_from_waiters_ms(lkb, ms, local);
 	if (error)
 		goto out;
@@ -4486,7 +4491,6 @@ static void _receive_cancel_reply(struct dlm_lkb *lkb,
 	if (error)
 		goto out;
 
-	/* local reply can happen with waiters_mutex held */
 	error = remove_from_waiters_ms(lkb, ms, local);
 	if (error)
 		goto out;
@@ -4887,8 +4891,6 @@ void dlm_recover_waiters_pre(struct dlm_ls *ls)
 	if (!ms_local)
 		return;
 
-	mutex_lock(&ls->ls_waiters_mutex);
-
 	list_for_each_entry_safe(lkb, safe, &ls->ls_waiters, lkb_wait_reply) {
 
 		dir_nodeid = dlm_dir_nodeid(lkb->lkb_resource);
@@ -4981,7 +4983,6 @@ void dlm_recover_waiters_pre(struct dlm_ls *ls)
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
2.39.3

