Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC11821578D
	for <gfs2@lists.linux.dev>; Fri, 23 Jan 2026 15:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769182288; cv=none; b=UHZsilNNDgGCAKx23lBfAhoSElEVT4UCPtMatCqLDV2nxmd+rBKeOotJlyfEz9N7RLqqY6jQ0smU7FkWvLndxspKhB/YTUCmva9RUUazBLMzJGjcQ7/yZjdSqXh94AWaHx2o5laiJjGfGUXvOnqxhnt5HPX05hlqmHTD8RHQHbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769182288; c=relaxed/simple;
	bh=3p/onBM9GVmWz7VY+i85+s6mT9MVhBVFM+qb7u3Lm/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=hkjMnYf4Aj/6FnohwqGej3WU9tyoHeDw2qfflgAGPknTK+kxqtyYhjDEj9uPovN7V9sMEshK85dv1I7ai/Q9yC7PfXxHSqG2jKm83TjgGdUs+bOVSgbwnkibu+EKvSZ273UI1RN1+9zsxe9D+6C/Sl4O4ATY1QaBi8SvC7fJB+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eBYxkLPW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eBYxkLPW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769182286;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RYYocqp+WzV/aJvRG9BSGKAunCY28cIoZdi54SVRKYQ=;
	b=eBYxkLPWoB2OJ2u5LNZ0Q+97TiA+TLkeZPfSLZnSY77j6D7yd/4bUxN267RwFZ0YeVk9VV
	c4xs59XjxPo24YHRcYdpZme3dtKoa1RDoIiyt0MobAd7l1WUupx67Xql98s+lmeBmtzoBe
	Tda1Offm8cyi2jNmdAGKuYaG/i0TPjk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-680-VKXVLK4QNPiYc1J4hJKYZA-1; Fri,
 23 Jan 2026 10:31:24 -0500
X-MC-Unique: VKXVLK4QNPiYc1J4hJKYZA-1
X-Mimecast-MFC-AGG-ID: VKXVLK4QNPiYc1J4hJKYZA_1769182284
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 131B91800473
	for <gfs2@lists.linux.dev>; Fri, 23 Jan 2026 15:31:24 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.52])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 168A130002D1;
	Fri, 23 Jan 2026 15:31:22 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 11/13] gfs2: gfs2_glock_hold cleanup
Date: Fri, 23 Jan 2026 16:31:01 +0100
Message-ID: <20260123153105.797382-12-agruenba@redhat.com>
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
X-Mimecast-MFC-PROC-ID: r9v3THlvt3gCDPz5TIKppPImdgnvhv5WYLsuFG7Arcg_1769182284
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Use lockref_get_not_dead() instead of an unguarded __lockref_is_dead()
check.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/glock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 7c3d488327ee..bba415511920 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -185,8 +185,8 @@ static void gfs2_free_dead_glocks(struct gfs2_sbd *sdp)
 
 struct gfs2_glock *gfs2_glock_hold(struct gfs2_glock *gl)
 {
-	GLOCK_BUG_ON(gl, __lockref_is_dead(&gl->gl_lockref));
-	lockref_get(&gl->gl_lockref);
+	if (!lockref_get_not_dead(&gl->gl_lockref))
+		GLOCK_BUG_ON(gl, 1);
 	return gl;
 }
 
-- 
2.52.0

