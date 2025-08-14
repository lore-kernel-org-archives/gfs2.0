Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCE742AB0
	for <gfs2@lists.linux.dev>; Thu, 14 Aug 2025 15:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755184946; cv=none; b=iJWYx+qFIHDOL1/dLAxZ+OBh1PcYqskWR5NnTnSKgEYX0NhxH6aLEttq1q+mM8xWzKevryZfloPOIoFWwNeC9a2xROV5276re/bgQngTb1XtEZghoBRGgd90LwWMjTsMo7t9jEab8+VA0gIZAy1F9iLiRnCEhzCImQ+ULxvpJAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755184946; c=relaxed/simple;
	bh=hvtlIFubXB9ZFkd6ENiCPlTlLegwsJPdRBz2C0DtKJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Wgdy7gXE0300M2dPbvHHh3w0WPpa4JBWgxCJLh1jCZswRYT9+2ePS0/wBkTHWugKcTHARS8SQ4HWik7ZsetL75oXMXKFrR/R8fAfBSB8ZToMzfpkSRQQwG+fTo9gxQEW9fHd1BXziqG3xIlXw3BEjDOrruOn84SrnqbrDE96npU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CILyguwk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CILyguwk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755184943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jjmEWG4TN8/3iwBMPStKtYBuZWh85jZshkOMNrqq0oM=;
	b=CILyguwkPyldwtbYE/TmAFqNazKoRIpdWEweScaue0hX/ZD1twrGz86QodDStUG0s8DWqD
	zj9c3lG01FuLcuz9S7Hh/Zj4KBbMEnpodsmv58LhfOv0w6hampgbshYdosGtcd5ZIEJfZn
	zzK8jCc7uIemX/Y0bBBxrsw1VuoMBMU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-19-t2KA5QNcN3GyU8NN1MwoOA-1; Thu,
 14 Aug 2025 11:22:22 -0400
X-MC-Unique: t2KA5QNcN3GyU8NN1MwoOA-1
X-Mimecast-MFC-AGG-ID: t2KA5QNcN3GyU8NN1MwoOA_1755184941
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B63221954203
	for <gfs2@lists.linux.dev>; Thu, 14 Aug 2025 15:22:21 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0DE9530001A8;
	Thu, 14 Aug 2025 15:22:20 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCH dlm/next 2/4] dlm: move to rinfo for all middle conversion cases
Date: Thu, 14 Aug 2025 11:22:12 -0400
Message-ID: <20250814152214.946153-2-aahringo@redhat.com>
In-Reply-To: <20250814152214.946153-1-aahringo@redhat.com>
References: <20250814152214.946153-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nRuMlbQwdZhULnS2xP6yK23Fr9-GOVZT9PVJt4M4v2A_1755184941
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Since commit f74dacb4c8116 ("dlm: fix recovery of middle conversions")
we introduced additional debugging information if we hit the middle
conversion by using log_limit(). The DLM log_limit() functionality
requires a DLM debug option being enabled. As this case is so rarely and
excempt any potential introduced new issue with recovery we switching it
to log_rinfo() ad this is ratelimited under normal DLM loglevel.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/lock.c    | 2 +-
 fs/dlm/recover.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index 6dd3a524cd352..be938fdf17d96 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -5576,7 +5576,7 @@ static int receive_rcom_lock_args(struct dlm_ls *ls, struct dlm_lkb *lkb,
 
 	if (rl->rl_status == DLM_LKSTS_CONVERT && middle_conversion(lkb)) {
 		/* We may need to adjust grmode depending on other granted locks. */
-		log_limit(ls, "%s %x middle convert gr %d rq %d remote %d %x",
+		log_rinfo(ls, "%s %x middle convert gr %d rq %d remote %d %x",
 			  __func__, lkb->lkb_id, lkb->lkb_grmode,
 			  lkb->lkb_rqmode, lkb->lkb_nodeid, lkb->lkb_remid);
 		rsb_set_flag(r, RSB_RECOVER_CONVERT);
diff --git a/fs/dlm/recover.c b/fs/dlm/recover.c
index be4240f09abd4..3ac020fb8139e 100644
--- a/fs/dlm/recover.c
+++ b/fs/dlm/recover.c
@@ -842,7 +842,7 @@ static void recover_conversion(struct dlm_rsb *r)
 		 */
 		if (((lkb->lkb_grmode == DLM_LOCK_PR) && (other_grmode == DLM_LOCK_CW)) ||
 		    ((lkb->lkb_grmode == DLM_LOCK_CW) && (other_grmode == DLM_LOCK_PR))) {
-			log_limit(ls, "%s %x gr %d rq %d, remote %d %x, other_lkid %u, other gr %d, set gr=NL",
+			log_rinfo(ls, "%s %x gr %d rq %d, remote %d %x, other_lkid %u, other gr %d, set gr=NL",
 				  __func__, lkb->lkb_id, lkb->lkb_grmode,
 				  lkb->lkb_rqmode, lkb->lkb_nodeid,
 				  lkb->lkb_remid, other_lkid, other_grmode);
-- 
2.43.0

