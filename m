Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CC328980F
	for <gfs2@lists.linux.dev>; Tue, 20 Jan 2026 15:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768923330; cv=none; b=uoN8r1s5U1SqVEZi4jKZPEo22fSa8JsprIjivdRz9r54xb0zVKDY7KgoWDc/WzvPGq33pap1WeA1emw0I6hm6C/qYCxOsdy1khTZgCgVUk+bQMcsfU59HYzcGDoMo3YLeC60GZ11sNqiLJ22chMVjYgxZSPgbOOMngONM1drZK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768923330; c=relaxed/simple;
	bh=lYprGBQzViPVc/OOIp0GR2FbEffUlsf2Phaos+C/+KM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=ZY/eVG/LSOSiqrdsGI8XR64ZKkhLdpavbKwDRXdn6IUUPNDD62vzZTeLLhZn7pnZjY70J+TziQpeDB71ztQgMcyarPWu4ybO9RXOBahIjGtGM5Oe+qjiKUscriLwdQPc4BlkV8vAC2WWmVmF9MbdgFZzpCjRScGT1XMVaEU7lIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TBKuGukh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TBKuGukh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768923327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a3400bWzu7Ryf/uB56KyMc/psxAAYehaWRolxS11vSU=;
	b=TBKuGukhv/q5C9blIu0gNXIl/BY7ZroS2V+G8U8kty9TMxv+psljDy6iRYLacc6MQQFYCq
	//rrual4EEaj5XswQ/YzdEb/QQKOULRmAIYII30HQRpNwJNXoDxKQI4IntE33mg/+gPle1
	FOt3xF3CQyC7andQKppf4w+P0nmgDcM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-582-BygPujA0NsWqFYi9HRGfSQ-1; Tue,
 20 Jan 2026 10:35:26 -0500
X-MC-Unique: BygPujA0NsWqFYi9HRGfSQ-1
X-Mimecast-MFC-AGG-ID: BygPujA0NsWqFYi9HRGfSQ_1768923325
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 17C441800BE8
	for <gfs2@lists.linux.dev>; Tue, 20 Jan 2026 15:35:23 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 84D521800996;
	Tue, 20 Jan 2026 15:35:22 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: aahringo@redhat.com,
	gfs2@lists.linux.dev
Subject: [PATCH vv6.19-rc6 6/7] dlm: use bool for coniditonal expressions
Date: Tue, 20 Jan 2026 10:35:10 -0500
Message-ID: <20260120153511.2201392-6-aahringo@redhat.com>
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
X-Mimecast-MFC-PROC-ID: hpjUJHsweHYCXrCJ1FjSZKI29Kpr7ti9pugIgCyYT7M_1768923325
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

This patch changes the return value of functions instead of using int
and their corresponding value 1/0 for true/false. Instead we use the
predefined true/false definitions.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/dlm_internal.h |   2 +-
 fs/dlm/lock.c         | 151 +++++++++++++++++++++---------------------
 fs/dlm/lowcomms.c     |  16 ++---
 fs/dlm/member.c       |  18 ++---
 fs/dlm/member.h       |   6 +-
 fs/dlm/requestqueue.c |  12 ++--
 fs/dlm/user.c         |  16 ++---
 fs/dlm/user.h         |   2 +-
 8 files changed, 111 insertions(+), 112 deletions(-)

diff --git a/fs/dlm/dlm_internal.h b/fs/dlm/dlm_internal.h
index d534a4bc162bb..c9d924b03f14a 100644
--- a/fs/dlm/dlm_internal.h
+++ b/fs/dlm/dlm_internal.h
@@ -381,7 +381,7 @@ static inline void rsb_clear_flag(struct dlm_rsb *r, enum rsb_flags flag)
 	__clear_bit(flag, &r->res_flags);
 }
 
-static inline int rsb_flag(struct dlm_rsb *r, enum rsb_flags flag)
+static inline bool rsb_flag(struct dlm_rsb *r, enum rsb_flags flag)
 {
 	return test_bit(flag, &r->res_flags);
 }
diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index a393ecaf3442a..7ec30fbe33d92 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -216,72 +216,72 @@ int dlm_lock_recovery_try(struct dlm_ls *ls)
 	return down_read_trylock(&ls->ls_in_recovery);
 }
 
-static inline int can_be_queued(struct dlm_lkb *lkb)
+static inline bool can_be_queued(struct dlm_lkb *lkb)
 {
 	return !(lkb->lkb_exflags & DLM_LKF_NOQUEUE);
 }
 
-static inline int force_blocking_asts(struct dlm_lkb *lkb)
+static inline bool force_blocking_asts(struct dlm_lkb *lkb)
 {
 	return (lkb->lkb_exflags & DLM_LKF_NOQUEUEBAST);
 }
 
-static inline int is_demoted(struct dlm_lkb *lkb)
+static inline bool is_demoted(struct dlm_lkb *lkb)
 {
 	return test_bit(DLM_SBF_DEMOTED_BIT, &lkb->lkb_sbflags);
 }
 
-static inline int is_altmode(struct dlm_lkb *lkb)
+static inline bool is_altmode(struct dlm_lkb *lkb)
 {
 	return test_bit(DLM_SBF_ALTMODE_BIT, &lkb->lkb_sbflags);
 }
 
-static inline int is_granted(struct dlm_lkb *lkb)
+static inline bool is_granted(struct dlm_lkb *lkb)
 {
 	return (lkb->lkb_status == DLM_LKSTS_GRANTED);
 }
 
-static inline int is_remote(struct dlm_rsb *r)
+static inline bool is_remote(struct dlm_rsb *r)
 {
 	DLM_ASSERT(r->res_nodeid >= 0, dlm_print_rsb(r););
 	return !!r->res_nodeid;
 }
 
-static inline int is_process_copy(struct dlm_lkb *lkb)
+static inline bool is_process_copy(struct dlm_lkb *lkb)
 {
 	return lkb->lkb_nodeid &&
 	       !test_bit(DLM_IFL_MSTCPY_BIT, &lkb->lkb_iflags);
 }
 
-static inline int is_master_copy(struct dlm_lkb *lkb)
+static inline bool is_master_copy(struct dlm_lkb *lkb)
 {
 	return test_bit(DLM_IFL_MSTCPY_BIT, &lkb->lkb_iflags);
 }
 
-static inline int middle_conversion(struct dlm_lkb *lkb)
+static inline bool middle_conversion(struct dlm_lkb *lkb)
 {
 	if ((lkb->lkb_grmode==DLM_LOCK_PR && lkb->lkb_rqmode==DLM_LOCK_CW) ||
 	    (lkb->lkb_rqmode==DLM_LOCK_PR && lkb->lkb_grmode==DLM_LOCK_CW))
-		return 1;
-	return 0;
+		return true;
+	return false;
 }
 
-static inline int down_conversion(struct dlm_lkb *lkb)
+static inline bool down_conversion(struct dlm_lkb *lkb)
 {
 	return (!middle_conversion(lkb) && lkb->lkb_rqmode < lkb->lkb_grmode);
 }
 
-static inline int is_overlap_unlock(struct dlm_lkb *lkb)
+static inline bool is_overlap_unlock(struct dlm_lkb *lkb)
 {
 	return test_bit(DLM_IFL_OVERLAP_UNLOCK_BIT, &lkb->lkb_iflags);
 }
 
-static inline int is_overlap_cancel(struct dlm_lkb *lkb)
+static inline bool is_overlap_cancel(struct dlm_lkb *lkb)
 {
 	return test_bit(DLM_IFL_OVERLAP_CANCEL_BIT, &lkb->lkb_iflags);
 }
 
-static inline int is_overlap(struct dlm_lkb *lkb)
+static inline bool is_overlap(struct dlm_lkb *lkb)
 {
 	return test_bit(DLM_IFL_OVERLAP_UNLOCK_BIT, &lkb->lkb_iflags) ||
 	       test_bit(DLM_IFL_OVERLAP_CANCEL_BIT, &lkb->lkb_iflags);
@@ -2136,19 +2136,19 @@ static void munge_altmode(struct dlm_lkb *lkb, const struct dlm_message *ms)
 	}
 }
 
-static inline int first_in_list(struct dlm_lkb *lkb, struct list_head *head)
+static inline bool first_in_list(struct dlm_lkb *lkb, struct list_head *head)
 {
 	struct dlm_lkb *first = list_entry(head->next, struct dlm_lkb,
 					   lkb_statequeue);
 	if (lkb->lkb_id == first->lkb_id)
-		return 1;
+		return true;
 
-	return 0;
+	return false;
 }
 
 /* Check if the given lkb conflicts with another lkb on the queue. */
 
-static int queue_conflict(struct list_head *head, struct dlm_lkb *lkb)
+static bool queue_conflict(struct list_head *head, struct dlm_lkb *lkb)
 {
 	struct dlm_lkb *this;
 
@@ -2156,9 +2156,9 @@ static int queue_conflict(struct list_head *head, struct dlm_lkb *lkb)
 		if (this == lkb)
 			continue;
 		if (!modes_compat(this, lkb))
-			return 1;
+			return true;
 	}
-	return 0;
+	return false;
 }
 
 /*
@@ -2202,7 +2202,7 @@ static int queue_conflict(struct list_head *head, struct dlm_lkb *lkb)
  * both already on the convert queue.
  */
 
-static int conversion_deadlock_detect(struct dlm_rsb *r, struct dlm_lkb *lkb2)
+static bool conversion_deadlock_detect(struct dlm_rsb *r, struct dlm_lkb *lkb2)
 {
 	struct dlm_lkb *lkb1;
 	int lkb_is_ahead = 0;
@@ -2215,14 +2215,14 @@ static int conversion_deadlock_detect(struct dlm_rsb *r, struct dlm_lkb *lkb2)
 
 		if (!lkb_is_ahead) {
 			if (!modes_compat(lkb2, lkb1))
-				return 1;
+				return true;
 		} else {
 			if (!modes_compat(lkb2, lkb1) &&
 			    !modes_compat(lkb1, lkb2))
-				return 1;
+				return true;
 		}
 	}
-	return 0;
+	return false;
 }
 
 /*
@@ -2241,10 +2241,10 @@ static int conversion_deadlock_detect(struct dlm_rsb *r, struct dlm_lkb *lkb2)
  * References are from chapter 6 of "VAXcluster Principles" by Roy Davis
  */
 
-static int _can_be_granted(struct dlm_rsb *r, struct dlm_lkb *lkb, int now,
-			   int recover)
+static bool _can_be_granted(struct dlm_rsb *r, struct dlm_lkb *lkb, bool now,
+			    bool recover)
 {
-	int8_t conv = (lkb->lkb_grmode != DLM_LOCK_IV);
+	bool conv = (lkb->lkb_grmode != DLM_LOCK_IV);
 
 	/*
 	 * 6-10: Version 5.4 introduced an option to address the phenomenon of
@@ -2266,7 +2266,7 @@ static int _can_be_granted(struct dlm_rsb *r, struct dlm_lkb *lkb, int now,
 	 */
 
 	if (lkb->lkb_exflags & DLM_LKF_EXPEDITE)
-		return 1;
+		return true;
 
 	/*
 	 * A shortcut. Without this, !queue_conflict(grantqueue, lkb) would be
@@ -2274,7 +2274,7 @@ static int _can_be_granted(struct dlm_rsb *r, struct dlm_lkb *lkb, int now,
 	 */
 
 	if (queue_conflict(&r->res_grantqueue, lkb))
-		return 0;
+		return false;
 
 	/*
 	 * 6-3: By default, a conversion request is immediately granted if the
@@ -2283,7 +2283,7 @@ static int _can_be_granted(struct dlm_rsb *r, struct dlm_lkb *lkb, int now,
 	 */
 
 	if (queue_conflict(&r->res_convertqueue, lkb))
-		return 0;
+		return false;
 
 	/*
 	 * The RECOVER_GRANT flag means dlm_recover_grant() is granting
@@ -2300,7 +2300,7 @@ static int _can_be_granted(struct dlm_rsb *r, struct dlm_lkb *lkb, int now,
 	 */
 
 	if (conv && recover)
-		return 1;
+		return true;
 
 	/*
 	 * 6-5: But the default algorithm for deciding whether to grant or
@@ -2326,7 +2326,7 @@ static int _can_be_granted(struct dlm_rsb *r, struct dlm_lkb *lkb, int now,
 	 */
 
 	if (now && conv && !(lkb->lkb_exflags & DLM_LKF_QUECVT))
-		return 1;
+		return true;
 
 	/*
 	 * Even if the convert is compat with all granted locks,
@@ -2335,9 +2335,9 @@ static int _can_be_granted(struct dlm_rsb *r, struct dlm_lkb *lkb, int now,
 
 	if (now && conv && (lkb->lkb_exflags & DLM_LKF_QUECVT)) {
 		if (list_empty(&r->res_convertqueue))
-			return 1;
+			return true;
 		else
-			return 0;
+			return false;
 	}
 
 	/*
@@ -2346,7 +2346,7 @@ static int _can_be_granted(struct dlm_rsb *r, struct dlm_lkb *lkb, int now,
 	 */
 
 	if (lkb->lkb_exflags & DLM_LKF_NOORDER)
-		return 1;
+		return true;
 
 	/*
 	 * 6-3: Once in that queue [CONVERTING], a conversion request cannot be
@@ -2355,7 +2355,7 @@ static int _can_be_granted(struct dlm_rsb *r, struct dlm_lkb *lkb, int now,
 	 */
 
 	if (!now && conv && first_in_list(lkb, &r->res_convertqueue))
-		return 1;
+		return true;
 
 	/*
 	 * 6-4: By default, a new request is immediately granted only if all
@@ -2370,7 +2370,7 @@ static int _can_be_granted(struct dlm_rsb *r, struct dlm_lkb *lkb, int now,
 
 	if (now && !conv && list_empty(&r->res_convertqueue) &&
 	    list_empty(&r->res_waitqueue))
-		return 1;
+		return true;
 
 	/*
 	 * 6-4: Once a lock request is in the queue of ungranted new requests,
@@ -2382,17 +2382,16 @@ static int _can_be_granted(struct dlm_rsb *r, struct dlm_lkb *lkb, int now,
 
 	if (!now && !conv && list_empty(&r->res_convertqueue) &&
 	    first_in_list(lkb, &r->res_waitqueue))
-		return 1;
+		return true;
 
-	return 0;
+	return false;
 }
 
-static int can_be_granted(struct dlm_rsb *r, struct dlm_lkb *lkb, int now,
-			  int recover, int *err)
+static bool can_be_granted(struct dlm_rsb *r, struct dlm_lkb *lkb, bool now,
+			   bool recover, int *err)
 {
-	int rv;
+	bool rv, is_convert = (lkb->lkb_grmode != DLM_LOCK_IV);
 	int8_t alt = 0, rqmode = lkb->lkb_rqmode;
-	int8_t is_convert = (lkb->lkb_grmode != DLM_LOCK_IV);
 
 	if (err)
 		*err = 0;
@@ -2449,27 +2448,27 @@ static int can_be_granted(struct dlm_rsb *r, struct dlm_lkb *lkb, int now,
 /* Returns the highest requested mode of all blocked conversions; sets
    cw if there's a blocked conversion to DLM_LOCK_CW. */
 
-static int grant_pending_convert(struct dlm_rsb *r, int high, int *cw,
+static int grant_pending_convert(struct dlm_rsb *r, int high, bool *cw,
 				 unsigned int *count)
 {
+	bool demoted, quit, grant_restart, demote_restart;
+	bool recover = rsb_flag(r, RSB_RECOVER_GRANT);
 	struct dlm_lkb *lkb, *s;
-	int recover = rsb_flag(r, RSB_RECOVER_GRANT);
-	int hi, demoted, quit, grant_restart, demote_restart;
-	int deadlk;
+	int hi, deadlk;
 
-	quit = 0;
+	quit = false;
  restart:
-	grant_restart = 0;
-	demote_restart = 0;
+	grant_restart = false;
+	demote_restart = false;
 	hi = DLM_LOCK_IV;
 
 	list_for_each_entry_safe(lkb, s, &r->res_convertqueue, lkb_statequeue) {
 		demoted = is_demoted(lkb);
 		deadlk = 0;
 
-		if (can_be_granted(r, lkb, 0, recover, &deadlk)) {
+		if (can_be_granted(r, lkb, false, recover, &deadlk)) {
 			grant_lock_pending(r, lkb);
-			grant_restart = 1;
+			grant_restart = true;
 			if (count)
 				(*count)++;
 			continue;
@@ -2478,7 +2477,7 @@ static int grant_pending_convert(struct dlm_rsb *r, int high, int *cw,
 		if (!demoted && is_demoted(lkb)) {
 			log_print("WARN: pending demoted %x node %d %s",
 				  lkb->lkb_id, lkb->lkb_nodeid, r->res_name);
-			demote_restart = 1;
+			demote_restart = true;
 			continue;
 		}
 
@@ -2505,33 +2504,33 @@ static int grant_pending_convert(struct dlm_rsb *r, int high, int *cw,
 		hi = max_t(int, lkb->lkb_rqmode, hi);
 
 		if (cw && lkb->lkb_rqmode == DLM_LOCK_CW)
-			*cw = 1;
+			*cw = true;
 	}
 
 	if (grant_restart)
 		goto restart;
 	if (demote_restart && !quit) {
-		quit = 1;
+		quit = true;
 		goto restart;
 	}
 
 	return max_t(int, high, hi);
 }
 
-static int grant_pending_wait(struct dlm_rsb *r, int high, int *cw,
+static int grant_pending_wait(struct dlm_rsb *r, int high, bool *cw,
 			      unsigned int *count)
 {
 	struct dlm_lkb *lkb, *s;
 
 	list_for_each_entry_safe(lkb, s, &r->res_waitqueue, lkb_statequeue) {
-		if (can_be_granted(r, lkb, 0, 0, NULL)) {
+		if (can_be_granted(r, lkb, false, false, NULL)) {
 			grant_lock_pending(r, lkb);
 			if (count)
 				(*count)++;
 		} else {
 			high = max_t(int, lkb->lkb_rqmode, high);
 			if (lkb->lkb_rqmode == DLM_LOCK_CW)
-				*cw = 1;
+				*cw = true;
 		}
 	}
 
@@ -2543,25 +2542,25 @@ static int grant_pending_wait(struct dlm_rsb *r, int high, int *cw,
    high is the largest rqmode of all locks blocked on the convert or
    waiting queue. */
 
-static int lock_requires_bast(struct dlm_lkb *gr, int high, int cw)
+static bool lock_requires_bast(struct dlm_lkb *gr, int high, bool cw)
 {
 	if (gr->lkb_grmode == DLM_LOCK_PR && cw) {
 		if (gr->lkb_highbast < DLM_LOCK_EX)
-			return 1;
-		return 0;
+			return true;
+		return false;
 	}
 
 	if (gr->lkb_highbast < high &&
 	    !__dlm_compat_matrix[gr->lkb_grmode+1][high+1])
-		return 1;
-	return 0;
+		return true;
+	return false;
 }
 
 static void grant_pending_locks(struct dlm_rsb *r, unsigned int *count)
 {
 	struct dlm_lkb *lkb, *s;
 	int high = DLM_LOCK_IV;
-	int cw = 0;
+	bool cw = false;
 
 	if (!is_master(r)) {
 		log_print("grant_pending_locks r nodeid %d", r->res_nodeid);
@@ -2598,13 +2597,13 @@ static int modes_require_bast(struct dlm_lkb *gr, struct dlm_lkb *rq)
 	if ((gr->lkb_grmode == DLM_LOCK_PR && rq->lkb_rqmode == DLM_LOCK_CW) ||
 	    (gr->lkb_grmode == DLM_LOCK_CW && rq->lkb_rqmode == DLM_LOCK_PR)) {
 		if (gr->lkb_highbast < DLM_LOCK_EX)
-			return 1;
-		return 0;
+			return true;
+		return false;
 	}
 
 	if (gr->lkb_highbast < rq->lkb_rqmode && !modes_compat(gr, rq))
-		return 1;
-	return 0;
+		return true;
+	return false;
 }
 
 static void send_bast_queue(struct dlm_rsb *r, struct list_head *head,
@@ -3039,7 +3038,7 @@ static int do_request(struct dlm_rsb *r, struct dlm_lkb *lkb)
 {
 	int error = 0;
 
-	if (can_be_granted(r, lkb, 1, 0, NULL)) {
+	if (can_be_granted(r, lkb, true, false, NULL)) {
 		grant_lock(r, lkb);
 		queue_cast(r, lkb, 0);
 		goto out;
@@ -3078,7 +3077,7 @@ static int do_convert(struct dlm_rsb *r, struct dlm_lkb *lkb)
 
 	/* changing an existing lock may allow others to be granted */
 
-	if (can_be_granted(r, lkb, 1, 0, &deadlk)) {
+	if (can_be_granted(r, lkb, true, false, &deadlk)) {
 		grant_lock(r, lkb);
 		queue_cast(r, lkb, 0);
 		goto out;
@@ -5025,16 +5024,16 @@ static void recover_convert_waiter(struct dlm_ls *ls, struct dlm_lkb *lkb,
 /* A waiting lkb needs recovery if the master node has failed, or
    the master node is changing (only when no directory is used) */
 
-static int waiter_needs_recovery(struct dlm_ls *ls, struct dlm_lkb *lkb,
-				 int dir_nodeid)
+static bool waiter_needs_recovery(struct dlm_ls *ls, struct dlm_lkb *lkb,
+				  int dir_nodeid)
 {
 	if (dlm_no_directory(ls))
-		return 1;
+		return true;
 
 	if (dlm_is_removed(ls, lkb->lkb_wait_nodeid))
-		return 1;
+		return true;
 
-	return 0;
+	return false;
 }
 
 /* Recovery for locks that are waiting for replies from nodes that are now
diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
index b3958008ba3f7..3c4d4b837e474 100644
--- a/fs/dlm/lowcomms.c
+++ b/fs/dlm/lowcomms.c
@@ -331,32 +331,32 @@ static struct connection *nodeid2con(int nodeid, gfp_t alloc)
 	return con;
 }
 
-static int addr_compare(const struct sockaddr_storage *x,
-			const struct sockaddr_storage *y)
+static bool addr_compare(const struct sockaddr_storage *x,
+			 const struct sockaddr_storage *y)
 {
 	switch (x->ss_family) {
 	case AF_INET: {
 		struct sockaddr_in *sinx = (struct sockaddr_in *)x;
 		struct sockaddr_in *siny = (struct sockaddr_in *)y;
 		if (sinx->sin_addr.s_addr != siny->sin_addr.s_addr)
-			return 0;
+			return false;
 		if (sinx->sin_port != siny->sin_port)
-			return 0;
+			return false;
 		break;
 	}
 	case AF_INET6: {
 		struct sockaddr_in6 *sinx = (struct sockaddr_in6 *)x;
 		struct sockaddr_in6 *siny = (struct sockaddr_in6 *)y;
 		if (!ipv6_addr_equal(&sinx->sin6_addr, &siny->sin6_addr))
-			return 0;
+			return false;
 		if (sinx->sin6_port != siny->sin6_port)
-			return 0;
+			return false;
 		break;
 	}
 	default:
-		return 0;
+		return false;
 	}
-	return 1;
+	return true;
 }
 
 static int nodeid_to_addr(int nodeid, struct sockaddr_storage *sas_out,
diff --git a/fs/dlm/member.c b/fs/dlm/member.c
index c1b5598997b7f..c34ddf726cb06 100644
--- a/fs/dlm/member.c
+++ b/fs/dlm/member.c
@@ -18,11 +18,11 @@
 #include "midcomms.h"
 #include "lowcomms.h"
 
-int dlm_slots_version(const struct dlm_header *h)
+bool dlm_slots_version(const struct dlm_header *h)
 {
 	if ((le32_to_cpu(h->h_version) & 0x0000FFFF) < DLM_HEADER_SLOTS)
-		return 0;
-	return 1;
+		return false;
+	return true;
 }
 
 void dlm_slot_save(struct dlm_ls *ls, struct dlm_rcom *rc,
@@ -353,20 +353,20 @@ static struct dlm_member *find_memb(struct list_head *head, int nodeid)
 	return NULL;
 }
 
-int dlm_is_member(struct dlm_ls *ls, int nodeid)
+bool dlm_is_member(struct dlm_ls *ls, int nodeid)
 {
 	if (find_memb(&ls->ls_nodes, nodeid))
-		return 1;
-	return 0;
+		return true;
+	return false;
 }
 
-int dlm_is_removed(struct dlm_ls *ls, int nodeid)
+bool dlm_is_removed(struct dlm_ls *ls, int nodeid)
 {
 	WARN_ON_ONCE(!nodeid || nodeid == -1);
 
 	if (find_memb(&ls->ls_nodes_gone, nodeid))
-		return 1;
-	return 0;
+		return true;
+	return false;
 }
 
 static void clear_memb_list(struct list_head *head,
diff --git a/fs/dlm/member.h b/fs/dlm/member.h
index f61cfde463140..c672009548f22 100644
--- a/fs/dlm/member.h
+++ b/fs/dlm/member.h
@@ -16,9 +16,9 @@ int dlm_ls_start(struct dlm_ls *ls);
 void dlm_clear_members(struct dlm_ls *ls);
 void dlm_clear_members_gone(struct dlm_ls *ls);
 int dlm_recover_members(struct dlm_ls *ls, struct dlm_recover *rv,int *neg_out);
-int dlm_is_removed(struct dlm_ls *ls, int nodeid);
-int dlm_is_member(struct dlm_ls *ls, int nodeid);
-int dlm_slots_version(const struct dlm_header *h);
+bool dlm_is_removed(struct dlm_ls *ls, int nodeid);
+bool dlm_is_member(struct dlm_ls *ls, int nodeid);
+bool dlm_slots_version(const struct dlm_header *h);
 void dlm_slot_save(struct dlm_ls *ls, struct dlm_rcom *rc,
 		   struct dlm_member *memb);
 void dlm_slots_copy_out(struct dlm_ls *ls, struct dlm_rcom *rc);
diff --git a/fs/dlm/requestqueue.c b/fs/dlm/requestqueue.c
index 719a5243a0693..daffc8df61e76 100644
--- a/fs/dlm/requestqueue.c
+++ b/fs/dlm/requestqueue.c
@@ -105,16 +105,16 @@ int dlm_process_requestqueue(struct dlm_ls *ls)
 	return error;
 }
 
-static int purge_request(struct dlm_ls *ls, struct dlm_message *ms, int nodeid)
+static bool purge_request(struct dlm_ls *ls, struct dlm_message *ms, int nodeid)
 {
 	__le32 type = ms->m_type;
 
 	/* the ls is being cleaned up and freed by release_lockspace */
 	if (!atomic_read(&ls->ls_count))
-		return 1;
+		return true;
 
 	if (dlm_is_removed(ls, nodeid))
-		return 1;
+		return true;
 
 	/* directory operations are always purged because the directory is
 	   always rebuilt during recovery and the lookups resent */
@@ -122,12 +122,12 @@ static int purge_request(struct dlm_ls *ls, struct dlm_message *ms, int nodeid)
 	if (type == cpu_to_le32(DLM_MSG_REMOVE) ||
 	    type == cpu_to_le32(DLM_MSG_LOOKUP) ||
 	    type == cpu_to_le32(DLM_MSG_LOOKUP_REPLY))
-		return 1;
+		return true;
 
 	if (!dlm_no_directory(ls))
-		return 0;
+		return false;
 
-	return 1;
+	return true;
 }
 
 void dlm_purge_requestqueue(struct dlm_ls *ls)
diff --git a/fs/dlm/user.c b/fs/dlm/user.c
index 51daf4acbe318..988584c49953a 100644
--- a/fs/dlm/user.c
+++ b/fs/dlm/user.c
@@ -156,20 +156,20 @@ static void compat_output(struct dlm_lock_result *res,
    not related to the lifetime of the lkb struct which is managed
    entirely by refcount. */
 
-static int lkb_is_endoflife(int mode, int status)
+static bool lkb_is_endoflife(int mode, int status)
 {
 	switch (status) {
 	case -DLM_EUNLOCK:
-		return 1;
+		return true;
 	case -DLM_ECANCEL:
 	case -ETIMEDOUT:
 	case -EDEADLK:
 	case -EAGAIN:
 		if (mode == DLM_LOCK_IV)
-			return 1;
+			return true;
 		break;
 	}
-	return 0;
+	return false;
 }
 
 /* we could possibly check if the cancel of an orphan has resulted in the lkb
@@ -877,13 +877,13 @@ static __poll_t device_poll(struct file *file, poll_table *wait)
 	return 0;
 }
 
-int dlm_user_daemon_available(void)
+bool dlm_user_daemon_available(void)
 {
 	/* dlm_controld hasn't started (or, has started, but not
 	   properly populated configfs) */
 
 	if (!dlm_our_nodeid())
-		return 0;
+		return false;
 
 	/* This is to deal with versions of dlm_controld that don't
 	   know about the monitor device.  We assume that if the
@@ -892,9 +892,9 @@ int dlm_user_daemon_available(void)
 	   should open the monitor device before populating configfs. */
 
 	if (dlm_monitor_unused)
-		return 1;
+		return true;
 
-	return atomic_read(&dlm_monitor_opened) ? 1 : 0;
+	return !!atomic_read(&dlm_monitor_opened);
 }
 
 static int ctl_device_open(struct inode *inode, struct file *file)
diff --git a/fs/dlm/user.h b/fs/dlm/user.h
index 2caf8e6e24d51..f7e6d1054492d 100644
--- a/fs/dlm/user.h
+++ b/fs/dlm/user.h
@@ -12,6 +12,6 @@ void dlm_user_add_ast(struct dlm_lkb *lkb, uint32_t flags, int mode,
 int dlm_user_init(void);
 void dlm_user_exit(void);
 int dlm_device_deregister(struct dlm_ls *ls);
-int dlm_user_daemon_available(void);
+bool dlm_user_daemon_available(void);
 
 #endif
-- 
2.43.0

