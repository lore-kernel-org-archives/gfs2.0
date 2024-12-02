Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8EE209F28
	for <gfs2@lists.linux.dev>; Mon,  2 Dec 2024 15:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733153216; cv=none; b=J3PWpzW7d5BJU42QScfeli3Lc4wLVJLk1F5j5dMxrzpKDwLTsnE6f5Lta5ew+7mAmcLJ9+FBa9WCXZ8600O62jEdMv64oCwa7y8avlfMqqonWwBT0uoCEdXeDU7LBaVU/q//Xz7COpk0k50AE7dS5J3a1aDEi/BixNlwLHYeW9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733153216; c=relaxed/simple;
	bh=ILXY3aNgGjCmV9htki2GbJbdJRSJ8z6lfRN850PHdwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=ZU8/iajdVIP4z33sXsnHoXvMkcG7TpdHOvrFl3jSuBXLH5cEW4/laCoEkfCba7Rbhw6l1AdpKs1h/TPxdixocwXPJrsjs+UtdxTP8UxCYJapkaBdLQbEU4sy2M4ezOJJIf9WEAHeAzALY9Sg8pYfXnAD3yGMbhhrwbeO8/y7dfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZeYwYRt6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZeYwYRt6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733153214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ISBeBTv6w3/6txvWl9K9Fatw/nH+0aNG0T7HTXOyD8c=;
	b=ZeYwYRt63zJkIS1wSJHE2HuhXAECka4dW8LPl3cp0fbFozo2YOi7XeNHVS4YeY1aqDmsRM
	y99sjv+yVv4xHYlDEj7+tmRVhyfrBa4mFtKkiSW58iz1flVczH6qSEppOF03qYXZeAwZHP
	35+WyMkLHfsiNtQU1dTlkucf6nmJkco=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-606-FXzsyep8N7GhdzZpbwr8wQ-1; Mon,
 02 Dec 2024 10:26:52 -0500
X-MC-Unique: FXzsyep8N7GhdzZpbwr8wQ-1
X-Mimecast-MFC-AGG-ID: FXzsyep8N7GhdzZpbwr8wQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1D85D1955EB3
	for <gfs2@lists.linux.dev>; Mon,  2 Dec 2024 15:26:52 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 75DE430000DF;
	Mon,  2 Dec 2024 15:26:51 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCH v6.13-rc1 5/5] dlm: return -ENOENT if no comm was found
Date: Mon,  2 Dec 2024 10:26:41 -0500
Message-ID: <20241202152641.3395369-5-aahringo@redhat.com>
In-Reply-To: <20241202152641.3395369-1-aahringo@redhat.com>
References: <20241202152641.3395369-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qC_M2RTt-TAoTbyEnLUpmlqO-bwWtZ2j9JTAyonj7R0_1733153212
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Currently if no comm can be found dlm_comm_seq() returns -EEXIST which
means entry already exists for a lookup it makes no sense to return
-EEXIST. We change it to -ENOENT. There is no user that will evaluate
the return value on a specific value so this should be fine.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/config.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/dlm/config.c b/fs/dlm/config.c
index b2f21aa00719..cf9ba6fd7a28 100644
--- a/fs/dlm/config.c
+++ b/fs/dlm/config.c
@@ -935,7 +935,7 @@ int dlm_comm_seq(int nodeid, uint32_t *seq, bool locked)
 		mutex_unlock(&clusters_root.subsys.su_mutex);
 	}
 	if (!cm)
-		return -EEXIST;
+		return -ENOENT;
 
 	*seq = cm->seq;
 	put_comm(cm);
-- 
2.43.0

