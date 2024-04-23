Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2991422AA
	for <gfs2@lists.linux.dev>; Tue, 23 Apr 2024 19:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713902170; cv=none; b=W+JrcaJ2yyqAthhbVeETYOgcrFRL1YRwbYdonln4weuLi6NViwbYswxA1DcywH4qQy8GWL95cs0woj1bRZ5/H8Wlz/stmCvAnUswpKxi3LXcwladp9QF5xuUjeEuh6i2TIUqVzLbAFDONTVKlpZokNhhFgspLwFY5zqiDjWHZD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713902170; c=relaxed/simple;
	bh=rM4oQ1ddIucEo1BzGbMDjpBJ89WK4eIFe3qlFyoK59k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q+DvmJobQ/XmHjI4BMcva3fNSPGM5Z/NZKJg0M5Q47lAnoQA635wpwhl+iXBKDabxm3+CWlQK17/3cnJpabeNKBJAlmMSV2uANczXlC9ujZUi7m+8iep+ebJITppAVw1FjBoJONFLUvRph8mQPhtie4nhwqO2s0BkXlZVoGANAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iLv8u9kk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iLv8u9kk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713902167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WWcRbjFcmf5FTpK0L0BdQOp8Yvy10WWIbC3zJqOcLAI=;
	b=iLv8u9kkYS7kZej/m8ANti9fJqyepoptEUEVb/zOb5c5rDIJcMMalh0yph8UqeJNqLipX2
	ejFwgvy+pZtLTZ5JJSM6Xer9TPTxbnEiVpFlg54RfR2Y1b4xbfiYrdnV77LEVj9DqPouMW
	xk9JWxKtiAiQLwze05G/jCs9Myx0cHo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-0uIORxDdPy-WLFlLHsAq8g-1; Tue, 23 Apr 2024 15:56:05 -0400
X-MC-Unique: 0uIORxDdPy-WLFlLHsAq8g-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8162B104B502
	for <gfs2@lists.linux.dev>; Tue, 23 Apr 2024 19:56:04 +0000 (UTC)
Received: from fs-i40c-03.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7929140F17B;
	Tue, 23 Apr 2024 19:56:04 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCH dlm/next 03/10] dlm: make dlm_our_nodeid read mostly
Date: Tue, 23 Apr 2024 15:55:52 -0400
Message-ID: <20240423195559.1527187-3-aahringo@redhat.com>
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

The dlm_our_nodeid global variable is used a lot in the DLM stack code
to check nodeids with ourself. It is only set once before DLM stack get
started. This patch marks it __read_mostly that does certain cache
aligned etc. to have a fast access to the variable. The function
dlm_our_nodeid() will be replaced by a macro to redirect to the global
dlm_our_nodeid variable.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/config.c | 14 +++++++-------
 fs/dlm/config.h |  3 ++-
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/dlm/config.c b/fs/dlm/config.c
index 99952234799e..1d5a75d23abe 100644
--- a/fs/dlm/config.c
+++ b/fs/dlm/config.c
@@ -33,6 +33,7 @@
  * The <cluster> level is useless, but I haven't figured out how to avoid it.
  */
 
+unsigned int dlm_our_nodeid __read_mostly;
 static struct config_group *space_list;
 static struct config_group *comm_list;
 static struct dlm_comm *local_comm;
@@ -538,8 +539,10 @@ static struct config_item *make_comm(struct config_group *g, const char *name)
 static void drop_comm(struct config_group *g, struct config_item *i)
 {
 	struct dlm_comm *cm = config_item_to_comm(i);
-	if (local_comm == cm)
+	if (local_comm == cm) {
+		dlm_our_nodeid = 0;
 		local_comm = NULL;
+	}
 	dlm_midcomms_close(cm->nodeid);
 	while (cm->addr_count--)
 		kfree(cm->addr[cm->addr_count]);
@@ -648,8 +651,10 @@ static ssize_t comm_local_store(struct config_item *item, const char *buf,
 
 	if (rc)
 		return rc;
-	if (cm->local && !local_comm)
+	if (cm->local && !local_comm) {
+		dlm_our_nodeid = cm->nodeid;
 		local_comm = cm;
+	}
 	return len;
 }
 
@@ -926,11 +931,6 @@ int dlm_comm_seq(int nodeid, uint32_t *seq)
 	return 0;
 }
 
-int dlm_our_nodeid(void)
-{
-	return local_comm ? local_comm->nodeid : 0;
-}
-
 /* num 0 is first addr, num 1 is second addr */
 int dlm_our_addr(struct sockaddr_storage *addr, int num)
 {
diff --git a/fs/dlm/config.h b/fs/dlm/config.h
index ed237d910208..ff0dd13e4457 100644
--- a/fs/dlm/config.h
+++ b/fs/dlm/config.h
@@ -21,6 +21,7 @@ struct dlm_config_node {
 	uint32_t comm_seq;
 };
 
+extern unsigned int dlm_our_nodeid __read_mostly;
 extern const struct rhashtable_params dlm_rhash_rsb_params;
 
 #define DLM_MAX_ADDR_COUNT 3
@@ -51,7 +52,7 @@ void dlm_config_exit(void);
 int dlm_config_nodes(char *lsname, struct dlm_config_node **nodes_out,
 		     int *count_out);
 int dlm_comm_seq(int nodeid, uint32_t *seq);
-int dlm_our_nodeid(void);
+#define dlm_our_nodeid() (dlm_our_nodeid)
 int dlm_our_addr(struct sockaddr_storage *addr, int num);
 
 #endif				/* __CONFIG_DOT_H__ */
-- 
2.43.0

