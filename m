Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEC81FDF98
	for <gfs2@lists.linux.dev>; Mon,  4 Nov 2024 22:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730757865; cv=none; b=AzZPYYRxSz4ablhLYzB6SCuL0Jtp+I/0Si/+6Rnj8RRkU2fP8stwWrIoLHYixLsma3y28OLcNJ4/RWtFirW2/wjN916MYpYgKiWd/esvI6Cw5UV9+DNKvkZYCOatFIoJoZLjiz7WfxIEL4ypUrm0ShUo72cNFFLukOjrbv5/lu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730757865; c=relaxed/simple;
	bh=Mh/h2WF62qUiSAVb6TowdhhAVPo7xWf3Dymab1okaJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZGU7G2rREYivMDSpKpQXtYhkSk2gld8vZxyNVvLtmd2KjKnUK8PYO2IF6HAD6jdrtcCDlCSiwDntT9C7n7j4tXj4f9dLLEmMFkupsM0piIkUc5X+MPlnSqWuNbVNV32ielWs4VpOjEhwq4lcnYHHEIPz03yweD4rdqAb4wMUeJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X3f5Q2Hb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X3f5Q2Hb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730757862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0FdqhwV7JS9qoqsAWCpX4jP1E9qx6oGFDByVxPoNnUs=;
	b=X3f5Q2HbmlJyTclvl0D8LkVruCte2bRHoAcwXnepYnzKPNvpr4NM/S1FZ54Qv/+JeIPbiP
	hS4AONixd/3UHmTq82PdTkDvkoeieLfj2Xx9lAUAzQOOdmP+VBvzu+Ip/la8AbxUp/BpSA
	pj/WVRVuuxC2WirfntO58SYrAJlQo0g=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-67-j8xTsw4HOTuzPpnQ36DtNQ-1; Mon,
 04 Nov 2024 17:04:21 -0500
X-MC-Unique: j8xTsw4HOTuzPpnQ36DtNQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E954F1955D56
	for <gfs2@lists.linux.dev>; Mon,  4 Nov 2024 22:04:20 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3BF131955F40;
	Mon,  4 Nov 2024 22:04:20 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCH dlm/next 3/3] dlm: log_limit() recover_conversion() handling
Date: Mon,  4 Nov 2024 17:04:17 -0500
Message-ID: <20241104220417.3883898-3-aahringo@redhat.com>
In-Reply-To: <20241104220417.3883898-1-aahringo@redhat.com>
References: <20241104220417.3883898-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Let's us easier be aware when middle_conversions() are handled by DLM
recovery handling.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/recover.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/dlm/recover.c b/fs/dlm/recover.c
index 011153fcb84f..7e89f362e50c 100644
--- a/fs/dlm/recover.c
+++ b/fs/dlm/recover.c
@@ -852,12 +852,12 @@ static void recover_conversion(struct dlm_rsb *r)
 				break;
 			}
 
-			log_debug(ls, "%s %x set gr to rq %d", __func__,
+			log_limit(ls, "%s %x set gr to rq %d", __func__,
 				  lkb->lkb_id, lkb->lkb_rqmode);
 		} else {
 			WARN_ON(grmode == lkb->lkb_rqmode);
 
-			log_debug(ls, "%s %x set gr %d", __func__,
+			log_limit(ls, "%s %x set gr %d", __func__,
 				  lkb->lkb_id, grmode);
 			lkb->lkb_grmode = grmode;
 		}
-- 
2.43.0

