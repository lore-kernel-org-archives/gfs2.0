Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661C9146A93
	for <gfs2@lists.linux.dev>; Wed, 25 Sep 2024 22:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727301845; cv=none; b=Wzep+Gxw8FuP61/MiPg++J9/5xvf6fN4/J6km0IDfxf1m4w/1BdXgRzUNeoh5ulm2aSNf7zzZXKwwMwkoUxwxI8VDNzr/fc2eBfUKJcsI0gMAW0wkrGA3TYdFr6a2XGYIsQSC+LopBhD96A22smGP4apSYYYiNSptTJRbFJCT9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727301845; c=relaxed/simple;
	bh=8lWGar+szQ+YpXybO42ChX5DyXIxbowJ5xwJ7NYGiPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IWVtzY/Xrj1flrHr6Sk9cKnral+4ZyVSnxhUSXQBaflGaMBdYev5qXfsnRB8GfFW547VUpIl50KdMkYgm1NLo/3cLMij3UzGBsYR3v/J3QyiOaREMIguR1NF5o5Aolve+7rzJU0ja3VDujbKlSD1tcrSq4OFZX8vtMmK3giwa4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OzWKCxo8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OzWKCxo8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727301843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CgFWt1OKYlA8awS2fDXJvsQI74vx7YhSY/SbmsmIPVA=;
	b=OzWKCxo83S3EXXGH7vRy4O7RACkdVXeb+Eoqe0QMwsKFvTI68VLBlzU6PndLUpkck/N8Jb
	6xBTwU9N9Y8TQsK2zGSaZ5ZrcixngjHnBK0KnvV3d4/FtT0uEw1OF00LzzSV3YP70R49aB
	rkNBlpJkksewvDw7nsbZ5v75jECYboE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-575-7-0nTESXN862GPqo1e777w-1; Wed,
 25 Sep 2024 18:04:01 -0400
X-MC-Unique: 7-0nTESXN862GPqo1e777w-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 361FD19772DB
	for <gfs2@lists.linux.dev>; Wed, 25 Sep 2024 22:04:01 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.77])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 113AB19560AA;
	Wed, 25 Sep 2024 22:03:59 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 16/16] gfs2: Make gfs2_inode_refresh static
Date: Thu, 26 Sep 2024 00:03:26 +0200
Message-ID: <20240925220331.417856-17-agruenba@redhat.com>
In-Reply-To: <20240925220331.417856-1-agruenba@redhat.com>
References: <20240925220331.417856-1-agruenba@redhat.com>
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

Function gfs2_inode_refresh() is only used in fs/gfs2/glops.c.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/glops.c | 2 +-
 fs/gfs2/inode.h | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/gfs2/glops.c b/fs/gfs2/glops.c
index dbc444bfc630..eb4714f299ef 100644
--- a/fs/gfs2/glops.c
+++ b/fs/gfs2/glops.c
@@ -470,7 +470,7 @@ static int gfs2_dinode_in(struct gfs2_inode *ip, const void *buf)
  * Returns: errno
  */
 
-int gfs2_inode_refresh(struct gfs2_inode *ip)
+static int gfs2_inode_refresh(struct gfs2_inode *ip)
 {
 	struct buffer_head *dibh;
 	int error;
diff --git a/fs/gfs2/inode.h b/fs/gfs2/inode.h
index fd15d1c6b6fb..9e5e1622d50a 100644
--- a/fs/gfs2/inode.h
+++ b/fs/gfs2/inode.h
@@ -93,8 +93,6 @@ struct inode *gfs2_lookup_by_inum(struct gfs2_sbd *sdp, u64 no_addr,
 				  u64 no_formal_ino,
 				  unsigned int blktype);
 
-int gfs2_inode_refresh(struct gfs2_inode *ip);
-
 struct inode *gfs2_lookupi(struct inode *dir, const struct qstr *name,
 			   int is_root);
 int gfs2_permission(struct mnt_idmap *idmap,
-- 
2.46.0

