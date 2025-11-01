Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66492581
	for <gfs2@lists.linux.dev>; Sat,  1 Nov 2025 00:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761956592; cv=none; b=IiLGY1kcNG4ax2mdhv/yVeRDAttWVWkqMScGu59y1iuORvHaAnwWicV7BF6XUTo94M9Gi/K216EI19AqrK9XlsO5dfBOO4p0gfG/hAN/wi/JZ2HxCt8BxIq/6a/7Ng31wx48XtDfWUGR/6HaAN7gej8MvjU8WlcH15+nK4D9C2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761956592; c=relaxed/simple;
	bh=RQZt3Fr2kV800Lo3J+lKPl8Rt4es5aHetsd/A8zJV1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=oJbysC2ItjIQtQ4gON0m7+hl/LseNZP18CTb4r6l3h554CHi7U9jgwRjKHx+dg/TXUHmVm4HFX7ikiHxACfFAtKYdrVsYigoA+e6pKYErX4TEhQyJyMtTGv8QskGZPB8X2JOAxHYajHGpBjeA2fthNjo86awZY7lYy8IahtnXrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dTvrO1hf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dTvrO1hf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761956589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1wFbxk4CGgMifUcsg07LhIZNbTKbK5aIHMqwTv+kFxc=;
	b=dTvrO1hfvgfZxJAx6IFDY+lKKfaGfHRj5GUuK9JtwkujCU7ubbyqaxEgbgrztgrhb1Lrwq
	XHXw7LfBibALgoK0q3P+lZ9QF10K1dW7FuJJ3HOKz+FfO7Y5coszUS2/UzutZRWUZu+K9Y
	pHOGfJdsEvL/4Mk/lwmiRZn9LzmAjPQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-358-s8oRjre3O7ObXLg76PAX6g-1; Fri,
 31 Oct 2025 20:23:08 -0400
X-MC-Unique: s8oRjre3O7ObXLg76PAX6g-1
X-Mimecast-MFC-AGG-ID: s8oRjre3O7ObXLg76PAX6g_1761956587
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 29FD91956080
	for <gfs2@lists.linux.dev>; Sat,  1 Nov 2025 00:23:07 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.12])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1DCBE18004D8;
	Sat,  1 Nov 2025 00:23:05 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 19/24] gfs2: Rename gfs2_{gl_dq_holders => withdraw_glocks}
Date: Sat,  1 Nov 2025 00:22:28 +0000
Message-ID: <20251101002234.1286383-20-agruenba@redhat.com>
In-Reply-To: <20251101002234.1286383-1-agruenba@redhat.com>
References: <20251101002234.1286383-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4BeJF6fJHaYKfxTUzD1Hns_-xyWUHSQLgaJ1cCFKy4Q_1761956587
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Rename function gfs2_gl_dq_holders() to gfs2_withdraw_glocks().  This
function will soon be used for more than just dequeuing holders.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/glock.c | 6 +++---
 fs/gfs2/glock.h | 2 +-
 fs/gfs2/util.c  | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index ee6d7fc78a2d..7c20750e482d 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -2069,7 +2069,7 @@ static void dump_glock_func(struct gfs2_glock *gl)
 	dump_glock(NULL, gl, true);
 }
 
-static void withdraw_dq(struct gfs2_glock *gl)
+static void withdraw_glock(struct gfs2_glock *gl)
 {
 	spin_lock(&gl->gl_lockref.lock);
 	if (!__lockref_is_dead(&gl->gl_lockref))
@@ -2077,9 +2077,9 @@ static void withdraw_dq(struct gfs2_glock *gl)
 	spin_unlock(&gl->gl_lockref.lock);
 }
 
-void gfs2_gl_dq_holders(struct gfs2_sbd *sdp)
+void gfs2_withdraw_glocks(struct gfs2_sbd *sdp)
 {
-	glock_hash_walk(withdraw_dq, sdp);
+	glock_hash_walk(withdraw_glock, sdp);
 }
 
 /**
diff --git a/fs/gfs2/glock.h b/fs/gfs2/glock.h
index e84ef6c6164d..55d5985f32a0 100644
--- a/fs/gfs2/glock.h
+++ b/fs/gfs2/glock.h
@@ -263,7 +263,7 @@ bool gfs2_queue_verify_delete(struct gfs2_glock *gl, bool later);
 void gfs2_cancel_delete_work(struct gfs2_glock *gl);
 void gfs2_flush_delete_work(struct gfs2_sbd *sdp);
 void gfs2_gl_hash_clear(struct gfs2_sbd *sdp);
-void gfs2_gl_dq_holders(struct gfs2_sbd *sdp);
+void gfs2_withdraw_glocks(struct gfs2_sbd *sdp);
 void gfs2_glock_thaw(struct gfs2_sbd *sdp);
 void gfs2_glock_free(struct gfs2_glock *gl);
 void gfs2_glock_free_later(struct gfs2_glock *gl);
diff --git a/fs/gfs2/util.c b/fs/gfs2/util.c
index 4f1db097212a..09fcfc04769b 100644
--- a/fs/gfs2/util.c
+++ b/fs/gfs2/util.c
@@ -149,7 +149,7 @@ static void do_withdraw(struct gfs2_sbd *sdp)
 		 * Dequeue any pending non-system glock holders that can no
 		 * longer be granted because the file system is withdrawn.
 		 */
-		gfs2_gl_dq_holders(sdp);
+		gfs2_withdraw_glocks(sdp);
 	}
 
 	gfs2_thaw_freeze_initiator(sdp->sd_vfs);
-- 
2.51.0

