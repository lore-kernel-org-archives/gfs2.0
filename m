Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F096917BB3
	for <gfs2@lists.linux.dev>; Tue, 27 Feb 2024 01:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708998565; cv=none; b=nEQl8RAJwYMdbDRU4cnsFlUrjq2kFISu+Lm1E4R1FnKVFr74E8p3yCD9tg1Wj9Lhy9LnVWEYpWmgJXyKab6Y8Z4JIKcUV3syAWFOAFGeZwF2cPopuuffLBzz6EJMz9u6IwEGp8YhKf6mmLEEW9dvtuR9txRVY8U5ww+dGoyew2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708998565; c=relaxed/simple;
	bh=d/kDLNXgG8uvtFhCxhIAMBNpMxAj2dtWj/JNB1U3Xw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eXkPLQY7KXzcoMjZaBXgq3KY/g3FXfhlXRP6k+xPXWi6Wyso/Hhyr1ML5lt61vRpvHp7gjHfbTXUDjZ4Z09gggJkKyd+qk+v72iPksvVbnKPcJPH1vxnFEMe3ZrlPI9YGXBQkFzdQfV8FADEyUuf/eMkwmSTnELXHsJuyjc6i7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ezvwPi4f; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ezvwPi4f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708998561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IpksuJFfk9Orkn37Gt7FD4303J7FizbKVgQSCaH8M0c=;
	b=ezvwPi4fsPM6vkbpG769kiiX0edGW2H7wks20PxseeLQIc0wiLOIcrCNZ4C3Ev77jQjLlK
	uSqfX5L3klZzvwsN71to1ccufiS3YrqLjiDAfkEb+dTN4Gl/08c5LS/7yfh9OG7geG5KZ+
	L836Te+FMBy1RQjI4PndJOiwKlxoc28=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-jWYs7Px8NDmhdItCvgQvPQ-1; Mon, 26 Feb 2024 20:49:19 -0500
X-MC-Unique: jWYs7Px8NDmhdItCvgQvPQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6297F185A787
	for <gfs2@lists.linux.dev>; Tue, 27 Feb 2024 01:49:19 +0000 (UTC)
Received: from fs-i40c-03.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.fast.eng.rdu2.dc.redhat.com [10.6.23.54])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5B1582166AF4;
	Tue, 27 Feb 2024 01:49:19 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCHv3 v6.8-rc6 13/18] dlm: convert res_lock to spinlock
Date: Mon, 26 Feb 2024 20:49:04 -0500
Message-ID: <20240227014909.93945-14-aahringo@redhat.com>
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

This patch converts the per dlm rsb res_lock from a mutex to a spinlock.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/dlm_internal.h | 2 +-
 fs/dlm/lock.c         | 2 +-
 fs/dlm/lock.h         | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/dlm/dlm_internal.h b/fs/dlm/dlm_internal.h
index 5975d52f4061..13225b28fa98 100644
--- a/fs/dlm/dlm_internal.h
+++ b/fs/dlm/dlm_internal.h
@@ -290,7 +290,7 @@ struct dlm_lkb {
 struct dlm_rsb {
 	struct dlm_ls		*res_ls;	/* the lockspace */
 	struct kref		res_ref;
-	struct mutex		res_mutex;
+	spinlock_t		res_lock;
 	unsigned long		res_flags;
 	int			res_length;	/* length of rsb name */
 	int			res_nodeid;
diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index 525635f42938..267a18bcf2c6 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -415,7 +415,7 @@ static int get_rsb_struct(struct dlm_ls *ls, const void *name, int len,
 	r->res_ls = ls;
 	r->res_length = len;
 	memcpy(r->res_name, name, len);
-	mutex_init(&r->res_mutex);
+	spin_lock_init(&r->res_lock);
 
 	INIT_LIST_HEAD(&r->res_lookup);
 	INIT_LIST_HEAD(&r->res_grantqueue);
diff --git a/fs/dlm/lock.h b/fs/dlm/lock.h
index bc787a470632..ca71f1dc1b06 100644
--- a/fs/dlm/lock.h
+++ b/fs/dlm/lock.h
@@ -70,12 +70,12 @@ static inline int is_master(struct dlm_rsb *r)
 
 static inline void lock_rsb(struct dlm_rsb *r)
 {
-	mutex_lock(&r->res_mutex);
+	spin_lock(&r->res_lock);
 }
 
 static inline void unlock_rsb(struct dlm_rsb *r)
 {
-	mutex_unlock(&r->res_mutex);
+	spin_unlock(&r->res_lock);
 }
 
 #endif
-- 
2.43.0

