Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDCC208A0
	for <gfs2@lists.linux.dev>; Tue, 18 Jun 2024 16:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718726741; cv=none; b=oQ7D1jRpHz+fxMhsZD3o7jtSgvaOTWtvX+sptggE5TdrfCd5UZPoGLlTbRBCkyCldC0lgZNsjyOPX+Hh9EWjimZhp48GHWRLuRQnm+a4nc3+nnR1dfNWaKMF/Kq+pOSoWoSb2AIEjlK+OjycqtMbhWzNW/oSFQVZcBSwGI6H9pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718726741; c=relaxed/simple;
	bh=luEMgVXzorEg++X4/6XiCKfwlT5fwb2+w5iaxy9h43w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EQdyfL9liN58RsrZdeA8e6n/lMJE8bX7Ax+xr69HBdFQyEhBXuW1PGBfqSfQbP6D1hV7OEcoNOaElyKGADwty3mBMJn4nDeIaFb0TBH/M7jIlXG3MbsjXepsjUvbliU/eWQn6MPBV/7WflL+rch3yAXoTEGP9de85RwpAcpvPEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cS+hV4Zb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cS+hV4Zb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718726739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ORRapzVy+w7vcQbyHrgAVm454NvC9okb3zXDv+I7nfk=;
	b=cS+hV4Zb2v4HNdjxzWZTqLrEYCkGeqjIZKB4tBUPdi2iw41m6pcnMRvtyRHLt6wrevFo02
	pvE0tg1BQrgj+7iuwAvlOBbIbhkmnWMkA4s02QWxK1eMXs3dv81A3HBkdVWB+PjYzgGMaL
	vAIFqDZDoV+D+MGCCUj9UjkXU6CesH4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-455-StUXcFuuPmmzT9xK8Vahaw-1; Tue,
 18 Jun 2024 12:05:37 -0400
X-MC-Unique: StUXcFuuPmmzT9xK8Vahaw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 540C119560AB
	for <gfs2@lists.linux.dev>; Tue, 18 Jun 2024 16:05:36 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.40])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 572A619560AE;
	Tue, 18 Jun 2024 16:05:35 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 11/13] gfs2: Get rid of some unnecessary quota locking
Date: Tue, 18 Jun 2024 18:05:15 +0200
Message-ID: <20240618160517.901589-12-agruenba@redhat.com>
In-Reply-To: <20240618160517.901589-1-agruenba@redhat.com>
References: <20240618160517.901589-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

With the locking the previous patch has introduced for each struct
gfs2_quota_data object, sd_quota_mutex has become largely irrelevant.
By waiting on the buffer head instead of waiting on the mutex in
get_bh(), it becomes completely irrelevant and can be removed.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/incore.h     |  1 -
 fs/gfs2/ops_fstype.c |  1 -
 fs/gfs2/quota.c      | 55 +++++++++++++++++++++++---------------------
 3 files changed, 29 insertions(+), 28 deletions(-)

diff --git a/fs/gfs2/incore.h b/fs/gfs2/incore.h
index 90fd2584357a..aa4ef67a34e0 100644
--- a/fs/gfs2/incore.h
+++ b/fs/gfs2/incore.h
@@ -782,7 +782,6 @@ struct gfs2_sbd {
 
 	struct list_head sd_quota_list;
 	atomic_t sd_quota_count;
-	struct mutex sd_quota_mutex;
 	struct mutex sd_quota_sync_mutex;
 	wait_queue_head_t sd_quota_wait;
 
diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index 0561edd6cc86..ff1f3e3dc65c 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -103,7 +103,6 @@ static struct gfs2_sbd *init_sbd(struct super_block *sb)
 	init_completion(&sdp->sd_journal_ready);
 
 	INIT_LIST_HEAD(&sdp->sd_quota_list);
-	mutex_init(&sdp->sd_quota_mutex);
 	mutex_init(&sdp->sd_quota_sync_mutex);
 	init_waitqueue_head(&sdp->sd_quota_wait);
 	spin_lock_init(&sdp->sd_bitmap_lock);
diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
index 283c6ff21911..2490117afb96 100644
--- a/fs/gfs2/quota.c
+++ b/fs/gfs2/quota.c
@@ -397,16 +397,17 @@ static int bh_get(struct gfs2_quota_data *qd)
 	struct inode *inode = sdp->sd_qc_inode;
 	struct gfs2_inode *ip = GFS2_I(inode);
 	unsigned int block, offset;
-	struct buffer_head *bh;
+	struct buffer_head *bh = NULL;
 	struct iomap iomap = { };
 	int error;
 
-	mutex_lock(&sdp->sd_quota_mutex);
-
-	if (qd->qd_bh_count++) {
-		mutex_unlock(&sdp->sd_quota_mutex);
+	spin_lock(&qd->qd_lockref.lock);
+	if (qd->qd_bh_count) {
+		qd->qd_bh_count++;
+		spin_unlock(&qd->qd_lockref.lock);
 		return 0;
 	}
+	spin_unlock(&qd->qd_lockref.lock);
 
 	block = qd->qd_slot / sdp->sd_qc_per_block;
 	offset = qd->qd_slot % sdp->sd_qc_per_block;
@@ -415,48 +416,52 @@ static int bh_get(struct gfs2_quota_data *qd)
 			       (loff_t)block << inode->i_blkbits,
 			       i_blocksize(inode), &iomap);
 	if (error)
-		goto fail;
+		return error;
 	error = -ENOENT;
 	if (iomap.type != IOMAP_MAPPED)
-		goto fail;
+		return error;
 
 	error = gfs2_meta_read(ip->i_gl, iomap.addr >> inode->i_blkbits,
 			       DIO_WAIT, 0, &bh);
 	if (error)
-		goto fail;
+		return error;
 	error = -EIO;
 	if (gfs2_metatype_check(sdp, bh, GFS2_METATYPE_QC))
-		goto fail_brelse;
-
-	qd->qd_bh = bh;
-	qd->qd_bh_qc = (struct gfs2_quota_change *)
-		(bh->b_data + sizeof(struct gfs2_meta_header) +
-		 offset * sizeof(struct gfs2_quota_change));
-
-	mutex_unlock(&sdp->sd_quota_mutex);
+		goto out;
 
-	return 0;
+	spin_lock(&qd->qd_lockref.lock);
+	if (qd->qd_bh == NULL) {
+		qd->qd_bh = bh;
+		qd->qd_bh_qc = (struct gfs2_quota_change *)
+			(bh->b_data + sizeof(struct gfs2_meta_header) +
+			 offset * sizeof(struct gfs2_quota_change));
+		bh = NULL;
+	}
+	qd->qd_bh_count++;
+	spin_unlock(&qd->qd_lockref.lock);
+	error = 0;
 
-fail_brelse:
+out:
 	brelse(bh);
-fail:
-	qd->qd_bh_count--;
-	mutex_unlock(&sdp->sd_quota_mutex);
 	return error;
 }
 
 static void bh_put(struct gfs2_quota_data *qd)
 {
 	struct gfs2_sbd *sdp = qd->qd_sbd;
+	struct buffer_head *bh = NULL;
 
-	mutex_lock(&sdp->sd_quota_mutex);
+	spin_lock(&qd->qd_lockref.lock);
 	gfs2_assert(sdp, qd->qd_bh_count);
 	if (!--qd->qd_bh_count) {
-		brelse(qd->qd_bh);
+		bh = qd->qd_bh;
 		qd->qd_bh = NULL;
 		qd->qd_bh_qc = NULL;
 	}
-	mutex_unlock(&sdp->sd_quota_mutex);
+	spin_unlock(&qd->qd_lockref.lock);
+
+	if (bh)
+		brelse(bh);
 }
 
 static bool qd_grab_sync(struct gfs2_sbd *sdp, struct gfs2_quota_data *qd,
@@ -676,7 +681,6 @@ static void do_qc(struct gfs2_quota_data *qd, s64 change)
 	bool needs_put = false;
 	s64 x;
 
-	mutex_lock(&sdp->sd_quota_mutex);
 	gfs2_trans_add_meta(ip->i_gl, qd->qd_bh);
 
 	/*
@@ -720,7 +724,6 @@ static void do_qc(struct gfs2_quota_data *qd, s64 change)
 	}
 	if (change < 0) /* Reset quiet flag if we freed some blocks */
 		clear_bit(QDF_QMSG_QUIET, &qd->qd_flags);
-	mutex_unlock(&sdp->sd_quota_mutex);
 }
 
 static int gfs2_write_buf_to_page(struct gfs2_sbd *sdp, unsigned long index,
-- 
2.45.1

