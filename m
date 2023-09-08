Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06AA1114
	for <gfs2@lists.linux.dev>; Fri,  8 Sep 2023 20:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694205984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JltdMJOn3ZrboCsifeKQPpXAf7eVoUYqXgRQ+8TiHyE=;
	b=FC22OvdsdE69Ybg8ypZSUQ84GKUgY5Cw8PqgzYvKRnn0C2ye3thhQ5da/U//2LCOn4LqSc
	vNooRQpRDHoVAbFfoGuxfD9xrxo9s4jacU1ey4VX4r7C49bbz1fr5SM/yjIWr+br3Oxtt3
	gOsJvnhNqMZEd3/+OW6UKhsFzn7NPig=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-209-T3XD9Q4MNwqEhxJEENx4kg-1; Fri, 08 Sep 2023 16:46:23 -0400
X-MC-Unique: T3XD9Q4MNwqEhxJEENx4kg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BB1D1800883
	for <gfs2@lists.linux.dev>; Fri,  8 Sep 2023 20:46:22 +0000 (UTC)
Received: from fs-i40c-03.fs.lab.eng.bos.redhat.com (fs-i40c-03.fs.lab.eng.bos.redhat.com [10.16.224.23])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 927A02013570;
	Fri,  8 Sep 2023 20:46:22 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: cluster-devel@redhat.com,
	gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [RFC dlm/next 02/10] fs: dlm: switch to GFP_ATOMIC in dlm allocations
Date: Fri,  8 Sep 2023 16:46:03 -0400
Message-Id: <20230908204611.1910601-2-aahringo@redhat.com>
In-Reply-To: <20230908204611.1910601-1-aahringo@redhat.com>
References: <20230908204611.1910601-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
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
index 44ea65a73f3b..970b8499b66f 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -1208,13 +1208,11 @@ static int _create_lkb(struct dlm_ls *ls, struct dlm_lkb **lkb_ret,
 	spin_lock_init(&lkb->lkb_cb_lock);
 	INIT_WORK(&lkb->lkb_cb_work, dlm_callback_work);
 
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
index c0c1a83f6381..f44532d9f5c8 100644
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
2.31.1

