Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D605A1CAA64
	for <gfs2@lists.linux.dev>; Fri, 28 Feb 2025 22:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740782939; cv=none; b=dNz8wG+uMj6CL3oReTafyBrchdzeqFYuS+I2zMlv5eiYAQK88LCuexMLworD2Cz+KiS0/Ng2HNl9vzTHA5rpaVmKQNS2HQAJisWw9w2qJdvo0igYbxZ3pYhO7wqFu9Ny7+yGfYEdhqciiZ9lRg1MrunCvzUS3CJVKlDqKfeARUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740782939; c=relaxed/simple;
	bh=O9U11jsP1m5FkLfi9oR3wO1iMsSRPM0EOQKLcuZFGxk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=udBh79jEdktK/1E7cqp/hBpk6mQ1v0KBbUSg1PrnspRHq5CwL0+5EV2baeyuUbLt82t6AYxJp6FFg5Z9p01sgyDVZPE6iSFlwMjVRQMDzaNxAQf95ahnalj9TuwbwPWsJvEpydKGlkPvQbLvwjp2Szr32GjZIcajboumtoq65xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SkT1fiIF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SkT1fiIF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740782936;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JU11SJXLG3nR5zxtWokAMxQZEi8b7+ufo1e7gl/dKws=;
	b=SkT1fiIFENxxvTxKvhq73I7It7ngxRPD53yiiAlxqUapuu3ttoHEct5ISrnAjpVqmubfLW
	GbQOdspZzr2arDxAxOc7NNSnkyk2oJObVk57qlvEeExlSFxjpIhcvGMEW85B+DUP/tlPrp
	xQB5GjLVexQeXqf/+Ux/6MSvAqQyHYg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-312-ue-46qApNs6KnIUvJZTbVw-1; Fri,
 28 Feb 2025 17:48:55 -0500
X-MC-Unique: ue-46qApNs6KnIUvJZTbVw-1
X-Mimecast-MFC-AGG-ID: ue-46qApNs6KnIUvJZTbVw_1740782934
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 06D2E1800373;
	Fri, 28 Feb 2025 22:48:54 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1EB371800357;
	Fri, 28 Feb 2025 22:48:52 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: stable@vger.kernel.org,
	gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCH dlm/next 1/2] dlm: fix error if inactive rsb is not hashed
Date: Fri, 28 Feb 2025 17:48:50 -0500
Message-ID: <20250228224851.1283094-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

If an inactive rsb is not hashed anymore and this could occur because we
releases and acquired locks we need to signal the followed code that the
lookup failed. Since the lookup was successful, but it isn't part of the
rsb hash anymore we need to signal it by setting error to -EBADR as
dlm_search_rsb_tree() does it.

Cc: stable@vger.kernel.org
Fixes: 01fdeca1cc2d ("dlm: use rcu to avoid an extra rsb struct lookup")
Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/lock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index c8ff88f1cdcf..499fa999ae83 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -784,6 +784,7 @@ static int find_rsb_dir(struct dlm_ls *ls, const void *name, int len,
 		}
 	} else {
 		write_unlock_bh(&ls->ls_rsbtbl_lock);
+		error = -EBADR;
 		goto do_new;
 	}
 
-- 
2.43.0

