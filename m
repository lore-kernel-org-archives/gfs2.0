Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D4D1591FC
	for <gfs2@lists.linux.dev>; Wed, 29 May 2024 17:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717002241; cv=none; b=rwFQywq1M9RsIP+hlyzAZfBxGPypS+xWmQpLpx8pcjYpA7Az+XS4G+MPb8dFImpq1rehSYg3Me8Rn6B6sYYR6IlyPXfxof+d42GY2ULM6UujAOUE/ap4QNv6C+yINJ5+gYcOx/HBcw9DP0Nlb4ErTb92TrG0adeXhz7jjdrhUW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717002241; c=relaxed/simple;
	bh=r6pO3yOJrjNCYDng9Y2FqZZKcXayWks1IDOZhx3Di/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G8SM8lVi6oJ9/x4c0xQGcSALCHZLHTPiz1DepiDC8F/JXl3LauhQxYUx7Y51fT6mEHSvS+vvzBc6oLxdpoPwsMOBglQUP4LbQEKD+PaO+9m8380P+qgtW0w8/d2p++ZkJ5P+J+A3CkVO0qcktHb1xH3EXM1MnaTXG+Cuts/WB6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YcDrfBde; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YcDrfBde"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717002238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bywAwVVhA51RjrK9rEptGVLrUcQDi8UxS3FAy+5xTQ0=;
	b=YcDrfBdeY1Jr9DiQ+6KBTD9n1EQQ2jdpyR0KEspwVw98rlIsLHRi6QagYC/qK64BniA6k8
	tJ8A1JWx5hgilAPLTrOeopSuW+xlRSKCcDZe1XOWZjdfyWqmS0VnKeXZPZCZEOhswp44IC
	iFYBTyjKtobIBgUErswe3QszzORL8Ik=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-iW5-0iXpPz-iGGHig9o92A-1; Wed, 29 May 2024 13:03:55 -0400
X-MC-Unique: iW5-0iXpPz-iGGHig9o92A-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EB3D6812296
	for <gfs2@lists.linux.dev>; Wed, 29 May 2024 17:03:54 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.40])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6F195492BC6;
	Wed, 29 May 2024 17:03:54 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 01/15] gfs2: Remove unnecessary function prototype
Date: Wed, 29 May 2024 19:03:38 +0200
Message-ID: <20240529170352.571141-2-agruenba@redhat.com>
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

Function __gfs2_glock_dq() gets defined before it is used, so there is
no need for a separate function declaration.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/glock.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 4ea6c8bfb4e6..873d76670238 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -61,7 +61,6 @@ struct gfs2_glock_iter {
 typedef void (*glock_examiner) (struct gfs2_glock * gl);
 
 static void do_xmote(struct gfs2_glock *gl, struct gfs2_holder *gh, unsigned int target);
-static void __gfs2_glock_dq(struct gfs2_holder *gh);
 static void handle_callback(struct gfs2_glock *gl, unsigned int state,
 			    unsigned long delay, bool remote);
 
-- 
2.45.1

