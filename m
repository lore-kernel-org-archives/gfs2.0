Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46F0FBF4
	for <gfs2@lists.linux.dev>; Fri,  3 Nov 2023 16:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yq5RzMQO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699028200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mqHyY1ODzJHu1kaplP/oYmep2UPhoo56QH6u+o1w3ak=;
	b=Yq5RzMQO5DjH5rReR7Guu8SR/3LJGJOWtuUCSVjSEl2+fQO6pDKRGY5ZVnFSoGvibodqK1
	+6xNYGClF20/z4c0vj5beQsJjiTvDZs2UeuRi1tb9TghYy3rQ8KHlXNd+PR5X6kxFGE+mW
	YMmRBgYMPDjDbryZnZ5Wceh9daZQfeo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-490-T1SwFjhKO9qkbNfNgp1B5g-1; Fri,
 03 Nov 2023 12:16:37 -0400
X-MC-Unique: T1SwFjhKO9qkbNfNgp1B5g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 827B32999B20;
	Fri,  3 Nov 2023 16:16:36 +0000 (UTC)
Received: from fs-i40c-03.fs.lab.eng.bos.redhat.com (fs-i40c-03.fast.rdu2.eng.redhat.com [10.6.23.54])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 74A7B1121309;
	Fri,  3 Nov 2023 16:16:36 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: will@kernel.org
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com,
	peterz@infradead.org,
	boqun.feng@gmail.com,
	mark.rutland@arm.com,
	linux-kernel@vger.kernel.org
Subject: [RFC 2/2] kref: introduce kref_put_lockptr() and use lockptr
Date: Fri,  3 Nov 2023 12:16:35 -0400
Message-Id: <20231103161635.1902667-2-aahringo@redhat.com>
In-Reply-To: <20231103161635.1902667-1-aahringo@redhat.com>
References: <20231103161635.1902667-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

This patch switches to make kref_put_lock() more locktype independend by
introducing kref_put_lockptr() and using refcount_dec_and_lockptr(). The
user can now pass a lockptr and do the specific locktype operation by
parameters. The current kref_put_mutex() and kref_put_lock() has been
adapted to use the new kref_put_lockptr() implementation for existing
users.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 include/linux/kref.h | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/include/linux/kref.h b/include/linux/kref.h
index d32e21a2538c..09bc79435dbb 100644
--- a/include/linux/kref.h
+++ b/include/linux/kref.h
@@ -68,26 +68,33 @@ static inline int kref_put(struct kref *kref, void (*release)(struct kref *kref)
 	return 0;
 }
 
-static inline int kref_put_mutex(struct kref *kref,
-				 void (*release)(struct kref *kref),
-				 struct mutex *lock)
+static inline int kref_put_lockptr(struct kref *kref,
+				   void (*release)(struct kref *kref),
+				   void (*lock)(void *lockptr),
+				   void (*unlock)(void *lockptr),
+				   void *lockptr)
 {
-	if (refcount_dec_and_mutex_lock(&kref->refcount, lock)) {
+	if (refcount_dec_and_lockptr(&kref->refcount, lock, unlock, lockptr)) {
 		release(kref);
 		return 1;
 	}
 	return 0;
 }
 
+static inline int kref_put_mutex(struct kref *kref,
+				 void (*release)(struct kref *kref),
+				 struct mutex *lock)
+{
+	return kref_put_lockptr(kref, release, lockptr_mutex_lock,
+				lockptr_mutex_unlock, lock);
+}
+
 static inline int kref_put_lock(struct kref *kref,
 				void (*release)(struct kref *kref),
 				spinlock_t *lock)
 {
-	if (refcount_dec_and_lock(&kref->refcount, lock)) {
-		release(kref);
-		return 1;
-	}
-	return 0;
+	return kref_put_lockptr(kref, release, lockptr_spin_lock,
+				lockptr_spin_unlock, lock);
 }
 
 /**
-- 
2.39.3

