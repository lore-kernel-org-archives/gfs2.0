Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D506C1DFFC
	for <gfs2@lists.linux.dev>; Mon, 19 May 2025 11:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747653563; cv=none; b=MKI00otMZRRIb6pfqNFSBlRCehvKsGaKuFgZ3amZXiLDlSUmcy7HkYgxajLYdAU6fZWmkeClYBSRgGlqef/IXXn9ft6KhZS5bSYUiseSeWEIqmGGjTyJkvlCfYdZvglV9I0lBqbQD7N31YNBls6Pjh/PeTmnJc72KmbFC3/u62g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747653563; c=relaxed/simple;
	bh=GPOsktgokXO/TH45HysB3+lfXqqaDVKqwkjgWwMHzZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=bHpO7iXPCsp2TiconOFUtgib1ufS2+kABzpsyICvVQ28QmIMyhGw8jX34N9qZwz2y7LM8tG5fQAC5/5kAwwjRxIs1T9wzmSc75YkzKiRoNWp/ZZp3aAWy8233X3MJmofiC6iWK2l2xneyt7ixE8h6aj5iLUAKay7SAcufaeSOjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AvjTgKYW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AvjTgKYW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747653561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YhG7WDiSvuMER9fWLlbi7RCxvak0c+4IwmyCvJczA4o=;
	b=AvjTgKYWBhJPS1stK0O/+bOvEQQiwL0BOIUxar0SQYDxD52M3NxnA+gvl+NbxDrBb3d8r1
	pZKPyRts5582/gwQwZrloz/Iz7+O9g/gD0WTDQRM43NuMSkIVWff1avpc3IGdU3Nxumvaq
	r9BM38eNWuX/X+0VylgC1J6P+QmbmBQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-648-0crgYG-9PnCeqbaw4Owtaw-1; Mon,
 19 May 2025 07:19:19 -0400
X-MC-Unique: 0crgYG-9PnCeqbaw4Owtaw-1
X-Mimecast-MFC-AGG-ID: 0crgYG-9PnCeqbaw4Owtaw_1747653558
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CFCB2195608C
	for <gfs2@lists.linux.dev>; Mon, 19 May 2025 11:19:18 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.234])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A775218004A7;
	Mon, 19 May 2025 11:19:17 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 6/6] gfs2: No more gfs2_find_jhead caching
Date: Mon, 19 May 2025 13:19:05 +0200
Message-ID: <20250519111906.1503215-7-agruenba@redhat.com>
In-Reply-To: <20250519111906.1503215-1-agruenba@redhat.com>
References: <20250519111906.1503215-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: EVp00iYa3vFKvVudFDIZRn2tUVfoNpuDdlYcUI4Dkuw_1747653558
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

We are no longer calling gfs2_find_jhead() on the same log twice, so
there is no more reason for keeping the log contents cached across those
calls.  In addition, log head lookup and log header writing didn't go
through the same address space and so the caching wasn't even fully
working, anyway.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/glops.c    | 2 +-
 fs/gfs2/lops.c     | 7 ++-----
 fs/gfs2/lops.h     | 2 +-
 fs/gfs2/recovery.c | 2 +-
 fs/gfs2/super.c    | 2 +-
 fs/gfs2/util.c     | 2 +-
 6 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/fs/gfs2/glops.c b/fs/gfs2/glops.c
index e153db45bbd9..cebd66b22694 100644
--- a/fs/gfs2/glops.c
+++ b/fs/gfs2/glops.c
@@ -601,7 +601,7 @@ static int freeze_go_xmote_bh(struct gfs2_glock *gl)
 	if (test_bit(SDF_JOURNAL_LIVE, &sdp->sd_flags)) {
 		j_gl->gl_ops->go_inval(j_gl, DIO_METADATA);
 
-		error = gfs2_find_jhead(sdp->sd_jdesc, &head, false);
+		error = gfs2_find_jhead(sdp->sd_jdesc, &head);
 		if (gfs2_assert_withdraw_delayed(sdp, !error))
 			return error;
 		if (gfs2_assert_withdraw_delayed(sdp, head.lh_flags &
diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
index ba97e97d3eee..9c8c305a75c4 100644
--- a/fs/gfs2/lops.c
+++ b/fs/gfs2/lops.c
@@ -496,15 +496,13 @@ static struct bio *gfs2_chain_bio(struct bio *prev, unsigned int nr_iovecs)
  * gfs2_find_jhead - find the head of a log
  * @jd: The journal descriptor
  * @head: The log descriptor for the head of the log is returned here
- * @keep_cache: If set inode pages will not be truncated
  *
  * Do a search of a journal by reading it in large chunks using bios and find
  * the valid log entry with the highest sequence number.  (i.e. the log head)
  *
  * Returns: 0 on success, errno otherwise
  */
-int gfs2_find_jhead(struct gfs2_jdesc *jd, struct gfs2_log_header_host *head,
-		    bool keep_cache)
+int gfs2_find_jhead(struct gfs2_jdesc *jd, struct gfs2_log_header_host *head)
 {
 	struct gfs2_sbd *sdp = GFS2_SB(jd->jd_inode);
 	struct address_space *mapping = jd->jd_inode->i_mapping;
@@ -593,8 +591,7 @@ int gfs2_find_jhead(struct gfs2_jdesc *jd, struct gfs2_log_header_host *head,
 	if (!ret)
 		ret = filemap_check_wb_err(mapping, since);
 
-	if (!keep_cache)
-		truncate_inode_pages(mapping, 0);
+	truncate_inode_pages(mapping, 0);
 
 	return ret;
 }
diff --git a/fs/gfs2/lops.h b/fs/gfs2/lops.h
index 07890c7b145d..be740bf33666 100644
--- a/fs/gfs2/lops.h
+++ b/fs/gfs2/lops.h
@@ -20,7 +20,7 @@ void gfs2_log_write(struct gfs2_sbd *sdp, struct gfs2_jdesc *jd,
 void gfs2_log_submit_bio(struct bio **biop, blk_opf_t opf);
 void gfs2_pin(struct gfs2_sbd *sdp, struct buffer_head *bh);
 int gfs2_find_jhead(struct gfs2_jdesc *jd,
-		    struct gfs2_log_header_host *head, bool keep_cache);
+		    struct gfs2_log_header_host *head);
 void gfs2_drain_revokes(struct gfs2_sbd *sdp);
 
 static inline unsigned int buf_limit(struct gfs2_sbd *sdp)
diff --git a/fs/gfs2/recovery.c b/fs/gfs2/recovery.c
index b3a11105df7c..24250478b085 100644
--- a/fs/gfs2/recovery.c
+++ b/fs/gfs2/recovery.c
@@ -454,7 +454,7 @@ void gfs2_recover_func(struct work_struct *work)
 	if (error)
 		goto fail_gunlock_ji;
 
-	error = gfs2_find_jhead(jd, &head, true);
+	error = gfs2_find_jhead(jd, &head);
 	if (error)
 		goto fail_gunlock_ji;
 	t_jhd = ktime_get();
diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index a9af02ef580d..dbc119f8c762 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -360,7 +360,7 @@ static int gfs2_lock_fs_check_clean(struct gfs2_sbd *sdp)
 		error = gfs2_jdesc_check(jd);
 		if (error)
 			break;
-		error = gfs2_find_jhead(jd, &lh, false);
+		error = gfs2_find_jhead(jd, &lh);
 		if (error)
 			break;
 		if (!(lh.lh_flags & GFS2_LOG_HEAD_UNMOUNT)) {
diff --git a/fs/gfs2/util.c b/fs/gfs2/util.c
index 13be8d1d228b..d5a1e63fa257 100644
--- a/fs/gfs2/util.c
+++ b/fs/gfs2/util.c
@@ -73,7 +73,7 @@ int check_journal_clean(struct gfs2_sbd *sdp, struct gfs2_jdesc *jd,
 			       "mount.\n");
 		goto out_unlock;
 	}
-	error = gfs2_find_jhead(jd, &head, false);
+	error = gfs2_find_jhead(jd, &head);
 	if (error) {
 		if (verbose)
 			fs_err(sdp, "Error parsing journal for spectator "
-- 
2.49.0

