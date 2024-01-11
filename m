Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E59537E3
	for <gfs2@lists.linux.dev>; Thu, 11 Jan 2024 17:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FluzjAo/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704994989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=L7VhQxQ4mOfgWFwz5amuPbUAz5yPvUpv/Y7+UwLm9Xs=;
	b=FluzjAo/riTUvMtcQB15QqF30TQa7iV0hIbM/NOdLAWdmiHiJq5YSV1W7NSylO+jziH1rU
	g41zUCIJPbTT2sh5Ci/xCNknLAhBSV3BaD2cbRyTLPMC/tLqy7pniWtdfmKmzJFihG80s4
	dUF1qudy5275S8dKXy8KfSz29k3eE0E=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-9JvCWhpYMWe0e3m1Q79HsA-1; Thu,
 11 Jan 2024 12:43:02 -0500
X-MC-Unique: 9JvCWhpYMWe0e3m1Q79HsA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 70DE7381CB69
	for <gfs2@lists.linux.dev>; Thu, 11 Jan 2024 17:43:02 +0000 (UTC)
Received: from b.redhat.com (unknown [10.42.28.186])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 377B13C25;
	Thu, 11 Jan 2024 17:43:00 +0000 (UTC)
From: Andrew Price <anprice@redhat.com>
To: agruenba@redhat.com
Cc: gfs2@lists.linux.dev
Subject: [PATCH] gfs2: Improve gfs2_consist_inode() usage
Date: Thu, 11 Jan 2024 17:42:58 +0000
Message-ID: <20240111174258.72123-1-anprice@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

gfs2_consist_inode() logs an error message with the source file and line
number. When we jump before calling it, the line number becomes less
useful as it no longer relates to the source of the error. To aid
troubleshooting, replace the gotos with the gfs2_consist_inode() calls
so that the error messages are more informative.

Signed-off-by: Andrew Price <anprice@redhat.com>
---
 fs/gfs2/dir.c   | 28 +++++++++++++++++-----------
 fs/gfs2/glops.c | 34 ++++++++++++++++++++--------------
 fs/gfs2/xattr.c | 28 ++++++++++++++++------------
 3 files changed, 53 insertions(+), 37 deletions(-)

diff --git a/fs/gfs2/dir.c b/fs/gfs2/dir.c
index 560e4624c09f2..47355c87efc3b 100644
--- a/fs/gfs2/dir.c
+++ b/fs/gfs2/dir.c
@@ -562,15 +562,18 @@ static struct gfs2_dirent *gfs2_dirent_scan(struct inode *inode, void *buf,
 	int ret = 0;
 
 	ret = gfs2_dirent_offset(GFS2_SB(inode), buf);
-	if (ret < 0)
-		goto consist_inode;
-
+	if (ret < 0) {
+		gfs2_consist_inode(GFS2_I(inode));
+		return ERR_PTR(-EIO);
+	}
 	offset = ret;
 	prev = NULL;
 	dent = buf + offset;
 	size = be16_to_cpu(dent->de_rec_len);
-	if (gfs2_check_dirent(GFS2_SB(inode), dent, offset, size, len, 1))
-		goto consist_inode;
+	if (gfs2_check_dirent(GFS2_SB(inode), dent, offset, size, len, 1)) {
+		gfs2_consist_inode(GFS2_I(inode));
+		return ERR_PTR(-EIO);
+	}
 	do {
 		ret = scan(dent, name, opaque);
 		if (ret)
@@ -582,8 +585,10 @@ static struct gfs2_dirent *gfs2_dirent_scan(struct inode *inode, void *buf,
 		dent = buf + offset;
 		size = be16_to_cpu(dent->de_rec_len);
 		if (gfs2_check_dirent(GFS2_SB(inode), dent, offset, size,
-				      len, 0))
-			goto consist_inode;
+				      len, 0)) {
+			gfs2_consist_inode(GFS2_I(inode));
+			return ERR_PTR(-EIO);
+		}
 	} while(1);
 
 	switch(ret) {
@@ -598,7 +603,6 @@ static struct gfs2_dirent *gfs2_dirent_scan(struct inode *inode, void *buf,
 		return ERR_PTR(ret);
 	}
 
-consist_inode:
 	gfs2_consist_inode(GFS2_I(inode));
 	return ERR_PTR(-EIO);
 }
@@ -609,14 +613,16 @@ static int dirent_check_reclen(struct gfs2_inode *dip,
 	const void *ptr = d;
 	u16 rec_len = be16_to_cpu(d->de_rec_len);
 
-	if (unlikely(rec_len < sizeof(struct gfs2_dirent)))
-		goto broken;
+	if (unlikely(rec_len < sizeof(struct gfs2_dirent))) {
+		gfs2_consist_inode(dip);
+		return -EIO;
+	}
 	ptr += rec_len;
 	if (ptr < end_p)
 		return rec_len;
 	if (ptr == end_p)
 		return -ENOENT;
-broken:
+
 	gfs2_consist_inode(dip);
 	return -EIO;
 }
diff --git a/fs/gfs2/glops.c b/fs/gfs2/glops.c
index 45653cbc8a87d..ae8d4731907d1 100644
--- a/fs/gfs2/glops.c
+++ b/fs/gfs2/glops.c
@@ -409,10 +409,14 @@ static int gfs2_dinode_in(struct gfs2_inode *ip, const void *buf)
 	struct inode *inode = &ip->i_inode;
 	bool is_new = inode->i_state & I_NEW;
 
-	if (unlikely(ip->i_no_addr != be64_to_cpu(str->di_num.no_addr)))
-		goto corrupt;
-	if (unlikely(!is_new && inode_wrong_type(inode, mode)))
-		goto corrupt;
+	if (unlikely(ip->i_no_addr != be64_to_cpu(str->di_num.no_addr))) {
+		gfs2_consist_inode(ip);
+		return -EIO;
+	}
+	if (unlikely(!is_new && inode_wrong_type(inode, mode))) {
+		gfs2_consist_inode(ip);
+		return -EIO;
+	}
 	ip->i_no_formal_ino = be64_to_cpu(str->di_num.no_formal_ino);
 	inode->i_mode = mode;
 	if (is_new) {
@@ -449,26 +453,28 @@ static int gfs2_dinode_in(struct gfs2_inode *ip, const void *buf)
 	/* i_diskflags and i_eattr must be set before gfs2_set_inode_flags() */
 	gfs2_set_inode_flags(inode);
 	height = be16_to_cpu(str->di_height);
-	if (unlikely(height > sdp->sd_max_height))
-		goto corrupt;
+	if (unlikely(height > sdp->sd_max_height)) {
+		gfs2_consist_inode(ip);
+		return -EIO;
+	}
 	ip->i_height = (u8)height;
 
 	depth = be16_to_cpu(str->di_depth);
-	if (unlikely(depth > GFS2_DIR_MAX_DEPTH))
-		goto corrupt;
+	if (unlikely(depth > GFS2_DIR_MAX_DEPTH)) {
+		gfs2_consist_inode(ip);
+		return -EIO;
+	}
 	ip->i_depth = (u8)depth;
 	ip->i_entries = be32_to_cpu(str->di_entries);
 
-	if (gfs2_is_stuffed(ip) && inode->i_size > gfs2_max_stuffed_size(ip))
-		goto corrupt;
-
+	if (gfs2_is_stuffed(ip) && inode->i_size > gfs2_max_stuffed_size(ip)) {
+		gfs2_consist_inode(ip);
+		return -EIO;
+	}
 	if (S_ISREG(inode->i_mode))
 		gfs2_set_aops(inode);
 
 	return 0;
-corrupt:
-	gfs2_consist_inode(ip);
-	return -EIO;
 }
 
 /**
diff --git a/fs/gfs2/xattr.c b/fs/gfs2/xattr.c
index 8c96ba6230d1b..17ae5070a90e6 100644
--- a/fs/gfs2/xattr.c
+++ b/fs/gfs2/xattr.c
@@ -96,30 +96,34 @@ static int ea_foreach_i(struct gfs2_inode *ip, struct buffer_head *bh,
 		return -EIO;
 
 	for (ea = GFS2_EA_BH2FIRST(bh);; prev = ea, ea = GFS2_EA2NEXT(ea)) {
-		if (!GFS2_EA_REC_LEN(ea))
-			goto fail;
+		if (!GFS2_EA_REC_LEN(ea)) {
+			gfs2_consist_inode(ip);
+			return -EIO;
+		}
 		if (!(bh->b_data <= (char *)ea && (char *)GFS2_EA2NEXT(ea) <=
-						  bh->b_data + bh->b_size))
-			goto fail;
-		if (!gfs2_eatype_valid(sdp, ea->ea_type))
-			goto fail;
+						  bh->b_data + bh->b_size)) {
+			gfs2_consist_inode(ip);
+			return -EIO;
+		}
+		if (!gfs2_eatype_valid(sdp, ea->ea_type)) {
+			gfs2_consist_inode(ip);
+			return -EIO;
+		}
 		error = ea_call(ip, bh, ea, prev, data);
 		if (error)
 			return error;
 
 		if (GFS2_EA_IS_LAST(ea)) {
 			if ((char *)GFS2_EA2NEXT(ea) !=
-			    bh->b_data + bh->b_size)
-				goto fail;
+			    bh->b_data + bh->b_size) {
+				gfs2_consist_inode(ip);
+				return -EIO;
+			}
 			break;
 		}
 	}
 
 	return error;
-
-fail:
-	gfs2_consist_inode(ip);
-	return -EIO;
 }
 
 static int ea_foreach(struct gfs2_inode *ip, ea_call_t ea_call, void *data)
-- 
2.43.0

