Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCE346B91
	for <gfs2@lists.linux.dev>; Tue, 18 Jun 2024 16:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718726744; cv=none; b=FWaWcP6L+ics6sSpKu8+10Kh+ynWWXnb3nkVsbxvQdAMwC+U5h2wDQ3YnPscvAqXRY1z3pxdItKTXvsQH4QkCeG+bVz5myhW20f0A0mJj/YWmIWDmbahBOdmQYgptOfwU8H3c3vitEB+ICFOQgvGu+g7HGhNi9uS8FAns8rXlzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718726744; c=relaxed/simple;
	bh=dn+ARu6v+scE0yM+kCAEuRJpycZPKygyrn828FgdQY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hePlDnET6MNUl2iWlu1hshnYvW+brVdiAkVYfHkt2g1DGBNccKiwYhcpZTfz+7HrE17oAAXOCch2/nVw2q/oxG7lak6iyoYLy+8YUEnVe/1jbHrS2mKmHKH7COnSEKD+nmVPF+uaUfLH9dzaR/AQxvenaD9UzRPoCnMrUQ7JsDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cibVz4Zn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cibVz4Zn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718726742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rhapX6wWApKQ/2kAlAWfoC+8S6TDxKAFvuHM9MVcL/g=;
	b=cibVz4ZnkRkkLNT4th5nCrYBxiut86QVNgRNQZ/k3R15aREPHjtFYBSvuVhbmEP7XazIpc
	98XtP3xOzCExz1eg+JWE9T+uB6Fha+YwvOmlLGlTNPdH2swXRcHFTZpy6LmvE5I/XrKVD4
	2LsCmv4IjIylHLnJpN8+CMxUSw3UuyM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-qcC-lwSCP9eOHyoQVJOkHQ-1; Tue,
 18 Jun 2024 12:05:40 -0400
X-MC-Unique: qcC-lwSCP9eOHyoQVJOkHQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 421F119560BA
	for <gfs2@lists.linux.dev>; Tue, 18 Jun 2024 16:05:39 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.40])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1FC0019560AE;
	Tue, 18 Jun 2024 16:05:37 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 13/13] gfs2: Revert "check for no eligible quota changes"
Date: Tue, 18 Jun 2024 18:05:17 +0200
Message-ID: <20240618160517.901589-14-agruenba@redhat.com>
In-Reply-To: <20240618160517.901589-1-agruenba@redhat.com>
References: <20240618160517.901589-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Since the previous commit, function gfs2_quota_sync() will not cause the
sync generation to creep forward by one every time the function is
called; this helps keep things a but more tidy.  We also don't care that
this function allocates a page of memory every time it is called, so no
good reason for keeping qd_changed() anymore, which just duplicates
qd_grab_sync().

This reverts commit 06aa6fd31a5f402b055e12ea53bb7b086359d3c8.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/quota.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
index e27fceee9c63..9a8a30b5aba4 100644
--- a/fs/gfs2/quota.c
+++ b/fs/gfs2/quota.c
@@ -1310,24 +1310,6 @@ void gfs2_quota_change(struct gfs2_inode *ip, s64 change,
 	}
 }
 
-static bool qd_changed(struct gfs2_sbd *sdp)
-{
-	struct gfs2_quota_data *qd;
-	bool changed = false;
-
-	spin_lock(&qd_lock);
-	list_for_each_entry(qd, &sdp->sd_quota_list, qd_list) {
-		spin_lock(&qd->qd_lockref.lock);
-		changed = !test_bit(QDF_LOCKED, &qd->qd_flags) &&
-			  test_bit(QDF_CHANGE, &qd->qd_flags);
-		spin_unlock(&qd->qd_lockref.lock);
-		if (changed)
-			break;
-	}
-	spin_unlock(&qd_lock);
-	return changed;
-}
-
 int gfs2_quota_sync(struct super_block *sb, int type)
 {
 	struct gfs2_sbd *sdp = sb->s_fs_info;
@@ -1338,8 +1320,6 @@ int gfs2_quota_sync(struct super_block *sb, int type)
 
 	if (sb_rdonly(sdp->sd_vfs))
 		return 0;
-	if (!qd_changed(sdp))
-		return 0;
 
 	qda = kcalloc(max_qd, sizeof(struct gfs2_quota_data *), GFP_KERNEL);
 	if (!qda)
-- 
2.45.1

