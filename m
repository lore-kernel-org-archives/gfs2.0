Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5070F1D5CE8
	for <gfs2@lists.linux.dev>; Mon, 19 May 2025 11:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747653561; cv=none; b=b1WNlMnJcFNGYGIhR7Y3BAJ/oDpN7ycoZ29ia34H/SZAfm48wRaiMXfAWKDemLSRVY/VGUzoQ4ohwbFxibP0b9eWk2a7Qpf26Y6kCLcaPyUHpcgBgap5aY2l4NG1xeDcd41Ytt/IhKVLx/8x+UqkvjNueFgGpCHmlBur8+67bVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747653561; c=relaxed/simple;
	bh=t1p4gIaftC/+OvAjc8EK3qQ15fMphrmklrP6rn/16xQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=TEjw4qH9yFl2nWTgb1sf01uEhMazFrWhMQCsPO7qhQVaB9gSo+q2nHkIgIclLhLQbU5RjeskG3ZiXNK8jApXaX2LioPmfSGqVpmapWFdJO9+Ue0ViiDcZ5+B8F/cAqxJvcfZlkY+bI4Pv5dEZ4BpgczmvSZA2staSC+fTUI/R0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nc3wdUJZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nc3wdUJZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747653558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7UEev2JqzZD8XyCwOhs0soBALlhhB0BLFAhyeNQWCdM=;
	b=Nc3wdUJZ025O/F3wxh/BvlDuInTElCYLXtvl4ovrCrYFTayWEgSIlkFK6bkSLUop8cMvSp
	MWf4PQZo9h2xi8tPHd1goFG6e2I79jzYzfZVuhmPEHgdKTiQSF8yMatT9LVukgfNsu2N4M
	bqk2148ziu6WoZUUAJ1toZJeSbMhH+A=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-650--7_VDJInMjm8yWR_ahDiWQ-1; Mon,
 19 May 2025 07:19:16 -0400
X-MC-Unique: -7_VDJInMjm8yWR_ahDiWQ-1
X-Mimecast-MFC-AGG-ID: -7_VDJInMjm8yWR_ahDiWQ_1747653555
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A6A5E195608B
	for <gfs2@lists.linux.dev>; Mon, 19 May 2025 11:19:15 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.234])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9147618004A7;
	Mon, 19 May 2025 11:19:14 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 4/6] gfs2: Simplify clean_journal
Date: Mon, 19 May 2025 13:19:03 +0200
Message-ID: <20250519111906.1503215-5-agruenba@redhat.com>
In-Reply-To: <20250519111906.1503215-1-agruenba@redhat.com>
References: <20250519111906.1503215-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: q1DDS_AqVmHa2XrNzYNO4iyndaziMDfV2I6ByGH9aiw_1747653555
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

In function clean_journal(), update @head to point at the log header
that indicates successful recovery:  this is where logging needs to
resume.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/recovery.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/gfs2/recovery.c b/fs/gfs2/recovery.c
index db1238480e91..5e37574820b7 100644
--- a/fs/gfs2/recovery.c
+++ b/fs/gfs2/recovery.c
@@ -264,10 +264,10 @@ static void clean_journal(struct gfs2_jdesc *jd,
 			  struct gfs2_log_header_host *head)
 {
 	struct gfs2_sbd *sdp = GFS2_SB(jd->jd_inode);
-	u32 lblock = head->lh_blkno;
 
-	gfs2_replay_incr_blk(jd, &lblock);
-	gfs2_write_log_header(sdp, jd, head->lh_sequence + 1, 0, lblock,
+	gfs2_replay_incr_blk(jd, &head->lh_blkno);
+	head->lh_sequence++;
+	gfs2_write_log_header(sdp, jd, head->lh_sequence, 0, head->lh_blkno,
 			      GFS2_LOG_HEAD_UNMOUNT | GFS2_LOG_HEAD_RECOVERY,
 			      REQ_PREFLUSH | REQ_FUA | REQ_META | REQ_SYNC);
 }
-- 
2.49.0

