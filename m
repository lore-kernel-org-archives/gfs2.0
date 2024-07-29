Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B01128812
	for <gfs2@lists.linux.dev>; Mon, 29 Jul 2024 19:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722281802; cv=none; b=ZaYMwx9ljkfKx2IEFvPZzfUZx980D5L4E4iqFbJwhO4V2zT3pvN3VNcbbgRSmevwQOet0jJS5hnnyPJDOFb7LSYUp6iOyD0LndzlfvrJYUGWo0f1zSw0qHaoSWeqZpKNKLa5MDcXST22w7tq0ft6GrOIRFpA5DnV3yI6WwEuG3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722281802; c=relaxed/simple;
	bh=n7Afz2n91j35rnhSvPk3sx+SR48rL2Xdn0hF+JfTcwU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=khdWNlsD/utDyGyh1S6o9UR0LJptxchuJjCoSEezaVDOkTRHZQcxh/EpCvvi8wOuNDV3DV8D8WW7pCPTApSj6I7fpH2/NsY6QTmMgIY3YQf4ADeKGsTHhoUHjRQmU4soNPZjhdy5BDxFjnLaAtv2CwwnSm2AlBNkHrZmR1ccjy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FKxKmes7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FKxKmes7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722281800;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=74AGwsvp2gKPcawCQnDRB9TvLDeSdxm19yrdhAEna1Y=;
	b=FKxKmes7NYMgCN4UrZIP+Vtz1VSewRX96+XvoYPNQ3j57iPz2igBksbBwiUCMMvhaFdQg0
	H0iST3JDPPc2g/fDcc906znwqwpd1UpaY7ehp3PWJekgdA5on7ObDpRlgrfoWmCuFSBlaK
	KbTNEOt1DWA4rMb0vFPjMpdfayFi5U8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-rGTcsjzvOPuNs4swEgVxvA-1; Mon,
 29 Jul 2024 15:36:38 -0400
X-MC-Unique: rGTcsjzvOPuNs4swEgVxvA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8724B1955D4C
	for <gfs2@lists.linux.dev>; Mon, 29 Jul 2024 19:36:37 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C4BAC1955D47;
	Mon, 29 Jul 2024 19:36:36 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCH v6.11-rc1 01/10] dlm: cleanup memory allocation helpers
Date: Mon, 29 Jul 2024 15:36:21 -0400
Message-ID: <20240729193630.3344082-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
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

