Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEAB12F38D
	for <gfs2@lists.linux.dev>; Thu, 28 Mar 2024 15:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711640928; cv=none; b=Jg1K9iF5a3oy0I18Zm5i/ePRZyZW6Zzid6x5ZnSvglW/nZjlznVd2mhpEYpRVdVqL/UoiBEZMLcSMqtrsULHpClSfPoYuRLPruwGaVb12amQg6TvzIo0IFVZ4nEh0pGDnkzZTLe/Kf9L5ZI+dsiyOS5fH6TKxE8ugj5jRZSkczA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711640928; c=relaxed/simple;
	bh=oM5VO0r47N2bO4ed5h+Pma8Jgk7RaksdPjc4HrZS53c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HwfXNXtvV29Ryea6Cv96VhB8uvRjBUll5D+E3nluo/eKmGjVLXz1zisfcQn7A0S6tt6ClDl8twFEh4uaErmLql5i8BuCtSzVSmnLlehYeoecCC2Muja1KTgroZrqybawoTgi3qfuMFeSImKNgEAtL3i8yu8mNqVZdEGuUw9t0k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BIcL2ZiF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BIcL2ZiF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711640925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VKTfh5M3Z/EK9iyQSLVi+oHk1Fa/l+1wRHSue4lwsjo=;
	b=BIcL2ZiFf8B0Wf4f6qYm7PuP1OALLtzyORls3zKtYpNBkkjbkcNnBSOJMMh+19Wu8ge7SR
	Ye8I3CCOoweapoiseaUYU3JevDDkD6DA5+dA3Ke7rGBC3nLW2b5bWHF1x+bgB01pzo9xSg
	rto+hc8zm2YzLducVInnRjnIiRajfhs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-lwGliaFsPeGjFdskx8d9ww-1; Thu, 28 Mar 2024 11:48:43 -0400
X-MC-Unique: lwGliaFsPeGjFdskx8d9ww-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 944738007A4
	for <gfs2@lists.linux.dev>; Thu, 28 Mar 2024 15:48:43 +0000 (UTC)
Received: from fs-i40c-03.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8DD1BC04124;
	Thu, 28 Mar 2024 15:48:43 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev
Subject: [PATCH v6.9-rc1 03/10] fs: dlm: Simplify the allocation of slab caches in dlm_lowcomms_msg_cache_create
Date: Thu, 28 Mar 2024 11:48:35 -0400
Message-ID: <20240328154842.1099288-3-aahringo@redhat.com>
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

