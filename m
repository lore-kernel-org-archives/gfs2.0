Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6135617C5
	for <gfs2@lists.linux.dev>; Wed, 25 Oct 2023 00:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cAO+yTZj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698195250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7vxkThACIBiCHz9y1rkcfIUS9nzQNafGAib6bqbcrQ8=;
	b=cAO+yTZj9z5azU9dGstfUzyX7e5CRqIu7MJ5Vnsgr7WvLWBA4iyKoD51xyYb9u2CODM15F
	rWfaW1eDnzbbdBSi3n4mVA7KLuaDR0CJ3mNJ/eQrpHYeMCaSEbFh2rzmHmG5y4qPe7EDdE
	z25647Ra4R7JQtl7Sht5XClbb1Gf5hU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-438-XjnHVd84MXWbAxGoC7bmtw-1; Tue,
 24 Oct 2023 20:53:59 -0400
X-MC-Unique: XjnHVd84MXWbAxGoC7bmtw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D977E380673B
	for <gfs2@lists.linux.dev>; Wed, 25 Oct 2023 00:53:58 +0000 (UTC)
Received: from fs-i40c-03.fs.lab.eng.bos.redhat.com (fs-i40c-03.fast.rdu2.eng.redhat.com [10.6.23.54])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D27BA40C6F7B;
	Wed, 25 Oct 2023 00:53:58 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCH dlm/next 06/10] dlm: convert res_lock to spinlock
Date: Tue, 24 Oct 2023 20:53:49 -0400
Message-Id: <20231025005353.855904-6-aahringo@redhat.com>
In-Reply-To: <20231025005353.855904-1-aahringo@redhat.com>
References: <20231025005353.855904-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

This patch converts the per dlm rsb res_lock from a mutex to a spinlock.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/dlm_internal.h | 2 +-
 fs/dlm/lock.c         | 2 +-
 fs/dlm/lock.h         | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/dlm/dlm_internal.h b/fs/dlm/dlm_internal.h
index 0f37436be075..a052b1dd8eb2 100644
--- a/fs/dlm/dlm_internal.h
+++ b/fs/dlm/dlm_internal.h
@@ -290,7 +290,7 @@ struct dlm_lkb {
 struct dlm_rsb {
 	struct dlm_ls		*res_ls;	/* the lockspace */
 	struct kref		res_ref;
-	struct mutex		res_mutex;
+	spinlock_t		res_lock;
 	unsigned long		res_flags;
 	int			res_length;	/* length of rsb name */
 	int			res_nodeid;
diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index 005e2d167cbd..4fc6bc3690a6 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -415,7 +415,7 @@ static int get_rsb_struct(struct dlm_ls *ls, const void *name, int len,
 	r->res_ls = ls;
 	r->res_length = len;
 	memcpy(r->res_name, name, len);
-	mutex_init(&r->res_mutex);
+	spin_lock_init(&r->res_lock);
 
 	INIT_LIST_HEAD(&r->res_lookup);
 	INIT_LIST_HEAD(&r->res_grantqueue);
diff --git a/fs/dlm/lock.h b/fs/dlm/lock.h
index b2fd74a2f8eb..0f6b2700c0da 100644
--- a/fs/dlm/lock.h
+++ b/fs/dlm/lock.h
@@ -69,12 +69,12 @@ static inline int is_master(struct dlm_rsb *r)
 
 static inline void lock_rsb(struct dlm_rsb *r)
 {
-	mutex_lock(&r->res_mutex);
+	spin_lock(&r->res_lock);
 }
 
 static inline void unlock_rsb(struct dlm_rsb *r)
 {
-	mutex_unlock(&r->res_mutex);
+	spin_unlock(&r->res_lock);
 }
 
 #endif
-- 
2.39.3

