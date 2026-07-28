Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7F938236F
	for <gfs2@lists.linux.dev>; Tue, 28 Jul 2026 16:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785256897; cv=none; b=onG/3i0UmG7tfGRyrDUFrKOzhmrmX6N+dR584FTfkFibQXSDIL0uvsGg4ggaGLVB+KU5WmZg+uPDbP7RIklzZZCMoToI81KWYlSwveI7TB7KjNCm7UgwLJQ5VeZm574bRFdSlc+7RZYO15F/sPEvkjSNKikyHv0VTJxTV0CjWR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785256897; c=relaxed/simple;
	bh=zNvfbTcmnj8nr4Z5EdrRHxGoNILiOfvaSsmqnNYUODI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=DtwuuSmHnykRSUjfVgeWOkfK5L+NJP0JdAOl2naVmtXijkDRJt6psKupTWGLvkaQ3QW+KcRKQjV6Nt5aSSKSgcecJgrAuWu8HQiDVXvN2xgSftPDGyx/Izq+HFmtCZCEKPrLuljYNz2Rb7kch0QxG2wanj6IRq22/P2JJVUOivs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iyicHCbC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iyicHCbC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785256895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0z0+p/docIMTO4yzS0VzUxZ1nH/xTgV/UmePJsKuIJQ=;
	b=iyicHCbCrZ/h6q4mHkgygbypII9KMJbEgmTS9V4eyv9lycBAGG8QgIO283tmdbKT67QS8S
	Pyg/2X5HFgbv3T2rSzMsDlaAkIicDESYK/qUUnGAlZF4YUM4n6HjFYu8vZb4fDyt8Uzf09
	tmlRJiKiUpwREzUR8rAB/Feft4FWoh4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-408-Mnh7ljFOP5q1SQA8ZScQyA-1; Tue,
 28 Jul 2026 12:41:33 -0400
X-MC-Unique: Mnh7ljFOP5q1SQA8ZScQyA-1
X-Mimecast-MFC-AGG-ID: Mnh7ljFOP5q1SQA8ZScQyA_1785256893
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 154AC195608A
	for <gfs2@lists.linux.dev>; Tue, 28 Jul 2026 16:41:33 +0000 (UTC)
Received: from pasta.redhat.com (unknown [10.44.48.20])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 27DDF300019F;
	Tue, 28 Jul 2026 16:41:31 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 2/4] gfs2: Don't cache unreferenced glocks
Date: Tue, 28 Jul 2026 18:41:22 +0200
Message-ID: <20260728164127.791843-3-agruenba@redhat.com>
In-Reply-To: <20260728164127.791843-1-agruenba@redhat.com>
References: <20260728164127.791843-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: uiO-WE47g1vtDjhPrgJ38fWb8f9jKsYYxcVpXqaiHhk_1785256893
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Currently, gfs2 caches unreferenced glocks until memory pressure sets in or the
filesystem is unmounted.  This was supposedly done to avoid excessive log
flushing: when a glock still has outstanding revokes, freeing it requires an
extra log flush, and we want to avoid too many of those extra log flushes.
Since commit 9287c6452d2b1 ("gfs2: Fix occasional glock use-after-free"),
outstanding revokes are accounted for in the glock reference count and glocks
with outstanding revokes will never be freed anymore, so this is no longer an
issue.

This also means that we won't need a glock LRU list anymore, but we leave
removing that list to a later patch for better readability.

It might seem that glocks that are not referenced anymore can be dropped
immediately without unlocking them first, but that isn't true for inode glocks
that have an address space attached (the "gfs2_glock(aspace)" slab cache): that
address space is only truncated when the associated glock is unlocked.  So
unlock those glocks when they become unreferenced.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/glock.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 0a93824424d5..f00dcae426c5 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -258,8 +258,8 @@ static bool __gfs2_glock_put_or_lock(struct gfs2_glock *gl)
 		return true;
 	GLOCK_BUG_ON(gl, gl->gl_lockref.count != 1);
 	if (gl->gl_state != LM_ST_UNLOCKED) {
-		gl->gl_lockref.count--;
-		gfs2_glock_add_to_lru(gl);
+		request_demote(gl, LM_ST_UNLOCKED, 0, false);
+		gfs2_glock_queue_work(gl, 0);
 		spin_unlock(&gl->gl_lockref.lock);
 		return true;
 	}
@@ -983,16 +983,19 @@ static void delete_work_func(struct work_struct *work)
 
 static void glock_work_func(struct work_struct *work)
 {
-	unsigned long delay = 0;
 	struct gfs2_glock *gl = container_of(work, struct gfs2_glock, gl_work.work);
-	unsigned int drop_refs = 1;
+	unsigned int drop_refs;
+	unsigned long delay;
 
 	spin_lock(&gl->gl_lockref.lock);
+again:
+	drop_refs = 1;
 	if (test_bit(GLF_HAVE_REPLY, &gl->gl_flags)) {
 		clear_bit(GLF_HAVE_REPLY, &gl->gl_flags);
 		finish_xmote(gl, gl->gl_reply);
 		drop_refs++;
 	}
+	delay = 0;
 	if (test_bit(GLF_PENDING_DEMOTE, &gl->gl_flags) &&
 	    gl->gl_state != LM_ST_UNLOCKED &&
 	    gl->gl_demote_state != LM_ST_EXCLUSIVE) {
@@ -1020,11 +1023,13 @@ static void glock_work_func(struct work_struct *work)
 	GLOCK_BUG_ON(gl, gl->gl_lockref.count < drop_refs);
 	gl->gl_lockref.count -= drop_refs;
 	if (!gl->gl_lockref.count) {
-		if (gl->gl_state == LM_ST_UNLOCKED) {
-			__gfs2_glock_put(gl);
-			return;
+		if (gl->gl_state != LM_ST_UNLOCKED) {
+			gl->gl_lockref.count++;
+			request_demote(gl, LM_ST_UNLOCKED, 0, false);
+			goto again;
 		}
-		gfs2_glock_add_to_lru(gl);
+		__gfs2_glock_put(gl);
+		return;
 	}
 	spin_unlock(&gl->gl_lockref.lock);
 }
-- 
2.55.0

