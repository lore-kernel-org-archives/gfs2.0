Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D67414008
	for <gfs2@lists.linux.dev>; Thu,  7 Sep 2023 20:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694117353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WIrfVYR5e+yZJiHlO1Qe+CJv6UyG5pe1DFg57B6pxrE=;
	b=d868gE+CSbl/ZKEYuKhpGPYVTq1DYyCGWVwrwx4NbFBkiLBNDnb+EPDzj+Op67lEbgm8J6
	PWJhVtJU17D9jLhSOeUNsQCsnTchv+Z9glAiOLrXA+L3/tHIYmKNkoqtIRC4JAc1drzYA9
	52/OLyw22CPNlnSpRhzkzZYJNI7uyRQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-193-vofF866ZO5utdoIDVMlmEA-1; Thu, 07 Sep 2023 16:09:12 -0400
X-MC-Unique: vofF866ZO5utdoIDVMlmEA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1D292800888
	for <gfs2@lists.linux.dev>; Thu,  7 Sep 2023 20:09:12 +0000 (UTC)
Received: from pasta.redhat.com (unknown [10.45.224.39])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 94DE01460FE5;
	Thu,  7 Sep 2023 20:09:11 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH] gfs2: Simplify function gfs2_upgrade_iopen_glock
Date: Thu,  7 Sep 2023 22:09:10 +0200
Message-Id: <20230907200910.2085025-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

When trying to upgrade the iopen glock, gfs2_upgrade_iopen_glock() tries
to take the iopen glock with the LM_FLAG_TRY_1CB flag set before trying
to take it without the LM_FLAG_TRY or LM_FLAG_TRY_1CB flags set.  Both
calls will cause the lock contention bast callbacks to be invoked
throughout the cluster, and we really don't need them to be invoked
twice.  Remove the first LM_FLAG_TRY_1CB call to eliminate unnecessary
dlm traffic.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>

diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index 02d93da21b2b..3141db77189e 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -1299,18 +1299,8 @@ static bool gfs2_upgrade_iopen_glock(struct inode *inode)
 	 * As a last resort, if another node keeps holding the iopen glock
 	 * without showing any activity on the inode glock, we will eventually
 	 * time out and fail the iopen glock upgrade.
-	 *
-	 * Note that we're passing the LM_FLAG_TRY_1CB flag to the first
-	 * locking request as an optimization to notify lock holders as soon as
-	 * possible.  Without that flag, they'd be notified implicitly by the
-	 * second locking request.
 	 */
 
-	gfs2_holder_reinit(LM_ST_EXCLUSIVE, LM_FLAG_TRY_1CB | GL_NOCACHE, gh);
-	error = gfs2_glock_nq(gh);
-	if (error != GLR_TRYFAILED)
-		return !error;
-
 	gfs2_holder_reinit(LM_ST_EXCLUSIVE, GL_ASYNC | GL_NOCACHE, gh);
 	error = gfs2_glock_nq(gh);
 	if (error)

