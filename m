Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E770C3E0249
	for <gfs2@lists.linux.dev>; Mon, 13 Apr 2026 14:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776091958; cv=none; b=ILGe92HUwxsw1u5SUyu978iopAHIliaI72CfqmGIfDbgbP+V4CcNcJoh5uHoIocKbf7GVO1nIeVYaBU82V6Zmlub94q2ib6JywwYOwmm/iywO0/Aj5vsd+SOl8u1fqfAAO1e17hX44LTX7tYCEimIIcd2jBdMvMHBwk6pMiwSok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776091958; c=relaxed/simple;
	bh=lX6f1msYi71LOcAxZEPo+piH+vMFbES6mXnjHRQUMFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=HXyUm5Q8cbxDLyvcBgPv0MW5Dgms9pmNQ+0yN92glPCJngLAN2cJaDpsAgwUivlmNrS9PI7XWvUQi69HscFttHF1C/RJBhrOXZkASa4K1MhiFOEvGcfUIcUFkvBh79uwKI2cbvNrsxKqsdsmWfYQP20gkssxkGlHH1nOTOfJ8jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E1AwpJeE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E1AwpJeE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776091956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/m749zS8fULm0m7CSTIk6fChOS0S311fGmbUP4JIUQg=;
	b=E1AwpJeE7UILGUBarz6xHkTjf1t/oxNpLVOonHb9e6t60DctE5n/dML/uz4cp2ok32v4Nd
	V9sE9krEmGmODyPWKglVmxJmIi0Dm1JTVTVM396F+c2uiSpV8vf2albQRCLeD0esEtrWys
	7lKVZ5KIINKiqohUYbcP6G30btv3HQw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-252-lI_FO2z2Ol-FW__TdQu4Rw-1; Mon,
 13 Apr 2026 10:52:33 -0400
X-MC-Unique: lI_FO2z2Ol-FW__TdQu4Rw-1
X-Mimecast-MFC-AGG-ID: lI_FO2z2Ol-FW__TdQu4Rw_1776091952
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4BB0B19560A7
	for <gfs2@lists.linux.dev>; Mon, 13 Apr 2026 14:52:32 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.44.32.156])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5820E19560B1;
	Mon, 13 Apr 2026 14:52:31 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 12/18] gfs2: fix address space truncation during withdraw
Date: Mon, 13 Apr 2026 16:52:05 +0200
Message-ID: <20260413145211.881752-13-agruenba@redhat.com>
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
X-Mimecast-MFC-PROC-ID: nTiWe0crY7y199VK2veXccr100lMTCYtTq_R5k5GiRQ_1776091952
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

When a withdrawn filesystem's inodes are being evicted, the address spaces of
those inodes still need to be truncated but we can no longer start new
transactions.  We still don't want gfs2_invalidate_folio() to race with
gfs2_log_flush(), so take a read lock on sdp->sd_log_flush_lock in that case.
(It may not be obvious, but gfs2_invalidate_folio() is a jdata-only address
space operation.)

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/log.c   | 17 +++++++++++------
 fs/gfs2/super.c | 41 ++++++++++++++++++++++++++++-------------
 2 files changed, 39 insertions(+), 19 deletions(-)

diff --git a/fs/gfs2/log.c b/fs/gfs2/log.c
index 8397d34527a4..31ee7a0e86a2 100644
--- a/fs/gfs2/log.c
+++ b/fs/gfs2/log.c
@@ -1024,17 +1024,22 @@ void gfs2_remove_from_journal(struct buffer_head *bh, int meta)
 		trace_gfs2_pin(bd, 0);
 		atomic_dec(&sdp->sd_log_pinned);
 		list_del_init(&bd->bd_list);
-		if (meta == REMOVE_META)
-			tr->tr_num_buf_rm++;
-		else
-			tr->tr_num_databuf_rm++;
-		set_bit(TR_TOUCHED, &tr->tr_flags);
+		if (tr) {
+			if (meta == REMOVE_META)
+				tr->tr_num_buf_rm++;
+			else
+				tr->tr_num_databuf_rm++;
+			set_bit(TR_TOUCHED, &tr->tr_flags);
+		}
 		was_pinned = 1;
 		brelse(bh);
 	}
 	if (bd) {
 		if (bd->bd_tr) {
-			gfs2_trans_add_revoke(sdp, bd);
+			if (tr)
+				gfs2_trans_add_revoke(sdp, bd);
+			else
+				 gfs2_remove_from_ail(bd);
 		} else if (was_pinned) {
 			bh->b_private = NULL;
 			kmem_cache_free(gfs2_bufdata_cachep, bd);
diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index e4219a04d16e..83b5bab56377 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -1339,27 +1339,44 @@ static int gfs2_truncate_inode_pages(struct inode *inode)
 	struct gfs2_sbd *sdp = GFS2_SB(inode);
 	struct address_space *mapping = &inode->i_data;
 	bool need_trans = gfs2_is_jdata(ip) && mapping->nrpages;
-	int ret;
+	int ret = 0;
 
 	/*
 	 * Truncating a jdata inode address space may create revokes in
 	 * truncate_inode_pages() -> gfs2_invalidate_folio() -> ... ->
 	 * gfs2_remove_from_journal(), so we need a transaction here.
 	 *
-	 * FIXME: During a withdraw, no new transactions can be created.
-	 * In that case, we skip the truncate, but that doesn't help because
-	 * truncate_inode_pages_final() will then call gfs2_invalidate_folio()
-	 * again, and outside of a transaction.
+	 * During a withdraw, no new transactions can be created.  We still
+	 * take the log flush lock to prevent truncate from racing with
+	 * gfs2_log_flush().
 	 */
 	if (need_trans) {
 		ret = gfs2_trans_begin(sdp, 0, sdp->sd_jdesc->jd_blocks);
 		if (ret)
-			return ret;
+			down_read(&sdp->sd_log_flush_lock);
 	}
 	truncate_inode_pages(mapping, 0);
-	if (need_trans)
-		gfs2_trans_end(sdp);
-	return 0;
+	if (need_trans) {
+		if (ret)
+			up_read(&sdp->sd_log_flush_lock);
+		else
+			gfs2_trans_end(sdp);
+	}
+	return ret;
+}
+
+static void gfs2_truncate_inode_pages_final(struct inode *inode)
+{
+	struct gfs2_inode *ip = GFS2_I(inode);
+	struct gfs2_sbd *sdp = GFS2_SB(inode);
+	struct address_space *mapping = &inode->i_data;
+	bool need_lock = gfs2_is_jdata(ip) && mapping->nrpages;
+
+	if (need_lock)
+		down_read(&sdp->sd_log_flush_lock);
+	truncate_inode_pages_final(mapping);
+	if (need_lock)
+		up_read(&sdp->sd_log_flush_lock);
 }
 
 /*
@@ -1398,10 +1415,8 @@ static int evict_linked_inode(struct inode *inode, struct gfs2_holder *gh)
 
 clean:
 	ret = gfs2_truncate_inode_pages(inode);
-	if (ret)
-		return ret;
 	truncate_inode_pages(metamapping, 0);
-	return 0;
+	return ret;
 }
 
 /**
@@ -1472,7 +1487,7 @@ static void gfs2_evict_inode(struct inode *inode)
 out:
 	if (gfs2_holder_initialized(&gh))
 		gfs2_glock_dq_uninit(&gh);
-	truncate_inode_pages_final(&inode->i_data);
+	gfs2_truncate_inode_pages_final(inode);
 	if (ip->i_qadata)
 		gfs2_assert_warn(sdp, ip->i_qadata->qa_ref == 0);
 	gfs2_rs_deltree(&ip->i_res);
-- 
2.53.0

