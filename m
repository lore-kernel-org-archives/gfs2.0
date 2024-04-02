Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8BF15B962
	for <gfs2@lists.linux.dev>; Tue,  2 Apr 2024 19:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712085504; cv=none; b=r6XWnSrbeL6ghm551e8ZnZQJr5uWjCQxc3FtReV+MvLn0QHhfxv39MbsNCXL/FcOAWT8Z42b27Ei3x2Y3MZn5oawytZ7dUlIpYTMX7EwHPmLnfsXhBwP38BvYCAnizfsT26eeSnIr35+xc4ciou8/MtxXFs4Zw4biBiVp78DWVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712085504; c=relaxed/simple;
	bh=O97mW7P+Kx5zrz8HYlma6OWm/dvPX3PeaAPIxv2sDE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o2NnobKdwVQ3LAMoEdyeApr1hvKg/d4ms/5lb4yWBMKWv1B1uyENKZGF64oXWIYlwBR3JyqB/99PSAKiindmH414xI1jmGyqSpsP5Wds6GyrzLJ/qIxxxoUS201dhc2njxvFzIjik/TsUZrFzR79Ur2FVowsUzVUPeW0tXnb6Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aJFPPWvd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aJFPPWvd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712085501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iXXyz2kC85VOQD+A6aI9f29kIVC747jWv45gJjY0YE4=;
	b=aJFPPWvdetVbut7oMcZgLCCwWbSX3bUQgolM5d3z3/6EfFeL2PET8jfJMvoim816ZQdgu+
	yBF+SyxfEUGoXwzub2FydAb02qd549vkDxzLvlG58UeHdJn6caqSMn6YNW18RHeba1aIcd
	BQATmlzRxMg5aijTuMseAGJXeY50kJk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-oXW_Om9aP1Gz-AN1ThdyzQ-1; Tue, 02 Apr 2024 15:18:19 -0400
X-MC-Unique: oXW_Om9aP1Gz-AN1ThdyzQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C5C02185A786
	for <gfs2@lists.linux.dev>; Tue,  2 Apr 2024 19:18:18 +0000 (UTC)
Received: from fs-i40c-03.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by smtp.corp.redhat.com (Postfix) with ESMTP id BDE6040C6DB5;
	Tue,  2 Apr 2024 19:18:18 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCHv4 dlm/next 13/15] dlm: remove schedule in dlm receive path
Date: Tue,  2 Apr 2024 15:18:08 -0400
Message-ID: <20240402191810.1932939-14-aahringo@redhat.com>
In-Reply-To: <20240402191810.1932939-1-aahringo@redhat.com>
References: <20240402191810.1932939-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

This patch removes an explicit schedule() call in the receive path of
dlm message processing. The goal in DLM is to not trigger any additional
scheduling while processing DLM messages. This schedule() is directly
called inside the dlm message processing path. As soon we handle the dlm
messaging processing in softirq context we cannot call schedule() in
this context anymore. This patch prepares for this transition by simple
removing this schedule() call.

Handling schedule() in a DLM lock request burst can result in that we
trigger more and more lock request without making the lock requests done.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/lock.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index 2f53fdfe262a..e4cec14f9973 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -2543,7 +2543,6 @@ static void process_lookup_list(struct dlm_rsb *r)
 	list_for_each_entry_safe(lkb, safe, &r->res_lookup, lkb_rsb_lookup) {
 		list_del_init(&lkb->lkb_rsb_lookup);
 		_request_lock(r, lkb);
-		schedule();
 	}
 }
 
-- 
2.43.0

