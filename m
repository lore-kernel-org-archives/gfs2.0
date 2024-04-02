Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334AD15B575
	for <gfs2@lists.linux.dev>; Tue,  2 Apr 2024 19:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712085503; cv=none; b=o6ubD+tIe3OBjKjSC3fLCfODrGUP+Ch2AhgYOM5njcqcXa+AdI0aI/sf8CmParVYzrlRRd4nvGMTsW76e0UH0RbFgrnaordR2yzDXKsTrSJKYr9nBMwg19FesLvW4UTm+XuVZGfBUrwPKc4c/aA5PkLElubJabgh9aXI7umcxdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712085503; c=relaxed/simple;
	bh=iIWRz2V4OC56qzX1F4voWsSTDy0TTGbk/op5rYNrFQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uqp3LNAsa2jzLI9+gArPtPpAGQCFavis3LuGGypIpN14LMk06JYXSxc6R0LlrFIieO5DQfIuxwu9pnz8/9WnCcMCNqyuCLFALJE/B52j8Eq8722jrOld+WRaQwMFw4lcGUmRgJ/33UVkNc1aMRY/khQwUGxuzX9jJBAnSrNpLfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fIAHGcOI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fIAHGcOI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712085500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FoS6OYktCsJbLl6is3JGy40TBcZvgcybS0oyXv6xhHQ=;
	b=fIAHGcOI33NmdQYmhy7H06BQWRpy//jmruHw4PEbUW1oqTUZPK4pgl8TEDjQjNmCsSCJB+
	Fv5wDYBO/oTdseHGKkAq8yfhAsw5xpLp5aOI0264Q5OnOWWHDbqZCedcf1s4SG593cLcrL
	fdcom5SUYlFumpCzMIkrfptK3cPNE6o=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-382-Vx_slq4yOOWxSolxZhtv7A-1; Tue,
 02 Apr 2024 15:18:18 -0400
X-MC-Unique: Vx_slq4yOOWxSolxZhtv7A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ADF571C05147
	for <gfs2@lists.linux.dev>; Tue,  2 Apr 2024 19:18:18 +0000 (UTC)
Received: from fs-i40c-03.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A566C40C6CC0;
	Tue,  2 Apr 2024 19:18:18 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCHv4 dlm/next 10/15] dlm: convert res_lock to spinlock
Date: Tue,  2 Apr 2024 15:18:05 -0400
Message-ID: <20240402191810.1932939-11-aahringo@redhat.com>
In-Reply-To: <20240402191810.1932939-1-aahringo@redhat.com>
References: <20240402191810.1932939-1-aahringo@redhat.com>
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

This patch converts the per dlm rsb res_lock from a mutex to a spinlock.
To prepare switching to a softirq context when parsing DLM messages.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/dlm_internal.h | 2 +-
 fs/dlm/lock.c         | 2 +-
 fs/dlm/lock.h         | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/dlm/dlm_internal.h b/fs/dlm/dlm_internal.h
index 98029fd5cd2b..9f98a815f935 100644
--- a/fs/dlm/dlm_internal.h
+++ b/fs/dlm/dlm_internal.h
@@ -320,7 +320,7 @@ struct dlm_lkb {
 struct dlm_rsb {
 	struct dlm_ls		*res_ls;	/* the lockspace */
 	struct kref		res_ref;
-	struct mutex		res_mutex;
+	spinlock_t		res_lock;
 	unsigned long		res_flags;
 	int			res_length;	/* length of rsb name */
 	int			res_nodeid;
diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index af677add4f5f..7b309231eebd 100644
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
index b2fd74a2f8eb..0f6b2700c0da 100644
--- a/fs/dlm/lock.h
+++ b/fs/dlm/lock.h
@@ -69,12 +69,12 @@ static inline int is_master(struct dlm_rsb *r)
 
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

