Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6419041C62
	for <gfs2@lists.linux.dev>; Sat,  1 Nov 2025 00:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761956564; cv=none; b=jzBwkmiLaXbduKWgUE9RIBMx01B+P/8Urnx19KmE65v0m7znrFkItQED0suE0aNwUqYjQu01auoteGjgtjUWsNItzeeGBx1Qg+Bx7aNCpxpKIuVTT/rWsekL7tdNnu08bxDBd2Ru76Ouy20snF4JidyV9OznHOJxJxt2+hY5FwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761956564; c=relaxed/simple;
	bh=LcUjxly9mHY8USDIFmehMdx5TMf1JbcZLb5UNHdg43g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=bYndSMu/1O1PXYuBqqBzJFYWM9CM47hR0wbf2Xxbguqh0NTUfiLKvMG5h0cAOL3e+mpP4HU2XSL6WzdpwGHZo379pkD00QigJywa120k6tQMDnS3FZoifbM+7Dz+tflcDzM6zt55+Hg0seeUA925lfypUNtfWawqbrludMyKpwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N6NLQe+5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N6NLQe+5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761956561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ugCZzgpX/bUEXUAwfd44eVZ8e1SLQkzJvIy8tpLDXa4=;
	b=N6NLQe+5Yi3R/6U1CY4uMZFxCUC/fPbvAg9KidAb09Kk9mu1aGLF8t62kBbNRJxulkxywH
	cc5pH++LFx1q/mSn6ThGJ9E+soLfkvgnFGyd3qWYnMz5vs5HIkQ28m8NELBnvpBIPhk+dM
	8c+Xd5f249UxBqY33vetFWT2hcMaVcc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-637-UqDvtgx_MNOmy9TWaHFLFw-1; Fri,
 31 Oct 2025 20:22:39 -0400
X-MC-Unique: UqDvtgx_MNOmy9TWaHFLFw-1
X-Mimecast-MFC-AGG-ID: UqDvtgx_MNOmy9TWaHFLFw_1761956558
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7A4CD19560A7
	for <gfs2@lists.linux.dev>; Sat,  1 Nov 2025 00:22:38 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.12])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4E591180035A;
	Sat,  1 Nov 2025 00:22:36 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 01/24] gfs2: Add clean argument to lm_unmount hook
Date: Sat,  1 Nov 2025 00:22:10 +0000
Message-ID: <20251101002234.1286383-2-agruenba@redhat.com>
In-Reply-To: <20251101002234.1286383-1-agruenba@redhat.com>
References: <20251101002234.1286383-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TyIyMsZY8hdST8yBNXMyy_gAX0rwr1MiJzyv3JxNZk8_1761956558
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Add a 'clean' argument to ->lm_unmount() that indicates whether the
filesystem is clean or needs recovery.  Set clean to true for normal
unmounts, and to false for withdraws.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/glock.h      |  2 +-
 fs/gfs2/lock_dlm.c   | 14 ++++++++++++--
 fs/gfs2/ops_fstype.c |  2 +-
 fs/gfs2/util.c       |  2 +-
 4 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/fs/gfs2/glock.h b/fs/gfs2/glock.h
index d041b922b45e..dfbe06346b35 100644
--- a/fs/gfs2/glock.h
+++ b/fs/gfs2/glock.h
@@ -136,7 +136,7 @@ struct lm_lockops {
 	void (*lm_first_done) (struct gfs2_sbd *sdp);
 	void (*lm_recovery_result) (struct gfs2_sbd *sdp, unsigned int jid,
 				    unsigned int result);
-	void (*lm_unmount) (struct gfs2_sbd *sdp);
+	void (*lm_unmount) (struct gfs2_sbd *sdp, bool clean);
 	void (*lm_withdraw) (struct gfs2_sbd *sdp);
 	void (*lm_put_lock) (struct gfs2_glock *gl);
 	int (*lm_lock) (struct gfs2_glock *gl, unsigned int req_state,
diff --git a/fs/gfs2/lock_dlm.c b/fs/gfs2/lock_dlm.c
index 4f00af7dd256..c18e732a04bd 100644
--- a/fs/gfs2/lock_dlm.c
+++ b/fs/gfs2/lock_dlm.c
@@ -1438,7 +1438,15 @@ static void gdlm_first_done(struct gfs2_sbd *sdp)
 		fs_err(sdp, "mount first_done error %d\n", error);
 }
 
-static void gdlm_unmount(struct gfs2_sbd *sdp)
+/*
+ * gdlm_unmount - release our lockspace
+ * @sdp: the superblock
+ * @clean: Indicates whether or not the remaining nodes in the cluster should
+ *	   perform recovery.  Recovery is necessary when a node withdraws and
+ *	   its journal remains dirty.  Recovery isn't necessary when a node
+ *	   cleanly unmounts a filesystem.
+ */
+static void gdlm_unmount(struct gfs2_sbd *sdp, bool clean)
 {
 	struct lm_lockstruct *ls = &sdp->sd_lockstruct;
 
@@ -1456,7 +1464,9 @@ static void gdlm_unmount(struct gfs2_sbd *sdp)
 release:
 	down_write(&ls->ls_sem);
 	if (ls->ls_dlm) {
-		dlm_release_lockspace(ls->ls_dlm, DLM_RELEASE_NORMAL);
+		dlm_release_lockspace(ls->ls_dlm,
+				      clean ? DLM_RELEASE_NORMAL :
+					      DLM_RELEASE_RECOVER);
 		ls->ls_dlm = NULL;
 	}
 	up_write(&ls->ls_sem);
diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index aa15183f9a16..a29e81b3e954 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -1041,7 +1041,7 @@ void gfs2_lm_unmount(struct gfs2_sbd *sdp)
 {
 	const struct lm_lockops *lm = sdp->sd_lockstruct.ls_ops;
 	if (!gfs2_withdrawing_or_withdrawn(sdp) && lm->lm_unmount)
-		lm->lm_unmount(sdp);
+		lm->lm_unmount(sdp, true);
 }
 
 static int wait_on_journal(struct gfs2_sbd *sdp)
diff --git a/fs/gfs2/util.c b/fs/gfs2/util.c
index 56412f63f3bb..27fdcbce2d75 100644
--- a/fs/gfs2/util.c
+++ b/fs/gfs2/util.c
@@ -339,7 +339,7 @@ void gfs2_withdraw(struct gfs2_sbd *sdp)
 
 		if (lm->lm_unmount) {
 			fs_err(sdp, "telling LM to unmount\n");
-			lm->lm_unmount(sdp);
+			lm->lm_unmount(sdp, false);
 		}
 		fs_err(sdp, "File system withdrawn\n");
 		dump_stack();
-- 
2.51.0

