Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A8F152DEB
	for <gfs2@lists.linux.dev>; Tue,  9 Apr 2024 16:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712681123; cv=none; b=KV7/C3ojp/xfb2YRNUPTV/08E5aT+GaYa687IAVAsMbu6Vky7VZfEtiGtutRowoqeUWO13DQqN0kNjDKtVe7kZug3dUc4+ywR3aRaHxoxsQzNZwTTtB8g6LxnJsVtiXIcJtNh5NgClddaGrQKC8v6hLeYJVAllyMyzFO4cBwMeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712681123; c=relaxed/simple;
	bh=9BJdy5qXBBcW3OHuYiYm8MgQejNs0k7ow71Bw7p+29Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UPxPuwGGv0ibUbHDZC6Lulpe+HoT92942qzA7R9WyXTM4SHrJQ7IIkBuMXTducs0KfN8zSSEtQ3NyfkNlMqV9RJ4ZRusFlaa0I97CYb3xyhjuKHcCde8hYvQQABqmExGnl0NisBb8q71iKX9jkBBVG77nr18lEnSY9fCrfCZIag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AssWFJNe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AssWFJNe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712681120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E5t3SQT6aRifFw+WDxRqeoTGMfuc/qB1ADcFejxtpVw=;
	b=AssWFJNeXO1Rk7DBCZIASagyxIJnIWpF+tzqe2JY5IOhhysqMhi03clgVdX1GZ40h6b/s3
	c6ngP+1Y4Zpawo8JpKI5ZdAj5xC6HSO4RPvrLyrdr5HbMj9Kw3O/F5JoNeJDWT8CHPimMN
	I/rrvCBYA/NgRb10qaTqB8ODXBzUB44=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-335-Z35D8FMMNW2lYieiKSJfpg-1; Tue,
 09 Apr 2024 12:45:19 -0400
X-MC-Unique: Z35D8FMMNW2lYieiKSJfpg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2BB7728EC102
	for <gfs2@lists.linux.dev>; Tue,  9 Apr 2024 16:45:19 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.28])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A13A1C26A4B;
	Tue,  9 Apr 2024 16:45:18 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 07/15] gfs2: Get rid of gfs2_glock_queue_put in signal_our_withdraw
Date: Tue,  9 Apr 2024 18:44:57 +0200
Message-ID: <20240409164508.79570-8-agruenba@redhat.com>
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

In function signal_our_withdraw(), we are calling gfs2_glock_queue_put()
in a context in which we are actually allowed to sleep, so replace that
with a simple call to gfs2_glock_put().

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/gfs2/util.c b/fs/gfs2/util.c
index 963d77c4ca21..0535a0206512 100644
--- a/fs/gfs2/util.c
+++ b/fs/gfs2/util.c
@@ -255,7 +255,7 @@ static void signal_our_withdraw(struct gfs2_sbd *sdp)
 		gfs2_glock_nq(&sdp->sd_live_gh);
 	}
 
-	gfs2_glock_queue_put(live_gl); /* drop extra reference we acquired */
+	gfs2_glock_put(live_gl); /* drop extra reference we acquired */
 	clear_bit(SDF_WITHDRAW_RECOVERY, &sdp->sd_flags);
 
 	/*
-- 
2.44.0

