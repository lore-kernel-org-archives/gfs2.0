Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D779646D572
	for <gfs2@lists.linux.dev>; Thu, 20 Aug 2026 14:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787235704; cv=none; b=bh04Huzm4ndo6OSvPlzH8uQ0krurGSFbLbW6yFI7lqL7M5kFUf5nwfBFnny95yZxnvkCsy54Kg19uTryDeGbnRlELWkPmqCYmPIIr0p8BogRD0lJD2MuS6U/DZQGPji73C8KnA/Urt4zdWWpmlRYmLN0TICU73CgDSyqqJzJgPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787235704; c=relaxed/simple;
	bh=r//P3wSr/3ZCH/9EopJhz8dMSZQ+K/ABKI+eAy0umYI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=l0UoIAWA229uhTHF4fclFHOhfoEzod2GJDOeKyFwGKaXdkBhQuLYNOoGK33cKKowIALxCzXPZlAd1OzMJFlrSfdzK7EOnBtC3RmwBDoaF77T4voo/57CmM56ogsFqOECHnF9dtWPphZH1V3eJyy0oFTa9kzr7WOiLDk59M/633U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EYhkqBOB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EYhkqBOB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787235698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=e2S7XZDSfhwKGrsG1DZUMkq9ZuDcWbhGSGTlNHMZoaY=;
	b=EYhkqBOBaKjuZKhFDBe2mqEaW09mO0kfVcB6jXiqjBhrtc3dkfarnZrsexs2FR/CE5Rgb9
	bGzZT6G2WZmHKuXbIFGpBGubuJqGVY51ioCLg4QEb67Bf3fkhGwUqXBq+b7rZ2ZeT1y0BG
	hEo/VgkNB1Zx/Q8JHSNq8hZIHmrN6eE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-634-cxRHA7JJOYOXN2zVAscUdQ-1; Thu,
 20 Aug 2026 10:21:33 -0400
X-MC-Unique: cxRHA7JJOYOXN2zVAscUdQ-1
X-Mimecast-MFC-AGG-ID: cxRHA7JJOYOXN2zVAscUdQ_1787235692
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 12AA01800344;
	Thu, 20 Aug 2026 14:21:32 +0000 (UTC)
Received: from pasta.redhat.com (unknown [10.44.48.197])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AE6013001DAF;
	Thu, 20 Aug 2026 14:21:30 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	Adrian Garcia Casado <adriangarciacasado42@gmail.com>
Subject: [PATCH 0/6] gfs2: silence sparse
Date: Thu, 20 Aug 2026 16:21:21 +0200
Message-ID: <20260820142129.1327413-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: H8dMl5WQyQ0rkIHjAlXzn8G03YuNdeZwPtxRtY1fuIM_1787235692
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Hello,

this patch queue is based on a patch from Adrian Garcia Casado [*] and
fixes the current sparse errors and warnings.  Please review.

I have put those patches onto the for-later branch for now [**]; my plan
is to move them to for-next once the 7.3 merge window closes.

Thanks,
Andreas

[*] https://lore.kernel.org/gfs2/6a74d41a.f3f7def5.e164f.560e@mx.google.com/
[**] https://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git/log/?h=for-later

Andreas Gruenbacher (6):
  gfs2: Avoid ip->i_gl dereferences in gfs2_inode_lookup and
    gfs2_create_inode
  gfs2: Get to super block from inode in tracepoints
  gfs2: Add inode variables
  gfs2: Introduce gfs2_inode_glock
  gfs2: annotate i_gl with __rcu
  gfs2: Silence sparse signedness warning

 fs/gfs2/acl.c        |  11 ++--
 fs/gfs2/aops.c       |  17 +++---
 fs/gfs2/bmap.c       |  89 +++++++++++++++++--------------
 fs/gfs2/dentry.c     |   6 +--
 fs/gfs2/dir.c        |  61 ++++++++++++++--------
 fs/gfs2/export.c     |   7 +--
 fs/gfs2/file.c       |  72 ++++++++++++++-----------
 fs/gfs2/glock.c      |   4 +-
 fs/gfs2/glops.c      |   3 +-
 fs/gfs2/incore.h     |   7 ++-
 fs/gfs2/inode.c      | 122 ++++++++++++++++++++++++-------------------
 fs/gfs2/lops.c       |  18 +++----
 fs/gfs2/meta_io.c    |   7 +--
 fs/gfs2/ops_fstype.c |  25 +++++----
 fs/gfs2/quota.c      |  48 +++++++++--------
 fs/gfs2/recovery.c   |  17 +++---
 fs/gfs2/rgrp.c       |   4 +-
 fs/gfs2/super.c      |  70 +++++++++++++------------
 fs/gfs2/trace_gfs2.h |   6 +--
 fs/gfs2/util.c       |   8 +--
 fs/gfs2/xattr.c      |  69 ++++++++++++++----------
 21 files changed, 373 insertions(+), 298 deletions(-)

-- 
2.55.0

