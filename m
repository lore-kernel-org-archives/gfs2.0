Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC05B448D03
	for <gfs2@lists.linux.dev>; Fri,  2 Oct 2026 21:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790975504; cv=none; b=FS8sWmhzxpCvu32lowntRrW5CaAv18Q9rfx9a09jwexEG9nn3m82tC7yOpXAk7K2UPmeCkthd+G6jNO3Mnaefvy83vzE7fDsbamLUAyjbijIagkOMDJAz/klc+RZssmFrnxkEvxnSTKvCn0GPgFnamIzrk1N3UQlVsqz5J4Ka4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790975504; c=relaxed/simple;
	bh=uIHOq2O3tDEVXOInoAlO3wEF0YaW4dPQKga3XTT9Tcc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=VIATYqB5xjPtLAfUaB8jiF5sB3jbMGPHtNoLStzZnvWrFxEixSUHyg77njXSO/4jc4pVfOQkcLb1gV6zmiqI+5stxUObKaKHYJ1pOOZQH5Z7BQ6Fqemr9roQ9Sos/9/VdRRBc8m0C1T9xIkqfKDCpc204NzdTSGMk2mrVzPhW5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pe34UPbh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pe34UPbh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790975496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pc2qLcLOJvkbIYVlb/87GSIp7y5C7mCD5vsXxSFwFAE=;
	b=Pe34UPbhospLXSi0u6VlvaMDCAhGhQGmK9IvUYMnJUggPkBIqbBYjJhuJIyONBq3+/i+D2
	3vdh642J4/QLIxanYhVgKX+zKjYzjSA1xfuGnDGt+8H8Xa4QHvzaQu3VQ/CFYTT4Ph1xdn
	pFTdjQirBfBskbmMeHIA5SbrN5jXm1o=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-53-vsIwggmGO8Oh9rita_yN4Q-1; Fri,
 02 Oct 2026 17:11:35 -0400
X-MC-Unique: vsIwggmGO8Oh9rita_yN4Q-1
X-Mimecast-MFC-AGG-ID: vsIwggmGO8Oh9rita_yN4Q_1790975495
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B72BD1955F76
	for <gfs2@lists.linux.dev>; Fri,  2 Oct 2026 21:11:34 +0000 (UTC)
Received: from fs-i40c-03.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 04E6E1956042;
	Fri,  2 Oct 2026 21:11:33 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: aahringo@redhat.com,
	gfs2@lists.linux.dev
Subject: [PATCH RESEND dlm/next 2/3] dlm: clean up a type in waiters_read()
Date: Fri,  2 Oct 2026 17:11:29 -0400
Message-ID: <20261002211130.1573679-3-aahringo@redhat.com>
In-Reply-To: <20261002211130.1573679-1-aahringo@redhat.com>
References: <20261002211130.1573679-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: eH8dTc6BZpQBCa8by2QP-881Hqz5Zfm49KP2ml9H9d4_1790975495
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

From: Dan Carpenter <error27@gmail.com>

This doesn't affect runtime but "rv" stores error codes and so
declare it as ssize_t instead of size_t.

Signed-off-by: Dan Carpenter <error27@gmail.com>
Acked-by: Alexander Aring <aahringo@redhat.com>
Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/debug_fs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/dlm/debug_fs.c b/fs/dlm/debug_fs.c
index 700a0cbb2f14..f52a51b1382a 100644
--- a/fs/dlm/debug_fs.c
+++ b/fs/dlm/debug_fs.c
@@ -596,7 +596,8 @@ static ssize_t waiters_read(struct file *file, char __user *userbuf,
 {
 	struct dlm_ls *ls = file->private_data;
 	struct dlm_lkb *lkb;
-	size_t len = DLM_DEBUG_BUF_LEN, pos = 0, ret, rv;
+	size_t len = DLM_DEBUG_BUF_LEN, pos = 0, ret;
+	ssize_t rv;
 
 	mutex_lock(&debug_buf_lock);
 	ret = dlm_lock_recovery_try(ls);
-- 
2.43.0

