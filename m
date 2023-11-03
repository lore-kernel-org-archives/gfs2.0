Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517521C69B
	for <gfs2@lists.linux.dev>; Fri,  3 Nov 2023 16:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E9raVbZi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699028201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tGwXPfRgzPSC1/7v7/xvW9BOx29g/brNKkSt4SGOuac=;
	b=E9raVbZirm9eCJOX5qgA4UJHScidBS07VBGEVh/hdKUS1XEuYN57U7Uv6B0IiZnBFWrFtV
	YkOzgZvtam4ISEMNgf3FmnPhmmt1Z2SPmImc4Wy97jGf1x/cGH2YSENEXJ+PKkWgaRnlb6
	zbzAjZG/7s2TEJfLUOkXGfj8Hhpu2x8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-687-0WUFZsn1MwqGhvhsr2N9QA-1; Fri,
 03 Nov 2023 12:16:36 -0400
X-MC-Unique: 0WUFZsn1MwqGhvhsr2N9QA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 758883806710;
	Fri,  3 Nov 2023 16:16:36 +0000 (UTC)
Received: from fs-i40c-03.fs.lab.eng.bos.redhat.com (fs-i40c-03.fast.rdu2.eng.redhat.com [10.6.23.54])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 511B71121308;
	Fri,  3 Nov 2023 16:16:36 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: will@kernel.org
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com,
	peterz@infradead.org,
	boqun.feng@gmail.com,
	mark.rutland@arm.com,
	linux-kernel@vger.kernel.org
Subject: [RFC 1/2] refcount: introduce generic lockptr funcs
Date: Fri,  3 Nov 2023 12:16:34 -0400
Message-Id: <20231103161635.1902667-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

This patch introduce lockptr refcount operations. Currently refcount has
a lot of refcount_dec_and_lock() functionality for most common used
locktype. Those functions look mostly all the same and is duplicated
inside the refcount implementation. Instead of introducing a new whole
refcount_dec_and_lock() functionality e.g. for rwlock_t and their _bh
variants this patch will introduce lockptr. A lockptr is just a void *
and refers to the actual locking instance that can even be an own
locking type. Over the passed callbacks for lock and unlock operations
the void *lockptr becomes to the real thing by casting it and do the
locktype specific lock operation.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 include/linux/refcount.h | 15 +++++++
 lib/refcount.c           | 92 ++++++++++++++++++++++++++++------------
 2 files changed, 80 insertions(+), 27 deletions(-)

diff --git a/include/linux/refcount.h b/include/linux/refcount.h
index a62fcca97486..7b1fb85212cc 100644
--- a/include/linux/refcount.h
+++ b/include/linux/refcount.h
@@ -366,4 +366,19 @@ extern __must_check bool refcount_dec_and_lock(refcount_t *r, spinlock_t *lock)
 extern __must_check bool refcount_dec_and_lock_irqsave(refcount_t *r,
 						       spinlock_t *lock,
 						       unsigned long *flags) __cond_acquires(lock);
+extern bool refcount_dec_and_lockptr(refcount_t *r, void (*lock)(void *lockptr),
+				     void (*unlock)(void *lockptr),  void *lockptr) __cond_acquires(lockptr);
+
+extern void lockptr_mutex_lock(void *lockptr) __acquires(lockptr);
+extern void lockptr_mutex_unlock(void *lockptr) __releases(lockptr);
+extern void lockptr_spin_lock(void *lockptr) __acquires(lockptr);
+extern void lockptr_spin_unlock(void *lockptr) __releases(lockptr);
+
+struct lockptr_irqsave_data {
+	void *lockptr;
+	unsigned long *flags;
+};
+extern void lockptr_irqsave(void *lockptr) __acquires(lockptr);
+extern void lockptr_irqsave(void *lockptr) __releases(lockptr);
+
 #endif /* _LINUX_REFCOUNT_H */
diff --git a/lib/refcount.c b/lib/refcount.c
index a207a8f22b3c..e28678f0f473 100644
--- a/lib/refcount.c
+++ b/lib/refcount.c
@@ -94,6 +94,34 @@ bool refcount_dec_not_one(refcount_t *r)
 }
 EXPORT_SYMBOL(refcount_dec_not_one);
 
+bool refcount_dec_and_lockptr(refcount_t *r, void (*lock)(void *lockptr),
+			      void (*unlock)(void *lockptr),  void *lockptr)
+{
+	if (refcount_dec_not_one(r))
+		return false;
+
+	lock(lockptr);
+	if (!refcount_dec_and_test(r)) {
+		unlock(lockptr);
+		return false;
+	}
+
+	return true;
+}
+EXPORT_SYMBOL(refcount_dec_and_lockptr);
+
+void lockptr_mutex_lock(void *lockptr)
+{
+	mutex_lock(lockptr);
+}
+EXPORT_SYMBOL(lockptr_mutex_lock);
+
+void lockptr_mutex_unlock(void *lockptr)
+{
+	mutex_unlock(lockptr);
+}
+EXPORT_SYMBOL(lockptr_mutex_unlock);
+
 /**
  * refcount_dec_and_mutex_lock - return holding mutex if able to decrement
  *                               refcount to 0
@@ -112,18 +140,22 @@ EXPORT_SYMBOL(refcount_dec_not_one);
  */
 bool refcount_dec_and_mutex_lock(refcount_t *r, struct mutex *lock)
 {
-	if (refcount_dec_not_one(r))
-		return false;
+	return refcount_dec_and_lockptr(r, lockptr_mutex_lock,
+					lockptr_mutex_unlock, lock);
+}
+EXPORT_SYMBOL(refcount_dec_and_mutex_lock);
 
-	mutex_lock(lock);
-	if (!refcount_dec_and_test(r)) {
-		mutex_unlock(lock);
-		return false;
-	}
+void lockptr_spin_lock(void *lockptr)
+{
+	spin_lock(lockptr);
+}
+EXPORT_SYMBOL(lockptr_spin_lock);
 
-	return true;
+void lockptr_spin_unlock(void *lockptr)
+{
+	spin_unlock(lockptr);
 }
-EXPORT_SYMBOL(refcount_dec_and_mutex_lock);
+EXPORT_SYMBOL(lockptr_spin_unlock);
 
 /**
  * refcount_dec_and_lock - return holding spinlock if able to decrement
@@ -143,18 +175,26 @@ EXPORT_SYMBOL(refcount_dec_and_mutex_lock);
  */
 bool refcount_dec_and_lock(refcount_t *r, spinlock_t *lock)
 {
-	if (refcount_dec_not_one(r))
-		return false;
+	return refcount_dec_and_lockptr(r, lockptr_spin_lock,
+					lockptr_spin_unlock, lock);
+}
+EXPORT_SYMBOL(refcount_dec_and_lock);
 
-	spin_lock(lock);
-	if (!refcount_dec_and_test(r)) {
-		spin_unlock(lock);
-		return false;
-	}
+void lockptr_lock_irqsave(void *lockptr)
+{
+	struct lockptr_irqsave_data *d = lockptr;
 
-	return true;
+	spin_lock_irqsave(d->lockptr, *d->flags);
 }
-EXPORT_SYMBOL(refcount_dec_and_lock);
+EXPORT_SYMBOL(lockptr_lock_irqsave);
+
+void lockptr_unlock_irqsave(void *lockptr)
+{
+	struct lockptr_irqsave_data *d = lockptr;
+
+	spin_unlock_irqrestore(d->lockptr, *d->flags);
+}
+EXPORT_SYMBOL(lockptr_unlock_irqsave);
 
 /**
  * refcount_dec_and_lock_irqsave - return holding spinlock with disabled
@@ -172,15 +212,13 @@ EXPORT_SYMBOL(refcount_dec_and_lock);
 bool refcount_dec_and_lock_irqsave(refcount_t *r, spinlock_t *lock,
 				   unsigned long *flags)
 {
-	if (refcount_dec_not_one(r))
-		return false;
+	struct lockptr_irqsave_data d = {
+		.lockptr = lock,
+		.flags = flags,
+	};
 
-	spin_lock_irqsave(lock, *flags);
-	if (!refcount_dec_and_test(r)) {
-		spin_unlock_irqrestore(lock, *flags);
-		return false;
-	}
-
-	return true;
+	return refcount_dec_and_lockptr(r, lockptr_lock_irqsave,
+					lockptr_unlock_irqsave, &d);
 }
 EXPORT_SYMBOL(refcount_dec_and_lock_irqsave);
+
-- 
2.39.3

