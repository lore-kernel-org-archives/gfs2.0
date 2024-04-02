Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331272C9D
	for <gfs2@lists.linux.dev>; Tue,  2 Apr 2024 19:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712085503; cv=none; b=Rn7a663Ic41XqrJ2VrkIgDcrWWAweJgaDAufWFO5b5L7/8rbBRcEyJwjmYzX4KT/mka9YiSl70GaD3ASHB122GbJMELE9RyG9I/401WdN0kKbvTNyqXFsHpt54P65jurUoel3+NkiP+p21bIhuYMgG/iHO1JV2xkHOhP0DWYLGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712085503; c=relaxed/simple;
	bh=ecct7lqCmgvDjlAj4lJ08vxBxDDOTbFj+Omw7rFET3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rQwHhcGvE2/j+RRiOukeVJqUJic6Z4Z8JeRXb3LfKtDfqLh1cecaU4Q6sfRRjEeyqvBTZHCx/wgOpMQ4fMhkkIRRSIOGRPpSfguDmhwqiuDZoURf3ddTKE8EyKKUj+u7mFbngm6kbD9Li0oqqsQKe9XLBqKuR0xJfz6/NVH8LXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JaQZZr2n; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JaQZZr2n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712085500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I2Mm6G4AQEX4jzMbKn6Fbhe0cya1evHCO/+FzS/7ViA=;
	b=JaQZZr2n1IEtPdBZbsQgc6DvpVY6UXaILnU2B/nCpKoSHZCn+mF4B82X7jCrilUcKeAn3m
	nzVXJoMy2H3+d4SWC+vdgwCm9d0kB2DdFqXs1hrMF/SPo6IIy6UCRG5AKl11CLDl2f3HGd
	znlzXr0WoQEWXLPmkNCC9lQH6NmlIH0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-iiSTTOwFOTS2ltfjoSeWSQ-1; Tue, 02 Apr 2024 15:18:18 -0400
X-MC-Unique: iiSTTOwFOTS2ltfjoSeWSQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 70E568059E9
	for <gfs2@lists.linux.dev>; Tue,  2 Apr 2024 19:18:18 +0000 (UTC)
Received: from fs-i40c-03.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6897340C6DB5;
	Tue,  2 Apr 2024 19:18:18 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCHv4 dlm/next 03/15] dlm: switch to GFP_ATOMIC in dlm allocations
Date: Tue,  2 Apr 2024 15:17:58 -0400
Message-ID: <20240402191810.1932939-4-aahringo@redhat.com>
In-Reply-To: <20240402191810.1932939-1-aahringo@redhat.com>
References: <20240402191810.1932939-1-aahringo@redhat.com>
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

This patch prepares to process dlm messages in softirq context. To
switch dlm to parse messages in softirq context some code parts either
runs inside the softirq context or need to switch to run while a spinlock
is held. This patch prepares to switch the allocation context to
GFP_ATOMIC for those places. It's not possible anymore to preload idr
allocations. However this is only a performance speedup and we might
switch to xarray implementation with more lockless readers paradigms.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/lock.c         | 2 --
 fs/dlm/memory.c       | 6 +++---
 fs/dlm/recover.c      | 2 --
 fs/dlm/requestqueue.c | 2 +-
 4 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index 2f94ffc3cf82..d87464614bc5 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -1206,13 +1206,11 @@ static int _create_lkb(struct dlm_ls *ls, struct dlm_lkb **lkb_ret,
 	INIT_LIST_HEAD(&lkb->lkb_ownqueue);
 	INIT_LIST_HEAD(&lkb->lkb_rsb_lookup);
 
-	idr_preload(GFP_NOFS);
 	spin_lock(&ls->ls_lkbidr_spin);
 	rv = idr_alloc(&ls->ls_lkbidr, lkb, start, end, GFP_NOWAIT);
 	if (rv >= 0)
 		lkb->lkb_id = rv;
 	spin_unlock(&ls->ls_lkbidr_spin);
-	idr_preload_end();
 
 	if (rv < 0) {
 		log_error(ls, "create_lkb idr error %d", rv);
diff --git a/fs/dlm/memory.c b/fs/dlm/memory.c
index ab663ca66aca..15a8b1cee433 100644
--- a/fs/dlm/memory.c
+++ b/fs/dlm/memory.c
@@ -84,7 +84,7 @@ char *dlm_allocate_lvb(struct dlm_ls *ls)
 {
 	char *p;
 
-	p = kzalloc(ls->ls_lvblen, GFP_NOFS);
+	p = kzalloc(ls->ls_lvblen, GFP_ATOMIC);
 	return p;
 }
 
@@ -97,7 +97,7 @@ struct dlm_rsb *dlm_allocate_rsb(struct dlm_ls *ls)
 {
 	struct dlm_rsb *r;
 
-	r = kmem_cache_zalloc(rsb_cache, GFP_NOFS);
+	r = kmem_cache_zalloc(rsb_cache, GFP_ATOMIC);
 	return r;
 }
 
@@ -112,7 +112,7 @@ struct dlm_lkb *dlm_allocate_lkb(struct dlm_ls *ls)
 {
 	struct dlm_lkb *lkb;
 
-	lkb = kmem_cache_zalloc(lkb_cache, GFP_NOFS);
+	lkb = kmem_cache_zalloc(lkb_cache, GFP_ATOMIC);
 	return lkb;
 }
 
diff --git a/fs/dlm/recover.c b/fs/dlm/recover.c
index 53917c0aa3c0..ce6dc914cb86 100644
--- a/fs/dlm/recover.c
+++ b/fs/dlm/recover.c
@@ -310,7 +310,6 @@ static int recover_idr_add(struct dlm_rsb *r)
 	struct dlm_ls *ls = r->res_ls;
 	int rv;
 
-	idr_preload(GFP_NOFS);
 	spin_lock(&ls->ls_recover_idr_lock);
 	if (r->res_id) {
 		rv = -1;
@@ -326,7 +325,6 @@ static int recover_idr_add(struct dlm_rsb *r)
 	rv = 0;
 out_unlock:
 	spin_unlock(&ls->ls_recover_idr_lock);
-	idr_preload_end();
 	return rv;
 }
 
diff --git a/fs/dlm/requestqueue.c b/fs/dlm/requestqueue.c
index 892d6ca21e74..c05940afd063 100644
--- a/fs/dlm/requestqueue.c
+++ b/fs/dlm/requestqueue.c
@@ -37,7 +37,7 @@ void dlm_add_requestqueue(struct dlm_ls *ls, int nodeid,
 	int length = le16_to_cpu(ms->m_header.h_length) -
 		sizeof(struct dlm_message);
 
-	e = kmalloc(sizeof(struct rq_entry) + length, GFP_NOFS);
+	e = kmalloc(sizeof(struct rq_entry) + length, GFP_ATOMIC);
 	if (!e) {
 		log_print("dlm_add_requestqueue: out of memory len %d", length);
 		return;
-- 
2.43.0

