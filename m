Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB0E15E85
	for <gfs2@lists.linux.dev>; Wed,  1 Nov 2023 16:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ucr/M6Az"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698857189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RQrC4+dEejZdl3XFk0dJvS7BuUnZDuWVtmk43y773Y4=;
	b=Ucr/M6AzSYFwk4W8IhR3LUfQZY92JQJWK5bzWpKp0gOTtRjD+g8uXuZ4hRBrVjBsQjrvRn
	UE1x32VvHNddeQctm9kS/nfMZvx74QhHqyQQQhR7DgMHV1L7FwSL6jk6kEx1f3sJh0m9F3
	PIn2EtxPWNSoUXOlJh7hyV6sX7BeqKI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-495-IlYLyQ1FOXSbabvZcM0J2g-1; Wed,
 01 Nov 2023 12:46:28 -0400
X-MC-Unique: IlYLyQ1FOXSbabvZcM0J2g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 908083826D2A
	for <gfs2@lists.linux.dev>; Wed,  1 Nov 2023 16:46:27 +0000 (UTC)
Received: from pasta.redhat.com (unknown [10.45.224.27])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1071340C6EBF;
	Wed,  1 Nov 2023 16:46:26 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 13/25] gfs2: Add metapath_dibh helper
Date: Wed,  1 Nov 2023 17:46:03 +0100
Message-ID: <20231101164615.1138692-14-agruenba@redhat.com>
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

Add a metapath_dibh() helper for extracting the inode's buffer head from
a metapath.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/bmap.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index 47d0f39feeb1..240f73e402d0 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -317,6 +317,12 @@ static void gfs2_metapath_ra(struct gfs2_glock *gl, __be64 *start, __be64 *end)
 	}
 }
 
+static inline struct buffer_head *
+metapath_dibh(struct metapath *mp)
+{
+	return mp->mp_bh[0];
+}
+
 static int __fillup_metapath(struct gfs2_inode *ip, struct metapath *mp,
 			     unsigned int x, unsigned int h)
 {
@@ -659,7 +665,7 @@ static int __gfs2_iomap_alloc(struct inode *inode, struct iomap *iomap,
 {
 	struct gfs2_inode *ip = GFS2_I(inode);
 	struct gfs2_sbd *sdp = GFS2_SB(inode);
-	struct buffer_head *dibh = mp->mp_bh[0];
+	struct buffer_head *dibh = metapath_dibh(mp);
 	u64 bn;
 	unsigned n, i, blks, alloced = 0, iblks = 0, branch_start = 0;
 	size_t dblks = iomap->length >> inode->i_blkbits;
-- 
2.41.0

