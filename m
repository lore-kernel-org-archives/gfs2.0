Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2290C80619
	for <gfs2@lists.linux.dev>; Tue,  9 Apr 2024 16:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712681122; cv=none; b=HK2tWW3DB3wpAnpWZeZMeNTcwbzAHAzq24JnJ+8DONNNxifFBcvtIb0eTQQDD8JSuUUbKNzQuw9ILiPXiR+yO5ptMvrn24bF+ejyo3FvV0m1IKJ7uAvvn2ZbEg3uFFtfGlwlzo/x1+JnBRol0h5ayZAcapcMJ+GoUWOBgnQLvPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712681122; c=relaxed/simple;
	bh=8f/L3SP8sBEzFDQlaEXlTzsJy7JHDrqiqsPN4WCC3ds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ck/12DvkFceQiDcZ6BbT/xFYi7NwkPIDlhCQCETUV/TDS0TvlB9U2f3LDMXzx4L+loDvu7LoLgZwkyJ2w1LZTA2GH5mpK2jnQO5TeYMWC/nbzPu+XkL8BPPJ68VS6ZWkWd0c9u/jGAzGZM3Nn8F/kMasw1pRY0cjLMqEU0/3yDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F4uVKwv/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F4uVKwv/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712681120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w+KGqIN/dQNLVMOu0EYU3tYItS0ODErT/45jq2biO2Q=;
	b=F4uVKwv/tsnVSbUM/dSv3re6+WAb5mvXyyATCmnRgbhZJ7CWqrvjmpUR1Fj4g1F6N82Xxy
	21RHMbxI/VdSSj73/ffOs0Nc3hDw2kW4U5/v5dQRZ4X6/eZrCVPEX6b8JjZu+h1y2Oc4HB
	GFncR8rp4OlnisAIYD+VFaVKbvtXwxM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-443-wtbpPSYSMuWNmiynSx50cA-1; Tue,
 09 Apr 2024 12:45:18 -0400
X-MC-Unique: wtbpPSYSMuWNmiynSx50cA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 688801C0C649
	for <gfs2@lists.linux.dev>; Tue,  9 Apr 2024 16:45:18 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.28])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DD872C09A05;
	Tue,  9 Apr 2024 16:45:17 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 06/15] gfs2: Fix NULL pointer dereference in gfs2_log_flush
Date: Tue,  9 Apr 2024 18:44:56 +0200
Message-ID: <20240409164508.79570-7-agruenba@redhat.com>
In-Reply-To: <20240409164508.79570-1-agruenba@redhat.com>
References: <20240409164508.79570-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

In gfs2_jindex_free(), set sdp->sd_jdesc to NULL under the log flush
lock to provide exclusion against gfs2_log_flush().

In gfs2_log_flush(), check if sdp->sd_jdesc is non-NULL before
dereferencing it.  Otherwise, we could run into a NULL pointer
dereference when outstanding glock work races with an unmount
(glock_work_func -> run_queue -> do_xmote -> inode_go_sync ->
gfs2_log_flush).

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/log.c   | 3 ++-
 fs/gfs2/super.c | 4 ++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/gfs2/log.c b/fs/gfs2/log.c
index 8cddf955ebc0..a6dd68b458ce 100644
--- a/fs/gfs2/log.c
+++ b/fs/gfs2/log.c
@@ -1108,7 +1108,8 @@ void gfs2_log_flush(struct gfs2_sbd *sdp, struct gfs2_glock *gl, u32 flags)
 	lops_before_commit(sdp, tr);
 	if (gfs2_withdrawing_or_withdrawn(sdp))
 		goto out_withdraw;
-	gfs2_log_submit_bio(&sdp->sd_jdesc->jd_log_bio, REQ_OP_WRITE);
+	if (sdp->sd_jdesc)
+		gfs2_log_submit_bio(&sdp->sd_jdesc->jd_log_bio, REQ_OP_WRITE);
 	if (gfs2_withdrawing_or_withdrawn(sdp))
 		goto out_withdraw;
 
diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index e5f79466340d..9de789b78bc5 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -67,9 +67,13 @@ void gfs2_jindex_free(struct gfs2_sbd *sdp)
 	sdp->sd_journals = 0;
 	spin_unlock(&sdp->sd_jindex_spin);
 
+	down_write(&sdp->sd_log_flush_lock);
 	sdp->sd_jdesc = NULL;
+	up_write(&sdp->sd_log_flush_lock);
+
 	while (!list_empty(&list)) {
 		jd = list_first_entry(&list, struct gfs2_jdesc, jd_list);
+		BUG_ON(jd->jd_log_bio);
 		gfs2_free_journal_extents(jd);
 		list_del(&jd->jd_list);
 		iput(jd->jd_inode);
-- 
2.44.0

