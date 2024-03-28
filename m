Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE7312EBC4
	for <gfs2@lists.linux.dev>; Thu, 28 Mar 2024 15:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711640928; cv=none; b=qNBENv/xOFbnOh4oLMhkLhZ54DlGiDmxDmZ9XyXm/20fgr5KBgD4YW3ush4+SUkqni6R8BE/re/BTHeZ2bfSNOEuwrfGppuxudcy0fJz2uBx8X49xo5gv6a+/i2yOzzQwMOu3HunsNAavEYU12LlGD0pB1G+qgIZX+FNSswj5Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711640928; c=relaxed/simple;
	bh=neDD8No3sL970oU8Fk0VGWc2GNcvO9HkYXFY4U0Jxps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=itas/CnFRkoYa99fUsYNOKGesdbLbJUWS6fDPaAudwnjaPz+ZF/Lluz8s890Tlfn4On90mRpPLsW1pI+//bKMetayGHFQ0guD7gOSmi8QF9n8RQGBX+BQOiBNF2/3wPIc/ON7Ec12ZGNNxu9anQffOXbi5W/nfdxNJWTKNQ6TWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V2GJcpyt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V2GJcpyt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711640925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uf3BQrvI2fKuFaVX5+VwPeDPPHlM6FDJdsLPd/cUEVI=;
	b=V2GJcpytwpcfG4Qd+lYPAM2MRIeu7ICjzXgvZX87efW7WC5CEfwwAFaTCnRuVvJnVY3jKz
	DpSeP2W8kXCjt21swAOQigur4TPCrzTO9bEymK7PwKHM9XR7h5bv82q5pE4DSwNwtvuCgz
	dZsH56heFUifN9/xiTGU7EVqlcSLAEI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-Kw_c-MtoOZiD9L2BnU-crg-1; Thu, 28 Mar 2024 11:48:43 -0400
X-MC-Unique: Kw_c-MtoOZiD9L2BnU-crg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A0B75800267
	for <gfs2@lists.linux.dev>; Thu, 28 Mar 2024 15:48:43 +0000 (UTC)
Received: from fs-i40c-03.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 98C00C04125;
	Thu, 28 Mar 2024 15:48:43 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev
Subject: [PATCH v6.9-rc1 04/10] dlm: put lkbs instead of force free
Date: Thu, 28 Mar 2024 11:48:36 -0400
Message-ID: <20240328154842.1099288-4-aahringo@redhat.com>
In-Reply-To: <20240328154842.1099288-1-aahringo@redhat.com>
References: <20240328154842.1099288-1-aahringo@redhat.com>
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
 fs/dlm/lockspace.c | 33 +++++++++++++++++++++++----------
 3 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index fd752dd03896..a39c2c49bff8 100644
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
index 0455dddb0797..0f9d7b498602 100644
--- a/fs/dlm/lockspace.c
+++ b/fs/dlm/lockspace.c
@@ -737,14 +737,30 @@ static int lkb_idr_is_any(int id, void *p, void *data)
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
+	/*
+	 * Forcibly reset wait_count and associated refcount. The
+	 * wait_count will almost always be 1, but in case of an
+	 * overlapping unlock/cancel it could be 2: see where
+	 * add_to_waiters() finds the lkb is already on the waiters
+	 * list and does lkb_wait_count++; hold_lkb().
+	 */
+	while (lkb->lkb_wait_count) {
+		lkb->lkb_wait_count--;
+		dlm_put_lkb(lkb);
+	}
+
+	WARN_ON_ONCE(!dlm_put_lkb(lkb));
 	return 0;
 }
 
@@ -826,7 +842,7 @@ static int release_lockspace(struct dlm_ls *ls, int force)
 	 * Free all lkb's in idr
 	 */
 
-	idr_for_each(&ls->ls_lkbidr, lkb_idr_free, ls);
+	idr_for_each(&ls->ls_lkbidr, lkb_idr_put, ls);
 	idr_destroy(&ls->ls_lkbidr);
 
 	/*
@@ -834,15 +850,12 @@ static int release_lockspace(struct dlm_ls *ls, int force)
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

