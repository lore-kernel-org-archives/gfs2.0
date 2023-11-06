Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5502D040
	for <gfs2@lists.linux.dev>; Mon,  6 Nov 2023 19:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OMl4P9dP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699297910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mJ+LiwbN2BndSbRN+OoIP2/njNNsDf+m3Dwmn8bd/c4=;
	b=OMl4P9dPcZQBjz/VvTU7tXT5LmqmYHgL4cNLddT4hbEts1oOFHnxnS6tiY9O1HDGqvL2OJ
	+fCZLj9ZdUpA+a4odh1NhHmQCxLY6xbkYPZYaMATIGEI/UGRj++QnXhU04+hktZEyr9jWK
	hMRLQhOYMCSptxTmOgI6Por4iIHSF0o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-SLmrcSgBNA-ymJxd3I8Etg-1; Mon, 06 Nov 2023 14:11:45 -0500
X-MC-Unique: SLmrcSgBNA-ymJxd3I8Etg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9B2CA185A788;
	Mon,  6 Nov 2023 19:11:44 +0000 (UTC)
Received: from fs-i40c-03.fs.lab.eng.bos.redhat.com (fs-i40c-03.fast.rdu2.eng.redhat.com [10.6.23.54])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8E47D1121306;
	Mon,  6 Nov 2023 19:11:44 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: peterz@infradead.org
Cc: will@kernel.org,
	gfs2@lists.linux.dev,
	aahringo@redhat.com,
	boqun.feng@gmail.com,
	mark.rutland@arm.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] kref: introduce __kref_put_lock macro
Date: Mon,  6 Nov 2023 14:11:38 -0500
Message-Id: <20231106191138.3179599-3-aahringo@redhat.com>
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

This patch introduce the __kref_put_lock macro to easily write a
kref_put_lock functionality based on refcount_dec_and_lock functions.
Existing per lock type specific kref_put_lock functionality are updated
to use the new __kref_put_lock macro.

Co-developed: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 include/linux/kref.h | 37 +++++++++++++++++++++++++++----------
 1 file changed, 27 insertions(+), 10 deletions(-)

diff --git a/include/linux/kref.h b/include/linux/kref.h
index d32e21a2538c..d8e26ac1d54f 100644
--- a/include/linux/kref.h
+++ b/include/linux/kref.h
@@ -68,26 +68,43 @@ static inline int kref_put(struct kref *kref, void (*release)(struct kref *kref)
 	return 0;
 }
 
+/**
+ * __kref_dec_and_lock - macro to create code to holding a lock and call the
+ *                       release callback if being able to decremnt refcount
+ *                       to 0
+ * @kref: the kref
+ * @_release: callback for the release function
+ * @_ref_dec_and_lock: ref_and_lock lock specific function call code
+ *
+ * The result will be directly returned as a right operand operation. Uusally
+ * the caller use it directly after a return statement.
+ */
+#define __kref_put_lock(_kref, _release, _ref_dec_and_lock)	\
+({								\
+	int _ret = 0;						\
+								\
+	if (_ref_dec_and_lock) {				\
+		_release(kref);					\
+		_ret = 1;					\
+	}							\
+								\
+	_ret;							\
+})
+
 static inline int kref_put_mutex(struct kref *kref,
 				 void (*release)(struct kref *kref),
 				 struct mutex *lock)
 {
-	if (refcount_dec_and_mutex_lock(&kref->refcount, lock)) {
-		release(kref);
-		return 1;
-	}
-	return 0;
+	return __kref_put_lock(kref, release,
+			       refcount_dec_and_mutex_lock(&kref->refcount, lock));
 }
 
 static inline int kref_put_lock(struct kref *kref,
 				void (*release)(struct kref *kref),
 				spinlock_t *lock)
 {
-	if (refcount_dec_and_lock(&kref->refcount, lock)) {
-		release(kref);
-		return 1;
-	}
-	return 0;
+	return __kref_put_lock(kref, release,
+			       refcount_dec_and_lock(&kref->refcount, lock));
 }
 
 /**
-- 
2.39.3

