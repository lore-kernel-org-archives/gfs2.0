Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0221459E3
	for <gfs2@lists.linux.dev>; Wed, 29 May 2024 17:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717002242; cv=none; b=AVREbl1RwbW/Pl5c8d8vFPi+EJ30gn2JdcTzJb88Oo6kSQBd5EOxeS8aU4rCHLZjaCA1KhYilUQwo0+aU+sLeSmQ/C+Qd1uFOjphY/kLyBdUlhi3L+oWXAnvqQdmm6egppFOxcwC3pRz9hG6CElL5G05OeOu/RTNMw9gk59ua+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717002242; c=relaxed/simple;
	bh=tQu1sbXsAj+2QqhtioW6mE11/fHT0kjscF5v30BdXM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kqKLGTOdV5CvFuQvTjYCs2nsVfSumfL7g9f9UxTLe9xcbbdLYBDVYvL/nubU/2b0KIFDyJMof6dkwsS/+X83Vtt0fZEP4fo7Hdo0AI6LvHlFTCzn/KlsXXL5BKZXrV6wmzg4OXFQ9lAKwGskUCyQAvydccFBdaUVSI6S/RNXRM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CfZQ2q5s; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CfZQ2q5s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717002240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IxKQiv/2mQNMEVH7SatcBjux/8DOyeqtfMjZI2zAcNQ=;
	b=CfZQ2q5sXIb7TNTxWm5S33eenGOVih4j/gXwAgt25V0OqK+dVLtHS0lcouEtPGOx1vOKWE
	LLItvlHM0ohNr7WYxpSFOizJ1VaK6/0GRJqL5j1ycRI8e2vtViIO48f/vSh6h8wolYkbbd
	qIs31+4wrzfHWdneJuoM8kgea8aHCmE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-682-ngDCsxbvMIem9Acrcm_RmA-1; Wed,
 29 May 2024 13:03:58 -0400
X-MC-Unique: ngDCsxbvMIem9Acrcm_RmA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E6B383806702
	for <gfs2@lists.linux.dev>; Wed, 29 May 2024 17:03:57 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.40])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6B24D492BC6;
	Wed, 29 May 2024 17:03:57 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 05/15] gfs2: Rename GLF_FROZEN to GLF_HAVE_FROZEN_REPLY
Date: Wed, 29 May 2024 19:03:42 +0200
Message-ID: <20240529170352.571141-6-agruenba@redhat.com>
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

The GLF_FROZEN flag indicates that a reply to a DLM locking request has
been received, but should not be processed at this time.  To clarify
that meaning, rename the flag to GLF_HAVE_FROZEN_REPLY.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/glock.c      | 8 ++++----
 fs/gfs2/incore.h     | 2 +-
 fs/gfs2/trace_gfs2.h | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 34af0e7db98b..bac7078e4870 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -1641,7 +1641,7 @@ int gfs2_glock_nq(struct gfs2_holder *gh)
 	spin_lock(&gl->gl_lockref.lock);
 	add_to_queue(gh);
 	if (unlikely((LM_FLAG_NOEXP & gh->gh_flags) &&
-		     test_and_clear_bit(GLF_FROZEN, &gl->gl_flags))) {
+		     test_and_clear_bit(GLF_HAVE_FROZEN_REPLY, &gl->gl_flags))) {
 		set_bit(GLF_HAVE_REPLY, &gl->gl_flags);
 		gl->gl_lockref.count++;
 		gfs2_glock_queue_work(gl, 0);
@@ -1986,7 +1986,7 @@ void gfs2_glock_complete(struct gfs2_glock *gl, int ret)
 
 	if (unlikely(test_bit(DFL_BLOCK_LOCKS, &ls->ls_recover_flags))) {
 		if (gfs2_should_freeze(gl)) {
-			set_bit(GLF_FROZEN, &gl->gl_flags);
+			set_bit(GLF_HAVE_FROZEN_REPLY, &gl->gl_flags);
 			spin_unlock(&gl->gl_lockref.lock);
 			return;
 		}
@@ -2180,7 +2180,7 @@ void gfs2_flush_delete_work(struct gfs2_sbd *sdp)
 
 static void thaw_glock(struct gfs2_glock *gl)
 {
-	if (!test_and_clear_bit(GLF_FROZEN, &gl->gl_flags))
+	if (!test_and_clear_bit(GLF_HAVE_FROZEN_REPLY, &gl->gl_flags))
 		return;
 	if (!lockref_get_not_dead(&gl->gl_lockref))
 		return;
@@ -2368,7 +2368,7 @@ static const char *gflags2str(char *buf, const struct gfs2_glock *gl)
 		*p++ = 'r';
 	if (test_bit(GLF_INITIAL, gflags))
 		*p++ = 'I';
-	if (test_bit(GLF_FROZEN, gflags))
+	if (test_bit(GLF_HAVE_FROZEN_REPLY, gflags))
 		*p++ = 'F';
 	if (!list_empty(&gl->gl_holders))
 		*p++ = 'q';
diff --git a/fs/gfs2/incore.h b/fs/gfs2/incore.h
index e4423075433b..73f24b86338c 100644
--- a/fs/gfs2/incore.h
+++ b/fs/gfs2/incore.h
@@ -324,7 +324,7 @@ enum {
 	GLF_INVALIDATE_IN_PROGRESS	= 8,
 	GLF_HAVE_REPLY			= 9,
 	GLF_INITIAL			= 10,
-	GLF_FROZEN			= 11,
+	GLF_HAVE_FROZEN_REPLY		= 11,
 	GLF_INSTANTIATE_IN_PROG		= 12, /* instantiate happening now */
 	GLF_LRU				= 13,
 	GLF_OBJECT			= 14, /* Used only for tracing */
diff --git a/fs/gfs2/trace_gfs2.h b/fs/gfs2/trace_gfs2.h
index 3721f0333dd7..65748bfaef69 100644
--- a/fs/gfs2/trace_gfs2.h
+++ b/fs/gfs2/trace_gfs2.h
@@ -55,7 +55,7 @@
 	{(1UL << GLF_INVALIDATE_IN_PROGRESS),	"i" },		\
 	{(1UL << GLF_HAVE_REPLY),		"r" },		\
 	{(1UL << GLF_INITIAL),			"I" },		\
-	{(1UL << GLF_FROZEN),			"F" },		\
+	{(1UL << GLF_HAVE_FROZEN_REPLY),	"F" },		\
 	{(1UL << GLF_LRU),			"L" },		\
 	{(1UL << GLF_OBJECT),			"o" },		\
 	{(1UL << GLF_BLOCKING),			"b" })
-- 
2.45.1

