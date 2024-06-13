Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD124C6B
	for <gfs2@lists.linux.dev>; Thu, 13 Jun 2024 17:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718298410; cv=none; b=QdERUIIv6zu/6/J7cOZWb5i8fjChKsQCho2ikbZBJ93jgT1ia1SQW7W6PZGAe1tTEaFunqLmOOQqW+2dBuaewAswL4vdYYzroA2FKniZrWTnlak9rdZBDCw/g5CaGHTPVZWrNnkLI8Yeh6uy+eaSRcxYHuVIPMow6xQR08v/cF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718298410; c=relaxed/simple;
	bh=TPwTVyxcgQI2VpLmRWdII6Ovn+E+huN6ovFqqU4nz6I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jO5W2j4/ITIR6yPWXTIqBDy5GVSkpcluiS9w/pGIiRQnsTy5j9Ekrn/ox89V51IrkjBy+05RWc+wQkTD9bZd/vre8FsSbgcwU7s5JaHNWn3v9qBoSszTlENDsHlEtr4Y7FnKpYFzwJHwAP44lH7qfMCXCSjBcqywXyW0HLhNJFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DDIGaYbG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DDIGaYbG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718298407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=v02zLoQZ24ATQ/Pol/0e+aWILajcQyqzs63tWZLlhfc=;
	b=DDIGaYbGi0dx8eN15fFhFnH9/J6244rlaXis4MGXzcO1SYlx20r7DByreyj/zpMtE/8OCp
	Su3tUWR8KF0co1Me1XPlbfFxXkVi6/Hc5TYPwlqg8opuKTWTxvZuspHJfl2lTeDIqw39yT
	Cr7eZGTIdobcWq6FhaKHs3pbuuYAgyU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-686-UgReIx4kObGC484vZwjFJA-1; Thu,
 13 Jun 2024 13:06:45 -0400
X-MC-Unique: UgReIx4kObGC484vZwjFJA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 10868195608B
	for <gfs2@lists.linux.dev>; Thu, 13 Jun 2024 17:06:45 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4D42919560AA;
	Thu, 13 Jun 2024 17:06:44 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCH dlm/next] dlm: add rcu_barrier before destroy kmem cache
Date: Thu, 13 Jun 2024 13:06:40 -0400
Message-ID: <20240613170640.3556585-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

In the case we trigger dlm_free_rsb() that does a call_rcu() and the
responding kfree() of res_lvbptr and a kmem_cache_free() of the rsb
pointer we need to wait until this pending operation is done before
calling kmem_cache_destroy(). We doing that by using rcu_barrier() that
waits until all pending call_rcu() are done. This avoids that
kmem_cache_destroy() complains about active objects around that are not
being freed yet by call_rcu().

There is currently more discussions about to make this behaviour better,
see:

https://lore.kernel.org/netdev/20240609082726.32742-1-Julia.Lawall@inria.fr/

However this is only for call_rcu() if the callback calls
kmem_cache_destroy() only to replace it by kfree_rcu() call which has
currently some issue. This isn't our case because we also free the
res_lvbptr if being set.

For our case, to avoid the above race rcu_barrier() should be used before
calling kmem_cache_destroy() to be sure that there are no active objects
around. This is exactly what net/batman-adv is also doing before calling their
kmem_cache_destroy() in module unloading.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/memory.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/dlm/memory.c b/fs/dlm/memory.c
index 105a79978706..8c44b954c166 100644
--- a/fs/dlm/memory.c
+++ b/fs/dlm/memory.c
@@ -72,6 +72,8 @@ int __init dlm_memory_init(void)
 
 void dlm_memory_exit(void)
 {
+	rcu_barrier();
+
 	kmem_cache_destroy(writequeue_cache);
 	kmem_cache_destroy(mhandle_cache);
 	kmem_cache_destroy(msg_cache);
-- 
2.43.0

