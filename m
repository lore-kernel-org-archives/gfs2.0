Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3EE124C09E
	for <gfs2@lists.linux.dev>; Tue, 29 Apr 2025 20:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745958567; cv=none; b=HR82rEDETegtz1TEp3uVmHsQGiXAsVavk9C8zTL8YGgvIeIdPXwLpRNhU/nLG2QrhVjqCuHd/MT2ilEEv/NbA3TwUjxBrDZbtuYZtzI2AquLEKypceWroOhWFtiGpkvzfxKcgMVOhJzCzeW5O2K3wSzzLV08f61x/oqWvvSxNu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745958567; c=relaxed/simple;
	bh=4X3PkFy8GhHlB6tvg0jb6mBhL1hVLOcm+R4OxdKwFjA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=N7nU2V1wnqnqcDXGiQmSx98P6qunscyBaaJJOdLIk+h4tTPsuuqiT/ROyMeXGTtRZbXUWrjdXmramS7xkrnSqtbIzTS7JynZjCot61O0DMHNjTdKj+S7NoU/WYjoNuBGSoen2+zmZ3zejBSu7pU1TxVQiEPO1ryb9FXZU5flwxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bG9FdkXH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bG9FdkXH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745958564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LnrMT7lQOfCmmbzL6y8B3Vey5MYJErAotiQVA3r0qlY=;
	b=bG9FdkXHw6gakRZm8Nq2dqQPAgPdTKjXwbZc2svMLewuSWkU7he4jEd+6AS/xGlZVwo6xC
	StS/x995kM+fWNBjhGszZsDLJNNzM1K709IFItl/Tt89gnJtM3o27mays8cwiM+Xk8Oenc
	sgwy0fwY7QwVDsR1w+hBAayR1pjGj9M=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-94-qzq_kgchP6eKHnD69EED2w-1; Tue,
 29 Apr 2025 16:29:21 -0400
X-MC-Unique: qzq_kgchP6eKHnD69EED2w-1
X-Mimecast-MFC-AGG-ID: qzq_kgchP6eKHnD69EED2w_1745958560
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 49609195608C;
	Tue, 29 Apr 2025 20:29:20 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 75A8D19560A3;
	Tue, 29 Apr 2025 20:29:19 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	glass.su@suse.com,
	heming.zhao@suse.com,
	lidong.zhong@suse.com,
	aahringo@redhat.com
Subject: [RFC PATCH dlm/next 1/4] dlm: mask sk_shutdown value
Date: Tue, 29 Apr 2025 16:29:10 -0400
Message-ID: <20250429202913.2908521-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: cfh4dU_kmZ_GkN5RN61nDeHfyCm9mT9dkk98IQbLDjk_1745958560
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The sk->sk_shutdown value is flag value so use masking to check if
RCV_SHUTDOWN is set as other possible values like SEND_SHUTDOWN can set
as well.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/lowcomms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
index 70abd4da17a6..50c42b368c83 100644
--- a/fs/dlm/lowcomms.c
+++ b/fs/dlm/lowcomms.c
@@ -533,7 +533,7 @@ static void lowcomms_state_change(struct sock *sk)
 	/* SCTP layer is not calling sk_data_ready when the connection
 	 * is done, so we catch the signal through here.
 	 */
-	if (sk->sk_shutdown == RCV_SHUTDOWN)
+	if (sk->sk_shutdown & RCV_SHUTDOWN)
 		lowcomms_data_ready(sk);
 }
 
-- 
2.43.0

