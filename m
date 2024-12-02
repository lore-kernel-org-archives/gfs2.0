Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66349209F26
	for <gfs2@lists.linux.dev>; Mon,  2 Dec 2024 15:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733153215; cv=none; b=ZW271+kKxzbmycvBNLP6lketU2Su2YK+NfsaCkzidm86zIfgBNRDwsxqABkUwq+lUM+ehzd6CKGmIyixAz2fGSu5pYJQFsPqf3cAIWXE67XhD+KX6KfdHnIWXiAOAoDd63QDYBDyw/zSHGzUlF6P6aMe9EghnV0O3o129albkyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733153215; c=relaxed/simple;
	bh=s+vGW+20lp38VqBWXV3Uhwxm+lr35pBnIuoNSNAEzaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=rsKq+VItmsR/Hv1H5aYn0gYjOdTP6txP0wyqikSLrh0h8TcRRThW5CvIB/pPm0ETlm9PnQm6iMm9ehvnguLC9cEXijjcV2tn3vkOLrw/pc0rh9ISYsrConOgSCvJRtTDuNcCJOkO7yHtbHwh4c7UuPopCaNiEJa4Aeujiz/0i2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IFTJgm59; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IFTJgm59"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733153212;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eQowBhJDnWZJODgyJNgZgsWAX63qBWxQOIR1ZGAyBMI=;
	b=IFTJgm59nNSFOAHItN/BwPhMsCTEpx6nwy+Lz5hwi3tLD08krUz6XjiSm7MuL1UN1+KkFl
	G1cirkfx0cLz8u7ky/VA5Gn5cUyX1B5vveAG67LD+jYIkUCTND5NcZPCsa9W4k6IhrZHR8
	h7t8oLy4FMHvfqB1Pey/Bg1M08Q3OQ4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-20-8VhILFi3Pqu8F1dEVQUAgQ-1; Mon,
 02 Dec 2024 10:26:51 -0500
X-MC-Unique: 8VhILFi3Pqu8F1dEVQUAgQ-1
X-Mimecast-MFC-AGG-ID: 8VhILFi3Pqu8F1dEVQUAgQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 54D071944D25
	for <gfs2@lists.linux.dev>; Mon,  2 Dec 2024 15:26:50 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9030230001A5;
	Mon,  2 Dec 2024 15:26:49 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCH v6.13-rc1 3/5] dlm: add more sanity checks related scan timer
Date: Mon,  2 Dec 2024 10:26:39 -0500
Message-ID: <20241202152641.3395369-3-aahringo@redhat.com>
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
X-Mimecast-MFC-PROC-ID: dliJB6NaddMVTCgKnZJD_9m4R0sbFlqLkfJ2tGxIZzw_1733153210
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

This patch adds more sanity checks if an invalid rsb structure is on the
scan timer which should never be on the timer because it is waiting on a
remove messages instead of a timeout of being unused.

The function del_scan() should therefore never be called on certain rsbs
that puts the rsb on the scan list for the scan timer. In case of a
find_rsb_dir() rsbs that are not the master and the dir record should
never be on the scan list as well as they waiting for a remove message.
We just always check on a lookup if there might be other buggy places
that accidentially moved those rsbs on the scan list.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/lock.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index a8885cf82913..a834c270f24e 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -426,8 +426,8 @@ static void del_scan(struct dlm_ls *ls, struct dlm_rsb *r)
 	spin_lock_bh(&ls->ls_scan_lock);
 	r->res_toss_time = 0;
 
-	/* if the rsb is not queued do nothing */
-	if (list_empty(&r->res_scan_list))
+	/* if the rsb is not queued do nothing, should never be the case */
+	if (WARN_ON(list_empty(&r->res_scan_list)))
 		goto out;
 
 	/* get the first element before delete */
@@ -830,6 +830,8 @@ static int find_rsb_dir(struct dlm_ls *ls, const void *name, int len,
 	if (r->res_master_nodeid == our_nodeid ||
 	    r->res_dir_nodeid != our_nodeid)
 		del_scan(ls, r);
+	else
+		WARN_ON(!list_empty(&r->res_scan_list));
 	list_move(&r->res_slow_list, &ls->ls_slow_active);
 	rsb_clear_flag(r, RSB_INACTIVE);
 	kref_init(&r->res_ref); /* ref is now used in active state */
-- 
2.43.0

