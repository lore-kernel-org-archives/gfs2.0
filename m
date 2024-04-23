Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942421422A4
	for <gfs2@lists.linux.dev>; Tue, 23 Apr 2024 19:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713902169; cv=none; b=nAEmYlAoPNXjBfbNReRGJOMooZLmKc8xX2/yJav2X7EDpXO3qv+IdvJLyecfoTm6Bh9IZzE1Cdz6zsGr1kf7KHlq9OnevaU7aLbwxDUKVTPVv8ev2nHA/Sh9Wh9hyoAfyOT84Wm8LzOB61YNhq50Eke2A02P6GTDx5IV2BMv5Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713902169; c=relaxed/simple;
	bh=OXco+3LFKa055G6zHS5n7Lr4zuRkvTXmD44PozPcUZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s6HpBc+0fl+uaJqVjca6K2pBfkphvp+XtwkcNoYSqOC+PXCQwNjzu7fwsKxmhjG+6HCVpaBwTMprshS9vxv7ApO6oV949Yklz14BxFTTPT6kovNbNkOM1AZnevoQ7s1dF7gYb7h7GYjHb1bvy72zSkd3T+J5dwTKfyiA+oBF74A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V4z6c1La; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V4z6c1La"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713902166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DT11DsgOiPlFs+ssGuzM8PSMmgTBvtqRZrjD7jQilqs=;
	b=V4z6c1LaNIqWOft/vA6lugZ1YGyho+AsmvQqwRuopU53bSfSNFUu3maWYjf4IZKmkEaame
	D36S0aYDFFc7h2twq9ysKCtkz7Ng4TDdQeupjRiRxZNiU/FmjC/dqRj/QIiafQ9j802rnj
	aLsVHFenssp4rACZEzzOKg5Na7j6QM4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-86-kzUxynZFPYidkvmcIiCX5w-1; Tue,
 23 Apr 2024 15:56:05 -0400
X-MC-Unique: kzUxynZFPYidkvmcIiCX5w-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C1C2F3810D23
	for <gfs2@lists.linux.dev>; Tue, 23 Apr 2024 19:56:04 +0000 (UTC)
Received: from fs-i40c-03.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B9F56492BC7;
	Tue, 23 Apr 2024 19:56:04 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCH dlm/next 10/10] dlm: use is_master() where it's prossible
Date: Tue, 23 Apr 2024 15:55:59 -0400
Message-ID: <20240423195559.1527187-10-aahringo@redhat.com>
In-Reply-To: <20240423195559.1527187-1-aahringo@redhat.com>
References: <20240423195559.1527187-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

There are numbers of checks to check if the node itself of a rsb is the
master or not. There is a helper is_master() for it. This patch changes
various places to use this helper.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/lock.c     | 9 ++++-----
 fs/dlm/recoverd.c | 2 +-
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index 5063d3a60834..5b19c246d308 100644
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
@@ -3978,7 +3978,7 @@ static int receive_request(struct dlm_ls *ls, const struct dlm_message *ms)
 
 	lock_rsb(r);
 
-	if (r->res_master_nodeid != dlm_our_nodeid()) {
+	if (!is_master(r)) {
 		error = validate_master_nodeid(ls, r, from_nodeid);
 		if (error) {
 			unlock_rsb(r);
@@ -4400,8 +4400,7 @@ static int receive_request_reply(struct dlm_ls *ls,
 			  from_nodeid, result, r->res_master_nodeid,
 			  r->res_dir_nodeid, r->res_first_lkid, r->res_name);
 
-		if (r->res_dir_nodeid != dlm_our_nodeid() &&
-		    r->res_master_nodeid != dlm_our_nodeid()) {
+		if (r->res_dir_nodeid != dlm_our_nodeid() && !is_master(r)) {
 			/* cause _request_lock->set_master->send_lookup */
 			r->res_master_nodeid = 0;
 			lkb->lkb_master_nodeid = 0;
@@ -4415,7 +4414,7 @@ static int receive_request_reply(struct dlm_ls *ls,
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

