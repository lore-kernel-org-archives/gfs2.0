Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CC532C316
	for <gfs2@lists.linux.dev>; Thu, 11 Sep 2025 13:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757599066; cv=none; b=OSPUPaNZL4Q3z+xB/Il0K7KCezDRZWNxNlGptgCu6X/vjwmPUPxWaWFjzJPGZelVd+VtM0siu9pheEwK0VCLNkv7Pi/Mhb4B8z5qRINIlb4SPE9iC3wY8HbzasLrkQlvhdR5TOCzWHY4gtU2CX/o7gQEEDY5b1Yi9hCQSjD97Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757599066; c=relaxed/simple;
	bh=36dn1cURywB7AEOAEJN0UDR48JofgQLs9KYglrJIvGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=lSNFQw8bnzrAnpvUT2khJdyiXoYLpkamawfOueCK4Tecik3tgxLjH8j1CHqq1s16+kW+QZFQYCediyJAIt6AnDDLtg0ByaCShF+jOyUivEQMJ6QelPPEzxIjaziaRle3qrdIwta/GuE2I8m8PWkDjq4LBKdyb3MptXC+6MzTf54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iwEXlwEV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iwEXlwEV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757599063;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u2fBDs0R2gdGu3RXRLvENys/q8nzISS1KQfGOEAL9MI=;
	b=iwEXlwEVfoXajBwfOQe+pilohWw3ZvDu1GEKL1g4/LkmgmQgf4EHwVn9sVxzcRD/4ra8kK
	SC5ofgAUZjsaPenc06eoTza9QrH57lMsJuZE8jimP9zNbo53MXkt8j3NZK8KMcFK4Xevwh
	38Q3Bfq0blN2ZcOsXyjqdje/OcK9/YQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-460-1ftmZaxXM8an1ZfargOr1g-1; Thu,
 11 Sep 2025 09:57:42 -0400
X-MC-Unique: 1ftmZaxXM8an1ZfargOr1g-1
X-Mimecast-MFC-AGG-ID: 1ftmZaxXM8an1ZfargOr1g_1757599062
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ECB7F180057A
	for <gfs2@lists.linux.dev>; Thu, 11 Sep 2025 13:57:41 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.44.32.31])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AF64719560B1;
	Thu, 11 Sep 2025 13:57:40 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 07/20] gfs2: Turn gfs2_withdraw into a void function
Date: Thu, 11 Sep 2025 15:57:12 +0200
Message-ID: <20250911135726.657575-8-agruenba@redhat.com>
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
X-Mimecast-MFC-PROC-ID: lRYIZXFkJigzMrJlwfVFGGrHI4bZPubdCdRNCSWppWc_1757599062
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Since commit 601ef0d52e96 ("gfs2: Force withdraw to replay journals and
wait for it to finish"), gfs2_withdraw() always returns -1, so turn it
into a straight void function.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/util.c | 21 ++++++++-------------
 fs/gfs2/util.h |  2 +-
 2 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/fs/gfs2/util.c b/fs/gfs2/util.c
index 24864a66074b..020dd21ad51e 100644
--- a/fs/gfs2/util.c
+++ b/fs/gfs2/util.c
@@ -309,7 +309,7 @@ void gfs2_lm(struct gfs2_sbd *sdp, const char *fmt, ...)
 	va_end(args);
 }
 
-int gfs2_withdraw(struct gfs2_sbd *sdp)
+void gfs2_withdraw(struct gfs2_sbd *sdp)
 {
 	struct lm_lockstruct *ls = &sdp->sd_lockstruct;
 	const struct lm_lockops *lm = ls->ls_ops;
@@ -322,7 +322,7 @@ int gfs2_withdraw(struct gfs2_sbd *sdp)
 				wait_on_bit(&sdp->sd_flags,
 					    SDF_WITHDRAW_IN_PROG,
 					    TASK_UNINTERRUPTIBLE);
-				return -1;
+				return;
 			}
 			new = old | BIT(SDF_WITHDRAWN) | BIT(SDF_WITHDRAW_IN_PROG);
 		} while (unlikely(!try_cmpxchg(&sdp->sd_flags, &old, new)));
@@ -350,8 +350,6 @@ int gfs2_withdraw(struct gfs2_sbd *sdp)
 
 	if (sdp->sd_args.ar_errors == GFS2_ERRORS_PANIC)
 		panic("GFS2: fsid=%s: panic requested\n", sdp->sd_fsname);
-
-	return -1;
 }
 
 /*
@@ -481,16 +479,14 @@ int gfs2_meta_check_ii(struct gfs2_sbd *sdp, struct buffer_head *bh,
 		       const char *function, char *file,
 		       unsigned int line)
 {
-	int me;
-
 	gfs2_lm(sdp,
 		"fatal: invalid metadata block - "
 		"bh = %llu (bad magic number), "
 		"function = %s, file = %s, line = %u\n",
 		(unsigned long long)bh->b_blocknr,
 		function, file, line);
-	me = gfs2_withdraw(sdp);
-	return (me) ? -1 : -2;
+	gfs2_withdraw(sdp);
+	return -1;
 }
 
 /*
@@ -503,16 +499,14 @@ int gfs2_metatype_check_ii(struct gfs2_sbd *sdp, struct buffer_head *bh,
 			   u16 type, u16 t, const char *function,
 			   char *file, unsigned int line)
 {
-	int me;
-
 	gfs2_lm(sdp,
 		"fatal: invalid metadata block - "
 		"bh = %llu (type: exp=%u, found=%u), "
 		"function = %s, file = %s, line = %u\n",
 		(unsigned long long)bh->b_blocknr, type, t,
 		function, file, line);
-	me = gfs2_withdraw(sdp);
-	return (me) ? -1 : -2;
+	gfs2_withdraw(sdp);
+	return -1;
 }
 
 /*
@@ -528,7 +522,8 @@ int gfs2_io_error_i(struct gfs2_sbd *sdp, const char *function, char *file,
 		"fatal: I/O error - "
 		"function = %s, file = %s, line = %u\n",
 		function, file, line);
-	return gfs2_withdraw(sdp);
+	gfs2_withdraw(sdp);
+	return -1;
 }
 
 /*
diff --git a/fs/gfs2/util.h b/fs/gfs2/util.h
index 27d03b641024..2a8a1fac611a 100644
--- a/fs/gfs2/util.h
+++ b/fs/gfs2/util.h
@@ -228,6 +228,6 @@ gfs2_tune_get_i(&(sdp)->sd_tune, &(sdp)->sd_tune.field)
 
 __printf(2, 3)
 void gfs2_lm(struct gfs2_sbd *sdp, const char *fmt, ...);
-int gfs2_withdraw(struct gfs2_sbd *sdp);
+void gfs2_withdraw(struct gfs2_sbd *sdp);
 
 #endif /* __UTIL_DOT_H__ */
-- 
2.51.0

