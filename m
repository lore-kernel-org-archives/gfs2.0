Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B75B182D1
	for <gfs2@lists.linux.dev>; Tue, 12 Sep 2023 14:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694528405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zF4TDMv1cij08S7/E9jNY87oZn4OaX2aZefE2BROOzs=;
	b=iq78cq9GJfjin7779nF7t+3/0wGiKiRaouLj86D6UZetBRyTHJpZDkazLjTfyqXF/OQmA7
	VXgGJFWgLnLcGKAyk0yoNBQhxxtpnAQ/XlvNjIatYttT8YG4Dt718wDCNmwf0hXlGSN+7E
	sP5/smQUNc3bk701akU8srILxo0dtXs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-606-qHMMCkOKNV63P9xm4XtYzg-1; Tue, 12 Sep 2023 10:20:03 -0400
X-MC-Unique: qHMMCkOKNV63P9xm4XtYzg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 70E3429AB435
	for <gfs2@lists.linux.dev>; Tue, 12 Sep 2023 14:20:03 +0000 (UTC)
Received: from pasta.redhat.com (unknown [10.45.226.29])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E7E9D10F1BE8;
	Tue, 12 Sep 2023 14:20:02 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH] gfs2: Fix another freeze/thaw hang
Date: Tue, 12 Sep 2023 16:20:02 +0200
Message-Id: <20230912142002.2613821-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

On a thawed filesystem, the freeze glock is held in shared mode.  In
order to initiate a cluster-wide freeze, the node initiating the freeze
drops the freeze glock and grabs it in exclusive mode.  The other nodes
recognize this as contention on the freeze glock; function
freeze_go_callback is invoked.  This indicates to them that they must
freeze the filesystem locally, drop the freeze glock, and then
re-acquire it in shared mode before being able to unfreeze the
filesystem locally.

While a node is trying to re-acquire the freeze glock in shared mode,
additional contention can occur.  In that case, the node must behave in
the same way as above.

Unfortunately, freeze_go_callback() contains a check that causes it to
bail out when the freeze glock isn't held in shared mode.  Fix that to
allow the glock to be unlocked or held in shared mode.

In addition, update a reference to trylock_super() which has been
renamed to super_trylock_shared() in the meantime.

Fixes: b77b4a4815a9 ("gfs2: Rework freeze / thaw logic")
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/glops.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/gfs2/glops.c b/fs/gfs2/glops.c
index 3d6f56fc85b9..5f845fd9f13a 100644
--- a/fs/gfs2/glops.c
+++ b/fs/gfs2/glops.c
@@ -567,15 +567,16 @@ static void freeze_go_callback(struct gfs2_glock *gl, bool remote)
 	struct super_block *sb = sdp->sd_vfs;
 
 	if (!remote ||
-	    gl->gl_state != LM_ST_SHARED ||
+	    (gl->gl_state != LM_ST_SHARED &&
+	     gl->gl_state != LM_ST_UNLOCKED) ||
 	    gl->gl_demote_state != LM_ST_UNLOCKED)
 		return;
 
 	/*
 	 * Try to get an active super block reference to prevent racing with
-	 * unmount (see trylock_super()).  But note that unmount isn't the only
-	 * place where a write lock on s_umount is taken, and we can fail here
-	 * because of things like remount as well.
+	 * unmount (see super_trylock_shared()).  But note that unmount isn't
+	 * the only place where a write lock on s_umount is taken, and we can
+	 * fail here because of things like remount as well.
 	 */
 	if (down_read_trylock(&sb->s_umount)) {
 		atomic_inc(&sb->s_active);
-- 
2.40.1

