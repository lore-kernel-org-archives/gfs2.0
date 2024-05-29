Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DE91459E3
	for <gfs2@lists.linux.dev>; Wed, 29 May 2024 17:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717002244; cv=none; b=RBIOG8iuh7pWhQfW9HbSWuxWYDH1qW6s4GE+vy5ErdaFG52rRNwaleQeC9OhDl+0XDGjIQ60wxaha/+ZthVzvrc67aNBPM1Lfy/luImsjxgR2ssc8GvvTIOwX2JvIOUyNeJT32xV3Pm1r1OqoD+zhw49jnTdS/W9Wkb0yoD1dvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717002244; c=relaxed/simple;
	bh=uNcVD2sQ7zpJjGm28O3ekuLEAnS1fU+yuomB8a9TMIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oAa7WfalpSwQvbaGOH0XpfjDs+HhBC/jp9K+IKAHflx2WNdcZ34QU7vfjfYLo0eUR4/0mHqBGRD4RtyRojEb3+HqD0+oM1HRvRwXVZX3Acjq8dJ2TsASBJQvpL8CJFcFzECtt4aBrMhCqIAGl5wPRgFoJ8f5XCQ996kwQXkcaLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FH0Wr8ob; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FH0Wr8ob"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717002242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vrh0fJtGDaOT1jjh4updJ72TMsSLD5eoPyGSML/aabg=;
	b=FH0Wr8ob+z1WsqI7IEumLwF9UbWN2i64PVi01PyPuQe/x0mSQHQZqX5La75fQcXw4shOk6
	wr0CVHWEb8u8CKUA7GZKRBrqyPzkR2uptOwypqUtmxDNyNFeE6euPb1/AbUaPHSr6nleCP
	KUXRQgZ/BSJdRowJ85sriCZSTj/+LgU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-62-72xcFI6_ObaLA4QhNqPxBg-1; Wed, 29 May 2024 13:04:00 -0400
X-MC-Unique: 72xcFI6_ObaLA4QhNqPxBg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2EB7A800CB1
	for <gfs2@lists.linux.dev>; Wed, 29 May 2024 17:04:00 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.40])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A580C492BC6;
	Wed, 29 May 2024 17:03:59 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 08/15] gfs2: Remove outdated comment in glock_work_func
Date: Wed, 29 May 2024 19:03:45 +0200
Message-ID: <20240529170352.571141-9-agruenba@redhat.com>
In-Reply-To: <20240529170352.571141-1-agruenba@redhat.com>
References: <20240529170352.571141-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/glock.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index c583ba05e8f5..ef4fbb197c99 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -1137,11 +1137,7 @@ static void glock_work_func(struct work_struct *work)
 		gfs2_glock_queue_work(gl, delay);
 	}
 
-	/*
-	 * Drop the remaining glock references manually here. (Mind that
-	 * gfs2_glock_queue_work depends on the lockref spinlock begin held
-	 * here as well.)
-	 */
+	/* Drop the remaining glock references manually. */
 	gl->gl_lockref.count -= drop_refs;
 	if (!gl->gl_lockref.count) {
 		__gfs2_glock_put(gl);
-- 
2.45.1

