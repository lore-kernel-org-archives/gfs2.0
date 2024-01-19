Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F47258104
	for <gfs2@lists.linux.dev>; Fri, 19 Jan 2024 21:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705699270; cv=none; b=JegnTMmizU+qJYpc7XI86MHWKda+ue6sVaWs8c4cAhvjgk93X1tTWpBbvNXzdfFNiKtjanYIJjkG4G9nn3mytHSItnHb/qQWafsC5lnhFsO7F8dY6L92miafsJ07MPgxD0M64GXziI0+27LYrjRJ6/ULlVTgHDZtvEDWCCL8QuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705699270; c=relaxed/simple;
	bh=HhQIhIJuMzodEQSaHa1EStCxBvsQkQhIvf3+R28LQr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EDprxEyZq9Tmiarni5VQNdLLgQy+v68WTVAHGn3Gi9NnFpRm1/ewq6M7f3lDbLPmeMUHlZX2ujB7R+QsV8RCFV2TmegScaqLbwHDO4DovSHztJGR2vIhqhg0NGLyba6YGxNy7k2sgFh7C5Ae9GT1MYCgWIazZeafztg4s8GKLro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i6vWHkhU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i6vWHkhU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705699267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yGYW7pgG2WBXBwNPfCZ6NranQb3S8CyMQ+yjOn58eLA=;
	b=i6vWHkhUDjblUARtcI0kE8SSKB03niAKPKE6feVtLGVDHCt5+hBnvySJXrEORh+csai0wX
	jk1hvU94wdwx5HLFUbGwoT49BgfJuZgb3tXCVuWkr9VJnaNuHrFcUfUiVFx2NvHaibKHyQ
	hscTe2LwaUh8AP++MGwCyGMkg/m2V80=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-3g1rkXVqNDyXPUkAnO82Pg-1; Fri, 19 Jan 2024 16:21:03 -0500
X-MC-Unique: 3g1rkXVqNDyXPUkAnO82Pg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7881D80007C;
	Fri, 19 Jan 2024 21:21:03 +0000 (UTC)
Received: from pasta.redhat.com (unknown [10.45.226.46])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D715F40D1B60;
	Fri, 19 Jan 2024 21:21:02 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 7/9] gfs2: Pass FGP flags to gfs2_dir_check
Date: Fri, 19 Jan 2024 22:20:54 +0100
Message-ID: <20240119212056.805617-8-agruenba@redhat.com>
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

Pass a fgp_flags argument to gfs2_dir_check().  If the FGP_NOWAIT flag
is set and gfs2_dir_check() would sleep, -EAGAIN is returned instead.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/dentry.c     | 2 +-
 fs/gfs2/dir.c        | 4 ++--
 fs/gfs2/dir.h        | 2 +-
 fs/gfs2/inode.c      | 6 +++---
 fs/gfs2/ops_fstype.c | 2 +-
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/gfs2/dentry.c b/fs/gfs2/dentry.c
index c6483fb98624..f179a6d94cbe 100644
--- a/fs/gfs2/dentry.c
+++ b/fs/gfs2/dentry.c
@@ -72,7 +72,7 @@ static int gfs2_drevalidate(struct dentry *dentry, unsigned int flags)
 			goto out;
 	}
 
-	error = gfs2_dir_check(dinode, &dentry->d_name, ip);
+	error = gfs2_dir_check(dinode, &dentry->d_name, ip, 0);
 	valid = inode ? !error : (error == -ENOENT);
 
 	if (!had_lock)
diff --git a/fs/gfs2/dir.c b/fs/gfs2/dir.c
index 81d1ea61f44f..d3a9c9094db0 100644
--- a/fs/gfs2/dir.c
+++ b/fs/gfs2/dir.c
@@ -1676,13 +1676,13 @@ struct inode *gfs2_dir_search(struct inode *dir, const struct qstr *name,
 }
 
 int gfs2_dir_check(struct inode *dir, const struct qstr *name,
-		   const struct gfs2_inode *ip)
+		   const struct gfs2_inode *ip, fgf_t fgp_flags)
 {
 	struct buffer_head *bh;
 	struct gfs2_dirent *dent;
 	int ret = -ENOENT;
 
-	dent = gfs2_dirent_search(dir, name, gfs2_dirent_find, 0, &bh);
+	dent = gfs2_dirent_search(dir, name, gfs2_dirent_find, fgp_flags, &bh);
 	if (dent) {
 		if (IS_ERR(dent))
 			return PTR_ERR(dent);
diff --git a/fs/gfs2/dir.h b/fs/gfs2/dir.h
index 25a857c78b53..cfec869a11c8 100644
--- a/fs/gfs2/dir.h
+++ b/fs/gfs2/dir.h
@@ -27,7 +27,7 @@ struct inode *gfs2_dir_search(struct inode *dir,
 			      const struct qstr *filename,
 			      bool fail_on_exist);
 int gfs2_dir_check(struct inode *dir, const struct qstr *filename,
-		   const struct gfs2_inode *ip);
+		   const struct gfs2_inode *ip, fgf_t fgp_flags);
 int gfs2_dir_add(struct inode *inode, const struct qstr *filename,
 		 const struct gfs2_inode *ip, struct gfs2_diradd *da);
 static inline void gfs2_dir_no_add(struct gfs2_diradd *da)
diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index a417650e378f..948f5c203a38 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -980,7 +980,7 @@ static int gfs2_link(struct dentry *old_dentry, struct inode *dir,
 	if (error)
 		goto out_gunlock;
 
-	error = gfs2_dir_check(dir, &dentry->d_name, NULL);
+	error = gfs2_dir_check(dir, &dentry->d_name, NULL, 0);
 	switch (error) {
 	case -ENOENT:
 		break;
@@ -1096,7 +1096,7 @@ static int gfs2_unlink_ok(struct gfs2_inode *dip, const struct qstr *name,
 	if (error)
 		return error;
 
-	return gfs2_dir_check(&dip->i_inode, name, ip);
+	return gfs2_dir_check(&dip->i_inode, name, ip, 0);
 }
 
 /**
@@ -1522,7 +1522,7 @@ static int gfs2_rename(struct inode *odir, struct dentry *odentry,
 		if (error)
 			goto out_gunlock;
 
-		error = gfs2_dir_check(ndir, &ndentry->d_name, NULL);
+		error = gfs2_dir_check(ndir, &ndentry->d_name, NULL, 0);
 		switch (error) {
 		case -ENOENT:
 			error = 0;
diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index 1a01adb48f5b..f6c80ff618cc 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -584,7 +584,7 @@ static int gfs2_jindex_hold(struct gfs2_sbd *sdp, struct gfs2_holder *ji_gh)
 		name.len = sprintf(buf, "journal%u", sdp->sd_journals);
 		name.hash = gfs2_disk_hash(name.name, name.len);
 
-		error = gfs2_dir_check(sdp->sd_jindex, &name, NULL);
+		error = gfs2_dir_check(sdp->sd_jindex, &name, NULL, 0);
 		if (error == -ENOENT) {
 			error = 0;
 			break;
-- 
2.43.0

