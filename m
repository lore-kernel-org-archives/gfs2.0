Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6E213C68E
	for <gfs2@lists.linux.dev>; Mon,  3 Jun 2024 21:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717451773; cv=none; b=d75kgD7ZKMc5m7+5c8T7vQPjIEr507H+xNByHPJAFXnkA3cSJq9gwwql7RdHeHAMG0jEOeLLfdzhoRBtCDgCwBf7QQyUapneEgp4VKzR64BxJOOaRjOFbkpPyIRcEUSrofvWYf7QFNAJpk5oyrZRrQuFdIP4m2KB6K9fmjgjPZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717451773; c=relaxed/simple;
	bh=uPyZhTczRbt6lqW73u9fuXTsDjMV6sRnxpZDbjct/CM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VpI+kZUDJTmRTvyj0n37z4w/+OakcWjXxGbEa8zgdR5AMyWKUvpdfmjybGYm+cigIMeWfWOzZyAUjNRbKRSR7O0qkK1GFWc8urOr0DK4mcx53H2ShseiSoyWiJmpx/7mG4w8OLXjkxPJuix4qfgk7dFUpPTjo58Jce59A33KoSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N4c3WKVF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N4c3WKVF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717451770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bShP03m/lI8RlVt6OnEiJn+8a8V/jVoXU4sKIi3R2B4=;
	b=N4c3WKVFgYVnrhb/TVWVXW9ZJB32qvLtOyGvi0HHnSvZ+1o9++YgbfKv6wXZZ/1mzz9klt
	QrcvoMv87Z3n1DIPN3IH0rJdJfPw8AdDSIKPdxuPl6y0lS+GjF5MRDD8GGw8BmjSKSS3LQ
	ksSIhMy4mc4vlAP0DqthjmHMvfU6VKE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-625-xU-geX_dMD2EwJnmtGkG4g-1; Mon,
 03 Jun 2024 17:56:09 -0400
X-MC-Unique: xU-geX_dMD2EwJnmtGkG4g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B7CC33C025A1;
	Mon,  3 Jun 2024 21:56:08 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by smtp.corp.redhat.com (Postfix) with ESMTP id AD40F200E575;
	Mon,  3 Jun 2024 21:56:08 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	song@kernel.org,
	yukuai3@huawei.com,
	linux-raid@vger.kernel.org,
	aahringo@redhat.com
Subject: [PATCH dlm/next 3/8] dlm: use is_master() on checks if we are the master
Date: Mon,  3 Jun 2024 17:55:53 -0400
Message-ID: <20240603215558.2722969-4-aahringo@redhat.com>
In-Reply-To: <20240603215558.2722969-1-aahringo@redhat.com>
References: <20240603215558.2722969-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

There are checks if we are the master or not done by
"r->res_master_nodeid == dlm_our_nodeid()" or unequal to check if we are
not the master. There is a helper function is_master() for doing this
kind of check. This patch replaces several checks of those by using the
helper instead of using the mentioned condition check.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/lock.c     | 9 ++++-----
 fs/dlm/recoverd.c | 2 +-
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index 3195d0b96c74..a41a6fa2123b 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -242,7 +242,7 @@ static inline int is_granted(struct dlm_lkb *lkb)
 static inline int is_remote(struct dlm_rsb *r)
 {
 	DLM_ASSERT(r->res_master_nodeid != 0, dlm_print_rsb(r););
-	return r->res_master_nodeid != dlm_our_nodeid();
+	return !is_master(r);
 }
 
 static inline int is_process_copy(struct dlm_lkb *lkb)
@@ -4025,7 +4025,7 @@ static int receive_request(struct dlm_ls *ls, const struct dlm_message *ms)
 
 	lock_rsb(r);
 
-	if (r->res_master_nodeid != dlm_our_nodeid()) {
+	if (!is_master(r)) {
 		error = validate_master_nodeid(ls, r, from_nodeid);
 		if (error) {
 			unlock_rsb(r);
@@ -4447,8 +4447,7 @@ static int receive_request_reply(struct dlm_ls *ls,
 			  from_nodeid, result, r->res_master_nodeid,
 			  r->res_dir_nodeid, r->res_first_lkid, r->res_name);
 
-		if (r->res_dir_nodeid != dlm_our_nodeid() &&
-		    r->res_master_nodeid != dlm_our_nodeid()) {
+		if (r->res_dir_nodeid != dlm_our_nodeid() && !is_master(r)) {
 			/* cause _request_lock->set_master->send_lookup */
 			r->res_master_nodeid = 0;
 			lkb->lkb_master_nodeid = 0;
@@ -4462,7 +4461,7 @@ static int receive_request_reply(struct dlm_ls *ls,
 		} else {
 			_request_lock(r, lkb);
 
-			if (r->res_master_nodeid == dlm_our_nodeid())
+			if (is_master(r))
 				confirm_master(r, 0);
 		}
 		break;
diff --git a/fs/dlm/recoverd.c b/fs/dlm/recoverd.c
index 06959b128bd0..98d83f90a0db 100644
--- a/fs/dlm/recoverd.c
+++ b/fs/dlm/recoverd.c
@@ -34,7 +34,7 @@ static int dlm_create_masters_list(struct dlm_ls *ls)
 
 	read_lock_bh(&ls->ls_rsbtbl_lock);
 	list_for_each_entry(r, &ls->ls_keep, res_rsbs_list) {
-		if (r->res_master_nodeid != dlm_our_nodeid())
+		if (!is_master(r))
 			continue;
 
 		list_add(&r->res_masters_list, &ls->ls_masters_list);
-- 
2.43.0

