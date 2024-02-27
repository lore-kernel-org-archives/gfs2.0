Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E830D6AA1
	for <gfs2@lists.linux.dev>; Tue, 27 Feb 2024 01:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708998564; cv=none; b=hhRAd0Vejapwp6ehloU1YD6XZgghFOpWgP/lEC7OnoAY8qp49kkO2Rz4PpJHFhy+NoxJQGSgTn4oP/7mInHoxT3egXc60tdp6O2Z/Ms/yl5eHvpXo05jsRUbPryzDN8eyX6H/0NehLaSEq6xtmCAB4JWupp7iRqkH7uC8M5kgHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708998564; c=relaxed/simple;
	bh=c8nZeyKlLsuXm37o9DgkGKqW+TO10B8xouiw+AH+G5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c+ZHXCAExgAD+Ncw8vcprK/yWjnBw6QJi2Ksq3sBHT6JAiGXI9Jb63oVF1S4c2XuadZEOSMxgyKM9fjgM0TAUOvNJELmMTcR/s5Dfzg0amAcFQluzAus6LXjooMzB1sqVzraTJvHImR5zrBU9ZHbHXeAEipqSQWB5x27ppt5ZPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dn4tYEl0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dn4tYEl0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708998561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rBVi39Cqy3tjgzbZxElOT7BhTmV8OCH0UcriDXw2Gyk=;
	b=Dn4tYEl0pcjF6SpTXiBMvUIQsvPDQZh4KdbmYM5FKOERN8GhXZeWa4BreBsJ377SnXzpfS
	17Svw/OCPDgir8CzlWuvRXTohfCZCiCSakg5MYFqrLOL/OuYhvynoG1r/ZZQsehqCcde21
	7wKDq6eAQFRnifBc1wKC9CWrdv3gmuw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-_bAavgAGO9SeCN6M5mxATQ-1; Mon, 26 Feb 2024 20:49:19 -0500
X-MC-Unique: _bAavgAGO9SeCN6M5mxATQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4A481108C067
	for <gfs2@lists.linux.dev>; Tue, 27 Feb 2024 01:49:19 +0000 (UTC)
Received: from fs-i40c-03.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.fast.eng.rdu2.dc.redhat.com [10.6.23.54])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 401642166AF3;
	Tue, 27 Feb 2024 01:49:19 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCHv3 v6.8-rc6 10/18] dlm: implement directory dump context
Date: Mon, 26 Feb 2024 20:49:01 -0500
Message-ID: <20240227014909.93945-11-aahringo@redhat.com>
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

This patch introduce to keep track of an directory dump in DLM. For now
we only add more sanity checks if e.g. the recovery sequence number has
been changed while dumping the directory. Another change is that we can
keep track of a per nodeid directory dump that can be later being used
to add log messages about how much entries in how many chunks was being
sent to a specific nodeid.

That the whole dump depends on the recovery barrier, because the
resource list is not manipulated during this time may later being
improved. For now we add more sanity checks in the recovery low path to
confirm there is no issue with the current behaviour e.g. it also checks
if the same list entry was being returned from the last resource lookup
vs last resource list entry.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/dir.c          | 115 ++++++++++++++++++++++++++++++++++++++++--
 fs/dlm/dlm_internal.h |   4 +-
 fs/dlm/lockspace.c    |   2 +
 fs/dlm/recoverd.c     |   5 --
 4 files changed, 116 insertions(+), 10 deletions(-)

diff --git a/fs/dlm/dir.c b/fs/dlm/dir.c
index 3da00c46cbb3..0dc8a1d9e411 100644
--- a/fs/dlm/dir.c
+++ b/fs/dlm/dir.c
@@ -224,6 +224,80 @@ static struct dlm_rsb *find_rsb_root(struct dlm_ls *ls, const char *name,
 	return NULL;
 }
 
+struct dlm_dir_dump {
+	/* init values to match if whole
+	 * dump fits to one seq. Sanity check only.
+	 */
+	uint64_t seq_init;
+	uint64_t nodeid_init;
+	/* compare local pointer with last lookup,
+	 * just a sanity check.
+	 */
+	struct list_head *last;
+
+	unsigned int sent_res; /* for log info */
+	unsigned int sent_msg; /* for log info */
+
+	struct list_head list;
+};
+
+static void drop_dir_ctx(struct dlm_ls *ls, int nodeid)
+{
+	struct dlm_dir_dump *dd, *safe;
+
+	write_lock(&ls->ls_dir_dump_lock);
+	list_for_each_entry_safe(dd, safe, &ls->ls_dir_dump_list, list) {
+		if (dd->nodeid_init == nodeid) {
+			log_error(ls, "drop dump seq %llu",
+				 (unsigned long long)dd->seq_init);
+			list_del(&dd->list);
+			kfree(dd);
+		}
+	}
+	write_unlock(&ls->ls_dir_dump_lock);
+}
+
+static struct dlm_dir_dump *lookup_dir_dump(struct dlm_ls *ls, int nodeid)
+{
+	struct dlm_dir_dump *iter, *dd = NULL;
+
+	read_lock(&ls->ls_dir_dump_lock);
+	list_for_each_entry(iter, &ls->ls_dir_dump_list, list) {
+		if (iter->nodeid_init == nodeid) {
+			dd = iter;
+			break;
+		}
+	}
+	read_unlock(&ls->ls_dir_dump_lock);
+
+	return dd;
+}
+
+static struct dlm_dir_dump *init_dir_dump(struct dlm_ls *ls, int nodeid)
+{
+	struct dlm_dir_dump *dd;
+
+	dd = lookup_dir_dump(ls, nodeid);
+	if (dd) {
+		log_error(ls, "found ongoing dir dump for node %d, will drop it",
+			  nodeid);
+		drop_dir_ctx(ls, nodeid);
+	}
+
+	dd = kzalloc(sizeof(*dd), GFP_ATOMIC);
+	if (!dd)
+		return NULL;
+
+	dd->seq_init = ls->ls_recover_seq;
+	dd->nodeid_init = nodeid;
+
+	write_lock(&ls->ls_dir_dump_lock);
+	list_add(&dd->list, &ls->ls_dir_dump_list);
+	write_unlock(&ls->ls_dir_dump_lock);
+
+	return dd;
+}
+
 /* Find the rsb where we left off (or start again), then send rsb names
    for rsb's we're master of and whose directory node matches the requesting
    node.  inbuf is the rsb name last sent, inlen is the name's length */
@@ -234,11 +308,20 @@ void dlm_copy_master_names(struct dlm_ls *ls, const char *inbuf, int inlen,
 	struct list_head *list;
 	struct dlm_rsb *r;
 	int offset = 0, dir_nodeid;
+	struct dlm_dir_dump *dd;
 	__be16 be_namelen;
 
 	read_lock(&ls->ls_masters_lock);
 
 	if (inlen > 1) {
+		dd = lookup_dir_dump(ls, nodeid);
+		if (!dd) {
+			log_error(ls, "failed to lookup dir dump context nodeid: %d",
+				  nodeid);
+			goto out;
+		}
+
+		/* next chunk in dump */
 		r = find_rsb_root(ls, inbuf, inlen);
 		if (!r) {
 			log_error(ls, "copy_master_names from %d start %d %.*s",
@@ -246,8 +329,25 @@ void dlm_copy_master_names(struct dlm_ls *ls, const char *inbuf, int inlen,
 			goto out;
 		}
 		list = r->res_masters_list.next;
+
+		/* sanity checks */
+		if (dd->last != &r->res_masters_list ||
+		    dd->seq_init != ls->ls_recover_seq) {
+			log_error(ls, "failed dir dump sanity check seq_init: %llu seq: %llu",
+				  (unsigned long long)dd->seq_init,
+				  (unsigned long long)ls->ls_recover_seq);
+			goto out;
+		}
 	} else {
+		dd = init_dir_dump(ls, nodeid);
+		if (!dd) {
+			log_error(ls, "failed to allocate dir dump context");
+			goto out;
+		}
+
+		/* start dump */
 		list = ls->ls_masters_list.next;
+		dd->last = list;
 	}
 
 	for (offset = 0; list != &ls->ls_masters_list; list = list->next) {
@@ -269,7 +369,7 @@ void dlm_copy_master_names(struct dlm_ls *ls, const char *inbuf, int inlen,
 			be_namelen = cpu_to_be16(0);
 			memcpy(outbuf + offset, &be_namelen, sizeof(__be16));
 			offset += sizeof(__be16);
-			ls->ls_recover_dir_sent_msg++;
+			dd->sent_msg++;
 			goto out;
 		}
 
@@ -278,7 +378,8 @@ void dlm_copy_master_names(struct dlm_ls *ls, const char *inbuf, int inlen,
 		offset += sizeof(__be16);
 		memcpy(outbuf + offset, r->res_name, r->res_length);
 		offset += r->res_length;
-		ls->ls_recover_dir_sent_res++;
+		dd->sent_res++;
+		dd->last = list;
 	}
 
 	/*
@@ -288,10 +389,18 @@ void dlm_copy_master_names(struct dlm_ls *ls, const char *inbuf, int inlen,
 
 	if ((list == &ls->ls_masters_list) &&
 	    (offset + sizeof(uint16_t) <= outlen)) {
+		/* end dump */
 		be_namelen = cpu_to_be16(0xFFFF);
 		memcpy(outbuf + offset, &be_namelen, sizeof(__be16));
 		offset += sizeof(__be16);
-		ls->ls_recover_dir_sent_msg++;
+		dd->sent_msg++;
+		log_rinfo(ls, "dlm_recover_directory nodeid %d sent %u res out %u messages",
+			  nodeid, dd->sent_res, dd->sent_msg);
+
+		write_lock(&ls->ls_dir_dump_lock);
+		list_del_init(&dd->list);
+		write_unlock(&ls->ls_dir_dump_lock);
+		kfree(dd);
 	}
  out:
 	read_unlock(&ls->ls_masters_lock);
diff --git a/fs/dlm/dlm_internal.h b/fs/dlm/dlm_internal.h
index 959f69fb2a52..9aa1e3a09e02 100644
--- a/fs/dlm/dlm_internal.h
+++ b/fs/dlm/dlm_internal.h
@@ -630,8 +630,6 @@ struct dlm_ls {
 	struct mutex		ls_requestqueue_mutex;
 	struct dlm_rcom		*ls_recover_buf;
 	int			ls_recover_nodeid; /* for debugging */
-	unsigned int		ls_recover_dir_sent_res; /* for log info */
-	unsigned int		ls_recover_dir_sent_msg; /* for log info */
 	unsigned int		ls_recover_locks_in; /* for log info */
 	uint64_t		ls_rcom_seq;
 	spinlock_t		ls_rcom_spin;
@@ -646,6 +644,8 @@ struct dlm_ls {
 
 	struct list_head	ls_masters_list; /* root resources */
 	rwlock_t		ls_masters_lock; /* protect root_list */
+	struct list_head	ls_dir_dump_list; /* root resources */
+	rwlock_t		ls_dir_dump_lock; /* protect root_list */
 
 	const struct dlm_lockspace_ops *ls_ops;
 	void			*ls_ops_arg;
diff --git a/fs/dlm/lockspace.c b/fs/dlm/lockspace.c
index 388358aafed4..5fe00bd1164d 100644
--- a/fs/dlm/lockspace.c
+++ b/fs/dlm/lockspace.c
@@ -582,6 +582,8 @@ static int new_lockspace(const char *name, const char *cluster,
 	init_waitqueue_head(&ls->ls_wait_general);
 	INIT_LIST_HEAD(&ls->ls_masters_list);
 	rwlock_init(&ls->ls_masters_lock);
+	INIT_LIST_HEAD(&ls->ls_dir_dump_list);
+	rwlock_init(&ls->ls_dir_dump_lock);
 
 	spin_lock(&lslist_lock);
 	ls->ls_create_count = 1;
diff --git a/fs/dlm/recoverd.c b/fs/dlm/recoverd.c
index e5649201ba23..5388db89e22f 100644
--- a/fs/dlm/recoverd.c
+++ b/fs/dlm/recoverd.c
@@ -173,8 +173,6 @@ static int ls_recover(struct dlm_ls *ls, struct dlm_recover *rv)
 		goto fail;
 	}
 
-	ls->ls_recover_dir_sent_res = 0;
-	ls->ls_recover_dir_sent_msg = 0;
 	ls->ls_recover_locks_in = 0;
 
 	dlm_set_recover_status(ls, DLM_RS_NODES);
@@ -211,9 +209,6 @@ static int ls_recover(struct dlm_ls *ls, struct dlm_recover *rv)
 
 	dlm_release_masters_list(ls);
 
-	log_rinfo(ls, "dlm_recover_directory %u out %u messages",
-		  ls->ls_recover_dir_sent_res, ls->ls_recover_dir_sent_msg);
-
 	/*
 	 * We may have outstanding operations that are waiting for a reply from
 	 * a failed node.  Mark these to be resent after recovery.  Unlock and
-- 
2.43.0

