Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430BD130AF5
	for <gfs2@lists.linux.dev>; Thu, 28 Mar 2024 15:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711640929; cv=none; b=iNS4tFsHktaHi2he8uW2C/jk03hv9aGzTfWsZOkwIMyjjHSeqRGo2mV+UXKYs+sEM6CO4y4lt7achiXm8nz+SrFYScxks0F9wuxkLvDTgT6E/uSSL5w63NEnyvXKIEsxY64d+XU6wnbFUbyhuJGZVZMwzSYnt0aRX6d8YMQuwiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711640929; c=relaxed/simple;
	bh=iY+tvYDypugrKn/rMvbi3QwGMjKB7gSsO8KCugPVWAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GEG2NKmgLP8TIKfE7sc6S1+k1iLumB4qzANRb34L+GkC94CGFlO8YZbeCXXHnk7goe5Y3yhuJt1kP4KsNxUJvmv4L/Z4YVp5tVoig9IwJNyBd8GQVYnvQVDvY9OfoeE6Kr9tF7oNBGDRJmKhikRT0dlztqqGlpswvrM2aQ2tDxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LNf68gxf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LNf68gxf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711640927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nI0VdpBPWStoWFvEDQ3e69uNZlmt34zGfGbseasVcXQ=;
	b=LNf68gxf002Dw8bo5or/wkQwC6FIygs/vvnECbl3OT8OUB7KlGusbD4q/KDjMs2wQi9sQe
	qHADws+0LMP82udoq8eAoUBEfur2HpfUJVDBrKSv54xi1jC2EWyH5TjV+tRLHqIzRy20SS
	Ch1PqXkHAoyjADRoVw/au/PUT1kldwg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-SosdqctaNxq01FYRWtUQwQ-1; Thu, 28 Mar 2024 11:48:44 -0400
X-MC-Unique: SosdqctaNxq01FYRWtUQwQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AEC7A101A526
	for <gfs2@lists.linux.dev>; Thu, 28 Mar 2024 15:48:43 +0000 (UTC)
Received: from fs-i40c-03.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A684FC04120;
	Thu, 28 Mar 2024 15:48:43 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev
Subject: [PATCH v6.9-rc1 05/10] dlm: remove lkb from ast bast tracepoints
Date: Thu, 28 Mar 2024 11:48:37 -0400
Message-ID: <20240328154842.1099288-5-aahringo@redhat.com>
In-Reply-To: <20240328154842.1099288-1-aahringo@redhat.com>
References: <20240328154842.1099288-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

This patch removes the lkb dependency from the ast and bast DLM
tracepoints to prepare to not hold a lkb reference when an ast or bast
is queued to be called. There is also no need to check if the
lkb_resource is set because it should always be the case in such
context.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/ast.c               |  9 ++++++--
 fs/dlm/user.c              |  9 ++++++--
 include/trace/events/dlm.h | 46 ++++++++++++++++----------------------
 3 files changed, 33 insertions(+), 31 deletions(-)

diff --git a/fs/dlm/ast.c b/fs/dlm/ast.c
index decedc4ee15f..dd7cca3c1472 100644
--- a/fs/dlm/ast.c
+++ b/fs/dlm/ast.c
@@ -171,6 +171,7 @@ void dlm_callback_work(struct work_struct *work)
 {
 	struct dlm_lkb *lkb = container_of(work, struct dlm_lkb, lkb_cb_work);
 	struct dlm_ls *ls = lkb->lkb_resource->res_ls;
+	struct dlm_rsb *rsb = lkb->lkb_resource;
 	void (*castfn) (void *astparam);
 	void (*bastfn) (void *astparam, int mode);
 	struct dlm_callback *cb;
@@ -190,14 +191,18 @@ void dlm_callback_work(struct work_struct *work)
 		bastfn = lkb->lkb_bastfn;
 
 		if (cb->flags & DLM_CB_BAST) {
-			trace_dlm_bast(ls, lkb, cb->mode);
+			trace_dlm_bast(ls->ls_global_id, lkb->lkb_id,
+				       cb->mode, rsb->res_name,
+				       rsb->res_length);
 			lkb->lkb_last_bast_time = ktime_get();
 			lkb->lkb_last_bast_mode = cb->mode;
 			bastfn(lkb->lkb_astparam, cb->mode);
 		} else if (cb->flags & DLM_CB_CAST) {
 			lkb->lkb_lksb->sb_status = cb->sb_status;
 			lkb->lkb_lksb->sb_flags = cb->sb_flags;
-			trace_dlm_ast(ls, lkb);
+			trace_dlm_ast(ls->ls_global_id, lkb->lkb_id,
+				      cb->sb_flags, cb->sb_status,
+				      rsb->res_name, rsb->res_length);
 			lkb->lkb_last_cast_time = ktime_get();
 			castfn(lkb->lkb_astparam);
 		}
diff --git a/fs/dlm/user.c b/fs/dlm/user.c
index 12a483deeef5..6f99bbeeac9b 100644
--- a/fs/dlm/user.c
+++ b/fs/dlm/user.c
@@ -805,6 +805,7 @@ static ssize_t device_read(struct file *file, char __user *buf, size_t count,
 	struct dlm_lkb *lkb;
 	DECLARE_WAITQUEUE(wait, current);
 	struct dlm_callback *cb;
+	struct dlm_rsb *rsb;
 	int rv, ret;
 
 	if (count == sizeof(struct dlm_device_version)) {
@@ -887,12 +888,16 @@ static ssize_t device_read(struct file *file, char __user *buf, size_t count,
 	}
 	spin_unlock(&proc->asts_spin);
 
+	rsb = lkb->lkb_resource;
 	if (cb->flags & DLM_CB_BAST) {
-		trace_dlm_bast(lkb->lkb_resource->res_ls, lkb, cb->mode);
+		trace_dlm_bast(rsb->res_ls->ls_global_id, lkb->lkb_id,
+			       cb->mode, rsb->res_name, rsb->res_length);
 	} else if (cb->flags & DLM_CB_CAST) {
 		lkb->lkb_lksb->sb_status = cb->sb_status;
 		lkb->lkb_lksb->sb_flags = cb->sb_flags;
-		trace_dlm_ast(lkb->lkb_resource->res_ls, lkb);
+		trace_dlm_ast(rsb->res_ls->ls_global_id, lkb->lkb_id,
+			      cb->sb_flags, cb->sb_status, rsb->res_name,
+			      rsb->res_length);
 	}
 
 	ret = copy_result_to_user(lkb->lkb_ua,
diff --git a/include/trace/events/dlm.h b/include/trace/events/dlm.h
index c1a146f9fc91..af160082c9e3 100644
--- a/include/trace/events/dlm.h
+++ b/include/trace/events/dlm.h
@@ -189,29 +189,25 @@ TRACE_EVENT(dlm_lock_end,
 
 TRACE_EVENT(dlm_bast,
 
-	TP_PROTO(struct dlm_ls *ls, struct dlm_lkb *lkb, int mode),
+	TP_PROTO(__u32 ls_id, __u32 lkb_id, int mode,
+		 const char *res_name, size_t res_length),
 
-	TP_ARGS(ls, lkb, mode),
+	TP_ARGS(ls_id, lkb_id, mode, res_name, res_length),
 
 	TP_STRUCT__entry(
 		__field(__u32, ls_id)
 		__field(__u32, lkb_id)
 		__field(int, mode)
-		__dynamic_array(unsigned char, res_name,
-				lkb->lkb_resource ? lkb->lkb_resource->res_length : 0)
+		__dynamic_array(unsigned char, res_name, res_length)
 	),
 
 	TP_fast_assign(
-		struct dlm_rsb *r;
-
-		__entry->ls_id = ls->ls_global_id;
-		__entry->lkb_id = lkb->lkb_id;
+		__entry->ls_id = ls_id;
+		__entry->lkb_id = lkb_id;
 		__entry->mode = mode;
 
-		r = lkb->lkb_resource;
-		if (r)
-			memcpy(__get_dynamic_array(res_name), r->res_name,
-			       __get_dynamic_array_len(res_name));
+		memcpy(__get_dynamic_array(res_name), res_name,
+		       __get_dynamic_array_len(res_name));
 	),
 
 	TP_printk("ls_id=%u lkb_id=%x mode=%s res_name=%s",
@@ -224,31 +220,27 @@ TRACE_EVENT(dlm_bast,
 
 TRACE_EVENT(dlm_ast,
 
-	TP_PROTO(struct dlm_ls *ls, struct dlm_lkb *lkb),
+	TP_PROTO(__u32 ls_id, __u32 lkb_id, __u8 sb_flags, int sb_status,
+		 const char *res_name, size_t res_length),
 
-	TP_ARGS(ls, lkb),
+	TP_ARGS(ls_id, lkb_id, sb_flags, sb_status, res_name, res_length),
 
 	TP_STRUCT__entry(
 		__field(__u32, ls_id)
 		__field(__u32, lkb_id)
-		__field(u8, sb_flags)
+		__field(__u8, sb_flags)
 		__field(int, sb_status)
-		__dynamic_array(unsigned char, res_name,
-				lkb->lkb_resource ? lkb->lkb_resource->res_length : 0)
+		__dynamic_array(unsigned char, res_name, res_length)
 	),
 
 	TP_fast_assign(
-		struct dlm_rsb *r;
-
-		__entry->ls_id = ls->ls_global_id;
-		__entry->lkb_id = lkb->lkb_id;
-		__entry->sb_flags = lkb->lkb_lksb->sb_flags;
-		__entry->sb_status = lkb->lkb_lksb->sb_status;
+		__entry->ls_id = ls_id;
+		__entry->lkb_id = lkb_id;
+		__entry->sb_flags = sb_flags;
+		__entry->sb_status = sb_status;
 
-		r = lkb->lkb_resource;
-		if (r)
-			memcpy(__get_dynamic_array(res_name), r->res_name,
-			       __get_dynamic_array_len(res_name));
+		memcpy(__get_dynamic_array(res_name), res_name,
+		       __get_dynamic_array_len(res_name));
 	),
 
 	TP_printk("ls_id=%u lkb_id=%x sb_flags=%s sb_status=%d res_name=%s",
-- 
2.43.0

