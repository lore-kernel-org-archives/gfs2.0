Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F751C4A24
	for <gfs2@lists.linux.dev>; Sat,  1 Nov 2025 00:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761956575; cv=none; b=hptewRUcCzR18kr5OWp1hX+m6WE9fjSIeVji1tljawiZUsIx17iyYR3m2fzbhgCjcQlnKf1XVc/xwxtCb1SuNVir/UETQlqf2GmvCU75xjqj/rgq16VarBswCCF73i6LlsEqN7wGzmN/HKvZHgzhDpYJUyYrIFIHr66eACjTgKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761956575; c=relaxed/simple;
	bh=EsEPYywLUVPqdSJ+tpXX7Mcw4fylwgrvpagP5/3koTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=BN85nR+hLWG0BOVYrpzNIDMbGwpHEXYXq4xYEM4DYs3aDoRnOhFbZxj4UgHXSUIxOxXhE6BsiXM5w3rgg5MLZKMb43+2fImKVd9T7oyptHX4pBwpHqEPK5qziIiErVL2KzKEiRmtSvwrbIA/XZsjWLcQtWyxcs1r2KuIE4snd/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U0bgMPZB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U0bgMPZB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761956571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1VuKv/hPYW+jcFuuh5ojKJbubP4ZYrDXue8IuBJaVw4=;
	b=U0bgMPZBIq8CwR2x8T4ahrTLkRxwOOL9d4Qbm97v/AbSbnVbmaOmAO0SXp7OKPYUw7iCc7
	rQndHJsyB3/tUpNqKQWyunDJ1aiM3jN5gjw8tOjgHq4IStHqPfauZwzSFMpuNIDq73De90
	CEQoIpjaOyesG0+eLIdR5Kk1nx7wHs4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-306-cr4v0gzLMZ6sr-zGBB5KTw-1; Fri,
 31 Oct 2025 20:22:48 -0400
X-MC-Unique: cr4v0gzLMZ6sr-zGBB5KTw-1
X-Mimecast-MFC-AGG-ID: cr4v0gzLMZ6sr-zGBB5KTw_1761956566
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 78C7519560A3
	for <gfs2@lists.linux.dev>; Sat,  1 Nov 2025 00:22:46 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.12])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6D2C91800579;
	Sat,  1 Nov 2025 00:22:45 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 06/24] gfs2: Kill gfs2_io_error_bh_wd
Date: Sat,  1 Nov 2025 00:22:15 +0000
Message-ID: <20251101002234.1286383-7-agruenba@redhat.com>
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
X-Mimecast-MFC-PROC-ID: H4IMLJdH9KleO1YERce5pFSPFNGwAXJgfFVaeKsoX_Q_1761956566
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

All callers of gfs2_io_error_bh() call gfs2_withdraw() as well, so
change gfs2_io_error_bh() to call gfs2_withdraw() directly.  This also
brings it in line with other similar error reporting functions.

With that, gfs2_io_error_bh() is the same as gfs2_io_error_bh_wd(), so
remove the latter.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/log.c     |  8 ++------
 fs/gfs2/lops.c    |  2 +-
 fs/gfs2/meta_io.c |  4 ++--
 fs/gfs2/util.c    | 10 +++-------
 fs/gfs2/util.h    |  8 ++------
 5 files changed, 10 insertions(+), 22 deletions(-)

diff --git a/fs/gfs2/log.c b/fs/gfs2/log.c
index 69734e18b23d..8312cd2cdae4 100644
--- a/fs/gfs2/log.c
+++ b/fs/gfs2/log.c
@@ -112,10 +112,8 @@ __acquires(&sdp->sd_ail_lock)
 					  &tr->tr_ail2_list);
 				continue;
 			}
-			if (!cmpxchg(&sdp->sd_log_error, 0, -EIO)) {
+			if (!cmpxchg(&sdp->sd_log_error, 0, -EIO))
 				gfs2_io_error_bh(sdp, bh);
-				gfs2_withdraw(sdp);
-			}
 		}
 
 		if (gfs2_withdrawn(sdp)) {
@@ -324,10 +322,8 @@ static int gfs2_ail1_empty_one(struct gfs2_sbd *sdp, struct gfs2_trans *tr,
 			continue;
 		}
 		if (!buffer_uptodate(bh) &&
-		    !cmpxchg(&sdp->sd_log_error, 0, -EIO)) {
+		    !cmpxchg(&sdp->sd_log_error, 0, -EIO))
 			gfs2_io_error_bh(sdp, bh);
-			gfs2_withdraw(sdp);
-		}
 		/*
 		 * If we have space for revokes and the bd is no longer on any
 		 * buf list, we can just add a revoke for it immediately and
diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
index 0ed81a685fcd..84ee34843b77 100644
--- a/fs/gfs2/lops.c
+++ b/fs/gfs2/lops.c
@@ -49,7 +49,7 @@ void gfs2_pin(struct gfs2_sbd *sdp, struct buffer_head *bh)
 	if (test_set_buffer_pinned(bh))
 		gfs2_assert_withdraw(sdp, 0);
 	if (!buffer_uptodate(bh))
-		gfs2_io_error_bh_wd(sdp, bh);
+		gfs2_io_error_bh(sdp, bh);
 	bd = bh->b_private;
 	/* If this buffer is in the AIL and it has already been written
 	 * to in-place disk block, remove it from the AIL.
diff --git a/fs/gfs2/meta_io.c b/fs/gfs2/meta_io.c
index 3ee90a4452b9..c680d5a226bf 100644
--- a/fs/gfs2/meta_io.c
+++ b/fs/gfs2/meta_io.c
@@ -303,7 +303,7 @@ int gfs2_meta_read(struct gfs2_glock *gl, u64 blkno, int flags,
 	if (unlikely(!buffer_uptodate(bh))) {
 		struct gfs2_trans *tr = current->journal_info;
 		if (tr && test_bit(TR_TOUCHED, &tr->tr_flags))
-			gfs2_io_error_bh_wd(sdp, bh);
+			gfs2_io_error_bh(sdp, bh);
 		brelse(bh);
 		*bhp = NULL;
 		return -EIO;
@@ -331,7 +331,7 @@ int gfs2_meta_wait(struct gfs2_sbd *sdp, struct buffer_head *bh)
 	if (!buffer_uptodate(bh)) {
 		struct gfs2_trans *tr = current->journal_info;
 		if (tr && test_bit(TR_TOUCHED, &tr->tr_flags))
-			gfs2_io_error_bh_wd(sdp, bh);
+			gfs2_io_error_bh(sdp, bh);
 		return -EIO;
 	}
 	if (gfs2_withdrawn(sdp) &&
diff --git a/fs/gfs2/util.c b/fs/gfs2/util.c
index 4c3b44eafc9f..d0c1345421fc 100644
--- a/fs/gfs2/util.c
+++ b/fs/gfs2/util.c
@@ -516,13 +516,11 @@ void gfs2_io_error_i(struct gfs2_sbd *sdp, const char *function, char *file,
 }
 
 /*
- * gfs2_io_error_bh_i - Flag a buffer I/O error
- * @withdraw: withdraw the filesystem
+ * gfs2_io_error_bh_i - Flag a buffer I/O error and withdraw
  */
 
 void gfs2_io_error_bh_i(struct gfs2_sbd *sdp, struct buffer_head *bh,
-			const char *function, char *file, unsigned int line,
-			bool withdraw)
+			const char *function, char *file, unsigned int line)
 {
 	if (gfs2_withdrawn(sdp))
 		return;
@@ -531,7 +529,5 @@ void gfs2_io_error_bh_i(struct gfs2_sbd *sdp, struct buffer_head *bh,
 	       "block = %llu, "
 	       "function = %s, file = %s, line = %u\n",
 	       (unsigned long long)bh->b_blocknr, function, file, line);
-	if (withdraw)
-		gfs2_withdraw(sdp);
+	gfs2_withdraw(sdp);
 }
-
diff --git a/fs/gfs2/util.h b/fs/gfs2/util.h
index 832c6c6eef41..d30e6a8ba8af 100644
--- a/fs/gfs2/util.h
+++ b/fs/gfs2/util.h
@@ -151,14 +151,10 @@ gfs2_io_error_i((sdp), __func__, __FILE__, __LINE__)
 
 
 void gfs2_io_error_bh_i(struct gfs2_sbd *sdp, struct buffer_head *bh,
-			const char *function, char *file, unsigned int line,
-			bool withdraw);
-
-#define gfs2_io_error_bh_wd(sdp, bh) \
-gfs2_io_error_bh_i((sdp), (bh), __func__, __FILE__, __LINE__, true)
+			const char *function, char *file, unsigned int line);
 
 #define gfs2_io_error_bh(sdp, bh) \
-gfs2_io_error_bh_i((sdp), (bh), __func__, __FILE__, __LINE__, false)
+gfs2_io_error_bh_i((sdp), (bh), __func__, __FILE__, __LINE__)
 
 
 extern struct kmem_cache *gfs2_glock_cachep;
-- 
2.51.0

