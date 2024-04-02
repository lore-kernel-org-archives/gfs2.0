Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05AC215B57D
	for <gfs2@lists.linux.dev>; Tue,  2 Apr 2024 19:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712085504; cv=none; b=PzPdctofIg8SbvmheFj1656nSZL1uAtfDDwUnCcoDLcxeEl8gc5gF4nR19yfV5pao+xlRYDWsU9gJ5fKFaxe6MUmf3X4VOyH9zZd2zNs76baUM6NiqYl4D9QFTH/3SOAWM6a/X5d3GmNW2JpEK4Ime4qWAs2QJUw8clx2ck3d0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712085504; c=relaxed/simple;
	bh=4sNqnVA4B51RiUxbJspgkGzMZqR9i7wDAh4ttYrLSpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TCsyL/EPyed4XIOl/H5JLWAZOE6Xwjt78qGr41oGEQYA19o4w+njnLSHNOvyRiMExLkEqH3hvOQyA9whxevhdiv2zgaL3sagjN0iYYDbSzX0/4QgtXyKSwIJ0fV0vNCuzasPrBbn5XCzpk4SmrfewWVTSnodVRfKRDod3F7gU3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XA2ayhsN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XA2ayhsN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712085500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KwLH2nMgwrYGbA2a/Uv/xRdbQBy0JzUxgEC4qA9VUE4=;
	b=XA2ayhsNy2wbnCOqBcsTRGndKQxkWCLXpv96RsW1X6mtWrvE2XdIIcIe1KFNPJmhmDdOgJ
	Ri7UkT41k/qNUmizpi3CzRMGjqVRdD9aA+cWVqdSZsb+DNJjbUtCH/rWLJOhEP+WMh1HdL
	rUsNhqLYj3/IfNGyfb/JycGdnEWMpg0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-Eo_OMhb5MXKSA3Ep3suZ_g-1; Tue, 02 Apr 2024 15:18:18 -0400
X-MC-Unique: Eo_OMhb5MXKSA3Ep3suZ_g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A61EE862F79
	for <gfs2@lists.linux.dev>; Tue,  2 Apr 2024 19:18:18 +0000 (UTC)
Received: from fs-i40c-03.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9DC3E40C6DB3;
	Tue,  2 Apr 2024 19:18:18 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCHv4 dlm/next 09/15] dlm: convert ls_waiters_mutex to spinlock
Date: Tue,  2 Apr 2024 15:18:04 -0400
Message-ID: <20240402191810.1932939-10-aahringo@redhat.com>
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

This patch converts the per dlm lockspace waiters lock from a mutex to a
spinlock. To prepare switching to a softirq context when parsing DLM
messages.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/debug_fs.c     |  4 ++--
 fs/dlm/dlm_internal.h |  2 +-
 fs/dlm/lock.c         | 20 ++++++++++----------
 fs/dlm/lockspace.c    |  2 +-
 4 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/fs/dlm/debug_fs.c b/fs/dlm/debug_fs.c
index c238a9308323..487dcf05d076 100644
--- a/fs/dlm/debug_fs.c
+++ b/fs/dlm/debug_fs.c
@@ -743,7 +743,7 @@ static ssize_t waiters_read(struct file *file, char __user *userbuf,
 		goto out;
 	}
 
-	mutex_lock(&ls->ls_waiters_mutex);
+	spin_lock(&ls->ls_waiters_lock);
 	memset(debug_buf, 0, sizeof(debug_buf));
 
 	list_for_each_entry(lkb, &ls->ls_waiters, lkb_wait_reply) {
@@ -754,7 +754,7 @@ static ssize_t waiters_read(struct file *file, char __user *userbuf,
 			break;
 		pos += ret;
 	}
-	mutex_unlock(&ls->ls_waiters_mutex);
+	spin_unlock(&ls->ls_waiters_lock);
 	dlm_unlock_recovery(ls);
 
 	rv = simple_read_from_buffer(userbuf, count, ppos, debug_buf, pos);
diff --git a/fs/dlm/dlm_internal.h b/fs/dlm/dlm_internal.h
index e03a379832d5..98029fd5cd2b 100644
--- a/fs/dlm/dlm_internal.h
+++ b/fs/dlm/dlm_internal.h
@@ -595,7 +595,7 @@ struct dlm_ls {
 	struct dlm_rsbtable	*ls_rsbtbl;
 	uint32_t		ls_rsbtbl_size;
 
-	struct mutex		ls_waiters_mutex;
+	spinlock_t		ls_waiters_lock;
 	struct list_head	ls_waiters;	/* lkbs needing a reply */
 
 	struct mutex		ls_orphans_mutex;
diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index 395b904a82f4..af677add4f5f 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -1406,7 +1406,7 @@ static int add_to_waiters(struct dlm_lkb *lkb, int mstype, int to_nodeid)
 	struct dlm_ls *ls = lkb->lkb_resource->res_ls;
 	int error = 0;
 
-	mutex_lock(&ls->ls_waiters_mutex);
+	spin_lock(&ls->ls_waiters_lock);
 
 	if (is_overlap_unlock(lkb) ||
 	    (is_overlap_cancel(lkb) && (mstype == DLM_MSG_CANCEL))) {
@@ -1449,7 +1449,7 @@ static int add_to_waiters(struct dlm_lkb *lkb, int mstype, int to_nodeid)
 		log_error(ls, "addwait error %x %d flags %x %d %d %s",
 			  lkb->lkb_id, error, dlm_iflags_val(lkb), mstype,
 			  lkb->lkb_wait_type, lkb->lkb_resource->res_name);
-	mutex_unlock(&ls->ls_waiters_mutex);
+	spin_unlock(&ls->ls_waiters_lock);
 	return error;
 }
 
@@ -1549,9 +1549,9 @@ static int remove_from_waiters(struct dlm_lkb *lkb, int mstype)
 	struct dlm_ls *ls = lkb->lkb_resource->res_ls;
 	int error;
 
-	mutex_lock(&ls->ls_waiters_mutex);
+	spin_lock(&ls->ls_waiters_lock);
 	error = _remove_from_waiters(lkb, mstype, NULL);
-	mutex_unlock(&ls->ls_waiters_mutex);
+	spin_unlock(&ls->ls_waiters_lock);
 	return error;
 }
 
@@ -1569,13 +1569,13 @@ static int remove_from_waiters_ms(struct dlm_lkb *lkb,
 	int error;
 
 	if (!local)
-		mutex_lock(&ls->ls_waiters_mutex);
+		spin_lock(&ls->ls_waiters_lock);
 	else
 		WARN_ON_ONCE(!rwsem_is_locked(&ls->ls_in_recovery) ||
 			     !dlm_locking_stopped(ls));
 	error = _remove_from_waiters(lkb, le32_to_cpu(ms->m_type), ms);
 	if (!local)
-		mutex_unlock(&ls->ls_waiters_mutex);
+		spin_unlock(&ls->ls_waiters_lock);
 	return error;
 }
 
@@ -4993,7 +4993,7 @@ static struct dlm_lkb *find_resend_waiter(struct dlm_ls *ls)
 {
 	struct dlm_lkb *lkb = NULL, *iter;
 
-	mutex_lock(&ls->ls_waiters_mutex);
+	spin_lock(&ls->ls_waiters_lock);
 	list_for_each_entry(iter, &ls->ls_waiters, lkb_wait_reply) {
 		if (test_bit(DLM_IFL_RESEND_BIT, &iter->lkb_iflags)) {
 			hold_lkb(iter);
@@ -5001,7 +5001,7 @@ static struct dlm_lkb *find_resend_waiter(struct dlm_ls *ls)
 			break;
 		}
 	}
-	mutex_unlock(&ls->ls_waiters_mutex);
+	spin_unlock(&ls->ls_waiters_lock);
 
 	return lkb;
 }
@@ -5101,9 +5101,9 @@ int dlm_recover_waiters_post(struct dlm_ls *ls)
 		}
 
 		/* Forcibly remove from waiters list */
-		mutex_lock(&ls->ls_waiters_mutex);
+		spin_lock(&ls->ls_waiters_lock);
 		list_del_init(&lkb->lkb_wait_reply);
-		mutex_unlock(&ls->ls_waiters_mutex);
+		spin_unlock(&ls->ls_waiters_lock);
 
 		/*
 		 * The lkb is now clear of all prior waiters state and can be
diff --git a/fs/dlm/lockspace.c b/fs/dlm/lockspace.c
index af7769f8e38c..945139805605 100644
--- a/fs/dlm/lockspace.c
+++ b/fs/dlm/lockspace.c
@@ -515,7 +515,7 @@ static int new_lockspace(const char *name, const char *cluster,
 	spin_lock_init(&ls->ls_lkbidr_spin);
 
 	INIT_LIST_HEAD(&ls->ls_waiters);
-	mutex_init(&ls->ls_waiters_mutex);
+	spin_lock_init(&ls->ls_waiters_lock);
 	INIT_LIST_HEAD(&ls->ls_orphans);
 	mutex_init(&ls->ls_orphans_mutex);
 
-- 
2.43.0

