Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DE817B41A
	for <gfs2@lists.linux.dev>; Tue, 28 May 2024 21:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716930771; cv=none; b=H5o8V9eLTFHBsZZQLZAysTedPGu01yJr9YXqJuXeEmWQhah26Vt4tVJR9Bl134s0FokNHMVG8pPlMAstcDmfoH2Fe5svpWpjQnFJSvRVi9dCY/cWoL/fuQeKfrS7RLRWYKoKXTRER+fzVmc6jVC7PkNKnPOTcUY6MdUgQ25hSL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716930771; c=relaxed/simple;
	bh=3Y6dYwxu3zghjz7gE/RgzFarLWrIqam+YTRzq8hQLs0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JiqEqtSrjGwrs94N7gXElvWh+5wq6prst6hRYmGprXReHWC2WtyVdULCKSwsXTzGf9iUuhexHEeu7lorh8+OwEdGcQO6U3k+M24NHU+U+j4QWScO6LWSSEV53R/pQn0YPnrBsucXIZjAf2zurHqVciGR+XU5i/IxZanP5cxsYY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EtqcHb26; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EtqcHb26"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716930768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QB7z6uL+VSl+R85YOuBQ8kbK/1JU95ItG2g7knZqwaU=;
	b=EtqcHb26Warit/t3qcVvSxzbVp70IrWU/yxMI9w/jBe4fcEd3LUE8bTM8dHCF912OObiCt
	997M1nIM+5mEUzHRkmNA+bOHgviRg+VF8tCtegXT7U2W1P0osP4Ta7lwUrJbzD56EO7B4O
	auMUgUUwhcW0RByo3AmSK/HieskAAus=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-411-GMYQLqWQP_uB_Ydq3ToYbg-1; Tue,
 28 May 2024 17:12:47 -0400
X-MC-Unique: GMYQLqWQP_uB_Ydq3ToYbg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2A01C29AA384
	for <gfs2@lists.linux.dev>; Tue, 28 May 2024 21:12:47 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2080F200A381;
	Tue, 28 May 2024 21:12:47 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCH v6.10-rc1 09/11] dlm: move recover idr to xarray datastructure
Date: Tue, 28 May 2024 17:12:39 -0400
Message-ID: <20240528211241.2140441-9-aahringo@redhat.com>
In-Reply-To: <20240528211241.2140441-1-aahringo@redhat.com>
References: <20240528211241.2140441-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

According to kdoc idr is deprecated and xarrays should be used nowadays.
This patch is moving the recover idr implementation to xarray
datastructure.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/dlm_internal.h |  7 +++--
 fs/dlm/lockspace.c    |  8 +++---
 fs/dlm/recover.c      | 61 +++++++++++++++++++++++--------------------
 3 files changed, 40 insertions(+), 36 deletions(-)

diff --git a/fs/dlm/dlm_internal.h b/fs/dlm/dlm_internal.h
index 3a62675bf52e..78960d914f68 100644
--- a/fs/dlm/dlm_internal.h
+++ b/fs/dlm/dlm_internal.h
@@ -36,7 +36,6 @@
 #include <linux/miscdevice.h>
 #include <linux/rhashtable.h>
 #include <linux/mutex.h>
-#include <linux/idr.h>
 #include <linux/xarray.h>
 #include <linux/ratelimit.h>
 #include <linux/uaccess.h>
@@ -317,7 +316,7 @@ struct dlm_rsb {
 	int			res_nodeid;
 	int			res_master_nodeid;
 	int			res_dir_nodeid;
-	int			res_id;		/* for ls_recover_idr */
+	unsigned long		res_id;		/* for ls_recover_xa */
 	uint32_t                res_lvbseq;
 	uint32_t		res_hash;
 	unsigned long		res_toss_time;
@@ -651,8 +650,8 @@ struct dlm_ls {
 	struct list_head	ls_recover_list;
 	spinlock_t		ls_recover_list_lock;
 	int			ls_recover_list_count;
-	struct idr		ls_recover_idr;
-	spinlock_t		ls_recover_idr_lock;
+	struct xarray		ls_recover_xa;
+	spinlock_t		ls_recover_xa_lock;
 	wait_queue_head_t	ls_wait_general;
 	wait_queue_head_t	ls_recover_lock_wait;
 	spinlock_t		ls_clear_proc_locks;
diff --git a/fs/dlm/lockspace.c b/fs/dlm/lockspace.c
index a1aefe804727..9c3118a698d6 100644
--- a/fs/dlm/lockspace.c
+++ b/fs/dlm/lockspace.c
@@ -481,8 +481,8 @@ static int new_lockspace(const char *name, const char *cluster,
 
 	INIT_LIST_HEAD(&ls->ls_recover_list);
 	spin_lock_init(&ls->ls_recover_list_lock);
-	idr_init(&ls->ls_recover_idr);
-	spin_lock_init(&ls->ls_recover_idr_lock);
+	xa_init_flags(&ls->ls_recover_xa, XA_FLAGS_ALLOC | XA_FLAGS_LOCK_BH);
+	spin_lock_init(&ls->ls_recover_xa_lock);
 	ls->ls_recover_list_count = 0;
 	init_waitqueue_head(&ls->ls_wait_general);
 	INIT_LIST_HEAD(&ls->ls_masters_list);
@@ -570,7 +570,7 @@ static int new_lockspace(const char *name, const char *cluster,
 	spin_lock_bh(&lslist_lock);
 	list_del(&ls->ls_list);
 	spin_unlock_bh(&lslist_lock);
-	idr_destroy(&ls->ls_recover_idr);
+	xa_destroy(&ls->ls_recover_xa);
 	kfree(ls->ls_recover_buf);
  out_lkbxa:
 	xa_destroy(&ls->ls_lkbxa);
@@ -736,7 +736,7 @@ static int release_lockspace(struct dlm_ls *ls, int force)
 
 	dlm_delete_debug_file(ls);
 
-	idr_destroy(&ls->ls_recover_idr);
+	xa_destroy(&ls->ls_recover_xa);
 	kfree(ls->ls_recover_buf);
 
 	/*
diff --git a/fs/dlm/recover.c b/fs/dlm/recover.c
index f493d5f30c58..d156196b9e69 100644
--- a/fs/dlm/recover.c
+++ b/fs/dlm/recover.c
@@ -293,73 +293,78 @@ static void recover_list_clear(struct dlm_ls *ls)
 	spin_unlock_bh(&ls->ls_recover_list_lock);
 }
 
-static int recover_idr_empty(struct dlm_ls *ls)
+static int recover_xa_empty(struct dlm_ls *ls)
 {
 	int empty = 1;
 
-	spin_lock_bh(&ls->ls_recover_idr_lock);
+	spin_lock_bh(&ls->ls_recover_xa_lock);
 	if (ls->ls_recover_list_count)
 		empty = 0;
-	spin_unlock_bh(&ls->ls_recover_idr_lock);
+	spin_unlock_bh(&ls->ls_recover_xa_lock);
 
 	return empty;
 }
 
-static int recover_idr_add(struct dlm_rsb *r)
+static int recover_xa_add(struct dlm_rsb *r)
 {
 	struct dlm_ls *ls = r->res_ls;
+	struct xa_limit limit = {
+		.min = 1,
+		.max = UINT_MAX,
+	};
+	uint32_t id;
 	int rv;
 
-	spin_lock_bh(&ls->ls_recover_idr_lock);
+	spin_lock_bh(&ls->ls_recover_xa_lock);
 	if (r->res_id) {
 		rv = -1;
 		goto out_unlock;
 	}
-	rv = idr_alloc(&ls->ls_recover_idr, r, 1, 0, GFP_NOWAIT);
+	rv = xa_alloc(&ls->ls_recover_xa, &id, r, limit, GFP_ATOMIC);
 	if (rv < 0)
 		goto out_unlock;
 
-	r->res_id = rv;
+	r->res_id = id;
 	ls->ls_recover_list_count++;
 	dlm_hold_rsb(r);
 	rv = 0;
 out_unlock:
-	spin_unlock_bh(&ls->ls_recover_idr_lock);
+	spin_unlock_bh(&ls->ls_recover_xa_lock);
 	return rv;
 }
 
-static void recover_idr_del(struct dlm_rsb *r)
+static void recover_xa_del(struct dlm_rsb *r)
 {
 	struct dlm_ls *ls = r->res_ls;
 
-	spin_lock_bh(&ls->ls_recover_idr_lock);
-	idr_remove(&ls->ls_recover_idr, r->res_id);
+	spin_lock_bh(&ls->ls_recover_xa_lock);
+	xa_erase_bh(&ls->ls_recover_xa, r->res_id);
 	r->res_id = 0;
 	ls->ls_recover_list_count--;
-	spin_unlock_bh(&ls->ls_recover_idr_lock);
+	spin_unlock_bh(&ls->ls_recover_xa_lock);
 
 	dlm_put_rsb(r);
 }
 
-static struct dlm_rsb *recover_idr_find(struct dlm_ls *ls, uint64_t id)
+static struct dlm_rsb *recover_xa_find(struct dlm_ls *ls, uint64_t id)
 {
 	struct dlm_rsb *r;
 
-	spin_lock_bh(&ls->ls_recover_idr_lock);
-	r = idr_find(&ls->ls_recover_idr, (int)id);
-	spin_unlock_bh(&ls->ls_recover_idr_lock);
+	spin_lock_bh(&ls->ls_recover_xa_lock);
+	r = xa_load(&ls->ls_recover_xa, (int)id);
+	spin_unlock_bh(&ls->ls_recover_xa_lock);
 	return r;
 }
 
-static void recover_idr_clear(struct dlm_ls *ls)
+static void recover_xa_clear(struct dlm_ls *ls)
 {
 	struct dlm_rsb *r;
-	int id;
+	unsigned long id;
 
-	spin_lock_bh(&ls->ls_recover_idr_lock);
+	spin_lock_bh(&ls->ls_recover_xa_lock);
 
-	idr_for_each_entry(&ls->ls_recover_idr, r, id) {
-		idr_remove(&ls->ls_recover_idr, id);
+	xa_for_each(&ls->ls_recover_xa, id, r) {
+		xa_erase_bh(&ls->ls_recover_xa, id);
 		r->res_id = 0;
 		r->res_recover_locks_count = 0;
 		ls->ls_recover_list_count--;
@@ -372,7 +377,7 @@ static void recover_idr_clear(struct dlm_ls *ls)
 			  ls->ls_recover_list_count);
 		ls->ls_recover_list_count = 0;
 	}
-	spin_unlock_bh(&ls->ls_recover_idr_lock);
+	spin_unlock_bh(&ls->ls_recover_xa_lock);
 }
 
 
@@ -470,7 +475,7 @@ static int recover_master(struct dlm_rsb *r, unsigned int *count, uint64_t seq)
 		set_new_master(r);
 		error = 0;
 	} else {
-		recover_idr_add(r);
+		recover_xa_add(r);
 		error = dlm_send_rcom_lookup(r, dir_nodeid, seq);
 	}
 
@@ -551,10 +556,10 @@ int dlm_recover_masters(struct dlm_ls *ls, uint64_t seq,
 
 	log_rinfo(ls, "dlm_recover_masters %u of %u", count, total);
 
-	error = dlm_wait_function(ls, &recover_idr_empty);
+	error = dlm_wait_function(ls, &recover_xa_empty);
  out:
 	if (error)
-		recover_idr_clear(ls);
+		recover_xa_clear(ls);
 	return error;
 }
 
@@ -563,7 +568,7 @@ int dlm_recover_master_reply(struct dlm_ls *ls, const struct dlm_rcom *rc)
 	struct dlm_rsb *r;
 	int ret_nodeid, new_master;
 
-	r = recover_idr_find(ls, le64_to_cpu(rc->rc_id));
+	r = recover_xa_find(ls, le64_to_cpu(rc->rc_id));
 	if (!r) {
 		log_error(ls, "dlm_recover_master_reply no id %llx",
 			  (unsigned long long)le64_to_cpu(rc->rc_id));
@@ -582,9 +587,9 @@ int dlm_recover_master_reply(struct dlm_ls *ls, const struct dlm_rcom *rc)
 	r->res_nodeid = new_master;
 	set_new_master(r);
 	unlock_rsb(r);
-	recover_idr_del(r);
+	recover_xa_del(r);
 
-	if (recover_idr_empty(ls))
+	if (recover_xa_empty(ls))
 		wake_up(&ls->ls_wait_general);
  out:
 	return 0;
-- 
2.43.0

