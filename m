Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA05C382F0C
	for <gfs2@lists.linux.dev>; Tue, 28 Jul 2026 16:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785256899; cv=none; b=PQ4JT6m32/5Urh40l8hlDVE1D8gDHxX29dnHTydtd3lZQAZ5R9wS0L518CIE11gdodOfTgzimRZwonDzXZMDDC/CIcY9nEPS/w4BjA2AJJMxDeAQUIuyLNPQDfoSVZfpHouTU8n/bCvWbQHgQu2lbNqNvbqy8HzK7+oAFo6mfy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785256899; c=relaxed/simple;
	bh=YWF9yfyLFlr3SYWEaZANgY8pDU9Q4p26avFGxLtjdOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=k4beeajnifK/QzO99WJ6JN2UFid+CBJRVrkOQiphe3HVG1BQ53GnTI3rCqScydrKUQLvBJj6HUXWLCugnhPcxDq5ChEDqIYIZkd8t4fJ2JO6GScRWtRHaVybzfRppvJilNvFfdRE/Q16Iuzf9tjLPEAnaa/BwaBYTo79xQE6Hz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nm1z2Avo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nm1z2Avo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785256896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Udkb8Nhf280Ty+0cWPxhELmxNsjfIcqnK9mFd5zjf7Q=;
	b=Nm1z2AvoRiohMH1ND6XUjv6NdgVLkeJVEyYuvz3kxcqlVN8pj1UwScybolIAGLCSZ6m4sf
	1sQm0gU0E7x8/+jp295QxS7ZPka8VinqRCVCO673wjpYfNSZAGCTXB2h0PuXtZWGMwAn6R
	hR7ZVSZQzxkROXDZZzHJHuc93eXs5H0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-394-Awxr6kb8MCS0WLFLZViYCA-1; Tue,
 28 Jul 2026 12:41:35 -0400
X-MC-Unique: Awxr6kb8MCS0WLFLZViYCA-1
X-Mimecast-MFC-AGG-ID: Awxr6kb8MCS0WLFLZViYCA_1785256894
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6C60A1956043
	for <gfs2@lists.linux.dev>; Tue, 28 Jul 2026 16:41:34 +0000 (UTC)
Received: from pasta.redhat.com (unknown [10.44.48.20])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7E4C8300019F;
	Tue, 28 Jul 2026 16:41:33 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 3/4] gfs2: Skip dlm unlocks earlier
Date: Tue, 28 Jul 2026 18:41:23 +0200
Message-ID: <20260728164127.791843-4-agruenba@redhat.com>
In-Reply-To: <20260728164127.791843-1-agruenba@redhat.com>
References: <20260728164127.791843-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: B76LhB440CRobnqHpU_vasRFCDQ5wOtYHJgL9cp9Byo_1785256894
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

When we were still caching unreferenced glocks, evicting all the cached inodes
in gfs2_kill_sb() did put the unreferenced glocks onto the glock lru list, and
they would be freed in gfs2_gl_hash_clear().  We could set the
SDF_SKIP_DLM_UNLOCK flag in gfs2_gl_hash_clear() to indicate to gdlm_put_lock()
to skip unlocking glocks explicitly when possible.  Now, glocks are demoted and
dropped immediately though, so to allow gdlm_put_lock() to skip unnecessary
unlocking, we need to set some "unmount" flag before calling
gfs2_evict_inodes().  We can use the existing SDF_KILL flag for that if we set
it before calling gfs2_evict_inodes() in gfs2_kill_sb().

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/glock.c      | 2 --
 fs/gfs2/incore.h     | 1 -
 fs/gfs2/lock_dlm.c   | 2 +-
 fs/gfs2/ops_fstype.c | 2 +-
 fs/gfs2/sys.c        | 2 --
 5 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index f00dcae426c5..eee1f31a41f0 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -2152,8 +2152,6 @@ void gfs2_gl_hash_clear(struct gfs2_sbd *sdp)
 	unsigned long start = jiffies;
 	bool timed_out = false;
 
-	set_bit(SDF_SKIP_DLM_UNLOCK, &sdp->sd_flags);
-	flush_workqueue(sdp->sd_glock_wq);
 	glock_hash_walk(clear_glock, sdp);
 	flush_workqueue(sdp->sd_glock_wq);
 
diff --git a/fs/gfs2/incore.h b/fs/gfs2/incore.h
index 61465777826a..6098447866d9 100644
--- a/fs/gfs2/incore.h
+++ b/fs/gfs2/incore.h
@@ -601,7 +601,6 @@ enum {
 	SDF_DEMOTE		= 5,
 	SDF_NOJOURNALID		= 6,
 	SDF_RORECOVERY		= 7, /* read only recovery */
-	SDF_SKIP_DLM_UNLOCK	= 8,
 	SDF_FORCE_AIL_FLUSH     = 9,
 	SDF_FREEZE_INITIATOR	= 10,
 	SDF_KILL		= 15,
diff --git a/fs/gfs2/lock_dlm.c b/fs/gfs2/lock_dlm.c
index 7828ad0b6f5a..ab7ac8e634bf 100644
--- a/fs/gfs2/lock_dlm.c
+++ b/fs/gfs2/lock_dlm.c
@@ -347,7 +347,7 @@ static void gdlm_put_lock(struct gfs2_glock *gl)
 	 * DLM_LOCK_PW mode, the lock value block (LVB) would be lost.
 	 */
 
-	if (test_bit(SDF_SKIP_DLM_UNLOCK, &sdp->sd_flags) &&
+	if (test_bit(SDF_KILL, &sdp->sd_flags) &&
 	    (!gl->gl_lksb.sb_lvbptr || gl->gl_state != LM_ST_EXCLUSIVE)) {
 		gfs2_glock_free_later(gl);
 		return;
diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index 9b9e70f14d25..71e9dedd8b88 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -1783,6 +1783,7 @@ static void gfs2_kill_sb(struct super_block *sb)
 	sdp->sd_master_dir = NULL;
 	shrink_dcache_sb(sb);
 
+	set_bit(SDF_KILL, &sdp->sd_flags);
 	gfs2_evict_inodes(sb);
 
 	/*
@@ -1790,7 +1791,6 @@ static void gfs2_kill_sb(struct super_block *sb)
 	 * destroy_workqueue()) to ensure that any delete work that
 	 * may be running will also see the SDF_KILL flag.
 	 */
-	set_bit(SDF_KILL, &sdp->sd_flags);
 	gfs2_flush_delete_work(sdp);
 	destroy_workqueue(sdp->sd_delete_wq);
 
diff --git a/fs/gfs2/sys.c b/fs/gfs2/sys.c
index 7051db9dbea0..ea2c7b9e4a77 100644
--- a/fs/gfs2/sys.c
+++ b/fs/gfs2/sys.c
@@ -80,7 +80,6 @@ static ssize_t status_show(struct gfs2_sbd *sdp, char *buf)
 		     "No Journal ID:            %d\n"
 		     "Mounted RO:               %d\n"
 		     "RO Recovery:              %d\n"
-		     "Skip DLM Unlock:          %d\n"
 		     "Force AIL Flush:          %d\n"
 		     "FS Freeze Initiator:      %d\n"
 		     "FS Frozen:                %d\n"
@@ -109,7 +108,6 @@ static ssize_t status_show(struct gfs2_sbd *sdp, char *buf)
 		     test_bit(SDF_NOJOURNALID, &f),
 		     (sb_rdonly(sdp->sd_vfs) ? 1 : 0),
 		     test_bit(SDF_RORECOVERY, &f),
-		     test_bit(SDF_SKIP_DLM_UNLOCK, &f),
 		     test_bit(SDF_FORCE_AIL_FLUSH, &f),
 		     test_bit(SDF_FREEZE_INITIATOR, &f),
 		     test_bit(SDF_FROZEN, &f),
-- 
2.55.0

