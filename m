Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E94121CA1D
	for <gfs2@lists.linux.dev>; Thu, 14 Aug 2025 15:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755184947; cv=none; b=NvPSTxpVEIg1huCKkD0u+zzaNw8LyGwpd0fEplTPRVPulsssdlKXG5aCOY8bFcvHd1X1vrhh1zDqJE/PxVgq/+07cyP79N9t9H86QkoV/8GzBWkIHhmbktMVPWqFRhjuSndGDq+TJrZQkvww68OkVZGi1ohbXu4IJbalfBjUoUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755184947; c=relaxed/simple;
	bh=LiPpJlJzF/XjG/3+mhydpPu/9yLzIHKbjhHgyPJdi58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=TRoTWXwO38yQ0LDfHp/jJZCOr/4vheEw7e/wuQslDgmhzLNDQNt5aY+PTnY8Uc8hF0pFSIMRtOt8bKO5ZZzIp19B1rjwLUQ/A81UR0q55aeS+HzTMetfgg0Dhsc7fPjtD9IeYICovNs9ZTDIxTJ3AtpEQ+1w62XZgbEMGdYMwqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MNUfxlqv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MNUfxlqv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755184945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1OaWmU+sTOAbMbVOqbWtKy3dhr7Ph5FXo8Mk7hrgVE0=;
	b=MNUfxlqvbHJ8DSGemEyBUSHxcyMcWJZFs0tP4XZ6hz7tZ5VbacdgGfXqY2bYB8kkG+9Rv5
	hdCG/IBwqSF9vwcJkgCX84likmlUYXr0mtCEumXhRqwRAkBZq+rV56qURUksn1o8QqpuCD
	4ZhDqVdFVTGDY0c0wZ80k6NGDKGTEso=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-35-H3SAE77TNvulFGQc-ZOleg-1; Thu,
 14 Aug 2025 11:22:23 -0400
X-MC-Unique: H3SAE77TNvulFGQc-ZOleg-1
X-Mimecast-MFC-AGG-ID: H3SAE77TNvulFGQc-ZOleg_1755184942
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CBDF1180035F
	for <gfs2@lists.linux.dev>; Thu, 14 Aug 2025 15:22:22 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EA49730001A6;
	Thu, 14 Aug 2025 15:22:21 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCH dlm/next 3/4] dlm: handle release_option as unsigned
Date: Thu, 14 Aug 2025 11:22:13 -0400
Message-ID: <20250814152214.946153-3-aahringo@redhat.com>
In-Reply-To: <20250814152214.946153-1-aahringo@redhat.com>
References: <20250814152214.946153-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: gAGgnEIVVl3je3FDrcGHKNa3PnJFzO6RE8I7aZLMvKg_1755184942
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Future patches will introduce a invalid argument check for undefined
values. All values for release_option are positive integer values to not
check on negative values as well we just change the parameter to
unsigned int.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/lockspace.c  | 8 ++++----
 include/linux/dlm.h | 3 ++-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/dlm/lockspace.c b/fs/dlm/lockspace.c
index d986b7ef153dc..8eadbf0fdf179 100644
--- a/fs/dlm/lockspace.c
+++ b/fs/dlm/lockspace.c
@@ -676,7 +676,7 @@ int dlm_new_user_lockspace(const char *name, const char *cluster,
    This is because there may be LKBs queued as ASTs that have been unlinked
    from their RSBs and are pending deletion once the AST has been delivered */
 
-static int lockspace_busy(struct dlm_ls *ls, int release_option)
+static int lockspace_busy(struct dlm_ls *ls, unsigned int release_option)
 {
 	struct dlm_lkb *lkb;
 	unsigned long id;
@@ -704,7 +704,7 @@ static int lockspace_busy(struct dlm_ls *ls, int release_option)
 	return rv;
 }
 
-static int release_lockspace(struct dlm_ls *ls, int release_option)
+static int release_lockspace(struct dlm_ls *ls, unsigned int release_option)
 {
 	int busy, rv;
 
@@ -792,7 +792,7 @@ static int release_lockspace(struct dlm_ls *ls, int release_option)
  * See DLM_RELEASE defines for release_option values and their meaning.
  */
 
-int dlm_release_lockspace(void *lockspace, int force)
+int dlm_release_lockspace(void *lockspace, unsigned int release_option)
 {
 	struct dlm_ls *ls;
 	int error;
@@ -803,7 +803,7 @@ int dlm_release_lockspace(void *lockspace, int force)
 	dlm_put_lockspace(ls);
 
 	mutex_lock(&ls_lock);
-	error = release_lockspace(ls, force);
+	error = release_lockspace(ls, release_option);
 	if (!error)
 		ls_count--;
 	if (!ls_count)
diff --git a/include/linux/dlm.h b/include/linux/dlm.h
index 108eb953eb181..34015a008b801 100644
--- a/include/linux/dlm.h
+++ b/include/linux/dlm.h
@@ -122,7 +122,8 @@ int dlm_new_lockspace(const char *name, const char *cluster,
  * release_option: see DLM_RELEASE values above.
  */
 
-int dlm_release_lockspace(dlm_lockspace_t *lockspace, int release_option);
+int dlm_release_lockspace(dlm_lockspace_t *lockspace,
+			  unsigned int release_option);
 
 /*
  * dlm_lock
-- 
2.43.0

