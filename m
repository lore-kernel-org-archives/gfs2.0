Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0726815E80
	for <gfs2@lists.linux.dev>; Wed,  1 Nov 2023 16:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R3ycpqzd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698857195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/Mszvu7PZu3S4eQZ0GqfN9Z4Kv8hH6/tY/ncOX/5H5I=;
	b=R3ycpqzdl1LmVxu3JpTylDONDacXWdUM7CyKqtbQyrrv5NfqNJNwvGUnSp9wLU05Y7lbV/
	Bl0+L2s0btReccOj92UKJAj0+2GinA4PKIb4x57UPMOUCqs1LXpn3L+md+fRjoj8fm5XF+
	BVvT62tJz9HWU3vuvpI7Zcyz41XEOwk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-VwGrAaMSNZeUggNkuU6ExA-1; Wed, 01 Nov 2023 12:46:34 -0400
X-MC-Unique: VwGrAaMSNZeUggNkuU6ExA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C234C811E86
	for <gfs2@lists.linux.dev>; Wed,  1 Nov 2023 16:46:33 +0000 (UTC)
Received: from pasta.redhat.com (unknown [10.45.224.27])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 416E640C6EBF;
	Wed,  1 Nov 2023 16:46:33 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 21/25] gfs2: Rename gfs2_lookup_{ simple => meta }
Date: Wed,  1 Nov 2023 17:46:11 +0100
Message-ID: <20231101164615.1138692-22-agruenba@redhat.com>
In-Reply-To: <20231101164615.1138692-1-agruenba@redhat.com>
References: <20231101164615.1138692-1-agruenba@redhat.com>
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

Function gfs2_lookup_simple() is used for looking up inodes in the
metadata directory tree, so rename it to gfs2_lookup_meta() to closer
match its purpose.  Clean the function up a little on the way.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/inode.c      | 13 +++++++------
 fs/gfs2/inode.h      |  2 +-
 fs/gfs2/ops_fstype.c | 16 ++++++++--------
 3 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index 54b449cd6201..79e96130ef9e 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -265,17 +265,18 @@ struct inode *gfs2_lookup_by_inum(struct gfs2_sbd *sdp, u64 no_addr,
 }
 
 
-struct inode *gfs2_lookup_simple(struct inode *dip, const char *name)
+/**
+ * gfs2_lookup_meta - Look up an inode in a metadata directory
+ * @dip: The directory
+ * @name: The name of the inode
+ */
+struct inode *gfs2_lookup_meta(struct inode *dip, const char *name)
 {
 	struct qstr qstr;
 	struct inode *inode;
+
 	gfs2_str2qstr(&qstr, name);
 	inode = gfs2_lookupi(dip, &qstr, 1);
-	/* gfs2_lookupi has inconsistent callers: vfs
-	 * related routines expect NULL for no entry found,
-	 * gfs2_lookup_simple callers expect ENOENT
-	 * and do not check for NULL.
-	 */
 	if (IS_ERR_OR_NULL(inode))
 		return inode ? inode : ERR_PTR(-ENOENT);
 
diff --git a/fs/gfs2/inode.h b/fs/gfs2/inode.h
index 041b93367002..aaf3cf420691 100644
--- a/fs/gfs2/inode.h
+++ b/fs/gfs2/inode.h
@@ -99,7 +99,7 @@ extern struct inode *gfs2_lookupi(struct inode *dir, const struct qstr *name,
 				  int is_root);
 extern int gfs2_permission(struct mnt_idmap *idmap,
 			   struct inode *inode, int mask);
-extern struct inode *gfs2_lookup_simple(struct inode *dip, const char *name);
+extern struct inode *gfs2_lookup_meta(struct inode *dip, const char *name);
 extern void gfs2_dinode_out(const struct gfs2_inode *ip, void *buf);
 extern int gfs2_open_common(struct inode *inode, struct file *file);
 extern loff_t gfs2_seek_data(struct file *file, loff_t offset);
diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index ecca978419e8..2fa9baf61c3f 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -647,7 +647,7 @@ static int init_statfs(struct gfs2_sbd *sdp)
 	struct gfs2_jdesc *jd;
 	struct gfs2_inode *ip;
 
-	sdp->sd_statfs_inode = gfs2_lookup_simple(master, "statfs");
+	sdp->sd_statfs_inode = gfs2_lookup_meta(master, "statfs");
 	if (IS_ERR(sdp->sd_statfs_inode)) {
 		error = PTR_ERR(sdp->sd_statfs_inode);
 		fs_err(sdp, "can't read in statfs inode: %d\n", error);
@@ -656,7 +656,7 @@ static int init_statfs(struct gfs2_sbd *sdp)
 	if (sdp->sd_args.ar_spectator)
 		goto out;
 
-	pn = gfs2_lookup_simple(master, "per_node");
+	pn = gfs2_lookup_meta(master, "per_node");
 	if (IS_ERR(pn)) {
 		error = PTR_ERR(pn);
 		fs_err(sdp, "can't find per_node directory: %d\n", error);
@@ -673,7 +673,7 @@ static int init_statfs(struct gfs2_sbd *sdp)
 			goto free_local;
 		}
 		sprintf(buf, "statfs_change%u", jd->jd_jid);
-		lsi->si_sc_inode = gfs2_lookup_simple(pn, buf);
+		lsi->si_sc_inode = gfs2_lookup_meta(pn, buf);
 		if (IS_ERR(lsi->si_sc_inode)) {
 			error = PTR_ERR(lsi->si_sc_inode);
 			fs_err(sdp, "can't find local \"sc\" file#%u: %d\n",
@@ -738,7 +738,7 @@ static int init_journal(struct gfs2_sbd *sdp, int undo)
 	if (undo)
 		goto fail_statfs;
 
-	sdp->sd_jindex = gfs2_lookup_simple(master, "jindex");
+	sdp->sd_jindex = gfs2_lookup_meta(master, "jindex");
 	if (IS_ERR(sdp->sd_jindex)) {
 		fs_err(sdp, "can't lookup journal index: %d\n", error);
 		return PTR_ERR(sdp->sd_jindex);
@@ -887,7 +887,7 @@ static int init_inodes(struct gfs2_sbd *sdp, int undo)
 		goto fail;
 
 	/* Read in the resource index inode */
-	sdp->sd_rindex = gfs2_lookup_simple(master, "rindex");
+	sdp->sd_rindex = gfs2_lookup_meta(master, "rindex");
 	if (IS_ERR(sdp->sd_rindex)) {
 		error = PTR_ERR(sdp->sd_rindex);
 		fs_err(sdp, "can't get resource index inode: %d\n", error);
@@ -896,7 +896,7 @@ static int init_inodes(struct gfs2_sbd *sdp, int undo)
 	sdp->sd_rindex_uptodate = 0;
 
 	/* Read in the quota inode */
-	sdp->sd_quota_inode = gfs2_lookup_simple(master, "quota");
+	sdp->sd_quota_inode = gfs2_lookup_meta(master, "quota");
 	if (IS_ERR(sdp->sd_quota_inode)) {
 		error = PTR_ERR(sdp->sd_quota_inode);
 		fs_err(sdp, "can't get quota file inode: %d\n", error);
@@ -940,7 +940,7 @@ static int init_per_node(struct gfs2_sbd *sdp, int undo)
 	if (undo)
 		goto fail_qc_gh;
 
-	pn = gfs2_lookup_simple(master, "per_node");
+	pn = gfs2_lookup_meta(master, "per_node");
 	if (IS_ERR(pn)) {
 		error = PTR_ERR(pn);
 		fs_err(sdp, "can't find per_node directory: %d\n", error);
@@ -948,7 +948,7 @@ static int init_per_node(struct gfs2_sbd *sdp, int undo)
 	}
 
 	sprintf(buf, "quota_change%u", sdp->sd_jdesc->jd_jid);
-	sdp->sd_qc_inode = gfs2_lookup_simple(pn, buf);
+	sdp->sd_qc_inode = gfs2_lookup_meta(pn, buf);
 	if (IS_ERR(sdp->sd_qc_inode)) {
 		error = PTR_ERR(sdp->sd_qc_inode);
 		fs_err(sdp, "can't find local \"qc\" file: %d\n", error);
-- 
2.41.0

