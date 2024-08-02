Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C566B15C128
	for <gfs2@lists.linux.dev>; Fri,  2 Aug 2024 17:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722619636; cv=none; b=OnUPbtLrbQNsz+kHoyLskGUNGw/TP5MLcL6cdKzYGhodYv3OZTK8MW0K6OggAcNvta1oiJ+6QHP0d764Dm3R/Ycr94XugHL99gCe0x1QAeHV9p13bvus5YpvfAxMvrQvsZn3LU4e299G0qV3Ovt5y2KXNQ76L1GiY6jne5moyMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722619636; c=relaxed/simple;
	bh=95fnvll8uXopA8SwJHVRBqlNhI3pR6qzlwSKBTanrC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZTiK5NF6PyOlbK3zoaEDA5mT8pyAjfrBi16RoRlQPi4O7R/epDjqvrez4iZwfDkBU3e7hhZ/D9ZNKENIay0P8wHc2c/b09tH5fafOxPJ0jbVFlRygH6o8Ua1gJs2UaSBUCbA9mPn4xLMOTvgt8eXSdLyUM3nASrmvEesOBwdbVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DHxAuGB8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DHxAuGB8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722619632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TfA0gyI9wcOL2eyq0HO8IQOs3T3yil2ksShp7vFHA7Y=;
	b=DHxAuGB8aG64pQdAW/8qC7febdkytF6g9y0H8ebIlmRZGFKe7Stbdc5d57/f9I5Mjvcq8e
	9QWr0d1141CgzmXjLuEvBq7Os5kUct7VMNTLbD6rVhhEjcsBDN6istpQTkCd0Y5Q4IDKAm
	MxAwKculj4bCXo2cDmMotuHggnbK6YI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-172-6MsoyCeBNXSZBi-xpP25HA-1; Fri,
 02 Aug 2024 13:27:10 -0400
X-MC-Unique: 6MsoyCeBNXSZBi-xpP25HA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 738391955D58
	for <gfs2@lists.linux.dev>; Fri,  2 Aug 2024 17:27:08 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B6C3819560AE;
	Fri,  2 Aug 2024 17:27:07 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCHv2 v6.11-rc1 05/10] dlm: drop kobject release callback handling
Date: Fri,  2 Aug 2024 13:26:42 -0400
Message-ID: <20240802172647.582745-5-aahringo@redhat.com>
In-Reply-To: <20240802172647.582745-1-aahringo@redhat.com>
References: <20240802172647.582745-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

