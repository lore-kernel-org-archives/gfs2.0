Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF502BD595
	for <gfs2@lists.linux.dev>; Wed, 23 Jul 2025 15:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753284130; cv=none; b=s2DAMuxAzO9aQJg5ZXxfoZKT0Aolhh/Ss5VOU53NHG6BiDquXYV6YDw7uskGOVGLbpITRhDptTiAmxBpEfjwKvhcgGSZuDMb6tklYECTJvgucN79oDYECKYOU65MHntHkou9DKH+ZjvbfcyF0rlTC9nroqqLSbGNv15530Ibw8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753284130; c=relaxed/simple;
	bh=9UeuQ0iNYwcSm0tFInIX01NyOTliGZ66vNPQYwYCnjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=MO8/rIhkXfLlzKX8SHnYxOE9i2CXNgjq5cEGgSVr6Ab8t/0zj1AWNnt4mjBVUHZ8AN8JwjDgQ8FuF0bVQ6DnjMLl5IKXQv8okO/Wkjrd5ccOgyPM3QvlOBbzpQYR8gVi9FIodSVlV8vXAZYFy95v2ffVAvzqqgF11Z4Yy/KJwc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iwKdWGOF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iwKdWGOF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753284127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AEHM0P61QDIEN0JB9NUyS9USGDIFvdTU2bZsrx+stzM=;
	b=iwKdWGOFUdGVr+EkRtdRjJKypEmRmozhA6B0zhqi4upchgfM7ytzSr87cg9Dtint5HCzTw
	cUcJqYQJjd5t7ipyavn9ZOjKNpK4LCD6LEbjs5Gru5fLXapw03rBmdGfQpf7Yu+4aXr6XE
	aJiqGiWeBhIM40NikYeqdfHcXo0fFJQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-536-_GgoSX0mNQegBm9pu2PUUw-1; Wed,
 23 Jul 2025 11:22:05 -0400
X-MC-Unique: _GgoSX0mNQegBm9pu2PUUw-1
X-Mimecast-MFC-AGG-ID: _GgoSX0mNQegBm9pu2PUUw_1753284125
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D2B511977310
	for <gfs2@lists.linux.dev>; Wed, 23 Jul 2025 15:22:04 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3B2D31955F57;
	Wed, 23 Jul 2025 15:22:02 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: agruenba@redhat.com,
	gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCH v6.16-rc7 4/5] dlm: add lockspace member configfs release_recover
Date: Wed, 23 Jul 2025 11:21:55 -0400
Message-ID: <20250723152156.2988833-5-aahringo@redhat.com>
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
X-Mimecast-MFC-PROC-ID: 0Kx5wmi59JccQc040QcOM2s35z4nKRVr-L6891ZUbg8_1753284125
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

This patch adds a new configfs entry to add an optional additional
attribute when a lockspace member was being removed by rmdir of its
directory.

As configfs does not allow additional attributes to rmdir() we need to set
such value before calling rmdir() to tell an additional attribute for
the rmdir operation. In this case its release_recover that can be used
later for additional handling.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/config.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++--
 fs/dlm/config.h |  2 ++
 fs/dlm/member.c |  7 ++++--
 3 files changed, 69 insertions(+), 4 deletions(-)

diff --git a/fs/dlm/config.c b/fs/dlm/config.c
index a23fd524a6ee3..a0d75b5c83c63 100644
--- a/fs/dlm/config.c
+++ b/fs/dlm/config.c
@@ -26,6 +26,7 @@
 /*
  * /config/dlm/<cluster>/spaces/<space>/nodes/<node>/nodeid (refers to <node>)
  * /config/dlm/<cluster>/spaces/<space>/nodes/<node>/weight
+ * /config/dlm/<cluster>/spaces/<space>/nodes/<node>/release_recover
  * /config/dlm/<cluster>/comms/<comm>/nodeid (refers to <comm>)
  * /config/dlm/<cluster>/comms/<comm>/local
  * /config/dlm/<cluster>/comms/<comm>/addr      (write only)
@@ -267,6 +268,7 @@ enum {
 enum {
 	NODE_ATTR_NODEID = 0,
 	NODE_ATTR_WEIGHT,
+	NODE_ATTR_RELEASE_RECOVER,
 };
 
 struct dlm_clusters {
@@ -280,6 +282,8 @@ struct dlm_spaces {
 struct dlm_space {
 	struct config_group group;
 	struct list_head members;
+	struct list_head members_gone;
+	int members_gone_count;
 	struct mutex members_lock;
 	int members_count;
 	struct dlm_nodes *nds;
@@ -310,6 +314,14 @@ struct dlm_node {
 	int weight;
 	int new;
 	int comm_seq; /* copy of cm->seq when nd->nodeid is set */
+	unsigned int release_recover;
+};
+
+struct dlm_member_gone {
+	int nodeid;
+	unsigned int release_recover;
+
+	struct list_head list; /* space->members_gone */
 };
 
 static struct configfs_group_operations clusters_ops = {
@@ -480,6 +492,7 @@ static struct config_group *make_space(struct config_group *g, const char *name)
 	configfs_add_default_group(&nds->ns_group, &sp->group);
 
 	INIT_LIST_HEAD(&sp->members);
+	INIT_LIST_HEAD(&sp->members_gone);
 	mutex_init(&sp->members_lock);
 	sp->members_count = 0;
 	sp->nds = nds;
@@ -587,10 +600,20 @@ static void drop_node(struct config_group *g, struct config_item *i)
 {
 	struct dlm_space *sp = config_item_to_space(g->cg_item.ci_parent);
 	struct dlm_node *nd = config_item_to_node(i);
+	struct dlm_member_gone *mb_gone;
+
+	mb_gone = kzalloc(sizeof(*mb_gone), GFP_KERNEL);
+	if (!mb_gone)
+		return;
 
 	mutex_lock(&sp->members_lock);
 	list_del(&nd->list);
 	sp->members_count--;
+
+	mb_gone->nodeid = nd->nodeid;
+	mb_gone->release_recover = nd->release_recover;
+	list_add(&mb_gone->list, &sp->members_gone);
+	sp->members_gone_count++;
 	mutex_unlock(&sp->members_lock);
 
 	config_item_put(i);
@@ -815,12 +838,34 @@ static ssize_t node_weight_store(struct config_item *item, const char *buf,
 	return len;
 }
 
+static ssize_t node_release_recover_show(struct config_item *item, char *buf)
+{
+	struct dlm_node *n = config_item_to_node(item);
+
+	return sprintf(buf, "%u\n", n->release_recover);
+}
+
+static ssize_t node_release_recover_store(struct config_item *item,
+					  const char *buf, size_t len)
+{
+	struct dlm_node *n = config_item_to_node(item);
+	int rc;
+
+	rc = kstrtouint(buf, 0, &n->release_recover);
+	if (rc)
+		return rc;
+
+	return len;
+}
+
 CONFIGFS_ATTR(node_, nodeid);
 CONFIGFS_ATTR(node_, weight);
+CONFIGFS_ATTR(node_, release_recover);
 
 static struct configfs_attribute *node_attrs[] = {
 	[NODE_ATTR_NODEID] = &node_attr_nodeid,
 	[NODE_ATTR_WEIGHT] = &node_attr_weight,
+	[NODE_ATTR_RELEASE_RECOVER] = &node_attr_release_recover,
 	NULL,
 };
 
@@ -882,9 +927,10 @@ static void put_comm(struct dlm_comm *cm)
 int dlm_config_nodes(char *lsname, struct dlm_config_node **nodes_out,
 		     int *count_out)
 {
+	struct dlm_member_gone *mb_gone, *mb_safe;
+	struct dlm_config_node *nodes, *node;
 	struct dlm_space *sp;
 	struct dlm_node *nd;
-	struct dlm_config_node *nodes, *node;
 	int rv, count;
 
 	sp = get_space(lsname);
@@ -898,7 +944,7 @@ int dlm_config_nodes(char *lsname, struct dlm_config_node **nodes_out,
 		goto out;
 	}
 
-	count = sp->members_count;
+	count = sp->members_count + sp->members_gone_count;
 
 	nodes = kcalloc(count, sizeof(struct dlm_config_node), GFP_NOFS);
 	if (!nodes) {
@@ -917,6 +963,20 @@ int dlm_config_nodes(char *lsname, struct dlm_config_node **nodes_out,
 		nd->new = 0;
 	}
 
+	/* we delay the remove on nodes until here as configfs does
+	 * not support addtional attributes for rmdir().
+	 */
+	list_for_each_entry_safe(mb_gone, mb_safe, &sp->members_gone, list) {
+		node->nodeid = mb_gone->nodeid;
+		node->release_recover = mb_gone->release_recover;
+		node->gone = true;
+		node++;
+
+		list_del(&mb_gone->list);
+		sp->members_gone_count--;
+		kfree(mb_gone);
+	}
+
 	*count_out = count;
 	*nodes_out = nodes;
 	rv = 0;
diff --git a/fs/dlm/config.h b/fs/dlm/config.h
index 13a3d0b261942..4ebd45f752762 100644
--- a/fs/dlm/config.h
+++ b/fs/dlm/config.h
@@ -17,8 +17,10 @@
 struct dlm_config_node {
 	int nodeid;
 	int weight;
+	bool gone;
 	int new;
 	uint32_t comm_seq;
+	unsigned int release_recover;
 };
 
 extern const struct rhashtable_params dlm_rhash_rsb_params;
diff --git a/fs/dlm/member.c b/fs/dlm/member.c
index b0864c93230f5..152d2cb16f591 100644
--- a/fs/dlm/member.c
+++ b/fs/dlm/member.c
@@ -569,10 +569,10 @@ int dlm_recover_members(struct dlm_ls *ls, struct dlm_recover *rv, int *neg_out)
 
 	list_for_each_entry_safe(memb, safe, &ls->ls_nodes, list) {
 		node = find_config_node(rv, memb->nodeid);
-		if (node && !node->new)
+		if (node && !node->new && !node->gone)
 			continue;
 
-		if (!node) {
+		if (node->gone) {
 			log_rinfo(ls, "remove member %d", memb->nodeid);
 		} else {
 			/* removed and re-added */
@@ -591,6 +591,9 @@ int dlm_recover_members(struct dlm_ls *ls, struct dlm_recover *rv, int *neg_out)
 
 	for (i = 0; i < rv->nodes_count; i++) {
 		node = &rv->nodes[i];
+		if (node->gone)
+			continue;
+
 		if (dlm_is_member(ls, node->nodeid))
 			continue;
 		error = dlm_add_member(ls, node);
-- 
2.43.0

