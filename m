Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5E915C126
	for <gfs2@lists.linux.dev>; Fri,  2 Aug 2024 17:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722619634; cv=none; b=OW+HNaCLh7AddWgZ3GLZPflynU+9dA3M7f+qVEH+fyg5YCk/Szdpq1pArhPJ7djVvZb7Rx1Egit3N81ubp/lo7Nirf8lbgxPrIO7MrNXAJV29m3elGLuFU/idqflnphnc79R1Fqx4vZqVb5VwYlcvpl55VzDHbgTBaIxkjYjXvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722619634; c=relaxed/simple;
	bh=Q3uMSa0B8e2MRHY6CnA5SgoiV1TWdTzcr/4uNcb/nmY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tK/OjHzmYSZbUcREKbS53qrVm76CC8PaUtxy2NpCNHztcfeLq7aF5qUixlckkzK0GjD73kymSgqR3ixwLvCTZv3+hGwwm8G82ViHbHD9AD+WIUGgMp1n9psVlL9mhTtAzvMOPFpTgAm24uxon4d9r7nHfCa9fDtIT1Ny89iicyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GAKdN8Vg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GAKdN8Vg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722619631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A7iBabShcun3mMofl7NvoeoLWupkHggzLcxCGmXRMEQ=;
	b=GAKdN8VgzT2mpbQ5q4ldgrb4GkvWkAWt6ywGuJIgI87532srDnKlA2uxdlVquSSOXT48UN
	LhltPfJvOgh3Driuc507sMZK8dSs3u4H0HDIGVty/aqES1HrK7590jP5H085Zwb7oh3agJ
	DeU/PcDmDvWoeGIrJrwoxyiRT3y8i68=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-132-m7ZuX-X2NCSMnq8F_I1seg-1; Fri,
 02 Aug 2024 13:27:08 -0400
X-MC-Unique: m7ZuX-X2NCSMnq8F_I1seg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A47461955F43
	for <gfs2@lists.linux.dev>; Fri,  2 Aug 2024 17:27:07 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AF9C919560AE;
	Fri,  2 Aug 2024 17:27:06 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCHv2 v6.11-rc1 04/10] dlm: warn about invalid nodeid comparsions
Date: Fri,  2 Aug 2024 13:26:41 -0400
Message-ID: <20240802172647.582745-4-aahringo@redhat.com>
In-Reply-To: <20240802172647.582745-1-aahringo@redhat.com>
References: <20240802172647.582745-1-aahringo@redhat.com>
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

This patch adds a warn on if is_master() and dlm_is_removed() checks on
invalid nodeid states that are probably not what the caller wants to do
here. The is_master() function checking on r->res_nodeid is invalid when
it is set to -1, whereas the dlm_is_removed() has a different meaning
as "nodeid member" and also 0 is invalid.

We run into these cases and this patch changes those cases as we never
will run into them. There should be no functional changes as the
condition should return the same result. However this patch signals now
on caller level that there might be an "extra" case to handle here.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/lock.c    | 6 +++---
 fs/dlm/lock.h    | 2 ++
 fs/dlm/member.c  | 2 ++
 fs/dlm/recover.c | 9 +++++----
 4 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index 720715ddaf48..30aec123a483 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -1151,7 +1151,7 @@ static void __dlm_master_lookup(struct dlm_ls *ls, struct dlm_rsb *r, int our_no
 		r->res_dir_nodeid = our_nodeid;
 	}
 
-	if (fix_master && dlm_is_removed(ls, r->res_master_nodeid)) {
+	if (fix_master && r->res_master_nodeid && dlm_is_removed(ls, r->res_master_nodeid)) {
 		/* Recovery uses this function to set a new master when
 		 * the previous master failed.  Setting NEW_MASTER will
 		 * force dlm_recover_masters to call recover_master on this
@@ -5283,7 +5283,7 @@ int dlm_recover_waiters_post(struct dlm_ls *ls)
 			case DLM_MSG_LOOKUP:
 			case DLM_MSG_REQUEST:
 				_request_lock(r, lkb);
-				if (is_master(r))
+				if (r->res_nodeid != -1 && is_master(r))
 					confirm_master(r, 0);
 				break;
 			case DLM_MSG_CONVERT:
@@ -5396,7 +5396,7 @@ void dlm_recover_purge(struct dlm_ls *ls, const struct list_head *root_list)
 
 	list_for_each_entry(r, root_list, res_root_list) {
 		lock_rsb(r);
-		if (is_master(r)) {
+		if (r->res_nodeid != -1 && is_master(r)) {
 			purge_dead_list(ls, r, &r->res_grantqueue,
 					nodeid_gone, &lkb_count);
 			purge_dead_list(ls, r, &r->res_convertqueue,
diff --git a/fs/dlm/lock.h b/fs/dlm/lock.h
index 4ed8d36f9c6d..b23d7b854ed4 100644
--- a/fs/dlm/lock.h
+++ b/fs/dlm/lock.h
@@ -66,6 +66,8 @@ int dlm_debug_add_lkb_to_waiters(struct dlm_ls *ls, uint32_t lkb_id,
 
 static inline int is_master(struct dlm_rsb *r)
 {
+	WARN_ON_ONCE(r->res_nodeid == -1);
+
 	return !r->res_nodeid;
 }
 
diff --git a/fs/dlm/member.c b/fs/dlm/member.c
index a7ee7fd2b9d3..c9661906568a 100644
--- a/fs/dlm/member.c
+++ b/fs/dlm/member.c
@@ -366,6 +366,8 @@ int dlm_is_member(struct dlm_ls *ls, int nodeid)
 
 int dlm_is_removed(struct dlm_ls *ls, int nodeid)
 {
+	WARN_ON_ONCE(!nodeid || nodeid == -1);
+
 	if (find_memb(&ls->ls_nodes_gone, nodeid))
 		return 1;
 	return 0;
diff --git a/fs/dlm/recover.c b/fs/dlm/recover.c
index c7afb428a2b4..2e1169c81c6e 100644
--- a/fs/dlm/recover.c
+++ b/fs/dlm/recover.c
@@ -452,10 +452,11 @@ static int recover_master(struct dlm_rsb *r, unsigned int *count, uint64_t seq)
 	int is_removed = 0;
 	int error;
 
-	if (is_master(r))
+	if (r->res_nodeid != -1 && is_master(r))
 		return 0;
 
-	is_removed = dlm_is_removed(ls, r->res_nodeid);
+	if (r->res_nodeid != -1)
+		is_removed = dlm_is_removed(ls, r->res_nodeid);
 
 	if (!is_removed && !rsb_flag(r, RSB_NEW_MASTER))
 		return 0;
@@ -664,7 +665,7 @@ int dlm_recover_locks(struct dlm_ls *ls, uint64_t seq,
 	int error, count = 0;
 
 	list_for_each_entry(r, root_list, res_root_list) {
-		if (is_master(r)) {
+		if (r->res_nodeid != -1 && is_master(r)) {
 			rsb_clear_flag(r, RSB_NEW_MASTER);
 			continue;
 		}
@@ -858,7 +859,7 @@ void dlm_recover_rsbs(struct dlm_ls *ls, const struct list_head *root_list)
 
 	list_for_each_entry(r, root_list, res_root_list) {
 		lock_rsb(r);
-		if (is_master(r)) {
+		if (r->res_nodeid != -1 && is_master(r)) {
 			if (rsb_flag(r, RSB_RECOVER_CONVERT))
 				recover_conversion(r);
 
-- 
2.43.0

