Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EE53C9EF1
	for <gfs2@lists.linux.dev>; Mon, 13 Apr 2026 14:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776091960; cv=none; b=OLD3prfSjC51204Fo8NlcHIoOPzgnwWFQnp4GBLPJ31QdW08qgUbLL2I1TeP8+rMFHbXlafypn+1wYzlFPBIxMojLoLo80v7HVTpTOBqH4A+nQU52wpKJ/9ZZzE7ePlGWqr29/5pL6QU0KlqbARfb7zaIkGYGvI3fPa/vaeDvwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776091960; c=relaxed/simple;
	bh=JwDIMFMkFH1rY1jl3IzZnukUSflOIt6LsXLJYgeMG0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=I+jBAvYfg/Qxvotrqg8S/AkqD1hopSWrPQDXKwdBZjQFY8qxWU3WbMBQPPXniSBcKLJfo/v/SyDWweedD5NMGxxzadchpQnekxuMymikBpuxXZ0ruisnr+n8QvLCnbtGXq8AqUHsNbvJMBpqu/gjCZKu1dK54D4JtRcVscSRwWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tg/C80oH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tg/C80oH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776091958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1Cd6hJ9W2bN7CZbdsxP9h/bvR1jwEjqbWd3OUE3VyRk=;
	b=Tg/C80oHlDxKQdjTjaf0pj4GZBIAWpSbwrHGms6oDiV/eQCvVb73B9anrYguNRU8TJHKNw
	VrucYqkzeuqgVdjGeQ7IEMvzZE9K4pGE7n3HUwzUnbvN/D0b1frN2H8Byfbux9+Eg8hIWp
	2iX2so9aKga7nb4W3bwQXUsuBd/WKv0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-687-MIUbxlKzNrOACV7LonO-2w-1; Mon,
 13 Apr 2026 10:52:34 -0400
X-MC-Unique: MIUbxlKzNrOACV7LonO-2w-1
X-Mimecast-MFC-AGG-ID: MIUbxlKzNrOACV7LonO-2w_1776091953
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AAB711955DB2
	for <gfs2@lists.linux.dev>; Mon, 13 Apr 2026 14:52:33 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.44.32.156])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B6D6719560AB;
	Mon, 13 Apr 2026 14:52:32 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 13/18] gfs2: add some missing log locking
Date: Mon, 13 Apr 2026 16:52:06 +0200
Message-ID: <20260413145211.881752-14-agruenba@redhat.com>
In-Reply-To: <20260413145211.881752-1-agruenba@redhat.com>
References: <20260413145211.881752-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: EO09_WlyNnZEa1M-lqEf2wXNF6Ekf3XfW0yz9JeWKD4_1776091953
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Function gfs2_logd() calls the log flushing functions gfs2_ail1_start(),
gfs2_ail1_wait(), and gfs2_ail1_empty() without holding sdp->sd_log_flush_lock,
but these functions require exclusion against concurrent transactions.

To fix that, add a non-locking __gfs2_log_flush() function.  Then, in
gfs2_logd(), take sdp->sd_log_flush_lock before calling the above mentioned log
flushing functions and __gfs2_log_flush().

Fixes: 5e4c7632aae1c ("gfs2: Issue revokes more intelligently")
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/log.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/fs/gfs2/log.c b/fs/gfs2/log.c
index 31ee7a0e86a2..a96f9b9331e8 100644
--- a/fs/gfs2/log.c
+++ b/fs/gfs2/log.c
@@ -1053,14 +1053,15 @@ void gfs2_remove_from_journal(struct buffer_head *bh, int meta)
 }
 
 /**
- * gfs2_log_flush - flush incore transaction(s)
+ * __gfs2_log_flush - flush incore transaction(s)
  * @sdp: The filesystem
  * @gl: The glock structure to flush.  If NULL, flush the whole incore log
  * @flags: The log header flags: GFS2_LOG_HEAD_FLUSH_* and debug flags
  *
  */
 
-void gfs2_log_flush(struct gfs2_sbd *sdp, struct gfs2_glock *gl, u32 flags)
+static void __gfs2_log_flush(struct gfs2_sbd *sdp, struct gfs2_glock *gl,
+			     u32 flags)
 {
 	struct gfs2_trans *tr = NULL;
 	unsigned int reserved_blocks = 0, used_blocks = 0;
@@ -1068,7 +1069,6 @@ void gfs2_log_flush(struct gfs2_sbd *sdp, struct gfs2_glock *gl, u32 flags)
 	unsigned int first_log_head;
 	unsigned int reserved_revokes = 0;
 
-	down_write(&sdp->sd_log_flush_lock);
 	trace_gfs2_log_flush(sdp, 1, flags);
 
 repeat:
@@ -1180,7 +1180,6 @@ void gfs2_log_flush(struct gfs2_sbd *sdp, struct gfs2_glock *gl, u32 flags)
 		gfs2_assert_withdraw(sdp, used_blocks < reserved_blocks);
 		gfs2_log_release(sdp, reserved_blocks - used_blocks);
 	}
-	up_write(&sdp->sd_log_flush_lock);
 	gfs2_trans_free(sdp, tr);
 	trace_gfs2_log_flush(sdp, 0, flags);
 	return;
@@ -1201,6 +1200,13 @@ void gfs2_log_flush(struct gfs2_sbd *sdp, struct gfs2_glock *gl, u32 flags)
 	goto out_end;
 }
 
+void gfs2_log_flush(struct gfs2_sbd *sdp, struct gfs2_glock *gl, u32 flags)
+{
+	down_write(&sdp->sd_log_flush_lock);
+	__gfs2_log_flush(sdp, gl, flags);
+	up_write(&sdp->sd_log_flush_lock);
+}
+
 /**
  * gfs2_merge_trans - Merge a new transaction into a cached transaction
  * @sdp: the filesystem
@@ -1332,19 +1338,25 @@ int gfs2_logd(void *data)
 			break;
 
 		if (gfs2_jrnl_flush_reqd(sdp) || t == 0) {
+			down_write(&sdp->sd_log_flush_lock);
 			gfs2_ail1_empty(sdp, 0);
-			gfs2_log_flush(sdp, NULL, GFS2_LOG_HEAD_FLUSH_NORMAL |
-						  GFS2_LFC_LOGD_JFLUSH_REQD);
+			__gfs2_log_flush(sdp, NULL,
+					 GFS2_LOG_HEAD_FLUSH_NORMAL |
+					 GFS2_LFC_LOGD_JFLUSH_REQD);
+			up_write(&sdp->sd_log_flush_lock);
 		}
 
 		if (test_bit(SDF_FORCE_AIL_FLUSH, &sdp->sd_flags) ||
 		    gfs2_ail_flush_reqd(sdp)) {
 			clear_bit(SDF_FORCE_AIL_FLUSH, &sdp->sd_flags);
+			down_write(&sdp->sd_log_flush_lock);
 			gfs2_ail1_start(sdp);
 			gfs2_ail1_wait(sdp);
 			gfs2_ail1_empty(sdp, 0);
-			gfs2_log_flush(sdp, NULL, GFS2_LOG_HEAD_FLUSH_NORMAL |
-						  GFS2_LFC_LOGD_AIL_FLUSH_REQD);
+			__gfs2_log_flush(sdp, NULL,
+					 GFS2_LOG_HEAD_FLUSH_NORMAL |
+					 GFS2_LFC_LOGD_AIL_FLUSH_REQD);
+			up_write(&sdp->sd_log_flush_lock);
 		}
 
 		t = gfs2_tune_get(sdp, gt_logd_secs) * HZ;
-- 
2.53.0

