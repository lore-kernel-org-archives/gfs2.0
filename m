Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF37531600
	for <gfs2@lists.linux.dev>; Tue, 22 Sep 2026 10:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790072879; cv=none; b=kzQE9hZO9jQAyPfG9NC7RiTRCk+uXna9+RwUNptSaRqyxVP3cdbCPPxHXIihssKOJvWLnxNHJz0uXVagIEfv2gKaaaXc3I6/IlKoTVuJNnzyWPel62XTC206TT3lPXgcC9Y/ixxNtVNQZnsXC+bhK3OEEuzPd4esMfxtquxx8RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790072879; c=relaxed/simple;
	bh=fm6/8YZBXjry/bEZ6PcMul9wyNDBYQXICZYH/zPw3HU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=YvhqoeDmlw0gVh/0i9jZkd0PoakHoWZ1HpF0qI2VPmWyW3Go6xUHE5NGU/2IbZKq2TjjWEiVQrSWUnaV0n20bZHXTGeoNJfvIGZ4Y1pDiQSOBTwc7WyfbPbBPsZMgDTnnm2P2zFZtZvN/W6pn3pPZIQT7VyzZadtTKs1ADUUQTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hLnzeK7N; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hLnzeK7N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790072876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6dRlcogDFnnw5ZddM5Q1WvilNHUEBgumSyfQmnJqhzg=;
	b=hLnzeK7Nr2r0k3CSE7cGzoQZnicX8tL1yc3mS+QCixIjhYuL+v8JMkecZxsJl2hJwd+CMH
	/3I5ozWXcv0XP2f2Kvfz+PdDpBecfVwhLDg5WL9KjUvC/ttre3A8EMOmYznKaweI7dqYr5
	hKwiqYMlAWdDFhKwhOXqXwjrNIHzKYw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-582-dM-HID03MOa3jjWFtprZNw-1; Tue,
 22 Sep 2026 06:27:53 -0400
X-MC-Unique: dM-HID03MOa3jjWFtprZNw-1
X-Mimecast-MFC-AGG-ID: dM-HID03MOa3jjWFtprZNw_1790072872
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 723B5193E884;
	Tue, 22 Sep 2026 10:27:52 +0000 (UTC)
Received: from pasta.redhat.com (unknown [10.44.48.10])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 06C3A1800348;
	Tue, 22 Sep 2026 10:27:50 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	NeilBrown <neil@brown.name>
Subject: [PATCH] gfs2: gfs2_create_inode excl cleanup
Date: Tue, 22 Sep 2026 12:27:49 +0200
Message-ID: <20260922102749.1610267-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: srg-J6miqBOKnbaghbajuZdt8gviizKoxLc2kh9xImw_1790072872
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Function gfs2_create_inode() is used for creating different types of
inodes.  Regular inodes can be created exclusively or non-exclusively,
while all other inode types are always created exclusively.

Right now, gfs2_create_inode() checks the inode type to determine when
creates should be exclusive; the excl argument is only set for regular
files.  Change that to set the excl argument correctly for all inode
types; this saves the inode type check in gfs2_create_inode().

Suggested-by: NeilBrown <neil@brown.name>
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/inode.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index 2ec848b993d0..f748f8b3c73a 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -740,7 +740,7 @@ static int gfs2_create_inode(struct inode *dir, struct dentry *dentry,
 	if (error)
 		goto fail_gunlock;
 
-	inode = gfs2_dir_search(dir, &dentry->d_name, !S_ISREG(mode) || excl);
+	inode = gfs2_dir_search(dir, &dentry->d_name, excl);
 	error = PTR_ERR(inode);
 	if (!IS_ERR(inode)) {
 		if (file && (file->f_flags & __O_REGULAR) &&
@@ -1338,7 +1338,7 @@ static int gfs2_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	if (size >= gfs2_max_stuffed_size(GFS2_I(dir)))
 		return -ENAMETOOLONG;
 
-	return gfs2_create_inode(dir, dentry, NULL, S_IFLNK | S_IRWXUGO, 0, symname, size, 0);
+	return gfs2_create_inode(dir, dentry, NULL, S_IFLNK | S_IRWXUGO, 0, symname, size, 1);
 }
 
 /**
@@ -1356,7 +1356,7 @@ static struct dentry *gfs2_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 {
 	unsigned dsize = gfs2_max_stuffed_size(GFS2_I(dir));
 
-	return ERR_PTR(gfs2_create_inode(dir, dentry, NULL, mode, 0, NULL, dsize, 0));
+	return ERR_PTR(gfs2_create_inode(dir, dentry, NULL, mode, 0, NULL, dsize, 1));
 }
 
 /**
@@ -1372,7 +1372,7 @@ static struct dentry *gfs2_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 static int gfs2_mknod(struct mnt_idmap *idmap, struct inode *dir,
 		      struct dentry *dentry, umode_t mode, dev_t dev)
 {
-	return gfs2_create_inode(dir, dentry, NULL, mode, dev, NULL, 0, 0);
+	return gfs2_create_inode(dir, dentry, NULL, mode, dev, NULL, 0, 1);
 }
 
 /**
-- 
2.55.0

