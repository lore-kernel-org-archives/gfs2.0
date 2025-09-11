Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3D82E541E
	for <gfs2@lists.linux.dev>; Thu, 11 Sep 2025 13:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757599084; cv=none; b=XFsEZi32v+zMHq+X5jI/au4flC+7Tr+y17R7AxfKKTk+CMR5yl5z30kBjbjuKCstO+4FvT025wyCmK2wkwZkZpxlknW38z+XDS44cLvZ4qNWA6e1z70kFLnhdNPp7F/SjCWPh0J7320MkUatoQg3btLOqUep0a0Odcz78xxqrXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757599084; c=relaxed/simple;
	bh=C0WuuOag7l2fjTphnmjHRHYoJ+ofljjkF9Lc48w9avg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=SMIESKogmcSxVUU/tPsACb3st1W4aN/vy4c4HkGEUmOgK7HZU/dL5TYdIT4paFTaqLRYH/qVRAGJ+bBFCa9h0v80xdJewl1zXaAQJW/4Qh5N9LyLcCT+sJSRZCrcaMhOteox7GHUWqO2ZMvRpGB5gBqRhgt/CpM/OYVD1r4I4JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FiPoOpM4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FiPoOpM4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757599082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xZPUUudtjM6F19XpTJc4gec/GuL2ib9AAsAFBLCpQWo=;
	b=FiPoOpM4PGC7SqhMX1VOGtfc2zgxZrhoAvxHAzo17MC9MQF+Jz62VLkt+QeyYBcn3n/XRE
	bu/1eZGqy/ZorDonSnc21cXgS6RGWeWB0W9/WGDOqJNWDqKEgJ02Dq8vXwM7KAtNrPwqwb
	Cg4lRimg5ShAvPQql9zyAGhog7boc0Y=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-27-idS1T8mgNgW4yCM41kPGjA-1; Thu,
 11 Sep 2025 09:58:01 -0400
X-MC-Unique: idS1T8mgNgW4yCM41kPGjA-1
X-Mimecast-MFC-AGG-ID: idS1T8mgNgW4yCM41kPGjA_1757599080
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3BD2A1956087
	for <gfs2@lists.linux.dev>; Thu, 11 Sep 2025 13:58:00 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.44.32.31])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E747619560BE;
	Thu, 11 Sep 2025 13:57:58 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 17/20] gfs2: run_queue cleanup
Date: Thu, 11 Sep 2025 15:57:22 +0200
Message-ID: <20250911135726.657575-18-agruenba@redhat.com>
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
X-Mimecast-MFC-PROC-ID: m9eAk3PSnS3K7OoiiueUncTSCQLECcV0qocUwv4CsKk_1757599080
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Transform the code in run_queue() to make it more readable.  No change
in functionality.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/glock.c | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 38f320e13a36..1eba27bb5f3c 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -835,8 +835,12 @@ __acquires(&gl->gl_lockref.lock)
 	/* While a demote is in progress, the GLF_LOCK flag must be set. */
 	GLOCK_BUG_ON(gl, test_bit(GLF_DEMOTE_IN_PROGRESS, &gl->gl_flags));
 
-	if (test_bit(GLF_DEMOTE, &gl->gl_flags) &&
-	    gl->gl_demote_state != gl->gl_state) {
+	if (test_bit(GLF_DEMOTE, &gl->gl_flags)) {
+		if (gl->gl_demote_state == gl->gl_state) {
+			gfs2_demote_wake(gl);
+			goto promote;
+		}
+
 		if (find_first_holder(gl))
 			goto out_unlock;
 		if (nonblock)
@@ -846,22 +850,21 @@ __acquires(&gl->gl_lockref.lock)
 		gl->gl_target = gl->gl_demote_state;
 		do_xmote(gl, NULL, gl->gl_target);
 		return;
-	} else {
-		if (test_bit(GLF_DEMOTE, &gl->gl_flags))
-			gfs2_demote_wake(gl);
-		do_promote(gl);
-		if (find_first_holder(gl))
-			goto out_unlock;
-		gh = find_first_waiter(gl);
-		if (!gh)
-			goto out_unlock;
-		gl->gl_target = gh->gh_state;
-		if (!(gh->gh_flags & (LM_FLAG_TRY | LM_FLAG_TRY_1CB)))
-			do_error(gl, 0); /* Fail queued try locks */
-		do_xmote(gl, gh, gl->gl_target);
-		return;
 	}
 
+promote:
+	do_promote(gl);
+	if (find_first_holder(gl))
+		goto out_unlock;
+	gh = find_first_waiter(gl);
+	if (!gh)
+		goto out_unlock;
+	gl->gl_target = gh->gh_state;
+	if (!(gh->gh_flags & (LM_FLAG_TRY | LM_FLAG_TRY_1CB)))
+		do_error(gl, 0); /* Fail queued try locks */
+	do_xmote(gl, gh, gl->gl_target);
+	return;
+
 out_sched:
 	clear_bit(GLF_LOCK, &gl->gl_flags);
 	gl->gl_lockref.count++;
-- 
2.51.0

