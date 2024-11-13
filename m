Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E3914AD20
	for <gfs2@lists.linux.dev>; Wed, 13 Nov 2024 16:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731516415; cv=none; b=lP4SPXwKOgV9lPGFFlAGk3EQ+738ins08SJ/S2aDZtGq666SuEYSQiXscrMiDdOwC4xJzhrZ8byxC6ojJif4j3+2clm0bLvVOSI04uJ7X2qRQtiKZPMlRb5bnRU+IpY7lE+90qG7cDfnygI7PqgJYqKbSCVQl18Sn/WMbGOvhZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731516415; c=relaxed/simple;
	bh=3mdVAZKgaFXbg467JnjsnxHNB3ID2ziCPVlKbzMqU0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HyB39UtQUb7Khgr5cqe8Ii+FExqkRz4skEa4XS7mBoBsJYnBwdFEkcF4bk3D+0UyzaKAu2uJOwZP3ndY1iBYA9sXeLfUby1zmTCRQLHU9IlwoJpeS/T+poifbtIr/PdfwG4COkQS27P6XuvCJy8q7/2FRlphL4kzE9j52+wZTSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rnee1vG3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rnee1vG3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731516413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fM/AS/ag1VCF6kcDqnHTBgubarqZjSbJeTueVi1zfjI=;
	b=Rnee1vG3fHuo6aJEugHUbvmAK/gBoe3g+qOQ1sNv+tAfLLE8I55+sZ52Plo/68BFNiYBbh
	nZM1rsu2uCEm4M5w1XUMrGzbZB28M+fJmWFzUn7z33swRSLAJs0UrdEmfIUYTilYB8gT3g
	i0XYYA3h7Fd34kMuP8A52wvAMlzJIgc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-573-37kLdzsvPzmyYhzPN8NKqA-1; Wed,
 13 Nov 2024 11:46:51 -0500
X-MC-Unique: 37kLdzsvPzmyYhzPN8NKqA-1
X-Mimecast-MFC-AGG-ID: 37kLdzsvPzmyYhzPN8NKqA
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DFDD91956057
	for <gfs2@lists.linux.dev>; Wed, 13 Nov 2024 16:46:50 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 40FFD1956054;
	Wed, 13 Nov 2024 16:46:50 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCH dlm/next 2/5] dlm: introduce lockspace control debugfs entry
Date: Wed, 13 Nov 2024 11:46:40 -0500
Message-ID: <20241113164643.464055-2-aahringo@redhat.com>
In-Reply-To: <20241113164643.464055-1-aahringo@redhat.com>
References: <20241113164643.464055-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YMoeMhgSom1IFojKljYBbK_79P24Db3eEgzJ9xWtPc4_1731516411
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

To create nowadays a kernel lockspace we need to call the kernel API.
This will provide a debugfs entry to do so. It is named "__ctrl" as the
debugfs entries my collide with lockspace names. It still can but it is
more unlikely as it has a "__" prefix.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/debug_fs.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/fs/dlm/debug_fs.c b/fs/dlm/debug_fs.c
index c76320acefc1..49ad31120286 100644
--- a/fs/dlm/debug_fs.c
+++ b/fs/dlm/debug_fs.c
@@ -26,6 +26,7 @@ static struct mutex debug_buf_lock;
 
 static struct dentry *dlm_root;
 static struct dentry *dlm_comms;
+static struct dentry *dlm_ctrl;
 
 static char *print_lockmode(int mode)
 {
@@ -759,6 +760,36 @@ void dlm_delete_debug_comms_file(void *ctx)
 	debugfs_remove(ctx);
 }
 
+static ssize_t dlm_ctrl_write(struct file *fp, const char __user *user_buf,
+			      size_t count, loff_t *ppos)
+{
+	char clname[DLM_LOCKSPACE_LEN + 1] = {};
+	char lsname[DLM_LOCKSPACE_LEN + 1] = {};
+	dlm_lockspace_t *ls;
+	char buf[512] = {};
+	int rv, n;
+
+	if (copy_from_user(buf, user_buf,
+			   min_t(size_t, sizeof(buf) - 1, count)))
+		return -EFAULT;
+
+	n = sscanf(buf, "%" __stringify(DLM_LOCKSPACE_LEN) "s %" __stringify(DLM_LOCKSPACE_LEN) "s",
+		   lsname, clname);
+	if (n != 2)
+		return -EINVAL;
+
+	rv = dlm_new_lockspace(lsname, clname, 0, 0, NULL, NULL, NULL, &ls);
+	if (rv)
+		return rv;
+
+	return count;
+}
+
+static const struct file_operations dlm_ctrl_fops = {
+	.open	= simple_open,
+	.write	= dlm_ctrl_write,
+};
+
 void dlm_create_debug_file(struct dlm_ls *ls)
 {
 	/* Reserve enough space for the longest file name */
@@ -816,6 +847,8 @@ void __init dlm_register_debugfs(void)
 	mutex_init(&debug_buf_lock);
 	dlm_root = debugfs_create_dir("dlm", NULL);
 	dlm_comms = debugfs_create_dir("comms", dlm_root);
+	dlm_ctrl = debugfs_create_file("__ctrl", 0644, dlm_root, NULL,
+				       &dlm_ctrl_fops);
 }
 
 void dlm_unregister_debugfs(void)
-- 
2.43.0

