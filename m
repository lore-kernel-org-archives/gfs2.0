Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B822C3DEAC5
	for <gfs2@lists.linux.dev>; Mon, 13 Apr 2026 14:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776091955; cv=none; b=d82Y8yovAbOwXGkUM4jnUBam5J/s37aEC3PUX8SkpDJZvkQENuUsgJmf5r0SLXPlaA6K1QKVAtTEeKr2qOrpmd9ALR5O11Zhk6P6oodKYe6M/3ePankbZDBq937ip7OhZp6oy4qsWBURQmsgQtomUuG9ZVzmFlZ1227b4xQeUcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776091955; c=relaxed/simple;
	bh=EJ3SYMmdymUAMdHlrWoBmkuW8hbmPsa7xtNP2CA/5fM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Wy0phD5EMjey+L0oYXsN9YW0jQVuzh+E0Olh9X7mIPo5AMuN7Xu7fMP5uqWe2F1Le8onHbEjnjvkX6bHJIGmQBy79UyIbAqy8TSRasRkEDzHni+N1nrZf181M3ColPhXD6StnyzXzQdgEpWyJ3qivCFZkr7vlGoBGcyv8T8KaxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N7JyfFgY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N7JyfFgY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776091952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AMAbxChCAANIb5fcZOQXWHu7wCuPBRgLDDFMqWbM+po=;
	b=N7JyfFgYy14m2EQ9VAVEKxg0XyrYeb9KAEBqsD9HeLTV7KJyhb5C5PzC+fsCwd5w/n0Lb3
	v3FYbAcwfegjtOlxuV4FR5PNupzK0LqcT8Qr24ZK/0X8wjZPjyn+bmHWhWOiX4Mkge9iWK
	c2Lt5JSreYpvKE+iWmRXPyOvyWu5cMw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-96-6e4YlJfvNtSsx81PkH2xAg-1; Mon,
 13 Apr 2026 10:52:30 -0400
X-MC-Unique: 6e4YlJfvNtSsx81PkH2xAg-1
X-Mimecast-MFC-AGG-ID: 6e4YlJfvNtSsx81PkH2xAg_1776091949
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 70BAB195607E
	for <gfs2@lists.linux.dev>; Mon, 13 Apr 2026 14:52:29 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.44.32.156])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7E2AE19560AB;
	Mon, 13 Apr 2026 14:52:28 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 10/18] gfs2: bufdata allocation race
Date: Mon, 13 Apr 2026 16:52:03 +0200
Message-ID: <20260413145211.881752-11-agruenba@redhat.com>
In-Reply-To: <20260413145211.881752-1-agruenba@redhat.com>
References: <20260413145211.881752-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qljUc1z5d2VVPdPbBGJo2tA_17iCh6QfNnW3PmJpvi0_1776091949
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The locking in gfs2_trans_add_data() and gfs2_trans_add_meta() doesn't
follow the usual coding pattern of checking bh->b_private under lock,
allocating a new bufdata object with the locks dropped, and re-checking
once the lock has been reacquired.  Both functions set bh->b_private
without holding the buffer lock.  Fix that.

Also, in gfs2_trans_add_meta(), taking the folio lock during the
allocation doesn't actually do anything useful.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/trans.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/fs/gfs2/trans.c b/fs/gfs2/trans.c
index 0ded2d63dbbb..65cbe06e301a 100644
--- a/fs/gfs2/trans.c
+++ b/fs/gfs2/trans.c
@@ -176,7 +176,6 @@ static struct gfs2_bufdata *gfs2_alloc_bufdata(struct gfs2_glock *gl,
 	INIT_LIST_HEAD(&bd->bd_list);
 	INIT_LIST_HEAD(&bd->bd_ail_st_list);
 	INIT_LIST_HEAD(&bd->bd_ail_gl_list);
-	bh->b_private = bd;
 	return bd;
 }
 
@@ -210,12 +209,15 @@ void gfs2_trans_add_data(struct gfs2_glock *gl, struct buffer_head *bh)
 	if (bd == NULL) {
 		spin_unlock(&sdp->sd_log_lock);
 		unlock_buffer(bh);
-		if (bh->b_private == NULL)
-			bd = gfs2_alloc_bufdata(gl, bh);
-		else
-			bd = bh->b_private;
+		bd = gfs2_alloc_bufdata(gl, bh);
 		lock_buffer(bh);
 		spin_lock(&sdp->sd_log_lock);
+		if (bh->b_private) {
+			kmem_cache_free(gfs2_bufdata_cachep, bd);
+			bd = bh->b_private;
+		} else {
+			bh->b_private = bd;
+		}
 	}
 	gfs2_assert(sdp, bd->bd_gl == gl);
 	set_bit(TR_TOUCHED, &tr->tr_flags);
@@ -271,14 +273,15 @@ void gfs2_trans_add_meta(struct gfs2_glock *gl, struct buffer_head *bh)
 	if (bd == NULL) {
 		spin_unlock(&sdp->sd_log_lock);
 		unlock_buffer(bh);
-		folio_lock(bh->b_folio);
-		if (bh->b_private == NULL)
-			bd = gfs2_alloc_bufdata(gl, bh);
-		else
-			bd = bh->b_private;
-		folio_unlock(bh->b_folio);
+		bd = gfs2_alloc_bufdata(gl, bh);
 		lock_buffer(bh);
 		spin_lock(&sdp->sd_log_lock);
+		if (bh->b_private) {
+			kmem_cache_free(gfs2_bufdata_cachep, bd);
+			bd = bh->b_private;
+		} else {
+			bh->b_private = bd;
+		}
 	}
 	gfs2_assert(sdp, bd->bd_gl == gl);
 	set_bit(TR_TOUCHED, &tr->tr_flags);
-- 
2.53.0

