Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6EB1411F4
	for <gfs2@lists.linux.dev>; Tue, 23 Apr 2024 19:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713902168; cv=none; b=T85a9vCcHRyyJ9/k+y2pCYBfYkxrKV5g4hnNCYyCk/K82l8JWPisPqHgn+5x9eSWwj994HLWvwXMiTDZtoCM6O+PRGuT82Ue5jIltQ/f5vWkNSG0NxbEzk1iKVCQ/IRu4rG6YuNaRuq45U72GKqJR/IiG1cgCgtkALBAbGR7hyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713902168; c=relaxed/simple;
	bh=cNFlQLowy4zNICcJBZO8uc0t6Mu80EuZkt23mNJ/CSY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ebH7Z7c6mS+Raamh0bhbGFymvDN/KPHeObd/IEdT1ldqnbr+JA8YAFJvdEn2QoLIfSE77Tm/8CdddbmwfitSY3+X6P4Bq6oyk/c60Qhk9U5kEuhGRKzMZHTEQE3x6nuFYDo62D17IA8A/A7WmwwfEIGFUCffs4z1CIowPAwXvns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dvn9ZXiM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dvn9ZXiM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713902166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tsVb76IygbQm7b89PtP6vO61chGnoW3dl/7xysmkAuk=;
	b=Dvn9ZXiMiaVo/oLJSs2jQ77C/YCCfs9JvcsFKM21xGrQTC5CLlP3mZMXyleNjMrW7brDJo
	5Upn1iH0vcgpHDrgQHuCjEErZd3gF9zw1bD35dO1vrSuKxB1gNrmVe33qHrDps4mhSW9LX
	/02jEIHH+tbzE7+1MYXbNeTgkCDYhKw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-Z3_7j9wzOjyhj6lGEsuoMA-1; Tue, 23 Apr 2024 15:56:04 -0400
X-MC-Unique: Z3_7j9wzOjyhj6lGEsuoMA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 72A778021A5
	for <gfs2@lists.linux.dev>; Tue, 23 Apr 2024 19:56:04 +0000 (UTC)
Received: from fs-i40c-03.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 67DBD492BC7;
	Tue, 23 Apr 2024 19:56:04 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCH dlm/next 01/10] dlm: don't kref_init rsb created for toss list
Date: Tue, 23 Apr 2024 15:55:50 -0400
Message-ID: <20240423195559.1527187-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

This patch removes a kref_init() that isn't necessary because the rsb is
created for toss list. Under toss list the rsb should not have any
reference counting logic. If in theory the rsb gets to into keep list
then a kref_init() for res_ref will be initiated.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/lock.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index f103b8c30592..e66972ed97b1 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -1385,7 +1385,6 @@ int dlm_master_lookup(struct dlm_ls *ls, int from_nodeid, const char *name,
 	r->res_dir_nodeid = our_nodeid;
 	r->res_master_nodeid = from_nodeid;
 	r->res_nodeid = from_nodeid;
-	kref_init(&r->res_ref);
 	rsb_set_flag(r, RSB_TOSS);
 
 	write_lock_bh(&ls->ls_rsbtbl_lock);
-- 
2.43.0

