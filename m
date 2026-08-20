Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B9E449B02
	for <gfs2@lists.linux.dev>; Thu, 20 Aug 2026 14:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787235708; cv=none; b=TzGZuM1WZc8spXbPl0YfmokQgsMH28fS8KgJ1/8Trh2l5eagzcOyZyD1YDplBFtPacCiIYk0ruX3dA1NvyfIT2/V6yUHheaDKOX2aJLCGHVQLr8upY3nQvyHyPgqGDe14N8rEPk6lB9QB/HT3gMC582wVNXWYT+TaJxX83yXOVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787235708; c=relaxed/simple;
	bh=w8F7OkaTh8yux4R9v6xmF7yLRZAJ4pmF+IvTmq09+kc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=e4gW/LQ0XZd/gBzvkg5abwq+ypF7kO8gmqCMy3La7XN3cQNwgU183+JELX6TpjqGWGUw3eClsrJDYA2fuDGCMP8C4AUrOwU7MJYSg4lDFsb+x3V2mXDs0x3WdQn4hy0nOvH197Z+PM+TX5QE8j3gctGYHUaUn0VOPUQlJETBb8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cSmZQtGE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cSmZQtGE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787235705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IOeqiiPchY7AXP2klbE6giFdSzzy+NbEwTRrSuRqp4s=;
	b=cSmZQtGE0rCzLgtRXAPFcBDbWqiFOegzBs8xRYo2hG7w74t6WPO6x01ZqGgQUH+bvjjeTS
	eJfMA+ixu3JGNjtrBDTlFUKVNBQKL5HG0+PpLbZoPxQrNfIzfxBbVd4xhSyfNQOpFT8fxi
	9a9qJ8alCX2QsSJxnaXzR1WjvPyL7lo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-396-5Af5gNO2MTapEOrkfGuVfw-1; Thu,
 20 Aug 2026 10:21:43 -0400
X-MC-Unique: 5Af5gNO2MTapEOrkfGuVfw-1
X-Mimecast-MFC-AGG-ID: 5Af5gNO2MTapEOrkfGuVfw_1787235702
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ABAB91956070;
	Thu, 20 Aug 2026 14:21:42 +0000 (UTC)
Received: from pasta.redhat.com (unknown [10.44.48.197])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 78FB93001DAF;
	Thu, 20 Aug 2026 14:21:41 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	Adrian Garcia Casado <adriangarciacasado42@gmail.com>
Subject: [PATCH 6/6] gfs2: Silence sparse signedness warning
Date: Thu, 20 Aug 2026 16:21:27 +0200
Message-ID: <20260820142129.1327413-7-agruenba@redhat.com>
In-Reply-To: <20260820142129.1327413-1-agruenba@redhat.com>
References: <20260820142129.1327413-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _eatFlqMkjjHz1iuH6vBU9vrJKlJfjLgh-fU65P_R18_1787235702
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Silence the following sparse warning:

fs/gfs2/bmap.c:1718:42: warning: unsigned value that used to be signed checked against zero?
fs/gfs2/bmap.c:2017:16: signed value source

It's unclear to me what sparse is trying to tell me there, but making the
height variables unsigned shuts it up.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/bmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index b5ddd936f489..3714364385c7 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -1699,7 +1699,7 @@ enum dealloc_states {
 };
 
 static inline void
-metapointer_range(struct metapath *mp, int height,
+metapointer_range(struct metapath *mp, unsigned int height,
 		  __u16 *start_list, unsigned int start_aligned,
 		  __u16 *end_list, unsigned int end_aligned,
 		  __be64 **start, __be64 **end)
@@ -1770,7 +1770,7 @@ static int punch_hole(struct gfs2_inode *ip, u64 offset, u64 length)
 	unsigned int strip_h = ip->i_height - 1;
 	u32 btotal = 0;
 	int ret, state;
-	int mp_h; /* metapath buffers are read in to this height */
+	unsigned int mp_h; /* metapath buffers are read in to this height */
 	u64 prev_bnr = 0;
 	__be64 *start, *end;
 
-- 
2.55.0

