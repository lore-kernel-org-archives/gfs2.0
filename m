Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F3415E83
	for <gfs2@lists.linux.dev>; Wed,  1 Nov 2023 16:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DJAPGiow"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698857179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=thpZTGlNrvFkwJHTonairpOo313JgBpF1UOhHkz49Lk=;
	b=DJAPGiowZ3Y2rkyaaFip5MOqYGje3eUO0z0L6CG8VHh76mB8hM5uzVg0vSAOWlbhKdV1EW
	tvbRD1Dvub4duK8E4l1JGTxLUO8lCzy7nMK9udNVn8ioBtFVjrwGgOgMESPTxA3qLRmlvm
	sxG1KWtBE6Pl93C1J/LZou/I2FwQEnQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-304-MGAvBvmnOd67ryMCX1srHQ-1; Wed,
 01 Nov 2023 12:46:18 -0400
X-MC-Unique: MGAvBvmnOd67ryMCX1srHQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EE0B13C1F123
	for <gfs2@lists.linux.dev>; Wed,  1 Nov 2023 16:46:17 +0000 (UTC)
Received: from pasta.redhat.com (unknown [10.45.224.27])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 700B540C6EBC;
	Wed,  1 Nov 2023 16:46:17 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 01/25] gfs2: Simplify function gfs2_upgrade_iopen_glock
Date: Wed,  1 Nov 2023 17:45:51 +0100
Message-ID: <20231101164615.1138692-2-agruenba@redhat.com>
In-Reply-To: <20231101164615.1138692-1-agruenba@redhat.com>
References: <20231101164615.1138692-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
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
---
 fs/gfs2/super.c | 10 ----------
 1 file changed, 10 deletions(-)

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
-- 
2.41.0

