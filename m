Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CC32107
	for <gfs2@lists.linux.dev>; Tue, 29 Oct 2024 17:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730222161; cv=none; b=CMKhhk3XhHl2uEG9C4BeJBD1uMlxvheKnwDDreLtfPj0JZ7wwQubuFcU/IMe9uzT5TFYlBFbWy3Dd9JEFsgVOYJsik8CV8jx016zCR7uvgBLaZSMiQ/j2fYVT8YGww0UtNdjghxhI8uqe2jJLCyy5XRYGoA9wgz35jP13PM2M6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730222161; c=relaxed/simple;
	bh=TQfjGby1XEx+z6ISstrc4RduU00jErF4qLq2ozuCW+I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HMvDXO0jGYF9G9W6x3kKYkr7423OOnj6dLvrD/OCOjRAbJpAMUDosEXElSA77Q0tvSWxMRXTKZf/FlUZUaYD8Jbj3Qb+fV6B9g28fPFj9S7mXeB46vhGsS52xRZtN5SRaNhsN/Lkh+LsNiza+TL1cWN9zrK09FjZdD/2Cd78BUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NM8CIsBC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NM8CIsBC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730222158;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jwtGffy4+UAQs92/ngPaqWQy9tfpjUUo41LWfNvy7XA=;
	b=NM8CIsBCuEdOZW/jAWT3YFaWvCngQmM45iZrjGf1QdAdKHASuSz6rtp/uy5aS/4kN604S9
	oJAW5YNbpiGIueqp8lk5yzT5BFGbxgsg9wHTJi/pYlDwfUI4FHgGsIionVXsYOu/OpRzNo
	7v3Yx8LQ8U0Dek5NPMlt+oG55H/rLN8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-198-ir28sNceMaeWPmLfoGukGg-1; Tue,
 29 Oct 2024 13:15:56 -0400
X-MC-Unique: ir28sNceMaeWPmLfoGukGg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B59741955EB7
	for <gfs2@lists.linux.dev>; Tue, 29 Oct 2024 17:15:55 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.39.194.114])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C111C300018D;
	Tue, 29 Oct 2024 17:15:54 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH] gfs2: Simplify DLM_LKF_QUECVT use
Date: Tue, 29 Oct 2024 18:15:53 +0100
Message-ID: <20241029171553.408671-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

The DLM_LKF_QUECVT flag needs to be set for "upward" lock conversions to
ensure fairness, but setting it for "downward" lock conversions will
lead to a failure.  The flag is currently set based on the GLF_BLOCKING
flag, and it's not obvious why this is correct.  Simplify things by
figuring out if a lock conversion is "upward" without relying on the
GLF_BLOCKING flag.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/lock_dlm.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/fs/gfs2/lock_dlm.c b/fs/gfs2/lock_dlm.c
index fa5134df985f..58aeeae7ed8c 100644
--- a/fs/gfs2/lock_dlm.c
+++ b/fs/gfs2/lock_dlm.c
@@ -224,8 +224,21 @@ static int make_mode(struct gfs2_sbd *sdp, const unsigned int lmstate)
 	return -1;
 }
 
+/* Taken from fs/dlm/lock.c. */
+
+static bool middle_conversion(int cur, int req)
+{
+	return (cur == DLM_LOCK_PR && req == DLM_LOCK_CW) ||
+	       (cur == DLM_LOCK_CW && req == DLM_LOCK_PR);
+}
+
+static bool down_conversion(int cur, int req)
+{
+	return !middle_conversion(cur, req) && req < cur;
+}
+
 static u32 make_flags(struct gfs2_glock *gl, const unsigned int gfs_flags,
-		      const int req)
+		      const int cur, const int req)
 {
 	u32 lkf = 0;
 
@@ -251,7 +264,14 @@ static u32 make_flags(struct gfs2_glock *gl, const unsigned int gfs_flags,
 
 	if (!test_bit(GLF_INITIAL, &gl->gl_flags)) {
 		lkf |= DLM_LKF_CONVERT;
-		if (test_bit(GLF_BLOCKING, &gl->gl_flags))
+
+		/*
+		 * The DLM_LKF_QUECVT flag needs to be set for "first come,
+		 * first served" semantics, but it must only be set for
+		 * "upward" lock conversions or else DLM will reject the
+		 * request as invalid.
+		 */
+		if (!down_conversion(cur, req))
 			lkf |= DLM_LKF_QUECVT;
 	}
 
@@ -271,13 +291,14 @@ static int gdlm_lock(struct gfs2_glock *gl, unsigned int req_state,
 		     unsigned int flags)
 {
 	struct lm_lockstruct *ls = &gl->gl_name.ln_sbd->sd_lockstruct;
-	int req;
+	int cur, req;
 	u32 lkf;
 	char strname[GDLM_STRNAME_BYTES] = "";
 	int error;
 
+	cur = make_mode(gl->gl_name.ln_sbd, gl->gl_state);
 	req = make_mode(gl->gl_name.ln_sbd, req_state);
-	lkf = make_flags(gl, flags, req);
+	lkf = make_flags(gl, flags, cur, req);
 	gfs2_glstats_inc(gl, GFS2_LKS_DCOUNT);
 	gfs2_sbstats_inc(gl, GFS2_LKS_DCOUNT);
 	if (test_bit(GLF_INITIAL, &gl->gl_flags)) {
-- 
2.46.2

