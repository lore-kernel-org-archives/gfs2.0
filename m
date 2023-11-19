Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1471427E
	for <gfs2@lists.linux.dev>; Sun, 19 Nov 2023 16:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B+AsK2jm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700411906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qbGVJRZ93TXKBQPdY22pD/XOdizPbcNzEBj3YMYpHfo=;
	b=B+AsK2jmNfvax/moX8KLvElPH+J2NcxfdGCiiBxhscMCi1+Kmc9CbyXYiaTO9GQqRzmNbZ
	QyPQX2Vu/IeLcVO7DRpARQFnxQ5LdRhtg/WddWCtD3Lz22eI39xMD++JtmAZTugFDD+iHT
	py6cwH2xKPQEQIrsv43kfvls0J7h5ig=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-SJzcbDOCNDquVs2WRgLPiQ-1; Sun, 19 Nov 2023 11:38:23 -0500
X-MC-Unique: SJzcbDOCNDquVs2WRgLPiQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 91417828B20
	for <gfs2@lists.linux.dev>; Sun, 19 Nov 2023 16:38:23 +0000 (UTC)
Received: from fs-i40c-03.fs.lab.eng.bos.redhat.com (fs-i40c-03.fast.rdu2.eng.redhat.com [10.6.23.54])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 883CD40C6EBB;
	Sun, 19 Nov 2023 16:38:23 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCHv2 dlm/next 03/13] dlm: move root_list functionality to recover.c
Date: Sun, 19 Nov 2023 11:38:07 -0500
Message-Id: <20231119163817.751872-4-aahringo@redhat.com>
In-Reply-To: <20231119163817.751872-1-aahringo@redhat.com>
References: <20231119163817.751872-1-aahringo@redhat.com>
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

This patch moves dlm_create_root_list() and dlm_release_root_list() to
recover.c and declare them static because they are only used there.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/recover.c  | 42 ------------------------------------------
 fs/dlm/recover.h  |  2 --
 fs/dlm/recoverd.c | 39 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 39 insertions(+), 44 deletions(-)

diff --git a/fs/dlm/recover.c b/fs/dlm/recover.c
index ce6dc914cb86..6abc283f8f36 100644
--- a/fs/dlm/recover.c
+++ b/fs/dlm/recover.c
@@ -889,48 +889,6 @@ void dlm_recover_rsbs(struct dlm_ls *ls)
 
 /* Create a single list of all root rsb's to be used during recovery */
 
-int dlm_create_root_list(struct dlm_ls *ls)
-{
-	struct rb_node *n;
-	struct dlm_rsb *r;
-	int i, error = 0;
-
-	down_write(&ls->ls_root_sem);
-	if (!list_empty(&ls->ls_root_list)) {
-		log_error(ls, "root list not empty");
-		error = -EINVAL;
-		goto out;
-	}
-
-	for (i = 0; i < ls->ls_rsbtbl_size; i++) {
-		spin_lock(&ls->ls_rsbtbl[i].lock);
-		for (n = rb_first(&ls->ls_rsbtbl[i].keep); n; n = rb_next(n)) {
-			r = rb_entry(n, struct dlm_rsb, res_hashnode);
-			list_add(&r->res_root_list, &ls->ls_root_list);
-			dlm_hold_rsb(r);
-		}
-
-		if (!RB_EMPTY_ROOT(&ls->ls_rsbtbl[i].toss))
-			log_error(ls, "dlm_create_root_list toss not empty");
-		spin_unlock(&ls->ls_rsbtbl[i].lock);
-	}
- out:
-	up_write(&ls->ls_root_sem);
-	return error;
-}
-
-void dlm_release_root_list(struct dlm_ls *ls)
-{
-	struct dlm_rsb *r, *safe;
-
-	down_write(&ls->ls_root_sem);
-	list_for_each_entry_safe(r, safe, &ls->ls_root_list, res_root_list) {
-		list_del_init(&r->res_root_list);
-		dlm_put_rsb(r);
-	}
-	up_write(&ls->ls_root_sem);
-}
-
 void dlm_clear_toss(struct dlm_ls *ls)
 {
 	struct rb_node *n, *next;
diff --git a/fs/dlm/recover.h b/fs/dlm/recover.h
index dbc51013ecad..0b54550ee055 100644
--- a/fs/dlm/recover.h
+++ b/fs/dlm/recover.h
@@ -23,8 +23,6 @@ int dlm_recover_masters(struct dlm_ls *ls, uint64_t seq);
 int dlm_recover_master_reply(struct dlm_ls *ls, const struct dlm_rcom *rc);
 int dlm_recover_locks(struct dlm_ls *ls, uint64_t seq);
 void dlm_recovered_lock(struct dlm_rsb *r);
-int dlm_create_root_list(struct dlm_ls *ls);
-void dlm_release_root_list(struct dlm_ls *ls);
 void dlm_clear_toss(struct dlm_ls *ls);
 void dlm_recover_rsbs(struct dlm_ls *ls);
 
diff --git a/fs/dlm/recoverd.c b/fs/dlm/recoverd.c
index 4d17491dea2f..8eb42554ccb0 100644
--- a/fs/dlm/recoverd.c
+++ b/fs/dlm/recoverd.c
@@ -20,6 +20,45 @@
 #include "requestqueue.h"
 #include "recoverd.h"
 
+static void dlm_create_root_list(struct dlm_ls *ls)
+{
+	struct rb_node *n;
+	struct dlm_rsb *r;
+	int i;
+
+	down_write(&ls->ls_root_sem);
+	if (!list_empty(&ls->ls_root_list)) {
+		log_error(ls, "root list not empty");
+		goto out;
+	}
+
+	for (i = 0; i < ls->ls_rsbtbl_size; i++) {
+		spin_lock_bh(&ls->ls_rsbtbl[i].lock);
+		for (n = rb_first(&ls->ls_rsbtbl[i].keep); n; n = rb_next(n)) {
+			r = rb_entry(n, struct dlm_rsb, res_hashnode);
+			list_add(&r->res_root_list, &ls->ls_root_list);
+			dlm_hold_rsb(r);
+		}
+
+		if (!RB_EMPTY_ROOT(&ls->ls_rsbtbl[i].toss))
+			log_error(ls, "%s toss not empty", __func__);
+		spin_unlock_bh(&ls->ls_rsbtbl[i].lock);
+	}
+ out:
+	up_write(&ls->ls_root_sem);
+}
+
+static void dlm_release_root_list(struct dlm_ls *ls)
+{
+	struct dlm_rsb *r, *safe;
+
+	down_write(&ls->ls_root_sem);
+	list_for_each_entry_safe(r, safe, &ls->ls_root_list, res_root_list) {
+		list_del_init(&r->res_root_list);
+		dlm_put_rsb(r);
+	}
+	up_write(&ls->ls_root_sem);
+}
 
 /* If the start for which we're re-enabling locking (seq) has been superseded
    by a newer stop (ls_recover_seq), we need to leave locking disabled.
-- 
2.39.3

