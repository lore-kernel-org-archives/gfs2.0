Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AE5125D5
	for <gfs2@lists.linux.dev>; Tue, 27 Feb 2024 01:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708998564; cv=none; b=S9TJb0CBsJs2CxbwBecu5pw+e1tcpnfWQxIITkYgT6AiJf/x6+A3viV4X9UFsJZErEuFEBErBmNC28hM/OlHIwkMTsNVGtfgaR0Q6J5x/3nMgBEbO0lMtJmAFJlSPs3rnaznt2J7FFLHAck9t8ceArNnbXBRbkTpybuXLSKAJuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708998564; c=relaxed/simple;
	bh=fZZoVCKZ83BwB0t6BmAmbusgKYdjfgIDAmilJo0WeyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OvrLmktalzJekfyHzEiouPz8UYFgdKohkESufiiGAuqxgVOtsFFNtpM2WyHfen+XzGd0PR/YpqDlAlIj3sifZ3YelUsIi2y6dDq4M0qoEvSAyeVJomqfBLh0PoKnjpJzRohrJXtYaeLPW5eV2EMfm6lVfuJtMy31LzxPjS9OBbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BBRapQGX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BBRapQGX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708998560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=795OHXFH+w/KQB2XY8m/zsIo6uQgkiho+W8fpXy8EH4=;
	b=BBRapQGX9BOTUXNNcWpbBgsJdnEGJvbh7KLlAPxQuRDtkqJCM9D3Wq/Ja8mEd2eDPMp+WR
	nsJ2wJOL6rIITlPA/CRCPZdw02F3ChGJc6J4DOYdJ2wJfEvsCi3NvuMxRjYBB6j+SrWPQQ
	e8RJzV3laSJ8CxjF2oLR9zNXNNll/NA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-NhhfEWWyOLCWvKsLV_siJQ-1; Mon, 26 Feb 2024 20:49:19 -0500
X-MC-Unique: NhhfEWWyOLCWvKsLV_siJQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 112F1108C064
	for <gfs2@lists.linux.dev>; Tue, 27 Feb 2024 01:49:19 +0000 (UTC)
Received: from fs-i40c-03.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.fast.eng.rdu2.dc.redhat.com [10.6.23.54])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 08E642166AED;
	Tue, 27 Feb 2024 01:49:19 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCHv3 v6.8-rc6 04/18] dlm: put lkbs instead of force free
Date: Mon, 26 Feb 2024 20:48:55 -0500
Message-ID: <20240227014909.93945-5-aahringo@redhat.com>
In-Reply-To: <20240227014909.93945-1-aahringo@redhat.com>
References: <20240227014909.93945-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
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
2.43.0

