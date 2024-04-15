Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A13154BFC
	for <gfs2@lists.linux.dev>; Mon, 15 Apr 2024 18:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713206391; cv=none; b=sFFJA4ajEMy+20Jc8Y7BVKuNc5U5cNPmyON50urMmj2Aa+hutfcuZ9gZ9h0ay0rIb0IyolLBklXgT9CA6YVunnn6M5OxjrQjeCX5R5JdQ/LeIJ1gSdX8q9haBDre1RDqlPZyB61T54vRi7/DONdREHR8RR4fUO1YMgLMERPskAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713206391; c=relaxed/simple;
	bh=m1FK8laqgbMGRikvYHIGaJYxYtftrrLyf49Uxc1CZrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YaqYCa1G8ac6fhPvtHWe3rmtx7obnuSnSR1JDYVLJJnraIKL10dkFJ2HcyYI1+LZQOyfcI+aoeSyzbwKkivR2BY/NmNYd9r8xcMtNgPVDNT6tl7NJWE22j898iCtW0PlazWxdtMzZwqiEg+Ftt0LbXeZH7YLpvky48xjIos9tsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hy3d8rAA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hy3d8rAA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713206387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=imakAG3MY2EeqTzesR/2rECc3rV8TeNNaPSfR8drfMs=;
	b=Hy3d8rAAS/qMpzhhmeMXt6UMihL9yDM5NT5inTaARSE5VblpKTchnyZpE2N6DR7qCUgUm1
	NnkqqyARwOgxl9JRiOAOCLf1KQjSeg03Hjw6XL20QzvEsBcQdw6WtipguQFgyPuWk7rikz
	79gx9Fo4nSdjr7hbdytsJ2H9Q5G/GvU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-ifHip03-MCy-LRkDUjL2-Q-1; Mon, 15 Apr 2024 14:39:45 -0400
X-MC-Unique: ifHip03-MCy-LRkDUjL2-Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5E0D58059E0
	for <gfs2@lists.linux.dev>; Mon, 15 Apr 2024 18:39:45 +0000 (UTC)
Received: from fs-i40c-03.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 527CDC04227;
	Mon, 15 Apr 2024 18:39:45 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCHv2 dlm/next 9/9] dlm: convert lkbidr to rwlock
Date: Mon, 15 Apr 2024 14:39:43 -0400
Message-ID: <20240415183943.645497-10-aahringo@redhat.com>
In-Reply-To: <20240415183943.645497-1-aahringo@redhat.com>
References: <20240415183943.645497-1-aahringo@redhat.com>
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
index b675bffb61ae..19e57cbd5b13 100644
--- a/fs/dlm/dlm_internal.h
+++ b/fs/dlm/dlm_internal.h
@@ -582,7 +582,7 @@ struct dlm_ls {
 	struct kobject		ls_kobj;
 
 	struct idr		ls_lkbidr;
-	spinlock_t		ls_lkbidr_spin;
+	rwlock_t		ls_lkbidr_lock;
 
 	struct rhashtable	ls_rsbtbl;
 	rwlock_t		ls_rsbtbl_lock;
diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index 790d0fd76bbe..bbbc9593a64e 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -1522,11 +1522,11 @@ static int _create_lkb(struct dlm_ls *ls, struct dlm_lkb **lkb_ret,
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
@@ -1547,11 +1547,11 @@ static int find_lkb(struct dlm_ls *ls, uint32_t lkid, struct dlm_lkb **lkb_ret)
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
@@ -1567,36 +1567,6 @@ static void kill_lkb(struct kref *kref)
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
 
@@ -1605,11 +1575,11 @@ static int __put_lkb(struct dlm_ls *ls, struct dlm_lkb *lkb)
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
index 04f4c74831ce..5ce26882159e 100644
--- a/fs/dlm/lockspace.c
+++ b/fs/dlm/lockspace.c
@@ -431,7 +431,7 @@ static int new_lockspace(const char *name, const char *cluster,
 		goto out_lsfree;
 
 	idr_init(&ls->ls_lkbidr);
-	spin_lock_init(&ls->ls_lkbidr_spin);
+	rwlock_init(&ls->ls_lkbidr_lock);
 
 	INIT_LIST_HEAD(&ls->ls_waiters);
 	spin_lock_init(&ls->ls_waiters_lock);
@@ -676,7 +676,7 @@ static int lockspace_busy(struct dlm_ls *ls, int force)
 {
 	int rv;
 
-	spin_lock_bh(&ls->ls_lkbidr_spin);
+	read_lock_bh(&ls->ls_lkbidr_lock);
 	if (force == 0) {
 		rv = idr_for_each(&ls->ls_lkbidr, lkb_idr_is_any, ls);
 	} else if (force == 1) {
@@ -684,7 +684,7 @@ static int lockspace_busy(struct dlm_ls *ls, int force)
 	} else {
 		rv = 0;
 	}
-	spin_unlock_bh(&ls->ls_lkbidr_spin);
+	read_unlock_bh(&ls->ls_lkbidr_lock);
 	return rv;
 }
 
-- 
2.43.0

