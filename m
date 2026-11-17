Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794882839;
	b=A143eK34sxiRnj5OJQco27618+h+C9lzFUtkARO9ngiNLwYjym/IRfPKpNQg96V32eea
	 pVV64tCzq1+1k1tnIDqy47GvGShkRIwNnbJ83DvhB4QZNjZmZagy3bGQpIHDqWhtr7Zs0
	 HhbEtB8joDzbMvVsQyKIfBdpJjoDcdcG85dSFrOfWEWCnMrGTiy5zZNiaT8JiXUNx1Gww
	 D4dG8q9Idwg8W1QSOUEI2/p2KPfD7nemgH+5SM2pQCuVQrb3RGv7AHzva9GCxWxbo4oRQ
	 XI1ooiCjihhz02GNDTF5CUTuCBAXInPzXzuZdFSSjZcB/Uq0arCO6yTqm6oNsNPKVwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794882839;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:X-Scanned-By:
	 X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type;
	bh=JwgZACERMIxp0QseefEuTufDNwND+5spRVD2Eaq8Nz8=;
	b=txwjlQoKIxTNntW2BeYfJNB7fZZrNXvDhh+0z0awZGWM5poBCXCWQx/cmDwpV/imDh+e
	 hsIckntW1NUHWFvcZ/EmQyA6ys4FeKtBxRyj7dedhsfy6XivZcsBrfkAJTjbkzvlRsT1s
	 ffDRMYSzr6Hz9TjZkH+b4zYoDlOcTOYt25OoPMMZrfPG80PtyDf9OKqHd7g9X0+ixT920
	 UV1RwAc/1Nw7M1SrygKYQxKkYzsTOtQYLE1JaF1QFtVQ/sBh7zfvMkSBc7OUWIpTsTLWG
	 S2qer0kKn6qSkxaoiP9khRrXk/680DezoHmzCeiD0F9wdRxx2VsUuySdzO3yYoxgAkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OzAyuzjw;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75348606A334
	for <gfs2@lists.linux.dev>; Tue, 17 Nov 2026 02:33:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75348606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OzAyuzjw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794882837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JwgZACERMIxp0QseefEuTufDNwND+5spRVD2Eaq8Nz8=;
	b=OzAyuzjwJUvXJfCWz5lkoH5SfD12vqvOwk2fSPFh2skm8J+QkNCJc3rQFHYlMFzh8pJfpg
	0bjU2ygDN/7F1om8UrMCVIsAJSppXYqc+PP1LMhwXKCgiPnxBFeWZB3BM6PvhfKZx5BU9b
	RpbRMVztG7pUvUsPxHNaaYrLRBhAJ6Q=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-611-2tFFPvquO-GydbEMAPV62g-1; Mon,
 16 Nov 2026 21:33:55 -0500
X-MC-Unique: 2tFFPvquO-GydbEMAPV62g-1
X-Mimecast-MFC-AGG-ID: 2tFFPvquO-GydbEMAPV62g_1794882835
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C93E41956065
	for <gfs2@lists.linux.dev>; Tue, 17 Nov 2026 02:33:54 +0000 (UTC)
Received: from agruenba-thinkpadx1carbongen9.rmtat.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D45AE41F;
	Tue, 17 Nov 2026 02:33:53 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 1/4] gfs2: list_for_each_entry_safe conversion
Date: Tue, 17 Nov 2026 03:33:46 +0100
Message-ID: <20261117023350.10180-2-agruenba@redhat.com>
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
X-Mimecast-MFC-PROC-ID: dfG9BrOhsY1zyER-Pq2jwlm9PinCc_WMZMz5MUUQ4Dk_1794882835
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Replace the following list iterations that don't drop the list lock:

    while (!list_empty(list)) {
	entry = list_first_entry(list, type, field);
	list_del(&entry->field);
    }

with the preferred equivalent form:

    list_for_each_entry_safe(entry, tmp, list, field) {
	list_del(&entry->field);
    }

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/bmap.c     |  5 ++---
 fs/gfs2/glock.c    |  7 ++-----
 fs/gfs2/log.c      | 21 +++++++--------------
 fs/gfs2/lops.c     | 20 ++++++--------------
 fs/gfs2/quota.c    |  5 ++---
 fs/gfs2/recovery.c |  6 ++----
 fs/gfs2/super.c    | 10 ++++------
 7 files changed, 25 insertions(+), 49 deletions(-)

diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index 264170f91c5d..4916bcfa1f30 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -2228,10 +2228,9 @@ int gfs2_file_dealloc(struct gfs2_inode *ip)
 
 void gfs2_free_journal_extents(struct gfs2_jdesc *jd)
 {
-	struct gfs2_journal_extent *jext;
+	struct gfs2_journal_extent *jext, *tmp;
 
-	while(!list_empty(&jd->extent_list)) {
-		jext = list_first_entry(&jd->extent_list, struct gfs2_journal_extent, list);
+	list_for_each_entry_safe(jext, tmp, &jd->extent_list, list) {
 		list_del(&jext->list);
 		kfree(jext);
 	}
diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index aa11168255e9..21b71fe286b7 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -179,12 +179,9 @@ void gfs2_glock_free_later(struct gfs2_glock *gl) {
 
 static void gfs2_free_dead_glocks(struct gfs2_sbd *sdp)
 {
-	struct list_head *list = &sdp->sd_dead_glocks;
-
-	while(!list_empty(list)) {
-		struct gfs2_glock *gl;
+	struct gfs2_glock *gl, *tmp;
 
-		gl = list_first_entry(list, struct gfs2_glock, gl_dead);
+	list_for_each_entry_safe(gl, tmp, &sdp->sd_dead_glocks, gl_dead) {
 		list_del(&gl->gl_dead);
 		__gfs2_glock_free(gl);
 	}
diff --git a/fs/gfs2/log.c b/fs/gfs2/log.c
index 7a391b50d13b..146f5c8da72b 100644
--- a/fs/gfs2/log.c
+++ b/fs/gfs2/log.c
@@ -281,11 +281,9 @@ static void gfs2_log_update_head(struct gfs2_sbd *sdp)
 static void gfs2_ail_empty_tr(struct gfs2_sbd *sdp, struct gfs2_trans *tr,
 			      struct list_head *head)
 {
-	struct gfs2_bufdata *bd;
+	struct gfs2_bufdata *bd, *tmp;
 
-	while (!list_empty(head)) {
-		bd = list_first_entry(head, struct gfs2_bufdata,
-				      bd_ail_st_list);
+	list_for_each_entry_safe(bd, tmp, head, bd_ail_st_list) {
 		gfs2_assert(sdp, bd->bd_tr == tr);
 		gfs2_remove_from_ail(bd);
 	}
@@ -933,7 +931,7 @@ static void log_write_header(struct gfs2_sbd *sdp, u32 flags)
  */
 void gfs2_ail_drain(struct gfs2_sbd *sdp)
 {
-	struct gfs2_trans *tr;
+	struct gfs2_trans *tr, *tmp;
 
 	spin_lock(&sdp->sd_ail_lock);
 	/*
@@ -943,17 +941,13 @@ void gfs2_ail_drain(struct gfs2_sbd *sdp)
 	 * before revokes are sent for that block. Items on the sd_ail2_list
 	 * should have already gotten beyond that point, so no need.
 	 */
-	while (!list_empty(&sdp->sd_ail1_list)) {
-		tr = list_first_entry(&sdp->sd_ail1_list, struct gfs2_trans,
-				      tr_list);
+	list_for_each_entry_safe(tr, tmp, &sdp->sd_ail1_list, tr_list) {
 		gfs2_ail_empty_tr(sdp, tr, &tr->tr_ail1_list);
 		gfs2_ail_empty_tr(sdp, tr, &tr->tr_ail2_list);
 		list_del(&tr->tr_list);
 		gfs2_trans_free(sdp, tr);
 	}
-	while (!list_empty(&sdp->sd_ail2_list)) {
-		tr = list_first_entry(&sdp->sd_ail2_list, struct gfs2_trans,
-				      tr_list);
+	list_for_each_entry_safe(tr, tmp, &sdp->sd_ail2_list, tr_list) {
 		gfs2_ail_empty_tr(sdp, tr, &tr->tr_ail2_list);
 		list_del(&tr->tr_list);
 		gfs2_trans_free(sdp, tr);
@@ -989,10 +983,9 @@ static void empty_ail1_list(struct gfs2_sbd *sdp)
 
 static void gfs2_trans_drain_list(struct gfs2_sbd *sdp, struct list_head *list)
 {
-	struct gfs2_bufdata *bd;
+	struct gfs2_bufdata *bd, *tmp;
 
-	while (!list_empty(list)) {
-		bd = list_first_entry(list, struct gfs2_bufdata, bd_list);
+	list_for_each_entry_safe(bd, tmp, list, bd_list) {
 		struct buffer_head *bh = bd->bd_bh;
 
 		WARN_ON_ONCE(!buffer_pinned(bh));
diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
index 13d8aa1dfea1..abf5afbce77d 100644
--- a/fs/gfs2/lops.c
+++ b/fs/gfs2/lops.c
@@ -726,15 +726,12 @@ static void buf_lo_before_commit(struct gfs2_sbd *sdp, struct gfs2_trans *tr)
 
 static void buf_lo_after_commit(struct gfs2_sbd *sdp, struct gfs2_trans *tr)
 {
-	struct list_head *head;
-	struct gfs2_bufdata *bd;
+	struct gfs2_bufdata *bd, *tmp;
 
 	if (tr == NULL)
 		return;
 
-	head = &tr->tr_buf;
-	while (!list_empty(head)) {
-		bd = list_first_entry(head, struct gfs2_bufdata, bd_list);
+	list_for_each_entry_safe(bd, tmp, &tr->tr_buf, bd_list) {
 		list_del_init(&bd->bd_list);
 		gfs2_unpin(sdp, bd->bd_bh, tr);
 	}
@@ -889,12 +886,10 @@ static void revoke_lo_before_commit(struct gfs2_sbd *sdp, struct gfs2_trans *tr)
 
 void gfs2_drain_revokes(struct gfs2_sbd *sdp)
 {
-	struct list_head *head = &sdp->sd_log_revokes;
-	struct gfs2_bufdata *bd;
+	struct gfs2_bufdata *bd, *tmp;
 	struct gfs2_glock *gl;
 
-	while (!list_empty(head)) {
-		bd = list_first_entry(head, struct gfs2_bufdata, bd_list);
+	list_for_each_entry_safe(bd, tmp, &sdp->sd_log_revokes, bd_list) {
 		list_del_init(&bd->bd_list);
 		gl = bd->bd_gl;
 		gfs2_glock_remove_revoke(gl);
@@ -1070,15 +1065,12 @@ static void databuf_lo_after_scan(struct gfs2_jdesc *jd, int error, int pass)
 
 static void databuf_lo_after_commit(struct gfs2_sbd *sdp, struct gfs2_trans *tr)
 {
-	struct list_head *head;
-	struct gfs2_bufdata *bd;
+	struct gfs2_bufdata *bd, *tmp;
 
 	if (tr == NULL)
 		return;
 
-	head = &tr->tr_databuf;
-	while (!list_empty(head)) {
-		bd = list_first_entry(head, struct gfs2_bufdata, bd_list);
+	list_for_each_entry_safe(bd, tmp, &tr->tr_databuf, bd_list) {
 		list_del_init(&bd->bd_list);
 		gfs2_unpin(sdp, bd->bd_bh, tr);
 	}
diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
index b2984fb7b35c..88bf87db1d27 100644
--- a/fs/gfs2/quota.c
+++ b/fs/gfs2/quota.c
@@ -137,10 +137,9 @@ static void gfs2_qd_dispose(struct gfs2_quota_data *qd)
 
 static void gfs2_qd_list_dispose(struct list_head *list)
 {
-	struct gfs2_quota_data *qd;
+	struct gfs2_quota_data *qd, *tmp;
 
-	while (!list_empty(list)) {
-		qd = list_first_entry(list, struct gfs2_quota_data, qd_lru);
+	list_for_each_entry_safe(qd, tmp, list, qd_lru) {
 		list_del(&qd->qd_lru);
 
 		gfs2_qd_dispose(qd);
diff --git a/fs/gfs2/recovery.c b/fs/gfs2/recovery.c
index 84db5bb7dc5c..908e7f1253d2 100644
--- a/fs/gfs2/recovery.c
+++ b/fs/gfs2/recovery.c
@@ -106,11 +106,9 @@ int gfs2_revoke_check(struct gfs2_jdesc *jd, u64 blkno, unsigned int where)
 
 void gfs2_revoke_clean(struct gfs2_jdesc *jd)
 {
-	struct list_head *head = &jd->jd_revoke_list;
-	struct gfs2_revoke_replay *rr;
+	struct gfs2_revoke_replay *rr, *tmp;
 
-	while (!list_empty(head)) {
-		rr = list_first_entry(head, struct gfs2_revoke_replay, rr_list);
+	list_for_each_entry_safe(rr, tmp, &jd->jd_revoke_list, rr_list) {
 		list_del(&rr->rr_list);
 		kfree(rr);
 	}
diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index bcb90ffe1816..c7777b8565a2 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -59,7 +59,7 @@ enum evict_behavior {
 void gfs2_jindex_free(struct gfs2_sbd *sdp)
 {
 	struct list_head list;
-	struct gfs2_jdesc *jd;
+	struct gfs2_jdesc *jd, *tmp;
 
 	spin_lock(&sdp->sd_jindex_spin);
 	list_add(&list, &sdp->sd_jindex_list);
@@ -71,8 +71,7 @@ void gfs2_jindex_free(struct gfs2_sbd *sdp)
 	sdp->sd_jdesc = NULL;
 	up_write(&sdp->sd_log_flush_lock);
 
-	while (!list_empty(&list)) {
-		jd = list_first_entry(&list, struct gfs2_jdesc, jd_list);
+	list_for_each_entry_safe(jd, tmp, &list, jd_list) {
 		BUG_ON(jd->jd_log_bio);
 		gfs2_free_journal_extents(jd);
 		list_del(&jd->jd_list);
@@ -324,7 +323,7 @@ struct lfcc {
 static int gfs2_lock_fs_check_clean(struct gfs2_sbd *sdp)
 {
 	struct gfs2_jdesc *jd;
-	struct lfcc *lfcc;
+	struct lfcc *lfcc, *tmp;
 	LIST_HEAD(list);
 	struct gfs2_log_header_host lh;
 	int error, error2;
@@ -381,8 +380,7 @@ static int gfs2_lock_fs_check_clean(struct gfs2_sbd *sdp)
 	gfs2_assert_withdraw(sdp, !error2);
 
 out:
-	while (!list_empty(&list)) {
-		lfcc = list_first_entry(&list, struct lfcc, list);
+	list_for_each_entry_safe(lfcc, tmp, &list, list) {
 		list_del(&lfcc->list);
 		gfs2_glock_dq_uninit(&lfcc->gh);
 		kfree(lfcc);
-- 
2.56.1

