Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF28141C62
	for <gfs2@lists.linux.dev>; Sat,  1 Nov 2025 00:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761956566; cv=none; b=gmTtpWaYU+NOpjMHTZOPMV+9MGxW60n5Wt5PnZym4Kb7CHQcb0TQR8uhrmqHxdbMc+hRlkc4BIidyAqr8Afc95PkAdRcecWp7XAGQ6UbalRRqCqUr2ae9wEYjR4Vm7WH3RAvGnTivQ4zylzEJsIKeKK0birRqvBVtvvqmmYcuTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761956566; c=relaxed/simple;
	bh=PTugCctCmXY+3a+tEWYxRfAuBxaBsyHBGITN7YD/02Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=U2bO4UA08s7gEaZ9bRWAYnQNkPxZvGoa/3CqmGSNn9kRMzjef6/MlvrBtWyqJ6G2lc8nUNzGfY2XsZVB8B7cEp7wX5elgdnvHeJKrpWQaJ1zTXQjO/ljQ8Tsm/eLGjlojKXOmNw//AWJvM6//6XNyNSomRJbOHvXT2Zy3F3Ov0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b04QdYfQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b04QdYfQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761956563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rV5+WBMkQZZ5b3Y6TTr5W+NUB6VCn7gcRL93sSYFOrE=;
	b=b04QdYfQrOBMVTThU+CGuMSjqBDpErDnwew5PqHtcjVs+Jw3c0MTUCVJtrieAVg0jYLTrR
	ejLgYqY23LPjAtVykP7037QFM9XpPgbdyYyTs6QuBIKrz8ykzLSHjUvZMdnK/ewvfJLhvw
	Xr8EH0L37VE5zMEOe9UA/6/bvT8Gmn0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-625-7MIaA3GwORmeufCbbFw9Fw-1; Fri,
 31 Oct 2025 20:22:42 -0400
X-MC-Unique: 7MIaA3GwORmeufCbbFw9Fw-1
X-Mimecast-MFC-AGG-ID: 7MIaA3GwORmeufCbbFw9Fw_1761956561
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B548619560AE
	for <gfs2@lists.linux.dev>; Sat,  1 Nov 2025 00:22:41 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.12])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A956B18004D8;
	Sat,  1 Nov 2025 00:22:40 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 03/24] gfs2: Get rid of delayed withdraws
Date: Sat,  1 Nov 2025 00:22:12 +0000
Message-ID: <20251101002234.1286383-4-agruenba@redhat.com>
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
X-Mimecast-MFC-PROC-ID: zKgLjz34-qyjdKUlVueTmdPQkqZmH6JueWNm4KDHuxE_1761956561
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Now that gfs2_withdraw() is asynchronous, is can be called in any
context and there is no more need for gfs2_withdraw_delayed() or for
turning delayed withdraws into actual withdraws.  Remove the
now-obsolete code.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/glock.c  |  2 +-
 fs/gfs2/glops.c  | 11 ++++-------
 fs/gfs2/incore.h |  1 -
 fs/gfs2/log.c    | 21 +++++----------------
 fs/gfs2/lops.c   |  2 +-
 fs/gfs2/sys.c    |  2 --
 fs/gfs2/util.c   | 15 ++-------------
 fs/gfs2/util.h   | 36 +++---------------------------------
 8 files changed, 16 insertions(+), 74 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 938bda75a338..0084c4aeb115 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -756,7 +756,7 @@ __acquires(&gl->gl_lockref.lock)
 	 * then it's okay to tell dlm to unlock it.
 	 */
 	if (unlikely(sdp->sd_log_error) && !gfs2_withdrawing_or_withdrawn(sdp))
-		gfs2_withdraw_delayed(sdp);
+		gfs2_withdraw(sdp);
 	if (glock_blocked_by_withdraw(gl) &&
 	    (target != LM_ST_UNLOCKED ||
 	     test_bit(SDF_WITHDRAW_RECOVERY, &sdp->sd_flags))) {
diff --git a/fs/gfs2/glops.c b/fs/gfs2/glops.c
index 0c0a80b3baca..8166c84a439b 100644
--- a/fs/gfs2/glops.c
+++ b/fs/gfs2/glops.c
@@ -45,7 +45,7 @@ static void gfs2_ail_error(struct gfs2_glock *gl, const struct buffer_head *bh)
 	       gl->gl_name.ln_type, gl->gl_name.ln_number,
 	       gfs2_glock2aspace(gl));
 	gfs2_lm(sdp, "AIL error\n");
-	gfs2_withdraw_delayed(sdp);
+	gfs2_withdraw(sdp);
 }
 
 /**
@@ -83,9 +83,6 @@ static void __gfs2_ail_flush(struct gfs2_glock *gl, bool fsync,
 	GLOCK_BUG_ON(gl, !fsync && atomic_read(&gl->gl_ail_count));
 	spin_unlock(&sdp->sd_ail_lock);
 	gfs2_log_unlock(sdp);
-
-	if (gfs2_withdrawing(sdp))
-		gfs2_withdraw(sdp);
 }
 
 
@@ -608,10 +605,10 @@ static int freeze_go_xmote_bh(struct gfs2_glock *gl)
 		j_gl->gl_ops->go_inval(j_gl, DIO_METADATA);
 
 		error = gfs2_find_jhead(sdp->sd_jdesc, &head);
-		if (gfs2_assert_withdraw_delayed(sdp, !error))
+		if (gfs2_assert_withdraw(sdp, !error))
 			return error;
-		if (gfs2_assert_withdraw_delayed(sdp, head.lh_flags &
-						 GFS2_LOG_HEAD_UNMOUNT))
+		if (gfs2_assert_withdraw(sdp, head.lh_flags &
+					 GFS2_LOG_HEAD_UNMOUNT))
 			return -EIO;
 		gfs2_log_pointers_init(sdp, &head);
 	}
diff --git a/fs/gfs2/incore.h b/fs/gfs2/incore.h
index db0e72adb999..5dfdd1f3c5da 100644
--- a/fs/gfs2/incore.h
+++ b/fs/gfs2/incore.h
@@ -599,7 +599,6 @@ enum {
 	SDF_SKIP_DLM_UNLOCK	= 8,
 	SDF_FORCE_AIL_FLUSH     = 9,
 	SDF_FREEZE_INITIATOR	= 10,
-	SDF_WITHDRAWING		= 11, /* Will withdraw eventually */
 	SDF_WITHDRAW_IN_PROG	= 12, /* Withdraw is in progress */
 	SDF_REMOTE_WITHDRAW	= 13, /* Performing remote recovery */
 	SDF_WITHDRAW_RECOVERY	= 14, /* Wait for journal recovery when we are
diff --git a/fs/gfs2/log.c b/fs/gfs2/log.c
index 115c4ac457e9..26a1baa21535 100644
--- a/fs/gfs2/log.c
+++ b/fs/gfs2/log.c
@@ -114,7 +114,7 @@ __acquires(&sdp->sd_ail_lock)
 			}
 			if (!cmpxchg(&sdp->sd_log_error, 0, -EIO)) {
 				gfs2_io_error_bh(sdp, bh);
-				gfs2_withdraw_delayed(sdp);
+				gfs2_withdraw(sdp);
 			}
 		}
 
@@ -326,7 +326,7 @@ static int gfs2_ail1_empty_one(struct gfs2_sbd *sdp, struct gfs2_trans *tr,
 		if (!buffer_uptodate(bh) &&
 		    !cmpxchg(&sdp->sd_log_error, 0, -EIO)) {
 			gfs2_io_error_bh(sdp, bh);
-			gfs2_withdraw_delayed(sdp);
+			gfs2_withdraw(sdp);
 		}
 		/*
 		 * If we have space for revokes and the bd is no longer on any
@@ -807,9 +807,6 @@ void gfs2_flush_revokes(struct gfs2_sbd *sdp)
 	gfs2_log_lock(sdp);
 	gfs2_ail1_empty(sdp, max_revokes);
 	gfs2_log_unlock(sdp);
-
-	if (gfs2_withdrawing(sdp))
-		gfs2_withdraw(sdp);
 }
 
 /**
@@ -987,9 +984,6 @@ static void empty_ail1_list(struct gfs2_sbd *sdp)
 		if (gfs2_withdrawing_or_withdrawn(sdp))
 			break;
 	}
-
-	if (gfs2_withdrawing(sdp))
-		gfs2_withdraw(sdp);
 }
 
 /**
@@ -1071,7 +1065,7 @@ void gfs2_log_flush(struct gfs2_sbd *sdp, struct gfs2_glock *gl, u32 flags)
 			sdp->sd_log_tr = NULL;
 			tr->tr_first = first_log_head;
 			if (unlikely(frozen)) {
-				if (gfs2_assert_withdraw_delayed(sdp,
+				if (gfs2_assert_withdraw(sdp,
 				       !tr->tr_num_buf_new && !tr->tr_num_databuf_new))
 					goto out_withdraw;
 			}
@@ -1096,7 +1090,7 @@ void gfs2_log_flush(struct gfs2_sbd *sdp, struct gfs2_glock *gl, u32 flags)
 		clear_bit(SDF_JOURNAL_LIVE, &sdp->sd_flags);
 
 	if (unlikely(frozen))
-		if (gfs2_assert_withdraw_delayed(sdp, !reserved_revokes))
+		if (gfs2_assert_withdraw(sdp, !reserved_revokes))
 			goto out_withdraw;
 
 	gfs2_ordered_write(sdp);
@@ -1151,13 +1145,11 @@ void gfs2_log_flush(struct gfs2_sbd *sdp, struct gfs2_glock *gl, u32 flags)
 		reserved_blocks += (reserved_revokes - sdp->sd_ldptrs) / sdp->sd_inptrs;
 out:
 	if (used_blocks != reserved_blocks) {
-		gfs2_assert_withdraw_delayed(sdp, used_blocks < reserved_blocks);
+		gfs2_assert_withdraw(sdp, used_blocks < reserved_blocks);
 		gfs2_log_release(sdp, reserved_blocks - used_blocks);
 	}
 	up_write(&sdp->sd_log_flush_lock);
 	gfs2_trans_free(sdp, tr);
-	if (gfs2_withdrawing(sdp))
-		gfs2_withdraw(sdp);
 	trace_gfs2_log_flush(sdp, 0, flags);
 	return;
 
@@ -1346,9 +1338,6 @@ int gfs2_logd(void *data)
 				t);
 	}
 
-	if (gfs2_withdrawing(sdp))
-		gfs2_withdraw(sdp);
-
 	return 0;
 }
 
diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
index 9c8c305a75c4..0ed81a685fcd 100644
--- a/fs/gfs2/lops.c
+++ b/fs/gfs2/lops.c
@@ -209,7 +209,7 @@ static void gfs2_end_log_write(struct bio *bio)
 		if (!cmpxchg(&sdp->sd_log_error, 0, err))
 			fs_err(sdp, "Error %d writing to journal, jid=%u\n",
 			       err, sdp->sd_jdesc->jd_jid);
-		gfs2_withdraw_delayed(sdp);
+		gfs2_withdraw(sdp);
 		/* prevent more writes to the journal */
 		clear_bit(SDF_JOURNAL_LIVE, &sdp->sd_flags);
 		wake_up(&sdp->sd_logd_waitq);
diff --git a/fs/gfs2/sys.c b/fs/gfs2/sys.c
index 1213f97419f6..8093a596661e 100644
--- a/fs/gfs2/sys.c
+++ b/fs/gfs2/sys.c
@@ -84,7 +84,6 @@ static ssize_t status_show(struct gfs2_sbd *sdp, char *buf)
 		     "Force AIL Flush:          %d\n"
 		     "FS Freeze Initiator:      %d\n"
 		     "FS Frozen:                %d\n"
-		     "Withdrawing:              %d\n"
 		     "Withdraw In Prog:         %d\n"
 		     "Remote Withdraw:          %d\n"
 		     "Withdraw Recovery:        %d\n"
@@ -117,7 +116,6 @@ static ssize_t status_show(struct gfs2_sbd *sdp, char *buf)
 		     test_bit(SDF_FORCE_AIL_FLUSH, &f),
 		     test_bit(SDF_FREEZE_INITIATOR, &f),
 		     test_bit(SDF_FROZEN, &f),
-		     test_bit(SDF_WITHDRAWING, &f),
 		     test_bit(SDF_WITHDRAW_IN_PROG, &f),
 		     test_bit(SDF_REMOTE_WITHDRAW, &f),
 		     test_bit(SDF_WITHDRAW_RECOVERY, &f),
diff --git a/fs/gfs2/util.c b/fs/gfs2/util.c
index c454bea101de..e15e11f6f161 100644
--- a/fs/gfs2/util.c
+++ b/fs/gfs2/util.c
@@ -364,8 +364,7 @@ void gfs2_withdraw(struct gfs2_sbd *sdp)
  */
 
 void gfs2_assert_withdraw_i(struct gfs2_sbd *sdp, char *assertion,
-			    const char *function, char *file, unsigned int line,
-			    bool delayed)
+			    const char *function, char *file, unsigned int line)
 {
 	if (gfs2_withdrawing_or_withdrawn(sdp))
 		return;
@@ -375,17 +374,7 @@ void gfs2_assert_withdraw_i(struct gfs2_sbd *sdp, char *assertion,
 	       "function = %s, file = %s, line = %u\n",
 	       assertion, function, file, line);
 
-	/*
-	 * If errors=panic was specified on mount, it won't help to delay the
-	 * withdraw.
-	 */
-	if (sdp->sd_args.ar_errors == GFS2_ERRORS_PANIC)
-		delayed = false;
-
-	if (delayed)
-		gfs2_withdraw_delayed(sdp);
-	else
-		gfs2_withdraw(sdp);
+	gfs2_withdraw(sdp);
 	dump_stack();
 }
 
diff --git a/fs/gfs2/util.h b/fs/gfs2/util.h
index f424ef2523c4..51347a467b89 100644
--- a/fs/gfs2/util.h
+++ b/fs/gfs2/util.h
@@ -37,24 +37,14 @@ do { \
 
 
 void gfs2_assert_withdraw_i(struct gfs2_sbd *sdp, char *assertion,
-			    const char *function, char *file, unsigned int line,
-			    bool delayed);
+			    const char *function, char *file, unsigned int line);
 
 #define gfs2_assert_withdraw(sdp, assertion) \
 	({ \
 		bool _bool = (assertion); \
 		if (unlikely(!_bool)) \
 			gfs2_assert_withdraw_i((sdp), #assertion, \
-					__func__, __FILE__, __LINE__, false); \
-		!_bool; \
-	})
-
-#define gfs2_assert_withdraw_delayed(sdp, assertion) \
-	({ \
-		bool _bool = (assertion); \
-		if (unlikely(!_bool)) \
-			gfs2_assert_withdraw_i((sdp), #assertion, \
-					__func__, __FILE__, __LINE__, true); \
+					__func__, __FILE__, __LINE__); \
 		!_bool; \
 	})
 
@@ -192,15 +182,6 @@ static inline unsigned int gfs2_tune_get_i(struct gfs2_tune *gt,
 	return x;
 }
 
-/**
- * gfs2_withdraw_delayed - withdraw as soon as possible without deadlocks
- * @sdp: the superblock
- */
-static inline void gfs2_withdraw_delayed(struct gfs2_sbd *sdp)
-{
-	set_bit(SDF_WITHDRAWING, &sdp->sd_flags);
-}
-
 /**
  * gfs2_withdrawing_or_withdrawn - test whether the file system is withdrawing
  *                                 or withdrawn
@@ -208,18 +189,7 @@ static inline void gfs2_withdraw_delayed(struct gfs2_sbd *sdp)
  */
 static inline bool gfs2_withdrawing_or_withdrawn(struct gfs2_sbd *sdp)
 {
-	return unlikely(test_bit(SDF_WITHDRAWN, &sdp->sd_flags) ||
-			test_bit(SDF_WITHDRAWING, &sdp->sd_flags));
-}
-
-/**
- * gfs2_withdrawing - check if a withdraw is pending
- * @sdp: the superblock
- */
-static inline bool gfs2_withdrawing(struct gfs2_sbd *sdp)
-{
-	return unlikely(test_bit(SDF_WITHDRAWING, &sdp->sd_flags) &&
-			!test_bit(SDF_WITHDRAWN, &sdp->sd_flags));
+	return unlikely(test_bit(SDF_WITHDRAWN, &sdp->sd_flags));
 }
 
 static inline bool gfs2_withdraw_in_prog(struct gfs2_sbd *sdp)
-- 
2.51.0

