Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6869222370A
	for <gfs2@lists.linux.dev>; Mon,  7 Apr 2025 18:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744051551; cv=none; b=RtMHh1l8F9IuKRQiS0uWVAK4InUQC4oHMj9NfkSfbS8k/s3JQ2ImnO5GIkZ5o5Wcmie8DTGClwVGgwCdfgBQrXvEUCkuplGO7qMTR7zJ9AKgPOXb0VWHfrfjwoBTNrMyzqzd1+fXRbfGjA9DtXGh/vFTRUW4dHJwaSnCjY2XBjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744051551; c=relaxed/simple;
	bh=lRSQOSDIkUr/FigGsMV4U2r31kg4l+yOFFwwb2NWTRk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=pQSc5LXzFTO/ZQsXRLu5ynRu/uOX48ZeCLcPtED3h1HJha6e1v4J4Y6XKgOxtkMMdyPZc7cNLdluFOo7BJBlzfTS3VkFxTz3T9RJLmb3lzZhRFT61WUwaa5ttIyrw1AiMXSM5mHkHGW3tFAYjLMMxw5S0UPHg0CqtRcxfczd4W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LF7L1l4Z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LF7L1l4Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744051548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LXpcY3tC+8a7CsBoiT2oqElYvSo6E2T/KCzijn7J7Mc=;
	b=LF7L1l4Zywd5hlfAd/Q/VtjuZ0inTQIUK/5EDerFjpRwXIAukYUFqFDWW+aXpDu1lSVoek
	6r9GRO0RD2EMX6UK5HI1xAwKEcH0eOQwYoDx+NuLEDMhNUC+Xh3zoxjg+yShTes6tbTsrN
	HFrQkk1O2KE4viQWUvBHnqHZtkVtmxg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-221-BAB_sUCnPyChdx1uu89w7A-1; Mon,
 07 Apr 2025 14:45:46 -0400
X-MC-Unique: BAB_sUCnPyChdx1uu89w7A-1
X-Mimecast-MFC-AGG-ID: BAB_sUCnPyChdx1uu89w7A_1744051546
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 05013195422F
	for <gfs2@lists.linux.dev>; Mon,  7 Apr 2025 18:45:46 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 26C301955BEF;
	Mon,  7 Apr 2025 18:45:44 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: agruenba@redhat.com
Cc: teigland@redhat.com,
	gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCH gfs2/for-next] gfs2: only apply DLM_LKF_VALBLK if GLOF_LVB is set
Date: Mon,  7 Apr 2025 14:45:38 -0400
Message-ID: <20250407184538.2686303-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1M5GmYtg05yRYdUPnd15Pflav5KvdobdfYP5XMDp5bE_1744051546
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Currently there are cases when sb_lvbptr is NULL but gfs2 always sets
the DLM_LKF_VALBLK that indicates lvb handling so sb_lvbptr should point
to a user allocated lvb memory lvb. This currently makes no problems
because DLM checks on sb_lvbptr being NULL when accessing sb_lvbptr and
force handle it as DLM_LKF_VALBLK would not be set. This patch uses the
same glock operation flag that indicates lvb handling to set
DLM_LKF_VALBLK instead of always setting it as this is against DLM API.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/gfs2/lock_dlm.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/gfs2/lock_dlm.c b/fs/gfs2/lock_dlm.c
index 58aeeae7ed8c..34037e23149b 100644
--- a/fs/gfs2/lock_dlm.c
+++ b/fs/gfs2/lock_dlm.c
@@ -328,6 +328,7 @@ static void gdlm_put_lock(struct gfs2_glock *gl)
 {
 	struct gfs2_sbd *sdp = gl->gl_name.ln_sbd;
 	struct lm_lockstruct *ls = &sdp->sd_lockstruct;
+	uint32_t flags = 0;
 	int error;
 
 	BUG_ON(!__lockref_is_dead(&gl->gl_lockref));
@@ -361,8 +362,11 @@ static void gdlm_put_lock(struct gfs2_glock *gl)
 		return;
 	}
 
+	if (gl->gl_ops->go_flags & GLOF_LVB)
+		flags = DLM_LKF_VALBLK;
+
 again:
-	error = dlm_unlock(ls->ls_dlm, gl->gl_lksb.sb_lkid, DLM_LKF_VALBLK,
+	error = dlm_unlock(ls->ls_dlm, gl->gl_lksb.sb_lkid, flags,
 			   NULL, gl);
 	if (error == -EBUSY) {
 		msleep(20);
-- 
2.43.0

