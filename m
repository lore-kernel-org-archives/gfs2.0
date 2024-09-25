Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3ED2AD20
	for <gfs2@lists.linux.dev>; Wed, 25 Sep 2024 22:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727301829; cv=none; b=JwjFXkBan97tLtSECVIvAIzxc2/eyFnwUPGh3xmBap5HOfNsKfIZ0stq2UVNEL+BcSS8YP2vVKszOOXlStwLK/DPH2kp4SWn1CaLT0/o8g4uFtLsWTFQ0l3kiBpD0MQoOiCdbDKl1UpgCK3IoBLS7KrL8E1HTTC/BpPDCr5yZbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727301829; c=relaxed/simple;
	bh=n1L/19QhNG5l5jNVv+eE++rHLyxztuBaz1GaAPZF7qU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c8qp8a4g76QGRh0mxu4ST3WOaWJ20g9yrHfs86PZxlQUn9TfLHoWF4Q1uAZl2fsM+GXZsHHpsoeRF1FSM9jo9NHlHQlxpi2WXI67oJbp43/qEV+Hxpa0oYcmkVteNlcRRep+rRTz1oMSbqXAlgPReZnchVxKBP0RTrFXNRfup9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HBhLaUXa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HBhLaUXa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727301826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jLJhcc8wLHOwf0MwWBP/G4OHvWucz3eUGg7UBKT9ONU=;
	b=HBhLaUXaeNQbIAJggzam6mYZtdNe6dmNnqeTea6yYxBsKehE7+x6++6yano/cMGrjGkRVt
	y8SbJCXxkHxa3/LFaOctL2RdBRIl2YnOsNAkNrKa7GM0JcHjTGyFQXroonGqWzOJPG+FFN
	1387tkWT/fISnH2/4RXd77yQ0PCmn58=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-231-_yksZ7gvP6uYpn9pns-Rgw-1; Wed,
 25 Sep 2024 18:03:45 -0400
X-MC-Unique: _yksZ7gvP6uYpn9pns-Rgw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B7E811944D29
	for <gfs2@lists.linux.dev>; Wed, 25 Sep 2024 22:03:44 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.77])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BA5F919560AA;
	Wed, 25 Sep 2024 22:03:43 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 06/16] gfs2: Rename GIF_{DEFERRED -> DEFER}_DELETE
Date: Thu, 26 Sep 2024 00:03:16 +0200
Message-ID: <20240925220331.417856-7-agruenba@redhat.com>
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

The GIF_DEFERRED_DELETE flag indicates an action that gfs2_evict_inode()
should take, so rename the flag to GIF_DEFER_DELETE to clarify.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/glock.c  | 4 ++--
 fs/gfs2/incore.h | 2 +-
 fs/gfs2/super.c  | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 4567c8c60a03..c095ff2efe1d 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -980,7 +980,7 @@ static bool gfs2_try_evict(struct gfs2_glock *gl)
 		ip = NULL;
 	spin_unlock(&gl->gl_lockref.lock);
 	if (ip) {
-		set_bit(GIF_DEFERRED_DELETE, &ip->i_flags);
+		set_bit(GIF_DEFER_DELETE, &ip->i_flags);
 		d_prune_aliases(&ip->i_inode);
 		iput(&ip->i_inode);
 
@@ -988,7 +988,7 @@ static bool gfs2_try_evict(struct gfs2_glock *gl)
 		spin_lock(&gl->gl_lockref.lock);
 		ip = gl->gl_object;
 		if (ip) {
-			clear_bit(GIF_DEFERRED_DELETE, &ip->i_flags);
+			clear_bit(GIF_DEFER_DELETE, &ip->i_flags);
 			if (!igrab(&ip->i_inode))
 				ip = NULL;
 		}
diff --git a/fs/gfs2/incore.h b/fs/gfs2/incore.h
index bd1348bff90e..4e19cce3d906 100644
--- a/fs/gfs2/incore.h
+++ b/fs/gfs2/incore.h
@@ -376,7 +376,7 @@ enum {
 	GIF_SW_PAGED		= 3,
 	GIF_FREE_VFS_INODE      = 5,
 	GIF_GLOP_PENDING	= 6,
-	GIF_DEFERRED_DELETE	= 7,
+	GIF_DEFER_DELETE	= 7,
 };
 
 struct gfs2_inode {
diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index 7f59c7f891fd..65aef2153b19 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -1324,7 +1324,7 @@ static enum dinode_demise evict_should_delete(struct inode *inode,
 	if (unlikely(test_bit(GIF_ALLOC_FAILED, &ip->i_flags)))
 		goto should_delete;
 
-	if (test_bit(GIF_DEFERRED_DELETE, &ip->i_flags))
+	if (test_bit(GIF_DEFER_DELETE, &ip->i_flags))
 		return SHOULD_DEFER_EVICTION;
 
 	/* Deletes should never happen under memory pressure anymore.  */
-- 
2.46.0

