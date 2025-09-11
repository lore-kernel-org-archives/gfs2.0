Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78FA27F747
	for <gfs2@lists.linux.dev>; Thu, 11 Sep 2025 13:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757599077; cv=none; b=fnx80X+nwmywppq4QSkd62DUOHaBSuqT8UWIGUB4YbgJ60khU7F5ZCsx2Z1+h7jystP8ua4FG2vXF+TCLszTVojmAW7cPe7jv/a8ztYgyYX0WRh6g7Ie2Ut0gyFdqnLpvR8VE612PMwHTDvdF12PYyZE9chuMMrRvs+j4ep778E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757599077; c=relaxed/simple;
	bh=ypsem35gYpOUTYecq1DRDnsXQ2LNtidp2qrDHClO9uw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=AQGmeAGA4rxPrlof7nrAIUnwiuDu256VdysCiNtHKsuDbiRew59AVD4nnZxv6NcLnH3A53lQ0HXpBZ3gA4WbMeYmNXDCx4awrKtl4dKRt55Z2jGS7fmCbs8myFocDepMrtOkBVocVfyGep8tsFGhlvHHw+BSSfNXUTJnuy2moa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SJnN0mM0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SJnN0mM0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757599074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aOJHLUIq+ir9Ug8LuylYzgvygrUAgSGehDWu8X1PaDA=;
	b=SJnN0mM0L4w6jkxGwIp6bPR52ivJac2JmQeDZdGHhp3kLo2eA40+xF894OX4O4qS+UVUUQ
	Otp87YG4O5IzBXivv+Z7zSqKUZ8RqZefcYHfaRrM1cQXnJ/lRhqRQRKU2nGzdObPKUdo/G
	Pr7qTEOcEqRMNkjYI/qo27D85zrt3UM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-111-E-wpRhAWMmy8Em3FA72mPQ-1; Thu,
 11 Sep 2025 09:57:53 -0400
X-MC-Unique: E-wpRhAWMmy8Em3FA72mPQ-1
X-Mimecast-MFC-AGG-ID: E-wpRhAWMmy8Em3FA72mPQ_1757599072
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C95FC1955E9E
	for <gfs2@lists.linux.dev>; Thu, 11 Sep 2025 13:57:52 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.44.32.31])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8BB8A19560B1;
	Thu, 11 Sep 2025 13:57:51 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 13/20] gfs2: Remove duplicate check in do_xmote
Date: Thu, 11 Sep 2025 15:57:18 +0200
Message-ID: <20250911135726.657575-14-agruenba@redhat.com>
In-Reply-To: <20250911135726.657575-1-agruenba@redhat.com>
References: <20250911135726.657575-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yG54CnWWnYiH1ha8H2Ji0dgM2fK8W1o_h2jfYTzQwl8_1757599072
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

In do_xmote(), remove the duplicate check for the ->go_sync and
->go_inval glock operations.  They are either both defined, or none of
them are.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/glock.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index e754214fdb1c..15a90ab8a979 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -714,25 +714,24 @@ __acquires(&gl->gl_lockref.lock)
 				     &gl->gl_flags))
 			return;
 	}
-	if (!glops->go_inval && !glops->go_sync)
+	if (!glops->go_inval || !glops->go_sync)
 		goto skip_inval;
 
 	spin_unlock(&gl->gl_lockref.lock);
-	if (glops->go_sync) {
-		ret = glops->go_sync(gl);
-		/* If we had a problem syncing (due to io errors or whatever,
-		 * we should not invalidate the metadata or tell dlm to
-		 * release the glock to other nodes.
-		 */
-		if (ret) {
-			if (cmpxchg(&sdp->sd_log_error, 0, ret)) {
-				fs_err(sdp, "Error %d syncing glock\n", ret);
-				gfs2_dump_glock(NULL, gl, true);
-			}
-			spin_lock(&gl->gl_lockref.lock);
-			goto skip_inval;
+	ret = glops->go_sync(gl);
+	/* If we had a problem syncing (due to io errors or whatever,
+	 * we should not invalidate the metadata or tell dlm to
+	 * release the glock to other nodes.
+	 */
+	if (ret) {
+		if (cmpxchg(&sdp->sd_log_error, 0, ret)) {
+			fs_err(sdp, "Error %d syncing glock\n", ret);
+			gfs2_dump_glock(NULL, gl, true);
 		}
+		spin_lock(&gl->gl_lockref.lock);
+		goto skip_inval;
 	}
+
 	if (test_bit(GLF_INVALIDATE_IN_PROGRESS, &gl->gl_flags)) {
 		/*
 		 * The call to go_sync should have cleared out the ail list.
-- 
2.51.0

