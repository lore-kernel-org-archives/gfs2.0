Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A496D1494CC
	for <gfs2@lists.linux.dev>; Wed, 13 Nov 2024 16:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731516415; cv=none; b=AfZ4xr2eZ+4fxYSQBBzBqi6E+R/6xkWjJ97iryKRcHCueyXcgamNWyGDQB0nugXm0m0uK/0bJEMVSg4b7ewIRif45fPhniNijfmdfa3x2a47V3I1Xhz0EgPjEZE3i65sJK/4ze8wlis/cHPs3gYf0IzGTbHZwVDk6h+dO5ws7KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731516415; c=relaxed/simple;
	bh=nXpZH4304wLYgGIUQMllIk7NFCLgELuZi5b32Bh7p7k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rgrSgB5C519VOOmD87NM9xNgP3qF1CPj5xRhnpVR8nNV2J8GcqDA7POfzIzrjFA6pQQ3fKG6N+XgvH/dql3ycXbxPdAmJN9hmEy/C7wkLUQERr9zn7ucoHQ9ofR8hPfWlQ1uXP0Voe06H1uLJd8VZJnJHAUFdZ5J9XiljpmJrJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q4Q2TQ6B; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q4Q2TQ6B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731516412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lTUGbZhI0snGkqRVBgXSYBl/H4qJxNJwVjxTzYcvxKI=;
	b=Q4Q2TQ6BvcgkstaAjMCN6wMpvJxXU0G7kSwW9EYj2wQMzLsd9hVkA5J8FaBvQ29XZnOCcy
	tUFJ9/ttywS8SHcz+WP7CG94EHt9O0z/H6Ysw/1jmYRaDhnrrKlqnXsG9saFcufVy9n5sZ
	S1yKOkIVPHIA0AmFxiNP3agS1wFOyhs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-28-t42nwgalMwO-knp9TTCneQ-1; Wed,
 13 Nov 2024 11:46:50 -0500
X-MC-Unique: t42nwgalMwO-knp9TTCneQ-1
X-Mimecast-MFC-AGG-ID: t42nwgalMwO-knp9TTCneQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E556B19560B2
	for <gfs2@lists.linux.dev>; Wed, 13 Nov 2024 16:46:49 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 339D61956054;
	Wed, 13 Nov 2024 16:46:49 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCH dlm/next 1/5] dlm: new max length for debugfs entry name
Date: Wed, 13 Nov 2024 11:46:39 -0500
Message-ID: <20241113164643.464055-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: rJBez4MqK0Sw2fN5UKqBpuWfqnTuhTsieXHoJuFMbVo_1731516410
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Since commit 16e98462b764 ("dlm: remove callback queue debugfs
functionality") the callback workqueue debugfs entry was being removed
again because lkb refcount issues with ongoing workers. Use the next
maximum name length for debugfs entry possible.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/debug_fs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/dlm/debug_fs.c b/fs/dlm/debug_fs.c
index 700a0cbb2f14..c76320acefc1 100644
--- a/fs/dlm/debug_fs.c
+++ b/fs/dlm/debug_fs.c
@@ -762,7 +762,7 @@ void dlm_delete_debug_comms_file(void *ctx)
 void dlm_create_debug_file(struct dlm_ls *ls)
 {
 	/* Reserve enough space for the longest file name */
-	char name[DLM_LOCKSPACE_LEN + sizeof("_queued_asts")];
+	char name[DLM_LOCKSPACE_LEN + sizeof("_waiters")];
 
 	/* format 1 */
 
-- 
2.43.0

