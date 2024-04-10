Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F93216C44C
	for <gfs2@lists.linux.dev>; Wed, 10 Apr 2024 13:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712756954; cv=none; b=SZHWrrOrN1dPc8Zpxjy4KGcB2t88UzsxszLJIdiv1uCwqNZCj33HNRZ650vDZ+82dP2dLGlCddPi3thr/1X7+kwFMUoYLPGKTkIePLLNJMIN7/Hf+bgOEonYhl/rXQDH5HpFu2UJDRgY83ezIjFHOYUmK3uA7TX8IcDMJqZBqZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712756954; c=relaxed/simple;
	bh=vwufc+9Y7+iil7EWViT5PgFe+FX5bmpKf2hG1h/t2yw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i1ShNJ1McCQFzaEqucwYhdXDeRI5dowbcHQCIhzHlFSgPglaRpDMBQAgxWlTt4fmPn4IfREOTY2HA0GRm7CYYdGDdQ2W6NT3Tj2YWZkh9KMmJ+nqfrPyoKmiq1m5NMNUaTChdMCFgb+R/p3ZZ/j2v+UUsJKxErQ46wLe5ITmf94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ci61/TKT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ci61/TKT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712756951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nPctJcEfChOdCucYWswXjFAyng2SKaxMUddxVGZVSx4=;
	b=Ci61/TKT2CP4lT9qgJG3XQvF+NAhyRiYL68Gs6TC7ufmHsc3yhKW7Jhs/4BsEWAG8PEykD
	ZwVM8EQFpUAX1b5c1KuETSVrdyol450dLkSYTB/D6iVXGj4Uw0MgjCDUaPoyQDg1idzeE2
	/pSfuAFL/zpP8vMUF46fF9ujiaJQ/Pw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-403-9mH9mNKwP_iBA9cscPoxcQ-1; Wed,
 10 Apr 2024 09:49:09 -0400
X-MC-Unique: 9mH9mNKwP_iBA9cscPoxcQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 114283C0CEEE
	for <gfs2@lists.linux.dev>; Wed, 10 Apr 2024 13:49:09 +0000 (UTC)
Received: from fs-i40c-03.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 047DFC27EB8;
	Wed, 10 Apr 2024 13:49:09 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [RFC dlm/next 9/9] dlm: convert lkbidr to rwlock
Date: Wed, 10 Apr 2024 09:48:58 -0400
Message-ID: <20240410134858.3295266-10-aahringo@redhat.com>
In-Reply-To: <20240410134858.3295266-1-aahringo@redhat.com>
References: <20240410134858.3295266-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

This patch converts lkbidr lock to rwlock. The most time we doing
lookups of idr only this can be done by holding the read lock only.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/dlm_internal.h |  2 +-
 fs/dlm/lock.c         | 44 +++++++------------------------------------
 fs/dlm/lockspace.c    |  6 +++---
 3 files changed, 11 insertions(+), 41 deletions(-)

diff --git a/fs/dlm/dlm_internal.h b/fs/dlm/dlm_internal.h
index 5714c073887d..04b5e6b7b8ce 100644
--- a/fs/dlm/dlm_internal.h
+++ b/fs/dlm/dlm_internal.h
@@ -583,7 +583,7 @@ struct dlm_ls {
 	struct kobject		ls_kobj;
 
 	struct idr		ls_lkbidr;
-	spinlock_t		ls_lkbidr_spin;
+	rwlock_t		ls_lkbidr_lock;
 
 	struct rhashtable	ls_rsbtbl;
 	rwlock_t		ls_rsbtbl_lock;
diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index 5cf94203b2db..93302c5be4a7 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -1419,11 +1419,11 @@ static int _create_lkb(struct dlm_ls *ls, struct dlm_lkb **lkb_ret,
 	INIT_LIST_HEAD(&lkb->lkb_ownqueue);
 	INIT_LIST_HEAD(&lkb->lkb_rsb_lookup);
 
-	spin_lock_bh(&ls->ls_lkbidr_spin);
+	write_lock_bh(&ls->ls_lkbidr_lock);
 	rv = idr_alloc(&ls->ls_lkbidr, lkb, start, end, GFP_NOWAIT);
 	if (rv >= 0)
 		lkb->lkb_id = rv;
-	spin_unlock_bh(&ls->ls_lkbidr_spin);
+	write_unlock_bh(&ls->ls_lkbidr_lock);
 
 	if (rv < 0) {
 		log_error(ls, "create_lkb idr error %d", rv);
@@ -1444,11 +1444,11 @@ static int find_lkb(struct dlm_ls *ls, uint32_t lkid, struct dlm_lkb **lkb_ret)
 {
 	struct dlm_lkb *lkb;
 
-	spin_lock_bh(&ls->ls_lkbidr_spin);
+	read_lock_bh(&ls->ls_lkbidr_lock);
 	lkb = idr_find(&ls->ls_lkbidr, lkid);
 	if (lkb)
 		kref_get(&lkb->lkb_ref);
-	spin_unlock_bh(&ls->ls_lkbidr_spin);
+	read_unlock_bh(&ls->ls_lkbidr_lock);
 
 	*lkb_ret = lkb;
 	return lkb ? 0 : -ENOENT;
@@ -1464,36 +1464,6 @@ static void kill_lkb(struct kref *kref)
 	DLM_ASSERT(!lkb->lkb_status, dlm_print_lkb(lkb););
 }
 
-/* TODO move this to lib/refcount.c */
-static __must_check bool
-dlm_refcount_dec_and_lock_bh(refcount_t *r, spinlock_t *lock)
-__cond_acquires(lock)
-{
-	if (refcount_dec_not_one(r))
-		return false;
-
-	spin_lock_bh(lock);
-	if (!refcount_dec_and_test(r)) {
-		spin_unlock_bh(lock);
-		return false;
-	}
-
-	return true;
-}
-
-/* TODO move this to include/linux/kref.h */
-static inline int dlm_kref_put_lock_bh(struct kref *kref,
-				       void (*release)(struct kref *kref),
-				       spinlock_t *lock)
-{
-	if (dlm_refcount_dec_and_lock_bh(&kref->refcount, lock)) {
-		release(kref);
-		return 1;
-	}
-
-	return 0;
-}
-
 /* __put_lkb() is used when an lkb may not have an rsb attached to
    it so we need to provide the lockspace explicitly */
 
@@ -1502,11 +1472,11 @@ static int __put_lkb(struct dlm_ls *ls, struct dlm_lkb *lkb)
 	uint32_t lkid = lkb->lkb_id;
 	int rv;
 
-	rv = dlm_kref_put_lock_bh(&lkb->lkb_ref, kill_lkb,
-				  &ls->ls_lkbidr_spin);
+	rv = dlm_kref_put_write_lock_bh(&lkb->lkb_ref, kill_lkb,
+					&ls->ls_lkbidr_lock);
 	if (rv) {
 		idr_remove(&ls->ls_lkbidr, lkid);
-		spin_unlock_bh(&ls->ls_lkbidr_spin);
+		write_unlock_bh(&ls->ls_lkbidr_lock);
 
 		detach_lkb(lkb);
 
diff --git a/fs/dlm/lockspace.c b/fs/dlm/lockspace.c
index 07d47f3427bf..58f9320858a2 100644
--- a/fs/dlm/lockspace.c
+++ b/fs/dlm/lockspace.c
@@ -431,7 +431,7 @@ static int new_lockspace(const char *name, const char *cluster,
 		goto out_lsfree;
 
 	idr_init(&ls->ls_lkbidr);
-	spin_lock_init(&ls->ls_lkbidr_spin);
+	rwlock_init(&ls->ls_lkbidr_lock);
 
 	INIT_LIST_HEAD(&ls->ls_waiters);
 	spin_lock_init(&ls->ls_waiters_lock);
@@ -671,7 +671,7 @@ static int lockspace_busy(struct dlm_ls *ls, int force)
 {
 	int rv;
 
-	spin_lock_bh(&ls->ls_lkbidr_spin);
+	read_lock_bh(&ls->ls_lkbidr_lock);
 	if (force == 0) {
 		rv = idr_for_each(&ls->ls_lkbidr, lkb_idr_is_any, ls);
 	} else if (force == 1) {
@@ -679,7 +679,7 @@ static int lockspace_busy(struct dlm_ls *ls, int force)
 	} else {
 		rv = 0;
 	}
-	spin_unlock_bh(&ls->ls_lkbidr_spin);
+	read_unlock_bh(&ls->ls_lkbidr_lock);
 	return rv;
 }
 
-- 
2.43.0

