Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A471FBB
	for <gfs2@lists.linux.dev>; Thu,  4 Jan 2024 02:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EyytCAEW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704333964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qCpVnOehh7vLji/S00Rq9BcEL84eRlggMamPuaC1bIU=;
	b=EyytCAEW/661t/TpI3oaucW7iMys71TtnmpARXj72Shpr6cODeIT06RKomZYOuueRJC+KX
	Vhbxhy1DMUmQWHQ1bA2VwdRj2+lG6RopqaIsFONZD1X+PwHcZxlhOMeGuI3TlNFO4BCalS
	f66W6fRxk9W4JGDHdPk0hdiGdly7U7k=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-358-OvBB1d06PKOcywYDAqJTKQ-1; Wed,
 03 Jan 2024 21:06:02 -0500
X-MC-Unique: OvBB1d06PKOcywYDAqJTKQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 94F603810B02
	for <gfs2@lists.linux.dev>; Thu,  4 Jan 2024 02:06:02 +0000 (UTC)
Received: from fs-i40c-03.fs.lab.eng.bos.redhat.com (fs-i40c-03.fast.eng.rdu2.dc.redhat.com [10.6.23.54])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8A118C15968;
	Thu,  4 Jan 2024 02:06:02 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCH dlm/next 2/2] dlm: put lkbs instead of force free
Date: Wed,  3 Jan 2024 21:05:58 -0500
Message-Id: <20240104020558.2594636-3-aahringo@redhat.com>
In-Reply-To: <20240104020558.2594636-1-aahringo@redhat.com>
References: <20240104020558.2594636-1-aahringo@redhat.com>
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

This patch converts a force free of the lkb idr and switch to use the
lkbs put functionality. If there are still references hold due the lkb
programming logic and its state it will be drop before. Instead of force
freeing the lkbs of the idr using the refcounters makes sure we using
the reference counters correctly. If we do that, then no rsb should be
left on the lockspace keep hash bucket which is an additonally check
added to this patch. All rsbs on the toss list should have a reference
counter of 1.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/lock.c      |  2 +-
 fs/dlm/lock.h      |  1 +
 fs/dlm/lockspace.c | 31 +++++++++++++++++++++----------
 3 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index c30e9f8d017e..f77f479e53b6 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -1368,7 +1368,7 @@ static void add_lkb(struct dlm_rsb *r, struct dlm_lkb *lkb, int status)
 	}
 }
 
-static void del_lkb(struct dlm_rsb *r, struct dlm_lkb *lkb)
+void del_lkb(struct dlm_rsb *r, struct dlm_lkb *lkb)
 {
 	lkb->lkb_status = 0;
 	list_del(&lkb->lkb_statequeue);
diff --git a/fs/dlm/lock.h b/fs/dlm/lock.h
index b54e2cbbe6e2..853c3d3dc49d 100644
--- a/fs/dlm/lock.h
+++ b/fs/dlm/lock.h
@@ -60,6 +60,7 @@ int dlm_debug_add_lkb(struct dlm_ls *ls, uint32_t lkb_id, char *name, int len,
 		      int lkb_nodeid, unsigned int lkb_flags, int lkb_status);
 int dlm_debug_add_lkb_to_waiters(struct dlm_ls *ls, uint32_t lkb_id,
 				 int mstype, int to_nodeid);
+void del_lkb(struct dlm_rsb *r, struct dlm_lkb *lkb);
 
 static inline int is_master(struct dlm_rsb *r)
 {
diff --git a/fs/dlm/lockspace.c b/fs/dlm/lockspace.c
index 0455dddb0797..c7ab7358422b 100644
--- a/fs/dlm/lockspace.c
+++ b/fs/dlm/lockspace.c
@@ -737,14 +737,28 @@ static int lkb_idr_is_any(int id, void *p, void *data)
 	return 1;
 }
 
-static int lkb_idr_free(int id, void *p, void *data)
+/*
+ * No locking required, lockspace usage should be synchronized
+ * to have any activity anymore.
+ */
+static int lkb_idr_put(int id, void *p, void *data)
 {
 	struct dlm_lkb *lkb = p;
 
-	if (lkb->lkb_lvbptr && test_bit(DLM_IFL_MSTCPY_BIT, &lkb->lkb_iflags))
-		dlm_free_lvb(lkb->lkb_lvbptr);
+	if (lkb->lkb_status)
+		del_lkb(lkb->lkb_resource, lkb);
 
-	dlm_free_lkb(lkb);
+	/* drop all wait_count references we still
+	 * hold a reference for this iteration.
+	 */
+	while (atomic_read(&lkb->lkb_wait_count)) {
+		if (atomic_dec_and_test(&lkb->lkb_wait_count))
+			list_del_init(&lkb->lkb_wait_reply);
+
+		WARN_ON_ONCE(dlm_put_lkb(lkb));
+	}
+
+	WARN_ON_ONCE(!dlm_put_lkb(lkb));
 	return 0;
 }
 
@@ -826,7 +840,7 @@ static int release_lockspace(struct dlm_ls *ls, int force)
 	 * Free all lkb's in idr
 	 */
 
-	idr_for_each(&ls->ls_lkbidr, lkb_idr_free, ls);
+	idr_for_each(&ls->ls_lkbidr, lkb_idr_put, ls);
 	idr_destroy(&ls->ls_lkbidr);
 
 	/*
@@ -834,15 +848,12 @@ static int release_lockspace(struct dlm_ls *ls, int force)
 	 */
 
 	for (i = 0; i < ls->ls_rsbtbl_size; i++) {
-		while ((n = rb_first(&ls->ls_rsbtbl[i].keep))) {
-			rsb = rb_entry(n, struct dlm_rsb, res_hashnode);
-			rb_erase(n, &ls->ls_rsbtbl[i].keep);
-			dlm_free_rsb(rsb);
-		}
+		WARN_ON_ONCE(!RB_EMPTY_ROOT(&ls->ls_rsbtbl[i].keep));
 
 		while ((n = rb_first(&ls->ls_rsbtbl[i].toss))) {
 			rsb = rb_entry(n, struct dlm_rsb, res_hashnode);
 			rb_erase(n, &ls->ls_rsbtbl[i].toss);
+			WARN_ON_ONCE(kref_read(&rsb->res_ref) != 1);
 			dlm_free_rsb(rsb);
 		}
 	}
-- 
2.39.3

