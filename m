Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064E92EB85A
	for <gfs2@lists.linux.dev>; Sat,  6 Sep 2025 12:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757163298; cv=none; b=U7euLwlLc/6GIbPQR/z7oj6RTuErI4dDjIXrtdPWwL/BEwvvm+5k7i+Is9SzunzXyH/BjKf0md98DlRnfBr9W/nWK5IlPqdyP16VdkuIseog8nBs7s19cvQa3w6r4ULysPf6UfU2c8Ljd7z293sKq5CswZrdQph5gRPIZjLYhgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757163298; c=relaxed/simple;
	bh=aVwVRRwKFyUNFGgvpjosr9jg2Uh5JoehBnFt4mVeH8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QA9XcDHVaJF7E2dwIz8UBTCnJMC3ivWb6awOGyFDXgt50svdH73uUNAKOPTWWD6KnlBeI1rRoCaSxfTmG8pV4+thpY12chAJplDbYBlZ7a+BEEHTIhPJlZltFVUHWTMJ6DH6VXG0Ei6LU7WXZfsmrmkVMbdz4xsat5FFOjsNJqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TAYPeGSX; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TAYPeGSX"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b04271cfc3eso397819366b.3
        for <gfs2@lists.linux.dev>; Sat, 06 Sep 2025 05:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757163295; x=1757768095; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UE2E1w8rpI/Rz1G+l/mrlTW7yKFl3iA8f0ZeFg6IUiY=;
        b=TAYPeGSXa4b0lplvsuc4x8v7AHnbbEPk0mZVtctxk49RMsju7FGjL/I0FovSjX0QA8
         mEEdLTd2+GK28Jpknl+OcsjEj8ZSeCLxnQt1FgYj0SMSX5Y3TPd7p5o7fXVb8QoS7N8w
         IShM8kF44WLlL/44wmArqnkOD2h4GMaWiJO4Z/6cf+2/4dogPxZhrkgyH7MzH/lwWKdF
         YNNkz2gBn10Qc89RM5FTZMVUOyG77JLAg37gdW1DU0VGHWzj+jm+CyovCogJOtw0bC/G
         6m6laFjTdeSdlSrtmEwy8W0pwxMIuZUNRwceFzvetWJmM6iXKtfwdr0Mb3mTHb9uU3zp
         H7Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757163295; x=1757768095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UE2E1w8rpI/Rz1G+l/mrlTW7yKFl3iA8f0ZeFg6IUiY=;
        b=dXqG26inDjAPEb7IqGXZtc8Jkc4qtq5DHIwsKEN8ltWhwPZ4Qgb5aKrVgwmqeU1659
         m8iMEUTZpR3J4UNvfTSNooYycO5aCU4vfk9pNpbFotKH0b1MdiJi2brwb4GjObOATUBs
         T0RjdxZK7m8+HatBWCcm36ItHq4PuFIfB0u1mL4V7qJ3NzXB5XnxNUjVXYs6Xo4AjiEj
         0nwVlzdKY513jyORzl5P2h3vrfS75rI0ATQQH94GwBH/qd0Idgo+XqiRXkNivICEWDmL
         n9sftOcUIjh3FYMqWPbhyxHUyxDBLN3wbohBxbnRz7407W54hSf3n6p4kuMVu29moTJZ
         hY3g==
X-Forwarded-Encrypted: i=1; AJvYcCVxf1+WWFcaYg3pZu9yjxnFZnrJ1J5aKs1NkElUh9y4HqhmfVdAGt6gPmwR+LhCmaK0VRuX@lists.linux.dev
X-Gm-Message-State: AOJu0YwXpcDX0Q2TyKKouAuRVE7lwKS2bD6MAdW7Lt4t6k0qEcmG6kA9
	Nsjq5UPkcOa1PkmayKnkFyK8YyDIO1O34xX5c6Nfz+LzgfS8rbNmpzoD
X-Gm-Gg: ASbGncvRT9s2IqHN4paQ5ZyyDqj2gUSMwjuI7MovEmKMSlPh6rcqWsj2okVXX3lpF71
	cSbDEAHDXwnb5zFnxwchZLbw4KReK3T2pPTfNQZJOezl+Uh1LZ7HxYyYvR7tpjoSKhydjx00ETJ
	9dOo5K5xyLIKEJ3MAPTxh8ioigaE+yEmsnmrUUpRjqZAd2SVsDYzyY3EX1StpwCRtwVHb1e7TrZ
	EiSrpFKGf5I7A86NHZuCvStUmN7CnmvFjZP9Hz1qCYBIt5/AT0V8pmtiyCIf+fhS9btqA/m/Onl
	VwHLysi4UlrDEgtsdmn/5zXIxCGVSK6ipdZtmQOhcdEYwLA8dQ2ctTIkXJ7d8CvfeHPv5ViQfCk
	qQrwIfHYORFKlmBFas4C8FmC2OPgs3JDjZVgOutqTK+9LutqE51kfbnj2x6qOsWb5pBzu5sV3mS
	c3Jo0MFhGVtymi2tNNXQsQwBtb9XqFP3VxwwSq4+2nBFrHCIkH+QVQ90BoQQvn
X-Google-Smtp-Source: AGHT+IH+7BOI358ylmKp8atw8bsdyRj/71mHyL9dUszzoXcWqukq4MMj2v7GgMWLJqT+/pR3VfCtNQ==
X-Received: by 2002:a17:907:2d1f:b0:b04:3fe2:23c4 with SMTP id a640c23a62f3a-b04b1437f92mr198976866b.19.1757163295028;
        Sat, 06 Sep 2025 05:54:55 -0700 (PDT)
Received: from local.station (net-93-148-93-71.cust.vodafonedsl.it. [93.148.93.71])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b046b783722sm838883666b.97.2025.09.06.05.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Sep 2025 05:54:54 -0700 (PDT)
From: Alessio Attilio <alessio.attilio.dev@gmail.com>
To: alessio.attilio.dev@gmail.com
Cc: aahringo@redhat.com,
	gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	teigland@redhat.com
Subject: [PATCH] fix: delete del_proc_lock
Date: Sat,  6 Sep 2025 14:54:51 +0200
Message-ID: <20250906125451.19206-1-alessio.attilio.dev@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250905160552.496879-1-alessio.attilio.dev@gmail.com>
References: <20250905160552.496879-1-alessio.attilio.dev@gmail.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The del_proc_lock function was originally retained for testing purposes during development of the Distributed Lock Manager (DLM).
With testing now complete and the function no longer serving a runtime role, it is safe to remove.

Reason for Removal: The function is unused in production code and was only kept temporarily for debugging and validation.
Its presence is no longer necessary and may cause confusion or clutter.

Impact: This change simplifies the codebase and improves maintainability without affecting functionality or stability.

Signed-off-by: Alessio Attilio <alessio.attilio.dev@gmail.com>
---
 fs/dlm/lock.c | 30 ++----------------------------
 1 file changed, 2 insertions(+), 28 deletions(-)

diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index 9d74b78d3544..9170b5c09823 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -6146,35 +6146,9 @@ static int unlock_proc_lock(struct dlm_ls *ls, struct dlm_lkb *lkb)
 	return error;
 }
 
-/* We have to release clear_proc_locks mutex before calling unlock_proc_lock()
-   (which does lock_rsb) due to deadlock with receiving a message that does
-   lock_rsb followed by dlm_user_add_cb() */
-
-static struct dlm_lkb *del_proc_lock(struct dlm_ls *ls,
-				     struct dlm_user_proc *proc)
+static void clean_proc_locks(struct dlm_ls *ls, struct dlm_user_proc *proc)
 {
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
-void dlm_clear_proc_locks(struct dlm_ls *ls, struct dlm_user_proc *proc)
-{
-	struct dlm_callback *cb, *cb_safe;
-	struct dlm_lkb *lkb, *safe;
+	struct dlm_lkb *lkb;
 
 	dlm_lock_recovery(ls);
 
-- 
2.48.1

