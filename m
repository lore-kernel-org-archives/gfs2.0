Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B9217729
	for <gfs2@lists.linux.dev>; Tue, 27 Feb 2024 01:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708998569; cv=none; b=a7lde5xe6LKiCzmWquM59JsiXiHZEr7/uTBL3NqNIlBdktIvIGSGsJRmxjIxh3mg15Z1cOCsojESXf4KoLOph33t2inzTYX3KxKRZpP3DvnqPq6Q/AkWRY45BhIuLkgtCrshBpZ2XW0vg+DpyquUb6fePt4nGv06eMrGI9kbFKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708998569; c=relaxed/simple;
	bh=lyCWNmQCs1fVewTtTixrHyrubMHQg3wMH3rEOki+yFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=frQaDzdM9Qyil9uHmST0cZQXDKRDt4640VM5TENgcNEosldI2BBMuGbaTCFOss29qvozUyv2P3E6FxFLh81JJUsASBW6EOeLE9tcBqWNuGHcEdZNRWLVSklHx5Zf5OAVCgc1mz95t8O/XpfmUuFv/BgBIkkaxQBbzl4M1nd530c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UIo5NSvx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UIo5NSvx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708998561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MNrjHgAt3QcsQut6lEEjCNddFrH9wZJwmHJpbdqI0O8=;
	b=UIo5NSvx348Aq5L4N0gtgjkWgib3w9Cr9/trpHnvYc8EliVSajJagupLRv2N1IlJcUtigq
	mNh02A8vEeQGS+uRRlAeAFfShcKrEHrYd30mZ+o/ozZqFtn9KniZu2uCzi4GTqeZJkClNR
	QtyQm+71wOQ/LxRnusWSKj2IclEIPpU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-zCt11vp1OcG6YsWxwKn6ew-1; Mon, 26 Feb 2024 20:49:19 -0500
X-MC-Unique: zCt11vp1OcG6YsWxwKn6ew-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EFA09108C063
	for <gfs2@lists.linux.dev>; Tue, 27 Feb 2024 01:49:18 +0000 (UTC)
Received: from fs-i40c-03.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.fast.eng.rdu2.dc.redhat.com [10.6.23.54])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E84492166B5D;
	Tue, 27 Feb 2024 01:49:18 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCHv3 v6.8-rc6 01/18] fs: dlm: Simplify the allocation of slab caches in dlm_midcomms_cache_create
Date: Mon, 26 Feb 2024 20:48:52 -0500
Message-ID: <20240227014909.93945-2-aahringo@redhat.com>
In-Reply-To: <20240227014909.93945-1-aahringo@redhat.com>
References: <20240227014909.93945-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

From: Kunwu Chan <chentao@kylinos.cn>

Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
to simplify the creation of SLAB caches.

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/midcomms.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/dlm/midcomms.c b/fs/dlm/midcomms.c
index 2247ebb61be1..8e9920f1b48b 100644
--- a/fs/dlm/midcomms.c
+++ b/fs/dlm/midcomms.c
@@ -226,8 +226,7 @@ static DEFINE_MUTEX(close_lock);
 
 struct kmem_cache *dlm_midcomms_cache_create(void)
 {
-	return kmem_cache_create("dlm_mhandle", sizeof(struct dlm_mhandle),
-				 0, 0, NULL);
+	return KMEM_CACHE(dlm_mhandle, 0);
 }
 
 static inline const char *dlm_state_str(int state)
-- 
2.43.0

