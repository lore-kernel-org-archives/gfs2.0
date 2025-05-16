Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A23C22DFF3
	for <gfs2@lists.linux.dev>; Fri, 16 May 2025 21:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747432120; cv=none; b=hXbW2OxhsO1XC9ZtfpvP68Zj3KUsk3ql/UGequJ+zNG96yR8l8SGLBUILt/KCWo8CA20dEqEKOo8D3K4AMhLhZV/E7Gkkm9n6ft65PqiFO0OZ03d+Wq+5U7/vaVh3Gq5BROjRnjy/1Y6NMM6IzZ/Pjx7SmGVB7zLRXiBpM93xbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747432120; c=relaxed/simple;
	bh=TO1GFJ/YJsduPUwM5AS+lo344GEU8TyLqOqEPvLci8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=XDk2fOTcGgBWM9g9uX9nBt5HHRGGRGF9t5S17k30hUrl3D2FVKvN1HI2P4nNULNjU+nGkN6k48GGbn0KaGXcWbke2GJihlzqZkebt6JMmYZS6iFG44aHkwWS6JJQFH+glJgcxwmYijUUJwpZ64wd03vWzdG2iXuGWLciTh2ksJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XHaNY5lx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XHaNY5lx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747432117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rrXNpMf7iEAvA05zh3VVXbZ9WNV3qovtT7VT5KUL1BI=;
	b=XHaNY5lxKEDTtcOHtgCHbT3FflKxuos6k5s01BPZ1ToWk23/yMgJuAVrdlBE5Fp1eO5Ra3
	oZD5A3xx03EN3AkRFKduGLf0sCUXobrIoOVICdU33Qn839wVmyYpYI9gIuDFFFBCn5yqdi
	kKu2Ww4guA+VFGWY7HSlWcfKZl6rq9o=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-460-XtADGBs6NcCU9y-evNMfRA-1; Fri,
 16 May 2025 17:48:36 -0400
X-MC-Unique: XtADGBs6NcCU9y-evNMfRA-1
X-Mimecast-MFC-AGG-ID: XtADGBs6NcCU9y-evNMfRA_1747432115
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DCC4618004AD;
	Fri, 16 May 2025 21:48:34 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.234])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6BD28195608D;
	Fri, 16 May 2025 21:48:33 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 3/3] gfs2: Don't start unnecessary transactions during log flush
Date: Fri, 16 May 2025 23:48:21 +0200
Message-ID: <20250516214822.905056-5-agruenba@redhat.com>
In-Reply-To: <20250516214822.905056-1-agruenba@redhat.com>
References: <20250516214822.905056-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GiFSsHtzUbPGeeeM6QbPKcqzOBL35qsf7bQ72TOrymQ_1747432115
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Commit 8d391972ae2d ("gfs2: Remove __gfs2_writepage()") changed the log
flush code in gfs2_ail1_start_one() to call aops->writepages() instead
of aops->writepage().  For jdata inodes, this means that we will now try
to reserve log space and start a transaction before we can determine
that the pages in question have already been journaled.  When this
happens in the context of gfs2_logd(), it can now appear that not enough
log space is available for freeing up log space, and we will lock up.

Fix that by issuing journal writes directly instead of going through
aops->writepages() in the log flush code.

Fixes: 8d391972ae2d ("gfs2: Remove __gfs2_writepage()")
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/aops.c | 31 +++++++++++++++++++++++++++++++
 fs/gfs2/aops.h |  1 +
 fs/gfs2/log.c  |  7 ++++++-
 3 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index 1a3a420316fa..14f204cd5a82 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -117,6 +117,37 @@ static int __gfs2_jdata_write_folio(struct folio *folio,
 	return gfs2_write_jdata_folio(folio, wbc);
 }
 
+/**
+ * gfs2_jdata_writeback - Write jdata folios to the log
+ * @mapping: The mapping to write
+ * @wbc: The writeback control
+ *
+ * Returns: errno
+ */
+int gfs2_jdata_writeback(struct address_space *mapping, struct writeback_control *wbc)
+{
+	struct inode *inode = mapping->host;
+	struct gfs2_inode *ip = GFS2_I(inode);
+	struct gfs2_sbd *sdp = GFS2_SB(mapping->host);
+	struct folio *folio = NULL;
+	int error;
+
+	BUG_ON(current->journal_info);
+	if (gfs2_assert_withdraw(sdp, ip->i_gl->gl_state == LM_ST_EXCLUSIVE))
+		return 0;
+
+	while ((folio = writeback_iter(mapping, wbc, folio, &error))) {
+		if (folio_test_checked(folio)) {
+			folio_redirty_for_writepage(wbc, folio);
+			folio_unlock(folio);
+			continue;
+		}
+		error = __gfs2_jdata_write_folio(folio, wbc);
+	}
+
+	return error;
+}
+
 /**
  * gfs2_writepages - Write a bunch of dirty pages back to disk
  * @mapping: The mapping to write
diff --git a/fs/gfs2/aops.h b/fs/gfs2/aops.h
index f9fa41aaeaf4..bf002522a782 100644
--- a/fs/gfs2/aops.h
+++ b/fs/gfs2/aops.h
@@ -9,5 +9,6 @@
 #include "incore.h"
 
 void adjust_fs_space(struct inode *inode);
+int gfs2_jdata_writeback(struct address_space *mapping, struct writeback_control *wbc);
 
 #endif /* __AOPS_DOT_H__ */
diff --git a/fs/gfs2/log.c b/fs/gfs2/log.c
index f9c5089783d2..115c4ac457e9 100644
--- a/fs/gfs2/log.c
+++ b/fs/gfs2/log.c
@@ -31,6 +31,7 @@
 #include "dir.h"
 #include "trace_gfs2.h"
 #include "trans.h"
+#include "aops.h"
 
 static void gfs2_log_shutdown(struct gfs2_sbd *sdp);
 
@@ -131,7 +132,11 @@ __acquires(&sdp->sd_ail_lock)
 		if (!mapping)
 			continue;
 		spin_unlock(&sdp->sd_ail_lock);
-		ret = mapping->a_ops->writepages(mapping, wbc);
+		BUG_ON(GFS2_SB(mapping->host) != sdp);
+		if (gfs2_is_jdata(GFS2_I(mapping->host)))
+			ret = gfs2_jdata_writeback(mapping, wbc);
+		else
+			ret = mapping->a_ops->writepages(mapping, wbc);
 		if (need_resched()) {
 			blk_finish_plug(plug);
 			cond_resched();
-- 
2.49.0

