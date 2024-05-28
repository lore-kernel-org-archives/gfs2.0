Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55ED617B427
	for <gfs2@lists.linux.dev>; Tue, 28 May 2024 21:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716930771; cv=none; b=ML5mj11CoYtQp2uDVL9v8JK1hehioEeeyPVPPYxSJCUIaaWKQeB1pl7tZ24+OYJ8Cc5BmzUzVLdZPkvi0lO76cr91EIOjolcNcTcJArFzHD4g6LeOODdhxF9ifwgqwYhWYHWhu315M+PK1OSkBl3QJUAL3KZ/0yoC+v1MgZnZwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716930771; c=relaxed/simple;
	bh=NgqkexdILoZknDYQOsxx4aunaeYZFm1Qc8tnwTG4J+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gCtxaqAA37B3W6QXrXLCQ9KYPFgXpconhlzYx//qd+aaRw4mUIwigUtlk5PV18b5wlFqyiFz/aWg6Td4UK4rKKfbnUW4R/k9WWpEE4lMXkSiPosjDEVn17lBpw3WaNqW4QijkwS4UTqftZisVM3IfAltOhXCe19Nq9AxSd5Pfzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B5xC0MSd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B5xC0MSd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716930768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nil8vdCuzbD7UwAr3AbqRzHs0EFCdtc12SK+z5U/qY0=;
	b=B5xC0MSdwHFitKST4uETXRVV9jqKzVDXx2OUnXU1LXPeRq8tqaeZ5Ze3oOaK+kWrMXn87D
	1bvX0LbAgEkK3zyahIYDNPFs/YA00cxGWHB+LRQmJr/mly6/S0F27CnCMl52D0cOE3Ee3t
	xivTKICLEelbwD1cVXhvWzcXYbpYBKk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-gCY4nHnPNyS68AOeEGLqpQ-1; Tue, 28 May 2024 17:12:47 -0400
X-MC-Unique: gCY4nHnPNyS68AOeEGLqpQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3D986185A780
	for <gfs2@lists.linux.dev>; Tue, 28 May 2024 21:12:47 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 35F09200BAB1;
	Tue, 28 May 2024 21:12:47 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCH v6.10-rc1 11/11] dlm: use is_master() where it's prossible
Date: Tue, 28 May 2024 17:12:41 -0400
Message-ID: <20240528211241.2140441-11-aahringo@redhat.com>
In-Reply-To: <20240528211241.2140441-1-aahringo@redhat.com>
References: <20240528211241.2140441-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
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
index a044edc2d143..14a73948bbd5 100644
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
index aae97bdc05f6..dd41ad444e98 100644
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

