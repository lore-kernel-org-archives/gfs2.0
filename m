Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794882839;
	b=L0T02nULYnzJWbQS4hbx8EmqHers+bnZKMJgtTvenoLBNHq/0xQeVHyjFJ2oY/12kTrT
	 NLLoOji/jCiTuFXXB/OhB1piHQsgR+Los30nPdckK6HMZ3X286o2QnwuN0Oaql/sjD7UY
	 jFiDfXW4hAzg0DE+krh63146F5lLw/4AXtyZKXIELzzXEB3z6wIpjYok65VH38OxngvWc
	 vQPdWxzC8ri0yDEZQkZh0rQ/7nQKM3TReXHliofiTNviVFxDAvmxyD7fmlNUrTB1Sccv3
	 hpPBMRz5vRPbbhGqKfaxsIf6J8sYW3AOHb2mPOhLdKSjWGHH1iGMnsA9MFzOd0FHFeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794882839;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:X-Scanned-By:
	 X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type;
	bh=wdAwSKlbKvQQq5DRKipsRlCBkzLqprUkOgu4ugiYUOI=;
	b=R1/yTjjNybOpOyfuhq1B2ELD1IXbIuhbZUywSYf2+urbMjtqb6LUvH1ZPuYhFjlteNZI
	 BWkMGoahQEpK9pGiKoybE4jP6HCBqnLRD0qNWCwGcCISjd/jRov9FSaNQVUOcVw7v0KyL
	 36gfq6DPhrKBlxZrxygnjTIndUPWGCTRlR78ncQCO/hfy7jmLgr5dHPTS0Za9BnEM2FhT
	 bLUbZu8EqFd2lKQh4FXOJiAHv401cqTsiI8LvROr2yCXRAznQhONABSPvCb7NgCuqsNu0
	 fpPTysbv6KqRChuYJk5rrr995zWiKVX3Oj4LXJKZPYnFJCDgLkSNaiMA9e1qOlG6oUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="Vz/7pgVP";
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA59606A335
	for <gfs2@lists.linux.dev>; Tue, 17 Nov 2026 02:33:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4EA59606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Vz/7pgVP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794882838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wdAwSKlbKvQQq5DRKipsRlCBkzLqprUkOgu4ugiYUOI=;
	b=Vz/7pgVPII0xfdxvIAT3ITD1B3CGYsnNPszJiEMo3mA5z84Z07LxzHWxVxvPBAVRqngvfC
	jIfdUeNwfNUcd5qotHjNOw6egG6JLm13lS/Pb8ruwBmIM1/pHQU+FsnC1o9A+9oTf968xE
	Nwyv7lHYadA+GeCQPnCwg6B9folzsFc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-30-stzxaIaBN56r60XJvhIMZw-1; Mon,
 16 Nov 2026 21:33:56 -0500
X-MC-Unique: stzxaIaBN56r60XJvhIMZw-1
X-Mimecast-MFC-AGG-ID: stzxaIaBN56r60XJvhIMZw_1794882836
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0C0371955F7B
	for <gfs2@lists.linux.dev>; Tue, 17 Nov 2026 02:33:56 +0000 (UTC)
Received: from agruenba-thinkpadx1carbongen9.rmtat.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1E03C44D;
	Tue, 17 Nov 2026 02:33:54 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 2/4] gfs2: Remove unnecessary list heads
Date: Tue, 17 Nov 2026 03:33:47 +0100
Message-ID: <20261117023350.10180-3-agruenba@redhat.com>
In-Reply-To: <20261117023350.10180-1-agruenba@redhat.com>
References: <20261117023350.10180-1-agruenba@redhat.com>
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Post: <mailto:gfs2@lists.linux.dev>
List-Help: <mailto:gfs2+help@lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
List-Owner: <mailto:gfs2+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YvgbdP7RpG5TQ4pDuAiO8mbpuyye3ZFa0iuLebpGm_Y_1794882836
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Remove a few list_head pointers: they don't provide any advantages and
make the code more difficult to follow.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/glops.c    | 3 +--
 fs/gfs2/log.c      | 8 +++-----
 fs/gfs2/lops.c     | 3 +--
 fs/gfs2/recovery.c | 5 ++---
 4 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/fs/gfs2/glops.c b/fs/gfs2/glops.c
index 2597e1cf2315..2073bbf5c8cf 100644
--- a/fs/gfs2/glops.c
+++ b/fs/gfs2/glops.c
@@ -59,14 +59,13 @@ static void __gfs2_ail_flush(struct gfs2_glock *gl, bool fsync,
 			     unsigned int nr_revokes)
 {
 	struct gfs2_sbd *sdp = glock_sbd(gl);
-	struct list_head *head = &gl->gl_ail_list;
 	struct gfs2_bufdata *bd, *tmp;
 	struct buffer_head *bh;
 	const unsigned long b_state = (1UL << BH_Dirty)|(1UL << BH_Pinned)|(1UL << BH_Lock);
 
 	spin_lock(&sdp->sd_log_lock);
 	spin_lock(&sdp->sd_ail_lock);
-	list_for_each_entry_safe_reverse(bd, tmp, head, bd_ail_gl_list) {
+	list_for_each_entry_safe_reverse(bd, tmp, &gl->gl_ail_list, bd_ail_gl_list) {
 		if (nr_revokes == 0)
 			break;
 		bh = bd->bd_bh;
diff --git a/fs/gfs2/log.c b/fs/gfs2/log.c
index 146f5c8da72b..3161c728b60b 100644
--- a/fs/gfs2/log.c
+++ b/fs/gfs2/log.c
@@ -198,7 +198,6 @@ static void dump_ail_list(struct gfs2_sbd *sdp)
 
 void gfs2_ail1_flush(struct gfs2_sbd *sdp, struct writeback_control *wbc)
 {
-	struct list_head *head = &sdp->sd_ail1_list;
 	struct gfs2_trans *tr;
 	struct blk_plug plug;
 	int ret;
@@ -215,7 +214,7 @@ void gfs2_ail1_flush(struct gfs2_sbd *sdp, struct writeback_control *wbc)
 		dump_ail_list(sdp);
 		goto out;
 	}
-	list_for_each_entry_reverse(tr, head, tr_list) {
+	list_for_each_entry_reverse(tr, &sdp->sd_ail1_list, tr_list) {
 		if (wbc->nr_to_write <= 0)
 			break;
 		ret = gfs2_ail1_start_one(sdp, wbc, tr, &plug);
@@ -403,18 +402,17 @@ static void __ail2_empty(struct gfs2_sbd *sdp, struct gfs2_trans *tr)
 
 static void ail2_empty(struct gfs2_sbd *sdp, unsigned int new_tail)
 {
-	struct list_head *ail2_list = &sdp->sd_ail2_list;
 	unsigned int old_tail = sdp->sd_log_tail;
 	struct gfs2_trans *tr, *safe;
 
 	spin_lock(&sdp->sd_ail_lock);
 	if (old_tail <= new_tail) {
-		list_for_each_entry_safe(tr, safe, ail2_list, tr_list) {
+		list_for_each_entry_safe(tr, safe, &sdp->sd_ail2_list, tr_list) {
 			if (old_tail <= tr->tr_first && tr->tr_first < new_tail)
 				__ail2_empty(sdp, tr);
 		}
 	} else {
-		list_for_each_entry_safe(tr, safe, ail2_list, tr_list) {
+		list_for_each_entry_safe(tr, safe, &sdp->sd_ail2_list, tr_list) {
 			if (old_tail <= tr->tr_first || tr->tr_first < new_tail)
 				__ail2_empty(sdp, tr);
 		}
diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
index abf5afbce77d..849cdcc1baa6 100644
--- a/fs/gfs2/lops.c
+++ b/fs/gfs2/lops.c
@@ -849,7 +849,6 @@ static void revoke_lo_before_commit(struct gfs2_sbd *sdp, struct gfs2_trans *tr)
 {
 	struct gfs2_meta_header *mh;
 	unsigned int offset;
-	struct list_head *head = &sdp->sd_log_revokes;
 	struct gfs2_bufdata *bd;
 	struct page *page;
 	unsigned int length;
@@ -862,7 +861,7 @@ static void revoke_lo_before_commit(struct gfs2_sbd *sdp, struct gfs2_trans *tr)
 	page = gfs2_get_log_desc(sdp, GFS2_LOG_DESC_REVOKE, length, sdp->sd_log_num_revoke);
 	offset = sizeof(struct gfs2_log_descriptor);
 
-	list_for_each_entry(bd, head, bd_list) {
+	list_for_each_entry(bd, &sdp->sd_log_revokes, bd_list) {
 		sdp->sd_log_num_revoke--;
 
 		if (offset + sizeof(u64) > sdp->sd_sb.sb_bsize) {
diff --git a/fs/gfs2/recovery.c b/fs/gfs2/recovery.c
index 908e7f1253d2..f950eb95f435 100644
--- a/fs/gfs2/recovery.c
+++ b/fs/gfs2/recovery.c
@@ -55,10 +55,9 @@ int gfs2_replay_read_block(struct gfs2_jdesc *jd, unsigned int blk,
 
 int gfs2_revoke_add(struct gfs2_jdesc *jd, u64 blkno, unsigned int where)
 {
-	struct list_head *head = &jd->jd_revoke_list;
 	struct gfs2_revoke_replay *rr = NULL, *iter;
 
-	list_for_each_entry(iter, head, rr_list) {
+	list_for_each_entry(iter, &jd->jd_revoke_list, rr_list) {
 		if (iter->rr_blkno == blkno) {
 			rr = iter;
 			break;
@@ -76,7 +75,7 @@ int gfs2_revoke_add(struct gfs2_jdesc *jd, u64 blkno, unsigned int where)
 
 	rr->rr_blkno = blkno;
 	rr->rr_where = where;
-	list_add(&rr->rr_list, head);
+	list_add(&rr->rr_list, &jd->jd_revoke_list);
 
 	return 1;
 }
-- 
2.56.1

