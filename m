Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FA932C64
	for <gfs2@lists.linux.dev>; Tue, 10 Oct 2023 22:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fLBR1sez"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696975518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e1DAsNmGZUyXNq+0RsyEaZwIKrlbsqv6ED1CKmPYg80=;
	b=fLBR1sezko1eBnKsaRTbO58jSy2Dv8xE3dafROCW47INs/B3UrappHIgkz7VUd+4x1NpCS
	bMJSuxlbDBkEY43tWDaTNj0zpmsf4rLkvGILit5hGVAJx6tYWfNjH1cu7+pOOt3I2PSuff
	J0bQoFerOwgFxL4v8dlW024VQIZ/QZU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-633-4Hpfvi0yNsaBQe9pAvAUug-1; Tue, 10 Oct 2023 18:04:58 -0400
X-MC-Unique: 4Hpfvi0yNsaBQe9pAvAUug-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B76FB38008A3;
	Tue, 10 Oct 2023 22:04:57 +0000 (UTC)
Received: from fs-i40c-03.fs.lab.eng.bos.redhat.com (fs-i40c-03.fs.lab.eng.bos.redhat.com [10.16.224.23])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8670D9A;
	Tue, 10 Oct 2023 22:04:57 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: cluster-devel@redhat.com,
	gfs2@lists.linux.dev,
	christophe.jaillet@wanadoo.fr,
	stable@vger.kernel.org,
	aahringo@redhat.com
Subject: [PATCH RESEND 3/8] fs: dlm: Remove some useless memset()
Date: Tue, 10 Oct 2023 18:04:43 -0400
Message-Id: <20231010220448.2978176-3-aahringo@redhat.com>
In-Reply-To: <20231010220448.2978176-1-aahringo@redhat.com>
References: <20231010220448.2978176-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

There is no need to clear the buffer used to build the file name.

snprintf() already guarantees that it is NULL terminated and such a
(useless) precaution was not done for the first string (i.e
ls_debug_rsb_dentry)

So, save a few LoC.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/debug_fs.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/dlm/debug_fs.c b/fs/dlm/debug_fs.c
index c93359ceaae6..42f332f46359 100644
--- a/fs/dlm/debug_fs.c
+++ b/fs/dlm/debug_fs.c
@@ -986,7 +986,6 @@ void dlm_create_debug_file(struct dlm_ls *ls)
 
 	/* format 2 */
 
-	memset(name, 0, sizeof(name));
 	snprintf(name, sizeof(name), "%s_locks", ls->ls_name);
 
 	ls->ls_debug_locks_dentry = debugfs_create_file(name,
@@ -997,7 +996,6 @@ void dlm_create_debug_file(struct dlm_ls *ls)
 
 	/* format 3 */
 
-	memset(name, 0, sizeof(name));
 	snprintf(name, sizeof(name), "%s_all", ls->ls_name);
 
 	ls->ls_debug_all_dentry = debugfs_create_file(name,
@@ -1008,7 +1006,6 @@ void dlm_create_debug_file(struct dlm_ls *ls)
 
 	/* format 4 */
 
-	memset(name, 0, sizeof(name));
 	snprintf(name, sizeof(name), "%s_toss", ls->ls_name);
 
 	ls->ls_debug_toss_dentry = debugfs_create_file(name,
@@ -1017,7 +1014,6 @@ void dlm_create_debug_file(struct dlm_ls *ls)
 						       ls,
 						       &format4_fops);
 
-	memset(name, 0, sizeof(name));
 	snprintf(name, sizeof(name), "%s_waiters", ls->ls_name);
 
 	ls->ls_debug_waiters_dentry = debugfs_create_file(name,
@@ -1028,7 +1024,6 @@ void dlm_create_debug_file(struct dlm_ls *ls)
 
 	/* format 5 */
 
-	memset(name, 0, sizeof(name));
 	snprintf(name, sizeof(name), "%s_queued_asts", ls->ls_name);
 
 	ls->ls_debug_queued_asts_dentry = debugfs_create_file(name,
-- 
2.39.3

