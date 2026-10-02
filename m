Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBCE44CAC1
	for <gfs2@lists.linux.dev>; Fri,  2 Oct 2026 21:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790975507; cv=none; b=UDP1Cc9gYhRkQ5p9jnsHaZrXQ1qJ+o00Wo3DvBBUP4mT+HX4f4i35yafgxJ0nl6RMka4lsKmnVHwqWRBHrYgRebTWGcxaCPOCNebIoObeDnEsklo1X9Fy4UgLcIw0eYdIw1QgsT0UNK8RluR7xzzgd3+XOF6AWnwsmwM5MB25yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790975507; c=relaxed/simple;
	bh=N2ciETMqHYsciazzt73fxTaOAArmewBN+Pe8aytpqvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=u5SPdd2GPEm4iSV3coDLrMijmrLYGjrXzdbmuMKzgwicdpgRjGCxHhNIQ/vCBSv+MON1YEbi54RSjMHKIpbRrwvx3AYhZybNLl6CQ3F5Wcbh3LC/coTrOviW6PYbmFOhrPdKoCOM0qaIYC/8kYRggcKVHc1VV3xID+cOXpL8zkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hQ/QYVPw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hQ/QYVPw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790975497;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=goJhIVm7jETL3WM3ulfdXA2Y/adrCuD9d5jB2oaZS74=;
	b=hQ/QYVPwm1DXPVlCxA979Tparx64LlyLNabM9rnGV3rv1tSXw2E7q6K4H5Rl543CW+K+ym
	xrLw5xP+D4NKJOz2bYdLLYzcEeuLIREVHJagJ1YPSfRkJ/U9EjqqG6+/HUwrXWYCfrnGjG
	NV24Piq+tpmH9P3D9BitAsO/OSB7ivs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-544-o66X3gsdMnOotwZFoc2PSA-1; Fri,
 02 Oct 2026 17:11:36 -0400
X-MC-Unique: o66X3gsdMnOotwZFoc2PSA-1
X-Mimecast-MFC-AGG-ID: o66X3gsdMnOotwZFoc2PSA_1790975495
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 466E7180AE11
	for <gfs2@lists.linux.dev>; Fri,  2 Oct 2026 21:11:35 +0000 (UTC)
Received: from fs-i40c-03.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C7F8F1955E97;
	Fri,  2 Oct 2026 21:11:34 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: aahringo@redhat.com,
	gfs2@lists.linux.dev
Subject: [PATCH RESEND dlm/next 3/3] dlm: fix typos in comments
Date: Fri,  2 Oct 2026 17:11:30 -0400
Message-ID: <20261002211130.1573679-4-aahringo@redhat.com>
In-Reply-To: <20261002211130.1573679-1-aahringo@redhat.com>
References: <20261002211130.1573679-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: NnU8DMQtarCIJIpPonXEwSFkmuJH_J1NbH3w9Jji1i8_1790975495
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

From: Hemanth Selam <hemanth.selam@gmail.com>

Fix typos in comments, reported by scripts/checkpatch.pl using the
misspelling list in scripts/spelling.txt.  Only touches comments, no code
changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
Acked-by: Alexander Aring <aahringo@redhat.com>
Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/ast.c  | 2 +-
 fs/dlm/lock.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/dlm/ast.c b/fs/dlm/ast.c
index 0fe8d80ce5e8..7dd38e15bd25 100644
--- a/fs/dlm/ast.c
+++ b/fs/dlm/ast.c
@@ -81,7 +81,7 @@ bool dlm_may_skip_callback(struct dlm_lkb *lkb, uint32_t flags, int mode,
 		 * Suppress some redundant basts here, do more on removal.
 		 * Don't even add a bast if the callback just before it
 		 * is a bast for the same mode or a more restrictive mode.
-		 * (the addional > PR check is needed for PR/CW inversion)
+		 * (the additional > PR check is needed for PR/CW inversion)
 		 */
 		if (lkb->lkb_last_cb_mode != -1 &&
 		    lkb->lkb_last_cb_flags & DLM_CB_BAST) {
diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index 2609e4fdeba8..c715e171bab7 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -92,7 +92,7 @@ static void do_purge(struct dlm_ls *ls, int nodeid, int pid);
 static void deactivate_rsb(struct kref *kref);
 
 /*
- * Lock compatibilty matrix - thanks Steve
+ * Lock compatibility matrix - thanks Steve
  * UN = Unlocked state. Not really a state, used as a flag
  * PD = Padding. Used to make the matrix a nice power of two in size
  * Other states are the same as the VMS DLM.
-- 
2.43.0

