Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2701A40865
	for <gfs2@lists.linux.dev>; Fri,  8 Mar 2024 16:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709914708; cv=none; b=UBEPeN5e8c0IpKT/wn4lPQd8gcuGIheReOw+6xbw04fLCTYgbh4OCPui5Nz5h2Z4RjhYpTc4N+HbBJzrCEEAMngCwGvweoYbKmLGW1CnzcHm5+a/+eCP+AivyqoyDtzP9MKep5FH733lfpSnUwXV5i7DC/GqpSpm1dAIdSDbj6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709914708; c=relaxed/simple;
	bh=F1QBoqJfyGxC2wNt59MRGnaLn49gxcsCPgjJfpTb1UM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RS0Se2yqE2T/5TAgtwBhJD4JTCMCKhLYYECFlD/fX1z3FpGXkWUxCqPy9jBS2+66jJFmS0vFR0ZfqBLs5V9No/uHQoZ3Y0r7Vt6LuKHAnu1PGkO9wLtLJtoCpSdLIxdfRRW+q9z7BfCc8ODw22FIYGDfIJcQirTUs8g/a5a6IuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ib2zWmOa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ib2zWmOa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709914706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OFajttIH0SbWpmJ1MTVjWNxxIU5ZwqCT7C42WDYtFzI=;
	b=ib2zWmOauIefuAc3NQrv7Il131G+zKIJz3v7lJz1fwpq8rhMzVBZvP17yrqfmPZhw8J/w0
	40W823Ey6/QKe8oter0hzj3uk9nzaS5aLK0Tc3Q46A006eodYJtRQrB8DR1Rfi/WVUyJ/V
	jpoaSqoFB2n6bCaqK2wtevoHEptO46o=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-411-fuR2nLsgMfmVFWV4txzlIg-1; Fri,
 08 Mar 2024 11:18:24 -0500
X-MC-Unique: fuR2nLsgMfmVFWV4txzlIg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DA60B28EC10C
	for <gfs2@lists.linux.dev>; Fri,  8 Mar 2024 16:18:22 +0000 (UTC)
Received: from fs-i40c-03.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.fast.eng.rdu2.dc.redhat.com [10.6.23.54])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D10CF492BD6;
	Fri,  8 Mar 2024 16:18:22 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [RFC v6.8-rc6 1/7] dlm: fix user space lock decision to copy lvb
Date: Fri,  8 Mar 2024 11:18:12 -0500
Message-ID: <20240308161818.2388451-2-aahringo@redhat.com>
In-Reply-To: <20240308161818.2388451-1-aahringo@redhat.com>
References: <20240308161818.2388451-1-aahringo@redhat.com>
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

This patch fixes the copy lvb decision in case of user space DLM lock
requests. Currently the granted mode and requested mode is the same when
evaluating the dlm_lvb_operations matrix. That reflects the diagonal of
the dlm_lvb_operations matrix. Luckely it will mostly return a non zero
result on its diagonal, but in case of requested mode PW or EX the
diagonal returns 0, depending on the granted mode before the user might
get an invalid lvb data that is marked as valid.

This patch will move the decision if the lvb area should be copied or
not to the enqueue callback functionality because the granted mode is
known there. It also removes any lkb reference in the user callback
result delivery functionality that is required for a future fix.

Fixes: 61bed0baa4db ("fs: dlm: use a non-static queue for callbacks")
Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/ast.c          | 16 ++++++++++++++++
 fs/dlm/dlm_internal.h |  1 +
 fs/dlm/user.c         | 17 +++--------------
 3 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/fs/dlm/ast.c b/fs/dlm/ast.c
index 1f2f70a1b824..0582b6739b29 100644
--- a/fs/dlm/ast.c
+++ b/fs/dlm/ast.c
@@ -12,6 +12,7 @@
 #include <trace/events/dlm.h>
 
 #include "dlm_internal.h"
+#include "lvb_table.h"
 #include "memory.h"
 #include "lock.h"
 #include "user.h"
@@ -42,6 +43,7 @@ int dlm_enqueue_lkb_callback(struct dlm_lkb *lkb, uint32_t flags, int mode,
 	struct dlm_ls *ls = lkb->lkb_resource->res_ls;
 	int rv = DLM_ENQUEUE_CALLBACK_SUCCESS;
 	struct dlm_callback *cb;
+	bool copy_lvb = false;
 	int prev_mode;
 
 	if (flags & DLM_CB_BAST) {
@@ -73,6 +75,19 @@ int dlm_enqueue_lkb_callback(struct dlm_lkb *lkb, uint32_t flags, int mode,
 				goto out;
 			}
 		}
+
+		lkb->lkb_last_bast_time = ktime_get();
+		lkb->lkb_last_bast_mode = mode;
+	} else if (flags & DLM_CB_CAST) {
+		if (test_bit(DLM_DFL_USER_BIT, &lkb->lkb_dflags) && lkb->lkb_last_cast) {
+			prev_mode = lkb->lkb_last_cb->mode;
+
+			if (!status && lkb->lkb_lksb->sb_lvbptr &&
+			    dlm_lvb_operations[prev_mode + 1][mode + 1])
+				copy_lvb = true;
+		}
+
+		lkb->lkb_last_cast_time = ktime_get();
 	}
 
 	cb = dlm_allocate_cb();
@@ -85,6 +100,7 @@ int dlm_enqueue_lkb_callback(struct dlm_lkb *lkb, uint32_t flags, int mode,
 	cb->mode = mode;
 	cb->sb_status = status;
 	cb->sb_flags = (sbflags & 0x000000FF);
+	cb->copy_lvb = copy_lvb;
 	kref_init(&cb->ref);
 	if (!test_and_set_bit(DLM_IFL_CB_PENDING_BIT, &lkb->lkb_iflags))
 		rv = DLM_ENQUEUE_CALLBACK_NEED_SCHED;
diff --git a/fs/dlm/dlm_internal.h b/fs/dlm/dlm_internal.h
index dfc444dad329..1b608953e1b2 100644
--- a/fs/dlm/dlm_internal.h
+++ b/fs/dlm/dlm_internal.h
@@ -222,6 +222,7 @@ struct dlm_callback {
 	int			sb_status;	/* copy to lksb status */
 	uint8_t			sb_flags;	/* copy to lksb flags */
 	int8_t			mode; /* rq mode of bast, gr mode of cast */
+	bool			copy_lvb;
 
 	struct list_head	list;
 	struct kref		ref;
diff --git a/fs/dlm/user.c b/fs/dlm/user.c
index 695e691b38b3..337e91468aa4 100644
--- a/fs/dlm/user.c
+++ b/fs/dlm/user.c
@@ -21,7 +21,6 @@
 #include "dlm_internal.h"
 #include "lockspace.h"
 #include "lock.h"
-#include "lvb_table.h"
 #include "user.h"
 #include "ast.h"
 #include "config.h"
@@ -710,7 +709,7 @@ static int device_close(struct inode *inode, struct file *file)
 }
 
 static int copy_result_to_user(struct dlm_user_args *ua, int compat,
-			       uint32_t flags, int mode, int copy_lvb,
+			       uint32_t flags, int mode, bool copy_lvb,
 			       char __user *buf, size_t count)
 {
 #ifdef CONFIG_COMPAT
@@ -806,8 +805,7 @@ static ssize_t device_read(struct file *file, char __user *buf, size_t count,
 	struct dlm_lkb *lkb;
 	DECLARE_WAITQUEUE(wait, current);
 	struct dlm_callback *cb;
-	int rv, copy_lvb = 0;
-	int old_mode, new_mode;
+	int rv;
 
 	if (count == sizeof(struct dlm_device_version)) {
 		rv = copy_version_to_user(buf, count);
@@ -864,9 +862,6 @@ static ssize_t device_read(struct file *file, char __user *buf, size_t count,
 
 	lkb = list_first_entry(&proc->asts, struct dlm_lkb, lkb_cb_list);
 
-	/* rem_lkb_callback sets a new lkb_last_cast */
-	old_mode = lkb->lkb_last_cast->mode;
-
 	rv = dlm_dequeue_lkb_callback(lkb, &cb);
 	switch (rv) {
 	case DLM_DEQUEUE_CALLBACK_EMPTY:
@@ -895,12 +890,6 @@ static ssize_t device_read(struct file *file, char __user *buf, size_t count,
 	if (cb->flags & DLM_CB_BAST) {
 		trace_dlm_bast(lkb->lkb_resource->res_ls, lkb, cb->mode);
 	} else if (cb->flags & DLM_CB_CAST) {
-		new_mode = cb->mode;
-
-		if (!cb->sb_status && lkb->lkb_lksb->sb_lvbptr &&
-		    dlm_lvb_operations[old_mode + 1][new_mode + 1])
-			copy_lvb = 1;
-
 		lkb->lkb_lksb->sb_status = cb->sb_status;
 		lkb->lkb_lksb->sb_flags = cb->sb_flags;
 		trace_dlm_ast(lkb->lkb_resource->res_ls, lkb);
@@ -908,7 +897,7 @@ static ssize_t device_read(struct file *file, char __user *buf, size_t count,
 
 	rv = copy_result_to_user(lkb->lkb_ua,
 				 test_bit(DLM_PROC_FLAGS_COMPAT, &proc->flags),
-				 cb->flags, cb->mode, copy_lvb, buf, count);
+				 cb->flags, cb->mode, cb->copy_lvb, buf, count);
 
 	kref_put(&cb->ref, dlm_release_callback);
 
-- 
2.43.0

