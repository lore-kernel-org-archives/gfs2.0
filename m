Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA0D2AD20
	for <gfs2@lists.linux.dev>; Wed, 25 Sep 2024 22:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727301824; cv=none; b=pogLPoTN1cnQV49+MDhsxbZn1jOFEZ0yctcoyF+SCYLcBgDhhv8jgJF78LcDN2UB8rf++qJItu9MJFDoCELzl/uoPYcJrETmW1JbCHYIhxP9Pt3gP/4stuLOFnSkoZmjxvuQZlf1P2lksr//+zjIhg6m4OEWPlsRB2BNr31CDr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727301824; c=relaxed/simple;
	bh=CwqHr/qXuHzKiWOBIrTsn6B5HPtreBeOgy2hVimSvis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hgMQVsYyZpFCyi7+BxX85QMn59sAGiVVbm4DdwCebo+eJMEDx8XMx8dy2iTTlWyVx/1PHsH29BB1+y4QuZmX5l1b1QDeZc58P9NbehfuJLvv+XpaOEDo+cKqwCoCpelZXzaseSIUXczG7FQBCze1VcZbeZzt9naxr830SKIJEK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UHuprTDp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UHuprTDp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727301822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d210df4LHQPyyMqD8ulyBv4W1AVXgC0Ty/7Th5gvu9M=;
	b=UHuprTDplgUnlnXOlgAWHN9GLHli0dyNOS9I6aGrNQhMjCpyBh7fEvjACYtfN6NMTBih9U
	ZkAx2Kz4MieXp95YJS22QDn6kRGDEDHAvjhkr2xoBl+fSSLa1cA8PILIpcFKdm/O8dISUb
	wqzy5w0V3VAU3rCP5f+gkqwZa87sZa8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-225-qioN2ukTPhKqliP_ddIjgA-1; Wed,
 25 Sep 2024 18:03:40 -0400
X-MC-Unique: qioN2ukTPhKqliP_ddIjgA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 076D61933E84
	for <gfs2@lists.linux.dev>; Wed, 25 Sep 2024 22:03:40 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.77])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0C02819560AA;
	Wed, 25 Sep 2024 22:03:38 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 04/16] gfs2: Fix unlinked inode cleanup
Date: Thu, 26 Sep 2024 00:03:14 +0200
Message-ID: <20240925220331.417856-5-agruenba@redhat.com>
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

Before commit f0e56edc2ec7 ("gfs2: Split the two kinds of glock "delete"
work"), function delete_work_func() was used to trigger the eviction of
in-memory inodes from remote as well as deleting unlinked inodes at a
later point.  These two kinds of work were then split into two kinds of
work, and the two places in the code were deferred deletion of inodes is
required accidentally ended up queuing the wrong kind of work.  This
caused unlinked inodes to be left behind, which could in the worst case
fill up filesystems and require a filesystem check to recover.

Fix that by queuing the right kind of work in try_rgrp_unlink() and
gfs2_drop_inode().

Fixes: f0e56edc2ec7 ("gfs2: Split the two kinds of glock "delete" work")
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/glock.c | 2 +-
 fs/gfs2/glock.h | 1 +
 fs/gfs2/rgrp.c  | 2 +-
 fs/gfs2/super.c | 2 +-
 4 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 7119037a866c..9273ec5345ed 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -1012,7 +1012,7 @@ bool gfs2_queue_try_to_evict(struct gfs2_glock *gl)
 				  &gl->gl_delete, 0);
 }
 
-static bool gfs2_queue_verify_delete(struct gfs2_glock *gl, bool later)
+bool gfs2_queue_verify_delete(struct gfs2_glock *gl, bool later)
 {
 	struct gfs2_sbd *sdp = gl->gl_name.ln_sbd;
 	unsigned long delay;
diff --git a/fs/gfs2/glock.h b/fs/gfs2/glock.h
index adf0091cc98f..63e101d448e9 100644
--- a/fs/gfs2/glock.h
+++ b/fs/gfs2/glock.h
@@ -245,6 +245,7 @@ static inline int gfs2_glock_nq_init(struct gfs2_glock *gl,
 void gfs2_glock_cb(struct gfs2_glock *gl, unsigned int state);
 void gfs2_glock_complete(struct gfs2_glock *gl, int ret);
 bool gfs2_queue_try_to_evict(struct gfs2_glock *gl);
+bool gfs2_queue_verify_delete(struct gfs2_glock *gl, bool later);
 void gfs2_cancel_delete_work(struct gfs2_glock *gl);
 void gfs2_flush_delete_work(struct gfs2_sbd *sdp);
 void gfs2_gl_hash_clear(struct gfs2_sbd *sdp);
diff --git a/fs/gfs2/rgrp.c b/fs/gfs2/rgrp.c
index 29c772816765..539303129715 100644
--- a/fs/gfs2/rgrp.c
+++ b/fs/gfs2/rgrp.c
@@ -1879,7 +1879,7 @@ static void try_rgrp_unlink(struct gfs2_rgrpd *rgd, u64 *last_unlinked, u64 skip
 		 */
 		ip = gl->gl_object;
 
-		if (ip || !gfs2_queue_try_to_evict(gl))
+		if (ip || !gfs2_queue_verify_delete(gl, false))
 			gfs2_glock_put(gl);
 		else
 			found++;
diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index 6678060ed4d2..e22c1edc32b3 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -1045,7 +1045,7 @@ static int gfs2_drop_inode(struct inode *inode)
 		struct gfs2_glock *gl = ip->i_iopen_gh.gh_gl;
 
 		gfs2_glock_hold(gl);
-		if (!gfs2_queue_try_to_evict(gl))
+		if (!gfs2_queue_verify_delete(gl, true))
 			gfs2_glock_put_async(gl);
 		return 0;
 	}
-- 
2.46.0

