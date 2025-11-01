Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5540E7E105
	for <gfs2@lists.linux.dev>; Sat,  1 Nov 2025 00:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761956597; cv=none; b=L0HvCao7+GrknLDUHVsxiE93oKduQjTTCSQ6gvR4+l5vwm6iRrLW3JRt1jq7FKgVa9rcbrhT2P1bVzGeAPz7A5tTsdeK3ZdUpkRNitOTzVo7ydv5w5pSBbvw+ZRrL29Yk+biXfJAh2Udyv+L/1l0kPY9BUavIoPni4Sxm+vTDI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761956597; c=relaxed/simple;
	bh=Qrpf1YIbwmE2XKX97lnaNLdIZo8AS9erXmwaWeicPJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=T6+g5GOmjcyq0pAJoiQ7Sdh2UinQjDiKvrjlsv57c9z664aSbtRUO1nnSikv1pcRT0kaNLHlSBZ7SaFGPTWjEEcCmGJtgGg7o8REdjnAPP9xqzsAtU7kGENtGmM/xzyPbN9Ks4scKLberfU0PTKZ0NVZR4QjeJd01qxng+V/oK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ODTIOG8x; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ODTIOG8x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761956595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nMndbCCxZJJ7sGL3VG68/lzWcLpPiJLhzNS9hxXdDSE=;
	b=ODTIOG8xgXrjxAjyR2+o4v1q6yxuGtm3JuyGuyD33OpcB+taTzr6yArzqAauEsM9p43KLg
	6Ti4CeSciu+VQp0uRJSRGDN0L+QY8a5wWNFVLTu23oHcSwpiKkKdLX1byGXUhSytxBVEdl
	LeWQsmADUPs/di3dxKemJwXrclBSfA4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-311-MnqQuwbrO9-BAQPoZM1dVg-1; Fri,
 31 Oct 2025 20:23:14 -0400
X-MC-Unique: MnqQuwbrO9-BAQPoZM1dVg-1
X-Mimecast-MFC-AGG-ID: MnqQuwbrO9-BAQPoZM1dVg_1761956593
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5A75A1800637
	for <gfs2@lists.linux.dev>; Sat,  1 Nov 2025 00:23:13 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.12])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4FFA91800583;
	Sat,  1 Nov 2025 00:23:12 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 23/24] gfs2: No longer thaw filesystems during a withdraw
Date: Sat,  1 Nov 2025 00:22:32 +0000
Message-ID: <20251101002234.1286383-24-agruenba@redhat.com>
In-Reply-To: <20251101002234.1286383-1-agruenba@redhat.com>
References: <20251101002234.1286383-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hO05u_4NmrboytROddi4iV-odQxutq0vryfY-O0kzfA_1761956593
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Previously, when a withdraw occurred, we would wait for another node to
recover our journal.  This also meant that frozen filesystem needed to
be thawed because otherwise, other nodes wouldn't be able to recover the
filesystem.  With the reversal of commit 601ef0d52e96 ("gfs2: Force
withdraw to replay journals and wait for it to finish"), we are no
longer waiting for journal recovery during a withdraw, so we no longer
need to thaw frozen filesystems, either.  This also fixes a potential
deadlock reported by lockdep when running xfstest generic/108.

In addition, there is nothing left in do_withdraw() that would require
taking sd_freeze_mutex, so don't bother taking that lock there anymore.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/super.c | 14 --------------
 fs/gfs2/super.h |  1 -
 fs/gfs2/util.c  |  7 -------
 3 files changed, 22 deletions(-)

diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index 5b5d25e79d37..cfcd02096f93 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -819,20 +819,6 @@ static int gfs2_thaw_super(struct super_block *sb, enum freeze_holder who,
 	return error;
 }
 
-void gfs2_thaw_freeze_initiator(struct super_block *sb)
-{
-	struct gfs2_sbd *sdp = sb->s_fs_info;
-
-	mutex_lock(&sdp->sd_freeze_mutex);
-	if (!test_bit(SDF_FREEZE_INITIATOR, &sdp->sd_flags))
-		goto out;
-
-	gfs2_freeze_unlock(sdp);
-
-out:
-	mutex_unlock(&sdp->sd_freeze_mutex);
-}
-
 /**
  * statfs_slow_fill - fill in the sg for a given RG
  * @rgd: the RG
diff --git a/fs/gfs2/super.h b/fs/gfs2/super.h
index b27a774d9580..173f1e74c2a9 100644
--- a/fs/gfs2/super.h
+++ b/fs/gfs2/super.h
@@ -47,7 +47,6 @@ void gfs2_statfs_change_out(const struct gfs2_statfs_change_host *sc,
 void update_statfs(struct gfs2_sbd *sdp, struct buffer_head *m_bh);
 int gfs2_statfs_sync(struct super_block *sb, int type);
 void gfs2_freeze_func(struct work_struct *work);
-void gfs2_thaw_freeze_initiator(struct super_block *sb);
 
 void free_local_statfs_inodes(struct gfs2_sbd *sdp);
 struct inode *find_local_statfs_inode(struct gfs2_sbd *sdp,
diff --git a/fs/gfs2/util.c b/fs/gfs2/util.c
index ff63070ed6de..b8ce04338b24 100644
--- a/fs/gfs2/util.c
+++ b/fs/gfs2/util.c
@@ -131,8 +131,6 @@ static void do_withdraw(struct gfs2_sbd *sdp)
 	 */
 	clear_bit(SDF_JOURNAL_LIVE, &sdp->sd_flags);
 	if (!sb_rdonly(sdp->sd_vfs)) {
-		bool locked = mutex_trylock(&sdp->sd_freeze_mutex);
-
 		wake_up(&sdp->sd_logd_waitq);
 		wake_up(&sdp->sd_quota_wait);
 
@@ -142,17 +140,12 @@ static void do_withdraw(struct gfs2_sbd *sdp)
 
 		sdp->sd_vfs->s_flags |= SB_RDONLY;
 
-		if (locked)
-			mutex_unlock(&sdp->sd_freeze_mutex);
-
 		/*
 		 * Dequeue any pending non-system glock holders that can no
 		 * longer be granted because the file system is withdrawn.
 		 */
 		gfs2_withdraw_glocks(sdp);
 	}
-
-	gfs2_thaw_freeze_initiator(sdp->sd_vfs);
 }
 
 void gfs2_lm(struct gfs2_sbd *sdp, const char *fmt, ...)
-- 
2.51.0

