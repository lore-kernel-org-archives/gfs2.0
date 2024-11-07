Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30339194C92
	for <gfs2@lists.linux.dev>; Thu,  7 Nov 2024 20:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731012389; cv=none; b=baVjkq4UJD6NIRZSnlP3JNUmAHAPl+94INn1kY8SVo3tA5Uw4UTnRWJv/fDeAB8tAVXZr9noPlXdBVtAcBbGJlI2119waz6T2+se6BBP7UAkaTfiZKY/A/bRgfvfEHjFvGSzHjW8KkHRtDee3fPeq6ROixH9r8dC1iCCDV5a1Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731012389; c=relaxed/simple;
	bh=ADTvPdW/H2JmU1V6Q6GYxEqgO0OjaA2xdK4snRv1Nqs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GthF/XV1a8hMEz2FZYssZl0WB1ip/t3qpfiKwXgUXJcLuQK/YWglSYXg2uSL0aJK65SVMPVbdW1WdIWDhcg/05+fpVearM/7kWJRAs7p8u7QSqfd4DYk9lBit4PikqnA0QGW9JjHiCahTY0FjBc+BKQODAwDTVjM0r9R8ikVmkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AyGSzmrG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AyGSzmrG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731012387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ENxwlOT/j+FqlJYe3QnjBwfgMLYSQ/A83FPa00+pEuY=;
	b=AyGSzmrGyp/jhajuChEgcKwNOTEJPdyKByMAUTN9/4A3NDn69EgsOdYwWOYZz98c4gJHCp
	DkTfKHiQHn2hpAt/NpkRB8o64yXDyqQoR3EU/5MFuOuhcmg0STff9ex2TK+SlZiLCFXSaf
	TkAirBGy9SfjzLLaB/Z01AzQ3csVcg0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-367-ftxJ3z7VMWCxCzHxRTdCfg-1; Thu,
 07 Nov 2024 15:46:24 -0500
X-MC-Unique: ftxJ3z7VMWCxCzHxRTdCfg-1
X-Mimecast-MFC-AGG-ID: ftxJ3z7VMWCxCzHxRTdCfg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EC2F019560AA
	for <gfs2@lists.linux.dev>; Thu,  7 Nov 2024 20:46:23 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 58475300019E;
	Thu,  7 Nov 2024 20:46:23 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [RFC dlm/next 03/11] dlm: use hold_lkb() instead kref_get()
Date: Thu,  7 Nov 2024 15:46:09 -0500
Message-ID: <20241107204617.147842-4-aahringo@redhat.com>
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
X-Mimecast-MFC-PROC-ID: NRLLYWdw3Fw8yHRpGlWEUVx-Q7ni2i9UOtk7aZ-saPg_1731012384
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Using internal dlm helper to call kref_get() for a lkb.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/lock.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index 32fdee78e7f5..42cef3d2af47 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -1523,6 +1523,15 @@ static int create_lkb(struct dlm_ls *ls, struct dlm_lkb **lkb_ret)
 	return _create_lkb(ls, lkb_ret, 1, ULONG_MAX);
 }
 
+/* This is only called to add a reference when the code already holds
+ * a valid reference to the lkb, so there's no need for locking.
+ */
+
+static inline void hold_lkb(struct dlm_lkb *lkb)
+{
+	kref_get(&lkb->lkb_ref);
+}
+
 static int find_lkb(struct dlm_ls *ls, uint32_t lkid, struct dlm_lkb **lkb_ret)
 {
 	struct dlm_lkb *lkb;
@@ -1536,7 +1545,7 @@ static int find_lkb(struct dlm_ls *ls, uint32_t lkid, struct dlm_lkb **lkb_ret)
 		 */
 		read_lock_bh(&ls->ls_lkbxa_lock);
 		if (kref_read(&lkb->lkb_ref))
-			kref_get(&lkb->lkb_ref);
+			hold_lkb(lkb);
 		else
 			lkb = NULL;
 		read_unlock_bh(&ls->ls_lkbxa_lock);
@@ -1593,14 +1602,6 @@ int dlm_put_lkb(struct dlm_lkb *lkb)
 	return __put_lkb(ls, lkb);
 }
 
-/* This is only called to add a reference when the code already holds
-   a valid reference to the lkb, so there's no need for locking. */
-
-static inline void hold_lkb(struct dlm_lkb *lkb)
-{
-	kref_get(&lkb->lkb_ref);
-}
-
 static void unhold_lkb_assert(struct kref *kref)
 {
 	struct dlm_lkb *lkb = container_of(kref, struct dlm_lkb, lkb_ref);
@@ -1638,7 +1639,7 @@ static void lkb_add_ordered(struct list_head *new, struct list_head *head,
 
 static void add_lkb(struct dlm_rsb *r, struct dlm_lkb *lkb, int status)
 {
-	kref_get(&lkb->lkb_ref);
+	hold_lkb(lkb);
 
 	DLM_ASSERT(!lkb->lkb_status, dlm_print_lkb(lkb););
 
-- 
2.43.0

