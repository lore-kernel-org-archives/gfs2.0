Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EC71D88C3
	for <gfs2@lists.linux.dev>; Thu,  7 Nov 2024 20:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731012387; cv=none; b=GkxjGNYVZF5bMwvEWgbwvvpq+EFV47biRkUeIkjS2e8D/shShwfJYVXtDgaZnvyiZnKxHQmXoB7/IgJJpBx0/I+gnWr7Rz7tX6LfuG8VKszjenlrn9ncmaEnab3fQm7yRRcSS6HlFIaAdcTLNaO5q0aimzOI4eALqvyxIGsGUok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731012387; c=relaxed/simple;
	bh=CnLyvaGcXmsD1+orQVwbTuk/iK6+cT2TiL8q2Qa7cTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eYuoff7j0exdNdr2CVLg2E0bXYgHpBBESz4vNVTuCrYfbZ8Dfyt/8kbc/dsWMRI/Bho631hzBhuxZ9S2gl9DhyQGbJVMSDmkm6TscwfYevqFk+3T2xAvrLSJlbvLVzo0lRewh1oLzSL6Ur79tqycgmUjfRK/FhLEb4HqZWCeyGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ELXvHugx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ELXvHugx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731012384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zPzydJO/4g2a19BwRpUHDOWPU68teUFwdjlHAMVUSLM=;
	b=ELXvHugx5fOs4HYMYKsJ9KdI75gmo/+JtA98fvxNxk9c3wYLnqs7Xl8PPToVPAF06nw3JI
	CA3mcXkBErA4z8CGTasa4Vq4VDIJm/0vjKtGLGE7Vb8kVKYAyOqRzAqA2tBCm1rF5JdeGY
	6nDa/LxFN13XPPl8K2+bEGVjPgfVpLc=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-638-UL9IDqChOrmxe4pRdXG41Q-1; Thu,
 07 Nov 2024 15:46:23 -0500
X-MC-Unique: UL9IDqChOrmxe4pRdXG41Q-1
X-Mimecast-MFC-AGG-ID: UL9IDqChOrmxe4pRdXG41Q
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 38BD319560B5
	for <gfs2@lists.linux.dev>; Thu,  7 Nov 2024 20:46:22 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7F964300019E;
	Thu,  7 Nov 2024 20:46:21 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [RFC dlm/next 01/11] dlm: remove set_master() negative return check
Date: Thu,  7 Nov 2024 15:46:07 -0500
Message-ID: <20241107204617.147842-2-aahringo@redhat.com>
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
X-Mimecast-MFC-PROC-ID: lCZj79zqmwYBpgDE58WTruUzjvKtTFJ07Fl0YJnWkQw_1731012382
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Remove the set_master() negative return check as set_master() cannot
return a negative return value.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/lock.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index 966a926c301b..cee32aa6b218 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -3174,8 +3174,6 @@ static int _request_lock(struct dlm_rsb *r, struct dlm_lkb *lkb)
 	/* set_master: sets lkb nodeid from r */
 
 	error = set_master(r, lkb);
-	if (error < 0)
-		goto out;
 	if (error) {
 		error = 0;
 		goto out;
-- 
2.43.0

