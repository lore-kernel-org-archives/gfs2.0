Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1C822A4FC
	for <gfs2@lists.linux.dev>; Mon, 27 Apr 2026 15:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777305589; cv=none; b=O0zgsb8BCAdoa3k+7gVi/lKgl8Mt1XDxmGca64lfYq1eo+lkCOaj4aECl1yXk+58JY01IxkyGOXG1XwDVMXxwiIlMHCEb5kqfPa0RAwpouIMAlcuMfs+hm2iA436gORZ50z2BxpGxebwsOA+0WntUj/Ut3lJFFTkmYnfJSZyNCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777305589; c=relaxed/simple;
	bh=XkYm0gcHlDp+Ta/KCf+woBmosZesT9zC3qmTohB16R0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=RyyuNtTuDASmm6YcdJSwMsBa1tBGvD37s7nmsG4LkYycUM8+Cz3kgJRDilM9iy2QQhuaeEYsBPD6x/ZvzWNjl8Ot58SuUjXsK+jCj/iyacHGVBaeglIkccQbBftXUX2zijJviL8qmZRUQHrVB4KFakXJ0owItf3GM1MCKc3A91A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FC6/32ch; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FC6/32ch"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777305587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XxenagkNFYmos6rL8FOJ3gdFe566U0vXNlFv0Xv4eNI=;
	b=FC6/32chjrvsHCewMXXEWOLTOw2A2EgGVt3RNxPDnQuT82j72SN2SFq/9ChX2nJPQus4ZV
	C95zW5qSciqbrE85qhB55dsHQfSZlrYThmVP/KUyTGKADcJlEPzu1EScoEGdEN9aYJVdv0
	2Wps7mJIvhAWR3cyFNNLCCwseASmkX4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-433-W9LH9AjeMvikA6YqpHxPzQ-1; Mon,
 27 Apr 2026 11:59:46 -0400
X-MC-Unique: W9LH9AjeMvikA6YqpHxPzQ-1
X-Mimecast-MFC-AGG-ID: W9LH9AjeMvikA6YqpHxPzQ_1777305584
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 844AD1956095
	for <gfs2@lists.linux.dev>; Mon, 27 Apr 2026 15:59:44 +0000 (UTC)
Received: from fs-i40c-03.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EEF58300070A;
	Mon, 27 Apr 2026 15:59:43 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: aahringo@redhat.com,
	gfs2@lists.linux.dev
Subject: [PATCH RESEND v7.1-rc1 4/4] dlm: init per node debugfs before add to node hash
Date: Mon, 27 Apr 2026 11:59:35 -0400
Message-ID: <20260427155935.2415989-5-aahringo@redhat.com>
In-Reply-To: <20260427155935.2415989-1-aahringo@redhat.com>
References: <20260427155935.2415989-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nMla38xtK0Xw-_R8_93ZhIHkZDZTkI63gQCkSIWmxYk_1777305584
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Avoiding potential issues when a node is added to the hash but the
debugfs is not NULL or IS_ERR() so a potential iteration over the hash
and debugfs_remove() will not fail like in dlm_midcomms_exit().

However dlm_midcomms_exit() will be called in module init/exit function
and the hash should be empty anyway at those stages. We change the
behavior as cleanup to avoid potential issues.

Reported-by: Ginger <ginger.jzllee@gmail.com>
Closes: https://lore.kernel.org/gfs2/CAGp+u1ZE7UsQ4sSUHBKQXU8x3M_jwK=ek1urSjEtd3jXQGFmVg@mail.gmail.com
Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/midcomms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/dlm/midcomms.c b/fs/dlm/midcomms.c
index 6b522d4e2b7e3..8964164600d2d 100644
--- a/fs/dlm/midcomms.c
+++ b/fs/dlm/midcomms.c
@@ -356,6 +356,7 @@ int dlm_midcomms_addr(int nodeid, struct sockaddr_storage *addr)
 	if (!node)
 		return -ENOMEM;
 
+	node->debugfs = dlm_create_debug_comms_file(nodeid, node);
 	node->nodeid = nodeid;
 	spin_lock_init(&node->state_lock);
 	spin_lock_init(&node->send_queue_lock);
@@ -369,7 +370,6 @@ int dlm_midcomms_addr(int nodeid, struct sockaddr_storage *addr)
 	hlist_add_head_rcu(&node->hlist, &node_hash[r]);
 	spin_unlock_bh(&nodes_lock);
 
-	node->debugfs = dlm_create_debug_comms_file(nodeid, node);
 	return 0;
 }
 
-- 
2.43.0

