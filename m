Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E19134A0
	for <gfs2@lists.linux.dev>; Sun, 19 Nov 2023 16:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T4vgg7xu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700411905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=geoVj6D3c/+KTWmyjJ8s7O+Wqx3brK12SNyGzJHCE9A=;
	b=T4vgg7xuF4UeVMi85F4uboVdL8reohQbLeNjJcTBPFhbFXD0UcUfPKw6XAmfoGNrDeC4Dp
	xsLs+AWSsF5A1RlmbA+WGBUjCTzXFflDZiLqhee1d6As0wbsFj11WsGaRLekesLq1dOQzY
	UzFPwFprrx6jvF4UtosIitK4zpqZCaY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-576-QqDJjnq9O8maNL8I5ZuDcA-1; Sun,
 19 Nov 2023 11:38:24 -0500
X-MC-Unique: QqDJjnq9O8maNL8I5ZuDcA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CE3463C0C12F
	for <gfs2@lists.linux.dev>; Sun, 19 Nov 2023 16:38:23 +0000 (UTC)
Received: from fs-i40c-03.fs.lab.eng.bos.redhat.com (fs-i40c-03.fast.rdu2.eng.redhat.com [10.6.23.54])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C63F240C6EBB;
	Sun, 19 Nov 2023 16:38:23 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCHv2 dlm/next 11/13] dlm: ls_recv_active semaphore to rwlock
Date: Sun, 19 Nov 2023 11:38:15 -0500
Message-Id: <20231119163817.751872-12-aahringo@redhat.com>
In-Reply-To: <20231119163817.751872-1-aahringo@redhat.com>
References: <20231119163817.751872-1-aahringo@redhat.com>
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

This patch converts the ls_recv_active semaphore to a rwlock to not
sleep during dlm message processing.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/dlm_internal.h | 2 +-
 fs/dlm/lock.c         | 4 ++--
 fs/dlm/lockspace.c    | 2 +-
 fs/dlm/member.c       | 4 ++--
 fs/dlm/recoverd.c     | 4 ++--
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/dlm/dlm_internal.h b/fs/dlm/dlm_internal.h
index 4cb1f38067d3..70de068bcf2b 100644
--- a/fs/dlm/dlm_internal.h
+++ b/fs/dlm/dlm_internal.h
@@ -623,7 +623,7 @@ struct dlm_ls {
 	uint64_t		ls_recover_seq;
 	struct dlm_recover	*ls_recover_args;
 	struct rw_semaphore	ls_in_recovery;	/* block local requests */
-	struct rw_semaphore	ls_recv_active;	/* block dlm_recv */
+	rwlock_t		ls_recv_active;	/* block dlm_recv */
 	struct list_head	ls_requestqueue;/* queue remote requests */
 	rwlock_t		ls_requestqueue_lock;
 	struct dlm_rcom		*ls_recover_buf;
diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index e2e98811eafa..091a8e58c06c 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -4834,7 +4834,7 @@ void dlm_receive_buffer(const union dlm_packet *p, int nodeid)
 	/* this rwsem allows dlm_ls_stop() to wait for all dlm_recv threads to
 	   be inactive (in this ls) before transitioning to recovery mode */
 
-	down_read(&ls->ls_recv_active);
+	read_lock(&ls->ls_recv_active);
 	if (hd->h_cmd == DLM_MSG)
 		dlm_receive_message(ls, &p->message, nodeid);
 	else if (hd->h_cmd == DLM_RCOM)
@@ -4842,7 +4842,7 @@ void dlm_receive_buffer(const union dlm_packet *p, int nodeid)
 	else
 		log_error(ls, "invalid h_cmd %d from %d lockspace %x",
 			  hd->h_cmd, nodeid, le32_to_cpu(hd->u.h_lockspace));
-	up_read(&ls->ls_recv_active);
+	read_unlock(&ls->ls_recv_active);
 
 	dlm_put_lockspace(ls);
 }
diff --git a/fs/dlm/lockspace.c b/fs/dlm/lockspace.c
index 757e473bc619..c021bf684fbc 100644
--- a/fs/dlm/lockspace.c
+++ b/fs/dlm/lockspace.c
@@ -552,7 +552,7 @@ static int new_lockspace(const char *name, const char *cluster,
 	ls->ls_recover_seq = get_random_u64();
 	ls->ls_recover_args = NULL;
 	init_rwsem(&ls->ls_in_recovery);
-	init_rwsem(&ls->ls_recv_active);
+	rwlock_init(&ls->ls_recv_active);
 	INIT_LIST_HEAD(&ls->ls_requestqueue);
 	rwlock_init(&ls->ls_requestqueue_lock);
 	spin_lock_init(&ls->ls_clear_proc_locks);
diff --git a/fs/dlm/member.c b/fs/dlm/member.c
index 707cebcdc533..ac1b555af9d6 100644
--- a/fs/dlm/member.c
+++ b/fs/dlm/member.c
@@ -630,7 +630,7 @@ int dlm_ls_stop(struct dlm_ls *ls)
 	 * message to the requestqueue without races.
 	 */
 
-	down_write(&ls->ls_recv_active);
+	write_lock(&ls->ls_recv_active);
 
 	/*
 	 * Abort any recovery that's in progress (see RECOVER_STOP,
@@ -654,7 +654,7 @@ int dlm_ls_stop(struct dlm_ls *ls)
 	 * requestqueue for later.
 	 */
 
-	up_write(&ls->ls_recv_active);
+	write_unlock(&ls->ls_recv_active);
 
 	/*
 	 * This in_recovery lock does two things:
diff --git a/fs/dlm/recoverd.c b/fs/dlm/recoverd.c
index 5388db89e22f..361327762c1b 100644
--- a/fs/dlm/recoverd.c
+++ b/fs/dlm/recoverd.c
@@ -103,7 +103,7 @@ static int enable_locking(struct dlm_ls *ls, uint64_t seq)
 {
 	int error = -EINTR;
 
-	down_write(&ls->ls_recv_active);
+	write_lock(&ls->ls_recv_active);
 
 	spin_lock(&ls->ls_recover_lock);
 	if (ls->ls_recover_seq == seq) {
@@ -115,7 +115,7 @@ static int enable_locking(struct dlm_ls *ls, uint64_t seq)
 	}
 	spin_unlock(&ls->ls_recover_lock);
 
-	up_write(&ls->ls_recv_active);
+	write_unlock(&ls->ls_recv_active);
 	return error;
 }
 
-- 
2.39.3

