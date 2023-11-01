Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD3214265
	for <gfs2@lists.linux.dev>; Wed,  1 Nov 2023 16:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fvVf+paU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698857201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tTKIF6vi0aXXL6RE1UPCQOsj9IBKrd34irhOfI7RfSU=;
	b=fvVf+paU3DsiAIPA3xqwzNCNIu/WIvsmPXtWqRcLZAE3Jt9/aLA7CLpR82CuqAIJ2bt8gs
	zqF0bbzB0haRaC+XYUd0XeFVvKvZB9exmlNSeHvvMaD5o/SI1cIn2dtsCJuzoCBE65OtVz
	S2FseJ+QI1/LOfiGsJs5R1PfVuchsaE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-H0WAFkfHPfSI4uRFYJUXYQ-1; Wed, 01 Nov 2023 12:46:36 -0400
X-MC-Unique: H0WAFkfHPfSI4uRFYJUXYQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B8A801064BE5;
	Wed,  1 Nov 2023 16:46:35 +0000 (UTC)
Received: from pasta.redhat.com (unknown [10.45.224.27])
	by smtp.corp.redhat.com (Postfix) with ESMTP id EF13040C6EBC;
	Wed,  1 Nov 2023 16:46:34 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Amir Goldstein <amir73il@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 23/25] gfs2: fs: derive f_fsid from s_uuid
Date: Wed,  1 Nov 2023 17:46:13 +0100
Message-ID: <20231101164615.1138692-24-agruenba@redhat.com>
In-Reply-To: <20231101164615.1138692-1-agruenba@redhat.com>
References: <20231101164615.1138692-1-agruenba@redhat.com>
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

From: Amir Goldstein <amir73il@gmail.com>

gfs2 already has optional persistent uuid.

Use that uuid to report f_fsid in statfs(2), same as ext2/ext4/zonefs.

This allows gfs2 to be monitored by fanotify filesystem watch.
for example, with inotify-tools 4.23.8.0, the following command can be
used to watch changes over entire filesystem:

  fsnotifywatch --filesystem /mnt/gfs2

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index 4dad30dd72fc..726f062bc490 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -1006,6 +1006,7 @@ static int gfs2_statfs(struct dentry *dentry, struct kstatfs *buf)
 	buf->f_files = sc.sc_dinodes + sc.sc_free;
 	buf->f_ffree = sc.sc_free;
 	buf->f_namelen = GFS2_FNAMESIZE;
+	buf->f_fsid = uuid_to_fsid(sb->s_uuid.b);
 
 	return 0;
 }
-- 
2.41.0

