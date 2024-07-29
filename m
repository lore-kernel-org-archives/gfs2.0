Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC54128812
	for <gfs2@lists.linux.dev>; Mon, 29 Jul 2024 19:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722281809; cv=none; b=BJcCKhz0VKVGE+Xrc1gjhLn8Uk7Xz5cZk7aD6A0yDtMTawhV0v54eWuzTlBsvGy1C+mvrrYHTVZvnjOZ0QjVByiqxJad1V+yy3FiaV6qVCWPrxh5pnWgoV3iqm8mgpe1MxNNWLuqqUwtEETBNFHodN//OmMLfsoGASwxQ5NkTNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722281809; c=relaxed/simple;
	bh=KqY3EpMKihmFQSgnScn0z7eqle+NzJqvkgCw9/+zZOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZohN26AtYDP+SQGL77iq2Q39yjuJU/DavQNyhC4IjL4pEsD053XPQaA3IyjLMnt82tQCrWPlJURGwxA07c/JrnZObVmPsquMNFt47z9dQe2zHfaXG7QwyaLY76sKGzOhwYGHETz2ksArs38wuzKY7LzWLrOu37hR7DV+23DnH4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gk2lbBr9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gk2lbBr9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722281807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cwCsCekkYVuGcDYwJ/7T+/sTSk2g6PmLLAkhAWWxNI4=;
	b=gk2lbBr9qN2FNU/GMBsRmwbJXmet7CZCaZX1UAx7n/3iFpF4WieeHR9Sd/4uojod+niSFh
	Fa5L9GvE2aEHR2DJ0LvXJEIXKJ8Vb5nwpQlTxPzSAnv5WmZde3PwTrjGB5cBeEaMxxwMoS
	DYqhoF3hLosDkvlWEk/rshBAU51XSmQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-556-QWJq4-tqOBSodQp0oSGfbA-1; Mon,
 29 Jul 2024 15:36:45 -0400
X-MC-Unique: QWJq4-tqOBSodQp0oSGfbA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8BB8D19560A2
	for <gfs2@lists.linux.dev>; Mon, 29 Jul 2024 19:36:44 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DF7641955D47;
	Mon, 29 Jul 2024 19:36:43 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCH v6.11-rc1 09/10] dlm: move lkb xarray lookup out of lock
Date: Mon, 29 Jul 2024 15:36:29 -0400
Message-ID: <20240729193630.3344082-9-aahringo@redhat.com>
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

This patch moves the xarray lookup functionality for the lkb out of the
ls_lkbxa_lock read lock handling. We can do that as the xarray should be
possible to access lockless in case of reader like xa_load(). We confirm
under ls_lkbxa_lock that the lkb is still part of the data structure and
take a reference when its still part of ls_lkbxa to avoid being freed
after doing the lookup. To do a check if the lkb is still part of the
ls_lkbxa data structure we use a kref_read() as the last put will remove
it from the ls_lkbxa data structure and any reference taken means it is
still part of ls_lkbxa.

A similar approach was done with the DLM rsb rhashtable just with a flag
instead of the refcounter because the refcounter has a slightly
different meaning.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/dlm_internal.h |  1 +
 fs/dlm/lock.c         | 18 ++++++++++++++----
 fs/dlm/memory.c       |  9 ++++++++-
 3 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/fs/dlm/dlm_internal.h b/fs/dlm/dlm_internal.h
index 0562099e60eb..d534a4bc162b 100644
--- a/fs/dlm/dlm_internal.h
+++ b/fs/dlm/dlm_internal.h
@@ -295,6 +295,7 @@ struct dlm_lkb {
 		void			*lkb_astparam;	/* caller's ast arg */
 		struct dlm_user_args	*lkb_ua;
 	};
+	struct rcu_head		rcu;
 };
 
 /*
diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index 9d3ec359d5e3..865dc70a9dfc 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -1527,11 +1527,21 @@ static int find_lkb(struct dlm_ls *ls, uint32_t lkid, struct dlm_lkb **lkb_ret)
 {
 	struct dlm_lkb *lkb;
 
-	read_lock_bh(&ls->ls_lkbxa_lock);
+	rcu_read_lock();
 	lkb = xa_load(&ls->ls_lkbxa, lkid);
-	if (lkb)
-		kref_get(&lkb->lkb_ref);
-	read_unlock_bh(&ls->ls_lkbxa_lock);
+	if (lkb) {
+		/* check if lkb is still part of lkbxa under lkbxa_lock as
+		 * the lkb_ref is tight to the lkbxa data structure, see
+		 * __put_lkb().
+		 */
+		read_lock_bh(&ls->ls_lkbxa_lock);
+		if (kref_read(&lkb->lkb_ref))
+			kref_get(&lkb->lkb_ref);
+		else
+			lkb = NULL;
+		read_unlock_bh(&ls->ls_lkbxa_lock);
+	}
+	rcu_read_unlock();
 
 	*lkb_ret = lkb;
 	return lkb ? 0 : -ENOENT;
diff --git a/fs/dlm/memory.c b/fs/dlm/memory.c
index 442898cf7185..5c35cc67aca4 100644
--- a/fs/dlm/memory.c
+++ b/fs/dlm/memory.c
@@ -115,8 +115,10 @@ struct dlm_lkb *dlm_allocate_lkb(void)
 	return kmem_cache_zalloc(lkb_cache, GFP_ATOMIC);
 }
 
-void dlm_free_lkb(struct dlm_lkb *lkb)
+static void __free_lkb_rcu(struct rcu_head *rcu)
 {
+	struct dlm_lkb *lkb = container_of(rcu, struct dlm_lkb, rcu);
+
 	if (test_bit(DLM_DFL_USER_BIT, &lkb->lkb_dflags)) {
 		struct dlm_user_args *ua;
 		ua = lkb->lkb_ua;
@@ -129,6 +131,11 @@ void dlm_free_lkb(struct dlm_lkb *lkb)
 	kmem_cache_free(lkb_cache, lkb);
 }
 
+void dlm_free_lkb(struct dlm_lkb *lkb)
+{
+	call_rcu(&lkb->rcu, __free_lkb_rcu);
+}
+
 struct dlm_mhandle *dlm_allocate_mhandle(void)
 {
 	return kmem_cache_alloc(mhandle_cache, GFP_ATOMIC);
-- 
2.43.0

