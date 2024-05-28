Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E637017B41C
	for <gfs2@lists.linux.dev>; Tue, 28 May 2024 21:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716930771; cv=none; b=RIL0lKB4NasDs8e6Xou0u9RKlWuxeFrKkfKu5jNqyJLUOuIxNf8Ok5zXDDV8D+Q1+4mm+amsG5ocLjv+Y0UuGFUcIGSgRkSHwoOvZsYe3+2W2Y7rYu3PoUIOQOlbJZuuaPFgZU/FHx1r934V6cA3hRpvs2C2YIfrKYodnYTz8bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716930771; c=relaxed/simple;
	bh=Yp+QvKuNahvsH1drUcvrspzyJChAv1muwgbljdFP8Bc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sdus6xmF77Yc1oFH4DE5QbGj+Ffg5Ujq/eTqwTkrd1A752/BMFnm7Ct4IFXQvYydRgjMM8bfUSqPFhHGQyD2cW3+rf0HRd7vKpSuqQ3rYx6wnWkpOIra18RoBMqNhpnCgYyGDSv+jZ1AmhkJzZahUkxlVEwz1798zmZwHg2sw10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z8zsQF2H; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z8zsQF2H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716930769;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dDGcWe+W4NKF/U+0s1Zpz8q2ImaYij2qb5AqCqdhGm0=;
	b=Z8zsQF2HCO5uBhiyZdSmuOJAAedFkd/1mOp/QWxOzg03ClQQp18tLkVPswseTXVyEx483R
	2bpNa1/y/VZZIPUWcgig6T91cHo+KSfj9YefwZQj+Ky40IjDUmcFOcj5J1uBI2bSzI076q
	+g/Q7aB4I/rt5W+mcFsA+prHETTk0Eo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677-yfzm5CcJN2adfwpYHOFG6Q-1; Tue,
 28 May 2024 17:12:47 -0400
X-MC-Unique: yfzm5CcJN2adfwpYHOFG6Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 059C1380670C
	for <gfs2@lists.linux.dev>; Tue, 28 May 2024 21:12:47 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by smtp.corp.redhat.com (Postfix) with ESMTP id EE9B6200B3A1;
	Tue, 28 May 2024 21:12:46 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCH v6.10-rc1 05/11] dlm: rename dlm_find_lockspace_local to dlm_get_lockspace
Date: Tue, 28 May 2024 17:12:35 -0400
Message-ID: <20240528211241.2140441-5-aahringo@redhat.com>
In-Reply-To: <20240528211241.2140441-1-aahringo@redhat.com>
References: <20240528211241.2140441-1-aahringo@redhat.com>
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

Previous patch got rid of the unnecessary loop to lookup the lockspace
pointer but the pointer to lookup was already the pointer that was
looking for. The purpose of dlm_find_lockspace_local() is more a
dlm_get_lockspace() to avoid lockspace releases. There is another
question if dlm_get_lockspace() is really necessary to call as it is
called in a lockspace resource itself and during this time the lockspace
cannot be freed as it is used by e.g. udev. Another questionable current
handling is refcounting when calling dlm api that might be an DLM user
problem because calling dlm_lockspace_release() when there are still
pending API calls around. However this might need more of a full code
review in future to remove some of them.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/lock.c      |  4 ++--
 fs/dlm/lockspace.c |  8 ++++----
 fs/dlm/lockspace.h |  2 +-
 fs/dlm/plock.c     |  8 ++++----
 fs/dlm/recoverd.c  |  4 ++--
 fs/dlm/user.c      | 12 ++++++------
 6 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index e66972ed97b1..205d6a20fcee 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -3391,7 +3391,7 @@ int dlm_lock(dlm_lockspace_t *lockspace,
 	struct dlm_args args;
 	int error, convert = flags & DLM_LKF_CONVERT;
 
-	ls = dlm_find_lockspace_local(lockspace);
+	ls = dlm_get_lockspace(lockspace);
 	if (!ls)
 		return -EINVAL;
 
@@ -3443,7 +3443,7 @@ int dlm_unlock(dlm_lockspace_t *lockspace,
 	struct dlm_args args;
 	int error;
 
-	ls = dlm_find_lockspace_local(lockspace);
+	ls = dlm_get_lockspace(lockspace);
 	if (!ls)
 		return -EINVAL;
 
diff --git a/fs/dlm/lockspace.c b/fs/dlm/lockspace.c
index 8155d7475c79..d25a09d6c710 100644
--- a/fs/dlm/lockspace.c
+++ b/fs/dlm/lockspace.c
@@ -38,7 +38,7 @@ static ssize_t dlm_control_store(struct dlm_ls *ls, const char *buf, size_t len)
 
 	if (rc)
 		return rc;
-	ls = dlm_find_lockspace_local(ls);
+	ls = dlm_get_lockspace(ls);
 	if (!ls)
 		return -EINVAL;
 
@@ -263,7 +263,7 @@ struct dlm_ls *dlm_find_lockspace_global(uint32_t id)
 	return ls;
 }
 
-struct dlm_ls *dlm_find_lockspace_local(dlm_lockspace_t *lockspace)
+struct dlm_ls *dlm_get_lockspace(dlm_lockspace_t *lockspace)
 {
 	struct dlm_ls *ls = lockspace;
 
@@ -794,12 +794,12 @@ static int release_lockspace(struct dlm_ls *ls, int force)
  * 3 - destroy lockspace as part of a forced shutdown
  */
 
-int dlm_release_lockspace(void *lockspace, int force)
+int dlm_release_lockspace(dlm_lockspace_t *lockspace, int force)
 {
 	struct dlm_ls *ls;
 	int error;
 
-	ls = dlm_find_lockspace_local(lockspace);
+	ls = dlm_get_lockspace(lockspace);
 	if (!ls)
 		return -EINVAL;
 	dlm_put_lockspace(ls);
diff --git a/fs/dlm/lockspace.h b/fs/dlm/lockspace.h
index 47ebd4411926..d59ce3fea03b 100644
--- a/fs/dlm/lockspace.h
+++ b/fs/dlm/lockspace.h
@@ -23,7 +23,7 @@
 int dlm_lockspace_init(void);
 void dlm_lockspace_exit(void);
 struct dlm_ls *dlm_find_lockspace_global(uint32_t id);
-struct dlm_ls *dlm_find_lockspace_local(void *id);
+struct dlm_ls *dlm_get_lockspace(dlm_lockspace_t *lockspace);
 struct dlm_ls *dlm_find_lockspace_device(int minor);
 void dlm_put_lockspace(struct dlm_ls *ls);
 void dlm_stop_lockspaces(void);
diff --git a/fs/dlm/plock.c b/fs/dlm/plock.c
index 9ca83ef70ed1..1ff172718d59 100644
--- a/fs/dlm/plock.c
+++ b/fs/dlm/plock.c
@@ -127,7 +127,7 @@ int dlm_posix_lock(dlm_lockspace_t *lockspace, u64 number, struct file *file,
 	struct plock_op *op;
 	int rv;
 
-	ls = dlm_find_lockspace_local(lockspace);
+	ls = dlm_get_lockspace(lockspace);
 	if (!ls)
 		return -EINVAL;
 
@@ -293,7 +293,7 @@ int dlm_posix_unlock(dlm_lockspace_t *lockspace, u64 number, struct file *file,
 	int rv;
 	unsigned char saved_flags = fl->c.flc_flags;
 
-	ls = dlm_find_lockspace_local(lockspace);
+	ls = dlm_get_lockspace(lockspace);
 	if (!ls)
 		return -EINVAL;
 
@@ -370,7 +370,7 @@ int dlm_posix_cancel(dlm_lockspace_t *lockspace, u64 number, struct file *file,
 	if (WARN_ON_ONCE(!fl->fl_lmops || !fl->fl_lmops->lm_grant))
 		return -EOPNOTSUPP;
 
-	ls = dlm_find_lockspace_local(lockspace);
+	ls = dlm_get_lockspace(lockspace);
 	if (!ls)
 		return -EINVAL;
 
@@ -426,7 +426,7 @@ int dlm_posix_get(dlm_lockspace_t *lockspace, u64 number, struct file *file,
 	struct plock_op *op;
 	int rv;
 
-	ls = dlm_find_lockspace_local(lockspace);
+	ls = dlm_get_lockspace(lockspace);
 	if (!ls)
 		return -EINVAL;
 
diff --git a/fs/dlm/recoverd.c b/fs/dlm/recoverd.c
index 17a40d1e6036..7e6c2c27d815 100644
--- a/fs/dlm/recoverd.c
+++ b/fs/dlm/recoverd.c
@@ -389,9 +389,9 @@ static void do_ls_recovery(struct dlm_ls *ls)
 
 static int dlm_recoverd(void *arg)
 {
-	struct dlm_ls *ls;
+	struct dlm_ls *ls = arg;
 
-	ls = dlm_find_lockspace_local(arg);
+	ls = dlm_get_lockspace(arg);
 	if (!ls) {
 		log_print("dlm_recoverd: no lockspace %p", arg);
 		return -1;
diff --git a/fs/dlm/user.c b/fs/dlm/user.c
index f6635a5314f4..73d7fa768f73 100644
--- a/fs/dlm/user.c
+++ b/fs/dlm/user.c
@@ -259,7 +259,7 @@ static int device_user_lock(struct dlm_user_proc *proc,
 	uint32_t lkid;
 	int error = -ENOMEM;
 
-	ls = dlm_find_lockspace_local(proc->lockspace);
+	ls = dlm_get_lockspace(proc->lockspace);
 	if (!ls)
 		return -ENOENT;
 
@@ -309,7 +309,7 @@ static int device_user_unlock(struct dlm_user_proc *proc,
 	struct dlm_user_args *ua;
 	int error = -ENOMEM;
 
-	ls = dlm_find_lockspace_local(proc->lockspace);
+	ls = dlm_get_lockspace(proc->lockspace);
 	if (!ls)
 		return -ENOENT;
 
@@ -337,7 +337,7 @@ static int device_user_deadlock(struct dlm_user_proc *proc,
 	struct dlm_ls *ls;
 	int error;
 
-	ls = dlm_find_lockspace_local(proc->lockspace);
+	ls = dlm_get_lockspace(proc->lockspace);
 	if (!ls)
 		return -ENOENT;
 
@@ -398,7 +398,7 @@ static int device_user_purge(struct dlm_user_proc *proc,
 	struct dlm_ls *ls;
 	int error;
 
-	ls = dlm_find_lockspace_local(proc->lockspace);
+	ls = dlm_get_lockspace(proc->lockspace);
 	if (!ls)
 		return -ENOENT;
 
@@ -423,7 +423,7 @@ static int device_create_lockspace(struct dlm_lspace_params *params)
 	if (error)
 		return error;
 
-	ls = dlm_find_lockspace_local(lockspace);
+	ls = dlm_get_lockspace(lockspace);
 	if (!ls)
 		return -ENOENT;
 
@@ -674,7 +674,7 @@ static int device_close(struct inode *inode, struct file *file)
 	struct dlm_user_proc *proc = file->private_data;
 	struct dlm_ls *ls;
 
-	ls = dlm_find_lockspace_local(proc->lockspace);
+	ls = dlm_get_lockspace(proc->lockspace);
 	if (!ls)
 		return -ENOENT;
 
-- 
2.43.0

