Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8F57EF
	for <gfs2@lists.linux.dev>; Fri, 19 Jan 2024 21:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705699267; cv=none; b=n9b0r6t7wa3FfBQcXjDGAHtopPpaK2QpW9DRIfFY99nBTzkkDUqI0in6BXxVOpNyttHOMwl7t8EGFF8E5KKhJZ/3ok4shKdjqPwgP4YMXQDS/B3XwzSUiJtIlzVZao5DaA8Qwe6Sh8EX94c4urg6hKObrqRqB0UEnzrDsljAzAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705699267; c=relaxed/simple;
	bh=7Sbqe6b/zinw3WrIBZi6sq0UYts96BAKfrzQmmIpyI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nsUNFnT92Nd6RHKF+PaSsqHn8dbmzuMb4U9ZakGOExXz7f+9N18iwZtKwZP6WSruTNVXP01yaXm9rZMxEfdKXsFG2h/jr11q6m0dAZlarrBwCjt9lEERks6KJtTlft0Cn/gDEW4vb07qPHeU8pbJ4CJWD2dHTaD1b/kUxa1IBco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XQ+V4rqA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XQ+V4rqA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705699265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FzzfEOIK8iH1/CydClrtZRckTtdAu17KiryYR02Lwp8=;
	b=XQ+V4rqAhayIfz+nR0DR3tV3Aoza50nbkTFP+8J81Jd5cHLQ4H9pFc6S4CzDpZCps0BtsJ
	SWJSMsbiaZKRbMapJZ5Tzm40bI3kJesQnDL1jocDYivuIoEPfCeBoO869VDuWPVgmWXhAN
	Ap5oX5NzKVLomw2+QaMO7ZXLL+kBeTI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-Rfp8O-pbOYaRupwCRBlOIg-1; Fri, 19 Jan 2024 16:21:02 -0500
X-MC-Unique: Rfp8O-pbOYaRupwCRBlOIg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9E94B83B82D;
	Fri, 19 Jan 2024 21:21:02 +0000 (UTC)
Received: from pasta.redhat.com (unknown [10.45.226.46])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 07FFE40D1B60;
	Fri, 19 Jan 2024 21:21:01 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 6/9] gfs2: Pass FGP flags to gfs2_dirent_search
Date: Fri, 19 Jan 2024 22:20:53 +0100
Message-ID: <20240119212056.805617-7-agruenba@redhat.com>
In-Reply-To: <20240119212056.805617-1-agruenba@redhat.com>
References: <20240119212056.805617-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Add an fgp_flags argument to gfs2_dirent_search().  When the FGP_NOWAIT
flag is set and gfs2_dirent_search() would sleep, -EAGAIN is returned
instead.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/dir.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/fs/gfs2/dir.c b/fs/gfs2/dir.c
index 8719c8316e28..81d1ea61f44f 100644
--- a/fs/gfs2/dir.c
+++ b/fs/gfs2/dir.c
@@ -805,6 +805,7 @@ static int get_first_leaf(struct gfs2_inode *dip, u32 index,
 static struct gfs2_dirent *gfs2_dirent_search(struct inode *inode,
 					      const struct qstr *name,
 					      gfs2_dscan_t scan,
+					      fgf_t fgp_flags,
 					      struct buffer_head **pbh)
 {
 	struct buffer_head *bh;
@@ -817,6 +818,11 @@ static struct gfs2_dirent *gfs2_dirent_search(struct inode *inode,
 		unsigned int hsize = BIT(ip->i_depth);
 		unsigned int index;
 		u64 ln;
+
+		/* no lockless lookup inside ExHash directories */
+		if (fgp_flags & FGP_NOWAIT)
+			return ERR_PTR(-EAGAIN);
+
 		if (hsize * sizeof(u64) != i_size_read(inode)) {
 			gfs2_consist_inode(ip);
 			return ERR_PTR(-EIO);
@@ -843,8 +849,7 @@ static struct gfs2_dirent *gfs2_dirent_search(struct inode *inode,
 		return error ? ERR_PTR(error) : NULL;
 	}
 
-
-	error = gfs2_meta_inode_buffer(ip, 0, &bh);
+	error = gfs2_meta_inode_buffer(ip, fgp_flags, &bh);
 	if (error)
 		return ERR_PTR(error);
 	dent = gfs2_dirent_scan(inode, bh->b_data, bh->b_size, scan, name, NULL);
@@ -1647,7 +1652,7 @@ struct inode *gfs2_dir_search(struct inode *dir, const struct qstr *name,
 	u64 addr, formal_ino;
 	u16 dtype;
 
-	dent = gfs2_dirent_search(dir, name, gfs2_dirent_find, &bh);
+	dent = gfs2_dirent_search(dir, name, gfs2_dirent_find, 0, &bh);
 	if (dent) {
 		struct inode *inode;
 		u16 rahead;
@@ -1677,7 +1682,7 @@ int gfs2_dir_check(struct inode *dir, const struct qstr *name,
 	struct gfs2_dirent *dent;
 	int ret = -ENOENT;
 
-	dent = gfs2_dirent_search(dir, name, gfs2_dirent_find, &bh);
+	dent = gfs2_dirent_search(dir, name, gfs2_dirent_find, 0, &bh);
 	if (dent) {
 		if (IS_ERR(dent))
 			return PTR_ERR(dent);
@@ -1805,7 +1810,8 @@ int gfs2_dir_add(struct inode *inode, const struct qstr *name,
 	while(1) {
 		if (da->bh == NULL) {
 			dent = gfs2_dirent_search(inode, name,
-						  gfs2_dirent_find_space, &bh);
+						  gfs2_dirent_find_space, 0,
+						  &bh);
 		}
 		if (dent) {
 			if (IS_ERR(dent))
@@ -1880,7 +1886,8 @@ int gfs2_dir_del(struct gfs2_inode *dip, const struct dentry *dentry)
 
 	/* Returns _either_ the entry (if its first in block) or the
 	   previous entry otherwise */
-	dent = gfs2_dirent_search(&dip->i_inode, name, gfs2_dirent_prev, &bh);
+	dent = gfs2_dirent_search(&dip->i_inode, name, gfs2_dirent_prev, 0,
+				  &bh);
 	if (!dent) {
 		gfs2_consist_inode(dip);
 		return -EIO;
@@ -1939,7 +1946,8 @@ int gfs2_dir_mvino(struct gfs2_inode *dip, const struct qstr *filename,
 	struct buffer_head *bh;
 	struct gfs2_dirent *dent;
 
-	dent = gfs2_dirent_search(&dip->i_inode, filename, gfs2_dirent_find, &bh);
+	dent = gfs2_dirent_search(&dip->i_inode, filename, gfs2_dirent_find, 0,
+				  &bh);
 	if (!dent) {
 		gfs2_consist_inode(dip);
 		return -EIO;
@@ -2166,7 +2174,7 @@ int gfs2_diradd_alloc_required(struct inode *inode, const struct qstr *name,
 	da->bh = NULL;
 	da->dent = NULL;
 
-	dent = gfs2_dirent_search(inode, name, gfs2_dirent_find_space, &bh);
+	dent = gfs2_dirent_search(inode, name, gfs2_dirent_find_space, 0, &bh);
 	if (!dent) {
 		da->nr_blocks = sdp->sd_max_dirres;
 		if (!(ip->i_diskflags & GFS2_DIF_EXHASH) &&
-- 
2.43.0

