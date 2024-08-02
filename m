Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2147815C12A
	for <gfs2@lists.linux.dev>; Fri,  2 Aug 2024 17:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722619636; cv=none; b=NWDdOEjQBhGhZaTHXgsWeOZAZDtlkbB6Ki954WRts3S4uDrAxdu33FFYoSQDcr/yrTNMrHq6rQ00C1771wGUpjqGyzlrSQG+saUPJL6Dw2Sj6LU5nEd+RYCg0J07ec0DiLHv70ClGElMQx4S5myzI9mKuLP9AJLkt+nQkYcwRCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722619636; c=relaxed/simple;
	bh=KqY3EpMKihmFQSgnScn0z7eqle+NzJqvkgCw9/+zZOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gUvziKixzQZuGu1q7ZO6zHOpoeY+acD3JxN5sHtsXxvhc/Zy/6t05PysM3WsssF7pdOZWosn0IrmEvLqPUCEMNwb6QVrMc/X33Q6eSt6JAAHNBaDDe8Hp23SGFaunI/1JdMsQps8252DGAU407Yol/UQmk8w2AWGJ13WnckK3Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iz+XQl2E; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iz+XQl2E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722619634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cwCsCekkYVuGcDYwJ/7T+/sTSk2g6PmLLAkhAWWxNI4=;
	b=iz+XQl2ESk/FPfPcwne9RN2p90h7lhAp06/E8bCPo5n5elJZCjmSH26ZxSEX4E1kzqaXqh
	23YFXVqvahyiSVXUlSTU8AG7LuSPJL7uv2ece8AXWT8Iuy+I9ZTXPYf+15A4PKQWWzUqOq
	rBC5TxEP8DLrFBPbT3MurREOhL6jEVg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-631-DAGFXplBNY-NKOW9lVecxQ-1; Fri,
 02 Aug 2024 13:27:12 -0400
X-MC-Unique: DAGFXplBNY-NKOW9lVecxQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DD9721955D5D
	for <gfs2@lists.linux.dev>; Fri,  2 Aug 2024 17:27:11 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2A1FA19560AE;
	Fri,  2 Aug 2024 17:27:10 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCHv2 v6.11-rc1 09/10] dlm: move lkb xarray lookup out of lock
Date: Fri,  2 Aug 2024 13:26:46 -0400
Message-ID: <20240802172647.582745-9-aahringo@redhat.com>
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

