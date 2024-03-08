Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB60F249E5
	for <gfs2@lists.linux.dev>; Fri,  8 Mar 2024 16:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709914708; cv=none; b=Px5Jt4PMdJQf+saPYsZ13pozh8mbnWGlrF19PyFUeivqYltbUbSsMj1byYKKagkP4EnEoj2FkRxFIGy9vs0hDfnjjar81JNmrhudXi9e224YrNxdc6kQUkfpaaWgNwGwSUXph3PSrKwH3dKTpxU6/IziOzaiH5a0e+Em0wfHflU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709914708; c=relaxed/simple;
	bh=Pa3EkQtU275Qb/7kQzSSmY9ea5Q5lfT8LGxCCncdFa4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J6o7EBGpNX6tNtbIa2R9SrekS1/iYKectmFNd00Ur4O9m070XbutkAohWnJNR8gFcKemvaBcGoYMWnK7cBEPKjNFsp9e4DEWVNjbPaTwaJodM4GKyu2sJmjd4O80JNSwDdMaLy2bnvE5ZE8oD4Up+pOU6MBaouB5S3/6j8w5ugs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I5wtCM1H; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I5wtCM1H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709914705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7JcEd54a8t4z2OqNQUFsDW+Fcti81Ipy0nhsdVp198Q=;
	b=I5wtCM1HOm4beqkzVstAZ/UQRRbr0y1sI5eX/SipIb16q2H2sEG4wkYtlGhjJQdJyxHGWz
	bg8tkmifAhsfl1TuGWLzAh3cxsC13BFrxTu10NFX8uu2YhQhusfzVpdYa713nm6l4TqTXI
	xFpLe5oVtaganmZJVtvPdcSv2fF9iTA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-vUDDkVlhM32uQWukWARIyQ-1; Fri, 08 Mar 2024 11:18:23 -0500
X-MC-Unique: vUDDkVlhM32uQWukWARIyQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0697D88B7A5
	for <gfs2@lists.linux.dev>; Fri,  8 Mar 2024 16:18:23 +0000 (UTC)
Received: from fs-i40c-03.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.fast.eng.rdu2.dc.redhat.com [10.6.23.54])
	by smtp.corp.redhat.com (Postfix) with ESMTP id F2810492BCB;
	Fri,  8 Mar 2024 16:18:22 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [RFC v6.8-rc6 5/7] dlm: combine switch case fail and default statements
Date: Fri,  8 Mar 2024 11:18:16 -0500
Message-ID: <20240308161818.2388451-6-aahringo@redhat.com>
In-Reply-To: <20240308161818.2388451-1-aahringo@redhat.com>
References: <20240308161818.2388451-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

This patch combines the failure and default cases for enqueue and
dequeue a callback to the lkb callback queue that should end in both
cases as it should never happen.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/ast.c  | 5 ++---
 fs/dlm/user.c | 9 ++++-----
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/fs/dlm/ast.c b/fs/dlm/ast.c
index ee9b27646682..69bb9b23e683 100644
--- a/fs/dlm/ast.c
+++ b/fs/dlm/ast.c
@@ -162,11 +162,10 @@ void dlm_add_cb(struct dlm_lkb *lkb, uint32_t flags, int mode, int status,
 		}
 		spin_unlock(&ls->ls_cb_lock);
 		break;
-	case DLM_ENQUEUE_CALLBACK_FAILURE:
-		WARN_ON_ONCE(1);
-		break;
 	case DLM_ENQUEUE_CALLBACK_SUCCESS:
 		break;
+	case DLM_ENQUEUE_CALLBACK_FAILURE:
+		fallthrough;
 	default:
 		WARN_ON_ONCE(1);
 		break;
diff --git a/fs/dlm/user.c b/fs/dlm/user.c
index c65b348606fe..f0b1792e2b40 100644
--- a/fs/dlm/user.c
+++ b/fs/dlm/user.c
@@ -231,10 +231,6 @@ void dlm_user_add_ast(struct dlm_lkb *lkb, uint32_t flags, int mode,
 
 	rv = dlm_enqueue_lkb_callback(lkb, flags, mode, status, sbflags);
 	switch (rv) {
-	case DLM_ENQUEUE_CALLBACK_FAILURE:
-		spin_unlock(&proc->asts_spin);
-		WARN_ON_ONCE(1);
-		goto out;
 	case DLM_ENQUEUE_CALLBACK_NEED_SCHED:
 		kref_get(&lkb->lkb_ref);
 		list_add_tail(&lkb->lkb_cb_list, &proc->asts);
@@ -242,9 +238,12 @@ void dlm_user_add_ast(struct dlm_lkb *lkb, uint32_t flags, int mode,
 		break;
 	case DLM_ENQUEUE_CALLBACK_SUCCESS:
 		break;
+	case DLM_ENQUEUE_CALLBACK_FAILURE:
+		fallthrough;
 	default:
+		spin_unlock(&proc->asts_spin);
 		WARN_ON_ONCE(1);
-		break;
+		goto out;
 	}
 	spin_unlock(&proc->asts_spin);
 
-- 
2.43.0

