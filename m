Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E420448D0C
	for <gfs2@lists.linux.dev>; Fri,  2 Oct 2026 21:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790975507; cv=none; b=AKh7WU7Fno9JRlF94MPNqZVkp4K9pqQRq8TY4O6wNn/3vImGg+ZxTOivfs920ra0NBDKoFZQrYeoO0jA1KpvaX7SnualV+cb588SoZnafyy0AnvwLtKgGgQOhtkOI/C5mfVReZZgRYSOt+DHTCnwvyHm024uPFMbeqrAtEqAsjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790975507; c=relaxed/simple;
	bh=M6bF7+7S7a8+8pegrPxUbjSrXXhTXu+AlEiM71Th05w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=PGCZsiNboth+nlLkCU0qYSQeyNaKoUhJuTlpc1+0blbwEJqRrfKxk0dEaGiD9jRwrlww/e29XvuKApVpGX44DTiE3B4IOSpXsMnMRDelBXJ/LlwSWxlO2VxCkuLdwvYWri+bohKUjaSMmSLIPwAbwI8SHEgJnUSJD4tLTSWM71A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IJrJZje+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IJrJZje+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790975498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZPecx+3TM1G58nOsrZpepgrgQX4wAaI7KA7QiFxVPTg=;
	b=IJrJZje+hWGcqX0e/P/YUqgUh+GGUbZ+kNTQY6mlV4412Ya1Cg6gvU4cyEC3Pt/CXtf8bN
	8oS3zmVevjVRO2eogErRQAyp8NRHZREEyDKXM8GP2Z+snNpfn9Iy8nAFyJndQ/q9usAyJV
	vpfuAM4iTaYhUub3RcyBrCgrqZHveag=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-490-t_NljYWJMXmOWlWvvnQ36w-1; Fri,
 02 Oct 2026 17:11:34 -0400
X-MC-Unique: t_NljYWJMXmOWlWvvnQ36w-1
X-Mimecast-MFC-AGG-ID: t_NljYWJMXmOWlWvvnQ36w_1790975493
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D214F18011EC
	for <gfs2@lists.linux.dev>; Fri,  2 Oct 2026 21:11:33 +0000 (UTC)
Received: from fs-i40c-03.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1C1E91956042;
	Fri,  2 Oct 2026 21:11:33 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: aahringo@redhat.com,
	gfs2@lists.linux.dev
Subject: [PATCH RESEND dlm/next 1/3] dlm: validate node weights before building member array
Date: Fri,  2 Oct 2026 17:11:28 -0400
Message-ID: <20261002211130.1573679-2-aahringo@redhat.com>
In-Reply-To: <20261002211130.1573679-1-aahringo@redhat.com>
References: <20261002211130.1573679-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: eweVCfbLVUtClwqVM1xhE5eqdCHkRpMYEg79AeV6Fv0_1790975493
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

From: Qing Ming <a0yami@mailbox.org>

DLM node weights are parsed as signed integers and copied into the member
list. make_member_array() uses their sum as the allocation count, but only
positive weights contribute entries to the array. A negative weight can
therefore reduce the allocation without reducing the number of writes.

The issue was found through static analysis of the configfs input and
member array construction. With two recovery members weighted -31 and 32,
the sum is 1, so recovery allocates one int and then writes the positive
member's node ID 32 times. A reproducer using dlm_controld and dlm_tool
triggered the same report on a KASAN kernel:

  BUG: KASAN: slab-out-of-bounds in dlm_recover_members [dlm]
  Write of size 4 by task dlm_recoverd

  Call Trace:
   dlm_recover_members
   dlm_recoverd
   kthread
   ret_from_fork

Reject negative weights at the configfs input boundary. Also detect
overflow when adding non-negative weights to the signed allocation count,
and propagate array construction errors to the recovery path.

Fixes: e7fd41792fc0 ("[DLM] The core of the DLM for GFS2/CLVM")
Signed-off-by: Qing Ming <a0yami@mailbox.org>
Assisted-by: Codex:gpt-5
Acked-by: Alexander Aring <aahringo@redhat.com>
Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/config.c |  9 ++++++++-
 fs/dlm/member.c | 17 +++++++++++------
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/fs/dlm/config.c b/fs/dlm/config.c
index 6c5c3f049b33..6ebc0fa9a2fa 100644
--- a/fs/dlm/config.c
+++ b/fs/dlm/config.c
@@ -857,10 +857,17 @@ static ssize_t node_weight_show(struct config_item *item, char *buf)
 static ssize_t node_weight_store(struct config_item *item, const char *buf,
 				 size_t len)
 {
-	int rc = kstrtoint(buf, 0, &config_item_to_node(item)->weight);
+	struct dlm_node *node = config_item_to_node(item);
+	int weight;
+	int rc;
 
+	rc = kstrtoint(buf, 0, &weight);
 	if (rc)
 		return rc;
+	if (weight < 0)
+		return -EINVAL;
+
+	node->weight = weight;
 	return len;
 }
 
diff --git a/fs/dlm/member.c b/fs/dlm/member.c
index f84233a0fe4a..3a1c558ce9f6 100644
--- a/fs/dlm/member.c
+++ b/fs/dlm/member.c
@@ -402,7 +402,7 @@ void dlm_clear_members_gone(struct dlm_ls *ls)
 	clear_memb_list(&ls->ls_nodes_gone, NULL);
 }
 
-static void make_member_array(struct dlm_ls *ls)
+static int make_member_array(struct dlm_ls *ls)
 {
 	struct dlm_member *memb;
 	int i, w, x = 0, total = 0, all_zero = 0, *array;
@@ -411,8 +411,8 @@ static void make_member_array(struct dlm_ls *ls)
 	ls->ls_node_array = NULL;
 
 	list_for_each_entry(memb, &ls->ls_nodes, list) {
-		if (memb->weight)
-			total += memb->weight;
+		if (check_add_overflow(total, memb->weight, &total))
+			return -EOVERFLOW;
 	}
 
 	/* all nodes revert to weight of 1 if all have weight 0 */
@@ -422,10 +422,9 @@ static void make_member_array(struct dlm_ls *ls)
 		all_zero = 1;
 	}
 
-	ls->ls_total_weight = total;
 	array = kmalloc_objs(*array, total, GFP_NOFS);
 	if (!array)
-		return;
+		return -ENOMEM;
 
 	list_for_each_entry(memb, &ls->ls_nodes, list) {
 		if (!all_zero && !memb->weight)
@@ -442,7 +441,10 @@ static void make_member_array(struct dlm_ls *ls)
 			array[x++] = memb->nodeid;
 	}
 
+	ls->ls_total_weight = total;
 	ls->ls_node_array = array;
+
+	return 0;
 }
 
 /* send a status request to all members just to establish comms connections */
@@ -617,7 +619,10 @@ int dlm_recover_members(struct dlm_ls *ls, struct dlm_recover *rv, int *neg_out)
 	}
 	ls->ls_low_nodeid = low;
 
-	make_member_array(ls);
+	error = make_member_array(ls);
+	if (error)
+		return error;
+
 	*neg_out = neg;
 
 	error = ping_members(ls, rv->seq);
-- 
2.43.0

