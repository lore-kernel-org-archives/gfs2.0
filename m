Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16A1283C89
	for <gfs2@lists.linux.dev>; Fri, 23 Jan 2026 15:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769182294; cv=none; b=pUGgENZiL2oWWtK7dS7Vzrj0B3mlIcBF8u84zKUVcvHANM6BNxV2hipCGwpbcvwomDfrqrxn0bnwsFxNY/seJDprDf7Wk7+un564nAepk3oVnX54fdub3jzMo9tdgw+GRBucRxSp2wShpAlXERFAkso3CtApseo4l31dOMirY5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769182294; c=relaxed/simple;
	bh=irq8CA464A6WPFLTT29FSzUpuc0CfiCmh0y91vu8Iwk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=p6wAEzsaoByHyjwn7ELVI442fUnQuUEAoFQ8umW2XX0+DfRTMtPmFdvKWUdxo+6WEW+Y5lGsMW5PmF1UJlfIz1DVwGgsY9fwYBUlWAPLq4kCoifrVvTczrZPCzyhnldtkKUd0cgyUzArgxf3mujJVWhXWIdEjXDjAGNTqYs80K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TCJrdahB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TCJrdahB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769182291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aW3AmTNiG7W+cLtzQl4usttp4shU1tgpZJJ6l43/nVM=;
	b=TCJrdahBRGA/GFP9nByiG4erVv1ljLLRpzqCCpF4/8UFSb/8EfyDj3Wu7QkjrF8DkPAPH9
	5t/caP91QoIJlN8o2xvdGg2wS5G/awmNGg3nUFyeCYroOfxB7NkSj/FNLOZlUXhiV4ZL7w
	fKWkbMhSi0UHg6eFSsXLW00iZJm9pKM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-OKc524q2PF-iNaaZy8TWkA-1; Fri,
 23 Jan 2026 10:31:28 -0500
X-MC-Unique: OKc524q2PF-iNaaZy8TWkA-1
X-Mimecast-MFC-AGG-ID: OKc524q2PF-iNaaZy8TWkA_1769182287
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5A8BC1944B35;
	Fri, 23 Jan 2026 15:31:27 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.52])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2496E30002D1;
	Fri, 23 Jan 2026 15:31:25 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	syzbot+046b605f01802054bff0@syzkaller.appspotmail.com
Subject: [PATCH 13/13] gfs2: Fix slab-use-after-free in qd_put
Date: Fri, 23 Jan 2026 16:31:03 +0100
Message-ID: <20260123153105.797382-14-agruenba@redhat.com>
In-Reply-To: <20260123153105.797382-1-agruenba@redhat.com>
References: <20260123153105.797382-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jskvqvVCes3szz7RjIV1VRtaySCWQM-gXXoWw9ZyjWA_1769182287
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Commit a475c5dd16e5 ("gfs2: Free quota data objects synchronously")
started freeing quota data objects during filesystem shutdown instead of
putting them back onto the LRU list, but it failed to remove these
objects from the LRU list, causing LRU list corruption.  This caused
use-after-free when the shrinker (gfs2_qd_shrink_scan) tried to access
already-freed objects on the LRU list.

Fix this by removing qd objects from the LRU list before freeing them in
qd_put().

Initial fix from Deepanshu Kartikey <kartikey406@gmail.com>.

Fixes: a475c5dd16e5 ("gfs2: Free quota data objects synchronously")
Reported-by: syzbot+046b605f01802054bff0@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=046b605f01802054bff0
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/quota.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
index 21dfe1e48da6..1c3455093ae8 100644
--- a/fs/gfs2/quota.c
+++ b/fs/gfs2/quota.c
@@ -334,6 +334,7 @@ static void qd_put(struct gfs2_quota_data *qd)
 		lockref_mark_dead(&qd->qd_lockref);
 		spin_unlock(&qd->qd_lockref.lock);
 
+		list_lru_del_obj(&gfs2_qd_lru, &qd->qd_lru);
 		gfs2_qd_dispose(qd);
 		return;
 	}
-- 
2.52.0

