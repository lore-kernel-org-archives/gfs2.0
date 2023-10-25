Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39B21377
	for <gfs2@lists.linux.dev>; Wed, 25 Oct 2023 00:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gKvPfUla"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698195240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=13tvGcFK3YSJhIDBd8okgrvtoxnr32/l/Wj3RaLXtos=;
	b=gKvPfUlaxxe09Zu0b6CnrjnqM2B7hHgS4HzMewYPN3CFVX0aoMIme0uRQPGKDpr4vPNEEN
	lGTkxcxc9Oyvl3xpbc9az0cMHrKFdCU/bhZz+o4g35ZwkpZaZK6Z7AK3fCsBIJwx7UATFI
	+GpdUciVmwewrBTm2PYe2QszusflkJo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-695-7IKt5RNHN1GIjdz8unjiyQ-1; Tue,
 24 Oct 2023 20:53:59 -0400
X-MC-Unique: 7IKt5RNHN1GIjdz8unjiyQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B806C1C05192
	for <gfs2@lists.linux.dev>; Wed, 25 Oct 2023 00:53:58 +0000 (UTC)
Received: from fs-i40c-03.fs.lab.eng.bos.redhat.com (fs-i40c-03.fast.rdu2.eng.redhat.com [10.6.23.54])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A655540C6F79;
	Wed, 25 Oct 2023 00:53:58 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCH dlm/next 01/10] dlm: remove allocation parameter in msg allocation
Date: Tue, 24 Oct 2023 20:53:44 -0400
Message-Id: <20231025005353.855904-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

This patch removes the context parameter for message allocations and
replace it by always do GFP_ATOMIC. We are preparing to process dlm
message in softirq context therefore it's necessary to switch to
GFP_ATOMIC allocation as we cannot sleep in this context. To simplify
the code overall we just drop the allocation flag and have GFP_ATOMIC
hardcoded when calling the allocation function.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/lock.c     | 31 ++++++++++++-------------------
 fs/dlm/lowcomms.c | 16 +++++++---------
 fs/dlm/lowcomms.h |  5 ++---
 fs/dlm/memory.c   |  8 ++++----
 fs/dlm/memory.h   |  4 ++--
 fs/dlm/midcomms.c | 24 ++++++++++--------------
 fs/dlm/midcomms.h |  3 +--
 fs/dlm/rcom.c     |  7 +++----
 8 files changed, 41 insertions(+), 57 deletions(-)

diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index 652c51fbbf76..44ea65a73f3b 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -3329,8 +3329,7 @@ int dlm_unlock(dlm_lockspace_t *lockspace,
 static int _create_message(struct dlm_ls *ls, int mb_len,
 			   int to_nodeid, int mstype,
 			   struct dlm_message **ms_ret,
-			   struct dlm_mhandle **mh_ret,
-			   gfp_t allocation)
+			   struct dlm_mhandle **mh_ret)
 {
 	struct dlm_message *ms;
 	struct dlm_mhandle *mh;
@@ -3340,7 +3339,7 @@ static int _create_message(struct dlm_ls *ls, int mb_len,
 	   pass into midcomms_commit and a message buffer (mb) that we
 	   write our data into */
 
-	mh = dlm_midcomms_get_mhandle(to_nodeid, mb_len, allocation, &mb);
+	mh = dlm_midcomms_get_mhandle(to_nodeid, mb_len, &mb);
 	if (!mh)
 		return -ENOBUFS;
 
@@ -3362,8 +3361,7 @@ static int _create_message(struct dlm_ls *ls, int mb_len,
 static int create_message(struct dlm_rsb *r, struct dlm_lkb *lkb,
 			  int to_nodeid, int mstype,
 			  struct dlm_message **ms_ret,
-			  struct dlm_mhandle **mh_ret,
-			  gfp_t allocation)
+			  struct dlm_mhandle **mh_ret)
 {
 	int mb_len = sizeof(struct dlm_message);
 
@@ -3384,7 +3382,7 @@ static int create_message(struct dlm_rsb *r, struct dlm_lkb *lkb,
 	}
 
 	return _create_message(r->res_ls, mb_len, to_nodeid, mstype,
-			       ms_ret, mh_ret, allocation);
+			       ms_ret, mh_ret);
 }
 
 /* further lowcomms enhancements or alternate implementations may make
@@ -3453,7 +3451,7 @@ static int send_common(struct dlm_rsb *r, struct dlm_lkb *lkb, int mstype)
 	if (error)
 		return error;
 
-	error = create_message(r, lkb, to_nodeid, mstype, &ms, &mh, GFP_NOFS);
+	error = create_message(r, lkb, to_nodeid, mstype, &ms, &mh);
 	if (error)
 		goto fail;
 
@@ -3513,8 +3511,7 @@ static int send_grant(struct dlm_rsb *r, struct dlm_lkb *lkb)
 
 	to_nodeid = lkb->lkb_nodeid;
 
-	error = create_message(r, lkb, to_nodeid, DLM_MSG_GRANT, &ms, &mh,
-			       GFP_NOFS);
+	error = create_message(r, lkb, to_nodeid, DLM_MSG_GRANT, &ms, &mh);
 	if (error)
 		goto out;
 
@@ -3535,8 +3532,7 @@ static int send_bast(struct dlm_rsb *r, struct dlm_lkb *lkb, int mode)
 
 	to_nodeid = lkb->lkb_nodeid;
 
-	error = create_message(r, NULL, to_nodeid, DLM_MSG_BAST, &ms, &mh,
-			       GFP_NOFS);
+	error = create_message(r, NULL, to_nodeid, DLM_MSG_BAST, &ms, &mh);
 	if (error)
 		goto out;
 
@@ -3561,8 +3557,7 @@ static int send_lookup(struct dlm_rsb *r, struct dlm_lkb *lkb)
 	if (error)
 		return error;
 
-	error = create_message(r, NULL, to_nodeid, DLM_MSG_LOOKUP, &ms, &mh,
-			       GFP_NOFS);
+	error = create_message(r, NULL, to_nodeid, DLM_MSG_LOOKUP, &ms, &mh);
 	if (error)
 		goto fail;
 
@@ -3586,8 +3581,7 @@ static int send_remove(struct dlm_rsb *r)
 
 	to_nodeid = dlm_dir_nodeid(r);
 
-	error = create_message(r, NULL, to_nodeid, DLM_MSG_REMOVE, &ms, &mh,
-			       GFP_ATOMIC);
+	error = create_message(r, NULL, to_nodeid, DLM_MSG_REMOVE, &ms, &mh);
 	if (error)
 		goto out;
 
@@ -3608,7 +3602,7 @@ static int send_common_reply(struct dlm_rsb *r, struct dlm_lkb *lkb,
 
 	to_nodeid = lkb->lkb_nodeid;
 
-	error = create_message(r, lkb, to_nodeid, mstype, &ms, &mh, GFP_NOFS);
+	error = create_message(r, lkb, to_nodeid, mstype, &ms, &mh);
 	if (error)
 		goto out;
 
@@ -3650,8 +3644,7 @@ static int send_lookup_reply(struct dlm_ls *ls,
 	struct dlm_mhandle *mh;
 	int error, nodeid = le32_to_cpu(ms_in->m_header.h_nodeid);
 
-	error = create_message(r, NULL, nodeid, DLM_MSG_LOOKUP_REPLY, &ms, &mh,
-			       GFP_NOFS);
+	error = create_message(r, NULL, nodeid, DLM_MSG_LOOKUP_REPLY, &ms, &mh);
 	if (error)
 		goto out;
 
@@ -6063,7 +6056,7 @@ static int send_purge(struct dlm_ls *ls, int nodeid, int pid)
 	int error;
 
 	error = _create_message(ls, sizeof(struct dlm_message), nodeid,
-				DLM_MSG_PURGE, &ms, &mh, GFP_NOFS);
+				DLM_MSG_PURGE, &ms, &mh);
 	if (error)
 		return error;
 	ms->m_nodeid = cpu_to_le32(nodeid);
diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
index 67f8dd8a05ef..db71982d709d 100644
--- a/fs/dlm/lowcomms.c
+++ b/fs/dlm/lowcomms.c
@@ -1229,14 +1229,13 @@ static struct writequeue_entry *new_wq_entry(struct connection *con, int len,
 };
 
 static struct dlm_msg *dlm_lowcomms_new_msg_con(struct connection *con, int len,
-						gfp_t allocation, char **ppc,
-						void (*cb)(void *data),
+						char **ppc, void (*cb)(void *data),
 						void *data)
 {
 	struct writequeue_entry *e;
 	struct dlm_msg *msg;
 
-	msg = dlm_allocate_msg(allocation);
+	msg = dlm_allocate_msg();
 	if (!msg)
 		return NULL;
 
@@ -1261,9 +1260,8 @@ static struct dlm_msg *dlm_lowcomms_new_msg_con(struct connection *con, int len,
  * dlm_lowcomms_commit_msg which is a must call if success
  */
 #ifndef __CHECKER__
-struct dlm_msg *dlm_lowcomms_new_msg(int nodeid, int len, gfp_t allocation,
-				     char **ppc, void (*cb)(void *data),
-				     void *data)
+struct dlm_msg *dlm_lowcomms_new_msg(int nodeid, int len, char **ppc,
+				     void (*cb)(void *data), void *data)
 {
 	struct connection *con;
 	struct dlm_msg *msg;
@@ -1284,7 +1282,7 @@ struct dlm_msg *dlm_lowcomms_new_msg(int nodeid, int len, gfp_t allocation,
 		return NULL;
 	}
 
-	msg = dlm_lowcomms_new_msg_con(con, len, allocation, ppc, cb, data);
+	msg = dlm_lowcomms_new_msg_con(con, len, ppc, cb, data);
 	if (!msg) {
 		srcu_read_unlock(&connections_srcu, idx);
 		return NULL;
@@ -1348,8 +1346,8 @@ int dlm_lowcomms_resend_msg(struct dlm_msg *msg)
 	if (msg->retransmit)
 		return 1;
 
-	msg_resend = dlm_lowcomms_new_msg_con(msg->entry->con, msg->len,
-					      GFP_ATOMIC, &ppc, NULL, NULL);
+	msg_resend = dlm_lowcomms_new_msg_con(msg->entry->con, msg->len, &ppc,
+					      NULL, NULL);
 	if (!msg_resend)
 		return -ENOMEM;
 
diff --git a/fs/dlm/lowcomms.h b/fs/dlm/lowcomms.h
index 3e8dca66183b..8deb16f8f620 100644
--- a/fs/dlm/lowcomms.h
+++ b/fs/dlm/lowcomms.h
@@ -39,9 +39,8 @@ void dlm_lowcomms_stop(void);
 void dlm_lowcomms_init(void);
 void dlm_lowcomms_exit(void);
 int dlm_lowcomms_close(int nodeid);
-struct dlm_msg *dlm_lowcomms_new_msg(int nodeid, int len, gfp_t allocation,
-				     char **ppc, void (*cb)(void *data),
-				     void *data);
+struct dlm_msg *dlm_lowcomms_new_msg(int nodeid, int len, char **ppc,
+				     void (*cb)(void *data), void *data);
 void dlm_lowcomms_commit_msg(struct dlm_msg *msg);
 void dlm_lowcomms_put_msg(struct dlm_msg *msg);
 int dlm_lowcomms_resend_msg(struct dlm_msg *msg);
diff --git a/fs/dlm/memory.c b/fs/dlm/memory.c
index 64f212a066cf..c0c1a83f6381 100644
--- a/fs/dlm/memory.c
+++ b/fs/dlm/memory.c
@@ -134,9 +134,9 @@ void dlm_free_lkb(struct dlm_lkb *lkb)
 	kmem_cache_free(lkb_cache, lkb);
 }
 
-struct dlm_mhandle *dlm_allocate_mhandle(gfp_t allocation)
+struct dlm_mhandle *dlm_allocate_mhandle(void)
 {
-	return kmem_cache_alloc(mhandle_cache, allocation);
+	return kmem_cache_alloc(mhandle_cache, GFP_ATOMIC);
 }
 
 void dlm_free_mhandle(struct dlm_mhandle *mhandle)
@@ -154,9 +154,9 @@ void dlm_free_writequeue(struct writequeue_entry *writequeue)
 	kmem_cache_free(writequeue_cache, writequeue);
 }
 
-struct dlm_msg *dlm_allocate_msg(gfp_t allocation)
+struct dlm_msg *dlm_allocate_msg(void)
 {
-	return kmem_cache_alloc(msg_cache, allocation);
+	return kmem_cache_alloc(msg_cache, GFP_ATOMIC);
 }
 
 void dlm_free_msg(struct dlm_msg *msg)
diff --git a/fs/dlm/memory.h b/fs/dlm/memory.h
index 6b29563d24f7..15198d46b42a 100644
--- a/fs/dlm/memory.h
+++ b/fs/dlm/memory.h
@@ -20,11 +20,11 @@ struct dlm_lkb *dlm_allocate_lkb(struct dlm_ls *ls);
 void dlm_free_lkb(struct dlm_lkb *l);
 char *dlm_allocate_lvb(struct dlm_ls *ls);
 void dlm_free_lvb(char *l);
-struct dlm_mhandle *dlm_allocate_mhandle(gfp_t allocation);
+struct dlm_mhandle *dlm_allocate_mhandle(void);
 void dlm_free_mhandle(struct dlm_mhandle *mhandle);
 struct writequeue_entry *dlm_allocate_writequeue(void);
 void dlm_free_writequeue(struct writequeue_entry *writequeue);
-struct dlm_msg *dlm_allocate_msg(gfp_t allocation);
+struct dlm_msg *dlm_allocate_msg(void);
 void dlm_free_msg(struct dlm_msg *msg);
 struct dlm_callback *dlm_allocate_cb(void);
 void dlm_free_cb(struct dlm_callback *cb);
diff --git a/fs/dlm/midcomms.c b/fs/dlm/midcomms.c
index 2247ebb61be1..ea0559e2a44d 100644
--- a/fs/dlm/midcomms.c
+++ b/fs/dlm/midcomms.c
@@ -380,8 +380,7 @@ static int dlm_send_ack(int nodeid, uint32_t seq)
 	struct dlm_msg *msg;
 	char *ppc;
 
-	msg = dlm_lowcomms_new_msg(nodeid, mb_len, GFP_ATOMIC, &ppc,
-				   NULL, NULL);
+	msg = dlm_lowcomms_new_msg(nodeid, mb_len, &ppc, NULL, NULL);
 	if (!msg)
 		return -ENOMEM;
 
@@ -429,7 +428,7 @@ static int dlm_send_fin(struct midcomms_node *node,
 	struct dlm_mhandle *mh;
 	char *ppc;
 
-	mh = dlm_midcomms_get_mhandle(node->nodeid, mb_len, GFP_ATOMIC, &ppc);
+	mh = dlm_midcomms_get_mhandle(node->nodeid, mb_len, &ppc);
 	if (!mh)
 		return -ENOMEM;
 
@@ -977,13 +976,13 @@ static void midcomms_new_msg_cb(void *data)
 }
 
 static struct dlm_msg *dlm_midcomms_get_msg_3_2(struct dlm_mhandle *mh, int nodeid,
-						int len, gfp_t allocation, char **ppc)
+						int len, char **ppc)
 {
 	struct dlm_opts *opts;
 	struct dlm_msg *msg;
 
 	msg = dlm_lowcomms_new_msg(nodeid, len + DLM_MIDCOMMS_OPT_LEN,
-				   allocation, ppc, midcomms_new_msg_cb, mh);
+				   ppc, midcomms_new_msg_cb, mh);
 	if (!msg)
 		return NULL;
 
@@ -1002,8 +1001,7 @@ static struct dlm_msg *dlm_midcomms_get_msg_3_2(struct dlm_mhandle *mh, int node
  * dlm_midcomms_commit_mhandle which is a must call if success
  */
 #ifndef __CHECKER__
-struct dlm_mhandle *dlm_midcomms_get_mhandle(int nodeid, int len,
-					     gfp_t allocation, char **ppc)
+struct dlm_mhandle *dlm_midcomms_get_mhandle(int nodeid, int len, char **ppc)
 {
 	struct midcomms_node *node;
 	struct dlm_mhandle *mh;
@@ -1018,7 +1016,7 @@ struct dlm_mhandle *dlm_midcomms_get_mhandle(int nodeid, int len,
 	/* this is a bug, however we going on and hope it will be resolved */
 	WARN_ON_ONCE(test_bit(DLM_NODE_FLAG_STOP_TX, &node->flags));
 
-	mh = dlm_allocate_mhandle(allocation);
+	mh = dlm_allocate_mhandle();
 	if (!mh)
 		goto err;
 
@@ -1029,8 +1027,7 @@ struct dlm_mhandle *dlm_midcomms_get_mhandle(int nodeid, int len,
 
 	switch (node->version) {
 	case DLM_VERSION_3_1:
-		msg = dlm_lowcomms_new_msg(nodeid, len, allocation, ppc,
-					   NULL, NULL);
+		msg = dlm_lowcomms_new_msg(nodeid, len, ppc, NULL, NULL);
 		if (!msg) {
 			dlm_free_mhandle(mh);
 			goto err;
@@ -1041,8 +1038,7 @@ struct dlm_mhandle *dlm_midcomms_get_mhandle(int nodeid, int len,
 		/* send ack back if necessary */
 		dlm_send_ack_threshold(node, DLM_SEND_ACK_BACK_MSG_THRESHOLD);
 
-		msg = dlm_midcomms_get_msg_3_2(mh, nodeid, len, allocation,
-					       ppc);
+		msg = dlm_midcomms_get_msg_3_2(mh, nodeid, len, ppc);
 		if (!msg) {
 			dlm_free_mhandle(mh);
 			goto err;
@@ -1502,8 +1498,8 @@ int dlm_midcomms_rawmsg_send(struct midcomms_node *node, void *buf,
 	rd.node = node;
 	rd.buf = buf;
 
-	msg = dlm_lowcomms_new_msg(node->nodeid, buflen, GFP_NOFS,
-				   &msgbuf, midcomms_new_rawmsg_cb, &rd);
+	msg = dlm_lowcomms_new_msg(node->nodeid, buflen, &msgbuf,
+				   midcomms_new_rawmsg_cb, &rd);
 	if (!msg)
 		return -ENOMEM;
 
diff --git a/fs/dlm/midcomms.h b/fs/dlm/midcomms.h
index e7246fb3ef57..278d26fdeb2c 100644
--- a/fs/dlm/midcomms.h
+++ b/fs/dlm/midcomms.h
@@ -16,8 +16,7 @@ struct midcomms_node;
 
 int dlm_validate_incoming_buffer(int nodeid, unsigned char *buf, int len);
 int dlm_process_incoming_buffer(int nodeid, unsigned char *buf, int buflen);
-struct dlm_mhandle *dlm_midcomms_get_mhandle(int nodeid, int len,
-					     gfp_t allocation, char **ppc);
+struct dlm_mhandle *dlm_midcomms_get_mhandle(int nodeid, int len, char **ppc);
 void dlm_midcomms_commit_mhandle(struct dlm_mhandle *mh, const void *name,
 				 int namelen);
 int dlm_midcomms_addr(int nodeid, struct sockaddr_storage *addr, int len);
diff --git a/fs/dlm/rcom.c b/fs/dlm/rcom.c
index 3b734aed26b5..2e3f529f3ff2 100644
--- a/fs/dlm/rcom.c
+++ b/fs/dlm/rcom.c
@@ -55,7 +55,7 @@ static int create_rcom(struct dlm_ls *ls, int to_nodeid, int type, int len,
 	struct dlm_mhandle *mh;
 	char *mb;
 
-	mh = dlm_midcomms_get_mhandle(to_nodeid, mb_len, GFP_NOFS, &mb);
+	mh = dlm_midcomms_get_mhandle(to_nodeid, mb_len, &mb);
 	if (!mh) {
 		log_print("%s to %d type %d len %d ENOBUFS",
 			  __func__, to_nodeid, type, len);
@@ -75,8 +75,7 @@ static int create_rcom_stateless(struct dlm_ls *ls, int to_nodeid, int type,
 	struct dlm_msg *msg;
 	char *mb;
 
-	msg = dlm_lowcomms_new_msg(to_nodeid, mb_len, GFP_NOFS, &mb,
-				   NULL, NULL);
+	msg = dlm_lowcomms_new_msg(to_nodeid, mb_len, &mb, NULL, NULL);
 	if (!msg) {
 		log_print("create_rcom to %d type %d len %d ENOBUFS",
 			  to_nodeid, type, len);
@@ -510,7 +509,7 @@ int dlm_send_ls_not_ready(int nodeid, const struct dlm_rcom *rc_in)
 	char *mb;
 	int mb_len = sizeof(struct dlm_rcom) + sizeof(struct rcom_config);
 
-	mh = dlm_midcomms_get_mhandle(nodeid, mb_len, GFP_NOFS, &mb);
+	mh = dlm_midcomms_get_mhandle(nodeid, mb_len, &mb);
 	if (!mh)
 		return -ENOBUFS;
 
-- 
2.39.3

