Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEBD153594
	for <gfs2@lists.linux.dev>; Tue,  9 Apr 2024 16:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712681126; cv=none; b=WNPDkmDV4XzL3iebg2hjDs4vJYvWZ0Io6cnmQuG5Iv5otTjtftT/DXs0z6o+FY2h1m5jzv0x105/86eJ/k6geJhq0KeADFjqy8UbxciyK2+HtKctNqDd3rl0bHTi2CB2Sq7pDAbfzO2Pi+lyAFR0N76RaeZAgFwX6/JGuce2x/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712681126; c=relaxed/simple;
	bh=/2CM6dCPDQDOLrtYeYlavaAFML9DzFYizOqHfo2mimg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vxo6LxvK8GnaEhxOe3MK0w/EmJe3gGCsHG7sSuuP1Uv2qXkQzsZPyb9/ahn0INAb1oxwmfNzD4WVxvKmAy5oVqOvloWTm7XXoSApz+s6+QtPZNg7PXDN2/DKOL+S3oQ2qoqIGbY4kgWR7h55dvdtulnY3xijd8QYaEzUkT7ur4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ir7Y0yGU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ir7Y0yGU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712681124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kx+vfb1pRg5yFxrvSCS5MZ3gpPRxnRk0NCYu4XB5/ac=;
	b=Ir7Y0yGU9f+D9Amm1JD/aioqpezf/1Qjs2tPmyHS2UChk9QWb/z7GY59GsWuJIh2vpZU/F
	UL9GoyRF4KHyMRAxW79SQvfi/gjJq6lx5RIkvnzBoq8i7KCJkWXaxyrs0IPVRwdZZavhwK
	AZFErm8pdygq4b+kb8mipknDEuQ/R+o=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-70-Iip1Y17QMn-4Di_cM_noTA-1; Tue,
 09 Apr 2024 12:45:23 -0400
X-MC-Unique: Iip1Y17QMn-4Di_cM_noTA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E8BF928EC102
	for <gfs2@lists.linux.dev>; Tue,  9 Apr 2024 16:45:22 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.28])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6A354C0157E;
	Tue,  9 Apr 2024 16:45:22 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 12/15] Revert "gfs2: fix glock shrinker ref issues"
Date: Tue,  9 Apr 2024 18:45:02 +0200
Message-ID: <20240409164508.79570-13-agruenba@redhat.com>
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

This reverts commit 62862485a4c3a52029fc30f4bdde9af04afdafc9.

Commit 62862485a4c3 tried to fix issues introduced by commit
228804a35caa ("gfs2: Make glock lru list scanning safer"), but like that
commit, it failed to account for the bias state_change() adds to the
glock reference count for locked glocks.  Revert commit 62862485a4c3 so
that we can fix commit 228804a35caa properly.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/glock.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index ec1f8eb28950..2882a42e88aa 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -2056,9 +2056,7 @@ static long gfs2_scan_glock_lru(int nr)
 		if (!test_bit(GLF_LOCK, &gl->gl_flags)) {
 			if (!spin_trylock(&gl->gl_lockref.lock))
 				continue;
-			if (gl->gl_lockref.count <= 1 &&
-			    (gl->gl_state == LM_ST_UNLOCKED ||
-			     demote_ok(gl))) {
+			if (!gl->gl_lockref.count) {
 				list_move(&gl->gl_lru, &dispose);
 				atomic_dec(&lru_count);
 				freed++;
-- 
2.44.0

