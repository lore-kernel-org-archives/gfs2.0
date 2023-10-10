Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFBB6119
	for <gfs2@lists.linux.dev>; Tue, 10 Oct 2023 22:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HB6nOgKv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696975502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2AMqunTsSyY5l7oJHOGnJLQkHHfoK+nmOjYPiFhLW9g=;
	b=HB6nOgKvSHO6EimcKT8Ae3kB7JT+b24pNW8kzzDMO9eeDFUuE8YS9JzLA0QrqSsCb19jQs
	aA2MkC4UlFSXxtaM6af/3d8YHzeJ0evbTU3igGpjF+LdaZgkO25cVgdqJ6mxjmwRFpxGCK
	XNtM/CijxNQUx/6qS25VlSyWLxA2YBo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-198-ZzLtFYJcPjGRc2rAL8rSCA-1; Tue, 10 Oct 2023 18:04:57 -0400
X-MC-Unique: ZzLtFYJcPjGRc2rAL8rSCA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7E1588F5DA3;
	Tue, 10 Oct 2023 22:04:57 +0000 (UTC)
Received: from fs-i40c-03.fs.lab.eng.bos.redhat.com (fs-i40c-03.fs.lab.eng.bos.redhat.com [10.16.224.23])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4DC0963F45;
	Tue, 10 Oct 2023 22:04:57 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: cluster-devel@redhat.com,
	gfs2@lists.linux.dev,
	christophe.jaillet@wanadoo.fr,
	stable@vger.kernel.org,
	aahringo@redhat.com
Subject: [PATCH RESEND 2/8] fs: dlm: Fix the size of a buffer in dlm_create_debug_file()
Date: Tue, 10 Oct 2023 18:04:42 -0400
Message-Id: <20231010220448.2978176-2-aahringo@redhat.com>
In-Reply-To: <20231010220448.2978176-1-aahringo@redhat.com>
References: <20231010220448.2978176-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

8 is not the maximum size of the suffix used when creating debugfs files.

Let the compiler compute the correct size, and only give a hint about the
longest possible string that is used.

When building with W=1, this fixes the following warnings:

  fs/dlm/debug_fs.c: In function ‘dlm_create_debug_file’:
  fs/dlm/debug_fs.c:1020:58: error: ‘snprintf’ output may be truncated before the last format character [-Werror=format-truncation=]
   1020 |         snprintf(name, DLM_LOCKSPACE_LEN + 8, "%s_waiters", ls->ls_name);
        |                                                          ^
  fs/dlm/debug_fs.c:1020:9: note: ‘snprintf’ output between 9 and 73 bytes into a destination of size 72
   1020 |         snprintf(name, DLM_LOCKSPACE_LEN + 8, "%s_waiters", ls->ls_name);
        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  fs/dlm/debug_fs.c:1031:50: error: ‘_queued_asts’ directive output may be truncated writing 12 bytes into a region of size between 8 and 72 [-Werror=format-truncation=]
   1031 |         snprintf(name, DLM_LOCKSPACE_LEN + 8, "%s_queued_asts", ls->ls_name);
        |                                                  ^~~~~~~~~~~~
  fs/dlm/debug_fs.c:1031:9: note: ‘snprintf’ output between 13 and 77 bytes into a destination of size 72
   1031 |         snprintf(name, DLM_LOCKSPACE_LEN + 8, "%s_queued_asts", ls->ls_name);
        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Fixes: 541adb0d4d10b ("fs: dlm: debugfs for queued callbacks")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/debug_fs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/dlm/debug_fs.c b/fs/dlm/debug_fs.c
index e9726c6cbdf2..c93359ceaae6 100644
--- a/fs/dlm/debug_fs.c
+++ b/fs/dlm/debug_fs.c
@@ -973,7 +973,8 @@ void dlm_delete_debug_comms_file(void *ctx)
 
 void dlm_create_debug_file(struct dlm_ls *ls)
 {
-	char name[DLM_LOCKSPACE_LEN + 8];
+	/* Reserve enough space for the longest file name */
+	char name[DLM_LOCKSPACE_LEN + sizeof("_queued_asts")];
 
 	/* format 1 */
 
-- 
2.39.3

