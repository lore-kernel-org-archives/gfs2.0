Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476864185C
	for <gfs2@lists.linux.dev>; Wed, 20 Dec 2023 20:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZiuqrhoD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703103901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fSItgBE1oqZADp4S7/+t5DRSYsWbHSBfmN8B19iYwHo=;
	b=ZiuqrhoDNGFW0bIJggURs4jHWT8f/ifhmnayNUs9ymT/ekC21Zay0Dy2of6ZQbzvgBRSnZ
	tnBBE2FSsnsf9Z+nkwwdI2+DNgbCEghBUz7IFdaDs2XiSsbGsGRiCx86ovjsxFVIVzaPKV
	pi+eBf+jpTF3R2jcckDnuRk+E6fBJWA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-0B5aPz5zNcyL_0AlNUfC2g-1; Wed, 20 Dec 2023 15:24:59 -0500
X-MC-Unique: 0B5aPz5zNcyL_0AlNUfC2g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0D16285A589
	for <gfs2@lists.linux.dev>; Wed, 20 Dec 2023 20:24:59 +0000 (UTC)
Received: from pasta.redhat.com (unknown [10.45.224.39])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 86CC9C15968;
	Wed, 20 Dec 2023 20:24:58 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 1/2] gfs2: Add GL_NOBLOCK flag
Date: Wed, 20 Dec 2023 21:24:56 +0100
Message-ID: <20231220202457.1581334-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Add a GL_NOBLOCK flag for trying to take a glock without sleeping.  This
will be used for implementing non-blocking lookup (MAY_NOT_BLOCK in
gfs2_permission, LOOKUP_RCU in gfs2_drevalidate).

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/glock.c | 39 ++++++++++++++++++++++++++++++++++++++-
 fs/gfs2/glock.h |  1 +
 2 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index d6bf1f8c25dc..2cb65f76eec8 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -516,6 +516,23 @@ static inline struct gfs2_holder *find_first_waiter(const struct gfs2_glock *gl)
 	return NULL;
 }
 
+/**
+ * find_last_waiter - find the last gh that's waiting for the glock
+ * @gl: the glock
+ *
+ * This also is a fast way of finding out if there are any waiters.
+ */
+
+static inline struct gfs2_holder *find_last_waiter(const struct gfs2_glock *gl)
+{
+	struct gfs2_holder *gh;
+
+	if (list_empty(&gl->gl_holders))
+		return NULL;
+	gh = list_last_entry(&gl->gl_holders, struct gfs2_holder, gh_list);
+	return test_bit(HIF_HOLDER, &gh->gh_iflags) ? NULL : gh;
+}
+
 /**
  * state_change - record that the glock is now in a different state
  * @gl: the glock
@@ -1555,11 +1572,30 @@ __acquires(&gl->gl_lockref.lock)
 int gfs2_glock_nq(struct gfs2_holder *gh)
 {
 	struct gfs2_glock *gl = gh->gh_gl;
-	int error = 0;
+	int error;
 
 	if (glock_blocked_by_withdraw(gl) && !(gh->gh_flags & LM_FLAG_NOEXP))
 		return -EIO;
 
+	if (gh->gh_flags & GL_NOBLOCK) {
+		struct gfs2_holder *current_gh;
+
+		error = -ECHILD;
+		spin_lock(&gl->gl_lockref.lock);
+		if (find_last_waiter(gl))
+			goto unlock;
+		current_gh = find_first_holder(gl);
+		if (!may_grant(gl, current_gh, gh))
+			goto unlock;
+		set_bit(HIF_HOLDER, &gh->gh_iflags);
+		list_add_tail(&gh->gh_list, &gl->gl_holders);
+		trace_gfs2_promote(gh);
+		error = 0;
+unlock:
+		spin_unlock(&gl->gl_lockref.lock);
+		return error;
+	}
+
 	if (test_bit(GLF_LRU, &gl->gl_flags))
 		gfs2_glock_remove_from_lru(gl);
 
@@ -1575,6 +1611,7 @@ int gfs2_glock_nq(struct gfs2_holder *gh)
 	run_queue(gl, 1);
 	spin_unlock(&gl->gl_lockref.lock);
 
+	error = 0;
 	if (!(gh->gh_flags & GL_ASYNC))
 		error = gfs2_glock_wait(gh);
 
diff --git a/fs/gfs2/glock.h b/fs/gfs2/glock.h
index 61197598abfd..0114f3e0ebe0 100644
--- a/fs/gfs2/glock.h
+++ b/fs/gfs2/glock.h
@@ -84,6 +84,7 @@ enum {
 #define GL_SKIP			0x0100
 #define GL_NOPID		0x0200
 #define GL_NOCACHE		0x0400
+#define GL_NOBLOCK		0x0800
   
 /*
  * lm_async_cb return flags
-- 
2.43.0

