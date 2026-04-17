Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6125D372B45
	for <gfs2@lists.linux.dev>; Fri, 17 Apr 2026 21:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776462857; cv=none; b=OjNPzHUs7bzoqkO3GVHZW2Cn9i37A1oMfqiSK5UaIUx845meshxnneobgTgyBaroR6l+1k9a19oRHRph7IqTMFm82SkZqH175yLYAd6aecwJ9Ellw3EE2mDaVDQWbJIVNVt9qTO8E6zMYMS/eLmEWJRAss9bgm8qK+FvZpNJDNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776462857; c=relaxed/simple;
	bh=UDbQrsy2gzvbWm0VEu65Ew2ISFqJfsCgGlHXVQxG7bU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=gXou7mLrGtw+pycwsp6BYss6oBZ9GTcovKLBaBmvbJdBBrp5CGb1vH9CEh4s7m+fIkwrpyPwVF8n0/8sffRHESjamPjgk9NpdLFWuqUM+q4OY/fFqLV5gtLk0s3zeY3/qP3HefkvIj/ZnJeOfswGtz6LHsyO+3ACE6JbOGBPIjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iuWqdSLH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iuWqdSLH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776462855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4uDZloAQMjT5KxS6fE0PysXrnjAlm1DsM3DqS9DQe3Q=;
	b=iuWqdSLHCkeeDwGRnP6YVJXPEORyug4E1rDiRmRM7l6w8sE+LB6jEG4DLvq1RVUjJEvLbu
	AdFdS/qPGwdxJhq8WGBJyb/aTR6ChJroSraUHHY3c1NEoZpoBovIjd8jMPcqp4YVOT0TOh
	v0o8Ec5t0fhapGIZnvbA40r1PJ9FkfQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-94-aKoBaJ9sMwyHREmu8DTCbA-1; Fri,
 17 Apr 2026 17:54:14 -0400
X-MC-Unique: aKoBaJ9sMwyHREmu8DTCbA-1
X-Mimecast-MFC-AGG-ID: aKoBaJ9sMwyHREmu8DTCbA_1776462853
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3F5881800473
	for <gfs2@lists.linux.dev>; Fri, 17 Apr 2026 21:54:13 +0000 (UTC)
Received: from fs-i40c-03.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B18A719560B1;
	Fri, 17 Apr 2026 21:54:12 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: aahringo@redhat.com,
	gfs2@lists.linux.dev
Subject: [PATCH dlm] dlm: fix add msg handle in send_queue ordered
Date: Fri, 17 Apr 2026 17:54:11 -0400
Message-ID: <20260417215411.1665232-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: WI3kEhMZanbKfAfX38rNdcUHyP3L9ewyfsCr0z3rZPc_1776462853
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

In a benchmark scenario triggering a lot of requests that triggers a lot
of DLM messages on the network it can be that the mh->seq is not ordered
according the oldest seq number. This ordering is required by
dlm_receive_ack as "before(mh->seq, seq)" will stop to check for older
sequence numbers that are ordered in the tail of "node->send_queue".

The side effects of not having it correct ordered regarding
"before(mh->seq, seq)" are refcounting issues and use-after free.

I only was able to reproduce this issue in a experimental DLM branch
and a user space DLM benchmark that uses io_uring. After changing this I
don't experienced any refcounting with the sending buffer issues anymore.

Fixes: 489d8e559c659 ("fs: dlm: add reliable connection if reconnect")
Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/midcomms.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/dlm/midcomms.c b/fs/dlm/midcomms.c
index a5b363b4785f3..6b522d4e2b7e3 100644
--- a/fs/dlm/midcomms.c
+++ b/fs/dlm/midcomms.c
@@ -969,10 +969,10 @@ static void midcomms_new_msg_cb(void *data)
 	atomic_inc(&mh->node->send_queue_cnt);
 
 	spin_lock_bh(&mh->node->send_queue_lock);
+	/* need to be locked with list_add_tail_rcu() because list is ordered */
+	mh->seq = atomic_fetch_inc(&mh->node->seq_send);
 	list_add_tail_rcu(&mh->list, &mh->node->send_queue);
 	spin_unlock_bh(&mh->node->send_queue_lock);
-
-	mh->seq = atomic_fetch_inc(&mh->node->seq_send);
 }
 
 static struct dlm_msg *dlm_midcomms_get_msg_3_2(struct dlm_mhandle *mh, int nodeid,
-- 
2.43.0

