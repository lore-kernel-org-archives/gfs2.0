Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA7B186E58
	for <gfs2@lists.linux.dev>; Thu,  7 Nov 2024 20:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731012391; cv=none; b=UHHnvjQSorcyAZmqadklgEjSko+o2bJQ7fmPjMaq6k5WctjvLNjni0YRQDKVjRJ2SNN8p9Oy8PEyWpcW5F6p5twf6YHRR6KwjLyvsighnKi9caeSIEisyVvfbgiHEpddry7zJQWNw1NhdY6ebfivkHoo4ERRlBvWIlialq9IiNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731012391; c=relaxed/simple;
	bh=q0r9RaS+ZqSFoW+2Eh9W7TWEs1WBCgCW2Lb+FNjBJcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ACAK35CzpdbIEofip8hCPLy1DmdAJ/tsuSmjY4DMfWJxxY8iPCxGEp0WBAuhxL2VSAX131viHuISf6mAsmyLmJJDD+VObPt+PHhhwK+EdRQfWIT0Xj0UZDi3jBVgNCaDh1PLA3jzIqTdKiG96ui1w9egLQg01Qtbu3JZdxrQsfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HoK/N9+t; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HoK/N9+t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731012389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gXFmoqnGggizRWJcvyfkXwheE5exjpivNfeABF/C8Jw=;
	b=HoK/N9+tFOF88MNb81rsvbHnCXmeXZbxdEvNT/GV2lwrnbnc6H4YQ9AA0vKCptHYDCEKoR
	ujnPGI7nGaxtgSzi7rdEd8k1NZBYQ0SAVJ/dlJqfnPy3Fm+p8t/yiIssTc5W/0PIGVLVPz
	186o9oEuJ25/OUt3pZvwjlzMyRYwbr4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-632-KwxFpmuWMvylCy9IBlGpKQ-1; Thu,
 07 Nov 2024 15:46:28 -0500
X-MC-Unique: KwxFpmuWMvylCy9IBlGpKQ-1
X-Mimecast-MFC-AGG-ID: KwxFpmuWMvylCy9IBlGpKQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5EC0A1955F41
	for <gfs2@lists.linux.dev>; Thu,  7 Nov 2024 20:46:27 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A00DA300019E;
	Thu,  7 Nov 2024 20:46:26 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [RFC dlm/next 07/11] dlm: call queue_cast() on master copy as well
Date: Thu,  7 Nov 2024 15:46:13 -0500
Message-ID: <20241107204617.147842-8-aahringo@redhat.com>
In-Reply-To: <20241107204617.147842-1-aahringo@redhat.com>
References: <20241107204617.147842-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _VNshrzzJEOFDlQ64_irAf76_jblHoBtlbhX21VLvAQ_1731012387
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

To prepare for a new lkb refcounting model that is tight to the lkb
request state and the ast callback being queued it is required to call
queue_cast() for master copies as well. Currently queue_cast() will drop
any call from a master copy lkb so there should be no change and
queue_cast() will ignore such request as well.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/lock.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index b570e9f7cc6f..f2060a9d78f3 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -2087,8 +2087,7 @@ static void grant_lock_pending(struct dlm_rsb *r, struct dlm_lkb *lkb)
 	grant_lock(r, lkb);
 	if (is_master_copy(lkb))
 		send_grant(r, lkb);
-	else
-		queue_cast(r, lkb, 0);
+	queue_cast(r, lkb, 0);
 }
 
 /* The special CONVDEADLK, ALTPR and ALTCW flags allow the master to
-- 
2.43.0

