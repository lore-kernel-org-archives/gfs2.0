Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56259136327
	for <gfs2@lists.linux.dev>; Fri,  2 Aug 2024 17:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722619631; cv=none; b=dx0oEWn6o4BHlrAtMKGYBNnFzbmglh2trxDkweuoEHVE4W63ry+gE285Rx77w16O54tCffVdAquQIgd+OWt7BBSh9X6+9IVWSzpFDkbr8R3bnio2AsvXVWOpWhO07I9mubS8Gjesv1SOI8fRWj6ct/gUJPZcwxLISZJUP81Wk0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722619631; c=relaxed/simple;
	bh=n7Afz2n91j35rnhSvPk3sx+SR48rL2Xdn0hF+JfTcwU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RBJ+11+0nzWWGilLPPw8GNadueKrYlKs66N4y0BuApEJ7l0tip6opiBJ7pwvzoQvvT7ejt1o/PJ75d2OFXtqUOC+oy9WoZxJrij9fYxcoM0Bsl+Br5YyMTm3CEg59XSAy3INGzgPIpO+HtWNuEph/CM8MuY+EPL7gltd+fgppWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f8v8JGLS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f8v8JGLS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722619626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=74AGwsvp2gKPcawCQnDRB9TvLDeSdxm19yrdhAEna1Y=;
	b=f8v8JGLS9MHaUOuYe7k0sVPk/ZEPXRJp7K9Skt3bynHbdtLtZWAlibgueMJvS9CqHxiYjE
	BsvYHGInp9g0UyucEDD9NRHAgBSxPE5iX4dRGIoYUYvhKIXJIBEqxwvKNGAJjIFsfxHJ01
	o7mR1Sg9ENXWDsNv7R1jJllTPapKMZU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-690-6LTHYsrOORSYFUMu5ToBPw-1; Fri,
 02 Aug 2024 13:27:05 -0400
X-MC-Unique: 6LTHYsrOORSYFUMu5ToBPw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BF3221955D50
	for <gfs2@lists.linux.dev>; Fri,  2 Aug 2024 17:27:04 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EBBC019560AE;
	Fri,  2 Aug 2024 17:27:03 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCHv2 v6.11-rc1 01/10] dlm: cleanup memory allocation helpers
Date: Fri,  2 Aug 2024 13:26:38 -0400
Message-ID: <20240802172647.582745-1-aahringo@redhat.com>
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

This patch removes a unnecessary parameter from DLM memory allocation
helpers and reduce some functions by just directly reply the pointer
address of the allocated memory.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/lock.c   |  4 ++--
 fs/dlm/memory.c | 19 +++++--------------
 fs/dlm/memory.h |  4 ++--
 3 files changed, 9 insertions(+), 18 deletions(-)

diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index 8bee4f444afd..6930d7c57216 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -600,7 +600,7 @@ static int get_rsb_struct(struct dlm_ls *ls, const void *name, int len,
 {
 	struct dlm_rsb *r;
 
-	r = dlm_allocate_rsb(ls);
+	r = dlm_allocate_rsb();
 	if (!r)
 		return -ENOMEM;
 
@@ -1497,7 +1497,7 @@ static int _create_lkb(struct dlm_ls *ls, struct dlm_lkb **lkb_ret,
 	limit.max = end;
 	limit.min = start;
 
-	lkb = dlm_allocate_lkb(ls);
+	lkb = dlm_allocate_lkb();
 	if (!lkb)
 		return -ENOMEM;
 
diff --git a/fs/dlm/memory.c b/fs/dlm/memory.c
index 8c44b954c166..442898cf7185 100644
--- a/fs/dlm/memory.c
+++ b/fs/dlm/memory.c
@@ -84,10 +84,7 @@ void dlm_memory_exit(void)
 
 char *dlm_allocate_lvb(struct dlm_ls *ls)
 {
-	char *p;
-
-	p = kzalloc(ls->ls_lvblen, GFP_ATOMIC);
-	return p;
+	return kzalloc(ls->ls_lvblen, GFP_ATOMIC);
 }
 
 void dlm_free_lvb(char *p)
@@ -95,12 +92,9 @@ void dlm_free_lvb(char *p)
 	kfree(p);
 }
 
-struct dlm_rsb *dlm_allocate_rsb(struct dlm_ls *ls)
+struct dlm_rsb *dlm_allocate_rsb(void)
 {
-	struct dlm_rsb *r;
-
-	r = kmem_cache_zalloc(rsb_cache, GFP_ATOMIC);
-	return r;
+	return kmem_cache_zalloc(rsb_cache, GFP_ATOMIC);
 }
 
 static void __free_rsb_rcu(struct rcu_head *rcu)
@@ -116,12 +110,9 @@ void dlm_free_rsb(struct dlm_rsb *r)
 	call_rcu(&r->rcu, __free_rsb_rcu);
 }
 
-struct dlm_lkb *dlm_allocate_lkb(struct dlm_ls *ls)
+struct dlm_lkb *dlm_allocate_lkb(void)
 {
-	struct dlm_lkb *lkb;
-
-	lkb = kmem_cache_zalloc(lkb_cache, GFP_ATOMIC);
-	return lkb;
+	return kmem_cache_zalloc(lkb_cache, GFP_ATOMIC);
 }
 
 void dlm_free_lkb(struct dlm_lkb *lkb)
diff --git a/fs/dlm/memory.h b/fs/dlm/memory.h
index 15198d46b42a..551b6b788489 100644
--- a/fs/dlm/memory.h
+++ b/fs/dlm/memory.h
@@ -14,9 +14,9 @@
 
 int dlm_memory_init(void);
 void dlm_memory_exit(void);
-struct dlm_rsb *dlm_allocate_rsb(struct dlm_ls *ls);
+struct dlm_rsb *dlm_allocate_rsb(void);
 void dlm_free_rsb(struct dlm_rsb *r);
-struct dlm_lkb *dlm_allocate_lkb(struct dlm_ls *ls);
+struct dlm_lkb *dlm_allocate_lkb(void);
 void dlm_free_lkb(struct dlm_lkb *l);
 char *dlm_allocate_lvb(struct dlm_ls *ls);
 void dlm_free_lvb(char *l);
-- 
2.43.0

