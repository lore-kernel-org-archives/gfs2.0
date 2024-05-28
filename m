Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574FF17B42D
	for <gfs2@lists.linux.dev>; Tue, 28 May 2024 21:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716930773; cv=none; b=gvQJblKdkfzt19PK4dM8uL9If9Qo76ki5+7S1NIi4/uTXif2u/J0oZvwM3GklLlpkXDJ2K1xB0JWeP8vys9dsad4XmvCqjFsOBubjdn6xKJjljD3ANr4wkc4VMZlyEQDpfWXc8E/UqysCYwzMH6VD1BncfpvzzYF72YEuDW0i1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716930773; c=relaxed/simple;
	bh=HnLP/y8GSvf94eN1dyi4SGPLJ0qAnChFA2EoFxCWw50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HGWvAV5qWzDqOqk7UReVHacLyVpIb0goNvu19SJveSIsS00vIlY0xMPZcnvEBpimCvs3r+SvBEsYUpKIwj5Y1HkziI7Hte7jeh35biUNhwn9WO00cL5ekqgXmH4Qg5knwjDQKoOmv6NVB8ncCYFwOnOJAqcChArb6GMumy9M7xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DBrbb38c; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DBrbb38c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716930769;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JbFxF71yQDvmtEcINvj/3E7EQgapkGHnegFH97ABx0U=;
	b=DBrbb38cuMwiZtjmO4OmKEEepSSjraSEv4BJYumhoZY/Zm9IRw70NlMfh79ohCh0aDAlo7
	UPHPq/9n+nbRjjmxzCnzbvMMfDfsX8CDaVXCrxaVQncw3dkynPWIG4mM1qnliWY6Ei4ax8
	s9Gne/ip7u45OXGp9J/KCfV0OjxcCM4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-622-RpAEEs0zP2CsBucYfFb7ug-1; Tue,
 28 May 2024 17:12:47 -0400
X-MC-Unique: RpAEEs0zP2CsBucYfFb7ug-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EFBC53C025A1
	for <gfs2@lists.linux.dev>; Tue, 28 May 2024 21:12:46 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E6B3B200A877;
	Tue, 28 May 2024 21:12:46 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCH v6.10-rc1 04/11] dlm: remove ls_local_handle from struct dlm_ls
Date: Tue, 28 May 2024 17:12:34 -0400
Message-ID: <20240528211241.2140441-4-aahringo@redhat.com>
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

This patch removes ls_local_handle from struct dlm_ls as it stores the
ls pointer of the top level structure itesef and this isn't necessary.
There is a lookup functionality to lookup the lockspace in
dlm_find_lockspace_local() but the given input parameter is the pointer
already. This might be more safe to lookup a lockspace but given a wrong
lockspace pointer is a bug in the code and we save the additional lookup
here. The dlm_ls structure can be still hidden by using dlm_lockspace_t
handle pointer.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/dlm_internal.h |  1 -
 fs/dlm/lockspace.c    | 16 +++-------------
 fs/dlm/user.c         |  4 ++--
 3 files changed, 5 insertions(+), 16 deletions(-)

diff --git a/fs/dlm/dlm_internal.h b/fs/dlm/dlm_internal.h
index 9618ce0720d9..e93ed8f7addd 100644
--- a/fs/dlm/dlm_internal.h
+++ b/fs/dlm/dlm_internal.h
@@ -561,7 +561,6 @@ struct rcom_lock {
 
 struct dlm_ls {
 	struct list_head	ls_list;	/* list of lockspaces */
-	dlm_lockspace_t		*ls_local_handle;
 	uint32_t		ls_global_id;	/* global unique lockspace ID */
 	uint32_t		ls_generation;
 	uint32_t		ls_exflags;
diff --git a/fs/dlm/lockspace.c b/fs/dlm/lockspace.c
index b6a1a6eb7f27..8155d7475c79 100644
--- a/fs/dlm/lockspace.c
+++ b/fs/dlm/lockspace.c
@@ -38,7 +38,7 @@ static ssize_t dlm_control_store(struct dlm_ls *ls, const char *buf, size_t len)
 
 	if (rc)
 		return rc;
-	ls = dlm_find_lockspace_local(ls->ls_local_handle);
+	ls = dlm_find_lockspace_local(ls);
 	if (!ls)
 		return -EINVAL;
 
@@ -265,18 +265,9 @@ struct dlm_ls *dlm_find_lockspace_global(uint32_t id)
 
 struct dlm_ls *dlm_find_lockspace_local(dlm_lockspace_t *lockspace)
 {
-	struct dlm_ls *ls;
+	struct dlm_ls *ls = lockspace;
 
-	spin_lock_bh(&lslist_lock);
-	list_for_each_entry(ls, &lslist, ls_list) {
-		if (ls->ls_local_handle == lockspace) {
-			atomic_inc(&ls->ls_count);
-			goto out;
-		}
-	}
-	ls = NULL;
- out:
-	spin_unlock_bh(&lslist_lock);
+	atomic_inc(&ls->ls_count);
 	return ls;
 }
 
@@ -496,7 +487,6 @@ static int new_lockspace(const char *name, const char *cluster,
 	idr_init(&ls->ls_recover_idr);
 	spin_lock_init(&ls->ls_recover_idr_lock);
 	ls->ls_recover_list_count = 0;
-	ls->ls_local_handle = ls;
 	init_waitqueue_head(&ls->ls_wait_general);
 	INIT_LIST_HEAD(&ls->ls_masters_list);
 	rwlock_init(&ls->ls_masters_lock);
diff --git a/fs/dlm/user.c b/fs/dlm/user.c
index 3173b974e8c8..f6635a5314f4 100644
--- a/fs/dlm/user.c
+++ b/fs/dlm/user.c
@@ -454,7 +454,7 @@ static int device_remove_lockspace(struct dlm_lspace_params *params)
 	if (params->flags & DLM_USER_LSFLG_FORCEFREE)
 		force = 2;
 
-	lockspace = ls->ls_local_handle;
+	lockspace = ls;
 	dlm_put_lockspace(ls);
 
 	/* The final dlm_release_lockspace waits for references to go to
@@ -657,7 +657,7 @@ static int device_open(struct inode *inode, struct file *file)
 		return -ENOMEM;
 	}
 
-	proc->lockspace = ls->ls_local_handle;
+	proc->lockspace = ls;
 	INIT_LIST_HEAD(&proc->asts);
 	INIT_LIST_HEAD(&proc->locks);
 	INIT_LIST_HEAD(&proc->unlocking);
-- 
2.43.0

