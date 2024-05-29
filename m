Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA6815B566
	for <gfs2@lists.linux.dev>; Wed, 29 May 2024 17:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717002246; cv=none; b=E99Hw5GjREI/J98jVQz5/DmIQW3+Zq1mGzxwqvOaY5vFIiMvVFlgrvlJmF8Kfle825Zv8u9QaCREZNRe8wp7vG7Gts0KofYWWMqxMQS7/+JGBkeGuPSI/Jq57ndPyKGTofQ6fGax4qPWESiKFJ3aJvnfetka+97jwd6Afafbi6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717002246; c=relaxed/simple;
	bh=89bWn011WQGZDGe1zTcekQZLS+au8VbdW20yuJzzR+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mtUFc8JU7btUzsN07qdz07Nf0nzrcRQkwLIeg23fyMFWf91LTjBnuEuoY18BXSS1uIreasfzZu/yEy4nVjm8EiabUyYhSvgM6NnqP2TDKVWXeP5kGaAIo2BVboJqZgzSe85sCZ9jyr77oyhlqcTthGFSyexDe88ZbNfY47nM9YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LQdpzNOb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LQdpzNOb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717002243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cef42i3G/9mUhQ2IaPrLF2VLC85fPAZ99Bh96cyCUyw=;
	b=LQdpzNOb8JqxU4/zW7poeUoEt2M/33h35kOzEy5gy3m2ENBu1fF958rzMmh6BdeH+0mNN8
	xmEaz/lvjjoObmpwn7kGBOiaaqapJLVxXCXer0Qf4HuSIdzFJ7/9PAJ3Iv3oLukudJ/rb4
	f01Raeq4QYe8Be1bOXwnvjBLrdMqa/w=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-453-WzwQJKlOPB6hZ_H4s7tj1g-1; Wed,
 29 May 2024 13:04:01 -0400
X-MC-Unique: WzwQJKlOPB6hZ_H4s7tj1g-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E53773C025B1
	for <gfs2@lists.linux.dev>; Wed, 29 May 2024 17:04:00 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.40])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 689BA492BC6;
	Wed, 29 May 2024 17:04:00 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 09/15] gfs2: Invert the GLF_INITIAL flag
Date: Wed, 29 May 2024 19:03:46 +0200
Message-ID: <20240529170352.571141-10-agruenba@redhat.com>
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

Invert the meaning of the GLF_INITIAL flag: right now, when GLF_INITIAL
is set, a DLM lock exists and we have a valid identifier for it; when
GLF_INITIAL is cleared, no DLM lock exists (yet).  This is confusing.
In addition, it makes more sense to highlight the exceptional case
(i.e., no DLM lock exists yet) in glock dumps and trace points than to
highlight the common case.

To avoid confusion between the "old" and the "new" meaning of the flag,
use 'a' instead of 'I' to represent the flag.

For improved code consistency, check if the GLF_INITIAL flag is cleared
to determine whether a DLM lock exists instead of checking if the lock
identifier is non-zero.

Document what the flag is used for.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/glock.c      |  6 ++++--
 fs/gfs2/lock_dlm.c   | 24 +++++++++++++++++-------
 fs/gfs2/trace_gfs2.h |  2 +-
 3 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index ef4fbb197c99..5fed5a22a8e7 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -1237,7 +1237,9 @@ int gfs2_glock_get(struct gfs2_sbd *sdp, u64 number,
 
 	atomic_inc(&sdp->sd_glock_disposal);
 	gl->gl_node.next = NULL;
-	gl->gl_flags = glops->go_instantiate ? BIT(GLF_INSTANTIATE_NEEDED) : 0;
+	gl->gl_flags = BIT(GLF_INITIAL);
+	if (glops->go_instantiate)
+		gl->gl_flags |= BIT(GLF_INSTANTIATE_NEEDED);
 	gl->gl_name = name;
 	lockdep_set_subclass(&gl->gl_lockref.lock, glops->go_subclass);
 	gl->gl_lockref.count = 1;
@@ -2363,7 +2365,7 @@ static const char *gflags2str(char *buf, const struct gfs2_glock *gl)
 	if (test_bit(GLF_HAVE_REPLY, gflags))
 		*p++ = 'r';
 	if (test_bit(GLF_INITIAL, gflags))
-		*p++ = 'I';
+		*p++ = 'a';
 	if (test_bit(GLF_HAVE_FROZEN_REPLY, gflags))
 		*p++ = 'F';
 	if (!list_empty(&gl->gl_holders))
diff --git a/fs/gfs2/lock_dlm.c b/fs/gfs2/lock_dlm.c
index cb2ad0031f9e..fa5134df985f 100644
--- a/fs/gfs2/lock_dlm.c
+++ b/fs/gfs2/lock_dlm.c
@@ -163,11 +163,21 @@ static void gdlm_ast(void *arg)
 			BUG();
 	}
 
-	set_bit(GLF_INITIAL, &gl->gl_flags);
+	/*
+	 * The GLF_INITIAL flag is initially set for new glocks.  Upon the
+	 * first successful new (non-conversion) request, we clear this flag to
+	 * indicate that a DLM lock exists and that gl->gl_lksb.sb_lkid is the
+	 * identifier to use for identifying it.
+	 *
+	 * Any failed initial requests do not create a DLM lock, so we ignore
+	 * the gl->gl_lksb.sb_lkid values that come with such requests.
+	 */
+
+	clear_bit(GLF_INITIAL, &gl->gl_flags);
 	gfs2_glock_complete(gl, ret);
 	return;
 out:
-	if (!test_bit(GLF_INITIAL, &gl->gl_flags))
+	if (test_bit(GLF_INITIAL, &gl->gl_flags))
 		gl->gl_lksb.sb_lkid = 0;
 	gfs2_glock_complete(gl, ret);
 }
@@ -239,7 +249,7 @@ static u32 make_flags(struct gfs2_glock *gl, const unsigned int gfs_flags,
 			BUG();
 	}
 
-	if (gl->gl_lksb.sb_lkid != 0) {
+	if (!test_bit(GLF_INITIAL, &gl->gl_flags)) {
 		lkf |= DLM_LKF_CONVERT;
 		if (test_bit(GLF_BLOCKING, &gl->gl_flags))
 			lkf |= DLM_LKF_QUECVT;
@@ -270,14 +280,14 @@ static int gdlm_lock(struct gfs2_glock *gl, unsigned int req_state,
 	lkf = make_flags(gl, flags, req);
 	gfs2_glstats_inc(gl, GFS2_LKS_DCOUNT);
 	gfs2_sbstats_inc(gl, GFS2_LKS_DCOUNT);
-	if (gl->gl_lksb.sb_lkid) {
-		gfs2_update_request_times(gl);
-	} else {
+	if (test_bit(GLF_INITIAL, &gl->gl_flags)) {
 		memset(strname, ' ', GDLM_STRNAME_BYTES - 1);
 		strname[GDLM_STRNAME_BYTES - 1] = '\0';
 		gfs2_reverse_hex(strname + 7, gl->gl_name.ln_type);
 		gfs2_reverse_hex(strname + 23, gl->gl_name.ln_number);
 		gl->gl_dstamp = ktime_get_real();
+	} else {
+		gfs2_update_request_times(gl);
 	}
 	/*
 	 * Submit the actual lock request.
@@ -301,7 +311,7 @@ static void gdlm_put_lock(struct gfs2_glock *gl)
 
 	BUG_ON(!__lockref_is_dead(&gl->gl_lockref));
 
-	if (gl->gl_lksb.sb_lkid == 0) {
+	if (test_bit(GLF_INITIAL, &gl->gl_flags)) {
 		gfs2_glock_free(gl);
 		return;
 	}
diff --git a/fs/gfs2/trace_gfs2.h b/fs/gfs2/trace_gfs2.h
index 65748bfaef69..8eae8d62a413 100644
--- a/fs/gfs2/trace_gfs2.h
+++ b/fs/gfs2/trace_gfs2.h
@@ -54,7 +54,7 @@
 	{(1UL << GLF_LFLUSH),			"f" },		\
 	{(1UL << GLF_INVALIDATE_IN_PROGRESS),	"i" },		\
 	{(1UL << GLF_HAVE_REPLY),		"r" },		\
-	{(1UL << GLF_INITIAL),			"I" },		\
+	{(1UL << GLF_INITIAL),			"a" },		\
 	{(1UL << GLF_HAVE_FROZEN_REPLY),	"F" },		\
 	{(1UL << GLF_LRU),			"L" },		\
 	{(1UL << GLF_OBJECT),			"o" },		\
-- 
2.45.1

