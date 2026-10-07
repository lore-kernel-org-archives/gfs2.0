Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDF546E011
	for <gfs2@lists.linux.dev>; Wed,  7 Oct 2026 11:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791372746; cv=none; b=nQjVHIUDeDsk0OII/w856GZah9GKh7lNul+CtOK0ZxV0zHGyiEevqMSueSicKvmj6haE7PYClISnzLHT/Ozi63IgQU2FkSr/WCAga8BSqH73+8JzwwdulB8dR91jSbyHAgE3BK+iU70KzM5n1ZhS8QiDLVzZpLyvlf+K6+5Mahk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791372746; c=relaxed/simple;
	bh=AqugtevlX1L8VFks7qCKC0P2AdCHO3zqizAjvv0ULqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q4EaK3MTlg0fE/2hSCXNLRG364XynXIG4yYMaZMQKg0dS/JI1hFXMFUByGSYtSbWq53/rikti8OFvuwu0KMXWQRNnNC3XxL0+CscrdoXzqY28PFkx2uXAR+/O2FlRtt4lq0+jXEv4K0wGzdaJQxVZsbMciWB6g9Nk7iXjD1eOfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DLEjXhSF; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DLEjXhSF"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1517bda04a0so1206726c88.0
        for <gfs2@lists.linux.dev>; Wed, 07 Oct 2026 04:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791372727; x=1791977527; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wlbZw9rWTpOOaVatPWUcRSYcWOK+5SaIvw5OFGXgdDg=;
        b=DLEjXhSFNzJ44tXUNNZy6xMXz0OSVS2KNwx5SPKay4UKvoditk4toBHzjpszP+uy8o
         oPYwZ8TfanAzLFUHDBVF3kBy1nWROhG9ww6ggJnpVFbq7lgS9TTucP6mvJU3rN6KLuMO
         l0S391CDuGob5SB98Abcz7v/EDzzdqm+vOhtDYYEErYK0YipMtnArFsfvH43200ht4Az
         +oIiSfkmymuXQYa76BV8ixlwOzjxfZEyIyNiW96wxdnwHeQLJ1iStjwujmDB2KhRH4Uv
         jg2SzHSYp8z6uexPa+bHmtgmKkIf6lRfSFdgA5YnE83lGpREPQlxoa+Im9QlkyxgZjs+
         AUnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791372727; x=1791977527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wlbZw9rWTpOOaVatPWUcRSYcWOK+5SaIvw5OFGXgdDg=;
        b=pRs1L9SCfgKDjPm+d/uIaxzrq6kOCdfG1H2vHga8auv+7CCAMGrqQIqYKTk+fhkBOj
         /8d2sla0Y+G/NycMsL/hvAtDz9xN1HQr9qDrPIyMXiZh/etoBGQpKudMqB8pBcObcRrt
         TDnjgNZFNponC2OIZ3xLa9UIoHMMYGX+x0wNJLv2zQVUiRm9KMpIKgB2cJIr3Ai9cNA4
         P/nqVnEyQ6dKJjFSIWM3DAiBbNvYq+IHPDzs57UG2IiGP8p7IJveoWa8oy/88qyKcKnG
         TFJwWK8VmMY1jLXIC0r1Hjnq06vGt0ZUJfNqF4LEgRQhzJ2QyW8YzEjRoqKPD/MfpqUo
         Q0yA==
X-Gm-Message-State: AFuF++neHvfshqztQ4yyeuo/0d3ULPRtyEfpe+Y1m8Vvag7O23U4bXQU
	mMNB06zBWfFq4vs7FdxgOij84l6SSOqBz06+AIVHLKcEuz29lndTYEj+
X-Gm-Gg: AYBFou0rTwbXu/+9WTRPerHCnvUsKmJI+l9NLUnV1HoAfrKwUz1rDW4S5FIG0eVXguD
	S1bOe8fsgsJDEFYv1wO1MrCxN5zGxuzdkL5kkCfRgjmGfNs0u85q11Jd/ITNlsC3mU72mAQ4Gkb
	Kyto8VWnOQ/H9T67clmwQovJJZ5qYcuffoNU1NGKfuM9KhzqMr/v4q4c5HCGz7inkEjCHZLmyH0
	FTiVkb92yFbnudOpoEoCe12MMhSllEunpjnwhGnIUswanq6gMxu739BpBaL/B4Ws4e+6J3EdmoQ
	axjlQHQXG+UnsrU7Yqc0z+98PGj+oyorqGXV4WTyZp5VlfJGV04fGodx9QQRkyC5qRfORobE5B1
	Z/THArmShaKM8vJ0aSlw94uwvBuux5f5vb8bH6PGSbTEH6KvyOuw1liKSJWPE2cbwjWnv4MKRxw
	Zdc7iKNNkPK45MKb7o9gJ92WLXxP/AhfRkCCaAXxh8eIQEyfDnAePsNaY5albEACoVK7wZAnHXm
	UKnAAF7MbXmXoj4AG9fx4MkxfaG0cuV
X-Received: by 2002:a05:7022:ea8e:b0:15e:3a65:5b97 with SMTP id a92af1059eb24-162041de5afmr1593969c88.16.1791372726707;
        Wed, 07 Oct 2026 04:32:06 -0700 (PDT)
Received: from LAPTOP-450UDG4J ([223.185.133.64])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-16375a1f898sm3132651c88.0.2026.10.07.04.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 04:32:05 -0700 (PDT)
From: Yogesh Gaur <yogeshgaur.83@gmail.com>
To: Alexander Aring <aahringo@redhat.com>,
	David Teigland <teigland@redhat.com>
Cc: gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Yogesh Gaur <yogeshgaur.83@gmail.com>,
	syzbot+da6dc573ce5e6624f505@syzkaller.appspotmail.com
Subject: [PATCH v3] dlm: don't publish a lkb in ls_lkbxa before it has an rsb
Date: Wed,  7 Oct 2026 17:01:55 +0530
Message-ID: <20261007113155.1982-1-yogeshgaur.83@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.5
In-Reply-To: <20261004051912.1045-1-yogeshgaur.83@gmail.com/>
References: <20261004051912.1045-1-yogeshgaur.83@gmail.com/>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

_create_lkb() puts a new lkb into ls_lkbxa straight away, which is also
what assigns its lkb_id, but the lkb only gets an rsb later, when
request_lock(), receive_request(), dlm_recover_master_copy() or
dlm_debug_add_lkb() call attach_lkb(). In between, find_lkb() hands the
lkb out with lkb_resource still NULL, and its callers go straight for
the rsb:

	r = lkb->lkb_resource;

	hold_rsb(r);
	lock_rsb(r);

For the userspace API the lkid is simply whatever was written to the
misc device, so a lkid can be aimed at a lkb that another thread is
still building, and hold_rsb() reads res_flags off NULL:

  BUG: KASAN: null-ptr-deref in rsb_flag fs/dlm/dlm_internal.h:386 [inline]
  BUG: KASAN: null-ptr-deref in hold_rsb fs/dlm/lock.c:334 [inline]
  BUG: KASAN: null-ptr-deref in unlock_lock fs/dlm/lock.c:3333 [inline]
  BUG: KASAN: null-ptr-deref in dlm_user_unlock+0x2ab/0x690 fs/dlm/lock.c:5956
  Read of size 8 at addr 0000000000000050 by task syz.3.570/7893
   rsb_flag fs/dlm/dlm_internal.h:386 [inline]
   hold_rsb fs/dlm/lock.c:334 [inline]
   unlock_lock fs/dlm/lock.c:3333 [inline]
   dlm_user_unlock+0x2ab/0x690 fs/dlm/lock.c:5956
   device_user_unlock+0x1ca/0x260 fs/dlm/user.c:321

Make it impossible for ls_lkbxa to hold a lkb without an rsb, rather
than filtering such lkbs in find_lkb() or reserving a NULL entry that
every walker would have to know about.  create_lkb() no longer touches
ls_lkbxa; attach_lkb() sets lkb_resource and only then allocates the
lkb_id and stores the lkb, so the lkb becomes visible already attached.
dlm_debug_add_lkb() presets the id it wants and attach_lkb() allocates
exactly that one.

attach_lkb() can now fail, and each of its four callers releases the
lkb on the error path it already has for a failure just before the
attach.  On failure attach_lkb() also clears lkb_id, so that
__put_lkb() cannot erase another lkb's entry when a requested id was
busy.  All four callers hold the rsb lock, and nothing takes an rsb
lock under ls_lkbxa_lock, so taking it there adds no new lock ordering.

As a side effect an lkb has no lkb_id until it is attached, so
trace_dlm_lock_start() and the validate_lock_args() and
receive_rcom_lock_args() error messages report 0 for a new lock.

The unchecked r = lkb->lkb_resource goes back to the original DLM
import, but an untrusted lkid only became possible once the userspace
device interface was added, so that is the tag below.

Fixes: 597d0cae0f99 ("[DLM] dlm: user locks")
Reported-by: syzbot+da6dc573ce5e6624f505@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=da6dc573ce5e6624f505
Suggested-by: Alexander Aring <aahringo@redhat.com>
Assisted-by: LLM
Signed-off-by: Yogesh Gaur <yogeshgaur.83@gmail.com>
---
v3: Incorporated Alexander Aring's review, don't reserve a NULL
    entry in ls_lkbxa either.  The lkb_id is now allocated in
    attach_lkb(), after lkb_resource is set, so ls_lkbxa only ever
    holds attached lkbs.  attach_lkb() can fail; all four callers
    handle it.  _create_lkb() folded into create_lkb().
v2: https://lore.kernel.org/all/20261004051912.1045-1-yogeshgaur.83@gmail.com/
v1: https://lore.kernel.org/all/20260909112108.2281-1-yogeshgaur.83@gmail.com/

Not runtime-tested. Built with W=1.

 fs/dlm/lock.c | 90 +++++++++++++++++++++++++++++++++++----------------
 1 file changed, 62 insertions(+), 28 deletions(-)

diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index c715e171bab7..3b3e15157f4c 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -1488,10 +1488,38 @@ void free_inactive_rsb(struct dlm_rsb *r)
 /* Attaching/detaching lkb's from rsb's is for rsb reference counting.
    The rsb must exist as long as any lkb's for it do. */
 
-static void attach_lkb(struct dlm_rsb *r, struct dlm_lkb *lkb)
+/*
+ * An lkb is only put into ls_lkbxa here, once it has an rsb, so
+ * find_lkb() never returns an lkb without one.  The lkb_id is assigned
+ * here too; dlm_debug_add_lkb() presets the one it wants.
+ */
+static int attach_lkb(struct dlm_rsb *r, struct dlm_lkb *lkb)
 {
+	struct dlm_ls *ls = r->res_ls;
+	struct xa_limit limit = XA_LIMIT(1, U32_MAX);
+	int rv;
+
+	if (lkb->lkb_id)
+		limit = XA_LIMIT(lkb->lkb_id, lkb->lkb_id);
+
 	hold_rsb(r);
 	lkb->lkb_resource = r;
+
+	write_lock_bh(&ls->ls_lkbxa_lock);
+	rv = xa_alloc(&ls->ls_lkbxa, &lkb->lkb_id, lkb, limit, GFP_ATOMIC);
+	write_unlock_bh(&ls->ls_lkbxa_lock);
+
+	if (rv < 0) {
+		log_error(ls, "%s xa error %d", __func__, rv);
+		/* the caller still holds its own rsb reference */
+		lkb->lkb_resource = NULL;
+		put_rsb(r);
+		/* don't let __put_lkb() erase another lkb's id */
+		lkb->lkb_id = 0;
+		return rv;
+	}
+
+	return 0;
 }
 
 static void detach_lkb(struct dlm_lkb *lkb)
@@ -1502,15 +1530,9 @@ static void detach_lkb(struct dlm_lkb *lkb)
 	}
 }
 
-static int _create_lkb(struct dlm_ls *ls, struct dlm_lkb **lkb_ret,
-		       unsigned long start, unsigned long end)
+static int create_lkb(struct dlm_ls *ls, struct dlm_lkb **lkb_ret)
 {
-	struct xa_limit limit;
 	struct dlm_lkb *lkb;
-	int rv;
-
-	limit.max = end;
-	limit.min = start;
 
 	lkb = dlm_allocate_lkb();
 	if (!lkb)
@@ -1525,25 +1547,10 @@ static int _create_lkb(struct dlm_ls *ls, struct dlm_lkb **lkb_ret,
 	INIT_LIST_HEAD(&lkb->lkb_ownqueue);
 	INIT_LIST_HEAD(&lkb->lkb_rsb_lookup);
 
-	write_lock_bh(&ls->ls_lkbxa_lock);
-	rv = xa_alloc(&ls->ls_lkbxa, &lkb->lkb_id, lkb, limit, GFP_ATOMIC);
-	write_unlock_bh(&ls->ls_lkbxa_lock);
-
-	if (rv < 0) {
-		log_error(ls, "create_lkb xa error %d", rv);
-		dlm_free_lkb(lkb);
-		return rv;
-	}
-
 	*lkb_ret = lkb;
 	return 0;
 }
 
-static int create_lkb(struct dlm_ls *ls, struct dlm_lkb **lkb_ret)
-{
-	return _create_lkb(ls, lkb_ret, 1, ULONG_MAX);
-}
-
 static int find_lkb(struct dlm_ls *ls, uint32_t lkid, struct dlm_lkb **lkb_ret)
 {
 	struct dlm_lkb *lkb;
@@ -3294,7 +3301,12 @@ static int request_lock(struct dlm_ls *ls, struct dlm_lkb *lkb,
 
 	lock_rsb(r);
 
-	attach_lkb(r, lkb);
+	error = attach_lkb(r, lkb);
+	if (error) {
+		unlock_rsb(r);
+		put_rsb(r);
+		return error;
+	}
 	lkb->lkb_lksb->sb_lkid = lkb->lkb_id;
 
 	error = _request_lock(r, lkb);
@@ -4038,7 +4050,14 @@ static int receive_request(struct dlm_ls *ls, const struct dlm_message *ms)
 		}
 	}
 
-	attach_lkb(r, lkb);
+	error = attach_lkb(r, lkb);
+	if (error) {
+		unlock_rsb(r);
+		put_rsb(r);
+		__put_lkb(ls, lkb);
+		goto fail;
+	}
+
 	error = do_request(r, lkb);
 	send_request_reply(r, lkb, error);
 	do_request_effects(r, lkb, error);
@@ -5642,7 +5661,12 @@ int dlm_recover_master_copy(struct dlm_ls *ls, const struct dlm_rcom *rc,
 		goto out_unlock;
 	}
 
-	attach_lkb(r, lkb);
+	error = attach_lkb(r, lkb);
+	if (error) {
+		__put_lkb(ls, lkb);
+		goto out_unlock;
+	}
+
 	add_lkb(r, lkb, rl->rl_status);
 	ls->ls_recover_locks_in++;
 
@@ -6300,12 +6324,14 @@ int dlm_debug_add_lkb(struct dlm_ls *ls, uint32_t lkb_id, char *name, int len,
 	if (!lksb)
 		return -ENOMEM;
 
-	error = _create_lkb(ls, &lkb, lkb_id, lkb_id + 1);
+	error = create_lkb(ls, &lkb);
 	if (error) {
 		kfree(lksb);
 		return error;
 	}
 
+	lkb->lkb_id = lkb_id;
+
 	dlm_set_dflags_val(lkb, lkb_dflags);
 	lkb->lkb_nodeid = lkb_nodeid;
 	lkb->lkb_lksb = lksb;
@@ -6321,7 +6347,15 @@ int dlm_debug_add_lkb(struct dlm_ls *ls, uint32_t lkb_id, char *name, int len,
 	}
 
 	lock_rsb(r);
-	attach_lkb(r, lkb);
+	error = attach_lkb(r, lkb);
+	if (error) {
+		unlock_rsb(r);
+		put_rsb(r);
+		kfree(lksb);
+		__put_lkb(ls, lkb);
+		return error;
+	}
+
 	add_lkb(r, lkb, lkb_status);
 	unlock_rsb(r);
 	put_rsb(r);
-- 
2.55.0.windows.5

