Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E5122324
	for <gfs2@lists.linux.dev>; Wed, 17 Apr 2024 19:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713381211; cv=none; b=gUoSKOu4Fti19uIfK7IKSuP3yp8gN3s/EdU/FfcozJABzufnH/l7LuTbB9fNjeWxfRLfzEzTDvhwUTSJiupa5SPtLiNd81mS5NPIUWZi1egUGnYLpWcmdrktyWfJxv2Kl20/ZcEybnC+4XWA9jyz2adfGm7Bs+k6J+8d4BOfWGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713381211; c=relaxed/simple;
	bh=NzEOmZxnGLUU4WiIYkbePVmxpGcSXEmE+FJSaJmuLtg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RNNx9gx8Rgifv35v+1yf03EJ2Vo9qLKlFhNngE6kQJMPggByXduPE2dxufdI59qgyNYm5xcjRw7Xlcu6kjlVE0A5vyZF/g4gpulKYuRqU+GJ0/bIQo6uFhNm51QZRuYej2W05xlgErlG3FTIZB7wjT3+LQZy9YCPkiDJ/YjGdCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jNqNPyHI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jNqNPyHI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713381208;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RnR38b0QcdM9mU9AXbgtdqQPPfQLFpak54cHHtMCNBQ=;
	b=jNqNPyHIz7VT+x9Qx/y77f3G+MGoQkb/AGiPC1nSurkR3tzXJ8l1KAwgUwLMUOYVm2OlBK
	vOrt0dr1Cfo0txcntTr44Kcgm/YwPb0C1j8wsa9109LXXMqbmjwj4tjWM0qV3/eZRHT4Uu
	T7UkB9DYvJagtWRm4wwtcQlr7inh+CE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-384-P45hNQOEN5OV7-diYGdFlg-1; Wed,
 17 Apr 2024 15:13:24 -0400
X-MC-Unique: P45hNQOEN5OV7-diYGdFlg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D50AC1C0514E;
	Wed, 17 Apr 2024 19:13:23 +0000 (UTC)
Received: from fs-i40c-03.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B8C1A2166B31;
	Wed, 17 Apr 2024 19:13:23 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	dan.carpenter@linaro.org,
	aahringo@redhat.com
Subject: [PATCH dlm/next] dlm: fix sleep in atomic context
Date: Wed, 17 Apr 2024 15:13:22 -0400
Message-ID: <20240417191322.952359-1-aahringo@redhat.com>
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

This patch changes the orphans mutex to a spinlock since commit
c288745f1d4a ("dlm: avoid blocking receive at the end of recovery") is
using a rwlock_t to lock the DLM message receive path and do_purge() can
be called while this lock is held that forbids to sleep.

We need to use spin_lock_bh() because also a user context that calls
dlm_user_purge() can call do_purge() and since commit 92d59adfaf71
("dlm: do message processing in softirq context") the DLM message
receive path is done under softirq context.

Fixes: c288745f1d4a ("dlm: avoid blocking receive at the end of recovery")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/gfs2/9ad928eb-2ece-4ad9-a79c-d2bce228e4bc@moroto.mountain/
Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/dlm_internal.h |  2 +-
 fs/dlm/lock.c         | 12 ++++++------
 fs/dlm/lockspace.c    |  2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/dlm/dlm_internal.h b/fs/dlm/dlm_internal.h
index 19e57cbd5b13..9085ba3b2f20 100644
--- a/fs/dlm/dlm_internal.h
+++ b/fs/dlm/dlm_internal.h
@@ -602,7 +602,7 @@ struct dlm_ls {
 	spinlock_t		ls_waiters_lock;
 	struct list_head	ls_waiters;	/* lkbs needing a reply */
 
-	struct mutex		ls_orphans_mutex;
+	spinlock_t		ls_orphans_lock;
 	struct list_head	ls_orphans;
 
 	spinlock_t		ls_new_rsb_spin;
diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index bbbc9593a64e..f103b8c30592 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -5880,7 +5880,7 @@ int dlm_user_adopt_orphan(struct dlm_ls *ls, struct dlm_user_args *ua_tmp,
 	int found_other_mode = 0;
 	int rv = 0;
 
-	mutex_lock(&ls->ls_orphans_mutex);
+	spin_lock_bh(&ls->ls_orphans_lock);
 	list_for_each_entry(iter, &ls->ls_orphans, lkb_ownqueue) {
 		if (iter->lkb_resource->res_length != namelen)
 			continue;
@@ -5897,7 +5897,7 @@ int dlm_user_adopt_orphan(struct dlm_ls *ls, struct dlm_user_args *ua_tmp,
 		*lkid = iter->lkb_id;
 		break;
 	}
-	mutex_unlock(&ls->ls_orphans_mutex);
+	spin_unlock_bh(&ls->ls_orphans_lock);
 
 	if (!lkb && found_other_mode) {
 		rv = -EAGAIN;
@@ -6089,9 +6089,9 @@ static int orphan_proc_lock(struct dlm_ls *ls, struct dlm_lkb *lkb)
 	int error;
 
 	hold_lkb(lkb); /* reference for the ls_orphans list */
-	mutex_lock(&ls->ls_orphans_mutex);
+	spin_lock_bh(&ls->ls_orphans_lock);
 	list_add_tail(&lkb->lkb_ownqueue, &ls->ls_orphans);
-	mutex_unlock(&ls->ls_orphans_mutex);
+	spin_unlock_bh(&ls->ls_orphans_lock);
 
 	set_unlock_args(0, lkb->lkb_ua, &args);
 
@@ -6241,7 +6241,7 @@ static void do_purge(struct dlm_ls *ls, int nodeid, int pid)
 {
 	struct dlm_lkb *lkb, *safe;
 
-	mutex_lock(&ls->ls_orphans_mutex);
+	spin_lock_bh(&ls->ls_orphans_lock);
 	list_for_each_entry_safe(lkb, safe, &ls->ls_orphans, lkb_ownqueue) {
 		if (pid && lkb->lkb_ownpid != pid)
 			continue;
@@ -6249,7 +6249,7 @@ static void do_purge(struct dlm_ls *ls, int nodeid, int pid)
 		list_del_init(&lkb->lkb_ownqueue);
 		dlm_put_lkb(lkb);
 	}
-	mutex_unlock(&ls->ls_orphans_mutex);
+	spin_unlock_bh(&ls->ls_orphans_lock);
 }
 
 static int send_purge(struct dlm_ls *ls, int nodeid, int pid)
diff --git a/fs/dlm/lockspace.c b/fs/dlm/lockspace.c
index 5ce26882159e..ed23787271b1 100644
--- a/fs/dlm/lockspace.c
+++ b/fs/dlm/lockspace.c
@@ -436,7 +436,7 @@ static int new_lockspace(const char *name, const char *cluster,
 	INIT_LIST_HEAD(&ls->ls_waiters);
 	spin_lock_init(&ls->ls_waiters_lock);
 	INIT_LIST_HEAD(&ls->ls_orphans);
-	mutex_init(&ls->ls_orphans_mutex);
+	spin_lock_init(&ls->ls_orphans_lock);
 
 	INIT_LIST_HEAD(&ls->ls_new_rsb);
 	spin_lock_init(&ls->ls_new_rsb_spin);
-- 
2.43.0

