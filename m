Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DAB85947
	for <gfs2@lists.linux.dev>; Mon, 29 Jul 2024 19:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722281806; cv=none; b=L7CLnbQoO7ITOC7kgLaK1toyNDoiNOF4QRkAIHdi8iKRnUUG62BzU1p8Xw85EbmyyoLiEixR73/MU8LGyHL4qvKyA22bLW1PA2JOxQTQO8RIQF+GRujmAFsMMgFqx9P+giPqS9p4rqZWVNdxKJlxm80GxpQmDvwy3Sa+jZZLTfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722281806; c=relaxed/simple;
	bh=95fnvll8uXopA8SwJHVRBqlNhI3pR6qzlwSKBTanrC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EUZiKbGBSCGZqS1Y0hVYCjWfM5QWkOqbJCHP7abCX3eJwAQNuON9TPT8FM2iLqkT2R2kJYVvkDjdOmJUbPBVH9Fx73z0EbBwPt2Z0QOOPXkewMmrekot7704LUSqeCqGZRAtl0W++JfjWGjG6SpLrXSfB/92fd0SALI5iR7x5N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WhDOFU8g; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WhDOFU8g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722281803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TfA0gyI9wcOL2eyq0HO8IQOs3T3yil2ksShp7vFHA7Y=;
	b=WhDOFU8g7fPXXsHZ3PpN4f8HjiDPqEQB3nvWI9RF5Y9pS0XG9DVVjpS/bvK/3gSO5/RkBq
	9jfFD+5c5M0dlH/yvcIrIEjZuoXTndEybmwD2mo9qC3QQ6lZtG1g4m0lORHC82a/Vo2Kjd
	fScuzeGz3XFFBIAea0he3z7vNsPP3D4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-637-TMrbAHhQOrirkNZUY-uYXA-1; Mon,
 29 Jul 2024 15:36:42 -0400
X-MC-Unique: TMrbAHhQOrirkNZUY-uYXA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1D99719560A2
	for <gfs2@lists.linux.dev>; Mon, 29 Jul 2024 19:36:41 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 717EA1955D42;
	Mon, 29 Jul 2024 19:36:40 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCH v6.11-rc1 05/10] dlm: drop kobject release callback handling
Date: Mon, 29 Jul 2024 15:36:25 -0400
Message-ID: <20240729193630.3344082-5-aahringo@redhat.com>
In-Reply-To: <20240729193630.3344082-1-aahringo@redhat.com>
References: <20240729193630.3344082-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

This patch removes the releasing of the "struct dlm ls" resource out of
the kobject handling. Instead we run kfree() after kobject_put() of the
lockspace kobject structure that should always being the last put call.
This prepares to split the releasing of all lockspace resources
asynchronously in the background and just deregister everything in
release_lockspace().

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/lockspace.c | 22 +++++-----------------
 1 file changed, 5 insertions(+), 17 deletions(-)

diff --git a/fs/dlm/lockspace.c b/fs/dlm/lockspace.c
index 1848cbbc96a9..bf14016d53e1 100644
--- a/fs/dlm/lockspace.c
+++ b/fs/dlm/lockspace.c
@@ -174,12 +174,6 @@ static ssize_t dlm_attr_store(struct kobject *kobj, struct attribute *attr,
 	return a->store ? a->store(ls, buf, len) : len;
 }
 
-static void lockspace_kobj_release(struct kobject *k)
-{
-	struct dlm_ls *ls  = container_of(k, struct dlm_ls, ls_kobj);
-	kfree(ls);
-}
-
 static const struct sysfs_ops dlm_attr_ops = {
 	.show  = dlm_attr_show,
 	.store = dlm_attr_store,
@@ -188,7 +182,6 @@ static const struct sysfs_ops dlm_attr_ops = {
 static struct kobj_type dlm_ktype = {
 	.default_groups = dlm_groups,
 	.sysfs_ops     = &dlm_attr_ops,
-	.release       = lockspace_kobj_release,
 };
 
 static struct kset *dlm_kset;
@@ -328,7 +321,6 @@ static int new_lockspace(const char *name, const char *cluster,
 			 int *ops_result, dlm_lockspace_t **lockspace)
 {
 	struct dlm_ls *ls;
-	int do_unreg = 0;
 	int namelen = strlen(name);
 	int error;
 
@@ -530,9 +522,6 @@ static int new_lockspace(const char *name, const char *cluster,
 	wait_event(ls->ls_recover_lock_wait,
 		   test_bit(LSFL_RECOVER_LOCK, &ls->ls_flags));
 
-	/* let kobject handle freeing of ls if there's an error */
-	do_unreg = 1;
-
 	ls->ls_kobj.kset = dlm_kset;
 	error = kobject_init_and_add(&ls->ls_kobj, &dlm_ktype, NULL,
 				     "%s", ls->ls_name);
@@ -580,10 +569,8 @@ static int new_lockspace(const char *name, const char *cluster,
 	xa_destroy(&ls->ls_lkbxa);
 	rhashtable_destroy(&ls->ls_rsbtbl);
  out_lsfree:
-	if (do_unreg)
-		kobject_put(&ls->ls_kobj);
-	else
-		kfree(ls);
+	kobject_put(&ls->ls_kobj);
+	kfree(ls);
  out:
 	module_put(THIS_MODULE);
 	return error;
@@ -743,6 +730,8 @@ static int release_lockspace(struct dlm_ls *ls, int force)
 
 	dlm_delete_debug_file(ls);
 
+	kobject_put(&ls->ls_kobj);
+
 	xa_destroy(&ls->ls_recover_xa);
 	kfree(ls->ls_recover_buf);
 
@@ -769,8 +758,7 @@ static int release_lockspace(struct dlm_ls *ls, int force)
 	dlm_clear_members_gone(ls);
 	kfree(ls->ls_node_array);
 	log_rinfo(ls, "release_lockspace final free");
-	kobject_put(&ls->ls_kobj);
-	/* The ls structure will be freed when the kobject is done with */
+	kfree(ls);
 
 	module_put(THIS_MODULE);
 	return 0;
-- 
2.43.0

