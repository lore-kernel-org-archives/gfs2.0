Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A9E141987
	for <gfs2@lists.linux.dev>; Wed, 25 Sep 2024 22:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727301832; cv=none; b=cKD8FqoIc7jFRXQyqkA+5jWQJM2ugpzso4xzQuJduBdYg9xtRXSDCiho5LPSWw6nt7IqZhFjbxY3yQj66m8lS1NZ3we5TqypFw6Qao+WCqeiaTLCfOzUaHlHndmRmOpau5Y0lx5Qbkw3/vfr2RhJxZhlJ3CezsXXFONm6ch5KHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727301832; c=relaxed/simple;
	bh=fpqjWbaiEMsRuXqDWLOITvL3Mc+WqjGFQhCSGAIayTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q5iePDZ7bqMvQnf+uZhDMNfGdkSQLLNCVrJgZsOtDOsaZdj6Gt1aLxnGNn2CAJKBTYyP/OV29QbOSi0R4tle7gqCabcU7gcVliwRUjzCoTw9Oy5H9RuFq7c0cvdizBnnVPtnD5jV5100e6qYyoQHyCnoB1EwCw9pa8q1Ql/UNQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MIEOBs4u; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MIEOBs4u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727301829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A8YF1hcs09T0vNbkJEIsJMuNWwpvWI2raQJ9C+kcVEA=;
	b=MIEOBs4uQ6NkdA047hGuUKuVyM1k4vb9U+WgX4oYS3nuvHn2L2QtndWvz6KbFiZjKXLk75
	B+ACEmbhGFi4GfVFJoXm+gWqM9kpeLryYGDYpZ0rDDjnjAGgzzb85eT6eMhPIPjoBVK+d3
	x/8hBJbV0LI6NtnjrPhHBXA44wql69w=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-657-vvgfNdeIMMSd_CKGrQ_wXQ-1; Wed,
 25 Sep 2024 18:03:48 -0400
X-MC-Unique: vvgfNdeIMMSd_CKGrQ_wXQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 167B619344B3
	for <gfs2@lists.linux.dev>; Wed, 25 Sep 2024 22:03:48 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.77])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1C27319560AA;
	Wed, 25 Sep 2024 22:03:46 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 08/16] gfs2: Return enum evict_behavior from gfs2_upgrade_iopen_glock
Date: Thu, 26 Sep 2024 00:03:18 +0200
Message-ID: <20240925220331.417856-9-agruenba@redhat.com>
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

In case an iopen glock cannot be upgraded, function
gfs2_upgrade_iopen_glock() needs to communicate to gfs2_evict_inode()
whether deleting the inode should be deferred or skipped altogether.
Change the function to return the appropriate enum evict_behavior value
to indicate that.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/super.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index bfe822827bbd..55cbe672d42e 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -1257,7 +1257,7 @@ static void gfs2_glock_put_eventually(struct gfs2_glock *gl)
 		gfs2_glock_put(gl);
 }
 
-static bool gfs2_upgrade_iopen_glock(struct inode *inode)
+static enum evict_behavior gfs2_upgrade_iopen_glock(struct inode *inode)
 {
 	struct gfs2_inode *ip = GFS2_I(inode);
 	struct gfs2_sbd *sdp = GFS2_SB(inode);
@@ -1290,7 +1290,7 @@ static bool gfs2_upgrade_iopen_glock(struct inode *inode)
 	gfs2_holder_reinit(LM_ST_EXCLUSIVE, GL_ASYNC | GL_NOCACHE, gh);
 	error = gfs2_glock_nq(gh);
 	if (error)
-		return false;
+		return EVICT_SHOULD_SKIP_DELETE;
 
 	wait_event_interruptible_timeout(sdp->sd_async_glock_wait,
 		!test_bit(HIF_WAIT, &gh->gh_iflags) ||
@@ -1298,9 +1298,14 @@ static bool gfs2_upgrade_iopen_glock(struct inode *inode)
 		5 * HZ);
 	if (!test_bit(HIF_HOLDER, &gh->gh_iflags)) {
 		gfs2_glock_dq(gh);
-		return false;
+		if (glock_needs_demote(ip->i_gl))
+			return EVICT_SHOULD_SKIP_DELETE;
+		return EVICT_SHOULD_DEFER_DELETE;
 	}
-	return gfs2_glock_holder_ready(gh) == 0;
+	error = gfs2_glock_holder_ready(gh);
+	if (error)
+		return EVICT_SHOULD_SKIP_DELETE;
+	return EVICT_SHOULD_DELETE;
 }
 
 /**
@@ -1359,9 +1364,12 @@ static enum evict_behavior evict_should_delete(struct inode *inode,
 should_delete:
 	if (gfs2_holder_initialized(&ip->i_iopen_gh) &&
 	    test_bit(HIF_HOLDER, &ip->i_iopen_gh.gh_iflags)) {
-		if (!gfs2_upgrade_iopen_glock(inode)) {
+		enum evict_behavior behavior =
+			gfs2_upgrade_iopen_glock(inode);
+
+		if (behavior != EVICT_SHOULD_DELETE) {
 			gfs2_holder_uninit(&ip->i_iopen_gh);
-			return EVICT_SHOULD_SKIP_DELETE;
+			return behavior;
 		}
 	}
 	return EVICT_SHOULD_DELETE;
-- 
2.46.0

