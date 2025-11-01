Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4492581
	for <gfs2@lists.linux.dev>; Sat,  1 Nov 2025 00:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761956596; cv=none; b=NwUghXFRIYnb4umgUOTBfAnp+LZqyNHmgBfT54ZEdBAyBN3TgLJwfG9eNyepqT0wl8ekTbD/mFyXe+xzr34GknYfn3mqkEKI05jaDVzHzUx17+lDnDBDd1YN7vXPseMGoiCCS/xDYf9+ChPiuua/1YUDPexAmU3jXcFtERzZgBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761956596; c=relaxed/simple;
	bh=dDfH33vAW9yag9GdgIG2MdmFlzo1j5Q7fL4zNAjmaK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=XDhud6/Mj7BC5xRzSQU3wXeaYfHU4LMUd45D+K62Dqt4/7UvMChsKcB2ADaqLKfAMc4ISdNbQ5vLtv8F9UbKFOiEZMQ97SfI6+0f1Rr4wRfZ1XXwGZL1bwlVmAVLBk+7kOMNH9EQYjZ3l0pXqhMPm4JKYhrfryeirdmMDpnBePE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L/hZgEQG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L/hZgEQG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761956594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OhCgd4jg/xbBBEIOBN1NzULHzurTnCaz7GJ6FndePVQ=;
	b=L/hZgEQG38BzyAFhzuPXXQR3UD1dmIlDa4ekLD9OgXeB2F5fzq2L3olFRxpSWxFlVfKHN4
	KSI7aFP214TDnx2lDSiNVfbxk99Nk7FQwMgsAQYRpvJap7p+GsI5wTVeaeAdasxuNhNP3p
	o2VnBARMeKwSRaOpSojgqG1QpAywDzE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-117--ZBEpgTmPXKAl2VC0ZzgBQ-1; Fri,
 31 Oct 2025 20:23:12 -0400
X-MC-Unique: -ZBEpgTmPXKAl2VC0ZzgBQ-1
X-Mimecast-MFC-AGG-ID: -ZBEpgTmPXKAl2VC0ZzgBQ_1761956591
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CBD821956095
	for <gfs2@lists.linux.dev>; Sat,  1 Nov 2025 00:23:11 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.12])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B79D0180035A;
	Sat,  1 Nov 2025 00:23:10 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 22/24] gfs2: Withdraw immediately in gfs2_trans_add_meta
Date: Sat,  1 Nov 2025 00:22:31 +0000
Message-ID: <20251101002234.1286383-23-agruenba@redhat.com>
In-Reply-To: <20251101002234.1286383-1-agruenba@redhat.com>
References: <20251101002234.1286383-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: WBUIkzkAgBt-3UkFZWXesJ6JFqTx58ihIaYpxsNl-r4_1761956591
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

We can now withdraw while the log is locked.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/trans.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/gfs2/trans.c b/fs/gfs2/trans.c
index f0cfdb5c5f2d..1cce8e0f85da 100644
--- a/fs/gfs2/trans.c
+++ b/fs/gfs2/trans.c
@@ -255,7 +255,6 @@ void gfs2_trans_add_meta(struct gfs2_glock *gl, struct buffer_head *bh)
 	struct gfs2_bufdata *bd;
 	struct gfs2_meta_header *mh;
 	struct gfs2_trans *tr = current->journal_info;
-	bool withdraw = false;
 
 	lock_buffer(bh);
 	if (buffer_pinned(bh)) {
@@ -296,7 +295,7 @@ void gfs2_trans_add_meta(struct gfs2_glock *gl, struct buffer_head *bh)
 	}
 	if (unlikely(sb->s_writers.frozen == SB_FREEZE_COMPLETE)) {
 		fs_info(sdp, "GFS2:adding buf while frozen\n");
-		withdraw = true;
+		gfs2_withdraw(sdp);
 		goto out_unlock;
 	}
 	gfs2_pin(sdp, bd->bd_bh);
@@ -306,8 +305,6 @@ void gfs2_trans_add_meta(struct gfs2_glock *gl, struct buffer_head *bh)
 	tr->tr_num_buf_new++;
 out_unlock:
 	gfs2_log_unlock(sdp);
-	if (withdraw)
-		gfs2_assert_withdraw(sdp, 0);
 out:
 	unlock_buffer(bh);
 }
-- 
2.51.0

