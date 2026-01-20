Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D4B2C3256
	for <gfs2@lists.linux.dev>; Tue, 20 Jan 2026 15:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768923330; cv=none; b=sMEYYg5TJWu9d5+/FCoZ+nbLII7m3lj3kdIYT2VZ2NueZ6HifaiKjSXz/FnR35GfTQx4ZVb1IKZ5+Ci7kTCINm9STbYa49mZpXRxLkrTVAJXy1UH12SApTtwW7wVMmOv4jatlJfhD39Z2Z0cIqF5ZNvHO1Yl9Upr2M9XpBYBkFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768923330; c=relaxed/simple;
	bh=gcGDA+ohBV0OGQzrBr7d9LQ0Szu+YxeSiiszrD29Meo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=F9LBwMuJHTnr1247nWo5vhZZwLnVwO5yqfXeBWjRoz5eQKC9fUV0j9tlQaZki404dSdEYsj3MeZRBtc/b56ATweKtdOOFwUbJQcgwKqdCtPIKNj3xVTO+JAwtuc3NRp1tct3Rputao2mEAtcrVVxSp3Gwteb7K23QN65+WqlOTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pya8KnIa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pya8KnIa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768923327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l6HF0fAEtfjYBTvI3F7kUHowyaBYdVwIokHKqzqyDgA=;
	b=Pya8KnIa82jKYeN3A0R0a/Mp5ol6Lw6vXWXkUkHLdkA3f2Wlv08jHfwFa6FPdRmFj2mNPr
	wBE6t4irZd33srtDTBrerdFHYRe2Si1EinFIpfJqnZodj+26DHIQVMY7RdAdGT0503J91J
	1KCa7afQV/tqQZ65wv6fZPRhPohPSo0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-625-8GvqDeWbMVKhCJtH22DIAg-1; Tue,
 20 Jan 2026 10:35:26 -0500
X-MC-Unique: 8GvqDeWbMVKhCJtH22DIAg-1
X-Mimecast-MFC-AGG-ID: 8GvqDeWbMVKhCJtH22DIAg_1768923325
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B433B18301B0
	for <gfs2@lists.linux.dev>; Tue, 20 Jan 2026 15:35:23 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4010918008FF;
	Tue, 20 Jan 2026 15:35:23 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: aahringo@redhat.com,
	gfs2@lists.linux.dev
Subject: [PATCH vv6.19-rc6 7/7] dlm: use coniditon expression instead return scalars
Date: Tue, 20 Jan 2026 10:35:11 -0500
Message-ID: <20260120153511.2201392-7-aahringo@redhat.com>
In-Reply-To: <20260120153511.2201392-1-aahringo@redhat.com>
References: <20260120153511.2201392-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zgI2AkdhtPCFhJA_gDRgD3dJYXJpgpn7ZgV8Seq-I94_1768923325
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
index 7ec30fbe33d92..d5bf194ae4f51 100644
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
@@ -2140,10 +2138,7 @@ static inline bool first_in_list(struct dlm_lkb *lkb, struct list_head *head)
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
@@ -2380,11 +2375,8 @@ static bool _can_be_granted(struct dlm_rsb *r, struct dlm_lkb *lkb, bool now,
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
@@ -2544,16 +2536,11 @@ static int grant_pending_wait(struct dlm_rsb *r, int high, bool *cw,
 
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
@@ -2595,15 +2582,10 @@ static void grant_pending_locks(struct dlm_rsb *r, unsigned int *count)
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
@@ -5030,10 +5012,7 @@ static bool waiter_needs_recovery(struct dlm_ls *ls, struct dlm_lkb *lkb,
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
index c34ddf726cb06..b670c4fc8f4c4 100644
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
@@ -355,18 +353,14 @@ static struct dlm_member *find_memb(struct list_head *head, int nodeid)
 
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

