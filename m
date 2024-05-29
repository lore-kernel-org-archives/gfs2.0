Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32491459E3
	for <gfs2@lists.linux.dev>; Wed, 29 May 2024 17:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717002240; cv=none; b=Kwk0T4DoX7g6aMFaXrmc2U/xXxkFMzCv8p1vYUd8CkOLhPsSFsPyS9F6hZWaUZ+Lenlbjnzmg0H98QgchkjJhq4Da/mGgySfc/CzGqP2thpKyNtV63S+kbDEeOEE3TfKpDvi9u4B10AZ2SgjMRDI9ZfDBLIjCcPe7bRJne+fGTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717002240; c=relaxed/simple;
	bh=9FmgrSV8YGnGo+upGvpHUIFBvar94LpzbRmG7c0GVpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZsBBAsOw2ZCVh7YlvDDfB36oJEhxSxkJxgcC1AviOul/eDE2HzbpHtIxH61uGt/9nybTVChjxvMFSSXN28pmfZo0VhkwCFkgPVCcTTgErA1EiPvkLfBoAQAwz+r5GFBVgoAQuThWKkg2/nZsh+G8tirt9J6RgE/5XoFbUwiypHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c2CPF6Tu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c2CPF6Tu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717002238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fdJ59N2T/QV5v4jdoQ6pNd9EfQ6jmX6riBQU4AXcOlc=;
	b=c2CPF6Tu0UkndQ9qBDIuq+iqulP+h6vDYJgj3dnlbBz8865VxDZM3ZLLoNQoKg6DaHLBNj
	95twfRxLt/8bZgb0q66DkhwG+a1vVzluOClzehRYKfZhg9AQj1fB1QX35NiIKX8f6Bwm/q
	kVtfnylDgzsvNp/Ivo/tgu9zXaMR5/Q=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-107-9UmUKfHqP9u31J3xiv0hfA-1; Wed,
 29 May 2024 13:03:55 -0400
X-MC-Unique: 9UmUKfHqP9u31J3xiv0hfA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ADD1F29AA384
	for <gfs2@lists.linux.dev>; Wed, 29 May 2024 17:03:55 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.40])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3104A492BC6;
	Wed, 29 May 2024 17:03:55 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 02/15] gfs2: Remove useless return statement in run_queue
Date: Wed, 29 May 2024 19:03:39 +0200
Message-ID: <20240529170352.571141-3-agruenba@redhat.com>
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

The return statement at the end of run_queue() is useless.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/glock.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 873d76670238..d1fb0b2b5649 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -909,7 +909,6 @@ __acquires(&gl->gl_lockref.lock)
 out_unlock:
 	clear_bit(GLF_LOCK, &gl->gl_flags);
 	smp_mb__after_atomic();
-	return;
 }
 
 /**
-- 
2.45.1

