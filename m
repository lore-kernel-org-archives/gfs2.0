Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7F2374756
	for <gfs2@lists.linux.dev>; Thu, 10 Sep 2026 08:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789027294; cv=none; b=nDx9Tls8dm0tYEdK5DDr5U20G3Yr3VJTnZOgsjCa7/1hLNC9Exo7mIV20TFeZBOzpMtCxKrJywCvdQviGddUr/ghCmLrEYNagfECEcmvvtznX3Xl/Oqgd1Rd/YDHZTfWptjF9z1mnT2eaRvcPXP+QQogJHwAtkvMKccM93HuN48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789027294; c=relaxed/simple;
	bh=WyAw1/jfoIXOQjPzISlBwt+H20rtIxF9JAc0nOecTV0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YMWGM+AH4r1Y5d1hzhzCA1SqbGDUAk3i7YQFLqnY+1zMCzTzdIdtLUjnvoiDyXzo5nLP6ESshSO6M108fg7EklvghcI9FSAs2VTe6wj+8jP6TOJ3WYnjUy5P6OQrIr3OrVfcLnQWdFcK67JE9tnOT7pieeohB79muaDAOrwAj1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Tft6q7Zq; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Tft6q7Zq"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hgVVt4Ck8zMlLQ;
	Thu, 10 Sep 2026 10:01:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1789027286;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xUGHDg3xfienPRmcFr9s3uJ4OnOAfKgnakOKetzCAb4=;
	b=Tft6q7Zq7HYYIMkbFVkTDrPotgEikW10Cyjk1KRMlJxjlHUC6E3WmpmEaQLkJf+qpS+vCl
	b/raW8jSQHS23P/M/C+F99n9AGI1yZiDGu8NMEdPT+Znx7XEH5yXf6889vB70PnQPwWuNb
	D2fZcG2CVVn+BZfto0gbo4e3PUjYx+omA31h2OWF/cMRnsf6J+4+dIJtNZk/FfBnC49o6Q
	qu05BZKpQrp2T/z0NcVtOP8Fdqm2S0M32m6Yzz249CLeLuiZeqmsgOj1xHYGwg+Ms//Km4
	hAvXxjK+AZ4txtTxLuEXV3E+GzdgN2d+05NFqoW1qBDaIE61ENrT+G9cs4d4HQ==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of a0yami@mailbox.org designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=a0yami@mailbox.org
From: Qing Ming <a0yami@mailbox.org>
To: Alexander Aring <aahringo@redhat.com>,
	David Teigland <teigland@redhat.com>
Cc: Steve Whitehouse <swhiteho@redhat.com>,
	gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dlm: validate node weights before building member array
Date: Thu, 10 Sep 2026 16:00:51 +0800
Message-ID: <20260910080051.160454-1-a0yami@mailbox.org>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: fgxwgaeytxicacq6ygq1gi1surqic4e8
X-MBO-RS-ID: 33ce265e6d82003944f
X-Rspamd-Queue-Id: 4hgVVt4Ck8zMlLQ

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

base-commit: ed9b6a1296f10e4881d93dfe6d76013fbbaeee87
-- 
2.53.0

