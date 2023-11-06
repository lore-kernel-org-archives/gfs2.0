Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E9328E22
	for <gfs2@lists.linux.dev>; Mon,  6 Nov 2023 19:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O45n9eKC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699297909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pvARdzk7JF5j0f2O61J3PPBv74WDWbFdIcUVxM6lsBQ=;
	b=O45n9eKCRBPg5AZej/eg00u/L1cZNrMEhlMx1BUVUZjNVQ4d0qR76RfC16WNELXvAfPpkE
	6JYvZzRwpsI4QJvcM8QGDlnaWWD4qWfiFNOtiiKnafVpSo+EJSHpxI+SejQuG+wHQCwiYc
	N+lqQvhVB0aLCQcmE6pictUgOAVOmBE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-208-pMWJkGsCMEWXJ3FSmzze8w-1; Mon,
 06 Nov 2023 14:11:45 -0500
X-MC-Unique: pMWJkGsCMEWXJ3FSmzze8w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 822BC3C14767;
	Mon,  6 Nov 2023 19:11:44 +0000 (UTC)
Received: from fs-i40c-03.fs.lab.eng.bos.redhat.com (fs-i40c-03.fast.rdu2.eng.redhat.com [10.6.23.54])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5ABBA1121306;
	Mon,  6 Nov 2023 19:11:44 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: peterz@infradead.org
Cc: will@kernel.org,
	gfs2@lists.linux.dev,
	aahringo@redhat.com,
	boqun.feng@gmail.com,
	mark.rutland@arm.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] refcount: move kdoc to header definition
Date: Mon,  6 Nov 2023 14:11:36 -0500
Message-Id: <20231106191138.3179599-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

This patch moves the kdoc for refcount_dec_and_lock functionality to
it's header prototype declarations.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 include/linux/refcount.h | 48 ++++++++++++++++++++++++++++++++++++++++
 lib/refcount.c           | 45 -------------------------------------
 2 files changed, 48 insertions(+), 45 deletions(-)

diff --git a/include/linux/refcount.h b/include/linux/refcount.h
index a62fcca97486..741cc6295f54 100644
--- a/include/linux/refcount.h
+++ b/include/linux/refcount.h
@@ -361,8 +361,56 @@ static inline void refcount_dec(refcount_t *r)
 
 extern __must_check bool refcount_dec_if_one(refcount_t *r);
 extern __must_check bool refcount_dec_not_one(refcount_t *r);
+
+/**
+ * refcount_dec_and_mutex_lock - return holding mutex if able to decrement
+ *                               refcount to 0
+ * @r: the refcount
+ * @lock: the mutex to be locked
+ *
+ * Similar to atomic_dec_and_mutex_lock(), it will WARN on underflow and fail
+ * to decrement when saturated at REFCOUNT_SATURATED.
+ *
+ * Provides release memory ordering, such that prior loads and stores are done
+ * before, and provides a control dependency such that free() must come after.
+ * See the comment on top.
+ *
+ * Return: true and hold mutex if able to decrement refcount to 0, false
+ *         otherwise
+ */
 extern __must_check bool refcount_dec_and_mutex_lock(refcount_t *r, struct mutex *lock) __cond_acquires(lock);
+
+/**
+ * refcount_dec_and_lock - return holding spinlock if able to decrement
+ *                         refcount to 0
+ * @r: the refcount
+ * @lock: the spinlock to be locked
+ *
+ * Similar to atomic_dec_and_lock(), it will WARN on underflow and fail to
+ * decrement when saturated at REFCOUNT_SATURATED.
+ *
+ * Provides release memory ordering, such that prior loads and stores are done
+ * before, and provides a control dependency such that free() must come after.
+ * See the comment on top.
+ *
+ * Return: true and hold spinlock if able to decrement refcount to 0, false
+ *         otherwise
+ */
 extern __must_check bool refcount_dec_and_lock(refcount_t *r, spinlock_t *lock) __cond_acquires(lock);
+
+/**
+ * refcount_dec_and_lock_irqsave - return holding spinlock with disabled
+ *                                 interrupts if able to decrement refcount to 0
+ * @r: the refcount
+ * @lock: the spinlock to be locked
+ * @flags: saved IRQ-flags if the is acquired
+ *
+ * Same as refcount_dec_and_lock() above except that the spinlock is acquired
+ * with disabled interrupts.
+ *
+ * Return: true and hold spinlock if able to decrement refcount to 0, false
+ *         otherwise
+ */
 extern __must_check bool refcount_dec_and_lock_irqsave(refcount_t *r,
 						       spinlock_t *lock,
 						       unsigned long *flags) __cond_acquires(lock);
diff --git a/lib/refcount.c b/lib/refcount.c
index a207a8f22b3c..c37edf66994f 100644
--- a/lib/refcount.c
+++ b/lib/refcount.c
@@ -94,22 +94,6 @@ bool refcount_dec_not_one(refcount_t *r)
 }
 EXPORT_SYMBOL(refcount_dec_not_one);
 
-/**
- * refcount_dec_and_mutex_lock - return holding mutex if able to decrement
- *                               refcount to 0
- * @r: the refcount
- * @lock: the mutex to be locked
- *
- * Similar to atomic_dec_and_mutex_lock(), it will WARN on underflow and fail
- * to decrement when saturated at REFCOUNT_SATURATED.
- *
- * Provides release memory ordering, such that prior loads and stores are done
- * before, and provides a control dependency such that free() must come after.
- * See the comment on top.
- *
- * Return: true and hold mutex if able to decrement refcount to 0, false
- *         otherwise
- */
 bool refcount_dec_and_mutex_lock(refcount_t *r, struct mutex *lock)
 {
 	if (refcount_dec_not_one(r))
@@ -125,22 +109,6 @@ bool refcount_dec_and_mutex_lock(refcount_t *r, struct mutex *lock)
 }
 EXPORT_SYMBOL(refcount_dec_and_mutex_lock);
 
-/**
- * refcount_dec_and_lock - return holding spinlock if able to decrement
- *                         refcount to 0
- * @r: the refcount
- * @lock: the spinlock to be locked
- *
- * Similar to atomic_dec_and_lock(), it will WARN on underflow and fail to
- * decrement when saturated at REFCOUNT_SATURATED.
- *
- * Provides release memory ordering, such that prior loads and stores are done
- * before, and provides a control dependency such that free() must come after.
- * See the comment on top.
- *
- * Return: true and hold spinlock if able to decrement refcount to 0, false
- *         otherwise
- */
 bool refcount_dec_and_lock(refcount_t *r, spinlock_t *lock)
 {
 	if (refcount_dec_not_one(r))
@@ -156,19 +124,6 @@ bool refcount_dec_and_lock(refcount_t *r, spinlock_t *lock)
 }
 EXPORT_SYMBOL(refcount_dec_and_lock);
 
-/**
- * refcount_dec_and_lock_irqsave - return holding spinlock with disabled
- *                                 interrupts if able to decrement refcount to 0
- * @r: the refcount
- * @lock: the spinlock to be locked
- * @flags: saved IRQ-flags if the is acquired
- *
- * Same as refcount_dec_and_lock() above except that the spinlock is acquired
- * with disabled interrupts.
- *
- * Return: true and hold spinlock if able to decrement refcount to 0, false
- *         otherwise
- */
 bool refcount_dec_and_lock_irqsave(refcount_t *r, spinlock_t *lock,
 				   unsigned long *flags)
 {
-- 
2.39.3

