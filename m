Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3922F50B9
	for <gfs2@lists.linux.dev>; Wed, 23 Jul 2025 15:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753284132; cv=none; b=Mz/MV7TmFRdKn7HPcGc2ufs80UvX5GxO7tpHWOOZZLqMqgkrAOQBWPJlOZNM4hKIEtA7ykY4KIy5UT+Ve/8pYrVWIi3XWdP4SyHzZu35W3fQXS2E8jICnmThpkSdEf7D7jw38c4/dkVXZU5+O/MfcvvSB9sa9ITmP5flULFZ6kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753284132; c=relaxed/simple;
	bh=ldWOw8s6UN53FOzAXNlBkcstbFXxB0kmcvpf4Unyd34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=HAWXKYpqcDatxa+5vikFterIpdefImplATx5J5Ys6y8mcVz/yGjcVQVUgXgmrGKOXWK9eQPTxcsorCsfTEFKSnPMr2ScFA1OA7SOVMKPJv6m9Mk7W/+qz267dO7gSjqou6RGwz+ISCcnlEXmwbAZDSBLG0Zqyn/GRKWOFvQcSOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NdvRuYkg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NdvRuYkg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753284129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8pMzsHaP1bwOIzuoww+LcPO+HPEFvcJOVSS1hO8Ggoo=;
	b=NdvRuYkgicHNn79Y0Vn5VeyVatLWz5KkQ+7/gMmQ8Piu0tVmXUoRd2rgbU0Md/h3wUhoSR
	1RRbSiWoq33oylXVTOkXH5JkGy7e7Icefvpc2PAu3dgIGN8e4pBZ5MOwaVnZlR3h2JXncF
	EG2FqAQsy+33RNxY3vtkvk5KGOH5s7U=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-523-bbSDj8jEMKqOdVGMDAhBYg-1; Wed,
 23 Jul 2025 11:22:07 -0400
X-MC-Unique: bbSDj8jEMKqOdVGMDAhBYg-1
X-Mimecast-MFC-AGG-ID: bbSDj8jEMKqOdVGMDAhBYg_1753284127
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E1B4D19560B0
	for <gfs2@lists.linux.dev>; Wed, 23 Jul 2025 15:22:06 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BDA5E195608D;
	Wed, 23 Jul 2025 15:22:04 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: agruenba@redhat.com,
	gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCH v6.16-rc7 5/5] dlm: introduce DLM_RELEASE_RECOVER
Date: Wed, 23 Jul 2025 11:21:56 -0400
Message-ID: <20250723152156.2988833-6-aahringo@redhat.com>
In-Reply-To: <20250723152156.2988833-1-aahringo@redhat.com>
References: <20250723152156.2988833-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nwpE3bJzdXS_1wVEkJawLEVp8QY-YZHk1rKNhBIw7VY_1753284127
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Introduce DLM_RELEASE_RECOVER value for dlm_lockspace_release() to tell
on remaining nodes to call the recover_slot() callback for the
dlm_lockspace_release() initiator if its called with DLM_RELEASE_RECOVER
as release option.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/lockspace.c  |  2 +-
 fs/dlm/member.c     | 14 ++++++++++----
 include/linux/dlm.h |  5 +++++
 3 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/fs/dlm/lockspace.c b/fs/dlm/lockspace.c
index 6ff666a511c7a..d986b7ef153dc 100644
--- a/fs/dlm/lockspace.c
+++ b/fs/dlm/lockspace.c
@@ -738,7 +738,7 @@ static int release_lockspace(struct dlm_ls *ls, int release_option)
 
 	if (release_option != DLM_RELEASE_NO_EVENT &&
 	    dlm_user_daemon_available())
-		do_uevent(ls, 0, 0);
+		do_uevent(ls, 0, (release_option == DLM_RELEASE_RECOVER));
 
 	dlm_recoverd_stop(ls);
 
diff --git a/fs/dlm/member.c b/fs/dlm/member.c
index 152d2cb16f591..356337102015e 100644
--- a/fs/dlm/member.c
+++ b/fs/dlm/member.c
@@ -478,7 +478,8 @@ static void dlm_lsop_recover_prep(struct dlm_ls *ls)
 	ls->ls_ops->recover_prep(ls->ls_ops_arg);
 }
 
-static void dlm_lsop_recover_slot(struct dlm_ls *ls, struct dlm_member *memb)
+static void dlm_lsop_recover_slot(struct dlm_ls *ls, struct dlm_member *memb,
+				  unsigned int release_recover)
 {
 	struct dlm_slot slot;
 	uint32_t seq;
@@ -495,7 +496,7 @@ static void dlm_lsop_recover_slot(struct dlm_ls *ls, struct dlm_member *memb)
 
 	error = dlm_comm_seq(memb->nodeid, &seq, false);
 
-	if (!error && seq == memb->comm_seq)
+	if (!release_recover && !error && seq == memb->comm_seq)
 		return;
 
 	slot.nodeid = memb->nodeid;
@@ -552,6 +553,7 @@ int dlm_recover_members(struct dlm_ls *ls, struct dlm_recover *rv, int *neg_out)
 	struct dlm_member *memb, *safe;
 	struct dlm_config_node *node;
 	int i, error, neg = 0, low = -1;
+	unsigned int release_recover;
 
 	/* previously removed members that we've not finished removing need to
 	 * count as a negative change so the "neg" recovery steps will happen
@@ -572,8 +574,12 @@ int dlm_recover_members(struct dlm_ls *ls, struct dlm_recover *rv, int *neg_out)
 		if (node && !node->new && !node->gone)
 			continue;
 
+		release_recover = 0;
+
 		if (node->gone) {
-			log_rinfo(ls, "remove member %d", memb->nodeid);
+			release_recover = node->release_recover;
+			log_rinfo(ls, "remove member %d%s", memb->nodeid,
+				  release_recover ? " (release_recover)" : "");
 		} else {
 			/* removed and re-added */
 			log_rinfo(ls, "remove member %d comm_seq %u %u",
@@ -584,7 +590,7 @@ int dlm_recover_members(struct dlm_ls *ls, struct dlm_recover *rv, int *neg_out)
 		list_move(&memb->list, &ls->ls_nodes_gone);
 		remove_remote_member(memb->nodeid);
 		ls->ls_num_nodes--;
-		dlm_lsop_recover_slot(ls, memb);
+		dlm_lsop_recover_slot(ls, memb, release_recover);
 	}
 
 	/* add new members to ls_nodes */
diff --git a/include/linux/dlm.h b/include/linux/dlm.h
index cc7a36244893d..108eb953eb181 100644
--- a/include/linux/dlm.h
+++ b/include/linux/dlm.h
@@ -103,11 +103,16 @@ int dlm_new_lockspace(const char *name, const char *cluster,
  *   a leave event to the cluster manager, so other nodes will
  *   not be notified that the node should be removed from the
  *   list of lockspace members.
+ *
+ * DLM_RELEASE_RECOVER like DLM_RELEASE_NORMAL, but the remaining
+ *   nodes will handle the removal of the node as if the node
+ *   had failed, e.g. the recover_slot() callback would be used.
  */
 #define DLM_RELEASE_NO_LOCKS		0
 #define DLM_RELEASE_UNUSED		1
 #define DLM_RELEASE_NORMAL		2
 #define DLM_RELEASE_NO_EVENT		3
+#define DLM_RELEASE_RECOVER		4
 
 /*
  * dlm_release_lockspace
-- 
2.43.0

