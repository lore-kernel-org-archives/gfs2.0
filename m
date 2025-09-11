Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CF354763
	for <gfs2@lists.linux.dev>; Thu, 11 Sep 2025 13:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757599124; cv=none; b=DWSY5cjTzINauigurm9LTP7crrm9Eb5d0ccNuWapOJV1XjEOT0kKKt5jD1az7PUzNMixwgSnPKMne9XUxhbpqWzMlPA25ul+0Jno+J3n6heH9IeLzt9b815W9CPIK6JXaR9nPt3pwojSmkPBt+IDB2ikEomDnimlFX8gyy02ye4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757599124; c=relaxed/simple;
	bh=icSSnUeRj2IvSKo9hhFsaLCN4js6qRRcmg4ScNV62+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=CfScfhl33Seqqk5ZRJ6T0ZvgjF/zSHODsZEEDCepmOg6Bo36aDT9g86d78E1GIcu7wo3lrTPX5iS+rola2x8AynKinZAeTSz8SwHf4WaOZja8eHgFMafnT3eMvyp+MEfNu1RyBsI4eCTOaRTTxUL+rBFA7g++KVOGh6G7wjiIYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CxD9PXa8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CxD9PXa8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757599122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EhH9KPYau/D1rsPTYHfEG1SchoY07eqta9ncIU4XxwU=;
	b=CxD9PXa8yLPeW0nouu3H0wsg6Q28lKCt6MPglzR2XHRqeFRgBFDGApfjAP1Gcj1gD+Brrn
	wKTVk6qTuZV2x01SybJ1a5sUg4OZwpZeio6KPGK9xiNoF95uB7D4/DosCJlFG1a5wG3x/5
	u9a2R4DlvsGPsAjUtSg0JdV/JlXkFDU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-540-M1FIs-9QPA-rchuLU3aEDQ-1; Thu,
 11 Sep 2025 09:57:51 -0400
X-MC-Unique: M1FIs-9QPA-rchuLU3aEDQ-1
X-Mimecast-MFC-AGG-ID: M1FIs-9QPA-rchuLU3aEDQ_1757599071
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EFF821944F0C
	for <gfs2@lists.linux.dev>; Thu, 11 Sep 2025 13:57:50 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.44.32.31])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B1E1619560B1;
	Thu, 11 Sep 2025 13:57:49 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 12/20] gfs2: Fix LM_FLAG_TRY* logic in add_to_queue
Date: Thu, 11 Sep 2025 15:57:17 +0200
Message-ID: <20250911135726.657575-13-agruenba@redhat.com>
In-Reply-To: <20250911135726.657575-1-agruenba@redhat.com>
References: <20250911135726.657575-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OPt38R0C9Yxfu2DC3-PICOMw9ID9B7vX31CrwWmkEq8_1757599071
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The logic in add_to_queue() for determining whether a LM_FLAG_TRY or
LM_FLAG_TRY_1CB holder should be queued does not make any sense: we are
interested in wether or not the new operation will block behind an
existing or future holder in the queue, but the current code checks for
ongoing locking or ->go_inval() operations, which has little to do with
that.

Replace that code with something more sensible, remove the incorrect
add_to_queue() function annotations, remove the similarly misguided
do_error(gl, 0) call in do_xmote(), and add a missing comment to the
same call in do_promote().

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/glock.c | 47 ++++++++++++++++++++++++-----------------------
 1 file changed, 24 insertions(+), 23 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 6294a9f36318..e754214fdb1c 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -502,7 +502,7 @@ static bool do_promote(struct gfs2_glock *gl)
 			 */
 			if (list_is_first(&gh->gh_list, &gl->gl_holders))
 				return false;
-			do_error(gl, 0);
+			do_error(gl, 0); /* Fail queued try locks */
 			break;
 		}
 		set_bit(HIF_HOLDER, &gh->gh_iflags);
@@ -713,7 +713,6 @@ __acquires(&gl->gl_lockref.lock)
 		if (test_and_set_bit(GLF_INVALIDATE_IN_PROGRESS,
 				     &gl->gl_flags))
 			return;
-		do_error(gl, 0); /* Fail queued try locks */
 	}
 	if (!glops->go_inval && !glops->go_sync)
 		goto skip_inval;
@@ -1459,6 +1458,24 @@ void gfs2_print_dbg(struct seq_file *seq, const char *fmt, ...)
 	va_end(args);
 }
 
+static bool gfs2_should_queue_trylock(struct gfs2_glock *gl,
+				      struct gfs2_holder *gh)
+{
+	struct gfs2_holder *current_gh, *gh2;
+
+	current_gh = find_first_holder(gl);
+	if (current_gh && !may_grant(gl, current_gh, gh))
+		return false;
+
+	list_for_each_entry(gh2, &gl->gl_holders, gh_list) {
+		if (test_bit(HIF_HOLDER, &gh2->gh_iflags))
+			continue;
+		if (!(gh2->gh_flags & (LM_FLAG_TRY | LM_FLAG_TRY_1CB)))
+			return false;
+	}
+	return true;
+}
+
 static inline bool pid_is_meaningful(const struct gfs2_holder *gh)
 {
         if (!(gh->gh_flags & GL_NOPID))
@@ -1477,27 +1494,20 @@ static inline bool pid_is_meaningful(const struct gfs2_holder *gh)
  */
 
 static inline void add_to_queue(struct gfs2_holder *gh)
-__releases(&gl->gl_lockref.lock)
-__acquires(&gl->gl_lockref.lock)
 {
 	struct gfs2_glock *gl = gh->gh_gl;
 	struct gfs2_sbd *sdp = gl->gl_name.ln_sbd;
 	struct gfs2_holder *gh2;
-	int try_futile = 0;
 
 	GLOCK_BUG_ON(gl, gh->gh_owner_pid == NULL);
 	if (test_and_set_bit(HIF_WAIT, &gh->gh_iflags))
 		GLOCK_BUG_ON(gl, true);
 
-	if (gh->gh_flags & (LM_FLAG_TRY | LM_FLAG_TRY_1CB)) {
-		if (test_bit(GLF_LOCK, &gl->gl_flags)) {
-			struct gfs2_holder *current_gh;
-
-			current_gh = find_first_holder(gl);
-			try_futile = !may_grant(gl, current_gh, gh);
-		}
-		if (test_bit(GLF_INVALIDATE_IN_PROGRESS, &gl->gl_flags))
-			goto fail;
+	if ((gh->gh_flags & (LM_FLAG_TRY | LM_FLAG_TRY_1CB)) &&
+	    !gfs2_should_queue_trylock(gl, gh)) {
+		gh->gh_error = GLR_TRYFAILED;
+		gfs2_holder_wake(gh);
+		return;
 	}
 
 	list_for_each_entry(gh2, &gl->gl_holders, gh_list) {
@@ -1509,15 +1519,6 @@ __acquires(&gl->gl_lockref.lock)
 			continue;
 		goto trap_recursive;
 	}
-	list_for_each_entry(gh2, &gl->gl_holders, gh_list) {
-		if (try_futile &&
-		    !(gh2->gh_flags & (LM_FLAG_TRY | LM_FLAG_TRY_1CB))) {
-fail:
-			gh->gh_error = GLR_TRYFAILED;
-			gfs2_holder_wake(gh);
-			return;
-		}
-	}
 	trace_gfs2_glock_queue(gh, 1);
 	gfs2_glstats_inc(gl, GFS2_LKS_QCOUNT);
 	gfs2_sbstats_inc(gl, GFS2_LKS_QCOUNT);
-- 
2.51.0

