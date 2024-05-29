Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42E815B559
	for <gfs2@lists.linux.dev>; Wed, 29 May 2024 17:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717002244; cv=none; b=DcsYGVn3R0avqN+GrzLMpBF7FTYyM8w/C3TESFDGvRma4MjwyzL0SdEmO+jb265YlO3R2wb2Kmy3hJN8H+peNKFqHqbMgMDKrdgkPjSmLOWNfXLK+UcsOW44wo2yZ8ZjhfkTUNpWPp6E509l8B/GpCp6u7lcYWSoGpi1JQ7rqrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717002244; c=relaxed/simple;
	bh=19HTGbO1DC7KBR/fCCWuwJaOdonh0vQzheBNjFc4pDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RQ79EF5yx3Jd1O3eYMrgq5lesbC9Eqzx/NZGz+oLGAiosvB16DiaOKUPmvDHGeUxqAY2ZYKdPqQL1W+L7Xo2mfVtv/ozg9HUAVJ8JhI9KXzaI+5+tChmhj6z6ihbwBsKYGekZ94ww/P5W1yW3Kae4QvlXn3Vf8uFy25fqmu0+Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NDUA065e; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NDUA065e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717002240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cIQSEM2J/lhVGEkl2WiVUsuHhnIkZd6I6OOrQbh6NKY=;
	b=NDUA065eksIy7TCoBKdZ719u65orCG5lbCR8Orql2lOlg41UvkOAVcsbwBtZw9EvCyAWCD
	cI8neDnf4QbWTL3FjhU+6QIxKFt8yQH+OZInNjLWJyWpsxx03xXacGsceOG/Ok7dhm7k0w
	Y48ORKFkUnW0XlJSqJ2bDdKzLqeROVI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-6tOTXzdYNKyvt2xBl2v6aA-1; Wed, 29 May 2024 13:03:58 -0400
X-MC-Unique: 6tOTXzdYNKyvt2xBl2v6aA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AAE3F85A58C
	for <gfs2@lists.linux.dev>; Wed, 29 May 2024 17:03:58 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.40])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2EB3D492BC6;
	Wed, 29 May 2024 17:03:58 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 06/15] gfs2: Rename handle_callback to request_demote
Date: Wed, 29 May 2024 19:03:43 +0200
Message-ID: <20240529170352.571141-7-agruenba@redhat.com>
In-Reply-To: <20240529170352.571141-1-agruenba@redhat.com>
References: <20240529170352.571141-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Function handle_callback() is used to request a glock demote.  This
often happens in response to a conflicting remote locking request and
subsequent bast callback from DLM, but there are other reasons for
triggering a demote request as well, such as when trying to release a
glock in response to memory pressure.  To clarify that, rename the
function to request_demote().

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/glock.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index bac7078e4870..c583ba05e8f5 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -61,8 +61,8 @@ struct gfs2_glock_iter {
 typedef void (*glock_examiner) (struct gfs2_glock * gl);
 
 static void do_xmote(struct gfs2_glock *gl, struct gfs2_holder *gh, unsigned int target);
-static void handle_callback(struct gfs2_glock *gl, unsigned int state,
-			    unsigned long delay, bool remote);
+static void request_demote(struct gfs2_glock *gl, unsigned int state,
+			   unsigned long delay, bool remote);
 
 static struct dentry *gfs2_root;
 static struct workqueue_struct *glock_workqueue;
@@ -811,7 +811,7 @@ __acquires(&gl->gl_lockref.lock)
 	    (target != LM_ST_UNLOCKED ||
 	     test_bit(SDF_WITHDRAW_RECOVERY, &sdp->sd_flags))) {
 		if (!is_system_glock(gl)) {
-			handle_callback(gl, LM_ST_UNLOCKED, 0, false); /* sets demote */
+			request_demote(gl, LM_ST_UNLOCKED, 0, false);
 			/*
 			 * Ordinarily, we would call dlm and its callback would call
 			 * finish_xmote, which would call state_change() to the new state.
@@ -1459,7 +1459,7 @@ int gfs2_glock_async_wait(unsigned int num_gh, struct gfs2_holder *ghs)
 }
 
 /**
- * handle_callback - process a demote request
+ * request_demote - process a demote request
  * @gl: the glock
  * @state: the state the caller wants us to change to
  * @delay: zero to demote immediately; otherwise pending demote
@@ -1469,8 +1469,8 @@ int gfs2_glock_async_wait(unsigned int num_gh, struct gfs2_holder *ghs)
  * practise: LM_ST_SHARED and LM_ST_UNLOCKED
  */
 
-static void handle_callback(struct gfs2_glock *gl, unsigned int state,
-			    unsigned long delay, bool remote)
+static void request_demote(struct gfs2_glock *gl, unsigned int state,
+			   unsigned long delay, bool remote)
 {
 	if (delay)
 		set_bit(GLF_PENDING_DEMOTE, &gl->gl_flags);
@@ -1686,7 +1686,7 @@ static void __gfs2_glock_dq(struct gfs2_holder *gh)
 	 * below.
 	 */
 	if (gh->gh_flags & GL_NOCACHE)
-		handle_callback(gl, LM_ST_UNLOCKED, 0, false);
+		request_demote(gl, LM_ST_UNLOCKED, 0, false);
 
 	list_del_init(&gh->gh_list);
 	clear_bit(HIF_HOLDER, &gh->gh_iflags);
@@ -1933,7 +1933,7 @@ void gfs2_glock_cb(struct gfs2_glock *gl, unsigned int state)
 		if (test_bit(GLF_HAVE_REPLY, &gl->gl_flags))
 			delay = gl->gl_hold_time;
 	}
-	handle_callback(gl, state, delay, true);
+	request_demote(gl, state, delay, true);
 	gfs2_glock_queue_work(gl, delay);
 	spin_unlock(&gl->gl_lockref.lock);
 }
@@ -2062,7 +2062,7 @@ __acquires(&lru_lock)
 		freed++;
 		gl->gl_lockref.count++;
 		if (demote_ok(gl))
-			handle_callback(gl, LM_ST_UNLOCKED, 0, false);
+			request_demote(gl, LM_ST_UNLOCKED, 0, false);
 		gfs2_glock_queue_work(gl, 0);
 		spin_unlock(&gl->gl_lockref.lock);
 		cond_resched_lock(&lru_lock);
@@ -2205,7 +2205,7 @@ static void clear_glock(struct gfs2_glock *gl)
 	if (!__lockref_is_dead(&gl->gl_lockref)) {
 		gl->gl_lockref.count++;
 		if (gl->gl_state != LM_ST_UNLOCKED)
-			handle_callback(gl, LM_ST_UNLOCKED, 0, false);
+			request_demote(gl, LM_ST_UNLOCKED, 0, false);
 		gfs2_glock_queue_work(gl, 0);
 	}
 	spin_unlock(&gl->gl_lockref.lock);
-- 
2.45.1

