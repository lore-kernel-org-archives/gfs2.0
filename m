Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3316A15B573
	for <gfs2@lists.linux.dev>; Tue,  2 Apr 2024 19:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712085503; cv=none; b=lA5trKLxQpFSouZcCz27B9pG7AFonfp115keyX/s2ApLLFWbpf/Z1gaLmcPNAZsvyqVWXwdS20H7X6GwHEJPnOn7HXe3BgLuVW10ZKnUBHBkgp+TA0c7hw8Hiz0URTzyvkt0NTfTk6SxqqTHgehe3qir3xMtRLvWs8tRSybFTkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712085503; c=relaxed/simple;
	bh=oM5VO0r47N2bO4ed5h+Pma8Jgk7RaksdPjc4HrZS53c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fbOwBVEK+L4R5QeJW9DCfxGDUIANuoGmuV5VICyxFRXGgkuv+esd2LPMRk3hraPvwp3IovbuO7SSG1gvGwWeHeCjN/TGVwriJQrmkDVwfX6XN/GiXjYT+BCToI9lALG1nf3X4DaYjNFhBTAvoYGKYxGc7QwT4hZUoGQO+wfTXVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A0iqRsRl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A0iqRsRl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712085500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VKTfh5M3Z/EK9iyQSLVi+oHk1Fa/l+1wRHSue4lwsjo=;
	b=A0iqRsRlYSCyxU8/qUfr2AkvBgVLw9pKrlW61jhmSditEniBx/Wlez/uq5ooCUfhWar+gN
	HWgVT7Fg/caxlhXvk9icPwxk0UK3KCCP/PIeHPlaAKAMu1ntpbxetYkQMq+sjxY0z6D4vv
	l+qSawRYe0R7SNNHTtBUtc6yYvAYwWU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-Cr-UEVtxOiKZPMS0yWVdBA-1; Tue, 02 Apr 2024 15:18:18 -0400
X-MC-Unique: Cr-UEVtxOiKZPMS0yWVdBA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5E39D8059E8
	for <gfs2@lists.linux.dev>; Tue,  2 Apr 2024 19:18:18 +0000 (UTC)
Received: from fs-i40c-03.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 577BB40C6DB3;
	Tue,  2 Apr 2024 19:18:18 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCHv4 dlm/next 01/15] dlm: Simplify the allocation of slab caches in dlm_lowcomms_msg_cache_create
Date: Tue,  2 Apr 2024 15:17:56 -0400
Message-ID: <20240402191810.1932939-2-aahringo@redhat.com>
In-Reply-To: <20240402191810.1932939-1-aahringo@redhat.com>
References: <20240402191810.1932939-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

From: Kunwu Chan <chentao@kylinos.cn>

Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
to simplify the creation of SLAB caches.

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
Acked-by: Alexander Aring <aahringo@redhat.com>
Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/lowcomms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
index 6296c62c10fa..712165a1e567 100644
--- a/fs/dlm/lowcomms.c
+++ b/fs/dlm/lowcomms.c
@@ -248,7 +248,7 @@ struct kmem_cache *dlm_lowcomms_writequeue_cache_create(void)
 
 struct kmem_cache *dlm_lowcomms_msg_cache_create(void)
 {
-	return kmem_cache_create("dlm_msg", sizeof(struct dlm_msg), 0, 0, NULL);
+	return KMEM_CACHE(dlm_msg, 0);
 }
 
 /* need to held writequeue_lock */
-- 
2.43.0

