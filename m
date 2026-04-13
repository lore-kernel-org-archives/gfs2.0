Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DFD3C0621
	for <gfs2@lists.linux.dev>; Mon, 13 Apr 2026 14:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776091949; cv=none; b=YrrJQekmsjDMRMiwX/RQ2gmdl1ZHFDgYPqG8Q56DjqZzvkD9wgECq7KxXdGVLFCUhGsHNBjpDg0DyXHt5i80ibFtZUwFG8NGfYI1C2IzFmRvJpuROBzkPI2fWfBn+81Vn9fmiAzdgYspLwjd98qeFlo4ohrB1b6EiHu3dp+Bzlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776091949; c=relaxed/simple;
	bh=mIF/d5m2mOki7bdHPOLee3evly5xn3vOIlGElTFuWq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=DHB+zGNd3FuY+gKEj6g+RFzMhmeQyhLH/GlEciUfojTSFHiJsXJ+9nMfdk7rCeyVvnywdFiDk3d828jt0F3onZOQvlJzXbfoeHaPe2KiRBb57bS9Fo3wuSI4TK5ZNgdllA0xxfRMxgtuM/15zcXVhtKPZWVOhGeEhIVeYXBW0R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MXPSLY7I; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MXPSLY7I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776091947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ALRlAggxNX1KFF5AmxyabFaeKLMK7ClCWEzrw+YXZvg=;
	b=MXPSLY7IPD4k6FpM/E02McTjz/qCcirMiEJXZFa8f+fPqiHwMdOgnLGCDFwkoc9L7a8NQu
	2A2X3r8PhPnDrxLUFlQoY7FBhYOim+P8C2MKE5q0b3FSEMDCBGnTUkTo5T5npb/icZAfb1
	HfXq02OoJPrwntlKmVaWF9uFBd7UlWw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-410-mYQHme-jPqKWOKattzqTqQ-1; Mon,
 13 Apr 2026 10:52:25 -0400
X-MC-Unique: mYQHme-jPqKWOKattzqTqQ-1
X-Mimecast-MFC-AGG-ID: mYQHme-jPqKWOKattzqTqQ_1776091945
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2167818001DA
	for <gfs2@lists.linux.dev>; Mon, 13 Apr 2026 14:52:25 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.44.32.156])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2DE7519560B1;
	Mon, 13 Apr 2026 14:52:23 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 07/18] gfs2: Get rid of gfs2_log_[un]lock helpers
Date: Mon, 13 Apr 2026 16:52:00 +0200
Message-ID: <20260413145211.881752-8-agruenba@redhat.com>
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
X-Mimecast-MFC-PROC-ID: VlHFITicavh1i2IugvHIMH01aMJ9wCvXWQBDMYkrOtk_1776091945
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

These two helpers only hide the locking operation; they do not make
the code more readable.

Created with:

sed -i -e 's:gfs2_log_unlock(sdp):spin_unlock(\&sdp->sd_log_lock):' \
       -e 's:gfs2_log_lock(sdp):spin_lock(\&sdp->sd_log_lock):'

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/aops.c    | 10 +++++-----
 fs/gfs2/glops.c   |  8 ++++----
 fs/gfs2/log.c     | 12 ++++++------
 fs/gfs2/log.h     | 24 ------------------------
 fs/gfs2/lops.c    | 16 ++++++++--------
 fs/gfs2/meta_io.c |  8 ++++----
 fs/gfs2/trans.c   | 20 ++++++++++----------
 7 files changed, 37 insertions(+), 61 deletions(-)

diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index 6a6ded7a61d2..403b5e1fada4 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -583,7 +583,7 @@ static void gfs2_discard(struct gfs2_sbd *sdp, struct buffer_head *bh)
 	struct gfs2_bufdata *bd;
 
 	lock_buffer(bh);
-	gfs2_log_lock(sdp);
+	spin_lock(&sdp->sd_log_lock);
 	clear_buffer_dirty(bh);
 	bd = bh->b_private;
 	if (bd) {
@@ -599,7 +599,7 @@ static void gfs2_discard(struct gfs2_sbd *sdp, struct buffer_head *bh)
 	clear_buffer_mapped(bh);
 	clear_buffer_req(bh);
 	clear_buffer_new(bh);
-	gfs2_log_unlock(sdp);
+	spin_unlock(&sdp->sd_log_lock);
 	unlock_buffer(bh);
 }
 
@@ -667,7 +667,7 @@ bool gfs2_release_folio(struct folio *folio, gfp_t gfp_mask)
 	 * again.
 	 */
 
-	gfs2_log_lock(sdp);
+	spin_lock(&sdp->sd_log_lock);
 	bh = head;
 	do {
 		if (atomic_read(&bh->b_count))
@@ -699,12 +699,12 @@ bool gfs2_release_folio(struct folio *folio, gfp_t gfp_mask)
 
 		bh = bh->b_this_page;
 	} while (bh != head);
-	gfs2_log_unlock(sdp);
+	spin_unlock(&sdp->sd_log_lock);
 
 	return try_to_free_buffers(folio);
 
 cannot_release:
-	gfs2_log_unlock(sdp);
+	spin_unlock(&sdp->sd_log_lock);
 	return false;
 }
 
diff --git a/fs/gfs2/glops.c b/fs/gfs2/glops.c
index ba61649368bf..aff7e890bf60 100644
--- a/fs/gfs2/glops.c
+++ b/fs/gfs2/glops.c
@@ -64,7 +64,7 @@ static void __gfs2_ail_flush(struct gfs2_glock *gl, bool fsync,
 	struct buffer_head *bh;
 	const unsigned long b_state = (1UL << BH_Dirty)|(1UL << BH_Pinned)|(1UL << BH_Lock);
 
-	gfs2_log_lock(sdp);
+	spin_lock(&sdp->sd_log_lock);
 	spin_lock(&sdp->sd_ail_lock);
 	list_for_each_entry_safe_reverse(bd, tmp, head, bd_ail_gl_list) {
 		if (nr_revokes == 0)
@@ -80,7 +80,7 @@ static void __gfs2_ail_flush(struct gfs2_glock *gl, bool fsync,
 	}
 	GLOCK_BUG_ON(gl, !fsync && atomic_read(&gl->gl_ail_count));
 	spin_unlock(&sdp->sd_ail_lock);
-	gfs2_log_unlock(sdp);
+	spin_unlock(&sdp->sd_log_lock);
 }
 
 
@@ -109,10 +109,10 @@ static int gfs2_ail_empty_gl(struct gfs2_glock *gl)
 		 * If none of these conditions are true, our revokes are all
 		 * flushed and we can return.
 		 */
-		gfs2_log_lock(sdp);
+		spin_lock(&sdp->sd_log_lock);
 		have_revokes = !list_empty(&sdp->sd_log_revokes);
 		log_in_flight = atomic_read(&sdp->sd_log_in_flight);
-		gfs2_log_unlock(sdp);
+		spin_unlock(&sdp->sd_log_lock);
 		if (have_revokes)
 			goto flush;
 		if (log_in_flight)
diff --git a/fs/gfs2/log.c b/fs/gfs2/log.c
index 347df29d610e..8a832eba1612 100644
--- a/fs/gfs2/log.c
+++ b/fs/gfs2/log.c
@@ -800,9 +800,9 @@ void gfs2_flush_revokes(struct gfs2_sbd *sdp)
 	/* number of revokes we still have room for */
 	unsigned int max_revokes = atomic_read(&sdp->sd_log_revokes_available);
 
-	gfs2_log_lock(sdp);
+	spin_lock(&sdp->sd_log_lock);
 	gfs2_ail1_empty(sdp, max_revokes);
-	gfs2_log_unlock(sdp);
+	spin_unlock(&sdp->sd_log_lock);
 }
 
 /**
@@ -1110,7 +1110,7 @@ void gfs2_log_flush(struct gfs2_sbd *sdp, struct gfs2_glock *gl, u32 flags)
 		goto out_withdraw;
 	lops_after_commit(sdp, tr);
 
-	gfs2_log_lock(sdp);
+	spin_lock(&sdp->sd_log_lock);
 	sdp->sd_log_blks_reserved = 0;
 
 	spin_lock(&sdp->sd_ail_lock);
@@ -1119,7 +1119,7 @@ void gfs2_log_flush(struct gfs2_sbd *sdp, struct gfs2_glock *gl, u32 flags)
 		tr = NULL;
 	}
 	spin_unlock(&sdp->sd_ail_lock);
-	gfs2_log_unlock(sdp);
+	spin_unlock(&sdp->sd_log_lock);
 
 	if (!(flags & GFS2_LOG_HEAD_FLUSH_NORMAL)) {
 		if (!sdp->sd_log_idle) {
@@ -1200,7 +1200,7 @@ static void log_refund(struct gfs2_sbd *sdp, struct gfs2_trans *tr)
 	unsigned int unused;
 	unsigned int maxres;
 
-	gfs2_log_lock(sdp);
+	spin_lock(&sdp->sd_log_lock);
 
 	if (sdp->sd_log_tr) {
 		gfs2_merge_trans(sdp, tr);
@@ -1218,7 +1218,7 @@ static void log_refund(struct gfs2_sbd *sdp, struct gfs2_trans *tr)
 		gfs2_log_release(sdp, unused);
 	sdp->sd_log_blks_reserved = reserved;
 
-	gfs2_log_unlock(sdp);
+	spin_unlock(&sdp->sd_log_lock);
 }
 
 static inline int gfs2_jrnl_flush_reqd(struct gfs2_sbd *sdp)
diff --git a/fs/gfs2/log.h b/fs/gfs2/log.h
index fc30ebdad83a..ca2cfadd7cce 100644
--- a/fs/gfs2/log.h
+++ b/fs/gfs2/log.h
@@ -20,30 +20,6 @@
  */
 #define GFS2_LOG_FLUSH_MIN_BLOCKS 4
 
-/**
- * gfs2_log_lock - acquire the right to mess with the log manager
- * @sdp: the filesystem
- *
- */
-
-static inline void gfs2_log_lock(struct gfs2_sbd *sdp)
-__acquires(&sdp->sd_log_lock)
-{
-	spin_lock(&sdp->sd_log_lock);
-}
-
-/**
- * gfs2_log_unlock - release the right to mess with the log manager
- * @sdp: the filesystem
- *
- */
-
-static inline void gfs2_log_unlock(struct gfs2_sbd *sdp)
-__releases(&sdp->sd_log_lock)
-{
-	spin_unlock(&sdp->sd_log_lock);
-}
-
 static inline void gfs2_ordered_add_inode(struct gfs2_inode *ip)
 {
 	struct gfs2_sbd *sdp = GFS2_SB(&ip->i_inode);
diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
index e03928def87e..6dabe73ad790 100644
--- a/fs/gfs2/lops.c
+++ b/fs/gfs2/lops.c
@@ -648,19 +648,19 @@ static void gfs2_before_commit(struct gfs2_sbd *sdp, unsigned int limit,
 	unsigned n;
 	__be64 *ptr;
 
-	gfs2_log_lock(sdp);
+	spin_lock(&sdp->sd_log_lock);
 	list_sort(NULL, blist, blocknr_cmp);
 	bd1 = bd2 = list_prepare_entry(bd1, blist, bd_list);
 	while(total) {
 		num = total;
 		if (total > limit)
 			num = limit;
-		gfs2_log_unlock(sdp);
+		spin_unlock(&sdp->sd_log_lock);
 		page = gfs2_get_log_desc(sdp,
 					 is_databuf ? GFS2_LOG_DESC_JDATA :
 					 GFS2_LOG_DESC_METADATA, num + 1, num);
 		ld = page_address(page);
-		gfs2_log_lock(sdp);
+		spin_lock(&sdp->sd_log_lock);
 		ptr = (__be64 *)(ld + 1);
 
 		n = 0;
@@ -674,14 +674,14 @@ static void gfs2_before_commit(struct gfs2_sbd *sdp, unsigned int limit,
 				break;
 		}
 
-		gfs2_log_unlock(sdp);
+		spin_unlock(&sdp->sd_log_lock);
 		gfs2_log_write_page(sdp, page);
-		gfs2_log_lock(sdp);
+		spin_lock(&sdp->sd_log_lock);
 
 		n = 0;
 		list_for_each_entry_continue(bd2, blist, bd_list) {
 			get_bh(bd2->bd_bh);
-			gfs2_log_unlock(sdp);
+			spin_unlock(&sdp->sd_log_lock);
 			lock_buffer(bd2->bd_bh);
 
 			if (buffer_escaped(bd2->bd_bh)) {
@@ -698,7 +698,7 @@ static void gfs2_before_commit(struct gfs2_sbd *sdp, unsigned int limit,
 			} else {
 				gfs2_log_write_bh(sdp, bd2->bd_bh);
 			}
-			gfs2_log_lock(sdp);
+			spin_lock(&sdp->sd_log_lock);
 			if (++n >= num)
 				break;
 		}
@@ -706,7 +706,7 @@ static void gfs2_before_commit(struct gfs2_sbd *sdp, unsigned int limit,
 		BUG_ON(total < num);
 		total -= num;
 	}
-	gfs2_log_unlock(sdp);
+	spin_unlock(&sdp->sd_log_lock);
 }
 
 static void buf_lo_before_commit(struct gfs2_sbd *sdp, struct gfs2_trans *tr)
diff --git a/fs/gfs2/meta_io.c b/fs/gfs2/meta_io.c
index 3c8e4553102d..814c86986b96 100644
--- a/fs/gfs2/meta_io.c
+++ b/fs/gfs2/meta_io.c
@@ -391,7 +391,7 @@ static void gfs2_ail1_wipe(struct gfs2_sbd *sdp, u64 bstart, u32 blen)
 	struct buffer_head *bh;
 	u64 end = bstart + blen;
 
-	gfs2_log_lock(sdp);
+	spin_lock(&sdp->sd_log_lock);
 	spin_lock(&sdp->sd_ail_lock);
 	list_for_each_entry_safe(tr, s, &sdp->sd_ail1_list, tr_list) {
 		list_for_each_entry_safe(bd, bs, &tr->tr_ail1_list,
@@ -404,7 +404,7 @@ static void gfs2_ail1_wipe(struct gfs2_sbd *sdp, u64 bstart, u32 blen)
 		}
 	}
 	spin_unlock(&sdp->sd_ail_lock);
-	gfs2_log_unlock(sdp);
+	spin_unlock(&sdp->sd_log_lock);
 }
 
 static struct buffer_head *gfs2_getjdatabuf(struct gfs2_inode *ip, u64 blkno)
@@ -456,11 +456,11 @@ void gfs2_journal_wipe(struct gfs2_inode *ip, u64 bstart, u32 blen)
 		}
 		if (bh) {
 			lock_buffer(bh);
-			gfs2_log_lock(sdp);
+			spin_lock(&sdp->sd_log_lock);
 			spin_lock(&sdp->sd_ail_lock);
 			gfs2_remove_from_journal(bh, ty);
 			spin_unlock(&sdp->sd_ail_lock);
-			gfs2_log_unlock(sdp);
+			spin_unlock(&sdp->sd_log_lock);
 			unlock_buffer(bh);
 			brelse(bh);
 		}
diff --git a/fs/gfs2/trans.c b/fs/gfs2/trans.c
index 95f2632cdb01..0ded2d63dbbb 100644
--- a/fs/gfs2/trans.c
+++ b/fs/gfs2/trans.c
@@ -205,17 +205,17 @@ void gfs2_trans_add_data(struct gfs2_glock *gl, struct buffer_head *bh)
 		set_bit(TR_TOUCHED, &tr->tr_flags);
 		goto out;
 	}
-	gfs2_log_lock(sdp);
+	spin_lock(&sdp->sd_log_lock);
 	bd = bh->b_private;
 	if (bd == NULL) {
-		gfs2_log_unlock(sdp);
+		spin_unlock(&sdp->sd_log_lock);
 		unlock_buffer(bh);
 		if (bh->b_private == NULL)
 			bd = gfs2_alloc_bufdata(gl, bh);
 		else
 			bd = bh->b_private;
 		lock_buffer(bh);
-		gfs2_log_lock(sdp);
+		spin_lock(&sdp->sd_log_lock);
 	}
 	gfs2_assert(sdp, bd->bd_gl == gl);
 	set_bit(TR_TOUCHED, &tr->tr_flags);
@@ -226,7 +226,7 @@ void gfs2_trans_add_data(struct gfs2_glock *gl, struct buffer_head *bh)
 		tr->tr_num_databuf_new++;
 		list_add_tail(&bd->bd_list, &tr->tr_databuf);
 	}
-	gfs2_log_unlock(sdp);
+	spin_unlock(&sdp->sd_log_lock);
 out:
 	unlock_buffer(bh);
 }
@@ -266,10 +266,10 @@ void gfs2_trans_add_meta(struct gfs2_glock *gl, struct buffer_head *bh)
 		set_bit(TR_TOUCHED, &tr->tr_flags);
 		goto out;
 	}
-	gfs2_log_lock(sdp);
+	spin_lock(&sdp->sd_log_lock);
 	bd = bh->b_private;
 	if (bd == NULL) {
-		gfs2_log_unlock(sdp);
+		spin_unlock(&sdp->sd_log_lock);
 		unlock_buffer(bh);
 		folio_lock(bh->b_folio);
 		if (bh->b_private == NULL)
@@ -278,7 +278,7 @@ void gfs2_trans_add_meta(struct gfs2_glock *gl, struct buffer_head *bh)
 			bd = bh->b_private;
 		folio_unlock(bh->b_folio);
 		lock_buffer(bh);
-		gfs2_log_lock(sdp);
+		spin_lock(&sdp->sd_log_lock);
 	}
 	gfs2_assert(sdp, bd->bd_gl == gl);
 	set_bit(TR_TOUCHED, &tr->tr_flags);
@@ -309,7 +309,7 @@ void gfs2_trans_add_meta(struct gfs2_glock *gl, struct buffer_head *bh)
 	list_add(&bd->bd_list, &tr->tr_buf);
 	tr->tr_num_buf_new++;
 out_unlock:
-	gfs2_log_unlock(sdp);
+	spin_unlock(&sdp->sd_log_lock);
 out:
 	unlock_buffer(bh);
 }
@@ -329,7 +329,7 @@ void gfs2_trans_remove_revoke(struct gfs2_sbd *sdp, u64 blkno, unsigned int len)
 	struct gfs2_bufdata *bd, *tmp;
 	unsigned int n = len;
 
-	gfs2_log_lock(sdp);
+	spin_lock(&sdp->sd_log_lock);
 	list_for_each_entry_safe(bd, tmp, &sdp->sd_log_revokes, bd_list) {
 		if ((bd->bd_blkno >= blkno) && (bd->bd_blkno < (blkno + len))) {
 			list_del_init(&bd->bd_list);
@@ -343,7 +343,7 @@ void gfs2_trans_remove_revoke(struct gfs2_sbd *sdp, u64 blkno, unsigned int len)
 				break;
 		}
 	}
-	gfs2_log_unlock(sdp);
+	spin_unlock(&sdp->sd_log_lock);
 }
 
 void gfs2_trans_free(struct gfs2_sbd *sdp, struct gfs2_trans *tr)
-- 
2.53.0

