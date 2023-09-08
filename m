Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC6E1FBB
	for <gfs2@lists.linux.dev>; Fri,  8 Sep 2023 20:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694205985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C5A1PiIUGnym3TzzZ4jCxGhFPtCjZa+spSmbxjRGRbk=;
	b=IQQat5NO1N7DtK71sR2Dx4i3UqSeEHwklAO3/uLh8f5YyNGg9da4EGmWV/KR3WvqGydeGD
	dMASmYNE6LAp4Hw3sd6ABzTEWD1QA6sTuo0zSh+zO5iuEXtfPnslspAPZURtz63XdVqjk3
	aL70J/sgp6PPFQMwwMOLMl/vWWr+rzA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-213-Vv79209zMCG5WXOSG2s3KA-1; Fri, 08 Sep 2023 16:46:23 -0400
X-MC-Unique: Vv79209zMCG5WXOSG2s3KA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 52F11816532
	for <gfs2@lists.linux.dev>; Fri,  8 Sep 2023 20:46:23 +0000 (UTC)
Received: from fs-i40c-03.fs.lab.eng.bos.redhat.com (fs-i40c-03.fs.lab.eng.bos.redhat.com [10.16.224.23])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2ACF721EE56C;
	Fri,  8 Sep 2023 20:46:23 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: cluster-devel@redhat.com,
	gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [RFC dlm/next 05/10] fs: dlm: convert res_lock to spinlock
Date: Fri,  8 Sep 2023 16:46:06 -0400
Message-Id: <20230908204611.1910601-5-aahringo@redhat.com>
In-Reply-To: <20230908204611.1910601-1-aahringo@redhat.com>
References: <20230908204611.1910601-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
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
index 2f32e053a9dc..383b26144a31 100644
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
index 5631623ce01a..3d17f4d6b765 100644
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
index b54e2cbbe6e2..1428fa3482d7 100644
--- a/fs/dlm/lock.h
+++ b/fs/dlm/lock.h
@@ -68,12 +68,12 @@ static inline int is_master(struct dlm_rsb *r)
 
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
2.31.1

