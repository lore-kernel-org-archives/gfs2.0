Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A6013D24D
	for <gfs2@lists.linux.dev>; Wed, 13 Nov 2024 16:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731516416; cv=none; b=lEAdRbilDwSQnFsLzJIERMeyreEcEJt8nWFPcke9cNzLR41rPF8b/J1YYvH83SVDsLup6R3IzqQPGDDXfd8bAZnW5zlppxUVel56KnoOIo4Yvxsi9Kc5tRyiw6vvGWwy8tYwrEddDXQXc8y/92O+gpncO7nFUhuGNgnY/JxYvWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731516416; c=relaxed/simple;
	bh=hrmuUQbajqCFMoDBytMe48Cgj8puvANJh7qu9pTMWGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uNPwk1ZObMOUJrZxHRlpKVf8RVKoLszZgZP82Ve5BWN31noaVJxSZ7g7nP4nBnX6FS3EEepHMpDyCIwALjhS6mEjdPRcm2h8aNM5rDWvpv+M/RRTeeRWf/DnXy3h1pKITLCQi+NCJyBXH5pHuH4bbyv4VGMYrCSD4GN1Jdp3keE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z6APue7T; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z6APue7T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731516413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gwaSIykDtBspAScx1xKEgxWmh2uFOfrhbsESl0UdB7s=;
	b=Z6APue7TOlEQMK+VxDDEI2TzWDPZ5LgZEHSQMWtbJSZGUvfg6oMGcCXq/dG4EcxltCTGV9
	xbetpb2zAS/YHuwDV7v8csZC3czmGvbSpCMFGa7aQ9GNmjgFKt3qjqBa7KLMgtA+CJDH+h
	Fz9pPkWYJXHsBZHDgR2TYbJqfuKswMY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-83-t74ziw_yNT24ZPcjYObWUw-1; Wed,
 13 Nov 2024 11:46:52 -0500
X-MC-Unique: t74ziw_yNT24ZPcjYObWUw-1
X-Mimecast-MFC-AGG-ID: t74ziw_yNT24ZPcjYObWUw
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DC1C5195608B
	for <gfs2@lists.linux.dev>; Wed, 13 Nov 2024 16:46:51 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 364601956054;
	Wed, 13 Nov 2024 16:46:51 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCH dlm/next 3/5] dlm: extend debugfs to manipulate more DLM states
Date: Wed, 13 Nov 2024 11:46:41 -0500
Message-ID: <20241113164643.464055-3-aahringo@redhat.com>
In-Reply-To: <20241113164643.464055-1-aahringo@redhat.com>
References: <20241113164643.464055-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: iVe62BGC79fbGSJsIJFhsxxoXWmyWygX8bZF0zdkEXo_1731516412
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

To reproduce more issues with the DLM recovery by using the DLM debugfs
developer backdoor to force manipulating the DLM lkb/rsb states.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/debug_fs.c     | 16 +++++++++-------
 fs/dlm/dlm_internal.h |  6 ++++++
 fs/dlm/lock.c         | 43 +++++++++++++++++++++++++++++++++++++++----
 fs/dlm/lock.h         |  4 +++-
 4 files changed, 57 insertions(+), 12 deletions(-)

diff --git a/fs/dlm/debug_fs.c b/fs/dlm/debug_fs.c
index 49ad31120286..54ad11e1cd2c 100644
--- a/fs/dlm/debug_fs.c
+++ b/fs/dlm/debug_fs.c
@@ -502,11 +502,11 @@ static int table_open2(struct inode *inode, struct file *file)
 static ssize_t table_write2(struct file *file, const char __user *user_buf,
 			    size_t count, loff_t *ppos)
 {
+	int n, len, lkb_status, error, from_nodeid, dir_nodeid, master_nodeid, rqmode, grmode;
 	struct seq_file *seq = file->private_data;
-	int n, len, lkb_nodeid, lkb_status, error;
 	char name[DLM_RESNAME_MAXLEN + 1] = {};
+	unsigned int lkb_dflags, lkb_iflags;
 	struct dlm_ls *ls = seq->private;
-	unsigned int lkb_flags;
 	char buf[256] = {};
 	uint32_t lkb_id;
 
@@ -514,14 +514,16 @@ static ssize_t table_write2(struct file *file, const char __user *user_buf,
 			   min_t(size_t, sizeof(buf) - 1, count)))
 		return -EFAULT;
 
-	n = sscanf(buf, "%x %" __stringify(DLM_RESNAME_MAXLEN) "s %x %d %d",
-		   &lkb_id, name, &lkb_flags, &lkb_nodeid, &lkb_status);
-	if (n != 5)
+	n = sscanf(buf, "%x %" __stringify(DLM_RESNAME_MAXLEN) "s %x %x %d %d %d %d %d %d",
+		   &lkb_id, name, &lkb_iflags, &lkb_dflags, &lkb_status, &from_nodeid,
+		   &dir_nodeid, &master_nodeid, &rqmode, &grmode);
+	if (n != 10)
 		return -EINVAL;
 
 	len = strnlen(name, DLM_RESNAME_MAXLEN);
-	error = dlm_debug_add_lkb(ls, lkb_id, name, len, lkb_flags,
-				  lkb_nodeid, lkb_status);
+	error = dlm_debug_add_lkb(ls, lkb_id, name, len, lkb_iflags, lkb_dflags,
+				  lkb_status, from_nodeid, dir_nodeid,
+				  master_nodeid, rqmode, grmode);
 	if (error)
 		return error;
 
diff --git a/fs/dlm/dlm_internal.h b/fs/dlm/dlm_internal.h
index d534a4bc162b..6ee6179e16a8 100644
--- a/fs/dlm/dlm_internal.h
+++ b/fs/dlm/dlm_internal.h
@@ -794,6 +794,12 @@ static inline void dlm_set_flags_val(unsigned long *addr, uint32_t val,
 	}
 }
 
+static inline void dlm_set_iflags_val(struct dlm_lkb *lkb, uint32_t val)
+{
+	dlm_set_flags_val(&lkb->lkb_iflags, val, __DLM_IFL_MIN_BIT,
+			  __DLM_IFL_MAX_BIT);
+}
+
 static inline void dlm_set_dflags_val(struct dlm_lkb *lkb, uint32_t val)
 {
 	dlm_set_flags_val(&lkb->lkb_dflags, val, __DLM_DFL_MIN_BIT,
diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index 966a926c301b..4219e0025fa2 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -6271,10 +6271,30 @@ int dlm_user_purge(struct dlm_ls *ls, struct dlm_user_proc *proc,
 	return error;
 }
 
+static void debug_bastfn(void *astparam, int mode)
+{
+	const struct dlm_lkb *lkb = astparam;
+
+	log_print("%s: lkb_id 0x%x mode %u", __func__, lkb->lkb_id, mode);
+}
+
+static void debug_astfn(void *astparam)
+{
+	const struct dlm_lkb *lkb = astparam;
+	const struct dlm_lksb *lksb;
+
+	lksb = lkb->lkb_lksb;
+
+	log_print("%s: lkb_id 0x%x status %d", __func__, lkb->lkb_id, lksb->sb_status);
+}
+
 /* debug functionality */
 int dlm_debug_add_lkb(struct dlm_ls *ls, uint32_t lkb_id, char *name, int len,
-		      int lkb_nodeid, unsigned int lkb_dflags, int lkb_status)
+		      unsigned int lkb_iflags, unsigned int lkb_dflags,
+		      int lkb_status, int from_nodeid, int dir_nodeid,
+		      int master_nodeid, int rqmode, int grmode)
 {
+	int our_nodeid = dlm_our_nodeid();
 	struct dlm_lksb *lksb;
 	struct dlm_lkb *lkb;
 	struct dlm_rsb *r;
@@ -6294,14 +6314,18 @@ int dlm_debug_add_lkb(struct dlm_ls *ls, uint32_t lkb_id, char *name, int len,
 		return error;
 	}
 
+	dlm_set_iflags_val(lkb, lkb_iflags);
 	dlm_set_dflags_val(lkb, lkb_dflags);
-	lkb->lkb_nodeid = lkb_nodeid;
 	lkb->lkb_lksb = lksb;
+	lkb->lkb_rqmode = rqmode;
+	lkb->lkb_grmode = grmode;
+	lkb->lkb_astfn = debug_astfn;
+	lkb->lkb_bastfn = debug_bastfn;
 	/* user specific pointer, just don't have it NULL for kernel locks */
 	if (~lkb_dflags & BIT(DLM_DFL_USER_BIT))
-		lkb->lkb_astparam = (void *)0xDEADBEEF;
+		lkb->lkb_astparam = lkb;
 
-	error = find_rsb(ls, name, len, 0, R_REQUEST, &r);
+	error = find_rsb(ls, name, len, from_nodeid, R_REQUEST, &r);
 	if (error) {
 		kfree(lksb);
 		__put_lkb(ls, lkb);
@@ -6309,6 +6333,17 @@ int dlm_debug_add_lkb(struct dlm_ls *ls, uint32_t lkb_id, char *name, int len,
 	}
 
 	lock_rsb(r);
+	if (dir_nodeid)
+		r->res_dir_nodeid = dir_nodeid;
+
+	r->res_master_nodeid = master_nodeid;
+	/* stupid second meaning of res_master_nodeid */
+	if (master_nodeid == our_nodeid)
+		r->res_nodeid = 0;
+	else
+		r->res_nodeid = master_nodeid;
+	lkb->lkb_nodeid = r->res_nodeid;
+
 	attach_lkb(r, lkb);
 	add_lkb(r, lkb, lkb_status);
 	unlock_rsb(r);
diff --git a/fs/dlm/lock.h b/fs/dlm/lock.h
index b23d7b854ed4..66ba9688f9c4 100644
--- a/fs/dlm/lock.h
+++ b/fs/dlm/lock.h
@@ -60,7 +60,9 @@ int dlm_user_purge(struct dlm_ls *ls, struct dlm_user_proc *proc,
 int dlm_user_deadlock(struct dlm_ls *ls, uint32_t flags, uint32_t lkid);
 void dlm_clear_proc_locks(struct dlm_ls *ls, struct dlm_user_proc *proc);
 int dlm_debug_add_lkb(struct dlm_ls *ls, uint32_t lkb_id, char *name, int len,
-		      int lkb_nodeid, unsigned int lkb_flags, int lkb_status);
+		      unsigned int lkb_iflags, unsigned int lkb_dflags,
+		      int lkb_status, int from_nodeid, int dir_nodeid,
+		      int master_nodeid, int rqmode, int grmode);
 int dlm_debug_add_lkb_to_waiters(struct dlm_ls *ls, uint32_t lkb_id,
 				 int mstype, int to_nodeid);
 
-- 
2.43.0

