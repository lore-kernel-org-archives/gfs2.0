Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E590E2AD20
	for <gfs2@lists.linux.dev>; Wed, 25 Sep 2024 22:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727301842; cv=none; b=ai2hKO+MKPBPc+7uMLQ1d9nVBpNv1XrjAc9rGXJ+13Qvpd+P9HgNXt+rCL72s+QOv7IgfNGG9zuuSlhVZUMn9mo92PXyDpfMaamYBfXMZ9U2Ur/O0tVPxJpwmMt+HYgVac3QgGVsdhRhSqXU4BqxytqSKuKasMCu0p78aTsj46A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727301842; c=relaxed/simple;
	bh=Ll8dnI/7TqSJprXGlEA9DPLia1zZLo7SrKxJEYsujQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i5LWXEn2bk8eyk8896ObI+PO696mfMQ/xivvpMjCor9S7INmXJec8dJUEBFvzLtO17DKvJnIXdIzD1fbklQpqlCtTyJ8+8znJRNl5YyNf4zg4NJlZ2lCmyrjCm3M/kaaPUW+WSgbRV6dpKxKFcXQDzdEnriRO/8IK6Fr4i0HjAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QG8b1bcz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QG8b1bcz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727301840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E1MLCCI3asvBFfxOEUSMauVHLLmD/CfaQhlQOs47knE=;
	b=QG8b1bcz8WNYng2EL+DC2DMqC795mrw2gP3f4EYu8vjvgNgIKAj0TcKxijUj7/uJxHf+Ic
	NglTpujMwrvNm360Ia9f3+SNBHH8/6s+SPVbZ8BZgqjZJaD/lVlhMF29aJFJk5YNSSrBtc
	eRj3PFb91mEstHQc0Vu1a3w1V9NXu3U=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-547-WFEVgBI8NGCBUbxECJ6tQA-1; Wed,
 25 Sep 2024 18:03:58 -0400
X-MC-Unique: WFEVgBI8NGCBUbxECJ6tQA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2A1381896E3D
	for <gfs2@lists.linux.dev>; Wed, 25 Sep 2024 22:03:58 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.77])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 087EE19560AA;
	Wed, 25 Sep 2024 22:03:56 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 14/16] gfs2: Randomize GLF_VERIFY_DELETE work delay
Date: Thu, 26 Sep 2024 00:03:24 +0200
Message-ID: <20240925220331.417856-15-agruenba@redhat.com>
In-Reply-To: <20240925220331.417856-1-agruenba@redhat.com>
References: <20240925220331.417856-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Randomize the delay of GLF_VERIFY_DELETE work.  This avoids thundering
herd problems when multiple nodes schedule that kind of work in response
to an inode being unlinked remotely.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/glock.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 5455f4dd14a3..46a6e97cd930 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -36,6 +36,7 @@
 #include <linux/pid_namespace.h>
 #include <linux/fdtable.h>
 #include <linux/file.h>
+#include <linux/random.h>
 
 #include "gfs2.h"
 #include "incore.h"
@@ -1018,7 +1019,7 @@ bool gfs2_queue_verify_delete(struct gfs2_glock *gl, bool later)
 
 	if (test_and_set_bit(GLF_VERIFY_DELETE, &gl->gl_flags))
 		return false;
-	delay = later ? 5 * HZ : 0;
+	delay = later ? HZ + get_random_long() % (HZ * 9) : 0;
 	return queue_delayed_work(sdp->sd_delete_wq, &gl->gl_delete, delay);
 }
 
-- 
2.46.0

