Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91D23C0621
	for <gfs2@lists.linux.dev>; Mon, 13 Apr 2026 14:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776091954; cv=none; b=D1GWBuH43xTskSdM82csnHlFB5PL3VfwT5Xm1XuKr+joWSbzaJrNQ0T9Vpg0bXfd8M942iwQHQNpEX/ym/FwrKuO8CefxgmAuJW42EPi+IWTdNZIWIGw6DItJOkYZsxque6nQCrqOQueT/YDb6N7fIcY+jaV2SgjaUv+mC2nxSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776091954; c=relaxed/simple;
	bh=oml9tm3S8+HUgtsDYpidh/DxjgflszRSNh8saSzbZds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=XFbkhx/nSaOJ5NjZOgTirTKfzM+ebYNs68FgO3Ip/ur1GPPHmqx967fteTld9ln6a0jJujOlk6RyK79X/XseRi2otu//9rXuJf0qnA/0i6D2dH0pOHpoKpcUJmz4VL3IL+thBONS2pM2CXD3HlOI9FT72iDorw7L/q3gH7Ddzos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jAxnTjJD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jAxnTjJD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776091951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ofsev5laZaHpAQwvybfc5Pukld/MyBphyDOSAvfJoew=;
	b=jAxnTjJDeovBMBfnT+uRaxhLvTjQaHToz8fYYhScfSKY5MHR7qMIFz5A/ZfuRLlc547mOM
	cLQqFDiXp2vIWtYlCCP7riOCr+umurDCXTkw3dtH3seusd+3lnNBb4PKR0mFtdytSUVCnt
	hlqA/79m0sy8iZkssxCNckAy7fAYJlM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-hhA549oHO02UuReoea1mzQ-1; Mon,
 13 Apr 2026 10:52:27 -0400
X-MC-Unique: hhA549oHO02UuReoea1mzQ-1
X-Mimecast-MFC-AGG-ID: hhA549oHO02UuReoea1mzQ_1776091946
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 812C61956062
	for <gfs2@lists.linux.dev>; Mon, 13 Apr 2026 14:52:26 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.44.32.156])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8D1BD19560AB;
	Mon, 13 Apr 2026 14:52:25 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 08/18] gfs2: Move gfs2_remove_from_journal to log.c
Date: Mon, 13 Apr 2026 16:52:01 +0200
Message-ID: <20260413145211.881752-9-agruenba@redhat.com>
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
X-Mimecast-MFC-PROC-ID: dU_Z7qZ1pYUq1XRDxbZMJhLQwbVLfhJ2y-4NMwDbabE_1776091946
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Move gfs2_remove_from_journal() from meta_io.c to log.c and fix a minor
indentation glitch.

With that, gfs2_remove_from_ail() is now only used inside log.c, so it
can be made static.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/log.c     | 37 ++++++++++++++++++++++++++++++++++++-
 fs/gfs2/log.h     |  2 +-
 fs/gfs2/meta_io.c | 35 -----------------------------------
 fs/gfs2/meta_io.h |  1 -
 4 files changed, 37 insertions(+), 38 deletions(-)

diff --git a/fs/gfs2/log.c b/fs/gfs2/log.c
index 8a832eba1612..dde65f7d7437 100644
--- a/fs/gfs2/log.c
+++ b/fs/gfs2/log.c
@@ -72,7 +72,7 @@ unsigned int gfs2_struct2blk(struct gfs2_sbd *sdp, unsigned int nstruct)
  *
  */
 
-void gfs2_remove_from_ail(struct gfs2_bufdata *bd)
+static void gfs2_remove_from_ail(struct gfs2_bufdata *bd)
 {
 	bd->bd_tr = NULL;
 	list_del_init(&bd->bd_ail_st_list);
@@ -1017,6 +1017,41 @@ static void trans_drain(struct gfs2_trans *tr)
 	}
 }
 
+void gfs2_remove_from_journal(struct buffer_head *bh, int meta)
+{
+	struct address_space *mapping = bh->b_folio->mapping;
+	struct gfs2_sbd *sdp = gfs2_mapping2sbd(mapping);
+	struct gfs2_bufdata *bd = bh->b_private;
+	struct gfs2_trans *tr = current->journal_info;
+	int was_pinned = 0;
+
+	if (test_clear_buffer_pinned(bh)) {
+		trace_gfs2_pin(bd, 0);
+		atomic_dec(&sdp->sd_log_pinned);
+		list_del_init(&bd->bd_list);
+		if (meta == REMOVE_META)
+			tr->tr_num_buf_rm++;
+		else
+			tr->tr_num_databuf_rm++;
+		set_bit(TR_TOUCHED, &tr->tr_flags);
+		was_pinned = 1;
+		brelse(bh);
+	}
+	if (bd) {
+		if (bd->bd_tr) {
+			gfs2_trans_add_revoke(sdp, bd);
+		} else if (was_pinned) {
+			bh->b_private = NULL;
+			kmem_cache_free(gfs2_bufdata_cachep, bd);
+		} else if (!list_empty(&bd->bd_ail_st_list) &&
+			   !list_empty(&bd->bd_ail_gl_list)) {
+			gfs2_remove_from_ail(bd);
+		}
+	}
+	clear_buffer_dirty(bh);
+	clear_buffer_uptodate(bh);
+}
+
 /**
  * gfs2_log_flush - flush incore transaction(s)
  * @sdp: The filesystem
diff --git a/fs/gfs2/log.h b/fs/gfs2/log.h
index ca2cfadd7cce..10beda62427c 100644
--- a/fs/gfs2/log.h
+++ b/fs/gfs2/log.h
@@ -37,7 +37,6 @@ static inline void gfs2_ordered_add_inode(struct gfs2_inode *ip)
 
 void gfs2_ordered_del_inode(struct gfs2_inode *ip);
 unsigned int gfs2_struct2blk(struct gfs2_sbd *sdp, unsigned int nstruct);
-void gfs2_remove_from_ail(struct gfs2_bufdata *bd);
 bool gfs2_log_is_empty(struct gfs2_sbd *sdp);
 void gfs2_log_release_revokes(struct gfs2_sbd *sdp, unsigned int revokes);
 void gfs2_log_release(struct gfs2_sbd *sdp, unsigned int blks);
@@ -48,6 +47,7 @@ void gfs2_log_reserve(struct gfs2_sbd *sdp, struct gfs2_trans *tr,
 void gfs2_write_log_header(struct gfs2_sbd *sdp, struct gfs2_jdesc *jd,
 			   u64 seq, u32 tail, u32 lblock, u32 flags,
 			   blk_opf_t op_flags);
+void gfs2_remove_from_journal(struct buffer_head *bh, int meta);
 void gfs2_log_flush(struct gfs2_sbd *sdp, struct gfs2_glock *gl,
 		    u32 type);
 void gfs2_log_commit(struct gfs2_sbd *sdp, struct gfs2_trans *trans);
diff --git a/fs/gfs2/meta_io.c b/fs/gfs2/meta_io.c
index 814c86986b96..d407dd476e72 100644
--- a/fs/gfs2/meta_io.c
+++ b/fs/gfs2/meta_io.c
@@ -338,41 +338,6 @@ int gfs2_meta_wait(struct gfs2_sbd *sdp, struct buffer_head *bh)
 	return 0;
 }
 
-void gfs2_remove_from_journal(struct buffer_head *bh, int meta)
-{
-	struct address_space *mapping = bh->b_folio->mapping;
-	struct gfs2_sbd *sdp = gfs2_mapping2sbd(mapping);
-	struct gfs2_bufdata *bd = bh->b_private;
-	struct gfs2_trans *tr = current->journal_info;
-	int was_pinned = 0;
-
-	if (test_clear_buffer_pinned(bh)) {
-		trace_gfs2_pin(bd, 0);
-		atomic_dec(&sdp->sd_log_pinned);
-		list_del_init(&bd->bd_list);
-		if (meta == REMOVE_META)
-			tr->tr_num_buf_rm++;
-		else
-			tr->tr_num_databuf_rm++;
-		set_bit(TR_TOUCHED, &tr->tr_flags);
-		was_pinned = 1;
-		brelse(bh);
-	}
-	if (bd) {
-		if (bd->bd_tr) {
-			gfs2_trans_add_revoke(sdp, bd);
-		} else if (was_pinned) {
-			bh->b_private = NULL;
-			kmem_cache_free(gfs2_bufdata_cachep, bd);
-		} else if (!list_empty(&bd->bd_ail_st_list) &&
-					!list_empty(&bd->bd_ail_gl_list)) {
-			gfs2_remove_from_ail(bd);
-		}
-	}
-	clear_buffer_dirty(bh);
-	clear_buffer_uptodate(bh);
-}
-
 /**
  * gfs2_ail1_wipe - remove deleted/freed buffers from the ail1 list
  * @sdp: superblock
diff --git a/fs/gfs2/meta_io.h b/fs/gfs2/meta_io.h
index 2fe5dec193ed..ec76215bfb1a 100644
--- a/fs/gfs2/meta_io.h
+++ b/fs/gfs2/meta_io.h
@@ -59,7 +59,6 @@ enum {
 	REMOVE_META = 1,
 };
 
-void gfs2_remove_from_journal(struct buffer_head *bh, int meta);
 void gfs2_journal_wipe(struct gfs2_inode *ip, u64 bstart, u32 blen);
 int gfs2_meta_buffer(struct gfs2_inode *ip, u32 mtype, u64 num,
 		     struct buffer_head **bhp);
-- 
2.53.0

