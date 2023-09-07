Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9713814008
	for <gfs2@lists.linux.dev>; Thu,  7 Sep 2023 20:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694117411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=exxQGD29WGViAfu/1wf8HcYDdzW2qIsxXGhyLrB4GU8=;
	b=Vw+GYDUX0wlwr9SaRNpJWlR3+OjTaVk1aGIh1ZHwGfN73s/tuH8hiT7MQEfwO5QsuEnET9
	l7gM28kVJ4DD5fsQIQNEvB/v6laWCGlpETJ1Q6X5Cu6UphA8tIjKsTDZ99YYor69SiyyMg
	A4eZJcBTla31XhzFrTqXUDHf3O8RSp4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-468-KGkW0vhUNwm617YJ1nQxww-1; Thu, 07 Sep 2023 16:10:09 -0400
X-MC-Unique: KGkW0vhUNwm617YJ1nQxww-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 91999800888
	for <gfs2@lists.linux.dev>; Thu,  7 Sep 2023 20:10:09 +0000 (UTC)
Received: from pasta.redhat.com (unknown [10.45.224.39])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 13E372026D76;
	Thu,  7 Sep 2023 20:10:08 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH] gfs2: Remove freeze_go_demote_ok
Date: Thu,  7 Sep 2023 22:10:08 +0200
Message-Id: <20230907201008.2085081-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
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

diff --git a/fs/gfs2/glops.c b/fs/gfs2/glops.c
index d26759a98b10..3d6f56fc85b9 100644
--- a/fs/gfs2/glops.c
+++ b/fs/gfs2/glops.c
@@ -612,18 +612,6 @@ static int freeze_go_xmote_bh(struct gfs2_glock *gl)
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
@@ -743,7 +731,6 @@ const struct gfs2_glock_operations gfs2_rgrp_glops = {
 
 const struct gfs2_glock_operations gfs2_freeze_glops = {
 	.go_xmote_bh = freeze_go_xmote_bh,
-	.go_demote_ok = freeze_go_demote_ok,
 	.go_callback = freeze_go_callback,
 	.go_type = LM_TYPE_NONDISK,
 	.go_flags = GLOF_NONDISK,

