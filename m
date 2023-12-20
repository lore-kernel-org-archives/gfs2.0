Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD81482FC
	for <gfs2@lists.linux.dev>; Wed, 20 Dec 2023 19:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OaImzXB/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703101144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wbrsnlwzROTT/lxLF/HK6UzTvCB/88AJJFQSM0n3faY=;
	b=OaImzXB/89Zz7nkcr6ZXalYU+HTdFcmcCnu1tTiyTQ3ir3LE33F37ZFPP+ZU7AISQZYsM+
	mT2rp61g/5Vvxb4pTS8i6gbfKgMiKvlRCi2maVEfs7NgNhOJeDfIEFMh7xmp0MM+Kv1NiW
	69EW+M3Wvh2ylNXPN7pbHps7YFV2Omw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-464-xysgYe-cNlSfnzqTepvTuA-1; Wed,
 20 Dec 2023 14:39:02 -0500
X-MC-Unique: xysgYe-cNlSfnzqTepvTuA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9A6442806401
	for <gfs2@lists.linux.dev>; Wed, 20 Dec 2023 19:39:02 +0000 (UTC)
Received: from fs-i40c-03.fs.lab.eng.bos.redhat.com (fs-i40c-03.fast.eng.rdu2.dc.redhat.com [10.6.23.54])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 91C6C492BE6;
	Wed, 20 Dec 2023 19:39:02 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCH dlm/next 1/2] dlm: fix format seq ops type 4
Date: Wed, 20 Dec 2023 14:38:58 -0500
Message-Id: <20231220193859.1333839-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

This patch fixes to set the type 4 format ops in case of table_open4().
It got accidentially changed by commit 541adb0d4d10 ("fs: dlm: debugfs
for queued callbacks") and since them toss debug dumps the same format
as format 5 that are the queued ast callbacks for lkbs.

Fixes: 541adb0d4d10 ("fs: dlm: debugfs for queued callbacks")
Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/debug_fs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/dlm/debug_fs.c b/fs/dlm/debug_fs.c
index ca65481df70d..87ec499777c5 100644
--- a/fs/dlm/debug_fs.c
+++ b/fs/dlm/debug_fs.c
@@ -748,7 +748,7 @@ static int table_open4(struct inode *inode, struct file *file)
 	struct seq_file *seq;
 	int ret;
 
-	ret = seq_open(file, &format5_seq_ops);
+	ret = seq_open(file, &format4_seq_ops);
 	if (ret)
 		return ret;
 
-- 
2.39.3

