Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495162797A1
	for <gfs2@lists.linux.dev>; Wed, 10 Sep 2025 17:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757524989; cv=none; b=BwQsZl0PCfIjtARDQzsRPrPg/ZWSxGPjcvBd5/TsLW0ySk1nH6qINgsw983TYTCftz2oWiIXVJiY5PZ40bKZRgt/+AISkt/tJjr7o3by7V6dZOY43Ze8v1jfrAszMu1ZX7GbwHbPwa+ifOK3G3ozmYptLkW8HIq/PkseG3xiXKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757524989; c=relaxed/simple;
	bh=U/Bw0oFJjYkILogoteFC2JraE5vzOSx4DuQGpJ23rt8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=psFqMgHMU7uMOS+C3Ne6a96jA9W6wKMtgVQt6F5Q3OXmRSen5r7iTomidGE8hOcoilYgfGjSymZy4xABplbmaDbxNOGzh7N2ZHhMNVkjVFSVKdC3dEifCInXGL1RAKBuAQyyERfP94lgxWjK98qjjB4O0Bhz3Ern+rjkaC0ZI+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bDbvrclX; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bDbvrclX"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-afcb7322da8so1330858266b.0
        for <gfs2@lists.linux.dev>; Wed, 10 Sep 2025 10:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757524985; x=1758129785; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VPbSGL+wh5oLzTDoSZB7hbuuAk8K+GQPqz1VxG3+o6k=;
        b=bDbvrclXqcy4rERECz0hsEbUvLog0tfU0/i2Y+T3EM4tG+aayuKm5sbInW+4Obqlcl
         F1bEnasW0VUFMq4An9paSLHx3dUmPqsCRqZPdfqXaB1NnWJb+TvnuL9mxHpHOhvAhgb6
         yagdSagatp9enlPTlHIzBSJVNkv1ne+Vj722wEYbwy88N5Tj6oDuBK91voxwzzUgSM/C
         F/bKb5kHaxrqh29Xe4b8n2KiYMPgf0Frii/NVHGDDXdc4GdweZ8gYcSvq+1Vok0asnGs
         wYYHbc2aYgdnEpkEppyh1DNBS9miFCz1ChVDpm8Zvzh55AyB/XMV78DQeoEoL/UR/5Z+
         /H7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757524985; x=1758129785;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VPbSGL+wh5oLzTDoSZB7hbuuAk8K+GQPqz1VxG3+o6k=;
        b=lWVPMuphxiHEw9NaLIOE+U01cJuyT++MWDJVxX+428dGkmfY9B782c/U/D0q3lB8vN
         g2elIqj4OVLvs8zbK6Ji4WzpiCbdHV0FU+7faOUgIFlQanuXIjf24az60g75TefuTlS6
         t0NETeyIw48Y05CbYTp2vr7U24wMSg7hO6SDMcvYQxl2sefbOzbnX+HxpNUKStg9EY31
         QbVgHkEVa8PgGqHg9Lh/T2m9H4TzPhGSJuR8ZjMrfcrga4Q/eKVTj6WYNhkbmKLNP4M+
         ea89BqAoG9ibfG2A9x0hocmRJUSXo1cKw3FcfbJHsWu2rqNITV9vXwvVjD+rdBjpLjib
         wvHA==
X-Forwarded-Encrypted: i=1; AJvYcCW8KxaAwM9JfcWv2moRVL0ZduHu2lpxcraI6+uDi66fwBdBL83vF10rFT8eLAqhEcgtw6B7@lists.linux.dev
X-Gm-Message-State: AOJu0YyoR3LY/X3K+N+rKJpiAQ56fZeEeKv0fEPgHviFMT2lwsShq12J
	SsRuA5cOXc4L7Za4BXuqSDXrlPLiOm+gyumO3AHh5W0idv0lhsEsgJ9wBH696ccT
X-Gm-Gg: ASbGncsKbPG1yyZv3yO7lRP5DWrednEK8o5UQvw8Wuqf5kPgGqphVpoh21cWTBoUEKb
	8CoZ3vJOV9pCO3ILHXsp7klJrnOFG3l7ku8YFTeGY5LTw/U8dEc2TUOl1VFrFf/4cTD6QRshlEt
	rgpz1z9wjJpFQzjCYh9uo68WgyxanurG7YTgI/WgnOzrr2I4Em8kLBsw1QWcS6GbFooOd2KOkDQ
	LBS/a0bLyr8JBrEWhN0q3BcGwKwOYjzLPeL+M/liJJvJi4dsQ64wm+6irWhMMUQ0LhcbWWPPQL1
	IZROAOe9Tog9b0EZJKIRb+a2b0Jrcmjv81nwQNpnnaYu1k2KT5J3CLo6FwflJUHAIVZYGpvtRez
	cix93f9+l1lnh3z+djz52eAvDl4Q9XxoZzOZDXFP/G+552lfI3VUoSKxTN8F51Hhj0c7OhvH2Iw
	QAwS2l5quZZp/VfoDbwoxmy0BLJGRoRRW5KVLXbxhRO9sgHDOStI/mQKLZHK3MxWvovT3C5Q==
X-Google-Smtp-Source: AGHT+IFUk1dDOuaOT329tP4Uhn2J0sm2O7Oj9XL3NsIFiXqJhDbLfm76/tPWMehVqhL/HSTbSP0NRg==
X-Received: by 2002:a17:907:3da9:b0:b04:4d7a:84ef with SMTP id a640c23a62f3a-b04b13fe1e9mr1471789366b.6.1757524985317;
        Wed, 10 Sep 2025 10:23:05 -0700 (PDT)
Received: from local.station (net-93-148-99-27.cust.dsl.teletu.it. [93.148.99.27])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b078334db1esm203495566b.65.2025.09.10.10.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 10:23:04 -0700 (PDT)
From: Alessio Attilio <alessio.attilio.dev@gmail.com>
To: aahringo@redhat.com
Cc: teigland@redhat.com,
	gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Alessio Attilio <alessio.attilio@engineer.com>,
	Alessio Attilio <alessio.attilio.dev@gmail.com>
Subject: [PATCH] * dlm: improve lock management and concurrency control
Date: Wed, 10 Sep 2025 19:17:06 +0200
Message-ID: <20250910171706.173976-1-alessio.attilio.dev@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alessio Attilio <alessio.attilio@engineer.com>

This patch introduces several improvements to lock handling in the DLM
subsystem, focusing on thread safety, correctness, and code clarity.

- Added explicit locking (spin_lock_bh/spin_unlock_bh) around accesses
  to proc->locks and proc->asts in dlm_clear_proc_locks, ensuring safe
  concurrent operations during lock cleanup.
- Replaced del_proc_lock with direct, lock-protected list operations
  for improved clarity and correctness.
- Updated send_unlock to set RSB_MASTER_UNCERTAIN only when releasing
  the last lock on an rsb, ensuring proper master confirmation.
- Improved handling of persistent and non-persistent locks by setting
  appropriate flags (DLM_DFL_ORPHAN_BIT or DLM_IFL_DEAD_BIT) before
  orphaning or unlocking.
- Removed outdated comments related to mutex protection and serialization
  assumptions, reflecting the updated concurrency model.

Signed-off-by: Alessio Attilio <alessio.attilio.dev@gmail.com>
---
 fs/dlm/lock.c | 99 ++++++++++++++++++++++++---------------------------
 1 file changed, 46 insertions(+), 53 deletions(-)

diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index 6dd3a524cd35..9170b5c09823 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -3654,12 +3654,33 @@ static int send_convert(struct dlm_rsb *r, struct dlm_lkb *lkb)
 	return error;
 }
 
-/* FIXME: if this lkb is the only lock we hold on the rsb, then set
-   MASTER_UNCERTAIN to force the next request on the rsb to confirm
-   that the master is still correct. */
-
 static int send_unlock(struct dlm_rsb *r, struct dlm_lkb *lkb)
 {
+	struct dlm_lkb *tmp;
+	int count = 0;
+
+	list_for_each_entry(tmp, &r->res_grantqueue, lkb_statequeue) {
+		if (is_process_copy(tmp))
+			count++;
+	}
+	list_for_each_entry(tmp, &r->res_convertqueue, lkb_statequeue) {
+		if (is_process_copy(tmp))
+			count++;
+	}
+	list_for_each_entry(tmp, &r->res_waitqueue, lkb_statequeue) {
+		if (is_process_copy(tmp))
+			count++;
+	}
+
+/*
+ * When releasing the last lock on the rsb, we mark the master as uncertain.
+ * This ensures that the next lock request will verify the master node,
+ * maintaining consistency across the cluster.
+ */
+
+	if (count == 1)
+		rsb_set_flag(r, RSB_MASTER_UNCERTAIN);
+
 	return send_common(r, lkb, DLM_MSG_UNLOCK);
 }
 
@@ -6125,79 +6146,52 @@ static int unlock_proc_lock(struct dlm_ls *ls, struct dlm_lkb *lkb)
 	return error;
 }
 
-/* We have to release clear_proc_locks mutex before calling unlock_proc_lock()
-   (which does lock_rsb) due to deadlock with receiving a message that does
-   lock_rsb followed by dlm_user_add_cb() */
-
-static struct dlm_lkb *del_proc_lock(struct dlm_ls *ls,
-				     struct dlm_user_proc *proc)
-{
-	struct dlm_lkb *lkb = NULL;
-
-	spin_lock_bh(&ls->ls_clear_proc_locks);
-	if (list_empty(&proc->locks))
-		goto out;
-
-	lkb = list_entry(proc->locks.next, struct dlm_lkb, lkb_ownqueue);
-	list_del_init(&lkb->lkb_ownqueue);
-
-	if (lkb->lkb_exflags & DLM_LKF_PERSISTENT)
-		set_bit(DLM_DFL_ORPHAN_BIT, &lkb->lkb_dflags);
-	else
-		set_bit(DLM_IFL_DEAD_BIT, &lkb->lkb_iflags);
- out:
-	spin_unlock_bh(&ls->ls_clear_proc_locks);
-	return lkb;
-}
-
-/* The ls_clear_proc_locks mutex protects against dlm_user_add_cb() which
-   1) references lkb->ua which we free here and 2) adds lkbs to proc->asts,
-   which we clear here. */
-
-/* proc CLOSING flag is set so no more device_reads should look at proc->asts
-   list, and no more device_writes should add lkb's to proc->locks list; so we
-   shouldn't need to take asts_spin or locks_spin here.  this assumes that
-   device reads/writes/closes are serialized -- FIXME: we may need to serialize
-   them ourself. */
-
-void dlm_clear_proc_locks(struct dlm_ls *ls, struct dlm_user_proc *proc)
+static void clean_proc_locks(struct dlm_ls *ls, struct dlm_user_proc *proc)
 {
-	struct dlm_callback *cb, *cb_safe;
-	struct dlm_lkb *lkb, *safe;
+	struct dlm_lkb *lkb;
 
 	dlm_lock_recovery(ls);
 
 	while (1) {
-		lkb = del_proc_lock(ls, proc);
+		lkb = NULL;
+		spin_lock_bh(&proc->locks_spin);
+		if (!list_empty(&proc->locks)) {
+			lkb = list_entry(proc->locks.next, struct dlm_lkb,
+					 lkb_ownqueue);
+			list_del_init(&lkb->lkb_ownqueue);
+		}
+		spin_unlock_bh(&proc->locks_spin);
+
 		if (!lkb)
 			break;
-		if (lkb->lkb_exflags & DLM_LKF_PERSISTENT)
+
+		if (lkb->lkb_exflags & DLM_LKF_PERSISTENT) {
+			set_bit(DLM_DFL_ORPHAN_BIT, &lkb->lkb_dflags);
 			orphan_proc_lock(ls, lkb);
-		else
+		} else {
+			set_bit(DLM_IFL_DEAD_BIT, &lkb->lkb_iflags);
 			unlock_proc_lock(ls, lkb);
-
-		/* this removes the reference for the proc->locks list
-		   added by dlm_user_request, it may result in the lkb
-		   being freed */
+		}
 
 		dlm_put_lkb(lkb);
 	}
 
-	spin_lock_bh(&ls->ls_clear_proc_locks);
-
+	spin_lock_bh(&proc->locks_spin);
 	/* in-progress unlocks */
 	list_for_each_entry_safe(lkb, safe, &proc->unlocking, lkb_ownqueue) {
 		list_del_init(&lkb->lkb_ownqueue);
 		set_bit(DLM_IFL_DEAD_BIT, &lkb->lkb_iflags);
 		dlm_put_lkb(lkb);
 	}
+	spin_unlock_bh(&proc->locks_spin);
 
+	spin_lock_bh(&proc->asts_spin);
 	list_for_each_entry_safe(cb, cb_safe, &proc->asts, list) {
 		list_del(&cb->list);
 		dlm_free_cb(cb);
 	}
+	spin_unlock_bh(&proc->asts_spin);
 
-	spin_unlock_bh(&ls->ls_clear_proc_locks);
 	dlm_unlock_recovery(ls);
 }
 
@@ -6351,4 +6345,3 @@ int dlm_debug_add_lkb_to_waiters(struct dlm_ls *ls, uint32_t lkb_id,
 	dlm_put_lkb(lkb);
 	return 0;
 }
-
-- 
2.48.1

