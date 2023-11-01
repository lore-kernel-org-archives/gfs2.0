Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E4315E85
	for <gfs2@lists.linux.dev>; Wed,  1 Nov 2023 16:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S5XqbFBa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698857183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Jkm4uqiN36nnGnqzCgnDXcpu1on5sXiXyR+a6lGrvE=;
	b=S5XqbFBa9Tojnka1kVXZCPBdOLBWPL/LtjRVuGX1RqD0xoMxjydT80lfLK7deWHd4185F+
	zWCoLg+4rEN0wOG8TuNr6gzKWPS/ZvcW+Z0HrE1giT3M5m9R/o8f7UVxpMG/Ldo06Bh3P7
	lluxApQ9FH61jK9ken07XjA6/dqkDQw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-453-zuF7ZFp7Mr-Ah2I4RbMJNA-1; Wed,
 01 Nov 2023 12:46:19 -0400
X-MC-Unique: zuF7ZFp7Mr-Ah2I4RbMJNA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B7C2728EA6FA
	for <gfs2@lists.linux.dev>; Wed,  1 Nov 2023 16:46:18 +0000 (UTC)
Received: from pasta.redhat.com (unknown [10.45.224.27])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 35C2740C6EBF;
	Wed,  1 Nov 2023 16:46:18 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 02/25] gfs2: Remove freeze_go_demote_ok
Date: Wed,  1 Nov 2023 17:45:52 +0100
Message-ID: <20231101164615.1138692-3-agruenba@redhat.com>
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

Before commit b77b4a4815a9 ("gfs2: Rework freeze / thaw logic"), the
freeze glock was kept around in the glock cache in shared mode without
being actively held while a filesystem is in thawed state.  In that
state, memory pressure could have eventually evicted the freeze glock,
and the freeze_go_demote_ok callback was needed to prevent that from
happening.

With the freeze / thaw rework, the freeze glock is now always actively
held in shared mode while a filesystem is thawed, and the
freeze_go_demote_ok hack is no longer needed.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/glops.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/fs/gfs2/glops.c b/fs/gfs2/glops.c
index f41ca89d216b..5f845fd9f13a 100644
--- a/fs/gfs2/glops.c
+++ b/fs/gfs2/glops.c
@@ -613,18 +613,6 @@ static int freeze_go_xmote_bh(struct gfs2_glock *gl)
 	return 0;
 }
 
-/**
- * freeze_go_demote_ok
- * @gl: the glock
- *
- * Always returns 0
- */
-
-static int freeze_go_demote_ok(const struct gfs2_glock *gl)
-{
-	return 0;
-}
-
 /**
  * iopen_go_callback - schedule the dcache entry for the inode to be deleted
  * @gl: the glock
@@ -744,7 +732,6 @@ const struct gfs2_glock_operations gfs2_rgrp_glops = {
 
 const struct gfs2_glock_operations gfs2_freeze_glops = {
 	.go_xmote_bh = freeze_go_xmote_bh,
-	.go_demote_ok = freeze_go_demote_ok,
 	.go_callback = freeze_go_callback,
 	.go_type = LM_TYPE_NONDISK,
 	.go_flags = GLOF_NONDISK,
-- 
2.41.0

