Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6CB85947
	for <gfs2@lists.linux.dev>; Mon, 29 Jul 2024 19:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722281804; cv=none; b=I8IhEte7M4Yq1U6wp3sV7q2PKSmbQQXUiV5OFY7r2L9kONWDkZY2tm4iPc9Wm3H1N8MMUfAePshiB7rFG7Ls6SiYuoOZ09uJQQsWU7ZHICCcnMNnSyJ7DxnN6XhT0Wo4wjpMWu9JPX9C/9O22zZAwqnq0Y3RaklcxUvRcT0g/ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722281804; c=relaxed/simple;
	bh=YPK2U4pIyyZrsq2SYubShjFdXGXiBEEjHJ2uLZt+4R8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nV7PhMcCIR25ExFcqozA/ukyA8LbVwRgIM16crpZAcV5+5djZ0KjFAl4r/6hbYWSuRkMxA67YacOVaoHC55B9Z/rsqHyXOfX5DN9bj1V19hGg4MVsTLm2a1dox+le3/iBL913GtPxspxSzGW7209Elktm49ho8SuP02MpkMxqOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bio7JVHn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bio7JVHn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722281801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lNFQ3Xg+P/srGAlTnRjtpo3tkXsCL8rjL6RTEU23vCs=;
	b=bio7JVHnfSbPJPmFnMEn/fKl5IajTJcjTorJh2A5dc0VwUmTdySDlcYmYTf6dqyzrgsikt
	NWkXx1Y9xes2gB1YAPIIa1q+CMx8Do/s59ZOUZhTTT/OrRbNAMkSKiVM9zXb+ZA2YbH6jv
	jdwIWPfy+Gk4isoTho40RLSmReTQpGc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-296-yLPuBAxONwORrmwZWQ1S3Q-1; Mon,
 29 Jul 2024 15:36:40 -0400
X-MC-Unique: yLPuBAxONwORrmwZWQ1S3Q-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 77AA01955F40
	for <gfs2@lists.linux.dev>; Mon, 29 Jul 2024 19:36:39 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 84A651955D42;
	Mon, 29 Jul 2024 19:36:38 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCH v6.11-rc1 03/10] dlm: never return invalid nodeid by dlm_our_nodeid()
Date: Mon, 29 Jul 2024 15:36:23 -0400
Message-ID: <20240729193630.3344082-3-aahringo@redhat.com>
In-Reply-To: <20240729193630.3344082-1-aahringo@redhat.com>
References: <20240729193630.3344082-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

This patch will remote the return of an invalid nodeid value when
local_comm is not set. This case should never happen as the DLM stack
tries to compare valid nodeids with an invalid nodeid returned by
dlm_our_nodeid(). Instead we let it crash to getting at least recognized
if we running into such state.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/config.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/dlm/config.c b/fs/dlm/config.c
index 99952234799e..eac96f1c1d74 100644
--- a/fs/dlm/config.c
+++ b/fs/dlm/config.c
@@ -928,7 +928,7 @@ int dlm_comm_seq(int nodeid, uint32_t *seq)
 
 int dlm_our_nodeid(void)
 {
-	return local_comm ? local_comm->nodeid : 0;
+	return local_comm->nodeid;
 }
 
 /* num 0 is first addr, num 1 is second addr */
-- 
2.43.0

