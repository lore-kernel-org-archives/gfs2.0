Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F15613D24D
	for <gfs2@lists.linux.dev>; Wed, 13 Nov 2024 16:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731516418; cv=none; b=mwdpJcsrHvUBlN+rIhyBw252yPotNJntsAPw3jw//qvt+1BfsPfhI4ZNsQRcy3zhZ6I5FZlUFHQQ5R75rKblshmpesY+wcVqrD1jEOsYrJTowC3EsueqfERrZFVRMoCvXs8HCxSFCXVSYU+9nKE5ouHZMaFxXg4KJH2z/V31VKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731516418; c=relaxed/simple;
	bh=NLwUCaby7B3Q8TZAAAFrE6lG0kRrtP85Wa9kTYU2qAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M4uChx7QxBRuGy4yFIVQNazSzSK9ajoJA1vN4Rohm0h9lw9c216M/MPjHxryphmwO1L4I8y0DI7WF2nSil3mk5CTYK1tq+iPrHgGwtnEdbSA3i3Tf0kcGFhUFDoljdMGuJkEHPSBwPmrN0YGUndWwTqlvFV7kJFU/4LLgMjITAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aZHtkY92; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aZHtkY92"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731516416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/DFhvoJz9zrf4AGGUVNa559JjBaeJmNI52S1eiqgOJ8=;
	b=aZHtkY92razNBKhdcAEtc+ju/dv/ba/IJSVH0kadAGLzePdCcjvnnENy7S8Fl7Eo+uaLH2
	5+/7JxoFfgU0h8SzAvwAr8Oc7tgb1NQjPm0IbPmHsNtEgM2tMv5SLssYOhNOp+pKnH59y9
	2t2uJm249CQNerHQErGLaHSP+EiPM7I=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-680-KTgi1MqhOuygirRDeHIDdA-1; Wed,
 13 Nov 2024 11:46:54 -0500
X-MC-Unique: KTgi1MqhOuygirRDeHIDdA-1
X-Mimecast-MFC-AGG-ID: KTgi1MqhOuygirRDeHIDdA
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AB724195609F
	for <gfs2@lists.linux.dev>; Wed, 13 Nov 2024 16:46:53 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 17D261956054;
	Wed, 13 Nov 2024 16:46:52 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCH dlm/next 4/5] dlm: fix middle conversion cases in DLM recovery
Date: Wed, 13 Nov 2024 11:46:42 -0500
Message-ID: <20241113164643.464055-4-aahringo@redhat.com>
In-Reply-To: <20241113164643.464055-1-aahringo@redhat.com>
References: <20241113164643.464055-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Os42paBUNmgHimU2z2g7S33sJhj8musculc1LtJGDXQ_1731516413
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

We saw some issue after recovery and a following
dlm_lock(QUECVT | CONVERT) returned with -EINVAL. After investigation it
came out the lkb grmode was in an invalid state "-1" although the lkb was
in granted state.

I was able to reproduce the issue with the following DLM lkb/rsb state
manipulation:

steps to reproduce (3 nodes cluster):

Recovery conversion case "recover_convert_waiter()":

Node 1:
$ echo "test $CLNAME" > /sys/kernel/debug/dlm/__ctrl
$ echo "1337 foobaaar 0x0 0x0 3 3 2 2 2 3" >
/sys/kernel/debug/dlm/test_locks
$ echo "1337 2 2" > /sys/kernel/debug/dlm/test_waiters
Node 2:
$ echo "test $CLNAME" > /sys/kernel/debug/dlm/__ctrl
Node 3:
$ echo "test $CLNAME" > /sys/kernel/debug/dlm/__ctrl

`dlm_tool lockdebug test` before recovery dumps:
Node 1:
---
Resource len  8  "foobaaar"
Master:2         flags 000000c8 first_lkid 0 root 0 recover 0 locks 0
Convert
00001337 PR (CW) Master:   2 00000000  wait 02

Expecting reply
nodeid  2 msg convert lkid 00001337 resource "foobaaar"
---

Do a fence of node 2.

`dlm_tool lockdebug test` after recovery dumps:

---
Resource len  8  "foobaaar"
Master           flags 000000c8 first_lkid 0 root 0 recover 0 locks 0
Granted
00001337 IV
---

The lkb ends up in an invalid granted state with the lock mode invalid.
A following lock conversion with QUECVT will always return -EINVAL.

This invalid case is only appears when we have a waiter for a PR <-> CW
lock conversion that waits for an answer from the master lock node but
the master was being fenced. As this case is mainly handled in
"recover_convert_waiter()".

There are more cases to check but this is so far the only one I can
confirm that there are problems with and should be fixed.

If the above case occurs it leaves the lkb in a invalid state of
"grmode == rqmode" on the convertqueue that "recover_conversion()"
handles.

After this patch the above invalid state does not appear anymore. It
ends in the following lock state after fencing node 2 and recovery is
being triggered:

`dlm_tool lockdebug test` after recovery dumps:
Node 1:
---
Resource len  8  "foobaaar"
Master           flags 000000c8 first_lkid 0 root 0 recover 0 locks 0
Granted
00001337 CW
---

That successful indicates the new master is node 1 and it got the CW
lock state granted as requested before recovery.

There is however a second case handled when a new master is elected and
"receive_rcom_lock_args()" recovers lock requests from non master nodes
to the new master. The condition in "receive_rcom_lock_args()" of
"rl->rl_wait_type == cpu_to_le16(DLM_MSG_CONVERT)" however can't be true
as "recover_convert_waiter()" would call "_receive_convert_reply()" and
remove the current waiter of the lkb if there is one. That always would
have ended in "wait_type == 0". In case of a new master the new master
will never receive the lkb with "wait_type != 0".

I tried to find problems in the current handling of
"receive_rcom_lock_args()" case and I couldn't find any. However there is
a condition that seems never to be worked correctly.

This solution was co-developed with the original DLM author David
Teigland that changes this case as it covers potential all other non yet
easy to reproduce cases for PR <-> CW that are on granted/convertqueue.

Co-developed: David Teigland <teigland@redhat.com>
Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/lock.c    | 20 ++++++++++++--------
 fs/dlm/recover.c | 40 +++++++++++++++++++++++++++-------------
 2 files changed, 39 insertions(+), 21 deletions(-)

diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index 4219e0025fa2..1e809f591d1a 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -4999,16 +4999,19 @@ static void recover_convert_waiter(struct dlm_ls *ls, struct dlm_lkb *lkb,
 				   struct dlm_message *ms_local)
 {
 	if (middle_conversion(lkb)) {
+		log_rinfo(ls, "%s %x middle convert in progress", __func__,
+			 lkb->lkb_id);
+
+		/* We sent this lock to the new master. The new master will
+		 * tell us when it's granted.  We no longer need a reply, so
+		 * use a fake reply to put the lkb into the right state.
+		 */
 		hold_lkb(lkb);
 		memset(ms_local, 0, sizeof(struct dlm_message));
 		ms_local->m_type = cpu_to_le32(DLM_MSG_CONVERT_REPLY);
 		ms_local->m_result = cpu_to_le32(to_dlm_errno(-EINPROGRESS));
 		ms_local->m_header.h_nodeid = cpu_to_le32(lkb->lkb_nodeid);
 		_receive_convert_reply(lkb, ms_local, true);
-
-		/* Same special case as in receive_rcom_lock_args() */
-		lkb->lkb_grmode = DLM_LOCK_IV;
-		rsb_set_flag(lkb->lkb_resource, RSB_RECOVER_CONVERT);
 		unhold_lkb(lkb);
 
 	} else if (lkb->lkb_rqmode >= lkb->lkb_grmode) {
@@ -5555,10 +5558,11 @@ static int receive_rcom_lock_args(struct dlm_ls *ls, struct dlm_lkb *lkb,
 	   The real granted mode of these converting locks cannot be determined
 	   until all locks have been rebuilt on the rsb (recover_conversion) */
 
-	if (rl->rl_wait_type == cpu_to_le16(DLM_MSG_CONVERT) &&
-	    middle_conversion(lkb)) {
-		rl->rl_status = DLM_LKSTS_CONVERT;
-		lkb->lkb_grmode = DLM_LOCK_IV;
+	if (rl->rl_status == DLM_LKSTS_CONVERT && middle_conversion(lkb)) {
+		/* We may need to adjust grmode depending on other granted locks. */
+		log_limit(ls, "%s %x middle convert gr %d rq %d remote %d %x",
+			  __func__, lkb->lkb_id, lkb->lkb_grmode,
+			  lkb->lkb_rqmode, lkb->lkb_nodeid, lkb->lkb_remid);
 		rsb_set_flag(r, RSB_RECOVER_CONVERT);
 	}
 
diff --git a/fs/dlm/recover.c b/fs/dlm/recover.c
index 2e1169c81c6e..5a7b4b2016c9 100644
--- a/fs/dlm/recover.c
+++ b/fs/dlm/recover.c
@@ -811,33 +811,47 @@ static void recover_lvb(struct dlm_rsb *r)
 }
 
 /* All master rsb's flagged RECOVER_CONVERT need to be looked at.  The locks
-   converting PR->CW or CW->PR need to have their lkb_grmode set. */
+ * converting PR->CW or CW->PR may need to have their lkb_grmode changed.
+ */
 
 static void recover_conversion(struct dlm_rsb *r)
 {
 	struct dlm_ls *ls = r->res_ls;
+	uint32_t other_lkid = 0;
+	int other_grmode = -1;
 	struct dlm_lkb *lkb;
-	int grmode = -1;
 
 	list_for_each_entry(lkb, &r->res_grantqueue, lkb_statequeue) {
 		if (lkb->lkb_grmode == DLM_LOCK_PR ||
 		    lkb->lkb_grmode == DLM_LOCK_CW) {
-			grmode = lkb->lkb_grmode;
+			other_grmode = lkb->lkb_grmode;
+			other_lkid = lkb->lkb_id;
 			break;
 		}
 	}
 
+	if (other_grmode == -1) {
+		log_limit(ls, "%s %x gr %d rq %d, remote %d %x, no granted PR/CW found",
+			  __func__, lkb->lkb_id, lkb->lkb_grmode,
+			  lkb->lkb_rqmode, lkb->lkb_nodeid,
+			  lkb->lkb_remid);
+		return;
+	}
+
 	list_for_each_entry(lkb, &r->res_convertqueue, lkb_statequeue) {
-		if (lkb->lkb_grmode != DLM_LOCK_IV)
-			continue;
-		if (grmode == -1) {
-			log_debug(ls, "recover_conversion %x set gr to rq %d",
-				  lkb->lkb_id, lkb->lkb_rqmode);
-			lkb->lkb_grmode = lkb->lkb_rqmode;
-		} else {
-			log_debug(ls, "recover_conversion %x set gr %d",
-				  lkb->lkb_id, grmode);
-			lkb->lkb_grmode = grmode;
+		/* Lock recovery created incompatible granted modes, so
+		 * change the granted mode of the converting lock to
+		 * NL. The rqmode of the converting lock should be CW,
+		 * which means the converting lock should be granted at
+		 * the end of recovery.
+		 */
+		if (((lkb->lkb_grmode == DLM_LOCK_PR) && (other_grmode == DLM_LOCK_CW)) ||
+		    ((lkb->lkb_grmode == DLM_LOCK_CW) && (other_grmode == DLM_LOCK_PR))) {
+			log_limit(ls, "%s %x gr %d rq %d, remote %d %x, other_lkid %u, other gr %d, set gr=NL",
+				  __func__, lkb->lkb_id, lkb->lkb_grmode,
+				  lkb->lkb_rqmode, lkb->lkb_nodeid,
+				  lkb->lkb_remid, other_lkid, other_grmode);
+			lkb->lkb_grmode = DLM_LOCK_NL;
 		}
 	}
 }
-- 
2.43.0

