Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794882881;
	b=dOj3azU5X+l9KaZeGDUIQCFn4h2m8jsiuV4dpffgas+0ob0zRExNFRh9n7PD4MTkc7ji
	 A+NG52JEXQ78+FsSWAIq+WpR7yOpBQWk2CaZf2p8NpdAMohauPCGfpqNp0phH2FJbpT7Q
	 7ukZphSaBUUc/FxcojVoq9lhl/NNI1JCw0etXEuJAEyqJkm0OnViLR3V3LbTgqMMB6iJB
	 BriBr74HEyXaE4TqA2Kwrf2UVFjfCDzIIdpOjnh0j9+va/nAHXnuqzNc0WLINZ4Mqapvf
	 60kCATcYCnIVbqg2YPZleIq75Q+5b69Av3XFd/CMhUZsLwQhW1vpat9PrMutCfMg/fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794882881;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:MIME-Version:X-Scanned-By:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type;
	bh=BXRzwzGuqc1qDITJmsDcr9jpizNvArY7J8sgNyU+5X8=;
	b=h6PW430f9KnbYYwosGAGXMeOJId/DgV/mEALAQRWEpSAt/IPlZyen0UVakrfOSdIeELU
	 Q48+XAoWG+Ss4TR1+TPqJdL+ZYnTlULt/e3CB2aQX2TyQHTc1w/u0ZQPyGDivoQpZ3jju
	 sqdD0saxGjQrzXXZpfiWbNJLfj6UALCWPWvNsn7yKlLbAIqe9KzzAb1T4gY/foeHwm8tQ
	 1UDrIeOgLqUdsakeFrE7rsvD5tuZQGuWtJbeS3ZdqXZDXw7FEIvSGtDY6y0Fz2btKhL2D
	 TbfWPAV02KEX2kse6qwCo3UlzmNHpakquFCnGTvGDVF5nfQS2MucT914eg4HVROtqwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WLt52gPx;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CC0606A31C
	for <gfs2@lists.linux.dev>; Tue, 17 Nov 2026 02:34:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12CC0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WLt52gPx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794882880;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BXRzwzGuqc1qDITJmsDcr9jpizNvArY7J8sgNyU+5X8=;
	b=WLt52gPxGO/2WS5Tcs9WHj32vDWtNZ57+nrLKl3bBqNI1qEBWox05huzYaQEs1TKjNh3i8
	Inmxl7SjOVkctD6lwUwTgiLKwjwlG8DFJ7YbR5yl6jpPsuauh0AIq8LGK8ouxlh0XBOMy/
	JkhyPapqLor+9n86VNZSRBUhMP+V6w8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-586-Kw_o0_FGOwS7yRwDoXWEqA-1; Mon,
 16 Nov 2026 21:34:38 -0500
X-MC-Unique: Kw_o0_FGOwS7yRwDoXWEqA-1
X-Mimecast-MFC-AGG-ID: Kw_o0_FGOwS7yRwDoXWEqA_1794882877
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6873C180055D
	for <gfs2@lists.linux.dev>; Tue, 17 Nov 2026 02:34:37 +0000 (UTC)
Received: from agruenba-thinkpadx1carbongen9.rmtat.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8C2D61801974;
	Tue, 17 Nov 2026 02:34:36 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH] gfs2: keep glocks alive while they have active buffers
Date: Tue, 17 Nov 2026 03:34:35 +0100
Message-ID: <20261117023435.10386-1-agruenba@redhat.com>
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Post: <mailto:gfs2@lists.linux.dev>
List-Help: <mailto:gfs2+help@lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
List-Owner: <mailto:gfs2+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VxTwhydCF2scEfQhgbyNjZ07FITzAIpCcjjAHfo5FQw_1794882877
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

It turns out that taking an extra inode glock reference in gfs2_unpin()
is not enough to keep the glock alive because the inode may already have
been evicted.  Instead, we must take that extra reference in gfs2_pin()
already.

To keep track of the number of active buffers, introduce an additional
gl_bufdata_count counter.  This counter includes all buffers that are on
sd_log_revokes, in sd_log_tr, or in any of the transactions on
sd_ail1_list or sd_ail2_list.

Grab an extra glock reference when gl_bufdata_count reaches 1, and drop
that extra reference when that counter drops to 0.  This replaces the
extra glock reference taking tied to the gl_revokes and gl_ail_count.

Fixes: 9287c6452d2b ("gfs2: Fix occasional glock use-after-free").
Fixes: 1c453efdaafa ("gfs2: keep glocks alive while AIL entries exist")
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/incore.h | 26 ++++++++++++++++++++++++++
 fs/gfs2/log.c    | 35 ++++++++++++++++++++++++++---------
 fs/gfs2/lops.c   | 10 ++++++++--
 fs/gfs2/main.c   |  1 +
 4 files changed, 61 insertions(+), 11 deletions(-)

diff --git a/fs/gfs2/incore.h b/fs/gfs2/incore.h
index 49cc232942a2..1ff19f87d3bd 100644
--- a/fs/gfs2/incore.h
+++ b/fs/gfs2/incore.h
@@ -137,6 +137,15 @@ TAS_BUFFER_FNS(Pinned, pinned)
 BUFFER_FNS(Escaped, escaped)
 TAS_BUFFER_FNS(Escaped, escaped)
 
+/**
+ * struct gfs2_bufdata
+ *
+ * Bufdata objects normally remain attached to their corresponding buffer head
+ * (bd->bd_bh == bh; bh->b_private == bd), but when they are turned into
+ * revokes, they are detached from bh and from their transaction and put onto
+ * the sd_log_revokes list.
+ */
+
 struct gfs2_bufdata {
 	struct buffer_head *bd_bh;
 	struct gfs2_glock *bd_gl;
@@ -330,6 +339,12 @@ enum {
 	GLF_CANCELING			= 21,
 };
 
+/**
+ * struct gfs2_glock
+ * @gl_bufdata_count: The number of bufdata objects that refer to this glock.
+ * Bufdata objects refer to glocks via transactions (struct gfs_trans) and via
+ * the sd_log_revokes list.
+ */
 struct gfs2_glock {
 	unsigned long gl_flags;		/* GLF_... */
 	struct lm_lockname gl_name;
@@ -356,6 +371,7 @@ struct gfs2_glock {
 
 	struct list_head gl_dead;
 	struct list_head gl_ail_list;
+	atomic_t gl_bufdata_count;
 	atomic_t gl_ail_count;
 	atomic_t gl_revokes;
 	struct delayed_work gl_work;
@@ -475,6 +491,16 @@ enum {
 	TR_ONSTACK = 3,
 };
 
+/**
+ * struct gfs2_trans
+ *
+ * Uncommitted transactions refer to bufdata objects via the tr_buf and
+ * tr_databuf lists.  Committed transactions refer to bufdata objects via
+ * tr_ail1_list and tr_ail2_list.  A bufdata object cannot be both on tr_buf
+ * and tr_databuf, and it cannot be both on tr_ail1_list and tr_ail2_list at
+ * the same time.  It can be part of an uncommitted and a committed transaction
+ * at the same time, though.
+ */
 struct gfs2_trans {
 	unsigned long tr_ip;
 
diff --git a/fs/gfs2/log.c b/fs/gfs2/log.c
index a89346c93f16..1baaaf30c4fa 100644
--- a/fs/gfs2/log.c
+++ b/fs/gfs2/log.c
@@ -65,25 +65,39 @@ unsigned int gfs2_struct2blk(struct gfs2_sbd *sdp, unsigned int nstruct)
 }
 
 /**
- * gfs2_remove_from_ail - Remove an entry from the ail lists, updating counters
+ * __gfs2_remove_from_ail - Remove an entry from the ail lists
  * @bd: The gfs2_bufdata to remove
  *
  * The ail lock _must_ be held when calling this function
  *
  */
 
-static void gfs2_remove_from_ail(struct gfs2_bufdata *bd)
+static void __gfs2_remove_from_ail(struct gfs2_bufdata *bd)
 {
 	struct gfs2_glock *gl = bd->bd_gl;
 
 	bd->bd_tr = NULL;
 	list_del_init(&bd->bd_ail_st_list);
 	list_del_init(&bd->bd_ail_gl_list);
-	if (atomic_dec_and_test(&gl->gl_ail_count))
-		gfs2_glock_put_async(gl);
+	atomic_dec(&gl->gl_ail_count);
 	brelse(bd->bd_bh);
 }
 
+static void gfs2_remove_from_ail(struct gfs2_bufdata *bd)
+{
+	__gfs2_remove_from_ail(bd);
+	if (list_empty(&bd->bd_list)) {
+		struct gfs2_glock *gl = bd->bd_gl;
+
+		/*
+		 * bd is not part of a uncommitted transaction, and it is still
+		 * attached to its bh.
+		 */
+		if (atomic_dec_and_test(&gl->gl_bufdata_count))
+			gfs2_glock_put_async(gl);
+	}
+}
+
 /**
  * gfs2_ail1_start_one - Start I/O on a transaction
  * @sdp: The superblock
@@ -765,11 +779,10 @@ void gfs2_add_revoke(struct gfs2_sbd *sdp, struct gfs2_bufdata *bd)
 	struct gfs2_glock *gl = bd->bd_gl;
 
 	sdp->sd_log_num_revoke++;
-	if (atomic_inc_return(&gl->gl_revokes) == 1)
-		gfs2_glock_hold(gl);
+	atomic_inc(&gl->gl_revokes);
 	bh->b_private = NULL;
 	bd->bd_blkno = bh->b_blocknr;
-	gfs2_remove_from_ail(bd); /* drops ref on bh */
+	__gfs2_remove_from_ail(bd); /* drops ref on bh */
 	bd->bd_bh = NULL;
 	set_bit(GLF_LFLUSH, &gl->gl_flags);
 	list_add(&bd->bd_list, &sdp->sd_log_revokes);
@@ -780,10 +793,10 @@ void gfs2_glock_remove_revoke(struct gfs2_bufdata *bd)
 	struct gfs2_glock *gl = bd->bd_gl;
 
 	list_del_init(&bd->bd_list);
-	if (atomic_dec_and_test(&gl->gl_revokes)) {
+	if (atomic_dec_and_test(&gl->gl_revokes))
 		clear_bit(GLF_LFLUSH, &gl->gl_flags);
+	if (atomic_dec_and_test(&gl->gl_bufdata_count))
 		gfs2_glock_put_async(gl);
-	}
 	kmem_cache_free(gfs2_bufdata_cachep, bd);
 }
 
@@ -1044,6 +1057,10 @@ void gfs2_remove_from_journal(struct buffer_head *bh, int meta)
 			else
 				 gfs2_remove_from_ail(bd);
 		} else if (was_pinned) {
+			struct gfs2_glock *gl = bd->bd_gl;
+
+			if (atomic_dec_and_test(&gl->gl_bufdata_count))
+				gfs2_glock_put_async(gl);
 			bh->b_private = NULL;
 			kmem_cache_free(gfs2_bufdata_cachep, bd);
 		} else if (!list_empty(&bd->bd_ail_st_list) &&
diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
index 204b2fb76575..657edd406dd1 100644
--- a/fs/gfs2/lops.c
+++ b/fs/gfs2/lops.c
@@ -57,6 +57,13 @@ void gfs2_pin(struct gfs2_sbd *sdp, struct buffer_head *bh)
 	spin_lock(&sdp->sd_ail_lock);
 	if (bd->bd_tr)
 		list_move(&bd->bd_ail_st_list, &bd->bd_tr->tr_ail2_list);
+	else {
+		struct gfs2_glock *gl = bd->bd_gl;
+
+		/* bd is attached to bh, so it cannot be a revoke. */
+		if (atomic_inc_return(&gl->gl_bufdata_count) == 1)
+			gfs2_glock_hold(gl);
+	}
 	spin_unlock(&sdp->sd_ail_lock);
 	get_bh(bh);
 	atomic_inc(&sdp->sd_log_pinned);
@@ -121,8 +128,7 @@ static void gfs2_unpin(struct gfs2_sbd *sdp, struct buffer_head *bh,
 	} else {
 		struct gfs2_glock *gl = bd->bd_gl;
 		list_add(&bd->bd_ail_gl_list, &gl->gl_ail_list);
-		if (atomic_inc_return(&gl->gl_ail_count) == 1)
-			gfs2_glock_hold(gl);
+		atomic_inc(&gl->gl_ail_count);
 	}
 	bd->bd_tr = tr;
 	list_add(&bd->bd_ail_st_list, &tr->tr_ail1_list);
diff --git a/fs/gfs2/main.c b/fs/gfs2/main.c
index 36c9c06e91ac..a607e98eb45f 100644
--- a/fs/gfs2/main.c
+++ b/fs/gfs2/main.c
@@ -53,6 +53,7 @@ static void gfs2_init_glock_once(void *foo)
 
 	INIT_LIST_HEAD(&gl->gl_holders);
 	INIT_LIST_HEAD(&gl->gl_ail_list);
+	atomic_set(&gl->gl_bufdata_count, 0);
 	atomic_set(&gl->gl_ail_count, 0);
 	atomic_set(&gl->gl_revokes, 0);
 }
-- 
2.56.1

