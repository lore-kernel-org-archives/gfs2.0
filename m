Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4041AA78F
	for <gfs2@lists.linux.dev>; Fri,  4 Oct 2024 15:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728054833; cv=none; b=Q7Wh3UQE+pKqCKc/HOOgnAk1Wt2MnRtAeCJBXd0M1ctQd40W2CUi2LjcLnGYf0L9epsoQHHTT37hUgJ8FApaOvy7cVlMWMvSpU8SHvBPN5ceJM+0kYge3z3WIxMLzYU2cJXEUVhrwIAH74eqt86n4UpS7s4YB8ocws0CkBbCHeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728054833; c=relaxed/simple;
	bh=B4Qg7u6998fXOT8Ax5DHWMswVcKghohjacYLtUtZg2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RemZbYRPxyHD8lTyZ0M1hT9tWoVIPqj0RsXvBopjO7z3s/32iRiFdfviS3G7fC45jRYD2o/6BWulHAyfKHzv4hS8xtCBkTvdjrfM5RgH3H8yammnNenozt1MGwl0AvFJ+tsyBhpAjmD7UeFGXHkxgicwvAiqtvfJb7cmaMe/YUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RKTIqQZv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RKTIqQZv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728054830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MegvDmVaIoF2eNscqgUCa6UhG+ff9w+yWljEm6GZIpU=;
	b=RKTIqQZvHLgfx10o560wse5HriYJ5GCqnZumvg7wgIVdY5/B5sn+jOiWWwuQMMxenk0+du
	poJmx4yBLfZiWNoakv/XlZ1Yyxd0ahItBiVQwcpciIrVEbxBvFThLm0cZhEV/mB4OM1Epd
	hcep7MwhOq43pNDvvqSFTodVRE4rVic=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-253-COUe_v4pOd-sqoi7Lp20pQ-1; Fri,
 04 Oct 2024 11:13:49 -0400
X-MC-Unique: COUe_v4pOd-sqoi7Lp20pQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3B5001955F29
	for <gfs2@lists.linux.dev>; Fri,  4 Oct 2024 15:13:48 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9591219560AE;
	Fri,  4 Oct 2024 15:13:47 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCH v6.12-rc1 2/7] dlm: fix possible lkb_resource null dereference
Date: Fri,  4 Oct 2024 11:13:38 -0400
Message-ID: <20241004151343.3952937-3-aahringo@redhat.com>
In-Reply-To: <20241004151343.3952937-1-aahringo@redhat.com>
References: <20241004151343.3952937-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

This patch fixes a possible null pointer dereference when this function is
called from request_lock() as lkb->lkb_resource is not assigned yet,
only after validate_lock_args() by calling attach_lkb(). Another issue
is that a resource name could be a non printable bytearray and we cannot
assume to be ASCII coded.

The log functionality is probably never being hit when DLM is used in
normal way and no debug logging is enabled. The null pointer dereference
can only occur on a new created lkb that does not have the resource
assigned yet, it probably never hits the null pointer dereference but we
should be sure that other changes might not change this behaviour and we
actually can hit the mentioned null pointer dereference.

In this patch we just drop the printout of the resource name, the lkb id
is enough to make a possible connection to a resource name if this
exists.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/lock.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index 865dc70a9dfc..dddedaef5e93 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -2861,16 +2861,14 @@ static int validate_lock_args(struct dlm_ls *ls, struct dlm_lkb *lkb,
 	case -EINVAL:
 		/* annoy the user because dlm usage is wrong */
 		WARN_ON(1);
-		log_error(ls, "%s %d %x %x %x %d %d %s", __func__,
+		log_error(ls, "%s %d %x %x %x %d %d", __func__,
 			  rv, lkb->lkb_id, dlm_iflags_val(lkb), args->flags,
-			  lkb->lkb_status, lkb->lkb_wait_type,
-			  lkb->lkb_resource->res_name);
+			  lkb->lkb_status, lkb->lkb_wait_type);
 		break;
 	default:
-		log_debug(ls, "%s %d %x %x %x %d %d %s", __func__,
+		log_debug(ls, "%s %d %x %x %x %d %d", __func__,
 			  rv, lkb->lkb_id, dlm_iflags_val(lkb), args->flags,
-			  lkb->lkb_status, lkb->lkb_wait_type,
-			  lkb->lkb_resource->res_name);
+			  lkb->lkb_status, lkb->lkb_wait_type);
 		break;
 	}
 
-- 
2.43.0

