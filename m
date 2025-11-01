Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E8541C62
	for <gfs2@lists.linux.dev>; Sat,  1 Nov 2025 00:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761956574; cv=none; b=unDPzlDapxqho6pAjIRzym4kbLinQHp/E58LGdT8sqdG4GI7u25pR1tyqm+2f5mHTe9sGI4n9HvK3DyVC8kzDyxnvp9YXzMqwXLsbbXgfrxy38tE/IL5fW3D0UkzXgshJfYishWh5ASsruYBSFo5NtwFYYjyRhjcNLQ6ILOvcjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761956574; c=relaxed/simple;
	bh=hp6wAt9L4lkuHK4W0TO9zRLb8HBPSLWrG3xFDkvH5Cg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=mr/yr4AVLDjpkopDC2PbS9dQ0xuGl0caPaoNMB13yfN69LkxthKmFS71WA73hTUQ/dZLtbEV9hGU2mSfoBn/WowPPvqwCYFuNw8wkbgvXsegJWTe/4t3/fOWnTvIZToiGDWgMy6/a6gSfblbTBGHEWm5s6GM1sjqnTfnXB+LCmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HHTk4F2h; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HHTk4F2h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761956572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ktz7kStnjZycvIr19k5xHbovP8OiiHMpOvxDcOIR1BQ=;
	b=HHTk4F2hAnYXldI1RjqV6iNOxA1UPrApLqxsRae/6xYgnCyyFf0CoK6ChYWvy6/b6TarCV
	H+vT5YXYwHjOZLq2OJQGxufOc3kL0Yah1vqivZY0YHGAYv0tP42B8gAfVXB5mgE2ONvzpJ
	nGO1P7OXgPCKqPspWCKVVj1YHjgZdsc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-97-J3SI1gEAMV29Tcr6_1mStw-1; Fri,
 31 Oct 2025 20:22:50 -0400
X-MC-Unique: J3SI1gEAMV29Tcr6_1mStw-1
X-Mimecast-MFC-AGG-ID: J3SI1gEAMV29Tcr6_1mStw_1761956569
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A92A419560B5
	for <gfs2@lists.linux.dev>; Sat,  1 Nov 2025 00:22:49 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.12])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8155E18004D8;
	Sat,  1 Nov 2025 00:22:48 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 08/24] Revert "gfs2: don't stop reads while withdraw in progress"
Date: Sat,  1 Nov 2025 00:22:17 +0000
Message-ID: <20251101002234.1286383-9-agruenba@redhat.com>
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
X-Mimecast-MFC-PROC-ID: wR8BeoW9rn9vv7ngtF4TDVGm8iXHZa6vWvDLVsFhZ4k_1761956569
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The current withdraw code duplicates the journal recovery code gfs2
already has for dealing with node failures, and it does so poorly.  That
code was added because when releasing a lockspace, we didn't have a way
to indicate that the lockspace needs recovery.  We now do have this
feature, so the current withdraw code can be removed almost entirely.
This is one of several steps towards that.

The withdrawing node has no role in recovering from the withdraw
anymore, so it also no longer needs to read metadata blocks after a
withdraw.

We now only need to set a single bit in gfs2_withdraw(), so switch from
try_cmpxchg() to test_and_set_bit().

Reverts commit 8cc67f704f4b ("gfs2: don't stop reads while withdraw in
progress").

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/incore.h  |  1 -
 fs/gfs2/meta_io.c |  9 +++------
 fs/gfs2/sys.c     |  2 --
 fs/gfs2/util.c    | 11 +++--------
 fs/gfs2/util.h    |  5 -----
 5 files changed, 6 insertions(+), 22 deletions(-)

diff --git a/fs/gfs2/incore.h b/fs/gfs2/incore.h
index 5dfdd1f3c5da..7886a4452daf 100644
--- a/fs/gfs2/incore.h
+++ b/fs/gfs2/incore.h
@@ -599,7 +599,6 @@ enum {
 	SDF_SKIP_DLM_UNLOCK	= 8,
 	SDF_FORCE_AIL_FLUSH     = 9,
 	SDF_FREEZE_INITIATOR	= 10,
-	SDF_WITHDRAW_IN_PROG	= 12, /* Withdraw is in progress */
 	SDF_REMOTE_WITHDRAW	= 13, /* Performing remote recovery */
 	SDF_WITHDRAW_RECOVERY	= 14, /* Wait for journal recovery when we are
 					 withdrawing */
diff --git a/fs/gfs2/meta_io.c b/fs/gfs2/meta_io.c
index c680d5a226bf..e4356198d8d8 100644
--- a/fs/gfs2/meta_io.c
+++ b/fs/gfs2/meta_io.c
@@ -263,8 +263,7 @@ int gfs2_meta_read(struct gfs2_glock *gl, u64 blkno, int flags,
 	struct buffer_head *bh, *bhs[2];
 	int num = 0;
 
-	if (gfs2_withdrawn(sdp) &&
-	    !gfs2_withdraw_in_prog(sdp)) {
+	if (gfs2_withdrawn(sdp)) {
 		*bhp = NULL;
 		return -EIO;
 	}
@@ -322,8 +321,7 @@ int gfs2_meta_read(struct gfs2_glock *gl, u64 blkno, int flags,
 
 int gfs2_meta_wait(struct gfs2_sbd *sdp, struct buffer_head *bh)
 {
-	if (gfs2_withdrawn(sdp) &&
-	    !gfs2_withdraw_in_prog(sdp))
+	if (gfs2_withdrawn(sdp))
 		return -EIO;
 
 	wait_on_buffer(bh);
@@ -334,8 +332,7 @@ int gfs2_meta_wait(struct gfs2_sbd *sdp, struct buffer_head *bh)
 			gfs2_io_error_bh(sdp, bh);
 		return -EIO;
 	}
-	if (gfs2_withdrawn(sdp) &&
-	    !gfs2_withdraw_in_prog(sdp))
+	if (gfs2_withdrawn(sdp))
 		return -EIO;
 
 	return 0;
diff --git a/fs/gfs2/sys.c b/fs/gfs2/sys.c
index 5439a65549af..80389fc167a6 100644
--- a/fs/gfs2/sys.c
+++ b/fs/gfs2/sys.c
@@ -84,7 +84,6 @@ static ssize_t status_show(struct gfs2_sbd *sdp, char *buf)
 		     "Force AIL Flush:          %d\n"
 		     "FS Freeze Initiator:      %d\n"
 		     "FS Frozen:                %d\n"
-		     "Withdraw In Prog:         %d\n"
 		     "Remote Withdraw:          %d\n"
 		     "Withdraw Recovery:        %d\n"
 		     "Killing:                  %d\n"
@@ -116,7 +115,6 @@ static ssize_t status_show(struct gfs2_sbd *sdp, char *buf)
 		     test_bit(SDF_FORCE_AIL_FLUSH, &f),
 		     test_bit(SDF_FREEZE_INITIATOR, &f),
 		     test_bit(SDF_FROZEN, &f),
-		     test_bit(SDF_WITHDRAW_IN_PROG, &f),
 		     test_bit(SDF_REMOTE_WITHDRAW, &f),
 		     test_bit(SDF_WITHDRAW_RECOVERY, &f),
 		     test_bit(SDF_KILL, &f),
diff --git a/fs/gfs2/util.c b/fs/gfs2/util.c
index 8e47f106e2ba..da7e4e5037b2 100644
--- a/fs/gfs2/util.c
+++ b/fs/gfs2/util.c
@@ -330,19 +330,13 @@ void gfs2_withdraw_func(struct work_struct *work)
 	if (lm->lm_unmount)
 		lm->lm_unmount(sdp, false);
 	fs_err(sdp, "file system withdrawn\n");
-	clear_bit(SDF_WITHDRAW_IN_PROG, &sdp->sd_flags);
 }
 
 void gfs2_withdraw(struct gfs2_sbd *sdp)
 {
 	if (sdp->sd_args.ar_errors == GFS2_ERRORS_WITHDRAW) {
-		unsigned long old = READ_ONCE(sdp->sd_flags), new;
-
-		do {
-			if (old & BIT(SDF_WITHDRAWN))
-				return;
-			new = old | BIT(SDF_WITHDRAWN) | BIT(SDF_WITHDRAW_IN_PROG);
-		} while (unlikely(!try_cmpxchg(&sdp->sd_flags, &old, new)));
+		if (test_and_set_bit(SDF_WITHDRAWN, &sdp->sd_flags))
+			return;
 
 		dump_stack();
 		/*
@@ -353,6 +347,7 @@ void gfs2_withdraw(struct gfs2_sbd *sdp)
 			return;
 		fs_err(sdp, "about to withdraw this file system\n");
 		schedule_work(&sdp->sd_withdraw_work);
+		return;
 	}
 
 	if (sdp->sd_args.ar_errors == GFS2_ERRORS_PANIC)
diff --git a/fs/gfs2/util.h b/fs/gfs2/util.h
index d30e6a8ba8af..ffcc47d6b0b4 100644
--- a/fs/gfs2/util.h
+++ b/fs/gfs2/util.h
@@ -187,11 +187,6 @@ static inline bool gfs2_withdrawn(struct gfs2_sbd *sdp)
 	return unlikely(test_bit(SDF_WITHDRAWN, &sdp->sd_flags));
 }
 
-static inline bool gfs2_withdraw_in_prog(struct gfs2_sbd *sdp)
-{
-	return unlikely(test_bit(SDF_WITHDRAW_IN_PROG, &sdp->sd_flags));
-}
-
 #define gfs2_tune_get(sdp, field) \
 gfs2_tune_get_i(&(sdp)->sd_tune, &(sdp)->sd_tune.field)
 
-- 
2.51.0

