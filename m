Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB037186E3B
	for <gfs2@lists.linux.dev>; Mon, 29 Jul 2024 19:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722281803; cv=none; b=bQQ9wyNgMpQ7cWULfhzH39PK6ScZ47V6d8DdWosE2KhGE/OCSD3srXFX0/LKkGdcXDX8O/HyTAmoAlAUk7MgeDYAqZ5PrqafU3EGmfIVyxMlaZwYAhSCh8PoTN3S8zvrDoY+JzOVnS04k5ksLj9sn0+/D89MMrGNynGn6EUWiOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722281803; c=relaxed/simple;
	bh=RI2YzXWMtQGzLFHmN/tzzmqnsF0psgMYyBqv9YVUkEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ngt7oyFj/mdVftmm0blR6Npbv4tbhVmsZi1a3EvzAQ/yvr4r6f4G6bRoA92DEQjhnJWNKi+bYPd9hHPdwZJEArTH7gpowzxla5yLvtzOO3Ddqd1RS+NJT40n6grqFDUNWzBop9FYUny8KGm9Iq6frnxq3FBlCKzDcurR9MsUbo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tvxgea1q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tvxgea1q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722281800;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qwxuW9oOhhNxk2/Z/1WdlSmeJagPTAlWdIhm1ZYCdxs=;
	b=Tvxgea1qL7LABwibPD0dQO/RT/YG0bey9JnrwM0qvZ/eKrug7jeq3TjUB9+UNPcLgW/XRx
	4kRDV3nsqOMrgQxeVnweK/9pq3SEwgmAtZpREOSrWrFJfAPQxHG4As4DW9H/LxRPBVidq4
	JB2OJJ4iyO9vC+Yo+luf4ngZzDVsphE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-591-x0e6nEdNMR6vG7aoKNPEbw-1; Mon,
 29 Jul 2024 15:36:39 -0400
X-MC-Unique: x0e6nEdNMR6vG7aoKNPEbw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 591E9195608B
	for <gfs2@lists.linux.dev>; Mon, 29 Jul 2024 19:36:38 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AE0DF1955D42;
	Mon, 29 Jul 2024 19:36:37 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCH v6.11-rc1 02/10] dlm: remove unnecessary refcounts
Date: Mon, 29 Jul 2024 15:36:22 -0400
Message-ID: <20240729193630.3344082-2-aahringo@redhat.com>
In-Reply-To: <20240729193630.3344082-1-aahringo@redhat.com>
References: <20240729193630.3344082-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

This patch removes unnecessary refcounts that are obviously not
necessary because either when the pointer is passed as parameter or it
is part of a list we should already hold a reference to it.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/lock.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index 6930d7c57216..720715ddaf48 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -1442,18 +1442,6 @@ static void deactivate_rsb(struct kref *kref)
 	}
 }
 
-/* See comment for unhold_lkb */
-
-static void unhold_rsb(struct dlm_rsb *r)
-{
-	int rv;
-
-	/* inactive rsbs are not ref counted */
-	WARN_ON(rsb_flag(r, RSB_INACTIVE));
-	rv = kref_put(&r->res_ref, deactivate_rsb);
-	DLM_ASSERT(!rv, dlm_dump_rsb(r););
-}
-
 void free_inactive_rsb(struct dlm_rsb *r)
 {
 	WARN_ON_ONCE(!rsb_flag(r, RSB_INACTIVE));
@@ -1675,10 +1663,8 @@ static void del_lkb(struct dlm_rsb *r, struct dlm_lkb *lkb)
 
 static void move_lkb(struct dlm_rsb *r, struct dlm_lkb *lkb, int sts)
 {
-	hold_lkb(lkb);
 	del_lkb(r, lkb);
 	add_lkb(r, lkb, sts);
-	unhold_lkb(lkb);
 }
 
 static int msg_reply_type(int mstype)
@@ -5409,7 +5395,6 @@ void dlm_recover_purge(struct dlm_ls *ls, const struct list_head *root_list)
 		return;
 
 	list_for_each_entry(r, root_list, res_root_list) {
-		hold_rsb(r);
 		lock_rsb(r);
 		if (is_master(r)) {
 			purge_dead_list(ls, r, &r->res_grantqueue,
@@ -5420,7 +5405,7 @@ void dlm_recover_purge(struct dlm_ls *ls, const struct list_head *root_list)
 					nodeid_gone, &lkb_count);
 		}
 		unlock_rsb(r);
-		unhold_rsb(r);
+
 		cond_resched();
 	}
 
-- 
2.43.0

