Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33482550BB
	for <gfs2@lists.linux.dev>; Fri, 16 May 2025 21:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747432119; cv=none; b=bU6wt6Ad8UQW8iSigdaYnjnb6Y7rEeragiWCC9CsaPXUQ7sw1c+jVDoVwBK7Siqh8vLkcE7IdVcvX+v9cNZlXkJCYAm647RM1JbizLigF5qesoU7bjz1lJZZ7QUAHggtq8sPuiOkLx1zYhb+/FP6Ww8+uyyTXrT5wnAH1HMug4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747432119; c=relaxed/simple;
	bh=zWG4JyLCPKadEwtojGKC+KS2W9arKbsyFun/mYDtDFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=lvTOPa/8+aquqGz6Zfkg9njq4GxJD7hv6e8AwKMgZ/8FydKUtVypAhMkbVrg0ypUlRqVUPunFcBCG7L65oOYgXIKN1wfteQq31M7NCEnCPluh+v+32RfbLX4Oorgcmyon50huFnBzv5T0UKbK0CdzAcW24YBFtzVslMZxLCLOZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TjO1XjxI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TjO1XjxI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747432117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1Qr3XzGDU6XmQkuRLKvdbUrxYclkjcd5/A2Pd/zQ278=;
	b=TjO1XjxIdbKu5ojPrp2HTFCzk+f8IijyF7pmBjM2B8Hqy9VY0TrjNf2aijj8ItoFMu19QV
	ijvVzQp0zaMVmpY3YQnyWRbmgXYmGJaXIANI/HdhNOmbJSjHV/g7JQMDAdidO39ZHkKAAw
	IFumoKi/8QTJTQDBEcIpgSU5G7DbGS8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-271-XbRNeu4vPOqNTRFafoU2mA-1; Fri,
 16 May 2025 17:48:33 -0400
X-MC-Unique: XbRNeu4vPOqNTRFafoU2mA-1
X-Mimecast-MFC-AGG-ID: XbRNeu4vPOqNTRFafoU2mA_1747432113
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E723319560AE;
	Fri, 16 May 2025 21:48:32 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.234])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9C706195608D;
	Fri, 16 May 2025 21:48:31 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 2/3] gfs2: Move gfs2_trans_add_databufs
Date: Fri, 16 May 2025 23:48:20 +0200
Message-ID: <20250516214822.905056-4-agruenba@redhat.com>
In-Reply-To: <20250516214822.905056-1-agruenba@redhat.com>
References: <20250516214822.905056-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wsQDn5VzM2sj_JI-Q8eh513bOuobPCSkokuVIefssMo_1747432113
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Move gfs2_trans_add_databufs() to trans.c.  Pass in a glock instead of
a gfs2_inode.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/aops.c  | 23 +----------------------
 fs/gfs2/aops.h  |  2 --
 fs/gfs2/bmap.c  |  3 ++-
 fs/gfs2/trans.c | 21 +++++++++++++++++++++
 fs/gfs2/trans.h |  2 ++
 5 files changed, 26 insertions(+), 25 deletions(-)

diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index 66b0ad9f1f92..1a3a420316fa 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -37,27 +37,6 @@
 #include "aops.h"
 
 
-void gfs2_trans_add_databufs(struct gfs2_inode *ip, struct folio *folio,
-			     size_t from, size_t len)
-{
-	struct buffer_head *head = folio_buffers(folio);
-	unsigned int bsize = head->b_size;
-	struct buffer_head *bh;
-	size_t to = from + len;
-	size_t start, end;
-
-	for (bh = head, start = 0; bh != head || !start;
-	     bh = bh->b_this_page, start = end) {
-		end = start + bsize;
-		if (end <= from)
-			continue;
-		if (start >= to)
-			break;
-		set_buffer_uptodate(bh);
-		gfs2_trans_add_data(ip->i_gl, bh);
-	}
-}
-
 /**
  * gfs2_get_block_noalloc - Fills in a buffer head with details about a block
  * @inode: The inode
@@ -133,7 +112,7 @@ static int __gfs2_jdata_write_folio(struct folio *folio,
 					inode->i_sb->s_blocksize,
 					BIT(BH_Dirty)|BIT(BH_Uptodate));
 		}
-		gfs2_trans_add_databufs(ip, folio, 0, folio_size(folio));
+		gfs2_trans_add_databufs(ip->i_gl, folio, 0, folio_size(folio));
 	}
 	return gfs2_write_jdata_folio(folio, wbc);
 }
diff --git a/fs/gfs2/aops.h b/fs/gfs2/aops.h
index a10c4334d248..f9fa41aaeaf4 100644
--- a/fs/gfs2/aops.h
+++ b/fs/gfs2/aops.h
@@ -9,7 +9,5 @@
 #include "incore.h"
 
 void adjust_fs_space(struct inode *inode);
-void gfs2_trans_add_databufs(struct gfs2_inode *ip, struct folio *folio,
-			     size_t from, size_t len);
 
 #endif /* __AOPS_DOT_H__ */
diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index 070905493f8f..7703d0471139 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -988,7 +988,8 @@ static void gfs2_iomap_put_folio(struct inode *inode, loff_t pos,
 	struct gfs2_sbd *sdp = GFS2_SB(inode);
 
 	if (!gfs2_is_stuffed(ip))
-		gfs2_trans_add_databufs(ip, folio, offset_in_folio(folio, pos),
+		gfs2_trans_add_databufs(ip->i_gl, folio,
+					offset_in_folio(folio, pos),
 					copied);
 
 	folio_unlock(folio);
diff --git a/fs/gfs2/trans.c b/fs/gfs2/trans.c
index f8ae2c666fd6..075f7e9abe47 100644
--- a/fs/gfs2/trans.c
+++ b/fs/gfs2/trans.c
@@ -226,6 +226,27 @@ void gfs2_trans_add_data(struct gfs2_glock *gl, struct buffer_head *bh)
 	unlock_buffer(bh);
 }
 
+void gfs2_trans_add_databufs(struct gfs2_glock *gl, struct folio *folio,
+			     size_t from, size_t len)
+{
+	struct buffer_head *head = folio_buffers(folio);
+	unsigned int bsize = head->b_size;
+	struct buffer_head *bh;
+	size_t to = from + len;
+	size_t start, end;
+
+	for (bh = head, start = 0; bh != head || !start;
+	     bh = bh->b_this_page, start = end) {
+		end = start + bsize;
+		if (end <= from)
+			continue;
+		if (start >= to)
+			break;
+		set_buffer_uptodate(bh);
+		gfs2_trans_add_data(gl, bh);
+	}
+}
+
 void gfs2_trans_add_meta(struct gfs2_glock *gl, struct buffer_head *bh)
 {
 
diff --git a/fs/gfs2/trans.h b/fs/gfs2/trans.h
index f8ce5302280d..790c55f59e61 100644
--- a/fs/gfs2/trans.h
+++ b/fs/gfs2/trans.h
@@ -42,6 +42,8 @@ int gfs2_trans_begin(struct gfs2_sbd *sdp, unsigned int blocks,
 
 void gfs2_trans_end(struct gfs2_sbd *sdp);
 void gfs2_trans_add_data(struct gfs2_glock *gl, struct buffer_head *bh);
+void gfs2_trans_add_databufs(struct gfs2_glock *gl, struct folio *folio,
+			     size_t from, size_t len);
 void gfs2_trans_add_meta(struct gfs2_glock *gl, struct buffer_head *bh);
 void gfs2_trans_add_revoke(struct gfs2_sbd *sdp, struct gfs2_bufdata *bd);
 void gfs2_trans_remove_revoke(struct gfs2_sbd *sdp, u64 blkno, unsigned int len);
-- 
2.49.0

