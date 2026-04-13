Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6683CCFB5
	for <gfs2@lists.linux.dev>; Mon, 13 Apr 2026 14:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776091959; cv=none; b=iHJ66yLSm4+MsZ+hENujMItyTGkk/m+8Hqk+hjBHUtfK8bUOhpNnb0lNBrBhRMbNQAYZkW7gKAol53SVmP8EEGg+5s/0euA/C56+671bXLlj2STNnA3OAvSyI2Wbtb8xxxooYvc3cZv5nLA9GG/MfZmUCMLF8y7TeS4Fk23Onnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776091959; c=relaxed/simple;
	bh=tKrMtYDkXOCBOMwM9C2EpS6+J3h7gGpgWO25a6yPzXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=oQSzYzGMjHcrKRLieeY8WWmA97Sp2e78/A9Dfi/zL2kwSWt/0I8I7opZeb7HDPVlfzwYfPWpYD2mxiGOPbhfDBNxe1nmMX62qWfY8g445dhmfSLZLChFXZ7lN86evPDtlzIynYbEX1p5dUJgUOlsDHU0GDF1/KD3zql6sLKey7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gF5xKxVW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gF5xKxVW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776091957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O4rhi9G1+MZsHjsM6k56eDd1kz6XDz68R9b0w7jECww=;
	b=gF5xKxVWgsOZDdtoLj4+TXueHDCtqVqdhCMRiylG02FxsuvAjOGfLlr+EXrw6pc7srxMSG
	4RWNYsgc/r/OoTJNxd5HxVomtKOPfZBbGKCiwDv0thrxIP2LJSOPK9ci/iABIjtooN8p1a
	RUWbuU4mUJP15oLswvYKB0rkHyioEyQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-456-FOTb548fP2WJxlL3d3QqrA-1; Mon,
 13 Apr 2026 10:52:36 -0400
X-MC-Unique: FOTb548fP2WJxlL3d3QqrA-1
X-Mimecast-MFC-AGG-ID: FOTb548fP2WJxlL3d3QqrA_1776091955
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2B8EB1955F29
	for <gfs2@lists.linux.dev>; Mon, 13 Apr 2026 14:52:35 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.44.32.156])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 219EB19560AB;
	Mon, 13 Apr 2026 14:52:33 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 14/18] gfs2: gfs2_log_flush withdraw fixes
Date: Mon, 13 Apr 2026 16:52:07 +0200
Message-ID: <20260413145211.881752-15-agruenba@redhat.com>
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
X-Mimecast-MFC-PROC-ID: N-xihrSskU-iwm4eqXBK_sYj8gO3asHlbO_IYfQ_oKQ_1776091955
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

When a withdraw occurs in gfs2_log_flush() and we are left with an unsubmitted
bio, fail that bio.  Otherwise, the bh's in that bio will remain locked and
gfs2_evict_inode() -> truncate_inode_pages() -> gfs2_invalidate_folio() ->
gfs2_discard() will hang trying to discard the locked bh's.

In addition, when gfs2_log_flush() fails to submit a new transaction, unpin the
buffers in the failing transaction like gfs2_remove_from_journal() does.  If
any of the bd's are on the ail2 list, leave them there and do_withdraw() ->
gfs2_withdraw_glocks() -> inode_go_inval() -> truncate_inode_pages() ->
gfs2_invalidate_folio() -> gfs2_discard() will remove them.  They will be freed
in gfs2_release_folio().

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/log.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/fs/gfs2/log.c b/fs/gfs2/log.c
index a96f9b9331e8..3a01d4e7667a 100644
--- a/fs/gfs2/log.c
+++ b/fs/gfs2/log.c
@@ -983,33 +983,38 @@ static void empty_ail1_list(struct gfs2_sbd *sdp)
 	}
 }
 
-static void gfs2_trans_drain_list(struct list_head *list)
+static void gfs2_trans_drain_list(struct gfs2_sbd *sdp, struct list_head *list)
 {
 	struct gfs2_bufdata *bd;
 
 	while (!list_empty(list)) {
 		bd = list_first_entry(list, struct gfs2_bufdata, bd_list);
+		struct buffer_head *bh = bd->bd_bh;
+
+		WARN_ON_ONCE(!buffer_pinned(bh));
+		clear_buffer_pinned(bh);
+		trace_gfs2_pin(bd, 0);
+		atomic_dec(&sdp->sd_log_pinned);
 		list_del_init(&bd->bd_list);
-		if (!list_empty(&bd->bd_ail_st_list))
-			gfs2_remove_from_ail(bd);
-		kmem_cache_free(gfs2_bufdata_cachep, bd);
+		brelse(bh);
 	}
 }
 
 /**
  * gfs2_trans_drain - drain the buf and databuf queue for a failed transaction
+ * @sdp: the filesystem
  * @tr: the transaction to drain
  *
  * When this is called, we're taking an error exit for a log write that failed
  * but since we bypassed the after_commit functions, we need to remove the
  * items from the buf and databuf queue.
  */
-static void gfs2_trans_drain(struct gfs2_trans *tr)
+static void gfs2_trans_drain(struct gfs2_sbd *sdp, struct gfs2_trans *tr)
 {
 	if (!tr)
 		return;
-	gfs2_trans_drain_list(&tr->tr_buf);
-	gfs2_trans_drain_list(&tr->tr_databuf);
+	gfs2_trans_drain_list(sdp, &tr->tr_buf);
+	gfs2_trans_drain_list(sdp, &tr->tr_databuf);
 }
 
 void gfs2_remove_from_journal(struct buffer_head *bh, int meta)
@@ -1185,7 +1190,11 @@ static void __gfs2_log_flush(struct gfs2_sbd *sdp, struct gfs2_glock *gl,
 	return;
 
 out_withdraw:
-	gfs2_trans_drain(tr);
+	if (sdp->sd_jdesc->jd_log_bio) {
+		bio_io_error(sdp->sd_jdesc->jd_log_bio);
+		sdp->sd_jdesc->jd_log_bio = NULL;
+	}
+	gfs2_trans_drain(sdp, tr);
 	/**
 	 * If the tr_list is empty, we're withdrawing during a log
 	 * flush that targets a transaction, but the transaction was
-- 
2.53.0

