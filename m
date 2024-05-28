Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBF117B414
	for <gfs2@lists.linux.dev>; Tue, 28 May 2024 21:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716930771; cv=none; b=t/AMvurNnORS25m7tJJTI/UAXR4bBDgzEb9oKRZbfl4O4IwxdfM6xLBuRMifzmH8K18z6pYynmAi20IorqB/hUwYOxbeFKYamAqbx7gjYK6BChPpO2t4a9V6Z+7aZHVvc+8oqiB/3SZDb3UdJUfCSkZoOsy4IDDLHugt2u7tb4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716930771; c=relaxed/simple;
	bh=1+hovymsvZOWij4Wql8wmNKiiOKYtvfXnaBGHvUXJtU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TV7uXMxdFuGZB0jHofPwrrUu3f0F2Q2cFgvyLKorf8I8c4MbsjAx/9FGYXV+kbjdPaiukZSE2hsLruIw0j2IJNcRA0DrNMbb4Q8o+UgAqhAvGvffvuIhDJ8ftFMKqaZXIyp2G4dsv3yYY1WYXtTc9LYLeKDC+idgysk3URGC2X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GejqkH6u; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GejqkH6u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716930768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VLUw73f4Cy5kDZ3hFCmUP5HnO8MBK93YhOi5mQg/rOY=;
	b=GejqkH6uhjynGyGCMGanvF3JgrPK39sGPYDatM4r2Itm3BoT5JwS1HjLowoWTgNKxO6ui1
	UOlJgswSaJ4OvuSMUj4N9F2qmNFgHM/rzaCAOTa7w8iMexigpOhCD0U/m0NTqZ1gZ2zGjq
	F9Jga1QN6BHrR6z/mcRt174J/ZBFaLE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-nF-LFmXsNhKFvGI5iyH-Qw-1; Tue, 28 May 2024 17:12:47 -0400
X-MC-Unique: nF-LFmXsNhKFvGI5iyH-Qw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 216BE85A58C
	for <gfs2@lists.linux.dev>; Tue, 28 May 2024 21:12:47 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 17096200B4D8;
	Tue, 28 May 2024 21:12:47 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCH v6.10-rc1 08/11] dlm: move lkb idr to xarray datastructure
Date: Tue, 28 May 2024 17:12:38 -0400
Message-ID: <20240528211241.2140441-8-aahringo@redhat.com>
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

According to kernel doc idr is deprecated and xarrays should be used
nowadays. This patch is moving the lkb idr implementation to xarrays.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/dlm_internal.h |  5 ++--
 fs/dlm/lock.c         | 30 ++++++++++++----------
 fs/dlm/lockspace.c    | 60 +++++++++++++++++++++----------------------
 3 files changed, 49 insertions(+), 46 deletions(-)

diff --git a/fs/dlm/dlm_internal.h b/fs/dlm/dlm_internal.h
index 5acdc6c2b4b8..3a62675bf52e 100644
--- a/fs/dlm/dlm_internal.h
+++ b/fs/dlm/dlm_internal.h
@@ -37,6 +37,7 @@
 #include <linux/rhashtable.h>
 #include <linux/mutex.h>
 #include <linux/idr.h>
+#include <linux/xarray.h>
 #include <linux/ratelimit.h>
 #include <linux/uaccess.h>
 
@@ -571,8 +572,8 @@ struct dlm_ls {
 	unsigned long		ls_flags;	/* LSFL_ */
 	struct kobject		ls_kobj;
 
-	struct idr		ls_lkbidr;
-	rwlock_t		ls_lkbidr_lock;
+	struct xarray		ls_lkbxa;
+	rwlock_t		ls_lkbxa_lock;
 
 	struct rhashtable	ls_rsbtbl;
 	rwlock_t		ls_rsbtbl_lock;
diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index 69a25ec82d1e..e176cf48011a 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -1460,11 +1460,15 @@ static void detach_lkb(struct dlm_lkb *lkb)
 }
 
 static int _create_lkb(struct dlm_ls *ls, struct dlm_lkb **lkb_ret,
-		       int start, int end)
+		       unsigned long start, unsigned long end)
 {
+	struct xa_limit limit;
 	struct dlm_lkb *lkb;
 	int rv;
 
+	limit.max = end;
+	limit.min = start;
+
 	lkb = dlm_allocate_lkb(ls);
 	if (!lkb)
 		return -ENOMEM;
@@ -1478,14 +1482,12 @@ static int _create_lkb(struct dlm_ls *ls, struct dlm_lkb **lkb_ret,
 	INIT_LIST_HEAD(&lkb->lkb_ownqueue);
 	INIT_LIST_HEAD(&lkb->lkb_rsb_lookup);
 
-	write_lock_bh(&ls->ls_lkbidr_lock);
-	rv = idr_alloc(&ls->ls_lkbidr, lkb, start, end, GFP_NOWAIT);
-	if (rv >= 0)
-		lkb->lkb_id = rv;
-	write_unlock_bh(&ls->ls_lkbidr_lock);
+	write_lock_bh(&ls->ls_lkbxa_lock);
+	rv = xa_alloc(&ls->ls_lkbxa, &lkb->lkb_id, lkb, limit, GFP_ATOMIC);
+	write_unlock_bh(&ls->ls_lkbxa_lock);
 
 	if (rv < 0) {
-		log_error(ls, "create_lkb idr error %d", rv);
+		log_error(ls, "create_lkb xa error %d", rv);
 		dlm_free_lkb(lkb);
 		return rv;
 	}
@@ -1496,18 +1498,18 @@ static int _create_lkb(struct dlm_ls *ls, struct dlm_lkb **lkb_ret,
 
 static int create_lkb(struct dlm_ls *ls, struct dlm_lkb **lkb_ret)
 {
-	return _create_lkb(ls, lkb_ret, 1, 0);
+	return _create_lkb(ls, lkb_ret, 1, ULONG_MAX);
 }
 
 static int find_lkb(struct dlm_ls *ls, uint32_t lkid, struct dlm_lkb **lkb_ret)
 {
 	struct dlm_lkb *lkb;
 
-	read_lock_bh(&ls->ls_lkbidr_lock);
-	lkb = idr_find(&ls->ls_lkbidr, lkid);
+	read_lock_bh(&ls->ls_lkbxa_lock);
+	lkb = xa_load(&ls->ls_lkbxa, lkid);
 	if (lkb)
 		kref_get(&lkb->lkb_ref);
-	read_unlock_bh(&ls->ls_lkbidr_lock);
+	read_unlock_bh(&ls->ls_lkbxa_lock);
 
 	*lkb_ret = lkb;
 	return lkb ? 0 : -ENOENT;
@@ -1532,10 +1534,10 @@ static int __put_lkb(struct dlm_ls *ls, struct dlm_lkb *lkb)
 	int rv;
 
 	rv = dlm_kref_put_write_lock_bh(&lkb->lkb_ref, kill_lkb,
-					&ls->ls_lkbidr_lock);
+					&ls->ls_lkbxa_lock);
 	if (rv) {
-		idr_remove(&ls->ls_lkbidr, lkid);
-		write_unlock_bh(&ls->ls_lkbidr_lock);
+		xa_erase(&ls->ls_lkbxa, lkid);
+		write_unlock_bh(&ls->ls_lkbxa_lock);
 
 		detach_lkb(lkb);
 
diff --git a/fs/dlm/lockspace.c b/fs/dlm/lockspace.c
index ecb9b5fcad8e..a1aefe804727 100644
--- a/fs/dlm/lockspace.c
+++ b/fs/dlm/lockspace.c
@@ -420,8 +420,8 @@ static int new_lockspace(const char *name, const char *cluster,
 	if (error)
 		goto out_lsfree;
 
-	idr_init(&ls->ls_lkbidr);
-	rwlock_init(&ls->ls_lkbidr_lock);
+	xa_init_flags(&ls->ls_lkbxa, XA_FLAGS_ALLOC | XA_FLAGS_LOCK_BH);
+	rwlock_init(&ls->ls_lkbxa_lock);
 
 	INIT_LIST_HEAD(&ls->ls_waiters);
 	spin_lock_init(&ls->ls_waiters_lock);
@@ -471,7 +471,7 @@ static int new_lockspace(const char *name, const char *cluster,
 	ls->ls_recover_buf = kmalloc(DLM_MAX_SOCKET_BUFSIZE, GFP_NOFS);
 	if (!ls->ls_recover_buf) {
 		error = -ENOMEM;
-		goto out_lkbidr;
+		goto out_lkbxa;
 	}
 
 	ls->ls_slot = 0;
@@ -572,8 +572,8 @@ static int new_lockspace(const char *name, const char *cluster,
 	spin_unlock_bh(&lslist_lock);
 	idr_destroy(&ls->ls_recover_idr);
 	kfree(ls->ls_recover_buf);
- out_lkbidr:
-	idr_destroy(&ls->ls_lkbidr);
+ out_lkbxa:
+	xa_destroy(&ls->ls_lkbxa);
 	rhashtable_destroy(&ls->ls_rsbtbl);
  out_lsfree:
 	if (do_unreg)
@@ -633,22 +633,8 @@ int dlm_new_user_lockspace(const char *name, const char *cluster,
 				   ops_arg, ops_result, lockspace);
 }
 
-static int lkb_idr_is_local(int id, void *p, void *data)
+static int lkb_idr_free(struct dlm_lkb *lkb)
 {
-	struct dlm_lkb *lkb = p;
-
-	return lkb->lkb_nodeid == 0 && lkb->lkb_grmode != DLM_LOCK_IV;
-}
-
-static int lkb_idr_is_any(int id, void *p, void *data)
-{
-	return 1;
-}
-
-static int lkb_idr_free(int id, void *p, void *data)
-{
-	struct dlm_lkb *lkb = p;
-
 	if (lkb->lkb_lvbptr && test_bit(DLM_IFL_MSTCPY_BIT, &lkb->lkb_iflags))
 		dlm_free_lvb(lkb->lkb_lvbptr);
 
@@ -656,23 +642,34 @@ static int lkb_idr_free(int id, void *p, void *data)
 	return 0;
 }
 
-/* NOTE: We check the lkbidr here rather than the resource table.
+/* NOTE: We check the lkbxa here rather than the resource table.
    This is because there may be LKBs queued as ASTs that have been unlinked
    from their RSBs and are pending deletion once the AST has been delivered */
 
 static int lockspace_busy(struct dlm_ls *ls, int force)
 {
-	int rv;
+	struct dlm_lkb *lkb;
+	unsigned long id;
+	int rv = 0;
 
-	read_lock_bh(&ls->ls_lkbidr_lock);
+	read_lock_bh(&ls->ls_lkbxa_lock);
 	if (force == 0) {
-		rv = idr_for_each(&ls->ls_lkbidr, lkb_idr_is_any, ls);
+		xa_for_each(&ls->ls_lkbxa, id, lkb) {
+			rv = 1;
+			break;
+		}
 	} else if (force == 1) {
-		rv = idr_for_each(&ls->ls_lkbidr, lkb_idr_is_local, ls);
+		xa_for_each(&ls->ls_lkbxa, id, lkb) {
+			if (lkb->lkb_nodeid == 0 &&
+			    lkb->lkb_grmode != DLM_LOCK_IV) {
+				rv = 1;
+				break;
+			}
+		}
 	} else {
 		rv = 0;
 	}
-	read_unlock_bh(&ls->ls_lkbidr_lock);
+	read_unlock_bh(&ls->ls_lkbxa_lock);
 	return rv;
 }
 
@@ -685,6 +682,8 @@ static void rhash_free_rsb(void *ptr, void *arg)
 
 static int release_lockspace(struct dlm_ls *ls, int force)
 {
+	struct dlm_lkb *lkb;
+	unsigned long id;
 	int busy, rv;
 
 	busy = lockspace_busy(ls, force);
@@ -741,11 +740,12 @@ static int release_lockspace(struct dlm_ls *ls, int force)
 	kfree(ls->ls_recover_buf);
 
 	/*
-	 * Free all lkb's in idr
+	 * Free all lkb's in xa
 	 */
-
-	idr_for_each(&ls->ls_lkbidr, lkb_idr_free, ls);
-	idr_destroy(&ls->ls_lkbidr);
+	xa_for_each(&ls->ls_lkbxa, id, lkb) {
+		lkb_idr_free(lkb);
+	}
+	xa_destroy(&ls->ls_lkbxa);
 
 	/*
 	 * Free all rsb's on rsbtbl
-- 
2.43.0

