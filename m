Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B2818622
	for <gfs2@lists.linux.dev>; Fri,  3 Nov 2023 16:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V5LNI4uS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699027619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mqHyY1ODzJHu1kaplP/oYmep2UPhoo56QH6u+o1w3ak=;
	b=V5LNI4uShDoseMknCkzTLkeejrDHnoAybXjUlt49TwlJa1Amcayuh3AQo0OdQvUZc876o8
	zU/S0azHR0teDnyvqxfLrM0RPZMS4iWBmXrBAX4BKVyBJa1bcr6YZ8ac2NyVccYsLHu1px
	6SuP1dXJ/h7EhXBKKi6WT0Xvvnv/vLE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-ly0nFnPFMxKFEppht4slag-1; Fri, 03 Nov 2023 12:06:58 -0400
X-MC-Unique: ly0nFnPFMxKFEppht4slag-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E6CC8101A52D;
	Fri,  3 Nov 2023 16:06:57 +0000 (UTC)
Received: from fs-i40c-03.fs.lab.eng.bos.redhat.com (fs-i40c-03.fast.rdu2.eng.redhat.com [10.6.23.54])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DB717492BE9;
	Fri,  3 Nov 2023 16:06:57 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: will@kernel.org
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com,
	peterz@infradead.org,
	boqun.feng@gmail.com,
	mark.rutland@arm.com
Subject: [RFC 2/2] kref: introduce kref_put_lockptr() and use lockptr
Date: Fri,  3 Nov 2023 12:06:51 -0400
Message-Id: <20231103160651.1902460-2-aahringo@redhat.com>
In-Reply-To: <20231103160651.1902460-1-aahringo@redhat.com>
References: <20231103160651.1902460-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

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

