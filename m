Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B062FB08C
	for <gfs2@lists.linux.dev>; Fri,  5 Sep 2025 16:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757088359; cv=none; b=D8QtZjImaZGKEqnYfqOQx1U/3lgOfukOnuO7sXP3rv7cJbQdVv3DZsBwMoo52MouyHXFA4kbxoFwzA0AYgkzbVp+mnJlj3WWi8QC8WHBmSbcXMmWVaBRvWOGRoOLi3/+FWVJC8JsS46jzbvcpSn6NQ4xWr+LqwPSqglRujfNy+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757088359; c=relaxed/simple;
	bh=DpH1spyQc2BwKZX8QWGF5X6Bgoy/8T1ImVR1qDJ5dpM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LQkp1lV2ZTgeGMEjFBWvQZt00SK57JjunjkUW5ilWiQtMtAS5UdU7QCtM0+HgF2DQopSkQPhRrnG7ToQSsbxz5Hvd0D2aycyKjeYTU+b2FiXEctxy1W2FTwcHXIWHHK3mSU2dwC5elTCEh1j2scSO2VvY3OScQCy3NOSpe2YXVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YjSJ1GBh; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YjSJ1GBh"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-621b8b0893bso1344706a12.2
        for <gfs2@lists.linux.dev>; Fri, 05 Sep 2025 09:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757088356; x=1757693156; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x2jF6CAli7KAHOTpVDwWFWeNvgtTN0tRc+2eH+xWVhY=;
        b=YjSJ1GBhwlwismEEOJsG1nga3opOzLGyOiJEBcpNzBMRfQua/Rn0qF4zxd8yCDAuSe
         5K2h7WCj+bIrf9a3eWNbAQKqsI9xzJQm12YlxAYP4uf+byRrWH8Wwk4494XuIPyWuSlM
         JN9jK/LlBTmmqbRcbiCgXrhzg5Z/TzftCk93KdFAcDHR8DBHYDOv7McuMSoQf3GbOZWu
         I+Gq7mzXjFIFTNrVpoOEiVI/CRzSZmIp1JY54bzU7YWjMpbzLL+8wcBnfmAmi4OIzZ94
         4A7juGps7lOxu2vYyYuf7FIaCAI2TF/DlzdEfxxMd21Mz7sVVHDAR4+F8/KCzy+EyASB
         /FEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757088356; x=1757693156;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x2jF6CAli7KAHOTpVDwWFWeNvgtTN0tRc+2eH+xWVhY=;
        b=XRcxj9NGgEZLyUe1IMnSAa0s/zeiBgNqUi58Ld1GR3GgCs19ZFpoh163NTvc0pVitJ
         LMxP+GB7cCARI3pLZOOAuN282CRceWRz5SRbrogeuQyXuLe+B9QGLvrAKJt+vrOsPz6M
         LT5DyHscT2cUdlN6EnGOm9dSWPS4t1e3vSbcvXBo4CF6aXtvD42SnTztM/YObCWnvGQ5
         +4bATz7xCBkpowgWq8FS0GIIZBbNmdvdAmRj9t+tOU2Tae6fFHPo1/r46LtGuZli8gnt
         cUSl9+7gJ6Vi/OIxTgYUyBR7BfNn4q//pGtri3chWsvoLkqZSx9/H3kUlkN3HCP6GmzH
         91KQ==
X-Gm-Message-State: AOJu0YxMW3RJsbzCKbmIWrKTwlHZfPi4M5uz9TpgOowk02xue9+qz9k5
	nswYWfksEDl4mP0h3i+LkGaiB5F86YzVq8RguOMKiwVTnl4D+ER4PyedQxZW6T5RgmQ=
X-Gm-Gg: ASbGncvwraub99ePlyg+e7R9Vvb/ivH5vDfA76w2wBmIPnp9TPGqaGazzzcqF2VrHRg
	JAKulwUIcozdp3tzkhx5JJRUv+RuH+E0tl4Fg3mY2aycRFJ2krU+BUHAbM+q6o1ud2xrhYm7nqs
	odGrU12PShBNsuo/J48XovbbKuZNyqJpJ/bVAHIQHR3pvEzbR6d9uUY7+QVh6dw2WLAKsGc9eY2
	oobHXI37yFr0xFROfcBaJpVl2xd6LCA7eGQ/tLoCXi+jh1doKrGMT/PMpM4JA11nGDaePYfV6rl
	+KsTHFsLrCwjDP2AVFrbfmg5a/RcijHKDVBVGqY294Id3VTEAAoqjF2MS5UHLEh9EX5A/nA1V6d
	py8xMzxSQghiYXgoZ/Ff5ZGKPpjawdPVG16LV2RTIIMKZhufjTu0q1FiYnYXu1IJyk5KLC0Fw4V
	OAPXjTw5h1wT4Z5UeFQZCWKKzymCLBt4iKxc0mpIVN3YdyDQWCofrnyuVQQYaGY8aOe8dBbdU=
X-Google-Smtp-Source: AGHT+IEQKOL2cDeCeyz7GsXf0xOGnUm4pZGUH7eFeY7Hn/xgYOpbaxtnkhVjJRD5BvrCb03pNODkyw==
X-Received: by 2002:a17:906:dc8f:b0:b04:1edf:a42b with SMTP id a640c23a62f3a-b041edfac8bmr1953165566b.11.1757088355649;
        Fri, 05 Sep 2025 09:05:55 -0700 (PDT)
Received: from local.station (net-93-148-93-71.cust.vodafonedsl.it. [93.148.93.71])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aff138a8c1dsm1725812666b.99.2025.09.05.09.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 09:05:55 -0700 (PDT)
From: Alessio Attilio <alessio.attilio.dev@gmail.com>
To: gfs2@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	aahringo@redhat.com,
	teigland@redhat.com,
	Alessio Attilio <alessio.attilio.dev@gmail.com>
Subject: [PATCH] dlm: improve lock management and concurrency control
Date: Fri,  5 Sep 2025 18:05:52 +0200
Message-ID: <20250905160552.496879-1-alessio.attilio.dev@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
 fs/dlm/lock.c | 68 +++++++++++++++++++++++++++++++++------------------
 1 file changed, 44 insertions(+), 24 deletions(-)

diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index 6dd3a524cd35..bde62c991cfc 100644
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
+	/*
+	 * When releasing the last lock on the rsb, we mark the master as uncertain.
+ 	 * This ensures that the next lock request will verify the master node,
+ 	 * maintaining consistency across the cluster.
+ 	 */
+
+	if (count == 1)
+		rsb_set_flag(r, RSB_MASTER_UNCERTAIN);
+
 	return send_common(r, lkb, DLM_MSG_UNLOCK);
 }
 
@@ -6150,16 +6171,6 @@ static struct dlm_lkb *del_proc_lock(struct dlm_ls *ls,
 	return lkb;
 }
 
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
 void dlm_clear_proc_locks(struct dlm_ls *ls, struct dlm_user_proc *proc)
 {
 	struct dlm_callback *cb, *cb_safe;
@@ -6168,36 +6179,45 @@ void dlm_clear_proc_locks(struct dlm_ls *ls, struct dlm_user_proc *proc)
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
 
-- 
2.48.1

