Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662B4209F23
	for <gfs2@lists.linux.dev>; Mon,  2 Dec 2024 15:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733153215; cv=none; b=HtSNo++dVkcXx3CyIxMV7udV3xvrZVnsuCA8JYgdG8lF0tgb/d35bMOk92UuK7DBAtEvgYnHqWtqSdG47X495pOLCoqe9CyVjLpHdsfobfj3QjMGv2dM8ZXD/moYHgZ3P+aSkV3P90pNEbD1S/qD6sndZSANERMjd6lO3Whnwow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733153215; c=relaxed/simple;
	bh=dP/NIInMhR4j43ktZNOOEnUrWXWLdBiQ1k7awqsM7XE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=aLgDnbRawu4jDWQfqFrb6LkHKpyEO30HGdMCM/HrFes8cQu+KLvj096cfglZVbMKhfrFSP6qM2zhX6+fCb7prcSifcwnCmbNuTuBqehHuVK5AaLqyVAG79dm+aOUi3ioXqMIFyuEBugz3jiwSUhFTK4YIN2kZM9IBQ0tEMljnHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a6/4AHWy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a6/4AHWy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733153212;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gZ4uS7soeP+oC3DWg2VxLagbyKUltU4YoxFMxsrCqMk=;
	b=a6/4AHWyVnCBg6PQKhdvrtO6WKkZxg3MkuGKRXyUVFE/o0anAUKm9XZ/PykQ/OEQEQkCES
	Df88ilB+ymAKy6Vg1KBE31t4cHzpE99YxHnG7FePXshgiyIBbqluCOhaM5OeEtSBAekqSX
	Ald3P941vBa1LMHvRFyFA4Lqlns00FM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-92-PYEgwWh0OmuC6GDQPG8fvw-1; Mon,
 02 Dec 2024 10:26:49 -0500
X-MC-Unique: PYEgwWh0OmuC6GDQPG8fvw-1
X-Mimecast-MFC-AGG-ID: PYEgwWh0OmuC6GDQPG8fvw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 613931955D58
	for <gfs2@lists.linux.dev>; Mon,  2 Dec 2024 15:26:48 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A65F230000DF;
	Mon,  2 Dec 2024 15:26:47 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCH v6.13-rc1 1/5] dlm: fix srcu_read_lock() return type to int
Date: Mon,  2 Dec 2024 10:26:37 -0500
Message-ID: <20241202152641.3395369-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7B3PHtvW4WNx4oA2SeSfCufLonZxx9TLg1I-rX1U3ZI_1733153208
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The return type of srcu_read_lock() is int and not bool. Whereas we
using the ret variable only to evaluate a bool type of
dlm_lowcomms_con_has_addr() to check if an address is already being set.

Fixes: 6f0b0b5d7ae7 ("fs: dlm: remove dlm_node_addrs lookup list")
Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/lowcomms.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
index df40c3fd1070..d28141829c05 100644
--- a/fs/dlm/lowcomms.c
+++ b/fs/dlm/lowcomms.c
@@ -462,7 +462,8 @@ static bool dlm_lowcomms_con_has_addr(const struct connection *con,
 int dlm_lowcomms_addr(int nodeid, struct sockaddr_storage *addr)
 {
 	struct connection *con;
-	bool ret, idx;
+	bool ret;
+	int idx;
 
 	idx = srcu_read_lock(&connections_srcu);
 	con = nodeid2con(nodeid, GFP_NOFS);
-- 
2.43.0

