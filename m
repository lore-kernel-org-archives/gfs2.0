Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F14412AAD3
	for <gfs2@lists.linux.dev>; Thu, 28 Mar 2024 15:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711640927; cv=none; b=KAI/VqY1d/5dnPlLpgRvnXdiAvz8NtHwP2aJlJ2hibL430Tkcea2CWPaOjBpeUNzTvg3eefvyYId7x/WpFljsvne97O+n+5OghCktK8TkIQB3quLsmHp5v1lgi/fyGxExVVYS87i2BqLrrfTSfs0eFV+4ujVQTIWcQ2ibPjAyP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711640927; c=relaxed/simple;
	bh=lyCWNmQCs1fVewTtTixrHyrubMHQg3wMH3rEOki+yFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OMgfuKXGqxUT3ciS43EJesvnN0seNdGvOiVzA9v/BHO4cQWzxKZfMZ+ifIKU1h6PuTWNQ/uSIPZYXOWNxKoeReZsJeS0XpooRWw1MXcRj9MzaFJ4MV17f9tmnOWzTKF6sUwNVagBFcli/hBwFdvHnt6cFVtleUOp8MmMLI1UwTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EPQvzL4X; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EPQvzL4X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711640925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MNrjHgAt3QcsQut6lEEjCNddFrH9wZJwmHJpbdqI0O8=;
	b=EPQvzL4Xwr6BUYcqi7i8j1S+bXzSlobZE3PabxfuwgHNjkDi9Rgjr8mep8X9iGMZ7WsVFe
	jhQvRLoHWW3r26tYT1Q1H8ViCxSmYA7RK5QNP5kpYFERg4FHEAJuZTTjwbHmSIEQo1OtcW
	6qCrOGqQXMawrcVdQ5o2kPPQpZR8RfE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-90fepr8QOeu0aywayX2I4A-1; Thu, 28 Mar 2024 11:48:43 -0400
X-MC-Unique: 90fepr8QOeu0aywayX2I4A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 89999811E81
	for <gfs2@lists.linux.dev>; Thu, 28 Mar 2024 15:48:43 +0000 (UTC)
Received: from fs-i40c-03.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 827B5C04123;
	Thu, 28 Mar 2024 15:48:43 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev
Subject: [PATCH v6.9-rc1 02/10] fs: dlm: Simplify the allocation of slab caches in dlm_midcomms_cache_create
Date: Thu, 28 Mar 2024 11:48:34 -0400
Message-ID: <20240328154842.1099288-2-aahringo@redhat.com>
In-Reply-To: <20240328154842.1099288-1-aahringo@redhat.com>
References: <20240328154842.1099288-1-aahringo@redhat.com>
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

