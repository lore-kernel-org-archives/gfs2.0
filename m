Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D024E27F747
	for <gfs2@lists.linux.dev>; Thu, 11 Sep 2025 13:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757599053; cv=none; b=TyH/+z+IManjFu0lqO+sCRCXeNg4troyBh5x0Y/OmnSsdpPCKQvHTn2RkTvIRT8H+LzXxkthNRn/Puw/GpVA9qfgMb+YSHLZxJdJA+dyq4OqyB3GIYNc9GA7VozJLzVqKD+OOx26YgyWL8LKaa92X9CheKZrxBb96A3q30uOrKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757599053; c=relaxed/simple;
	bh=5IVd5n609lEtKZCuFtLJ07/aJP+dW78/UO0pn8YhSFI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=jgJwENi/4J73Pa/b6OZlvj1dpgUGWqH3dQC2m72WdJU7RO9/rUnezCrjkIz98opIs99wySSxl2YapOrU+QEiRtoA1IVvbShmcUd9VJn39un8UbFdUZBKFcOyXQ/gwBarioLpPxcQ0HAo5oq9C/y1H8eSb+meJ3hwKTloyOT69UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W8zVJl9Y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W8zVJl9Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757599050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=E1JP/ikpjwG67RK57N4dqArDkk4nZT01ZSQopz3DFpY=;
	b=W8zVJl9YpA2EBPHAxF+02eC42hwfFTrNPop5+5KsDx+A+lkrHTNRwougYCusrMmlWIELNR
	0Sl9+YQ6jFcYyN40NDxvb31qPqPq7JnJ2QfPTYUbRmM7l6kymHv0Vmx4i2NoRBeR6qzSOb
	aH+GMht2/kmFzlU7NcgKrcgImD7o28Y=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-359-bKdtnsY6OTKNy9MKaXeMMA-1; Thu,
 11 Sep 2025 09:57:29 -0400
X-MC-Unique: bKdtnsY6OTKNy9MKaXeMMA-1
X-Mimecast-MFC-AGG-ID: bKdtnsY6OTKNy9MKaXeMMA_1757599049
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BA8D91800378
	for <gfs2@lists.linux.dev>; Thu, 11 Sep 2025 13:57:28 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.44.32.31])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9F33419560BD;
	Thu, 11 Sep 2025 13:57:27 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 00/20] gfs2 patches on for-next
Date: Thu, 11 Sep 2025 15:57:05 +0200
Message-ID: <20250911135726.657575-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ClNQNAqeNTamCrFE0mGk5JJbIitm4L75UOSfkGLVmQE_1757599049
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Hello,

the following patches have accumulated on for-next and will be part of
the next pull request.  (Colin Ian King's patch has gone through the
list already.)  Please review.

Thanks,
Andreas

Andreas Gruenbacher (19):
  gfs2: Remove unused GIF_FREE_VFS_INODE flag
  gfs2: Remove unused sd_withdraw_wait field
  gfs2: do_xmote cleanup
  gfs2: Simplify refcounting in do_xmote
  gfs2: Partially revert "gfs2: do_xmote fixes"
  gfs2: Turn gfs2_withdraw into a void function
  gfs2: Sanitize gfs2_meta_check, gfs2_metatype_check, gfs2_io_error
  gfs2: Do not use atomic operations unnecessarily
  gfs2: Further sanitize lock_dlm.c
  gfs2: Remove DLM_LKF_ALTCW / DLM_LKF_ALTPR code
  gfs2: Fix LM_FLAG_TRY* logic in add_to_queue
  gfs2: Remove duplicate check in do_xmote
  gfs2: Fix GLF_INVALIDATE_IN_PROGRESS flag clearing in do_xmote
  gfs2: Get rid of GLF_INVALIDATE_IN_PROGRESS
  gfs2: Simplify do_promote
  gfs2: run_queue cleanup
  gfs2: Minor run_queue fixes
  gfs2: Add proper lockspace locking
  gfs2: Fix unlikely race in gdlm_put_lock

Colin Ian King (1):
  gfs2: Remove space before newline

 fs/gfs2/file.c       |  23 ++++--
 fs/gfs2/glock.c      | 185 ++++++++++++++++++++-----------------------
 fs/gfs2/glock.h      |   4 +
 fs/gfs2/incore.h     |   5 +-
 fs/gfs2/lock_dlm.c   | 100 +++++++++++++----------
 fs/gfs2/trace_gfs2.h |   1 -
 fs/gfs2/util.c       |  38 +++------
 fs/gfs2/util.h       |  36 +++++----
 8 files changed, 199 insertions(+), 193 deletions(-)

-- 
2.51.0

