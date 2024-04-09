Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4A314F12C
	for <gfs2@lists.linux.dev>; Tue,  9 Apr 2024 16:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712681124; cv=none; b=N5aIXM4zfTSMHQlsW2NNT1cI4CkWB+jBsWXysBHkmp9bDbsluZwFMUciOvliwTJdgy2WndlePWvpRQ3ymILA6AGgiWG5YSFwlG8k0NqYEyKeUjqNkljUpKXpmOiEkOB9zRUCj1Ud4qWx7y+UQRWavegAWhgPhLzVhzDlYgK3FnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712681124; c=relaxed/simple;
	bh=5k+w8DAdBNnpv6AdLahXzYRs3Q96AlNFTrXuEWCRcPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PdF8yE7NzY4ppta0czqMvfVNKVrUeTB1tmQ0bCKgNrc8RMUwtb86hu6dM/pk4O7rC3zoN2Vl9SUfDOAZklyYJ/Yqr5cDIreI3Zw0Kl8TumYSJEMHEkjnr1UBX3FM+WMX2GxjhfCz3D4cgfKvS6AQFYwdEzT2EwEXnld+HNimMis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KL7Hmiu7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KL7Hmiu7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712681121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p4htDxS5BB8Rqia7Kb84552bESi5ay3AY4Sqv17geMg=;
	b=KL7Hmiu7qH+Ijlump2l4QquUQY6xKgBK4euNFqSVECcFZ6uFzDgGJEXg47c/vamHF9M9vd
	pPo9xuzRUom5LFk+3y1m1xKnEb2RW7xXRjqn3lWdRB/+s8m/orsm0WQ8aDILa5PjZMv5xH
	sXsry1zBv/jjD0dcL92saLNpiOrBJ/I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-PtcN4kw2NPOPn8oseHd3Qw-1; Tue, 09 Apr 2024 12:45:20 -0400
X-MC-Unique: PtcN4kw2NPOPn8oseHd3Qw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E386E80D626
	for <gfs2@lists.linux.dev>; Tue,  9 Apr 2024 16:45:19 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.28])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 64E3DC0157E;
	Tue,  9 Apr 2024 16:45:19 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 08/15] gfs2: Replace gfs2_glock_queue_put with gfs2_glock_put_async
Date: Tue,  9 Apr 2024 18:44:58 +0200
Message-ID: <20240409164508.79570-9-agruenba@redhat.com>
In-Reply-To: <20240409164508.79570-1-agruenba@redhat.com>
References: <20240409164508.79570-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Function gfs2_glock_queue_put() puts a glock reference by enqueuing
glock work instead of putting the reference directly.  This ensures that
the operation won't sleep, but it is costly and really only necessary
when putting the final glock reference.  Replace it with a new
gfs2_glock_put_async() function that only queues glock work when putting
the last glock reference.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/glock.c | 27 +++++++++++++++++----------
 fs/gfs2/glock.h |  2 +-
 fs/gfs2/log.c   |  2 +-
 fs/gfs2/super.c |  4 ++--
 4 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 34540f9d011c..ed90033b9c72 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -285,14 +285,6 @@ static void __gfs2_glock_put(struct gfs2_glock *gl)
 	sdp->sd_lockstruct.ls_ops->lm_put_lock(gl);
 }
 
-/*
- * Cause the glock to be put in work queue context.
- */
-void gfs2_glock_queue_put(struct gfs2_glock *gl)
-{
-	gfs2_glock_queue_work(gl, 0);
-}
-
 /**
  * gfs2_glock_put() - Decrement reference count on glock
  * @gl: The glock to put
@@ -307,6 +299,22 @@ void gfs2_glock_put(struct gfs2_glock *gl)
 	__gfs2_glock_put(gl);
 }
 
+/*
+ * gfs2_glock_put_async - Decrement reference count without sleeping
+ * @gl: The glock to put
+ *
+ * Decrement the reference count on glock immediately unless it is the last
+ * reference.  Defer putting the last reference to work queue context.
+ */
+void gfs2_glock_put_async(struct gfs2_glock *gl)
+{
+	if (lockref_put_or_lock(&gl->gl_lockref))
+		return;
+
+	__gfs2_glock_queue_work(gl, 0);
+	spin_unlock(&gl->gl_lockref.lock);
+}
+
 /**
  * may_grant - check if it's ok to grant a new lock
  * @gl: The glock
@@ -2529,8 +2537,7 @@ static void gfs2_glock_iter_next(struct gfs2_glock_iter *gi, loff_t n)
 	if (gl) {
 		if (n == 0)
 			return;
-		if (!lockref_put_not_zero(&gl->gl_lockref))
-			gfs2_glock_queue_put(gl);
+		gfs2_glock_put_async(gl);
 	}
 	for (;;) {
 		gl = rhashtable_walk_next(&gi->hti);
diff --git a/fs/gfs2/glock.h b/fs/gfs2/glock.h
index 0114f3e0ebe0..2c697674a86f 100644
--- a/fs/gfs2/glock.h
+++ b/fs/gfs2/glock.h
@@ -172,7 +172,7 @@ int gfs2_glock_get(struct gfs2_sbd *sdp, u64 number,
 		   int create, struct gfs2_glock **glp);
 struct gfs2_glock *gfs2_glock_hold(struct gfs2_glock *gl);
 void gfs2_glock_put(struct gfs2_glock *gl);
-void gfs2_glock_queue_put(struct gfs2_glock *gl);
+void gfs2_glock_put_async(struct gfs2_glock *gl);
 
 void __gfs2_holder_init(struct gfs2_glock *gl, unsigned int state,
 		        u16 flags, struct gfs2_holder *gh,
diff --git a/fs/gfs2/log.c b/fs/gfs2/log.c
index a6dd68b458ce..6ee6013fb825 100644
--- a/fs/gfs2/log.c
+++ b/fs/gfs2/log.c
@@ -786,7 +786,7 @@ void gfs2_glock_remove_revoke(struct gfs2_glock *gl)
 {
 	if (atomic_dec_return(&gl->gl_revokes) == 0) {
 		clear_bit(GLF_LFLUSH, &gl->gl_flags);
-		gfs2_glock_queue_put(gl);
+		gfs2_glock_put_async(gl);
 	}
 }
 
diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index 9de789b78bc5..d481db9510ac 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -1049,7 +1049,7 @@ static int gfs2_drop_inode(struct inode *inode)
 
 		gfs2_glock_hold(gl);
 		if (!gfs2_queue_try_to_evict(gl))
-			gfs2_glock_queue_put(gl);
+			gfs2_glock_put_async(gl);
 		return 0;
 	}
 
@@ -1255,7 +1255,7 @@ static int gfs2_dinode_dealloc(struct gfs2_inode *ip)
 static void gfs2_glock_put_eventually(struct gfs2_glock *gl)
 {
 	if (current->flags & PF_MEMALLOC)
-		gfs2_glock_queue_put(gl);
+		gfs2_glock_put_async(gl);
 	else
 		gfs2_glock_put(gl);
 }
-- 
2.44.0

