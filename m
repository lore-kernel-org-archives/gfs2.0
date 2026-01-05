Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD2E311975
	for <gfs2@lists.linux.dev>; Mon,  5 Jan 2026 18:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767639081; cv=none; b=WSZzVWizWIb1IS11YgR3/d8FNb8b3Yf1dEC0LYzYaeuHCwD3FFkp7j1u574ipu82PsKWtTMNWMC1V9r4ZVC/WVyzkOqnI7YEUmj/6fNyf/xRimD7WigQpjYeu5UpKzMnv2Q+stFKSqvkfzWPtopmQsR8HvoDDRsoU5UIyZmcMzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767639081; c=relaxed/simple;
	bh=Yqp+4tZdQM80A3vvkx0sqrA4UPVJ3mu5pRXKsClbhbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=K332R67PkgduztESu7CvCzSPvYpZTpcN49NuTMlcF5ijD1mFnwl2hthQpjgr2H+5MrQBbIF0gauqosfjxpcFJV1XTWdIPGoGKbaOsy+jsMkimeO7Xr1ajTVcG7bgfxRG4g4FlA2KXFP7gScYz9uVAfuY6BqsQTbm6y3ywAYb7O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dyFLJdHt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dyFLJdHt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767639078;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3F3/mq6QzZQgho2EWlRYhcvQILgQ3d5I+j7jYR6htmk=;
	b=dyFLJdHtIWbpF9BWpu7DczAoK3+Uo/rN+upH5fvDXSRgPf28OoPuoUbHlGiZUvvN4EiwOD
	IehSPmnLNvmFJUFO/+QBQ1+yQ0IOc3360pR4gWGKFZ8GElbTkBMRh0aZsEAkKJzX8GsXZr
	issGxompu8vDy9O1WeFgf7dZ9L3xNBE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-630-TygyDE-FMgSWvoEvXROXbA-1; Mon,
 05 Jan 2026 13:51:15 -0500
X-MC-Unique: TygyDE-FMgSWvoEvXROXbA-1
X-Mimecast-MFC-AGG-ID: TygyDE-FMgSWvoEvXROXbA_1767639074
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5E8B71956088
	for <gfs2@lists.linux.dev>; Mon,  5 Jan 2026 18:51:14 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A6F98180049F;
	Mon,  5 Jan 2026 18:51:13 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: aahringo@redhat.com,
	gfs2@lists.linux.dev
Subject: [PATCH dlm/next 2/2] dlm: use coniditon expression instead return scalars
Date: Mon,  5 Jan 2026 13:51:10 -0500
Message-ID: <20260105185110.3925620-2-aahringo@redhat.com>
In-Reply-To: <20260105185110.3925620-1-aahringo@redhat.com>
References: <20260105185110.3925620-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: B6tdpY7bIkvtRp4_611gR3BIzmGw49Ok2f5IiPmIAkQ_1767639074
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Removes the condition and the scalar returns, instead we return directly
the boolean expression.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/lock.c         | 47 ++++++++++++-------------------------------
 fs/dlm/member.c       | 12 +++--------
 fs/dlm/requestqueue.c |  5 +----
 3 files changed, 17 insertions(+), 47 deletions(-)

diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index f5489a7432768..2bbefe9a744ea 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -260,10 +260,8 @@ static inline bool is_master_copy(struct dlm_lkb *lkb)
 
 static inline bool middle_conversion(struct dlm_lkb *lkb)
 {
-	if ((lkb->lkb_grmode==DLM_LOCK_PR && lkb->lkb_rqmode==DLM_LOCK_CW) ||
-	    (lkb->lkb_rqmode==DLM_LOCK_PR && lkb->lkb_grmode==DLM_LOCK_CW))
-		return true;
-	return false;
+	return ((lkb->lkb_grmode == DLM_LOCK_PR && lkb->lkb_rqmode == DLM_LOCK_CW) ||
+		(lkb->lkb_rqmode == DLM_LOCK_PR && lkb->lkb_grmode == DLM_LOCK_CW));
 }
 
 static inline bool down_conversion(struct dlm_lkb *lkb)
@@ -2139,10 +2137,7 @@ static inline bool first_in_list(struct dlm_lkb *lkb, struct list_head *head)
 {
 	struct dlm_lkb *first = list_entry(head->next, struct dlm_lkb,
 					   lkb_statequeue);
-	if (lkb->lkb_id == first->lkb_id)
-		return true;
-
-	return false;
+	return (lkb->lkb_id == first->lkb_id);
 }
 
 /* Check if the given lkb conflicts with another lkb on the queue. */
@@ -2379,11 +2374,8 @@ static bool _can_be_granted(struct dlm_rsb *r, struct dlm_lkb *lkb, bool now,
 	 * of the most restrictive lock granted on the resource.
 	 */
 
-	if (!now && !conv && list_empty(&r->res_convertqueue) &&
-	    first_in_list(lkb, &r->res_waitqueue))
-		return true;
-
-	return false;
+	return (!now && !conv && list_empty(&r->res_convertqueue) &&
+		first_in_list(lkb, &r->res_waitqueue));
 }
 
 static bool can_be_granted(struct dlm_rsb *r, struct dlm_lkb *lkb, bool now,
@@ -2543,16 +2535,11 @@ static int grant_pending_wait(struct dlm_rsb *r, int high, bool *cw,
 
 static bool lock_requires_bast(struct dlm_lkb *gr, int high, bool cw)
 {
-	if (gr->lkb_grmode == DLM_LOCK_PR && cw) {
-		if (gr->lkb_highbast < DLM_LOCK_EX)
-			return true;
-		return false;
-	}
+	if (gr->lkb_grmode == DLM_LOCK_PR && cw)
+		return (gr->lkb_highbast < DLM_LOCK_EX);
 
-	if (gr->lkb_highbast < high &&
-	    !__dlm_compat_matrix[gr->lkb_grmode+1][high+1])
-		return true;
-	return false;
+	return (gr->lkb_highbast < high &&
+		!__dlm_compat_matrix[gr->lkb_grmode+1][high+1]);
 }
 
 static void grant_pending_locks(struct dlm_rsb *r, unsigned int *count)
@@ -2594,15 +2581,10 @@ static void grant_pending_locks(struct dlm_rsb *r, unsigned int *count)
 static int modes_require_bast(struct dlm_lkb *gr, struct dlm_lkb *rq)
 {
 	if ((gr->lkb_grmode == DLM_LOCK_PR && rq->lkb_rqmode == DLM_LOCK_CW) ||
-	    (gr->lkb_grmode == DLM_LOCK_CW && rq->lkb_rqmode == DLM_LOCK_PR)) {
-		if (gr->lkb_highbast < DLM_LOCK_EX)
-			return true;
-		return false;
-	}
+	    (gr->lkb_grmode == DLM_LOCK_CW && rq->lkb_rqmode == DLM_LOCK_PR))
+		return (gr->lkb_highbast < DLM_LOCK_EX);
 
-	if (gr->lkb_highbast < rq->lkb_rqmode && !modes_compat(gr, rq))
-		return true;
-	return false;
+	return (gr->lkb_highbast < rq->lkb_rqmode && !modes_compat(gr, rq));
 }
 
 static void send_bast_queue(struct dlm_rsb *r, struct list_head *head,
@@ -5029,10 +5011,7 @@ static bool waiter_needs_recovery(struct dlm_ls *ls, struct dlm_lkb *lkb,
 	if (dlm_no_directory(ls))
 		return true;
 
-	if (dlm_is_removed(ls, lkb->lkb_wait_nodeid))
-		return true;
-
-	return false;
+	return dlm_is_removed(ls, lkb->lkb_wait_nodeid);
 }
 
 /* Recovery for locks that are waiting for replies from nodes that are now
diff --git a/fs/dlm/member.c b/fs/dlm/member.c
index f3e29c9879636..3ef57ec639c77 100644
--- a/fs/dlm/member.c
+++ b/fs/dlm/member.c
@@ -20,9 +20,7 @@
 
 bool dlm_slots_version(const struct dlm_header *h)
 {
-	if ((le32_to_cpu(h->h_version) & 0x0000FFFF) < DLM_HEADER_SLOTS)
-		return false;
-	return true;
+	return !((le32_to_cpu(h->h_version) & 0x0000FFFF) < DLM_HEADER_SLOTS);
 }
 
 void dlm_slot_save(struct dlm_ls *ls, struct dlm_rcom *rc,
@@ -359,18 +357,14 @@ static struct dlm_member *find_memb(struct list_head *head, int nodeid)
 
 bool dlm_is_member(struct dlm_ls *ls, int nodeid)
 {
-	if (find_memb(&ls->ls_nodes, nodeid))
-		return true;
-	return false;
+	return !!find_memb(&ls->ls_nodes, nodeid);
 }
 
 bool dlm_is_removed(struct dlm_ls *ls, int nodeid)
 {
 	WARN_ON_ONCE(!nodeid || nodeid == -1);
 
-	if (find_memb(&ls->ls_nodes_gone, nodeid))
-		return true;
-	return false;
+	return !!find_memb(&ls->ls_nodes_gone, nodeid);
 }
 
 static void clear_memb_list(struct list_head *head,
diff --git a/fs/dlm/requestqueue.c b/fs/dlm/requestqueue.c
index daffc8df61e76..ac18dd0c09df6 100644
--- a/fs/dlm/requestqueue.c
+++ b/fs/dlm/requestqueue.c
@@ -124,10 +124,7 @@ static bool purge_request(struct dlm_ls *ls, struct dlm_message *ms, int nodeid)
 	    type == cpu_to_le32(DLM_MSG_LOOKUP_REPLY))
 		return true;
 
-	if (!dlm_no_directory(ls))
-		return false;
-
-	return true;
+	return dlm_no_directory(ls);
 }
 
 void dlm_purge_requestqueue(struct dlm_ls *ls)
-- 
2.43.0

