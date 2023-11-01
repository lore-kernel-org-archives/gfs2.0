Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF24815E88
	for <gfs2@lists.linux.dev>; Wed,  1 Nov 2023 16:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IuxfAtZu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698857182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MqDOBGvr5LuC1yHOYrXOIKee6LwoldLdMyHC0vdOGhQ=;
	b=IuxfAtZuBHcvp+Q3vQ5Kar/7O57PnGjZSsdOjC/TCLPTnVjMfgX3BIWDp3jGuc8hSUotGE
	BQUAkJU9L/rtVJPZPrsLdF9qIJfWBXYKosWGULsz31r3LUQqHHlIcVKw884lnvnGFEObOR
	BItarXfyeSDUPw+6MDwYOTWgbXC7yJQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-8r1m7SFVOY67UZugL8SpnQ-1; Wed, 01 Nov 2023 12:46:21 -0400
X-MC-Unique: 8r1m7SFVOY67UZugL8SpnQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0FDC381B175
	for <gfs2@lists.linux.dev>; Wed,  1 Nov 2023 16:46:21 +0000 (UTC)
Received: from pasta.redhat.com (unknown [10.45.224.27])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8500C40C6EBF;
	Wed,  1 Nov 2023 16:46:20 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 05/25] gfs2: Don't update inode timestamps for direct writes
Date: Wed,  1 Nov 2023 17:45:55 +0100
Message-ID: <20231101164615.1138692-6-agruenba@redhat.com>
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

During direct reads and writes, the caller is holding the inode glock in
deferred mode, which doesn't allow metadata updates.  However, a previous
change caused callers to update the inode modification time before carrying out
direct writes, which caused the inode glock to be converted to exclusive mode
for the timestamp update, only to be immediately converted back to deferred
mode for the direct write.  This locks out other direct readers and writers
and wreaks havoc on performance.

Fix that by reverting to not updating the inode modification time for direct
writes.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/file.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index f2700477a300..5bc103b031e2 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -1120,14 +1120,16 @@ static ssize_t gfs2_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if (ret)
 		goto out_unlock;
 
-	ret = file_update_time(file);
-	if (ret)
-		goto out_unlock;
-
 	if (iocb->ki_flags & IOCB_DIRECT) {
 		struct address_space *mapping = file->f_mapping;
 		ssize_t buffered, ret2;
 
+		/*
+		 * Note that under direct I/O, we don't allow and inode
+		 * timestamp updates, so we're not calling file_update_time()
+		 * here.
+		 */
+
 		ret = gfs2_file_direct_write(iocb, from, &gh);
 		if (ret < 0 || !iov_iter_count(from))
 			goto out_unlock;
@@ -1154,6 +1156,10 @@ static ssize_t gfs2_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		if (!ret || ret2 > 0)
 			ret += ret2;
 	} else {
+		ret = file_update_time(file);
+		if (ret)
+			goto out_unlock;
+
 		ret = gfs2_file_buffered_write(iocb, from, &gh);
 		if (likely(ret > 0))
 			ret = generic_write_sync(iocb, ret);
-- 
2.41.0

