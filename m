Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F6619413E
	for <gfs2@lists.linux.dev>; Mon, 12 Aug 2024 20:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723493676; cv=none; b=A4j++DV98sxl6GnVNWMjRJimGKVoWtHKs6Rvq+9y/O7RpH5HMcec46bhJQa84BtBYNmp3ymSBOZp15UoQgUUX9vmwyLF0+dAaMK3uvMirTCUR+IpvfVGQbSlMJJnU8m7alOyqzVqHGtqQPJ7tk/YikUSyZXkujGmVowFXT9z4X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723493676; c=relaxed/simple;
	bh=LpASqDfyPgarGGJ4oAXAbedBh1e1lVVK3yQHqvPtlPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AeEBFS+52vOS0heDEpqkKlsKB/L+ApVG/0Olg3nJHPVwujn9doSn8/W7tI6nSEO85OwXB0n1hT2RRMrZ9ZH9TIQ2IsxKhlX+Ln50Y4NWN/5BucnThlJb8O4d1EOBNIHBz86WEfrwAVj6dMq9jggigQhK4ltS2Qjl68Vu5cIeUNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kdk2Ho5P; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kdk2Ho5P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723493673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=D0JbpA+tudKhIAZmQN8YXoP59DKNQsrVIsxi72VKTmw=;
	b=Kdk2Ho5P/UJzOr4B/mv2gpTwr6/RgT/2naSK+R6TU3ix823w0YzjCAO7Q3CyeTc5vq6G1j
	qU7ZLc83aS6IULnDB+PsLjuJfAOKzFzwPdA8boadUqjqe50nYTM1WFDdVPfu51o+WbFVlN
	NtOksPtmqBhUmiiAodc6j3mfMB6PTyg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618-lZd7FZF_O6OQoP-uQI7f-Q-1; Mon,
 12 Aug 2024 16:14:29 -0400
X-MC-Unique: lZd7FZF_O6OQoP-uQI7f-Q-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C2DB41953955;
	Mon, 12 Aug 2024 20:14:28 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DC4F3196BE80;
	Mon, 12 Aug 2024 20:14:27 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com,
	dan.carpenter@linaro.org
Subject: [PATCH dlm/next] dlm: add missing -ENOMEM if alloc_workqueue() fails
Date: Mon, 12 Aug 2024 16:14:24 -0400
Message-ID: <20240812201424.1711957-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

This patch sets an missing -ENOMEM as error return value when the
allocation of the dlm workqueue fails.

Fixes: 94e180d6255f ("dlm: async freeing of lockspace resources")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202408110800.OsoP8TB9-lkp@intel.com/
Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/dlm/main.c b/fs/dlm/main.c
index cb15db8ba9bf..4887c8a05318 100644
--- a/fs/dlm/main.c
+++ b/fs/dlm/main.c
@@ -53,8 +53,10 @@ static int __init init_dlm(void)
 		goto out_user;
 
 	dlm_wq = alloc_workqueue("dlm_wq", 0, 0);
-	if (!dlm_wq)
+	if (!dlm_wq) {
+		error = -ENOMEM;
 		goto out_plock;
+	}
 
 	printk("DLM installed\n");
 
-- 
2.43.0

