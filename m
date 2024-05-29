Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC215A55
	for <gfs2@lists.linux.dev>; Wed, 29 May 2024 17:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717002243; cv=none; b=u5uWG+kB8JKegDSY+WrsV5HCS17acuH4GOKDlfW5W0zMDhgxkAsT3R3MXo1gI3vCAwbFDKT3yVTd5IC9ANAZb0gnu+uaYwyxAZmZ4ZPfBLpBq5o5uLGpPOP7m0kGlTmN4UDBWd6RqtLST+UzPEcUI98laqABiFqmaTs0edcT4mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717002243; c=relaxed/simple;
	bh=nVNf8FiuvUyVWDyYBSynQHugQo2b37z+i7SboxcxyGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JF0GylmaIMNbEOeBnCYBRuJIDbezjc4mXbksqZ8sMXCFkHB+6JCtTxyzMrICzxh6uwIOAhhqJixl/0y9Wh6IAmBoKkhDmdwUg82E8Dlfs95ioINdpC181bbFKf1S6/U/RTm4YZ9c+d1h5YE3VaOrgbI1nYdGRkGbsf7NEQ+0xcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hgMp0KYq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hgMp0KYq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717002239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/8cD3pFVsORkNXYKYWMnCWfdBqnwkNaTpu9kmgJddK0=;
	b=hgMp0KYqpiRli2z+O1/BzBLOnsiz8LKpFH8SbiUpdWhRhbdjppX17m82WScfXMhlX4CvUb
	6qZF4/DHHgJiaqpnOHAJwADM1VNnk0vDjV+XFuZVUD8GiC3Eez5KeHk/g0T3LMIZRmOXIM
	rgZruSEIORnspA6KoYS9S/v1dRHq64E=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-290-4JuCMwMfMWuViu2rpqJgMA-1; Wed,
 29 May 2024 13:03:57 -0400
X-MC-Unique: 4JuCMwMfMWuViu2rpqJgMA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 312453C025B1
	for <gfs2@lists.linux.dev>; Wed, 29 May 2024 17:03:57 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.40])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A873D492BC6;
	Wed, 29 May 2024 17:03:56 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 04/15] gfs2: Rename GLF_REPLY_PENDING to GLF_HAVE_REPLY
Date: Wed, 29 May 2024 19:03:41 +0200
Message-ID: <20240529170352.571141-5-agruenba@redhat.com>
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

The GLF_REPLY_PENDING flag indicates to glock_work_func() that in
response to a locking request, DLM has sent a reply that needs to be
processed.  A flag with that name could as well indicate that we are
waiting on a reply from DLM, however.  To disambiguate these two cases,
rename the flag to GLF_HAVE_REPLY.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/glock.c      | 14 +++++++-------
 fs/gfs2/incore.h     |  2 +-
 fs/gfs2/trace_gfs2.h |  2 +-
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 959668e22c9d..34af0e7db98b 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -1109,8 +1109,8 @@ static void glock_work_func(struct work_struct *work)
 	unsigned int drop_refs = 1;
 
 	spin_lock(&gl->gl_lockref.lock);
-	if (test_bit(GLF_REPLY_PENDING, &gl->gl_flags)) {
-		clear_bit(GLF_REPLY_PENDING, &gl->gl_flags);
+	if (test_bit(GLF_HAVE_REPLY, &gl->gl_flags)) {
+		clear_bit(GLF_HAVE_REPLY, &gl->gl_flags);
 		finish_xmote(gl, gl->gl_reply);
 		drop_refs++;
 	}
@@ -1642,7 +1642,7 @@ int gfs2_glock_nq(struct gfs2_holder *gh)
 	add_to_queue(gh);
 	if (unlikely((LM_FLAG_NOEXP & gh->gh_flags) &&
 		     test_and_clear_bit(GLF_FROZEN, &gl->gl_flags))) {
-		set_bit(GLF_REPLY_PENDING, &gl->gl_flags);
+		set_bit(GLF_HAVE_REPLY, &gl->gl_flags);
 		gl->gl_lockref.count++;
 		gfs2_glock_queue_work(gl, 0);
 	}
@@ -1930,7 +1930,7 @@ void gfs2_glock_cb(struct gfs2_glock *gl, unsigned int state)
 	    gl->gl_name.ln_type == LM_TYPE_INODE) {
 		if (time_before(now, holdtime))
 			delay = holdtime - now;
-		if (test_bit(GLF_REPLY_PENDING, &gl->gl_flags))
+		if (test_bit(GLF_HAVE_REPLY, &gl->gl_flags))
 			delay = gl->gl_hold_time;
 	}
 	handle_callback(gl, state, delay, true);
@@ -1993,7 +1993,7 @@ void gfs2_glock_complete(struct gfs2_glock *gl, int ret)
 	}
 
 	gl->gl_lockref.count++;
-	set_bit(GLF_REPLY_PENDING, &gl->gl_flags);
+	set_bit(GLF_HAVE_REPLY, &gl->gl_flags);
 	gfs2_glock_queue_work(gl, 0);
 	spin_unlock(&gl->gl_lockref.lock);
 }
@@ -2186,7 +2186,7 @@ static void thaw_glock(struct gfs2_glock *gl)
 		return;
 
 	spin_lock(&gl->gl_lockref.lock);
-	set_bit(GLF_REPLY_PENDING, &gl->gl_flags);
+	set_bit(GLF_HAVE_REPLY, &gl->gl_flags);
 	gfs2_glock_queue_work(gl, 0);
 	spin_unlock(&gl->gl_lockref.lock);
 }
@@ -2364,7 +2364,7 @@ static const char *gflags2str(char *buf, const struct gfs2_glock *gl)
 		*p++ = 'f';
 	if (test_bit(GLF_INVALIDATE_IN_PROGRESS, gflags))
 		*p++ = 'i';
-	if (test_bit(GLF_REPLY_PENDING, gflags))
+	if (test_bit(GLF_HAVE_REPLY, gflags))
 		*p++ = 'r';
 	if (test_bit(GLF_INITIAL, gflags))
 		*p++ = 'I';
diff --git a/fs/gfs2/incore.h b/fs/gfs2/incore.h
index aa6dbde9cd19..e4423075433b 100644
--- a/fs/gfs2/incore.h
+++ b/fs/gfs2/incore.h
@@ -322,7 +322,7 @@ enum {
 	GLF_DIRTY			= 6,
 	GLF_LFLUSH			= 7,
 	GLF_INVALIDATE_IN_PROGRESS	= 8,
-	GLF_REPLY_PENDING		= 9,
+	GLF_HAVE_REPLY			= 9,
 	GLF_INITIAL			= 10,
 	GLF_FROZEN			= 11,
 	GLF_INSTANTIATE_IN_PROG		= 12, /* instantiate happening now */
diff --git a/fs/gfs2/trace_gfs2.h b/fs/gfs2/trace_gfs2.h
index a5deb9f86831..3721f0333dd7 100644
--- a/fs/gfs2/trace_gfs2.h
+++ b/fs/gfs2/trace_gfs2.h
@@ -53,7 +53,7 @@
 	{(1UL << GLF_DIRTY),			"y" },		\
 	{(1UL << GLF_LFLUSH),			"f" },		\
 	{(1UL << GLF_INVALIDATE_IN_PROGRESS),	"i" },		\
-	{(1UL << GLF_REPLY_PENDING),		"r" },		\
+	{(1UL << GLF_HAVE_REPLY),		"r" },		\
 	{(1UL << GLF_INITIAL),			"I" },		\
 	{(1UL << GLF_FROZEN),			"F" },		\
 	{(1UL << GLF_LRU),			"L" },		\
-- 
2.45.1

