Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EE185947
	for <gfs2@lists.linux.dev>; Mon, 29 Jul 2024 19:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722281820; cv=none; b=K216HT5UeBCe/hNCk7NLyRj4IfYASxV5my7Pq6rTIDLgGVl0zUOeohzNxlXmNDuio4SWivnh1o8khhFOe9n4JQ+Y3aQMp0cMk7jXOkuBbfVQhALeE4u/hW1XJp28syN4uEvuVkt7J20crgbzToy5B04AngOD0UhKsTQwLZSHa6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722281820; c=relaxed/simple;
	bh=8Hoo1DrLpdD/YIF5wSHnDMauZj+lwETZmL77fJs+S3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qsndIzcU6qtBCLEV88OnIyAgKnluf4K/LTQAfs6EwNWnOvvbxzhm35GjhDDEfhNdwW00y93lUDr8aDoxLdw2XQLaxYAc/eVy/2A5ZDDWTzuwivSe8l+Vuk3wOtolfTvZo64po5ht9nVpF6qpnkN410iRT/o/MYcXRswKehYJFoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JJfbmSxq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JJfbmSxq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722281818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R/nREdBAI5U3tXdONd+0dX1YEdm6KfkO93wt/SjZ7rk=;
	b=JJfbmSxqbJJ/SdfpKNeHU6NYhiv3f3hCJsIAGyetGdX3Op6e/7X7SJjlZ2W4hqZNy1J7jE
	mFR+HWeVjP38GHzqqbtFElO2ixLXLY9iLZRX/ei0av5wvcaOHGcPuG3n8KKvHCTILydDUN
	02K8Vei2PdMfLQC7yAfX3PDhioKoUu0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-339-CgVQYv-eMYOe3ktfDyHSeA-1; Mon,
 29 Jul 2024 15:36:44 -0400
X-MC-Unique: CgVQYv-eMYOe3ktfDyHSeA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B42C61955D4B
	for <gfs2@lists.linux.dev>; Mon, 29 Jul 2024 19:36:43 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 14B321955D42;
	Mon, 29 Jul 2024 19:36:42 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCH v6.11-rc1 08/10] dlm: move dlm_search_rsb_tree() out of lock
Date: Mon, 29 Jul 2024 15:36:28 -0400
Message-ID: <20240729193630.3344082-8-aahringo@redhat.com>
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

The rhashtable structure is lockless for readers such as
rhashtable_lookup_fast(). It should be save to call this lookup
functionality out of holding ls_rsbtbl_lock to get the rsb pointer out
of the hash. This reduce the contention time of ls_rsbtbl_lock in some
cases. We still need to check if the rsb is part of the check as this
state can be changed while ls_rsbtbl_lock is not held. If its part of
the rhashtable data structure we take a reference to be sure it will not
be freed after we drop the ls_rsbtbl_lock read lock.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/lock.c | 77 +++++++++++++++++++++++++++++++--------------------
 1 file changed, 47 insertions(+), 30 deletions(-)

diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index 8bf3654f4827..9d3ec359d5e3 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -733,11 +733,13 @@ static int find_rsb_dir(struct dlm_ls *ls, const void *name, int len,
 	}
 
  retry:
+	error = dlm_search_rsb_tree(&ls->ls_rsbtbl, name, len, &r);
+	if (error)
+		goto do_new;
 
 	/* check if the rsb is active under read lock - likely path */
 	read_lock_bh(&ls->ls_rsbtbl_lock);
-	error = dlm_search_rsb_tree(&ls->ls_rsbtbl, name, len, &r);
-	if (error) {
+	if (!rsb_flag(r, RSB_HASHED)) {
 		read_unlock_bh(&ls->ls_rsbtbl_lock);
 		goto do_new;
 	}
@@ -918,11 +920,13 @@ static int find_rsb_nodir(struct dlm_ls *ls, const void *name, int len,
 	int error;
 
  retry:
+	error = dlm_search_rsb_tree(&ls->ls_rsbtbl, name, len, &r);
+	if (error)
+		goto do_new;
 
 	/* check if the rsb is in active state under read lock - likely path */
 	read_lock_bh(&ls->ls_rsbtbl_lock);
-	error = dlm_search_rsb_tree(&ls->ls_rsbtbl, name, len, &r);
-	if (error) {
+	if (!rsb_flag(r, RSB_HASHED)) {
 		read_unlock_bh(&ls->ls_rsbtbl_lock);
 		goto do_new;
 	}
@@ -1276,36 +1280,38 @@ static int _dlm_master_lookup(struct dlm_ls *ls, int from_nodeid, const char *na
 	}
 
  retry:
+	error = dlm_search_rsb_tree(&ls->ls_rsbtbl, name, len, &r);
+	if (error)
+		goto not_found;
 
 	/* check if the rsb is active under read lock - likely path */
 	read_lock_bh(&ls->ls_rsbtbl_lock);
-	error = dlm_search_rsb_tree(&ls->ls_rsbtbl, name, len, &r);
-	if (!error) {
-		if (rsb_flag(r, RSB_INACTIVE)) {
-			read_unlock_bh(&ls->ls_rsbtbl_lock);
-			goto do_inactive;
-		}
-
-		/* because the rsb is active, we need to lock_rsb before
-		 * checking/changing re_master_nodeid
-		 */
+	if (!rsb_flag(r, RSB_HASHED)) {
+		read_unlock_bh(&ls->ls_rsbtbl_lock);
+		goto not_found;
+	}
 
-		hold_rsb(r);
+	if (rsb_flag(r, RSB_INACTIVE)) {
 		read_unlock_bh(&ls->ls_rsbtbl_lock);
-		lock_rsb(r);
+		goto do_inactive;
+	}
 
-		__dlm_master_lookup(ls, r, our_nodeid, from_nodeid, false,
-				    flags, r_nodeid, result);
+	/* because the rsb is active, we need to lock_rsb before
+	 * checking/changing re_master_nodeid
+	 */
 
-		/* the rsb was active */
-		unlock_rsb(r);
-		put_rsb(r);
+	hold_rsb(r);
+	read_unlock_bh(&ls->ls_rsbtbl_lock);
+	lock_rsb(r);
 
-		return 0;
-	} else {
-		read_unlock_bh(&ls->ls_rsbtbl_lock);
-		goto not_found;
-	}
+	__dlm_master_lookup(ls, r, our_nodeid, from_nodeid, false,
+			    flags, r_nodeid, result);
+
+	/* the rsb was active */
+	unlock_rsb(r);
+	put_rsb(r);
+
+	return 0;
 
  do_inactive:
 	/* unlikely path - check if still part of ls_rsbtbl */
@@ -1403,14 +1409,14 @@ void dlm_dump_rsb_name(struct dlm_ls *ls, const char *name, int len)
 	struct dlm_rsb *r = NULL;
 	int error;
 
-	read_lock_bh(&ls->ls_rsbtbl_lock);
+	rcu_read_lock();
 	error = dlm_search_rsb_tree(&ls->ls_rsbtbl, name, len, &r);
 	if (!error)
 		goto out;
 
 	dlm_dump_rsb(r);
  out:
-	read_unlock_bh(&ls->ls_rsbtbl_lock);
+	rcu_read_unlock();
 }
 
 static void deactivate_rsb(struct kref *kref)
@@ -4309,16 +4315,27 @@ static void receive_remove(struct dlm_ls *ls, const struct dlm_message *ms)
 	memset(name, 0, sizeof(name));
 	memcpy(name, ms->m_extra, len);
 
-	write_lock_bh(&ls->ls_rsbtbl_lock);
-
+	rcu_read_lock();
 	rv = dlm_search_rsb_tree(&ls->ls_rsbtbl, name, len, &r);
 	if (rv) {
+		rcu_read_unlock();
 		/* should not happen */
 		log_error(ls, "%s from %d not found %s", __func__,
 			  from_nodeid, name);
+		return;
+	}
+
+	write_lock_bh(&ls->ls_rsbtbl_lock);
+	if (!rsb_flag(r, RSB_HASHED)) {
+		rcu_read_unlock();
 		write_unlock_bh(&ls->ls_rsbtbl_lock);
+		/* should not happen */
+		log_error(ls, "%s from %d got removed during removal %s",
+			  __func__, from_nodeid, name);
 		return;
 	}
+	/* at this stage the rsb can only being freed here */
+	rcu_read_unlock();
 
 	if (!rsb_flag(r, RSB_INACTIVE)) {
 		if (r->res_master_nodeid != from_nodeid) {
-- 
2.43.0

