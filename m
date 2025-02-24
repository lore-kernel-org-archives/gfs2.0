Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C87C1EDA0F
	for <gfs2@lists.linux.dev>; Mon, 24 Feb 2025 19:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740425144; cv=none; b=RjEW05WUuHkk2/rP7iSXMkqiSBmvnTFWVsZdBsq3q2yVhUjmmkciq5a1VYOo+XSnLevdekkFglPg7OXyUM1LvLh8miNuO4ogiClxv/CciG5AUIlTKcv52wV4hpwPlKWGpD8Y6Sog6kmi/mW27p4gtiqP23kimR477EmFLIwC3ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740425144; c=relaxed/simple;
	bh=svW1exXQ03oPlgdg3UIMqaCxaaP9KNn31iqC5fizrmM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M2ytdH2DYtYz9JQ/IFom2zgR9ie1fdiyQV2dE7f5yOOPaMsT5qAxl1mgPyRApTDvhLs0Xoro2IFqO0sDNXhULgrdwPQ5fgzGRG/x2CF08PhUwDCTZ3uBrJkKMJu9Grt/8KDUrlbkvl5dswuzVGIhLWc9n1eAZv0S5VqzkgnkcVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lidxoh/x; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lidxoh/x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740425140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=raZeTMMykYsj1E6LPySnAyAC4pYT6HdMrvMqEuLWarA=;
	b=Lidxoh/xl6C9LIbkqOTdp7zL4DfXbV6I99ZiBRxykgsu1ehPsEBHZ2H+d6xfZA3tC/QFyx
	dWo40HmR+mQvK1Wn/HuKBNexi8xoYZ37TNnSz3q1ACMZDz4ZYZjYUDl4voWIusvrtZSNyi
	dTuPexuO7JrgnsnCJ153saOpKEcPfuk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-26-_a3eYmzEOaGuNnn4O_35hw-1; Mon,
 24 Feb 2025 14:25:38 -0500
X-MC-Unique: _a3eYmzEOaGuNnn4O_35hw-1
X-Mimecast-MFC-AGG-ID: _a3eYmzEOaGuNnn4O_35hw_1740425137
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3DD9F18009A5;
	Mon, 24 Feb 2025 19:25:34 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 376891955BD4;
	Mon, 24 Feb 2025 19:25:32 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: stable@vger.kernel.org,
	msmith626@gmail.com,
	jakobkoschel@gmail.com,
	gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCH] dlm: fix lkb timeout scanning lookup
Date: Mon, 24 Feb 2025 14:25:28 -0500
Message-ID: <20250224192528.411319-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

If a lkb is timed out when dlm_scan_timeout() kicks in and removes a
timed out lkb from ls->ls_timeout list the next iteration can end in
timeout the same lkb again that shouldn't happen. Since commit dc1acd5c9469
("dlm: replace usage of found with dedicated list iterator variable")
we don't set the lkb variable before the inner lookup loop to NULL. The
outer loop will not stop and checks if there was a successful lookup with
the lkb pointer of the last iteration that wasn't set to NULL. To stop this
behavior we use the old condition "!do_cancel && !do_warn" which signals if
there was a successful lookup and the lkb variable should be set with the
lkb that was looked up to be timed out. If the condition is false there is
no timed out lkb in ls->ls_timeout and the outer loop stops.

Cc: stable@vger.kernel.org
Reported-by: Marc Smith <msmith626@gmail.com>
Fixes: dc1acd5c9469 ("dlm: replace usage of found with dedicated list iterator variable")
Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/lock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index 226822f49d30..1ff842be5891 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -1919,7 +1919,7 @@ void dlm_scan_timeout(struct dlm_ls *ls)
 		}
 		mutex_unlock(&ls->ls_timeout_mutex);
 
-		if (!lkb)
+		if (!do_cancel && !do_warn)
 			break;
 
 		r = lkb->lkb_resource;
-- 
2.43.0

