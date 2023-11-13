Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7344224EA
	for <gfs2@lists.linux.dev>; Mon, 13 Nov 2023 21:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K3cTJlAD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699910661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZDDCg6b+9hXukj/lsJySt0kpz4WIxad9YwCmSOLS7Tc=;
	b=K3cTJlAD4EVR0SVqs+7mmxBuo1m6QiucwqWyEP3O9jrTPxmjNp7gMZ0lOTGjyu2fQC7JEL
	6h8qEH9Si2wCu/d4gg151vbH/241lFvqe283lnlhTR9ZDvsfFVpFZGg+XjxbxDBEQuwwA4
	ZBIljAqKsWOTRu0hm8GeQTp+KaV35dA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-VbKBUaETOB-rf3_us9-fnA-1; Mon, 13 Nov 2023 16:24:17 -0500
X-MC-Unique: VbKBUaETOB-rf3_us9-fnA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 84CEA185A782;
	Mon, 13 Nov 2023 21:24:17 +0000 (UTC)
Received: from fs-i40c-03.fs.lab.eng.bos.redhat.com (fs-i40c-03.fast.rdu2.eng.redhat.com [10.6.23.54])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7B5A63D3;
	Mon, 13 Nov 2023 21:24:17 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	jlayton@kernel.org,
	aahringo@redhat.com
Subject: [PATCH v6.7-rc1 3/3] dlm: implement EXPORT_OP_ASYNC_LOCK
Date: Mon, 13 Nov 2023 16:24:11 -0500
Message-Id: <20231113212411.4187690-3-aahringo@redhat.com>
In-Reply-To: <20231113212411.4187690-1-aahringo@redhat.com>
References: <20231113212411.4187690-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

This patch is activating the EXPORT_OP_ASYNC_LOCK export flag to
signal lockd that both filesystems are able to handle async lock
requests. The cluster filesystems gfs2 and ocfs2 will redirect their
lock requests to DLMs plock implementation that can handle async lock
requests.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/gfs2/export.c  | 1 +
 fs/ocfs2/export.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/fs/gfs2/export.c b/fs/gfs2/export.c
index cf40895233f5..ef1013eff936 100644
--- a/fs/gfs2/export.c
+++ b/fs/gfs2/export.c
@@ -192,5 +192,6 @@ const struct export_operations gfs2_export_ops = {
 	.fh_to_parent = gfs2_fh_to_parent,
 	.get_name = gfs2_get_name,
 	.get_parent = gfs2_get_parent,
+	.flags = EXPORT_OP_ASYNC_LOCK,
 };
 
diff --git a/fs/ocfs2/export.c b/fs/ocfs2/export.c
index eaa8c80ace3c..b8b6a191b5cb 100644
--- a/fs/ocfs2/export.c
+++ b/fs/ocfs2/export.c
@@ -280,4 +280,5 @@ const struct export_operations ocfs2_export_ops = {
 	.fh_to_dentry	= ocfs2_fh_to_dentry,
 	.fh_to_parent	= ocfs2_fh_to_parent,
 	.get_parent	= ocfs2_get_parent,
+	.flags		= EXPORT_OP_ASYNC_LOCK,
 };
-- 
2.39.3

