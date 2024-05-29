Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98453A55
	for <gfs2@lists.linux.dev>; Wed, 29 May 2024 17:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717002248; cv=none; b=suzR6UalTTE2Hk8H6FJaZ64ioXWPQXZ2UZQv1AxwsUWV6X//taRCshmXmEfA99zhJxtKJzK+pggipPKLQO/EjmjbXW3iTZhIZOn5UnpNhNopAkNyB5IHVDqDh8TXN3VeF8VxVoK8bX9UHTM7Xgtw4zHEizbx+5Ty/XVbWAdhM1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717002248; c=relaxed/simple;
	bh=9ggw/yQ2pv2hJ4zBOvJ4HVA2DNutdz6Ue03UjY7Yw2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rlF4mvTp1R5oBs1Cut/WR2oPCqrw8I+yAn4Q6GFWy0Skl5xfTNAh0C93XmRsCDEHnmU4wRxod6XUAt8kaUTuAMOHZQfbQQdMA2Th6bygo/ewGY3yGHcr2e94Q62pis3x1dkBue3T2wVeJnL9civtOXyE4WE5sw5S45PZbDw3ZEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KPb+vu0P; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KPb+vu0P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717002245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Aa8ZUly9BnWmhe58YC1JNfAjNUPmMmsb2pgQiyBEUYs=;
	b=KPb+vu0P5xNhwN5YaFPdmLGGAQab/T5DCeG69t/eE2Vd5hcgHt3SUZed66gt1wH6oQyRmR
	+X/PthsuvIlqcUPDf3EE4j/01ICoF1dr089m78jqmGHnO0uWeNPPPUEHRv0kStom23IqGL
	KcacfKG9lZD3dtFeILevf1GbYgLEOJE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-09dsw9FqOwOdnaWgMsKOWQ-1; Wed, 29 May 2024 13:04:02 -0400
X-MC-Unique: 09dsw9FqOwOdnaWgMsKOWQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6C9BC185A780
	for <gfs2@lists.linux.dev>; Wed, 29 May 2024 17:04:02 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.40])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E2A27492BC6;
	Wed, 29 May 2024 17:04:01 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 11/15] gfs2: Report when glocks cannot be freed for a long time
Date: Wed, 29 May 2024 19:03:48 +0200
Message-ID: <20240529170352.571141-12-agruenba@redhat.com>
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

When glocks cannot be freed for a long time, avoid the "task blocked for
more than N seconds" messages and report how many glocks are still
outstanding, instead.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/glock.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 2d4e927c4d2f..b819f8b8d98b 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -2248,13 +2248,25 @@ void gfs2_gl_dq_holders(struct gfs2_sbd *sdp)
 
 void gfs2_gl_hash_clear(struct gfs2_sbd *sdp)
 {
+	unsigned long start = jiffies;
+	bool timed_out = false;
+
 	set_bit(SDF_SKIP_DLM_UNLOCK, &sdp->sd_flags);
 	flush_workqueue(glock_workqueue);
 	glock_hash_walk(clear_glock, sdp);
 	flush_workqueue(glock_workqueue);
-	wait_event_timeout(sdp->sd_kill_wait,
-			   atomic_read(&sdp->sd_glock_disposal) == 0,
-			   HZ * 600);
+	while (!timed_out) {
+		wait_event_timeout(sdp->sd_kill_wait,
+				   !atomic_read(&sdp->sd_glock_disposal),
+				   HZ * 60);
+		if (!atomic_read(&sdp->sd_glock_disposal))
+			break;
+		timed_out = time_after(jiffies, start + (HZ * 600));
+		fs_warn(sdp, "%u glocks left after %u seconds%s\n",
+			atomic_read(&sdp->sd_glock_disposal),
+			jiffies_to_msecs(jiffies - start) / 1000,
+			timed_out ? ":" : "; still waiting");
+	}
 	gfs2_lm_unmount(sdp);
 	gfs2_free_dead_glocks(sdp);
 	glock_hash_walk(dump_glock_func, sdp);
-- 
2.45.1

