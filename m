Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FE62C869
	for <gfs2@lists.linux.dev>; Mon,  6 Nov 2023 19:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AEvpKN8q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699297908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NFYAlpr3mCFx2VdOux1+OiNwc+JRrHXIPRJP0tooHeo=;
	b=AEvpKN8qkhRtXdQ+3lW1bTQrYxSWCv799eE+UlSQzpVrU+nS69fvs+EI2lWaA2Ul3uviIv
	iYPHKCgFYzLaNlB0t4M1HTYX5uMtpVJbezH1xZiicycEBzvLuyEFJIZHWi8N08R0EvOqMM
	+CVizxy6ihjJnzdtWC639NfZd+wVyNA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-347-oHThYmJUOn6oNy-3gimBAA-1; Mon,
 06 Nov 2023 14:11:45 -0500
X-MC-Unique: oHThYmJUOn6oNy-3gimBAA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8E9072808FE6;
	Mon,  6 Nov 2023 19:11:44 +0000 (UTC)
Received: from fs-i40c-03.fs.lab.eng.bos.redhat.com (fs-i40c-03.fast.rdu2.eng.redhat.com [10.6.23.54])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 81CDF1121307;
	Mon,  6 Nov 2023 19:11:44 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: peterz@infradead.org
Cc: will@kernel.org,
	gfs2@lists.linux.dev,
	aahringo@redhat.com,
	boqun.feng@gmail.com,
	mark.rutland@arm.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] refcount: introduce __refcount_dec_and_lock macro
Date: Mon,  6 Nov 2023 14:11:37 -0500
Message-Id: <20231106191138.3179599-2-aahringo@redhat.com>
In-Reply-To: <20231106191138.3179599-1-aahringo@redhat.com>
References: <20231106191138.3179599-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

This patch adds the __refcount_dec_and_lock macro to generate code for a
lock specific refcount_dec_and_lock implementation. Existing
refcount_dec_and_lock implementation are updated to use the new
__refcount_dec_and_lock macro. In future other lock implementation can
added to use the refcount_dec_and_lock trick to only hold the lock when
the refcount is going to be zero. Per subsystem own lock implementation
can use the macro as well to provide such implementation for their own
locking type.

Co-developed: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 include/linux/refcount.h | 25 +++++++++++++++++++++++++
 lib/refcount.c           | 36 ++++++------------------------------
 2 files changed, 31 insertions(+), 30 deletions(-)

diff --git a/include/linux/refcount.h b/include/linux/refcount.h
index 741cc6295f54..d5cf40d3f4bc 100644
--- a/include/linux/refcount.h
+++ b/include/linux/refcount.h
@@ -362,6 +362,31 @@ static inline void refcount_dec(refcount_t *r)
 extern __must_check bool refcount_dec_if_one(refcount_t *r);
 extern __must_check bool refcount_dec_not_one(refcount_t *r);
 
+/**
+ * __refcount_dec_and_lock - macro to create code to holding a lock if being
+ *                           able to decremnt refcount to 0
+ * @_ref: the refcount
+ * @_lock: lock function call code
+ * @_unlock: unlock function call code
+ *
+ * The result will be directly returned as a right operand operation. Uusally
+ * the caller use it directly after a return statement.
+ */
+#define __refcount_dec_and_lock(_ref, _lock, _unlock)	\
+({							\
+	bool _ret = false;				\
+							\
+	if (!refcount_dec_not_one(_ref)) {		\
+		_lock;					\
+		if (!refcount_dec_and_test(_ref))	\
+			_unlock;			\
+		else					\
+			_ret = true;			\
+	}						\
+							\
+	_ret;						\
+})
+
 /**
  * refcount_dec_and_mutex_lock - return holding mutex if able to decrement
  *                               refcount to 0
diff --git a/lib/refcount.c b/lib/refcount.c
index c37edf66994f..5511498df708 100644
--- a/lib/refcount.c
+++ b/lib/refcount.c
@@ -96,46 +96,22 @@ EXPORT_SYMBOL(refcount_dec_not_one);
 
 bool refcount_dec_and_mutex_lock(refcount_t *r, struct mutex *lock)
 {
-	if (refcount_dec_not_one(r))
-		return false;
-
-	mutex_lock(lock);
-	if (!refcount_dec_and_test(r)) {
-		mutex_unlock(lock);
-		return false;
-	}
-
-	return true;
+	return __refcount_dec_and_lock(r, mutex_lock(lock),
+				       mutex_unlock(lock));
 }
 EXPORT_SYMBOL(refcount_dec_and_mutex_lock);
 
 bool refcount_dec_and_lock(refcount_t *r, spinlock_t *lock)
 {
-	if (refcount_dec_not_one(r))
-		return false;
-
-	spin_lock(lock);
-	if (!refcount_dec_and_test(r)) {
-		spin_unlock(lock);
-		return false;
-	}
-
-	return true;
+	return __refcount_dec_and_lock(r, spin_lock(lock),
+				       spin_unlock(lock));
 }
 EXPORT_SYMBOL(refcount_dec_and_lock);
 
 bool refcount_dec_and_lock_irqsave(refcount_t *r, spinlock_t *lock,
 				   unsigned long *flags)
 {
-	if (refcount_dec_not_one(r))
-		return false;
-
-	spin_lock_irqsave(lock, *flags);
-	if (!refcount_dec_and_test(r)) {
-		spin_unlock_irqrestore(lock, *flags);
-		return false;
-	}
-
-	return true;
+	return __refcount_dec_and_lock(r, spin_lock_irqsave(lock, *flags),
+				       spin_unlock_irqrestore(lock, *flags));
 }
 EXPORT_SYMBOL(refcount_dec_and_lock_irqsave);
-- 
2.39.3

