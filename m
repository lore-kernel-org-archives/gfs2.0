Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A9715E80
	for <gfs2@lists.linux.dev>; Wed,  1 Nov 2023 16:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BDRungXe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698857185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n5dTUkENh70RaZapsX9tpF8qdveUQ/uHru2UWXUSoUQ=;
	b=BDRungXeVQ5UYBaPqDflBRnF6rwzMtAxhfEEH+8k3bsmiD/08okoJ4s7XXZ+lY5D3kuG1n
	kC8oe5bIzg13v74OwjWGSCpCoVdS0n6uk9MuS+wRkXZUIWXQzsy5Av2wzN3YL0rZPcXkjo
	6muicuYgQq8MnU2FqG2j5WIu2kpVvBQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-264-bFSMJ3T8NIiwAglXzDeXog-1; Wed,
 01 Nov 2023 12:46:23 -0400
X-MC-Unique: bFSMJ3T8NIiwAglXzDeXog-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 492FE3826D47
	for <gfs2@lists.linux.dev>; Wed,  1 Nov 2023 16:46:20 +0000 (UTC)
Received: from pasta.redhat.com (unknown [10.45.224.27])
	by smtp.corp.redhat.com (Postfix) with ESMTP id BAEA740C6EBF;
	Wed,  1 Nov 2023 16:46:19 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 04/25] gfs2: Get rid of the gfs2_glock_is_held_* helpers
Date: Wed,  1 Nov 2023 17:45:54 +0100
Message-ID: <20231101164615.1138692-5-agruenba@redhat.com>
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

Those helpers don't add any clarity and are easy to use wrong.  Spell
them out to make more obvious what's happening.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/aops.c  |  2 +-
 fs/gfs2/glock.h | 15 ---------------
 fs/gfs2/inode.c |  2 +-
 3 files changed, 2 insertions(+), 17 deletions(-)

diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index c26d48355cc2..52fad5bcb047 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -155,7 +155,7 @@ static int gfs2_jdata_writepage(struct page *page, struct writeback_control *wbc
 	struct gfs2_inode *ip = GFS2_I(inode);
 	struct gfs2_sbd *sdp = GFS2_SB(inode);
 
-	if (gfs2_assert_withdraw(sdp, gfs2_glock_is_held_excl(ip->i_gl)))
+	if (gfs2_assert_withdraw(sdp, ip->i_gl->gl_state == LM_ST_EXCLUSIVE))
 		goto out;
 	if (folio_test_checked(folio) || current->journal_info)
 		goto out_ignore;
diff --git a/fs/gfs2/glock.h b/fs/gfs2/glock.h
index c8685ca7d2a2..4daad53f9436 100644
--- a/fs/gfs2/glock.h
+++ b/fs/gfs2/glock.h
@@ -156,21 +156,6 @@ static inline struct gfs2_holder *gfs2_glock_is_locked_by_me(struct gfs2_glock *
 	return gh;
 }
 
-static inline int gfs2_glock_is_held_excl(struct gfs2_glock *gl)
-{
-	return gl->gl_state == LM_ST_EXCLUSIVE;
-}
-
-static inline int gfs2_glock_is_held_dfrd(struct gfs2_glock *gl)
-{
-	return gl->gl_state == LM_ST_DEFERRED;
-}
-
-static inline int gfs2_glock_is_held_shrd(struct gfs2_glock *gl)
-{
-	return gl->gl_state == LM_ST_SHARED;
-}
-
 static inline struct address_space *gfs2_glock2aspace(struct gfs2_glock *gl)
 {
 	if (gl->gl_ops->go_flags & GLOF_ASPACE) {
diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index 0eac04507904..2880d6ca19e1 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -2153,7 +2153,7 @@ static int gfs2_update_time(struct inode *inode, int flags)
 	int error;
 
 	gh = gfs2_glock_is_locked_by_me(gl);
-	if (gh && !gfs2_glock_is_held_excl(gl)) {
+	if (gh && gl->gl_state != LM_ST_EXCLUSIVE) {
 		gfs2_glock_dq(gh);
 		gfs2_holder_reinit(LM_ST_EXCLUSIVE, 0, gh);
 		error = gfs2_glock_nq(gh);
-- 
2.41.0

