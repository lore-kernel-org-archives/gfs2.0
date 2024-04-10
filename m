Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E5A1836CE
	for <gfs2@lists.linux.dev>; Wed, 10 Apr 2024 21:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712784504; cv=none; b=jw91SVqwim7qxHgJ4xJivfsj0gcklpZkMaFflgrmztwn7vbwhvGtFaE8QW7hpW+QWwzrmflMydPY6nUl8PzEKvoNJwIMun7d4BYJNcbBW+5ZXEv2LtMJdRfefv4sTIOzPlPrjAueASRdEQMw41swSIBmhOFZHxqZfZ+5h8wMn5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712784504; c=relaxed/simple;
	bh=l45ViEiAEJaToy9ZogHdCyCQCMk1fknve+saPvPXEt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iY8XkLRHaOidnhsBnN9ug45cIXpMqjIjYguxZ78IEuInH0s01v0YF8XFGmRZOmnZ26WWxFxwsEx/W682caK+yeBrP2lrmoeM9OKtiePifi8bvj+RzDsAiiet3li3MArzaCJJJYYRjbI7VxNNL9js2u8jvpS9VocuGHDFXm7TaIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MT4UnOEH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MT4UnOEH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712784501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9qfdBkoEQjWFasni84ubhoNipuP+ALBUv6/Uxt31pmo=;
	b=MT4UnOEHxWFgf4qHM5SMMijV6Khp98M0GafIJVfZ9J8UqbHAxJ450WEO0CRRfaMu9Jo51Y
	8FcMGpfBW9HM9MKp4Uwcklfc0jpjQCCFf8mj/lU7nH7Pkc5vD7aK4iGEn6QQSw9AvvH61J
	iX6cp7aNTuTu1wwE8gGeCYV3lesZzB8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-49-UW__2vFWNCSmz8zONMvIoQ-1; Wed,
 10 Apr 2024 17:28:20 -0400
X-MC-Unique: UW__2vFWNCSmz8zONMvIoQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2D7051C05156
	for <gfs2@lists.linux.dev>; Wed, 10 Apr 2024 21:28:20 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.28])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A75B1444FE2;
	Wed, 10 Apr 2024 21:28:19 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 1/3] gfs2: Remove ill-placed consistency check
Date: Wed, 10 Apr 2024 23:28:11 +0200
Message-ID: <20240410212814.204819-2-agruenba@redhat.com>
In-Reply-To: <20240410212814.204819-1-agruenba@redhat.com>
References: <20240410212814.204819-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

This consistency check was originally added by commit 9287c6452d2b1
("gfs2: Fix occasional glock use-after-free").  It is ill-placed in
gfs2_glock_free() because if it holds there, it must equally hold in
__gfs2_glock_put() already.  Either way, the check doesn't seem
necessary anymore.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/glock.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 4be140ab53e4..60503e378740 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -170,7 +170,6 @@ void gfs2_glock_free(struct gfs2_glock *gl)
 {
 	struct gfs2_sbd *sdp = gl->gl_name.ln_sbd;
 
-	gfs2_glock_assert_withdraw(gl, atomic_read(&gl->gl_revokes) == 0);
 	rhashtable_remove_fast(&gl_hash_table, &gl->gl_node, ht_parms);
 	smp_mb();
 	wake_up_glock(gl);
-- 
2.44.0

