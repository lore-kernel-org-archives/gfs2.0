Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC019213E9F
	for <gfs2@lists.linux.dev>; Sat,  1 Nov 2025 08:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761984570; cv=none; b=jnXZg0RAouM18594CPnHnR3bqJ/xZvOX6nZee2TavhXyzxybCYE6ytYQj1jI1rWIbO07l5++LZScJ+torqcIOC9vOmMRB2rRAyd47gVsp285ug2beZZFpRxX0SvCiRbPq+GlawOJgYIWYtJWx4tenSVgi2ICzdHtUYjp72lwx4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761984570; c=relaxed/simple;
	bh=6weTYzqO11W7vUz/+Lxzf4Trg4vOwofFdRRglKtfE0w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A86mmc1GZGl6kn9uEFUi2IPF0SE7H5W55LP9ffPJUIYRPNt9vxo1baAVLphmNd7Cdp1iRNPL/iSvP1TKQfDhVpwgZpXFLz3H6Claou7cLZk7HJmFTKwUpLyd8tnM1sIHAvIOHraRLB+dwaZNjDn2nnGrchO1EUf6j5E58Gafx84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JDch3wIK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JDch3wIK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761984567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9t6HRTvKO8eeiNCnIxk4LWupor3SqkoWYueS8/rqkUI=;
	b=JDch3wIKTV3P5MYIyM54sSIFCbHHHHjLZ/mZviSWM35Wbb6anSX2T9rdPOBTR3sIfBGm5t
	4FFwGCYD+fiOxbxzcMh5C7L0Lkn6KldHKyBNjdJ/ZWs/LV/L54wgoFZI7gCnHLYjsjxIWM
	TkChLugu2ySCuV+d0KhQq06tpHmQI4w=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-484-VNKFMFBZPIuSWH08Mr08pg-1; Sat,
 01 Nov 2025 04:09:24 -0400
X-MC-Unique: VNKFMFBZPIuSWH08Mr08pg-1
X-Mimecast-MFC-AGG-ID: VNKFMFBZPIuSWH08Mr08pg_1761984563
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D36AC180035A;
	Sat,  1 Nov 2025 08:09:22 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.12])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0B51119560B7;
	Sat,  1 Nov 2025 08:09:20 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev,
	Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org,
	Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 0/5] gfs2 non-blocking lookup
Date: Sat,  1 Nov 2025 08:09:14 +0000
Message-ID: <20251101080919.1290117-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

This patch queue implements non-blocking lookup in gfs2.

A previous attempt to implement this feature was made in December 2023
[1], but issues were found [2] and that attempt was aborted.  This new
implementation should be free of those problems.

Please review.

Thanks,
Andreas

[1] https://lore.kernel.org/gfs2/20231220202457.1581334-2-agruenba@redhat.com/
[2] https://lore.kernel.org/gfs2/20240119212056.805617-1-agruenba@redhat.com/


Andreas Gruenbacher (5):
  gfs2: No d_revalidate op for "lock_nolock" mounts
  gfs2: Get rid of had_lock in gfs2_drevalidate
  gfs2: Use unique tokens for gfs2_revalidate
  gfs2: Enable non-blocking lookup in gfs2_permission
  Revert "gfs2: Add GL_NOBLOCK flag"

 fs/gfs2/dentry.c     | 63 +++++++++++++++++++++++++++++---------------
 fs/gfs2/glock.c      | 39 +--------------------------
 fs/gfs2/glock.h      |  1 -
 fs/gfs2/glops.c      | 15 +++++++++--
 fs/gfs2/incore.h     |  1 +
 fs/gfs2/inode.c      | 20 +++++++++-----
 fs/gfs2/ops_fstype.c |  6 ++++-
 fs/gfs2/super.h      |  1 +
 8 files changed, 76 insertions(+), 70 deletions(-)

-- 
2.51.0

