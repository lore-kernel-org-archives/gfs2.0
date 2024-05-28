Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB2116F90E
	for <gfs2@lists.linux.dev>; Tue, 28 May 2024 21:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716930771; cv=none; b=FHF4odTjyWtnxfLFfnW+xcgvE9tUhmID+OK+XoBnk6XD9ZkRKt/zBjTHdRGCPgSVR9PGqgmLd97db4gElds/93oshNPuHVbPmfl6R7jDJ4H+BAwtdI0xlVtlw/XS8c4DyDBYr4jIr0U+2F5C6o9chD3dM8mbSCJ0lhlrzFOPtFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716930771; c=relaxed/simple;
	bh=cNFlQLowy4zNICcJBZO8uc0t6Mu80EuZkt23mNJ/CSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NoyUq7Stupcl3H896G1PEkU2uJJnRC56RNvnlMlRdT/nhNzM/dQunsw6E2o9H7x90LPVtwJY7lKCThlbcCsTqaanWvdRcUeElqa1ISXRfmfs0PQTmsvsNEJ4wqOI9QUBoc7+pMZGv1ELEv1DUIePYcxXl3UMwOteDL8FcLwqCnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xzgf2+LG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xzgf2+LG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716930768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tsVb76IygbQm7b89PtP6vO61chGnoW3dl/7xysmkAuk=;
	b=Xzgf2+LG/404Y3KlUMxyQnBn2dY0AE+rLVCs1Qwd8pHvat9gY5A1T9i+t88XwsVZQR23lN
	yuRt4lCW3JnVH+YaJugo3ST4i0/0fffIyyVmPjceJsRTLnAiw5pyP8mzF3W6bnfmdxtSfO
	wmn6C2tDTqENGWjgMYs+krV1Id7W53U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631--VjLRBdANHissIq0NFO8NQ-1; Tue, 28 May 2024 17:12:47 -0400
X-MC-Unique: -VjLRBdANHissIq0NFO8NQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DFF05101A525
	for <gfs2@lists.linux.dev>; Tue, 28 May 2024 21:12:46 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D8132200A381;
	Tue, 28 May 2024 21:12:46 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCH v6.10-rc1 02/11] dlm: don't kref_init rsbs created for toss list
Date: Tue, 28 May 2024 17:12:32 -0400
Message-ID: <20240528211241.2140441-2-aahringo@redhat.com>
In-Reply-To: <20240528211241.2140441-1-aahringo@redhat.com>
References: <20240528211241.2140441-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
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

