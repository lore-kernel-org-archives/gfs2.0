Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F174517BB5
	for <gfs2@lists.linux.dev>; Tue, 27 Feb 2024 01:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708998565; cv=none; b=Lt1XORIu51ReNZfHL8vSvrpi9IJ8L4xBUA5rQortKn8IceAgfg1W3rOTE5EwgWMi/1h2JMHZWWyjcVudezBerTmndelwYDwu5q3noMRiw/yEHNHlrKZCmHepcBtR5z0r/H02ZAP16fQi2XdAISyQDyDP3AHmwdv5Idc93c4a9q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708998565; c=relaxed/simple;
	bh=/S+ybNVzL6lqtdrWVXoCbaiNhq8lMHyhlXvsNi/j21A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ohJfJlshUXyxAjWblIPxsnXiWlOnEPd8oIr1kgRg6JwqHPr8ZMecvR+DlIHRTh8fIR5om5J6uaF9l7Wqf8g3mf/QLTfVhpkFXT/S8ypBggdI9P7zEzmBeUBbbNv6ts8VNcRG3PV/rIpgqkqIx17gBdTzILAVzl58HEf+Rz4tsDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JjIVdaA7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JjIVdaA7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708998561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZyCTRYNibJFb6ViljAiQWiMVK6zpuf/FZzf998rXOaQ=;
	b=JjIVdaA7An9Z7IPgLQ06NO+yjcBl0aOnAtTy8db0xwc/gBz6rEl8mHTkTYZ4UffAhKbyiN
	me4xe2WJbmO0D0uPZyh7RKJH2JIovM1i9ULy7ZZRSKAgoCwpkbX4RDYZi4nkkNp01tu90o
	NTSt4Jlb4lcS8twUbSKOjSSVjqkg4mQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-nG-xcpj4M4KaMS8wqoPdwQ-1; Mon, 26 Feb 2024 20:49:19 -0500
X-MC-Unique: nG-xcpj4M4KaMS8wqoPdwQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 361BD88F5A5
	for <gfs2@lists.linux.dev>; Tue, 27 Feb 2024 01:49:19 +0000 (UTC)
Received: from fs-i40c-03.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.fast.eng.rdu2.dc.redhat.com [10.6.23.54])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2C9CF2166B33;
	Tue, 27 Feb 2024 01:49:19 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCHv3 v6.8-rc6 08/18] dlm: move master dir dump to own list
Date: Mon, 26 Feb 2024 20:48:59 -0500
Message-ID: <20240227014909.93945-9-aahringo@redhat.com>
In-Reply-To: <20240227014909.93945-1-aahringo@redhat.com>
References: <20240227014909.93945-1-aahringo@redhat.com>
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

This patch moves the master directory dump, means dlm_rsbs where we are
the master of (res_nodeid == 0), to it's own list handling. Currently
the only mutual access to ls->root_list is due the master directory
dump. Put it into it's own list handling allows us to put the root_list
out of the global per lockspace context and make it lockless. While on
it move the rw semaphore to a rwlock as the context allows it.

Add a comment that we should keep track of our own master rsbs while
locking occurs instead of recovery creates it in a snapshot like mode.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/dir.c          | 22 ++++++---------
 fs/dlm/dlm_internal.h |  3 ++
 fs/dlm/lockspace.c    |  2 ++
 fs/dlm/recoverd.c     | 64 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 77 insertions(+), 14 deletions(-)

diff --git a/fs/dlm/dir.c b/fs/dlm/dir.c
index f6acba4310a7..10753486049a 100644
--- a/fs/dlm/dir.c
+++ b/fs/dlm/dir.c
@@ -216,16 +216,13 @@ static struct dlm_rsb *find_rsb_root(struct dlm_ls *ls, const char *name,
 	if (!rv)
 		return r;
 
-	down_read(&ls->ls_root_sem);
-	list_for_each_entry(r, &ls->ls_root_list, res_root_list) {
+	list_for_each_entry(r, &ls->ls_masters_list, res_masters_list) {
 		if (len == r->res_length && !memcmp(name, r->res_name, len)) {
-			up_read(&ls->ls_root_sem);
 			log_debug(ls, "find_rsb_root revert to root_list %s",
 				  r->res_name);
 			return r;
 		}
 	}
-	up_read(&ls->ls_root_sem);
 	return NULL;
 }
 
@@ -241,7 +238,7 @@ void dlm_copy_master_names(struct dlm_ls *ls, const char *inbuf, int inlen,
 	int offset = 0, dir_nodeid;
 	__be16 be_namelen;
 
-	down_read(&ls->ls_root_sem);
+	read_lock(&ls->ls_masters_lock);
 
 	if (inlen > 1) {
 		r = find_rsb_root(ls, inbuf, inlen);
@@ -250,16 +247,13 @@ void dlm_copy_master_names(struct dlm_ls *ls, const char *inbuf, int inlen,
 				  nodeid, inlen, inlen, inbuf);
 			goto out;
 		}
-		list = r->res_root_list.next;
+		list = r->res_masters_list.next;
 	} else {
-		list = ls->ls_root_list.next;
+		list = ls->ls_masters_list.next;
 	}
 
-	for (offset = 0; list != &ls->ls_root_list; list = list->next) {
-		r = list_entry(list, struct dlm_rsb, res_root_list);
-		if (r->res_nodeid)
-			continue;
-
+	for (offset = 0; list != &ls->ls_masters_list; list = list->next) {
+		r = list_entry(list, struct dlm_rsb, res_masters_list);
 		dir_nodeid = dlm_dir_nodeid(r);
 		if (dir_nodeid != nodeid)
 			continue;
@@ -294,7 +288,7 @@ void dlm_copy_master_names(struct dlm_ls *ls, const char *inbuf, int inlen,
 	 * terminating record.
 	 */
 
-	if ((list == &ls->ls_root_list) &&
+	if ((list == &ls->ls_masters_list) &&
 	    (offset + sizeof(uint16_t) <= outlen)) {
 		be_namelen = cpu_to_be16(0xFFFF);
 		memcpy(outbuf + offset, &be_namelen, sizeof(__be16));
@@ -302,6 +296,6 @@ void dlm_copy_master_names(struct dlm_ls *ls, const char *inbuf, int inlen,
 		ls->ls_recover_dir_sent_msg++;
 	}
  out:
-	up_read(&ls->ls_root_sem);
+	read_unlock(&ls->ls_masters_lock);
 }
 
diff --git a/fs/dlm/dlm_internal.h b/fs/dlm/dlm_internal.h
index dfc444dad329..cb18f383acff 100644
--- a/fs/dlm/dlm_internal.h
+++ b/fs/dlm/dlm_internal.h
@@ -312,6 +312,7 @@ struct dlm_rsb {
 	struct list_head	res_waitqueue;
 
 	struct list_head	res_root_list;	    /* used for recovery */
+	struct list_head	res_masters_list;   /* used for recovery */
 	struct list_head	res_recover_list;   /* used for recovery */
 	int			res_recover_locks_count;
 
@@ -645,6 +646,8 @@ struct dlm_ls {
 
 	struct list_head	ls_root_list;	/* root resources */
 	struct rw_semaphore	ls_root_sem;	/* protect root_list */
+	struct list_head	ls_masters_list;	/* root resources */
+	rwlock_t		ls_masters_lock;	/* protect root_list */
 
 	const struct dlm_lockspace_ops *ls_ops;
 	void			*ls_ops_arg;
diff --git a/fs/dlm/lockspace.c b/fs/dlm/lockspace.c
index c7ab7358422b..977a648485ee 100644
--- a/fs/dlm/lockspace.c
+++ b/fs/dlm/lockspace.c
@@ -582,6 +582,8 @@ static int new_lockspace(const char *name, const char *cluster,
 	init_waitqueue_head(&ls->ls_wait_general);
 	INIT_LIST_HEAD(&ls->ls_root_list);
 	init_rwsem(&ls->ls_root_sem);
+	INIT_LIST_HEAD(&ls->ls_masters_list);
+	rwlock_init(&ls->ls_masters_lock);
 
 	spin_lock(&lslist_lock);
 	ls->ls_create_count = 1;
diff --git a/fs/dlm/recoverd.c b/fs/dlm/recoverd.c
index 8eb42554ccb0..dfce8fc6a783 100644
--- a/fs/dlm/recoverd.c
+++ b/fs/dlm/recoverd.c
@@ -20,6 +20,48 @@
 #include "requestqueue.h"
 #include "recoverd.h"
 
+static int dlm_create_masters_list(struct dlm_ls *ls)
+{
+	struct rb_node *n;
+	struct dlm_rsb *r;
+	int i, error = 0;
+
+	write_lock(&ls->ls_masters_lock);
+	if (!list_empty(&ls->ls_masters_list)) {
+		log_error(ls, "root list not empty");
+		error = -EINVAL;
+		goto out;
+	}
+
+	for (i = 0; i < ls->ls_rsbtbl_size; i++) {
+		spin_lock_bh(&ls->ls_rsbtbl[i].lock);
+		for (n = rb_first(&ls->ls_rsbtbl[i].keep); n; n = rb_next(n)) {
+			r = rb_entry(n, struct dlm_rsb, res_hashnode);
+			if (r->res_nodeid)
+				continue;
+
+			list_add(&r->res_masters_list, &ls->ls_masters_list);
+			dlm_hold_rsb(r);
+		}
+		spin_unlock_bh(&ls->ls_rsbtbl[i].lock);
+	}
+ out:
+	write_unlock(&ls->ls_masters_lock);
+	return error;
+}
+
+static void dlm_release_masters_list(struct dlm_ls *ls)
+{
+	struct dlm_rsb *r, *safe;
+
+	write_lock(&ls->ls_masters_lock);
+	list_for_each_entry_safe(r, safe, &ls->ls_masters_list, res_masters_list) {
+		list_del_init(&r->res_masters_list);
+		dlm_put_rsb(r);
+	}
+	write_unlock(&ls->ls_masters_lock);
+}
+
 static void dlm_create_root_list(struct dlm_ls *ls)
 {
 	struct rb_node *n;
@@ -123,6 +165,23 @@ static int ls_recover(struct dlm_ls *ls, struct dlm_recover *rv)
 
 	dlm_recover_dir_nodeid(ls);
 
+	/* Create a snapshot of all active rsbs were we are the master of.
+	 * During the barrier between dlm_recover_members_wait() and
+	 * dlm_recover_directory() other nodes can dump their necessary
+	 * directory dlm_rsb (r->res_dir_nodeid == nodeid) in rcom
+	 * communication dlm_copy_master_names() handling.
+	 *
+	 * TODO We should create a per lockspace list that contains rsbs
+	 * that we are the master of. Instead of creating this list while
+	 * recovery we keep track of those rsbs while locking handling and
+	 * recovery can use it when necessary.
+	 */
+	error = dlm_create_masters_list(ls);
+	if (error) {
+		log_rinfo(ls, "dlm_create_masters_list error %d", error);
+		goto fail;
+	}
+
 	ls->ls_recover_dir_sent_res = 0;
 	ls->ls_recover_dir_sent_msg = 0;
 	ls->ls_recover_locks_in = 0;
@@ -132,6 +191,7 @@ static int ls_recover(struct dlm_ls *ls, struct dlm_recover *rv)
 	error = dlm_recover_members_wait(ls, rv->seq);
 	if (error) {
 		log_rinfo(ls, "dlm_recover_members_wait error %d", error);
+		dlm_release_masters_list(ls);
 		goto fail;
 	}
 
@@ -145,6 +205,7 @@ static int ls_recover(struct dlm_ls *ls, struct dlm_recover *rv)
 	error = dlm_recover_directory(ls, rv->seq);
 	if (error) {
 		log_rinfo(ls, "dlm_recover_directory error %d", error);
+		dlm_release_masters_list(ls);
 		goto fail;
 	}
 
@@ -153,9 +214,12 @@ static int ls_recover(struct dlm_ls *ls, struct dlm_recover *rv)
 	error = dlm_recover_directory_wait(ls, rv->seq);
 	if (error) {
 		log_rinfo(ls, "dlm_recover_directory_wait error %d", error);
+		dlm_release_masters_list(ls);
 		goto fail;
 	}
 
+	dlm_release_masters_list(ls);
+
 	log_rinfo(ls, "dlm_recover_directory %u out %u messages",
 		  ls->ls_recover_dir_sent_res, ls->ls_recover_dir_sent_msg);
 
-- 
2.43.0

