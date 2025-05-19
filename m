Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B9D1E5B7B
	for <gfs2@lists.linux.dev>; Mon, 19 May 2025 11:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747653562; cv=none; b=Lyrs3Vm3AFgllxG1iUuk92GjMjRYcUck4SSyVR+n2uUck+RY8kDMP6Zehfx3zHJP9rmKbMFRdbpcu2YnYll78oW4gTRWrU8hcMZV/9MLqcbdNHcmPYUiDBgSSkFMNXpV8hLvB1IKGHOFUbiwLyWbtdyGJuFJX1HjUdS2RuR8Vdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747653562; c=relaxed/simple;
	bh=nl3YkON8qBxw9vOPQHggl5+Dl4jsHdhf0Df0BVeR1Gw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=QuZXRdo4JjDDwhOkgGwH4xx0x51e3iO0MEisMWJwHegytzjwY4Sz3Irphix4B79611AXD2T5EP43agaY04drPtrrujkjTQ0s7fxzOFrLmhwkWXeiAq4Ho1XJCft8ksjYXRRxioikhlhGT00qZ1UfrsY+tUevgBkMVo43NPvCd/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=InM3BYJ+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="InM3BYJ+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747653559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C/WSipiLH4Kthg+cABOC5gBaXemchjq0Zb+yzwj/6N0=;
	b=InM3BYJ+s/V+FSdTtOkjzMvRB5ieP5OS90XyYgZgXHY/dmR/efW1Ay/wOGlG8XV0kvniX7
	n4ua1vXQWQp5ywCJhxukIZ2RrthGMUPiopy4j3PQbirdFORMGH41OAQYPymRlSsop9eDh4
	dx0VuuxvlSOS9U3/I3ZT6X3m5aFOf3E=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-384-zV2StvTAPZmb-TTXNvBnRw-1; Mon,
 19 May 2025 07:19:18 -0400
X-MC-Unique: zV2StvTAPZmb-TTXNvBnRw-1
X-Mimecast-MFC-AGG-ID: zV2StvTAPZmb-TTXNvBnRw_1747653557
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4DE3118001EA
	for <gfs2@lists.linux.dev>; Mon, 19 May 2025 11:19:17 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.234])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 28CA018004A7;
	Mon, 19 May 2025 11:19:15 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 5/6] gfs2: Get rid of duplicate log head lookup
Date: Mon, 19 May 2025 13:19:04 +0200
Message-ID: <20250519111906.1503215-6-agruenba@redhat.com>
In-Reply-To: <20250519111906.1503215-1-agruenba@redhat.com>
References: <20250519111906.1503215-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: SnKRugBCmVUMJDLr4EsG1feQd4Zg9-C0hk2U7o5SwAo_1747653557
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Currently at mount time, the recovery code looks up the current log head
and, if necessary, replays the log and writes a recovery header to
indicate that the log is clean.  It does that for each log that may need
recovery.  We also know that our own log will always be checked as part
of that process.  Then, the mount code looks up the log head of our own
log again.

The double log head lookup can be costly, but more importantly, it is
unnecessary because we can trivially compute the position of the log
head after recovery; all we need to do for that is bump the position and
lh_sequence by one when writing a recovery header.

With that in mind, move the call to gfs2_log_pointers_init() into
gfs2_recover_func() and get rid of the double lookup in
gfs2_make_fs_rw().

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/recovery.c |  3 +++
 fs/gfs2/super.c    | 15 +++------------
 2 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/fs/gfs2/recovery.c b/fs/gfs2/recovery.c
index 5e37574820b7..b3a11105df7c 100644
--- a/fs/gfs2/recovery.c
+++ b/fs/gfs2/recovery.c
@@ -530,6 +530,9 @@ void gfs2_recover_func(struct work_struct *work)
 			ktime_ms_delta(t_rep, t_tlck));
 	}
 
+	if (jd->jd_jid == sdp->sd_lockstruct.ls_jid)
+		gfs2_log_pointers_init(sdp, &head);
+
 	gfs2_recovery_done(sdp, jd->jd_jid, LM_RD_SUCCESS);
 
 	if (jlocked) {
diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index b55aa38a485a..a9af02ef580d 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -134,27 +134,18 @@ int gfs2_make_fs_rw(struct gfs2_sbd *sdp)
 {
 	struct gfs2_inode *ip = GFS2_I(sdp->sd_jdesc->jd_inode);
 	struct gfs2_glock *j_gl = ip->i_gl;
-	struct gfs2_log_header_host head;
 	int error;
 
 	j_gl->gl_ops->go_inval(j_gl, DIO_METADATA);
 	if (gfs2_withdrawing_or_withdrawn(sdp))
 		return -EIO;
 
-	error = gfs2_find_jhead(sdp->sd_jdesc, &head, false);
-	if (error) {
-		gfs2_consist(sdp);
-		return error;
-	}
-
-	if (!(head.lh_flags & GFS2_LOG_HEAD_UNMOUNT)) {
-		gfs2_consist(sdp);
+	if (sdp->sd_log_sequence == 0) {
+		fs_err(sdp, "unknown status of our own journal jid %d",
+		       sdp->sd_lockstruct.ls_jid);
 		return -EIO;
 	}
 
-	/*  Initialize some head of the log stuff  */
-	gfs2_log_pointers_init(sdp, &head);
-
 	error = gfs2_quota_init(sdp);
 	if (!error && gfs2_withdrawing_or_withdrawn(sdp))
 		error = -EIO;
-- 
2.49.0

