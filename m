Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468102511E
	for <gfs2@lists.linux.dev>; Mon, 13 Nov 2023 21:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VeSbBir9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699910661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EfJ5TqIVefF4p/X+QFkgaHmTuuSImTiJf6mZ+UjaV1o=;
	b=VeSbBir9PXcloj6yhBZFQw3mHXMh//H0FhkFZr7Xnnifo5BhTDbwx0xwAPK5gL9B0sn3eZ
	eGZj00aspOiWHP1+e6FawRxAKuQtTrcYqw+SC4A9BsmKNPT+Hf+xkyR523/Xio+mRBnIZg
	LFmXXh3b6vJ3Vz00Lt8+uxSupRjQg5Y=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-437-hv1ijw-HMGaR4Aef9tQNTQ-1; Mon,
 13 Nov 2023 16:24:17 -0500
X-MC-Unique: hv1ijw-HMGaR4Aef9tQNTQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 740FF2806047;
	Mon, 13 Nov 2023 21:24:17 +0000 (UTC)
Received: from fs-i40c-03.fs.lab.eng.bos.redhat.com (fs-i40c-03.fast.rdu2.eng.redhat.com [10.6.23.54])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 681393D3;
	Mon, 13 Nov 2023 21:24:17 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	jlayton@kernel.org,
	aahringo@redhat.com
Subject: [PATCH v6.7-rc1 1/3] dlm: use fl_owner from lockd
Date: Mon, 13 Nov 2023 16:24:09 -0500
Message-Id: <20231113212411.4187690-1-aahringo@redhat.com>
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

This patch is changing the fl_owner value in case of an nfs lock request
to not be the pid of lockd. Instead this patch changes it to be the
owner value that nfs is giving us.

Currently there exists proved problems with this behaviour. One nfsd
server was created to export a gfs2 filesystem mount. Two nfs clients
doing a nfs mount of this export. Those two clients should conflict each
other operating on the same nfs file.

A small test program was written:

int main(int argc, const char *argv[])
{
	struct flock fl = {
		.l_type = F_WRLCK,
		.l_whence = SEEK_SET,
		.l_start = 1L,
		.l_len = 1L,
	};
	int fd;

	fd = open("filename", O_RDWR | O_CREAT, 0700);
	printf("try to lock...\n");
	fcntl(fd, F_SETLKW, &fl);
	printf("locked!\n");
	getc(stdin);

	return 0;
}

Running on both clients at the same time and don't interrupting by
pressing any key. It will show that both clients are able to acquire the
lock which shouldn't be the case. The issue is here that the fl_owner
value is the same and the lock context of both clients should be
separated.

This patch lets lockd define how to deal with lock contexts and chose
hopefully the right fl_owner value. A test after this patch was made and
the locks conflicts each other which should be the case.

Acked-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/plock.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/fs/dlm/plock.c b/fs/dlm/plock.c
index e6b4c1a21446..ee6e0236d4f8 100644
--- a/fs/dlm/plock.c
+++ b/fs/dlm/plock.c
@@ -145,6 +145,7 @@ int dlm_posix_lock(dlm_lockspace_t *lockspace, u64 number, struct file *file,
 	op->info.number		= number;
 	op->info.start		= fl->fl_start;
 	op->info.end		= fl->fl_end;
+	op->info.owner = (__u64)(long)fl->fl_owner;
 	/* async handling */
 	if (fl->fl_lmops && fl->fl_lmops->lm_grant) {
 		op_data = kzalloc(sizeof(*op_data), GFP_NOFS);
@@ -154,9 +155,6 @@ int dlm_posix_lock(dlm_lockspace_t *lockspace, u64 number, struct file *file,
 			goto out;
 		}
 
-		/* fl_owner is lockd which doesn't distinguish
-		   processes on the nfs client */
-		op->info.owner	= (__u64) fl->fl_pid;
 		op_data->callback = fl->fl_lmops->lm_grant;
 		locks_init_lock(&op_data->flc);
 		locks_copy_lock(&op_data->flc, fl);
@@ -168,8 +166,6 @@ int dlm_posix_lock(dlm_lockspace_t *lockspace, u64 number, struct file *file,
 		send_op(op);
 		rv = FILE_LOCK_DEFERRED;
 		goto out;
-	} else {
-		op->info.owner	= (__u64)(long) fl->fl_owner;
 	}
 
 	send_op(op);
@@ -326,10 +322,7 @@ int dlm_posix_unlock(dlm_lockspace_t *lockspace, u64 number, struct file *file,
 	op->info.number		= number;
 	op->info.start		= fl->fl_start;
 	op->info.end		= fl->fl_end;
-	if (fl->fl_lmops && fl->fl_lmops->lm_grant)
-		op->info.owner	= (__u64) fl->fl_pid;
-	else
-		op->info.owner	= (__u64)(long) fl->fl_owner;
+	op->info.owner = (__u64)(long)fl->fl_owner;
 
 	if (fl->fl_flags & FL_CLOSE) {
 		op->info.flags |= DLM_PLOCK_FL_CLOSE;
@@ -389,7 +382,7 @@ int dlm_posix_cancel(dlm_lockspace_t *lockspace, u64 number, struct file *file,
 	info.number = number;
 	info.start = fl->fl_start;
 	info.end = fl->fl_end;
-	info.owner = (__u64)fl->fl_pid;
+	info.owner = (__u64)(long)fl->fl_owner;
 
 	rv = do_lock_cancel(&info);
 	switch (rv) {
@@ -450,10 +443,7 @@ int dlm_posix_get(dlm_lockspace_t *lockspace, u64 number, struct file *file,
 	op->info.number		= number;
 	op->info.start		= fl->fl_start;
 	op->info.end		= fl->fl_end;
-	if (fl->fl_lmops && fl->fl_lmops->lm_grant)
-		op->info.owner	= (__u64) fl->fl_pid;
-	else
-		op->info.owner	= (__u64)(long) fl->fl_owner;
+	op->info.owner = (__u64)(long)fl->fl_owner;
 
 	send_op(op);
 	wait_event(recv_wq, (op->done != 0));
-- 
2.39.3

