Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92613C9EF1
	for <gfs2@lists.linux.dev>; Mon, 13 Apr 2026 14:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776091954; cv=none; b=pUlqEjBClHK34rh2V2J2y+fWB1sDHydhcSCcsrI4xPydl7nNCGXDBiCa171pj/Yak49GTbKBpIR80WKaPztAvHFGCaLv2trNt4LXDinjie9kgtWqAw+jGiguibXB/xXBFl0QsAIpNUg2stMI6/xmAVtu0F2R8Ok7J7ESmx+Bq8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776091954; c=relaxed/simple;
	bh=StZsnHxVfezxrwJSDJEQBV8J6JhUQ1wuGfhIjqvQ8UQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=tdES9oGegpDENIhchbDQ6O62hv8A3mXI65tPfutwdz1OHTeexEoIRiPES6MQRUfuga32XqYWel+fFKfE09TMxMLUbWxADde4GHpD6GkTTiG1Kd3amPfQf8e+VmBrxoT3zGonJN1i/vBs6UoR9+CKILRrccqHGA82O4MLuBnoJv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ajtIIApH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ajtIIApH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776091952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9D0kdc39BXIzz1AMra1JTtWNsqK6dCCvYU08e6P670I=;
	b=ajtIIApHLttHHTaawtpNi2TMtFLCL9kVTWIS5LCHEW5n6x/A7+Wu/upPrfoxctB+pzV4hg
	rKfrZyeNn9Bx4ZiVMpZ04kZRdNnPmszAfwP21mWuTFCuhafDhMvhM83J8eGklqSDEQoSBm
	BKmFq/B/2i12c9LXcf+Xt1TtWEdiems=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-641-BJpv6AoJN3Gph-kXOyGbtA-1; Mon,
 13 Apr 2026 10:52:28 -0400
X-MC-Unique: BJpv6AoJN3Gph-kXOyGbtA-1
X-Mimecast-MFC-AGG-ID: BJpv6AoJN3Gph-kXOyGbtA_1776091948
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0EE5A180123A
	for <gfs2@lists.linux.dev>; Mon, 13 Apr 2026 14:52:28 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.44.32.156])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EE9ED19560B1;
	Mon, 13 Apr 2026 14:52:26 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 09/18] gfs2: Remove trans_drain code duplication
Date: Mon, 13 Apr 2026 16:52:02 +0200
Message-ID: <20260413145211.881752-10-agruenba@redhat.com>
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
X-Mimecast-MFC-PROC-ID: jhWt3kNpyaDOGlCh6kIDLf-XdfFd38r02jjO_IeK3mU_1776091948
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Rename trans_drain() to gfs2_trans_drain().

Add a new gfs2_trans_drain_list() helper and use it in
gfs2_trans_drain() to reduce code duplication.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/log.c | 41 ++++++++++++++++++-----------------------
 1 file changed, 18 insertions(+), 23 deletions(-)

diff --git a/fs/gfs2/log.c b/fs/gfs2/log.c
index dde65f7d7437..8397d34527a4 100644
--- a/fs/gfs2/log.c
+++ b/fs/gfs2/log.c
@@ -983,38 +983,33 @@ static void empty_ail1_list(struct gfs2_sbd *sdp)
 	}
 }
 
+static void gfs2_trans_drain_list(struct list_head *list)
+{
+	struct gfs2_bufdata *bd;
+
+	while (!list_empty(list)) {
+		bd = list_first_entry(list, struct gfs2_bufdata, bd_list);
+		list_del_init(&bd->bd_list);
+		if (!list_empty(&bd->bd_ail_st_list))
+			gfs2_remove_from_ail(bd);
+		kmem_cache_free(gfs2_bufdata_cachep, bd);
+	}
+}
+
 /**
- * trans_drain - drain the buf and databuf queue for a failed transaction
+ * gfs2_trans_drain - drain the buf and databuf queue for a failed transaction
  * @tr: the transaction to drain
  *
  * When this is called, we're taking an error exit for a log write that failed
  * but since we bypassed the after_commit functions, we need to remove the
  * items from the buf and databuf queue.
  */
-static void trans_drain(struct gfs2_trans *tr)
+static void gfs2_trans_drain(struct gfs2_trans *tr)
 {
-	struct gfs2_bufdata *bd;
-	struct list_head *head;
-
 	if (!tr)
 		return;
-
-	head = &tr->tr_buf;
-	while (!list_empty(head)) {
-		bd = list_first_entry(head, struct gfs2_bufdata, bd_list);
-		list_del_init(&bd->bd_list);
-		if (!list_empty(&bd->bd_ail_st_list))
-			gfs2_remove_from_ail(bd);
-		kmem_cache_free(gfs2_bufdata_cachep, bd);
-	}
-	head = &tr->tr_databuf;
-	while (!list_empty(head)) {
-		bd = list_first_entry(head, struct gfs2_bufdata, bd_list);
-		list_del_init(&bd->bd_list);
-		if (!list_empty(&bd->bd_ail_st_list))
-			gfs2_remove_from_ail(bd);
-		kmem_cache_free(gfs2_bufdata_cachep, bd);
-	}
+	gfs2_trans_drain_list(&tr->tr_buf);
+	gfs2_trans_drain_list(&tr->tr_databuf);
 }
 
 void gfs2_remove_from_journal(struct buffer_head *bh, int meta)
@@ -1186,7 +1181,7 @@ void gfs2_log_flush(struct gfs2_sbd *sdp, struct gfs2_glock *gl, u32 flags)
 	return;
 
 out_withdraw:
-	trans_drain(tr);
+	gfs2_trans_drain(tr);
 	/**
 	 * If the tr_list is empty, we're withdrawing during a log
 	 * flush that targets a transaction, but the transaction was
-- 
2.53.0

