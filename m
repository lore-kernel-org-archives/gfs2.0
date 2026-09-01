Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F6D48C8C1
	for <gfs2@lists.linux.dev>; Tue,  1 Sep 2026 17:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788284849; cv=none; b=bS947f7tlZbYs+ZH8Ay9iF0PtNNH3wa52DOjeTc+GTDSBQknAKg8S+L9Z07CW48k08gFqxYresHtPblEi6LKiCkyHf2ieIedEFyqN6jo/ShmJ/KskTfZvFQPQBHkqbC4V7X7l0UO1TFf8BxyJ+7W7bcr2s9ls21+YuoPBFsr8Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788284849; c=relaxed/simple;
	bh=RYp2aWNXs0VU48yVSD1CEYHhUFCkLVsEoUf/CGIQ9pg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=th7zmxxlieERrucXIEHqBMMSTl6zlDvmLj1ZmcSky9nDKornRxYNDM63/5JyU9qkkF+FM/pvNPE4CfaXwF7IrR88moXobXzCBjTfXJA5qVZ9ZV8F0yvpplTX0GqEZmoCVuCy5DMG4FeaGmDhaewNa3QpgwGdFGU+w7v9nDlmDTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EbOFFo2g; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EbOFFo2g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788284847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rcjR0OL/Ys8fh9BhxqIvzdpYnJTnUC4AjAUfzLDznmM=;
	b=EbOFFo2g7s2l6tXraF2EoHudZTXJQgWFavKYxJQaWa7XdJPaTgjsEp/Bw0E1upRXW8Dmyv
	nBljC7p7nsEn2POO+gl9qmSVmSJYozc6bfZsj81F6JD8oNSFdV4Lxz7BUJWUQKcJK/DZ3x
	rwe2FRQLTjupjZvawdYnakKvVl4GCbM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-604-0uCrTNmkMsGh_cERmBYNig-1; Tue,
 01 Sept 2026 13:47:25 -0400
X-MC-Unique: 0uCrTNmkMsGh_cERmBYNig-1
X-Mimecast-MFC-AGG-ID: 0uCrTNmkMsGh_cERmBYNig_1788284844
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 90A04195608B
	for <gfs2@lists.linux.dev>; Tue,  1 Sep 2026 17:47:24 +0000 (UTC)
Received: from fs-i40c-03.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E7FFC1803A59;
	Tue,  1 Sep 2026 17:47:23 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: aahringo@redhat.com,
	gfs2@lists.linux.dev
Subject: [PATCH RESEND dlm/next 4/8] dlm: fix buffer overflow from negative len in dlm_search_rsb_tree
Date: Tue,  1 Sep 2026 13:47:11 -0400
Message-ID: <20260901174715.3825582-5-aahringo@redhat.com>
In-Reply-To: <20260901174715.3825582-1-aahringo@redhat.com>
References: <20260901174715.3825582-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4RlEinYVc3DBz4Ye_8gxZsquZWf_1ka8ZTM1_A6Jpnc_1788284844
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

From: Joseph Qi <joseph.qi@linux.alibaba.com>

commit 080e5563f878c ("dlm: validate length in dlm_search_rsb_tree")
only checks for len > DLM_RESNAME_MAXLEN, which does not catch negative
values. While the input 'len' can be negative and a negative int passed
to memcpy() is implicitly converted to a large size_t, causing a stack
buffer overflow on the key[] array.

Fix this by changing the 'len' parameter type from int to unsigned int.
This ensures negative values from callers are implicitly converted to
large unsigned values that are caught by the existing
len > DLM_RESNAME_MAXLEN check.

Acked-by: Alexander Aring <aahringo@redhat.com>
Signed-off-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/lock.c | 6 ++++--
 fs/dlm/lock.h | 4 ++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index c381e10284465..373abdb4354a7 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -622,12 +622,14 @@ static int get_rsb_struct(struct dlm_ls *ls, const void *name, int len,
 	return 0;
 }
 
-int dlm_search_rsb_tree(struct rhashtable *rhash, const void *name, int len,
-			struct dlm_rsb **r_ret)
+int dlm_search_rsb_tree(struct rhashtable *rhash, const void *name,
+			unsigned int len, struct dlm_rsb **r_ret)
 {
 	char key[DLM_RESNAME_MAXLEN] = {};
+
 	if (len > DLM_RESNAME_MAXLEN)
 		return -EINVAL;
+
 	memcpy(key, name, len);
 	*r_ret = rhashtable_lookup_fast(rhash, &key, dlm_rhash_rsb_params);
 	if (*r_ret)
diff --git a/fs/dlm/lock.h b/fs/dlm/lock.h
index b23d7b854ed46..c75975937331c 100644
--- a/fs/dlm/lock.h
+++ b/fs/dlm/lock.h
@@ -31,8 +31,8 @@ void resume_scan_timer(struct dlm_ls *ls);
 int dlm_master_lookup(struct dlm_ls *ls, int from_nodeid, const char *name,
 		      int len, unsigned int flags, int *r_nodeid, int *result);
 
-int dlm_search_rsb_tree(struct rhashtable *rhash, const void *name, int len,
-			struct dlm_rsb **r_ret);
+int dlm_search_rsb_tree(struct rhashtable *rhash, const void *name,
+			unsigned int len, struct dlm_rsb **r_ret);
 
 void dlm_recover_purge(struct dlm_ls *ls, const struct list_head *root_list);
 void dlm_purge_mstcpy_locks(struct dlm_rsb *r);
-- 
2.43.0

