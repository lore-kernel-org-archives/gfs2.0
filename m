Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDB5152DEB
	for <gfs2@lists.linux.dev>; Tue,  9 Apr 2024 16:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712681121; cv=none; b=I4JJW7UKAVTACSQLCsiFIwf7S4hogARZsrJZJJ8VYpJfm5cklo0/gRaB8ZbXuVfkpf0PpgWELMAeucKQBywisGoihwn5yFTEZV9CqiRG3ftKK7f17ymG9YkeL+6EuAH4E3r5sDecDNDLlTy9VVliohP3Txd0BEEPSy3Bp0aSguw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712681121; c=relaxed/simple;
	bh=skavClBJswnkY9OAX2kTwhRvQnMKleCUqF0xQLaAqoY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EOvm9rmQpvrvAWfTjC6mLfZvXtGjLX6u6ePjYgztNO8yrhha8UOFws9jbMQ35x/LTBF1FbYfnL8K0402e/PbTkZ6GPkPEpsvY7MczFGiAmIn2nTD9VAHbQv/ZVRwYPkgFkukde44P337FbK6pVxt5ynB3mhNILl+V9xzuMnQDt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gWRRTIF6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gWRRTIF6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712681118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JAwXz5UR/1P7m8SY0JBglagut8a6yUUyZfQfUNLBTko=;
	b=gWRRTIF6sGQRE5+UG3fL5xppkhZ9gN+ke0hR1rsEfHLgJFykKdEyx8dZ/P1THl5CxuZ05k
	Tdqj4lB0EOKz5b7pPmjchnfqjDxSx7C+3S/F4/UPlLuZJ+Qn5G/dizHu8/z3Jh+G6C3sBK
	hIsYbpQ0TZMULTqSshKG/LMRaQJ49eY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-392-Yhd4D8CFNIu71ZeoR9ZYmA-1; Tue, 09 Apr 2024 12:45:17 -0400
X-MC-Unique: Yhd4D8CFNIu71ZeoR9ZYmA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E0B8F188ACA6
	for <gfs2@lists.linux.dev>; Tue,  9 Apr 2024 16:45:16 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.28])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 60CE9C09A05;
	Tue,  9 Apr 2024 16:45:16 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 04/15] gfs2: Use [NO_]CREATE consistently for gfs2_glock_get
Date: Tue,  9 Apr 2024 18:44:54 +0200
Message-ID: <20240409164508.79570-5-agruenba@redhat.com>
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

When calling gfs2_glock_get(), consistently pass the CREATE or NO_CREATE
flag for the create argument.  This is the only place that passes 0
instead.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/sys.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/gfs2/sys.c b/fs/gfs2/sys.c
index 32d3484270f3..ecc699f8d9fc 100644
--- a/fs/gfs2/sys.c
+++ b/fs/gfs2/sys.c
@@ -336,7 +336,7 @@ static ssize_t demote_rq_store(struct gfs2_sbd *sdp, const char *buf, size_t len
 		return -EINVAL;
 	if (!test_and_set_bit(SDF_DEMOTE, &sdp->sd_flags))
 		fs_info(sdp, "demote interface used\n");
-	rv = gfs2_glock_get(sdp, glnum, glops, 0, &gl);
+	rv = gfs2_glock_get(sdp, glnum, glops, NO_CREATE, &gl);
 	if (rv)
 		return rv;
 	gfs2_glock_cb(gl, glmode);
-- 
2.44.0

