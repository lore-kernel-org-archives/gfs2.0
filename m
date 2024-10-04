Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993A31D9A60
	for <gfs2@lists.linux.dev>; Fri,  4 Oct 2024 15:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728054834; cv=none; b=UzWlOELGXUcFQotZmQlhFUBIHUQjyHT0wgx3X9RiG//U+YbQDUV9PRA6A/+Q3HroNSqivPuufmt7DvlpQjYH1rzD+soDyjlU69CWh8wHWWQHp2cQl6sJ5iKqCrx8qZBz0mx+REjSYZTSYc+nWAEH3/2Bxqax1FA2RUQG7o66lTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728054834; c=relaxed/simple;
	bh=1N6+VTCri3RTU/B1u7V///ykb3jYlbpuLCHC0uEO5gg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PMymeTMKM+Z63ysnrwhRB1w7xjYM2ctjOxFtce4ssg/XcxaTxOm5WDvzG+VzCKdZKkY9GLqtQgJuswyOe+XCE+UOl6iRDJCxxcgkeq5sCxuJ407JMlnQxn0ZxtC5Rf6GeVZQ9zxocQB2MQMtQjiswWU9gHyaI22BuHWoCK92gkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FH+Swnq1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FH+Swnq1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728054831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EM1/wUgmR5kOkfgqcx7i30KJLeQppHU2kA3889Q5bww=;
	b=FH+Swnq1mzcEo7Y2HnDQ7oEfWvneTPXWxarIVHXwOzi5IDEhzjYgVibYNJgQHLf5UYVTK+
	EovW+4wL+6YYNHBY+dnJAqzQDtvZYwYWyaATtCUb7K+M+D6eOVaWjgVIWiOrCjWUu6YpTP
	FOTFci9SwC+lHZ1Bje0rahLDyKScNSA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-644-jpJb76VNPUWFuVey25WGCQ-1; Fri,
 04 Oct 2024 11:13:50 -0400
X-MC-Unique: jpJb76VNPUWFuVey25WGCQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1F3F11955EE6
	for <gfs2@lists.linux.dev>; Fri,  4 Oct 2024 15:13:49 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7B86319560AE;
	Fri,  4 Oct 2024 15:13:48 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCH v6.12-rc1 3/7] dlm: disallow different configs nodeid storages
Date: Fri,  4 Oct 2024 11:13:39 -0400
Message-ID: <20241004151343.3952937-4-aahringo@redhat.com>
In-Reply-To: <20241004151343.3952937-1-aahringo@redhat.com>
References: <20241004151343.3952937-1-aahringo@redhat.com>
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

The DLM configfs path has usually a nodeid in it's directory path and
again a file to store the nodeid again in a separate storage. It is
forced that the user space will set both (the directory name and nodeid
file) storage to the same value if it doesn't do that we run in some
kind of broken state.

This patch will simply represent the file storage to it's upper
directory nodeid name. It will force the user now to use a valid
unsigned int as nodeid directory name and will ignore all nodeid writes
in the nodeid file storage as this will now always represent the upper
nodeid directory name.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/config.c | 69 +++++++++++++++++++++++++++++++++----------------
 fs/dlm/config.h |  2 +-
 fs/dlm/member.c |  2 +-
 3 files changed, 49 insertions(+), 24 deletions(-)

diff --git a/fs/dlm/config.c b/fs/dlm/config.c
index eac96f1c1d74..1980afaaa68c 100644
--- a/fs/dlm/config.c
+++ b/fs/dlm/config.c
@@ -24,9 +24,9 @@
 #include "lowcomms.h"
 
 /*
- * /config/dlm/<cluster>/spaces/<space>/nodes/<node>/nodeid
+ * /config/dlm/<cluster>/spaces/<space>/nodes/<node>/nodeid (refers to <node>)
  * /config/dlm/<cluster>/spaces/<space>/nodes/<node>/weight
- * /config/dlm/<cluster>/comms/<comm>/nodeid
+ * /config/dlm/<cluster>/comms/<comm>/nodeid (refers to <comm>)
  * /config/dlm/<cluster>/comms/<comm>/local
  * /config/dlm/<cluster>/comms/<comm>/addr      (write only)
  * /config/dlm/<cluster>/comms/<comm>/addr_list (read only)
@@ -517,6 +517,12 @@ static void release_space(struct config_item *i)
 static struct config_item *make_comm(struct config_group *g, const char *name)
 {
 	struct dlm_comm *cm;
+	unsigned int nodeid;
+	int rv;
+
+	rv = kstrtouint(name, 0, &nodeid);
+	if (rv)
+		return ERR_PTR(rv);
 
 	cm = kzalloc(sizeof(struct dlm_comm), GFP_NOFS);
 	if (!cm)
@@ -528,7 +534,7 @@ static struct config_item *make_comm(struct config_group *g, const char *name)
 	if (!cm->seq)
 		cm->seq = dlm_comm_count++;
 
-	cm->nodeid = -1;
+	cm->nodeid = nodeid;
 	cm->local = 0;
 	cm->addr_count = 0;
 	cm->mark = 0;
@@ -555,16 +561,25 @@ static void release_comm(struct config_item *i)
 static struct config_item *make_node(struct config_group *g, const char *name)
 {
 	struct dlm_space *sp = config_item_to_space(g->cg_item.ci_parent);
+	unsigned int nodeid;
 	struct dlm_node *nd;
+	uint32_t seq = 0;
+	int rv;
+
+	rv = kstrtouint(name, 0, &nodeid);
+	if (rv)
+		return ERR_PTR(rv);
 
 	nd = kzalloc(sizeof(struct dlm_node), GFP_NOFS);
 	if (!nd)
 		return ERR_PTR(-ENOMEM);
 
 	config_item_init_type_name(&nd->item, name, &node_type);
-	nd->nodeid = -1;
+	nd->nodeid = nodeid;
 	nd->weight = 1;  /* default weight of 1 if none is set */
 	nd->new = 1;     /* set to 0 once it's been read by dlm_nodeid_list() */
+	dlm_comm_seq(nodeid, &seq, true);
+	nd->comm_seq = seq;
 
 	mutex_lock(&sp->members_lock);
 	list_add(&nd->list, &sp->members);
@@ -622,16 +637,19 @@ void dlm_config_exit(void)
 
 static ssize_t comm_nodeid_show(struct config_item *item, char *buf)
 {
-	return sprintf(buf, "%d\n", config_item_to_comm(item)->nodeid);
+	unsigned int nodeid;
+	int rv;
+
+	rv = kstrtouint(config_item_name(item), 0, &nodeid);
+	if (WARN_ON(rv))
+		return rv;
+
+	return sprintf(buf, "%u\n", nodeid);
 }
 
 static ssize_t comm_nodeid_store(struct config_item *item, const char *buf,
 				 size_t len)
 {
-	int rc = kstrtoint(buf, 0, &config_item_to_comm(item)->nodeid);
-
-	if (rc)
-		return rc;
 	return len;
 }
 
@@ -772,20 +790,19 @@ static struct configfs_attribute *comm_attrs[] = {
 
 static ssize_t node_nodeid_show(struct config_item *item, char *buf)
 {
-	return sprintf(buf, "%d\n", config_item_to_node(item)->nodeid);
+	unsigned int nodeid;
+	int rv;
+
+	rv = kstrtouint(config_item_name(item), 0, &nodeid);
+	if (WARN_ON(rv))
+		return rv;
+
+	return sprintf(buf, "%u\n", nodeid);
 }
 
 static ssize_t node_nodeid_store(struct config_item *item, const char *buf,
 				 size_t len)
 {
-	struct dlm_node *nd = config_item_to_node(item);
-	uint32_t seq = 0;
-	int rc = kstrtoint(buf, 0, &nd->nodeid);
-
-	if (rc)
-		return rc;
-	dlm_comm_seq(nd->nodeid, &seq);
-	nd->comm_seq = seq;
 	return len;
 }
 
@@ -845,7 +862,7 @@ static struct dlm_comm *get_comm(int nodeid)
 	if (!comm_list)
 		return NULL;
 
-	mutex_lock(&clusters_root.subsys.su_mutex);
+	WARN_ON_ONCE(!mutex_is_locked(&clusters_root.subsys.su_mutex));
 
 	list_for_each_entry(i, &comm_list->cg_children, ci_entry) {
 		cm = config_item_to_comm(i);
@@ -856,7 +873,6 @@ static struct dlm_comm *get_comm(int nodeid)
 		config_item_get(i);
 		break;
 	}
-	mutex_unlock(&clusters_root.subsys.su_mutex);
 
 	if (!found)
 		cm = NULL;
@@ -916,11 +932,20 @@ int dlm_config_nodes(char *lsname, struct dlm_config_node **nodes_out,
 	return rv;
 }
 
-int dlm_comm_seq(int nodeid, uint32_t *seq)
+int dlm_comm_seq(int nodeid, uint32_t *seq, bool locked)
 {
-	struct dlm_comm *cm = get_comm(nodeid);
+	struct dlm_comm *cm;
+
+	if (locked) {
+		cm = get_comm(nodeid);
+	} else {
+		mutex_lock(&clusters_root.subsys.su_mutex);
+		cm = get_comm(nodeid);
+		mutex_unlock(&clusters_root.subsys.su_mutex);
+	}
 	if (!cm)
 		return -EEXIST;
+
 	*seq = cm->seq;
 	put_comm(cm);
 	return 0;
diff --git a/fs/dlm/config.h b/fs/dlm/config.h
index ed237d910208..8a14a6e95463 100644
--- a/fs/dlm/config.h
+++ b/fs/dlm/config.h
@@ -50,7 +50,7 @@ int dlm_config_init(void);
 void dlm_config_exit(void);
 int dlm_config_nodes(char *lsname, struct dlm_config_node **nodes_out,
 		     int *count_out);
-int dlm_comm_seq(int nodeid, uint32_t *seq);
+int dlm_comm_seq(int nodeid, uint32_t *seq, bool locked);
 int dlm_our_nodeid(void);
 int dlm_our_addr(struct sockaddr_storage *addr, int num);
 
diff --git a/fs/dlm/member.c b/fs/dlm/member.c
index c9661906568a..b0864c93230f 100644
--- a/fs/dlm/member.c
+++ b/fs/dlm/member.c
@@ -493,7 +493,7 @@ static void dlm_lsop_recover_slot(struct dlm_ls *ls, struct dlm_member *memb)
 	   we consider the node to have failed (versus
 	   being removed due to dlm_release_lockspace) */
 
-	error = dlm_comm_seq(memb->nodeid, &seq);
+	error = dlm_comm_seq(memb->nodeid, &seq, false);
 
 	if (!error && seq == memb->comm_seq)
 		return;
-- 
2.43.0

