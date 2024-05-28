Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A7F17B414
	for <gfs2@lists.linux.dev>; Tue, 28 May 2024 21:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716930773; cv=none; b=ApNCkusAnsPgwJCxzZZVQ1uP6nyljlFG2adyoSVoW9x+i14iVOnpJimnv7GMWNibCYhDUbqTIHSGjlN5c+8Oq42YXSi79dSZNYQ2Ov0JZUvIW54RbSVVdPHuIH4XRJ97gct+3IAXJUdO3yKpwMwfDZ8PxTEpqiNOiGU6aTSglx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716930773; c=relaxed/simple;
	bh=2YM/4+mHHJBGnskuk9oI4cAhhNg7bE6aQ3gleEuWrgc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=roVoWea6scujEFu1/wJqLV0yQKilBX9fNOKhIq0b7tAPv3xonkN/ivtpG18s0815ehPf9WGk+znjKWmy7aLYud5SQpavaEfo0ZxadvOlgB1QeiMjiGlUByHLdaZFEOr007d57H9uHAoZtq0Onli2Vt93Uxq/hMTgq/RMIrM+qcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=czLl8y2K; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="czLl8y2K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716930770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XvGt1qaVz2kUhe9jrxpmPT40rq0njPBQcucA3NxYLlk=;
	b=czLl8y2Kauh1SrU9rHOdd2yTOVFoyVkAnwzCvFLuR6LhoXj+DlPLyJtANdgdgaMX+iw4ej
	B/u3VGdwtrToeAN+kMIVzSy0nfhav/n7tw7YWGPIJgcQRdbNCTMRTFHuSGLZ0BLHJvfFkZ
	KMcYuxMA1Kk/aj92YBQVk6swY29fb4k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-YS-Q4H4NNM-AP4XlsE7WJQ-1; Tue, 28 May 2024 17:12:47 -0400
X-MC-Unique: YS-Q4H4NNM-AP4XlsE7WJQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D90418058D4
	for <gfs2@lists.linux.dev>; Tue, 28 May 2024 21:12:46 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by smtp.corp.redhat.com (Postfix) with ESMTP id CB4C6200A35C;
	Tue, 28 May 2024 21:12:46 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCH v6.10-rc1 01/11] dlm: remove scand leftovers
Date: Tue, 28 May 2024 17:12:31 -0400
Message-ID: <20240528211241.2140441-1-aahringo@redhat.com>
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

This patch removes some leftover related code from dlm_scand that was
dropped in commit b1f2381c1a8d ("dlm: drop dlm_scand kthread and use
timers").

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/dlm_internal.h | 8 --------
 fs/dlm/lockspace.c    | 1 -
 2 files changed, 9 deletions(-)

diff --git a/fs/dlm/dlm_internal.h b/fs/dlm/dlm_internal.h
index 9085ba3b2f20..9618ce0720d9 100644
--- a/fs/dlm/dlm_internal.h
+++ b/fs/dlm/dlm_internal.h
@@ -559,13 +559,6 @@ struct rcom_lock {
 	char			rl_lvb[];
 };
 
-/*
- * The max number of resources per rsbtbl bucket that shrink will attempt
- * to remove in each iteration.
- */
-
-#define DLM_REMOVE_NAMES_MAX 8
-
 struct dlm_ls {
 	struct list_head	ls_list;	/* list of lockspaces */
 	dlm_lockspace_t		*ls_local_handle;
@@ -578,7 +571,6 @@ struct dlm_ls {
 	wait_queue_head_t	ls_count_wait;
 	int			ls_create_count; /* create/release refcount */
 	unsigned long		ls_flags;	/* LSFL_ */
-	unsigned long		ls_scan_time;
 	struct kobject		ls_kobj;
 
 	struct idr		ls_lkbidr;
diff --git a/fs/dlm/lockspace.c b/fs/dlm/lockspace.c
index 475ab4370dda..b6a1a6eb7f27 100644
--- a/fs/dlm/lockspace.c
+++ b/fs/dlm/lockspace.c
@@ -410,7 +410,6 @@ static int new_lockspace(const char *name, const char *cluster,
 	atomic_set(&ls->ls_count, 0);
 	init_waitqueue_head(&ls->ls_count_wait);
 	ls->ls_flags = 0;
-	ls->ls_scan_time = jiffies;
 
 	if (ops && dlm_config.ci_recover_callbacks) {
 		ls->ls_ops = ops;
-- 
2.43.0

