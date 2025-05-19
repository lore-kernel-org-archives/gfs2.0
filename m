Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EA3274673
	for <gfs2@lists.linux.dev>; Mon, 19 May 2025 11:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747653555; cv=none; b=pksmzYaItSV4AXVJxP0zsJev4iqFMo+eAd5ehBfqExo5PGYt3OSQ4MwSWfgT2tivwm4aM8fbmCm+RZ7q8LFZQ8hLJJZUl5fPPZMM1Yw3YhqnnxE+mJTFZZnSKWAK/ORMRC+OJcv7S1IS2eKBaKuNFjuGlrUGV2H5d7gUVtIJrEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747653555; c=relaxed/simple;
	bh=cjAHFmSINJATxS/LyMsF6LVmVXaYhYXChYfFnC2hJGo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=rYbqzdEbvD2umFPox6025jPNdxaGlj9lf4Bu0XQf6vMe36vcnF04kxSfJVXReznOMbGCOcF1svZnlhFQ5CIZcL3l2CBoiZ3BvinCTqEp9WzHI3TKLFrmGklm0K+k/awYnLBtTw5ugbPg++D9O9Q/EgrhlC7+1+1TyvaUVaPw2t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WdoO0nw5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WdoO0nw5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747653552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/8uwbPi6BqpIG13dZNn9S30dnKDhzIIrP0wewdHJ0iY=;
	b=WdoO0nw52kFy9bI7UQ6kKVtyAc/kePCSF5y9N7yXdIzcIGn3/00Pburi46Wrl1MdV5h4d8
	286CnAUxlwPOQnQJs0oC+7xWl+e/BUsIkfBUxHrVVjZdAvXC6GZFmeFkMfPTdFaep/iSMH
	lTBVtDmxUJ7z6v+P8M7+i7u0DzxB9Is=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-448-r-O_cldPPcGqfCZd0Ivz-g-1; Mon,
 19 May 2025 07:19:11 -0400
X-MC-Unique: r-O_cldPPcGqfCZd0Ivz-g-1
X-Mimecast-MFC-AGG-ID: r-O_cldPPcGqfCZd0Ivz-g_1747653549
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 326DF1800256
	for <gfs2@lists.linux.dev>; Mon, 19 May 2025 11:19:09 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.234])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0717E18004A7;
	Mon, 19 May 2025 11:19:07 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 0/6] gfs2: mount failure after successful recovery
Date: Mon, 19 May 2025 13:18:59 +0200
Message-ID: <20250519111906.1503215-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jrxoK2prbl5P2P4dC7nO-6RDX8tCz0fbmUuHsE8zTrc_1747653549
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

This set of patches fixes an occasional failure to mount a filesystem
after it has been successfully recovered.  What's happening is that due
to incorrect cache invalidation, gfs2_find_jhead() fails to find the log
head written during recovery.  This is fixed by only looking up the log
head before recovery and then updating it instead of looking it up a
second time after recovery.

Thanks,
Andreas

Andreas Gruenbacher (6):
  gfs2: Minor comments fix
  gfs2: Move gfs2_log_pointers_init
  gfs2: Simplify gfs2_log_pointers_init
  gfs2: Simplify clean_journal
  gfs2: Get rid of duplicate log head lookup
  gfs2: No more gfs2_find_jhead caching

 fs/gfs2/glops.c    |  5 ++---
 fs/gfs2/log.h      | 11 -----------
 fs/gfs2/lops.c     | 11 ++++-------
 fs/gfs2/lops.h     |  2 +-
 fs/gfs2/recovery.c | 25 +++++++++++++++++--------
 fs/gfs2/recovery.h |  2 ++
 fs/gfs2/super.c    | 18 ++++--------------
 fs/gfs2/util.c     |  2 +-
 8 files changed, 31 insertions(+), 45 deletions(-)

-- 
2.49.0

